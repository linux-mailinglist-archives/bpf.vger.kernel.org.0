Return-Path: <bpf+bounces-30923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B68D47C6
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363841C225F2
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D2114E2F5;
	Thu, 30 May 2024 08:57:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279D14A4CE
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059432; cv=none; b=ZPpbNM2kbbCrP4TPVSZPzK2x7oeMl6tI+4s7dKinZfxE9pJs034YeYRjaFkuvMULTFraAPsDQp5QiQBSJaCK/Op7EQOBWmlFFKNK6jld2n9NKr/8Nnrq7U/HOpXYJwR40wt6UTV+1bu5bWRsSFuz2JiRXh2TCsfwPxCQAXyOd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059432; c=relaxed/simple;
	bh=GLJEKiC+c5SRHiAlBvJhAZnQgIIR96bHaDBNMWBJ5B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gidIwRWw7vwQTtOHL2lOUp/47Zq9+zlfrX3sitmXRprTrTeiofQNhqijwq96WZKNqGHcSWcuEDDcWLRl4BMJfCInBg7oP2sVqZy7ze+eUuqvYIVYjrkjDWP2Ft/DsR2Lxh6aHf1Iq2DQ0UK1JVc4pT0dWcL+RTDPuCZFLc+ynss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 42067E801B5;
	Thu, 30 May 2024 10:57:00 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 43256160185; Thu, 30 May 2024 10:56:59 +0200 (CEST)
Date: Thu, 30 May 2024 10:56:58 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] libbpf: keep FD_CLOEXEC flag when dup()'ing FD
Message-ID: <Zlg_Wrcj-nN8Gine@gardel-login>
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

On Mi, 29.05.24 15:32, Andrii Nakryiko (andrii@kernel.org) wrote:

> Make sure to preserve and/or enforce FD_CLOEXEC flag on duped FDs.
> Use dup3() with O_CLOEXEC flag for that.
>
> Without this fix libbpf effectively clears FD_CLOEXEC flag on each of BPF
> map/prog FD, which is definitely not the right or expected behavior.

Thanks!

lgtm, superficially.

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

Lennart

--
Lennart Poettering, Berlin

