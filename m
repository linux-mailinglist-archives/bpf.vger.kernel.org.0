Return-Path: <bpf+bounces-27476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216C8AD5D2
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C56B21F1E
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D718AED;
	Mon, 22 Apr 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ckyIPaJK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A5EEDB
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817950; cv=none; b=Vv3X4ayQqqiI/1pIlaaitSnX49xBzFNVknN+vRUFgSlTUnnstLUAQSa1Lqk7L4v9w+0+zAAt1e3Q6Gup9nP6Z7pEGzsEL4OhonPEcF1oXVXy8YsAZJiRTliDqb5xL+duOZ2RP43QF2mlxbSfUWgW2bc+A+7ChppUW19RPvbfQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817950; c=relaxed/simple;
	bh=0BPsPy9DiEKhyzNfesOvUlnnquuZf5JpngNIRo/a78w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=aBhUMiwf9U9BMUmW6vkxj1aQsvbvptgQIDy3XVWWzB1TMpv7lSq0BaaSkBRLbZb/ggj6jh72Aczwe7t/x4s1udJl9gp+iuUckZZ7y6jgIrm1zUwSVSzrIru5U110VvFKkaUFZ8hA7IeJU3W8dwFR1TWsuny5dcUXAkiSPVUVqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ckyIPaJK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e65a1370b7so47210885ad.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713817949; x=1714422749; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cLP0MQu5MhlVHjlWp2vzkIn1+c6I9TOc7HBlIeniAkc=;
        b=ckyIPaJK6riFO/9n2/8Az/BHTx3ugnIdl/yGQbfRufAuF18F6/dX9jFPfB/j0hBNdd
         m4tJKCq5uVt4yghyIPGB80iwk7JKxZ1LjqUIbIrQprtpoiesN4d1GoAqa52Ug/2TWGbM
         7/nten+27vkuH0pzKZ04SOEavDDk/B93Fe1Y8iEfXkyF7yhT1eKfU4za4/cTnzMB2oMV
         5GhlYKUZ6/e9qChAQ4AmBGxT8rULDEfYI9KAusuM54Dl9EybKWvcIGbsQUBegIoQPPym
         gKwO7Ujg1YMDcpZBvj3DoZHeY0vERG9s6zzvskiWe1dXujn88ovGrPrVhWR19Fkt9n7q
         P+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817949; x=1714422749;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLP0MQu5MhlVHjlWp2vzkIn1+c6I9TOc7HBlIeniAkc=;
        b=NPdX5bVz3OqOzWa0bvWNSP4MuK5LMnlV1eR08cKcW7cWDBBIoHDFjxQwQAbw9FzJ/m
         Ufuc2R2Ry2O5v+1CHxpQJuvOgT9J7rO2TK0VSTut7PKI5Ho+kUbh9fcDb7VcN0ZFccmQ
         skcpFjmz6z5xwO+jxJ3/k2FnShzYEDkfLyDHZ1occsVKqVU6AxCcJPSsRWN8UO2rE3YF
         WLldOgg+tZ+hb9KQhHGMsLDlufg+NuCrBhhuOo8lg3w2boaeuZmc1jK1ayQ5PbOnS/i/
         KcBzmhpAMEp3dCNIMz7gqWP+GS/fS2cKfkehD3QcEO9oy1jHtQo+6sUue9D7SWybghc7
         hMtg==
X-Forwarded-Encrypted: i=1; AJvYcCUTHaxd3qvJdfhopN6jxLSVQRWa1yrrsT4Ywqf/kUIRmBhoz9HjRA9SdKgPD07tSCNKOKszE5lFfQrKUOrV5qceee5b
X-Gm-Message-State: AOJu0YzgPJjQDc5+ysQ4txKEPYxgXMQWzlTGX+fjnB7/ESSngD8SIjNW
	p/3QFqtqxaaujpiMThViJqL/cwcmA9hYUgRwhjA2/jOGSvE+J4E3
X-Google-Smtp-Source: AGHT+IHDXqMjVmgQajcfh3oKO8a4ljHXebFydDeNyub2OD4AUnjmeGeN3o6/n8/fPE6fuDHYwXk6vw==
X-Received: by 2002:a17:902:6f08:b0:1e5:e5fb:709b with SMTP id w8-20020a1709026f0800b001e5e5fb709bmr13252052plk.9.1713817948709;
        Mon, 22 Apr 2024 13:32:28 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id ju24-20020a170903429800b001e3d8c237a2sm8539438plb.260.2024.04.22.13.32.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2024 13:32:28 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <dthaler1968@googlemail.com>,
	"'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com> <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com> <149401da94e4$2da0acd0$88e20670$@gmail.com> <20240422193451.GA18561@maniforge> <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
In-Reply-To: <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
Subject: RE: BPF ISA Security Considerations section
Date: Mon, 22 Apr 2024 13:32:26 -0700
Message-ID: <160f01da94f4$31201c50$936054f0$@gmail.com>
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
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWAbyzN8QCsHqedwKUttqRAeznaHmwflJCkA==
Content-Language: en-us

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


