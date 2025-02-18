Return-Path: <bpf+bounces-51796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1DDA39224
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5103AB3D4
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 04:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257418B495;
	Tue, 18 Feb 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8+MzaHl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F61ACEBA;
	Tue, 18 Feb 2025 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739853155; cv=none; b=dgQncC2r9FYGZwXlb5IRqF6wRb2rt3KTXmSmHVwJSRaDNeMFU5V4o+6066rM9SWxa59dwj3Nbsd6zJ3HMmk/h2R33+N+O9vBLk+dupa/ErBj3awq75dXg38f0PJbRk0AxAIXQTElTeRWW/D5yg47utZf6N52OXiqHXexLbmVYEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739853155; c=relaxed/simple;
	bh=ZlCxIQ6nLSNKYpFJNe5bVjFTd4IzLJgoQB/l0C4mt9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HY8cvZtZ2NqaMUh1vWUi9c9MgQ/erUzdjyK+UCW03jYbtqg36ZlHNkl0NAtS79mlirkaoIXKlCQbmB7jbhU+Si8C2QdxAeAaHlrVbl+ZMYGSQKBeznAYjjgk7y1MsNaZAykZ/AMINXS7s/69ByZ1Osu8rXH/SBE59lUyI/lH92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8+MzaHl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-221057b6ac4so41065995ad.2;
        Mon, 17 Feb 2025 20:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739853153; x=1740457953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXkc5D8zSe0fz724t/KPS1px8hlKa4AQcyFwB/aU3Z4=;
        b=T8+MzaHluHEFKwbgfU8WXiNXFG8vucAxN+IFdcxrXR3URD7xXv8A253OTRLg+ocPBs
         mWF3CivfdSItH2DcDcwwbV+l7eJW07OnRjWStLkWuq0aWBmAEtSeBawaT0pDA2cMMo3Q
         ZurQxF9tvf/ZHscCMegxMl/FXpduEVTv+K5BSBzi65XJZa9g7UTBvrBM66e4EVaGsZX8
         C+PU8TPizEGgzXg+NKEJ/QcPnNY/6U1k0Sht/I68sNH+mOSvPA+ukZLwDhkQCNj3VAh6
         v9YTB2mvgymCP/mFFugunfXlAUNCKXXePRd1CWkcauVgL3CHZv79wuUBRbd+5ig5kCHs
         E5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739853153; x=1740457953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXkc5D8zSe0fz724t/KPS1px8hlKa4AQcyFwB/aU3Z4=;
        b=TT9EkApnzGAXbEx4UtFYGt1zqBsrpYRUcSZvhN2buAOEkD9yAKcxrvHDE1xCMBF2kq
         A6hfKPw8713Fw1eBirKGSkDUg8xavN642TZNZR5YgKBHyNEOuUCorEqSkUaQS9Pki3j7
         wx4Fzcnp6wHsA3vbEJdgoAxcp99KcnE96AyTXBQlmZFq/wdb8euKGbE1AkUjDdKMF/jG
         Ur4AOJQRP1iX9EOF3tALijBTp8rHKssZ+WTQW8N0dWzijfsV0QnaUhlPsYvqfU0fD1YA
         4BSlKJkpHLtfgkfSNOv0JA8jZNqDzRRD12BCKpUER1Ett/ji0BpfZRyVNvBRkDyyDR52
         xROg==
X-Forwarded-Encrypted: i=1; AJvYcCWlAVzqrIAP7MtFm3CaQEKuVZCKPgr7OXoAKW6kcWo3SA4DlfSsqqwyr8aH0Xb8X5kN7f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbx86gtyeAmor9Z5W5HPRl4FbY/KwiRcwZtL7C1WBPODbkaKOX
	7stQQwXVnirFs7QDzEo2qGmTnIfmmZYOp29FU8Gb32hVqqtmGKCS8jfw7w==
X-Gm-Gg: ASbGncsaP7wyyxIoheOHp2+PGYTO6xw+1X3v304/UHhTPgR1WgqxCVL/0dxmJ05gCHo
	eE+iOultUA1dfcrVWUqyP9Kb3hZAWXt7Y5vRhfDARgrgfIpEqYWLBOndS3PHVRE10+FPEJARNgY
	PJQPOrZWYUedclfdaF/qLI0fbLZ2CIL9ecblcyEn26/MIsTXyWsFDzQ261h2AIfaVtIHnOpCcrf
	FElIHUHUUQMAqNmcZ47zySl9QtXelGtQTNK88OTCQV37B+Y2arj5+AO8Ua/S+RIVO34ptUpy45G
	WPa+T1aedR3JAhM7WpQb6bccgDqGISbv9DsvTTpEOIJ6
X-Google-Smtp-Source: AGHT+IG0PMJ197PoE6O2S7ppmjCksxA0DUXdJ+Abf2BzmR+SqxxroSDzqPMo+/cx0wcElHs9lMqsqw==
X-Received: by 2002:a05:6a00:1746:b0:732:535d:bb55 with SMTP id d2e1a72fcca58-732617757demr19112518b3a.4.1739853153078;
        Mon, 17 Feb 2025 20:32:33 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:304e:ca62:f87b:b334])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326aef465dsm4907501b3a.177.2025.02.17.20.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 20:32:32 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [Patch net 4/4] selftests/bpf: Add a specific dst port matching
Date: Mon, 17 Feb 2025 20:32:10 -0800
Message-Id: <20250218043210.732959-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
References: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After this patch:

 #102/1   flow_dissector_classification/ipv4:OK
 #102/2   flow_dissector_classification/ipv4_continue_dissect:OK
 #102/3   flow_dissector_classification/ipip:OK
 #102/4   flow_dissector_classification/gre:OK
 #102/5   flow_dissector_classification/port_range:OK
 #102/6   flow_dissector_classification/ipv6:OK
 #102     flow_dissector_classification:OK
 Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED

Cc: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../bpf/prog_tests/flow_dissector_classification.c         | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
index 3729fbfd3084..80b153d3ddec 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
@@ -542,8 +542,12 @@ static void detach_program(struct bpf_flow *skel, int prog_fd)
 
 static int set_port_drop(int pf, bool multi_port)
 {
+	char dst_port[16];
+
+	snprintf(dst_port, sizeof(dst_port), "%d", CFG_PORT_INNER);
+
 	SYS(fail, "tc qdisc add dev lo ingress");
-	SYS(fail_delete_qdisc, "tc filter add %s %s %s %s %s %s %s %s %s %s",
+	SYS(fail_delete_qdisc, "tc filter add %s %s %s %s %s %s %s %s %s %s %s %s",
 	    "dev lo",
 	    "parent FFFF:",
 	    "protocol", pf == PF_INET6 ? "ipv6" : "ip",
@@ -551,6 +555,7 @@ static int set_port_drop(int pf, bool multi_port)
 	    "flower",
 	    "ip_proto udp",
 	    "src_port", multi_port ? "8-10" : "9",
+	    "dst_port", dst_port,
 	    "action drop");
 	return 0;
 
-- 
2.34.1


