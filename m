Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791194AE980
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiBIFqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiBIFnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:43:19 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185FC0043F8
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:43:20 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id r19so2426455pfh.6
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXEpBl9Bjx/UIuskvPdDre+BWHevTDTuWJ/EW9M/Hi4=;
        b=bQJj+w1lYiBRRzB1sFapQSASZqt/IuXMS9ieGZvg6+nNXpXb0jpLcHnHYgEDFeXOOg
         QkGI1BUJNrp4PFO4rJGc2z1bbiEXAs3sti3ZnRCmWkikIu7jYUOCq1FhGXT9fU56/Znw
         zMqu2vZcrQ2NBoINjiB5iuw3jAXCO/fG4SFSbIAS64cZTNyNKn5sTrH0zEHK7ffwrtlU
         4uLzWv1BgDUXX8Ev53pEpUhOigB4qUd0w3XC7mwpVG1ZptpW1QSxpHt9H0wUzcXEH65g
         qwexP1Fs49oqQU5AnEqHDZlYEUq2SL3/aTROXitIgNwFJM5ULRMi7df2OCoe1M7olTl1
         mXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXEpBl9Bjx/UIuskvPdDre+BWHevTDTuWJ/EW9M/Hi4=;
        b=mVRr/Ympsmd7bszieGK8MEaVKFDkN/RChsWGLI0pBn3efOXkQ4f5nWi8y2xucF2cHK
         HXT3NzChwGJOO96vvozvR+oySLjJcxyLJqgykzIiVSNmP38PcihyCyFuwEqEqZn15bnX
         aMFh+cshcvqGGB9h9hiB7NROTgyBsGIrz4zRCIpZcStko7MmW2VFfAnHJg4Nbcko1XBd
         leNCMBMuAzwWdsdvrNtP5s8CawH6X5KYjjT856dkPupZdjcbHtBUDsUlMaJZQvF/L7gc
         I/wKnKyIuzI6Zp1NpUUdsgJC9IvxNvQNe5wKd3uc3S2duDxouadpFmj1mc5ATLosdlal
         WKQg==
X-Gm-Message-State: AOAM530hDFzz5TExMzkGGz9q0hsfjThAadCWgmkxaIe9gzC4HgnA5coX
        cId6MgNOqGQI4gGboSY+m5M=
X-Google-Smtp-Source: ABdhPJxwPAIfpw9zDBm3BOTkRvnf1oK0HbIDMQwLwokBL3S6eI76K+FaN5X76atdgx5YEFoq4no8LA==
X-Received: by 2002:a65:5c84:: with SMTP id a4mr644773pgt.258.1644385400310;
        Tue, 08 Feb 2022 21:43:20 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:cbf])
        by smtp.gmail.com with ESMTPSA id nn5sm4543607pjb.2.2022.02.08.21.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:43:19 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 1/5] bpf: Extend sys_bpf commands for bpf_syscall programs.
Date:   Tue,  8 Feb 2022 21:43:11 -0800
Message-Id: <20220209054315.73833-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
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

