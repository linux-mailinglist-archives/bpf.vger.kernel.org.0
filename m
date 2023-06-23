Return-Path: <bpf+bounces-3271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500DD73B9BF
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8137D1C21214
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C97BE78;
	Fri, 23 Jun 2023 14:16:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C09441
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:28 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B161C1BDF;
	Fri, 23 Jun 2023 07:16:27 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1acfce1fc0bso544507fac.2;
        Fri, 23 Jun 2023 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529787; x=1690121787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR64Cmt8i5FJsJGupQTPYJtgTllYuN+cFKijdvjcj5o=;
        b=EQ7iNkE7ti0f7zBc5e//BENDi552fhrE7IpR9u5FeBTGZdzSKCVDhsvM2Aa77gqDcw
         sHKdRyqJcO2vIufs5qlCx7uo6hwODOzuWkI689nmevebIK2EB1ezWJ3brS8bEjJ23am4
         NibywcXiPYFOMaqeMb9/oJo889m0lADlR6hkV67HhHPk6LWx0CJvDmHgyB85yZN5Uxg6
         1D9RPnzxN+LVS20sHas8jQ7F7nu+b29jTqE45Dj3z/+Ta2PCoRGzx1FkjQVeH4Bq9Pk8
         Kop+RjrkxNBSp6X1gt/dU1041lqsn+Wb42D8ROdytdWsycyXSfXv9ZhRbFzrkeoeHYef
         zgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529787; x=1690121787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR64Cmt8i5FJsJGupQTPYJtgTllYuN+cFKijdvjcj5o=;
        b=CmXotASDEYeYgS5EPiFmHMj6kMUh5ckTDZcpxZ9o3XfvBwqvFuJaSa4WANxfJUq7Gn
         57lrQwYLx0B7if9VpMXOSCSgvEJfaPl5cH9c/dFn9uZbc10QcoQ7RWzYpXgvEQJWjJmp
         ogg6mKWjDHRmvInvcwXpSOCHkRdlv5En0YY5OEYfQxWKp974xc9HZIQzf26+VsN6mf63
         ubSsUqBWLfrCVDUhSGuRWXa7XXHwdwVRpX51s+wHEApFWE7uuYvU4KUCoSaMr3dcOp7c
         hwxtHQhQccjDkb1fLAMdwIzeLsVKJevnT/M8IjWwJX1mEXCIymxqQx0M2UiEW6DklMP9
         YBvg==
X-Gm-Message-State: AC+VfDwrPc1wIjDfp9LjKP7aiS7i9ql6spsDujNmOwh4mx2ne6qEuJKf
	m3ypAS1brWp5GKW/fImbWNE=
X-Google-Smtp-Source: ACHHUZ42HZuuQHS2WbQ0zQXjoMb8L5bxZPsRe8wyzSeG/Hj0exEthhJb++8LC4+zFak4KVBYeS12DA==
X-Received: by 2002:a05:6870:c805:b0:1a6:c04a:84ef with SMTP id ee5-20020a056870c80500b001a6c04a84efmr10844401oab.6.1687529786912;
        Fri, 23 Jun 2023 07:16:26 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:26 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 07/11] bpf: Add a common helper bpf_copy_to_user()
Date: Fri, 23 Jun 2023 14:15:42 +0000
Message-Id: <20230623141546.3751-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
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
index a75c54b..f3e2d4e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3291,6 +3291,25 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
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
@@ -3309,20 +3328,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
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


