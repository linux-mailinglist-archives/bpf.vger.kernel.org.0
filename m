Return-Path: <bpf+bounces-27334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307CB8AC03B
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF735281663
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E6A28DDF;
	Sun, 21 Apr 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HjSf0LTa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF28D527
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713720030; cv=none; b=J78LtouuefljXR8AuyMUV68i7tyUVqr8B1Tn4wA6yuaKFaA1B0HgJywjuydAlrWmLO8JJVPAsY8rZ6G0xmorFMDAkwEFftNfImHGM/Cw2usSbKx6LI2S85Xd/NVV4VRsYw/keBTHDWmSjpi9aZl5cJx9cUs7zpN2xHMxw7m6h8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713720030; c=relaxed/simple;
	bh=PyKg9WMoudPImVk4awAouRVG+dXludE4Mzx6w2kBBiY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=sbkGOGOKY47CfCTTNQIGkeulT7yqb+ZNa8PPxg+mv0ocijIArmfWfGo029QSOLXA7tQerwXdYfaJWgyK/bwjWR5Aek18PsxAx6YOHf0IJB0//40K0QzC5n6U5gFamOf+kwEUoqRPgvW4KuxSMTMtzd0OQQDpYcKbFbT+LRtPiSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HjSf0LTa; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2760072a12.2
        for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713720028; x=1714324828; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9Yz6HDK807IdB3m9hlHlHuh7TdmfJH1q4CbmAOxdBA=;
        b=HjSf0LTa5fjcg9neFTnIo2CmvGt2Oz888VY4uzQY05hOjntzTo14AYDc+xtxvXF3hP
         IFs9eXqZ7bFMrjUNp8g1gVWejVu35G716gA+In02HYfrOJEJPTAT9Qgt680G5gA+FndL
         lh4lLnEIwkLnJL7tZviXfzm+M5Xu8vYUh+GgU+wvPIwxZCXvYRAgmFmcyGbgSBeMye/m
         tRwxeY5++Kc6nvAgdBGKloi3s6iy+PlkS7gWpw3XAL1IDO+9vCtSjwgSRvq/MxJdH5Gl
         mkQqpMlX4Z6jy8MMGod5fH4PMIHBpHR4xCVsXfaV9nKgEvztHTWTyjWl6mYSZDBvxD7C
         s62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713720028; x=1714324828;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9Yz6HDK807IdB3m9hlHlHuh7TdmfJH1q4CbmAOxdBA=;
        b=ojfBHa+3VGCICd10keqIMx/G5p6+OIJBDzeudwIr6dKLshNK8OTc99/2FCQXo0G6wt
         HlQ9q+UQsgtMMNK66faiMXtuFV13KFWJFsO+nQ3Ck48FRmRvqxqJeyYlbr30L3ty9rPL
         udKGfWhgOyTErIbw1CMqdbt+vy/SMW8GPDKvZ8sIqbF4USbf0RFE6lE/H/gJF66cAK6a
         JuSrWcVzskR1xtnGTbd2i/KnNwjB39hN/tdWH6lyQGN6qGBRXom4ycr0rYiUG13yAYSf
         FkpjjD3OQO9D+EDQyG0Pcz/wXcg//5TbKKNX7f6TRIZV3msRozkgIgT64m0OAZSCQNgs
         2Elw==
X-Forwarded-Encrypted: i=1; AJvYcCUO1JDwKRmm7pwvHTbcgkf6K+1ocX4wpY+teLrpkoQZD6imkPYdUUZ+QWSjVqdqcdWs1L664l5tpy1IMPGa9qEZEA+r
X-Gm-Message-State: AOJu0Yy5c7VhG2NVNTwC4KheLowiZm6wVHD0T0HMrgOyRcNkALyNwhpP
	q+K+WhSIHLwAbp9gqZ4ri/AWf2CjrdlDVaa8vFAK7SrSto9TxxLO
X-Google-Smtp-Source: AGHT+IFfsP/+CXJPcD47uC2NhEgBLgCITIwfdwND9WgoLLQ6OMV3Sv21NZWeyHGGztPagmcGjFUNCg==
X-Received: by 2002:a17:90a:5213:b0:2a7:600e:ce0 with SMTP id v19-20020a17090a521300b002a7600e0ce0mr5822844pjh.42.1713720027552;
        Sun, 21 Apr 2024 10:20:27 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090ac00400b002a3a154b974sm6134119pjt.55.2024.04.21.10.20.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2024 10:20:27 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com> <20240421165134.GA9215@maniforge>
In-Reply-To: <20240421165134.GA9215@maniforge>
Subject: RE: BPF ISA Security Considerations section
Date: Sun, 21 Apr 2024 10:20:24 -0700
Message-ID: <109c01da9410$331ae880$9950b980$@gmail.com>
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
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWsMQACeA=
Content-Language: en-us

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


