Return-Path: <bpf+bounces-77657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3BFCECB03
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 01:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6BF30245C0
	for <lists+bpf@lfdr.de>; Thu,  1 Jan 2026 00:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20F212B93;
	Thu,  1 Jan 2026 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9KIOqDY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2ABBA3F
	for <bpf@vger.kernel.org>; Thu,  1 Jan 2026 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767226066; cv=none; b=orXigrHActQnoM10bbLUDyAHKTtOhP1Ii9vdpoR4bKLPmTflQeDjulrTMAoGNsYEvLralEyD7Q8hr38aSy/KMestPKTJnt5OaHvuFTa40V4lmiI4vbhAhfYVQwPSij66AC/LMCimQg0BiaKLqqp67KzuLAkJaB4qNWRcyY463n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767226066; c=relaxed/simple;
	bh=9TZdqYDvxAWJNyqKxpwV1QhwM8327YU4KxvehCryeNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0pCoWXwLd1i+3hT4toLHgRGiaiYZ2H935onHKWGKZJ5nRz8YrF7lY9icabHL4oKsNBn/X4HdqUmnLfEv0HFjH1Pfhq9BLQZHv0bexe4KLzalotw5De5MlfBElfdfv0scZ4o6Emokw65vcf+q0fxqrIkov6N6eg1bCXGGLsoJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9KIOqDY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47774d3536dso89695255e9.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 16:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767226063; x=1767830863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nswqdzdzgDL2SsgFG1RXJY/Ml4QDsRI1s4C4JVgdyk=;
        b=W9KIOqDY5uq8Vzo/lrEM4+cGHvnUcnIfSQsVAhZYSOcaRwOd4hZYEbu5a/LYVTZLVp
         RMqM1UlZIUvHEv4bK7XF0knCXor4Od2wig0Scuy8x/DYNmbdfI1Ey0+iUWnd1ZjX9N/f
         4WGDqZAM8Ch2z4xT6uNxpDIYXRS0ZuYHQSHaaLDL5KGQetgMrLrM2lDYT2gyIRhLubJc
         3nSNz2x4iC8nbjIRI7SbZCd2Li2fOgub8tU3igVlbz4zfStAeIp9kWH8QBwQjccxlHxf
         yVtwcjL/pdom8z+i5JH1iuMizq3hNSPPlglClsZBaa6qibONymwXOYMMmt+lGctMssV6
         KDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767226063; x=1767830863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6nswqdzdzgDL2SsgFG1RXJY/Ml4QDsRI1s4C4JVgdyk=;
        b=uCzXGmbvq1YFROK2LBhGbJHdcD4lAzBAChmZZJWzVw/6Db5q18x646PXtsR3eQnB6E
         3enZkUHsvE8qN7FxePtPPX3OB16uW9QZv8nOQcm0rys/dWLXPaWStCCydzD5m2dHoKH6
         v+bVpPkqoTDJS1IdFwv2ztfLLAbFyIMaJb3BTsSojNQcGbf/T6J/1JXslhTsm4RhF3eg
         YSGV8X0Pumt8RH0Zr1YPVJVjoNqvc+PFO5Mh9Jfeqtq/nBWX4ALu/DCaZB2szLVvG3ct
         fM7i3FFMcHZ4wrLXotwTgt2IAkQmb7S2qcraGEOg3ij5o9lDzkuZWEeWMaugPdHaOd+q
         p87w==
X-Forwarded-Encrypted: i=1; AJvYcCVBDbT6ZbfufsMHbiWBbxYuu+uBhWyg7aS+ZMgrRGsG498GsvS4iwra1OFovss0xK9j9PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAP+RXOYUeNMB8Zqf/SoanxYozbxRIJeRrYVsOkon2abzW6cKm
	LsS9+FIuX1fgPIfzUZQHNoxDU0iF0jeoVscVm68eU2xIVvdsQZydQ27RluvteE+5Sn9BMpr8Skl
	iGhfPxM0dzflEXYJ+W9cVkZddfUV5cGE=
X-Gm-Gg: AY/fxX5WdwlMoVC4ylzPzLnQbCPaKF4v+SZhHK13Q/J5lPiG+Lt8cTf6wHFZtCQjDTS
	3oVCfu312rqB3XW14AJzpaW9GJOLTsYs+Gt+4I1AkJWXzr3otaTO2GmSaRCFtcZfVNNkySlE4ns
	OHP0Y1frm29RTAdM6n/RoHgN33UPGE97mptg9PJ0n/6cj5+0hxaXWs4J4KyF6wS7u3PNEdDEqrX
	mq7DwfTEgSdLpRq0GcyqZJ7LgY55G0cnB2QwMPhmuZ9rM49QAbkcPufFyl5hS4gkEVMpMmtgyzu
	99uTAE4HytZSR7DKxL7/3HmoXA1E
X-Google-Smtp-Source: AGHT+IEuQszZg7wTp+W6ileKKwymt4EKRPFjA2SMulfekoh0KIiAS/kTnlLwyyMRH0XJuHJgfjyOaw7GUSI+Za6glwc=
X-Received: by 2002:a05:600c:181b:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-47be29afe18mr345736325e9.8.1767226062825; Wed, 31 Dec 2025
 16:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232048.2860014-1-maze@google.com>
In-Reply-To: <20251231232048.2860014-1-maze@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 16:07:31 -0800
X-Gm-Features: AQt7F2px-lQKro5XezvemgzE0XuwobUnwdCsPbj7ENtRF5rqiJQbbZYMafwEdLk
Message-ID: <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 3:21=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> Over the years there's been a number of issues with the eBPF
> verifier/jit/codegen (incl. both code bugs & spectre related stuff).
>
> It's an amazing but very complex piece of logic, and I don't think
> it's realistic to expect it to ever be (or become) 100% secure.
>
> For example we currently have KASAN reporting buffer length violation
> issues on 6.18 (which may or may not be due to eBPF subsystem, but are
> worrying none-the-less)
>
> Blocking bpf(BPF_PROG_LOAD, ...) is the only sure fire way to guarantee
> the inability to exploit the eBPF subsystem.
> In comparison other eBPF operations are pretty benign.
> Even map creation is usually at most a memory DoS, furthermore it
> remains useful (even with prog load disabled) due to inner maps.
>
> This new sysctl is designed primarily for verified boot systems,
> where (while the system is booting from trusted/signed media)
> BPF_PROG_LOAD can be enabled, but before untrusted user
> media is mounted or networking is enabled, BPF_PROG_LOAD
> can be outright disabled.
>
> This provides for a very simple way to limit eBPF programs to only
> those signed programs that are part of the verified boot chain,
> which has always been a requirement of eBPF use in Android.
>
> I can think of two other ways to accomplish this:
> (a) via sepolicy with booleans, but it ends up being pretty complex
>     (especially wrt verifying the correctness of the resulting policies)
> (b) via BPF_LSM bpf_prog_load hook, which requires enabling additional
>     kernel options which aren't necessarily worth the bother,
>     and requires dynamically patching the kernel (frowned upon by
>     security folks).
>
> This approach appears to simply be the most trivial.

You seem to ignore the existence of sysctl_unprivileged_bpf_disabled.
And with that the CAP_BPF is the only way to prog_load to work.

I suspect you're targeting some old kernels.
We're definitely not adding new sysctl because you cannot upgrade
android kernel fast enough.

pw-bot: cr

