Return-Path: <bpf+bounces-27455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB18AD416
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8AC1F21BA6
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0BD15443D;
	Mon, 22 Apr 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="hX2HveeT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ycfrLswt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U5/+aiU7"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FF153BC6
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811110; cv=none; b=jnC938ZF04qVwqYzqLXIKGLhqhjkQpAVNE4B7RI+VxGmUqC8y4RblaqJRHH97hYkg/Y5NZ8haS3xa3Oi2PXo8YCtK7Z2QOl9w69HfuwMd/jWCdJ/KuM616005jGecDQkpY/7lGGUbaJA/ozJumYN9838z03A9sRtl/E7nY+gi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811110; c=relaxed/simple;
	bh=cWlIMer9hHy4kV7Xc5yFem7clarwYBPezqcDJ72aOm8=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=T9mCcQEE45nl9HxavE7EWDnkd1Sn3V+St6UjIdvvCmpwQHfSaCEwb2TlSyh69jUdAeuEfb01m8Xi+7OtPx4Exg4XlpvdEjPj2HTEDfMTM4DtrD9goyBEavJtI2DZ7f6YKu/Hlv0ktddd5Nf1fIXhJhMRQUCKQwBzeEiPhttA/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=hX2HveeT; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ycfrLswt reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=U5/+aiU7 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 04818C1CAF46
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713811099; bh=cWlIMer9hHy4kV7Xc5yFem7clarwYBPezqcDJ72aOm8=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hX2HveeTDpr3har9LzIBp4sZiHsMznCJwZ3hRDudsv/cickO9g58Xw4kakIZvyPsL
	 jhZ2MFeAQPQ9rFWduLaPbdBWUpWsoqqM1WgIb377MtEaGY2x1Cin24YTMW9+Tk0j7V
	 9UxBJptXX/06DbyNGp33mEelt5RHk+WYM04CN/40=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id B6E43C180B53;
 Mon, 22 Apr 2024 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713811098; bh=cWlIMer9hHy4kV7Xc5yFem7clarwYBPezqcDJ72aOm8=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=ycfrLswtnZ2ul/7qB7e1qdtu5ewqxMvxonZJYFqeY1N2im18GibYStS6NKJRVZe82
 M8n2th5ZKYVEcoxIAhYmUnyUstcirw1HPwf6K5m7jv9faad25eib3fKddELe6xKckg
 hEFiBZoWN/fKnhUb1gOXYLdl8wrifUOzzHAmUGyc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id CA346C180B5E
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 11:38:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ett1MMyBoCoG for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 11:38:13 -0700 (PDT)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 61051C180B7A
 for <bpf@ietf.org>; Mon, 22 Apr 2024 11:37:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ed5109d924so4052018b3a.0
 for <bpf@ietf.org>; Mon, 22 Apr 2024 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713811072; x=1714415872; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=i/O8pnmYH0xDG4ELW4n0m95T2/dxB9yFPAEgLSJkkMk=;
 b=U5/+aiU7p8H1N7G6gdYSPj9hxiDXLpjVF2f5goQN0hMHstRDew1gPpWrOp3Dby5J6z
 LoF2K3r35REnEV07A2zi5iIBxn9z2tl+H2N3liPlIQMpsS93HVPabCJ6Rvin8oc373wg
 anq6sbIrQLgU0pkaq7cH3tUUQdYwkaW0Tw2WBEYrSTIJyooi3IMBsniGypb2HV1CNXfW
 JrE2dHFRN/pUTE5hd/EGzfhk3XD0Q1LJQ0NC63IUjB7J8zp8ieMLJtxg9G/81h/kULaJ
 GKcrNBeL3usEdVD9gW7XIkO81bqnjD1QTRppowadVfin1cyKDzHUkgVKZ5a823TsElVJ
 4wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713811072; x=1714415872;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i/O8pnmYH0xDG4ELW4n0m95T2/dxB9yFPAEgLSJkkMk=;
 b=hb2rK6jVqmIIHgX2hB3Z0rt8B+X9QMt3ghtrBgtEnxEyiCZLinmHu6Og9Qz1OirNDb
 EdW3m+S0XOBy+M4jAZ+XfkSqgqaMjs+jbQLaeuuAKdYqYHHlWFha0Va+RAb7TfZVL24i
 iwcibte1MXyeWrhuXI6pz5gEv/e36GJ7j/HItVv8MbEsjxzealBLM8ih0fxFECVOd7zM
 8WyvkcKhHrvRyZ/aqpTbfW48GZNIOXOEn/VSw+2xP2+aFnjKzoKHuVXhGlrxfy+y2iMW
 HnahV9xhAumtE4AI19p+6LdTBbI7ZZuZAovsheBr0cTpyfvuImEGhfwNm+T7utSOkDIU
 w35A==
