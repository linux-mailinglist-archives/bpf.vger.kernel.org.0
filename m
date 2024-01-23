Return-Path: <bpf+bounces-20131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211FC839B47
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5729286B48
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD383A8C1;
	Tue, 23 Jan 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aa6K7/qT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="tkpNZQmA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cvzvb0dO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010E3B18D
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046082; cv=none; b=RiQa9l73dVROV27DTdn02WH4KIgC19SyM9cE4zJ5UfanA35LRUBB7piUseRH1jFfYpeigtIXx/VfJ/X5wky9H6qwkxINsc6CBfPrMULySunYYzPQRkHKo1w2v2J98c6DGh6gO7ddMOnuFTXb8JsZ/GDVND517JjtMgxrXNellsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046082; c=relaxed/simple;
	bh=34DXqrnKmu15gd4j39sdV22ekQ4nIunCDM6flFk+3zc=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=RkLI4A/1ebhMrYajMNMQjdlYO4cmDqRG2O9BOkD6cE8OnXEDHV6qwPl/aWBFVe2ftlSBXj9kPOEgBvgHy2YGrV0FtiCZQ/RHks4plV3eSTCNjwlEj8rI/APJ0Uqy6bsTwjq9BYFabJsniLHF8KF3Wi+lMSxwUV+J/nOInkWc0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aa6K7/qT; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=tkpNZQmA reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cvzvb0dO reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9C7F3C14CE5D
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706046080; bh=34DXqrnKmu15gd4j39sdV22ekQ4nIunCDM6flFk+3zc=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aa6K7/qTXQnJ0W7xwlm1QOFkMarOOgie4hDciscl9tHcrp/rCKiVBv+GD08H2211G
	 Edufa9x0R17Y+0uHEiVvK3xyMj0zsTxPW3ZLgH82Uw9LCbWZPH1aScTUrMhn+RueTF
	 wTlbSGysZiCOIDHCepKs2mplDOcg7q9647ukz+0M=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7CD29C14F6FC;
 Tue, 23 Jan 2024 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706046080; bh=34DXqrnKmu15gd4j39sdV22ekQ4nIunCDM6flFk+3zc=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=tkpNZQmAkygTi2UM5SfNkFyDW972INYdIhgc0cUkAY3XF8C29tUpulitFuZ6p6360
 u03XAX9m5a+9eLIJMrzxQoQT0nonPxhRZHu/LxzsPzVLkU2oRGLJEHcRzNuOrtikFi
 xYtuvysLaiGXN+7w1A6Nws9nNJ3MtjEDJmSiCPKs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B323DC14F6EF
 for <bpf@ietfa.amsl.com>; Tue, 23 Jan 2024 13:41:19 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DlPbajjJMkaf for <bpf@ietfa.amsl.com>;
 Tue, 23 Jan 2024 13:41:15 -0800 (PST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 2822CC14F604
 for <bpf@ietf.org>; Tue, 23 Jan 2024 13:41:15 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6e0d86d4659so3313884a34.1
 for <bpf@ietf.org>; Tue, 23 Jan 2024 13:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706046074; x=1706650874; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7FLMHyPB0yGngUluQZ2X5jHRvGaiUZVT19xSHxw4Z8=;
 b=cvzvb0dOVRy9aW+LUKiXtoJ1ejoxZQRzNlrsZwRE4QPqw/BmG6TKKqC80OFLvkzDuJ
 JWwiKVx7YJtSiz9xal+Mnz4husw+yH0RVLNjgJeCl4B+mcwLwetPjIXt1zBKYRsE1eWd
 FNGUirCm72lxihLVsaTpJ/wqJWcEslpr+WlD8JjR2+8Nbx/m7TeuTEIBf61KUt6lzRM8
 3bCfW4eHQbeVI//pUCBk+f6GaGViFQlumPYgac6hfMXRtS4BoJKQo/LZtrKxxcFSbyH8
 1R47YGMA46ynx36fsd8TflNTZaAu2yQCCICfWQJ1lGDQAKdsFZw3uWvJCw+l236ne064
 iGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706046074; x=1706650874;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7FLMHyPB0yGngUluQZ2X5jHRvGaiUZVT19xSHxw4Z8=;
 b=qN2GmDU25fJLqjNYE5OBXqejH2fjypqgzY5av6FTnttvZoP11W/qEOgDdTyppqAugx
 OXo2n06AgpWhN+kJTXJGJUCkCUtiW/pgb9Aqs/3y+zORuvACAyrO8VLelLEcMvZ2tSB3
 YVj9bMmEMhtGLqsRHgmMCTjfWLS+x+YzxjP6k5aUSNpkbIbZ9wgb9LS0mvsKpHXV6Fg3
 /ZO2pR0EE5TejA+MqfDPBZDH/Ym5IcnUVGOIKV0owP07xS5kvRQYbAD+SLNSkcdLt/5u
 Ev2tOQiTzPAcmZK+AzW3E79tISfzf5vZkvKlo0Sr5JMlqDR91bzvaE9rt3VrslaQ5xkn
 3XbA==
X-Gm-Message-State: AOJu0YzBqNd/nEklVzZ89Ig/E9IdsLi/+8/74bbeCE1u9viC/YGY/ISs
 k5trMT6OAJGJcU0cKJA02/q3jjqMkh5M7MUdgNdaoHdp3jYAdJkI914L1n9GXio=
X-Google-Smtp-Source: AGHT+IHDa4h1k2Ef4tChn29gCdSowpX+0jMjXcxaOToTU/xlAXKeV7jx7cNKSXJrF+Hkpjb0ge9+Cw==
X-Received: by 2002:a05:6359:4599:b0:176:7284:8305 with SMTP id
 no25-20020a056359459900b0017672848305mr1970780rwb.20.1706046073625; 
 Tue, 23 Jan 2024 13:41:13 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 c32-20020a631c20000000b005c259cef481sm10571793pgc.59.2024.01.23.13.41.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jan 2024 13:41:13 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>,
	<jose.marchesi@oracle.com>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
 <20240123213100.GA221838@maniforge>
In-Reply-To: <20240123213100.GA221838@maniforge>
Date: Tue, 23 Jan 2024 13:41:10 -0800
Message-ID: <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEMYhjceuFr/KIoMYEnffEkkY0NOwHLV0EHsnVpLvA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Z8pyaAWBKdRyJNQSee-2dNWC1H0>
Subject: Re: [Bpf] Standardizing BPF assembly language?
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

