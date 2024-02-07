Return-Path: <bpf+bounces-21423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E76284D14E
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 19:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74ED2B23251
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06010839F7;
	Wed,  7 Feb 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HC9O29e8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF945A4D4
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331180; cv=none; b=OytSZFvfHOnjRYguh1pp7lyRtBZOT4ZpjUsjtf1q1aBAa4FY5XolhT4A0JhxovXheatwnwdrilv1cT8y0/Q8ZrMT5a7PVmXUg/rA+pUAUeqzsWG4MfmWZ/pS+KSSn2J3JfimD2bM0c++CwmLVFa+bqP9texvhkaBFTMdMeq93H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331180; c=relaxed/simple;
	bh=+iArjslDp7rzId26Befzs/9RLzZdzGPiVIUXzwAAU2g=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQmi3WJuHky1lriWkzZ+BhD8+khb+rRyW67IKV2q3IVqgbIyzje58Vd4JJjii9rVWWwb2BBsIMPKhHxMM8FN48Z7X8BgCHIK5kq3gUJLge8FHnSLysnyR+2jgLHfn1nZYWJAgLPnkMR7r3XnLmhjxav3LDYc/GCn807ik/RTNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HC9O29e8; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bba50cd318so768509b6e.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707331178; x=1707935978; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrAbsT0EZ00gT6OWInQSNVdN560BkoUCoMaPJ98KcDc=;
        b=HC9O29e8z5dMGYcyU8aPXDmOob7jnpX/JYQC0p0qFpmOKVPnyhlcdliXERrWdAjAFq
         /42XMusl2e+WgU2RHjxyqZYtBrbAjSQ1PrgNd7jCcmwfJe9Vsc+n5uaKTSYM9URF9t/s
         dBIOJMNKWuq1fQc9vSvXL0REI8/Tpea+klDvD3/gD7PG/dJ08ZCfMP+CjnP9mPSzenpJ
         GF0BN432XW4OwwNKx2JvA29Qj3WobEA+olnlumZVaN0ip1mlclk9T4O1mV4qm0ANmVPB
         P4qlZwbZ8UfnlJXbUyvr/P2gqua99dF/wwN1GVR2jXHiofty3w0jBJUTUTd5o4dVW8Fp
         2IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331178; x=1707935978;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrAbsT0EZ00gT6OWInQSNVdN560BkoUCoMaPJ98KcDc=;
        b=bo3Lni3F6gAYYl2dep7ilDsOwiiyfjfoWUwMlf60XeCc/bpLdcGBFMvmNATalY4xcb
         lhbHMTHdfWoeZ0obi8sv+hc5INlJcVPtJFAS76WnK7kvYEgLjNVrrcDrcsL4iT1G7gB/
         AXjDuGZ8s38x+RSAbreoB0akUvdwWbjAs2PXRup0lnxyxzMg9XxcPt9yZ3NmxI6E6vAt
         ii9GJLR/GemVrIBDS4Lg0VWWI0MFwIitUh/6jbmmwwzG/26CkIEHXjt/I5tYq2j40kY9
         PQGQr6G3kosCrAnWJK1Yn+F5SMTqMwrf0cVZx8+BV2rL7nq3862u9NdnJ+xvTGxHyP7B
         ZvoQ==
X-Gm-Message-State: AOJu0YyCHlsGxaLsHlbo5vz01SPoUYOth/33lp1y47Shsa5RMZrlOvdk
	upc38NWL6J8Itb4RmrUVqoojT1tWpvan+bDPk+tm6swcukot27yj
