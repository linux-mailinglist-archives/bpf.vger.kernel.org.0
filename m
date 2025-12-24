Return-Path: <bpf+bounces-77392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499ACDB036
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C2643020354
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 00:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEBA23507B;
	Wed, 24 Dec 2025 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UGGiabCB"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98721D3DC
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537921; cv=none; b=aQ97AEXmgT3aL5hvGbML8ZVrfS9iwyWlkZ6JN/W6nGpupj+dK17KDU+4yEaXJcjFUQ/VhnMHz5VG3TWnRivpsnisTp2233+DOdKi7A98jTfKCv+MHrR/Ov21wnGdYDxuQL0h4ondfpOShf8ZkjkAt6wNifiyZU+VCYxZ2806Ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537921; c=relaxed/simple;
	bh=m1xppCf6Sfjg2XT4d7KPEMA5nR8Nbi0GlUaoLXnssIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmFawoNdhUNPH4mx8gUOgeRIIpleafHIot5rjxsMtM9+yss0FY9xNu7sbJy9szcu2/324BBZ0o2LtjWv6ccKsqrWxi2cCDs7nfavDCYSFJt7nKjWRDf41fyqalUMND0Jrti1eqs/qQu7PZcYfThI27zJjzve8OtzbsRVc4r4nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UGGiabCB; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766537908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VkIGme4fltU4a5vFCl+hn5EcbJPsBzmDE23i5d/2G74=;
	b=UGGiabCBL0BZgjY80GTOZz3okOnr/o4friaEfuSri5WBjyIU7sZ+DQjWZxrygDU21mLh4C
	dETivcrH9qhcwyNmOstqaj5JmeiD/RYevPYYw9kFdRbN371knQZK5wb1ArJ4Lv3AHPRP0s
	DN+vkYwe0gt/Z06QbPcZaEw2CUCTfrg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [RFC PATCH v1] module: Fix kernel panic when a symbol st_shndx is out of bounds
Date: Tue, 23 Dec 2025 16:57:52 -0800
Message-ID: <20251224005752.201911-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I've been chasing down the following flaky splat, introduced by recent
changes in BTF generation [1]:

  ------------[ cut here ]------------
  BUG: unable to handle page fault for address: ffa000000233d828
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 100000067 P4D 100253067 PUD 100258067 PMD 0
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 1 UID: 0 PID: 390 Comm: test_progs Tainted: G        W  OE       6.19.0-rc1-gf785a31395d9 #331 PREEMPT(full)
  Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.el9 04/01/2014
  RIP: 0010:simplify_symbols+0x2b2/0x480
     9.737179] Code: 85 f6 4d 89 f7 b8 01 00 00 00 4c 0f 44 f8 49 83 fd f0 4d 0f 44 fe 75 5b 4d 85 ff 0f 85 76 ff ff ff eb 50 49 8b 4e 20 c1 e0 06 <48> 8b 44 01 10 9 cf fd ff ff 49 89 c5 eb 36 49 c7 c5
  RSP: 0018:ffa00000017afc40 EFLAGS: 00010216
  RAX: 00000000003fffc0 RBX: 0000000000000002 RCX: ffa0000001f3d858
  RDX: ffffffffc0218038 RSI: ffffffffc0218008 RDI: aaaaaaaaaaaaaaab
  RBP: ffa00000017afd18 R08: 0000000000000072 R09: 0000000000000069
  R10: ffffffff8160d6ca R11: 0000000000000000 R12: ffa0000001f3d577
  R13: ffffffffc0214058 R14: ffa00000017afdc0 R15: ffa0000001f3e518
  FS:  00007f1c638654c0(0000) GS:ff1100089b7bc000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffa000000233d828 CR3: 000000010ba1f001 CR4: 0000000000771ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __kmalloc_node_track_caller_noprof+0x37f/0x740
   ? __pfx_setup_modinfo_srcversion+0x10/0x10
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? kstrdup+0x4a/0x70
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? setup_modinfo_srcversion+0x1a/0x30
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? setup_modinfo+0x12b/0x1e0
   load_module+0x133a/0x1610
   __x64_sys_finit_module+0x31b/0x450
   ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
   do_syscall_64+0x80/0x2d0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? exc_page_fault+0x95/0xc0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f1c63a2582d
     9.794028] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff 8 8b 0d bb 15 0f 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffe513df128 EFLAGS: 00000206 ORIG_RAX: 0000000000000139
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1c63a2582d
  RDX: 0000000000000000 RSI: 0000000000ee83f9 RDI: 0000000000000016
  RBP: 00007ffe513df150 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffe513e3588
  R13: 000000000088fad0 R14: 00000000014bddb0 R15: 00007f1c63ba7000
   </TASK>
  Modules linked in: bpf_testmod(OE)
  CR2: ffa000000233d828
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:simplify_symbols+0x2b2/0x480
     9.821595] Code: 85 f6 4d 89 f7 b8 01 00 00 00 4c 0f 44 f8 49 83 fd f0 4d 0f 44 fe 75 5b 4d 85 ff 0f 85 76 ff ff ff eb 50 49 8b 4e 20 c1 e0 06 <48> 8b 44 01 10 9 cf fd ff ff 49 89 c5 eb 36 49 c7 c5
  RSP: 0018:ffa00000017afc40 EFLAGS: 00010216
  RAX: 00000000003fffc0 RBX: 0000000000000002 RCX: ffa0000001f3d858
  RDX: ffffffffc0218038 RSI: ffffffffc0218008 RDI: aaaaaaaaaaaaaaab
  RBP: ffa00000017afd18 R08: 0000000000000072 R09: 0000000000000069
  R10: ffffffff8160d6ca R11: 0000000000000000 R12: ffa0000001f3d577
  R13: ffffffffc0214058 R14: ffa00000017afdc0 R15: ffa0000001f3e518
  FS:  00007f1c638654c0(0000) GS:ff1100089b7bc000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffa000000233d828 CR3: 000000010ba1f001 CR4: 0000000000771ef0
  PKRU: 55555554
  Kernel panic - not syncing: Fatal exception
  Kernel Offset: disabled

