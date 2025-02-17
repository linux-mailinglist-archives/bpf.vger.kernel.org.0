Return-Path: <bpf+bounces-51755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7706EA388ED
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 17:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C380167371
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15DC224B17;
	Mon, 17 Feb 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSqtxkbs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DB223700
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808785; cv=none; b=DDOythIHUFa/FONdxzy/tYVdOJ7jfJbU6zeAqIjef0fZb9QFh2YfxQuNOqKvlyIUcTop0SUuKr+LRSswlPj6wjlLbdwSe2qMMA1Xh5jgVW9PPvRpJCgVR7UwsB1SgyrkD/WhFQYfxM8euz0jOtgE3IjPT7URJjTZc+7Z45KYxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808785; c=relaxed/simple;
	bh=TyFc+m+o5Ip61yVd3LutnSKqRmbGsdZH3zjUdTzZjJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqRqpVZiS7CsfNlD9zs2sZqeCQlm0w+NNxD08OVcSJevAICJDq+rP8IoaKA4j5SQH3F+4NX8ZibmGyHZXZi7vJJysS5BJ+Xc7Qad1e1ECWCFs1APEVr9kQVqAojxbUS+k/qEWeG7psJnLPW/3IiIWtLQDRanHpia3xGLxdpBZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSqtxkbs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739808783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWhOzTyt32fDH0giRXlm9T2UpJRlwSqApuOdt4srbxg=;
	b=QSqtxkbsL4aVnlrxiIvGvF4fy+CPIvvFoi+fQtcTJ5cSz8/U8S4NxaGVlPduuCNFVzey1U
	9uu+aGq9705r9YZ5ywYS2+L3m75vFRR5HYI+LdmTgPKoomi6DYGGpBV/a/A3Tt3qYFFtIw
	GnyAJXnRtExiaRxrGMBlW7T8luBeUmQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-ydGPgqKWO5W8I6WzF8btgw-1; Mon,
 17 Feb 2025 11:12:58 -0500
X-MC-Unique: ydGPgqKWO5W8I6WzF8btgw-1
X-Mimecast-MFC-AGG-ID: ydGPgqKWO5W8I6WzF8btgw_1739808776
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B368B180087C;
	Mon, 17 Feb 2025 16:12:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4DD241955BCB;
	Mon, 17 Feb 2025 16:12:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 17 Feb 2025 17:12:26 +0100 (CET)
Date: Mon, 17 Feb 2025 17:12:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next] uprobes: fix two zero old_folio bugs in
 __replace_page()
Message-ID: <20250217161218.GD8082@redhat.com>
References: <20250217123826.88503-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217123826.88503-1-tongtiangen@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Can't comment, my understanding of mm/ is not enough these days.

Just one question...

On 02/17, Tong Tiangen wrote:
>
> Fixes: 7396fa818d62 ("uprobes/core: Make background page replacement logic account for rss_stat counters")
> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")

Are you sure this logic was wrong from the very beginning? Just curious.

Oleg.

> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  kernel/events/uprobes.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 46ddf3a2334d..ff5694acfa68 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -213,7 +213,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>  		dec_mm_counter(mm, MM_ANONPAGES);
>  
>  	if (!folio_test_anon(old_folio)) {
> -		dec_mm_counter(mm, mm_counter_file(old_folio));
> +		if (!is_zero_folio(old_folio))
> +			dec_mm_counter(mm, mm_counter_file(old_folio));
>  		inc_mm_counter(mm, MM_ANONPAGES);
>  	}
>  
> @@ -227,7 +228,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>  	if (!folio_mapped(old_folio))
>  		folio_free_swap(old_folio);
>  	page_vma_mapped_walk_done(&pvmw);
> -	folio_put(old_folio);
> +	if (!is_zero_folio(old_folio))
> +		folio_put(old_folio);
>  
>  	err = 0;
>   unlock:
> -- 
> 2.25.1
> 


