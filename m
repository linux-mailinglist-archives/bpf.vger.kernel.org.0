Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2A44C04F
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhKJLt3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhKJLt2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 06:49:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E12C061767
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:46:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso3440323wmh.0
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czAlx45XekS6T7E6vCDjy/iYH9MvCYJzu7jpipCouho=;
        b=yKmTdcdutKR305mFcuyPviyqxNGSrNMBCloV/7DKiITAeJxRm8/gKgb2tyHfCN2++k
         jH9Zk3OVlIg7TewyylbO3z8FeSVmTwwBjQZ4JxuowCBfjHMua7fMVLGCHxp87S53z7oP
         Ld89268IMEOjZ5rJxSpDgroEvocdwHyF3KfYCnMCv1ArCSKCh4J+sA+KPLomCA1sLnK7
         sNHiWN+/TELe+Um9Lji2NlrUbfc/0/XskJFcpVS3sPsUHe9URctNOlI8jY7a+9P6Q65Z
         mq68dceX43MMHqGv1cRMZtBbROJ15IW4/n4LXJpTK7ngDsYq9la1bET9SIxFUWb3Hb8b
         uY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czAlx45XekS6T7E6vCDjy/iYH9MvCYJzu7jpipCouho=;
        b=n9nT7lEffxwg1Gao77KWpQGyXwddY6ItA9MbV8D71Albsm8OThrmLrCcBo6hEzte26
         l+Sm1Vc7lFFSHS9G0lkCGd5C7sVic1fqk1Ni5Cljg73TKLCTJenJMpqRMR1/qt6qOFeN
         SKrLV/c54l9sTmUs4+dkPV+bSYJhF32q4M65IppoqJ0QoXTriSGOUGaiE8s5P9p3vMPV
         SsHSQP5+npPLHZ6on7Pp3BSJQKqjn3ODlB8Gv+k7zRGgDUj6E93etuESlBV0iqQwzefB
         OlQ6SnFbyYD4REXvYOvVY4SqzEI7oVu8pNBe/IInsiDcTXZIqpbS9ObNGt9GUV5NB1Z3
         q5JQ==
X-Gm-Message-State: AOAM533f/4iU1yDk6lmCoxvC6PoDa1nKD72DtBcCm6vYjqsMEFP3EuEZ
        wmb9BeTMqnbuPNgLwrT4x3vshmsd0Zw2AA==
X-Google-Smtp-Source: ABdhPJxJ8a3seoMJLfdJVggYTKQNpgbOUoC3EZca3uGdC/2c355Z5J/PTV7zmc3WtHY+29aOxtEi0w==
X-Received: by 2002:a05:600c:2206:: with SMTP id z6mr15498712wml.132.1636544799753;
        Wed, 10 Nov 2021 03:46:39 -0800 (PST)
Received: from localhost.localdomain ([149.86.79.190])
        by smtp.gmail.com with ESMTPSA id i15sm6241152wmq.18.2021.11.10.03.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:46:39 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 5/6] bpftool: Update the lists of names for maps and prog-attach types
Date:   Wed, 10 Nov 2021 11:46:31 +0000
Message-Id: <20211110114632.24537-6-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110114632.24537-1-quentin@isovalent.com>
References: <20211110114632.24537-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To support the different BPF map or attach types, bpftool must remain
up-to-date with the types supported by the kernel. Let's update the
lists, by adding the missing Bloom filter map type and the perf_event
attach type.

Both missing items were found with test_bpftool_synctypes.py.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/bash-completion/bpftool       | 3 ++-
 tools/bpf/bpftool/common.c                      | 1 +
 tools/bpf/bpftool/map.c                         | 3 ++-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 1445cadc15d4..991d18fd84f2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -52,7 +52,7 @@ MAP COMMANDS
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-		| **task_storage** }
+|		| **task_storage** | **bloom_filter** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 88e2bcf16cca..b57f318ed649 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -710,7 +710,8 @@ _bpftool()
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
                                 percpu_cgroup_storage queue stack sk_storage \
-                                struct_ops inode_storage task_storage ringbuf'
+                                struct_ops ringbuf inode_storage task_storage \
+                                bloom_filter'
                             COMPREPLY=( $( compgen -W "$BPFTOOL_MAP_CREATE_TYPES" -- "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 511eccdbdfe6..fa8eb8134344 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -74,6 +74,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_XDP]			= "xdp",
 	[BPF_SK_REUSEPORT_SELECT]	= "sk_skb_reuseport_select",
 	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_skb_reuseport_select_or_migrate",
+	[BPF_PERF_EVENT]		= "perf_event",
 };
 
 void p_err(const char *fmt, ...)
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index cae1f1119296..68cb121e65c4 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -53,6 +53,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_RINGBUF]			= "ringbuf",
 	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
 	[BPF_MAP_TYPE_TASK_STORAGE]		= "task_storage",
+	[BPF_MAP_TYPE_BLOOM_FILTER]		= "bloom_filter",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
@@ -1477,7 +1478,7 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage }\n"
+		"                 task_storage | bloom_filter }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.32.0

