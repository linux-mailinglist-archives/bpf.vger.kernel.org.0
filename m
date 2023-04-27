Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1345E6F0784
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbjD0Ocm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243440AbjD0Ocj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 10:32:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29240F8
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 07:32:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2fbb99cb297so7845106f8f.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682605932; x=1685197932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NC7nq0EbIOtkjFyp1W7XN3emfgeyS+wIyNqgVyHKOuU=;
        b=SeAz2TjPKuEo4D4KgtTb/qTkQK1pezteODWCgPPn1nz/+7aisQtWiBIUaVhuYhg/jt
         9PcV106ADxzwNuJFqn6Wy/O9K7gheXVKn2Ek+XRhLFa5VDHPKUMoYqowG5EZBPsiK0Hl
         JGMFxaLMfQe926eIh0Farg2EQ1wcmvCXPx1Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605932; x=1685197932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC7nq0EbIOtkjFyp1W7XN3emfgeyS+wIyNqgVyHKOuU=;
        b=Or+GsXt0gEflQOp3CXuG0Tw0JZ8tY9LQS/fG2oc/cQVvQD7kZ7+83yZGuY5merJV5i
         cGyq5ASDHmxfT6rFcsRSId+BtGRtUYMgDS3MW3t0ZnZUdr1YP4b3tM/5BkBnDjp+X4Qf
         JEGpJMEVg8YBOmwIWKkqMpReFvkvOKIHAslHbk9IzwtDqhz6JQ6M5CfxdHj8rxB9aTzd
         t1hKF1J54JUk+i8bl4w0VjZIxjXdw1+mSEEIC1q6fRocMcRNMRmIW3qtBpKfIqJCWFm8
         CkuJ0AqFOXZ1kQWpFDPCOquyIbGTYS+//my5Heoxl81g33SPblQ8QpansqfzEfOElKIA
         JMiw==
X-Gm-Message-State: AC+VfDw8k07cq0HHGRpANOIqqyS6tgN3yVPKVxuvrcCI6tmHr4kc6JsN
        HWvZXLDelphaRQ0puZngzYSnePwZpOf8yDyiZac=
X-Google-Smtp-Source: ACHHUZ50LBDYutiMUxQ1tWNieYj/8HkeAXbjh0HR/2VCNyZAhByDhZ+SqEjFucyOyBTLclm571HD0Q==
X-Received: by 2002:adf:fe8b:0:b0:2f2:3dbf:6922 with SMTP id l11-20020adffe8b000000b002f23dbf6922mr1408147wrr.22.1682605932268;
        Thu, 27 Apr 2023 07:32:12 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:a66d:4f2c:7ce5:e8ea])
        by smtp.gmail.com with ESMTPSA id u6-20020adff886000000b002f28de9f73bsm18735484wrp.55.2023.04.27.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:32:11 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, mykolal@fb.com, martin.lau@linux.dev,
        song@kernel.org, xukuohai@huaweicloud.com, mark.rutland@arm.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] selftests/bpf: Update the aarch64 tests deny list
Date:   Thu, 27 Apr 2023 16:32:07 +0200
Message-ID: <20230427143207.635263-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that ftrace supports direct call on arm64, BPF tracing programs work
on that architecture. This fixes the vast majority of BPF selftests
except for:

- multi_kprobe programs which require fprobe, not available on arm64 yet
- tracing_struct which requires trampoline support to access struct args

This patch updates the list of BPF selftests which are known to fail so
the BPF CI can validate the tests which pass now.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 81 +-------------------
 1 file changed, 4 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 0a6837f97c32..4b6b18424140 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,33 +1,5 @@
-bloom_filter_map                                 # libbpf: prog 'check_bloom': failed to attach: ERROR: strerror_r(-524)=22
-bpf_cookie/lsm
-bpf_cookie/multi_kprobe_attach_api
-bpf_cookie/multi_kprobe_link_api
-bpf_cookie/trampoline
-bpf_loop/check_callback_fn_stop                  # link unexpected error: -524
-bpf_loop/check_invalid_flags
-bpf_loop/check_nested_calls
-bpf_loop/check_non_constant_callback
-bpf_loop/check_nr_loops
-bpf_loop/check_null_callback_ctx
-bpf_loop/check_stack
-bpf_mod_race                                     # bpf_mod_kfunc_race__attach unexpected error: -524 (errno 524)
-bpf_tcp_ca/dctcp_fallback
-btf_dump/btf_dump: var_data                      # find type id unexpected find type id: actual -2 < expected 0
-cgroup_hierarchical_stats                        # attach unexpected error: -524 (errno 524)
-d_path/basic                                     # setup attach failed: -524
-deny_namespace                                   # attach unexpected error: -524 (errno 524)
-fentry_fexit                                     # fentry_attach unexpected error: -1 (errno 524)
-fentry_test                                      # fentry_attach unexpected error: -1 (errno 524)
-fexit_sleep                                      # fexit_attach fexit attach failed: -1
-fexit_stress                                     # fexit attach unexpected fexit attach: actual -524 < expected 0
-fexit_test                                       # fexit_attach unexpected error: -1 (errno 524)
-get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
-get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
-htab_update/reenter_update
-kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
-kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
-kfunc_call/subprog_lskel                         # skel unexpected error: -2
-kfunc_dynptr_param/dynptr_data_null              # libbpf: prog 'dynptr_data_null': failed to attach: ERROR: strerror_r(-524)=22
+bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
+bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/attach_api_pattern             # bpf_program__attach_kprobe_multi_opts unexpected error: -95
@@ -35,51 +7,6 @@ kprobe_multi_test/attach_api_syms                # bpf_program__attach_kprobe_mu
 kprobe_multi_test/bench_attach                   # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: actual -95 < expected 0
 kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
