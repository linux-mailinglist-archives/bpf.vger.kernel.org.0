Return-Path: <bpf+bounces-27575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA48AF5F3
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4541F2469C
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192013F455;
	Tue, 23 Apr 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="DnsYnRGQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xI7Atahi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XBSQx7gy"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7C13E02B
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895160; cv=none; b=fapx/NlSx9KvUYs6nEm4YWBIW7U4dQWWN+y4uYZskvVyZ0FwEw1oJMY6s4oSQHkpgx4hB1eS6mthB4t9ta51T1unyHfJfPxy4kE9uoAK/IZn0Qi99EruXGR2jon2eRoX9Hhb4Iol5ig5Oo8TC0Z+ys6ZyjrckpK2jollS30UScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895160; c=relaxed/simple;
	bh=GeOLHQmV2aJCi3AgDSDo/fKkX59++FaT+F6CI+el6W8=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=cyc7bMx22DeJoGVHt1pzNgAtZVVF+9p7nLEVBpfM7XVWGIQebZcCjuX8G19hhCNlXG4OFk6NDcakyUVpVEhyZoHdGyA/JVZo6u4G+A8wWkH22u2cy8OCUwsnk6XMHMVWMF6czK0NYpaT3yDYGI38NRliNqA2LNM/oNvCHR99wAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=DnsYnRGQ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=xI7Atahi reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XBSQx7gy reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 093B9C15152B
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713895158; bh=GeOLHQmV2aJCi3AgDSDo/fKkX59++FaT+F6CI+el6W8=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DnsYnRGQZWqXD9uvqwvbSkHV0ke+SOy/tycMSew8ccr6qx2LaqyaNq01u7tK/THNc
	 6sElwfDy1ejc1yK/6b18HoFDO4MOB2Blm9SkLYLg1TZ147AFtue9u30HskDJvPOCQT
	 RRJghN4yrT9BLGev65b+5NLAayYh6XpXkOS1JRzY=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id D411FC14F6AA;
 Tue, 23 Apr 2024 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713895157; bh=GeOLHQmV2aJCi3AgDSDo/fKkX59++FaT+F6CI+el6W8=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=xI7AtahiecX+odvXrhaZbmpNViYDXnygXNCQuoRXNK47EhnIsSQjBdgAPY2UMDaUG
 +1L6Uj48w10ozki0lNeSVfL5SIEaPaRLmsfgJp2uHJkMnlDjW/q47h1C0PZXmU4lLD
 8mGBFFbve5itWOg+YnWs+sXrWWuAxzgHpPB2odJ4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7FCB0C14F6AA
 for <bpf@ietfa.amsl.com>; Tue, 23 Apr 2024 10:59:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.844
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9VkqiQEP3Mfk for <bpf@ietfa.amsl.com>;
 Tue, 23 Apr 2024 10:59:13 -0700 (PDT)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7AE20C14F69E
 for <bpf@ietf.org>; Tue, 23 Apr 2024 10:59:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e40042c13eso43801995ad.2
 for <bpf@ietf.org>; Tue, 23 Apr 2024 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713895153; x=1714499953; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rzr2S8gxVYUH3LL7p/I5C6SRBVnZxMl84/YSRebCjZg=;
 b=XBSQx7gyT2UE6oGpXUw/5nWtvfkR5VpWLjHFy29zZxdrVSlVp8MhcGIjCD7qApnk6R
 JIaHZV0m22s3GhP05bqCGtX2Kdl2V+MH4K4Bh+57uY0/jCgBoZcOi4ttwbpk8Ab5atXN
 CJj8r8t1dMBJ3IBtqoslhUf6FTf2mCHeQLTK1lX3oR7tHp5TwNfzkHh8EIe3bHF5iYSK
 YCLLlUXw9qXwtOrlklRmRdAK1gQh1YqahGRvm5YobMHGrQxPFRbOWe9CwTwX/beo9Yfe
 miARyhZjU6NORBBjYT76FgVUGqKpaBu03QzLABdfIIy4+U78iBJlSzzKrJo9uGWp8t00
 DSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713895153; x=1714499953;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rzr2S8gxVYUH3LL7p/I5C6SRBVnZxMl84/YSRebCjZg=;
 b=LOqMhSRIVHKpCIgYWDqgszBH11we1Jbc8CGBHI6s2y6PXQPvqHTvIZyQD068XCkMkF
 0w+6i01C6Cf1pIRWjrYiGsSwveGr4cU7q30zvbJ0iohmlB3L7BLI44TF1CiBQiHOdJQu
 Ym+LFx9+sOj6hI1dQgYVjAbwjIhpByvMUgWEfnqWtHG16ECGewBQ251y3HbshcRcDi94
 pNyA54r/wZC1wdK9pxQOR7xehB/hTYKcPjcb09BC7jBrklGJOs0q/nux9sMRLgYEuA8k
 oMiVlQEIs1mROzHdG9s98f1QNJ4dvDnmwyYJKi2lSnc/dep3lLnOKA2NCcgmrShqfcRp
 wfTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Rc2q/XUHqn2Wh9QuChMuc+SsOUElrL/UWUAkpb7d1sfEZcO7FNiauvZwlD1rjdTK7uzcOm3RsdXBRbQ=
