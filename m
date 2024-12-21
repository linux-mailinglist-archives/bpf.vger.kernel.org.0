Return-Path: <bpf+bounces-47504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB699F9DBE
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330467A268A
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163653FBB3;
	Sat, 21 Dec 2024 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROpvj3qY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C625765
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744371; cv=none; b=dpGjfVQRJvfXF3QUASHBZ8/ZLCLEMlVGPBtGLciPhhXb+sny1HzlsfxcxRcGXmq2mHmBSC/MXx/C1fUVuEzprydhA6C2UJgsyKxj0ZNDBpv8iKnITx61LwoTxU3IJ65w2RnfsMIIUagrTzyGM8fUHojPgRJmDEcfjUDvzK3f3xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744371; c=relaxed/simple;
	bh=DLpv7tN8tWj9GmuppCeHTKMXzEqGVF0ivwjlaG3AhNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UY6Wvbpc1BqBADbbb9OjVr1/XO+d9Gb/jxrojhP4Vr3LVNDVn7RGubW2EYI+Rtzt5vSbtQ7FmA/B7GXB9vMq491WLII5RRUNNqyRemOpdCkAPyMiPKv2SN0kmKIBbt7mk/uxEZoPdVrMvDisxcW/rMsXcf86jJcM0inlv6jVwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ROpvj3qY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21632eacb31so17169315ad.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 17:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734744369; x=1735349169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bytesDbDVUYNBSRD3xSwDN7qmEeS7owIZnIend2YERw=;
        b=ROpvj3qYEFoDH31hwu/YBOXN8EsnTWdJdcPJ2SBG7nJxXbjaEx18f+ZEWkUVj1KKSW
         o+6Zb0+gmkhGhPViD9K5E+gwdzg+CENMbqIIGBU2QF3BuHCP8J3f3xgSHepeSDtt4KNy
         3FPXPN4I73f2pZdM+iZPYZk5+YdmpPEhI3njFyfQA2pjG0EfLMFeDFSecHuKWV0j/QzM
         29q4kyKqQ2ey4rtKL+XWDdNw0K93UnZB7NOX/hCrqGo3yo2dMEd8n8UL514U6R7thrGR
         AAoyJdlxTwckocz4lgDYgtJs0fkCYnq/oe+rYh1ydzruP5QvvoglUj4SeG+xkxhsk0MV
         +ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734744369; x=1735349169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bytesDbDVUYNBSRD3xSwDN7qmEeS7owIZnIend2YERw=;
        b=wf+/tXmW8G1TEpO8crcBejoO28mlvyTD1t52tN4noFe/iHrkBTrjZC2ClLTm5dSzW+
         kZ4itaaffPjXIgAiPJs7tgYFsQ7FsTM3aZ7rSZ9q4idKnwKH7dCPi0X0nBYLjyHPmh+N
         HCSgtlQbYI4vhSTCim9rYJ7DZFV32s/ezenUo5a7DBJQ/zXE2Y6UbCuH4Q1nQYbRWl0r
         5q59koAjI40Zj2GidoAE+IRrmBlveYM2kMQeJVPAEb58kM6dN6p6L9IsLuRL4zrGwReJ
         K+GOtr5WN7mDLrOk4zGg5C2jEe9JcLnxfmtzH9VbZavbruHwRY96najJDchwmSSZ865G
         eX8A==
X-Gm-Message-State: AOJu0YwNr8OJfR0H2U9iI+ww3fedzb701n3uWLbhg7LPBKo3OnzGcU1O
	HHh7cx7CSR2+kCWX+RM9edfezh5oalNpgJ0JmSw+g3za8rx10kwUX00U5K0aICP+2JsqrNYS+j1
	mybI3UqzKcF6U6DwyiLnCS1PWcdj2x/0mhM6QAR9dgk5CdDCCOFjDjRwI0mFZFOoRF7ixP7t9c2
	y1RNQYKkI95i1lyIex0K+rvVFcvK1vrVPuNQieq2I=
X-Google-Smtp-Source: AGHT+IHYk9A9yRfGSCHIhMa9AwDi+tWyoGUU43W6BZLFLwohK9iNEKLbcMkTYl+xrGSNlL3eTaKbUcNGwhS/ZQ==
X-Received: from ploz22.prod.google.com ([2002:a17:902:8f96:b0:216:4295:2584])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d546:b0:216:4e9f:4ec3 with SMTP id d9443c01a7336-219e6f2eb8fmr79334885ad.39.1734744369464;
 Fri, 20 Dec 2024 17:26:09 -0800 (PST)
Date: Sat, 21 Dec 2024 01:25:57 +0000
In-Reply-To: <cover.1734742802.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1734742802.git.yepeilin@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <b59b9954a5bb8ee03f1cf8924a89bcd4b475511e.1734742802.git.yepeilin@google.com>
Subject: [PATCH RFC bpf-next v1 3/4] selftests/bpf: Delete duplicate
 verifier/atomic_invalid tests
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	David Vernet <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Right now, the BPF_ADD and BPF_ADD | BPF_FETCH cases are tested twice:

  #55/u atomic BPF_ADD access through non-pointer  OK
  #55/p atomic BPF_ADD access through non-pointer  OK
  #56/u atomic BPF_ADD | BPF_FETCH access through non-pointer  OK
  #56/p atomic BPF_ADD | BPF_FETCH access through non-pointer  OK
  #57/u atomic BPF_ADD access through non-pointer  OK
  #57/p atomic BPF_ADD access through non-pointer  OK
  #58/u atomic BPF_ADD | BPF_FETCH access through non-pointer  OK
  #58/p atomic BPF_ADD | BPF_FETCH access through non-pointer  OK

Reviewed-by: Josh Don <joshdon@google.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 tools/testing/selftests/bpf/verifier/atomic_invalid.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/atomic_invalid.c b/tools/testing/selftests/bpf/verifier/atomic_invalid.c
index 25f4ac1c69ab..8c52ad682067 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_invalid.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_invalid.c
@@ -13,8 +13,6 @@
 	}
 __INVALID_ATOMIC_ACCESS_TEST(BPF_ADD),
 __INVALID_ATOMIC_ACCESS_TEST(BPF_ADD | BPF_FETCH),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD | BPF_FETCH),
 __INVALID_ATOMIC_ACCESS_TEST(BPF_AND),
 __INVALID_ATOMIC_ACCESS_TEST(BPF_AND | BPF_FETCH),
 __INVALID_ATOMIC_ACCESS_TEST(BPF_OR),
-- 
2.47.1.613.gc27f4b7a9f-goog


