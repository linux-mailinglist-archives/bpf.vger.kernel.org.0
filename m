Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A34AE1FF
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 20:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385633AbiBHTNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 14:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385605AbiBHTNM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 14:13:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94A9C0612C1
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 11:13:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so3889246pjb.1
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KaEbUFRJyIgT3B5jjuOV+HjcH9SCqSe/5cpM0kVQMrA=;
        b=B2BbQ6dADYysJydxqi1pXzQGaW49DV6QcF7hshP4ss5OkaHQMvJkhrpjhePbR7SGQb
         BVRNqpjWNZMguQj8JlxP2a+TmZxOIpBQzLmjLO1MwfvN1yG7U2YY6+sgrIq4IxUKeWI7
         h5KWNdYs+6uviIx+ayD3l9IwTvkFFcK8WVM54npxKvp/DVUbyU0CCCQnleBNIFjk/K6G
         CXXxR9ymnL5afGoIc6C3WcMLRrfL7I3s4B547u8JANjNQwiaKzSCJ8ploK54WO9s9HyY
         ixHPoYm45Y3tjcKo7esBv62qTPuqmdWmamvCIQMNS5zfVr3gL7ONnvSrjgTgEzvn4CUU
         aijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KaEbUFRJyIgT3B5jjuOV+HjcH9SCqSe/5cpM0kVQMrA=;
        b=kSFF756GJFZ8RxOYQB+hC3GEeHXD5SHw37OwuDUhJeMwTm93YViu6ku8Do9C/iOXTg
         zosILiGG5QuHXb3JFS5LNywa1OC+0SXdSPZCMGiUvCpcjxGl2M5qe9ZhilMUhONsulrT
         m4dKtV+1JNP4N+6SRWB99K+jt2rIpdO3bV6V3nhnF4BIe7wc0erVfuGF3Ocy6Zao6AfC
         KIZAquFpB9RWIvthFrWwQRf85HtuYoNd3EETCD6v+J31kDpRVOyC9nFyAvUmcx3yAT0n
         nL30mZ6IciDP+jhOKSD/A3wK+DGEAyRnph45LQzTPU4aXPk3BSyrvuFQRJngk8dNmq33
         FsZg==
X-Gm-Message-State: AOAM530aMhay7+sR4BoYNEIO8ncX+h2VqAB0Nk2oy825QFyvrCCRTPw4
        xED7v3Cw2EUgUqTW1Mi8I+E=
X-Google-Smtp-Source: ABdhPJzIcCAtMR77lvPc58feKCnTFdkf5oxpwU0NVT7yXezcshwcipIthq/n6OP2TUA4n2uaJnKKPA==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr5866700plk.23.1644347591180;
        Tue, 08 Feb 2022 11:13:11 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:72b2])
        by smtp.gmail.com with ESMTPSA id gx10sm3508459pjb.7.2022.02.08.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:13:10 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 1/5] bpf: Extend sys_bpf commands for bpf_syscall programs.
Date:   Tue,  8 Feb 2022 11:13:02 -0800
Message-Id: <20220208191306.6136-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

bpf_sycall programs can be used directly by the kernel modules
to load programs and create maps via kernel skeleton.
. Export bpf_sys_bpf syscall wrapper to be used in kernel skeleton.
. Export bpf_map_get to be used in kernel skeleton.
. Allow prog_run cmd for bpf_syscall programs with recursion check.
. Enable link_create and raw_tp_open cmds.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 72ce1edde950..49f88b30662a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -985,6 +985,7 @@ struct bpf_map *bpf_map_get(u32 ufd)
 
 	return map;
 }
+EXPORT_SYMBOL(bpf_map_get);
 
 struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 {
@@ -4756,23 +4757,52 @@ static bool syscall_prog_is_valid_access(int off, int size,
 	return true;
 }
 
-BPF_CALL_3(bpf_sys_bpf, int, cmd, void *, attr, u32, attr_size)
+BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
 {
+	struct bpf_prog * __maybe_unused prog;
+
 	switch (cmd) {
 	case BPF_MAP_CREATE:
 	case BPF_MAP_UPDATE_ELEM:
 	case BPF_MAP_FREEZE:
 	case BPF_PROG_LOAD:
 	case BPF_BTF_LOAD:
+	case BPF_LINK_CREATE:
+	case BPF_RAW_TRACEPOINT_OPEN:
 		break;
-	/* case BPF_PROG_TEST_RUN:
-	 * is not part of this list to prevent recursive test_run
-	 */
+#ifdef CONFIG_BPF_JIT /* __bpf_prog_enter_sleepable used by trampoline and JIT */
+	case BPF_PROG_TEST_RUN:
+		if (attr->test.data_in || attr->test.data_out ||
+		    attr->test.ctx_out || attr->test.duration ||
+		    attr->test.repeat || attr->test.flags)
+			return -EINVAL;
+
+		prog = bpf_prog_get_type(attr->test.prog_fd, BPF_PROG_TYPE_SYSCALL);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+
+		if (attr->test.ctx_size_in < prog->aux->max_ctx_offset ||
+		    attr->test.ctx_size_in > U16_MAX) {
+			bpf_prog_put(prog);
+			return -EINVAL;
+		}
+
+		if (!__bpf_prog_enter_sleepable(prog)) {
+			/* recursion detected */
+			bpf_prog_put(prog);
+			return -EBUSY;
+		}
+		attr->test.retval = bpf_prog_run(prog, (void *) (long) attr->test.ctx_in);
+		__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats */);
+		bpf_prog_put(prog);
+		return 0;
+#endif
 	default:
 		return -EINVAL;
 	}
 	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size);
 }
+EXPORT_SYMBOL(bpf_sys_bpf);
 
 static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.func		= bpf_sys_bpf,
-- 
2.30.2

