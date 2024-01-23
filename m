Return-Path: <bpf+bounces-20130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841EB839B46
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475ACB2352D
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D363B78E;
	Tue, 23 Jan 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cbEwvJs5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C13984D
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046076; cv=none; b=YPpYt9LCfdM0TFTT+zkx1MugybVRwFR/Se1u1+KuEO/7Aw2nxXiasmHgzyeZUXqPMV5uC0hVBJFTA+p/khKb8ocnSmRxktpAxFXHF20/FqOL3zhtg9wSce4ap/45lYJ/I6iIHAVPOoRGV4d/wn8bp2YB8hNJD7ihn/aM7YmJ17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046076; c=relaxed/simple;
	bh=Le8/UeYfMaYPz8PA08WMlw+3dO3wmUrN6nDTi3nn3wQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VWcWLC4slSR/bN2G7Cz1+MZEy3o6OOt27WnkeCy6vJXwUzVp1QIGV8xd177oFBZsIZ+lSF4G830xY4tAewyeVgWpSeoEWsq8k3yjpZ82soYyfPWQoK9gJ6a166A32bElpo1QRVa2uUrbC4JgxVWxgyM7D0xcHhHpNrObcKTMU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cbEwvJs5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ddf05b1922so3603677a34.2
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706046074; x=1706650874; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7FLMHyPB0yGngUluQZ2X5jHRvGaiUZVT19xSHxw4Z8=;
        b=cbEwvJs5gKzUMiSuvJMKQQCkOhPVO7uXmPo1C1fASgJTiXry74YVhE2LgDVO9kMI3f
         NTj7bvHv+r0aEv2grDlQP613ns/um22eFoiRU1nlPFyBVIjLwwoIgvXM+6WLD3J1N5qZ
         6vT3PXVg+fJRYCMJbUodkBegmDc9Y5S6a/ybub1GQSNPbz4kFyYtL7ea8h4gOnkkTAdH
         5RarsxlPKShO6caTifPmdBVEs/FvcDnf7kmZS0sr5UtFvheOFCTZw1j+hyi4ipOvSJJ3
         hl55y8K54w3g+2+f8HgpFoytinz4eqJ/TAyQpZVqNivbSoBY+gJoFlH11UMSunn3BIS6
         vRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046074; x=1706650874;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7FLMHyPB0yGngUluQZ2X5jHRvGaiUZVT19xSHxw4Z8=;
        b=QAsV1mAxTsD3B3Uuy5zjqtG7P3R+l94QsQKOZ6kMgJuW8LBRRte8GVjbS77tnxY0QL
         XYMdTsoQ8+G6aYMvkP9CWi9VJ2Pu0FF+iUJ3CLZ/wzuoXc842FBx8gp6fd3ugp0CUv5N
         Z1WVhQET6pL7MgHrFnpyYbk5TTzT2Kue44H3TKTMoHufJTqlae9qv6/fPSEjhLJAVTsR
         d0UiI/qAn/ypu2tVPRpCQX9NqOGe10ltpZ7f3VpqHfikR1fx0+iqGLOOmWf6ds0dekkp
         NqVhLgu096Kv5+ugUiypmeHrbplatuXQDmrpRCQhi4qgmB2om6d5JUN+FgDEpNKkwZxF
         faEQ==
X-Gm-Message-State: AOJu0Yx56Vn8hk8R+FoIoBkiSLkgwTJynSl5C+RbNPFMzpYl9WBobPU0
	ZeVrktrTzkKrDCJqBy3cdT2STuUbJ2JXKx7JDxTdOIgwMq/BK79T
X-Google-Smtp-Source: AGHT+IHDa4h1k2Ef4tChn29gCdSowpX+0jMjXcxaOToTU/xlAXKeV7jx7cNKSXJrF+Hkpjb0ge9+Cw==
X-Received: by 2002:a05:6359:4599:b0:176:7284:8305 with SMTP id no25-20020a056359459900b0017672848305mr1970780rwb.20.1706046073625;
        Tue, 23 Jan 2024 13:41:13 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id c32-20020a631c20000000b005c259cef481sm10571793pgc.59.2024.01.23.13.41.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 13:41:13 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>,
	<jose.marchesi@oracle.com>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com> <20240123213100.GA221838@maniforge>
In-Reply-To: <20240123213100.GA221838@maniforge>
Subject: RE: [Bpf] Standardizing BPF assembly language?
Date: Tue, 23 Jan 2024 13:41:10 -0800
Message-ID: <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEMYhjceuFr/KIoMYEnffEkkY0NOwHLV0EHsnVpLvA=
Content-Language: en-us

> -----Original Message-----
> From: David Vernet <void@manifault.com>
> Sent: Tuesday, January 23, 2024 1:31 PM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org; jose.marchesi@oracle.com
> Subject: Re: [Bpf] Standardizing BPF assembly language?
> 
> On Tue, Jan 23, 2024 at 08:45:32AM -0800,
> dthaler1968=40googlemail.com@dmarc.ietf.org wrote:
> > At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
> > language (http://vger.kernel.org/bpfconf2023_material/compiled_bpf.txt).
> >
> > Jose wrote in that link:
> > > There are two dialects of BPF assembler in use today:
> > >
> > > - A "pseudo-c" dialect (originally "BPF verifier format")
> > >  : r1 = *(u64 *)(r2 + 0x00f0)
> > >  : if r1 > 2 goto label
> > >  : lock *(u32 *)(r2 + 10) += r3
> > >
> > > - An "assembler-like" dialect
> > >  : ldxdw %r1, [%r2 + 0x00f0]
> > >  : jgt %r1, 2, label
> > >  : xaddw [%r2 + 2], r3
> >
> > During Jose's talk, I discovered that uBPF didn't quote match the
> > second dialect and submitted a bug report.  By the time the conference
> > was over, uBPF had been updated to match GCC, so that discussion
> > worked to reduce the number of variants.
> >
> > As more instructions get added and supported by more tools and
> > compilers there's the risk of even more variants unless it's
standardized.
> >
> > Hence I'd recommend that BPF assembly language get documented in some
> > WG draft.  If folks agree with that premise, the first question is
> > then: which document?
> 
> > One possible answer would be the ISA document that specifies the
> > instructions, since that would the IANA registry could list the
> > assembly for each instruction, and any future documents that add
> > instructions would necessarily need to specify the assembly for them,
> > preventing variants from springing up for new instructions.
> 
> I'm not opposed to this, but would strongly prefer that we do it as an
extension
> if we go this route to avoid scope creep for the first iteration.

If the first iteration does not have it, then presumably the initial IANA
registry
would not have it either, since this iteration creates the registry and the
rules for it.

That's doable, but may continue to proliferate more and more variants
until it is addressed.

If it's in another document, do you agree it would still fall under the
existing
charter bullet about "defining the instructions"
> [PS] the BPF instruction set architecture (ISA) that defines the
> instructions and low-level virtual machine for BPF programs,
?


> > A second question would be, which dialect(s) to standardize.  Jose's
> > link above argues that the second dialect should be the one
> > standardized (tools are free to support multiple dialects for
> > backwards compat if they want).  See the link for rationale.
> 
> My recollection was that the outcome of that discussion is that we were
going
> to continue to support both. If we wanted to standardize, I have a hard
time
> seeing any other way other than to standardize both dialects unless
there's
> been a significant change in sentiment since LSFMM.

If "standardize both", does that mean neither is mandatory and each tool
is free to pick one or the other?  And would the IANA registry require a
document
adding any new instructions to specify the assembly in both dialects?

Dave


