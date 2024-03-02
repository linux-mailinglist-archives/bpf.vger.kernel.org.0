Return-Path: <bpf+bounces-23237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE486EE0D
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 03:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F8828426A
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030B17489;
	Sat,  2 Mar 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV4SsN9n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300FF6FB5
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344827; cv=none; b=dssAHAZWUnta2jADCZvT0srqOlQ4wq4voMj1Ta5/ksVhpez1LCZrQ2Iwii/P1wSkebL+b2T5JTMVn1z+ArYP3jlvXrM+Pxtro36WNT1PGsNrflHbqngDVllb3s2u9aG54SLQ4C6Kj+M7xlIoY1CA9rbQSkIdgrsK6A9vY7sVhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344827; c=relaxed/simple;
	bh=dfXEAHZhy6jdQ4xwmTIA+k+a5jFU6CG/dcqvpa7co3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnOhBB6QbH2Nlz2NgqHnsKdgKLZ3i1vDpSpLcatvLC/fpjZDHwvFib4C64DOOBWmODSDwJ2yN4zr3z853AkTQ0Z1GcIY6V8DqXNexbLrWhiPE2tv83OKvS1OKhVufpCISw865qEhibhgHEJfxmhoIkRxZALX+ORqi8Z6uvXMp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV4SsN9n; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29a378040daso1921793a91.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 18:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709344825; x=1709949625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5wx9ymqphzfExBttxLv5GhJT6/NHpgQiyl9aEQxmqQ=;
        b=jV4SsN9np655/enCXoqRzdzMNDyZHMBdsu1T+fMoaBTnGqqgJt9sL6/shQzzPHGbD/
         Hs7aM965+KdqyuaTfwmCUEN0nkgHlQlGwdrri3x4CM71NrWHVjg5GYtGFyapeXGEj3m3
         0NmmEtR2NV6vESCzfjYOy+c2Pe+9s0FCNEFuB4IpzWwRMyLZkmyk7hptiTQv39DaQXrs
         AgTCaMTosVR0efz/acxzoxkYBsko5aenoF9W3pFQ77bIyEfRskqBq9D7bbneFcK5rHAc
         IJoIeqJF6UewsNXdfcuA7WEIpnzvmCnMT+bWzBsl6VBjNWoVh2cxu6V4i4EFdxQmHpNA
         4MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344825; x=1709949625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5wx9ymqphzfExBttxLv5GhJT6/NHpgQiyl9aEQxmqQ=;
        b=qsb26lyNEDZOzPJ7iwKCVaCB+TLemcYvRrxS85ExOXq4VidYsWmjC0J0EDRKal/H6m
         Qr9rZnQFvqkL3B5vvsCd7f2eYvpiYndqwYoy706M0Huw4Ds7c/WbqJE9noj3lPNm1yi6
         PnILNlGANwUm/HiXCxUD/cX7M+El1qvXhpl+13y6AWgCerZakztqkjRXa5eP3x0fKBMB
         vDfnCmgvw8H4eWA+uniu620l65k3iVYOFVdVOzUA6kETlMH+1xwrn+i3OqgcBDRP8CaC
         g5obYBgyPtesMAOTlJbMDEAb4AWipsfq34WYVMx1YkZylj2PQjLVQzn+T8NnXalnL+Go
         upSQ==
X-Gm-Message-State: AOJu0YxQ0RPYwcUyCCA0ZdsQragtshYCXZRHIC6RqkWXvc4QWov4dgFc
	R/Bn1Ltuw2smcceK1cFIWYY7UHU6EQENifQofS2alAzJMFvEzQizcHtHR2Wb
X-Google-Smtp-Source: AGHT+IEUz4MaZ51hmwAi5KorrGBNGEAMvOK37aZQ5gK3SQzteou/mdYGS6UfGpNAL1UzQKa4kdWjHA==
X-Received: by 2002:a17:90a:fc96:b0:299:6ee1:592a with SMTP id ci22-20020a17090afc9600b002996ee1592amr2854599pjb.47.1709344824629;
        Fri, 01 Mar 2024 18:00:24 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id oh5-20020a17090b3a4500b0029ab712f648sm6037915pjb.38.2024.03.01.18.00.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Mar 2024 18:00:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 3/4] bpf: Add cond_break macro
Date: Fri,  1 Mar 2024 18:00:09 -0800
Message-Id: <20240302020010.95393-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Use may_goto instruction to implement cond_break macro.
Ideally the macro should be written as:
  asm volatile goto(".byte 0xe5;
                     .byte 0;
                     .short (%l[l_break] - . - 4) / 8;
                     .long 0;
but LLVM doesn't recognize fixup of 2 byte PC relative yet.
Hence use
  asm volatile goto(".byte 0xe5;
                     .byte 0;
                     .long (%l[l_break] - . - 4) / 8;
                     .short 0;
that produces correct asm on little endian.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 0d749006d107..2d408d8b9b70 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -326,6 +326,18 @@ l_true:												\
        })
 #endif
 
+#define cond_break					\
+	({ __label__ l_break, l_continue;		\
+	 asm volatile goto(".byte 0xe5;			\
+		      .byte 0;				\
+		      .long (%l[l_break] - . - 4) / 8;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: break;					\
+	l_continue:;					\
+	})
+
 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
-- 
2.34.1


