Return-Path: <bpf+bounces-2272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77372A574
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6112D1C21155
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352023425;
	Fri,  9 Jun 2023 21:40:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB0408E0
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:40:52 +0000 (UTC)
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF94F3A81
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:40:48 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 56CF1101AFC
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:40:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D78F31014D7
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:40:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686346846; a=rsa-sha256;
	cv=none;
	b=3PM7G0prnEEZUVkD1MvL4IIAwSZeyTnDoOb4GEGZQKhTM1fi9jHcg2xXNc1K6O22g0BEC6
	r1beXM2HNIGTMsscyWcVJOsczxj7krPdsa7L3RUtp4SfbUvDCbEMb5QS6qi6UfflDwJwUo
	WylpijVgXlxi+9ri0f79kJJHkDf5L8PXrydFt+7q4Bw5d8Xk4Jiz8SKaxxjC/TbBNnZjUY
	qgoi07ZvuOYhDIcNVcSwOKsFbPC0/PxBPvHaoQf+w+QXHRqWMcA0aVqCI+LI52LvfZbv3g
	mwSw0PqBavZqGb6aP8pB9kGQEfZf/wQlzGrLzcd+4W5YngktiE8oFeqNc6If0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686346846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gltbK8ydRIbwpte3aEqpNTy+/R8ZSH6iUk0sVn8mJqE=;
	b=uNEddNp3uZxe8wNKRgM1fFr2lDBmU5etTr7pWEYICgttHi/8AnjUY2WY8gHGlCPN68da0k
	JD6g0Kfwwy8g12xIEr8UoQkSo8nSFs0mKyuDAzTRdV+MCJeZBSKvsg4iX3OmZHymGoxytd
	eGtgAiD2zRUoHA5wrLlg0qZUjKp2L+G8NOY17P56Mm0TtKiRHXJnFq7HfnbVBvhYkeqxro
	P7d28Q8PRpE1MUnvROtjXU/t6qFlym87SJwNA/dT+eFiN3Awv9uGcCfJMoZCvAwzfjgOss
	I2wHJhZxc+6oFVRuXBMhuutT8sCxbBhXmTDMFhqfT3EZZJcZ9D+OYVMbXiLkzw==
ARC-Authentication-Results: i=1;
	rspamd-6c69b8658d-f796t;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Supply-Fumbling: 4851b00a49172d9f_1686346847128_1270427964
X-MC-Loop-Signature: 1686346847128:1759324031
X-MC-Ingress-Time: 1686346847128
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.163.21 (trex/6.8.1);
	Fri, 09 Jun 2023 21:40:47 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4QdDz14gkLzmM
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686346845;
	bh=gltbK8ydRIbwpte3aEqpNTy+/R8ZSH6iUk0sVn8mJqE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=EJubkK/7eYxIDJedEoHDamhxA0JtMfWmWJSOR1caFsUlwxNxUIiG+K2L7hYwZuMi7
	 2DTDRlFhWgQCjJP82uMwAVinQosKVcfdqGHBlcnIzIxzy/wlfpqDODq3TAUFOVmxaT
	 sC17YdGwKfH85qB9QOTvFNylo3UPuR+3GayDI7tY=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00d9
	by kmjvbox (DragonFly Mail Agent v0.12);
	Fri, 09 Jun 2023 14:40:44 -0700
Date: Fri, 9 Jun 2023 14:40:44 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 2/2] selftests/bpf: add a test for subprogram extables
Message-ID: <6a8b4285d119652f78993af2955a213e7af58ba0.1686345886.git.kjlx@templeofstupid.com>
References: <cover.1686345886.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686345886.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In certain situations a program with subprograms may have a NULL
extable entry.  This should not happen, and when it does, it turns a
single trap into multiple.  Add a test case for further debugging and to
prevent regressions.

The test-case contains three essentially identical versions of the same
test because just one program may not be sufficient to trigger the oops.
This is due to the fact that the items are stored in a binary tree and
have identical values so it's possible to sometimes find the ksym with
the extable.  With 3 copies, this has been reliable on this author's
test systems.

