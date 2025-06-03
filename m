Return-Path: <bpf+bounces-59499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D42EACC655
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B7716EE26
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 12:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C81D63E4;
	Tue,  3 Jun 2025 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwTKIThU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79492208CA;
	Tue,  3 Jun 2025 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953166; cv=none; b=uoUWxTJDfAQ449L3SzSTylwDN/fCD0MiGNMeBQ/vkwwHVLDylJBn6lP3cfeECvyIgup9GcnwinSw9WkDdRQrFy9/dQgOY3DzBAw8KYmEM4x5ILgdA3jOeYArl/US46OeQb6/LpAGejb9+Y8sx9AWxJuPuDuUbMRWDmXs3I/alCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953166; c=relaxed/simple;
	bh=DqInlHgGUC8wA/jx/Z/vUgDAF4d8VLW898q95/N8Pgc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd2Sgbx1bCtg5lTkGLlaqt3a2JbamfMRvU3NkC7dUbzEOikWuUPX0uP++Gqo99zrjvErhMyRJWv235l7l5udsbB/BDBup8W9OBWKZ05e2aWRoZEdbYZOg7ROUJwlyufnXCdOGrqIrUWwlYMu8vAWyL+seDYBTLobwjI9cJVXEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwTKIThU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so1201564f8f.2;
        Tue, 03 Jun 2025 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748953163; x=1749557963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bl03MDUx0F/SrGXUBQC5RzPHEcFKL9mDrZ+xTfAWQRg=;
        b=NwTKIThUB4djT0JpEeMCaT4KN6ArEMWoJyxOAtg31yQWb9wijHa3G+t2wK7+2WzOHd
         SFmXr+E+HYyDLD1L1FB76LZIWYBXiaeAKdT1ZF1NGLiCsDlNf3fkgf1XwLTx9EAWJeBr
         sCxHac39+VDAAMFB9Ju+B3AgY5jYz56ZmfQ6OdW/6WcK7e5+XcjGYaWc8RnVVeMLo3dK
         Q+8tFu/k5rr10xRWnrdoH7ONXqCeOatzi+SPv7BYN0K0Sr8rwUvn6IDFuL5Zrwo1Cfg1
         Jcz5S3YUrJbkLUABJ9KCiWIbez5QaQ0JpccbQtoO0sRs/IwWQOVZQGJiiuuEVsOziBcK
         zxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748953163; x=1749557963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl03MDUx0F/SrGXUBQC5RzPHEcFKL9mDrZ+xTfAWQRg=;
        b=G0Tgokl/dCTo/Mlz8lUuBRXNAMGk+/wYqnU8zl39uq25CXMpK0/z81syc97roD8HV2
         3mPB+7amD6quTuyovjUMVMFZ2fdhdv7zNTI7y8DKgkE7S405XL3jCv7XDGtbagkt8IiI
         X3g9WBxNO/6epeegUNm3++VI8a18gSEf0/imeZZFwiq+OCwBbL+2OMEJw13cYyFX1eZt
         PFK45Rst1ymVQLJp2FFw3hGlFZgwdzZHTfTkZqqqeA3er0QXa2Y/mMLDj6ZkodegFYPH
         3Pg09zDga3zsEhKnqJZIv1pd4JSmT+kwbtziXxwGCR+62thNoDrRi80c+y4Ve0oyBB/D
         LADQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaAhDVSTcW24EwdaLwvTNCth5ACxRVjBmz/WOaaLgRx20f4vlWte/npA7hUJk7tZW/Qls=@vger.kernel.org, AJvYcCXVAsU1PRW8EOd14C/nPY5RWzRr5rQ0kXmRGjz94sX71jGxs7FQgo6MaZsekYHBXoTkt0BvXbbG3M6RWqUo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1J+LhPUJLwVx0wWNoCOrIwd18XnNd1gGIn5TWMCGAdFlwevw1
	ZSd8Bvy9xyIQuMsyXqr0TSbq17OmhMJvxITfsCYJ7Xu29tPNyeI2HKe29g4cPsOfcYQ=
X-Gm-Gg: ASbGncsgAPLHecb92vCzWnbUq8WLTW8ha7HiWywBMKMqnIi8dpFkw5+JF8ypMpDuCFr
	cc0rVAjiGJY4wOo0Mf8H4VVppLb+91F1mYgiwH+5OAHDbe8h2dP2Wgh7DTNiym/spqAySbJBIlQ
	WdsGtKm4lxJEKstdUmqygGWGUxQSkrRwWMkWXJPLQaUbUzMV7FXxm4DyFx5A/R9o6BksWY4ZTxz
	2xKjWT7pzBpSmIK+NiJviK6Cw1vfgSjiD3CKDzl890FZe39roT+SMuV+r3YqfxHAX04flSGlAFb
	IkFeZ3gxsgYSVwuGTqUuLfagd5Rbb3C75YIs/4c=
X-Google-Smtp-Source: AGHT+IGItsfgYlbHQZDCP71xRq6KTlEQWb1ZRdGAl6gV1Z1mtfsj/v0ABe4kDBl3vVSrU+o1K3l0rg==
X-Received: by 2002:a05:6000:3112:b0:3a0:7f9c:189a with SMTP id ffacd0b85a97d-3a4f799acd4mr13508939f8f.0.1748953162464;
        Tue, 03 Jun 2025 05:19:22 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009fbf7sm17998771f8f.83.2025.06.03.05.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 05:19:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Jun 2025 14:19:19 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add cookie to raw_tp bpf_link_info
Message-ID: <aD7oR_JGXuG4ru9W@krava>
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603022610.3005963-1-chen.dylane@linux.dev>

On Tue, Jun 03, 2025 at 10:26:08AM +0800, Tao Chen wrote:
> After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
> (raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
> like kprobe etc.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  include/uapi/linux/bpf.h       | 2 ++
>  kernel/bpf/syscall.c           | 1 +
>  tools/include/uapi/linux/bpf.h | 2 ++
>  3 files changed, 5 insertions(+)
> 
> Change list:
> - v1 -> v2:
>     - fill the hole in bpf_link_info.(Jiri)
> - v1:
>     https://lore.kernel.org/bpf/20250529165759.2536245-1-chen.dylane@linux.dev
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 07ee73cdf9..f3e2aae302 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6644,6 +6644,8 @@ struct bpf_link_info {
>  		struct {
>  			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>  			__u32 tp_name_len;     /* in/out: tp_name buffer len */
> +			__u32 reserved; /* just fill the hole */
> +			__u64 cookie;
>  		} raw_tracepoint;
>  		struct {
>  			__u32 attach_type;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9794446bc8..1c3dbe44ac 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3687,6 +3687,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
>  		return -EINVAL;
>  
>  	info->raw_tracepoint.tp_name_len = tp_len + 1;
> +	info->raw_tracepoint.cookie = raw_tp_link->cookie;
>  
>  	if (!ubuf)
>  		return 0;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 07ee73cdf9..f3e2aae302 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6644,6 +6644,8 @@ struct bpf_link_info {
>  		struct {
>  			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>  			__u32 tp_name_len;     /* in/out: tp_name buffer len */
> +			__u32 reserved; /* just fill the hole */
> +			__u64 cookie;
>  		} raw_tracepoint;
>  		struct {
>  			__u32 attach_type;
> -- 
> 2.43.0
> 

