Return-Path: <bpf+bounces-50417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708BAA275C7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 16:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2795218868E4
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E92144A6;
	Tue,  4 Feb 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjZJPmmE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C5213E81;
	Tue,  4 Feb 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682899; cv=none; b=LQX50jB6+Kt6ZGMOkfDmVhTbngATHr5PvsJgfLsWd6fv/u3a0JcFFGs+IGikYU7XPnWCplmDcXVUMg92vDg7tn5oTKQNZ2SevSjYezKYpGyUa+C0hNWtuT4Oy/d0TzdOnDZreTr75gpjXHCYS9yfbZaelApyA4C7be8EeQjcOMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682899; c=relaxed/simple;
	bh=+RTmhaHHaQGm4cIFZWnW7TQKI/e/CUSRnumlIk8Xc7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeKn6KtONSGYR/tJRPuETmltPFPyvfke1zdePNwIMUje5C12uHyHO2pTMjphr1hZMRtQ9A0sVQ52fivBOgvEz9+nK++JzbMn0V0bGq9jVAL+ZbFFBRT8e1cGBlta1H17IPv+FYd6qTr3encvWQg5osW+8V74rMxq6H+gmw6E/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjZJPmmE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38da88e6db0so440851f8f.2;
        Tue, 04 Feb 2025 07:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738682896; x=1739287696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJhPx/n140dbE5Ug5FtKmDwUapQIL+7iGwFgWil94QY=;
        b=mjZJPmmEg17I3X2sItNy7ITedaTCpWNgiU+7sYjhWEL0m4vZ5raPZM4wTVEnOT9PRD
         YTZ10dlU/K3ReS4ZNLH/9vu/KO6tH5ULQbVCff3zKb9JDYXZM/5mYwF81pvWLEX+EgkQ
         +I7t6Hrb32cid5iS/gbMZYu2q3apNeFvrJWtPos/PrhJIqvIJmmZJWdQi/WbQfwLBdT+
         yMwzFwYzIS7Lv3YnTtk+V2pPEqXsqoLvWQGRJ9d4HmoaNKCih8yx99MmqM4/LG/nWmyK
         9hwaNhbe93ts+OkKpWNkkSvzpaFnFSUUZYUg4SXMupJoOE0tum6CG72Jbt/vv0megekO
         BfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738682896; x=1739287696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJhPx/n140dbE5Ug5FtKmDwUapQIL+7iGwFgWil94QY=;
        b=iiFEnLZbQs1JLYEyFwTRt28v7hAyw6gUUxP3mkxydWQ2BlxY8LGix9ynoJZfc0r2WG
         dkJcKucrng/DfUExTTYgIzYLEmeX5bgj8Lt7/ApkJZ3IDcHDQ3obeDRqVRWGfRq77s8p
         oGJE0/eQDqKcQH1vO3FaFva8oXkNQfTFyXrBHH2mS7COvW56ya0gYSGKJ6YL8pjhqfij
         TkN1BCuaicgxO7XSv6Ggg1BnlH3O2CxYoWInVw3vzgqUKRDb/WIy++/r+5sZv7vypTkU
         e8ZpqAB0ABOrzcixPFFTX/Yhwkt77sNC2zzOOb7hpWSba3XV1J5fPAW1kFQ0yGioto+f
         YUdw==
X-Forwarded-Encrypted: i=1; AJvYcCUDyNNrMynLJyGhaFrLd+IbtcSpCCqJcPVpXSVL6a3ciZIkQBeMKVHWrQ8Nvl+efGaCAZ43rwa54H2VpBalKg==@vger.kernel.org, AJvYcCWFiCml5nLfIQiiuCNryCmt/8f7sxbPkK7SlBw+tNxojdD2gBv+c4qn0yF/NbqtIunkIHeRk6OXH+uB/XVw@vger.kernel.org, AJvYcCXW57dCsCJR9OZbo9uG5XOFvLFLaZxMQLSIqz0Z9Nmhjz9MSkySkfU7xhAWRunfVMzcip4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMBgdg13DC46sIEt90FRXfaI0YmKmrZACmAQRkWXAF+DTEofX
	Bi0JGICXNhR21cpbwLErTu+7hVOUblY9Fzd8et4lVowkychtvkVZwpCrWXgunP7WQGcD2jxbMI1
	ZFpwDScKqDd6uIsDlB7L04MoJWg0=
