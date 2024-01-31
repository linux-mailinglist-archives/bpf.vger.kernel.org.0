Return-Path: <bpf+bounces-20874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2384496C
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 22:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06875B2767D
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418038FB5;
	Wed, 31 Jan 2024 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="RPpckab1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="iwY45hg/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P68qOWWa"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58020208C1
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735264; cv=none; b=RMS24EpCECeyBV0OT5A35d+KRZ/QtFpExlAV8X5+a8siQrQ/984K6w15tJWVOX90b34BRW3tHaXtRaAZYdbvJ+sBFqlJ4Bs7urZqgEfDyrCcVtt6mkYMn9BYEcRX4stTHaQAL++3r8C1Y22ew8F+XnbnTypZfNC0QSd0CFH9UOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735264; c=relaxed/simple;
	bh=t8F0bp3/XLsg1qz5Sf+JKdHv5rIhgGsGN9UMqCiRuv0=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=pie8w5mouzzV026TzzzU3kvgxBbnLryNmvzez/SV52e7KDF54UYMe4v36LSdNBer88p611tP2/F+ZfDdMKkNfjAr8l8eHK/BTP9ZBTUWE/xVS+7/wfinrm04rWNQEBLWH6zC41HQ4NK7j0fpAw8mnMRLly7lG+troNd4bavZBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=RPpckab1; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=iwY45hg/ reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=P68qOWWa reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AC2C2C14F70C
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 13:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706735261; bh=t8F0bp3/XLsg1qz5Sf+JKdHv5rIhgGsGN9UMqCiRuv0=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RPpckab1sjj5K9ig68fl8X2OVE0ntbXPGR1mSeRlO1R1LkvRDmE6+65h5ZPx8gGwp
	 7Qn7NYZLE6MmC35MUNhGpD7gC3oE0Ol1g/ah3GMHon2YXjQVLo67RKsaAfwzAInI9Z
	 ymrtUeXR5rFmdfMk05p2JRNpqxKGIJAsGQQcsvLA=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9460DC14F682;
 Wed, 31 Jan 2024 13:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706735261; bh=t8F0bp3/XLsg1qz5Sf+JKdHv5rIhgGsGN9UMqCiRuv0=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=iwY45hg/I6bA+YSzkqY/8VkrxhHTbvYCbU1yOw2UuSG11Wecvievr8EBpwXK0FF3b
 IJhAOF4ok1IMj03hxTf+h5W+RtZfL9rOoHwqarYoliae5JiF77786NSCewov+Q8bdH
 z8XwLWsUb2O4lZcEJn2GwKcduldNndeUBzyeaTiE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 87643C14F602
 for <bpf@ietfa.amsl.com>; Wed, 31 Jan 2024 13:07:40 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k_Knyd3dBysv for <bpf@ietfa.amsl.com>;
 Wed, 31 Jan 2024 13:07:36 -0800 (PST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1967FC14F682
 for <bpf@ietf.org>; Wed, 31 Jan 2024 13:07:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d7431e702dso2158055ad.1
 for <bpf@ietf.org>; Wed, 31 Jan 2024 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706735255; x=1707340055; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw1LX+ZFVIgrafnYqjC0jzokl66M1v8G3kvRIrEAPI0=;
 b=P68qOWWaY1KWTr/X7Qq8uZO8/+X604BdJ4Q+WoLkrFL/rqW8/FtKA2Pgrzqs+EOKyI
 5tif0oTVOyJRg08TSY/e6KIxUuEFSSl3tpkanMTBYR+tTJ9M9Tf718WRqScuGYz97wDi
 Pzd2/14alwNcgMK/t63P3KHhE2tDpjdhiaNQHL1DArbnDER+VTta5U9mKK0C85fbfoXS
 RWv+Ua3XyKhjO2xPCbrkDHNYWcuUI8GW04REWyN4qD+7YQT1Ld8YToVwmqTwDyjfB4ZK
 B9vo5Bp8Sa77TUPBus2/5184H9nYHsQsskU/54MkLQYR4ieQi+8mkrnZkMqDgg7OTxBd
 EaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706735255; x=1707340055;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw1LX+ZFVIgrafnYqjC0jzokl66M1v8G3kvRIrEAPI0=;
 b=bPVnuffOw7EMCkVbU6H6iEGO1vUaAfDPacPcxxbjAACe87yRY/uPVfZ8Omm/0lKJj1
 7b/zM8mhMjwFvqa8lUq7sGS9tDvBl6jA8yfeIqwhNjV1Q/1/Rn2fTLq8P+l3tf+JahhW
 B+Ew28FOstEWtYj1tIobicTmdvOkZDGVWj8/Kfu2chFaoWJeML55Mxqrq25TmCKUXbD/
 sNevIh05LDP9FsKG1dOtaJJ5ZWAlUxDhW+vBl4Z1BxNTfXZhtdqziEw+LM6dbk34KR72
 cKm2G8/1850Cb/HMi8ToGsyYfe08GJcXMbxIzNeFOAJyNkdphlK+nBbcEQ2VzB5oUTqy
 bE0w==
X-Gm-Message-State: AOJu0Yy3VM0JwjzT8Lxk2k4sSkjMTOmNNZcTy4QCLgawgbHHOSizrOkl
 V1bWmSIKlxx5eAgVQY/ahM8JKkkoHgbWl56+79ocXd7Gxfao0zmc
X-Google-Smtp-Source: AGHT+IF5S807DOfcTfpp+v/W0Aye9P2y0DsuqML6OlDnp9rN4VCczfwQwvro0nBZD4jqi+zjj41ABg==
X-Received: by 2002:a17:902:ec82:b0:1d8:a782:6cc9 with SMTP id
 x2-20020a170902ec8200b001d8a7826cc9mr3652020plg.16.1706735254983; 
 Wed, 31 Jan 2024 13:07:34 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 jk7-20020a170903330700b001d8e5a3be8asm5849831plb.259.2024.01.31.13.07.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jan 2024 13:07:34 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
 "'Dave Thaler'" <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: <bpf@vger.kernel.org>, <bpf@ietf.org>, <kuba@kernel.org>,
 <jose.marchesi@oracle.com>, <hch@infradead.org>, <ast@kernel.org>
References: <20240127170314.15881-1-dthaler1968@gmail.com>
 <20240129210423.GB753614@maniforge> <20240131192646.GB1051028@maniforge>
In-Reply-To: <20240131192646.GB1051028@maniforge>
Date: Wed, 31 Jan 2024 13:07:31 -0800
Message-ID: <0ce001da5489$8216dc80$86449580$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJpLjBt+wHlyPZMEEMiFiltNz6/8AG1jGS4Ap1WwKSvtB9JUA==
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/FepO_8h6gPpzqvYFcSj2TassbXA>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Expand set of initial conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

