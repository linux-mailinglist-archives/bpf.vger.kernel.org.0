Return-Path: <bpf+bounces-28591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE2C8BBFC1
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 10:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B98A1C20CD1
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708FE6FBF;
	Sun,  5 May 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp+mC9HW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEBB672;
	Sun,  5 May 2024 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714897287; cv=none; b=EJiMdUFq11xLWe0tRER0nUZiqYFeOSca7eFxx2DESK72TxOdw8bzhaGsD8irkmIlsLR7fx7ZcaGhxWqnWNa1+qVyf1zL0TgchP2T6MImuAJYJb0oNMazz1+payudt+mBZJm6nqY9G0IkZCIPz8bIGO8pZ3a3cLerNrJTzw55Zo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714897287; c=relaxed/simple;
	bh=nnWWU6Av9ppVhpFVlXtww6Fd+dstAUsmq49usKvTCRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7I14PJJiWI7sUSS+CNnrbHgaG2yUelS4sz1UbiY4CLRv0lqo2xJ7FIT16syQXpM8YOMOzFuMS5PFEB8qgobLHdb3WXjPcwx4MIE4fgfNKQgFjH4/qLnTRTkPKh53IowvS+2oY2RLN3Xgn9aWeKJAqGWcTVIxPxAtzpQJJJ//+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp+mC9HW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34da4d6f543so854129f8f.3;
        Sun, 05 May 2024 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714897284; x=1715502084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hocpwkdCzNkFP2oJ/Rkbamwkx4VeWwV1/HslBK8Y70c=;
        b=Hp+mC9HW/CPfu0AW5Js9XCQ/l39B4P9Yt5oyI8y4CMNNkR+5BffS062qZy4B8asIEB
         wTTQKCjF2bRf5KwNDqlIvDjnERFlfJS/bxs0I+NN6teYdNmNeSOSI7Xgr7kHz8VKvNWR
         gkyV82vKR/3D0Axo26wlJL8iin/cKoH+IBb6H/BgiIwhBUElnP/U9UArnKVXojRZVjc8
         V5C80uc96JNnO0HN3YO17tzrORvoXH8PDdLKw14wGRFTs/Kig12UFhE16VRO4RH+vJwt
         Pt9VwnQhPPkw6DgNr7Nb+PCBvHTXoSTe7jKAR/GfvgmlGhCMs3zvVDuSfbxYyPRARZfc
         Kukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714897284; x=1715502084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hocpwkdCzNkFP2oJ/Rkbamwkx4VeWwV1/HslBK8Y70c=;
        b=G/sHOkhhjdet+WTbqrXMb67GjVzITbRP02myjC+r71bgjDKp3/NtkXXgx4W+9mn9hD
         e+FabkG3twe9PcSVUmwLwqb/YOOUErN08A4BPQgzO29LMn87CZYhlHGs9XyyiBy/fzWC
         nFCfcxWrUGDsXidd47uR+kokkYbHeosj9YTZlunAP+uYI3PDWn5Jieddk6mbk212Prnw
         38xTZoQvAgaRCZJGDjhPWRVA+0p58+vI+VXnZjFdyXdxYqKm9HbENweJa1C6e/nF26kw
         biCffKeNGtRFcs6oB1YhbmgqxRVrVmjhkxp//pUHYWfEXGNAL5NqGLg11Gz+OqPswJMW
         i70g==
X-Forwarded-Encrypted: i=1; AJvYcCUAOMfPusq1JtjzU8uO7tAMivj1blGvrfSg6Sz2RpPdhBXT3zAuoMttMCXXkMJYx994Mv33IQpIJzQFeY6J67FsgM/mzDqpTl6TOvQ52/f+fLfZvbu9Amx41G1sweNsc2k7
X-Gm-Message-State: AOJu0Yz2ciQPQnWTCj+FgddQ3DObs95mqwrz4kQJyI69hchjzel5ZPht
	K8PuX9ZLzckhcOp1cJZYeHLfy2ZfUuRGTkNWcsMiNiG56jwfUE6JCxbFKNEEkxfjpsx1NXEF9+v
	hBCA8DMMLpnwfSiT91Y0jrEihkl003Icb
X-Google-Smtp-Source: AGHT+IHDFIkkKjfZL1rO+h6mO95Gz2E5ZxMtDsqUiyjTw4b/DcMlShLSqm+oM09OkPAb05xdy9JbW+ZUqRrj3TdlGjY=
X-Received: by 2002:a05:6000:1cc8:b0:34f:595:a390 with SMTP id
 bf8-20020a0560001cc800b0034f0595a390mr685105wrb.63.1714897283436; Sun, 05 May
 2024 01:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505014641.203643-1-cam.alvarez.i@gmail.com>
In-Reply-To: <20240505014641.203643-1-cam.alvarez.i@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 May 2024 01:21:12 -0700
Message-ID: <CAADnVQ+Y5k0XMytXo9CLGYDUnVNXcgtz+2mTLUdS-yWV7JDjeQ@mail.gmail.com>
Subject: Re: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
To: Camila Alvarez <cam.alvarez.i@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 6:49=E2=80=AFPM Camila Alvarez <cam.alvarez.i@gmail.=
com> wrote:
>
> The error indicates that the verifier is letting through a program with
> a stack depth bigger than 512.
>
> This is due to the verifier not checking the stack depth after
> instruction rewrites are perfomed. For example, the MAY_GOTO instruction
> adds 8 bytes to the stack, which means that if the stack at the moment
> was already 512 bytes it would overflow after rewriting the instruction.

This is by design. may_goto and other constructs like bpf_loop
inlining can consume a few words above 512 limit.

> The fix involves adding a stack depth check after all instruction
> rewrites are performed.
>
> Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com

This syzbot report is likely unrelated.
It says that it bisected it to may_goto, but it has this report
before may_goto was introduced, so bisection is incorrect.

pw-bot: cr

> Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
> ---
>  kernel/bpf/verifier.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 63749ad5ac6b..a9e23b6b8e8f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21285,6 +21285,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>         if (ret =3D=3D 0)
>                 ret =3D do_misc_fixups(env);
>
> +        /* max stack depth verification must be done after rewrites as w=
ell */
> +        if (ret =3D=3D 0)
> +                ret =3D check_max_stack_depth(env);
> +
>         /* do 32-bit optimization after insn patching has done so those p=
atched
>          * insns could be handled correctly.
>          */
> --
> 2.34.1
>

