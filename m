Return-Path: <bpf+bounces-56763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB75A9D6B4
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 02:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81651899728
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD61E1DEB;
	Sat, 26 Apr 2025 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IROMo4Un"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D5189902;
	Sat, 26 Apr 2025 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745627572; cv=none; b=bpc85WjCym66dML8/0y/zkrh3Ctu3jc/5aEEot+SnbdW4gMeIq9jRbkKAWa3G/K3nX3nYd88eSWJjuv2BVMVRWB/2kiiMZIX8F4dtEf4p3FREq5qh5rQX7szfGw90wRoDDoHnoJOEaLUHG/5LZ8cBLfpWD3vzibeU3lKvABQHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745627572; c=relaxed/simple;
	bh=jxFM2/MdYLgqKQn325343jF0av7/eQ9QvB7wBi232P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leZPRxd8lYc9E9hhmB/bT+sooqIwVRHIrS3LX5IJPWl8w9moR/Z7XbYPiHSHT0C2aqKsphcjMStBnubwlvC3yv4elxoUCxN5SLAMfWzRpQEU7V+Hemd5Pwp6cZ/SuQna74nqqeagGUG0vjqwh5pl/oMODtdckly4CEdzAtn1q94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IROMo4Un; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso1828425f8f.0;
        Fri, 25 Apr 2025 17:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745627569; x=1746232369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mChKlW8gPH2BaMRaNQEH7MVPD51hIovVMJniZVEmEuU=;
        b=IROMo4UnEVtVyJyOWlGes0AvVYcI8bhmMh7tL3dJTjip4cf7fN/FlTA8JOBuMGS8Nv
         kxd+3J2bDLL59/DNQSziFL+zoSQQKpmGYBMYCC6NNZxnjbdQ7vWkHVbER++xr8QDrvYL
         N84pgvsSSbk3cbFNXNFG46UwNmC/3Vuka4Zi10Lfxb4a1DiSUxWCOZzmb2Z2cHbtbVSK
         eCGPOuimkL1mhXf98iLs1pMPy5UEkRwgMlGM2oLFozCHKanKHM53+3ICgglTNJHUBngE
         qBdAr8B7rw/OZXJddHEgST9XTgm0DtfDXTNnwYYHNR9Ush4SeoOvfk57hEP+6F25Z4vI
         /XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745627569; x=1746232369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mChKlW8gPH2BaMRaNQEH7MVPD51hIovVMJniZVEmEuU=;
        b=Y1cDaRiFg1EKCAJ7kxgZgGF6LbfseUfH5qYs+OOqmwat8pxSuAmcaJBrSfBqxJAH4t
         13rSbO2JVgFhz15bqh6rIuPpFPeotBnVcRm8atSa54JE2zAdleS8pL/99CsUAQu/n5VF
         xyob4JU5VSdTl12tpShKcMtEu7YzhddqBwu+n1mr1IlnRCBKBHimTSyV48ygta5nC6pP
         Cl5vh4pwbw3UMAmrQbyNR8UuN7XRsZPFHpm7JHvP0XPUkm0ttAlb/s1Rnt8FMEdaAQas
         sRFFmKVdE82nZTJydltqKrMTHsu889gWn69XO0+yt53IH90ZIMrV7dWwFEwg37m68M+g
         GQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCXH566F++JOdP6VMghAZfx3WEc8VclJ25Wfj8HGtXXG/O0f1CjmzkDXCYLexCu28Jg1ugo=@vger.kernel.org, AJvYcCXxC2/++Lo2AVopG4BiUW9DhK4+muPQ6w7aINo+oZZ/FbJsl3/0Jn1Lqhk3tRSsNfqTl94mGUWK@vger.kernel.org
X-Gm-Message-State: AOJu0YynIgfSoQAkhkJ/mRs8emqz+rLE+KEaxeTa8LApMUZF8deUnSR7
	tFggBsAB4frOcm9g3WJvq2YjGbHWr4W/7fkOR+U0rQbNOCeR8+m7qm1vB1ukGy4W64g1kRbUKg2
	425uzaIN8l63gyz8iiIb2VjdPQFQ=
