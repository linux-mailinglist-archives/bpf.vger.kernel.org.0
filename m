Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830496A1A70
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 11:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBXKio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 05:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjBXKiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 05:38:02 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A0DA2A157;
        Fri, 24 Feb 2023 02:36:59 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxQMxKk_hjCKcEAA--.3585S3;
        Fri, 24 Feb 2023 18:36:58 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxQuVHk_hjToM6AA--.5828S5;
        Fri, 24 Feb 2023 18:36:58 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Use __NR_prlimit64 instead of __NR_getrlimit in user_ringbuf test
Date:   Fri, 24 Feb 2023 18:36:55 +0800
Message-Id: <1677235015-21717-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
References: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxQuVHk_hjToM6AA--.5828S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZF4DGry8Jw1kCF18tF1kZrb_yoW5JFWDpa
        y8G343tF1SyF43Jw18CrWxZFyfJrsrZF4FkF4ktr95Zr1UXas7Xr1xKF4YgrnIgrZaqrsY
        va4IgF9ruw48AwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84xRDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After commit 80d7da1cac62 ("asm-generic: Drop getrlimit and setrlimit
syscalls from default list"), new architectures won't need to include
getrlimit and setrlimit, they are superseded with prlimit64.

In order to maintain compatibility for the new architectures, such as
LoongArch which does not define __NR_getrlimit, it is better to use
__NR_prlimit64 instead of __NR_getrlimit in user_ringbuf test to fix
the following build error:

    TEST-OBJ [test_progs] user_ringbuf.test.o
  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c: In function 'kick_kernel_cb':
  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:593:17: error: '__NR_getrlimit' undeclared (first use in this function)
    593 |         syscall(__NR_getrlimit);
        |                 ^~~~~~~~~~~~~~
  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:593:17: note: each undeclared identifier is reported only once for each function it appears in
  make: *** [Makefile:573: tools/testing/selftests/bpf/user_ringbuf.test.o] Error 1
  make: Leaving directory 'tools/testing/selftests/bpf'

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c    | 2 +-
 tools/testing/selftests/bpf/progs/user_ringbuf_success.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index 3a13e10..e51721d 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -590,7 +590,7 @@ static void *kick_kernel_cb(void *arg)
 	/* Kick the kernel, causing it to drain the ring buffer and then wake
 	 * up the test thread waiting on epoll.
 	 */
-	syscall(__NR_getrlimit);
+	syscall(__NR_prlimit64);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_success.c b/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
index b39093d..0ade111 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
@@ -202,7 +202,7 @@ do_nothing_cb(struct bpf_dynptr *dynptr, void *context)
 	return 0;
 }
 
-SEC("fentry/" SYS_PREFIX "sys_getrlimit")
+SEC("fentry/" SYS_PREFIX "sys_prlimit64")
 int test_user_ringbuf_epoll(void *ctx)
 {
 	long num_samples;
-- 
2.1.0

