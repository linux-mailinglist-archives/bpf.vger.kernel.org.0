Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E067AC89AC
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 15:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfJBNaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 09:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbfJBNag (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 09:30:36 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25E333D94D
        for <bpf@vger.kernel.org>; Wed,  2 Oct 2019 13:30:36 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id q3so3550275lfc.5
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 06:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pqLC3K0zosC/Ijfelepo4fx24olc2AqeXpVeWBxBt4o=;
        b=BpLaXOuQsC/FwGvSRwIyD7QeIiiiteVYNxK7Oxt4hXUs66uuZcsUt7Hhy8+ZVwB/Q/
         mgb0e+Hm7e7LakyR2e9wzCncTdMmZe205DMQ//WOhrkOnKNu7f//SDfeVzzVffc0pFY/
         9jkfqaQZN+uHsOjtkZmNC4NZv7DJW12vLvV+oplA9wud5Rwfm+wd0Smt5lVLYynKRuaE
         6Kr1Ytd0P79nvrxax+x9opfQTulVYsPdKF3zmDVR9XiSPbMu2+jvH6sgb9ZmXzmjD5yc
         Px60BomYR29VRire6B2ABiFeG9ccPmoz55S1KRzrbBqcLMz/o3e/ox+YW1tGVTU/A1nP
         mQBQ==
X-Gm-Message-State: APjAAAV47Slf+/ys63W6LKA1K/KxB83515fraeD2/n2/5lzJZX7dBS1D
        ZXADTEDUqc93VujN+CVtaqVeEG1dx8r9I8vZfB7dgPt4RSL/XXKnjUVc/io+Ai9r0yeQhwtMZyM
        tsimXtelEf05O
X-Received: by 2002:a19:ef17:: with SMTP id n23mr2264339lfh.109.1570023034730;
        Wed, 02 Oct 2019 06:30:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyf+i0aehSnS03SCOX01y6ZKk/kXFw701LZVoGDGz5WSDlfP1vxr3k6yYRK8vjW24yO32CIcQ==
X-Received: by 2002:a19:ef17:: with SMTP id n23mr2264329lfh.109.1570023034557;
        Wed, 02 Oct 2019 06:30:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id c16sm4543320lfj.8.2019.10.02.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 06:30:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 46661180641; Wed,  2 Oct 2019 15:30:32 +0200 (CEST)
Subject: [PATCH bpf-next 7/9] bpftool: Add definitions for xdp_chain map type
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Wed, 02 Oct 2019 15:30:32 +0200
Message-ID: <157002303220.1302756.13509533392771604835.stgit@alrua-x1>
In-Reply-To: <157002302448.1302756.5727756706334050763.stgit@alrua-x1>
References: <157002302448.1302756.5727756706334050763.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Adds bash completion and definition types for the xdp_chain map type to
bpftool.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst |    4 ++--
 tools/bpf/bpftool/bash-completion/bpftool       |    2 +-
 tools/bpf/bpftool/map.c                         |    3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 1c0f7146aab0..9aefcef50b53 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -47,8 +47,8 @@ MAP COMMANDS
 |	*TYPE* := { **hash** | **array** | **prog_array** | **perf_event_array** | **percpu_hash**
 |		| **percpu_array** | **stack_trace** | **cgroup_array** | **lru_hash**
 |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
-|		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
-|		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
+|		| **devmap** | **devmap_hash** | **xdp_chain** | **sockmap** | **cpumap** | **xskmap**
+|		| **sockhash** | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |		| **queue** | **stack** }
 
 DESCRIPTION
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 70493a6da206..95f19191b8d1 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -489,7 +489,7 @@ _bpftool()
                                 perf_event_array percpu_hash percpu_array \
                                 stack_trace cgroup_array lru_hash \
                                 lru_percpu_hash lpm_trie array_of_maps \
-                                hash_of_maps devmap devmap_hash sockmap cpumap \
+                                hash_of_maps devmap devmap_hash xdp_chain sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
                                 percpu_cgroup_storage queue stack' -- \
                                                    "$cur" ) )
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index de61d73b9030..97b5b42df79c 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -38,6 +38,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_HASH_OF_MAPS]		= "hash_of_maps",
 	[BPF_MAP_TYPE_DEVMAP]			= "devmap",
 	[BPF_MAP_TYPE_DEVMAP_HASH]		= "devmap_hash",
+	[BPF_MAP_TYPE_XDP_CHAIN]		= "xdp_chain",
 	[BPF_MAP_TYPE_SOCKMAP]			= "sockmap",
 	[BPF_MAP_TYPE_CPUMAP]			= "cpumap",
 	[BPF_MAP_TYPE_XSKMAP]			= "xskmap",
@@ -1326,7 +1327,7 @@ static int do_help(int argc, char **argv)
 		"       TYPE := { hash | array | prog_array | perf_event_array | percpu_hash |\n"
 		"                 percpu_array | stack_trace | cgroup_array | lru_hash |\n"
 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_maps |\n"
-		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
+		"                 devmap | devmap_hash | xdp_chain | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",

