Return-Path: <bpf+bounces-27477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A91E8AD5D3
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5041F216F5
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141018EBF;
	Mon, 22 Apr 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ljeZl81e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qU/Z1vdP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VV27v30q"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D9EEDB
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817956; cv=none; b=kn5iuVK00xxXtLcBybmTeEal3uXeuxzoB1V+JpPzbiwFXvwGEszlP0KR4iqg/SBvMKfw8ccpPFvwamS4aCdVUuYoZCr6M6WUgto/6lvG0QwmJfLIkBrtV0kh0Vx3bXnEjX5DAj1uVUBjiquwnLHw+hJjcw117DJynF5wRn2yWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817956; c=relaxed/simple;
	bh=Tbi3qE1l2X/HT1cfV7NKzVa2p+LSxTTOZk1GLcCrhkY=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=BobmE/2IRuwtlI+yY3VKI233P1WEMN6T3fMEKYZvY2tHFS4od7wpD/K+2f/tvKyGdeFKH8twuQjcY9B8mAnwjoUzGm3jrZ2ch0SptPGX9g4fe1Ogt4WPutkC0mCcSRaFakVQ5nPKwGt2XtCkDZT8wksDUfFC88/j/F+CItXbfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ljeZl81e; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=qU/Z1vdP reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VV27v30q reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CAC16C1D4CFF
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713817954; bh=Tbi3qE1l2X/HT1cfV7NKzVa2p+LSxTTOZk1GLcCrhkY=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ljeZl81eXPomKfgUGutja0XZ0MKA5PYQRDTbIJaWmm0d7lXxvUOcsTwUueMVvyBpy
	 DyY6V41mAW0qAhUn4/PoJIdEg02GbHSS1w3BOxMT21EQilAuHt2cDRbUcLeLccns3y
	 4EKP9ifKmtmOpmZdtgxC7G1li5oVC3Y8kZEFYBow=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id AD77FC1D4A86;
 Mon, 22 Apr 2024 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713817954; bh=Tbi3qE1l2X/HT1cfV7NKzVa2p+LSxTTOZk1GLcCrhkY=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=qU/Z1vdPJI+ky0IeHk5SXCav/mUX8ymtfpTckorid5dfTMY5TkY75OaJQnPAAjY2Y
 AqVBr7inEqHatyKoviWbyB6eX+E3WfG+nUBK6xulgobI6RIuHxnRJJnQpjhJNxmfu1
 b10Q2ebXu9eIIXbNONsHyqlLdxfHOrTQiwCu1JTg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8A780C1D4A86
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 13:32:33 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.846
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WUFBTNmv3qhz for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 13:32:29 -0700 (PDT)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B4C74C1C6340
 for <bpf@ietf.org>; Mon, 22 Apr 2024 13:32:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5f807d941c4so2361104a12.0
 for <bpf@ietf.org>; Mon, 22 Apr 2024 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713817949; x=1714422749; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cLP0MQu5MhlVHjlWp2vzkIn1+c6I9TOc7HBlIeniAkc=;
 b=VV27v30qAH0t9PvzbMWXF0+eISuU/nvI9RdiRBFhOoxIudgwYa4aAFwqLnAeESL8+c
 lXZL9sDiT3s0OETok7VoDpwxRCL4N7mCYWDpMhE8megdJe4sR2G0MOPuCIboyvCLsiS2
 dOzbFiEEMa85ZxD1ujCDJ8oeWT+ekPH6kc4yQq4A0FvgK5Wfp8fvEgtOLDkRa+E6yCZn
 Xaqk7Ez3s6j4Fi3unzQdmaw0fyr5BvdLDSvcqyaBpDcDQ8yYJRz2TA7YME6YolJuytmy
 fU9zHZnhCe7usZLrPRAXWYaEfCkw6AaRFZ5JJamR9o28PcdrwcTfZhlLr71s4PMGqMue
 QepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713817949; x=1714422749;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLP0MQu5MhlVHjlWp2vzkIn1+c6I9TOc7HBlIeniAkc=;
 b=wz5fAzA0ux83kfjjSlDW/iCEra/qGeW+0oRwF/aKH+I4L0oQXVPoqJPBr8NooyICAt
 estbAG3otzFDGtGj55kf5Wa/az7gLlp+5jwKl4CaiMAYsGoQSqjKJkNgIdYHuU14PFHP
 mDR1B2D7lXvLWKl4B0mCgzQMP8wBSOoPfd5S+e1iZhOLrKWB5OjjfhyIkS9F9As1E6Y8
 1KpXDOZUetXs82MSkkk3sOo4iIXR3KJCrZcZTUAO2LyXqQGOVE37zPNH2DNUb8M+/so4
 WVFta0Pe2H5zHIFP+5zP3YR3uqlw8D7IhuVjTxt6UAaPoPagP4WIRWnB8r3z46FEd7kE
 V6kg==