X-Gm-Gg: ASbGncvHSljK6I87xQOBk39fgbjidmtuScBT+YBAICjM7Pj8eNswvvojyI6lhe3bUS4
	toA1NUDV46gREM88lW9wnQmSp8VqFA1UiHCk5dEV8hYhdrCSEXzR3N54k0ptzRWVzs0PtvyPlVG
	y654/7JHS6HTQn
X-Google-Smtp-Source: AGHT+IFhUU0NGcAm74lqYKBjmVZFYxqKNWGzHqhC76jkheWflwBMBvUcfdp+145E+7L0HxVO/HGqB2zGjvC83k5JbeQ=
X-Received: by 2002:a05:6000:1a8d:b0:386:36e7:f44f with SMTP id
 ffacd0b85a97d-38c519602famr21645102f8f.18.1738682896006; Tue, 04 Feb 2025
 07:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com> <xsg3mrozb3zd7g3hqki7lvdkc4zbi6bs3oiif64kvnnldaai5a@3g7gnpcz5igh>
In-Reply-To: <xsg3mrozb3zd7g3hqki7lvdkc4zbi6bs3oiif64kvnnldaai5a@3g7gnpcz5igh>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 15:28:03 +0000
X-Gm-Features: AWEUYZm7qusB4k_yByZ1Yov0CkD9oT2bxmzUNE_2hxazTeM6MjG1S9C9NSBjpNk
Message-ID: <CAADnVQLto_Zt7q4vmTFXby0QH8QX7r5am5inLskC5sKqL=0gow@mail.gmail.com>
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-modules@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 1:30=E2=80=AFPM Daniel Gomez <da.gomez@kernel.org> w=
rote:
>
> On Wed, Jan 22, 2025 at 09:02:19AM +0100, Alexei Starovoitov wrote:
> > On Wed, Jan 22, 2025 at 5:12=E2=80=AFAM Daniel Gomez <da.gomez@samsung.=
com> wrote:
> > >
> > > Add support for a module error injection tool. The tool
> > > can inject errors in the annotated module kernel functions
> > > such as complete_formation(), do_init_module() and
> > > module_enable_rodata_after_init(). Module name and module function ar=
e
> > > required parameters to have control over the error injection.
> > >
> > > Example: Inject error -22 to module_enable_rodata_ro_after_init for
> > > brd module:
> > >
> > > sudo moderr --modname=3Dbrd --modfunc=3Dmodule_enable_rodata_ro_after=
_init \
> > > --error=3D-22 --trace
> > > Monitoring module error injection... Hit Ctrl-C to end.
> > > MODULE     ERROR FUNCTION
> > > brd        -22   module_enable_rodata_after_init()
> > >
> > > Kernel messages:
> > > [   89.463690] brd: module loaded
> > > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22=
,
> > > ro_after_init data might still be writable
> > >
> > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > ---
> > >  tools/bpf/Makefile            |  13 ++-
> > >  tools/bpf/moderr/.gitignore   |   2 +
> > >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
> > >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
> > >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++=
++++++++++
> > >  tools/bpf/moderr/moderr.h     |  40 +++++++
> > >  6 files changed, 510 insertions(+), 3 deletions(-)
> >
> > The tool looks useful, but we don't add tools to the kernel repo.
> > It has to stay out of tree.
>
> Can you clarify what do you mean? There are other tools under tools/ and =
tools/
> bpf [1].
>
> [1] https://lore.kernel.org/bpf/20200114184230.GA204154@krava/

As you noticed we added only one tool out of many and recently
discussed removing it, since the value of keeping it in the tree
is minimal.

> I will anyway move the tool to the suggested location in the other thread=
.

I don't think it's a good idea.
Keep it outside. There is no reason for it to live in the tree.

