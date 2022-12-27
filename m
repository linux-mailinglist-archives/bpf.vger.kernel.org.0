Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480E656EAB
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 21:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiL0Uda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 15:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiL0UdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 15:33:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77606D13B;
        Tue, 27 Dec 2022 12:33:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D288FB81023;
        Tue, 27 Dec 2022 20:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3B8C433D2;
        Tue, 27 Dec 2022 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672173181;
        bh=ie148qpRt6z9C2iaLSshGaAAoSR2OLbFzSIO1HD1v1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyuRH7dxzbrho+Pg0PB8axJETApg4oEjJqY4B1kIHtmT2QlqXbrprubSR/3AeKBuP
         uLjhmj5xoKpPTh9cYnL1R4Yvmw15G3Krjl6R1mSePmW1QqsPJ1rkRY7tSA5KCa2nb/
         00Et+EgzkrM38cYScquXr7vP8BU4pC5keoCw4PINL0ANZuoNEcAFkbY4d/1rSaqc3n
         +o949xA1ExYsn6KH5nh3R4SwOPck4Bb8hwjeO4UavpLBhmA2ya8+Nx0DpHnFN1Pgm9
         EIDUV3IBID7hbEj/dVRNF9BdxEPr9AlDF2YLAeWjOVrJ/IdFqeH5NFf7xAOm/FcfN7
         SmMbEIT/aZl9w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edward Lo <edward.lo@ambergroup.io>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/28] fs/ntfs3: Validate resident attribute name
Date:   Tue, 27 Dec 2022 15:32:30 -0500
Message-Id: <20221227203249.1213526-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221227203249.1213526-1-sashal@kernel.org>
References: <20221227203249.1213526-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Edward Lo <edward.lo@ambergroup.io>

[ Upstream commit 54e45702b648b7c0000e90b3e9b890e367e16ea8 ]

Though we already have some sanity checks while enumerating attributes,
resident attribute names aren't included. This patch checks the resident
attribute names are in the valid ranges.

