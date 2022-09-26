Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C25E97E3
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 04:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIZCYs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 22:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiIZCYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 22:24:41 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4FA1A7;
        Sun, 25 Sep 2022 19:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1664159074;
        bh=cPukUtOLiqyi5AwR+ie+7DqHn1YGnUzhf4l9dRKS2kE=;
        h=From:To:Cc:Subject:Date;
        b=yU1Fmtl9cy8zxZw0AQM9yCQexww+xzULjUUfn+pOMPZixDJvywhjhMxE//sxBgn/A
         +iukxXS9D9XHZDZyoKbsq1pMo48KJ4kPbBSePzgAoveHlhCXGoEG+OzG7lueCFw+tB
         hXSLHQpheLBMjUjm2rkYMxSeUzVqYMNjJ4udCLAs=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrsza30.qq.com (NewEsmtp) with SMTP
        id 5CEB689C; Mon, 26 Sep 2022 10:23:14 +0800
X-QQ-mid: xmsmtpt1664158994ta1rnlxni
Message-ID: <tencent_1C233A1BC00A0164C55FCAAB24BF768C320A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9LMOAlbYZPOsz9T9kLlmD8RWBpKDavG3lu2XpE9du0RZQxRbLzQ
         eqTv36OyRh5ryjjNe/9nMjXtlrSQP/bo7XvJMHIcDec7DqHHrvTxoyXZrOrglsmQlD8pV4sD0jMk
         ud9zmsD5xh6wDBp4D9Na/tgvwhhVnoJoeL4XHlOwpiDNaJpjtCfFhB/y4v45AwArutAMZzy/fN6s
         QRKhZvd25ci61PYBVgJtSD89JMtIsWofOQCxLngJiCd49R+sSIQtisaH401oOnIcHNqPsZHr3s1s
         6ZlquRqsRYlBSeipYo0LY8k2P8eg+Q+IzzyD/S14dyR6CeJfqsYJug1Hyz95wfh5Gfay9lWVYj5/
         /PXk5sdjGq9GFHmGvAzX5ejNzSU97iNfk15QGxvR0ySVBBUsRn2t/6PEcoE9kw00TD1x/Ue7IC37
         kcgysU4d+EbMqeyOEShLrKvVFlby4Blv3KUTzfWcaWsoOooYk/4WsWoZXU2aSXNTU/ztbp8BzHGh
         hX+hwOvykowHpRoqxYliPKmamK1vrDvt/IpswTo3ltmWoRdgmV/NndVSxWy7AtsqWnTFJ39WbI8X
         Td20Zek/6hvic/NrsUVuV1lbcsvnReXtLian4uyCdgYzDXFbQ7sVSIeeujmuXBYU3Miu98iQBhY5
         lz8YvAjY8SZn8YPlLVAWG6q04p2i3YbcsURoRgp5zHHteTTJooops5o7U4OX8+pyhbAz5pVBddfD
         Qiv8+LFJmb1tmCZv6HGqR2aiTsFU9Q+cOcidAfkWe+RNON1MbFl04uebq1Cy4TKgl5kJh0SbdjhQ
         d0fwFkTrBDPnJ9IsuiEP4/TLIljY+WXnh+k2BQD8aVnDuT3YZpki/qBV6OkAuAKA3zLtIWqYBGGp
         10J9Umpx8qXBUmTnzjWIqAJBQygtv91ck+jQ93e8J7isQYR47911NSEvfz0BjJgHuwBmdqaaz4Dx
         b/UUXHyybVZu8gfwOg3dFsf/TQAH42dxb+0nZGwJN1szn0ts09tY0sliazYPnAOXJAim9bW2xOSk
         FAJlxY2jAsej7EJt5q
From:   Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] samples/bpf: offwaketime: pretty print
Date:   Mon, 26 Sep 2022 10:22:42 +0800
X-OQ-MSGID: <20220926022242.20222-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

A sample of call stack:
swapper/10 [
	secondary_startup_64_no_verify
	cpu_startup_entry
	do_idle
	schedule_idle
	__schedule
	__traceiter_sched_switch
	__traceiter_sched_switch
	-
	try_to_wake_up
	call_timer_fn
	__run_timers.part.0
	run_timer_softirq
	__softirqentry_text_start
	__irq_exit_rcu
	sysvec_apic_timer_interrupt
	asm_sysvec_apic_timer_interrupt
	cpuidle_enter_state
	cpuidle_enter
	cpuidle_idle_call
	do_idle
	cpu_startup_entry
	secondary_startup_64_no_verify
] swapper/10 1

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/offwaketime_user.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/samples/bpf/offwaketime_user.c b/samples/bpf/offwaketime_user.c
index b6eedcb98fb9..d89278d62e4e 100644
--- a/samples/bpf/offwaketime_user.c
+++ b/samples/bpf/offwaketime_user.c
@@ -30,9 +30,9 @@ static void print_ksym(__u64 addr)
 	}
 
 	if (PRINT_RAW_ADDR)
-		printf("%s/%llx;", sym->name, addr);
+		printf("\t%s/%llx\n", sym->name, addr);
 	else
-		printf("%s;", sym->name);
+		printf("\t%s\n", sym->name);
 }
 
 #define TASK_COMM_LEN 16
@@ -50,21 +50,21 @@ static void print_stack(struct key_t *key, __u64 count)
 	static bool warned;
 	int i;
 
-	printf("%s;", key->target);
+	printf("%s [\n", key->target);
 	if (bpf_map_lookup_elem(map_fd[1], &key->tret, ip) != 0) {
-		printf("---;");
+		printf("\t---\n");
 	} else {
 		for (i = PERF_MAX_STACK_DEPTH - 1; i >= 0; i--)
 			print_ksym(ip[i]);
 	}
-	printf("-;");
+	printf("\t-\n");
 	if (bpf_map_lookup_elem(map_fd[1], &key->wret, ip) != 0) {
-		printf("---;");
+		printf("\t---\n");
 	} else {
 		for (i = 0; i < PERF_MAX_STACK_DEPTH; i++)
 			print_ksym(ip[i]);
 	}
-	printf(";%s %lld\n", key->waker, count);
+	printf("] %s %lld\n", key->waker, count);
 
 	if ((key->tret == -EEXIST || key->wret == -EEXIST) && !warned) {
 		printf("stackmap collisions seen. Consider increasing size\n");
-- 
2.31.1

