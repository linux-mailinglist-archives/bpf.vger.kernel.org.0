Return-Path: <bpf+bounces-52180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9931DA3F8F3
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 16:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABA4704A16
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90300216380;
	Fri, 21 Feb 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+qejeEB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582C21579F
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151774; cv=none; b=DnyRRWlgFS3lNr27mo/KWZOxdEdKhMD4qgimwUHpmEnbAWoGW8NTMNKllIFdeM3U1bXn4kjRDr6pwyB0kroys4ioE5v90VppVQ6pfbj7WXjyT2NNj+DwXAxLSPIdZ0VB268Yv1lBGWMdsZ8FjYj6rabWKUfDAjyeuIb8ma9kRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151774; c=relaxed/simple;
	bh=RPWq7Di80wCaezBdT5MKfthytldTTyeI8zqYu5ssG9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu61u+iq7hZIjynhH0p0LfhU3kU8mXKG2J06lKbw+QdmTZtSVcMKozaz5VBJXz8QTFBqCBE4eY+77NUpJzkk2nI2w0jqvPx92rD9+TrfbDnAB6e7cN8OL0germOl23w1NlweW2bhzXuS2N4daR+NzBeBZVdoK4+trVSleuG7XWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+qejeEB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740151768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ic1/uViOEImLUfOGxnGRSWveOc6wET399Ae2ZdSNHEc=;
	b=h+qejeEBMi7n15RS4Ng0N3d2Rp74Lwg1RSMFqXHHwEJ7dsK+LscZ+xg0JQSxtdvxLSnINp
	ClIbUDND+AHuH2oy1swcI2OKRkiTxGuLs0Ruoyrmc222yF0JQIwyqiD/cWpuigUN45aIvB
	6Dj737DB5RHWeXAQxD6rJyk83w2gwVI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-W3hhLAD0P8O_s-BkpsjBfQ-1; Fri,
 21 Feb 2025 10:29:25 -0500
X-MC-Unique: W3hhLAD0P8O_s-BkpsjBfQ-1
X-Mimecast-MFC-AGG-ID: W3hhLAD0P8O_s-BkpsjBfQ_1740151763
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2F6619373D8;
	Fri, 21 Feb 2025 15:29:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.97])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3BE231800943;
	Fri, 21 Feb 2025 15:29:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Feb 2025 16:28:51 +0100 (CET)
Date: Fri, 21 Feb 2025 16:28:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Peter Xu <peterx@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v2] uprobes: fix two zero old_folio bugs in
 __replace_page()
Message-ID: <20250221152841.GA24705@redhat.com>
References: <20250221015056.1269344-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221015056.1269344-1-tongtiangen@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/21, Tong Tiangen wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -506,6 +506,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	if (ret <= 0)
>  		goto put_old;
>
> +	if (is_zero_page(old_page)) {
> +		ret = -EINVAL;
> +		goto put_old;
> +	}

I agree with David, the subject looks a bit misleading.

And. I won't insist, this is cosmetic, but if you send V2 please consider
moving the "verify_opcode()" check down, after the is_zero_page/PageCompound
checks.

Oleg.


