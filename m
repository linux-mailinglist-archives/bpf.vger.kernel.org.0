Return-Path: <bpf+bounces-2108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC17727CEB
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99DB2812EC
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3BDC8E7;
	Thu,  8 Jun 2023 10:35:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B7C2D8
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:44 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDBB2D40
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:42 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6261a25e9b6so3410036d6.0
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220542; x=1688812542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIqt3XjrxTuvqftnfbbwKPC43OuqsK9HXwQWl45kfGw=;
        b=VRiEIaCnTG+l/hJr2yVr70HRushuOzGKtPK5YS1kvvbOocQSvPg2i74jF8SqDf+Qvx
         7hoRvGo2y91N/myHpJEdwg+kU9vy0uaZ5P68JRN91Urmom2nbglZxYTAHdAms6rRRw0V
         R5WifonjLDUOgZUEswjCtX8l0J81Opn5Xb63Nm48qdHRTFTacHTVBxInAoRS66HVJyYB
         VbgO/uBVwU68AF5lNFTTyEQIInSvccKVsTg69CMP10fy/Ufym66yF5b8uiHznDfY7p1O
         2LCQx4PxBiSaYLwRDWi1rNGMGkH9zszLTStGH8ZoGVWY3to3Ou7Yn8E1TE6pMULGdfMt
         hODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220542; x=1688812542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIqt3XjrxTuvqftnfbbwKPC43OuqsK9HXwQWl45kfGw=;
        b=jvpQJtir5t1qFvjuXkTJd7wHYp2gQvcPx9CDFaQUfGMsZomywVwaTKFxF/gWzPvq1A
         CZ2PsBH9QXHoILlpqlulclVz3DoFtnH12ugi+W0USZDO2TfK7OzCKtdEGzhKNm9H4rsf
         2VRcN9o47xDtcV/t4mF8IC0dScYfOx3HTvEsnLxzEvfKimRHbcHxtDXKQWZBGSLiVqD7
         BBq/JPMtUXCBOaqjI67JGd2LOPNRs8fciY8kpgvjVHp74ZBmdhhHKTlhRTpW8vVQRKq3
         Zw3ymB9yeWdgh5auWCccgMEe7jhPP2OdzD7wznDqOaNmXQ/SIyhLnzvyB953ik39cc7X
         tEWg==
X-Gm-Message-State: AC+VfDxaUkYVbPtPNLlEFF+CMg43QZyMqvK8MUhsfldSMi3aa2wp+QDf
	wkPCTWJU41+VnwAvfnR03CU=
X-Google-Smtp-Source: ACHHUZ4Z1piJ2Cl8qfLVcTWUnFRMW9Y8J6USDZ/m7r1qjiJd24ZvFkCar3+NHpBez97KtH+bBNyfdQ==
X-Received: by 2002:ad4:5c4b:0:b0:625:bf3e:4d7d with SMTP id a11-20020ad45c4b000000b00625bf3e4d7dmr971587qva.40.1686220541952;
        Thu, 08 Jun 2023 03:35:41 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:41 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 07/11] bpf: Add a common helper bpf_copy_to_user()
Date: Thu,  8 Jun 2023 10:35:19 +0000
Message-Id: <20230608103523.102267-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
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
index 92a57ef..80c9ec0 100644
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


