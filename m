Return-Path: <bpf+bounces-27320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D528ABC5C
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 18:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F1828171E
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F4D39852;
	Sat, 20 Apr 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="DmjtsTDZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="IgPJyybm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EgSfvDSV"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE93232
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713629348; cv=none; b=ij3epSf1pk+13Pn6W2RocUEP+n2jwmcA2HSKK1RW0JSEH1tUjqCzipXXLq3nlzXdj1o/fhfwiVpM0VwQy3JJDbX20I5cYskQZGYm8HWvW7E9tq3EPrrezQ4zJuHIqXUSbAceWYI8RFwCuBSZLzhIPHvSxEI5JTOMH3l3FnV/kFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713629348; c=relaxed/simple;
	bh=t0NGb5n1zZGgYdrTt/iwDK6ECiw1MjCPQiad6Cy2/14=;
	h=To:Date:Message-ID:MIME-Version:Subject:Content-Type:From; b=U4XXcTlNwKAyb0UZiCNqlkELV8RP7jFogQ1e6ZKcvsj6gZiOigFzqhA5knLX5cwDFXf+40TDGHbTlZxB4WXNvODfVB8oAaW9HgFm26QjJ4zspeVkb8uCjnOn4XptM+HX5ylQmgKIUpOZspuMwN+9SBctwtkYkJCTXmmMfQfH5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=DmjtsTDZ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=IgPJyybm reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EgSfvDSV reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E6155C14F701
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713629345; bh=t0NGb5n1zZGgYdrTt/iwDK6ECiw1MjCPQiad6Cy2/14=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=DmjtsTDZAYaO7oP/+vsXFZOMJb1+Vt3isDTIs6kFfuszaYcHGajQ1apPB6iC2ZRm2
	 Qfs3VwkpdE2kCfzJ7e4j59qKuTPI+95LrgWWOdthkt2r0D7XJDpYt821TMIFXB9RbW
	 AXxTZfjTn1d2fQThIM2WII3YQriCw+My0ZtSObWw=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id B7EBEC14F615;
 Sat, 20 Apr 2024 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713629345; bh=t0NGb5n1zZGgYdrTt/iwDK6ECiw1MjCPQiad6Cy2/14=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=IgPJyybmXz32RDD2HZWgpUMAJ6dzNR43EFf4+o5Ta84mVr8ZKrU5cWEQadZbTIrav
 1k4BWmYEf/gmM0Kqf21mNii03OKTODgDciZwnZ4DY/5wGHCRI4Ro+UbNQLS5aGUv4H
 40qfJPziIIsEzK5ieylCCcKtxF7RPb85bwunigj0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 689E7C14F605
 for <bpf@ietfa.amsl.com>; Sat, 20 Apr 2024 09:09:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m1c2NmR90cr9 for <bpf@ietfa.amsl.com>;
 Sat, 20 Apr 2024 09:09:00 -0700 (PDT)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 412CCC14F5FF
 for <bpf@ietf.org>; Sat, 20 Apr 2024 09:09:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e9320c2ef6so3185455ad.2
 for <bpf@ietf.org>; Sat, 20 Apr 2024 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713629339; x=1714234139; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=E/WmtljErpsPGSoYf+NBQ+/HwJNg6O75Uptt6hKujQ4=;
 b=EgSfvDSVv/ndd27sYJ06od5WGv+qmtD7S/q+mNaaAdut3mpEhbcMoxr4bsKRHq1uvR
 lG9m55QArKAAIIlVf3k47R3XvQk4mH1IxXSC3fbhdHmksXdAUPD4HNzEIa7AH6ZdYfOH
 SxdlZpAIAohf48NCB1wPF95Ch+Dv8He7MzARgm/7wJYVZ40UnYjGVRxRAskhUqUqzjdi
 a8FmYZ9QKqTrHQkjLUbr77PRP2XmDnb3Q7Bww6ihc4Q2xgQ92s8ZaZPbAAcVnWPJJlkf
 lglC/f8+gNUVBF4plIYd5KKKyPWjKZBQrzCtbC+2UPaJ/3bdMaGhGu9+wv2MOJancs6g
 A86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713629339; x=1714234139;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/WmtljErpsPGSoYf+NBQ+/HwJNg6O75Uptt6hKujQ4=;
 b=WBx2n/9pF6OXZ4s1eDrZrx9fDEE/KE2o30Gh0qsH23IPLsxHBLLSu5TTP/1Zmwmwa/
 YyMyX0/7tscQWpAmx7Klm8SFhBFvdpsKXlG4ufVDwVGDbzHlAAb5AugRurszYottBYnb
 z0KpdXk759BHPyHJRINRonH6OfPKDdr3SzOK54tWBxW+S+9T8y0qyImxwuSIM9450n3i
 vjhMPGr9TSkN0b9Aq6HE8dDPUyN0bgnxsCEa+Yg9G1o7oVHyijIX6QZaDpNgGXPlkt7m
 K8BoMsPyYVBDS+c/R/Tkw1hTy1rWNCY2Hqa9Oa8mhefio0TdFKmYpZicU26/XTmVR5JV
 G0vw==
X-Gm-Message-State: AOJu0Yx86LuPrDENNjTVEFyALHWso635+KTbnAVsbD35QwzIKtEwW1gS
 hebKnA1BpefNbsX+nxy9gCB33iOoaphOVA2CqVzPjEefEfBJPfIvfzTzbRCd
X-Google-Smtp-Source: AGHT+IEC+tf+O7t4uAXZEPvdFLa+pRZDDtdgrjZeDDMxbyiGnoM2e113+fi2HXf5vXIPj2TUNWDmZg==
X-Received: by 2002:a17:902:f78b:b0:1e2:1915:2479 with SMTP id
 q11-20020a170902f78b00b001e219152479mr6890395pln.12.1713629339222; 
 Sat, 20 Apr 2024 09:08:59 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 s10-20020a170902a50a00b001e0da190a07sm5230358plq.167.2024.04.20.09.08.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Apr 2024 09:08:58 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
Date: Sat, 20 Apr 2024 09:08:56 -0700
Message-ID: <093301da933d$0d478510$27d68f30$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdqTOqUAZKicZw8rQGyj6y+Q3f6+eQ==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ep1ry_n82ORKtRSerr45CwcM570>
Subject: [Bpf] BPF ISA Security Considerations section
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

