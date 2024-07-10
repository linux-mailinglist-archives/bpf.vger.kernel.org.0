Return-Path: <bpf+bounces-34350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A8E92C90D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 05:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7C6282143
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B528683;
	Wed, 10 Jul 2024 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDDEiXEe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B617756
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581569; cv=none; b=LeNYPUU4na542HjeRCnLOJnXlUIitWOEGAy4ejjReC5SsAPYnMeW1xr3NepXr6XzNA30rDw9WdzOSSiGojr6+DEJiuXofpVFLKQYLmRp2OwdFe11a9XbdUGyXYiScS+KXZsQRYWzMVXO1L4Fm33Shopfj9YV0djrR+LTU8dJTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581569; c=relaxed/simple;
	bh=Ub8pEp6UJemFDTZuRuYmqNZhw3bIF1Dr7vpO/xTvmHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gaaofvjc3QauYScllLm+R9dfUfEx7Kobv+nekneg7geWWGw03WwSytSXQPo9ME1vfFWc+i75jqwh64X77eLd0RcxuUvXThS1R6QjjHeSdWwvG2P0ignilVjhOxfQeDN0S5SxCw2y6U1CZP/IblmWMWG7ARja98/xaYpoN5LuMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDDEiXEe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36796a9b636so3989553f8f.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720581566; x=1721186366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENTM6XKk3eTDcv+XoyQbVjAVk42C3QpyE6UuGepTueY=;
        b=aDDEiXEegupEdhZgEmwh3Nksammy3PQnDN+oCmRMrwBkXaq3gV3ARqF+TmDtB/gz32
         WvVinCRX8ZZaCbAeF7a2cP5T07TdvAb6ZfYkPpTiIXeyfj0IXQOLh4L1KC6yTKPLJDok
         tP6iQikkmIR83m0gPC71levN9ULz+VIK2BPPMuJ2NXf2fDnlNfn+dk9rLkyieCRYmgJf
         x/MNraL2pN5AoET2uaikQVEoZI/h/4IkPilJxo1jmP5FKcm1NI9Dqvx79WZoP38NGRci
         2N9wrOaVr368FGCQEoOHDTvEH6B0PnbR2O1kayKafmlZ9tWVNzu1dt0lRqBv70GEFSnf
         mHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581566; x=1721186366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENTM6XKk3eTDcv+XoyQbVjAVk42C3QpyE6UuGepTueY=;
        b=WPUfArt3z5JuhWR/aR7yVRgHSMirNmunkEHaN61B8oNYCOPDYOaYi51y1j+igsdfyG
         eh2drajD/7d3bDratKpf1V9byCCg55GYyGnHee++D0vm7SH5xM+Si8Td2D1trVRWldQv
         TtiS4sEL0JpIFTAOYS4eVfwVBuQ7ovJX1km9/g/BfDQcjD1TpffEc0YUfcEQ4eDC5tcy
         OqxocdcGri9sFfozgT4qgOhIix05T+bVnGUeXK9vZtRKW7R7xtKhaWREkcn/NXaH7OeK
         ov0stT8Jc3hS0NrfBbDM4z92raeX1wItFWiaE+NE0iOaa67YrlTmUtpAT6SNslo4V9Ei
         5Gtw==
X-Forwarded-Encrypted: i=1; AJvYcCX+g4BqMab78l0bygCnUSMl4xR6STwzUmHBNCy0+2z3fcXvDe2tXdSsbo62Jtryu9t2BKiyAbocdCIUXxBpZvEk62C9
X-Gm-Message-State: AOJu0Yytn49vPsH7i2xP7tnb7Q2TQXgvQHFSvmE08GogJ8Ta9br8rU7H
	TruMf1WTi8Ml4ggpgwvEzebpKTbhwQLGVcsd0hvORo4NQqwWE6jMIa1y3xiAeP/I0vkhBYp0S5a
	GDwi9QzTYTyVer246mkeo+UHZYj0=
X-Google-Smtp-Source: AGHT+IE6k8ocUTe3qqcYS6Md6+iA4udRnGw/jOJ1ZE7jD/ptUaEqup5k1kGfYGqh9Qq0jJvulHtGvLMCuSTn+sQCvGE=
X-Received: by 2002:a05:6000:237:b0:367:9c93:f87e with SMTP id
 ffacd0b85a97d-367cea964d6mr2979130f8f.33.1720581565840; Tue, 09 Jul 2024
 20:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613021942.46743-1-flyingpeng@tencent.com> <CAADnVQ++WUh6H8ZkE3GT561X=ZbPDzWv+w3ivHo5zdnU5_cHUA@mail.gmail.com>
In-Reply-To: <CAADnVQ++WUh6H8ZkE3GT561X=ZbPDzWv+w3ivHo5zdnU5_cHUA@mail.gmail.com>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Wed, 10 Jul 2024 11:19:14 +0800
Message-ID: <CAPm50aJoD8oTuXKhHiM+BuG55wpP7gU33Sfsp11Lck8EUWCmzA@mail.gmail.com>
Subject: Re: [PATCH] bpf: increase frame warning limit in verifier when using
 KASAN or KCSAN
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 12, 2024 at 7:19=E2=80=AFPM <flyingpenghao@gmail.com> wrote:
> >
> > From: Peng Hao <flyingpeng@tencent.com>
> >
> > When building kernel with clang, which will typically
> > have sanitizers enabled, there is a warning about a large stack frame.
> >
> > kernel/bpf/verifier.c:21163:5: error: stack frame size (2392) exceeds
> > limit (2048) in 'bpf_check' [-Werror,-Wframe-larger-than]
> > int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t ua=
ttr,
> > __u32 uattr_size)
> >     ^
> > 632/2392 (26.42%) spills, 1760/2392 (73.58%) variables
> > so increase the limit for configurations that have KASAN or KCSAN enabl=
ed for not
> > breaking the majority of builds.
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  kernel/bpf/Makefile | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index e497011261b8..07ed1e81aa62 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -6,6 +6,12 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -f=
no-gcse
> >  endif
> >  CFLAGS_core.o +=3D -Wno-override-init $(cflags-nogcse-yy)
> >
> > +ifneq ($(CONFIG_FRAME_WARN),0)
> > +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> > +CFLAGS_verifier.o =3D -Wframe-larger-than=3D2392
>
> that's very compiler specific.
> version +-1 will have different results.
> Please investigate what is causing the large stack size instead.
> pw-bot: cr
This increase in stack frame size only occurs when KASAN or KCSAN is
configured. KASAN or
KCSAN will cause the stack frame size to increase, and it will insert
additional code and data
structures to detect memory errors during compilation. These
additional checks will increase
the stack space requirements of the function.
Thanks.