-kprobe_multi_test/skel_api                       # kprobe_multi__attach unexpected error: -524 (errno 524)
-ksyms_module/libbpf                              # 'bpf_testmod_ksym_percpu': not found in kernel BTF
-ksyms_module/lskel                               # test_ksyms_module_lskel__open_and_load unexpected error: -2
-libbpf_get_fd_by_id_opts                         # test_libbpf_get_fd_by_id_opts__attach unexpected error: -524 (errno 524)
-linked_list
-lookup_key                                       # test_lookup_key__attach unexpected error: -524 (errno 524)
-lru_bug                                          # lru_bug__attach unexpected error: -524 (errno 524)
-modify_return                                    # modify_return__attach failed unexpected error: -524 (errno 524)
-module_attach                                    # skel_attach skeleton attach failed: -524
-module_fentry_shadow                             # bpf_link_create unexpected bpf_link_create: actual -524 < expected 0
-mptcp/base                                       # run_test mptcp unexpected error: -524 (errno 524)
-netcnt                                           # packets unexpected packets: actual 10001 != expected 10000
-rcu_read_lock                                    # failed to attach: ERROR: strerror_r(-524)=22
-recursion                                        # skel_attach unexpected error: -524 (errno 524)
-ringbuf                                          # skel_attach skeleton attachment failed: -1
-setget_sockopt                                   # attach_cgroup unexpected error: -524
-sk_storage_tracing                               # test_sk_storage_tracing__attach unexpected error: -524 (errno 524)
-skc_to_unix_sock                                 # could not attach BPF object unexpected error: -524 (errno 524)
-socket_cookie                                    # prog_attach unexpected error: -524
-stacktrace_build_id                              # compare_stack_ips stackmap vs. stack_amap err -1 errno 2
-task_local_storage/exit_creds                    # skel_attach unexpected error: -524 (errno 524)
-task_local_storage/recursion                     # skel_attach unexpected error: -524 (errno 524)
-test_bprm_opts                                   # attach attach failed: -524
-test_ima                                         # attach attach failed: -524
-test_local_storage                               # attach lsm attach failed: -524
-test_lsm                                         # test_lsm_first_attach unexpected error: -524 (errno 524)
-test_overhead                                    # attach_fentry unexpected error: -524
-timer                                            # timer unexpected error: -524 (errno 524)
-timer_crash                                      # timer_crash__attach unexpected error: -524 (errno 524)
-timer_mim                                        # timer_mim unexpected error: -524 (errno 524)
-trace_printk                                     # trace_printk__attach unexpected error: -1 (errno 524)
-trace_vprintk                                    # trace_vprintk__attach unexpected error: -1 (errno 524)
+kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
+module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
 tracing_struct                                   # tracing_struct__attach unexpected error: -524 (errno 524)
-trampoline_count                                 # attach_prog unexpected error: -524
-unpriv_bpf_disabled                              # skel_attach unexpected error: -524 (errno 524)
-user_ringbuf/test_user_ringbuf_post_misaligned   # misaligned_skel unexpected error: -524 (errno 524)
-user_ringbuf/test_user_ringbuf_post_producer_wrong_offset
-user_ringbuf/test_user_ringbuf_post_larger_than_ringbuf_sz
-user_ringbuf/test_user_ringbuf_basic             # ringbuf_basic_skel unexpected error: -524 (errno 524)
-user_ringbuf/test_user_ringbuf_sample_full_ring_buffer
-user_ringbuf/test_user_ringbuf_post_alignment_autoadjust
-user_ringbuf/test_user_ringbuf_overfill
-user_ringbuf/test_user_ringbuf_discards_properly_ignored
-user_ringbuf/test_user_ringbuf_loop
-user_ringbuf/test_user_ringbuf_msg_protocol
-user_ringbuf/test_user_ringbuf_blocking_reserve
-verify_pkcs7_sig                                 # test_verify_pkcs7_sig__attach unexpected error: -524 (errno 524)
-vmlinux                                          # skel_attach skeleton attach failed: -524
-- 
2.40.1.495.gc816e09b53d-goog

