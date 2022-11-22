Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5246332DA
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiKVCQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiKVCP7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:15:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E82FE0CB0
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:15:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b17-20020a25b851000000b006e32b877068so12626228ybm.16
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0CYFA8id+z3HCWs5kIS2LaBGk6W/Uf1gWskynavTxc=;
        b=ShxBlDIAwmGqs4fi1P8OTQDitIxkzNdyy6obpBx2DiuBICfglgIm/sEJ56k72mcrDk
         7sLoBmC3BCBKNBVTw+a5yisI9f+LbrX/R2U/hPfRfpMyfdvSp6UftfpxF8ptuAxhR1Mc
         QGRV0dQNmsWkVelI+ut+E9YXVVVey/xFndnaY0+7hsgFk0UClNwfx7uB/GiuIE3WJxKQ
         1tWaQL+uuqyCVQsmD7uv1PiRFexy5YwGgOZ9H2D50koMDi22pO5sT5Kyfhs1JNRKiAwl
         aIbAYznQ2PAOlxao5zbdAc37GRH4JJZVovarG4GlgWKkZq84useB0vbbhW6mKS1ak4Gp
         rFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0CYFA8id+z3HCWs5kIS2LaBGk6W/Uf1gWskynavTxc=;
        b=M21ZptznvCIAIl8sEHPKcyffZ1WYYfGvDk8q/mGzDMmffgYms0h10Z7t5XTmqFY0PC
         AlyF5SpHRguguKxCz5v4yaJeVqSPo4s9ZdfuNAUO6omQpJG0BUyx7UUQbpZUsM7bliny
         GjQgW52jxDLzULbZXaHyMIqs9WztR0YXTWCmgh8KXXtOzqFSAOVADJGzIAc6inQpGbkp
         5qy5KCO1Mm1deJvkrQF2bBI3vCnM9CvMT2TC6NwfwEOWQqsk1Ql4sGHi6Z5Kev1zrFRS
         B30BWsOWrFoaYub7d3vmLt05w73u0hOa78ehLEZhpiWMeyHJCQ8kjWi9hK/W93lqia6x
         wiSw==
X-Gm-Message-State: ANoB5pmnO+0MYTAOnfAJS7bdgcnU6b/haRJZ42hQlD1uQaNBHz3dSZ2O
        J4RZC3IgIdnbzVdK3+phLbzzle+mb7A=
X-Google-Smtp-Source: AA0mqf5Qa1+oao+nkSGR5uF4SNsNwocRj9uOPh0IhMr0Lv2HxEcrI6FPMQ8VuaivB5WjRzhmz9adJH/pD3Q=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a81:994a:0:b0:36f:d061:dfcd with SMTP id
 q71-20020a81994a000000b0036fd061dfcdmr1364844ywg.188.1669083358500; Mon, 21
 Nov 2022 18:15:58 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:17 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-3-drosen@google.com>
Subject: [RFC PATCH v2 02/21] fuse-bpf: Update fuse side uapi
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds structures which will be used to inform fuse about what it is being
stacked on top of. Once filters are in place, error_in will inform the
post filter if the backing call returned an error.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 include/uapi/linux/fuse.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 76ee8f9e024a..0e19076729d9 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -576,6 +576,21 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+#define FUSE_BPF_MAX_ENTRIES	2
+
+enum fuse_bpf_type {
+	FUSE_ENTRY_BACKING		= 1,
+	FUSE_ENTRY_BPF			= 2,
+	FUSE_ENTRY_REMOVE_BACKING	= 3,
+	FUSE_ENTRY_REMOVE_BPF		= 4,
+};
+
+struct fuse_bpf_entry_out {
+	uint32_t	entry_type;
+	uint32_t	unused;
+	uint64_t	fd;
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };
@@ -874,7 +889,7 @@ struct fuse_in_header {
 	uint32_t	uid;
 	uint32_t	gid;
 	uint32_t	pid;
-	uint32_t	padding;
+	uint32_t	error_in;
 };
 
 struct fuse_out_header {
-- 
2.38.1.584.g0f3c55d4c2-goog

