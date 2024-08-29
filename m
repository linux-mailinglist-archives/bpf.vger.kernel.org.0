Return-Path: <bpf+bounces-38345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B59638E3
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 05:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55ED628500A
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 03:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED3549651;
	Thu, 29 Aug 2024 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuXO+Fro"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD6647;
	Thu, 29 Aug 2024 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903162; cv=none; b=nyZxb6nveQ6HF+lw4tSjUl1hBNyro6he/TzrcK688A5Jhe5djkWpGfhtJQ0J68LIaQEAgYFpu9TzKNuwHCmMATg6tuxsGL0WiyirHhVA/gBe/u9b+fTBBHxBih0PNbayFUhJ+M7tmkgqjm1b+mn0ckMg4s9oSPPNomPd/BQrNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903162; c=relaxed/simple;
	bh=10pr+LTTajHa7NV/ajDdAVpnvjKFDzqWogPR3/Vdj1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxbBY9ZK0HbcZsg7dcalWl4d07OQzMG64ah76Yw30LDBeJxmDMgHjDwcOds1wiPjHeGWzO1mMz5ZeOQO85JxLmGtHuuMC/+5KBVC84kWpi1Z6NcEjMRjKAGo8/7UqAN7YVLhI2RvDZikINd4D5nuXfvAtyWkQ0+JJj+eLVD7FDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuXO+Fro; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso109455a12.0;
        Wed, 28 Aug 2024 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724903160; x=1725507960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knDSBhsKojl3mS79su22wP2RPFRwPNCrGRqYJ3OCgtE=;
        b=PuXO+FroVMcdQSAtxR94ntedT6qlbX0eWDnAJBKKaIL/8HpDYGxZEQMVHUt+RxEtRn
         ydF0cBm1Ss8cl0TJ98u+eq+xdCLKrQua1oaxgcHObnqkKbA78fHmk0qeGwMmEl5J12aJ
         d4f3JSk3ix5Ld8xx3i2Jr7CW83JoRKQkGsz7IVNzgxY8BU4ht9VaEPWYiT9fuLyBShc1
         bzrbeTD0lctJxQAk1ThHrObhE9u9JqsU2run1RBMeqxEJAB9nBTuzOxLnZGGfdEzaFrJ
         bnr3grVQN1lWTFkvxGVrdtLYO3h5KWmjkbGtVOT4ZsXT/L7wUW14sy6xM+iU+NLrLiX7
         sj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724903160; x=1725507960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knDSBhsKojl3mS79su22wP2RPFRwPNCrGRqYJ3OCgtE=;
        b=pSNH7bE6wU2hTTzorKRcf+THiV4CNm8Zw6ZYWO+yA23q/wZ3QHSjEtDiTHxwUZ/1Fi
         38Vv2UORQiIYdX6ce73qiow8D/2rJFUM++gdJPxdNDtvUOT5Tzeij/xwL223m/PDiyGQ
         fpchrLZd4iCKGqtSk6Htji4br6cSX/rtBJqiyPOkEn+kWkmbLGUyWKJud5eoIJai8H6c
         ybr9R0O1FBAlC+5mwKpFFqiPmjAIGVE9GCml0BPoiLdmDCNeeqcLP39K8j6Qc9vb36Ks
         gzpIpMrp4F0kNiRNvjlWlxmjik1fdCGy0SPGJOE5yfpohKLgaHrIxvjgQFGSL7teMpQN
         LCbw==
X-Forwarded-Encrypted: i=1; AJvYcCWiuLhZ5UrmQaRLADjrXw2XiRusX9iTL2iNB4yXxX80uMCVAhyOL3UTSfTU66NRAqAkYN8=@vger.kernel.org, AJvYcCXl1VHXSamP/UvgDj4YC+xsh1IxvjR/yrTMyoRZp9J0bh7d2mtCLnHIntoD08db0bd2DGWHPtLeIq/rr7Vk@vger.kernel.org
X-Gm-Message-State: AOJu0YzQM/hk/7AVnwIQtdCYkubV2x/Vk0D6a/S/qIzIMZISJugad26d
	7AHE17eiVy8fYWj1uilwHNoLo6z4hBpOrNhKyAr2AalDzZA1ZPvM
