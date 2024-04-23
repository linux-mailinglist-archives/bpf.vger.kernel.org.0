Return-Path: <bpf+bounces-27574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F218AF5E9
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C0228B82E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714313E3EB;
	Tue, 23 Apr 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GSLXazTd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8413E03B
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895154; cv=none; b=kWapAV2cMSp9oFY6l9bDu3LZI9JV+vcAOeArN/DmOcXE6DaQiRg7ZoObrPptyH3Au0PadBhOtOiBFpMc9KijhHJ54NKyjdzRR4wX9SsviMXgh7VHbBJsuIxaRwJ+Di1oiglTxIgKGM3rb4I8BP9tZQenOl14L4JlQq4W5I+SrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895154; c=relaxed/simple;
	bh=muCuiB9JPin63jig6QeMR9f/HGUlIlt4aO/ZDtGuATo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=k2Rd8pjCYdxk/0Eem1N87Z1dWgJB8qO+FUpTdfhgHGushbj/J4cfjNy/+X9hI8kOiypUkRPXv4w8e21QT6KDowmpSlzZkMsuTDfmAqWqjxhiQRD0AXbLsdronJH5NRXJxq4vC7grfxHY7exY9tIfNrGzKEKpcDSmI03g4gOGK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GSLXazTd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3c9300c65so51268915ad.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713895153; x=1714499953; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzr2S8gxVYUH3LL7p/I5C6SRBVnZxMl84/YSRebCjZg=;
        b=GSLXazTdxPS4BDNBNOeV2R2ZMu7BTHDFbOVeRI0umh0z8Q4DBzaACbTsejIsWzQijw
         TSrpQYTzSHlDhn84jhO8rvTcntnnsqU/SytFbol+3BII21pHZhlu9c6vQMYQPHqo6HY6
         R00a6d0FfvdFzzjkmqK4JqrcIXsgfkBGtn2Mwm7Y8w+/NjwSkSuRmt7QS4UHyUJM+hFl
         6kENmSvWm+wQBlrz7ROJyglkbo+Hep84UZo9rWLMU6byHJW0Ng37XmTuP8OANlqyTJ20
         0GmU6NJnCZAUNAoLPT2tqtojieixepP1wJjQa41WazFE0NDhxByjl448ol90MDRpTZt7
         xsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895153; x=1714499953;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzr2S8gxVYUH3LL7p/I5C6SRBVnZxMl84/YSRebCjZg=;
        b=pumfde4xjozJUdBAWWpl0VsjNjP+R3geKneeZH12Q8xpOH9ed8B7Ap4oDP6zGOfHVZ
         hVfgZ0XWWMUoTjy+W7vxo2rfO2OjLmDisOa7i8en3qWkjGslnQwYtzR8sTNKW8SankuF
         6keG2zfaenUx2aLbRIWVhilRH2mhKw1zO3Xj3ogN678W76ytx5n9tyg4hM42G9ozVrow
         3nAt1gQYx8/7lWkw4TEv/RupGYjAa49oOppHm8NhffjEXr7RR9K1/Ido9KaceX5fqbei
         1sqfRDBFSIAOyhoeU3VAJEyJ6IljNxUB4VYUgkVGWjMbsKVr4ULEnYPbX1zlIOycrM2Q
         an4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZS3DZsro1R7hE70B3ZUVeEmejU/Qep6/D9twkUCobOCjleg1AzBVgY/zxEeb4RmuAdccniIaWhilh/40gyxzmDw96
X-Gm-Message-State: AOJu0YzSX96rpNf0xULVAaIQmNAyZjTYa6IXg/bmcK9yMsc+CpHbPRMT
	8mWVy36RLPc4GcSb2wV53Nu6ZOZY/0BUVCGxGYf2X2Avalx047P1
X-Google-Smtp-Source: AGHT+IETD7RDVXoMYsVAvqtuxS1A0YmNiOqZY7/ot9Hqsj6EmXRlCRhov93Xqqnc8OOoVhbe04NVdQ==
X-Received: by 2002:a17:902:8d87:b0:1e2:a40d:b742 with SMTP id v7-20020a1709028d8700b001e2a40db742mr198051plo.56.1713895152526;
        Tue, 23 Apr 2024 10:59:12 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b001e4344a7601sm10345119plg.42.2024.04.23.10.59.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:59:11 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Watson Ladd'" <watsonbladd@gmail.com>,
	"'Alan Jowett'" <Alan.Jowett@microsoft.com>
Cc: "'David Vernet'" <void@manifault.com>,
	<bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com> <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com> <149401da94e4$2da0acd0$88e20670$@gmail.com> <20240422193451.GA18561@maniforge> <160501da94f3$4f8aef40$eea0cdc0$@gmail.com> <160f01da94f4$31201c50$936054f0$@gmail.com> <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
In-Reply-To: <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
Subject: RE: [Bpf] BPF ISA Security Considerations section
Date: Tue, 23 Apr 2024 10:59:09 -0700
Message-ID: <1b5f01da95a7$f1a684b0$d4f38e10$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWAbyzN8QCsHqedwKUttqRAeznaHkCeyV1OQEF6vAGsGOvYKA=
Content-Language: en-us

Thanks Watson and Alan for continued feedback.

Watson wrote:
> But W^X mappings are for JIT (and avoidable by writing, then remapping =
and
> executing), not interpreters.

Removed W^X phrase.

> How about we just say "Executing the program requires
> an interpreter or JIT compiler in the same memory space as the system =
being
> probed or extended.

Execution does not require that the interpreter or JIT compiler is in =
the same
memory space, even if that is the most common implementation.  (And =
Alan's
point also applies here that compilation might or might not be JIT per =
se.)

Below is the latest strawman after taking the latest feedback into =
account...

-Dave


Security Considerations
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

BPF programs could use BPF instructions to do malicious things with =
memory, CPU, networking,
or other system resources.  This is not fundamentally different from any =
other type of
software that may run on a device.  Execution environments should be =
carefully designed
to only run BPF programs that are trusted and verified, and sandboxing =
and privilege level
separation are key strategies for limiting security and abuse impact.  =
For example, BPF
verifiers are well-known and widely deployed and are responsible for =
ensuring that BPF programs
will terminate within a reasonable time, only interact with memory in =
safe ways, and adhere to
platform-specified API contracts. This level of verification can often =
provide a stronger level
of security assurance than for other software and operating system code.
While the details are out of scope of this document,
`Linux <https://www.kernel.org/doc/html/latest/bpf/verifier.html>`_ and
`PREVAIL =
<https://pldi19.sigplan.org/details/pldi-2019-papers/44/Simple-and-Precis=
e-Static-Analysis-of-Untrusted-Linux-K                                   =
                                                                         =
   Kernel-Extensions>`_ do provide many details.  Future IETF work will =
document verifier expectations
and building blocks for allowing safe execution of untrusted BPF =
programs.

Executing programs using the BPF instruction set also requires either an =
interpreter or a compiler
to translate them to hardware processor native instructions. In general, =
interpreters are considered a
source of insecurity (e.g., gadgets susceptible to side-channel attacks =
due to speculative execution)
whenever one is used in the same memory address space as data with =
confidentiality
concerns.  As such, use of a compiler is recommended instead.  Compilers =
should be audited
carefully for vulnerabilities to ensure that compilation of a trusted =
and verified BPF program
to native processor instructions does not introduce vulnerabilities.

Exposing functionality via BPF extends the interface between the =
component executing the BPF program and the
component submitting it. Careful consideration of what functionality is =
exposed and how
that impacts the security properties desired is required.




