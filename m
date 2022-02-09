Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D24B0122
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 00:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiBIXUL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 18:20:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiBIXUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 18:20:10 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB94E06786C
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 15:20:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k17so329710plk.0
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 15:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXEpBl9Bjx/UIuskvPdDre+BWHevTDTuWJ/EW9M/Hi4=;
        b=Mm8TjwkbhRB/BwJMN+7XXZ97DZjNFlJsOSNze5U+T9hHA7TrEsMlCNQ/Q5omphSBzc
         VoFrJZMSF0fmU+1td1P/DO3Qu3xO5sAIsFvix3Y8NLWiMsNShCDt3jYhzY1vGOFIk6Sm
         +T48kXOqfSDa0A5H8nKDOl+KIT7w3+S0JcaaReS7NT+V+vTp1azU3eZq+6a0tt5VIpwP
         ZORTPaq/FjmbCcYiWt/GFVwI1v6PnkDKnkXbT7pQkY6wJs67Jgm0OAhifgVyOTWhY7pW
         vzITlfigaIjSC4nRvVEIOaRIptT2VHdaQb8rsaNDrwEb8AnLt7MQBb66gXnexczQEaSj
         DJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXEpBl9Bjx/UIuskvPdDre+BWHevTDTuWJ/EW9M/Hi4=;
        b=GXaCS7YXE+5Akvwa1gA+mYlGLFgqeWgDjRQNGS1lxrOOm/FfYF4OkzUXyG7xfimP1x
         xRHLAlZ2bDAxI9DLTwtbdNtg+pJMYOpDILzeaYLZcYkCIdKYbuLhOGsObLpGeQNLxG/n
         n1FRu1Ao+X9FkFjQTzwY9ghhAehFdTEhVDnYmhlJZjCwqrlpGOJozB9nWvdmqUCEZaS8
         s6CkCJIEGHaZ2LBfSEwnNy1Zpn6ErZPJ3SNMKhtzt5NzyPS5bil+R9steKFQmBK4YEHc
         EslGvi06tdiP7RhjaNXimQ4XPDiCi3UmmHhl8YXyqjyr6pNY70BnCErTFxnaovtj7szo
         m/KQ==
X-Gm-Message-State: AOAM531WEdP8EaRTw4MxmDozFtn86SYErOvcBYa5qUaRrGNvAkfA2R0E
        PEyYdBXJF3b8pFDSnSpYuKbNucpJFTI=
X-Google-Smtp-Source: ABdhPJzewV0DZJOIZe1RH2LrxRX0OqWBP5HitgAFY6+Nv7v7tK+JRPpLuPoDHIFjS956OACycSdjNg==
X-Received: by 2002:a17:902:f68a:: with SMTP id l10mr4547985plg.146.1644448806448;
        Wed, 09 Feb 2022 15:20:06 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:9eba])
        by smtp.gmail.com with ESMTPSA id s2sm14453697pgl.21.2022.02.09.15.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:20:06 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 1/5] bpf: Extend sys_bpf commands for bpf_syscall programs.
Date:   Wed,  9 Feb 2022 15:19:57 -0800
Message-Id: <20220209232001.27490-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
References: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

