Return-Path: <bpf+bounces-18684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC38081E92B
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 20:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E77282597
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B0A17F8;
	Tue, 26 Dec 2023 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA4IDJr2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587D1847
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso35419845ad.3
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703617931; x=1704222731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTDFkTaiquOLQBQ36/VOECl2Jd30FPIqWNtMhdRHoyE=;
        b=UA4IDJr277oY1wvYfghyDib6zMlo0IwKSl6Nw1LQC1ylnssVAHTAj0+fFsCwlZkWnm
         syStxZK47yi4kMJMQtsEz/Z8FKtdYWvCxU/IUhzrO+JOPgwUbeBxoVzv54GtmC1XhYpX
         mi31ZCu9OAH/DGSmQqKaRXYUZZIjjF3HO/MqbYZEmCIYAuRUwHHmVnB46QZPSl9Owfrf
         6hqqpciJ2MAO1aCfb7l4YlEqVo/LkfLsM/8tb2v2uTPa4w/tYhcn3PZeu5FJ8WHigOAm
         PMF6rUOxgMA+h/gAUJOOBhuQNPOBLQH1zqBCdrvvJ5Tc2PUhrZQ6VEglxv6xTVB157ZM
         WCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617931; x=1704222731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTDFkTaiquOLQBQ36/VOECl2Jd30FPIqWNtMhdRHoyE=;
        b=PU+RN3XmXCaxc0SCLU9AW9bq83+NrM9FSv6+uH8zWa82nD0VxCPyoKS9TbrhnE8hJG
         9hSoUr20nNOkjOrJ3VIRLcyKnq9N/kVp0z9ypqpwm1ICxl47wFDy2+Gjgfg6ezpYXl1y
         X4MJAx+gKu4QHYhUdUGCnLeVmAPitJUNj4wH2v1KOKRyPQPB53rDPiZNUQJU8Ra7o8TC
         rPEQHq1194d5hNJoaBzcPJnjSebOKgvOreJEPWjFHSHRyuY6FFfoSVKGcaH7j7Ioo9nZ
         KHnhCX7+JJvLXqLP0e+E/h0ORmtNJr756yp8LH0cYpHaCeouDh9Cq9tOAKiOdg/E42UW
         bEWg==
X-Gm-Message-State: AOJu0YwLp4rm/Hnh6oxMNpI0Ft4y9EwD3mTjfmxYAuYPC6evfIv79e16
	d6ZSXipgsxI3tVWodp4/NG5kV3CkTew=
X-Google-Smtp-Source: AGHT+IFADHfALheNVLx0D3WMyQv1X6rTdynWNf7BBGcLiNxyUfo/TPSDrFJuBimH7OT3ydSTD888xA==
X-Received: by 2002:a17:902:d4ca:b0:1d4:6803:7fc4 with SMTP id o10-20020a170902d4ca00b001d468037fc4mr2332878plg.136.1703617931535;
        Tue, 26 Dec 2023 11:12:11 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:bc9b])
        by smtp.gmail.com with ESMTPSA id iw19-20020a170903045300b001d077da4ac4sm10455028plb.212.2023.12.26.11.12.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Dec 2023 11:12:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 5/6] bpf: Add bpf_nop_mov() asm macro.
Date: Tue, 26 Dec 2023 11:11:47 -0800
Message-Id: <20231226191148.48536-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_nop_mov(var) asm macro emits nop register move: rX = rX.
If 'var' is a scalar and not a fixed constant the verifier will assign ID to it.
If it's later spilled the stack slot will carry that ID as well.
Hence the range refining comparison "if rX < const" will update all copies
including spilled slot.
This macro is a temporary workaround until the verifier gets smarter.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4c5ba91fa55a..6ecee9866970 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -323,6 +323,11 @@ l_true:\
        })
 #endif
 
+#ifndef bpf_nop_mov
+#define bpf_nop_mov(var) \
+	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
+#endif
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
-- 
2.34.1