X-Google-Smtp-Source: AGHT+IEZlSAl4sALJEoN6/Ha0DNqwCGAV7yO8cCe/5pHizlQcJaK64Iazq6TLCj7HDWX5jKXGJJ23g==
X-Received: by 2002:a05:6a21:3949:b0:1c8:bfa8:d55a with SMTP id adf61e73a8af0-1cce100ef06mr1653753637.21.1724903160025;
        Wed, 28 Aug 2024 20:46:00 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446c1c52sm2782340a91.38.2024.08.28.20.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:45:59 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: aha310510@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf] bpf: add check for invalid name in btf_name_valid_section()
Date: Thu, 29 Aug 2024 12:45:52 +0900
Message-Id: <20240829034552.262214-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAADnVQKsZ9zboc4k0mnrwcUv6ioSQ6aBXXC+t+-233n17Vdw-A@mail.gmail.com>
References: <CAADnVQKsZ9zboc4k0mnrwcUv6ioSQ6aBXXC+t+-233n17Vdw-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Alexei Starovoitov wrote:
>
> On Fri, Aug 23, 2024 at 3:43 AM Jeongjun Park <aha310510@gmail.com> wrote:
> >
> > If the length of the name string is 1 and the value of name[0] is NULL
> > byte, an OOB vulnerability occurs in btf_name_valid_section() and the
> > return value is true, so the invalid name passes the check.
> >
> > To solve this, you need to check if the first position is NULL byte.
> >
> > Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC names")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 520f49f422fe..5c24ea1a65a4 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -823,6 +823,9 @@ static bool btf_name_valid_section(const struct btf *btf, u32 offset)
> >         const char *src = btf_str_by_offset(btf, offset);
> >         const char *src_limit;
> >
> > +       if (!*src)
> > +               return false;
> > +
>
> We've talked about it. Quote:
> "Pls add a selftest that demonstrates the issue
> and produce a patch to fix just that."
>
> length == 1 and name[0] = 0 is a hypothesis.
> Demonstrate that such a scenario is possible then this patch will be
> worth applying.
>
> pw-bot: cr

Sorry for the omission, I still don't know how to write selftest.

But I can give you the C repro and KASAN log that trigger this vulnerability. 
I would appreciate it if you could look at it and make a judgment.

Regards,
Jeongjun Park

C repro:
// gcc -o repro repro.c
#define _GNU_SOURCE 

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