When triggered out of this test case, the oops looks like this:

   BUG: kernel NULL pointer dereference, address: 000000000000000c
   #PF: supervisor read access in kernel mode
   #PF: error_code(0x0000) - not-present page
   PGD 0 P4D 0
   Oops: 0000 [#1] PREEMPT SMP NOPTI
   CPU: 0 PID: 1132 Comm: test_progs Tainted: G           OE      6.4.0-rc3+ #2
   RIP: 0010:cmp_ex_search+0xb/0x30
   Code: cc cc cc cc e8 36 cb 03 00 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 48 8b 07 <48> 63 0e 48 01 f1 31 d2 48 39 c8 19 d2 48 39 c8 b8 01 00 00 00 0f
   RSP: 0018:ffffb30c4291f998 EFLAGS: 00010006
   RAX: ffffffffc00b49da RBX: 0000000000000002 RCX: 000000000000000c
   RDX: 0000000000000002 RSI: 000000000000000c RDI: ffffb30c4291f9e8
   RBP: ffffb30c4291f998 R08: ffffffffab1a42d0 R09: 0000000000000001
   R10: 0000000000000000 R11: ffffffffab1a42d0 R12: ffffb30c4291f9e8
   R13: 000000000000000c R14: 000000000000000c R15: 0000000000000000
   FS:  00007fb5d9e044c0(0000) GS:ffff92e95ee00000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 000000000000000c CR3: 000000010c3a2005 CR4: 00000000007706f0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   PKRU: 55555554
   Call Trace:
    <TASK>
    bsearch+0x41/0x90
    ? __pfx_cmp_ex_search+0x10/0x10
    ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
    search_extable+0x3b/0x60
    ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
    search_bpf_extables+0x10d/0x190
    ? bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
    search_exception_tables+0x5d/0x70
    fixup_exception+0x3f/0x5b0
    ? look_up_lock_class+0x61/0x110
    ? __lock_acquire+0x6b8/0x3560
    ? __lock_acquire+0x6b8/0x3560
    ? __lock_acquire+0x6b8/0x3560
    kernelmode_fixup_or_oops+0x46/0x110
    __bad_area_nosemaphore+0x68/0x2b0
    ? __lock_acquire+0x6b8/0x3560
    bad_area_nosemaphore+0x16/0x20
    do_kern_addr_fault+0x81/0xa0
    exc_page_fault+0xd6/0x210
    asm_exc_page_fault+0x2b/0x30
   RIP: 0010:bpf_prog_45a7907e7114d0ff_handle_fexit_ret_subprogs3+0x2a/0x6c
   Code: f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 7f 08 49 bb 00 00 00 00 00 80 00 00 4c 39 df 73 04 31 f6 eb 04 <48> 8b 77 00 49 bb 00 00 00 00 00 80 00 00 48 81 c7 7c 00 00 00 4c
   RSP: 0018:ffffb30c4291fcb8 EFLAGS: 00010282
   RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
   RDX: 00000000cddf1af1 RSI: 000000005315a00d RDI: ffffffffffffffea
   RBP: ffffb30c4291fcb8 R08: ffff92e644bf38a8 R09: 0000000000000000
   R10: 0000000000000000 R11: 0000800000000000 R12: ffff92e663652690
   R13: 00000000000001c8 R14: 00000000000001c8 R15: 0000000000000003
    bpf_trampoline_251255721842_2+0x63/0x1000
    bpf_testmod_return_ptr+0x9/0xb0 [bpf_testmod]
    ? bpf_testmod_test_read+0x43/0x2d0 [bpf_testmod]
    sysfs_kf_bin_read+0x60/0x90
    kernfs_fop_read_iter+0x143/0x250
    vfs_read+0x240/0x2a0
    ksys_read+0x70/0xe0
    __x64_sys_read+0x1f/0x30
    do_syscall_64+0x68/0xa0
    ? syscall_exit_to_user_mode+0x77/0x1f0
    ? do_syscall_64+0x77/0xa0
    ? irqentry_exit+0x35/0xa0
    ? sysvec_apic_timer_interrupt+0x4d/0x90
    entry_SYSCALL_64_after_hwframe+0x72/0xdc
   RIP: 0033:0x7fb5da00a392
   Code: ac 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb be 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
   RSP: 002b:00007ffc5b3cab68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
   RAX: ffffffffffffffda RBX: 000055bee7b8b100 RCX: 00007fb5da00a392
   RDX: 00000000000001c8 RSI: 0000000000000000 RDI: 0000000000000009
   RBP: 00007ffc5b3caba0 R08: 0000000000000000 R09: 0000000000000037
   R10: 000055bee7b8c2a7 R11: 0000000000000246 R12: 000055bee78f1f60
   R13: 00007ffc5b3cae90 R14: 0000000000000000 R15: 0000000000000000
    </TASK>
   Modules linked in: bpf_testmod(OE) nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common intel_uncore_frequency_common ppdev nfit crct10dif_pclmul crc32_pclmul psmouse ghash_clmulni_intel sha512_ssse3 aesni_intel parport_pc crypto_simd cryptd input_leds parport rapl ena i2c_piix4 mac_hid serio_raw ramoops reed_solomon pstore_blk drm pstore_zone efi_pstore autofs4 [last unloaded: bpf_testmod(OE)]
   CR2: 000000000000000c

Though there may be some variation, depending on which suprogram
triggers the bug.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 .../bpf/prog_tests/subprogs_extable.c         | 29 +++++++++++
 .../bpf/progs/test_subprogs_extable.c         | 51 +++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
new file mode 100644
index 000000000000..3afd9f775f68
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "test_subprogs_extable.skel.h"
+
+void test_subprogs_extable(void)
+{
+	const int read_sz = 456;
+	struct test_subprogs_extable *skel;
+	int err;
+
+	skel = test_subprogs_extable__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = test_subprogs_extable__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	ASSERT_OK(trigger_module_test_read(read_sz), "trigger_read");
+
+	ASSERT_NEQ(skel->bss->triggered, 0, "verify at least one program ran");
+
+	test_subprogs_extable__detach(skel);
+
+cleanup:
+	test_subprogs_extable__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
new file mode 100644
index 000000000000..e2a21fbd4e44
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 8);
+	__type(key, __u32);
+	__type(value, __u64);
+} test_array SEC(".maps");
+
+unsigned int triggered;
+
+static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
+{
+	return 1;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	triggered++;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	triggered++;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	triggered++;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1


