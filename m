Return-Path: <bpf+bounces-4518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B3E74C07F
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0381C20915
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D723A2;
	Sun,  9 Jul 2023 02:56:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417F20EB
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:55 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD04E45;
	Sat,  8 Jul 2023 19:56:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6687466137bso2151495b3a.0;
        Sat, 08 Jul 2023 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871414; x=1691463414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EDZiltXtZiRXBISY5whPBCDNVu9JkoSp6hmQC4uk80=;
        b=m5iYDsB/ndZ2LsgP3970+iscf5FQR0VpOpNVZNf3KOuIgrxjQTjlATAmto3t545YON
         0XEQGJn2zcW4KfyDM2u2CCTWpibRRPxdp9JAq+c4VIYNuoMTS2MNavgeHBMuR8fAOGj9
         svaKw4osPWhzUEPNV1goKbUEdTF9Q5Vv5WQSfvZZdJdiWS1eb8aRZDpOolSq47YbdFPl
         DvVB+OX3iM3GFG1QEvQSASPtMLRyBKhlXgpyP+MKPHjzbXmRpLB3Xi3pkTJB+G65ceDP
         LQUeYulesKoilOR+73RRpmTrY8v4Y97yLs8dILdHYdiI/cK13kR1waITCCQ9UlRc1NGF
         AYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871414; x=1691463414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EDZiltXtZiRXBISY5whPBCDNVu9JkoSp6hmQC4uk80=;
        b=QsJcLiIO2eMiecAzKHGEkk2iz56XbWuEaCz8O0h8KUj/d5fcgKhdouxPulHStRm7+7
         akVrGxcu10n2aT/auDBkX+ww5geTdP1k2K2lW/hrb/r99JBrZNz2oQZLSjqcJNCxdul1
         vuxV8i0tP1mqaoU4LhfLMEikBNHL5UV5tBLtZfe4bGh228bBBNlDtvVP5nuCd3K/jG4i
         Wr68L1rffd+2l5fMt+3Oa2Uvm4fG057p0auXt7bBb8PrvDMoBFL6Y6Ja45D1ahIHGtvl
         GO6fEl8PfeaQ0RmxXfX4Duqr8Hug/HMtxq1B7BuXz+sdYPLVfSEX/ara2LWlnT0yaLcd
         wnZw==
X-Gm-Message-State: ABy/qLblqEAmdgn3MaLVPpUzvV3Nvf0u0ORj12nWUDKccnLEckVOl/LU
	EiCoGeVQxQBqFC/qakIlP4g=
X-Google-Smtp-Source: APBJJlE6EFX7g66Yex9oCSgZiT2C/9QHRiiZ1ikFMxThgZ20lIZIK7XhWZd1iFs/IICw6Yf+YJIDmw==
X-Received: by 2002:a05:6a00:1acd:b0:678:5629:fd43 with SMTP id f13-20020a056a001acd00b006785629fd43mr8297085pfv.9.1688871413943;
        Sat, 08 Jul 2023 19:56:53 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:53 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 bpf-next 07/10] bpf: Add a common helper bpf_copy_to_user()
Date: Sun,  9 Jul 2023 02:56:27 +0000
Message-Id: <20230709025630.3735-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a common helper bpf_copy_to_user(), which will be used at multiple
places.
No functional change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..4aa6e5776a04 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3295,6 +3295,25 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
 		   raw_tp_link->btp->tp->name);
 }
 
+static int bpf_copy_to_user(char __user *ubuf, const char *buf, u32 ulen,
+			    u32 len)
+{
+	if (ulen >= len + 1) {
+		if (copy_to_user(ubuf, buf, len + 1))
+			return -EFAULT;
+	} else {
+		char zero = '\0';
+
+		if (copy_to_user(ubuf, buf, ulen - 1))
+			return -EFAULT;
+		if (put_user(zero, ubuf + ulen - 1))
+			return -EFAULT;
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
 static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 					  struct bpf_link_info *info)
 {
@@ -3313,20 +3332,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 	if (!ubuf)
 		return 0;
 
-	if (ulen >= tp_len + 1) {
-		if (copy_to_user(ubuf, tp_name, tp_len + 1))
-			return -EFAULT;
-	} else {
-		char zero = '\0';
-
-		if (copy_to_user(ubuf, tp_name, ulen - 1))
-			return -EFAULT;
-		if (put_user(zero, ubuf + ulen - 1))
-			return -EFAULT;
-		return -ENOSPC;
-	}
-
-	return 0;
+	return bpf_copy_to_user(ubuf, tp_name, ulen, tp_len);
 }
 
 static const struct bpf_link_ops bpf_raw_tp_link_lops = {
-- 
2.30.1 (Apple Git-130)


