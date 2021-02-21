Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA99320D58
	for <lists+bpf@lfdr.de>; Sun, 21 Feb 2021 21:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhBUT6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Feb 2021 14:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhBUT6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Feb 2021 14:58:21 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D9C061574
        for <bpf@vger.kernel.org>; Sun, 21 Feb 2021 11:57:39 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id y7so50019401lji.7
        for <bpf@vger.kernel.org>; Sun, 21 Feb 2021 11:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kHfuexVSmHwRWMhRHwyfy7csnqh7U6km9QFGM4V9cs=;
        b=E+Snhg723PuSgqDWkdGOWFOXk2TAhRyG26hMa9N8WJQggvlQxMH7JJ5on1/smgmzS7
         XrJYcdCEmrnCv3fUbF6bbN561FjHFrKxDqcrccc1UIqf3bUY5fr+hgZwsGILGwomVN9c
         pp/rrfw/zoDyrSUQmSH1jVNvwyYtL3dGZg7bE17cghoNdNdX6qmiXKwnOQQWZn738DVh
         kVzyFGzBHgCClzBgB2Y249Q/6MJq71ka7wo1gMYCs3TRr00GfL8m6/eJtXYgoL3bAz9M
         wPe8Dl5RJYFIKphDZh8H0kNYNWAa/qVlKr89Y3ECj2dn6dJZ2Zg+IOJdLQvRN35k8Lez
         NK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kHfuexVSmHwRWMhRHwyfy7csnqh7U6km9QFGM4V9cs=;
        b=dQGzredsTqPzCA5TH2iAdN6jw03IXRGLJHUaLbZVJwieYjB9C0CVbS6lmR3qY2m+ff
         DLEdNWN8BWmjAscnI+dbFsjh1jyywzlCqisXcyRK/Cc7IP1NYQFBFj8r/FahimdmFLJs
         kXe3/09yX+gp0aRqoxNXieEE5mh9E2Cx0dHRSvKzp734Ca863hRvyQn4JsCQo73d/FMh
         mcadbWzJLTnJpksiH3AluTpK8wgLQjES/kInnLgRT2grrMJl94rMO2MEMT28SiOIyBm8
         jDi7JAG4EnTOe1iTQE8lVg7oaj2/UxrGpdAHtKBZZp+OFv3GzUvOyjOc3NNneQEk+yIR
         +kAw==
X-Gm-Message-State: AOAM533HULWjWKKrbwnSjsZoUJkjsRp0sLr4Z6FxaWPzsQmv1MRfopDw
        +pGRJb8ZojhyXSaZDrqdzQjcz1nHDug4Cm43KRQ=
X-Google-Smtp-Source: ABdhPJz4Ncrdn2qbqDAJmzHmVl5vH3cJNd5n97QIPUkl4eHp3jyUVh7SEaq/ZmNPLB3BDfXP2XAa0A==
X-Received: by 2002:a19:cce:: with SMTP id 197mr9476990lfm.54.1613937458099;
        Sun, 21 Feb 2021 11:57:38 -0800 (PST)
Received: from localhost (nat-79-173-88-8.gtn.ru. [79.173.88.8])
        by smtp.gmail.com with ESMTPSA id q7sm1658676lfm.149.2021.02.21.11.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 11:57:37 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH bpf-next] bpf: Drop imprecise log message
Date:   Sun, 21 Feb 2021 23:57:29 +0400
Message-Id: <20210221195729.92278-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After 4ddb74165ae5 it is possible for global function to have a pointer
argument that points to something different than struct. Drop the
irrelevant log message and keep the logic same.

Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 kernel/bpf/btf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2efeb5f4b343..b1a76fe046cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4321,8 +4321,6 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
 		 * is not supported yet.
 		 * BPF_PROG_TYPE_RAW_TRACEPOINT is fine.
 		 */
-		if (log->level & BPF_LOG_LEVEL)
-			bpf_log(log, "arg#%d type is not a struct\n", arg);
 		return NULL;
 	}
 	tname = btf_name_by_offset(btf, t->name_off);
-- 
2.25.1

