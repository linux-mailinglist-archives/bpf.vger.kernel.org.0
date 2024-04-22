Return-Path: <bpf+bounces-27475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3061B8AD5CB
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89991B20DD6
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3A1155726;
	Mon, 22 Apr 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Sa19guqs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="rPC8AMo5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E2yUebKF"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330715535D
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817578; cv=none; b=OeOOXw+hHKxhQzcVhVW1r4yjgAnR1sV110n3+KDc6NjuXlUrr4SR/BKCtmAP5GDfPwDIN77shfetKbsBunlXhC8DVdewFpcoQO4IJsrTwtC8QfloXdNVY7Kkrj3XABkAotzSVoUee1dVw9ZjlomHskhd1ZsyGD7Hmp4PAbqjkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817578; c=relaxed/simple;
	bh=YnHnOcq3g0VTMUXvYGpo/AyUbjNMEyBnYnvc8kfPqqs=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=cYlcYt9g4lTFUqOusM3BdaPYsXhRngnOqZ6BK3fpjR+/Y97tgduuBMT09/lrxMGFIl2WjbqEIyGc+yj2WcEvZjA3B9jIW/TomoqRSFmNZIsaxCPlfa5+eXXoK/yjQ+wqXgU7OPR4t8pQRPTzJThZzHE/9N6aMCyJEryU+fMsiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Sa19guqs; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=rPC8AMo5 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=E2yUebKF reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A38DDC1D4CC9
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713817576; bh=YnHnOcq3g0VTMUXvYGpo/AyUbjNMEyBnYnvc8kfPqqs=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sa19guqsFagrAeK8yGp2zH3z2MKdz0uxAR7rF183/R6bq5Ro5+TzUjtiZKEqX3HLL
	 +Fd57g09h1MysUO8eyEra9T/dyzUS4+1C7zB2eWJOZBD7hOLm6vmjgl+u8QbRAvoh5
	 vHAC06ppo/QI+mGE/QKrDVZQn+Sn8NiHrVlXZIKo=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6900EC1CAF55;
 Mon, 22 Apr 2024 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713817576; bh=YnHnOcq3g0VTMUXvYGpo/AyUbjNMEyBnYnvc8kfPqqs=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=rPC8AMo5GUNKGno1PsAvNVxzKRFwk58D2kJta3pOKHNQdaG+TshqoSG3F63ofNXoF
 Ri11iRU6hCB/4Qz/rKMnUPYZUnwstWhjzdB1qdqjMBlAHR+GQB9f8hFwW2PFj6y3W2
 jtm1+OcVUCXtBXwGMYUQHOvHp0KdyiIdkiQHxbZc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C3E3AC180B69
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 13:26:14 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.846
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8UJ92vK1MlBm for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 13:26:10 -0700 (PDT)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D96A6C1CAF55
 for <bpf@ietf.org>; Mon, 22 Apr 2024 13:26:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e2c725e234so44580845ad.1
 for <bpf@ietf.org>; Mon, 22 Apr 2024 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713817570; x=1714422370; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=sAleLJ3Lnsbgg5q0zBlOroU0eQVdHDAK3QVBYwKAgSE=;
 b=E2yUebKF2qwOiHGlxNPhxrOoQzQVpA0qYUqXygs7AEtRXdVPJ6RZtKvIXGgmF/+V15
 qC+hgXIn657NBKEDRanlcfwCXJNbpJSlBbmkcbeDjJJ52Yr4BEOGgoXmvYVp9XDeTw/c
 wimQn5feko7/9eLJ0rTDSXPGS8+AlDSwLRFPK3CrEsxM0aWucoG/kVBB4iPdSUhOPQLP
 JakDpOt54SQ4JPl+qzQJHqJJMZ7Aga1kOfE/nRlmzjclKptaOvvm1C8xBE9wWgsciioy
 /p1gnxrsAsGATYy6p4LWtXA/+ySNWdhZoEMVT3xBZdIs3T8Gc9Blkf8Q3PQ+5xho0bjn
 nVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713817570; x=1714422370;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sAleLJ3Lnsbgg5q0zBlOroU0eQVdHDAK3QVBYwKAgSE=;
 b=vPmO6gyARTJy/K4hnD2HhYuFOR3kwlWumVZZlI8YvjKLpO6fkXoxiNkjHL1l1cFoIZ
 +0CWf/T1/XQZjrQaUU0qC7ffpxRM5pVRE53j9TYfX0fj/17PORBpgJFONJFAGYq0kvWt
 KsSXs6++mOV9FIbDVR4jDSPNsNnzt7xAMuU1/iASueh2PTIrq/ye+HljIDk58EOGSiWv
 iaqkwB+0J0jTZCYPoCeEZT3Ziyk2YQug3vLvj7ILmC5p1HHGJUvcl9Jml3spODyW7nPE
 nwLJSY2pUZetGfwRZmhGlC3PW3ZZy+BHR3TwQjpHXLh79UHoWfWe6C+njp/ylwMCLo8e
 Tw5A==
X-Gm-Message-State: AOJu0YwvWyq994yvdGEet7u67PeOSlPyIDxn7pmzuzesV7lT+xv5Im4t
 B8IRgE9T3p7kae9Wa2VGC2ilasGDK0WHJtyYULn64g1d5C5R1bw4a85Z98Qj
