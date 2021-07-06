Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8482A3BD4B5
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 14:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhGFMRD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 08:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235812AbhGFLa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 07:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E10E61DEA;
        Tue,  6 Jul 2021 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570513;
        bh=0XRFg5hIq6dpQhf6aGNiDBR8wtXCngnhyGCW3ADbjSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ubw04I4Xje6pl0cX7PZY6csqQz9JYMmm3DFolbos9jk6t43WusJjj2O/x7p7DvPE0
         JjmTjTqFWS7HsAmHAWYfPZVN7dxAsQHOF0gYaPbndyZkQcMX8ogs6KFX+7oEy/99hm
         YC5tHFm/EW1wghhCqx5DEEE3LAYdSqeC+Ftv1j3WqQhVDI0XjRgPYuNumZXG/+kgGd
         URj1OTKZBNUgsYbyeX1wrHGcSZ+GTshAfqfiONdEXsMdQqdXW22axC2m0GoK4Kj87Y
         XdwHCN+05jOm+SkI2Djj8kjjlG1Xd0L8RWooVVZkAU18m6wI9QsZkefZFK3dDwzBFd
         kdnmUtjaPDnQA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rustam Kovhaev <rkovhaev@gmail.com>,
        syzbot+5d895828587f49e7fe9b@syzkaller.appspotmail.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 154/160] bpf: Fix false positive kmemleak report in bpf_ringbuf_area_alloc()
Date:   Tue,  6 Jul 2021 07:18:20 -0400
Message-Id: <20210706111827.2060499-154-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111827.2060499-1-sashal@kernel.org>
References: <20210706111827.2060499-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rustam Kovhaev <rkovhaev@gmail.com>

[ Upstream commit ccff81e1d028bbbf8573d3364a87542386c707bf ]

kmemleak scans struct page, but it does not scan the page content. If we
allocate some memory with kmalloc(), then allocate page with alloc_page(),
and if we put kmalloc pointer somewhere inside that page, kmemleak will
report kmalloc pointer as a false positive.

We can instruct kmemleak to scan the memory area by calling kmemleak_alloc()
and kmemleak_free(), but part of struct bpf_ringbuf is mmaped to user space,
and if struct bpf_ringbuf changes we would have to revisit and review size
argument in kmemleak_alloc(), because we do not want kmemleak to scan the
user space memory. Let's simplify things and use kmemleak_not_leak() here.

For posterity, also adding additional prior analysis from Andrii:

  I think either kmemleak or syzbot are misreporting this. I've added a
  bunch of printks around all allocations performed by BPF ringbuf. [...]
  On repro side I get these two warnings:

  [vmuser@archvm bpf]$ sudo ./repro
  BUG: memory leak
  unreferenced object 0xffff88810d538c00 (size 64):
    comm "repro", pid 2140, jiffies 4294692933 (age 14.540s)
    hex dump (first 32 bytes):
      00 af 19 04 00 ea ff ff c0 ae 19 04 00 ea ff ff  ................
      80 ae 19 04 00 ea ff ff c0 29 2e 04 00 ea ff ff  .........)......
    backtrace:
      [<0000000077bfbfbd>] __bpf_map_area_alloc+0x31/0xc0
      [<00000000587fa522>] ringbuf_map_alloc.cold.4+0x48/0x218
      [<0000000044d49e96>] __do_sys_bpf+0x359/0x1d90
      [<00000000f601d565>] do_syscall_64+0x2d/0x40
      [<0000000043d3112a>] entry_SYSCALL_64_after_hwframe+0x44/0xae

  BUG: memory leak
  unreferenced object 0xffff88810d538c80 (size 64):
    comm "repro", pid 2143, jiffies 4294699025 (age 8.448s)
    hex dump (first 32 bytes):
      80 aa 19 04 00 ea ff ff 00 ab 19 04 00 ea ff ff  ................
      c0 ab 19 04 00 ea ff ff 80 44 28 04 00 ea ff ff  .........D(.....
    backtrace:
      [<0000000077bfbfbd>] __bpf_map_area_alloc+0x31/0xc0
      [<00000000587fa522>] ringbuf_map_alloc.cold.4+0x48/0x218
      [<0000000044d49e96>] __do_sys_bpf+0x359/0x1d90
      [<00000000f601d565>] do_syscall_64+0x2d/0x40
      [<0000000043d3112a>] entry_SYSCALL_64_after_hwframe+0x44/0xae

  Note that both reported leaks (ffff88810d538c80 and ffff88810d538c00)
  correspond to pages array bpf_ringbuf is allocating and tracking properly
  internally. Note also that syzbot repro doesn't close FD of created BPF
  ringbufs, and even when ./repro itself exits with error, there are still
  two forked processes hanging around in my system. So clearly ringbuf maps
  are alive at that point. So reporting any memory leak looks weird at that
  point, because that memory is being used by active referenced BPF ringbuf.

  It's also a question why repro doesn't clean up its forks. But if I do a
  `pkill repro`, I do see that all the allocated memory is /properly/ cleaned
  up [and the] "leaks" are deallocated properly.

  BTW, if I add close() right after bpf() syscall in syzbot repro, I see that
  everything is immediately deallocated, like designed. And no memory leak
  is reported. So I don't think the problem is anywhere in bpf_ringbuf code,
  rather in the leak detection and/or repro itself.

Reported-by: syzbot+5d895828587f49e7fe9b@syzkaller.appspotmail.com
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
[ Daniel: also included analysis from Andrii to the commit log ]
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: syzbot+5d895828587f49e7fe9b@syzkaller.appspotmail.com
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4BzYk+dqs+jwu6VKXP-RttcTEGFe+ySTGWT9CRNkagDiJVA@mail.gmail.com
Link: https://lore.kernel.org/lkml/YNTAqiE7CWJhOK2M@nuc10
Link: https://lore.kernel.org/lkml/20210615101515.GC26027@arm.com
Link: https://syzkaller.appspot.com/bug?extid=5d895828587f49e7fe9b
Link: https://lore.kernel.org/bpf/20210626181156.1873604-1-rkovhaev@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/ringbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 84b3b35fc0d0..9e0c10c6892a 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -8,6 +8,7 @@
 #include <linux/vmalloc.h>
 #include <linux/wait.h>
 #include <linux/poll.h>
+#include <linux/kmemleak.h>
 #include <uapi/linux/btf.h>
 
 #define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
@@ -105,6 +106,7 @@ static struct bpf_ringbuf *bpf_ringbuf_area_alloc(size_t data_sz, int numa_node)
 	rb = vmap(pages, nr_meta_pages + 2 * nr_data_pages,
 		  VM_ALLOC | VM_USERMAP, PAGE_KERNEL);
 	if (rb) {
+		kmemleak_not_leak(pages);
 		rb->pages = pages;
 		rb->nr_pages = nr_pages;
 		return rb;
-- 
2.30.2