int main(void)
{
		syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
	const char* reason;
	(void)reason;
				if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {}
	*(uint64_t*)0x20000340 = 0x20000140;
	*(uint16_t*)0x20000140 = 0xeb9f;
	*(uint8_t*)0x20000142 = 1;
	*(uint8_t*)0x20000143 = 0;
	*(uint32_t*)0x20000144 = 0x18;
	*(uint32_t*)0x20000148 = 0;
	*(uint32_t*)0x2000014c = 0xc4;
	*(uint32_t*)0x20000150 = 0xc4;
	*(uint32_t*)0x20000154 = 5;
	*(uint32_t*)0x20000158 = 4;
	*(uint16_t*)0x2000015c = 0xa;
	*(uint8_t*)0x2000015e = 0;
	*(uint8_t*)0x2000015f = 0xf;
	*(uint32_t*)0x20000160 = 1;
	*(uint32_t*)0x20000164 = 3;
	*(uint32_t*)0x20000168 = 1;
	*(uint32_t*)0x2000016c = 0x9247;
	*(uint32_t*)0x20000170 = 3;
	*(uint32_t*)0x20000174 = 0xfffffff9;
	*(uint32_t*)0x20000178 = 9;
	*(uint32_t*)0x2000017c = 5;
	*(uint32_t*)0x20000180 = 0x7d;
	*(uint32_t*)0x20000184 = 0x48;
	*(uint32_t*)0x20000188 = 3;
	*(uint32_t*)0x2000018c = 9;
	*(uint32_t*)0x20000190 = 2;
	*(uint32_t*)0x20000194 = 1;
	*(uint32_t*)0x20000198 = 0xe;
	*(uint32_t*)0x2000019c = 5;
	*(uint32_t*)0x200001a0 = 3;
	*(uint32_t*)0x200001a4 = 0xfffffa64;
	*(uint32_t*)0x200001a8 = 0xffff;
	*(uint32_t*)0x200001ac = 3;
	*(uint32_t*)0x200001b0 = 3;
	*(uint32_t*)0x200001b4 = 0xfff;
	*(uint32_t*)0x200001b8 = 5;
	*(uint32_t*)0x200001bc = 0x8fd;
	*(uint32_t*)0x200001c0 = 0xa16;
	*(uint32_t*)0x200001c4 = 2;
	*(uint32_t*)0x200001c8 = 7;
	*(uint32_t*)0x200001cc = 6;
	*(uint32_t*)0x200001d0 = 2;
	*(uint32_t*)0x200001d4 = 0xe821;
	*(uint32_t*)0x200001d8 = 5;
	memset((void*)0x200001dc, 104, 1);
	*(uint32_t*)0x200001dd = 0xf;
	*(uint16_t*)0x200001e1 = 0;
	*(uint8_t*)0x200001e3 = 0;
	*(uint8_t*)0x200001e4 = 8;
	*(uint32_t*)0x200001e5 = 4;
	*(uint32_t*)0x200001e9 = 0;
	*(uint16_t*)0x200001ed = 0;
	*(uint8_t*)0x200001ef = 0;
	*(uint8_t*)0x200001f0 = 3;
	*(uint32_t*)0x200001f1 = 0;
	*(uint32_t*)0x200001f5 = 4;
	*(uint32_t*)0x200001f9 = 3;
	*(uint32_t*)0x200001fd = 2;
	*(uint32_t*)0x20000201 = 7;
	*(uint16_t*)0x20000205 = 0;
	*(uint8_t*)0x20000207 = 0;
	*(uint8_t*)0x20000208 = 0xa;
	*(uint32_t*)0x20000209 = 5;
	*(uint32_t*)0x2000020d = 3;
	*(uint16_t*)0x20000211 = 0;
	*(uint8_t*)0x20000213 = 0;
	*(uint8_t*)0x20000214 = 0xf;
	*(uint32_t*)0x20000215 = 3;
	memcpy((void*)0x20000219, "\x65\xd8\x38", 3);
	*(uint8_t*)0x2000021c = 0;
	*(uint8_t*)0x2000021d = 0;
	*(uint8_t*)0x2000021e = 0;
	*(uint8_t*)0x2000021f = 0;
	*(uint8_t*)0x20000220 = 0;
	*(uint64_t*)0x20000348 = 0;
	*(uint32_t*)0x20000350 = 0xe1;
	*(uint32_t*)0x20000354 = 0;
	*(uint32_t*)0x20000358 = 0;
	*(uint32_t*)0x2000035c = 0;
	syscall(__NR_bpf, /*cmd=*/0x12ul, /*arg=*/0x20000340ul, /*size=*/0x20ul);
	return 0;
}

KASAN log:

==================================================================
BUG: KASAN: slab-out-of-bounds in btf_name_valid_section kernel/bpf/btf.c:829 [inline]
BUG: KASAN: slab-out-of-bounds in btf_datasec_check_meta+0x7f8/0x880 kernel/bpf/btf.c:4698
Read of size 1 at addr ffff888012faaeb8 by task syz.3.2008/25618

