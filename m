Return-Path: <bpf+bounces-27474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337738AD5CA
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F852B211F3
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4AB155722;
	Mon, 22 Apr 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZfWixaa3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACB15535D
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817572; cv=none; b=JbiC4PUNHVDGquRyIegeB5Z0aB+HFE8AqtKqwxews9He97g22B3PyF9Nx/f5rvTtcf2wf5rrResyBeKTaYunrvotZpGFxaAiEY2tLjlH2U+RpTW16fOrT5Pwu82EhBBC81Ck9ERHirv5QL7O4GfwTQVxwoGm+CI+V+g2h09X+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817572; c=relaxed/simple;
	bh=wwilZw/NqDPOQfAJxwdWU+RY3id0x0BNa/3GzQIfPY8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=H5iwB27J1xJDIKFcnHqOp5L/XgjVEKG6rZUnOi1n5PghAnM5PMAdS2hpPFRAFQ8FwPNASEIGmO9DXkipFRgwOqhkYYtvG6QiEPkkoTvulFi+LDvHXjyMsr16pCHphmQ6He2ED2jOBjEV43NNS9TO5HrMM/GJx5lI+SJWkFh5tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZfWixaa3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so36148955ad.0
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713817570; x=1714422370; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAleLJ3Lnsbgg5q0zBlOroU0eQVdHDAK3QVBYwKAgSE=;
        b=ZfWixaa3hDsnhX19WewSzT3sMTLMDVjeHoJ1nO2LX8OS6JXFGhPIb0UayvH7suFb4J
         JXb6ocvghCJZUj664CPicUZt2buuGZ5m58L+rgFPdlYGeiAaqCnXzVDmht2dSdbiU3R/
         TTSTepHqfSqJiltBRKVgiCRF1sTHV8Aoc5mzfWyV39MreLP5m8JGCH7fcYmp4kGwHZbX
         6BqpuP+nZdjuv92zltpv/ORT26PG2cyqEXLsIFEWrdSSz6R5Z08hQlcaD0bnZWQOoF5d
         bB3TsHLSApt1KvZAL0b5NOF2kDNNtkpkAy/YuzJgGAovmdBA0n9usaKpq54hF1uRAy7B
         hR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817570; x=1714422370;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAleLJ3Lnsbgg5q0zBlOroU0eQVdHDAK3QVBYwKAgSE=;
        b=dlBduzra14Sb26PMkFnlhtzMQYUmErOPDalwE+5VZ43WyqWiE6ZrRSMxBX/AwB87F1
         clhBfMgHmzE1+h4EPZf139uWWYrERzmsbgUr/dKEUM0MQh4EjJ+49YBTRvH/+OpA0K1O
         XPTs//uwITPKQXB9YK5G019x+l9Y2k2e93g1SYcl+0CHQUn+s1/iSVF55gYtgskapSjz
         lXji2UqVNEHfWdyeDYzV+BMW9BJkdlwakz1sfmpPJ7VF7VzLQ4lVtM0/guvNGrrDBS5o
         ds0pdHJ5lxKYWXWSYfzWaM44IrS9sTxxFYvQzVRK+cBiQL3lrMygXSegOk88JL8ofs+g
         Osfw==
X-Forwarded-Encrypted: i=1; AJvYcCWbxKKIo3YaisBgWjdpRCyHwd2L1j5K/bU1WEpbHjV9mCgxLCKwvST6A7boH24SV4k1Ym48uABJd4x6H1XsRH9v8584
X-Gm-Message-State: AOJu0YwjQtbmSE7hW+Pdh4xN1YENe2rUHGtF5s+dLOMePpBXifJq8QoT
	Kprp65t6ldj500VY04A/jjaODbVXnhKyb2zAc8kxYsumXOlu8nRqXkR8mLUc
X-Google-Smtp-Source: AGHT+IGTCcFq8Z70m7WCdP62KIRPrwyDkCCrImhtPjT3LggVPB3SVov4liWxAKAdQc0aR1Rz0/HWZA==
X-Received: by 2002:a17:903:2309:b0:1e5:c131:ca0e with SMTP id d9-20020a170903230900b001e5c131ca0emr1007464plh.6.1713817570006;
        Mon, 22 Apr 2024 13:26:10 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id jv21-20020a170903059500b001e89827e2e8sm7968336plb.305.2024.04.22.13.26.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2024 13:26:09 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	<dthaler1968@googlemail.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com> <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com> <149401da94e4$2da0acd0$88e20670$@gmail.com> <20240422193451.GA18561@maniforge>
In-Reply-To: <20240422193451.GA18561@maniforge>
Subject: RE: BPF ISA Security Considerations section
Date: Mon, 22 Apr 2024 13:26:08 -0700
Message-ID: <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
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
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWAbyzN8QCsHqedwKUttqRsI22rCA=
Content-Language: en-us

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


