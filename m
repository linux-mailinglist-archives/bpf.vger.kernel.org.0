Return-Path: <bpf+bounces-27335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5458AC03C
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDEFB20B45
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541629427;
	Sun, 21 Apr 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="m++x4A9W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WqWVFeJs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L23ZMt8Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE2D527
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713720036; cv=none; b=aqJzjeKo/Se3Gjj0pRMy2j6jDc1vt2E2iID2HyYTtV+aQZy6lXZ0njTuCJAPojucDAkxNMhqrbtCoj657ErO9p/UPKo9SIMG6NLx32H4AUk0QCarJMfMxxYAz4p5FvG5E5/c3h57iyn5k4wJs0kz3Kl57mF8///WZvaQKTRq5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713720036; c=relaxed/simple;
	bh=M97acyUDlIGoS1BvcaHER7fhTtY1HypfoBrKaJkZRDc=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=YQcEafqmuZ5Hqw0WPE6dqAp0XPkpNotK9Xnfjd7gou4A7gPu+Fttn0Rrg/EXsRAiWfv8vGRLrfxC4NwHIbiz9L+orWxo3JVvsBjPniixAT03cuIRX/aOcBKN7JpiaPJfC7moNWdQuFkYMLt2jFhK0dj3VT3lJv70jz6jFoAZIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=m++x4A9W; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WqWVFeJs reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=L23ZMt8Q reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 31050C14F739
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713720034; bh=M97acyUDlIGoS1BvcaHER7fhTtY1HypfoBrKaJkZRDc=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m++x4A9WVH3fpbZoW3xE0DEgrwT/lsgwQoF9lsvGcOxVojMbek6wyIVQwFsj+5Gf7
	 +cmpQmA3ujRFu39JRhHa40EuBs4GNLMnUye1WDSoAA1vpeFjI92O+cQ4yrhpEENDHH
	 zUZZBYMBW6NYLWnuG66K+xD+/pJxZFtyOrU2x/Ho=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0691EC14F605;
 Sun, 21 Apr 2024 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713720034; bh=M97acyUDlIGoS1BvcaHER7fhTtY1HypfoBrKaJkZRDc=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=WqWVFeJswn1LlWyquMUFjohyoo7h10D6zeVgip4CvA7BMvznpfGNkVwmA6pFBjp2w
 t6atc50f5x7ArDD65/jPvpPsnp1QH0hLJ2gv33IqhoE7gifEYSShxT1NErsIV3MhHx
 j8b3zcHE3DGUEvdktcYq4iXsRx7B47VD8Vi2ibXM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 28514C14F5EE
 for <bpf@ietfa.amsl.com>; Sun, 21 Apr 2024 10:20:33 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.846
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j1x1A3VGsKGe for <bpf@ietfa.amsl.com>;
 Sun, 21 Apr 2024 10:20:29 -0700 (PDT)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 06B61C14F605
 for <bpf@ietf.org>; Sun, 21 Apr 2024 10:20:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so2698569a12.3
 for <bpf@ietf.org>; Sun, 21 Apr 2024 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713720028; x=1714324828; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H9Yz6HDK807IdB3m9hlHlHuh7TdmfJH1q4CbmAOxdBA=;
 b=L23ZMt8Q+x6hm/iibapzIb8pBApwlt42u6deBd82rxwu1ZeuWeVLnBM3qFd1YY+e5w
 6IC9YwOWaIb/UaDzlrFWcEM0X4boXxDmGEymvttChlt4JySHq3fqukkyRs+9wgHu4kcQ
 JIpMzIOzM+63aVG0xD7ePZm4+Y20wmukzxVURFBDDwc2A9EQWObKcxm+JteAcaahHwKq
 w2I+kWbAkzqYCdnTs8zh9GhSjq9LAnjwNFvIKF/Wpwn0JdPlw7crfVxax5o5HO4knObo
 at5FmsM+hwOzHOw2e2jQkTy7uI3bR7ukqI40kEMrtFD083RMoOqbDGE+XFyHgPYMFukK
 kJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713720028; x=1714324828;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H9Yz6HDK807IdB3m9hlHlHuh7TdmfJH1q4CbmAOxdBA=;
 b=LfJZJCdks+hCY7X59tyMTBcNHji44eIxLkcTTKWIH+PYqx2/FWnigAUNzaA7Ta1zsS
 r1OWGv6Xs1z0XEauM5etW138And59sD9P0k0M6gTwb6XbZhTkuR0ILUuBVvs3Sh9O/uy
 ByeBFCbHE0FiiitKV1TeqYuDoeT6bPD5BxCWrwL89hfgffLrbDSXUwxLl6epsiJ4/lqk
 xgOpM4X9lrSa7DUYbUZuq06KDlHW6AsUGNZ1yYHlNCK3df/gzZA1lsow8KVMUpHEaiiL
 NyXRiNo5l9a2bNtCc/hbOVzDm1R5aJSG3YVrEe+2xnQlGDb01IbvYJB7Z/JrZ5eRJClJ
 hfiA==
