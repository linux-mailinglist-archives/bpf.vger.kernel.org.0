Return-Path: <bpf+bounces-37198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E7E952154
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 19:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EB32829B5
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9FF1BC07A;
	Wed, 14 Aug 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/tNz8Ht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F21B32D2
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656918; cv=none; b=sP5JEcs5LMkuTRR9xeOSHEBr+OaD5kR80eO/96paVzRGpVGcQtmhdezIaENMbKcFmRXNsU3N2MBXAcYfjUyuZwlUhOb6q2E64gppGYTXwWSXjliFxUZFxfqY4D5wGc89CfvIK0i7KLELYFeeQoQaliRueqZFqC8EByazqxexTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656918; c=relaxed/simple;
	bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC5oirZWGRd5FGYHryTmfrBW/4bcPcPWStifQf3KSaGj0hg2BRNkF3XEJhH7SBtkxyps3717OK8Hr3GhWnHAxuCavwZSR4orr4s1X0kE04HEimtAEkJscyN1mBtrF/ymC698YsTInGfvS3cjjEslm/Dsc/kDgVRKzCDMzLVdfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/tNz8Ht; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53212e0aa92so125935e87.0
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723656915; x=1724261715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
        b=H/tNz8HtkGiGMKcPN+qSt5RnpqVA9WH2BkwImL0krz6Fua4FH9X/Ppt1QilJ9B4Ql7
         M4b5j91OMzPo9u/ZJdJgBY9XQBnQr5PhsHYl1z29hVnt/hvSGsfiXUxW8uWwIpmeJUb8
         rImxKi1pjrV7IxFX4WW6zW+Sn6XyNFTUitj6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656915; x=1724261715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWbitBG4Vy57q6SFKYvH/+aIN3UK4pDJiwGhdEeSOtA=;
        b=N3o72cARqX2NhFT1FWQPOUp3cV0g6JICYUAh6U4DKE9rnjG1ph8o7bEHXyV3xKwNpP
         qhzgAnSHUVU19X8PvyUOWtj/6kaT9rX2ImJmvc1seayHlYIGujfA0Nt1OSUKpT+dzjlQ
         CVLNjwnCB+fM3taz0mByQ7JMvwnHycXtJGYEp9vTC0GgZKByBEC/qPzUhXV1SdF7qLkp
         Lhn8vfnQn6kSu6Jvz5daSOZuc6Qr/VUIfX09QIPkxN9hjCbo4IbxDTWQaeF84sHvft1/
         MAkTyVCSUBKplEPHrCh9puKd6rjfeRbz6uwRvKOjSOMFFQirVwuyxGGeQXYIOLaCk9nS
         sChQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5tSofaN0W6r6vY2hGIGtKO2sbJC9WaTfxExyLuld6+N3z2L5X8/FOmjTWPvaycyMoWO2iWLNG2QDSuGnRyB7wGg7v
X-Gm-Message-State: AOJu0YySNuG8OnH+c1paIrzLPHWBCx5F8CwxkDM2SOXu6ezhjWI98/qK
	9IdGfK165sEdDadTQcPHIkou72axCoFNq3PgrjtAEV3pIgDU4WeN8jRU7UQFJqe97mbK+OJRGQw
	=
X-Google-Smtp-Source: AGHT+IEBrEPQBMvTWkw4CDQgJniDD4KimIYYkzWASH4EvPIw5kdTjZfI0RTCoi5Eums5onGqJ3SoqA==
X-Received: by 2002:a05:6512:ac2:b0:530:bb10:2874 with SMTP id 2adb3069b0e04-532eda5b0c2mr2950274e87.6.1723656914921;
        Wed, 14 Aug 2024 10:35:14 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200f3fb21sm1319018e87.249.2024.08.14.10.35.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:35:14 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53212e0aa92so125897e87.0
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 10:35:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXf07tFcPuUaY9FtHmzNniPnoatyKwSTny+eFt+M11pJBSNUi8LU8l06WuuUzZdko+qfiehnc/ju1r2/EEdSyJ/MEG8
X-Received: by 2002:a05:6512:10c6:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-532edba89e2mr2666679e87.40.1723656913739; Wed, 14 Aug 2024
 10:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814173021.3726785-1-agordeev@linux.ibm.com>
In-Reply-To: <20240814173021.3726785-1-agordeev@linux.ibm.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 14 Aug 2024 10:35:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
Message-ID: <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
Subject: Re: [PATCH] tools build: Provide consistent build options for fixdep
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 10:30=E2=80=AFAM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> The fixdep binary is being compiled and linked in one step since commit
> ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues").
> While the host linker flags are passed to the compiler the host compiler
> flags are missed.
>
> That might lead to failures as result of the compiler vs linker flags
> inconsistency. For example, during RPM package build redhat-hardened-ld
> script is provided to gcc, while redhat-hardened-cc1 script is missed.
> That leads to an error on s390:
>
> /usr/bin/ld: /tmp/ccUT8Rdm.o: `stderr@@GLIBC_2.2' non-PLT reloc for
> symbol defined in shared library and accessed from executable (rebuild
> file with -fPIC ?)
>
> Provide both KBUILD_HOSTCFLAGS and KBUILD_HOSTLDFLAGS to avoid that.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

FWIW, I already fielded some reports about this, and proposed a very
similar (but not identical) fix:

https://lore.kernel.org/lkml/20240814030436.2022155-1-briannorris@chromium.=
org/

Frankly, I wasn't sure about HOSTxxFLAGS vs KBUILD_HOSTxxFLAGS -- and
that's the difference between yours and mine. If yours works, that
looks like the cleaner solution. So:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Either way, it might be good to also include some of these tags if
this is committed:

Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@l=
eemhuis.info/
Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")

Brian

