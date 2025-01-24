Return-Path: <bpf+bounces-49669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A86A1B80E
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 15:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BC51889219
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0EF14658C;
	Fri, 24 Jan 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkY/P384"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812F142903;
	Fri, 24 Jan 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729889; cv=none; b=TqIfBimwH18Lcw9vrSilHJKuErR48KotdGrk1OoPgj4WhfIm9lAkp5iCRsLVvpqC3DAau8GTD8GMhIVj1VLx07f1lpIRQe5VTutWSOJBb/Kcr7Fv71++Z2M9V/y/mZDLa7QxHHnB3LReCXtQC/lu45qF1+V5L5UHl1BwGuNLpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729889; c=relaxed/simple;
	bh=sADeObZQ80GVJ8Ms+GOsFTX06KM/CT0ahGO6X0UP6eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NZv7cwOx71sGbzug1YhXpopldQdmsTIzoAoX/MOjtxsU7cyGcczxV8l9fuQBZwo/B70kOwQhug6wSJA31zv+ROUxaELNH5pT9VWOeEbnsK6StUUSEJRwTkOvhQB2y/OGaNwc16G4ApXArlbpJkPYF2KUoRm+12Nb3XFrSDSEs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkY/P384; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165448243fso47300055ad.1;
        Fri, 24 Jan 2025 06:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737729887; x=1738334687; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/dZeTRE5QHhX1HNBAMGfjj8uCpLdJlJkYDaC0zdXrY=;
        b=gkY/P384nEiAausp40o9f03Cg3xFKE/ifCFNS6Wv4y5D0snN7UNcigsZzIi7c9/2T1
         bfLx+gxyEMuwZWbPUprbSgrPCCGW2NR+kf+WKmnSBmVppoYBnw6VMDE85paezSenv3cO
         EOY3dAJjlgitNR7dO9aqAdSpPDIQskFOrioUJEGj2HPevKeDAhvcpw/F6W0cUtk9kPnY
         Na71ISD6dF2icGQ/e5VKd0BoPTyW6lXR21JzsGSJY3XB69WY/XS6eGMzboH++lLox2L4
         ooGXD+i7rBrvBdGegxuvhrBtOWP7eYML5HJTZvM77nt1rqtuCVn0f53By+XUu3tPV+w8
         u8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737729887; x=1738334687;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/dZeTRE5QHhX1HNBAMGfjj8uCpLdJlJkYDaC0zdXrY=;
        b=afRxheqy96Gqf/huEDyXXFCBRD8eACcIR2DMyiV6AeoZmLnSgOOupb2pmKtAyQM/wN
         U0HzC+3J/evmw9jc1a+9pZ2laJdXgSvMSotxPI9KGAAixWCl9Jrs003JP6NJ5vGh1Mqb
         xp73p4cS8I0afjkIAt+cX3LORr8k9Zd2H/w4gOLFX4rxW5/yP8mAkupGqsyEjIBOYMKU
         1/Q6AUISqvDmRIjbUqtVScXxsDRreXWO8e+03oNR//3FAIDSgrD3zGzB/QkOEKW/bDgP
         ZnL6IPhhMWYJTnbOKtCsc/Z5iM4LWTgSoqIPnTENn8kqAL0GnZNw500MkLTwHe9gXIp5
         J0fw==
X-Forwarded-Encrypted: i=1; AJvYcCXOTrQ+SvWiFBTKvSTleeqvVT4iR3o42wcZ2BfIm01QarWGPMjJ91C26JzmkpGl/ph2kDccm8Fc9c/3NGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKEBr5f5p64fluu6c1gAGHm+T8LgZokFlheh8bLx2V2pfebkR
	NguD8Arbt2NYrxivSDSPOLjJv829My0qMt14zPIPJJ9TeLI3GY3v
X-Gm-Gg: ASbGncto7d6VqVB3tJQ7tUtI4Gm0V2piiCLoerY1kQNtIJFzTCHsUaJ0/e7QmCUnpvz
	VcOwuHG1D/OU3DyyPlmCQHzQiJ7ucZEPa2OGS3TPb7AKo9JlrYid4pf4YPU+MH+C/Ek/80qRNZ8
	HzM6zE433jwZ24Af6mQIA2K8vH1CACMqrX9xdRfZpEaHuXfvrPlnbEzBEVeE82RF+64GoljYp4K
	TTIIAsNk6J8THAs22yffJj6P2BQvX7H8oKGnPBfIM3mRVbPkAX6rB/vazLqUDCJ1D7JypKxXnrG
	gbs/Cg==
X-Google-Smtp-Source: AGHT+IH2CwgeBnFdAYGL45JoTkGnv0BDiXlqm4Cw4oTY/AWlgak8mcVyj6lUtSza8olfidjnYWsT+A==
X-Received: by 2002:a17:903:1205:b0:216:6be9:fd57 with SMTP id d9443c01a7336-21c35551b81mr505718885ad.21.1737729886781;
        Fri, 24 Jan 2025 06:44:46 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496e9e01csm1669740a12.74.2025.01.24.06.44.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2025 06:44:46 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/3] libbpf: Refactor libbpf_probe_bpf_helper
Date: Fri, 24 Jan 2025 22:44:09 +0800
Message-Id: <20250124144411.13468-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250124144411.13468-1-chen.dylane@gmail.com>
References: <20250124144411.13468-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Extract the common part as probe_func_comm, which will be used in
both libbpf_probe_bpf_{helper, kfunc}

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 38 ++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..b73345977b4e 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,22 +413,20 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
-int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
-			    const void *opts)
+static int probe_func_comm(enum bpf_prog_type prog_type, struct bpf_insn insn,
+			   char *accepted_msgs, size_t msgs_size)
 {
 	struct bpf_insn insns[] = {
-		BPF_EMIT_CALL((__u32)helper_id),
+		BPF_EXIT_INSN(),
 		BPF_EXIT_INSN(),
 	};
 	const size_t insn_cnt = ARRAY_SIZE(insns);
-	char buf[4096];
-	int ret;
+	int err;
 
-	if (opts)
-		return libbpf_err(-EINVAL);
+	insns[0] = insn;
 
 	/* we can't successfully load all prog types to check for BPF helper
-	 * support, so bail out with -EOPNOTSUPP error
+	 * and kfunc support, so bail out with -EOPNOTSUPP error
 	 */
 	switch (prog_type) {
 	case BPF_PROG_TYPE_TRACING:
@@ -440,10 +438,26 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 		break;
 	}
 
-	buf[0] = '\0';
-	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
-	if (ret < 0)
-		return libbpf_err(ret);
+	accepted_msgs[0] = '\0';
+	err = probe_prog_load(prog_type, insns, insn_cnt, accepted_msgs, msgs_size);
+	if (err < 0)
+		return libbpf_err(err);
+
+	return 0;
+}
+
+int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
+			    const void *opts)
+{
+	char buf[4096];
+	int ret;
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	ret = probe_func_comm(prog_type, BPF_EMIT_CALL((__u32)helper_id), buf, sizeof(buf));
+	if (ret)
+		return ret;
 
 	/* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
 	 * at all, it will emit something like "invalid func unknown#181".
-- 
2.43.0


