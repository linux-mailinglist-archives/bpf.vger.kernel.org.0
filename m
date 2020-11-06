Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6AD2A9485
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 11:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKFKiW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 05:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgKFKhy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:54 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40AAC0613D6
        for <bpf@vger.kernel.org>; Fri,  6 Nov 2020 02:37:53 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 23so657842wmg.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 02:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSzUbTNsne9al3ng9/59i+9c1bESHaPY8FhaRGWHPGM=;
        b=YLKZw4HhpyYUZFVlUFiEw5Wm1C7+sYLDey9ZnEaIvUaEdd7Z+xlGXvdHkR0hLU2Q5C
         dxnZ26g5i/A/nhj4HpRNcjfgZNfllEay2/MpW3mPXB4RAr2zCKpuQTSfH4VvWKrHlfwq
         UpleKG8EL2h3iuz8rbk4G83YiaApAGR79exs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSzUbTNsne9al3ng9/59i+9c1bESHaPY8FhaRGWHPGM=;
        b=c6w5KogLeceydg+qemq3Wr2iwHM76Nw7CN2cxTmskrC42xIwQQx34UQ2lcBzeCqjxc
         1+qv2AJXS1cndFfdsXzkfn3AVU0dvXm+PzewT3Z1NTmiOJ2xfQellx8bLPWxT8r032TS
         CtdmUGQYJRMe6B0t0qmpP2gllsCVXuJSIdTdmXX4dgBbxff8k3hcnsV/YQf5a9z2TGgq
         fSjNbjeWJaaRfAw+RrfM0qwLDt0yFIhynkhnPos+BGniobRiprF+nx/i/y+piftFLH68
         O7SEw1wssFZ7TSXFTHOj5WFntgWITyb8iZZbfsjcu3rDGQ4UGsZz/GHkZ8pJmSZdbw6d
         MlIA==
X-Gm-Message-State: AOAM533OOdqJfvs4K2d9X2HsNgb7RuJjPO0kGcbuCd3DkNdS9dqrIIFR
        RXA1ZkdhRByL5+GbOSHCZtfB1g==
X-Google-Smtp-Source: ABdhPJy2mEtxLwhLJgLaHvy0Y7Fhz+4GASBr58Mb2+CRdivIgpW3T4tlTUkuLbflM56RHfgMCSpKxw==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr1708819wmb.175.1604659072681;
        Fri, 06 Nov 2020 02:37:52 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:52 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 4/9] bpftool: Add support for task local storage
Date:   Fri,  6 Nov 2020 10:37:42 +0000
Message-Id: <20201106103747.2780972-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Updates the binary to handle the BPF_MAP_TYPE_TASK_STORAGE as
"task_storage" for printing and parsing. Also updates the documentation
and bash completion

Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
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