This hasn't happened on BPF CI so far, for example, however I was able
to reproduce it on a particular x64 machine using a kernel built with
LLVM 20.

The crash happens on attempt to load one of the BPF selftest modules
(tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.ko) which
is used by kfunc_module_order test.

The reason for the crash is that simplify_symbols() doesn't check for
bounds of the ELF section index:

       for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
		const char *name = info->strtab + sym[i].st_name;

		switch (sym[i].st_shndx) {
		case SHN_COMMON:

		[...]

		default:
			/* Divert to percpu allocation if a percpu var. */
			if (sym[i].st_shndx == info->index.pcpu)
				secbase = (unsigned long)mod_percpu(mod);
			else
  /** HERE --> **/		secbase = info->sechdrs[sym[i].st_shndx].sh_addr;
			sym[i].st_value += secbase;
			break;
		}
	}

And in the case I was able to reproduce, the value 0xffff
(SHN_HIRESERVE aka SHN_XINDEX [2]) fell through here.

Now this code fragment is between 15 and 20 years old, so obviously
it's not expected for a kmodule symbol to have such st_shndx
value. Even so, the kernel probably should fail loading the module
instead of crashing, which is what this patch attempts to fix.

Investigating further, I discovered that the module binary became
corrupted by `${OBJCOPY} --update-section` operation updating .BTF_ids
section data in scripts/gen-btf.sh. This explains how the bug has
surfaced after gen-btf.sh was introduced:

  $ llvm-readelf -s --wide bpf_test_modorder_x.ko | grep 'BTF_ID'
  llvm-readelf: warning: 'bpf_test_modorder_x.ko': found an extended symbol index (2), but unable to locate the extended symbol index table
  llvm-readelf: warning: 'bpf_test_modorder_x.ko': found an extended symbol index (3), but unable to locate the extended symbol index table
  llvm-readelf: warning: 'bpf_test_modorder_x.ko': found an extended symbol index (4), but unable to locate the extended symbol index table
       3: 0000000000000000    16 NOTYPE  LOCAL  DEFAULT   RSV[0xffff] __BTF_ID__set8__bpf_test_modorder_kfunc_x_ids
  llvm-readelf: warning: 'bpf_test_modorder_x.ko': found an extended symbol index (16), but unable to locate the extended symbol index table
       4: 0000000000000008     4 OBJECT  LOCAL  DEFAULT   RSV[0xffff] __BTF_ID__func__bpf_test_modorder_retx__44417

