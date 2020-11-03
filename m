Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0832A49E5
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 16:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgKCPcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 10:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgKCPbm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24252C061A48
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 07:31:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c9so11643558wml.5
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 07:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/hi5M/ONr9FmVWZQj+fQ5Mxc0yXVmVmFktosguyo6U=;
        b=Ra7mzVcbE4g/qMhGU0oYjLySylw8TMhH8t6h10XracjSTrGcm90SKx+jOzzKOi1MFi
         dwGitsjtnahNFA0IsIUC4dHgKixoubVSyTSkNUcVch/AKcX5/puljm7LLOXvUajA8yGz
         DPhA1lGnbucxaLZW9e7eSpFfMchgbpEDm2FnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/hi5M/ONr9FmVWZQj+fQ5Mxc0yXVmVmFktosguyo6U=;
        b=aAgEDvDd76XxVsurRdzRlVT7S21ZdHTEZ49KJRNoBqnCAsUDjBqb1mefb9I6uw+8Vr
         czsdRvhqKUJjVl516nhW4bvE+PJbnTQXJ8NzvVxknWWH0v8RydpUzW6cvnQkxt3XadrA
         cOu10Zw0HCwiFkbipWJPQOf+UFY537DP9JWjvB/GtZS3HhW0Hbhk1z5ugtBhNVMdrjuU
         A7eduwSpnpzYoi63vUiCYeZaN2VsaY0sMFhIREdkS+SCIGj7SuFIr8tUiELOyqR+mxLg
         IQupnl7qzb36TNkfm0MnDajol9tR4XOWHyXodWd18qsf4f5cMw1/de2OqVKFsIod/gAD
         d4ow==
X-Gm-Message-State: AOAM531Ru60X8DMoTyg9ipw7GsgrGTf04QF91x1qlSjFCryftPC0wn5G
        vYePW23EZ0WYc4TVcoQNw0a53Q==
X-Google-Smtp-Source: ABdhPJzpwzEycdMKOOL066jO9Uco1cFAajcC4DtUw1voOst31A8jB3dxAbfytEA8HPypUwIvjffPkQ==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr356211wmb.114.1604417500837;
        Tue, 03 Nov 2020 07:31:40 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:40 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 3/8] bpftool: Add support for task local storage
Date:   Tue,  3 Nov 2020 16:31:27 +0100
Message-Id: <20201103153132.2717326-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103153132.2717326-1-kpsingh@chromium.org>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 3 ++-
 tools/bpf/bpftool/bash-completion/bpftool       | 2 +-
 tools/bpf/bpftool/map.c                         | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index dade10cdf295..3d52256ba75f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -50,7 +50,8 @@ MAP COMMANDS
 |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
-|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage** }
+|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
+		| **task_storage** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 3f1da30c4da6..fdffbc64c65c 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -705,7 +705,7 @@ _bpftool()
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
                                 percpu_cgroup_storage queue stack sk_storage \
-                                struct_ops inode_storage' -- \
+                                struct_ops inode_storage task_storage' -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index a7efbd84fbcc..b400364ee054 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -51,6 +51,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_MAP_TYPE_RINGBUF]			= "ringbuf",
 	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
+	[BPF_MAP_TYPE_TASK_STORAGE]		= "task_storage",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
@@ -1464,7 +1465,8 @@ static int do_help(int argc, char **argv)
 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_maps |\n"
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
-		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage }\n"
+		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
+		"		  task_storage }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, argv[-2]);
-- 
2.29.1.341.ge80a0c044ae-goog

