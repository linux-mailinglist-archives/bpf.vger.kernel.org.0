Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC46DED59
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDLIQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDLIQg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 04:16:36 -0400
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CAEC2;
        Wed, 12 Apr 2023 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681287393;
        bh=Zg7cJ0N5bxqHMBmSaRWwD4RCA39YjoHwbrackzoeNlo=;
        h=From:To:Cc:Subject:Date;
        b=E9KpF5Hd+E4ILwlf8rMs8qRgxJ4Q0TAPYbfmqgNrPP4sSXzBP3h5sR831MxdbXxof
         Y3uSOWXiupRYzSM0O7C5P++odIm4nohyPL9eQoHXBabLVePbRvUTZDgfsher7apQDu
         NJoi6T+HRwlQyug+IzG+FMwsYT2L3tNGy9poPuyU=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 41A946FA; Wed, 12 Apr 2023 16:16:26 +0800
X-QQ-mid: xmsmtpt1681287386th3gm2jcb
Message-ID: <tencent_A0E82E0BEE925285F8156D540731DF805F05@qq.com>
X-QQ-XMAILINFO: NojR6Ao/DkEDmiSI3Qg84sUcSSkbAMO67ajz8zB4ch+AK+3RcEtgF76MQBQgEk
         3DG1rk5jrAzIXcgEDwhOtrTjOH1PI36PlZeJw4+y5OrSLSx5XkVI2ypW95TAz/+wH7pPJ/W0btk1
         KfvUpDGiz689PR+ync9qYRyhaqzwmjIAzaxpUDi8nK1VBOrqY2oaKH36bVCEONuWn6NdZiVMiVgi
         Mcgft6+zrRR86jkgJNq/8IjYNB97HcVJ1gxXmpQorxgOYFA5rcLBC8OFeY1gSwkL3N2jneM+cAH5
         Bn5n5RY7Y2T+NVCWnYogt9bfQqE6F7k8H4WrMVTIwQriJuvOHc02lUhb+xBdYr865oNTwllH+QjP
         AkoZ7PNkyu2EYhQY/8tRP4lBZ3pBGf0MtTCI0wWVvX4zGX/eCN4hypP36BXJdj43YyF7FOOH0X9S
         uKnXwsaXNmtH7Sx6DxJus5dT/iHeUcye6iMJ2gQJjiAPxJZlrQMjjZbvj0/9aog/8W3SBt3moMqz
         aoHKXMvUNoxqR4m1x7gxn7k8Xz6s2dtscAZ0l17D6YV46Zwgh/lj+Nrz2fNOu82KPHUwS3O+HPft
         3AE87url8UB3pEwA5WcUqduEUEeudtQL6x4xANsoMdiPFzTL2a1AKh9A7EQe+/FHQj8woFhCz1N+
         nwC00xPuhryM3QxHdLAsU+rQ4GK7wUWXrTeh5oNHy+Yr7NNqearyljVsjbq3bFpeL1SksD3ZexIw
         P7QtqHqRKYUXm8x4vbGN1x6F6D4X87YPaNEe67tcFKJaHnn+WJH1PKdZ0jJG26UuTOH9a2rfWZxZ
         /vR0NAO348vhOUiUmDXQ82c8J+W7ncOOrFo6owVUBhInktQ9avQOFsi7A/77QYkP/Z1IcNGRmKcK
         yQTwNWkvkJe+mH5nmN1V7uRzGtNYQo8snthivgBCWfTzVXBnnZOtbclTFbHHBo7qmgBe+kuQwEpQ
         KkTqn4zJ5z27GyS5rcAlTqKvIgKvzXKbXEWCecqTk1fSqn+Z/oYg==
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org, rongtao@cestc.cn
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] samples/bpf: sampleip: Replace PAGE_OFFSET with _text address
Date:   Wed, 12 Apr 2023 16:16:24 +0800
X-OQ-MSGID: <20230412081625.55541-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Macro PAGE_OFFSET(0xffff880000000000) in sampleip_user.c is inaccurate,
for example, in aarch64 architecture, this value depends on the
CONFIG_ARM64_VA_BITS compilation configuration, this value defaults to 48,
the corresponding PAGE_OFFSET is 0xffff800000000000, if we use the value
defined in sampleip_user.c, then all KSYMs obtained by sampleip are (user)

