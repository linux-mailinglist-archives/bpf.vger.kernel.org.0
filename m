Return-Path: <bpf+bounces-30906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3370A8D45CA
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658D31C219BE
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA34D8AF;
	Thu, 30 May 2024 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFbE9LRs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EB4D8A1
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053128; cv=none; b=sBdnB5h7XvH4zydMo2OhK8IOwrqYAsArbJbk+n0m6bQjSNfu5VwC1KteWp2F2igdfv5+AWEDcGYpJDjPd03j8FEDezYf8a68KidgaNQgiDaHvv/ZBEmpX/ijX86BKcv6VpaXA1C/1rdMs1yRoHbOmsEDUF9AH2MlXc6+ShT2ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053128; c=relaxed/simple;
	bh=wDpOGW33rbU+AGQTylkolR59dIkgVPEzz7WwsJezHY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmFBQRYF2F5p0abvIedxaNKIi2PjZ5gpXmrAmbFgpoCBc9FFvqXDiTqqdk6SHh+xmW2t+Zg+jtY9P9DLenfXxxgvTZ9wRyVtJi8sMOOOOeyJheoEXLXel/by25AlyUx14mbZY5Xz83HlSWtNdKFAa6Gc9fLX/s0SsVR6kol7JQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFbE9LRs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421124a04d6so6631575e9.3
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717053125; x=1717657925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K387m7xERm/MYxfu3JeJErTVIW9VwbJTiSjdxG5dKXY=;
        b=kFbE9LRswFfFgUfBbS0BPZJK5XJ4pEU7xbxmaEYoJ8VHwtZ1TZu4X/Y9uyH3QF8POY
         b3hp0Vg/YVZWTxdJEp26lOsLfYkoL58USkNW4xt/fvfTGItBqATgZQcWujSwa2YItGMr
         lBH+iqnWWvgbRrpgRR7q6VRzh1bNXGxP2nMlnFTQwOOW5hE/nqqw95VXNACf4bQFaOZ8
         9AXNowATFQShkgBmZygz2dd7IJ9MifW6rAZV3YRNkBduCo+mtoCMAYzqFuKnSnuNZ3i4
         Tq2+5K8IL6d9TuvEJJQKMrssP09ME+a8JWO2pimjOZQM5BxhxGjcE7I9VMFs4PwAvt0e
         CfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053125; x=1717657925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K387m7xERm/MYxfu3JeJErTVIW9VwbJTiSjdxG5dKXY=;
        b=PFaN8Zx+3++KOTYkzFhgkLYpX91bkOdgvuJtyxfG+9UqEXnDD2QOwqFW+NbdJsGKuo
         LO9gulQaR+zb0m8VspAU4xX+bg3ZxFkQJlZycClGRbdJd0jvJNHtBcJgM2R2YL/LLz6i
         WgrK88ach5KxKdIVDRE1tbWdDvqyl/XvbmB9uip9erxAs9seR3gTeAXoJsgYkMeZThbH
         AM0oX7zGyXEsabDfTVBaPvbgs1IovKNHJY7XS5tpU/dfvlAIMGIBMC6+oC+iX3lCI5i1
         HzK+3XYHnLJI895Wt0QWkDBlKfOqbba4TvAf+Q+P5p5J+BnoraFbeSmA5WbGPNhgjPiu
         lcMw==
X-Gm-Message-State: AOJu0YwWk8w4BI3CCWptozfin9id9+rSYjnpGsLh5d4C/KLljAqoevfQ
	jjhQU7zxaH4AlgRGAyyMBbpKf7wBKMY4yZ2JppNQd46Nsov03cwW
X-Google-Smtp-Source: AGHT+IGQWH0iUtfes/6BAdkHsPYVaYE2l+2xFp32esfrcvZ/ErV1NaTwoenqBs1sAY+K9lH+QdJH6Q==
X-Received: by 2002:a05:600c:198d:b0:41b:e0e5:a525 with SMTP id 5b1f17b1804b1-42127915a89mr15454065e9.17.1717053124588;
        Thu, 30 May 2024 00:12:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270ad1a7sm15254595e9.40.2024.05.30.00.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:12:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 May 2024 09:12:02 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH bpf-next] libbpf: keep FD_CLOEXEC flag when dup()'ing FD
Message-ID: <ZlgmwrPv4y8n-gE-@krava>
References: <20240529223239.504241-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529223239.504241-1-andrii@kernel.org>

On Wed, May 29, 2024 at 03:32:39PM -0700, Andrii Nakryiko wrote:
> Make sure to preserve and/or enforce FD_CLOEXEC flag on duped FDs.
> Use dup3() with O_CLOEXEC flag for that.
> 
> Without this fix libbpf effectively clears FD_CLOEXEC flag on each of BPF
> map/prog FD, which is definitely not the right or expected behavior.

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Fixes: bc308d011ab8 ("libbpf: call dup2() syscall directly")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf_internal.h | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index a0dcfb82e455..7e7e686008c6 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -597,13 +597,9 @@ static inline int ensure_good_fd(int fd)
>  	return fd;
>  }
>  
> -static inline int sys_dup2(int oldfd, int newfd)
> +static inline int sys_dup3(int oldfd, int newfd, int flags)
>  {
> -#ifdef __NR_dup2
> -	return syscall(__NR_dup2, oldfd, newfd);
> -#else
> -	return syscall(__NR_dup3, oldfd, newfd, 0);
> -#endif
> +	return syscall(__NR_dup3, oldfd, newfd, flags);
>  }
>  
>  /* Point *fixed_fd* to the same file that *tmp_fd* points to.
> @@ -614,7 +610,7 @@ static inline int reuse_fd(int fixed_fd, int tmp_fd)
>  {
>  	int err;
>  
> -	err = sys_dup2(tmp_fd, fixed_fd);
> +	err = sys_dup3(tmp_fd, fixed_fd, O_CLOEXEC);
>  	err = err < 0 ? -errno : 0;
>  	close(tmp_fd); /* clean up temporary FD */
>  	return err;
> -- 
> 2.43.0
> 
> 