X-Gm-Gg: ASbGncvhaho0izPtYEHWrSaudAFV6D1faBP7qBwy80YeEELjzUyairnNlnOKIDM6Q3B
	qZHtvY0vBZJsTqHGlImQ+4ck/M9aTcPn7wU3PtZ4k9sKSQ+H+eV5C/FWPe71UfN1b+ag66MrvcP
	Z4xAZ2Zoqs9NGfXDx+sX6BIah1bQlhUyMxpt15kMDFb/+r/ogQ
X-Google-Smtp-Source: AGHT+IFVMzGpnK3lEhfZ0UfTv0+bsPojvQakKf3hxfZxdtXJSRWyvPF9LEo5PskUoqv/mBNTYxBgLXO03TI+mmiqmDQ=
X-Received: by 2002:a05:6000:118a:b0:391:2b11:657 with SMTP id
 ffacd0b85a97d-3a07ab9bd84mr637240f8f.38.1745627568859; Fri, 25 Apr 2025
 17:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424165525.154403-1-iii@linux.ibm.com> <174551961000.3446286.10420854203925676664.git-patchwork-notify@kernel.org>
 <CAADnVQL2YzG1TX4UkTOwhfeExCPV5Sj3dd-2c8Wn98PMsUQWCA@mail.gmail.com> <20250425-artichoke-dove-of-reward-6e3ca2@lemur>
In-Reply-To: <20250425-artichoke-dove-of-reward-6e3ca2@lemur>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Apr 2025 17:32:37 -0700
X-Gm-Features: ATxdqUFCMFWDjyytxkh42zUHYgRBEDi-WKI9CJ-Qy0vAnncpQsTlcm1zfKI5flg
Message-ID: <CAADnVQ++W2vQTZgzQk4Ruj7E68DcA4WS=q=GV-dF4kTvcJd83g@mail.gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:58=E2=80=AFAM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Thu, Apr 24, 2025 at 11:41:16AM -0700, Alexei Starovoitov wrote:
> > > On Thu, 24 Apr 2025 18:41:24 +0200 you wrote:
> > > > Hi,
> > > >
> > > > I tried running the arena_spin_lock test on s390x and ran into the
> > > > following issues:
> > > >
> > > > * Changing the header file does not lead to rebuilding the test.
> > > > * The checked for number of CPUs and the actually required number o=
f
> > > >   CPUs are different.
> > > > * Endianness issue in spinlock definition.
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - [1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
> > >     https://git.kernel.org/netdev/net-next/c/4fe09ff1a54a
> > >   - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less tha=
n 16 CPUs
> > >     (no matching commit)
> > >   - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declarat=
ion
> > >     (no matching commit)
> >
> > Hmm. Looks like pw-bot had too much influence from AI bots
> > and started hallucinating itself :)
>
> Looks like it's a mix of bad assumptions and the usual difficulty of
> recognizing fast-forward merges that came in through a different tree.
>
> If you look at the commit mentioned above, it has:
>
> | Note that the first patch in this series is a leftover from an
> | earlier patchset that was abandoned:
> | Link: https://lore.kernel.org/netdev/20250129004337.36898-2-shannon.nel=
son@amd.com/
>
> This confuses the bot into thinking that the linked message is the source=
 of
> the patch (which is why we started using patch.msgid.link to disambiguate
> links aimed at cross-referencing and links aimed at indicating commit
> provenance -- but we aren't relying on this disambiguation in the bot its=
elf
> yet).

Thanks for investigating. The above part is clear,
but I still don't understand what was so special about Ilya's
patch that only his first patch in the series became a victim.
msgid-s are completely different.

> The other replies are the usual mess when fast-forward tree updates confu=
se
> things. It's a long-standing hard bug to fix.
>
> I am going to re-enable the bot for now -- in general it's not any more w=
rong
> than usual.

Makes sense. Better to have it flaky than none at all.

> I'm scheduling some time next week to try to tackle the
> fast-forwards problem.

Thanks. That would be great.