[  259.209031] BUG: KASAN: slab-out-of-bounds in ni_create_attr_list+0x1e1/0x850
[  259.210770] Write of size 426 at addr ffff88800632f2b2 by task exp/255
[  259.211551]
[  259.212035] CPU: 0 PID: 255 Comm: exp Not tainted 6.0.0-rc6 #37
[  259.212955] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  259.214387] Call Trace:
[  259.214640]  <TASK>
[  259.214895]  dump_stack_lvl+0x49/0x63
[  259.215284]  print_report.cold+0xf5/0x689
[  259.215565]  ? kasan_poison+0x3c/0x50
[  259.215778]  ? kasan_unpoison+0x28/0x60
[  259.215991]  ? ni_create_attr_list+0x1e1/0x850
[  259.216270]  kasan_report+0xa7/0x130
[  259.216481]  ? ni_create_attr_list+0x1e1/0x850
[  259.216719]  kasan_check_range+0x15a/0x1d0
[  259.216939]  memcpy+0x3c/0x70
[  259.217136]  ni_create_attr_list+0x1e1/0x850
[  259.217945]  ? __rcu_read_unlock+0x5b/0x280
[  259.218384]  ? ni_remove_attr+0x2e0/0x2e0
[  259.218712]  ? kernel_text_address+0xcf/0xe0
[  259.219064]  ? __kernel_text_address+0x12/0x40
[  259.219434]  ? arch_stack_walk+0x9e/0xf0
[  259.219668]  ? __this_cpu_preempt_check+0x13/0x20
[  259.219904]  ? sysvec_apic_timer_interrupt+0x57/0xc0
[  259.220140]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  259.220561]  ni_ins_attr_ext+0x52c/0x5c0
[  259.220984]  ? ni_create_attr_list+0x850/0x850
[  259.221532]  ? run_deallocate+0x120/0x120
[  259.221972]  ? vfs_setxattr+0x128/0x300
[  259.222688]  ? setxattr+0x126/0x140
[  259.222921]  ? path_setxattr+0x164/0x180
[  259.223431]  ? __x64_sys_setxattr+0x6d/0x80
[  259.223828]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  259.224417]  ? mi_find_attr+0x3c/0xf0
[  259.224772]  ni_insert_attr+0x1ba/0x420
[  259.225216]  ? ni_ins_attr_ext+0x5c0/0x5c0
[  259.225504]  ? ntfs_read_ea+0x119/0x450
[  259.225775]  ni_insert_resident+0xc0/0x1c0
[  259.226316]  ? ni_insert_nonresident+0x400/0x400
[  259.227001]  ? __kasan_kmalloc+0x88/0xb0
[  259.227468]  ? __kmalloc+0x192/0x320
[  259.227773]  ntfs_set_ea+0x6bf/0xb30
[  259.228216]  ? ftrace_graph_ret_addr+0x2a/0xb0
[  259.228494]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  259.228838]  ? ntfs_read_ea+0x450/0x450
[  259.229098]  ? is_bpf_text_address+0x24/0x40
[  259.229418]  ? kernel_text_address+0xcf/0xe0
[  259.229681]  ? __kernel_text_address+0x12/0x40
[  259.229948]  ? unwind_get_return_address+0x3a/0x60
[  259.230271]  ? write_profile+0x270/0x270
[  259.230537]  ? arch_stack_walk+0x9e/0xf0
[  259.230836]  ntfs_setxattr+0x114/0x5c0
[  259.231099]  ? ntfs_set_acl_ex+0x2e0/0x2e0
[  259.231529]  ? evm_protected_xattr_common+0x6d/0x100
[  259.231817]  ? posix_xattr_acl+0x13/0x80
[  259.232073]  ? evm_protect_xattr+0x1f7/0x440
[  259.232351]  __vfs_setxattr+0xda/0x120
[  259.232635]  ? xattr_resolve_name+0x180/0x180
[  259.232912]  __vfs_setxattr_noperm+0x93/0x300
[  259.233219]  __vfs_setxattr_locked+0x141/0x160
[  259.233492]  ? kasan_poison+0x3c/0x50
[  259.233744]  vfs_setxattr+0x128/0x300
[  259.234002]  ? __vfs_setxattr_locked+0x160/0x160
[  259.234837]  do_setxattr+0xb8/0x170
[  259.235567]  ? vmemdup_user+0x53/0x90
[  259.236212]  setxattr+0x126/0x140
[  259.236491]  ? do_setxattr+0x170/0x170
[  259.236791]  ? debug_smp_processor_id+0x17/0x20
[  259.237232]  ? kasan_quarantine_put+0x57/0x180
[  259.237605]  ? putname+0x80/0xa0
[  259.237870]  ? __kasan_slab_free+0x11c/0x1b0
[  259.238234]  ? putname+0x80/0xa0
[  259.238500]  ? preempt_count_sub+0x18/0xc0
[  259.238775]  ? __mnt_want_write+0xaa/0x100
[  259.238990]  ? mnt_want_write+0x8b/0x150
[  259.239290]  path_setxattr+0x164/0x180
[  259.239605]  ? setxattr+0x140/0x140
[  259.239849]  ? debug_smp_processor_id+0x17/0x20
[  259.240174]  ? fpregs_assert_state_consistent+0x67/0x80
[  259.240411]  __x64_sys_setxattr+0x6d/0x80
[  259.240715]  do_syscall_64+0x3b/0x90
[  259.240934]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  259.241697] RIP: 0033:0x7fc6b26e4469
[  259.242647] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 088
[  259.244512] RSP: 002b:00007ffc3c7841f8 EFLAGS: 00000217 ORIG_RAX: 00000000000000bc
[  259.245086] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc6b26e4469
[  259.246025] RDX: 00007ffc3c784380 RSI: 00007ffc3c7842e0 RDI: 00007ffc3c784238
[  259.246961] RBP: 00007ffc3c788410 R08: 0000000000000001 R09: 00007ffc3c7884f8
[  259.247775] R10: 000000000000007f R11: 0000000000000217 R12: 00000000004004e0
[  259.248534] R13: 00007ffc3c7884f0 R14: 0000000000000000 R15: 0000000000000000
[  259.249368]  </TASK>
[  259.249644]
[  259.249888] Allocated by task 255:
[  259.250283]  kasan_save_stack+0x26/0x50
[  259.250957]  __kasan_kmalloc+0x88/0xb0
[  259.251826]  __kmalloc+0x192/0x320
[  259.252745]  ni_create_attr_list+0x11e/0x850
[  259.253298]  ni_ins_attr_ext+0x52c/0x5c0
[  259.253685]  ni_insert_attr+0x1ba/0x420
[  259.253974]  ni_insert_resident+0xc0/0x1c0
[  259.254311]  ntfs_set_ea+0x6bf/0xb30
[  259.254629]  ntfs_setxattr+0x114/0x5c0
[  259.254859]  __vfs_setxattr+0xda/0x120
[  259.255155]  __vfs_setxattr_noperm+0x93/0x300
[  259.255445]  __vfs_setxattr_locked+0x141/0x160
[  259.255862]  vfs_setxattr+0x128/0x300
[  259.256251]  do_setxattr+0xb8/0x170
[  259.256522]  setxattr+0x126/0x140
[  259.256911]  path_setxattr+0x164/0x180
[  259.257308]  __x64_sys_setxattr+0x6d/0x80
[  259.257637]  do_syscall_64+0x3b/0x90
[  259.257970]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  259.258550]
[  259.258772] The buggy address belongs to the object at ffff88800632f000
[  259.258772]  which belongs to the cache kmalloc-1k of size 1024
[  259.260190] The buggy address is located 690 bytes inside of
[  259.260190]  1024-byte region [ffff88800632f000, ffff88800632f400)
[  259.261412]
[  259.261743] The buggy address belongs to the physical page:
[  259.262354] page:0000000081e8cac9 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x632c
[  259.263722] head:0000000081e8cac9 order:2 compound_mapcount:0 compound_pincount:0
[  259.264284] flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
[  259.265312] raw: 000fffffc0010200 ffffea0000060d00 dead000000000004 ffff888001041dc0
[  259.265772] raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
[  259.266305] page dumped because: kasan: bad access detected
[  259.266588]
[  259.266728] Memory state around the buggy address:
[  259.267225]  ffff88800632f300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.267841]  ffff88800632f380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.269111] >ffff88800632f400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  259.269626]                    ^
[  259.270162]  ffff88800632f480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  259.270810]  ffff88800632f500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Signed-off-by: Edward Lo <edward.lo@ambergroup.io>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 9f81944441ae..af1e4b364ea8 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -265,6 +265,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (t16 + t32 > asize)
 			return NULL;
 
+		if (attr->name_len &&
+		    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len > t16) {
+			return NULL;
+		}
+
 		return attr;
 	}
 
-- 
2.35.1

