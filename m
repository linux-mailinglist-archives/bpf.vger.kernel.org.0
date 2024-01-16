Return-Path: <bpf+bounces-19687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D2E82FC63
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9FF28EE92
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DD02577B;
	Tue, 16 Jan 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YeYQRTBl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533525625
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438549; cv=none; b=LQVKtgkGOfCQ8WT11Kcjo2MwwquQH+MH6biLVJMU+KpsZQoIK+TqFm9K06Rf5ZzI5pQi9bUumZmejBC7j+1awJkCWEDsQeqVAIpFgUe6yXkSUVAt5qG8ggJzzFdIcW0cV1bz2bMQy5h+6PzT2rgFMPjVZtVSXEl6hTQT57u85NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438549; c=relaxed/simple;
	bh=DlZXQSEO2MSyZETuO+rcAWhvW1Ag1UJ2TRevGaH/dqc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:Thread-Index:Content-Language; b=fXf6BCNhjTfXmj/7QxKno9kUusCc3CHraj7IBL7Oytq9dZy87ufOoHP6P2WtekZNzXpOC7+/Fj6FhVgazEM/08VozWbEdC3GUqxEgr756w54SCai5Zmnhb2cxepJ3m13NJ3G6krRqAHytXo1CBl0L5a++ZOTcHxygOBUuxO3iaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YeYQRTBl; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd5c4cffefso4421241b6e.1
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705438547; x=1706043347; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlZXQSEO2MSyZETuO+rcAWhvW1Ag1UJ2TRevGaH/dqc=;
        b=YeYQRTBlQjrz0kG4V8g70c5LK46rigolu+AcWDyJuoJOqVOLoC1n0Q2oRi+ocpjyNl
         CuYD1UyGy6JGG4fjFAfBG4XjesPSORJYrKLSFYUP9oZAi+EfWiLC4vaNbV+/gWwTVw3/
         WPFFq94aqWhtNcmlHOwPTDRVVFLrh3fSvzL2NIGtlnilKgkBRL8QxgckSr3EjAnQRegd
         WZ40VQeoJY4RsQzEsORta0oIAPKOpMI6rVvBI8WOBugT/kk9bCjdfv2eZ65SaZxnGrpO
         bYC1rny2t1hHT7Tff3LRrnbSHvjsYWFeA7vwlu4lfT/XIHEK7suDiqYc5H7MkNyc2HQN
         Ca2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438547; x=1706043347;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlZXQSEO2MSyZETuO+rcAWhvW1Ag1UJ2TRevGaH/dqc=;
        b=mLGD4tn21hO58l/+KzI8AhfPlpIczGhAOkl5BaLnXHnf1CoBkTJZVyhXQs89i0FOSz
         AnqRlCwwA/IgEY+rcGxnAb9AA/Ke9yI6C1OSJ3zh2l9zAt80iVcqJnA4wUKa6g4Wprmr
         obmL38k4DY9Qj+C6UvTP9smj8aXXw/QbzSydv49bpRr9CBoeTQERPz++n2Ljg9iM49J5
         UC0bWgjeSro7ESRQKnkCCpczU7ZvnKHy7GUb1YXZHIGnbPO6Lwo7+HmYZeQ51UY2j2DD
         259NNRPLjCvfv+Ue+dcGnGmzPRQK+0qkw+J7Fg/Y/HNewnbSItr76dmSxa7LDje0z/sG
         Qxrg==
X-Gm-Message-State: AOJu0Ywu80FJzOl61mUfJmbqE6qi385R48utzjb6knwM1NCraiqPZ2XR
	+T+ea16c1/yyvXGVhXcnyS0=
X-Google-Smtp-Source: AGHT+IG5/DVFmUDJZbosCWeDjP+r3KcPmjIWGwF0M9JDdRAfR7XeSlPbiUQBz/rxrO3D51moiCznPQ==
X-Received: by 2002:a05:6359:2a0:b0:176:57b:f71d with SMTP id ek32-20020a05635902a000b00176057bf71dmr735462rwb.53.1705438547197;
        Tue, 16 Jan 2024 12:55:47 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056a00399500b006d0d90edd2csm18695pfb.42.2024.01.16.12.55.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:55:46 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
In-Reply-To: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
Subject: Sign extension ISA question
Date: Tue, 16 Jan 2024 12:55:44 -0800
Message-ID: <08ab01da48be$603541a0$209fc4e0$@gmail.com>
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
Thread-Index: AQGkwaT1bS2nmU/D6EzqCIA6r6THFLFH+T6A
Content-Language: en-us

(Resending since a spam filter seems to have blocked the first attempt.)

Is there any semantic difference between the following two instructions?

{.opcode = BPF_ALU64 | BPF_MOV | BPF_K, .offset = 0, .imm = -1}

{.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}

From my reading both of them treat imm as a signed 32-bit number and
sign-extend it to 64 bits.

Dave


