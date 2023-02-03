Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9951C689F22
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBCQZV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjBCQZU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:25:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834AA6B89
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:25:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42604B82B48
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616D4C433D2;
        Fri,  3 Feb 2023 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441508;
        bh=VMIdSt8+1TqovFmK0V2D7eVadXZ8nezXZiumP9Pd7OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azOba9yyI68V0Y9hedu9GH4CKyISpkg3IMLiwATpSQDGSeTo6GxH+04VCr0PvLz24
         MKRWx2ba+n6DQLbcXHKcehjtQOttha/bAoXbVxZ16s2VxA6yi5aPL+aPSrHwlH5iaM
         mA+A0HEUDtJGuCIYw3Gv21SwuRSvj7h2LBZmJWbYKDKUC8OSRg59hJAK/V3czpu9LU
         csOmR2t7w6l8aFm68dN0QeODIdfeHSb8udUOig6SrsCfTA8Pkx2ABzcEUt9++J2ReL
         kWv7mSk6qZaIRkGDoedE1A2RUQyoHI4SX1QKCviIOF2ol/jXHb4CqnhN4E1VwmKKrT
         C1y4q0uo8LtTw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv3 bpf-next 8/9] selftests/bpf: Remove extern from kfuncs declarations
Date:   Fri,  3 Feb 2023 17:23:35 +0100
Message-Id: <20230203162336.608323-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203162336.608323-1-jolsa@kernel.org>
References: <20230203162336.608323-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There's no need to keep the extern in kfuncs declarations.

Suggested-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index 86d94257716a..27d4494444c8 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -10,32 +10,32 @@
 #define __ksym
 #endif
 
-extern struct prog_test_ref_kfunc *
+struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
-extern struct prog_test_ref_kfunc *
+struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
+void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 
-extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
-extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
-extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
-extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
+void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
+int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+void bpf_kfunc_call_int_mem_release(int *p) __ksym;
+u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 
-extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
+void bpf_testmod_test_mod_kfunc(int i) __ksym;
 
-extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
+__u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
-extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
-extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
+int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
+struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
+long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 
-extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
-extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
-extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
-extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
+void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
+void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
+void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
+void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
-extern void bpf_kfunc_call_test_destructive(void) __ksym;
+void bpf_kfunc_call_test_destructive(void) __ksym;
 
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.39.1

