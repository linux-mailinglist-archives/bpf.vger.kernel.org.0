Return-Path: <bpf+bounces-27319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0B8ABC5B
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DCA1F2166B
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF067383BD;
	Sat, 20 Apr 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gpL73mpL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60B3232
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713629341; cv=none; b=oPaL96oyFMKKJcUCSQt0eV+kqpN0TOV9gX83mYcCTDhTiFOvTxOalPSGuNCnQ7L/N8TR/fQMEabxDBcZHaXJlzenIMRWtIozg133UASskXauUHY6pAcluP6KYw27WhhVKSUYkdbCKQBKVd7Eky/64Lil8dpMS/fr1hy9Y1VNSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713629341; c=relaxed/simple;
	bh=t7M0pQ2Vihkj3GtxtH8+DjTk5Rlt2lxM3Ez/au/QYhk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g4P5yEERdryYwXflG6Z945ET3FJtnYf8BAxMx2fVN/2YOSbkvsP1KPazFH1XwMqmeuKiJ0LPeW0kpk8fYa2sh4aN5DLCINElfgErLNDmjF+pQj3yhWn/7FFJPxHKzPyzcgVvPcS1So0qQJIkzcWMeYG04YjGkhNGIAIzSWayab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gpL73mpL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2348594a12.1
        for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713629339; x=1714234139; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E/WmtljErpsPGSoYf+NBQ+/HwJNg6O75Uptt6hKujQ4=;
        b=gpL73mpLSrbSjE6UyxkXbTNyykKMPQSzs32DaxUQccBORPIsTzHDKh9t7b01Ipgshl
         5F8SCz/RwzF3CXefQ+BqSwURuGjI9lv/7QCKkDPAin/aTXVN8tMsS0DdRbTMBMORYsiD
         gnU4+gQyfBhhUfL+k0yStGrfmmnL5O0zbWkok1bV145LWl18zRYk14rLKoykiHu5MrtP
         e/FPskfXBvR+rJXCcMQjBBlRWEeI4X+eBW2kl7AuJRbEIAAAXtEGOeojPfbP+Neg3VWl
         vGJeaZEuvftrW7wTtauQWxMVpGPWiin6Rx11Kq+GjyaLdQ3iyuE4PkxP0WcZa6MSilg7
         WNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713629339; x=1714234139;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/WmtljErpsPGSoYf+NBQ+/HwJNg6O75Uptt6hKujQ4=;
        b=YXGm9HfBzqRM8/pI8Em+ykC0nc2PKlcTT1pBek9PytHmUOnqBqFD8fvaWuOqpAqpuC
         HN2hhbwHXpKziHnF8JWAgDEbesWlFP6wFxRy5302zD5goffcPRTZg75X9GjwWW7Eb5PM
         F3tfhC4zmxIbPrjyC4NPAh3FWAUl1s6z5BgeDpgrc14Zuy2fM0Yy50FBQ9IBiWBgtcu5
         z5+ksczaBh/EqXxKkmDL8516r9aOVu0v2bXE7SRTpDwnmTQjchsyAJ9UuMFF17bT7dRK
         rhFwWrEGeaVofY8XnMn7z08ooRBuT0zRRw8zikR+qkXHM7zuX42Rm5K5liVIXGf17RBt
         gSkg==
X-Forwarded-Encrypted: i=1; AJvYcCWMuSvskC9y+toDL3nXILKYvvnafVgsgfBGWD/KWXlKK+LCVBBkva16SATBpaVpxXkk3I8lq02QKJf5PWBWf4JUJOfS
X-Gm-Message-State: AOJu0YzMsHMeXEFUzJs8bdWT7NtPgfj+WjaKmD/UuTrDCA+2yVBHGxa4
	TBcJ4+zkGZs4ASc/JKWsyAKLp3oM5QRcXBktDJO+qB4HBcNMgAUyyEQmFkqd
X-Google-Smtp-Source: AGHT+IEC+tf+O7t4uAXZEPvdFLa+pRZDDtdgrjZeDDMxbyiGnoM2e113+fi2HXf5vXIPj2TUNWDmZg==
X-Received: by 2002:a17:902:f78b:b0:1e2:1915:2479 with SMTP id q11-20020a170902f78b00b001e219152479mr6890395pln.12.1713629339222;
        Sat, 20 Apr 2024 09:08:59 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001e0da190a07sm5230358plq.167.2024.04.20.09.08.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2024 09:08:58 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
Subject: BPF ISA Security Considerations section
Date: Sat, 20 Apr 2024 09:08:56 -0700
Message-ID: <093301da933d$0d478510$27d68f30$@gmail.com>
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
Thread-Index: AdqTOqUAZKicZw8rQGyj6y+Q3f6+eQ==
Content-Language: en-us

Per https://authors.ietf.org/en/required-content#security-considerations,
the BPF ISA draft is required to have a Security Considerations section
before
it can become an RFC.

Below is strawman text that tries to strike a balance between discussing
security issues and solutions vs keeping details out of scope that belong in
other
documents like the "verifier expectations and building blocks for allowing
safe
execution of untrusted BPF programs" document that is a separate item on the
IETF WG charter.

Proposed text:

> Security Considerations
>
> BPF programs could use BPF instructions to do malicious things with
memory,
> CPU, networking, or other system resources. This is not fundamentally
different
> from any other type of software that may run on a device. Execution
environments
> should be carefully designed to only run BPF programs that are trusted or
verified,
> and sandboxing and privilege level separation are key strategies for
limiting
> security and abuse impact. For example, BPF verifiers are well-known and
widely
> deployed and are responsible for ensuring that BPF programs will terminate
> within a reasonable time, only interact with memory in safe ways, and
adhere to
> platform-specified API contracts. The details are out of scope of this
document
> (but see [LINUX] and [PREVAIL]), but this level of verification can often
provide a
> stronger level of security assurance than for other software and operating
system
> code.
>
> Executing programs using the BPF instruction set also requires either an
interpreter
> or a JIT compiler to translate them to hardware processor native
instructions. In
> general, interpreters are considered a source of insecurity (e.g., gadgets
susceptible
> to side-channel attacks due to speculative execution) and are not
recommended.
>
> Informative References:
>
> [LINUX] "eBPF verifier",
https://www.kernel.org/doc/html/latest/bpf/verifier.html
>
> [PREVAIL] Elazar Gershuni, Nadav Amit, Arie Gurfinkel, Nina Narodytska,
Jorge
>    A. Navas, Noam Rinetzky, Leonid Ryzhyk, and Mooly Sagiv. "Simple and
Precise
>    Static Analysis of Untrusted Linux Kernel Extensions." In Proceedings
of the 40th
>    ACM SIGPLAN Conference on Programming Language Design and
Implementation,
>    pp. 1069-1084. 2019.
>
https://pldi19.sigplan.org/details/pldi-2019-papers/44/Simple-and-Precise-St
atic-Analysis-of-Untrusted-Linux-Kernel-Extensions

Dave


