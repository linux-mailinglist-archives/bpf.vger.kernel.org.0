Return-Path: <bpf+bounces-18913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE78236C5
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34C31F2547A
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5B1D54F;
	Wed,  3 Jan 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0yiDYhQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDA1D547
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso833400f8f.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 12:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704314880; x=1704919680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wf3C9kelqEXrEzkggJyaN3U4yjJAjmp+ZBy5HVHtXz0=;
        b=e0yiDYhQXVvEFXBbLdebR/rtTVPMDsU8U+mnEEq/QmUOvs4Ks+tpA+RDUoZB27I6QB
         JTRmSob9h99QxPTM5m3+UBwmRkxBkfeurMEheh9W0BGJ0O7z3/9d1pDCb9OfXDou2dKj
         C9gRlaP4lBd76EHsrcAw/WM5JBcXtRqmV+7j5oQnmauoJrsarYeklUa3QtrEFYHMkDBD
         6tuJux2CF0oHkB+zHBX3quhyoSGIw8LoLT6FwnXvnCJEE0IsHMm/rzfQN7fUYbPm8uZV
         kMpX5dOcEmgdVA5vdD/+GnQZqBvhMWSAsnmLRWU0spzviWrL67wNNNaPvPkvsHz52nXA
         y23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704314880; x=1704919680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wf3C9kelqEXrEzkggJyaN3U4yjJAjmp+ZBy5HVHtXz0=;
        b=KY8A5uIJ8BKsCKj0tGt/JeVFk3zYmrl6KcYHq3Pe+8KQOcXcemCZB6L3M1ao+XKhi/
         oXbzIH6ADl18OX7Z5chczO4tXNeTaEZGjMmOS07+Z3ISCu8xm+B4lwMW6Sz5jH8Nt4ys
         JSdrvOgAv2WGRnaMasHvbKVFvM0S9GFYUgE0zOtJo5fjNdl8zoXW+FfOOhb9YnWSXb3p
         tFjCG2eBJQHZU1Waj9RBBDF2H3AoQNe/LyBjhvPIQPIxHw8rJxyFdPuG17j+g2HYycNl
         T2nwKSgSxTCGwmb3vmNNk+pQDDCaMRh8D/QL2moVbrL8sj7tts9FI6eFzbWk3AVNAgH7
         y9UA==
X-Gm-Message-State: AOJu0Yz2prEKbLr4knoVgaIc0JjsRz7PqTWQjKlnW07s0RYSZNPsqwdj
	xbK2ZJVXBGh9wbKaK2MlGwvmEb2srdb7n0WD6Gg=
X-Google-Smtp-Source: AGHT+IH4zyQWe/IH5UNaky+wX3olJ/RJsbAAw29tNtTsdL/pA+k/b9uC1aTH493iceD45LvpteTehrNzVsSn4z9SNe0=
X-Received: by 2002:a5d:69cd:0:b0:336:c32e:5ae8 with SMTP id
 s13-20020a5d69cd000000b00336c32e5ae8mr8224164wrw.56.1704314880437; Wed, 03
 Jan 2024 12:48:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SEZPR03MB6786598744F4D5DE29C46651B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <2024010317-undercoat-widow-e087@gregkh> <SEZPR03MB678613E8257AD66C6CE47410B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <SEZPR03MB6786B27446DE261893D911B5B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB6786B27446DE261893D911B5B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jan 2024 12:47:49 -0800
Message-ID: <CAADnVQL-Lvg8ySrN+DNw45AHvKtWBdKLfPhdQn2ZZOdcrgrCyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Adding BPF NX
To: Maxwell Bland <mbland@motorola.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Andrew Wheeler <awheeler@motorola.com>, =?UTF-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>, 
	"di_jin@brown.edu" <di_jin@brown.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:16=E2=80=AFAM Maxwell Bland <mbland@motorola.com>=
 wrote:
>
> From: Tenut <tenut@Niobium>
> Subject: [PATCH 1/2] Adding BPF NX
>
> Reserve a memory region for BPF program, and check for it in the interpre=
ter. This simulate the effect of non-executable memory for BPF execution.

Hi Maxwell,

interesting ideas in these two patches.
Coding style is not kernel, so if you want to upstream them
you need to follow the patch submission process more closely.

Also checking that you're aware that the interpreter is not secure in gener=
al.
Secure systems must use CONFIG_BPF_JIT_ALWAYS_ON.
Adding extra checks to interpreter helps a bit,
but you should really remove the interpreter.

