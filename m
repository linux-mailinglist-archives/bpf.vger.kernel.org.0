Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4959A54DFA3
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiFPLC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 07:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiFPLC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 07:02:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C8764E
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 04:02:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b8so1643269edj.11
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHmItW+ZxwsMa6slplXFNuLqcY8BV5v91LocLylbQD4=;
        b=AZTIgM6InXYmFsMIHmRPf4ZMAVOranMWT/E7XjxyA4oDUgAmVc2x15qcVzeGFeDdQz
         07e2JHXyg0Kkf6cKsq3n17aYRjtwby+GHMxVlQUFaIEc7GEHQ6VmQGPZaaFqWf0t7cQk
         tJ1ad6zYPbsba7S09kXZb/vBd6s4CLXU+CGE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHmItW+ZxwsMa6slplXFNuLqcY8BV5v91LocLylbQD4=;
        b=C2a400IlwZg24O+dpUZghNQOhFxoS7kOe7BDxu6pqVJ7S/pg3gPzpMfcjyQhLMKKWm
         wrclQMlgt/Pi93UnVFo+jC0iSfBTGn0p9V3ydCZT/Cb8IxFQyi3pwywp8b5Sppx1nPCc
         KrNmpUjxZ37WUE7Rs7nfUhsSTEjELXUtyd3O+X0JVo/d01IyrFZhjeAxI2YcSs7peqbX
         dVin2b1I2vqp1jj2TMOrZ1/9sLOWdhFE8Po9Os1y+N8tOYsDP2w92kK29V/z2pSuso89
         iRLTHeHH9ZQpXkJd+zwjlzUQqo6UkV5gbmfCtU8JcVJ4eRJV71pkDEZcjJwm7y8CX+qv
         whEw==
X-Gm-Message-State: AJIora8xlY/meVe6pXl7D1YW/x+38hYTFV/kY2SCvi6TVJA52s40aV8u
        VoBAfbIacHaYgFSbF5T/7iw86OHz/PfYXQ==
X-Google-Smtp-Source: AGRyM1uDJ3gJ1a5ZwmwT/V5YUbz1BmXc/d52BMOip9jfBRdom3zr2FZS0NekZPdLZI1e0KAspahCfA==
X-Received: by 2002:a05:6402:28b6:b0:433:2b53:157a with SMTP id eg54-20020a05640228b600b004332b53157amr5779307edb.395.1655377374326;
        Thu, 16 Jun 2022 04:02:54 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b006fed8dfcf78sm616313ejx.225.2022.06.16.04.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 04:02:53 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [RFC bpf] selftests/bpf: Curious case of a successful tailcall that returns to caller
Date:   Thu, 16 Jun 2022 13:02:52 +0200
Message-Id: <20220616110252.418333-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While working aarch64 JIT to allow mixing bpf2bpf calls with tailcalls, I
noticed unexpected tailcall behavior in x86 JIT.

I don't know if it is by design or a bug. The bpf_tail_call helper
documentation says that the user should not expect the control flow to
return to the previous program, if the tail call was successful:

> If the call succeeds, the kernel immediately runs the first
> instruction of the new program. This is not a function call,
> and it never returns to the previous program.

However, when a tailcall happens from a subprogram, that is after a bpf2bpf
call, that is not the case. We return to the caller program because the
stack destruction is too shallow. BPF stack of just the top-most BPF
function gets destroyed.

This in turn allows the return value of the tailcall'ed program to get
overwritten, as the test below test demonstrates. It currently fails on
x86:

test_tailcall_bpf2bpf_7:PASS:open and load 0 nsec
test_tailcall_bpf2bpf_7:PASS:entry prog fd 0 nsec
test_tailcall_bpf2bpf_7:PASS:jmp_table map fd 0 nsec
test_tailcall_bpf2bpf_7:PASS:classifier_0 prog fd 0 nsec
test_tailcall_bpf2bpf_7:PASS:jmp_table map update 0 nsec
test_tailcall_bpf2bpf_7:PASS:entry prog test run 0 nsec
test_tailcall_bpf2bpf_7:FAIL:tailcall retval unexpected tailcall retval: actual 2 != expected 0
test_tailcall_bpf2bpf_7:PASS:bss map fd 0 nsec
test_tailcall_bpf2bpf_7:PASS:bss map lookup 0 nsec
test_tailcall_bpf2bpf_7:PASS:done flag is set 0 nsec

If we step through the program, we can observe the flow as so:

int entry(struct __sk_buff * skb):
bpf_prog_3bb007ac57240471_entry:
; subprog_tail(skb);
   0:   nopl   0x0(%rax,%rax,1)
   5:   xor    %eax,%eax
   7:   push   %rbp
   8:   mov    %rsp,%rbp
   b:   push   %rax
   c:   mov    -0x8(%rbp),%rax
  13:   call   0x0000000000000048 ---------.
