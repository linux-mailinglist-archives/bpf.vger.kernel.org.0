Return-Path: <bpf+bounces-21386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C684C248
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 03:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EEAB2B317
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D20DDC1;
	Wed,  7 Feb 2024 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dphcRb6Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB5DDB3
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271920; cv=none; b=IG8XJgSi2/cTmwKbOJ9G3lyqbAHm+GSzq0sr8oQM3Rtj0UNp08rjDZ845t1wKuLyKfDBoufAUnUJRWbq0zcNoUDwVIwmfTZ2HLJsZlhk7oHTzv3k6Vifyy8XLMGu3mnstGDkTtGqiODmkwOMwIKCT3zXsWLycjLVZznE6vKUX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271920; c=relaxed/simple;
	bh=zGoZub+Exxi+FM/aVWaN5wygaNDMchQ3SK5krOpHFng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rp9rsrvzqhrPaUXp46NRm4E/jRDZPAP6i02KTyemnvshQRG5jJsuevWv4e7mHiuF2cIhDZ9Bna/iXqB/72Rctgmv/CpgIYykkP0+m6eqe7NBOqFXGYETywrijWZ/5FzHHCcHQ8kTTuNwm8jQEyJABps7NxXIms2uJkmPl1KDrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dphcRb6Z; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b29b5ea86so99177f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 18:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707271917; x=1707876717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SEHEUNvhqJwK6/Tus4sUiPtU6RclW7cz5I6oxUd24I=;
        b=dphcRb6ZmId37cSAVcQt/hVxoUK/jJoD5IE9Ai4dW1LlvSZWCIns+Mo29xqCxDAKNc
         wyS/Pbrh2i1kQiPN4P8nvYQTnNnQge0f4eb69dQVtsilYDN3Ln435IwMdDY6+S35wwRc
         KBvwC+6AsR7UO5VR+fnQVxy4OOC36gLZocwpnHydAtxgHlU6exl1mV8wpd/M8Dd0t1t7
         UzYiyytJrBp7bF9LwJQM4eWexAYH0b6nWAn3rnSXXyFS+v1zHSCz23fwqZgAtniwfCl5
         wB7x2TMf9WDRDhZUgWRR450MDg5VkW0abzpHfRMDz84mkJbX56+4eN8zGYADqlnZ25CM
         3FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707271917; x=1707876717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SEHEUNvhqJwK6/Tus4sUiPtU6RclW7cz5I6oxUd24I=;
        b=Lb01wTAvnGmtzu11i3zEGGHZIdJHZYryPJ5ZruPQdZRRQL418lIxAHDNLtQbGHY3O/
         PACWu0nmgA5vPYjpT5qxSMmVdcgiL3WvfrnZFHtt85gplYAd5a6xk9CONooxMSpB0Qxa
         S3L+1DxXIqXc5HrmI4Zv/IQy1hNWP8rRLeW2YuxV+Wm1l3s0MngyE7Qx4u5Do9SsxnnB
         eQtNS4SVZ/SRBMBeDl6Bg3YqkAWGaU2YRWClFaMvfPSswAKyJ2Hq+ncDsN4K3xtcXM7a
         dPONQ5lV5ZiniKUwOkU4cvdkX6xWPGli/moyyXpewDLxLyWgDVPWyXE7xkysRipPrxl+
         /Ecw==
X-Gm-Message-State: AOJu0YyEqEtarTgBoB055WCYbOtzfVLqpYirDw+WX2D9y96+1UUbTqZW
	V0LetHbBzA8vkLetRdMquJb5zJ+g8iayHMsLICaqNy/d+SUajiFEl1wIA2KrrWAihC6DAjY/9IA
	mfYNaeZcf2vxj3K4aqckKVyeS2Ng=
X-Google-Smtp-Source: AGHT+IHWxRyU7SSfyjNbfwwbAjXdZnqDPnxUOdhFythjw6BU/kCMiJfQUeZV8uoEIfwV7mDORzrgfBhR4+pIkiFhMiM=
X-Received: by 2002:adf:ce8b:0:b0:33b:4d5e:ace4 with SMTP id
 r11-20020adfce8b000000b0033b4d5eace4mr516863wrn.36.1707271916411; Tue, 06 Feb
 2024 18:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com> <87wmrqiotx.fsf@oracle.com>
 <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com> <0d8301da591b$813d05a0$83b710e0$@gmail.com>
In-Reply-To: <0d8301da591b$813d05a0$83b710e0$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Feb 2024 18:11:44 -0800
Message-ID: <CAADnVQJUrLh91so59_4F7txVefPnp5mSongXpZAD0R1yvfq7JA@mail.gmail.com>
Subject: Re: [Bpf] ISA: BPF_CALL | BPF_X
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 8:42=E2=80=AFAM <dthaler1968@googlemail.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Jan 30, 2024 at 11:49=E2=80=AFAM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> > > > clang generates BPF code with opcode 0x8d (BPF_CALL | BPF_X, which
> > > > it calls "callx"), when compiling with -O0 or -O1.  Of course -O2 i=
s
> > > > recommended, but if anyone later defines opcode 0x8d for anything
> > > > other than what clang means by it, it could cause problems.
> > >
> > > GCC also generates BPF_CALL|BPF_X also named callx, but only if the
> > > experimental -mxbpf option is passed to the compiler.
> > >
> > > I recommend this particular encoding to be specifically reserved for =
a
> > > future `call REG' for when/if a time comes when the BPF verifier
> > > supports some form of indirect calls.
> >
> > +1.
> > Same thinking from llvm pov.
> > CALL|X is what we will use when the kernel supports indirect calls.
> > I think it means we need to add a 'reserved' category to the spec.
>
> My reading of this thread is that there seems to be consensus that:
> 1) CALL|X should have an entry in the IANA registry with its own conforma=
nce group,
> 2) The intended meaning is understood,
> 3) clang and gcc both implement it already with the intended meaning,
> 4) The Linux kernel might support it someday.
>
> I'd propose we make it its own conformance group called "callx",
> which of course the Linux kernel does not yet support, but clang and gcc =
do.
>
> Rationale:
> * There may be other instructions reserved over time in the future so
>    using a more specific name than just "reserved" is good since later
>    additions require new groups with different names.
> * Defining it now with the meaning already implemented by clang & gcc
>    means that no changes are needed later once Linux supports it.
> * ebpf-for-windows is likely to start supporting it in the very near futu=
re
>    as a result of this thread. There is already a github pull request und=
er
>    review to add support for it in the PREVAIL verifier.

All makes sense to me.
Could you share a prevail pull link?
I'm curious what it means to support it in that verifier?

