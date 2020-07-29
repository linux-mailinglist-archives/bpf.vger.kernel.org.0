Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8782316C5
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 02:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgG2AbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 20:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgG2AbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 20:31:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65570C061794
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 17:31:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j207so21001522ybg.20
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 17:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Z07j8LTcaioG0qCkJk70fNDVB7GWknR8AKhYdzK6Syw=;
        b=ANjIMCDYYRjGWoOZ9Y+SZbw2ZtJMkx1qg3zG3ScssDaPUO8rC5xdMGbfGWLZqtkJcf
         JlxhfVvu5+XSfM+/18wPHjDc19xe7NcQJV7zCZZ3foyqHgRRlisT7u1ugjIwkyuJKx0U
         +TqCHdJRMKT2+pk7oxNF5wS1ykn9RtqNJeeXiVrBqLRTSdlVK5cZ7VdGAgdjHmOa+cAu
         5l99lxDxNUfqciKUJMQ1QDq7T1AKIxNvOEDIaD844ixIK4HLjhNGalUgqmbu0KCYSBs2
         hCpNgRmIUiWRT3e7RRDYSOmS5dP7PEeMa9v9mtiWfamoCrMFGGoExY99Rq+cwakfroe2
         BC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Z07j8LTcaioG0qCkJk70fNDVB7GWknR8AKhYdzK6Syw=;
        b=cM5BAQAVf9p3SgDfnqEfHaL6U/boVSuj763FQYOFfGEoIV6bwmaX1d/6L2MaLSPCum
         nqU7JeAocaL9njiGOU9+K9+Hlmp0vADQiznMfeiKTk4tDaIO6uLoCAzs3aoyb9oz1lNN
         hoiujlE2VyXNt7wcQixGpddXOtzWuxVINL1JAW++uMKVyycj2gtTfrZhSt36SH+DuB+T
         GXW3triOt6pFTSQ5xHljech4amXoHb1EtcjuGqtBxzWVWvp6EaCKQ12ioZRgw8zhL47/
         ohGM7J4t1ooltlKTDuo48CNzJvEMBsbaoy/evM9ayv5X0iQCdDChYF5VpQCZBGuN0+lL
         iYIg==
X-Gm-Message-State: AOAM530JhXbaNn1xXnuGNZhdQwHvfe4NBxC9VGbjB3eI13oxONqxaN4K
        FbM2FM90ceTOrFd4AN9c6pdf1q8=
X-Google-Smtp-Source: ABdhPJyZfPHk34oocJNE5G3TAGLIFR03/Mby83zy7tckMohqxJ0NmL4uIXP80JNbfb6+sUuf6HXUFkQ=
X-Received: by 2002:a25:c615:: with SMTP id k21mr43792524ybf.379.1595982666554;
 Tue, 28 Jul 2020 17:31:06 -0700 (PDT)
Date:   Tue, 28 Jul 2020 17:31:03 -0700
Message-Id: <20200729003104.1280813-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH bpf-next 1/2] bpf: expose socket storage to BPF_PROG_TYPE_CGROUP_SOCK
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This lets us use socket storage from the following hooks:
* BPF_CGROUP_INET_SOCK_CREATE
* BPF_CGROUP_INET_SOCK_RELEASE
* BPF_CGROUP_INET4_POST_BIND
* BPF_CGROUP_INET6_POST_BIND

Using existing 'bpf_sk_storage_get_proto' doesn't work because
second argument is ARG_PTR_TO_SOCKET. Even though
BPF_PROG_TYPE_CGROUP_SOCK hooks operate on 'struct bpf_sock',
the verifier still considers it as a PTR_TO_CTX.
That's why I'm adding another 'bpf_sk_storage_get_cg_sock_proto'
definition strictly for BPF_PROG_TYPE_CGROUP_SOCK which accepts
ARG_PTR_TO_CTX which is really 'struct sock' for this program type.

Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/bpf_sk_storage.c | 10 ++++++++++
 net/core/filter.c         |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index eafcd15e7dfd..d3377c90a291 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -944,6 +944,16 @@ const struct bpf_func_proto bpf_sk_storage_get_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto = {
+	.func		= bpf_sk_storage_get,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_CTX, /* context is 'struct sock' */
+	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 	.func		= bpf_sk_storage_delete,
 	.gpl_only	= false,
diff --git a/net/core/filter.c b/net/core/filter.c
index 29e3455122f7..7124f0fe6974 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6187,6 +6187,7 @@ bool bpf_helper_changes_pkt_data(void *func)
 }
 
 const struct bpf_func_proto bpf_event_output_data_proto __weak;
+const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto __weak;
 
 static const struct bpf_func_proto *
 sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
@@ -6219,6 +6220,8 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_cgroup_classid:
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_cg_sock_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
-- 
2.28.0.163.g6104cc2f0b6-goog

