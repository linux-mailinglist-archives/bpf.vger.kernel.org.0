Return-Path: <bpf+bounces-56635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C2A9B696
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8985B1B6791F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9828B4ED;
	Thu, 24 Apr 2025 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luMIY+oO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33B1624E5;
	Thu, 24 Apr 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520091; cv=none; b=YTrw6d1UG9cBxW7igPRsskzdG4+aaaAin++gUyj77Sk7/7uDbxptEe2PFw6bI8e62qY287Gdkn/wCgx3C1L2nrzh5riDhvtuCGMoyo7Hq3a8BFCUh727WkuhCRPIeAG7VGD3Wl0HZYfaPbDNKVimtNM1JZFQEtFsW1mht2ti09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520091; c=relaxed/simple;
	bh=TxaKB9vxM/485KL+b0862QI2ohvCLs/x7hb1VbHyswQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0q9JcZaRK/voE1Nf6Jnkv1kRdA8sYVu+jJaHytGy7n42xgYlT2Ri1J4VSgLR2tpO8tFRNy37CV2FBTWHbJmJe5ghSYU8Y/s+eFpjfg14qHPP+GpjWNxW5YgVtxhW+cPh4kP1VvKtpSPXJKw+cw87RC5Gd4EFpqOoivK07Dvvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luMIY+oO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so8798725e9.2;
        Thu, 24 Apr 2025 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745520088; x=1746124888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCE0gJMmePe/3RV+KyS+ndLqphyxKvAQtF0DNgRVBW0=;
        b=luMIY+oOa2riRVnTKszz7NFvEF9UETGbBn6cRwycZdFLqhloLUja9sXyl7zuAY4QdS
         tcuqTncRI0GlsYoX0BiN1gUU3yX+vSBiBDeUfq6tsgncEFWqY9Hfp41uNGprKwMbAzA+
         Qzr5bJv/3LmWekngd7DMEbxZ47XesmYTFX3DI1+kzE3PPIklYTtTiegKwEFYw67bE5e7
         fuiKOKyFvZHdefXGYNWP8XONhOL3qE7YStnWvF03gjvyvYguYEI9PnNhypk/qqBbH/Fc
         +QjcYF7HpzfbdAqdgHYo9pRq7/AWRrS1diOA8qtqJ8idnjLzZ/sJADq/QSyje4Yy7d1r
         5mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745520088; x=1746124888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCE0gJMmePe/3RV+KyS+ndLqphyxKvAQtF0DNgRVBW0=;
        b=HGgq3vtqGFlwLjNJGu/9Ak1c7T6hmBEuOrk7e5fV4WtozmCyizWl4n/yOh+lNhJXN3
         K5D7Pm6aMH9AFeoJpFF8ACQNBMrNF4ObsVzWTx/figX1D559uZuc1hi3hDQd/i2+J7aU
         Byd+IhmgLW7rzLIWEbP00ghdLvRnxm8jzTzG2XNM4HVDul37q9E2EdzQYO3m4FbmGeTm
         4U0L2UPs4Nj1oOzCjtfmLBEa0ufgyC34R2I2kkvQS6WZIddOqpJrPNRkXnIiDEl3KeCo
         qoYavPIPJ5e6YGmObX4gxZY03WHmHp7hShxsW9i/cBH9wBzaS1mnCWj4kIiXzfSkcVcz
         YScg==
X-Forwarded-Encrypted: i=1; AJvYcCUPjji2Hu4z81ZEPR5v7uQRn3TBaz++PYfwWqYw2Fl9vwK9I/pt5wek+mwXJAKFaLVOr/Q=@vger.kernel.org, AJvYcCVEZWV8vAjNaioyzDQ6cl4jFtXtgQH4KIfNZRk+a/Bc3O3+MguCS5WkOSGl4VR6zY6doVlqP2Hm@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPwYoTUZoXW9W05PuuwFFuQOYCxva1HDkdCJeKddXdsh7L6da
	dnqnZGASZkm+Apakjml0fH2kUhvHdjdLF8fl2ejl4Wm95sbMOmaG9fM+3A7Ht0x5tdtiSSb/tjq
	G2noxQnHHIpLPzLTMXiZrIL/kS+qIB03r
X-Gm-Gg: ASbGncsitFgHO1358swtk+BiF6Kcv3KtxekcA6JGLu2g9xYvOyw3sYMLzmWN1yxk8et
	+ZadGptTKGVRb3Wh4KsoWp/umqCc7j0mOuGOqSFiKSNAj4LG0Lm9a/AhL9TJ/CpVSb1kXS/y9rI
	tPW+5cR+goBe+3Qnsemb4ujEqS9J88jwbySmi2WncmKVOlz54=
X-Google-Smtp-Source: AGHT+IHXoa+faSicYK5posziH2w+qkp+1Uux2eB+Rx8LRoiT30YdTG8DYS8weX7N2KowNWmrPakmO/M9Sh2pIqB5+u8=
X-Received: by 2002:a05:600c:3586:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-440a3173f86mr5224235e9.24.1745520087688; Thu, 24 Apr 2025
 11:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424165525.154403-1-iii@linux.ibm.com> <174551961000.3446286.10420854203925676664.git-patchwork-notify@kernel.org>
In-Reply-To: <174551961000.3446286.10420854203925676664.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Apr 2025 11:41:16 -0700
X-Gm-Features: ATxdqUFy_nCmKUO1ObUCWMB8r01ix_G89fiB1vRFnVk08HeuAZz868_RFqqd-g4
Message-ID: <CAADnVQL2YzG1TX4UkTOwhfeExCPV5Sj3dd-2c8Wn98PMsUQWCA@mail.gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
To: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:32=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Thu, 24 Apr 2025 18:41:24 +0200 you wrote:
> > Hi,
> >
> > I tried running the arena_spin_lock test on s390x and ran into the
> > following issues:
> >
> > * Changing the header file does not lead to rebuilding the test.
> > * The checked for number of CPUs and the actually required number of
> >   CPUs are different.
> > * Endianness issue in spinlock definition.
> >
> > [...]
>
> Here is the summary with links:
>   - [1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
>     https://git.kernel.org/netdev/net-next/c/4fe09ff1a54a
>   - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16=
 CPUs
>     (no matching commit)
>   - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
>     (no matching commit)

Hmm. Looks like pw-bot had too much influence from AI bots
and started hallucinating itself :)


Ilya,

no worries. Your patches are still under review.
I unmarked it in patchwork.

