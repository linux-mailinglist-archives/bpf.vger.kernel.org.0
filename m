Return-Path: <bpf+bounces-20873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4592284496B
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 22:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FFF1C22EC5
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA36738FB6;
	Wed, 31 Jan 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hXO34L1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8380208C1
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735257; cv=none; b=P0DiTi21W5X7kHAdgg2D8+SCvQMSd6Yy2L+mhaPVUvvijL5tHW8VmEIi2tB3qfXoEj92pCanIvC/wZKTAXL4u8XKYN0EjHic46XIzSTmc3GhzZbd4hpNsPtZWp0umwryeRyOGPOJl7alFp5FVzQzYz0lpdGikJUZHL0CwhJ5Pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735257; c=relaxed/simple;
	bh=EKgNokRofw0YCmZPOEBcQo7n38JXQ3eozJ+Gm/CQyeQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=sCIybz7FKYF7XAB+IoMNjcFSPGVmwhqoMz35yb+2SuAljvet9WypRre+AzQjd7GdIHRKnWNxm33Vh2l4n4uXPOZ+1ianLlcxfU9YwDUlB7f3+3/qZYYnHeWHhMvx+1JKJSLZnxe4OqG96wMfQws29s2NPkYoa6v5pdgv2kbKlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hXO34L1M; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d918008b99so1825945ad.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 13:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706735255; x=1707340055; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw1LX+ZFVIgrafnYqjC0jzokl66M1v8G3kvRIrEAPI0=;
        b=hXO34L1MQlrUcblM009CQGZPCS5T+KQDjucN9CV+iiyGnWwNibOB8Js974ytk08mNb
         obxqgPDReV4Bn8oA4z1CUZ/PlEtU0olMOX9W8ve926URQkoda+uCVWP+7OiNeldt2XbN
         qSzFQiEUzD1BIWPxi++V+lur56gXr8jb3M52vuUpX/O7Lf2Q2E9PGdPYxi3Vw8fxpOCJ
         pMQjqo3IaeB91HVLLikPNKXmenx9XgMCurTsYpMMg8vqbuKVAfRYnetaQAolUC/E7TD6
         Gfk0OKTlXK5SAc3d19I9y5GEKyMZjy6P/VWrnEzf5VSniLrnOepua3KLPWvRL5rJvQmh
         DrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735255; x=1707340055;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw1LX+ZFVIgrafnYqjC0jzokl66M1v8G3kvRIrEAPI0=;
        b=PbOESS49L3WihqBR3nF7wdod0cXO3WAF1EYBPpv9kl1UNn0sjvFYXSfcOHn4Noh98L
         RgS3H1HelS4XkjsJNHpG4MLK4TTLRs7Q+wmCj23GzUvW+nwYh5/20BI1v/B5kIpq3j3Q
         RHg6p3g4GippZzQfOrMirhEazWnui7ZEAigtKDNlI/XAEdDp5H7QSujyro/6GwXlRvtM
         ZDZXRZxpjHPNwWpuAPdj1LSVbru9aUdkZD2LQcftU3NpKV0fXxhUe9RqtysPycqIdhek
         9Ft0Kk+6L8gEW3HNCkp0llkJ+hMYZzSjyOZwuc0ecZvsNseRlNrGf5vRvac86gCb0xw1
         FClg==
X-Gm-Message-State: AOJu0YwavCjKxRNKD/9IIinlEqovNZV5k3kvlITXu7cfoqZBYh0lgvjb
	VoP011qGzhy/wFjqfkSDxgEaoQ1XJRw9BWme7nr+Tephr6K7RB8+
X-Google-Smtp-Source: AGHT+IF5S807DOfcTfpp+v/W0Aye9P2y0DsuqML6OlDnp9rN4VCczfwQwvro0nBZD4jqi+zjj41ABg==
X-Received: by 2002:a17:902:ec82:b0:1d8:a782:6cc9 with SMTP id x2-20020a170902ec8200b001d8a7826cc9mr3652020plg.16.1706735254983;
        Wed, 31 Jan 2024 13:07:34 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id jk7-20020a170903330700b001d8e5a3be8asm5849831plb.259.2024.01.31.13.07.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:07:34 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	"'Dave Thaler'" <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>,
	<kuba@kernel.org>,
	<jose.marchesi@oracle.com>,
	<hch@infradead.org>,
	<ast@kernel.org>
References: <20240127170314.15881-1-dthaler1968@gmail.com> <20240129210423.GB753614@maniforge> <20240131192646.GB1051028@maniforge>
In-Reply-To: <20240131192646.GB1051028@maniforge>
Subject: RE: [Bpf] [PATCH bpf-next] bpf, docs: Expand set of initial conformance groups
Date: Wed, 31 Jan 2024 13:07:31 -0800
Message-ID: <0ce001da5489$8216dc80$86449580$@gmail.com>
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
Content-Language: en-us
Thread-Index: AQJpLjBt+wHlyPZMEEMiFiltNz6/8AG1jGS4Ap1WwKSvtB9JUA==

David Vernet <void@manifault.com> wrote: 
[...]
> > > +  as being in the base64 conformance group.
> > > +* atom32: includes 32-bit atomic operation instructions (see `Atomic
> operations`_).
> > > +* atom64: includes atom32, plus 64-bit atomic operation instructions.
> > > +* div32: includes 32-bit division and modulo instructions.
> >
> > Did we want to separate division and modulo? It looks like Netronome
> > doesn't support modulo [0], presumably because it's not as useful as
> > in tracing.
> >
> > Jakub -- can you confirm? If so, how difficult would it have been to
> > add modulo support, and do you think it would have provided any value?
> >
> > [0]:
> > https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/net
> > ronome/nfp/bpf/jit.c#L3421
> 
> I spoke about this offline with Jakub. It turns out that there was
actually
> neither division nor modulo in the silicon. They only supported division
by the
> kernel's reciprocal division library. We could choose to apply Netronome's
> choice to the standard, but I really don't think we should.  Kuba pointed
out
> that Netronome is old silicon, and that most vendors today would likely
start
> with RISC-V.
> 
> To that point, I believe the most prudent thing is to just mirror the
smallest
> riscv32 instruction-set granularity for our conformance groups.
> For the case of multiplication, division, and modulo, this would be the
"M"
> standard extension for Integer Multiplication and Division, which provides
> signed and unsigned multiplication, division, and modulo instructions.
> 
> My suggestion is for us to mirror this exactly, here. I think the contours
set by
> RISC-V are much stronger data points for what will make sense for vendors
than
> what Netronome did on what at this point is rather old silicon.
> 
> How do we feel about having divmul32/64 conformance groups? Thus
> removing multiplication from the base32/64 groups. This would leave us
> with:
> 
> - base{32/64}   (reflecting RV32I and RV64I plus our call instructions,
> 		 which logically fit here given that RISC-V control flow
> 		 instructions are in RV{32,64}I as well)
> - divmul{32/64} (the "M" instruction set provides both 32 and 64 bit
> 		 versions of MUL(W), DIV{U}(W), and REM{U}(W)
> 		 instructions respectively)
> - atom{32/64}   (the "A" extension provides 32 and 64 bit instructions
> 		 for R32 and R64 respectively, just like with div/mod)
> - legacy
> 
> This to me seems like both the most logical layout of instructions, as
well as the
> least likely to cause pain for vendors given the precedence that's already
been
> set by RISC-V.

This sounds fine to me.

Dave