X-Gm-Message-State: AOJu0YzQJhtdSQCHoTAE/NFh8gxD7wiOBRZB8/ngJzQh/GqFW9BhLXsb
 QvUOeEkuvW5Sftwe0yWdL+pVaA2RMC4FJj7sormgNJwU6hTA2mKzXW5VqsVr
X-Google-Smtp-Source: AGHT+IHDXqMjVmgQajcfh3oKO8a4ljHXebFydDeNyub2OD4AUnjmeGeN3o6/n8/fPE6fuDHYwXk6vw==
X-Received: by 2002:a17:902:6f08:b0:1e5:e5fb:709b with SMTP id
 w8-20020a1709026f0800b001e5e5fb709bmr13252052plk.9.1713817948709; 
 Mon, 22 Apr 2024 13:32:28 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 ju24-20020a170903429800b001e3d8c237a2sm8539438plb.260.2024.04.22.13.32.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Apr 2024 13:32:28 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <dthaler1968@googlemail.com>,
	"'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com>
 <149401da94e4$2da0acd0$88e20670$@gmail.com>
 <20240422193451.GA18561@maniforge>
 <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
In-Reply-To: <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
Date: Mon, 22 Apr 2024 13:32:26 -0700
Message-ID: <160f01da94f4$31201c50$936054f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWAbyzN8QCsHqedwKUttqRAeznaHmwflJCkA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/wKdyOzg8u9_-f-Js0KM2cb8Qy6s>
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

