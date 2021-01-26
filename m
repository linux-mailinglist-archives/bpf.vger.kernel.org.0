Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7D30354F
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 06:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbhAZFiz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:38:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15612 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727193AbhAZCtz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Jan 2021 21:49:55 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10Q05O6n031233
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 16:12:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Xt6hpuokcSoHInuJjC3bH76rsACcbFBKy8Zmx0JECQU=;
 b=KWxutWzIXszGs95bQecNUKGXlH7O1hxSO+bTJgvvZxafu40hZj1INTq00pH3xioySvkV
 VzJHqoL0hSBbIFM/3L5EAM9kN4pxoNVzHhO9xo820UJ8ykWfMZEotf8bgEVnpyTL33d2
 IxHnXy4D3rzu/ZN4XMedQK39Vm8tHdVPA4Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 368j6uuy57-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 16:12:30 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 25 Jan 2021 16:12:22 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E97523704F94; Mon, 25 Jan 2021 16:12:19 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <x86@kernel.org>, KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
Date:   Mon, 25 Jan 2021 16:12:19 -0800
Message-ID: <20210126001219.845816-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_10:2021-01-25,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101250122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When reviewing patch ([1]), which adds a script to run bpf selftest
through qemu at /sbin/init stage, I found the following kernel bug
warning:

[  112.118892] BUG: sleeping function called from invalid context at arch/x=
86/mm/fault.c:1351
[  112.119805] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 354, =
name: new_name
[  112.120512] 3 locks held by new_name/354:
[  112.120868]  #0: ffff88800476e0a0 (&p->lock){+.+.}-{3:3}, at: bpf_seq_re=
ad+0x3a/0x3d0
[  112.121573]  #1: ffffffff82d69800 (rcu_read_lock){....}-{1:2}, at: bpf_i=
ter_run_prog+0x5/0x160
[  112.122348]  #2: ffff8880061c2088 (&mm->mmap_lock#2){++++}-{3:3}, at: ex=
c_page_fault+0x1a1/0x640
[  112.123128] Preemption disabled at:
[  112.123130] [<ffffffff8108f913>] migrate_disable+0x33/0x80
[  112.123942] CPU: 0 PID: 354 Comm: new_name Tainted: G           O      5=
.11.0-rc4-00524-g6e66fbb
10597-dirty #1249
[  112.124822] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.9.3-1.el7.centos 04/01
/2014
[  112.125614] Call Trace:
[  112.125835]  dump_stack+0x77/0x97
[  112.126137]  ___might_sleep.cold.119+0xf2/0x106
[  112.126537]  exc_page_fault+0x1c1/0x640
[  112.126888]  asm_exc_page_fault+0x1e/0x30
[  112.127241] RIP: 0010:bpf_prog_0a182df2d34af188_dump_bpf_prog+0xf5/0xb3c
[  112.127825] Code: 00 00 8b 7d f4 41 8b 76 44 48 39 f7 73 06 48 01 fb 49 =
89 df 4c 89 7d d8 49 8b
bd 20 01 00 00 48 89 7d e0 49 8b bd e0 00 00 00 <48> 8b 7f 20 48 01 d7 48 8=
9 7d e8 48 89 e9 48 83 c
1 d0 48 8b 7d c8
[  112.129433] RSP: 0018:ffffc9000035fdc8 EFLAGS: 00010282
[  112.129895] RAX: 0000000000000000 RBX: ffff888005a49458 RCX: 00000000000=
00024
[  112.130509] RDX: 00000000000002f0 RSI: 0000000000000509 RDI: 00000000000=
00000
[  112.131126] RBP: ffffc9000035fe20 R08: 0000000000000001 R09: 00000000000=
00000
[  112.131737] R10: 0000000000000002 R11: 0000000000000000 R12: 00000000000=
00400
[  112.132355] R13: ffff888006085800 R14: ffff888004718540 R15: ffff888005a=
49458
[  112.132990]  ? bpf_prog_0a182df2d34af188_dump_bpf_prog+0xc8/0xb3c
[  112.133526]  bpf_iter_run_prog+0x75/0x160
[  112.133880]  __bpf_prog_seq_show+0x39/0x40
[  112.134258]  bpf_seq_read+0xf6/0x3d0
[  112.134582]  vfs_read+0xa3/0x1b0
[  112.134873]  ksys_read+0x4f/0xc0
[  112.135166]  do_syscall_64+0x2d/0x40
[  112.135482]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

