Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7496E57B531
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiGTLQ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbiGTLQK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 07:16:10 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 887705B799;
        Wed, 20 Jul 2022 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HaEog
        rGXBO9W6cWg3CIvTltGLAfoziXsyoiJVv5i5qM=; b=ATNaX1+4SJr5RStOgo/j4
        JeybmIgtoowIMV1VeCCOLjAgvA6Ng2wUrPLgMlo1LOXnP4EFFCHpTE2Odj6aF2y0
        Ve/3oauSfO1/SBnlEm8v7rOCwZAk2DSDX0KWsHRSyrbDtox3gpM/HxXEOjkzW3bS
        6ou9nseLAYWXi2Ahrg7jXc=
Received: from localhost.localdomain (unknown [112.97.48.93])
        by smtp4 (Coremail) with SMTP id HNxpCgDXyNhe49dihuDYPg--.344S2;
        Wed, 20 Jul 2022 19:13:37 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     martin.lau@linux.dev, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] docs: bpf: Fix typo in comment
Date:   Wed, 20 Jul 2022 19:13:33 +0800
Message-Id: <20220720111333.17075-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDXyNhe49dihuDYPg--.344S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1DZFWUuF4kWryruF1ftFb_yoW8Gw1kpF
        nrXwn0g3Z8Z343uFy8t342qa4FgF4kWw4UGrZ8tw1Sya17tFW0vryIyFnYy3WUGFyfAa12
        vryFyF1UWw1jy3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRco7NUUUUU=
X-Originating-IP: [112.97.48.93]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDRVEZFaEKAPoCAACsj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 Documentation/bpf/map_cgroup_storage.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
index cab9543017bf..8e5fe532c07e 100644
--- a/Documentation/bpf/map_cgroup_storage.rst
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -31,7 +31,7 @@ The map uses key of type of either ``__u64 cgroup_inode_id`` or
     };
 
 ``cgroup_inode_id`` is the inode id of the cgroup directory.
-``attach_type`` is the the program's attach type.
+``attach_type`` is the program's attach type.
 
 Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
 When this key type is used, then all attach types of the particular cgroup and
@@ -155,7 +155,7 @@ However, the BPF program can still only associate with one map of each type
 ``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
 ``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
 
-In all versions, userspace may use the the attach parameters of cgroup and
+In all versions, userspace may use the attach parameters of cgroup and
 attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
 APIs to read or update the storage for a given attachment. For Linux 5.9
 attach type shared storages, only the first value in the struct, cgroup inode
-- 
2.25.1

