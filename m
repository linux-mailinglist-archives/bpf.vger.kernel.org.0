Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473055A6B79
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiH3R62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiH3R6E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:58:04 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E741CB2C
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:56:03 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 14D36240029
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 19:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1661882162; bh=zuIZ5BmhwrzPF7Oju+BbJUTFoviY2GwEQTKCqGkaZUo=;
        h=From:To:Cc:Subject:Date:From;
        b=OB+oGjxtZuBcKXD6Jz+MR487MbIb8dWCVrciUV0n9l7sFXkB4udCVqPmPV2BR9X7w
         brumXpM7BcCfs6Rgi6sFrLPm75OP5s0JjzGq2zi8sGrm7yi9+pa8ythf4YXB0g2xr4
         kYYPuFe6gbh3Zx8XTEOT07w8tNft2svYYz8ceI+9fCe9hnHWCtiJ+c7TP1cQAM7rVO
         AN5iAKl9XXDD2XoU3rk5DMHgWo+wbYnMYfJDmGCPUiA36D5YWLci3FF6PkQeYckl0T
         DVq9TwkULgZMxGIlEnFcDLiPI6B+xBQvopwxRemXbUVIko8TPt6SVwbQWIrFWmD73q
         FsQSZ0w8UFyhQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MHFNJ3JPSz6tn5;
        Tue, 30 Aug 2022 19:56:00 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Cc:     deso@posteo.net
Subject: [PATCH bpf-next v2] selftests/bpf: Store BPF object files with .bpf.o extension
Date:   Tue, 30 Aug 2022 17:55:50 +0000
Message-Id: <20220830175550.3838206-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF object files are, in a way, the final artifact produced as part of
the ahead-of-time compilation process. That makes them somewhat special
compared to "regular" object files, which are a intermediate build
artifacts that can typically be removed safely. As such, it can make
sense to name them differently to make it easier to spot this difference
at a glance.
Among others, libbpf-bootstrap [0] has established the extension .bpf.o
for BPF object files. It seems reasonable to follow this example and
establish the same denomination for selftest build artifacts. To that
end, this change adjusts the corresponding part of the build system and
the test programs loading BPF object files to work with .bpf.o files.

[0] https://github.com/libbpf/libbpf-bootstrap

Signed-off-by: Daniel Müller <deso@posteo.net>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
---

Changelog:
- fixed up subject; it's only a single patch

 tools/testing/selftests/bpf/Makefile          | 34 ++++-----
 .../selftests/bpf/get_cgroup_id_user.c        |  2 +-
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |  2 +-
 .../bpf/prog_tests/bpf_verif_scale.c          | 54 +++++++-------
 tools/testing/selftests/bpf/prog_tests/btf.c  |  4 +-
 .../selftests/bpf/prog_tests/btf_dump.c       |  6 +-
 .../selftests/bpf/prog_tests/btf_endian.c     |  2 +-
 .../bpf/prog_tests/connect_force_port.c       |  2 +-
 .../selftests/bpf/prog_tests/core_reloc.c     | 74 +++++++++----------
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 44 +++++------
 .../bpf/prog_tests/get_stack_raw_tp.c         |  4 +-
 .../selftests/bpf/prog_tests/global_data.c    |  2 +-
 .../bpf/prog_tests/global_data_init.c         |  2 +-
 .../bpf/prog_tests/global_func_args.c         |  2 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |  2 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |  4 +-
 .../bpf/prog_tests/load_bytes_relative.c      |  2 +-
 .../selftests/bpf/prog_tests/map_lock.c       |  2 +-
 .../selftests/bpf/prog_tests/pinning.c        |  4 +-
 .../selftests/bpf/prog_tests/pkt_access.c     |  2 +-
 .../selftests/bpf/prog_tests/pkt_md_access.c  |  2 +-
 .../selftests/bpf/prog_tests/probe_user.c     |  2 +-
 .../bpf/prog_tests/queue_stack_map.c          |  4 +-
 .../selftests/bpf/prog_tests/rdonly_maps.c    |  2 +-
 .../bpf/prog_tests/reference_tracking.c       |  2 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |  2 +-
 .../bpf/prog_tests/select_reuseport.c         |  4 +-
 .../selftests/bpf/prog_tests/sk_assign.c      |  2 +-
 .../selftests/bpf/prog_tests/skb_ctx.c        |  2 +-
 .../selftests/bpf/prog_tests/skb_helpers.c    |  2 +-
 .../bpf/prog_tests/sockopt_inherit.c          |  2 +-
 .../selftests/bpf/prog_tests/sockopt_multi.c  |  2 +-
 .../selftests/bpf/prog_tests/spinlock.c       |  2 +-
 .../selftests/bpf/prog_tests/stacktrace_map.c |  2 +-
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 20 ++---
 .../bpf/prog_tests/task_fd_query_rawtp.c      |  2 +-
 .../bpf/prog_tests/task_fd_query_tp.c         |  2 +-
 .../selftests/bpf/prog_tests/tcp_estats.c     |  2 +-
 .../bpf/prog_tests/test_global_funcs.c        | 34 ++++-----
 .../selftests/bpf/prog_tests/test_overhead.c  |  2 +-
 .../bpf/prog_tests/tp_attach_query.c          |  2 +-
 .../bpf/prog_tests/trampoline_count.c         |  2 +-
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  2 +-
 .../bpf/prog_tests/xdp_adjust_frags.c         |  2 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          | 10 +--
 .../selftests/bpf/prog_tests/xdp_attach.c     |  2 +-
 .../selftests/bpf/prog_tests/xdp_info.c       |  2 +-
 .../selftests/bpf/prog_tests/xdp_perf.c       |  2 +-
 .../selftests/bpf/prog_tests/xdp_synproxy.c   |  2 +-
 .../selftests/bpf/progs/fexit_bpf2bpf.c       |  8 +-
 tools/testing/selftests/bpf/test_dev_cgroup.c |  2 +-
 .../selftests/bpf/test_lirc_mode2_user.c      |  2 +-
 tools/testing/selftests/bpf/test_maps.c       | 10 +--
 tools/testing/selftests/bpf/test_offload.py   | 22 +++---
 .../selftests/bpf/test_skb_cgroup_id.sh       |  2 +-
 tools/testing/selftests/bpf/test_sock_addr.c  | 16 ++--
 tools/testing/selftests/bpf/test_sockmap.c    |  4 +-
 tools/testing/selftests/bpf/test_sysctl.c     |  6 +-
 .../selftests/bpf/test_tcp_check_syncookie.sh |  2 +-
 .../selftests/bpf/test_tcpnotify_user.c       |  2 +-
 .../selftests/bpf/test_xdp_redirect.sh        |  8 +-
 .../selftests/bpf/test_xdp_redirect_multi.sh  |  2 +-
 tools/testing/selftests/bpf/test_xdp_veth.sh  |  8 +-
 .../selftests/bpf/xdp_redirect_multi.c        |  2 +-
 tools/testing/selftests/bpf/xdp_synproxy.c    |  2 +-
 tools/testing/selftests/bpf/xdping.c          |  2 +-
 67 files changed, 236 insertions(+), 236 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index eecad9..787631 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -45,7 +45,7 @@ ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
-TEST_GEN_FILES = test_lwt_ip_encap.o test_tc_edt.o
+TEST_GEN_FILES = test_lwt_ip_encap.bpf.o test_tc_edt.bpf.o
 TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
@@ -358,17 +358,17 @@ LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
 SKEL_BLACKLIST += $$(LSKELS)
 
-test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
-linked_funcs.skel.h-deps := linked_funcs1.o linked_funcs2.o
-linked_vars.skel.h-deps := linked_vars1.o linked_vars2.o
-linked_maps.skel.h-deps := linked_maps1.o linked_maps2.o
+test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
+linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
+linked_vars.skel.h-deps := linked_vars1.bpf.o linked_vars2.bpf.o
+linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
 # In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
 # but that's created as a side-effect of the skel.h generation.
-test_subskeleton.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o test_subskeleton.o
-test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o
-test_usdt.skel.h-deps := test_usdt.o test_usdt_multispec.o
+test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
+test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
+test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
 
-LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
+LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
@@ -386,7 +386,7 @@ TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
 TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
 TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
-TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS))
+TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.bpf.o, $$(TRUNNER_BPF_SRCS))
 TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
 				 $$(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),\
 					       $$(TRUNNER_BPF_SRCS)))
@@ -416,7 +416,7 @@ endif
 # input/output directory combination
 ifeq ($($(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs),)
 $(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs := y
-$(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
+$(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
 		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
 		     $$(INCLUDE_DIR)/vmlinux.h				\
@@ -426,22 +426,22 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
 					  $(TRUNNER_BPF_CFLAGS))
 
-$(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
 	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$@
-	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$(@:.skel.h=.subskel.h)
+	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@
+	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h)
 
-$(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
 	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.o=_lskel)) > $$@
+	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
 
 $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.o))
@@ -500,7 +500,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
 	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
-	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
+	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
 
 endef
diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
index e021cc6..156743 100644
--- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/get_cgroup_id_user.c
@@ -48,7 +48,7 @@ static int bpf_find_map(const char *test, struct bpf_object *obj,
 int main(int argc, char **argv)
 {
 	const char *probe_name = "syscalls/sys_enter_nanosleep";
-	const char *file = "get_cgroup_id_kern.o";
+	const char *file = "get_cgroup_id_kern.bpf.o";
 	int err, bytes, efd, prog_fd, pmu_fd;
 	int cgroup_fd, cgidmap_fd, pidmap_fd;
 	struct perf_event_attr attr = {};
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
index dbe56f..e1c1e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -7,7 +7,7 @@ void serial_test_bpf_obj_id(void)
 {
 	const __u64 array_magic_value = 0xfaceb00c;
 	const __u32 array_key = 0;
-	const char *file = "./test_obj_id.o";
+	const char *file = "./test_obj_id.bpf.o";
 	const char *expected_prog_name = "test_obj_id";
 	const char *expected_map_name = "test_map_id";
 	const __u64 nsec_per_sec = 1000000000;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index ff6cce..5ca252 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -75,45 +75,45 @@ static void scale_test(const char *file,
 
 void test_verif_scale1()
 {
-	scale_test("test_verif_scale1.o", BPF_PROG_TYPE_SCHED_CLS, false);
+	scale_test("test_verif_scale1.bpf.o", BPF_PROG_TYPE_SCHED_CLS, false);
 }
 
 void test_verif_scale2()
 {
-	scale_test("test_verif_scale2.o", BPF_PROG_TYPE_SCHED_CLS, false);
+	scale_test("test_verif_scale2.bpf.o", BPF_PROG_TYPE_SCHED_CLS, false);
 }
 
 void test_verif_scale3()
 {
-	scale_test("test_verif_scale3.o", BPF_PROG_TYPE_SCHED_CLS, false);
+	scale_test("test_verif_scale3.bpf.o", BPF_PROG_TYPE_SCHED_CLS, false);
 }
 
 void test_verif_scale_pyperf_global()
 {
-	scale_test("pyperf_global.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("pyperf_global.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_pyperf_subprogs()
 {
-	scale_test("pyperf_subprogs.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("pyperf_subprogs.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_pyperf50()
 {
 	/* full unroll by llvm */
-	scale_test("pyperf50.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("pyperf50.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_pyperf100()
 {
 	/* full unroll by llvm */
-	scale_test("pyperf100.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("pyperf100.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_pyperf180()
 {
 	/* full unroll by llvm */
-	scale_test("pyperf180.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("pyperf180.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_pyperf600()
@@ -124,13 +124,13 @@ void test_verif_scale_pyperf600()
 	 * 16k insns in loop body.
 	 * Total of 5 such loops. Total program size ~82k insns.
 	 */
-	scale_test("pyperf600.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("pyperf600.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_pyperf600_bpf_loop(void)
 {
 	/* use the bpf_loop helper*/
-	scale_test("pyperf600_bpf_loop.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("pyperf600_bpf_loop.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_pyperf600_nounroll()
@@ -141,37 +141,37 @@ void test_verif_scale_pyperf600_nounroll()
 	 * ~110 insns in loop body.
 	 * Total of 5 such loops. Total program size ~1500 insns.
 	 */
-	scale_test("pyperf600_nounroll.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("pyperf600_nounroll.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_loop1()
 {
-	scale_test("loop1.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("loop1.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_loop2()
 {
-	scale_test("loop2.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("loop2.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_loop3_fail()
 {
-	scale_test("loop3.o", BPF_PROG_TYPE_RAW_TRACEPOINT, true /* fails */);
+	scale_test("loop3.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, true /* fails */);
 }
 
 void test_verif_scale_loop4()
 {
-	scale_test("loop4.o", BPF_PROG_TYPE_SCHED_CLS, false);
+	scale_test("loop4.bpf.o", BPF_PROG_TYPE_SCHED_CLS, false);
 }
 
 void test_verif_scale_loop5()
 {
-	scale_test("loop5.o", BPF_PROG_TYPE_SCHED_CLS, false);
+	scale_test("loop5.bpf.o", BPF_PROG_TYPE_SCHED_CLS, false);
 }
 
 void test_verif_scale_loop6()
 {
-	scale_test("loop6.o", BPF_PROG_TYPE_KPROBE, false);
+	scale_test("loop6.bpf.o", BPF_PROG_TYPE_KPROBE, false);
 }
 
 void test_verif_scale_strobemeta()
@@ -180,54 +180,54 @@ void test_verif_scale_strobemeta()
 	 * Total program size 20.8k insn.
 	 * ~350k processed_insns
 	 */
-	scale_test("strobemeta.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("strobemeta.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_strobemeta_bpf_loop(void)
 {
 	/* use the bpf_loop helper*/
-	scale_test("strobemeta_bpf_loop.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("strobemeta_bpf_loop.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_strobemeta_nounroll1()
 {
 	/* no unroll, tiny loops */
-	scale_test("strobemeta_nounroll1.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("strobemeta_nounroll1.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_strobemeta_nounroll2()
 {
 	/* no unroll, tiny loops */
-	scale_test("strobemeta_nounroll2.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("strobemeta_nounroll2.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_strobemeta_subprogs()
 {
 	/* non-inlined subprogs */
-	scale_test("strobemeta_subprogs.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+	scale_test("strobemeta_subprogs.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_sysctl_loop1()
 {
-	scale_test("test_sysctl_loop1.o", BPF_PROG_TYPE_CGROUP_SYSCTL, false);
+	scale_test("test_sysctl_loop1.bpf.o", BPF_PROG_TYPE_CGROUP_SYSCTL, false);
 }
 
 void test_verif_scale_sysctl_loop2()
 {
-	scale_test("test_sysctl_loop2.o", BPF_PROG_TYPE_CGROUP_SYSCTL, false);
+	scale_test("test_sysctl_loop2.bpf.o", BPF_PROG_TYPE_CGROUP_SYSCTL, false);
 }
 
 void test_verif_scale_xdp_loop()
 {
-	scale_test("test_xdp_loop.o", BPF_PROG_TYPE_XDP, false);
+	scale_test("test_xdp_loop.bpf.o", BPF_PROG_TYPE_XDP, false);
 }
 
 void test_verif_scale_seg6_loop()
 {
-	scale_test("test_seg6_loop.o", BPF_PROG_TYPE_LWT_SEG6LOCAL, false);
+	scale_test("test_seg6_loop.bpf.o", BPF_PROG_TYPE_LWT_SEG6LOCAL, false);
 }
 
 void test_verif_twfw()
 {
-	scale_test("twfw.o", BPF_PROG_TYPE_CGROUP_SKB, false);
+	scale_test("twfw.bpf.o", BPF_PROG_TYPE_CGROUP_SKB, false);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index ef6528..127b8ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4651,8 +4651,8 @@ struct btf_file_test {
 };
 
 static struct btf_file_test file_tests[] = {
-	{ .file = "test_btf_newkv.o", },
-	{ .file = "test_btf_nokv.o", .btf_kv_notfound = true, },
+	{ .file = "test_btf_newkv.bpf.o", },
+	{ .file = "test_btf_nokv.bpf.o", .btf_kv_notfound = true, },
 };
 
 static void do_test_file(unsigned int test_num)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 7b5bbe2..b1ca95 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -52,7 +52,7 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 	int err = 0, fd = -1;
 	FILE *f = NULL;
 
-	snprintf(test_file, sizeof(test_file), "%s.o", t->file);
+	snprintf(test_file, sizeof(test_file), "%s.bpf.o", t->file);
 
 	btf = btf__parse_elf(test_file, NULL);
 	if (!ASSERT_OK_PTR(btf, "btf_parse_elf")) {
@@ -841,8 +841,8 @@ static void test_btf_dump_datasec_data(char *str)
 	char license[4] = "GPL";
 	struct btf_dump *d;
 
-	btf = btf__parse("xdping_kern.o", NULL);
-	if (!ASSERT_OK_PTR(btf, "xdping_kern.o BTF not found"))
+	btf = btf__parse("xdping_kern.bpf.o", NULL);
+	if (!ASSERT_OK_PTR(btf, "xdping_kern.bpf.o BTF not found"))
 		return;
 
 	d = btf_dump__new(btf, btf_dump_snprintf, str, NULL);
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_endian.c b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
index 8afbf3d0..5b9f84d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_endian.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
@@ -23,7 +23,7 @@ void test_btf_endian() {
 	int var_id;
 
 	/* Load BTF in native endianness */
-	btf = btf__parse_elf("btf_dump_test_case_syntax.o", NULL);
+	btf = btf__parse_elf("btf_dump_test_case_syntax.bpf.o", NULL);
 	if (!ASSERT_OK_PTR(btf, "parse_native_btf"))
 		goto err_out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
index 9c4325f..24d553 100644
--- a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
+++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
@@ -53,7 +53,7 @@ static int run_test(int cgroup_fd, int server_fd, int family, int type)
 	__u16 expected_peer_port = 60000;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	const char *obj_file = v4 ? "connect_force_port4.o" : "connect_force_port6.o";
+	const char *obj_file = v4 ? "connect_force_port4.bpf.o" : "connect_force_port6.bpf.o";
 	int fd, err;
 	__u32 duration = 0;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index c8655ba..47f42e 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -13,7 +13,7 @@ static int duration = 0;
 
 #define MODULES_CASE(name, pg_name, tp_name) {				\
 	.case_name = name,						\
-	.bpf_obj_file = "test_core_reloc_module.o",			\
+	.bpf_obj_file = "test_core_reloc_module.bpf.o",			\
 	.btf_src_file = NULL, /* find in kernel module BTFs */		\
 	.input = "",							\
 	.input_len = 0,							\
@@ -43,8 +43,8 @@ static int duration = 0;
 
 #define FLAVORS_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_flavors.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_flavors.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_flavors"				\
 
@@ -68,8 +68,8 @@ static int duration = 0;
 
 #define NESTING_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_nesting.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_nesting.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_nesting"				\
 
@@ -96,8 +96,8 @@ static int duration = 0;
 
 #define ARRAYS_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_arrays.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_arrays.bpf.o",			\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_arrays"					\
 
@@ -130,8 +130,8 @@ static int duration = 0;
 
 #define PRIMITIVES_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_primitives.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_primitives.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_primitives"				\
 
@@ -150,8 +150,8 @@ static int duration = 0;
 
 #define MODS_CASE(name) {						\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_mods.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_mods.bpf.o",			\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.input = STRUCT_TO_CHAR_PTR(core_reloc_##name) {		\
 		.a = 1,							\
 		.b = 2,							\
@@ -174,8 +174,8 @@ static int duration = 0;
 
 #define PTR_AS_ARR_CASE(name) {						\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_ptr_as_arr.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_ptr_as_arr.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.input = (const char *)&(struct core_reloc_##name []){		\
 		{ .a = 1 },						\
 		{ .a = 2 },						\
@@ -203,8 +203,8 @@ static int duration = 0;
 
 #define INTS_CASE_COMMON(name)						\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_ints.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_ints.bpf.o",			\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_ints"
 
@@ -223,18 +223,18 @@ static int duration = 0;
 
 #define FIELD_EXISTS_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_existence.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_existence.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_existence"
 
 #define BITFIELDS_CASE_COMMON(objfile, test_name_prefix,  name)		\
 	.case_name = test_name_prefix#name,				\
 	.bpf_obj_file = objfile,					\
-	.btf_src_file = "btf__core_reloc_" #name ".o"
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o"
 
 #define BITFIELDS_CASE(name, ...) {					\
-	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_probed.o",	\
+	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_probed.bpf.o",	\
 			      "probed:", name),				\
 	.input = STRUCT_TO_CHAR_PTR(core_reloc_##name) __VA_ARGS__,	\
 	.input_len = sizeof(struct core_reloc_##name),			\
@@ -244,7 +244,7 @@ static int duration = 0;
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_bitfields",				\
 }, {									\
-	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_direct.o",	\
+	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_direct.bpf.o",	\
 			      "direct:", name),				\
 	.input = STRUCT_TO_CHAR_PTR(core_reloc_##name) __VA_ARGS__,	\
 	.input_len = sizeof(struct core_reloc_##name),			\
@@ -256,14 +256,14 @@ static int duration = 0;
 
 
 #define BITFIELDS_ERR_CASE(name) {					\
-	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_probed.o",	\
+	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_probed.bpf.o",	\
 			      "probed:", name),				\
 	.fails = true,							\
-	.run_btfgen_fails = true,							\
+	.run_btfgen_fails = true,					\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_bitfields",				\
 }, {									\
-	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_direct.o",	\
+	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_direct.bpf.o",	\
 			      "direct:", name),				\
 	.fails = true,							\
 	.run_btfgen_fails = true,							\
@@ -272,8 +272,8 @@ static int duration = 0;
 
 #define SIZE_CASE_COMMON(name)						\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_size.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_size.bpf.o",			\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_size"
 
@@ -307,13 +307,13 @@ static int duration = 0;
 #define SIZE_ERR_CASE(name) {						\
 	SIZE_CASE_COMMON(name),						\
 	.fails = true,							\
-	.run_btfgen_fails = true,							\
+	.run_btfgen_fails = true,					\
 }
 
 #define TYPE_BASED_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_type_based.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_type_based.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_type_based"
 
@@ -331,8 +331,8 @@ static int duration = 0;
 
 #define TYPE_ID_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_type_id.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_type_id.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_type_id"
 
@@ -350,8 +350,8 @@ static int duration = 0;
 
 #define ENUMVAL_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_enumval.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_enumval.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_enumval"
 
@@ -369,8 +369,8 @@ static int duration = 0;
 
 #define ENUM64VAL_CASE_COMMON(name)					\
 	.case_name = #name,						\
-	.bpf_obj_file = "test_core_reloc_enum64val.o",			\
-	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.bpf_obj_file = "test_core_reloc_enum64val.bpf.o",		\
+	.btf_src_file = "btf__core_reloc_" #name ".bpf.o",		\
 	.raw_tp_name = "sys_enter",					\
 	.prog_name = "test_core_enum64val"
 
@@ -547,7 +547,7 @@ static const struct core_reloc_test_case test_cases[] = {
 	/* validate we can find kernel image and use its BTF for relocs */
 	{
 		.case_name = "kernel",
-		.bpf_obj_file = "test_core_reloc_kernel.o",
+		.bpf_obj_file = "test_core_reloc_kernel.bpf.o",
 		.btf_src_file = NULL, /* load from /lib/modules/$(uname -r) */
 		.input = "",
 		.input_len = 0,
@@ -629,8 +629,8 @@ static const struct core_reloc_test_case test_cases[] = {
 	/* validate edge cases of capturing relocations */
 	{
 		.case_name = "misc",
-		.bpf_obj_file = "test_core_reloc_misc.o",
-		.btf_src_file = "btf__core_reloc_misc.o",
+		.bpf_obj_file = "test_core_reloc_misc.bpf.o",
+		.btf_src_file = "btf__core_reloc_misc.bpf.o",
 		.input = (const char *)&(struct core_reloc_misc_extensible[]){
 			{ .a = 1 },
 			{ .a = 2 }, /* not read */
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index da860b..d1e32e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -174,8 +174,8 @@ static void test_target_no_callees(void)
 	const char *prog_name[] = {
 		"fexit/test_pkt_md_access",
 	};
-	test_fexit_bpf2bpf_common("./fexit_bpf2bpf_simple.o",
-				  "./test_pkt_md_access.o",
+	test_fexit_bpf2bpf_common("./fexit_bpf2bpf_simple.bpf.o",
+				  "./test_pkt_md_access.bpf.o",
 				  ARRAY_SIZE(prog_name),
 				  prog_name, true, NULL);
 }
@@ -188,8 +188,8 @@ static void test_target_yes_callees(void)
 		"fexit/test_pkt_access_subprog2",
 		"fexit/test_pkt_access_subprog3",
 	};
-	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.o",
-				  "./test_pkt_access.o",
+	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.bpf.o",
+				  "./test_pkt_access.bpf.o",
 				  ARRAY_SIZE(prog_name),
 				  prog_name, true, NULL);
 }
@@ -206,8 +206,8 @@ static void test_func_replace(void)
 		"freplace/get_constant",
 		"freplace/test_pkt_write_access_subprog",
 	};
-	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.o",
-				  "./test_pkt_access.o",
+	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.bpf.o",
+				  "./test_pkt_access.bpf.o",
 				  ARRAY_SIZE(prog_name),
 				  prog_name, true, NULL);
 }
@@ -217,8 +217,8 @@ static void test_func_replace_verify(void)
 	const char *prog_name[] = {
 		"freplace/do_bind",
 	};
-	test_fexit_bpf2bpf_common("./freplace_connect4.o",
-				  "./connect4_prog.o",
+	test_fexit_bpf2bpf_common("./freplace_connect4.bpf.o",
+				  "./connect4_prog.bpf.o",
 				  ARRAY_SIZE(prog_name),
 				  prog_name, false, NULL);
 }
@@ -227,7 +227,7 @@ static int test_second_attach(struct bpf_object *obj)
 {
 	const char *prog_name = "security_new_get_constant";
 	const char *tgt_name = "get_constant";
-	const char *tgt_obj_file = "./test_pkt_access.o";
+	const char *tgt_obj_file = "./test_pkt_access.bpf.o";
 	struct bpf_program *prog = NULL;
 	struct bpf_object *tgt_obj;
 	struct bpf_link *link;
@@ -272,8 +272,8 @@ static void test_func_replace_multi(void)
 	const char *prog_name[] = {
 		"freplace/get_constant",
 	};
-	test_fexit_bpf2bpf_common("./freplace_get_constant.o",
-				  "./test_pkt_access.o",
+	test_fexit_bpf2bpf_common("./freplace_get_constant.bpf.o",
+				  "./test_pkt_access.bpf.o",
 				  ARRAY_SIZE(prog_name),
 				  prog_name, true, test_second_attach);
 }
@@ -281,10 +281,10 @@ static void test_func_replace_multi(void)
 static void test_fmod_ret_freplace(void)
 {
 	struct bpf_object *freplace_obj = NULL, *pkt_obj, *fmod_obj = NULL;
-	const char *freplace_name = "./freplace_get_constant.o";
-	const char *fmod_ret_name = "./fmod_ret_freplace.o";
+	const char *freplace_name = "./freplace_get_constant.bpf.o";
+	const char *fmod_ret_name = "./fmod_ret_freplace.bpf.o";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
-	const char *tgt_name = "./test_pkt_access.o";
+	const char *tgt_name = "./test_pkt_access.bpf.o";
 	struct bpf_link *freplace_link = NULL;
 	struct bpf_program *prog;
 	__u32 duration = 0;
@@ -339,8 +339,8 @@ static void test_func_sockmap_update(void)
 	const char *prog_name[] = {
 		"freplace/cls_redirect",
 	};
-	test_fexit_bpf2bpf_common("./freplace_cls_redirect.o",
-				  "./test_cls_redirect.o",
+	test_fexit_bpf2bpf_common("./freplace_cls_redirect.bpf.o",
+				  "./test_cls_redirect.bpf.o",
 				  ARRAY_SIZE(prog_name),
 				  prog_name, false, NULL);
 }
@@ -385,15 +385,15 @@ static void test_obj_load_failure_common(const char *obj_file,
 static void test_func_replace_return_code(void)
 {
 	/* test invalid return code in the replaced program */
-	test_obj_load_failure_common("./freplace_connect_v4_prog.o",
-				     "./connect4_prog.o");
+	test_obj_load_failure_common("./freplace_connect_v4_prog.bpf.o",
+				     "./connect4_prog.bpf.o");
 }
 
 static void test_func_map_prog_compatibility(void)
 {
 	/* test with spin lock map value in the replaced program */
-	test_obj_load_failure_common("./freplace_attach_probe.o",
-				     "./test_attach_probe.o");
+	test_obj_load_failure_common("./freplace_attach_probe.bpf.o",
+				     "./test_attach_probe.bpf.o");
 }
 
 static void test_func_replace_global_func(void)
@@ -402,8 +402,8 @@ static void test_func_replace_global_func(void)
 		"freplace/test_pkt_access",
 	};
 
-	test_fexit_bpf2bpf_common("./freplace_global_func.o",
-				  "./test_pkt_access.o",
+	test_fexit_bpf2bpf_common("./freplace_global_func.bpf.o",
+				  "./test_pkt_access.bpf.o",
 				  ARRAY_SIZE(prog_name),
 				  prog_name, false, NULL);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index 160489..858e057 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -84,8 +84,8 @@ static void get_stack_print_output(void *ctx, int cpu, void *data, __u32 size)
 
 void test_get_stack_raw_tp(void)
 {
-	const char *file = "./test_get_stack_rawtp.o";
-	const char *file_err = "./test_get_stack_rawtp_err.o";
+	const char *file = "./test_get_stack_rawtp.bpf.o";
+	const char *file_err = "./test_get_stack_rawtp_err.bpf.o";
 	const char *prog_name = "bpf_prog1";
 	int i, err, prog_fd, exp_cnt = MAX_CNT_RAWTP;
 	struct perf_buffer *pb = NULL;
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data.c b/tools/testing/selftests/bpf/prog_tests/global_data.c
index 027685..fadfb6 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data.c
@@ -131,7 +131,7 @@ static void test_global_data_rdonly(struct bpf_object *obj, __u32 duration)
 
 void test_global_data(void)
 {
-	const char *file = "./test_global_data.o";
+	const char *file = "./test_global_data.bpf.o";
 	struct bpf_object *obj;
 	int err, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 57331c..846633 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -3,7 +3,7 @@
 
 void test_global_data_init(void)
 {
-	const char *file = "./test_global_data.o";
+	const char *file = "./test_global_data.bpf.o";
 	int err = -ENOMEM, map_fd, zero = 0;
 	__u8 *buff = NULL, *newval = NULL;
 	struct bpf_object *obj;
diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_args.c b/tools/testing/selftests/bpf/prog_tests/global_func_args.c
index 29039a3..d99709 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_func_args.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_func_args.c
@@ -39,7 +39,7 @@ static void test_global_func_args0(struct bpf_object *obj)
 
 void test_global_func_args(void)
 {
-	const char *file = "./test_global_func_args.o";
+	const char *file = "./test_global_func_args.bpf.o";
 	struct bpf_object *obj;
 	int err, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index 1cee695..735793 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -69,7 +69,7 @@ void serial_test_kfree_skb(void)
 	const int zero = 0;
 	bool test_ok[2];
 
-	err = bpf_prog_test_load("./test_pkt_access.o", BPF_PROG_TYPE_SCHED_CLS,
+	err = bpf_prog_test_load("./test_pkt_access.bpf.o", BPF_PROG_TYPE_SCHED_CLS,
 				 &obj, &prog_fd);
 	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
index 55f733..9c1a18 100644
--- a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
+++ b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
@@ -90,7 +90,7 @@ static void test_l4lb(const char *file)
 void test_l4lb_all(void)
 {
 	if (test__start_subtest("l4lb_inline"))
-		test_l4lb("test_l4lb.o");
+		test_l4lb("test_l4lb.bpf.o");
 	if (test__start_subtest("l4lb_noinline"))
-		test_l4lb("test_l4lb_noinline.o");
+		test_l4lb("test_l4lb_noinline.bpf.o");
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c b/tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
index 4e0b2ec..b150c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
+++ b/tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
@@ -27,7 +27,7 @@ void test_load_bytes_relative(void)
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_cgroup_fd;
 
-	err = bpf_prog_test_load("./load_bytes_relative.o", BPF_PROG_TYPE_CGROUP_SKB,
+	err = bpf_prog_test_load("./load_bytes_relative.bpf.o", BPF_PROG_TYPE_CGROUP_SKB,
 			    &obj, &prog_fd);
 	if (CHECK_FAIL(err))
 		goto close_server_fd;
diff --git a/tools/testing/selftests/bpf/prog_tests/map_lock.c b/tools/testing/selftests/bpf/prog_tests/map_lock.c
index e4e99b..1d6726f 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_lock.c
@@ -49,7 +49,7 @@ static void *parallel_map_access(void *arg)
 
 void test_map_lock(void)
 {
-	const char *file = "./test_map_lock.o";
+	const char *file = "./test_map_lock.bpf.o";
 	int prog_fd, map_fd[2], vars[17] = {};
 	pthread_t thread_id[6];
 	struct bpf_object *obj = NULL;
diff --git a/tools/testing/selftests/bpf/prog_tests/pinning.c b/tools/testing/selftests/bpf/prog_tests/pinning.c
index 31c09b..d95cee 100644
--- a/tools/testing/selftests/bpf/prog_tests/pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/pinning.c
@@ -26,13 +26,13 @@ __u32 get_map_id(struct bpf_object *obj, const char *name)
 
 void test_pinning(void)
 {
-	const char *file_invalid = "./test_pinning_invalid.o";
+	const char *file_invalid = "./test_pinning_invalid.bpf.o";
 	const char *custpinpath = "/sys/fs/bpf/custom/pinmap";
 	const char *nopinpath = "/sys/fs/bpf/nopinmap";
 	const char *nopinpath2 = "/sys/fs/bpf/nopinmap2";
 	const char *custpath = "/sys/fs/bpf/custom";
 	const char *pinpath = "/sys/fs/bpf/pinmap";
-	const char *file = "./test_pinning.o";
+	const char *file = "./test_pinning.bpf.o";
 	__u32 map_id, map_id2, duration = 0;
 	struct stat statbuf = {};
 	struct bpf_object *obj;
diff --git a/tools/testing/selftests/bpf/prog_tests/pkt_access.c b/tools/testing/selftests/bpf/prog_tests/pkt_access.c
index 0bcccd..682e4f 100644
--- a/tools/testing/selftests/bpf/prog_tests/pkt_access.c
+++ b/tools/testing/selftests/bpf/prog_tests/pkt_access.c
@@ -4,7 +4,7 @@
 
 void test_pkt_access(void)
 {
-	const char *file = "./test_pkt_access.o";
+	const char *file = "./test_pkt_access.bpf.o";
 	struct bpf_object *obj;
 	int err, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
diff --git a/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c b/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
index 00ee1d..0d85e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
+++ b/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
@@ -4,7 +4,7 @@
 
 void test_pkt_md_access(void)
 {
-	const char *file = "./test_pkt_md_access.o";
+	const char *file = "./test_pkt_md_access.bpf.o";
 	struct bpf_object *obj;
 	int err, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
index 34dbd2..8721671 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -11,7 +11,7 @@ void serial_test_probe_user(void)
 #endif
 	};
 	enum { prog_count = ARRAY_SIZE(prog_names) };
-	const char *obj_file = "./test_probe_user.o";
+	const char *obj_file = "./test_probe_user.bpf.o";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
 	int err, results_map_fd, sock_fd, duration = 0;
 	struct sockaddr curr, orig, tmp;
diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index d2743f..722c5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -28,9 +28,9 @@ static void test_queue_stack_map_by_type(int type)
 		vals[i] = rand();
 
 	if (type == QUEUE)
-		strncpy(file, "./test_queue_map.o", sizeof(file));
+		strncpy(file, "./test_queue_map.bpf.o", sizeof(file));
 	else if (type == STACK)
-		strncpy(file, "./test_stack_map.o", sizeof(file));
+		strncpy(file, "./test_stack_map.bpf.o", sizeof(file));
 	else
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c b/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
index fd5d2d..19e2f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
+++ b/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
@@ -16,7 +16,7 @@ struct rdonly_map_subtest {
 
 void test_rdonly_maps(void)
 {
-	const char *file = "test_rdonly_maps.o";
+	const char *file = "test_rdonly_maps.bpf.o";
 	struct rdonly_map_subtest subtests[] = {
 		{ "skip loop", "skip_loop", 0, 0 },
 		{ "part loop", "part_loop", 3, 2 + 3 + 4 },
diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index 739d2ea..d86320 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -3,7 +3,7 @@
 
 void test_reference_tracking(void)
 {
-	const char *file = "test_sk_lookup_kern.o";
+	const char *file = "test_sk_lookup_kern.bpf.o";
 	const char *obj_name = "ref_track";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 		.object_name = obj_name,
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index c197261..f81d08d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -101,7 +101,7 @@ static int resolve_symbols(void)
 	int type_id;
 	__u32 nr;
 
-	btf = btf__parse_elf("btf_data.o", NULL);
+	btf = btf__parse_elf("btf_data.bpf.o", NULL);
 	if (CHECK(libbpf_get_error(btf), "resolve",
 		  "Failed to load BTF from btf_data.o\n"))
 		return -1;
diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 1cbd8c..64c5f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -91,9 +91,9 @@ static int prepare_bpf_obj(void)
 	struct bpf_map *map;
 	int err;
 
-	obj = bpf_object__open("test_select_reuseport_kern.o");
+	obj = bpf_object__open("test_select_reuseport_kern.bpf.o");
 	err = libbpf_get_error(obj);
-	RET_ERR(err, "open test_select_reuseport_kern.o",
+	RET_ERR(err, "open test_select_reuseport_kern.bpf.o",
 		"obj:%p PTR_ERR(obj):%d\n", obj, err);
 
 	map = bpf_object__find_map_by_name(obj, "outer_map");
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 1d272e..3e190e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -47,7 +47,7 @@ configure_stack(void)
 	if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
 		return false;
 	sprintf(tc_cmd, "%s %s %s %s", "tc filter add dev lo ingress bpf",
-		       "direct-action object-file ./test_sk_assign.o",
+		       "direct-action object-file ./test_sk_assign.bpf.o",
 		       "section tc",
 		       (env.verbosity < VERBOSE_VERY) ? " 2>/dev/null" : "verbose");
 	if (CHECK(system(tc_cmd), "BPF load failed;",
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
index ce0e555..33f950 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -31,7 +31,7 @@ void test_skb_ctx(void)
 	struct bpf_object *obj;
 	int err, prog_fd, i;
 
-	err = bpf_prog_test_load("./test_skb_ctx.o", BPF_PROG_TYPE_SCHED_CLS,
+	err = bpf_prog_test_load("./test_skb_ctx.bpf.o", BPF_PROG_TYPE_SCHED_CLS,
 				 &obj, &prog_fd);
 	if (!ASSERT_OK(err, "load"))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_helpers.c b/tools/testing/selftests/bpf/prog_tests/skb_helpers.c
index 97dc8b..f7ee25 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_helpers.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_helpers.c
@@ -20,7 +20,7 @@ void test_skb_helpers(void)
 	struct bpf_object *obj;
 	int err, prog_fd;
 
-	err = bpf_prog_test_load("./test_skb_helpers.o",
+	err = bpf_prog_test_load("./test_skb_helpers.bpf.o",
 				 BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
 	if (!ASSERT_OK(err, "load"))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 8ed78a9..c5cb6e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -174,7 +174,7 @@ static void run_test(int cgroup_fd)
 	pthread_t tid;
 	int err;
 
-	obj = bpf_object__open_file("sockopt_inherit.o", NULL);
+	obj = bpf_object__open_file("sockopt_inherit.bpf.o", NULL);
 	if (!ASSERT_OK_PTR(obj, "obj_open"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
index abce12..28d592dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
@@ -310,7 +310,7 @@ void test_sockopt_multi(void)
 	if (CHECK_FAIL(cg_child < 0))
 		goto out;
 
-	obj = bpf_object__open_file("sockopt_multi.o", NULL);
+	obj = bpf_object__open_file("sockopt_multi.bpf.o", NULL);
 	if (!ASSERT_OK_PTR(obj, "obj_load"))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/spinlock.c b/tools/testing/selftests/bpf/prog_tests/spinlock.c
index 8e329ea..15eb13 100644
--- a/tools/testing/selftests/bpf/prog_tests/spinlock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spinlock.c
@@ -19,7 +19,7 @@ static void *spin_lock_thread(void *arg)
 
 void test_spinlock(void)
 {
-	const char *file = "./test_spin_lock.o";
+	const char *file = "./test_spin_lock.bpf.o";
 	pthread_t thread_id[4];
 	struct bpf_object *obj = NULL;
 	int prog_fd;
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 313f0a6..df59e4 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -6,7 +6,7 @@ void test_stacktrace_map(void)
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
 	const char *prog_name = "oncpu";
 	int err, prog_fd, stack_trace_len;
-	const char *file = "./test_stacktrace_map.o";
+	const char *file = "./test_stacktrace_map.bpf.o";
 	__u32 key, val, duration = 0;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
index 1cb8dd..c6ef06f 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
@@ -5,7 +5,7 @@ void test_stacktrace_map_raw_tp(void)
 {
 	const char *prog_name = "oncpu";
 	int control_map_fd, stackid_hmap_fd, stackmap_fd;
-	const char *file = "./test_stacktrace_map.o";
+	const char *file = "./test_stacktrace_map.bpf.o";
 	__u32 key, val, duration = 0;
 	int err, prog_fd;
 	struct bpf_program *prog;
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 19c7088..8409f3 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -20,7 +20,7 @@ static void test_tailcall_1(void)
 		.repeat = 1,
 	);
 
-	err = bpf_prog_test_load("tailcall1.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
+	err = bpf_prog_test_load("tailcall1.bpf.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
 			    &prog_fd);
 	if (CHECK_FAIL(err))
 		return;
@@ -156,7 +156,7 @@ static void test_tailcall_2(void)
 		.repeat = 1,
 	);
 
-	err = bpf_prog_test_load("tailcall2.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
+	err = bpf_prog_test_load("tailcall2.bpf.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
 			    &prog_fd);
 	if (CHECK_FAIL(err))
 		return;
@@ -299,7 +299,7 @@ static void test_tailcall_count(const char *which)
  */
 static void test_tailcall_3(void)
 {
-	test_tailcall_count("tailcall3.o");
+	test_tailcall_count("tailcall3.bpf.o");
 }
 
 /* test_tailcall_6 checks that the count value of the tail call limit
@@ -307,7 +307,7 @@ static void test_tailcall_3(void)
  */
 static void test_tailcall_6(void)
 {
-	test_tailcall_count("tailcall6.o");
+	test_tailcall_count("tailcall6.bpf.o");
 }
 
 /* test_tailcall_4 checks that the kernel properly selects indirect jump
@@ -329,7 +329,7 @@ static void test_tailcall_4(void)
 		.repeat = 1,
 	);
 
-	err = bpf_prog_test_load("tailcall4.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
+	err = bpf_prog_test_load("tailcall4.bpf.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
 			    &prog_fd);
 	if (CHECK_FAIL(err))
 		return;
@@ -419,7 +419,7 @@ static void test_tailcall_5(void)
 		.repeat = 1,
 	);
 
-	err = bpf_prog_test_load("tailcall5.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
+	err = bpf_prog_test_load("tailcall5.bpf.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
 			    &prog_fd);
 	if (CHECK_FAIL(err))
 		return;
@@ -507,7 +507,7 @@ static void test_tailcall_bpf2bpf_1(void)
 		.repeat = 1,
 	);
 
-	err = bpf_prog_test_load("tailcall_bpf2bpf1.o", BPF_PROG_TYPE_SCHED_CLS,
+	err = bpf_prog_test_load("tailcall_bpf2bpf1.bpf.o", BPF_PROG_TYPE_SCHED_CLS,
 			    &obj, &prog_fd);
 	if (CHECK_FAIL(err))
 		return;
@@ -591,7 +591,7 @@ static void test_tailcall_bpf2bpf_2(void)
 		.repeat = 1,
 	);
 
-	err = bpf_prog_test_load("tailcall_bpf2bpf2.o", BPF_PROG_TYPE_SCHED_CLS,
+	err = bpf_prog_test_load("tailcall_bpf2bpf2.bpf.o", BPF_PROG_TYPE_SCHED_CLS,
 			    &obj, &prog_fd);
 	if (CHECK_FAIL(err))
 		return;
@@ -671,7 +671,7 @@ static void test_tailcall_bpf2bpf_3(void)
 		.repeat = 1,
 	);
 
-	err = bpf_prog_test_load("tailcall_bpf2bpf3.o", BPF_PROG_TYPE_SCHED_CLS,
+	err = bpf_prog_test_load("tailcall_bpf2bpf3.bpf.o", BPF_PROG_TYPE_SCHED_CLS,
 			    &obj, &prog_fd);
 	if (CHECK_FAIL(err))
 		return;
@@ -766,7 +766,7 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 		.repeat = 1,
 	);
 
-	err = bpf_prog_test_load("tailcall_bpf2bpf4.o", BPF_PROG_TYPE_SCHED_CLS,
+	err = bpf_prog_test_load("tailcall_bpf2bpf4.bpf.o", BPF_PROG_TYPE_SCHED_CLS,
 			    &obj, &prog_fd);
 	if (CHECK_FAIL(err))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
index 17947c..3d34bab 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
@@ -3,7 +3,7 @@
 
 void test_task_fd_query_rawtp(void)
 {
-	const char *file = "./test_get_stack_rawtp.o";
+	const char *file = "./test_get_stack_rawtp.bpf.o";
 	__u64 probe_offset, probe_addr;
 	__u32 len, prog_id, fd_type;
 	struct bpf_object *obj;
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
index c2a98a7..c71774 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
@@ -4,7 +4,7 @@
 static void test_task_fd_query_tp_core(const char *probe_name,
 				       const char *tp_name)
 {
-	const char *file = "./test_tracepoint.o";
+	const char *file = "./test_tracepoint.bpf.o";
 	int err, bytes, efd, prog_fd, pmu_fd;
 	struct perf_event_attr attr = {};
 	__u64 probe_offset, probe_addr;
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_estats.c b/tools/testing/selftests/bpf/prog_tests/tcp_estats.c
index 11bf75..032dbf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_estats.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_estats.c
@@ -3,7 +3,7 @@
 
 void test_tcp_estats(void)
 {
-	const char *file = "./test_tcp_estats.o";
+	const char *file = "./test_tcp_estats.bpf.o";
 	int err, prog_fd;
 	struct bpf_object *obj;
 	__u32 duration = 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index b90ee4..0c59c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -65,23 +65,23 @@ struct test_def {
 void test_test_global_funcs(void)
 {
 	struct test_def tests[] = {
-		{ "test_global_func1.o", "combined stack size of 4 calls is 544" },
-		{ "test_global_func2.o" },
-		{ "test_global_func3.o" , "the call stack of 8 frames" },
-		{ "test_global_func4.o" },
-		{ "test_global_func5.o" , "expected pointer to ctx, but got PTR" },
-		{ "test_global_func6.o" , "modified ctx ptr R2" },
-		{ "test_global_func7.o" , "foo() doesn't return scalar" },
-		{ "test_global_func8.o" },
-		{ "test_global_func9.o" },
-		{ "test_global_func10.o", "invalid indirect read from stack" },
-		{ "test_global_func11.o", "Caller passes invalid args into func#1" },
-		{ "test_global_func12.o", "invalid mem access 'mem_or_null'" },
-		{ "test_global_func13.o", "Caller passes invalid args into func#1" },
-		{ "test_global_func14.o", "reference type('FWD S') size cannot be determined" },
-		{ "test_global_func15.o", "At program exit the register R0 has value" },
-		{ "test_global_func16.o", "invalid indirect read from stack" },
-		{ "test_global_func17.o", "Caller passes invalid args into func#1" },
+		{ "test_global_func1.bpf.o", "combined stack size of 4 calls is 544" },
+		{ "test_global_func2.bpf.o" },
+		{ "test_global_func3.bpf.o" , "the call stack of 8 frames" },
+		{ "test_global_func4.bpf.o" },
+		{ "test_global_func5.bpf.o" , "expected pointer to ctx, but got PTR" },
+		{ "test_global_func6.bpf.o" , "modified ctx ptr R2" },
+		{ "test_global_func7.bpf.o" , "foo() doesn't return scalar" },
+		{ "test_global_func8.bpf.o" },
+		{ "test_global_func9.bpf.o" },
+		{ "test_global_func10.bpf.o", "invalid indirect read from stack" },
+		{ "test_global_func11.bpf.o", "Caller passes invalid args into func#1" },
+		{ "test_global_func12.bpf.o", "invalid mem access 'mem_or_null'" },
+		{ "test_global_func13.bpf.o", "Caller passes invalid args into func#1" },
+		{ "test_global_func14.bpf.o", "reference type('FWD S') size cannot be determined" },
+		{ "test_global_func15.bpf.o", "At program exit the register R0 has value" },
+		{ "test_global_func16.bpf.o", "invalid indirect read from stack" },
+		{ "test_global_func17.bpf.o", "Caller passes invalid args into func#1" },
 	};
 	libbpf_print_fn_t old_print_fn = NULL;
 	int err, i, duration = 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
index 05acb3..f27013 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
@@ -72,7 +72,7 @@ void test_test_overhead(void)
 	if (CHECK_FAIL(prctl(PR_GET_NAME, comm, 0L, 0L, 0L)))
 		return;
 
-	obj = bpf_object__open_file("./test_overhead.o", NULL);
+	obj = bpf_object__open_file("./test_overhead.bpf.o", NULL);
 	if (!ASSERT_OK_PTR(obj, "obj_open_file"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index 39e792..a47908 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -6,7 +6,7 @@ void serial_test_tp_attach_query(void)
 	const int num_progs = 3;
 	int i, j, bytes, efd, err, prog_fd[num_progs], pmu_fd[num_progs];
 	__u32 duration = 0, info_len, saved_prog_ids[num_progs];
-	const char *file = "./test_tracepoint.o";
+	const char *file = "./test_tracepoint.bpf.o";
 	struct perf_event_query_bpf *query;
 	struct perf_event_attr attr = {};
 	struct bpf_object *obj[num_progs];
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index b0acbd..564b75b 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -35,7 +35,7 @@ static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
 /* TODO: use different target function to run in concurrent mode */
 void serial_test_trampoline_count(void)
 {
-	char *file = "test_trampoline_count.o";
+	char *file = "test_trampoline_count.bpf.o";
 	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
 	struct inst inst[MAX_TRAMP_PROGS + 1] = {};
 	struct bpf_program *prog;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp.c b/tools/testing/selftests/bpf/prog_tests/xdp.c
index ec21c5..947863a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp.c
@@ -8,7 +8,7 @@ void test_xdp(void)
 	struct vip key6 = {.protocol = 6, .family = AF_INET6};
 	struct iptnl_info value4 = {.family = AF_INET};
 	struct iptnl_info value6 = {.family = AF_INET6};
-	const char *file = "./test_xdp.o";
+	const char *file = "./test_xdp.bpf.o";
 	struct bpf_object *obj;
 	char buf[128];
 	struct ipv6hdr iph6;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
index 2f033da..fce2036 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
@@ -4,7 +4,7 @@
 
 static void test_xdp_update_frags(void)
 {
-	const char *file = "./test_xdp_update_frags.o";
+	const char *file = "./test_xdp_update_frags.bpf.o";
 	int err, prog_fd, max_skb_frags, buf_size, num;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 21ceac..9b9cf84 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -4,7 +4,7 @@
 
 static void test_xdp_adjust_tail_shrink(void)
 {
-	const char *file = "./test_xdp_adjust_tail_shrink.o";
+	const char *file = "./test_xdp_adjust_tail_shrink.bpf.o";
 	__u32 expect_sz;
 	struct bpf_object *obj;
 	int err, prog_fd;
@@ -39,7 +39,7 @@ static void test_xdp_adjust_tail_shrink(void)
 
 static void test_xdp_adjust_tail_grow(void)
 {
-	const char *file = "./test_xdp_adjust_tail_grow.o";
+	const char *file = "./test_xdp_adjust_tail_grow.bpf.o";
 	struct bpf_object *obj;
 	char buf[4096]; /* avoid segfault: large buf to hold grow results */
 	__u32 expect_sz;
@@ -73,7 +73,7 @@ static void test_xdp_adjust_tail_grow(void)
 
 static void test_xdp_adjust_tail_grow2(void)
 {
-	const char *file = "./test_xdp_adjust_tail_grow.o";
+	const char *file = "./test_xdp_adjust_tail_grow.bpf.o";
 	char buf[4096]; /* avoid segfault: large buf to hold grow results */
 	int tailroom = 320; /* SKB_DATA_ALIGN(sizeof(struct skb_shared_info))*/;
 	struct bpf_object *obj;
@@ -135,7 +135,7 @@ static void test_xdp_adjust_tail_grow2(void)
 
 static void test_xdp_adjust_frags_tail_shrink(void)
 {
-	const char *file = "./test_xdp_adjust_tail_shrink.o";
+	const char *file = "./test_xdp_adjust_tail_shrink.bpf.o";
 	__u32 exp_size;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
@@ -202,7 +202,7 @@ static void test_xdp_adjust_frags_tail_shrink(void)
 
 static void test_xdp_adjust_frags_tail_grow(void)
 {
-	const char *file = "./test_xdp_adjust_tail_grow.o";
+	const char *file = "./test_xdp_adjust_tail_grow.bpf.o";
 	__u32 exp_size;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
index 62aa3e..062fbc 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -8,7 +8,7 @@ void serial_test_xdp_attach(void)
 {
 	__u32 duration = 0, id1, id2, id0 = 0, len;
 	struct bpf_object *obj1, *obj2, *obj3;
-	const char *file = "./test_xdp.o";
+	const char *file = "./test_xdp.bpf.o";
 	struct bpf_prog_info info = {};
 	int err, fd1, fd2, fd3;
 	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_info.c b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
index 0d01ff6..cd3aa34 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
@@ -7,7 +7,7 @@
 void serial_test_xdp_info(void)
 {
 	__u32 len = sizeof(struct bpf_prog_info), duration = 0, prog_id;
-	const char *file = "./xdp_dummy.o";
+	const char *file = "./xdp_dummy.bpf.o";
 	struct bpf_prog_info info = {};
 	struct bpf_object *obj;
 	int err, prog_fd;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_perf.c b/tools/testing/selftests/bpf/prog_tests/xdp_perf.c
index f543d1..ec5369 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_perf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_perf.c
@@ -3,7 +3,7 @@
 
 void test_xdp_perf(void)
 {
-	const char *file = "./xdp_dummy.o";
+	const char *file = "./xdp_dummy.bpf.o";
 	struct bpf_object *obj;
 	char in[128], out[128];
 	int err, prog_fd;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
index 874a84..75550a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
@@ -82,7 +82,7 @@ static void test_synproxy(bool xdp)
 	SYS("ethtool -K tmp0 tx off");
 	if (xdp)
 		/* Workaround required for veth. */
-		SYS("ip link set tmp0 xdp object xdp_dummy.o section xdp 2> /dev/null");
+		SYS("ip link set tmp0 xdp object xdp_dummy.bpf.o section xdp 2> /dev/null");
 
 	ns = open_netns("synproxy");
 	if (!ASSERT_OK_PTR(ns, "setns"))
diff --git a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
index 48cd14b4..4547b0 100644
--- a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
@@ -73,10 +73,10 @@ int test_subprog2(struct args_subprog2 *ctx)
 			      __builtin_preserve_access_index(&skb->len));
 
 	ret = ctx->ret;
-	/* bpf_prog_test_load() loads "test_pkt_access.o" with BPF_F_TEST_RND_HI32
-	 * which randomizes upper 32 bits after BPF_ALU32 insns.
-	 * Hence after 'w0 <<= 1' upper bits of $rax are random.
-	 * That is expected and correct. Trim them.
+	/* bpf_prog_test_load() loads "test_pkt_access.bpf.o" with
+	 * BPF_F_TEST_RND_HI32 which randomizes upper 32 bits after BPF_ALU32
+	 * insns. Hence after 'w0 <<= 1' upper bits of $rax are random. That is
+	 * expected and correct. Trim them.
 	 */
 	ret = (__u32) ret;
 	if (len != 74 || ret != 148)
diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testing/selftests/bpf/test_dev_cgroup.c
index 788626..adeaf6 100644
--- a/tools/testing/selftests/bpf/test_dev_cgroup.c
+++ b/tools/testing/selftests/bpf/test_dev_cgroup.c
@@ -16,7 +16,7 @@
 #include "cgroup_helpers.h"
 #include "testing_helpers.h"
 
-#define DEV_CGROUP_PROG "./dev_cgroup.o"
+#define DEV_CGROUP_PROG "./dev_cgroup.bpf.o"
 
 #define TEST_CGROUP "/test-bpf-based-device-cgroup/"
 
diff --git a/tools/testing/selftests/bpf/test_lirc_mode2_user.c b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
index 2893e9f..469442 100644
--- a/tools/testing/selftests/bpf/test_lirc_mode2_user.c
+++ b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
@@ -59,7 +59,7 @@ int main(int argc, char **argv)
 		return 2;
 	}
 
-	ret = bpf_prog_test_load("test_lirc_mode2_kern.o",
+	ret = bpf_prog_test_load("test_lirc_mode2_kern.bpf.o",
 				 BPF_PROG_TYPE_LIRC_MODE2, &obj, &progfd);
 	if (ret) {
 		printf("Failed to load bpf program\n");
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index cbebfa..c49f20 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -651,9 +651,9 @@ static void test_stackmap(unsigned int task, void *data)
 #include <arpa/inet.h>
 #include <sys/select.h>
 #include <linux/err.h>
-#define SOCKMAP_PARSE_PROG "./sockmap_parse_prog.o"
-#define SOCKMAP_VERDICT_PROG "./sockmap_verdict_prog.o"
-#define SOCKMAP_TCP_MSG_PROG "./sockmap_tcp_msg_prog.o"
+#define SOCKMAP_PARSE_PROG "./sockmap_parse_prog.bpf.o"
+#define SOCKMAP_VERDICT_PROG "./sockmap_verdict_prog.bpf.o"
+#define SOCKMAP_TCP_MSG_PROG "./sockmap_tcp_msg_prog.bpf.o"
 static void test_sockmap(unsigned int tasks, void *data)
 {
 	struct bpf_map *bpf_map_rx, *bpf_map_tx, *bpf_map_msg, *bpf_map_break;
@@ -1143,8 +1143,8 @@ static void test_sockmap(unsigned int tasks, void *data)
 	exit(1);
 }
 
-#define MAPINMAP_PROG "./test_map_in_map.o"
-#define MAPINMAP_INVALID_PROG "./test_map_in_map_invalid.o"
+#define MAPINMAP_PROG "./test_map_in_map.bpf.o"
+#define MAPINMAP_INVALID_PROG "./test_map_in_map_invalid.bpf.o"
 static void test_map_in_map(void)
 {
 	struct bpf_object *obj;
diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 6cd6ef..7fc15e0 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -782,7 +782,7 @@ if out.find("/sys/kernel/debug type debugfs") == -1:
     cmd("mount -t debugfs none /sys/kernel/debug")
 
 # Check samples are compiled
-samples = ["sample_ret0.o", "sample_map_ret0.o"]
+samples = ["sample_ret0.bpf.o", "sample_map_ret0.bpf.o"]
 for s in samples:
     ret, out = cmd("ls %s/%s" % (bpf_test_dir, s), fail=False)
     skip(ret != 0, "sample %s/%s not found, please compile it" %
@@ -803,7 +803,7 @@ cmd("ip netns delete %s" % (ns))
 netns = []
 
 try:
-    obj = bpf_obj("sample_ret0.o")
+    obj = bpf_obj("sample_ret0.bpf.o")
     bytecode = bpf_bytecode("1,6 0 0 4294967295,")
 
     start_test("Test destruction of generic XDP...")
@@ -1023,7 +1023,7 @@ try:
 
     sim.wait_for_flush()
     start_test("Test non-offload XDP attaching to HW...")
-    bpftool_prog_load("sample_ret0.o", "/sys/fs/bpf/nooffload")
+    bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/nooffload")
     nooffload = bpf_pinned("/sys/fs/bpf/nooffload")
     ret, _, err = sim.set_xdp(nooffload, "offload",
                               fail=False, include_stderr=True)
@@ -1032,7 +1032,7 @@ try:
     rm("/sys/fs/bpf/nooffload")
 
     start_test("Test offload XDP attaching to drv...")
-    bpftool_prog_load("sample_ret0.o", "/sys/fs/bpf/offload",
+    bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/offload",
                       dev=sim['ifname'])
     offload = bpf_pinned("/sys/fs/bpf/offload")
     ret, _, err = sim.set_xdp(offload, "drv", fail=False, include_stderr=True)
@@ -1043,7 +1043,7 @@ try:
 
     start_test("Test XDP load failure...")
     sim.dfs["dev/bpf_bind_verifier_accept"] = 0
-    ret, _, err = bpftool_prog_load("sample_ret0.o", "/sys/fs/bpf/offload",
+    ret, _, err = bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/offload",
                                  dev=sim['ifname'], fail=False, include_stderr=True)
     fail(ret == 0, "verifier should fail on load")
     check_verifier_log(err, "[netdevsim] Hello from netdevsim!")
@@ -1169,7 +1169,7 @@ try:
 
     simdev = NetdevSimDev()
     sim, = simdev.nsims
-    map_obj = bpf_obj("sample_map_ret0.o")
+    map_obj = bpf_obj("sample_map_ret0.bpf.o")
     start_test("Test loading program with maps...")
     sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
 
@@ -1307,10 +1307,10 @@ try:
     sims = (simA, simB1, simB2, simB3)
     simB = (simB1, simB2, simB3)
 
-    bpftool_prog_load("sample_map_ret0.o", "/sys/fs/bpf/nsimA",
+    bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/nsimA",
                       dev=simA['ifname'])
     progA = bpf_pinned("/sys/fs/bpf/nsimA")
-    bpftool_prog_load("sample_map_ret0.o", "/sys/fs/bpf/nsimB",
+    bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/nsimB",
                       dev=simB1['ifname'])
     progB = bpf_pinned("/sys/fs/bpf/nsimB")
 
@@ -1344,14 +1344,14 @@ try:
     mapA = bpftool("prog show %s" % (progA))[1]["map_ids"][0]
     mapB = bpftool("prog show %s" % (progB))[1]["map_ids"][0]
 
-    ret, _ = bpftool_prog_load("sample_map_ret0.o", "/sys/fs/bpf/nsimB_",
+    ret, _ = bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/nsimB_",
                                dev=simB3['ifname'],
                                maps=["idx 0 id %d" % (mapB)],
                                fail=False)
     fail(ret != 0, "couldn't reuse a map on the same ASIC")
     rm("/sys/fs/bpf/nsimB_")
 
-    ret, _, err = bpftool_prog_load("sample_map_ret0.o", "/sys/fs/bpf/nsimA_",
+    ret, _, err = bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/nsimA_",
                                     dev=simA['ifname'],
                                     maps=["idx 0 id %d" % (mapB)],
                                     fail=False, include_stderr=True)
@@ -1359,7 +1359,7 @@ try:
     fail(err.count("offload device mismatch between prog and map") == 0,
          "error message missing for cross-ASIC map")
 
-    ret, _, err = bpftool_prog_load("sample_map_ret0.o", "/sys/fs/bpf/nsimB_",
+    ret, _, err = bpftool_prog_load("sample_map_ret0.bpf.o", "/sys/fs/bpf/nsimB_",
                                     dev=simB1['ifname'],
                                     maps=["idx 0 id %d" % (mapA)],
                                     fail=False, include_stderr=True)
diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
index a9bc6f8..515c2ea 100755
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
+++ b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
@@ -54,7 +54,7 @@ DIR=$(dirname $0)
 TEST_IF="test_cgid_1"
 TEST_IF_PEER="test_cgid_2"
 MAX_PING_TRIES=5
-BPF_PROG_OBJ="${DIR}/test_skb_cgroup_id_kern.o"
+BPF_PROG_OBJ="${DIR}/test_skb_cgroup_id_kern.bpf.o"
 BPF_PROG_SECTION="cgroup_id_logger"
 BPF_PROG_ID=0
 PROG="${DIR}/test_skb_cgroup_id_user"
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 458564..2c8967 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -26,14 +26,14 @@
 #endif
 
 #define CG_PATH	"/foo"
-#define CONNECT4_PROG_PATH	"./connect4_prog.o"
-#define CONNECT6_PROG_PATH	"./connect6_prog.o"
-#define SENDMSG4_PROG_PATH	"./sendmsg4_prog.o"
-#define SENDMSG6_PROG_PATH	"./sendmsg6_prog.o"
-#define RECVMSG4_PROG_PATH	"./recvmsg4_prog.o"
-#define RECVMSG6_PROG_PATH	"./recvmsg6_prog.o"
-#define BIND4_PROG_PATH		"./bind4_prog.o"
-#define BIND6_PROG_PATH		"./bind6_prog.o"
+#define CONNECT4_PROG_PATH	"./connect4_prog.bpf.o"
+#define CONNECT6_PROG_PATH	"./connect6_prog.bpf.o"
+#define SENDMSG4_PROG_PATH	"./sendmsg4_prog.bpf.o"
+#define SENDMSG6_PROG_PATH	"./sendmsg6_prog.bpf.o"
+#define RECVMSG4_PROG_PATH	"./recvmsg4_prog.bpf.o"
+#define RECVMSG6_PROG_PATH	"./recvmsg6_prog.bpf.o"
+#define BIND4_PROG_PATH		"./bind4_prog.bpf.o"
+#define BIND6_PROG_PATH		"./bind6_prog.bpf.o"
 
 #define SERV4_IP		"192.168.1.254"
 #define SERV4_REWRITE_IP	"127.0.0.1"
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 0fbaccd..dcb038 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -52,8 +52,8 @@ static void running_handler(int a);
 #define S1_PORT 10000
 #define S2_PORT 10001
 
-#define BPF_SOCKMAP_FILENAME  "test_sockmap_kern.o"
-#define BPF_SOCKHASH_FILENAME "test_sockhash_kern.o"
+#define BPF_SOCKMAP_FILENAME  "test_sockmap_kern.bpf.o"
+#define BPF_SOCKHASH_FILENAME "test_sockhash_kern.bpf.o"
 #define CG_PATH "/sockmap"
 
 /* global sockets */
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index 57620e..bcdbd2 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -1372,7 +1372,7 @@ static struct sysctl_test tests[] = {
 	},
 	{
 		"C prog: deny all writes",
-		.prog_file = "./test_sysctl_prog.o",
+		.prog_file = "./test_sysctl_prog.bpf.o",
 		.attach_type = BPF_CGROUP_SYSCTL,
 		.sysctl = "net/ipv4/tcp_mem",
 		.open_flags = O_WRONLY,
@@ -1381,7 +1381,7 @@ static struct sysctl_test tests[] = {
 	},
 	{
 		"C prog: deny access by name",
-		.prog_file = "./test_sysctl_prog.o",
+		.prog_file = "./test_sysctl_prog.bpf.o",
 		.attach_type = BPF_CGROUP_SYSCTL,
 		.sysctl = "net/ipv4/route/mtu_expires",
 		.open_flags = O_RDONLY,
@@ -1389,7 +1389,7 @@ static struct sysctl_test tests[] = {
 	},
 	{
 		"C prog: read tcp_mem",
-		.prog_file = "./test_sysctl_prog.o",
+		.prog_file = "./test_sysctl_prog.bpf.o",
 		.attach_type = BPF_CGROUP_SYSCTL,
 		.sysctl = "net/ipv4/tcp_mem",
 		.open_flags = O_RDONLY,
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
index 102e65..b42c24 100755
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
@@ -76,7 +76,7 @@ main()
 DIR=$(dirname $0)
 TEST_IF=lo
 MAX_PING_TRIES=5
-BPF_PROG_OBJ="${DIR}/test_tcp_check_syncookie_kern.o"
+BPF_PROG_OBJ="${DIR}/test_tcp_check_syncookie_kern.bpf.o"
 CLSACT_SECTION="tc"
 XDP_SECTION="xdp"
 BPF_PROG_ID=0
diff --git a/tools/testing/selftests/bpf/test_tcpnotify_user.c b/tools/testing/selftests/bpf/test_tcpnotify_user.c
index 8284db..595194 100644
--- a/tools/testing/selftests/bpf/test_tcpnotify_user.c
+++ b/tools/testing/selftests/bpf/test_tcpnotify_user.c
@@ -69,7 +69,7 @@ int verify_result(const struct tcpnotify_globals *result)
 
 int main(int argc, char **argv)
 {
-	const char *file = "test_tcpnotify_kern.o";
+	const char *file = "test_tcpnotify_kern.bpf.o";
 	struct bpf_map *perf_map, *global_map;
 	struct tcpnotify_globals g = {0};
 	struct perf_buffer *pb = NULL;
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect.sh b/tools/testing/selftests/bpf/test_xdp_redirect.sh
index 1d79f3..0746a4 100755
--- a/tools/testing/selftests/bpf/test_xdp_redirect.sh
+++ b/tools/testing/selftests/bpf/test_xdp_redirect.sh
@@ -54,10 +54,10 @@ test_xdp_redirect()
 		return 0
 	fi
 
-	ip -n ${NS1} link set veth11 $xdpmode obj xdp_dummy.o sec xdp &> /dev/null
-	ip -n ${NS2} link set veth22 $xdpmode obj xdp_dummy.o sec xdp &> /dev/null
-	ip link set dev veth1 $xdpmode obj test_xdp_redirect.o sec redirect_to_222 &> /dev/null
-	ip link set dev veth2 $xdpmode obj test_xdp_redirect.o sec redirect_to_111 &> /dev/null
+	ip -n ${NS1} link set veth11 $xdpmode obj xdp_dummy.bpf.o sec xdp &> /dev/null
+	ip -n ${NS2} link set veth22 $xdpmode obj xdp_dummy.bpf.o sec xdp &> /dev/null
+	ip link set dev veth1 $xdpmode obj test_xdp_redirect.bpf.o sec redirect_to_222 &> /dev/null
+	ip link set dev veth2 $xdpmode obj test_xdp_redirect.bpf.o sec redirect_to_111 &> /dev/null
 
 	if ip netns exec ${NS1} ping -c 1 10.1.1.22 &> /dev/null &&
 	   ip netns exec ${NS2} ping -c 1 10.1.1.11 &> /dev/null; then
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
index cc57cb8..4c3c3fd 100755
--- a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
+++ b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
@@ -94,7 +94,7 @@ setup_ns()
 		# Add a neigh entry for IPv4 ping test
 		ip -n ${NS[$i]} neigh add 192.0.2.253 lladdr 00:00:00:00:00:01 dev veth0
 		ip -n ${NS[$i]} link set veth0 $mode obj \
-			xdp_dummy.o sec xdp &> /dev/null || \
+			xdp_dummy.bpf.o sec xdp &> /dev/null || \
 			{ test_fail "Unable to load dummy xdp" && exit 1; }
 		IFACES="$IFACES veth$i"
 		veth_mac[$i]=$(ip -n ${NS[0]} link show veth$i | awk '/link\/ether/ {print $2}')
diff --git a/tools/testing/selftests/bpf/test_xdp_veth.sh b/tools/testing/selftests/bpf/test_xdp_veth.sh
index 49936c..5211ca9 100755
--- a/tools/testing/selftests/bpf/test_xdp_veth.sh
+++ b/tools/testing/selftests/bpf/test_xdp_veth.sh
@@ -101,7 +101,7 @@ ip -n ${NS3} link set dev veth33 up
 
 mkdir $BPF_DIR
 bpftool prog loadall \
-	xdp_redirect_map.o $BPF_DIR/progs type xdp \
+	xdp_redirect_map.bpf.o $BPF_DIR/progs type xdp \
 	pinmaps $BPF_DIR/maps
 bpftool map update pinned $BPF_DIR/maps/tx_port key 0 0 0 0 value 122 0 0 0
 bpftool map update pinned $BPF_DIR/maps/tx_port key 1 0 0 0 value 133 0 0 0
@@ -110,9 +110,9 @@ ip link set dev veth1 xdp pinned $BPF_DIR/progs/xdp_redirect_map_0
 ip link set dev veth2 xdp pinned $BPF_DIR/progs/xdp_redirect_map_1
 ip link set dev veth3 xdp pinned $BPF_DIR/progs/xdp_redirect_map_2
 
-ip -n ${NS1} link set dev veth11 xdp obj xdp_dummy.o sec xdp
-ip -n ${NS2} link set dev veth22 xdp obj xdp_tx.o sec xdp
-ip -n ${NS3} link set dev veth33 xdp obj xdp_dummy.o sec xdp
+ip -n ${NS1} link set dev veth11 xdp obj xdp_dummy.bpf.o sec xdp
+ip -n ${NS2} link set dev veth22 xdp obj xdp_tx.bpf.o sec xdp
+ip -n ${NS3} link set dev veth33 xdp obj xdp_dummy.bpf.o sec xdp
 
 trap cleanup EXIT
 
diff --git a/tools/testing/selftests/bpf/xdp_redirect_multi.c b/tools/testing/selftests/bpf/xdp_redirect_multi.c
index c03b3a..c1fc44 100644
--- a/tools/testing/selftests/bpf/xdp_redirect_multi.c
+++ b/tools/testing/selftests/bpf/xdp_redirect_multi.c
@@ -142,7 +142,7 @@ int main(int argc, char **argv)
 	}
 	printf("\n");
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s_kern.bpf.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	err = libbpf_get_error(obj);
 	if (err)
diff --git a/tools/testing/selftests/bpf/xdp_synproxy.c b/tools/testing/selftests/bpf/xdp_synproxy.c
index d874dd..ff35320 100644
--- a/tools/testing/selftests/bpf/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/xdp_synproxy.c
@@ -193,7 +193,7 @@ static int syncookie_attach(const char *argv0, unsigned int ifindex, bool tc)
 	int prog_fd;
 	int err;
 
-	snprintf(xdp_filename, sizeof(xdp_filename), "%s_kern.o", argv0);
+	snprintf(xdp_filename, sizeof(xdp_filename), "%s_kern.bpf.o", argv0);
 	obj = bpf_object__open_file(xdp_filename, NULL);
 	err = libbpf_get_error(obj);
 	if (err < 0) {
diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
index 5b6f97..1503a1 100644
--- a/tools/testing/selftests/bpf/xdping.c
+++ b/tools/testing/selftests/bpf/xdping.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	snprintf(filename, sizeof(filename), "%s_kern.bpf.o", argv[0]);
 
 	if (bpf_prog_test_load(filename, BPF_PROG_TYPE_XDP, &obj, &prog_fd)) {
 		fprintf(stderr, "load of %s failed\n", filename);
-- 
2.30.2

