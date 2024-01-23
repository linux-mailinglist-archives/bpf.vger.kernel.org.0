Return-Path: <bpf+bounces-20140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2DC839D19
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945701F2B56C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB953E2F;
	Tue, 23 Jan 2024 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mi9kN+v/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DFD54BE5
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051714; cv=none; b=TiBkh/9i7SyywFSGHBJLc3NJPetkguyItlYV4n1RgCoafZX/G+jkF3tFjF/5P6TIl20I3CNOU5dkvONOzqKPSzGVeaQ3qCw/34yS8pzCDUvwdCqCfEZhRq8JIQSdOrdtY6XJvAwbPh9IWos35l7YSUl5XyejqzBFrKb/j2wdXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051714; c=relaxed/simple;
	bh=N5ADeftqseBrcgSLlicxZQo1UcSmTEkh+DCoUzs8cH4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCCm7fz9bqyftHqMHgg9ZLCCV/zZ4zjnBsox/Hkz7RH5wmJcujnDrzc99fdX4I75J9u0N5wQi3pYWoATKQlwMop5iQ79q1x+0h5THbi9bnwkksBKivwt2hy+QyJGkbworXNxAt4rhpHwPxXIFHuXWm+Iz4nolgrK7M6YXpfe2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mi9kN+v/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dd853c1f80so504127b3a.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 15:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706051712; x=1706656512; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZsPWFi0DkghszaEQJ3umNHAJEjOSzjsjB52xKFrixo=;
        b=mi9kN+v/IoTJmuTlxDQP13Dx8RlO1+a1hAbHF9hrfn3A59c4yceHX9KubO4KbETzxH
         sio5Gv7/RRCNdBUoAN56rUQoFZaZzojw1ClxkNvKkQWmAaBTExDY6zXkeD+rfUyAsV+N
         PO9OvmBWx1GKr95svPWoD1hi6iyqt4U/sbwtR5Z9KFt5jpJFwJvV6gunvamf8DDITbvV
         qBolto9u45D/yx6vCUwu4ACoshEE2sASHv9IUVG00sU6LgLmqQVidH15Ok8/fQCpQMRk
         HBNuVDwxMM1JGMuEj8m/1SB87Fqdj4aWA8QASF2FzDHDzw/A555tO8r98xDcP05OdEHd
         FlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051712; x=1706656512;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZsPWFi0DkghszaEQJ3umNHAJEjOSzjsjB52xKFrixo=;
        b=UXLijhFTSC0SOh1BNubmtMAWjtshzkiE8Lnb+oJrfLPCike0MLvq5Jv5kwRJfdWlix
         bzjI43i/Z/DILg2jGljCSU3qXeAHOTWBRnRD2XH2cly8RtBRrRtcmuaT4xSVXKRU/bAl
         uTrbsEJ5RStue5r8X9PGoewyYU9QAa/VdBXbfwbZMjY3WbN2DpJsaC9ygqsX8P1/5zCz
         fO6c8CT2ZqHP2tEeMsSptzLsJLhR4tFKwa+aHfBKKuaMKYirSOBUVrJqU+NgDv41TaSW
         g4Updt6Zn9HYPI8g43kvfCTwJIq7GiYqZoXnt2r+aRqOJbggZk8JAQlL5V/eyTvIbRda
         bSeg==
X-Gm-Message-State: AOJu0YxX2DL+5nw8XmYwFPD7QKiEZqui9wtD8CTqUH0lEGsEZS8aq9TE
	f0pmtxb5Hal+YONWH/CmFxoOe/yfWuAR3r+QoZ1Yt1NGDqscYD9EwEwXBS+qFUU=
X-Google-Smtp-Source: AGHT+IGzfsXIQbLrPPJkFRU/fb/bmorOZSGrsZfqVMXM/+L3Ts2mtlFXug10aZ0MenlYaPp7Mbw0ng==
X-Received: by 2002:a05:6a00:b95:b0:6db:d315:3781 with SMTP id g21-20020a056a000b9500b006dbd3153781mr419483pfj.20.1706051712383;
        Tue, 23 Jan 2024 15:15:12 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id y137-20020a62ce8f000000b006dd7ae4cd1fsm2031313pfg.49.2024.01.23.15.15.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 15:15:12 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	<dthaler1968@googlemail.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>,
	<jose.marchesi@oracle.com>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com> <20240123213100.GA221838@maniforge> <1e9101da4e44$e24a1720$a6de4560$@gmail.com> <20240123215214.GC221862@maniforge>
In-Reply-To: <20240123215214.GC221862@maniforge>
Subject: RE: [Bpf] Standardizing BPF assembly language?
Date: Tue, 23 Jan 2024 15:15:09 -0800
Message-ID: <1f6101da4e52$032b11d0$09813570$@gmail.com>
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
Thread-Index: AQEMYhjceuFr/KIoMYEnffEkkY0NOwHLV0EHAKl61oMBPW6XvrJmTNEA
Content-Language: en-us

