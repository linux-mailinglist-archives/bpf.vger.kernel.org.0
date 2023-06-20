Return-Path: <bpf+bounces-2936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3B7371A7
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EB3280CC6
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0400B18AE5;
	Tue, 20 Jun 2023 16:30:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743F19937
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:30:31 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8618B171F;
	Tue, 20 Jun 2023 09:30:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25e89791877so2231753a91.2;
        Tue, 20 Jun 2023 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278630; x=1689870630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAQhcd36ZACkATZxiZq5szSI+Xon4GOwdKbkiICwAjg=;
        b=DKahbAEF5rWmYfNxytZBAmdngVIMQrFw3E1D0EfiwMwzi17VX3VXNzqi3hSUbYV7yh
         85QXE6Yc4tilzJ/BcvY1XM1ziMi0C5PnKDHRmuP0vXJc1J9wSEA+/fqN4c5lqrADQebZ
         ia4FnfKE3o8ZxBcQCWstPrSc9EjwndXQjxRt9KGqT8UDmC2Hr5KOXyY0Sabfq9e3Re8c
         zzR1FxsRegwGoGA/L0vqj/P5OpHKCb03IaqoWkuzZorcin76kxRDQ3628PhToKlVpg79
         5hNcmLgbdNe//uD4jiPuN+6g4pSPjO5DdfxiQFEbsGZsIcVe15DJN7UL4PR8ddiokvib
         2THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278630; x=1689870630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAQhcd36ZACkATZxiZq5szSI+Xon4GOwdKbkiICwAjg=;
        b=PZO9SVf2WcD/7dC0piakrJ7vmR6gA+N+VvFcmau5rSuzsGqMmjoMnt16Hqwxjwk+LY
         o+bf9FjH8zIpS6DVaHDmoFMzR1TAMD8gCli9zyVcHtk1Y2c3CGkq37+3daYyq/SfDI1A
         wfeF+dbZvyeR+zNamZcVGS3H3RG2gC0nHfX9wwyr9FFw2mTG/pVh4od/6m5m19G/z2f3
         r2+T5J5+7fMW9X4On54axhQuPwkFf+8uDROV7tHurRf06+G/gfHiEetCkVVJOgjjHkUD
         eHaONrjw6KGZvBGklDi3SwnGhot8Wjh31K26GoVuR463bKlFC3HTiKK932v/p2IIyUI4
         3WQg==
X-Gm-Message-State: AC+VfDz5P7BYq7rPhc/E7bsFWY25LVPmfKVl3u4CKaSPutjISKouLUbJ
	77q0HSRyzwrNREf7QGwDIYQ=
X-Google-Smtp-Source: ACHHUZ409+etT6fEoE+GNlbUmxhwCza62ZoKLuH9rdyEdqHZgGlYj9zhNYZRBwee21cos3uOqUit6A==
X-Received: by 2002:a17:90a:189:b0:25f:982:2d73 with SMTP id 9-20020a17090a018900b0025f09822d73mr3949947pjc.15.1687278629921;
        Tue, 20 Jun 2023 09:30:29 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:29 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 07/11] bpf: Add a common helper bpf_copy_to_user()
Date: Tue, 20 Jun 2023 16:30:04 +0000
Message-Id: <20230620163008.3718-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a common helper bpf_copy_to_user(), which will be used at multiple
places.
No functional change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1295541..6af003d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3237,6 +3237,25 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
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
@@ -3255,20 +3274,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
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
1.8.3.1


