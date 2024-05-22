Return-Path: <bpf+bounces-30327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192058CC79A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 22:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C718D282AB5
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F91419BA;
	Wed, 22 May 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehtr33Rd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DCF4E7
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716408248; cv=none; b=kMC0s64QDRH1LcBfeso7xvmbkAA0454512ZFHdau0wyR0wjH96kUzxtJB/Wa0MBSL69DwaBtdR5FQM5cHJVoP9OycICHxZRPDfV8DnHacm5Lg+z6fOsu2fl76upBh4dKLpZClXDXOYShF016YHLVC75PwfyJMqdcYPlzazlf90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716408248; c=relaxed/simple;
	bh=0S0r/8WLVka2Cs2oMxvctUNJiVLN9GcQQp/WTKR9tyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTT9cw2zgAsfVBUBdSlu8cC6ig6FBr7/5j992ZW8dPQhdCrmZNTLHHm07gwiwSFELh5kWKwYxmzZQtnJHl6vK0yMAMi0Nr5xwLosDF6uetBkXRoyW9ScH2ym9v8Cv+h4dPEAY9a5RGuwbwJ+T4GqvKFyXceXGlAbeNAz1rBnY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehtr33Rd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so1401439f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716408245; x=1717013045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S0r/8WLVka2Cs2oMxvctUNJiVLN9GcQQp/WTKR9tyI=;
        b=Ehtr33Rdk1zVmvDhcXdjyRAHGbbOaSCR5lHtb8TGVTV0GOwWESCSpddi1knKBzn5Yt
         ILQJt5oKuHGoE4Bcs98B1GocGSpMT5Tkw8cM2Y6GmPJ2Q+088PpTBtKtixzfX4sU4VSv
         RJQPdMGzyNFUF2K/Nl1b+1WA5DL3wznMexPuZg9u8i3ZQAsDJGHzhNkzgn9KrtnL48fd
         jZrOgDJROmlKh3kWxV3fjIFxyOMeQVsbbRlsqF5gPBjf9bP33bsK2NWpR3W3Sx0qWxKo
         72nXy6jaYAwgtMsCEYZXeH8FSdjOLqICYpIEuWVmhNMgrjAPfikWDT4dBadcL31jxklJ
         GONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716408245; x=1717013045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S0r/8WLVka2Cs2oMxvctUNJiVLN9GcQQp/WTKR9tyI=;
        b=To3nPa7d8ny+/0OlcNrcUZFvHjEbBnEgcfxuKDj7HlFKHb5HF6AgIdLDOut2MKUHRK
         +w790nON5znhUsbuNQMkAok6cKFEtaKsPmmtJYKWJdUryyFlo1UYxfyI6I88KdB0jp9a
         ZRBwWCYPgREE06D39hdf04p/GrzOCG+WnNoNalhD6blGAj9MsM6WhdkY0WcSRgDxddhk
         loDVWCOGw0NS6IcwtKUG+8J5AE8hg/5g4jROBm/uTEGdIk+iXeiMtyDK9fxsgUhapYRw
         68KF7hXVj/0HpyrSiifcE34XXl4bk83z0eQ6eq1IDJqFnqOAv0I+YUHuWGDUOQ3erZaO
         Z0Qg==
X-Gm-Message-State: AOJu0YwTNsMePJu4DaF8D0/gH+fHXHVesJLTcsRx6ROUTOsEIZx4Squ1
	3S6kzhtMP47gs1Phn++2jaksOHHTjrht39/Y0OM2I6fte5e/EK9K6828+g2RXQ22ZS63mJaCQGV
	wa9isQt8bNUISad0GpP55nxXpMHBydI6n
X-Google-Smtp-Source: AGHT+IEG93jGYvwokn1WQ4oOrC+kdjhpILt2Ry1WSs1Lmjbpv1umbyAfT+y1Jzr8BT6+l5xC7b/kZPYnjLuGY1dmxRE=
X-Received: by 2002:adf:a394:0:b0:354:e0f0:2943 with SMTP id
 ffacd0b85a97d-354e0f0297bmr2071888f8f.37.1716408244819; Wed, 22 May 2024
 13:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3faf9614-d61c-47a4-b8ba-6d97ae71fd44@google.com>
In-Reply-To: <3faf9614-d61c-47a4-b8ba-6d97ae71fd44@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 May 2024 13:03:53 -0700
Message-ID: <CAADnVQJw=mEX7ZEKffGMUm9my1Di9wFHwayhz+4vno_fypmnsQ@mail.gmail.com>
Subject: Re: BPF timers in hard irq context?
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>, Dohyun Kim <dohyunkim@google.com>, 
	Neel Natu <neelnatu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 2:59=E2=80=AFPM Barret Rhoden <brho@google.com> wro=
te:
>
> hi -
>
> we've noticed some variability in bpf timer expiration that goes away if
> we change the timers to run in hardirq context.

What kind of variability are we talking about?

> i imagine the use of softirqs was to keep the potentially long-running
> timer callback out of hardirq, but is there anything particularly
> dangerous about making them run in hardirq?

exactly what you said. We don't have a good mechanism to
keep bpf prog runtime tiny enough for hardirq.

> would you all be open to a patch that makes that a flag or something?
> e.g. BPF_F_TIMER_HARDIRQ.

There are very few users of MODE_*_HARD in the kernel.
Even the most demanding users like networking are using soft.

Have you tried BPF_F_TIMER_CPU_PIN to reduce jitter?