Symbol error due to PAGE_OFFSET error:

    $ sudo ./sampleip 1
    Sampling at 99 Hertz for 1 seconds. Ctrl-C also ends.
    ADDR                KSYM                             COUNT
    0xffff80000810ceb8  (user)                           1
    0xffffb28ec880      (user)                           1
    0xffff8000080c82b8  (user)                           1
    0xffffb23fed24      (user)                           1
    0xffffb28944fc      (user)                           1
    0xffff8000084628bc  (user)                           1
    0xffffb2a935c0      (user)                           1
    0xffff80000844677c  (user)                           1
    0xffff80000857a3a4  (user)                           1
    ...

A few examples of addresses in the CONFIG_ARM64_VA_BITS=48 environment in
the aarch64 environment:

    $ sudo head /proc/kallsyms
    ffff8000080a0000 T _text
    ffff8000080b0000 t gic_handle_irq
    ffff8000080b0000 T _stext
    ffff8000080b0000 T __irqentry_text_start
    ffff8000080b00b0 t gic_handle_irq
    ffff8000080b0230 t gic_handle_irq
    ffff8000080b03b4 T __irqentry_text_end
    ffff8000080b03b8 T __softirqentry_text_start
    ffff8000080b03c0 T __do_softirq
    ffff8000080b0718 T __entry_text_start

We just need to replace the PAGE_OFFSET with the address _text in
/proc/kallsyms to solve this problem:

    $ sudo ./sampleip 1
    Sampling at 99 Hertz for 1 seconds. Ctrl-C also ends.
    ADDR                KSYM                             COUNT
    0xffffb2892ab0      (user)                           1
    0xffffb2b1edfc      (user)                           1
    0xffff800008462834  __arm64_sys_ppoll                1
    0xffff8000084b87f4  eventfd_read                     1
    0xffffb28e6788      (user)                           1
    0xffff8000081e96d8  rcu_all_qs                       1
    0xffffb2ada878      (user)                           1
    ...

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/sampleip_user.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
index 921c505bb567..9283f47844fb 100644
--- a/samples/bpf/sampleip_user.c
+++ b/samples/bpf/sampleip_user.c
@@ -21,10 +21,10 @@
 #define DEFAULT_FREQ	99
 #define DEFAULT_SECS	5
 #define MAX_IPS		8192
-#define PAGE_OFFSET	0xffff880000000000
 
 static int map_fd;
 static int nr_cpus;
+static long _text_addr;
 
 static void usage(void)
 {
@@ -108,7 +108,7 @@ static void print_ip_map(int fd)
 	/* sort and print */
 	qsort(counts, max, sizeof(struct ipcount), count_cmp);
 	for (i = 0; i < max; i++) {
-		if (counts[i].ip > PAGE_OFFSET) {
+		if (counts[i].ip > _text_addr) {
 			sym = ksym_search(counts[i].ip);
 			if (!sym) {
 				printf("ksym not found. Is kallsyms loaded?\n");
@@ -169,6 +169,13 @@ int main(int argc, char **argv)
 		return 2;
 	}
 
+	/* used to determine whether the address is kernel space */
+	_text_addr = ksym_get_addr("_text");
+	if (!_text_addr) {
+		fprintf(stderr, "ERROR: no '_text' in /proc/kallsyms\n");
+		return 3;
+	}
+
 	/* create perf FDs for each CPU */
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	links = calloc(nr_cpus, sizeof(struct bpf_link *));
-- 
2.31.1

