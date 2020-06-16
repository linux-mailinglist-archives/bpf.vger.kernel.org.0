Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF231FAF40
	for <lists+bpf@lfdr.de>; Tue, 16 Jun 2020 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgFPLdR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jun 2020 07:33:17 -0400
Received: from sym2.noone.org ([178.63.92.236]:57200 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgFPLdH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 07:33:07 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49mQzz560Wzvjc1; Tue, 16 Jun 2020 13:33:03 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
Subject: [PATCH bpf] tools, bpftool: Add ringbuf map type to map command docs
Date:   Tue, 16 Jun 2020 13:33:03 +0200
Message-Id: <20200616113303.8123-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit c34a06c56df7 ("tools/bpftool: Add ringbuf map to a list of known
map types") added the symbolic "ringbuf" name. Document it in the bpftool
map command docs and usage as well.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 31101643e57c..70c78faa47ab 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -49,7 +49,7 @@ MAP COMMANDS
 |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
-|		| **queue** | **stack** | **sk_storage** | **struct_ops** }
+|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 99109a6afe17..1d3b60651078 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1591,7 +1591,7 @@ static int do_help(int argc, char **argv)
 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_maps |\n"
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
-		"                 queue | stack | sk_storage | struct_ops }\n"
+		"                 queue | stack | sk_storage | struct_ops | ringbuf }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, argv[-2]);
-- 
2.27.0

