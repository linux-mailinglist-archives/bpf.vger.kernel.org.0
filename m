Return-Path: <bpf+bounces-77508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08491CE93DF
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEB7B3011410
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE42C033C;
	Tue, 30 Dec 2025 09:41:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B0721D3F4
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087704; cv=none; b=eccHYrYK/o821aatPnQaDjc23qbmvbnySkqmilREK897uSZYxCS99A3YY2Cnl9C45ZrBiVXX9+CwXASy03nSi+uM2lGR2KJHRVTGhfBKjwqp0xx1AFeh5TkmNLGQMrHNjOWu1kjRDDsgm/xxsCkL2Xce3v20BxPMdZATHUJk/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087704; c=relaxed/simple;
	bh=Xl+DxNKuJUAyQBUhAGYXHEleG4jIs00lsrE6+NWXgeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sn5p9ZEqiJuUWbOkXgE/iECcPPVxRS/+hm4mVqxWg98gqzHvWMJs7Fnt+aWYclrYwhi/uY1gmh9gxIzfjdGZaawNdeobtdRdaQTgbaSpVTuGzGdrraU9FtFBEx2Er+9XIIvNH3BY63RXpqiCURP7fn98/F2Q6jFtv+34vXQ1JXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dgSl91FdnzKHMb2
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 17:41:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F37974056B
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 17:41:37 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBXcYBNnlNpAr7tBw--.22205S2;
	Tue, 30 Dec 2025 17:41:34 +0800 (CST)
Message-ID: <d2c23a07-7072-4f10-856c-dab02e3ed15c@huaweicloud.com>
Date: Tue, 30 Dec 2025 17:41:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] KASAN: invalid-access in
 bpf_patch_insn_data+0x22c/0x2f0
To: Jeongho Choi <jh1012.choi@samsung.com>, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com
Cc: joonki.min@samsung.com, hajun.sung@samsung.com
References: <CGME20251229105858epcas2p26c433715e7955d20072e72964e83c3e7@epcas2p2.samsung.com>
 <20251229110431.GA2243991@tiffany>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20251229110431.GA2243991@tiffany>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXcYBNnlNpAr7tBw--.22205S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4ftryUur43AF1xZr1rtFb_yoW7Jw43pr
	1qk34Ikw4kJ3y5uw4av3ZrCw12va1a93W3Gr4xJ3yFqr13Zrn3JF15tFy8Jr13u34qkr13
	AryDKr1aqryUZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/29/2025 7:05 PM, Jeongho Choi wrote:
