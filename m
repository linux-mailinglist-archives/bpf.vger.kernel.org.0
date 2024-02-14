Return-Path: <bpf+bounces-21958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D100854400
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 09:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC00B2123C
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60840125A6;
	Wed, 14 Feb 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0hXPZrT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8FE125A1
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899038; cv=none; b=qHoByt59xtZWHvherLlCxBwGMci5t3LNP6nv9kHch3hVRfS98kakXpGcLXwBtd9RVmmhli8DL54eW79h+4xJJt7jUceK/CAii1zm+lZQ/+cO+P1arYphd3F3xZzafxZqQT3kXgfQwO5ASdUu+ymQjxwybPCrt6TjH49P5lQ5qx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899038; c=relaxed/simple;
	bh=Puuvln02ttVnQT9SoAZ4aqzONn0CjB+qish1y+GDzvI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8rDM16PFHkXPKUgl+moWLvebUS2Id77MM3hEj3mJDn4sPrwZNQ5mLyQuWT/sdaCmVfhKa6f0xz78N6Ve9jx0qq3gIs9YT21JBifQnUmH3I8jLFPdUxFm+XSDYopVrPxC0vIThDgQ0N3MfotH9OoYlUKznGUv2Al1KkAT3v4fmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0hXPZrT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33cd57b7eabso901255f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707899035; x=1708503835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qx9idV/v0/1F0cQJ6MLWsvHtt2DZjORZiOGiDZGoC/U=;
        b=A0hXPZrT/LSzuMK9ZDYevITIg2ZGT1/64qzU9KwV6p8NorIhANrfdz58CY44XYg8i+
         JZcECHa5mFw+IFBWpFtRSmbO3TFAa7//jt+DQzh2NGPrPwLru5He/nalotvnmc+EKPGH
         4HceKfVIN5ZNEoD6wbVCH6MW41ALkrz2oWd7SMQiL00fipegqJO8oZdeE5hREIke/rsY
         nlGxECwa/mQPKSc7BChlMxHAVN2KJUP7/CiyrW7gXIcfgG7TlqK1lSYe3QbajYYqjW4J
         IH7Ya8/jdKkH1QHRK3kVgiKobgf265klIeafOwWpn7ugeh/dA8LRAgFwxLSnCgHtirq8
         p9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707899035; x=1708503835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx9idV/v0/1F0cQJ6MLWsvHtt2DZjORZiOGiDZGoC/U=;
        b=Dg8/dy7AJK7kAaNO/r8UQL758xPRzsPo3fo9w1gVX8RHKiRKWm8/MEMiTlusbPLX8o
         leZ0734ZFu2McfNej8HkvNmmnUaBjFG2FgtKD5Oi612LusJCGPZJIflwUvBdNo+D/NRh
         kY52Wt1bNgzZmCwTufDQlDKVlaN5tMjKVMU6+rhVu+R7XYogtxiX8U5eXxpdtE5R/xNw
         r48/uBPGKqDz4kJNhWV7145hmx+S3Q8NHbQbXxFQ9EYqkJCEuao7GWv7pPEjNAqQJJhJ
         x5bcLaXpa3T+uHkM7qhzFNDc06J1atZ53MUxSLBSt990PbjDvVfdccNnVmW6rh7qCMpz
         MsKg==
X-Gm-Message-State: AOJu0Yx6vvN1YPfpPEEwHWlq5fS4g8SP2F826Ht2SxULgHVBRv3zkExj
	YqLf+RK9r5Ufun1uDANby2DoriKAljG9wg6CvpURrAV9NJhjlL7woP/4+FL3
X-Google-Smtp-Source: AGHT+IFv+5Ae+UW1/hMF7lrW7mzvP+3SRfufdKurnKr+q2K3ENH1RA/Nzyer5Qz1CvZ3vzUYm1/TnQ==
X-Received: by 2002:a5d:650b:0:b0:33a:ff6f:744e with SMTP id x11-20020a5d650b000000b0033aff6f744emr1217585wru.18.1707899035088;
        Wed, 14 Feb 2024 00:23:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVohoTX/LoMDaXpFrXGe6y5ofYtbMHQ5+og4P+MzmqqYrSXLwsaNtNqJWUlCmfebNEz6TAyGZSA40TU40kcV7cK+viQ8XsVdYpOhQh6MkDy57E=
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id bh2-20020a05600005c200b0033b7fb4d7dbsm8850275wrb.34.2024.02.14.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:23:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Feb 2024 09:23:53 +0100
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Subject: Re: [PATCH v2 bpf-next] libbpf: make remark about zero-initializing
 bpf_*_info structs
Message-ID: <Zcx4mbzhFBGJp36N@krava>
References: <ZcxsEQ8Ld_hqbi7L@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcxsEQ8Ld_hqbi7L@google.com>

On Wed, Feb 14, 2024 at 07:30:25AM +0000, Matt Bobrowski wrote:
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
>  tools/lib/bpf/bpf.h | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index f866e98b2436..3ed745f99da3 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -500,7 +500,10 @@ LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
>   * program corresponding to *prog_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized before calling into this helper. Failing to zero-initialize
> + * *info* under certain circumstances can result in this helper returning an
> + * error.
>   *
>   * @param prog_fd BPF program file descriptor
>   * @param info pointer to **struct bpf_prog_info** that will be populated with
> @@ -517,7 +520,10 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
>   * map corresponding to *map_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized before calling into this helper. Failing to zero-initialize
> + * *info* under certain circumstances can result in this helper returning an
> + * error.
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
> + * zero-initialized before calling into this helper. Failing to zero-initialize
> + * *info* under certain circumstances can result in this helper returning an
> + * error.
>   *
>   * @param btf_fd BTF object file descriptor
>   * @param info pointer to **struct bpf_btf_info** that will be populated with
> @@ -551,7 +560,10 @@ LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info, __u
>   * link corresponding to *link_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized before calling into this helper. Failing to zero-initialize
> + * *info* under certain circumstances can result in this helper returning an
> + * error.

this is slightly misleading, because like for uprobe/kprobe multi links we normally
call bpf_link_get_info_by_fd twice, first time with zero initialed info to get the
static data and then again with info filled with user space buffer pointers to get
other data like addresses or cookies.. I think to some extend this is similar also
for bpf_prog_get_info_by_fd

maybe something like:

Note that *info* should be zero-initialized or initialized as expected by the
requested object type. Failing to (zero)initialize *info* under certain circumstances
can result in this helper returning an error.

jirka

>   *
>   * @param link_fd BPF link file descriptor
>   * @param info pointer to **struct bpf_link_info** that will be populated with
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 
> /M
> 

