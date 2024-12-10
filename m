Return-Path: <bpf+bounces-46486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED029EA717
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AABF1628F5
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF16226171;
	Tue, 10 Dec 2024 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlfgo4Jv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3C22578E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803879; cv=none; b=O2gGxUp+yzrmAEgRsUV33h94BB6CyPW2ENNpf4PhsrPBjZJsAUDvGVdAODs144JHlER/Scb6h5Qa7hok3PYWzDmBLjNtMM+Vwzbjy1b2p+dIpLl0v4uhn6rcZZMB2zMMRc4hHdzeHer6xcNrHGqh+gyFZeQ5dB0EtqZ6COwPXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803879; c=relaxed/simple;
	bh=lW4mQ58JGfw7JGH8bL/drjsNfSgfvzBEqWD7FVkfokg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpouwxZDe2GSaXzUXHE8hetNy7jGt8ibttrhTvYDsj3eT5W4+zv16fI31j4s2RXNL6mqV+Nbl9Sugk62QJwqzqnHAeAMuIKQq4LEupv5C/JO+c5ZHeUGa9o5SQorhOAaoVj9dkvbxsUI3DaVGsISaUUlsOHkECiZ0sl7BanbPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlfgo4Jv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216401de828so17383365ad.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803877; x=1734408677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VTXn9EJbSSdNCqgtyoG6wj3OIgIOOdlJuFJ/UTprec=;
        b=Jlfgo4JvXjnCpiYY8K6/U8q8P36jf60QiKHvG9PXVl4yIawO5jR6PZewX/YMype1s3
         ExaxoduHHGf0xxloViSnZe1z48FEdcfCica2Z4TacRH6Yp7aeIXOC/DyOl2FQTf5r/ac
         OFk37YeAglcGpu8QXTZxPAqu6YOwrPwF8tryKblGKLalxkx05eyFOU+siePem5BO4iSx
         OQLH9u+9l/+g3ZpKVX+lZUT3OdScfmYsVBxvzuX0ykLeL3K6egpfzUUACmre0gkYiNSu
         BoWcTT3iMjpAe4fflOPgCfMG6dY+kGG61/YNElBPc9iVPFaqdf4qJHIATQ4uqxuh6YDM
         uA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803877; x=1734408677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VTXn9EJbSSdNCqgtyoG6wj3OIgIOOdlJuFJ/UTprec=;
        b=d5VooK9+vMIa6Ee1w8oZ3vIpaeiROMYn1TxYU0LhkbAXo+WOTByXmJ+LoQ/2C+pQLW
         jEQey4FCOJjBzoI0MWOmoC/hYz4lUCQ6QknOn6ToRR3+C/gfFn15e/Ycc0NQHQN56Uix
         oZFmEK1zs30ETTfTctmX12PoUAhfRElKwb2JB/0O9x0mdtv5aV9f7noIwEVh/JqJ6+gc
         NyFpDW2Jx8gP84hRinpzmpPUdTYaGNDMyBHiK+pl79RbevB/W+bFUJ6d6tjEY41s8WYJ
         GvcC5JrlEgm3him4vFFfUGMeX6BtquOHj6mkDspz5zEjvawDLRpNZHggFZb+WqxUJ/Hw
         BeqQ==
X-Gm-Message-State: AOJu0YzYIUC37gz+Hcje9XlBeAhdKqpFbnaEKWeRxnjtl7AlSLxVnBcs
	Au9uOuddVsXNXEGOPkqLCcdHbY3Jo6LEgTg4VRai6FHkdOEeiebdEozVRg==
X-Gm-Gg: ASbGncsy5VXM8ba0PukxtI7FguGi4IOw+XeEj4KGF1t8P/a/D0hTV73bC9jcD67gHbm
	5QWIw37S9CGRR8HDhNVrHb/FsBURHnKmcPbrwQgEZQfQPOn8MW3Ri4hP3YhO+zSlDmk+N8wIHm0
	GOE8zXIuVuwM+qO55VNXtd1oe7sYYccGxIEVGG5aE/2sYSXIMRReIBRa2btkwuKkH0dKDsTs+o2
	lo7pdH9950VsX8mz1yFIMn/7QdwZMWCBUScqFIl38yvIXzF+w==
X-Google-Smtp-Source: AGHT+IHOriS3VG/8eWxi9dabbh1IoJgKUF1psJMpMMPFXkTfDPgVAGa+GyhxXZvf4sdRi8ov21BpFQ==
X-Received: by 2002:a17:902:f70b:b0:215:a179:14d2 with SMTP id d9443c01a7336-2166a0635dfmr42471755ad.50.1733803877066;
        Mon, 09 Dec 2024 20:11:17 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:16 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 4/8] selftests/bpf: test for changing packet data from global functions
Date: Mon,  9 Dec 2024 20:10:56 -0800
Message-ID: <20241210041100.1898468-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if verifier is aware of packet pointers invalidation done in
global functions. Based on a test shared by Nick Zavaritsky in [0].

[0] https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/

Suggested-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index d3e70e38e442..51826379a1aa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1037,4 +1037,32 @@ __naked void sock_create_read_src_port(void)
 	: __clobber_all);
 }
 
+__noinline
+long skb_pull_data2(struct __sk_buff *sk, __u32 len)
+{
+	return bpf_skb_pull_data(sk, len);
+}
+
+__noinline
+long skb_pull_data1(struct __sk_buff *sk, __u32 len)
+{
+	return skb_pull_data2(sk, len);
+}
+
+/* global function calls bpf_skb_pull_data(), which invalidates packet
+ * pointers established before global function call.
+ */
+SEC("tc")
+__failure __msg("invalid mem access")
+int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	skb_pull_data1(sk, 0);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.0