vs expected

  $ llvm-readelf -s --wide bpf_test_modorder_x.ko | grep 'BTF_ID'
       3: 0000000000000000    16 NOTYPE  LOCAL  DEFAULT     6 __BTF_ID__set8__bpf_test_modorder_kfunc_x_ids
       4: 0000000000000008     4 OBJECT  LOCAL  DEFAULT     6 __BTF_ID__func__bpf_test_modorder_retx__44417

But why? Updating section data without changing it's size is not
supposed to affect sections indices, right?

With a bit more testing I confirmed that this is a LLVM-specific
issue (doesn't reproduce with GCC kbuild), and it's not stable,
because in link-vmlinux.h we also do:

    ${OBJCOPY} --update-section .BTF_ids=${btfids_vmlinux} ${VMLINUX}

However:

  $ llvm-readelf -s --wide ~/workspace/prog-aux/linux/vmlinux | grep 0xffff
  # no output, which is good

So the suspect is the implementation of llvm-objcopy. As it turns out
there is a relevant known bug that explains the flakiness and isn't
fixed yet [3].

[1] https://lore.kernel.org/bpf/20251219181825.1289460-3-ihor.solodrai@linux.dev/
[2] https://man7.org/linux/man-pages/man5/elf.5.html
[3] https://github.com/llvm/llvm-project/issues/168060#issuecomment-3533552952

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

RFC

While this llvm-objcopy bug is not fixed, we can not trust it in the
kernel build pipeline. In the short-term we have to come up with a
workaround for .BTF_ids section update and replace the calls to
${OBJCOPY} --update-section with something else.

One potential workaround is to force the use of the objcopy (from
binutils) instead of llvm-objcopy when updating .BTF_ids section.

Alternatively, we could just dd the .BTF_ids data computed by
resolve_btfids at the right offset in the target ELF file.

Surprisingly I couldn't find a good way to read a section offset and
size from the ELF with a specified format in a command line. Both
readelf and {llvm-}objdump give a human readable output, and it
appears we can't rely on the column order, for example.

We could still try parsing readelf output with awk/grep, covering
output variants that appear in the kernel build.

We can also do:

   llvm-readobj --elf-output-style=JSON --sections "$elf" | \
        jq -r --arg name .BTF_ids '
            .[0].Sections[] |
            select(.Section.Name.Name == $name) |
            "\(.Section.Offset) \(.Section.Size)"'

...but idk man, doesn't feel right.

Most reliable way to determine the size and offset of .BTF_ids section
is probably reading them by a C program with libelf, such as
resolve_btfids. Which is quite ironic, given the recent
changes. Setting the irony aside, we could add smth like:
         resolve_btfids --section-info=.BTF_ids $elf

Reverting the gen-btf.sh patch is also a possible workaround, but I'd
really like to avoid it, given that BPF features/optimizations in
development depend on it.

I'd appreciate comments and suggestions on this issue. Thank you!
---
 kernel/module/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 710ee30b3bea..5bf456fad63e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1568,6 +1568,13 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 			break;
 
 		default:
+			if (sym[i].st_shndx >= info->hdr->e_shnum) {
+				pr_err("%s: Symbol %s has an invalid section index %u (max %u)\n",
+				       mod->name, name, sym[i].st_shndx, info->hdr->e_shnum - 1);
+				ret = -ENOEXEC;
+				break;
+			}
+
 			/* Divert to percpu allocation if a percpu var. */
 			if (sym[i].st_shndx == info->index.pcpu)
 				secbase = (unsigned long)mod_percpu(mod);
-- 
2.52.0


