Return-Path: <bpf+bounces-74652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0079C60840
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C7EA351ECC
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955AB26E6F5;
	Sat, 15 Nov 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAUO6c1N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D002168BD
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763222457; cv=none; b=oHm29KguXoTNUF5LgmrIz4+IYfhApxJBnJIZ4u7jnuXF2TQvRJgZrbCib+B/ROEKqphvV3KZji9PP2smktJSdS2pxDoSTXL2Wf283RxFLrv4a+i+4rpI34aiYIb0almJ3A/dArAaqQ/QY/FrJZeuLY+AMQZ+Mpbo4NgowSLQRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763222457; c=relaxed/simple;
	bh=xxvebE00O64w8tSSLbdQs0D8zslt5ecSFnzCLuI4daA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coml2lwLBgDRDwAO0QSYPDCwWA03mb+QXFZ5Joty4SR9LeT5xHGVOKnNkz9aRR/h3uKemrwbzH9b7AHrrLTImJ8SThd1V4bw6pxdgIlqDsC6w8BFlAOYvqMptDBTTHvDS5TbOj/tEut1vIhXgoCczHuq/I5ioSnvw6zo+ZlO1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAUO6c1N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so2671925e9.2
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763222454; x=1763827254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEqXJuarxbh+iu7d3ZuGUeDSFsNQBHolLTZUKoxfZlE=;
        b=mAUO6c1N6APjWFBMXvRCYQJTIoKwbMoMd7tDuvSsQ+BWw9gjQSV/hPfMFhaxKMZJxh
         qDUP2sAR3mBbnd285pOgZSmsYe4eji1lIZgEqZ+iPeMXQ6AGqY0KM2kTNJz304X4WC+h
         ALHHUJPxeRfxhNlUk212uNIHfblvpaHZsDWMRVajgQeTNNhtxB2pexkzKl28RERWVcu3
         pNxfP+w7XL2pHsZiu6U4M60BnW2kfcD9k0FiF8Pr3lwIvX4ApYvJgBcFB2B6smfiAfnU
         1ynhPTXvFDwErGNj1qGo+9xU2yBLyTr2K34YHqY8vJxKnQkaDnFS1HGzJojAmABaO+HS
         TDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763222454; x=1763827254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zEqXJuarxbh+iu7d3ZuGUeDSFsNQBHolLTZUKoxfZlE=;
        b=VDX+A+1AKpmUtzkzhlCqOv7qBzkCX9vIO/OQDLTmOlgav3RB62wu0cyURU82PI/aoe
         UQTRhZDnSkKEvtlL+CaZNW2b7cu9WM9d8aP8CxHhQhE3ZITPq5FvkByGVUcWw1yrXy0Q
         n9CfBXOQZZQuEQ59iY77qhubdE9WiHolYRo1WFWVArzbiWJIyKaPU2BTD8zXwvVi2ULz
         g5A7M5Ujtu2PVcikmYm7XRtiUkLxFxteJiD0GH4Q6xdeXGviKXOHJ+BgkIhPfuwwGemu
         pOMCL+zDzo1XVOZ6hKiJNnlCSDc9lHzyLCJBg5xpsT/SfjIINizL08kmT6xWE1U1e2WF
         aopw==
X-Gm-Message-State: AOJu0Yw4sf7aNQr5NDORKcu30JW8zkfuL4N+rZAKUJo3/rUdLOxehbKZ
	BpsfCMTkd+6FEwiNj3oH+xoCSQ3zxZiVRLlANqoDIhystjTAbqtXWOId8wy60/sDLdUKCls1XPj
	rXnLi9OrQY2ctOX+Q39/mtrKHLIa1ePQ=
X-Gm-Gg: ASbGncvAld58nr9cIS2gwvcM8ahgiDiZRPZFGh+y7AHY6nv+JnpZ7kEn8rsjvhdj6yS
	bzr4QX5bCwEDnldWpqDamFo15OspvIG3zvcubsZw8E8JKL/3lu1DQ6cE1o3qJ6sYfzoA/jJtuNv
	VawXhv53Z+QpNf2fjqiPkmzPJRjg6+zVJjMT4/GVaZMVX56poI2JRuSv7HpScE+iqLdjSvRaOH7
	SuOn9HpTGOngvq3vmakOk9MGwGGJWKRFVTdZ5YbEg6OG22CWOyC8Mf6wfOAqj6B8zJYuxxZDEds
	a9BovUPc9J6XOPUfPszoVSewUwTqxb1vYk+TKjM=
X-Google-Smtp-Source: AGHT+IEX6bpHc0RR82FTCho67Wc6ykIJKPOK38GSinApbdWl6bKkg7ncPP4obUu4h9dI1Bzh+k8SXHE5M5ud8dl27c4=
X-Received: by 2002:a05:600c:45d5:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-4778fe59054mr66015135e9.14.1763222453592; Sat, 15 Nov 2025
 08:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115022611.64898-3-alexei.starovoitov@gmail.com> <4f10e55e592146a40bf7ad0814f4efe685b9f4d58ffd6ccbdb1fc9f5c93b90b0@mail.kernel.org>
In-Reply-To: <4f10e55e592146a40bf7ad0814f4efe685b9f4d58ffd6ccbdb1fc9f5c93b90b0@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 15 Nov 2025 08:00:42 -0800
X-Gm-Features: AWmQ_bmDeBxTez4feLK3qwytuCyCkddSbwBRx105Vm1vW5tH_D6bU118e2C_D7k
Message-ID: <CAADnVQJ=hSKkrgOeah7qAb5b7=9A2caDGZ8wjQiONWtXd3P=Xg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
To: bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Hao Sun <sunhao.th@gmail.com>, 
	Kernel Team <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 7:01=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tool=
s/testing/selftests/bpf/progs/verifier_subreg.c
> > index 8613ea160..0b572c067 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
> > @@ -670,4 +670,47 @@ __naked void ldx_w_zero_extend_check(void)
> >       : __clobber_all);
> >  }
> >
> > +SEC("socket")
> > +__description("s>>=3D31")
> > +__success __success_unpriv __retval(0)
> > +__naked void arsh_31(void)
> > +{
> > +     /* Below is what LLVM generates in cilium's bpf_wiregard.o */
> > +     asm volatile ("                                 \
> > +     call %[bpf_get_prandom_u32];                    \
> > +     w2 =3D w0;                                        \
> > +     w2 s>>=3D 31;                                     \
> > +     w2 &=3D -134; /* w2 becomes 0 or -134 */          \
> > +     if w2 s> -1 goto +2;                            \
> > +     if w2 !=3D -136 goto +1;                          \
>                    ^^^^
>
> Should this be -134 instead of -136?  The comment on the previous line
> states that w2 becomes either 0 or -134 after the AND operation, so w2
> can never equal -136.  This means the condition is always true and the
> division by zero at "w0 /=3D 0" is never reachable.

exactly :)
As the side note it's nice to see that AI understands bpf assembly
and can do this logical reasoning.
Maybe the verifier should defer to AI for prog validation :)

> In arsh_31(), after the arithmetic right shift by 31 bits, w2 will be
> either 0 (if the sign bit was 0) or -1 (if the sign bit was 1). Then
> "w2 &=3D -134" produces either 0 or -134, never -136.

