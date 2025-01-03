Return-Path: <bpf+bounces-47853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D90A00E6A
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 20:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CE27A1CB3
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D2E1FC111;
	Fri,  3 Jan 2025 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1L1NKwz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5681A8F80
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735932523; cv=none; b=rFTKZes7lbM76OYvRX0RD2R6z/wenZKEcxa83/CLQwQNK34bX6RFeeZbLO7LHMJxrPQPc38b3UjEXAzOJ76hc3B1QXQdpxQ6OvmzAtWJwI/Qo8ALdouxgLWZ6AM/G5ZxIWd946kndQVqkFzH16ZDn1UEfI52raSbn5go3xkOqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735932523; c=relaxed/simple;
	bh=Bjcc5w9StM2BFcMJFRJoHnwoiGbwCz4E5MbyWuAWsx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgVFeuaPSSZ03v9gMQ8ETXq4wF45qY6p1unhdSo5M3gPqtUsRMPG9mw0nyctMBD6jQ2f2onyOqjUbVoXQKQuJ03lY/qKrz4l6lcM8wLKlJftGgcvMehxywf8QBhnDBJujtrCQ8i86NA7KI/BfD38LW37KIvogkU7R1TtJ258IfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1L1NKwz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so4716795e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2025 11:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735932519; x=1736537319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKiGt/2T0jZG8bldSLAf8j9ZXczlh2JxIZGUn6eJBCw=;
        b=h1L1NKwzvL2e3nocG9r4eRB8/Rjiuowp3ul4KtLZKtscG0c9HcShXWdOrnkS+DJC60
         iwFC1evtVohnBEq9scnRPKdLlzWOXfYDmUyEDPcAGqv0MycnBT1erIx2A6xwBrcQgLXw
         2J3DTAeMn+Rd03oK9k9EsCYddwzTjkZ2+D5XDknGdCmlbbhXlTTWBrVaeKiWfI/SGh17
         dX+SiHq0jZSnqRqKcRM7ULbqb2b911FxnBedjiyrvr/MZUzL1N121hjeX6LPtirMsdHx
         W35ObKSuLd3X7s+0l6GKckW+c/YShqO9O42RKVtK5Gz8USiRPYNqO0pO/y2Ig663i9YX
         +5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735932519; x=1736537319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKiGt/2T0jZG8bldSLAf8j9ZXczlh2JxIZGUn6eJBCw=;
        b=g5idV3vtRkiIk5E47MBxUH9pDKlXGMcZ8konqtdGBMT0kXonhxjHTdevS+rDPltWK8
         8fTqd4sQgivwHKUuub+KDtC2f2qgC3DhEIo+PZUfLyW0K73BGrBVIAO6RbtCfFAiWTPd
         +dsSW2DKSgw3dlbyNBoMpzhRlryST5zfFrUU75S3Np7I8s7689+nzNakLRUGrw57w2jq
         cxnt434vr6Oj/gy2yL+0RtBVEYpJI174RGMcC2543mRKbcz7jWYjFtSKMenQ+RGnrkeY
         yCjHg+iEPtc7ApKu9N1tP1pNsMipo6qXmmWW1VGUCl4waWM91bpkCzsJwkichltiV5qF
         eY8w==
X-Forwarded-Encrypted: i=1; AJvYcCU2CZPT24j21lpJmQE6oGj8D/h7/Oy2KVFJ3m2lYgLt2eC1hIpO+aKuvdrpBj5V0hfI2qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVINjY78gSNieJ3mTyyM3Xs8LclQv+nPYcrCfSOQDKO0CgMikF
	FhcZmcrBawKvq6YKIAPxH6qdmHESkhmL71DBeG/lNxdpUtt7KjJ9xcGzKYkQV8DhMxW45K/rnVP
	L1WHQK1bEm3019XFwjSgw5SKuE9U=
X-Gm-Gg: ASbGncsO5pr1IRPto1bnc48n6qdKUWHqLxupGCSJq+t+uhXiLH3rVEd2rjQYmEm+DNN
	Yvzx9T8MJLM7NXg4dDI6FhmILgvIBu/KRDfncN+fDU99kZ+qE1qLdrkQ75GWz08T3+VfEEw==
X-Google-Smtp-Source: AGHT+IFCNmRhSZU3Akm96JOxELI6iRCgqldvcwEC81e1O32dsh93lT/1cTDQuqmGh8coNlVkVvZZV7ZDOrXPG/7vztE=
X-Received: by 2002:a5d:5847:0:b0:38a:2b34:e13e with SMTP id
 ffacd0b85a97d-38a456cbf49mr20325218f8f.18.1735932519353; Fri, 03 Jan 2025
 11:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com>
 <20241220140058.GE17537@noisy.programming.kicks-ass.net> <CADxym3Z5GKJB_+m4iyw-Ycy98usMvwHr6jBwW_zBiwX+mdPW5Q@mail.gmail.com>
In-Reply-To: <CADxym3Z5GKJB_+m4iyw-Ycy98usMvwHr6jBwW_zBiwX+mdPW5Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Jan 2025 11:28:28 -0800
Message-ID: <CAADnVQJct=ANAmXCSancBjm7k7uThEOau3u_e8Pe3Mf9jrDzYg@mail.gmail.com>
Subject: Re: Idea for "function meta"
To: Menglong Dong <menglong8.dong@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 7:25=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Fri, Dec 20, 2024 at 10:01=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Fri, Dec 20, 2024 at 09:57:22PM +0800, Menglong Dong wrote:
> >
> > > However, the other 5-bytes will be consumed if CFI_CLANG is
> > > enabled, and the space is not enough anymore in this case, and
> > > the insn will be like this:
> > >
> > > __cfi_do_test:
> > > mov (5byte)
> > > nop nop (2 bytes)
> > > sarq (9 bytes)
> > > do_test:
> > > xxx
> > >
> >
> > FineIBT will fully consume those 16 bytes.
> >
> > Also, text is ROX, you cannot easily write there. Furthermore, writing
> > non-instructions there will destroy disassemblers ability to make sense
> > of the memory.
>
> Thanks for the reply. Your words make sense, and it
> seems to be dangerous too.

Raw bytes are indeed dangerous in the text section, but
I think we can make it work.

We can prepend 5 byte mov %eax, 0x12345678
or 10 byte mov %rax, 0x12345678aabbccdd
instructions before function entry and before FineIBT/kcfi preamble.

Ideally 5 byte insn and use 4 byte as an offset within 4Gb region
for this per-function metadata that we will allocate on demand.
We can prototype with 10 byte insn and full 8 byte pointer to metadata.
Without mitigations it will be
-fpatchable-function-entry=3D10
with FineIBT
-fpatchable-function-entry=3D26

but we have to measure the impact on I-cache iTLB first.

Menglong,
could you do performance benchmarking for no-mitigation kernel
with extra 5 and extra 10 bytes of padding ?

Since we have:
select FUNCTION_ALIGNMENT_16B           if X86_64 || X86_ALIGNMENT_16

the functions are aligned to 16 all the time,
so there is some gap between them.
Extra -fpatchable-function-entry=3D5 might be in the noise
from performance point of view,
but the ability to provide such per function metadata block
will be very useful for all kinds of use cases.

