Return-Path: <bpf+bounces-34419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C260A92D846
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5158D1F2207F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFD195FFA;
	Wed, 10 Jul 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+f0h+96"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787373BBED
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636201; cv=none; b=EYMgLp16kHc72Kqw4iJYmEVwRxDGc0Zr9shPOgKIVzltwuqbI9mIN7J/DPjxczshnOZgBw5kTOmu0s7OzhsRsSez8TYeIS4D0tGxYoRdcsxaVy1j4uFmpVEAcsLXkF5fkjED+qNK+bN2ZD44Kpa7qkFkCCu++rYArIUfNJF7NHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636201; c=relaxed/simple;
	bh=9Ny7/cbL1T9dgByTX2aZoEnItp6ybkY2GvkIv+2/TQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRSlc2KjJdtz9i+1r/V4+yuGXP46YVVWXGS4qcszg34BPGm4Ekey9wmfQPSYx/VQM68gEb66bLLCAi5c7z70SEAtX2LdoQ21qh6PSdGbHWtikFSp5YZ8RakC2O6uNzC+uSf3+moe9Ng7GSyujfJ4KcL1/4gdeyiKdyi7QGPAlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+f0h+96; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266edee10cso417495e9.2
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720636198; x=1721240998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtzw/Ob0ihzxdqbd9QoukeZXYxXlAYjwT70u7if+KCA=;
        b=c+f0h+96j2V4vDOR/NuEjII2yx3ro8WGm2XCiVdX6uO6y/TyO+SS2MU1mJA/zTqI7l
         cuKPtJshPIIS6okn9yrbIYNsiXr10M9tXOBumKqmcpMQhUOzPhrzPhy+EJhVRIKMihxk
         RuKC4AQ1g8hj9Bt99z4Q5rxVMhW4B6RHr8yCkz7KiwCrWfaN0YK6jqrF62jFfzo/tH84
         EjEoHVBLkr0dtWLbxoNGV7lu7X0/yj16Qec5HZq+5UpS9BlU4HRQNtmyezu4hA7An29u
         SXpGvBR2A0WnaoahB3b6Jt1gl45Fnan9pcKKw6JCSL4qtExtddCSA4LuHS9+fq7Rtavt
         m9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636198; x=1721240998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtzw/Ob0ihzxdqbd9QoukeZXYxXlAYjwT70u7if+KCA=;
        b=oDiEFHjn5DozeZovG2dRZkUBKknh+QRvvOeARcar4jr4StE2k6qE6SddC580jkvmde
         lgn7qUGAXLqJ+tqa4F2IH4Z2UymofVkRKlrKpLp7lLKXrArV5GymqUeE4POgFDm8CUzb
         FFmlJulcy5PFlm9dAX+kGHbbbKHsmCsRrbvkPfHsshjJ+gjcA9qfPsxtv+QZ0cuEsKsM
         VZZj+qYp1bUFH7sjTddLYxK51GgshyOqSayyZaVtEK43/90GFzDfdSSRgdiD8CY8aOYy
         ALha3cs2gfGBPLVEc3yOfpcWu6ESI2V506FhdHDOkzKnEX4rN8QK3UH3bFO8baKgeJGi
         jH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKD3GTiXkb2s7kTdsSMGSrWoi//xjRxn0qKJvjk6f/ShuuJ2QrzYoDE9usgFIgQk13noAcY6QWlKTlWNqqE1QescOL
X-Gm-Message-State: AOJu0YyjFjiUosLbiwOVOdSVOSUxbO/8eJ/xDH7ID0XHur3BmgYQpx1e
	IfOPRNoHq/Fmlh4dAaeyYBhSvWHI6d/GMiy6wYp6seVBG/2TMPW7lutDefeywjklxAOPT5FUQDM
	qqGcAWKExRsqTmEyEYhQqhyOLLUE=
X-Google-Smtp-Source: AGHT+IH+HJRUp1f+XK8cZjIQrlxcycjRqFypgYdX3+nCw7zC/Kw/Qwwy/KyGrAbP32UY4lydHvnOW1OP5sRs2IqRyKQ=
X-Received: by 2002:a5d:4fd1:0:b0:367:97b9:d5f3 with SMTP id
 ffacd0b85a97d-367cea4674emr4635961f8f.2.1720636197448; Wed, 10 Jul 2024
 11:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613021942.46743-1-flyingpeng@tencent.com>
 <CAADnVQ++WUh6H8ZkE3GT561X=ZbPDzWv+w3ivHo5zdnU5_cHUA@mail.gmail.com> <CAPm50aJoD8oTuXKhHiM+BuG55wpP7gU33Sfsp11Lck8EUWCmzA@mail.gmail.com>
In-Reply-To: <CAPm50aJoD8oTuXKhHiM+BuG55wpP7gU33Sfsp11Lck8EUWCmzA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 11:29:46 -0700
Message-ID: <CAADnVQLqfKLr+bwWtu3iBPOo9HmuCEfJB=PLHt90Nbn3cxhODA@mail.gmail.com>
Subject: Re: [PATCH] bpf: increase frame warning limit in verifier when using
 KASAN or KCSAN
To: Hao Peng <flyingpenghao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:19=E2=80=AFPM Hao Peng <flyingpenghao@gmail.com> w=
rote:
>
> On Thu, Jun 13, 2024 at 11:02=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 12, 2024 at 7:19=E2=80=AFPM <flyingpenghao@gmail.com> wrote=
:
> > >
> > > From: Peng Hao <flyingpeng@tencent.com>
> > >
> > > When building kernel with clang, which will typically
> > > have sanitizers enabled, there is a warning about a large stack frame=
.
> > >
> > > kernel/bpf/verifier.c:21163:5: error: stack frame size (2392) exceeds
> > > limit (2048) in 'bpf_check' [-Werror,-Wframe-larger-than]
> > > int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t =
uattr,
> > > __u32 uattr_size)
> > >     ^
> > > 632/2392 (26.42%) spills, 1760/2392 (73.58%) variables
> > > so increase the limit for configurations that have KASAN or KCSAN ena=
bled for not
> > > breaking the majority of builds.
> > >
> > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > > ---
> > >  kernel/bpf/Makefile | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > > index e497011261b8..07ed1e81aa62 100644
> > > --- a/kernel/bpf/Makefile
> > > +++ b/kernel/bpf/Makefile
> > > @@ -6,6 +6,12 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D =
-fno-gcse
> > >  endif
> > >  CFLAGS_core.o +=3D -Wno-override-init $(cflags-nogcse-yy)
> > >
> > > +ifneq ($(CONFIG_FRAME_WARN),0)
> > > +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> > > +CFLAGS_verifier.o =3D -Wframe-larger-than=3D2392
> >
> > that's very compiler specific.
> > version +-1 will have different results.
> > Please investigate what is causing the large stack size instead.
> > pw-bot: cr
> This increase in stack frame size only occurs when KASAN or KCSAN is
> configured. KASAN or
> KCSAN will cause the stack frame size to increase, and it will insert
> additional code and data
> structures to detect memory errors during compilation. These
> additional checks will increase
> the stack space requirements of the function.

This generic statement about kasan is not helpful.
Figure out which exact variables and what functions are causing this
kasan behavior.

