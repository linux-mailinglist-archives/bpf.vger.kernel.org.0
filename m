Return-Path: <bpf+bounces-60942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC30ADEF1D
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE973177E90
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804C2EACE5;
	Wed, 18 Jun 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqNSuyCS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE628137C
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256590; cv=none; b=lj/8K0ogNPL4WDTEQbbhFn6Iettss5RANh38vyJxrEGr6spANIihXN2zPn5T0pF4vIlvG1+q9sKsJiaMuA2+KmPHvKqtowUpmclRVppo+U1W9Q7FNHXVipDFnGi5SVlo0pHaeAZV0BvtlZlaJ1ZkO0Ox+teQ5qyVrpy4V4d0H0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256590; c=relaxed/simple;
	bh=n7+cjd1VyHcpNP13JlmNBkSTByav6W6lei0UBrp8ihU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAhJIYcyl+kvmaqo5XArY/Y6h6sVgJrK7eIFr7SmHpXp9tLH8K6MVSyaoKS20kspPKSiylP3f9wCCJUR88lqSRX9Bopw/8Ddyie5ZppIMoPO2b1h5zx7YhVhBLTE3+oWYSDvEHpnGmHU7CvshRugYg0GJlP+9rzD6STF1f2QdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqNSuyCS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso14079402a12.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750256587; x=1750861387; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cy3fAy0BX4pZqoqoQhf1uWIglbHLRaZZUFXxb9DufFQ=;
        b=NqNSuyCScdY9KaR1quaff6B5O6hQL4KSa4iWJGXR832eYvjQ4KtF2rnUmLczZESyvX
         Iq3mYUANYzL5IDFOsA4jIPEVkjJ+gqV1nEVvXKD641ctQQt8JqpqHqKVtJ6ZbJtR626v
         aXcjPyzw2S1JssvkC8nLrl1bN2XkMnh9/1dI02+SH8mwfDZM2N0Sr3JD5ctgOyEvaYUp
         l6aTdPW8etMCzRVWUEYIkbs99m9J4L1qmRWuKNp+Y6/uu+cFc1HD8Y8e+vkmv6L0gEQE
         IvwGNcsYr5zjUSKGgfjGy8WqqnkgNQ0v78CMpFdKUdYoHeWx6qPKGaQXcXoo2nhpCSoA
         dI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256587; x=1750861387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy3fAy0BX4pZqoqoQhf1uWIglbHLRaZZUFXxb9DufFQ=;
        b=nGFViXrrq2FF94DxQ3kpJ5hjR4cmZnQldzX8X0+dCeZt1Jw6yux3kGhfFMDe5VWlHX
         Iyiwyrm/8DcDS0d4rIidsrT/HZ/obLUWa3dKqSSHqJAj5IbAyKoe+TuL/6cvb1Q/cWj0
         jwdpk7sec4CbIcn7FOJqWiW63hPPzjlUstX+1QEBc/8f4HcljqFUlx7iVp1qvP0b82fo
         VCCNlQHHUbPcXmCw9wcEzN3KIRrZ8cL//FlPZddX+0+6zXjjXcZUrBYI1EhySaXaRtf2
         aFDHmqa0B1mewo7mhslyywyI5yJhIuWf1/38l8TcWSmai1cdV9voOdcMBZXJ2UOrtmTz
         vv0w==
X-Gm-Message-State: AOJu0YzNov7zg/2v1x9cLs5fV7w4yCoj8zugGbvq44O1XmBt6/hlb3c8
	wJB/pSmPmEJqDBVhLiSNm6Gu9DREBdeHlwb3MtjTZ+SET2JtrfKOXTJR
X-Gm-Gg: ASbGncsAg6t6i78WsqOKVyFIX4HYuFR+7XVlzhdl22IhvU6mr1j4l5wqw8epq8OQICd
	Id/ayWpbetUXBpy4I2OU89ExpWhMGwZSydE/B/WXFCmP6pB9x2/lOyyyWQv5GSGcuidRQug2i+E
	j9AhdIscYY+YLcr42ibcV9ZYGYyrmrfttyJ/45cUyp8PAEQdXNLtaLtKOPAPF1bVg0H3Lg543fJ
	BOEKDOkFT3CXmAE2GkEfBXlzEtZgcBVvLbu8IjwQIhoLIJy1XLpIFIbd51WScwPRnl3G5D7xGup
	hFOr7pqXKgfGp/q6U1J+aOt4CRBEd8gHMO6vrIUVI+75xbzdt7TJI/OdR8/KBwKqt/WQDstkqGs
	sJHG6NON7
X-Google-Smtp-Source: AGHT+IEVWh/fZIsiLHo5Auql73Eql+HFAt1tLQ61bJsJjTXqRuGDXbqKscbMqfSAx41YEUqnTywrrA==
X-Received: by 2002:a17:906:6a1c:b0:ad4:d00f:b4ca with SMTP id a640c23a62f3a-adfad4f4e53mr1697995966b.50.1750256586724;
        Wed, 18 Jun 2025 07:23:06 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81baf3esm1055434966b.40.2025.06.18.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:23:06 -0700 (PDT)
Date: Wed, 18 Jun 2025 14:28:50 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 4/9] bpf, x86: allow indirect jumps to r8...r15
Message-ID: <aFLNIjeDvKLLVkls@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-5-a.s.protopopov@gmail.com>
 <CAADnVQLtPuWOQmeJhPtBf-wyR8PS=u+1Wg4DtNVNZ7kPF5QZ0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLtPuWOQmeJhPtBf-wyR8PS=u+1Wg4DtNVNZ7kPF5QZ0Q@mail.gmail.com>

On 25/06/17 12:41PM, Alexei Starovoitov wrote:
> On Sun, Jun 15, 2025 at 1:55 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > Currently, the emit_indirect_jump() function only accepts one of the
> > RAX, RCX, ..., RBP registers as the destination. Prepare it to accept
> > R8, R9, ..., R15 as well. This is necessary to enable indirect jumps
> > support in eBPF.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 923c38f212dc..37dc83d91832 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -659,7 +659,19 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> >
> >  #define EMIT_LFENCE()  EMIT3(0x0F, 0xAE, 0xE8)
> >
> > -static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> > +static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
> 
> Instead of adding bool flag make reg to be bpf reg
> instead of x86 reg, tweak the signature to
> emit_indirect_jump(..., u32 reg, ..),
> and add is_ereg(reg) inside.

Ok, will do. Didn't do it initially, because it assumes this change
(and another one similar):

-       emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
+       emit_indirect_jump(&prog, BPF_REG_4 /* R4 -> rcx */, ip + (prog - start));

but with the "R4 -> rcx" actually looks ok to me.

> Also drop RFC tag next time. Let CI do the work.

Ok

