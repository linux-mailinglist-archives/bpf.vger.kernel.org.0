Return-Path: <bpf+bounces-37317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A0953D24
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80BA1F26192
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B81547F9;
	Thu, 15 Aug 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/ghPiIn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018914A089
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759634; cv=none; b=F9E9Uf/p0f4Q0Pw2lRKHEMSSfqmeBCTOA6cI+YXIZOaXHtBhnZ8xRCJFuoZIVzzERvFbXK2h5QLX9U2yM6MJhOft/aTWnPMdMnYsmD0Bux3rkNh1D47d/5QNDWkox2/e2Ty+GlimFSHNWQSAcEUVVZAQN4Ljkrm+86zMMuFNzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759634; c=relaxed/simple;
	bh=lgOPmI/mhHSNbhkiwwEgGBzkQCnG4OemEgzRCwr+bDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=To58+HNsF16NQ7oVmUVWTe3pV+7Z077cBKyxvq/6iAmiqc0gF09ojEw+O0VPaX3n5cSD11F68yodfJB7QaF4lpFmcscfRSXzCmcaPYbHOUAwniVTEWxRMbRlN1W3C0icif48b/vCWY+fTEJ5wrBO9H7al6Rb8ys9kVSJbtPIJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/ghPiIn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso1013884a91.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759632; x=1724364432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQLD31nKt+xKEDG7IDoU5eAo3p4E9nstbU1XntXJpVQ=;
        b=j/ghPiInxxID4SA3Ni/72UoTJ9MiB0QqDsTuNnIH9sP8IcmQAShAwVhZmsSxiygMzE
         9OnnEMHfz/AYmIguwMu5+tcXZ46/uHRNR62Lq5xUuBQxcIXnoJXdsOtwOttt7WkY69xC
         EucGYmBGBCodj8aKptTv7JZSXmiuJhcYfHl8JiWkgvaFN2APOW6hggVUVdauAEMPUvFc
         g9LPdQwujPMPK2zPX8G/pvw1+JRSnwiLZf1jA8eXIoSlBWXdXn9T0YFks1vhy9gR2n1q
         ln56rickc9D1Yvgon6DxEBqwum4wQsDOsQs55MHbeIu6Z/dSzqaHLWndsx3PXmDEUKnV
         kwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759632; x=1724364432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQLD31nKt+xKEDG7IDoU5eAo3p4E9nstbU1XntXJpVQ=;
        b=Re7ewV6P3184IBfFBQv24HUBObv+ZYm2RDYmbz6c7oFzvsBVdSIZHmDElOY4rIFtcr
         mr/4xFuZpcrQxSd23F3SgLuTy59YVbjhiBXt3cIkIuLlq+MaePMZg1Lm9sv5iQ5ZEDyL
         ehyug9Xb/a8CzgmjpgyjvWmsFAyDRaw0JSIDRasBks1zZdTkFlwgRDW6A+bZNYNJy6NH
         GWZEzoeBVaCrB1S/BkDOwt6VNV5nh9+jfHwwpN7kzZ0KwI4vwj5xRIDfIVCK1h/OzpwN
         4o5KomWuwaHy0YsJA1TPFw+wQti84i7+PEZ6m+vw/MrPKQxoURcFsD70VPcjxH73+dVi
         2RJg==
X-Gm-Message-State: AOJu0YwF50zSiHJ/OthnIM6oU0eckSRhbMJrEqvKQ8q4vj7DdmVNaCx0
	EgdPVmcanzHYBMKgVI6/PqDmSrCoD4Xj3s4lRvD+fWEACkJpAtm6+zt572k98DOk0htipc7wc7C
	VSYurS59AI2W09c0God2vBBYx9f0=
X-Google-Smtp-Source: AGHT+IGE5o6xoPZpfgeQMinayb+gcjtdczTJHN29ZN4QAt3hMoSSs800Jz7lorCi1nDsL9GqmqkEokPBkjGZf59Xlzk=
X-Received: by 2002:a17:90a:dc13:b0:2d3:ce96:eb62 with SMTP id
 98e67ed59e1d1-2d3e03ffa41mr1189930a91.38.1723759632392; Thu, 15 Aug 2024
 15:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809010518.1137758-1-eddyz87@gmail.com> <20240809010518.1137758-5-eddyz87@gmail.com>
 <CAEf4Bza97Ksce2XYiQrvzYC5Lnqz68xWM+JvDeKMfj5M3pr+Rg@mail.gmail.com> <7925b20a052588f5b7b911ed10e23ba9fd56d4a4.camel@gmail.com>
In-Reply-To: <7925b20a052588f5b7b911ed10e23ba9fd56d4a4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:07:00 -0700
Message-ID: <CAEf4BzZNN4YViWtv_LR996T4uw86MhcOLLkNFPMgb=Y8qpxK8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-08-15 at 14:15 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > +/* program entry for main(), regular function prologue */
> > > +__jit_x86("    endbr64")
> > > +__jit_x86("    nopl    (%rax,%rax)")
> > > +__jit_x86("    xorq    %rax, %rax")
> > > +__jit_x86("    pushq   %rbp")
> > > +__jit_x86("    movq    %rsp, %rbp")
> >
> > I'm a bit too lazy to fish it out of the code, so I'll just ask.
> > Does matching of __jit_x86() string behave in the same way as __msg().
> > I.e., there could be unexpected lines that would be skipped, as long
> > as we find a match for each __jit_x86() one?
>
> Yes, behaves same way as __msg().
>
> > Isn't that a bit counter-intuitive and potentially dangerous behavior
> > for checking disassembly? If my assumption is correct, maybe we should
> > add some sort of `__jit_x86("...")` placeholder to explicitly mark
> > that we allow some amount of lines to be skipped, but otherwise be
> > strict and require matching line-by-line?
>
> This is a valid concern.
> What you suggest with "..." looks good.

I'd add just that for now. _not and _next might be useful in the
future, but meh.

> Another option is to follow llvm-lit conventions and add
> __jit_x86_next("<whatever>"), which would only match if pattern
> is on line below any previous match.
> (And later add __jit_x86_next_not, and make these *_not, *_next
>  variants accessible for every __msg-like macro).
>
> Link: https://llvm.org/docs/CommandGuide/FileCheck.html#the-check-next-di=
rective
>
> [...]
>

