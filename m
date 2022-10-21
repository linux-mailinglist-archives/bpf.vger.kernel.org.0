Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A759608089
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJUVHz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJUVHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:07:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF5C2A1D9E
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f9-20020a17090a654900b00210928389f8so7800207pjs.2
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3fGSgweRZaQlIUtk+ggwNnuo6kcjIj5U7JrtK/7+Vw=;
        b=dq8yIr2g0mhiGN9nlgf8v6ToqL33iFay/XKyDAXsyXtSJ1JRc8XU/sKIm5wI3Qp9Gv
         aVuUuCoMKO+4R02wXrn6BISSBsk1KfgRwCYxhE0gWHlTdAGSLa6vB/TKeyhS5feJNHEq
         Shs3lZJu78jLZnmAto4KBQwuNPDTdc1CgHZ0WzoA/m4KTI4vu6fb4pXy5u8ONXdA6J4P
         q3JBSDN2dTVok8UbpnKKwdsHIv/6wnr5YCaFJrAVcR/Yn71vn0Z8zWdyaWODl2eta/Rp
         s7rCUTteEBVShiXOVfzF5wNEMUARfvIeGsVrmA5HLQ4Nys2UUOip7kYt311T2LCfj02K
         Gq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3fGSgweRZaQlIUtk+ggwNnuo6kcjIj5U7JrtK/7+Vw=;
        b=Iw69WZW4Pvmhjnzdo/QcjjJvQra5tccJwga5Dlh8TeES/aB62f2cWeqpZdwUA2d9YE
         GbRo/EwtcY/3PEanBFdj/g4/sPIf++Y3RYjmj30Lr0OV9MWZ0cDce3uNxDVgkndl0/CV
         +9QvhAY81RcdSX/Ha46+iCRIrTzlIDxNMAPpDlPPZymTya9FYOm6YzJf7t60fT7PCc/5
         EMM3ltOeFLL4yDS0VxYOUKFXOUPmoDEIEbda4b/EC40wEtEMor+fyadJIVMKWPM5gDvc
         So/TNdm5IVSzeLuPqUBUbyUSJMRGn9KmKWixCNjTjmhkP2tXI9kke9xckDDptLBYwweB
         vEwg==
X-Gm-Message-State: ACrzQf1R5QOvohcSFmL5AhBFn2Ovxm0OiqTgjGIMvUP/PNlBDPuDolMP
        DpWI1YkkIW+0LjxyT81V1g8=
X-Google-Smtp-Source: AMsMyM5MUqo6QBlwq+NiVsP2y1t0xs7KXukVRWU7uuJuIN9qngGAGZPZVKYV/mNdglDqtWKgkwviUw==
X-Received: by 2002:a17:90b:4b0e:b0:20d:213b:1083 with SMTP id lx14-20020a17090b4b0e00b0020d213b1083mr24827690pjb.208.1666386469632;
        Fri, 21 Oct 2022 14:07:49 -0700 (PDT)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id b65-20020a62cf44000000b0053e6d352ae4sm15550107pfg.24.2022.10.21.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:07:49 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, bpf@vger.kernel.org, andrii@kernel.org,
        mykolal@fb.com, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Subject: [PATCH bpf-next 4/4] selftests/bpf: Initial DENYLIST for aarch64
Date:   Fri, 21 Oct 2022 14:07:01 -0700
Message-Id: <20221021210701.728135-5-chantr4@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021210701.728135-1-chantr4@gmail.com>
References: <20221021210701.728135-1-chantr4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Those tests are currently failing on aarch64, ignore them until they are
individually addressed.

Using this deny list, vmtest.sh ran successfully using

