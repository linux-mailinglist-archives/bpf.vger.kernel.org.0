Return-Path: <bpf+bounces-9874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D413F79E140
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E57E281ECF
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45F1DA3C;
	Wed, 13 Sep 2023 07:56:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730981802E;
	Wed, 13 Sep 2023 07:56:12 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8175E1729;
	Wed, 13 Sep 2023 00:56:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rlt7B6MbKz4f3mHR;
	Wed, 13 Sep 2023 15:56:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3RtYUawFlzwxoAQ--.53713S2;
	Wed, 13 Sep 2023 15:56:08 +0800 (CST)
Subject: Re: linux-next: boot warning from the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>
References: <20230913133436.0eeec4cb@canb.auug.org.au>
 <20230913145919.6060ae61@canb.auug.org.au>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <64f1f578-17e7-a8a8-12f2-6a1a0d98a4af@huaweicloud.com>
Date: Wed, 13 Sep 2023 15:56:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230913145919.6060ae61@canb.auug.org.au>
Content-Type: multipart/mixed;
 boundary="------------B6581E172DB28EDFDE8542E4"
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3RtYUawFlzwxoAQ--.53713S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15AFWrGF1xZw4kKF15Arb_yoWrAr47pr
	1UJr1UCr48Jr1UJr1UJF15Jr1UJr1UAF1UJr1kJryUJr1UJr1UJr1UJr1UJr1UJr4UXr1U
	Jw1Dtr1Utr1UGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02
	F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI
	0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CE
	bIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJ
	UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

This is a multi-part message in MIME format.
--------------B6581E172DB28EDFDE8542E4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi,

On 9/13/2023 12:59 PM, Stephen Rothwell wrote:
> Hi all,
>
> On Wed, 13 Sep 2023 13:34:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Today's linux-next boot tests (powerpc pseries_le_defconfig) produced
>> this warning:
>>
>>  ------------[ cut here ]------------
>>  bpf_mem_cache[0]: unexpected object size 16, expect 96
>>  WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:500 bpf_mem_alloc_init+0x410/0x440
>>  Modules linked in:
>>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-04964-g2e08ed1d459f #1
>>  Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,HEAD pSeries
>>  NIP:  c0000000003c0890 LR: c0000000003c088c CTR: 0000000000000000
>>  REGS: c000000004783890 TRAP: 0700   Not tainted  (6.6.0-rc1-04964-g2e08ed1d459f)
>>  MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000280  XER: 00000000
>>  CFAR: c00000000014cfa0 IRQMASK: 0 
>>  GPR00: c0000000003c088c c000000004783b30 c000000001578c00 0000000000000036 
>>  GPR04: 0000000000000000 c000000002667e18 0000000000000001 0000000000000000 
>>  GPR08: c000000002667ce0 0000000000000001 0000000000000000 0000000044000280 
>>  GPR12: 0000000000000000 c000000002b00000 c000000000011188 0000000000000060 
>>  GPR16: c0000000011f9a30 c000000002920f68 c0000000021fac40 c0000000021fac40 
>>  GPR20: c000000002a3ed88 c000000002921560 c0000000014867f0 c00000000291ccd8 
>>  GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000010 
>>  GPR28: c0000000011f9a30 0000000000000000 000000000000000b c00000007fc9ac40 
>>  NIP [c0000000003c0890] bpf_mem_alloc_init+0x410/0x440
>>  LR [c0000000003c088c] bpf_mem_alloc_init+0x40c/0x440
>>  Call Trace:
>>  [c000000004783b30] [c0000000003c088c] bpf_mem_alloc_init+0x40c/0x440 (unreliable)
>>  [c000000004783c20] [c00000000203d0c0] bpf_global_ma_init+0x5c/0x9c
>>  [c000000004783c50] [c000000000010bc0] do_one_initcall+0x80/0x300
>>  [c000000004783d20] [c000000002004978] kernel_init_freeable+0x30c/0x3b4
>>  [c000000004783df0] [c0000000000111b0] kernel_init+0x30/0x1a0
>>  [c000000004783e50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
>>  --- interrupt: 0 at 0x0
>>  NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
>>  REGS: c000000004783e80 TRAP: 0000   Not tainted  (6.6.0-rc1-04964-g2e08ed1d459f)
>>  MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
>>  CFAR: 0000000000000000 IRQMASK: 0 
>>  GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>  GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>  GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>  GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>  GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>  GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>  GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>  NIP [0000000000000000] 0x0
>>  LR [0000000000000000] 0x0
>>  --- interrupt: 0
>>  Code: 3b000000 4bfffcbc 78650020 3c62ffe7 39200001 3d420130 7cc607b4 7ba40020 386382f0 992a1e24 4bd8c631 60000000 <0fe00000> 4bffff40 ea410080 3860fff4 
>>  ---[ end trace 0000000000000000 ]---
>>
>> Presumably related to commit
>>
>>   41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")
>>
>> (or other commist in that series) from the bpf-next tree.
> Actually it looks like it is some interaction between that commit a
> commits in the bpf tree.

Yes. The warning is due to the checking added in commit c93047255202
("bpf: Ensure unit_size is matched with slab cache object size").
Considering that bpf-next has not merged the patch-set yet, should I
post a patch to bpf tree to fix it ? A fix patch is attached which can
fix the warning in my local setup.

>
>


--------------B6581E172DB28EDFDE8542E4
Content-Type: text/plain; charset=UTF-8;
 name="0001-bpf-Skip-unit_size-checking-for-global-per-cpu-alloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-bpf-Skip-unit_size-checking-for-global-per-cpu-alloc.pa";
 filename*1="tch"

From 395d19f1ac747070fce43356cea336b4430afed2 Mon Sep 17 00:00:00 2001
From: Hou Tao <houtao1@huawei.com>
Date: Wed, 13 Sep 2023 15:33:13 +0800
Subject: [PATCH] bpf: Skip unit_size checking for global per-cpu allocator

For global per-cpu allocator, the size of free object in free list
doesn't match with unit_size and now there is no way to get the size of
per-cpu pointer saved in free object, so just skip the checking.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index aad558cdc70f..0ad175277f89 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -491,6 +491,13 @@ static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
 	struct llist_node *first;
 	unsigned int obj_size;
 
+	/* For per-cpu allocator, the size of free objects in free list doesn't
+	 * match with unit_size and now there is no way to get the size of
+	 * per-cpu pointer saved in free object, so just skip the checking.
+	 */
+	if (c->percpu_size)
+		return 0;
+
 	first = c->free_llist.first;
 	if (!first)
 		return 0;
-- 
2.29.2


--------------B6581E172DB28EDFDE8542E4--


