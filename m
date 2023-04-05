Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539C66D859F
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjDESE0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjDESEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 14:04:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDC96A4E
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 11:03:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso24243520wms.1
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680717782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQdcTlDGXvPRJ4m15hfcne85GRNuWqVXBxpqryUgNqc=;
        b=DzGA6NL7PFjpkBNgTxQ8fPF/wI6uojo5o+hoBkP00PtSFDftbFN10OBnm60fqSjHfY
         RoDRjnCTLB3EDE4JQG0YC/TkNNT2GbF3+Ie2TIcX0ylQ8d55buoS3o8udqunISyH1JX8
         HxsvCvbxk9syy6I7b4xrXC36+6yxsYeXfYA5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQdcTlDGXvPRJ4m15hfcne85GRNuWqVXBxpqryUgNqc=;
        b=HFbpa0d7lmH268k1VtBJZ2s7XrDXOKlikKiU7nEPM954tG1jKZbJzzRnWtDMt78m5C
         j+RQ4rc6o63eCu9Lu20OK2neV9MMUHu7dwH9PZt4SPY031XU0D2Z4uJfeKayBQQvbJBg
         uZX7DpyWTC4QB77EZIjIjKG28dyqRmyh/mK4jhlQdE1T1vKOdpukZSlMXz/5kAoQvRvt
         PgSuCI1D7u/BNANN+Tt5P0e7msYYRSBej/NInl81INoxoOipUqcnFXc6+qnXK0aNF7Nx
         Q6x+yyI9OcR4F16OZteKKYqALDBlN34aZwcxKptRR9d4KvQVjaA7Vg1aNUtm9I8IBT3g
         VmXw==
X-Gm-Message-State: AAQBX9e7tZ8f9NtC5tx7Lgsz2tJGLzVP7UmETdeTEXJZRo/LbFo0Y/FT
        mUyTNh/5YM9XlUol5qxwgLnb5Q==
X-Google-Smtp-Source: AKy350atwB7m2uAvdLkAs0GkN4WMx7NuiwMzD0Tg6MaI9xhXWQOqFnENfLJpeMTEz25CAljjq65WsQ==
X-Received: by 2002:a05:600c:21ca:b0:3eb:3104:efef with SMTP id x10-20020a05600c21ca00b003eb3104efefmr5464126wmj.31.1680717781652;
        Wed, 05 Apr 2023 11:03:01 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:cf6a:9ae6:15f1:4213])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b003f0472ffc7csm2913233wmb.11.2023.04.05.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:03:01 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v6 5/5] selftests/bpf: Update the tests deny list on aarch64
Date:   Wed,  5 Apr 2023 20:02:50 +0200
Message-Id: <20230405180250.2046566-6-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230405180250.2046566-1-revest@chromium.org>
References: <20230405180250.2046566-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 82 ++------------------
 1 file changed, 5 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 99cc33c51eaa..6b95cb544094 100644
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
@@ -35,50 +7,6 @@ kprobe_multi_test/attach_api_syms                # bpf_program__attach_kprobe_mu
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
-tracing_struct                                   # tracing_struct__attach unexpected error: -524 (errno 524)
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
+kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
+module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
+tracing_struct                                   # tracing_struct__attach unexpected error: -524 (errno 524)
\ No newline at end of file
-- 
2.40.0.577.gac1e443424-goog