X-Gm-Message-State: AOJu0Yzn7+T3BWgmwau1eAkek97CQbFcgW7dMVsPzW93+JwSNXsBoq1W
 b8AroIo2Udt5IV2AtBeftphW66D1XSf4wgldxD+O02Ag4f/58kEcRyU4wOFo
X-Google-Smtp-Source: AGHT+IFfsP/+CXJPcD47uC2NhEgBLgCITIwfdwND9WgoLLQ6OMV3Sv21NZWeyHGGztPagmcGjFUNCg==
X-Received: by 2002:a17:90a:5213:b0:2a7:600e:ce0 with SMTP id
 v19-20020a17090a521300b002a7600e0ce0mr5822844pjh.42.1713720027552; 
 Sun, 21 Apr 2024 10:20:27 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 p4-20020a17090ac00400b002a3a154b974sm6134119pjt.55.2024.04.21.10.20.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2024 10:20:27 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge>
In-Reply-To: <20240421165134.GA9215@maniforge>
Date: Sun, 21 Apr 2024 10:20:24 -0700
Message-ID: <109c01da9410$331ae880$9950b980$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWsMQACeA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/-vbcu-jz96_rsA5aCdA5KG9Y4bw>
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
> Sent: Sunday, April 21, 2024 9:52 AM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org
> Subject: Re: BPF ISA Security Considerations section
> 
> On Sat, Apr 20, 2024 at 09:08:56AM -0700, dthaler1968@googlemail.com
wrote:
> > Per
> > https://authors.ietf.org/en/required-content#security-considerations,
> > the BPF ISA draft is required to have a Security Considerations
> > section before it can become an RFC.
> >
> > Below is strawman text that tries to strike a balance between
> > discussing security issues and solutions vs keeping details out of
> > scope that belong in other documents like the "verifier expectations
> > and building blocks for allowing safe execution of untrusted BPF
> > programs" document that is a separate item on the IETF WG charter.
> >
> > Proposed text:
> 
> Hi Dave,
> 
> Thanks for writing this up. Overall it looks great, just had one comment
below.
> 
> > > Security Considerations
> > >
> > > BPF programs could use BPF instructions to do malicious things with
> > > memory, CPU, networking, or other system resources. This is not
> > > fundamentally different  from any other type of software that may
> > > run on a device. Execution environments should be carefully designed
> > > to only run BPF programs that are trusted or verified, and
> > > sandboxing and privilege level separation are key strategies for
> > > limiting security and abuse impact. For example, BPF verifiers are
> > > well-known and widely deployed and are responsible for ensuring that
> > > BPF programs will terminate within a reasonable time, only interact
> > > with memory in safe ways, and adhere to platform-specified API
> > > contracts. The details are out of scope of this document (but see
> > > [LINUX] and [PREVAIL]), but this level of verification can often
> > > provide a stronger level of security assurance than for other
> > > software and operating system code.
> > >
> > > Executing programs using the BPF instruction set also requires
> > > either an interpreter or a JIT compiler to translate them to
> > > hardware processor native instructions. In general, interpreters are
> > > considered a source of insecurity (e.g., gadgets susceptible to
> > > side-channel attacks due to speculative execution) and are not
> > > recommended.
> 
> Do we need to say that it's not recommended to use JIT engines? Given that
this is
> explaining how BPF programs are executed, to me it reads a bit as saying,
"It's not
> recommended to use BPF." Is it not sufficient to just explain the risks?

It says it's not recommended to use interpreters.
I couldn't tell if your comment was a typo, did you mean interpreters or JIT
engines?
It should read as saying it's recommended to use a JIT engine rather than an
interpreter.

Do you have a suggested alternate wording?

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

