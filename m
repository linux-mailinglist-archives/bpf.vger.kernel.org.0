Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA6643A86
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 02:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiLFBK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 20:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFBKz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 20:10:55 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA2B7FF
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 17:10:54 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id o18-20020a170902d4d200b00189d4c25568so4304482plg.13
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 17:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eE5QWKLcAG3L+QQNdNqzOExJZK6SuWw0RxbpYZ6+G80=;
        b=qD+H+l7ckmn1QdifKtWk8Lzo5WwOZ4MSo2HXtvGnZqY8mYYR8dY07bqgl4j0Ha989j
         u6FO584lp1iXRDuVY38EMVRHRDOywUwNPmdWPQoRx5/WkTc0O7Y+j88PGJOrffWuLpDm
         ZxkpPdc1B35+thiREp7qsj0Z9/atZuD+X9nFZZky6LKqJ0RAD2WO8rHqjU7pFJjLOUdN
         HS11YVDMoY6up3ngwj+DBBAAJSn9+JdbZErEV25Bmtef8vVNAF1d6telzk0cNoIT6Xd+
         EjDmhF6VRO+9z5liypztl793e7ShGky86LCRbtCzi2eQjZz874St1EaNC0OV0TGiq2ll
         FKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eE5QWKLcAG3L+QQNdNqzOExJZK6SuWw0RxbpYZ6+G80=;
        b=3WaypUbN76McBmLPKY3g1snQiv47Znf6GI146S6CmxTe/kGpQGyvx1lAzGIuR1Mphk
         6MPN2RR8DirWnMXLGc+bBhfKiZXKeCevLgjJXalJg6XH8ADtsVuh0bRhwuMmrHpJC5Ly
         Ap+K9OSPvvYzw4frwRJ6QWRnKn9gr4rbc6uGIdQi0d+pGRXYYVXM1fJvJJw2JwfY6qWE
         ZR1Nc7WEa3CrG3my+6aGCJep2/C/TE2f+7JPJal1Cr/DtC//9R4o4fwH8BiUK3eKLZj2
         LdeeaQfW0zGYJwOHbP7es2D0VwJcuBBJhSOUyw78ablPVWyRHP0rJoy8CUjbFm+iqNOK
         z6bg==
X-Gm-Message-State: ANoB5pmP0aOX1UNP8uK+f1/hTmbicdA7tzePerld/BNeFD2IUrUEFvWO
        VIVBoBk1B7R9N1akyEzyZF7oeBoynSFYWz3G70awpR4mh4pTfObXK17b5CM0cgSaLkU06nIkJcV
        SkCrMOngW69SRAJtUr3/+zO+1fCwbOQofb9VuZGAcXUlAAfro+A==
X-Google-Smtp-Source: AA0mqf4gSvuOfmqApfHJ4oQn/y7J0dSXdwSvfMaeXpNC3pHXzdoKHxWj0gl8CKB2mFlvYBl1TmjssyQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:6d62:b0:219:4ee5:ccc9 with SMTP id
 z89-20020a17090a6d6200b002194ee5ccc9mr35988593pjj.63.1670289054333; Mon, 05
 Dec 2022 17:10:54 -0800 (PST)
