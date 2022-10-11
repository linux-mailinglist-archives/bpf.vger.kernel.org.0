Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C85FB899
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJKQxN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJKQxM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 12:53:12 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0195AC8;
        Tue, 11 Oct 2022 09:53:11 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id m6so3767217qkm.4;
        Tue, 11 Oct 2022 09:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpdgEuSb3F1ygoCxUKvxfcNnEzF8vOEvho0w1ANF7Ik=;
        b=p7jASqBKRU3iRdJlIT9TJZPazJ47R/+3MZc4UBPb3oYDllUx3xRuSLoTYEhB6IbdsE
         2w5O0irK0hUVW8iSseKvF+3Y1Q6oxjskfdQ6CsDHlW6LEnn+E1bbQLrLDUUiMoWHSSLM
         4R70E/52Rw70hqdcrjdojUDBjbnWkfIH//ZP8DDhlJY4Hp3/C985ImMCS9pHUrtqTX02
         JGWLYaY790ClEyqDmjpFOUjoz51gM+h5n2LcxLBcONt9lejOL6aT6DC+a620/eN2HQy4
         hUN0GMhWW3iQ3i5owV2ThqBIxJjQ9Csn5Zd7am+9zYq8R0yMETtEG8keT/InmVlcC+Ct
         sKQA==
X-Gm-Message-State: ACrzQf1PLPXIzrM3bx0bh/bvVjtab+CSPI4nBTE7fubl8+ICl07Q7Ycu
        EqaGBY3u6SZGGeQMHsbI6HFCXvONqqk5qA==
X-Google-Smtp-Source: AMsMyM6W5ZsZscEIHpfeWQe6aRYyPjgBKGlNrH/yKL2kGAqnpTFDuHrByFdg8NJ8ekAF3lc0X9JV1g==
X-Received: by 2002:ae9:e107:0:b0:6ed:638:930 with SMTP id g7-20020ae9e107000000b006ed06380930mr7354159qkm.211.1665507189867;
        Tue, 11 Oct 2022 09:53:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3552])
        by smtp.gmail.com with ESMTPSA id n1-20020a05622a11c100b0035d55c66a69sm11188715qtk.76.2022.10.11.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:53:09 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, sdf@google.com,
        song@kernel.org, yhs@fb.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Alphabetize DENYLISTs
Date:   Tue, 11 Oct 2022 11:52:55 -0500
Message-Id: <20221011165255.774014-1-void@manifault.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The DENYLIST and DENYLIST.s390x files are used to specify testcases
which should not be run on CI. Currently, testcases are appended to the
end of these files as needed. This can make it a pain to resolve merge
conflicts. This patch alphabetizes the DENYLIST files to ease this
burden.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/DENYLIST       |  2 +-
 tools/testing/selftests/bpf/DENYLIST.s390x | 40 +++++++++++-----------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/selftests/bpf/DENYLIST
index 939de574fc7f..5a07ecacd7b0 100644
--- a/tools/testing/selftests/bpf/DENYLIST
+++ b/tools/testing/selftests/bpf/DENYLIST
@@ -1,6 +1,6 @@
 # TEMPORARY
 get_stack_raw_tp    # spams with kernel warnings until next bpf -> bpf-next merge
-stacktrace_build_id_nmi
 stacktrace_build_id
+stacktrace_build_id_nmi
 task_fd_query_rawtp
 varlen
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index beef1232a47a..19d6f534e5be 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,13 +1,17 @@
 # TEMPORARY
 atomics                                  # attach(add): actual -524 <= expected 0                                      (trampoline)
-bpf_iter_setsockopt                      # JIT does not support calling kernel function                                (kfunc)
 bloom_filter_map                         # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
-bpf_tcp_ca                               # JIT does not support calling kernel function                                (kfunc)
+bpf_cookie                               # failed to open_and_load program: -524 (trampoline)
+bpf_iter_setsockopt                      # JIT does not support calling kernel function                                (kfunc)
 bpf_loop                                 # attaches to __x64_sys_nanosleep
 bpf_mod_race                             # BPF trampoline
 bpf_nf                                   # JIT does not support calling kernel function
