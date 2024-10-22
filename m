Return-Path: <bpf+bounces-42847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488499ABA21
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 01:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C0C1C21F39
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 23:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1331CCEDF;
	Tue, 22 Oct 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMT0EXQh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE218DF6B
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640243; cv=none; b=qhuu66nYxGm+p84LSZLjqg03iynZ42tqYQGgyQgY60JGEe4oVuaD+vLcyZkjNVzlEgkc3cDRdMbGhVjTJWG+t9Yg1/CYOJzvrTiNM/yKyA4Wtu7t5Nc3NVJQ/PcBnuhtJUCO9zyZjFhQTC2TfSAJgxOtPsH39PL3fUO0x7W7JYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640243; c=relaxed/simple;
	bh=I8frADe4ITnfzdev7cegg85D5qb80M9dxPCb1E5//gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFK7ASMzifHsU0kddU/f75e19BwCLY/bMbatILatT7Uv56Yt7oExRTRKoixrd1oY+KyBtSp2YPr2/gFyPIEgwUD/vSBl81EVcK1t7lk3a5x2Nvdo4lHHvolyTJ3wD9lOK9UdsM0DVHqm4cp/7JL+SA0Oer8UPhaoUntripJVw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMT0EXQh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e13375d3so6860194e87.3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729640240; x=1730245040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8frADe4ITnfzdev7cegg85D5qb80M9dxPCb1E5//gQ=;
        b=mMT0EXQhB9k+gr3PJ4WZMmxkbOMME5B7v14VSP7mB09LzGPyj++ls//22Dt0dqGhlD
         DTxv8c9+DQKHyq2cI18qqRGjJiYEdJCbsXrax9N6wSIGdaGtCIL8PEPrcM6tSgu0Nzci
         dmwt11dssJqC/wcG9G0CTsYBirjvy9gnUYcu19gTCtYfPYd6k6QY3trIk/KiRkjc1Pfe
         emFgB83kmkYW0/wXUs97CgZhpAQNnOakQVqNKQIiCKIHipqlktgbeoCjRzq8n/tIiZcz
         BkhLhBpLyI3h9qmj/wdNt2ZDVVrJDhmOX2GAmVF5PkpbfXq5uc8EvGHho4TwbdbnmsC/
         aDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729640240; x=1730245040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8frADe4ITnfzdev7cegg85D5qb80M9dxPCb1E5//gQ=;
        b=gwCZiiRjX77kSIqY7z/6kBBe8IDsocIFhcwD2ibNNIdYj1vL8/CaiK7CKL83DWhnxS
         YCD7itP3zkqfb9MzYMX3SCsnkcPlAwi70ZJh+tp0hs6/xpZ8csI2eqszPZrSq7yP7RHD
         +5DSSPj7OQcOMwBL7lYHZS3htRCbwD7BzLTTXFYtybTww7n4dIKcf3k9p/irGqV0Nba+
         Hd3qFNIYlxZ/lS9WGXiA0hXV/mFdfChQ3D+5PAjpnaSH0b9GxxJA1Cs45ab1VVx8Nx9t
         m1sFcFCQjeJX9SOmX/tXqBR/N3rQj6z3coYJCiGQNIQyb9gndJ2SifxYkq4SOtbKbld5
         QG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvBhyiezZrgRZw49FKVsuCMNHfjf8vEkt8cv+FsbswRr6OrK8fmHkxX26HYVPdDjIptHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTYKjgkXcUjkZZ00j8rhNuJyGFJEsrfp5XV3xAKDT4FwGf/5z
	fk13rtujc+8rwOHd5Z4kI2TyRropUFCmKkF5e3piRClKJVHB2p2RogSGPpNNB0V7Jt0P1E9muFy
	cb6jNbfFU8QQhjGLeaPVdE+DsHj8=
X-Google-Smtp-Source: AGHT+IHAKH+Udn2KrP2YTJBtjRNEEnOCeMK5mVfyz/jPTUEUyQ/AJTbkrXlIOmu+fgGrLA+UYDqEiq1ViGR7wX0lXpo=
X-Received: by 2002:a05:6512:31c8:b0:53a:40e:d53d with SMTP id
 2adb3069b0e04-53b1a31dceamr202338e87.13.1729640239483; Tue, 22 Oct 2024
 16:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019092709.128359-1-xukuohai@huaweicloud.com> <CAADnVQLOY-eHby6CMNXr3FvwPm85W-tWDxiWnRaR_U_=71ADuA@mail.gmail.com>
In-Reply-To: <CAADnVQLOY-eHby6CMNXr3FvwPm85W-tWDxiWnRaR_U_=71ADuA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 23 Oct 2024 01:37:08 +0200
Message-ID: <CANk7y0jiuiHSMTEZ_JCb4QpEPzhkK4ikicDGFa1F30DinZta8A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, arm64: Fix stack frame construction for
 struct_ops trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Oct 19, 2024 at 2:15=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.c=
om> wrote:
> >
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > The callsite layout for arm64 fentry is:
> >
> > mov x9, lr
> > nop
> >
> > When a bpf prog is attached, the nop instruction is patched to a call
> > to bpf trampoline:
> >
> > mov x9, lr
> > bl <bpf trampoline>
> >
> > This passes two return addresses to bpf trampoline: the return address
> > for the traced function/prog, stored in x9, and the return address for
> > the bpf trampoline, stored in lr. To ensure stacktrace works properly,
> > the bpf trampoline constructs two fake function stack frames using x9
> > and lr.
> >
> > However, struct_ops progs are used as function callbacks and are invoke=
d
> > directly, without x9 being set as the fentry callsite does. Therefore,
> > only one stack frame should be constructed using lr for struct_ops.
>
> Are you saying that currently stack unwinder on arm64 is
> completely broken for struct_ops progs ?
> or it shows an extra frame that doesn't have to be shown ?
>
> If former then it's certainly a bpf tree material.
> If latter then bpf-next will do.
> Pls clarify.

It is not completely broken, only an extra garbage frame is shown
between the caller of the trampoline and its caller.

So, this can go from the bpf-next tree. But let's wait for Xu to
provide more information.

Thanks,
Puranjay

