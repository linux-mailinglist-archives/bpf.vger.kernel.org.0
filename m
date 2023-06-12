Return-Path: <bpf+bounces-2412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09772C9A1
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDE72810DD
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486F1D2A1;
	Mon, 12 Jun 2023 15:16:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0F19511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:28 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0D010FF;
	Mon, 12 Jun 2023 08:16:24 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39a505b901dso2226159b6e.0;
        Mon, 12 Jun 2023 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582983; x=1689174983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIqt3XjrxTuvqftnfbbwKPC43OuqsK9HXwQWl45kfGw=;
        b=RRBrge+Nhcy7jAZZfCWSZCEKkBAUJAAMz2aCFmpbbsCWrYrEbKCF0cb2HjZ+m+R1FL
         SNfZkE7rcXQLXtwy8RspjrZLAa+ZlE5KXFNUkNfSzvmKXNERbczVnnXrqXVrzO0rN/d4
         1/WD4uSk1CIT48nw5OjiIpDcN01MGitKP6F+c1fF6RsKTNffXcmQgd+VHXMSaOWc04zQ
         EAjjACm1E6GHPuEZP2/y4jdwReH/XMBi2UjQXlFNSJrMcIC0mTNn2WrBGe0nZS1HvRkw
         zgfLzkoHvkeb2qlqGYZ+pO4HmmIlA9U0Acr2wLfSXkigB3OHs7nMdlFnnHR+YIbSekqa
         F2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582983; x=1689174983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIqt3XjrxTuvqftnfbbwKPC43OuqsK9HXwQWl45kfGw=;
        b=L4JNmMCV+jjRpaA6Nynwr+3Pa4U+ufa++rFwazZptS8yGSRoyVMpesmaAGtDopztFq
         +1BPZGX9+porI+cwxR3Vk+WBdLUAQd24jtkrMVeXERL738FPXUZKGrt/mgX8P6iBZZqy
         JLmZOXS45trR/TyaRB2g/jNpsG2+j3G0jjpXOg+bSmfgSrHPZvqbiWzB5YicxhFwBHnQ
         7SB0wG/ImlC49a1xYg2T3XEAlsWasYggZNeGr5e307AEh8AK+plqEMuXsZvPIaDJtEmE
         Ee9Gm7wT6VWHyv4NQL79mXUjBbWfvmSm45vUj0o+E9p+npSO9ccQb4ePvFyNGPhnb3sN
         GOqw==
X-Gm-Message-State: AC+VfDxrDnqDk67ITPst9Nu26sZLlWWfNGv7qj164QVjS4YYYdu5jIVJ
	au+sK2LBqLYA1JnqgS6g2+g=
X-Google-Smtp-Source: ACHHUZ5sUABGNfZQb99E8VCmdyqm2qoyHxDRiC6VqLiE0eqObSsmd2/3igWTRdwf7A2ABCt7SKhP8A==
X-Received: by 2002:a05:6808:1892:b0:39c:785a:9755 with SMTP id bi18-20020a056808189200b0039c785a9755mr5679900oib.9.1686582983516;
        Mon, 12 Jun 2023 08:16:23 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:22 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 07/10] bpf: Add a common helper bpf_copy_to_user()
Date: Mon, 12 Jun 2023 15:16:05 +0000
Message-Id: <20230612151608.99661-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
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


