Return-Path: <bpf+bounces-1365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8924713A0C
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FBE280E51
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E278568F;
	Sun, 28 May 2023 14:20:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B92B566E
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:42 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB9BE
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b0df7b225so148996785a.1
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283640; x=1687875640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m3WbT+7kNIyhOS6++rBbmSoW09np9ycUVNSp6pOAWc=;
        b=lk5ZrpwCrOGLuVLDT3//gA79yQ0PK+BCM9RcKk+1b6JIJur22f4yG0zoE9hgP2olQX
         CA8YW4xNqtptJWPwo6O9uiLIqDDgCw/dwYHVflyizEQqA66zKTz9Zls8eXg0kYfjgc7/
         /3Q4NkYND1ImSjkDaR7i4LazxjKg6uXZfKCu2SZlv+1zF6C3O/Z3mL9uyw5pgz+/YM0l
         j5qIf459U+dKWUZIErDH7SXgRyyy+mQaBUCMxyygy84TadtZ58LuqYYWXS9pqwZJQ19K
         EDhjhiMY/JzAuzkSo8N0t16ZNNo7EHHhWrxu17PabyBZDeN8DXMr2aIKm4uzvGU/HPvV
         KA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283640; x=1687875640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m3WbT+7kNIyhOS6++rBbmSoW09np9ycUVNSp6pOAWc=;
        b=HQB3wkOKEMu7qghXOQlIgMmGOIrgqmmGCsf7vJT6qGAfeXG9I/wmCS2Pq5ZYr1kps1
         XFIVqBQ8/kHKK4WY8bbm84CsEXpE7c6HiuoPULdI6ITXUj7RR0dswAuYeW4AygEy9GS7
         CSK8gLSHLqWozjj88AhyeFG5RogNzi4IzZsLCi93xlIVvf2Q9pUj4dVKTKWMSwjoQQV4
         QMtrTzqSCl0leDCR1zi6eBqtO9zmRcAmQ2uafd78F0ncdVnfB1Yo6uTZQGW8JtGt2bF4
         4XJPtTBoMsHUrax9E42NPCduujVX5284WPwreNZWM4cLo/oAM44GJbkmavRRldAUx7DR
         9IjA==
X-Gm-Message-State: AC+VfDx5i25HDeWENvEmJTHTbLt6qbWq/7OwIjR+9+pbws+rxtZs+tGq
	i+0GfQ4+r4TctiSQoI6X9E0=
X-Google-Smtp-Source: ACHHUZ6Fhp+9nLvYI6UT2Be3F6yZtd09gLtsMXQ6sdHAG0n7eTcylYkRFSrKNqgvlXr8ZQUjhuK6TQ==
X-Received: by 2002:a05:6214:27c6:b0:625:b3b1:71da with SMTP id ge6-20020a05621427c600b00625b3b171damr8372995qvb.56.1685283639878;
        Sun, 28 May 2023 07:20:39 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:39 -0700 (PDT)
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
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 6/8] bpf: Add a common helper bpf_copy_to_user()
Date: Sun, 28 May 2023 14:20:25 +0000
Message-Id: <20230528142027.5585-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230528142027.5585-1-laoar.shao@gmail.com>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
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

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e6b5127..33a72ec 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3234,6 +3234,25 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
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
@@ -3252,20 +3271,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
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