X-Gm-Message-State: AOJu0Yx3MD9uF4GFhLPp+gPT4NsnIogbGMBXs4SbfdWcObstjYNzSJhJ
 wZAyMAsw9NSBnra1v/L67OADiHr7x3OD3JbKWidi+hySbNKb4BQa
X-Google-Smtp-Source: AGHT+IETD7RDVXoMYsVAvqtuxS1A0YmNiOqZY7/ot9Hqsj6EmXRlCRhov93Xqqnc8OOoVhbe04NVdQ==
X-Received: by 2002:a17:902:8d87:b0:1e2:a40d:b742 with SMTP id
 v7-20020a1709028d8700b001e2a40db742mr198051plo.56.1713895152526; 
 Tue, 23 Apr 2024 10:59:12 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 u1-20020a170902e80100b001e4344a7601sm10345119plg.42.2024.04.23.10.59.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2024 10:59:11 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Watson Ladd'" <watsonbladd@gmail.com>,
 "'Alan Jowett'" <Alan.Jowett@microsoft.com>
Cc: "'David Vernet'" <void@manifault.com>, <bpf@ietf.org>,
 <bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com>
 <149401da94e4$2da0acd0$88e20670$@gmail.com>
 <20240422193451.GA18561@maniforge>
 <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
 <160f01da94f4$31201c50$936054f0$@gmail.com>
 <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
In-Reply-To: <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
Date: Tue, 23 Apr 2024 10:59:09 -0700
Message-ID: <1b5f01da95a7$f1a684b0$d4f38e10$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWAbyzN8QCsHqedwKUttqRAeznaHkCeyV1OQEF6vAGsGOvYKA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/IKjIWOp0YIF6sYOBkIhcLLZWZAg>
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

Thanks Watson and Alan for continued feedback.

Watson wrote:
> But W^X mappings are for JIT (and avoidable by writing, then remapping and
> executing), not interpreters.

Removed W^X phrase.

> How about we just say "Executing the program requires
> an interpreter or JIT compiler in the same memory space as the system being
> probed or extended.

Execution does not require that the interpreter or JIT compiler is in the same
memory space, even if that is the most common implementation.  (And Alan's
point also applies here that compilation might or might not be JIT per se.)

Below is the latest strawman after taking the latest feedback into account...

-Dave


Security Considerations
=======================

BPF programs could use BPF instructions to do malicious things with memory, CPU, networking,
or other system resources.  This is not fundamentally different from any other type of
software that may run on a device.  Execution environments should be carefully designed
to only run BPF programs that are trusted and verified, and sandboxing and privilege level
separation are key strategies for limiting security and abuse impact.  For example, BPF
verifiers are well-known and widely deployed and are responsible for ensuring that BPF programs
will terminate within a reasonable time, only interact with memory in safe ways, and adhere to
platform-specified API contracts. This level of verification can often provide a stronger level
of security assurance than for other software and operating system code.
While the details are out of scope of this document,
`Linux <https://www.kernel.org/doc/html/latest/bpf/verifier.html>`_ and
`PREVAIL <https://pldi19.sigplan.org/details/pldi-2019-papers/44/Simple-and-Precise-Static-Analysis-of-Untrusted-Linux-K                                                                                                               Kernel-Extensions>`_ do provide many details.  Future IETF work will document verifier expectations
and building blocks for allowing safe execution of untrusted BPF programs.

Executing programs using the BPF instruction set also requires either an interpreter or a compiler
to translate them to hardware processor native instructions. In general, interpreters are considered a
source of insecurity (e.g., gadgets susceptible to side-channel attacks due to speculative execution)
whenever one is used in the same memory address space as data with confidentiality
concerns.  As such, use of a compiler is recommended instead.  Compilers should be audited
carefully for vulnerabilities to ensure that compilation of a trusted and verified BPF program
to native processor instructions does not introduce vulnerabilities.

Exposing functionality via BPF extends the interface between the component executing the BPF program and the
component submitting it. Careful consideration of what functionality is exposed and how
that impacts the security properties desired is required.



-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

