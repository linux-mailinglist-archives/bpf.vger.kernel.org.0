Return-Path: <bpf+bounces-21970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B40854AB6
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 14:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585E92882D9
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5F54BD9;
	Wed, 14 Feb 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWZULm4Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74654745
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918375; cv=none; b=F/mrbcKIMrg/21VcAPaPfX3P7/WgmEpfGA/+83aCiUu6+xSrAWI5hDaJhuRekakGiOT6Fd8cmdVMkmsa+p+kpn2FD6wCnHWMTcchNM40Tjm4XVaNk/CeubszpnVleozH4ZkFxfg74et2m6L4JBChZ38mA/nO7KnFTIgCjSAGBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918375; c=relaxed/simple;
	bh=Y/0Z1znV0Egghm2g11rYCmII7aPASItf6yoEO/Qj7TM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPC7OgsVfK1kqynkKQ4nr/qgZdEIeR8fmFqxDkhfRxqp6zmsKLX/r+8YBukr1CoHQLLZWaKahiGLIs9lJh3m/Xwf3axIfUoMYDxCowAlR+im+4jOfipQE6ZsFPhzTOkGzc+E7pNkxl4RfLFedEWp6xwgaRC65+nUF0EWJB54GVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWZULm4Q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411d253098eso9713225e9.3
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707918372; x=1708523172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/D1Yz4Q/QAAoMte0Dr7Mky8/VPqAqX1nFNytfhTbhUw=;
        b=HWZULm4QIhPWRLo8QDgfdbYBVW9nNqp0eJQEoJh+nPuYDZa5cCtxZprWbCUE2DqNPY
         UbxFrM85IXvfiXejMGP9cDwisRCz/OAQirN5g621yOTvS6VC/XmmPK2CMPdwmaWqFx4Y
         rBT3TmXwMWAtvcrsWlkOU/YQotpvl4jD2crwlBOIkKIL0Kn8AwFYuQPmIHUdbgnkVw91
         Gz320rL5xb6sdjOoaHmXNDCXoQkrQ4h8kATzcFgP5mXhaH5oYisIdHqsPCch3UFagySv
         AnrHPZT8LWRgIw6dCmpRxQzBWFTXwLGLFfqEseAbNJ78b5eZvLlGxcyDqiLhC2vPk3OX
         Dm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707918372; x=1708523172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D1Yz4Q/QAAoMte0Dr7Mky8/VPqAqX1nFNytfhTbhUw=;
        b=HXDblKyEb1jqRnusPUjE230vAxrmJuUZFU49N1K2SmCJzODw3xTSob0OxJlMJ/tiCV
         nRHaViaBDVuEzw4grKhRmae7ZOd/XX08g6+eq4NADp/bjTWU9vGALpUwsER7bBeYO+Gp
         Dfi3ksFE1CFXfq8WDs2UbGNglOgHG8DpCsWyN6B2N6y6PbyujQnWlErCK8zRp7mZHiwa
         C+1ZAfyGKArusGUxYCyv+0Mu23gJxxqAAtJndOx71eZsvzBX0mSJrHoO9gV+jlV+yqax
         IDZrx5YUZJ9NPc/1b1asOB0nXB94Qm8N2B08YFbUSylYmFznC4NvqNPM99IehZkPyXpU
         O5uA==
X-Gm-Message-State: AOJu0YzKyFWDQuU1exrdi+gjqeiLu0I44LnZbvlh1V77R3acPuVanD7B
	ZX41vJI45T52cSA6aVwxCBZYwD+ROhZeHnHv+/VD/qZtziJjVd16
X-Google-Smtp-Source: AGHT+IHdkH5NzrF49t+lybQdOkDMxVaOKnWwH2BlXWxLTlJsU2FgxmjnQVoa4a2VCQORLgmQHi8E2g==
X-Received: by 2002:a5d:4a4f:0:b0:33b:4e6d:1020 with SMTP id v15-20020a5d4a4f000000b0033b4e6d1020mr1513913wrs.34.1707918371508;
        Wed, 14 Feb 2024 05:46:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVz0uTTbljTVgN3ghW00ugaSiHtcwPckO1bFwsRgmfrPFTLe/4Y51QKnkCEtQTsS9JmzumjHpVX+eI1U+68cbAD5kUM6GtIGlberLIe9ObThU1YuqDT/u8GKqMHuTwDY0cXSVRG3A==
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b0033cf260462fsm799008wrx.110.2024.02.14.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:46:11 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Feb 2024 14:46:09 +0100
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	olsajiri@gmail.com
Subject: Re: [PATCH v3 bpf-next] libbpf: make remark about zero-initializing
 bpf_*_info structs
