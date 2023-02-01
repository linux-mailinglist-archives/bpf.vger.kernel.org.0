Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5061686D0F
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjBARbd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjBARbE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:31:04 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A577D6E6;
        Wed,  1 Feb 2023 09:30:29 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id w3so9107243qts.7;
        Wed, 01 Feb 2023 09:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmYeQHTJJ+BqQ7/b7CPgYScTbqD+a3RMWdPSk3vQJO0=;
        b=MmDkjk4x0O1mFCGQ5y0jlCWvOuYkG2A+r8uJWrlrtug56o2iwKOxSOPHtWsev4WXp4
         O/WkPMqdgIip0/qg6V/OlkbK3jPO8S/PSPDcy2UQWXKd3HtxNWfrV7BP6H4kiYKzFp/s
         z4+XxpZWGtsRyuHflkJIj9D1SZOd/sjhYuMFy36m+aCRNT1mZxd7f2DhMldIljRGyi2R
         CeWvAxHGRLsxeRCeWAT4gp5eobPJBzGXMYHf8NVEp4zBcQ7clRF5lYSHdQFJic062LOH
         HIynKwG/Wi2K+o2QAxy70LWg/ksiQ9SUYLLglEjINLAyIEzP5punx4tOPSOPVcguoaxG
         0gJQ==
X-Gm-Message-State: AO0yUKVgRD9IdzCXIRsd/O8+xTbZ88eAEtpzBQfajkRFTNIAqENdwaYr
        kDooO9x5DeWR6zUXaUkM/9xCZYEAu6H/szTA
X-Google-Smtp-Source: AK7set9R1ochULuyhQOux1zSB/fGIvwkoteQCt+LiG7zEs9wow6ZJY1dgXpM4b/09rOU/o6DQAOYoA==
X-Received: by 2002:a05:622a:507:b0:3b6:302d:714 with SMTP id l7-20020a05622a050700b003b6302d0714mr5002056qtx.4.1675272627840;
        Wed, 01 Feb 2023 09:30:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1971])
        by smtp.gmail.com with ESMTPSA id bs18-20020ac86f12000000b003b8558eabd0sm7688598qtb.23.2023.02.01.09.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:30:27 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, corbet@lwn.net, hch@infradead.org,
        acme@kernel.org, alan.maguire@oracle.com
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Add testcase for static kfunc with unused arg
Date:   Wed,  1 Feb 2023 11:30:16 -0600
Message-Id: <20230201173016.342758-5-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201173016.342758-1-void@manifault.com>
References: <20230201173016.342758-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kfuncs are allowed to be static, or not use one or more of their
arguments. For example, bpf_xdp_metadata_rx_hash() in net/core/xdp.c is
meant to be implemented by drivers, with the default implementation just
returning -EOPNOTSUPP. As described in [0], such kfuncs can have their
arguments elided, which can cause BTF encoding to be skipped. The new
__bpf_kfunc macro should address this, and this patch adds a selftest
which verifies that a static kfunc with at least one unused argument can
still be encoded and invoked by a BPF program.

Signed-off-by: David Vernet <void@manifault.com>
---
 net/bpf/test_run.c                                  |  6 ++++++
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c |  1 +
 tools/testing/selftests/bpf/progs/kfunc_call_test.c | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index af9827c4b351..e6f773d12045 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -741,6 +741,11 @@ __bpf_kfunc void bpf_kfunc_call_test_destructive(void)
 {
 }
 
+__bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused)
+{
+	return arg;
+}
+
 __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
@@ -779,6 +784,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index bb4cd82a788a..a543742cd7bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -77,6 +77,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_TEST(kfunc_call_test_get_mem, 42),
 	SYSCALL_TEST(kfunc_syscall_test, 0),
 	SYSCALL_NULL_CTX_TEST(kfunc_syscall_test_null, 0),
+	TC_TEST(kfunc_call_test_static_unused_arg, 0),
 };
 
 struct syscall_test_args {
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index d91c58d06d38..7daa8f5720b9 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -17,6 +17,7 @@ extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
 extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
 extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 
 SEC("tc")
 int kfunc_call_test4(struct __sk_buff *skb)
@@ -181,4 +182,14 @@ int kfunc_call_test_get_mem(struct __sk_buff *skb)
 	return ret;
 }
 
+SEC("tc")
+int kfunc_call_test_static_unused_arg(struct __sk_buff *skb)
+{
+
+	u32 expected = 5, actual;
+
+	actual = bpf_kfunc_call_test_static_unused_arg(expected, 0xdeadbeef);
+	return actual != expected ? -1 : 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.39.0