> Hello
> I'm jeongho Choi from samsung System LSI.
> I'm developing kernel BSP for exynos SoC.
> 
> I'm asking a question because I've recently been experiencing
> issues after enable SW KASAN in Android17 kernel 6.18 environment.
> 
> Context:
>   - Kernel version: v6.18
>   - Architecture: ARM64
> 
> Question:
> When SW tag KASAN is enabled, we got kernel crash from bpf/verifier.
> I found that it occurred only from 6.18, not 6.12 LTS we're working on.
> 
> After some tests, I found that the device is booted when 2 commits are reverted.
> 
> bpf: potential double-free of env->insn_aux_data
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b13448dd64e27752fad252cec7da1a50ab9f0b6f
> 
> bpf: use realloc in bpf_patch_insn_data
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77620d1267392b1a34bfc437d2adea3006f95865
> 
> ==================================================================
> [   79.419177] [4:     netbpfload:  825] BUG: KASAN: invalid-access in bpf_patch_insn_data+0x22c/0x2f0
> [   79.419415] [4:     netbpfload:  825] Write of size 27896 at addr 25ffffc08e6314d0 by task netbpfload/825
> [   79.419984] [4:     netbpfload:  825] Pointer tag: [25], memory tag: [fa]
> [   79.425193] [4:     netbpfload:  825]
> [   79.427365] [4:     netbpfload:  825] CPU: 4 UID: 0 PID: 825 Comm: netbpfload Tainted: G           OE       6.18.0-rc6-android17-0-gd28deb424356-4k #1 PREEMPT  92293e52a7788dc6ec1b9dff6625aaee925f3475
> [   79.427374] [4:     netbpfload:  825] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [   79.427378] [4:     netbpfload:  825] Hardware name: Samsung ERD9965 board based on S5E9965 (DT)
> [   79.427382] [4:     netbpfload:  825] Call trace:
> [   79.427385] [4:     netbpfload:  825]  show_stack+0x18/0x28 (C)
> [   79.427394] [4:     netbpfload:  825]  __dump_stack+0x28/0x3c
> [   79.427401] [4:     netbpfload:  825]  dump_stack_lvl+0x7c/0xa8
> [   79.427407] [4:     netbpfload:  825]  print_address_description+0x7c/0x20c
> [   79.427414] [4:     netbpfload:  825]  print_report+0x70/0x8c
> [   79.427421] [4:     netbpfload:  825]  kasan_report+0xb4/0x114
> [   79.427427] [4:     netbpfload:  825]  kasan_check_range+0x94/0xa0
> [   79.427432] [4:     netbpfload:  825]  __asan_memmove+0x54/0x88
> [   79.427437] [4:     netbpfload:  825]  bpf_patch_insn_data+0x22c/0x2f0
> [   79.427442] [4:     netbpfload:  825]  bpf_check+0x2b44/0x8c34
> [   79.427449] [4:     netbpfload:  825]  bpf_prog_load+0x8dc/0x990
> [   79.427453] [4:     netbpfload:  825]  __sys_bpf+0x300/0x4c8
> [   79.427458] [4:     netbpfload:  825]  __arm64_sys_bpf+0x48/0x64
> [   79.427465] [4:     netbpfload:  825]  invoke_syscall+0x6c/0x13c
> [   79.427471] [4:     netbpfload:  825]  el0_svc_common+0xf8/0x138
> [   79.427478] [4:     netbpfload:  825]  do_el0_svc+0x30/0x40
> [   79.427484] [4:     netbpfload:  825]  el0_svc+0x38/0x8c
> [   79.427491] [4:     netbpfload:  825]  el0t_64_sync_handler+0x68/0xdc
> [   79.427497] [4:     netbpfload:  825]  el0t_64_sync+0x1b8/0x1bc
> [   79.427502] [4:     netbpfload:  825]
> [   79.545586] [4:     netbpfload:  825] The buggy address belongs to a 8-page vmalloc region starting at 0x25ffffc08e631000 allocated at bpf_patch_insn_data+0x8c/0x2f0
> [   79.558777] [4:     netbpfload:  825] The buggy address belongs to the physical page:
> [   79.565029] [4:     netbpfload:  825] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8b308b
> [   79.573710] [4:     netbpfload:  825] memcg:c6ffff882d1d6402
> [   79.577791] [4:     netbpfload:  825] flags: 0x6f80000000000000(zone=1|kasantag=0xbe)
> [   79.584042] [4:     netbpfload:  825] raw: 6f80000000000000 0000000000000000 dead000000000122 0000000000000000
> [   79.592460] [4:     netbpfload:  825] raw: 0000000000000000 0000000000000000 00000001ffffffff c6ffff882d1d6402
> [   79.600877] [4:     netbpfload:  825] page dumped because: kasan: bad access detected
> [   79.607126] [4:     netbpfload:  825]
> [   79.609296] [4:     netbpfload:  825] Memory state around the buggy address:
> [   79.614766] [4:     netbpfload:  825]  ffffffc08e637f00: 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
> [   79.622665] [4:     netbpfload:  825]  ffffffc08e638000: 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
> [   79.630562] [4:     netbpfload:  825] >ffffffc08e638100: 25 25 25 25 25 25 25 fa fa fa fa fa fa fe fe fe
> [   79.638463] [4:     netbpfload:  825]                                         ^
> [   79.644190] [4:     netbpfload:  825]  ffffffc08e638200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [   79.652089] [4:     netbpfload:  825]  ffffffc08e638300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [   79.659987] [4:     netbpfload:  825] ==================================================================
> 

Seems it is the same as the second issue fixed by the following patch:
https://lore.kernel.org/all/3f851f7704ab8468530f384b901b22cdef94aa43.1765978969.git.m.wieczorretman@pm.me

> I have a question about the above phenomenon.
> Thanks,
> Jeongho Choi
> 
> 


