Return-Path: <bpf+bounces-74612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C02C5FD68
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C6144E42D4
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788ED198E91;
	Sat, 15 Nov 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMRVWSkD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59784224D6
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170354; cv=none; b=HrvT2jb7wb8Z5eGOI/vmvlLn/F99shqxfsVEasOnbGit6YgSxRVbj1F2Fd7gUEkHG3Uo1FUSIqDSbuOPulF3rRbvu5C3wS4sIGymBaN/uBdI2CRpwnxwcfSluFPfNa4tgq9nqHEtSZ6RrO1qanCTtovBpTyymOJn0F2A1YLX/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170354; c=relaxed/simple;
	bh=2ZvF3lVHhybLaT46R0HK7c8tvcqAXaJ2fHdaHPubXq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wtt74YJup2AiAqIH/3JvYt5I/PIT26ColQcZUx4gE65SRQLYb41x+arpXAk/5BmmOw3M5N+1+Ckq9GrjjDoM/DelMK1qz8Z5ePAP0lO5W6zpR4sS8vxBF2boIm539R9pFCAvwF1gZcbIV676EQ9l1pRca3zMY2Fiw/Y7FHZ1k44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMRVWSkD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477775d3728so25910965e9.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763170351; x=1763775151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHMwHcRXcYl/VjdL5deS5ODGWxA48ERuUSAFt4Siz8Q=;
        b=RMRVWSkDmdtYitNcRE2iqyP1nS7RhAJZ2yTshGLNU8TpVt3GTDOU4b8+gfLvJWQa+D
         dgTSAO2ubYETqbqWbDbjCE2I9RmR9gAJqRuW4D4hw9U6VYsGfBLvBjkqviG3cLOflCxc
         8xuxDBZRjjub/3k12/kL31I2OxLUyP99wHj8x4K70DUmyR7DiE4JZaaqj6O6Q7qFTDUJ
         AI10+X9ToG+bfx9G7SiKjhE32CMjNAYG1ImMQMsKG4hAOVPjFwgluNnmb1xzKIOH4TxU
         MWIDXDF3NWVU7i6TGFQ+cYhR1cjmvqPDmgX6P+zNYvvrm0mYDnWY4g3MmINi+l7bcQx+
         0JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763170351; x=1763775151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FHMwHcRXcYl/VjdL5deS5ODGWxA48ERuUSAFt4Siz8Q=;
        b=Car9n4wWds871YRnrnIjJU2fKMoBXdpDfjcIcJ6Q8L5t+Xc31WlxjSVaQLG2nhtyVR
         Einn2TJLu4JFzqYTOXj4VJbNrMMVVA062+PiS96BoeDf/qfuJgtcfr+mpkUhjzfyOeWP
         BeWeqQePfN/+oDseyDwrrT+cbQn4Fi74SACGe4DxTRC3Gahe2DaGcs9uzSIi8yB4Flzp
         pYynVC5VhJ855Z6I2CIHgMGE15lmJ0DN48dS9Shh8YRpC5kZdYDa+iSiJ8R05P0RYQnP
         uT3HNVucoP3fgchF2gtD9szuNkP6wuHh34lK40DT04GYwQ/pfxigtgnuytNGIEqKWPnQ
         R/nQ==
X-Gm-Message-State: AOJu0YzNeRNP95WOeCnDS1+Yimg/ChJ6dPPkFBwPRN8wpaNkOSeZH14J
	FM3f5jRVnPM7X+bJdHgnqGqp9F3Z6g6ri5iecEoWKl3VE34jZz7Z36bpyrdLrNZEQ8wflWFFm0J
	XdC943Ue30U0hHYo3vj77C8ywRDGSJYc=
X-Gm-Gg: ASbGncsJOanvXH69iDto8ZHlgLBjIqSwzT00fkquzzamPLCo2u+FFq7M2Lvhq653AWY
	8bmpHpf7S0F+F/7D4Lo6ulLL2NGbzq32lPwUQW5eyF9KKBcMc0tlT4WHDpCV5cH6qCA13C+YwpW
	4HcZBEEF1ch+fu2U0yACWlRsdH2R0L/1M/7d8rEiuk/FeEIbAeGW/YPtXh4igdensDxvWHTmXba
	3mfumgyhscjvdb1RW1oHD9/gXG5fT5TX7qmnijfhaQV0jpXetwdGK40m2Lul1xQjYaphxwF1Iny
	Z4DI7IkeoBSvR5udHfZlzlKP1Mb5hk9VpYBjH5Q=
X-Google-Smtp-Source: AGHT+IEuyrnz1tKL4nKP9lrsJJgkkElL4cykDP2upe3dTj7dJtnuNhlszBF2zMzdi7FJQBOu5jdmEq1r81cm3RnthTk=
X-Received: by 2002:a05:6000:61e:b0:429:d6dc:ae1a with SMTP id
 ffacd0b85a97d-42b59377f5cmr4280505f8f.30.1763170350535; Fri, 14 Nov 2025
 17:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
 <20251114031039.63852-2-alexei.starovoitov@gmail.com> <55fb1a1f8d976e30dbaceff6f07b9e661cdc77f1.camel@gmail.com>
In-Reply-To: <55fb1a1f8d976e30dbaceff6f07b9e661cdc77f1.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 17:32:19 -0800
X-Gm-Features: AWmQ_bk_P247KiCxp-RLv0CVsP8x9A3yroP1jxICjMSZaDnI3-pFBLen3grNeFw
Message-ID: <CAADnVQJB3BbspTWzqi=D7WqkwwuCiQL+es=LVhr=i-uYfJaBdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Hao Sun <sunhao.th@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > +SEC("socket")
> > +__description("s>>=3D31")
> > +__success __success_unpriv __retval(0)
> > +__naked void arsh_31(void)
> > +{
> > +     asm volatile ("                                 \
> > +     call %[bpf_get_prandom_u32];                    \
> > +     w2 =3D w0;                                        \
> > +     w2 s>>=3D 31;                                     \
> > +     w2 &=3D -134;                                     \
> > +     if w2 s> -1 goto +2;                            \
> > +     if w2 !=3D 0xffffff78 goto +1;                    \
> > +     w0 /=3D 0;                                        \
> > +     w0 =3D 0;                                         \
> > +     exit;                                           \
> > +"    :
> > +     : __imm(bpf_get_prandom_u32)
> > +     : __clobber_all);
> > +}
>
> Tbh, I find this test case a bit more convoluted then necessary.
> I'd use smaller constants, removed the 'if ... s> ...' and added some
> commentary, e.g. as below:
>
> SEC("socket")
> __success
> __naked void arsh_31(void)
> {
>         asm volatile ("                                 \
>         call %[bpf_get_prandom_u32];                    \
>         w2 =3D w0;                                        \
>         w2 s>>=3D 31;     /* w2 is in range [-1,0] here */\
>         w2 &=3D -2;       /* w2 is either -2 or 0 here  */\
>         if w2 !=3D -4 goto +1;                            \
>         w0 /=3D 0;                                        \
>         exit;                                           \
> "       :
>         : __imm(bpf_get_prandom_u32)
>         : __clobber_all);
> }

Come on :) Now you're nitpicking on constants and extra 'if' ?
I'll keep the original, since that's what it was in the code,
and will keep __retval(0), since yours doesn't clear w0.