CPU: 0 UID: 0 PID: 25618 Comm: syz.3.2008 Not tainted 6.11.0-rc5 #12
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc0/0x5e0 mm/kasan/report.c:488
 kasan_report+0xbd/0xf0 mm/kasan/report.c:601
 btf_name_valid_section kernel/bpf/btf.c:829 [inline]
 btf_datasec_check_meta+0x7f8/0x880 kernel/bpf/btf.c:4698
 btf_check_meta kernel/bpf/btf.c:5180 [inline]
 btf_check_all_metas kernel/bpf/btf.c:5204 [inline]
 btf_parse_type_sec kernel/bpf/btf.c:5340 [inline]
 btf_parse kernel/bpf/btf.c:5732 [inline]
 btf_new_fd+0x1764/0x4c30 kernel/bpf/btf.c:7650
 bpf_btf_load kernel/bpf/syscall.c:5035 [inline]
 __sys_bpf+0x1dc4/0x5040 kernel/bpf/syscall.c:5755
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6dee39712d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6def181fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f6dee535f80 RCX: 00007f6dee39712d
RDX: 0000000000000020 RSI: 0000000020000600 RDI: 0000000000000012
RBP: 00007f6dee41bd8a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6dee535f80 R15: 00007f6def162000
 </TASK>

Allocated by task 25618:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_node_noprof+0x20a/0x450 mm/slub.c:4164
 __kvmalloc_node_noprof+0x148/0x1b0 mm/util.c:650
 btf_parse kernel/bpf/btf.c:5708 [inline]
 btf_new_fd+0x5f9/0x4c30 kernel/bpf/btf.c:7650
 bpf_btf_load kernel/bpf/syscall.c:5035 [inline]
 __sys_bpf+0x1dc4/0x5040 kernel/bpf/syscall.c:5755
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888012faae00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes to the right of
 allocated 184-byte region [ffff888012faae00, ffff888012faaeb8)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12faa
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff8880154413c0 ffffea00004b78c0 dead000000000002
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 8387, tgid 8387 (syz-executor), ts 57078807121, free_ts 54812229064
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2e7/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0xbf3/0x2850 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x214/0x21e0 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x55/0x100 mm/slub.c:2321
 allocate_slab mm/slub.c:2484 [inline]
 new_slab+0x83/0x260 mm/slub.c:2537
 ___slab_alloc+0xbb7/0x1850 mm/slub.c:3723
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __kmalloc_cache_noprof+0x2be/0x310 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 kset_create lib/kobject.c:965 [inline]
 kset_create_and_add+0x4f/0x1a0 lib/kobject.c:1008
 register_queue_kobjects net/core/net-sysfs.c:1887 [inline]
 netdev_register_kobject+0x1d2/0x400 net/core/net-sysfs.c:2140
 register_netdevice+0x1329/0x1bf0 net/core/dev.c:10444
 veth_newlink+0x4bd/0x960 drivers/net/veth.c:1860
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink+0x1138/0x18e0 net/core/rtnetlink.c:3730
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c9/0xfb0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2550
page last free pid 96 tgid 96 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x9c6/0x1320 mm/page_alloc.c:2660
 shrink_folio_list+0x29f0/0x4260 mm/vmscan.c:1530
 evict_folios+0x71e/0x1b50 mm/vmscan.c:4580
 try_to_shrink_lruvec+0x62b/0x9a0 mm/vmscan.c:4775
 shrink_one+0x417/0x7c0 mm/vmscan.c:4813
 shrink_many mm/vmscan.c:4876 [inline]
 lru_gen_shrink_node mm/vmscan.c:4954 [inline]
 shrink_node+0x244d/0x3830 mm/vmscan.c:5934
 kswapd_shrink_node mm/vmscan.c:6762 [inline]
 balance_pgdat+0xba2/0x1880 mm/vmscan.c:6954
 kswapd+0x702/0xd50 mm/vmscan.c:7223
 kthread+0x2c7/0x3b0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888012faad80: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888012faae00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888012faae80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                        ^
 ffff888012faaf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888012faaf80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
==================================================================

