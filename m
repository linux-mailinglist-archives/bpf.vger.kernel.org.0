Return-Path: <bpf+bounces-63072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8AB0231C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD105562EA9
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924C2F0C4E;
	Fri, 11 Jul 2025 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0q0VVwJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B037155C97
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256060; cv=none; b=Tk2bbdqg8Tv/2hZWW6jQmMuoPYMdYilU9ZnmzxZBSKkk6G92H1BLY5Lyik2tUeyx74DlyLcMnFmVmqyacZr+ibXvnEDrJW0beh2w7XrHYfrYombUlymS79v7MiB8GmsYA5uu/p4UUmkZAGyJNTQnM6CvVM3fl+UYlSCocxSMz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256060; c=relaxed/simple;
	bh=ZBZlTBD4pnXN5kz9zHZp+FCjbMp+dWC9eNIcY62zafQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzUzZ5aPvxQLGawvfMBLwKvFpYKVy9tni6Q3oF/4zDoAz8wEBd2AlSM0TY0BVvSSQFO6AOitYWgKAYSBdFnxv3XLp+R9KYs1qRx/LI5RmtjmO1LiL7HSfruToUK+QDtUlisq9PxA4G+NIhxgVRjbJ5isYFN/z2nAc+g4ncRmv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0q0VVwJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752256057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PT3etH5wWzqKF5yn/gGxr2M7euz7R+JyBf/lL06UfGk=;
	b=c0q0VVwJPvWdBwBKcvc6aRro/u+OSGINmbFb1jAze62F/Unmfs+XBhotPvO6sWA6WRAOwW
	Vmy39juvbpjJ2VzZZT1pvhIihwUziQKtwrKPh6PeA+lznY4moG0SduvOkaPHOLdGayodvI
	D5CR+qLmmqx0eNZfIWSqRgQscpHt4lw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-ZUayp3rGPguKN_3BEAfiOA-1; Fri,
 11 Jul 2025 13:47:32 -0400
X-MC-Unique: ZUayp3rGPguKN_3BEAfiOA-1
X-Mimecast-MFC-AGG-ID: ZUayp3rGPguKN_3BEAfiOA_1752256049
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64A611956089;
	Fri, 11 Jul 2025 17:47:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BEF5C1956094;
	Fri, 11 Jul 2025 17:47:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 11 Jul 2025 19:46:39 +0200 (CEST)
Date: Fri, 11 Jul 2025 19:46:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <20250711174631.GB11322@redhat.com>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-9-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711082931.3398027-9-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/11, Jiri Olsa wrote:
>
> +static unsigned long find_nearest_trampoline(unsigned long vaddr)
> +{
> +	struct vm_unmapped_area_info info = {
> +		.length     = PAGE_SIZE,
> +		.align_mask = ~PAGE_MASK,
> +	};
> +	unsigned long low_limit, high_limit;
> +	unsigned long low_tramp, high_tramp;
> +	unsigned long call_end = vaddr + 5;
> +
> +	if (check_add_overflow(call_end, INT_MIN, &low_limit))
> +		low_limit = PAGE_SIZE;
> +
> +	high_limit = call_end + INT_MAX;
> +
> +	/* Search up from the caller address. */
> +	info.low_limit = call_end;
> +	info.high_limit = min(high_limit, TASK_SIZE);
> +	high_tramp = vm_unmapped_area(&info);
> +
> +	/* Search down from the caller address. */
> +	info.low_limit = max(low_limit, PAGE_SIZE);
> +	info.high_limit = call_end;
> +	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> +	low_tramp = vm_unmapped_area(&info);
> +
> +	if (IS_ERR_VALUE(high_tramp) && IS_ERR_VALUE(low_tramp))
> +		return -ENOMEM;
> +	if (IS_ERR_VALUE(high_tramp))
> +		return low_tramp;
> +	if (IS_ERR_VALUE(low_tramp))
> +		return high_tramp;
> +
> +	/* Return address that's closest to the caller address. */
> +	if (call_end - low_tramp < high_tramp - call_end)
> +		return low_tramp;
> +	return high_tramp;
> +}

IIUC, nothing else has changed since I've acked the previous version?
Then my ack still stands,

Acked-by: Oleg Nesterov <oleg@redhat.com>