X-Google-Smtp-Source: AGHT+IEIPVIsrUAlnIdEQSYUztKLl95tym+Y+az3x56nYHqaTEZaXDYosBqTfQVjjtrWdj0vJ3e7tA==
X-Received: by 2002:a05:6808:3088:b0:3bf:ee8f:556a with SMTP id bl8-20020a056808308800b003bfee8f556amr2325923oib.48.1707331177939;
        Wed, 07 Feb 2024 10:39:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcYkA0ZcIk2eWWvDOC3koweUSGBcPlB9pYPc65i9vBuKs8WEilFS1gdqOpl6EF6Ht7tXSk5mVDuqaSlL6GFCqWX/9lNlkyiX1eBlZGoFLt9EQKFR+Q05Wqc0QE8+Y=
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d26-20020a05680808fa00b003bed4bba856sm287426oic.13.2024.02.07.10.39.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 10:39:37 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>
Cc: <bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>,
	"'Jose E. Marchesi'" <jose.marchesi@oracle.com>
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com> <87wmrqiotx.fsf@oracle.com> <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com> <0d8301da591b$813d05a0$83b710e0$@gmail.com> <CAADnVQJUrLh91so59_4F7txVefPnp5mSongXpZAD0R1yvfq7JA@mail.gmail.com>
In-Reply-To: <CAADnVQJUrLh91so59_4F7txVefPnp5mSongXpZAD0R1yvfq7JA@mail.gmail.com>
Subject: RE: [Bpf] ISA: BPF_CALL | BPF_X
Date: Wed, 7 Feb 2024 10:39:34 -0800
Message-ID: <123001da59f4$ffebb2a0$ffc317e0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLEYKQbFH8DoKfsRCUXp0fT6URjgIX5UybAepfDAQBGtXGJAH4fYNCsOUVqkA=
Content-Language: en-us

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:=20
> On Tue, Feb 6, 2024 at 8:42=E2=80=AFAM <dthaler1968@googlemail.com> =
wrote:
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > On Tue, Jan 30, 2024 at 11:49=E2=80=AFAM Jose E. Marchesi
> > > <jose.marchesi@oracle.com> wrote:
> > > > > clang generates BPF code with opcode 0x8d (BPF_CALL | BPF_X,
> > > > > which it calls "callx"), when compiling with -O0 or -O1.  Of
> > > > > course -O2 is recommended, but if anyone later defines opcode
> > > > > 0x8d for anything other than what clang means by it, it could =
cause
> problems.
> > > >
> > > > GCC also generates BPF_CALL|BPF_X also named callx, but only if
> > > > the experimental -mxbpf option is passed to the compiler.
> > > >
> > > > I recommend this particular encoding to be specifically reserved
> > > > for a future `call REG' for when/if a time comes when the BPF
> > > > verifier supports some form of indirect calls.
> > >
> > > +1.
> > > Same thinking from llvm pov.
> > > CALL|X is what we will use when the kernel supports indirect =
calls.
> > > I think it means we need to add a 'reserved' category to the spec.
> >
> > My reading of this thread is that there seems to be consensus that:
> > 1) CALL|X should have an entry in the IANA registry with its own
> > conformance group,
> > 2) The intended meaning is understood,
> > 3) clang and gcc both implement it already with the intended =
meaning,
> > 4) The Linux kernel might support it someday.
> >
> > I'd propose we make it its own conformance group called "callx", =
which
> > of course the Linux kernel does not yet support, but clang and gcc =
do.
> >
> > Rationale:
> > * There may be other instructions reserved over time in the future =
so
> >    using a more specific name than just "reserved" is good since =
later
> >    additions require new groups with different names.

This also now makes me think we should probably rename the
"legacy" conformance group to "packet" for similar reasons.
It's the status (Historical) of the group rather than the name that =
actually
makes it legacy.

> > * Defining it now with the meaning already implemented by clang & =
gcc
> >    means that no changes are needed later once Linux supports it.
> > * ebpf-for-windows is likely to start supporting it in the very near =
future
> >    as a result of this thread. There is already a github pull =
request under
> >    review to add support for it in the PREVAIL verifier.
>=20
> All makes sense to me.
> Could you share a prevail pull link?
> I'm curious what it means to support it in that verifier?

https://github.com/vbpf/ebpf-verifier/pull/584

I don't know yet whether it will be accepted in the current form,
but the proposed approach is basically:

* Fail verification unless the register is known to always hold a single
   integer value at the time of the instruction.  This covers the common =
case.
* Using the single integer, do the same verifier checks as would have
   been done with the normal BPF_CALL instruction.
* It's only implemented for src =3D 0x0 so far since PREVAIL doesn't yet
   support src =3D 0x1 or 0x2 (there's separate github issues tracking =
those),
   but the mechanism for callx would be the same for those once they're
   implemented.

Dave


