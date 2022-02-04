Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87B4AA425
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 00:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378006AbiBDXRS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 18:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiBDXRS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 18:17:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E62DFDA6D7
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 15:17:16 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g20so6205267pgn.10
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 15:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ym0egyZ6wQ+6Evxd/TMe29RTUH+h4dLheTJVj8yT+qk=;
        b=YU4FMY3Kr/luNSXm0vvEEiaMXgmjVLEVvTvcMrKxiofJpjjZoYilUwuqPz+aAdhJXN
         bOUmsAobNoA/Lv+pYccvuGn8jHPEG57KVmeElqFxvV+rGcRRIm2CVfBTtNTCFgeJoJ9P
         7NpJAynyKs6v2ySsTX1CBYg+6GuTqmkukvLRHX9lMU6T0NKZ++NI/GBccNi5YlCy2H9q
         rl4dZT+P1azc2Gum2gl6bmstBCmgZLtAz2mdj9zlyveGlramIKseieMzVduBOMVJBGMy
         09wYiBAPXA2RLfX7CJZ/vR8x9+wLFRmKTkoS9snQyvDxgGZb2JcDjP+iT0F8rQP/Kp4x
         KGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ym0egyZ6wQ+6Evxd/TMe29RTUH+h4dLheTJVj8yT+qk=;
        b=XADbshv2wWVBPVIKSbykQr4rVo9Gn2DSVRQcg+6BAKhA6NvKdSKJKwVU8PIqb6IDMj
         RKu08lrxI9IMKigkEdqAA83zMU30SWwbuwXYLLqjbNfuLf12asU63Ck7a7qYnFkhwF5M
         89fzbIP5vlRUleeJRf5CLTQpOsUz/srunTkki74FBPXGZAnQ9RsV0tO600qz9sYtwIr5
         RfZjn2Fwq7KGKAdh13A3tIdZmeBQ8DK7oPXkJ2s0sRC4FbaMwYhKKx5ulG07JkpvwzNE
         sfGHbisEemtcmi4+oFUwvFpBM0b0gGPqKH9NPsbkR6biQi15mB8fskH8mYaZLL6PLhR6
         uyHQ==
X-Gm-Message-State: AOAM532niKDvtAVBEXcgwK9gMbsRfK7Aa3BKTSfZYEZGiK1Cs24qMxAO
        T/ix82pqMhkhutiuMjUiybo=
X-Google-Smtp-Source: ABdhPJzVrw0aXFLmSq72gRuRlybsX27Wtg84wRaMHnfcZ8wUhbZ0PauDgxEEc82k3Kp2yyUAP+48Og==
X-Received: by 2002:a65:60d2:: with SMTP id r18mr1058668pgv.444.1644016635619;
        Fri, 04 Feb 2022 15:17:15 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:e4ee])
        by smtp.gmail.com with ESMTPSA id il18sm16014726pjb.27.2022.02.04.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:17:15 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 1/5] bpf: Extend sys_bpf commands for bpf_syscall programs.
Date:   Fri,  4 Feb 2022 15:17:06 -0800
Message-Id: <20220204231710.25139-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
References: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 72ce1edde950..08ac01acc51e 100644
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
+	struct bpf_prog *prog;
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