+bpf_tcp_ca                               # JIT does not support calling kernel function                                (kfunc)
+cb_refs                                  # expected error message unexpected error: -524                               (trampoline)
+cgroup_hierarchical_stats                # JIT does not support calling kernel function                                (kfunc)
 core_read_macros                         # unknown func bpf_probe_read#4                                               (overlapping)
 d_path                                   # failed to auto-attach program 'prog_stat': -524                             (trampoline)
+deny_namespace                           # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
 dummy_st_ops                             # test_run unexpected error: -524 (errno 524)                                 (trampoline)
 fentry_fexit                             # fentry attach failed: -524                                                  (trampoline)
 fentry_test                              # fentry_first_attach unexpected error: -524                                  (trampoline)
@@ -18,19 +22,28 @@ fexit_test                               # fexit_first_attach unexpected error:
 get_func_args_test	                 # trampoline
 get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
+htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
 kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
 kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
+kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
+kprobe_multi_test                        # relies on fentry
 ksyms_module                             # test_ksyms_module__open_and_load unexpected error: -9                       (?)
 ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
 ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
+libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
+lookup_key                               # JIT does not support calling kernel function                                (kfunc)
+lru_bug                                  # prog 'printk': failed to auto-attach: -524
+map_kptr                                 # failed to open_and_load program: -524 (trampoline)
 modify_return                            # modify_return attach failed: -524                                           (trampoline)
 module_attach                            # skel_attach skeleton attach failed: -524                                    (trampoline)
 mptcp
-kprobe_multi_test                        # relies on fentry
 netcnt                                   # failed to load BPF skeleton 'netcnt_prog': -7                               (?)
 probe_user                               # check_kprobe_res wrong kprobe res from probe read                           (?)
 recursion                                # skel_attach unexpected error: -524                                          (trampoline)
 ringbuf                                  # skel_load skeleton load failed                                              (?)
+select_reuseport                         # intermittently fails on new s390x setup
+send_signal                              # intermittently fails to receive signal
+setget_sockopt                           # attach unexpected error: -524                                               (trampoline)
 sk_assign                                # Can't read on server: Invalid argument                                      (?)
 sk_lookup                                # endianness problem
 sk_storage_tracing                       # test_sk_storage_tracing__attach unexpected error: -524                      (trampoline)
@@ -52,28 +65,15 @@ timer_mim                                # failed to auto-attach program 'test1'
 trace_ext                                # failed to auto-attach program 'test_pkt_md_access_new': -524                (trampoline)
 trace_printk                             # trace_printk__load unexpected error: -2 (errno 2)                           (?)
 trace_vprintk                            # trace_vprintk__open_and_load unexpected error: -9                           (?)
+tracing_struct                           # failed to auto-attach: -524                                                 (trampoline)
 trampoline_count                         # prog 'prog1': failed to attach: ERROR: strerror_r(-524)=22                  (trampoline)
+unpriv_bpf_disabled                      # fentry
+user_ringbuf                             # failed to find kernel BTF type ID of '__s390x_sys_prctl': -3                (?)
 verif_stats                              # trace_vprintk__open_and_load unexpected error: -9                           (?)
+verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
 vmlinux                                  # failed to auto-attach program 'handle__fentry': -524                        (trampoline)
 xdp_adjust_tail                          # case-128 err 0 errno 28 retval 1 size 128 expect-size 3520                  (?)
 xdp_bonding                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
 xdp_bpf2bpf                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
-map_kptr                                 # failed to open_and_load program: -524 (trampoline)
-bpf_cookie                               # failed to open_and_load program: -524 (trampoline)
 xdp_do_redirect                          # prog_run_max_size unexpected error: -22 (errno 22)
-send_signal                              # intermittently fails to receive signal
-select_reuseport                         # intermittently fails on new s390x setup
 xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
-unpriv_bpf_disabled                      # fentry
-lru_bug                                  # prog 'printk': failed to auto-attach: -524
-setget_sockopt                           # attach unexpected error: -524                                               (trampoline)
-cb_refs                                  # expected error message unexpected error: -524                               (trampoline)
-cgroup_hierarchical_stats                # JIT does not support calling kernel function                                (kfunc)
-htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
-tracing_struct                           # failed to auto-attach: -524                                                 (trampoline)
-user_ringbuf                             # failed to find kernel BTF type ID of '__s390x_sys_prctl': -3                (?)
-lookup_key                               # JIT does not support calling kernel function                                (kfunc)
-verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
-kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
-deny_namespace                           # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
-libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
-- 
2.38.0

