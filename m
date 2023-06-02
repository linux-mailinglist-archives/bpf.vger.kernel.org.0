Return-Path: <bpf+bounces-1662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B071FCBD
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B9F2816CD
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD78168C9;
	Fri,  2 Jun 2023 08:52:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9214266
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:52:53 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F299EE51
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 01:52:51 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565e6beb7aaso18569827b3.2
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685695971; x=1688287971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl+AK0T9hur52OaYcgWIsqNGxbmTBsbkE2leUjsComM=;
        b=fis+lOWYVR+Qp8IvYCxWvE1IVqwMqxkgtsANnwb2gJnrQaXOjpW9Ah/WnC50ADMv0R
         xd5421CFpLkTpBI9aHvShM9ykeDZEwpSr5tBhcQ7DiIrWGzMDo1rBk5hAe3LK3eCPjqS
         IZsDKpGgrC0YUNlHTTEHWVetROLVOZzyxfnXwWDy7dGKKgjX5xaEU80tBF3ZlnPwYVcL
         iqOZLaTM85/bqFg/NmJY3AMERY5RH5wTvrsIxsy1csIyjtw2HpEOSQxXi+JzN8qcQmuV
         cmj2KI3RuXjgrI1FJVFXMydHpralWsQQGatJtBiC/hUQNR/Rd+ivkIag16sV5TNVr4xt
         IuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695971; x=1688287971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl+AK0T9hur52OaYcgWIsqNGxbmTBsbkE2leUjsComM=;
        b=WhHmxUCHGfuCiZEuX7QejkkwVi0WTG6Sf3QaOeTKQcyoMHKeGM0ylwwGDjlpy0lZOa
         JRWbvoxgkkilVKp/62M76QxL71s1/KqO8zsiXhxmrZMAmnmZVSSsPfUa9wAVznfbMeKF
         o9CiFWPguloNASKvjL9Lcon9Ok+S64lppq2OuqhudGraFCpT1CnNeVKqJB/Lyk4ICrlC
         yUMbmg8vDtrenirVEn8p8jurDAfBgawRJrnAjfKUJv7HF98Q1Ks8QvA4c38KSmBQ/tUB
         nCmABQXo4Xuiv+5i12VjAYD1Kqzo4BNpyTc2vWWcfFYzCjzhFhb0YHRYGucrzPGCwYhc
         6cNg==
X-Gm-Message-State: AC+VfDyiUiNAlCo7iyZNYtbS+Yu0IhI5N5iAZk0lnNIN72wkJSj1DW6U
	PZr0C+ZbHdFwtOhSkZGiJiw=
X-Google-Smtp-Source: ACHHUZ5av1D8Jv3An+z/Zik4XlBO5Z8K+qyV+my4hxX9ldfvZNHWdqPpW1P+a3kjJH+SM4G7V1M2bg==
X-Received: by 2002:a0d:d64e:0:b0:565:c966:60dd with SMTP id y75-20020a0dd64e000000b00565c96660ddmr12751515ywd.48.1685695971193;
        Fri, 02 Jun 2023 01:52:51 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5401:1e90:5400:4ff:fe75:fb5d])
        by smtp.gmail.com with ESMTPSA id b123-20020a0dd981000000b00565c29cf592sm289828ywe.10.2023.06.02.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:52:50 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/6] bpf: Add a common helper bpf_copy_to_user()
Date: Fri,  2 Jun 2023 08:52:37 +0000
Message-Id: <20230602085239.91138-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230602085239.91138-1-laoar.shao@gmail.com>
References: <20230602085239.91138-1-laoar.shao@gmail.com>
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


