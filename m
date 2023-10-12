Return-Path: <bpf+bounces-12032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074A7C6F6D
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795541C20FA0
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F1129429;
	Thu, 12 Oct 2023 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5827705
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 13:40:02 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2273594
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:39:59 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39CDdlXh064863;
	Thu, 12 Oct 2023 22:39:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Thu, 12 Oct 2023 22:39:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39CDdllV064860
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 12 Oct 2023 22:39:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <adfab6e8-b1de-4efc-a9ef-84e219c91833@I-love.SAKURA.ne.jp>
Date: Thu, 12 Oct 2023 22:39:44 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Is tools/testing/selftests/bpf/ maintained?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello.

I'm having problem with finding BPF LSM examples that work.
I tried building tools/testing/selftests/bpf/progs/lsm.c and
tools/testing/selftests/bpf/prog_tests/test_lsm.c explained at
https://docs.kernel.org/bpf/prog_lsm.html , but got a lot of errors.

----------------------------------------
root@ubuntu:/usr/src# git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
Cloning into 'linux'...
remote: Total 9723739 (delta 8227084), reused 9723739 (delta 8227084)
Receiving objects: 100% (9723739/9723739), 1.81 GiB | 4.04 MiB/s, done.
Resolving deltas: 100% (8227084/8227084), done.
Checking objects: 100% (33554432/33554432), done.
Updating files: 100% (81759/81759), done.
root@ubuntu:/usr/src# cd linux
root@ubuntu:/usr/src/linux# git describe
v6.6-rc5-72-g401644852d0b
root@ubuntu:/usr/src/linux# make -s headers
root@ubuntu:/usr/src/linux# make -sC tools/testing/selftests/bpf/
  MKDIR    libbpf
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'
  TEST-HDR [test_progs] tests.h
  EXT-OBJ  [test_progs] testing_helpers.o
  EXT-OBJ  [test_progs] cap_helpers.o
  EXT-OBJ  [test_progs] unpriv_helpers.o
  BINARY   test_verifier
  BINARY   test_tag
  MKDIR    bpftool

  GEN      vmlinux.h
  CLNG-BPF [test_maps] async_stack_depth.bpf.o
progs/async_stack_depth.c:8:19: error: field has incomplete type 'struct bpf_timer'
        struct bpf_timer timer;
                         ^
/usr/src/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h:41:8: note: forward declaration of 'struct bpf_timer'
struct bpf_timer;
       ^
1 error generated.
make: *** [Makefile:598: /usr/src/linux/tools/testing/selftests/bpf/async_stack_depth.bpf.o] Error 1
----------------------------------------

To fix these errors, something like the following
(this seems to be a fraction) is needed. What am I missing?

----------------------------------------
diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tools/testing/selftests/bpf/progs/async_stack_depth.c
index 3517c0e01206..0318229d8fb2 100644
--- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
+++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
@@ -4,6 +4,11 @@
 
 #include "bpf_misc.h"
 
+struct bpf_timer {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct hmap_elem {
 	struct bpf_timer timer;
 };
diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
index 76d661b20e87..d1fb43346dc1 100644
--- a/tools/testing/selftests/bpf/progs/cb_refs.c
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -2,6 +2,9 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+struct prog_test_member1 {
+	int a;
+};
 #include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 struct map_value {
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c b/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c
index 8aeba1b75c83..5de35c0e08cc 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c
@@ -14,7 +14,7 @@ struct socket_cookie {
 };
 
 struct {
-	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
 	__type(value, struct socket_cookie);
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_negative.c b/tools/testing/selftests/bpf/progs/cgrp_ls_negative.c
index d41f90e2ab64..21043a18b67d 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_negative.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_negative.c
@@ -8,7 +8,7 @@
 char _license[] SEC("license") = "GPL";
 
 struct {
-	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
 	__type(value, long);
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
index a043d8fefdac..cc175f004266 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
@@ -8,14 +8,14 @@
 char _license[] SEC("license") = "GPL";
 
 struct {
-	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
 	__type(value, long);
 } map_a SEC(".maps");
 
 struct {
-	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
 	__type(value, long);
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
index 4c7844e1dbfa..0130e2e6b3d7 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
@@ -9,7 +9,7 @@
 char _license[] SEC("license") = "GPL";
 
 struct {
-	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
 	__type(value, long);
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c b/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
index 9ebb8e2fe541..e47c88c8790c 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
@@ -8,14 +8,14 @@
 char _license[] SEC("license") = "GPL";
 
 struct {
-	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
 	__type(value, long);
 } map_a SEC(".maps");
 
 struct {
-	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
 	__type(value, long);
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
index 0bf969a0b5ed..f681d6f15c43 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
@@ -3,6 +3,18 @@
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+
+struct bpf_dummy_ops_state {
+	int val;
+};
+
+struct bpf_dummy_ops {
+	int (*test_1)(struct bpf_dummy_ops_state *cb);
+	int (*test_2)(struct bpf_dummy_ops_state *cb, int a1, unsigned short a2,
+		      char a3, unsigned long a4);
+	int (*test_sleepable)(struct bpf_dummy_ops_state *cb);
+};
+
 #include <bpf/bpf_tracing.h>
 
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index da30f0d59364..b0db7b893461 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -68,7 +68,7 @@ struct lru_pcpu_hash_map {
 } lru_pcpu_hash_map SEC(".maps");
 
 struct cgrp_ls_map {
-	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
 	__type(value, struct map_value);
----------------------------------------