Message-ID: <ZczEIRqhXa27O-CY@krava>
References: <ZcyEb8x4VbhieWsL@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcyEb8x4VbhieWsL@google.com>

On Wed, Feb 14, 2024 at 09:14:23AM +0000, Matt Bobrowski wrote:
> In some situations, if you fail to zero-initialize the
> bpf_{prog,map,btf,link}_info structs supplied to the set of LIBBPF
> helpers bpf_{prog,map,btf,link}_get_info_by_fd(), you can expect the
> helper to return an error. This can possibly leave people in a
> situation where they're scratching their heads for an unnnecessary
> amount of time. Make an explicit remark about the requirement of
> zero-initializing the supplied bpf_{prog,map,btf,link}_info structs
> for the respective LIBBPF helpers.
> 
> Internally, LIBBPF helpers bpf_{prog,map,btf,link}_get_info_by_fd()
> call into bpf_obj_get_info_by_fd() where the bpf(2)
> BPF_OBJ_GET_INFO_BY_FD command is used. This specific command is
> effectively backed by restrictions enforced by the
> bpf_check_uarg_tail_zero() helper. This function ensures that if the
> size of the supplied bpf_{prog,map,btf,link}_info structs are larger
> than what the kernel can handle, trailing bits are zeroed. This can be
> a problem when compiling against UAPI headers that don't necessarily
> match the sizes of the same underlying types known to the kernel.
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
> 
> v2 to v3:
> 
> * Modified the comment wording a little to make it less
>   misleading. Specifically, noting that the supplied
>   bpf_{prog,map,btf,link}_info structs should be zero-initialized or
>   initialized as expected. In some cases, subsequent invocations to
>   bpf_{prog,map,btf,link}_get_info_by_fd() helpers don't necessarily
>   require the bpf_{prog,map,btf,link}_info struct to be
>   zero-initialized, but rather that it just has been properly
>   initialized at some point.

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/lib/bpf/bpf.h | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index f866e98b2436..ab2570d28aec 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -500,7 +500,10 @@ LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
>   * program corresponding to *prog_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized or initialized as expected by the requested *info*
> + * type. Failing to (zero-)initialize *info* under certain circumstances can
> + * result in this helper returning an error.
>   *
>   * @param prog_fd BPF program file descriptor
>   * @param info pointer to **struct bpf_prog_info** that will be populated with
> @@ -517,7 +520,10 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
>   * map corresponding to *map_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized or initialized as expected by the requested *info*
> + * type. Failing to (zero-)initialize *info* under certain circumstances can
> + * result in this helper returning an error.
>   *
>   * @param map_fd BPF map file descriptor
>   * @param info pointer to **struct bpf_map_info** that will be populated with
> @@ -530,11 +536,14 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
>  LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info, __u32 *info_len);
>  
>  /**
> - * @brief **bpf_btf_get_info_by_fd()** obtains information about the 
> + * @brief **bpf_btf_get_info_by_fd()** obtains information about the
>   * BTF object corresponding to *btf_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized or initialized as expected by the requested *info*
> + * type. Failing to (zero-)initialize *info* under certain circumstances can
> + * result in this helper returning an error.
>   *
>   * @param btf_fd BTF object file descriptor
>   * @param info pointer to **struct bpf_btf_info** that will be populated with
> @@ -551,7 +560,10 @@ LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info, __u
>   * link corresponding to *link_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized or initialized as expected by the requested *info*
> + * type. Failing to (zero-)initialize *info* under certain circumstances can
> + * result in this helper returning an error.
>   *
>   * @param link_fd BPF link file descriptor
>   * @param info pointer to **struct bpf_link_info** that will be populated with
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 
> /M

