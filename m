Return-Path: <bpf+bounces-46188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1529E6168
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41340188443A
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 23:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A411CDFAE;
	Thu,  5 Dec 2024 23:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6pafc4n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC149627;
	Thu,  5 Dec 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441791; cv=none; b=rchhI5HHDHFTvA/DW0cVCx1+Gfg3kkAfEksERNANm0cRZdUPZS0uNC73yU/AwymuNFHDY7ducLW+bxyuVWRPkV11lXVm2qRkljKu+qKl//gZwA9e8Vr0AGjDS/MiRWlTY4vJPI9PbSddab0Fni2Y/00z4eXEjMS2HOGwHoE0s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441791; c=relaxed/simple;
	bh=NwuLwrvl7dGHOZTiIWhR99j3XQrPoL6Gp8aZq7I1bzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2Ja6MazfrJBUra22uW0JWsJF7Ysg1Yd2S6ZlsrkTAYdWKucksYkaJ/+4B5mrn61q31kz3NB6DoWeQbMsq7aCbUdZ/I4OMGpHR0y+NHaY8q/Qatc3BgfmXo4ILxFi2G+kElllPjjlbrWIWSvufLD88msH64VX5b6qJauFpDG7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6pafc4n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef10b314e4so1292097a91.0;
        Thu, 05 Dec 2024 15:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733441789; x=1734046589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng7kZ/YTvdaoB00ECoAPKVGg9G2Agwwk8WgdDEaHgnA=;
        b=m6pafc4nRwPZAKCJKru7OM1SOs/kvu1x1/1Uiv8RDWuvU+YuetpaEQciZXTXGbw5Dg
         UmS0nRhhK2+e63MsMnEEBYPrjbLnDOtJBw/kUoFdSUcGJJsOhsrHy7WZXTIZAynuC8EL
         wu5TiGVp2j8j1e5RnGvsViwX1iC/kkGYpcc11keLPR/YsKJ/KBcFscqUUxUcFH03e5rq
         Wv+TZsCOdKut2XYvvVx2LBYzNjCC+BuHRODS3LbPNBe2Y2TAgsM/mmMBjZzjKYl2yPMc
         fnvLfiL7sTtbnu6PjqeEXhZdXyOm/hxJmH+i+yewP8lcwG3lttgCDSroag63WqJykZpF
         qDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733441789; x=1734046589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng7kZ/YTvdaoB00ECoAPKVGg9G2Agwwk8WgdDEaHgnA=;
        b=F85vwJ0m8daChuOWKAwVxqde0FSkY+B2vZpSr1CML4u2ZNHhRTmfqXdiXwe477p25T
         rKHKh0wnvtGeOr/WwefzwZsLXKw6U/8/5BFaB9KyC6BGpCRb+fdbDVmgscZuBWRB8ULL
         Fuyi762fDyoAQ2+isv5k4IXk1Y/0MxkGQbwowP980aieB+KCm8V8g8E3lTIZ/yqPUIeA
         09qXdeZ5C5szlf9Gy7Pr3jm8/ieetxPmiQimjXGQ8OZEu9dN96ZPXzrqaBsGRsk39Tpm
         JW4ovUJiN2WBDJ0FaQfJhVACrrxoBPrNNouokUIlkO7MYziBxNqcZTwkqGQ8ozTB8T/Z
         HHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMs06zQKiz8cFlFkQ596sdJ1bYdBoEMDcwVVcnfWk/Q80nhfK+boqW+JOIbcXdkSdvzx8MxB0JmZ2BBHfZ@vger.kernel.org, AJvYcCWPD32FVomFDHC7TmmwrwDRe6HOxihGOpXQJXhcnSQz3dfpAeVDnL7ievg0oTMW0QLjdggOkPe8R1ZTZofR@vger.kernel.org, AJvYcCXVkZJ1GoHUf5gRwZUKH3aS1cxqwgSj52PPwT/MJdt1BHeOfSnUzKPvyhqLBS9R4M0uiZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEt8j8YXIiqAlcOFj+lKBdAdpRYXfKrmNm1EDrH9lnsXYW0ITk
	P0fjp1IRdJSLSMv1bKDg45a9++AlBWUQbWPYxzAg9MiyoDCPbNUMEyZtfwK4I6/wpCJbSrn4LZb
	n0SHJGPojAEDG+7j1AVI1BmH6vdI=
X-Gm-Gg: ASbGncuW+CjmK9i0c+aoUxy5LqMhgxOqYMG+DGxz4Tw4oOjC2sh8vejuhOOS4vftE0P
	xx97hHThFL0T4GeQRKSEClU/XoQgXZdT4H+vbB13CdOQDr04=
X-Google-Smtp-Source: AGHT+IH1w7P6xCp3gCPM7QBsMHRuvicw/bZAJipR3Nsv0xLIOSEs65VTzbCLZYW4sM1pbtS8YBt+j3zdu2KIn3J91Ws=
X-Received: by 2002:a17:90b:2882:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2ef6aad12f3mr1401015a91.27.1733441789520; Thu, 05 Dec 2024
 15:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-resolve_btfids-v3-0-e6a279a74cfd@weissschuh.net> <173344143126.2102866.16200180283142893645.git-patchwork-notify@kernel.org>
In-Reply-To: <173344143126.2102866.16200180283142893645.git-patchwork-notify@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Dec 2024 15:36:17 -0800
Message-ID: <CAEf4BzbOzUiiMbW-1_avQ6DoVWc_0Bm=Bz9iC1rGq7NqG-Y1TA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] kbuild: propagate CONFIG_WERROR to resolve_btfids
To: patchwork-bot+netdevbpf@kernel.org
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:30=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)

I unlanded this for now. We are waiting for a fix in the bpf tree to
make it into bpf-next before we can land this, sorry for the noise.

> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Wed, 04 Dec 2024 20:37:43 +0100 you wrote:
> > Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
> > Allow the CI bots to prevent the introduction of new warnings.
> >
> > This series currently depends on
> > "[PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs" [0]
> >
> > [0] https://lore.kernel.org/lkml/20241123-bpf_lsm_task_getsecid_obj-v1-=
1-0d0f94649e05@weissschuh.net/
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next,v3,1/2] tools/resolve_btfids: Add --fatal_warnings option
>     https://git.kernel.org/bpf/bpf-next/c/2fd821354772
>   - [bpf-next,v3,2/2] kbuild: propagate CONFIG_WERROR to resolve_btfids
>     https://git.kernel.org/bpf/bpf-next/c/0a7a188468c0
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

