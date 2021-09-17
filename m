Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9627E4100FE
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbhIQV7F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhIQV7E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:59:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA68C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r2so10870398pgl.10
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNsKiVNd6zCl/MEwp4m+lqbbHPrNeloj/KvUUEFXui4=;
        b=TH18Wi/obelbLMIf0fJUW2Qbx4ltA6oeFhqjkn06nk6xn/jqWviJHKMB/2GqvsZwr4
         6Eyzz6JoRB3SMlJa6jq78mzm+ato6bkM4zup8PNusZOe3uQDrHz0HVRso3nB8a4NnqMx
         SETmVbk7168CwznQ1WSI838TvptQwQutheGvDlwXkFGsWSgoBBmnB7v585ZS7qDZ2i4o
         LhanngQGLXAbtx3b740kn8ign7S4ZIYBY3A1uPbWV5kocWY7pvv3E4SEOS+CVkivUBL5
         oYVEG333DQALRkXg0lQDpiAhQhZuJCG4dfO6KzB3CyCFgmMdxAeIrlo4AHkGpdESUUo1
         x1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNsKiVNd6zCl/MEwp4m+lqbbHPrNeloj/KvUUEFXui4=;
        b=WcTh/UJW4uelRdAc00UNke+Rtn5MYKaC3LolsN2T13WUHsCFRimu4zPXUHuezEuFbG
         y/y5zOlJbQvKAXilHTBGuZBN/6sp7KKB3S2ZaAeVlj603GzvevxkV2gfOeKFe/xpRBAA
         TWFgwZ3LZFhtckhJ6/XnmclAblG2L0O8s0l+uUodldOkUTYgtB27M+ppdNQlimim+QHx
         CbPPO3YLHLYfAcnNY9Q7B/QXvOdNSi0gfg+/RnFtv1kB6ZFkV/p26YveszcdmgZ53eD+
         FRf9kF08ox5nV0azKLJqe4kA1Tm9c5YB4ZeHc966ZdOKYLO08GIMEW53tNWg4D1X8LeU
         h4Eg==
X-Gm-Message-State: AOAM533jTQb//PVCFV2A7eltK6HU1SiDbHmh3XyIGoCw78RroEvdowMV
        45p1/0DrtvqFFED1s5Ymy0uKoyQr0KU=
X-Google-Smtp-Source: ABdhPJykR3KIRUrpV9tXOsICkMRSY3jukK+VPLN/vjExHmUGdBHawdQa6CZ1nr6ggAgEWHjVabOAsg==
X-Received: by 2002:a63:558:: with SMTP id 85mr11449799pgf.45.1631915861845;
        Fri, 17 Sep 2021 14:57:41 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id f144sm7046788pfa.24.2021.09.17.14.57.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:41 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 06/10] libbpf: Make gen_loader data aligned.
Date:   Fri, 17 Sep 2021 14:57:17 -0700
Message-Id: <20210917215721.43491-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Align gen_loader data to 8 byte boundary to make sure union bpf_attr,
bpf_insns and other structs are aligned.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/gen_loader.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index fe2415ab53f6..28ecd932713b 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <errno.h>
 #include <linux/filter.h>
+#include <sys/param.h>
 #include "btf.h"
 #include "bpf.h"
 #include "libbpf.h"
@@ -135,13 +136,17 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
 {
+	__u32 size8 = roundup(size, 8);
+	__u64 zero = 0;
 	void *prev;
 
-	if (realloc_data_buf(gen, size))
+	if (realloc_data_buf(gen, size8))
 		return 0;
 	prev = gen->data_cur;
 	memcpy(gen->data_cur, data, size);
 	gen->data_cur += size;
+	memcpy(gen->data_cur, &zero, size8 - size);
+	gen->data_cur += size8 - size;
 	return prev - gen->data_start;
 }
 
-- 
2.30.2

