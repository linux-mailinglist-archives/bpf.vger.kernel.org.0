Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EAA4377AD
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhJVNJm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 09:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhJVNJl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 09:09:41 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2962CC061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:07:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t184so3263433pgd.8
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1DEvjS9aiuILbVD403rQL7cOozCIYtiCbVqNxfmuDw=;
        b=NmY8pLBcszUAuJdaWVHOpwEVi+SQh09vQ6QE3pXfLNGil+G+3qXx9Nwoj+ZULGy4vL
         lixgAa39qUtcXx5nhrpWkP/nbkB2esRt+DfISlfjk24guqBoImd9jIdrxKtDOelt62pI
         dARMsqBOKru9Y72/XLHAjOF8mUznk5gB0A/4qsbou8e/K4aLz1xZPObF744F8ThTtR49
         bfMvYYE9ZIGkNc+CLNGIqzRKxd8cqCOypFYjrF4hgSvhHqT6YF8AGUO/+lkXsma63xuN
         cGc8FwSYO6Q8lnwjr8MRnfancFsz9jwNEles3pfKxXrkMLWbV2RKLDTmh0XYtv46ItWs
         rMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1DEvjS9aiuILbVD403rQL7cOozCIYtiCbVqNxfmuDw=;
        b=0+H6sd9nSv0v1jXfy3M9g7SissqcoGMoHKXdRTRJZIyU6GdFxsDtGLwM7Wg2FIlDZj
         0q553nb6QUJ9CN2Q2odkuY48bubGUKJ/JWdZEQ8oPc75QzO1HkYW72Mvvq6UXsSjHBn0
         tFypIfT2WE00JRYjn3/9Tf93/JwFcDbN3geP2rFOClkImtZSHK4d/DJOuoV9G/N7+NoK
         ZyAaMlGVvf2Gvj5h+GftJfXLlQj4X18LGV29WRxEKnnXS/lwa18z618Q+zxqJ6E0A9h3
         VR/lhy58A/X+Z3hW47/9mbHfRfORwIwCr5sRlfSsnXlXNLwYPqxgqblInxsSKms9AVW1
         zNxQ==
X-Gm-Message-State: AOAM531jSAJQ72ta8AjL9cCra/YD+m9L05ns4UI/6KtjrMKZxYCt9CuU
        KZ0IDCMyjII6Y41u10EzMtWWgVwRqTpQcg==
X-Google-Smtp-Source: ABdhPJxR3Ql2zBHpvhd7TGSSqhvXUJ1e2SBG6EXNoWiqp7iyYpNQl+is/offbRlWH6xTifB+z5E7RQ==
X-Received: by 2002:a63:2a10:: with SMTP id q16mr8947185pgq.45.1634908041570;
        Fri, 22 Oct 2021 06:07:21 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id k22sm9632083pfi.149.2021.10.22.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:07:21 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 3/5 v2] tools/resolve_btfids: Switch to new btf__type_cnt API
Date:   Fri, 22 Oct 2021 21:06:21 +0800
Message-Id: <20211022130623.1548429-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022130623.1548429-1-hengqi.chen@gmail.com>
References: <20211022130623.1548429-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace the call to btf__get_nr_types with new API btf__type_cnt.
The old API will be deprecated in libbpf v0.7+. No functionality
change.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 716e6ad1864b..a59cb0ee609c 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -502,12 +502,12 @@ static int symbols_resolve(struct object *obj)
 	}

 	err = -1;
-	nr_types = btf__get_nr_types(btf);
+	nr_types = btf__type_cnt(btf);

 	/*
 	 * Iterate all the BTF types and search for collected symbol IDs.
 	 */
-	for (type_id = 1; type_id <= nr_types; type_id++) {
+	for (type_id = 1; type_id < nr_types; type_id++) {
 		const struct btf_type *type;
 		struct rb_root *root;
 		struct btf_id *id;
--
2.30.2
