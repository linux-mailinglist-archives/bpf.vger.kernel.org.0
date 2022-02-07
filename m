Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413E04AC217
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 15:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbiBGO5B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 09:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385249AbiBGObz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 09:31:55 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CEC0401C2
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 06:31:54 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i186so13303175pfe.0
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 06:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYGLPmfv/rlKYmpOwsNn6cRCECl0Y0mw5t7TSoiX12A=;
        b=XG8F5XHfhs0v8gjpve6UQEIWtuv7aMcz3fhtf6Ot2m0RT5sfitdjIzJbGfWmjcJRsj
         fPxcgQI6Otls7Bc6OkteluqUzhcfX+/1PQpqURN9dbzrHBpqZGG3HmJKtmtk6RKUOsw1
         HADWEsETg1EX9Kmw1WkS0stp1EnBGMnL40bCyLaInAxC4Epql9V1ULY2sa050+1geA28
         rn8hHk1ssZyXOJQxlb7bi7LwK7dA82JfYgwXb/OIZz/ejX8lshPY4m0qxe8C4ME8pd+A
         7ibJ6dSc17r61mOZue8FGHLKnxdoUCDE8WnnO4oXi4dJRQpURVwi9PBXojtxxEltcqb9
         Qgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYGLPmfv/rlKYmpOwsNn6cRCECl0Y0mw5t7TSoiX12A=;
        b=nDAiBw1Hgt5FoCPxaJaOKpI6QVr6ymOyIKp950zy3hr8txNko6OWefQyU5IoAJa4hz
         rOP6o/fZv7a72i20TlzyPQwWZkYEHhyJ1exDs/t9NhZpudoOowYiklQzDGBlRiL5cs/z
         W0mFNvscea1JiUT/PwH6yAJxyOP14X79Rdzeg0ABlMnYDXPxClGQ+7fdMPh2Cae4w0U/
         aKWvMLTa1jLAPMXG0jgDwDXmmwS3z4SUk673zCizpQTjPxMjLxWw/Ju/9Y4FHKH6hz0Q
         Yv/wPtBnMuZIb+BxJIaULOdHwlAF8W9wssaEsbGCg9sXhA5clraeVdPj0+ay++TRK1DI
         4V+A==
X-Gm-Message-State: AOAM531uRcUzVWfOfF60JhiOpY6Vxdd0qXGtU/xwtS38IY4PyQbaUN5/
        /5u2jsec2jGws1xsJq++dVUPEyaEzk8=
X-Google-Smtp-Source: ABdhPJxuXuOIE/81UzBccqb29HEp0vCUJPjQVC1anEJl+8ivW/OwICWAIwYoCoKDq1NVbs1NC4Krmw==
X-Received: by 2002:a05:6a00:2490:: with SMTP id c16mr15813862pfv.67.1644244313728;
        Mon, 07 Feb 2022 06:31:53 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id s84sm8928747pgs.77.2022.02.07.06.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:31:53 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test BPF_KPROBE_SYSCALL macro
Date:   Mon,  7 Feb 2022 22:31:34 +0800
Message-Id: <20220207143134.2977852-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207143134.2977852-1-hengqi.chen@gmail.com>
References: <20220207143134.2977852-1-hengqi.chen@gmail.com>
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

Add tests for the newly added BPF_KPROBE_SYSCALL macro.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../bpf/prog_tests/test_bpf_syscall_macro.c   |  6 +++++
 .../selftests/bpf/progs/bpf_syscall_macro.c   | 23 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
index f5f4c8adf539..87d05c8a7a4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
@@ -58,6 +58,12 @@ void test_bpf_syscall_macro(void)
 	ASSERT_EQ(skel->bss->arg4_core, exp_arg4, "syscall_arg4_core_variant");
 	ASSERT_EQ(skel->bss->arg5_core, exp_arg5, "syscall_arg5_core_variant");

+	ASSERT_EQ(skel->bss->option_syscall, exp_arg1, "BPF_KPROBE_SYSCALL_option");
+	ASSERT_EQ(skel->bss->arg2_syscall, exp_arg2, "BPF_KPROBE_SYSCALL_arg2");
+	ASSERT_EQ(skel->bss->arg3_syscall, exp_arg3, "BPF_KPROBE_SYSCALL_arg3");
+	ASSERT_EQ(skel->bss->arg4_syscall, exp_arg4, "BPF_KPROBE_SYSCALL_arg4");
+	ASSERT_EQ(skel->bss->arg5_syscall, exp_arg5, "BPF_KPROBE_SYSCALL_arg5");
+
 cleanup:
 	bpf_syscall_macro__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index e7c622cb6a39..c1481fcbfacb 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -21,6 +21,12 @@ unsigned long arg4_core_cx = 0;
 unsigned long arg4_core = 0;
 unsigned long arg5_core = 0;

+int option_syscall = 0;
+unsigned long arg2_syscall = 0;
+unsigned long arg3_syscall = 0;
+unsigned long arg4_syscall = 0;
+unsigned long arg5_syscall = 0;
+
 const volatile pid_t filter_pid = 0;

 SEC("kprobe/" SYS_PREFIX "sys_prctl")
@@ -56,4 +62,21 @@ int BPF_KPROBE(handle_sys_prctl)
 	return 0;
 }

+SEC("kprobe/" SYS_PREFIX "sys_prctl")
+int BPF_KPROBE_SYSCALL(prctl_enter, int option, unsigned long arg2,
+		       unsigned long arg3, unsigned long arg4, unsigned long arg5)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != filter_pid)
+		return 0;
+
+	option_syscall = option;
+	arg2_syscall = arg2;
+	arg3_syscall = arg3;
+	arg4_syscall = arg4;
+	arg5_syscall = arg5;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
--
2.30.2
