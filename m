Return-Path: <bpf+bounces-59405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B9AAC9A13
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A16B189E46D
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41685235071;
	Sat, 31 May 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWk0lN8D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55372608;
	Sat, 31 May 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748680220; cv=none; b=SmKz/00/I6VIiBY5UYw3LYrdNpSRftHpqHUDHdCF2eOepZ4R7IL5UIjCZbAimdOV49GYguAPiNFLKMmBvhJyBY4NSCjL2e4MXJw/93zfl2of5Su9gBepOm4+plJbI1FXZvMSB5drYpTYlAZ2qa7s0P4iEBQzW9GlhP0ZdvCymrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748680220; c=relaxed/simple;
	bh=SXSXDy40WaxtHCF6QED8ZGmEZ1lJdaaHt0UvQ6KDqhw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uON9H7qNivlXG8JgCTwj8y31fMzI2zhDP0ZaYPKg/wa3zfrBmasYpPgkGR0Zg77gfkjAm6/XZRLke/YXZ7hzfiTJ2QtOZ+Q+TpkhG3vmETPODdP3L/t8xpDDCTseitDlAaeTQfya6az6TPR8qRRsmclJfehEGA2vl3JArS8DREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWk0lN8D; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad88d77314bso490411766b.1;
        Sat, 31 May 2025 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748680217; x=1749285017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPvaR31j5liYWmKFXeknzL+qjeQFmOq6Nv/68VW+G58=;
        b=XWk0lN8DycXYhFhufFUwRy1csVb3MxJJbtHfaoOY6ncKc2k7POZ+xk41USKEyVfO4I
         LhuDULfe+lMtq0c+b2yg2Gr4FkkwOAUSrneyd59umw4PzNZFrAHFOEp/KCybMghKW1Mi
         FBWzwIyrDgqvpyQaSNXts1mghn1xsF2SNnUGMnNHwffP0A8LtiCQdhPg/gKtvWG6BpND
         a0bFxWBVxZ1NdqE+wYcUcXXbeCvoUdZ8itRwZr3I+eZXihm9RNV0YN878v/ZyCG1vHlM
         tQqKilxi3hEk8EnaQVlcBBcJVsFnBW8EdgWPG7IKkhSDifBRSUwenKCDJCD/j66qUQxn
         Df6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748680217; x=1749285017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPvaR31j5liYWmKFXeknzL+qjeQFmOq6Nv/68VW+G58=;
        b=rMMa4R9ti//z5z4RvV9kvHHRIZLZt5M6UM2uv2VnAu2OnofFFudYm1VrkAOT6lcyIJ
         /ejSeGxoTV1X42FemIGLtuP9tNEKKg0tjgyyxtglq0uhSdjxJWHAH6zeynHz9rNLvSsM
         HbjcMoDs4ivwc/+kfo8TTYYO3hpn5Vt+mvAOvzjqUzIxdMAPwGSFVeAA3/8Gq0Q9c3x9
         Rv4a61j2hMbTghq0gZapFej2GJQsoud80c1vLNKGMveAP+VuCH9h3+a5ox/zkShlQfcW
         DcZ1ZJV2PzM6CdJD5FW2rKBtDn5cfRdIaX/dB6u0BIPqB1sncWCSj0I942IlRT3YZqM/
         75zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQDTGz3oOAfQJ8rEo8ZvfbXwv9g2JSsgsCXzju9Hgfmp2MvyxzNF2i2WehwfJWyy0bkp34x+6v3/pUC3Wj@vger.kernel.org, AJvYcCW360cCqtuml/cRAbUQrmKoDC4go6YM+xYLp1l1x0wadM/chAFSFdEMmyQPYc5k2mifYCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqAFx6W7RjdV0Jl1rcyT4fPTbUEGIU/amTjoG7K0wRLTVk3QUt
	MpJkP8hDVsqvqg8bRIj4J8aHtf+4FWeIXCLkcrbWvxdPXFIZI3i6vqtg
X-Gm-Gg: ASbGncs2J8fuh4Ea5xgSAqgyDmbQtHTkrlaYk9mgPtS7M5pxbPg+PwCnBmYYbSR3MkG
	kMZS/vlUYceuoggnJ+r/cn5Q5WR+5OjaP7vRdkTisvacOvCxEE6SwwDdyBUF0JCyRCq6ReWH2yG
	/3f7F1OkUhUOM/srY8tPuliqR+xo4h7O73dNvzM2CtJCdk9gGxPxxrKrcrA0nzi32S7aIeBzR1o
	MO32A8lc+vM2+lrqd53Tu/BjDl4ziEAUYX5sMJPxUBwi1iXdmcJrLA7CU03Kj+rXZaE1SDhsk2T
	GYbQcdlkTJvluQKRMnn/nPZDUmI6rTJTW8BQVC0SdIXSaZvcSw==
X-Google-Smtp-Source: AGHT+IGotvBseJAMbLvgO9Xrpod7ZwJRyG5Td7SuGZoIXVLVp59qbNcJuN7+yc4STOYDZfZx+msYYQ==
X-Received: by 2002:a17:907:9721:b0:ad2:4c38:5a22 with SMTP id a640c23a62f3a-adb3243dd27mr541887966b.51.1748680217139;
        Sat, 31 May 2025 01:30:17 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c2a762sm2899876a12.4.2025.05.31.01.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 01:30:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 31 May 2025 10:30:15 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next  1/3] bpf: Add cookie to raw_tp bpf_link_info
Message-ID: <aDq-F9nK4K74ubjo@krava>
References: <20250529165759.2536245-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529165759.2536245-1-chen.dylane@linux.dev>

On Fri, May 30, 2025 at 12:57:57AM +0800, Tao Chen wrote:
> After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
> (raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
> like kprobe etc.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/uapi/linux/bpf.h       | 1 +
>  kernel/bpf/syscall.c           | 1 +
>  tools/include/uapi/linux/bpf.h | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 07ee73cdf9..7d0ad5c2b6 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6644,6 +6644,7 @@ struct bpf_link_info {
>  		struct {
>  			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>  			__u32 tp_name_len;     /* in/out: tp_name buffer len */

there's hole now in here, let's add something like

  __u32 reserved;

jirka


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
> index 07ee73cdf9..7d0ad5c2b6 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6644,6 +6644,7 @@ struct bpf_link_info {
>  		struct {
>  			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>  			__u32 tp_name_len;     /* in/out: tp_name buffer len */
> +			__u64 cookie;
>  		} raw_tracepoint;
>  		struct {
>  			__u32 attach_type;
> -- 
> 2.43.0
> 

