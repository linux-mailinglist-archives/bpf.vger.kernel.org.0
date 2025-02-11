Return-Path: <bpf+bounces-51138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD5A309C8
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7C516196D
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF21F9F61;
	Tue, 11 Feb 2025 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPg+GKGh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B91F8BB0;
	Tue, 11 Feb 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272749; cv=none; b=LeXPtNOTr9mqW/eHBMgaEhFQF7UFGkGcWfahobYgtUNl25v6aR+GtglO4OgsTmCH0yhOapd4DvF5teldE/vziB4axRJMAZGQonteFYqxe3mtv52txg0PuOYDLM01NiS+0ykqg/Ybha8Qv52j1QVDWhdcZTJoOCUXoit3RMSy4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272749; c=relaxed/simple;
	bh=gCSkhghV4FSQv8s+RD3+Va+foCnFjyb66eHvLgkiuWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Hx7LsADR+F0YcnpKH48VduY7nmGC3hSc4sY329l2RWvHK0cCKa3+Khs9ztMIntuzfhSxo030VlY7PYg2xEuuxDXEDQdjMLPtzjwoqiQqwubObUok6Oyr7NM9FMIK07upMP3MuWVpm7XFy9V0SlZyDkXLTGjsJqh/QNNbk2DLyUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPg+GKGh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f48ab13d5so88106965ad.0;
        Tue, 11 Feb 2025 03:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739272747; x=1739877547; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3SRCkrYu/UmXO72yLMKra7PMrlLBZ+7UhvcccuRgDqg=;
        b=UPg+GKGh719LyRpa4SQpnVKZgO3x2IeOrJdgcvGqeNaq1oTV3P+jjg0iFOuPh76Wjc
         2DXxhuM53+J1Y3XDOaYDucW0U9rgZvp8lQ0XtD78el8ThMGkwgIxMT6GCeyHgYR+IX7O
         O297IWqHNFhxhD0CAym+yi3r61zHkZ5KW+4K0fZkN/alIEouNmyAAz+baX3vO3NFFOCJ
         gT2doIWvtxmdJVo+U5O1lbffIbyfO2bfiTOI1u3Oi5GGJrhk7SiGX9DFJgylMbBp2OP+
         acYl8dzKK/Up6QrouaIGMPDJBzDDPRGFMgARWgk87XLxsns6SdsY1RFWsDc3D2sMMIZw
         eksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272747; x=1739877547;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SRCkrYu/UmXO72yLMKra7PMrlLBZ+7UhvcccuRgDqg=;
        b=COWdmaZshTPdRfpv8R3mO7QvDASgxJjZvr3zGUT3YoM3ZBIBjJUsxbZVoE6rDkh44b
         vt/IgxvLadkIlQmwfRMOct9RwoDY/z6Fy0meTLsibFEnTXX1n84jQM9kenw47Rxa/BH6
         5leSROKRpQbvF/TI7CVwdMb+tW63UMiMsOx1lvXn3tLbHnyrHqb/pSk7Ov5epSoHL/JD
         LcVul9H5IuKiBBRlLN4oh+2vKgwqr4Oa9M9+SA95iMWHSAUOLA/I2W4+f4IvEeuVsenv
         MnueBY5gWKXjBPoRh+wH2pHx6fyaj+TDe13u2m7Gal9eKBXuKwCpGD6pX/vchpDFBu7g
         MKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7J8KthWIDK20N/5N5TsuspVzBcTFNp0etm76n4UGQZQvhcqouN+wzwzM8Jk1v5IpKuD+ao8X85UycPQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRp7Gb4gdFI/c9f2NfGo/RXURyDAggghSbotQWFZnFy5chPR2
	A6/1IpIC15VyOpaEuPFLkIPmUpco/NqdC0tGGphHulwL0AzLkgrqttCpUw==
X-Gm-Gg: ASbGncu8tQrukNic08giaCKSvqjDuPZrxdR0qHUTg9Pz8wZHjduuWIKNzxkR/pCMC84
	yocjld+gvwNO4eGt1+dxO5RmLjIZI5rrlZbSGjWesJQVXO3FgxxxQhjITMQJzv2v6659AK1cvY4
	G3Z4ui8P+mutt+b01gtYxjHFih0UeoSNvf6bp7N+BuiGMVDPqHtEgQXV4I/7r7qtNJma4ULJxML
	5DzceTshzWZe+I8ZuBfR9ketwAA6oKatpre2lsYyZsdH+t2UeHwamtgRUH6bGNOJREtFSRNVqpT
	BUFzCK+CwXGK/rCk
X-Google-Smtp-Source: AGHT+IFXhoTlIoHXmMzobJotR7aBVRNPcGpCrw35HZLZvwdW4hmBcdiTCXeN5GkhSYrEE09urKBSAQ==
X-Received: by 2002:a17:902:ea0d:b0:21d:dae6:d956 with SMTP id d9443c01a7336-21f4e6e1eb8mr285806775ad.24.1739272746717;
        Tue, 11 Feb 2025 03:19:06 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b3ee47sm10406298a91.39.2025.02.11.03.19.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2025 03:19:06 -0800 (PST)
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
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v6 1/4] libbpf: Extract prog load type check from libbpf_probe_bpf_helper
Date: Tue, 11 Feb 2025 19:18:56 +0800
Message-Id: <20250211111859.6029-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250211111859.6029-1-chen.dylane@gmail.com>
References: <20250211111859.6029-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Extract prog load type check part from libbpf_probe_bpf_helper
suggested by Andrii, which will be used in both
libbpf_probe_bpf_{helper, kfunc}.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..aeb4fd97d801 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,6 +413,23 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
+static bool can_probe_prog_type(enum bpf_prog_type prog_type)
+{
+	/* we can't successfully load all prog types to check for BPF helper
+	 * and kfunc support.
+	 */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return false;
+	default:
+		break;
+	}
+	return true;
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
@@ -427,18 +444,8 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	/* we can't successfully load all prog types to check for BPF helper
-	 * support, so bail out with -EOPNOTSUPP error
-	 */
-	switch (prog_type) {
-	case BPF_PROG_TYPE_TRACING:
-	case BPF_PROG_TYPE_EXT:
-	case BPF_PROG_TYPE_LSM:
-	case BPF_PROG_TYPE_STRUCT_OPS:
+	if (!can_probe_prog_type(prog_type))
 		return -EOPNOTSUPP;
-	default:
-		break;
-	}
 
 	buf[0] = '\0';
 	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
-- 
2.43.0