To reproduce the issue, with patch [1] and use the following script:
  tools/testing/selftests/bpf/run_in_vm.sh -- cat /sys/fs/bpf/progs.debug

The reason of the above kernel warning is due to bpf program
tries to dereference an address of 0 and which is not caught
by bpf exception handling logic.

...
SEC("iter/bpf_prog")
int dump_bpf_prog(struct bpf_iter__bpf_prog *ctx)
{
	struct bpf_prog *prog =3D ctx->prog;
	struct bpf_prog_aux *aux;
	...
	if (!prog)
		return 0;
	aux =3D prog->aux;
	...
	... aux->dst_prog->aux->name ...
	return 0;
}

If the aux->dst_prog is NULL pointer, a fault will happen when trying
to access aux->dst_prog->aux.

In arch/x86/mm/fault.c function do_usr_addr_fault(), we have following code
         if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
                      !(hw_error_code & X86_PF_USER) &&
                      !(regs->flags & X86_EFLAGS_AC)))
         {
                 bad_area_nosemaphore(regs, hw_error_code, address);
                 return;
         }

When the test is run normally after login prompt, cpu_feature_enabled(X86_F=
EATURE_SMAP)
is true and bad_area_nosemaphore() is called and then fixup_exception() is =
called,
where bpf specific handler is able to fixup the exception.

But when the test is run at /sbin/init time, cpu_feature_enabled(X86_FEATUR=
E_SMAP) is
false, the control reaches
         if (unlikely(!mmap_read_trylock(mm))) {
                 if (!user_mode(regs) && !search_exception_tables(regs->ip)=
) {
                         /*
                          * Fault from code in kernel from
                          * which we do not expect faults.
                          */
                         bad_area_nosemaphore(regs, hw_error_code, address);
                         return;
                 }
retry:
                 mmap_read_lock(mm);
         } else {
                 /*
                  * The above down_read_trylock() might have succeeded in
                  * which case we'll have missed the might_sleep() from
                  * down_read():
                  */
                 might_sleep();
         }
and might_sleep() is triggered and the above kernel warning is print.

To fix the issue, before the above mmap_read_trylock(), we will check
whether fault ip can be served by bpf exception handler or not, if
yes, the exception will be fixed up and return.

[1] https://lore.kernel.org/bpf/20210123004445.299149-1-kpsingh@kernel.org/

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/include/asm/extable.h |  3 +++
 arch/x86/mm/extable.c          | 14 ++++++++++++++
 arch/x86/mm/fault.c            |  9 +++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index 1f0cbc52937c..1e99da15336c 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -38,6 +38,9 @@ enum handler_type {
=20
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
+extern int fixup_bpf_exception(struct pt_regs *regs, int trapnr,
+			       unsigned long error_code,
+			       unsigned long fault_addr);
 extern int fixup_bug(struct pt_regs *regs, int trapnr);
 extern enum handler_type ex_get_fault_handler_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b93d6cd08a7f..311da42c0aec 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -155,6 +155,20 @@ enum handler_type ex_get_fault_handler_type(unsigned l=
ong ip)
 		return EX_HANDLER_OTHER;
 }
=20
+int fixup_bpf_exception(struct pt_regs *regs, int trapnr,
+			unsigned long error_code, unsigned long fault_addr)
+{
+	const struct exception_table_entry *e;
+	ex_handler_t handler;
+
+	e =3D search_bpf_extables(regs->ip);
+	if (!e)
+		return 0;
+
+	handler =3D ex_fixup_handler(e);
+	return handler(e, regs, trapnr, error_code, fault_addr);
+}
+
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_=
code,
 		    unsigned long fault_addr)
 {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f1f1b5a0956a..e8182d30bf67 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1317,6 +1317,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 		if (emulate_vsyscall(hw_error_code, regs, address))
 			return;
 	}
+
+#ifdef CONFIG_BPF_JIT
+	/*
+	 * Faults incurred by bpf program might need emulation, i.e.,
+	 * clearing the dest register.
+	 */
+	if (fixup_bpf_exception(regs, X86_TRAP_PF, hw_error_code, address))
+		return;
+#endif
 #endif
=20
 	/*
--=20
2.24.1

