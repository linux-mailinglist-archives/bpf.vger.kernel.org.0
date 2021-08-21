Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EE13F3C2F
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 20:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhHUStU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Aug 2021 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhHUStT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Aug 2021 14:49:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E2AC061575;
        Sat, 21 Aug 2021 11:48:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so9497951pjb.0;
        Sat, 21 Aug 2021 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZddMfhMy2qsp873EeyfgTUq4LH9HW+30X5gjNhM9wo=;
        b=bmquxEjHBtdGMSRvccpdM7/fghIGiLxLV/zF0d1abeel6FJWYJmOkpjBbRprZAMlRg
         ZH5kb7JXG2GxaMtfFVVIX2oyQQwzzxmtILosvre+YLmzScTu7Kk2hxQuoGDA3r+7z16l
         39ZbAnclqpcoyi7yaYtEU+Cc386gwkWtJgDA++z80B4hG5vVkg5mdgnyq0xwY7Un1fv3
         AWXDlkIX7xvb8xAJrEQ/4Rrgnz8WXicev8MjwV0z3ogRfQDKYplTV+Gq2IeYJrGCTYBO
         RRvkfc8+su0l/f/+thjy/HUdnEL+pzkt5c2sKoietiYbFWZ+yBjRX6KFhLKm4AWfRf8P
         zMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZddMfhMy2qsp873EeyfgTUq4LH9HW+30X5gjNhM9wo=;
        b=bCD5twVHF4zziwCz3WqvlfhmRprVM1RB//cRsLCFuHlQ4uKW/dOLCEDecFlYXpS7tG
         aqU7iJNMaGU5a7oT6dmBlFBTR+z014O5Cd72dNuXSH//6/q1j3Wxxlg6FrdTRWru3eDc
         KlkM2Io3J1oUB5Hkp5Zk9ZhCXGRRRioW7Q17Prm89WUYOUZxE6fk66/T+svvQKSgmsbU
         IxAWHsrUjbUQkkMdqoIzppZr13LNCcYvi5t253x/pwPU7/creujcJhCNyIhcw2s7BXrB
         lK1RaHb2xE5HpsCIPQJ6Yo81HSyiw4X4fZrOqvlThbbCyCa37T4UJqC3f/1Bi2DfKvmt
         2pig==
X-Gm-Message-State: AOAM531tshS9y2k2bq3szRmXOM2zcr/be4lMsCIanE6HzZ8Hut9Pjxuw
        l3ftFuhfpprId7ICBM8XIyWxfEHI7IQ=
X-Google-Smtp-Source: ABdhPJyp3LyoghFddr8lX9qvWQo5pKIQJ5wKj3tssSUcAMvKg7bpbywQTkte+teU52IbeXRuT7+Ltg==
X-Received: by 2002:a17:902:9346:b0:132:6ba5:109 with SMTP id g6-20020a170902934600b001326ba50109mr3168144plp.19.1629571719546;
        Sat, 21 Aug 2021 11:48:39 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id 65sm12520856pgi.12.2021.08.21.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 11:48:39 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next RFC v1 4/5] tools: bpf: update bpftool for file_storage map
Date:   Sun, 22 Aug 2021 00:18:23 +0530
Message-Id: <20210821184824.2052643-5-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210821184824.2052643-1-memxor@gmail.com>
References: <20210821184824.2052643-1-memxor@gmail.com>
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

