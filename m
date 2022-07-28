Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6B58482F
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 00:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiG1WXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 18:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiG1WXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 18:23:51 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457E5796AB
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 15:23:50 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9F87E240028
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 00:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1659047027; bh=brhmUTxz8h78gto1c37CahBwD7JoeUEaB7krq6o4+1w=;
        h=From:To:Subject:Date:From;
        b=DECqQzX2Y3Po+WACfpBt4ow2s1ZlHQgVxFkULStWeYGnqyrL0ZJvaLBs3pYVuXAvy
         MOQ8NMF8LoFAku9FvMdD48pNSYvdkXHa0iqGBGgOD3mfhXsb7IbsoSi+U+fwhufIJ/
         2jNVNIJSgXh1whbsnhlqM5d5HAER9FMcWzUo7bOKBOoaWx8zgnXrdXMQ/EPG9IAnHm
         gHtnm3WgWSXHj74EFsONw5PcF0lJK8EFMHkit8tmI9LKzu6yuQ/YJzMk6X7f1+d+fW
         wukIA9QxJbYdqF7keYoKF3Bc+HNHLoM1T8QBE3MgTZAtAZN+ZmHWnGo1Y1h5RmBYmf
         TcaEaa5gZGpWQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lv4tV6tnBz6tmN;
        Fri, 29 Jul 2022 00:23:46 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next] libbpf: Support PPC in arch_specific_syscall_pfx
Date:   Thu, 28 Jul 2022 22:23:45 +0000
Message-Id: <20220728222345.3125975-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 708ac5bea0ce ("libbpf: add ksyscall/kretsyscall sections support
for syscall kprobes") added the arch_specific_syscall_pfx() function,
which returns a string representing the architecture in use. As it turns
out this function is currently not aware of Power PC, where NULL is
returned. That's being flagged by the libbpf CI system, which builds for
ppc64le and the compiler sees a NULL pointer being passed in to a %s
format string.
With this change we add representations for two more architectures, for
Power PC and Power PC 64, and also adjust the string format logic to
handle NULL pointers gracefully, in an attempt to prevent similar issues
with other architectures in the future.

Fixes: 708ac5bea0ce ("libbpf: add ksyscall/kretsyscall sections support for syscall kprobes")
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b01fe01..50d4181 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9995,6 +9995,10 @@ static const char *arch_specific_syscall_pfx(void)
 	return "mips";
 #elif defined(__riscv)
 	return "riscv";
+#elif defined(__powerpc__)
+	return "powerpc";
+#elif defined(__powerpc64__)
+	return "powerpc64";
 #else
 	return NULL;
 #endif
@@ -10127,8 +10131,13 @@ struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (kernel_supports(prog->obj, FEAT_SYSCALL_WRAPPER)) {
+		/* arch_specific_syscall_pfx() should never return NULL here
+		 * because it is guarded by kernel_supports(). However, since
+		 * compiler does not know that we have an explicit conditional
+		 * as well.
+		 */
 		snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
-			 arch_specific_syscall_pfx(), syscall_name);
+			 arch_specific_syscall_pfx() ? : "", syscall_name);
 	} else {
 		snprintf(func_name, sizeof(func_name), "__se_sys_%s", syscall_name);
 	}
-- 
2.30.2