X-Google-Smtp-Source: AGHT+IGTCcFq8Z70m7WCdP62KIRPrwyDkCCrImhtPjT3LggVPB3SVov4liWxAKAdQc0aR1Rz0/HWZA==
X-Received: by 2002:a17:903:2309:b0:1e5:c131:ca0e with SMTP id
 d9-20020a170903230900b001e5c131ca0emr1007464plh.6.1713817570006; 
 Mon, 22 Apr 2024 13:26:10 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 jv21-20020a170903059500b001e89827e2e8sm7968336plb.305.2024.04.22.13.26.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Apr 2024 13:26:09 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	<dthaler1968@googlemail.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com>
 <149401da94e4$2da0acd0$88e20670$@gmail.com>
 <20240422193451.GA18561@maniforge>
In-Reply-To: <20240422193451.GA18561@maniforge>
Date: Mon, 22 Apr 2024 13:26:08 -0700
Message-ID: <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWAbyzN8QCsHqedwKUttqRsI22rCA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/VlJQR_OdQnkhzvplYtmaIkdnqSQ>
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
> From: David Vernet <void@manifault.com>
> Sent: Monday, April 22, 2024 12:35 PM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org
> Subject: Re: BPF ISA Security Considerations section
> 
> On Mon, Apr 22, 2024 at 11:37:48AM -0700, dthaler1968@googlemail.com
wrote:
> > David Vernet <void@manifault.com> wrote:
> > > > Thanks for writing this up. Overall it looks great, just had one
> > > > comment
> > > below.
> > > >
> > > > > > Security Considerations
> > > > > >
> > > > > > BPF programs could use BPF instructions to do malicious things
> > > > > > with memory, CPU, networking, or other system resources. This
> > > > > > is not fundamentally different  from any other type of
> > > > > > software that may run on a device. Execution environments
> > > > > > should be carefully designed to only run BPF programs that are
> > > > > > trusted or verified, and sandboxing and privilege level
> > > > > > separation are key strategies for limiting security and abuse
> > > > > > impact. For example, BPF verifiers are well-known and widely
> > > > > > deployed and are responsible for ensuring that BPF programs
> > > > > > will terminate within a reasonable time, only interact with
> > > > > > memory in safe ways, and adhere to platform-specified API
> > > > > > contracts. The details are out of scope of this document (but
> > > > > > see [LINUX] and [PREVAIL]), but this level of verification can
> > > > > > often provide a stronger level of security assurance than for
other software
> and operating system code.
> > > > > >
> > > > > > Executing programs using the BPF instruction set also requires
> > > > > > either an interpreter or a JIT compiler to translate them to
> > > > > > hardware processor native instructions. In general,
> > > > > > interpreters are considered a source of insecurity (e.g.,
> > > > > > gadgets susceptible to side-channel attacks due to speculative
> > > > > > execution) and are not recommended.
> > > >
> > > > Do we need to say that it's not recommended to use JIT engines?
> > > > Given that this is explaining how BPF programs are executed, to me
> > > > it reads a bit as saying, "It's not recommended to use BPF." Is it
> > > > not sufficient to just explain the risks?
> > >
> > > It says it's not recommended to use interpreters.  I couldn't tell
> > > if your comment was a typo, did you mean interpreters or JIT
> > > engines?  It should read as saying it's recommended to use a JIT
> > > engine rather than an interpreter.
> 
> Sorry, yes, I meant to say interpreters. What I really meant though is
that discussing
> the safety of JIT engines vs. interpreters seems a bit out of scope for
this Security
> Considerations section. It's not as though JIT is a foolproof method in
and of itself.
> 
> > > Do you have a suggested alternate wording?
> 
> How about this:
> 
> Executing programs using the BPF instruction set also requires either an
interpreter
> or a JIT compiler to translate them to hardware processor native
instructions. In
> general, interpreters and JIT engines can be a source of insecurity (e.g.,
gadgets
> susceptible to side-channel attacks due to speculative execution, or W^X
mappings),
> and should be audited carefully for vulnerabilities.

I've had security researchers tell me that using an interpreter in the same
address
space as other confidential data is inherently a vulnerability, i.e., no one
can prove
that it's not a side channel attack waiting to happen and all evidence is
that it cannot
be protected.  Only an interpreter in a separate address space from any
secrets
can be safe in that respect.  So I believe just saying that interpreters
"should be
audited carefully for vulnerabilities" would not pass security muster by
such folks.

> > How about:
> >
> > OLD: In general, interpreters are considered a
> > OLD: source of insecurity (e.g., gadgets susceptible to side-channel
> > attacks due to speculative execution)
> > OLD: and are not recommended.
> >
> > NEW: In general, interpreters are considered a
> > NEW: source of insecurity (e.g., gadgets susceptible to side-channel
> > attacks due to speculative execution)
> > NEW: so use of a JIT compiler is recommended instead.
> 
> This is fine too. My only worry is that there have also been plenty of
vulnerabilities
> exploited against JIT engines as well, so it might be more prudent to just
warn the
> reader of the risks of interpreters/JITs in general as opposed to
prescribing one over
> the other.
> 
> What do you think?

I think the "should be audited carefully for vulnerabilities" phrase would
apply to
JITs for sure.  However it would also apply to any non-BPF code in a
privileged
context such as a kernel, so it would seem odd to call it out here and not
in all other
RFCs that would apply to kernel code (e.g., TCP/IP).  But if others really
want that,
we could certainly say that.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

