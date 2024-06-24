Return-Path: <bpf+bounces-32862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E59140DA
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 05:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E3283D30
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A416E79CF;
	Mon, 24 Jun 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew4nI3Tt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D0623
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719200339; cv=none; b=VFi5X3EqYqH9D8UDx87TR4wV5agnDQ9iGSVipJBW546a+UcOQxBY66oJigxMDy92CTQTMXMNllbtW+czVaT4V6K5ppz5hucfmVsb6+0y13XBHGqrLmbQdHldpbxkh+M+ZQFqhPFzdVveQeiYfSXbtpT/Dfc0Oxd67ioe29gNO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719200339; c=relaxed/simple;
	bh=5mXea3MGyy4VC12TDy+Jn0U6ZDjYhSR9JZ8y7Ub4NVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4eBYdYCdflXSn1BWR5bnmRkFnMhuoAz5ioVx89qQY/BDrOp6R7+R59Xc/DLoFF9yBeP/GqrUrtg75K5j2QuOcNb5fExQm4uDVhobbVZhLUvgLReFEG5pphv0JPRb90osyl5yBy0d8BvTAlXNWdc0lRApVG576l1mbtFbLqFPXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew4nI3Tt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3632a6437d7so2180639f8f.0
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 20:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719200336; x=1719805136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mXea3MGyy4VC12TDy+Jn0U6ZDjYhSR9JZ8y7Ub4NVQ=;
        b=ew4nI3TtEww8rTB8OO6C3YIYB0OBg2xZ4qkEEVyIYhjZ1Bb0lFiFL/X77fR83S9Z9u
         oeKy473yOtLwgf7Xfr0RoQa11wIWhFlcze9I4dAK0lkbsYn5KItbrR0J1JjwGv9C8q78
         zp0SIJPAbpvHmPeehMbOV1JjRs9P/6idUjLjmJJMU/2deYkdMWeJW5vdhRcLrDgTJTF4
         e2cjnV4W1+9AzMR+vql9xwHqhzx9QnGtxdKcl+dGttPTVTmxlS6OQX8oi0KFxxQNUT1c
         ybN80CJeTe60ESObtKE0eW8h/myNkjumzV5bxPZq8IAfDfEyN0jVymwjXLYLmpfpNvgd
         2p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719200336; x=1719805136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mXea3MGyy4VC12TDy+Jn0U6ZDjYhSR9JZ8y7Ub4NVQ=;
        b=ux+P0dS1xK7PF7ZZNxovo/wFL57U7sZ+5QcUb6125AkFfhkr4FEubiszNMVpsQUh+/
         A0ofGnia2Zu7/xQuD2cXE1BLHz1s9pF/5aVtsMw6u7lOt/NTO4ds1lLH/Kiy/eHiNuB3
         EcttYJDnqD/Vo2/OPYUJFU4E5K+C99qkJHmcy5pe60X3LrejwP3Hwda/0S4E2sV02AAu
         DwEhP1CDCooNXpMfvbj5rV1yAl8c6gQL7tST83NmrhHHx7ZfMZhKHYgpDoBiZqYtswur
         9vksDPn0D4baUfYADATRqgk6uuBrR/YGb0fJmQPq+bAWwu5l5q/g8CqY/f4M0z3tIuie
         /YHQ==
X-Gm-Message-State: AOJu0YzVMvwdV8ZdbgnkJh1ChvMmEfCdwp5wTGGFPbqbYdf70WDz+N7f
	jAYo9DwEfAuFaUz2wRBaBgrdeKTjTzU6pAgvmI/OsOsTgNWuAOwF+4ak6IlwYqjE8Nk+LQop0Wf
	vNXLopAmP5gSvpkOC5D8FhI1aeKs=
X-Google-Smtp-Source: AGHT+IHT6M3e4YKxSdP6EK9IpXKQ8QnKPK+5LYSGM56u23Geoh45KEheraXbf7k9zriIam3HpnDJIDow36Cx0H0SfE0=
X-Received: by 2002:a05:6000:4026:b0:366:595c:ca0c with SMTP id
 ffacd0b85a97d-366e36af80fmr4371420f8f.24.1719200335602; Sun, 23 Jun 2024
 20:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623070324.12634-1-shung-hsi.yu@suse.com> <20240623070324.12634-2-shung-hsi.yu@suse.com>
In-Reply-To: <20240623070324.12634-2-shung-hsi.yu@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 23 Jun 2024 20:38:44 -0700
Message-ID: <CAADnVQJar6vM-3U_e49yxz=keZs7=xn7O+k_EOAWjnA7kH1VLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: verifier: use check_add_overflow() to
 check for addition overflows
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 12:03=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> signed_add*_overflows() was added back when there was no overflow-check
> helper. With the introduction of such helpers in commit f0907827a8a91
> ("compiler.h: enable builtin overflow checkers and add fallback code"), w=
e
> can drop signed_add*_overflows() in kernel/bpf/verifier.c and use the
> generic check_add_overflow() instead.
>
> This will make future refactoring easier, and possibly taking advantage o=
f
> compiler-emitted hardware instructions that efficiently implement these
> checks.
>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> shung-hsi.yu: maybe there's a better name instead of {min,max}_cur, but
> I coudln't come up with one.

Just smin/smax without _cur suffix ?

What is the asm before/after ?