> -----Original Message-----
> From: David Vernet <void@manifault.com>
> Sent: Tuesday, January 23, 2024 1:52 PM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org; jose.marchesi@oracle.com
> Subject: Re: [Bpf] Standardizing BPF assembly language?
> 
> On Tue, Jan 23, 2024 at 01:41:10PM -0800, dthaler1968@googlemail.com
> wrote:
> > > -----Original Message-----
> > > From: David Vernet <void@manifault.com>
> > > Sent: Tuesday, January 23, 2024 1:31 PM
> > > To: dthaler1968@googlemail.com
> > > Cc: bpf@ietf.org; bpf@vger.kernel.org; jose.marchesi@oracle.com
> > > Subject: Re: [Bpf] Standardizing BPF assembly language?
> > >
> > > On Tue, Jan 23, 2024 at 08:45:32AM -0800,
> > > dthaler1968=40googlemail.com@dmarc.ietf.org wrote:
> > > > At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
> > > > language
(http://vger.kernel.org/bpfconf2023_material/compiled_bpf.txt).
> > > >
> > > > Jose wrote in that link:
> > > > > There are two dialects of BPF assembler in use today:
> > > > >
> > > > > - A "pseudo-c" dialect (originally "BPF verifier format")
> > > > >  : r1 = *(u64 *)(r2 + 0x00f0)
> > > > >  : if r1 > 2 goto label
> > > > >  : lock *(u32 *)(r2 + 10) += r3
> > > > >
> > > > > - An "assembler-like" dialect
> > > > >  : ldxdw %r1, [%r2 + 0x00f0]
> > > > >  : jgt %r1, 2, label
> > > > >  : xaddw [%r2 + 2], r3
> > > >
> > > > During Jose's talk, I discovered that uBPF didn't quote match the
> > > > second dialect and submitted a bug report.  By the time the
> > > > conference was over, uBPF had been updated to match GCC, so that
> > > > discussion worked to reduce the number of variants.
> > > >
> > > > As more instructions get added and supported by more tools and
> > > > compilers there's the risk of even more variants unless it's
> > standardized.
> > > >
> > > > Hence I'd recommend that BPF assembly language get documented in
> > > > some WG draft.  If folks agree with that premise, the first
> > > > question is
> > > > then: which document?
> > >
> > > > One possible answer would be the ISA document that specifies the
> > > > instructions, since that would the IANA registry could list the
> > > > assembly for each instruction, and any future documents that add
> > > > instructions would necessarily need to specify the assembly for
> > > > them, preventing variants from springing up for new instructions.
> > >
> > > I'm not opposed to this, but would strongly prefer that we do it as
> > > an
> > extension
> > > if we go this route to avoid scope creep for the first iteration.
> >
> > If the first iteration does not have it, then presumably the initial
> > IANA registry would not have it either, since this iteration creates
> > the registry and the rules for it.
> >
> > That's doable, but may continue to proliferate more and more variants
> > until it is addressed.
> 
> The same could be said for any new instructions that are added while we
sort
> out standardizing the assembly language as well, no?

Yes, that was my point.  If the initial ISA spec at time of publication
includes the
assembly language then there's no issue.

Not saying we have to wait, just that this which document to put it in is
what the WG should agree on in my view.

> > If it's in another document, do you agree it would still fall under
> > the existing charter bullet about "defining the instructions"
> > > [PS] the BPF instruction set architecture (ISA) that defines the
> > > instructions and low-level virtual machine for BPF programs,
> > ?
> 
> I wouldn't say it's illogical to group assembly language in this bucket,
but I
> would say that defining the assembly language does not need to be tied at
the
> hip with defining instruction encodings and semantics. So my answer is
"yes, I
> think it belongs here", but I also don't think it's necessary or desirable
for the
> first iteration.
> 
> > > > A second question would be, which dialect(s) to standardize.
> > > > Jose's link above argues that the second dialect should be the one
> > > > standardized (tools are free to support multiple dialects for
> > > > backwards compat if they want).  See the link for rationale.
> > >
> > > My recollection was that the outcome of that discussion is that we
> > > were
> > going
> > > to continue to support both. If we wanted to standardize, I have a
> > > hard
> > time
> > > seeing any other way other than to standardize both dialects unless
> > there's
> > > been a significant change in sentiment since LSFMM.
> >
> > If "standardize both", does that mean neither is mandatory and each
> > tool is free to pick one or the other?  And would the IANA registry
> > require a document adding any new instructions to specify the assembly
> > in both dialects?
> 
> Well, if we're standardizing on both, then yes I think it would be
mandatory for
> a tool to support both, and I think instructions would require assembly
for both
> dialects. Practically speaking that's already what's happening, no? Both
dialects
> are already pervasive, so it seems unlikely that a tool would succeed
without
> supporting both regardless.

There's plenty of counter examples of things that exist (whether they
"succeed"
or not depends on the definition of succeed) that support or supported
neither.
E.g., uBPF prior to Jose's talk.

> To Jose's point (pasted below), there are of course drawbacks:
> 
> > - Expensive :: it makes it very difficult to reuse infrastructure.
> > - Problematic :: dis/assemblers, CGEN, LaTeX, editors, IDEs, etc.
> > - Ambiguous :: with both GAS and llvm/MCParser: symbol assignments.
> > - Pervasive :: because of the inline asm.
> 
> I think it would be a lot simpler to standardize on only a single dialect,
but I also
> think the standard should reflect how BPF is being used in practice.

Dave


