Return-Path: <bpf+bounces-30826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CDF8D3196
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C3D1F2243A
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2B16F0DC;
	Wed, 29 May 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSlKwQV6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CE16A380;
	Wed, 29 May 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971490; cv=none; b=Mleta4djfW7Y57eolemQY6XXeAfwmU7USDHmqEEvSgBmT4Ofe8hOyHwjejvwhrfOlJLyvhBzs4NG233ueh1V2OY4wL9AziIqJdNiPRTB2r5Nuejo6TMvzxgRS1X3BtrBNjGyEh7OdM1H5LRU2oE/i5bVDDJm9dvEhzZ3oX62DRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971490; c=relaxed/simple;
	bh=g8wLVx6SzI7f5hfBWjCx8/IiFtnpI5IJH84ulc3VsEM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9efdMUX5247T9Ry709p23zO0JelV/jtT5L5wiP9eE5KM6MfoK9sEbh/9t0X8k6Qce1/gIB7GNq4ZHLV3j6f/b1wfToAvq+nltltveq1eOQ56jdXBNgWIIKOhVKCp2wxSPTkz+U7OwZtfEVrCyXZJv0fLOJRdWoxD8z8YY4o4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSlKwQV6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso15301675e9.0;
        Wed, 29 May 2024 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971487; x=1717576287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rn7yPS61VZDyN0hXW0NrmYKzmNUSInF0ZrwB9evZ1F8=;
        b=eSlKwQV65+3CTLQvtQrK4CTKupGaewTEFgzelyuGJx2eT2E93IlP6IMcNqPy4sYU2u
         7O8DFaPj5YoWwQrL2Lk+rHTTkzeCIR1o5iPQcRRI9LLVbPPBMWIkjvhlAttlUiWddqXc
         EXQkIHIXKP6+K/lBfSizSPyJKZ4HYB+T0Cg9rY0kh/CItemTiHWICxxIY+aODcjFBdvj
         3TXqAuMJvP+90SNN7x7xKfctY9nPxrbcCJeZVwK1YyS0xkEZMaODEO/ufLvUsfRJd3dJ
         hv8fkuO/3msPnLoP7Mhmvwl9l6zJht84i3QS+zn0GUNJ1L4XjRPbzdHNh79QGzhcsAhl
         +IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971487; x=1717576287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn7yPS61VZDyN0hXW0NrmYKzmNUSInF0ZrwB9evZ1F8=;
        b=u76IGlEtY7brFr7aMwLI1rF7NPWdXFfc1GaEzEedJ4L7li9NtWoGzB2GJO/WAW4+t9
         V4E8kwf5X6XmlezL9pcTWza5nSBvUtgl9ZOn9otryNedlm8JbOmR9gdBl2+QNuI1FS9d
         vP82guQWpEzQCJN8LQQqizBslaBr+1MBj0RD5rK0qtWZV+e8yBZB8MWelCFDHBf/Ncol
         yXma7yuY8IXBPMpGvrboG6a+vfwaF2pyW635IxkFB2L9QJirvrf0xKBWvBCFKDLGuONU
         bpQ5nfQ4FvKLMhwExBR1iHxyRiDsHAZJoVJFsjqHAFOCIqiihG4vSph3nVD86e74pvIc
         tJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCW1BpSWuw6eO90jppbWx6/JAzJNZMO1TB7qMWhjCTGiXCoBzKJ0LNZ8P5oA76gDJG4pVf5mzcrQ3NxphMYrqgRgzwfTSTn3xnLg4145j4KyV09LL2TFNnPmBESOeG2hYY9r
X-Gm-Message-State: AOJu0YxLUsk9oDJJ8Z8AovKTuopx3MjBTsQUGtJXPQKWCYCQkNz73bRd
	0IuY9AieWRHSG2vDyE3y2wxY2AvUmRIMJbeS25spQY0fxLCFu2to
X-Google-Smtp-Source: AGHT+IHI3lJArJXzafeVRrKWqyHrhTUty+cf9AUiuyoKb+lHZLYh8EC0aY14fLhOqSAqg6nNMo5YFQ==
X-Received: by 2002:adf:e444:0:b0:356:4cfa:b4b9 with SMTP id ffacd0b85a97d-3564cfaecfdmr8805125f8f.2.1716971486900;
        Wed, 29 May 2024 01:31:26 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-358a33e6f03sm9046320f8f.36.2024.05.29.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:31:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 May 2024 10:31:24 +0200
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, LKML <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Aleksei Shchekotikhin <alekseis@google.com>,
	Nilay Vaish <nilayvaish@google.com>
Subject: Re: [PATCH v2] bpf: Allocate bpf_event_entry with node info
Message-ID: <Zlbn3DOGrzHlw95h@krava>
References: <20240529065311.1218230-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529065311.1218230-1-namhyung@kernel.org>

On Tue, May 28, 2024 at 11:53:11PM -0700, Namhyung Kim wrote:
> It was reported that accessing perf_event map entry caused pretty high
> LLC misses in get_map_perf_counter().  As reading perf_event is allowed
> for the local CPU only, I think we can use the target CPU of the event
> as hint for the allocation like in perf_event_alloc() so that the event
> and the entry can be in the same node at least.

looks good, is there any profile to prove the gain?

jirka

> 
> Reported-by: Aleksei Shchekotikhin <alekseis@google.com>
> Reported-by: Nilay Vaish <nilayvaish@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

> ---
> v2) fix build errors
> 
>  kernel/bpf/arraymap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index feabc0193852..067f7cf27042 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -1194,10 +1194,17 @@ static struct bpf_event_entry *bpf_event_entry_gen(struct file *perf_file,
>  						   struct file *map_file)
>  {
>  	struct bpf_event_entry *ee;
> +	struct perf_event *event = perf_file->private_data;
> +	int node = -1;
>  
> -	ee = kzalloc(sizeof(*ee), GFP_KERNEL);
> +#ifdef CONFIG_PERF_EVENTS
> +	if (event->cpu >= 0)
> +		node = cpu_to_node(event->cpu);
> +#endif
> +
> +	ee = kzalloc_node(sizeof(*ee), GFP_KERNEL, node);
>  	if (ee) {
> -		ee->event = perf_file->private_data;
> +		ee->event = event;
>  		ee->perf_file = perf_file;
>  		ee->map_file = map_file;
>  	}
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

