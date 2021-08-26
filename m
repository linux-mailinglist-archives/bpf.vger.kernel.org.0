Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA43F8929
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbhHZNkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242601AbhHZNkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 09:40:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF74AC061757;
        Thu, 26 Aug 2021 06:39:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u6so2168008pfi.0;
        Thu, 26 Aug 2021 06:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZddMfhMy2qsp873EeyfgTUq4LH9HW+30X5gjNhM9wo=;
        b=YFkhE8dlbtgirv8svxYN51iSJOIAyJK7rAxHygkFAxmY+ttyvToWJm701kt+vnEnR0
         eC7B63GPKhGn5BaFunHx/rGVU7D5yBMQJsZMPKU3BwScp3GvBhwRPJQcaI0HMWxc6XB3
         vmz3v2zZiYY4GvuhMuRfu3LpUIPQtBODc+247g/w5bB2nlDIAHKdNjzHDGVrtsop3HDb
         dVNJjiFl1Y02tqyrR19hzHT65Chssm576RF/c06401qnoYFoLLGy07xaZCupmTNORKzs
         jQnP/5Nvb0//xTBnswj3KncsgDrKtmt6LT/AEpRNLBXTO2F1l23ASL9ZbSTXCGzau9sk
         En6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZddMfhMy2qsp873EeyfgTUq4LH9HW+30X5gjNhM9wo=;
        b=fEvHz2Ma7597x5eXeY/xzzdP4dtMt0bihRhfwI1T6Q7rO0RO7yK3n5M7AYq++ktbBf
         PBtLy7Z5G/ROs1CUWsNQaMrSCvUamm6Bj5F+m4EP1gQe8MO9KDEP/6vkEVnEJNA2ERrY
         sd4UVavrhOhyo9ECXVHHT3hWtQ+HVYonfNLYPlKZVTwG/K0775U/glM8G5DY6pOUPBDy
         rAUvYClnaA13fL6gCXRD8A6UqG5FTk43CvDjKTcEJGygIVE8OcFr60KuQveaclcVhCN+
         nW6JK45bTlqU2hRi5kk0PnzvcLl97oK2fXVuCQXbi5BrcRQgby2JDNfrRECWkViwoP9G
         PDXw==
X-Gm-Message-State: AOAM5329UeB8rfibgMjh2LzedhJpTVJ95tMwH6jypMBk+/fno7i1GTNl
        pEWFcILUgYqKza6bNkzxA68W5Tf+fQ4=
X-Google-Smtp-Source: ABdhPJw82MPp+FiMSCOUVR3v1ciRHgmaCI2IZaloa3O0ujKJKvBQm9DJbaU0td0MnucWaS5LhQ+nHg==
X-Received: by 2002:a62:80d2:0:b0:3f1:e19c:a23 with SMTP id j201-20020a6280d2000000b003f1e19c0a23mr3789918pfd.43.1629985170279;
        Thu, 26 Aug 2021 06:39:30 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id k20sm3506830pfu.133.2021.08.26.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:39:30 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 4/5] tools: bpf: update bpftool for file_storage map
Date:   Thu, 26 Aug 2021 19:09:12 +0530
Message-Id: <20210826133913.627361-5-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826133913.627361-1-memxor@gmail.com>
References: <20210826133913.627361-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This updates bpftool to recognise the new file local storage map type.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/bash-completion/bpftool       | 3 ++-
 tools/bpf/bpftool/map.c                         | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index d0c4abe08aba..aff192eb6e37 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -52,7 +52,7 @@ MAP COMMANDS
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-		| **task_storage** }
+		| **task_storage** | **file_storage** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 88e2bcf16cca..e7939e82bda4 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -710,7 +710,8 @@ _bpftool()
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
                                 percpu_cgroup_storage queue stack sk_storage \
-                                struct_ops inode_storage task_storage ringbuf'
+                                struct_ops inode_storage task_storage ringbuf \
+                                file_storage'
                             COMPREPLY=( $( compgen -W "$BPFTOOL_MAP_CREATE_TYPES" -- "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 407071d54ab1..f3c6ea47f846 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -52,6 +52,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_RINGBUF]			= "ringbuf",
 	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
 	[BPF_MAP_TYPE_TASK_STORAGE]		= "task_storage",
+	[BPF_MAP_TYPE_FILE_STORAGE]		= "file_storage",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
@@ -1466,7 +1467,7 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage }\n"
+		"		  task_storage | file_storage }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.33.0

