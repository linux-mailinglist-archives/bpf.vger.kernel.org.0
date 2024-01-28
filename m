Return-Path: <bpf+bounces-20513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A883F4B3
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 10:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63472B22068
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2DDDD2;
	Sun, 28 Jan 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msScNsRC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFC1D6AA;
	Sun, 28 Jan 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706432701; cv=none; b=LLXdubwj4QhJNofPR3t+vS/WNbYU+gdZG8/hOcQCKZ43sykCasyLILRlq8+WmnX8vAYofshEuM23d4b0kt5tFfw8NK+cE+QdoNb+ePgv9iUwC9JRcWky/BAqWvLFMEmKh4twC8VF4FF/5wXvrZQoDM5pjl9fnkJeLilyN1R14O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706432701; c=relaxed/simple;
	bh=cqQB+hxFCinicygJMRW5BqeUGRh3MDCarAyABJ+7TSA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TffU4IwBOnfw97VBL20oEOSxp4LWq8MAho3y9JhnZbwbXpoQPkk56+psD9oibkB/+78P6PT03dB9eSl+19Vgn35TQ6IYMR5T4EGX1wNkeyvaV/4T1JEvl1lC5VWDpuZFt80jf1l7efBkjVBebPb7jMhYJSnxe4BaWV27WqC/qHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msScNsRC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ae4eb360aso885245f8f.0;
        Sun, 28 Jan 2024 01:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706432698; x=1707037498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7m4rFHoaCpBaJ7r/5zIVxCi1iGTVkKhocl6qddIiYRY=;
        b=msScNsRCh29TD4iC2P0YkQbIcwMbQ/porT+u2eYr3LjMCAB6yLDDdD0LRBfE0GrhVy
         iNGp90IsO+0QCuv4IZrbQJ4/mjUqZPHzi8IjfCOJ95TX1HZH7M0Z2Lw6mkgn6XEX+hYn
         q/ADU1hON1KGySeEFcTLbzL6TWMCp5Uvhz9XW0Uc0zZDk7XMWDzzedTbd5AU4241MYc3
         1hwU4TeIB+j/kk4/qk37hmc2XEdzskmY/R+BsQAnEi0BAd28MW7GqzExf0MIKBTDAvoF
         U6CGq8SSki9M8A9WQNZB11lL/Q9tFg03bnWH9ioUjwfAWbKUizM7aJawKjsuMAn1pCzt
         k4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706432698; x=1707037498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m4rFHoaCpBaJ7r/5zIVxCi1iGTVkKhocl6qddIiYRY=;
        b=asFnArAAi7CaFviyBOXThZuRvqJOtLJhB36jqwaRBUlzicBBO+5i++hlE74CRHrG3p
         gYA+WYsZ01p4depFhfusW4Yfc2QcDIEKat052Xm4MX8mtd9sXhzbVzie7vTwc1dRBQzi
         XwST0arCZr2bn8spPKJbMN4lwf6d0pud47GkmFW3WnYssVlzDHhoHOKLoZgsUKYxL1ZC
         mbkctFt8rlCRHx1rZh5vFdUNFkA7kBA5MCsFLnpE0O+2fPtdwysEYbRnXcAUkDUOrAoy
         8ziwRgYap9aN34+zJnGZDCtnlB+S47FdftoNeC4MAdAt36osGjb3s3pHI0uLuflVa4u3
         zPLQ==
X-Gm-Message-State: AOJu0YzX68cmAfRH9bod49q2GvG+cL2gbvCc3U6sNccfT0xSRYs+mZVs
	oGTSTbgmeY4oPbMognmmnmr3uyBr7/Av7yiuxiojvqH0ow+UTQ4Z
X-Google-Smtp-Source: AGHT+IE1t2Mnk5Zgaifz4gNtmQc3COHdjcATjOoXrnJVcoR64p8xTK0Ylcm/FlGahoO65PIONulMUQ==
X-Received: by 2002:adf:f011:0:b0:337:8f4f:9075 with SMTP id j17-20020adff011000000b003378f4f9075mr2311126wro.7.1706432698025;
        Sun, 28 Jan 2024 01:04:58 -0800 (PST)
Received: from krava ([83.240.60.213])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d60cb000000b003392d3dcf60sm5160333wrt.88.2024.01.28.01.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 01:04:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 28 Jan 2024 10:04:55 +0100
To: Menglong Dong <dongmenglong.8@bytedance.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: remove unused field "mod" in struct
 bpf_trampoline
Message-ID: <ZbYYtx7-Z-A07K4N@krava>
References: <20240128055443.413291-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128055443.413291-1-dongmenglong.8@bytedance.com>

On Sun, Jan 28, 2024 at 01:54:43PM +0800, Menglong Dong wrote:
> It seems that the field "mod" in struct bpf_trampoline is not used
> anywhere after the commit 31bf1dbccfb0 ("bpf: Fix attaching
> fentry/fexit/fmod_ret/lsm to modules"). So we can just remove it now.
> 
> Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>

Fixes: 31bf1dbccfb0 ("bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules")

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  include/linux/bpf.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b86bd15a051d..1ebbee1d648e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1189,7 +1189,6 @@ struct bpf_trampoline {
>  	int progs_cnt[BPF_TRAMP_MAX];
>  	/* Executable image of trampoline */
>  	struct bpf_tramp_image *cur_image;
> -	struct module *mod;
>  };
>  
>  struct bpf_attach_target_info {
> -- 
> 2.39.2
> 

