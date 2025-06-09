Return-Path: <bpf+bounces-60104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165CAD297C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D510D16FCB2
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 22:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9145C1A238C;
	Mon,  9 Jun 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3GBvA1v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1ED1FA178
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509106; cv=none; b=Qo7ZTXJE2LblsKwQ/USa1bvKe2ncQm+8y8r6XGjdbnT6AIp0IvYWdZsk0UJntW5GqaMYLSqCxfPSlSfdLospUwFS+L7TVFGo9u5kVwc6mOEV2hay/WndTod6W9IcC5aGzJoN+U9EF6Zz2MSiQVxfM1g5mkkIYDZgVNHPm03CKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509106; c=relaxed/simple;
	bh=I0FZhXTT0rYksNDbqQ3bbCa9mXlvw2vzx4XVs1jmxuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wlj+c+gpaC9O6RbSN4UDoPN/S5wUWdoI6ZwCzaQRS90X8hOWrCUwLZLhjojf+lnAw593gPWHkD4e+ZYS+fpn4g2bIk5EtS1juT0YsMT1mW0bwfDMe/KfQEQ132B5VNEpBN742/DdgMY7iRoSTvkkMRGf6uKtShcGpEa38EbeaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3GBvA1v; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236192f8770so13510445ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509104; x=1750113904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFKDA7iaja6fdRnDNzBE4ELMQqjlpap1GMSe1zQkkJY=;
        b=J3GBvA1v4myBUjGET28C0A0GZWROu2rQgjRcsZeE/TamSjMuYRz1Fkhmm6p2tvZV8Q
         OQsU2o2ZZ2rAhwC2btgqySH3ra1lngGGlwjMK3nPPzK69PnpkP+A2OAL3dO1jbIf3Nam
         abbCp+qvmaKy/YDCdLmTRiz+fv99ciTjj0gykrQUfbM3C1q5e0wDQ58YQcBUpWSmjIOQ
         O2Rr0HQjraMfzdo9xo2tmk8olx9A8kWf+hpJelEtp3S9p30aVikz4x4J+MAihq+b4ZMi
         tkDZsqpzzFB3/JfXTZeLJDkqZkzwsBHxoTybtfczRSIQAJtO2QeXFNnlJO19bDI6WH54
         pu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509104; x=1750113904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFKDA7iaja6fdRnDNzBE4ELMQqjlpap1GMSe1zQkkJY=;
        b=WlGg06zGKxF1odyHLJ+QDGyR69u00807hFAQsRwuZ3Dpw12UpzQOH1ueTu0Fcj6sLA
         bsxHtF6OAQshM2CvatlY/QudtiWlstkbbmuClXhX2PJFqEySaN9O+OpkIN3xQwfn9/mP
         WYhV92MH3xAXS+CYRdIeRmcuqYnMnmPm0KXKz9UqLeuv7rHPYGuYebrIC7A11Wl1Kwg7
         +7zTcv+x8ke0YdO9x22iguJKfrDBJp+UjRRyVOkSEWixBBCAUwofBBnm4MFZGqm9srP0
         ENBmD4rCRv6CZ4CO8CgVe7OmMgtCp3/d84W+VoiFEXJe6o3DGYbU4aOFOGRelhfEqd6t
         ICww==
X-Gm-Message-State: AOJu0YwOYRTzM+/mdnzZjUaAxDSdDWeQs80S8jHJ4svIAY6Ux+kIWwdB
	otx3DCm06w605KNhYhXLYzMHAeGHcGm1xUGzwAqZLeQNYTJe09b1zH/TWRvp
X-Gm-Gg: ASbGncudOLVo1Nq9o0tmm014LZm/jm8vmxGZ+zGRsMkIBwtBanyhdpPjjnc2Qn0hjRP
	YkbR6TiGRk3fmLfmA5zgtGEtJq5VPqDxT+iuE2HP/nfA6Fn1xT8MQjhIPuakb+pmslfq8PmJtEE
	+irUheGRK34B/NIXGDXIG2Hk4uT/SiQGCykNhOZNzTtrGpgrfihKYK6suhmKU216Y5whUJwfwSv
	6kXwaYzA33i5okAC2ed2AhMHT0iT+JV/d1Cicv9ycB4Z/DcfXAyrNanDA8aAkjSqQCyztpqE2VE
	35ZzHG5h16QH8ZzkUYMkV7p4CxqOt/2COwzibZonvWiWhJWTbxRXrzyyHjfu79WnJMJq/Ih2NjH
	LOazGMtv3aLf1+H466vfomH0=
X-Google-Smtp-Source: AGHT+IHZClct454JIMMrJrn1I3meHEzrwXNvoe8QNhWvLxabka7MIia4NYY3mquxtAmsHygBEtyMWg==
X-Received: by 2002:a17:902:cec5:b0:235:e1d6:2ac0 with SMTP id d9443c01a7336-23635c9cf2bmr16754685ad.24.1749509103950;
        Mon, 09 Jun 2025 15:45:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3134b1552b2sm6063867a91.44.2025.06.09.15.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:45:03 -0700 (PDT)
Date: Mon, 9 Jun 2025 15:45:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix an issue in bpf_prog_test_run_xdp
 when page size greater than 4K
Message-ID: <aEdj7n6e1Pb0WSBP@mini-arch>
References: <20250608165534.1019914-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250608165534.1019914-1-yonghong.song@linux.dev>

On 06/08, Yonghong Song wrote:
> The bpf selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow failed on
> arm64 with 64KB page:
>    xdp_adjust_tail/xdp_adjust_frags_tail_grow:FAIL
> 
> In bpf_prog_test_run_xdp(), the xdp->frame_sz is set to 4K, but later on
> when constructing frags, with 64K page size, the frag data_len could
> be more than 4K. This will cause problems in bpf_xdp_frags_increase_tail().
> 
> Limiting the data_len to be 4K for each frag fixed the above test failure.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  net/bpf/test_run.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index aaf13a7d58ed..5529ec007954 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1214,6 +1214,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	u32 repeat = kattr->test.repeat;
>  	struct netdev_rx_queue *rxqueue;
>  	struct skb_shared_info *sinfo;
> +	const u32 frame_sz = 4096;
>  	struct xdp_buff xdp = {};
>  	int i, ret = -EINVAL;
>  	struct xdp_md *ctx;
> @@ -1255,7 +1256,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  		headroom -= ctx->data;
>  	}
>  

[..]

> -	max_data_sz = 4096 - headroom - tailroom;
> +	max_data_sz = frame_sz - headroom - tailroom;

I wonder whether we should do s/4096/PAGE_SIZE/ here instead. Have you
tried that? If we are on a 64K page arch, we should not try to preserve
4K page limits.