LLVM_STRIP=llvm-strip-16 CLANG=clang-16 \
    tools/testing/selftests/bpf/vmtest.sh  -- \
        ./test_progs -d \
            \"$(cat tools/testing/selftests/bpf/DENYLIST{,.aarch64} \
                | cut -d'#' -f1 \
                | sed -e 's/^[[:space:]]*//' \
                      -e 's/[[:space:]]*$//' \
                | tr -s '\n' ','\
            )\"

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 81 ++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.aarch64

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
new file mode 100644
index 000000000000..09416d5d2e33
--- /dev/null
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -0,0 +1,81 @@
+bloom_filter_map                                 # libbpf: prog 'check_bloom': failed to attach: ERROR: strerror_r(-524)=22
+bpf_cookie/lsm
+bpf_cookie/multi_kprobe_attach_api
+bpf_cookie/multi_kprobe_link_api
+bpf_cookie/trampoline
+bpf_loop/check_callback_fn_stop                  # link unexpected error: -524
+bpf_loop/check_invalid_flags
+bpf_loop/check_nested_calls
+bpf_loop/check_non_constant_callback
+bpf_loop/check_nr_loops
+bpf_loop/check_null_callback_ctx
+bpf_loop/check_stack
+bpf_mod_race                                     # bpf_mod_kfunc_race__attach unexpected error: -524 (errno 524)
+bpf_tcp_ca/dctcp_fallback
+btf_dump/btf_dump: var_data                      # find type id unexpected find type id: actual -2 < expected 0
+cgroup_hierarchical_stats                        # attach unexpected error: -524 (errno 524)
+d_path/basic                                     # setup attach failed: -524
+deny_namespace                                   # attach unexpected error: -524 (errno 524)
+fentry_fexit                                     # fentry_attach unexpected error: -1 (errno 524)
+fentry_test                                      # fentry_attach unexpected error: -1 (errno 524)
+fexit_sleep                                      # fexit_attach fexit attach failed: -1
+fexit_stress                                     # fexit attach unexpected fexit attach: actual -524 < expected 0
+fexit_test                                       # fexit_attach unexpected error: -1 (errno 524)
+get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
+get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
+htab_update/reenter_update
+kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
+kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
+kfunc_call/subprog_lskel                         # skel unexpected error: -2
+kfunc_dynptr_param/dynptr_data_null              # libbpf: prog 'dynptr_data_null': failed to attach: ERROR: strerror_r(-524)=22
+kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
+kprobe_multi_test/attach_api_pattern             # bpf_program__attach_kprobe_multi_opts unexpected error: -95
+kprobe_multi_test/attach_api_syms                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
+kprobe_multi_test/bench_attach                   # bpf_program__attach_kprobe_multi_opts unexpected error: -95
+kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: actual -95 < expected 0
+kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
+kprobe_multi_test/skel_api                       # kprobe_multi__attach unexpected error: -524 (errno 524)
+ksyms_module/libbpf                              # 'bpf_testmod_ksym_percpu': not found in kernel BTF
+ksyms_module/lskel                               # test_ksyms_module_lskel__open_and_load unexpected error: -2
+libbpf_get_fd_by_id_opts                         # test_libbpf_get_fd_by_id_opts__attach unexpected error: -524 (errno 524)
+lookup_key                                       # test_lookup_key__attach unexpected error: -524 (errno 524)
+lru_bug                                          # lru_bug__attach unexpected error: -524 (errno 524)
+modify_return                                    # modify_return__attach failed unexpected error: -524 (errno 524)
+module_attach                                    # skel_attach skeleton attach failed: -524
+mptcp/base                                       # run_test mptcp unexpected error: -524 (errno 524)
+netcnt                                           # packets unexpected packets: actual 10001 != expected 10000
+recursion                                        # skel_attach unexpected error: -524 (errno 524)
+ringbuf                                          # skel_attach skeleton attachment failed: -1
+setget_sockopt                                   # attach_cgroup unexpected error: -524
+sk_storage_tracing                               # test_sk_storage_tracing__attach unexpected error: -524 (errno 524)
+skc_to_unix_sock                                 # could not attach BPF object unexpected error: -524 (errno 524)
+socket_cookie                                    # prog_attach unexpected error: -524
+stacktrace_build_id                              # compare_stack_ips stackmap vs. stack_amap err -1 errno 2
+task_local_storage/exit_creds                    # skel_attach unexpected error: -524 (errno 524)
+task_local_storage/recursion                     # skel_attach unexpected error: -524 (errno 524)
+test_bprm_opts                                   # attach attach failed: -524
+test_ima                                         # attach attach failed: -524
+test_local_storage                               # attach lsm attach failed: -524
+test_lsm                                         # test_lsm_first_attach unexpected error: -524 (errno 524)
+test_overhead                                    # attach_fentry unexpected error: -524
+timer                                            # timer unexpected error: -524 (errno 524)
+timer_crash                                      # timer_crash__attach unexpected error: -524 (errno 524)
+timer_mim                                        # timer_mim unexpected error: -524 (errno 524)
+trace_printk                                     # trace_printk__attach unexpected error: -1 (errno 524)
+trace_vprintk                                    # trace_vprintk__attach unexpected error: -1 (errno 524)
+tracing_struct                                   # tracing_struct__attach unexpected error: -524 (errno 524)
+trampoline_count                                 # attach_prog unexpected error: -524
+unpriv_bpf_disabled                              # skel_attach unexpected error: -524 (errno 524)
+user_ringbuf/test_user_ringbuf_post_misaligned   # misaligned_skel unexpected error: -524 (errno 524)
+user_ringbuf/test_user_ringbuf_post_producer_wrong_offset
+user_ringbuf/test_user_ringbuf_post_larger_than_ringbuf_sz
+user_ringbuf/test_user_ringbuf_basic             # ringbuf_basic_skel unexpected error: -524 (errno 524)
+user_ringbuf/test_user_ringbuf_sample_full_ring_buffer
+user_ringbuf/test_user_ringbuf_post_alignment_autoadjust
+user_ringbuf/test_user_ringbuf_overfill
+user_ringbuf/test_user_ringbuf_discards_properly_ignored
+user_ringbuf/test_user_ringbuf_loop
+user_ringbuf/test_user_ringbuf_msg_protocol
+user_ringbuf/test_user_ringbuf_blocking_reserve
+verify_pkcs7_sig                                 # test_verify_pkcs7_sig__attach unexpected error: -524 (errno 524)
+vmlinux                                          # skel_attach skeleton attach failed: -524
-- 
2.30.2