Date:   Mon,  5 Dec 2022 17:10:52 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206011052.3099563-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Bring test_offload.py back to life
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit ccc3f56918f6 ("selftests/bpf: convert remaining legacy map
definitions") converted sample_map_ret0.c to modern BTF map format.
However, it doesn't looks like iproute2 part that attaches XDP
supports this format. Let's use bpftool to load the obj file
instead of iproute2; iproute2 will only attach a pinned program.

Some other related issues:
* bpftool has new extra libbpf_det_bind probing map we need to exclude
* skip trying to load netdevsim modules if it's already loaded (builtin)

Cc: Jakub Kicinski <kuba@kernel.org>
Fixes: ccc3f56918f6 ("selftests/bpf: convert remaining legacy map definitions")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_offload.py | 33 ++++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 7fc15e0d24a9..9718140c13fa 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -769,12 +769,14 @@ skip(ret != 0, "bpftool not installed")
 base_progs = progs
 _, base_maps = bpftool("map")
 base_map_names = [
-    'pid_iter.rodata' # created on each bpftool invocation
+    'pid_iter.rodata', # created on each bpftool invocation
+    'libbpf_det_bind', # created on each bpftool invocation
 ]
 
 # Check netdevsim
-ret, out = cmd("modprobe netdevsim", fail=False)
-skip(ret != 0, "netdevsim module could not be loaded")
+if not os.path.isdir("/sys/bus/netdevsim/"):
+    ret, out = cmd("modprobe netdevsim", fail=False)
+    skip(ret != 0, "netdevsim module could not be loaded")
 
 # Check debugfs
 _, out = cmd("mount")
@@ -1169,9 +1171,12 @@ netns = []
 
     simdev = NetdevSimDev()
     sim, = simdev.nsims
-    map_obj = bpf_obj("sample_map_ret0.bpf.o")
+    bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/offload",
+                      dev=sim['ifname'])
+    offload = bpf_pinned("/sys/fs/bpf/offload")
+
     start_test("Test loading program with maps...")
-    sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
+    sim.set_xdp(offload, "offload", JSON=False) # map fixup msg breaks JSON
 
     start_test("Test bpftool bound info reporting (own ns)...")
     check_dev_info(False, "")
@@ -1191,6 +1196,7 @@ netns = []
     prog_file, _ = pin_prog("/sys/fs/bpf/tmp_prog")
     map_file, _ = pin_map("/sys/fs/bpf/tmp_map", idx=1, expected=2)
     simdev.remove()
+    rm("/sys/fs/bpf/offload")
 
     start_test("Test bpftool bound info reporting (removed dev)...")
     check_dev_info_removed(prog_file=prog_file, map_file=map_file)
@@ -1203,7 +1209,10 @@ netns = []
     sim, = simdev.nsims
 
     start_test("Test map update (no flags)...")
-    sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
+    bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/offload",
+                      dev=sim['ifname'])
+    offload = bpf_pinned("/sys/fs/bpf/offload")
+    sim.set_xdp(offload, "offload", JSON=False) # map fixup msg breaks JSON
     maps = bpftool_map_list(expected=2)
     array = maps[0] if maps[0]["type"] == "array" else maps[1]
     htab = maps[0] if maps[0]["type"] == "hash" else maps[1]
@@ -1280,23 +1289,31 @@ netns = []
 
     start_test("Test map remove...")
     sim.unset_xdp("offload")
+    rm("/sys/fs/bpf/offload")
     bpftool_map_list_wait(expected=0)
     simdev.remove()
 
     simdev = NetdevSimDev()
     sim, = simdev.nsims
-    sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
+    bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/offload",
+                      dev=sim['ifname'])
+    offload = bpf_pinned("/sys/fs/bpf/offload")
+    sim.set_xdp(offload, "offload", JSON=False) # map fixup msg breaks JSON
+    rm("/sys/fs/bpf/offload")
     simdev.remove()
     bpftool_map_list_wait(expected=0)
 
     start_test("Test map creation fail path...")
     simdev = NetdevSimDev()
     sim, = simdev.nsims
+    bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/nooffload")
+    nooffload = bpf_pinned("/sys/fs/bpf/nooffload")
     sim.dfs["bpf_map_accept"] = "N"
-    ret, _ = sim.set_xdp(map_obj, "offload", JSON=False, fail=False)
+    ret, _ = sim.set_xdp(nooffload, "offload", JSON=False, fail=False)
     fail(ret == 0,
          "netdevsim didn't refuse to create a map with offload disabled")
 
+    rm("/sys/fs/bpf/nooffload")
     simdev.remove()
 
     start_test("Test multi-dev ASIC program reuse...")
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