> -----Original Message-----
> From: dthaler1968@googlemail.com <dthaler1968@googlemail.com>
> Sent: Monday, April 22, 2024 1:26 PM
> To: 'David Vernet' <void@manifault.com>; dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org
> Subject: RE: BPF ISA Security Considerations section
> 
> > -----Original Message-----
> > From: David Vernet <void@manifault.com>
> > Sent: Monday, April 22, 2024 12:35 PM
> > To: dthaler1968@googlemail.com
> > Cc: bpf@ietf.org; bpf@vger.kernel.org
> > Subject: Re: BPF ISA Security Considerations section
> >
> > On Mon, Apr 22, 2024 at 11:37:48AM -0700, dthaler1968@googlemail.com
> wrote:
> > > David Vernet <void@manifault.com> wrote:
> > > > > Thanks for writing this up. Overall it looks great, just had one
> > > > > comment
> > > > below.
> > > > >
> > > > > > > Security Considerations
> > > > > > >
> > > > > > > BPF programs could use BPF instructions to do malicious
> > > > > > > things with memory, CPU, networking, or other system
> > > > > > > resources. This is not fundamentally different  from any
> > > > > > > other type of software that may run on a device. Execution
> > > > > > > environments should be carefully designed to only run BPF
> > > > > > > programs that are trusted or verified, and sandboxing and
> > > > > > > privilege level separation are key strategies for limiting
> > > > > > > security and abuse impact. For example, BPF verifiers are
> > > > > > > well-known and widely deployed and are responsible for
> > > > > > > ensuring that BPF programs will terminate within a
> > > > > > > reasonable time, only interact with memory in safe ways, and
> > > > > > > adhere to platform-specified API contracts. The details are
> > > > > > > out of scope of this document (but see [LINUX] and
> > > > > > > [PREVAIL]), but this level of verification can often provide
> > > > > > > a stronger level of security assurance than for
> other software
> > and operating system code.
> > > > > > >
> > > > > > > Executing programs using the BPF instruction set also
> > > > > > > requires either an interpreter or a JIT compiler to
> > > > > > > translate them to hardware processor native instructions. In
> > > > > > > general, interpreters are considered a source of insecurity
> > > > > > > (e.g., gadgets susceptible to side-channel attacks due to
> > > > > > > speculative
> > > > > > > execution) and are not recommended.
> > > > >
> > > > > Do we need to say that it's not recommended to use JIT engines?
> > > > > Given that this is explaining how BPF programs are executed, to
> > > > > me it reads a bit as saying, "It's not recommended to use BPF."
> > > > > Is it not sufficient to just explain the risks?
> > > >
> > > > It says it's not recommended to use interpreters.  I couldn't tell
> > > > if your comment was a typo, did you mean interpreters or JIT
> > > > engines?  It should read as saying it's recommended to use a JIT
> > > > engine rather than an interpreter.
> >
> > Sorry, yes, I meant to say interpreters. What I really meant though is
> that discussing
> > the safety of JIT engines vs. interpreters seems a bit out of scope
> > for
> this Security
> > Considerations section. It's not as though JIT is a foolproof method
> > in
> and of itself.
> >
> > > > Do you have a suggested alternate wording?
> >
> > How about this:
> >
> > Executing programs using the BPF instruction set also requires either
> > an
> interpreter
> > or a JIT compiler to translate them to hardware processor native
> instructions. In
> > general, interpreters and JIT engines can be a source of insecurity
> > (e.g.,
> gadgets
> > susceptible to side-channel attacks due to speculative execution, or
> > W^X
> mappings),
> > and should be audited carefully for vulnerabilities.
> 
> I've had security researchers tell me that using an interpreter in the
same address
> space as other confidential data is inherently a vulnerability, i.e., no
one can prove
> that it's not a side channel attack waiting to happen and all evidence is
that it cannot
> be protected.  Only an interpreter in a separate address space from any
secrets can
> be safe in that respect.  So I believe just saying that interpreters
"should be audited
> carefully for vulnerabilities" would not pass security muster by such
folks.
> 
> > > How about:
> > >
> > > OLD: In general, interpreters are considered a
> > > OLD: source of insecurity (e.g., gadgets susceptible to side-channel
> > > attacks due to speculative execution)
> > > OLD: and are not recommended.
> > >
> > > NEW: In general, interpreters are considered a
> > > NEW: source of insecurity (e.g., gadgets susceptible to side-channel
> > > attacks due to speculative execution)
> > > NEW: so use of a JIT compiler is recommended instead.
> >
> > This is fine too. My only worry is that there have also been plenty of
> vulnerabilities
> > exploited against JIT engines as well, so it might be more prudent to
> > just
> warn the
> > reader of the risks of interpreters/JITs in general as opposed to
> prescribing one over
> > the other.
> >
> > What do you think?
> 
> I think the "should be audited carefully for vulnerabilities" phrase would
apply to JITs
> for sure.  However it would also apply to any non-BPF code in a privileged
context
> such as a kernel, so it would seem odd to call it out here and not in all
other RFCs
> that would apply to kernel code (e.g., TCP/IP).  But if others really want
that, we
> could certainly say that.

Updated proposed text, based on David's and Watson's feedback:

Executing programs using the BPF instruction set also requires either an
interpreter or a JIT compiler
to translate them to hardware processor native instructions.  In general,
interpreters are considered a
source of insecurity (e.g., gadgets susceptible to side-channel attacks due
to speculative execution,
or W^X mappings) whenever one is used in the same memory address space as
data with confidentiality
concerns.  As such, use of a JIT compiler is recommended instead.  JIT
compilers should be audited
carefully for vulnerabilities to ensure that JIT compilation of a trusted
and verified BPF program
does not introduce vulnerabilities.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

