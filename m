Return-Path: <bpf+bounces-46147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB619E526F
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91B31880753
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24B1D63F6;
	Thu,  5 Dec 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNoUn/qm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7081A8F90;
	Thu,  5 Dec 2024 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394959; cv=none; b=WnSL7DHBV744rkJcLRQPWyCpZDhvZthARlxk3LFdJc71aW28jYogrjU4DN6/q4FIDoF9fOH5F9qFLF8tSRwMGKLjnaq+3hfYhhxHH39DM9vH1F1zyls/Ouey/tC/0xKEev2gKkQ2q8F6C6avmppg05eChC5W8YZS96dFPlH+Bz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394959; c=relaxed/simple;
	bh=7IXKdskA+LLIPp8jR5IiT8OqfYI64uIJlxwsBYx/fLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFrSPXzhTWiE5eHJz0gXoaKDmgWkUCh4EycEixUVueekOmKZHeTwz11Tltp0KLKxslqgvwnXKvR12364clH7a2P02dm8QF255pnkP2wUOx6G6R6cU0+7XSkULGXDLBXyQ1gtHQniMBXu5sgozJDehoik54d1xy2x7UYNM1Z4wUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNoUn/qm; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so6098321fa.3;
        Thu, 05 Dec 2024 02:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733394955; x=1733999755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGBlXjWXX6UA1pnUb6eFZF67zXS/U/rRQY47JDY/d7M=;
        b=VNoUn/qmBYayJ2DR+JKMU4G/7lOYLIb/37/g2Hxlki0HkcIWYA0RZQ2c6FxMRO+8Y8
         GoFME80pUDeSGg1BSILpIXneQyqk0XPJ0zMAmVJDh2UsJXHgB+a/JnGRCYqvAaaFmkVB
         ScB5Atcu+LmXbf0zD51AT5dROoT2qu7o5qusqRFppGLa3hGa2tU2P7W1oaMC1BfhceMV
         OhdLmpyeU0J1TzHWHxAv75AQ4YAMn/elUcGaMo9T16HM/2WioTxnx86gJTGyoEwrtiN2
         DvbKXdxcr9sR1BSfBYqMle30TIicDNqnUnT2fRGX+ftLpM1aRs447V//fnfa1E282S+V
         Ku8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394955; x=1733999755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGBlXjWXX6UA1pnUb6eFZF67zXS/U/rRQY47JDY/d7M=;
        b=pZBT45kseOBnjGIaU65b64qJUYmMIYR29mfkcYSS69Re94Y/iUnAg/XE8cp7iFxHwG
         D3JL2yxmtVVrDwy/h98Nb3T79fv0eHhvdLqgDxswKco8NaN+lJsY9kuC8Zn4QV+IboDh
         8ziJMGd4FIUDCPo16lxcm3urSrO449mPVQmOediIsE1XI+dGdMx9pJcUklQzlf5CWasT
         CZwdDw3IpdTRS4dPIT1jCNY5GePqVi1OCLnCDFucNoiZOsDN8GeSoazF+Vh5rcLxLuv1
         /tfzw6vdk9XuEd64ivToYBv7vn2jlu3xJSTyB3IsqESH3WcnGYvreI+LsjUGW4wGhjTM
         eOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsrB9fZq7ciIRfVjc5FdwJC9zlAXcPEYdk94VgzWR/ClZiQyRFn5CCNX/bSvNLAjjFJq0=@vger.kernel.org, AJvYcCWQZGv+QOPPcGPtn5CDMeLaQRfwFqTfrMaAsecjLHtDefhzh5mxQgIfB4zODGrsMx3Vi6d03aJILgAFvsUs@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMZU2zn1RV+ZzIdofYy2tabZjw3AN4+sT5nCef70l/9BbTL0M
	Ij+Ttg1ZyJfhfj+tkREKe1+ih3cFg5nuiZ5Kj4kdV+Zre07W4am4hpsFe1+oKnDcClSn45aDV8F
	PwL56Em3799G26IsFOnbSQxd6ATA=
X-Gm-Gg: ASbGncvznxO5+mVXgBg0tM8WRNVlun9qIIhx6A09xMOqv6v4DFnc6VDQ3rus5emaQYR
	qcPhHCMjieUh/EIpT1Kj24aiqWvDORqk=
X-Google-Smtp-Source: AGHT+IF9hnQNVk6ZpYzIQHDzAkhYHiH62b9JV3oF6rG0cJLloFhfMCIv2naxMshN7F04Gzkb9fWAIsCQyME/4ARi2mw=
X-Received: by 2002:a2e:a554:0:b0:2ff:c99f:dcea with SMTP id
 38308e7fff4ca-30009caa60bmr70105361fa.34.1733394955215; Thu, 05 Dec 2024
 02:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com> <Z1GBXHM1M4-Ws9Br@krava>
In-Reply-To: <Z1GBXHM1M4-Ws9Br@krava>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Dec 2024 11:35:43 +0100
Message-ID: <CAFULd4YMoOmKUb+_rqdMv=Nu=8UNSdxe9EtN+R4kHB4Ag7cGpA@mail.gmail.com>
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>, alan.maguire@oracle.com, bpf@vger.kernel.org, 
	chrome-platform@lists.linux.dev, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Dec 04, 2024 at 04:53:05PM +0100, Laura Nao wrote:
> > On 11/15/24 18:17, Laura Nao wrote:
> > > I managed to reproduce the issue locally and I've uploaded the vmlinu=
x[1]
> > > (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of =
the
> > > modules[3] and its btf data[4] extracted with:
> > >
> > > bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd=
_led_backlight.ko.raw
> > >
> > > Looking again at the logs[5], I've noticed the following is reported:
> > >
> > > [    0.415885] BPF:          type_id=3D115803 offset=3D177920 size=3D=
1152
> > > [    0.416029] BPF:
> > > [    0.416083] BPF: Invalid offset
> > > [    0.416165] BPF:
> > >
> > > There are two different definitions of rcu_data in '.data..percpu', o=
ne
> > > is a struct and the other is an integer:
> > >
> > > type_id=3D115801 offset=3D177920 size=3D1152 (VAR 'rcu_data')
> > > type_id=3D115803 offset=3D177920 size=3D1152 (VAR 'rcu_data')
> > >
> > > [115801] VAR 'rcu_data' type_id=3D115572, linkage=3Dstatic
> > > [115803] VAR 'rcu_data' type_id=3D1, linkage=3Dstatic
> > >
> > > [115572] STRUCT 'rcu_data' size=3D1152 vlen=3D69
> > > [1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 enc=
oding=3D(none)
> > >
> > > I assume that's not expected, correct?
> > >
> > > I'll dig a bit deeper and report back if I can find anything else.
> >
> > I ran a bisection, and it appears the culprit commit is:
> > https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/
>
> which tree are you using, I can't see this in linu-next ?

The offending commit is now part of linus tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D001217defda86d0d6a5a9e6cf77a6b813857e7e3

Uros.

