Return-Path: <bpf+bounces-21046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB8C846F50
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E110E1C22856
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8601213BEB5;
	Fri,  2 Feb 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyVASkPG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63565608FD
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874331; cv=none; b=NgrI2D7e6RmD2BKi9hG2OR0eq2YiJbw3FAzR61mDk02fCjvecI0I6FCDMJfd3DUbDZiohjvuX1B23YN83QxYrAkVjsYotVa0OSOGPiLwqsz+FCXsj81eLEx3sriTHOLAIZan40HBj/FStnT1EoF/WpcItWpul9LnyeXOxpGl6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874331; c=relaxed/simple;
	bh=T5mIuZ/SwLWFsPXnrPEOC9EciPyGVDTkvjKJOX+GZKk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As6/8vhNMIKD1vTSw3GDT4CAoqXs5AAhkS3eF8qZ4pn9v1R7Bsu0KtBeenHXbGPDnNBnYQQe6ijCZTRrggWzCAyLGjMWcBftOLh3Rarjev0kAXlxZMa9LQ4XjPPZdl+d95/Utv5qJi2OKqLmhSqrRdx+SjsX01D9iZzBVXXik+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyVASkPG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so2848425a12.2
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706874327; x=1707479127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DUag2bNXnLgT6vtKfx9vedz4gfBKi/qeU1UpbpH5qu8=;
        b=HyVASkPG6KE80MPsk4CnZ3w9Vv6rqyNXTxa7m8tKiXq/gyYD184LHRFehp1CWuHItD
         UWY2mVo/SvDZVm+T5jDWeKc3digxss182wG+Z2YbCjwZXcj+JEs7ng7o1duy/Y1tvVtK
         I3idW97pJk+g82JFqRerTPj+d+fal0A5nU84n8iVCgmnXNU+bwMc+hOgKSjS9ti3NJMY
         dWT5Gt0vs4I/Z7gTwkhQrqWDF3uOA7u6RRL5VB8rdvJO4fk6hr3ljMtsRnX/tzWpmKD7
         1qlqgzexHCWbhmiq4fJrHR7A5TgHptjs0r35c+KM3olxOwNOdgaHRO3R0j1WP8ip4Zs0
         UoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874327; x=1707479127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUag2bNXnLgT6vtKfx9vedz4gfBKi/qeU1UpbpH5qu8=;
        b=WBCaNmVBnDPClOTSi56HJTBvgRq/RRaWD3ndrUNkK/5nKjA2rQLcLHwfkIfNuIozLD
         d+EiTflz0Hcs3mTX5k6juoWNX5PgrcfdzB6cfxiNcCuvo/dUr6fFfzuDP6W8APgWP4pu
         7IocUkUkpEm/tFFmBFzpZbmsutGXC27ivvBLeUdQTSySD9mCuRZ/XJm/a1W+gsdvPFwZ
         6ZZnvZVdTXhifKl2OfPqR8S932KsR3VMvb8d3x8hGY+b+rRy6hD3NXHAXnTFPL2im/yg
         urSiRW9PZ0U61xsspYTiILyy8cKmTPttaeR0fs+1ldlmEoRChfymlr63Li2zt9I1auuM
         6gNQ==
X-Gm-Message-State: AOJu0YxT1Xt22MVpo52U1datnxcaSqcdaPZRve0SQM5tcljTnRFXdI0F
	u0qdfuuy12LCWSwlDHVVH0/krv9bMfcRKQHBwI9jg0R3Yiaf5vkU
X-Google-Smtp-Source: AGHT+IFybhEnoxSivgmOIjFSz1hCUudk8LD/uI8/sgKCW2DQDg2MdYB8g9+uOwE7Pi9yWxyupVXFeg==
X-Received: by 2002:a05:6402:2211:b0:55f:1728:3b33 with SMTP id cq17-20020a056402221100b0055f17283b33mr4344044edb.40.1706874327217;
        Fri, 02 Feb 2024 03:45:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV2s+ZaEqdPKzHhUG5cKZL/nH/mrHTeNCMMQ1qpt6H48mlQzA83++19JoPozRdq37xuj2t2ulF2xywyh2r/UqPrRypbliILZQmWv7YbXStM0BtciiU89DRkfKS0U+mbxSKEbjTsQtxZUFK90HJ+8qN0h+WQjGln/K4uqnnnjY8OnR17YUCsFF+3Sm6MkZLscWMkHVVLF1+wlCStJDkBZjtJ/m6bXKo6vK8znrtS7lg26/qBCFZkS+9CpA4K9ARWS36xerKtK5B8B4z+EV5v90/vqmmz4aN57YVFzxjulQ/a8uXaz9AhRKec91owcEcdK6pJE8qny/E8Bt4MFICMsSMRAna9IkeRjA4M6hPGW3az/miWZ2yqtbKZX6UHhQd+11uPr14JZB7YLGjqsU5/+pG5QOFwrTpNDLqmBXuTevR4kqORt7RzjwTS+CsPNQIV2FhfqRw=
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640205d000b0055ff1749b15sm477006edx.66.2024.02.02.03.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:45:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 2 Feb 2024 12:45:24 +0100
To: Geliang Tang <geliang@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH] bpf, btf: Add DEBUG_INFO_BTF checks for
 __register_bpf_struct_ops
Message-ID: <ZbzV1OVvSzQkNRqb@krava>
References: <beca71007a184b2d199f404a471f020fd4359823.1706863036.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beca71007a184b2d199f404a471f020fd4359823.1706863036.git.tanggeliang@kylinos.cn>

On Fri, Feb 02, 2024 at 05:18:48PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Similar to the handling in the functions __register_btf_kfunc_id_set() and
> register_btf_id_dtor_kfuncs(), this patch adds CONFIG_DEBUG_INFO_BTF and
> CONFIG_DEBUG_INFO_BTF_MODULES checks for __register_bpf_struct_ops() on
> error path too when btf_get_module_btf() returns NULL.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  kernel/bpf/btf.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ef380e546952..381676add335 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8880,8 +8880,15 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
>  	int err = 0;
>  
>  	btf = btf_get_module_btf(st_ops->owner);
> -	if (!btf)
> -		return -EINVAL;
> +	if (!btf) {
> +		if (!st_ops->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> +			pr_err("missing vmlinux BTF, cannot register structs\n");
> +			return -EINVAL;
> +		}
> +		if (st_ops->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> +			pr_warn("missing module BTF, cannot register structs\n");
> +		return 0;

given that we have the same code in 2 other functions
would it make sense to add function for that?

jirka

> +	}
>  
>  	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
>  	if (!log) {
> -- 
> 2.40.1
> 