; return 2;                                |
  18:   mov    $0x2,%eax <--------------------------------------.
  1d:   leave                              |                    |
  1e:   ret                                |                    |
                                           |                    |
int subprog_tail(struct __sk_buff * skb):  |                    |
bpf_prog_3a140cef239a4b4f_F:               |                    |
; int subprog_tail(struct __sk_buff *skb)  |                    |
   0:   nopl   0x0(%rax,%rax,1) <----------'                    |
   5:   xchg   %ax,%ax                                          |
   7:   push   %rbp                                             |
   8:   mov    %rsp,%rbp                                        |
   b:   push   %rax                                             |
   c:   push   %rbx                                             |
   d:   push   %r13                                             |
   f:   mov    %rdi,%rbx                                        |
; asm volatile("r1 = %[ctx]\n\t"                                |
  12:   movabs $0xffff888104119000,%r13                         |
  1c:   mov    %rbx,%rdi                                        |
  1f:   mov    %r13,%rsi                                        |
  22:   xor    %edx,%edx                                        |
  24:   mov    -0x4(%rbp),%eax                                  |
  2a:   cmp    $0x21,%eax                                       |
  2d:   jae    0x0000000000000046                               |
  2f:   add    $0x1,%eax                                        |
  32:   mov    %eax,-0x4(%rbp)                                  |
  38:   jmp    0x0000000000000046 ---------------------------.  |
  3d:   pop    %r13                                          |  |
  3f:   pop    %rbx                                          |  |
  40:   pop    %rax                                          |  |
  41:   nopl   0x0(%rax,%rax,1)                              |  |
; return 1;                                                  |  |
  46:   pop    %r13                                          |  |
  48:   pop    %rbx                                          |  |
  49:   leave                                                |  |
  4a:   ret                                                  |  |
                                                             |  |
int classifier_0(struct __sk_buff * skb):                    |  |
bpf_prog_6e664b22811ace0d_classifier_0:                      |  |
; done = 1;                                                  |  |
   0:   nopl   0x0(%rax,%rax,1)                              |  |
   5:   xchg   %ax,%ax                                       |  |
   7:   push   %rbp                                          |  |
   8:   mov    %rsp,%rbp                                     |  |
   b:   movabs $0xffffc900000b6000,%rdi <--------------------'  |
  15:   mov    $0x1,%esi                                        |
  1a:   mov    %esi,0x0(%rdi)                                   |
; return 0;                                                     |
  1d:   xor    %eax,%eax                                        |
  1f:   leave                                                   |
  20:   ret ----------------------------------------------------'

My question is - is it a bug or intended behavior that other JITs should
replicate?

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 55 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_bpf2bpf7.c   | 37 +++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf7.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index c4da87ec3ba4..696c307a1bee 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -831,6 +831,59 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	bpf_object__close(obj);
 }
 
+#include "tailcall_bpf2bpf7.skel.h"
+
+/* The tail call should never return to the previous program, if the
+ * jump was successful.
+ */
+static void test_tailcall_bpf2bpf_7(void)
+{
+	struct tailcall_bpf2bpf7 *obj;
+	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+
+	obj = tailcall_bpf2bpf7__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "open and load"))
+		return;
+
+	main_fd = bpf_program__fd(obj->progs.entry);
+	if (!ASSERT_GE(main_fd, 0, "entry prog fd"))
+		goto out;
+
+	map_fd = bpf_map__fd(obj->maps.jmp_table);
+	if (!ASSERT_GE(map_fd, 0, "jmp_table map fd"))
+		goto out;
+
+	prog_fd = bpf_program__fd(obj->progs.classifier_0);
+	if (!ASSERT_GE(prog_fd, 0, "classifier_0 prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "jmp_table map update"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "entry prog test run");
+	ASSERT_EQ(topts.retval, 0, "tailcall retval");
+
+	data_fd = bpf_map__fd(obj->maps.bss);
+	if (!ASSERT_GE(map_fd, 0, "bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "bss map lookup");
+	ASSERT_EQ(val, 1, "done flag is set");
+
+out:
+	tailcall_bpf2bpf7__destroy(obj);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -855,4 +908,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_4(false);
 	if (test__start_subtest("tailcall_bpf2bpf_5"))
 		test_tailcall_bpf2bpf_4(true);
+	if (test__start_subtest("tailcall_bpf2bpf_7"))
+		test_tailcall_bpf2bpf_7();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf7.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf7.c
new file mode 100644
index 000000000000..1be27cfa1702
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf7.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define __unused __attribute__((always_unused))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int done = 0;
+
+SEC("tc")
+int classifier_0(struct __sk_buff *skb __unused)
+{
+	done = 1;
+	return 0;
+}
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return 1;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	subprog_tail(skb);
+	return 2;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.35.3

