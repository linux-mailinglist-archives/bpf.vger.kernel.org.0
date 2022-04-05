Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F004F4D77
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiDEXnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577689AbiDEXMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 19:12:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED33FD6DE
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 14:44:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n207-20020a25d6d8000000b0063bd7a74ae4so269635ybg.21
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MhoasprV20JlI7ZLzrp/5wwx/R2QKS0RPiN6/YMdzGY=;
        b=pj0hH2QOuC0gC5ANwRWNDiuhKEKRSIUvtnQztS6hfWX68NA5Eq62BO/qIdoeNoXreI
         pP5kC5uAxJ6GmHSMS99creDx0Ts/8ZX0ltMR5V+tBKRpIJuAMFjZ/iLtVdWdhHDgDGRc
         W4H74nPWbGquoP3tlULFJLQjN5tya/psS6zIQWNJfNNzDTUnbW5KV6k4dPVfYIYFbbin
         B80c6NLrR530Fc6uh++zT63xk926fBgkR9Ut49Q7jFJAkLVtc2IazogHutIHlU77FCCA
         AxaPyOGCi0wUUhCQ6JsE8uz94xrHZfg+dNPZe8XSNxWoatKcH+JVNMnDeF7XA66eqy21
         S83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MhoasprV20JlI7ZLzrp/5wwx/R2QKS0RPiN6/YMdzGY=;
        b=PIW9CIA39ou5p3+j5rrBkm6/XQunWr48+Aw+Clrn9j4co1GY1ZC819sTiEEKzc+iM8
         7TFJa/1mw+0NZXW6HhXKIYtYUHQ5x1ulg2yAbQCStCiER/BH/Dn48rM1FgLNpq5lLEAO
         9gHUXt0NxQSY0odcBRj9Kywx4W6gfP+JigiH4z6D4IQEiVBKRcU85F85zDrFTZ5ki6cS
         qyFjj/5rYzCJhNpfONtZ2m8OLxGSPmNZOvIjCp63YSVi3iTY2gK0DskYpH/DEuGG8rzm
         mBZI5XkSq5kLDmAK7LDMqcJyZG+v4NqNNBTs1EzDV9z/O6An5uXyzWE99I46CFhMdrir
         tWrQ==
X-Gm-Message-State: AOAM5314nbkS6q/UJCLqzXFmSDWkmm6lqIcAWiXG1P7wCosCo2+g0qGd
        Q87mlzQ3t2Ef+RtEZtWVp5YAhPA=
X-Google-Smtp-Source: ABdhPJyGdauGRNobP5luxMOGks1h7FwQ0l6pvw7TAC9tGTRf2sr5JIheiRynEseMm3FnBb/2iDEv+J8=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:73b5:ffab:2024:2901])
 (user=sdf job=sendgmr) by 2002:a05:6902:1351:b0:63d:d3ae:da8d with SMTP id
 g17-20020a056902135100b0063dd3aeda8dmr4116187ybu.445.1649195037512; Tue, 05
 Apr 2022 14:43:57 -0700 (PDT)
Date:   Tue,  5 Apr 2022 14:43:40 -0700
In-Reply-To: <20220405214342.1968262-1-sdf@google.com>
Message-Id: <20220405214342.1968262-6-sdf@google.com>
Mime-Version: 1.0
References: <20220405214342.1968262-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH bpf-next v2 5/7] libbpf: add lsm_cgoup_sock type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

lsm_cgroup/ is the prefix for BPF_LSM_CGROUP.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 91ce94b61f7f..9ec0b48002fb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8667,6 +8667,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace/",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("lsm_cgroup/",	LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
 	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
@@ -9088,6 +9089,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.35.1.1094.g7c7d902a7c-goog

