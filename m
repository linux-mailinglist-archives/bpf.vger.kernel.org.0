Return-Path: <bpf+bounces-49498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AAA19745
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611837A4BA0
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE982153E6;
	Wed, 22 Jan 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTPQlP0s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767C2153DE;
	Wed, 22 Jan 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566061; cv=none; b=kri6uJO/eOeCXr4ahpJAu/7MUDQRSCVW/f8f5xeTL/7mlrbRpMJ8htPSadLU/AlB20MwwyJ94VJMho+B+JDCH8pqTH52jnAtHlPejGB/mnJq9JNqlzY+WpaGwID8y8Y1K+aHLRBpRrlRiuM3KZl+7LoONliZLmxXSCS3L8PDbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566061; c=relaxed/simple;
	bh=tDh/mOS6P7ygFbCpjoHq826cKO7iE1Bzif0WualZ6Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+uFE8sJkRKn0U7o8D7MJZEfUTptrbyil2AKXNkxGQZPDg4sFJnSS/cSQx3+iXhRlqBd/GmFOpJx9HyhdyozLRbr3Ji9T1WtdWiaQ19dTkUmOe90kpY5myTtTSvrI4/gV2qX1ZWHWtd0mSmfEgcKbEPNZSlRJ7ZRwnjMMFZuZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTPQlP0s; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be6fdeee35so421521285a.1;
        Wed, 22 Jan 2025 09:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737566059; x=1738170859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zINL8i15bfcigl3lUWFYKL/YF1uNpTwZIKUV5mY0Z8=;
        b=ZTPQlP0spN3T7k0O9l6liok4uo8yyqsKd9y53kcjA5eNRsk8NIaeENE51wLQ/obLwO
         HDmFrUejQkChPXPn/e0TXKOT8PICsTc3e89aldehNHS9cFR4UGWE+NnjQ5QVjjaKiemj
         EYrhbVAekQDavKMknDZ09deGwhhX0yFrEGY+RXpWdNIdb+6wMHSTo00PaZlQBLysq44V
         gH0GSAMmtVX4yxBUdHUyj3fBrsFPDuSFRM+7Qk7G+PRCA1rflS42eYluBHFqXlp9dQX7
         E5ebGhmWfy54Z8zh6GgL39a5xIf0rH5VtoSVWF8gWawLxovCSq6m+xfvlrCgALaHK0FO
         GDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737566059; x=1738170859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zINL8i15bfcigl3lUWFYKL/YF1uNpTwZIKUV5mY0Z8=;
        b=N2wGv5azi1LF3GEhsfu4hsDJcpUfOkUsZlQANkIGvMVJfmLn5Ae8eY6SP6plMqOdeo
         C1kYCNirk/hm4K5fgyM7yEmjnAyoNhOrxGnoHccl+/OWPWkogCMgAlwwhJB6ALIKTrlE
         d0R6wb5CR1Lj28UP6IF7YaEUpjbVPfQa5o6vHMXv5oH/pa6bBPjZQGeWQ8j0eHH63u0O
         Ye6SpNYGyHIXJPJTcENAFOc+isagx61SN1V9KgdAucJqTGqOwwC3RDpDHQvPjZcLZJam
         nqJ+sbPkFe5LqrJc/gSzUguA1XwgL+di0hWOnPmZA338efBit+dew8f23V1cTkGmd/4Q
         asNA==
X-Forwarded-Encrypted: i=1; AJvYcCVd/fpdCiRs/t4N4r2wSEkXZvdeiVfusSe9r4FRsbmanWODFG80pN2A4Fy+HnJtHrm+Ksb0zIuOyGtkIWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2etAFr8vSFGIPFkiKiJ1PtC+8rs+6fSYMgLCTTiGOaleC+qu9
	yLEatOcKUMIplLZC/JHNcyWmEs8ZT7ELzPqdb0L/Ya5jNTCw7g/OqyDRzU1O
X-Gm-Gg: ASbGnct3j7sVcNhyaDC3tnWJO24pSTn8pH0CqVSufbTn/j+o1/OrWRlY15FG0/DWFYB
	xE9wLLsK3f/eBZCwpJ/tx1sLnHhrFGPRM6TjVnXrTuFbxOWI1xE8WOdjnI+LVSTF71nvo0rO4GT
	POf1AiuaGqQsjEDWOQ0XoRD9zUKTHB711URnJKlMveP2WWRaLA130d7YXdCW0A3snjC58GlXlXE
	BDuM6oziyv+wnFWv32We6oKtUryOnrp0nSQH4HH3etyf3GSkDx2VIwYJPj3C437Ry2a+jn/ETAB
	J5g=
X-Google-Smtp-Source: AGHT+IFPh+gbWNP7KkDyRef18vWnid2Fs5yl4acqrLJWBC8Fd66kqTR+46Dgv0A5im8o6EE0p6JUqw==
X-Received: by 2002:a05:6a00:1a94:b0:725:ea30:aafc with SMTP id d2e1a72fcca58-72daf929f5cmr24289570b3a.5.1737566047372;
        Wed, 22 Jan 2025 09:14:07 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab814520sm11150913b3a.49.2025.01.22.09.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:14:06 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [RFC PATCH bpf-next 0/2] Add prog_kfunc feature probe
Date: Thu, 23 Jan 2025 01:13:57 +0800
Message-Id: <20250122171359.232791-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More and more kfunc functions are being added to the kernel.
Different prog types have different restrictions when using kfunc.
Therefore, prog_kfunc probe is added to check whether it is supported,
and the use of this api will be added to bpftool later.

Tao Chen (2):
  libbpf: Add libbpf_probe_bpf_kfunc API
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        | 16 ++++++++-
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/lib/bpf/libbpf_probes.c                 | 36 +++++++++++++++++++
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 30 ++++++++++++++++
 4 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.43.0