X-Gm-Message-State: AOJu0YzN1FBxSd2UmryneJjytmoPm3LFsW6wczkxQChU5Go9a1Q58DoR
 enS0nRgespVaqFAhZdoSPx0uz3xwXro9RVfLRNn+LZNZq2YfUAR0aoD0J7yf
X-Google-Smtp-Source: AGHT+IHIdONuhi1tU+z0ZhjG4E0Tr/CgUPURvarA/i4pLG2Vs562U3KrvymtWQu3Xe5GyxVhorKclA==
X-Received: by 2002:a05:6a00:a0e:b0:6eb:6:6b72 with SMTP id
 p14-20020a056a000a0e00b006eb00066b72mr12320037pfh.25.1713811072347; 
 Mon, 22 Apr 2024 11:37:52 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 s11-20020a62e70b000000b006ecde91bb6esm8169972pfh.183.2024.04.22.11.37.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Apr 2024 11:37:52 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <dthaler1968@googlemail.com>,
	"'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com>
In-Reply-To: <109c01da9410$331ae880$9950b980$@gmail.com>
Date: Mon, 22 Apr 2024 11:37:48 -0700
Message-ID: <149401da94e4$2da0acd0$88e20670$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWAbyzN8Swt8KZIA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/EBLIrGUAlAn-hzm9BIQ_ZzrGi7M>
Subject: Re: [Bpf] BPF ISA Security Considerations section
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
> > Thanks for writing this up. Overall it looks great, just had one
> > comment
> below.
> >
> > > > Security Considerations
> > > >
> > > > BPF programs could use BPF instructions to do malicious things
> > > > with memory, CPU, networking, or other system resources. This is
> > > > not fundamentally different  from any other type of software that
> > > > may run on a device. Execution environments should be carefully
> > > > designed to only run BPF programs that are trusted or verified,
> > > > and sandboxing and privilege level separation are key strategies
> > > > for limiting security and abuse impact. For example, BPF verifiers
> > > > are well-known and widely deployed and are responsible for
> > > > ensuring that BPF programs will terminate within a reasonable
> > > > time, only interact with memory in safe ways, and adhere to
> > > > platform-specified API contracts. The details are out of scope of
> > > > this document (but see [LINUX] and [PREVAIL]), but this level of
> > > > verification can often provide a stronger level of security
> > > > assurance than for other software and operating system code.
> > > >
> > > > Executing programs using the BPF instruction set also requires
> > > > either an interpreter or a JIT compiler to translate them to
> > > > hardware processor native instructions. In general, interpreters
> > > > are considered a source of insecurity (e.g., gadgets susceptible
> > > > to side-channel attacks due to speculative execution) and are not
> > > > recommended.
> >
> > Do we need to say that it's not recommended to use JIT engines? Given
> > that
> this is
> > explaining how BPF programs are executed, to me it reads a bit as
> > saying,
> "It's not
> > recommended to use BPF." Is it not sufficient to just explain the risks?
> 
> It says it's not recommended to use interpreters.
> I couldn't tell if your comment was a typo, did you mean interpreters or
JIT
> engines?
> It should read as saying it's recommended to use a JIT engine rather than
an
> interpreter.
> 
> Do you have a suggested alternate wording?

How about:

OLD: In general, interpreters are considered a
OLD: source of insecurity (e.g., gadgets susceptible to side-channel attacks
due to speculative execution)
OLD: and are not recommended.

NEW: In general, interpreters are considered a
NEW: source of insecurity (e.g., gadgets susceptible to side-channel attacks
due to speculative execution)
NEW: so use of a JIT compiler is recommended instead.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

