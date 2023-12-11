Return-Path: <bpf+bounces-17392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF4B80C7FD
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F628180A
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0A37168;
	Mon, 11 Dec 2023 11:29:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C4B8;
	Mon, 11 Dec 2023 03:29:49 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpffY5cv3z4f3lVy;
	Mon, 11 Dec 2023 19:29:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A7C131A0713;
	Mon, 11 Dec 2023 19:29:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBX+0mk8nZlT0rRDQ--.30712S2;
	Mon, 11 Dec 2023 19:29:44 +0800 (CST)
Subject: Re: WARNING: kmalloc bug in bpf_uprobe_multi_link_attach
To: xingwei lee <xrivendell7@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <689db41e-90f5-c5ba-b690-00586f22d616@huaweicloud.com>
Date: Mon, 11 Dec 2023 19:29:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBX+0mk8nZlT0rRDQ--.30712S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1UWr13ur4DWFWkCFyDZFb_yoW7Gryrpr
	WrJF4YkrW8JryxJF17ta15trZxArZ8C3WDJwsrGFyFvF18WFyjqF4qqw1F9ry5JrWvyr13
	tF1DXr4jvr1UW3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE
	14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/11/2023 4:12 PM, xingwei lee wrote:
> Sorry for containing HTML part, repeat the mail
> Hello I found a bug in net/bpf in the lastest upstream linux and
> lastest net tree.
> WARNING: kmalloc bug in bpf_uprobe_multi_link_attach
>
> kernel: net 28a7cb045ab700de5554193a1642917602787784
> Kernel config: https://github.com/google/syzkaller/commits/fc59b78e3174009510ed15f20665e7ab2435ebee
>
> in the lastest net tree, the crash like:
>
> [   68.363836][ T8223] ------------[ cut here ]------------
> [   68.364967][ T8223] WARNING: CPU: 2 PID: 8223 at mm/util.c:632
> kvmalloc_node+0x18a/0x1a0
> [   68.366527][ T8223] Modules linked in:
> [   68.367882][ T8223] CPU: 2 PID: 8223 Comm: 36d Not tainted
> 6.7.0-rc4-00146-g28a7cb045ab7 #2
> [   68.369260][ T8223] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.16.2-1.fc38 04/014
> [   68.370811][ T8223] RIP: 0010:kvmalloc_node+0x18a/0x1a0
> [   68.371689][ T8223] Code: dc 1c 00 eb aa e8 86 33 c6 ff 41 81 e4 00
> 20 00 00 31 ff 44 89 e6 e8 e5 20
> [   68.375001][ T8223] RSP: 0018:ffffc9001088fb68 EFLAGS: 00010293
> [   68.375989][ T8223] RAX: 0000000000000000 RBX: 00000037ffffcec8
> RCX: ffffffff81c1a32b
> [   68.377154][ T8223] RDX: ffff88802cc00040 RSI: ffffffff81c1a339
> RDI: 0000000000000005
> [   68.377950][ T8223] RBP: 0000000000000400 R08: 0000000000000005
> R09: 0000000000000000
> [   68.378744][ T8223] R10: 0000000000000000 R11: 0000000000000000
> R12: 0000000000000000
> [   68.379523][ T8223] R13: 00000000ffffffff R14: ffff888017eb4a28
> R15: 0000000000000000
> [   68.380307][ T8223] FS:  0000000000827380(0000)
> GS:ffff8880b9900000(0000) knlGS:0000000000000000
> [   68.381185][ T8223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   68.381843][ T8223] CR2: 0000000020000140 CR3: 00000000204d2000
> CR4: 0000000000750ef0
> [   68.382624][ T8223] PKRU: 55555554
> [   68.382978][ T8223] Call Trace:
> [   68.383312][ T8223]  <TASK>
> [   68.383608][ T8223]  ? show_regs+0x8f/0xa0
> [   68.384052][ T8223]  ? __warn+0xe6/0x390
> [   68.384470][ T8223]  ? kvmalloc_node+0x18a/0x1a0
> [   68.385111][ T8223]  ? report_bug+0x3b9/0x580
> [   68.385585][ T8223]  ? handle_bug+0x67/0x90
> [   68.386032][ T8223]  ? exc_invalid_op+0x17/0x40
> [   68.386503][ T8223]  ? asm_exc_invalid_op+0x1a/0x20
> [   68.387065][ T8223]  ? kvmalloc_node+0x17b/0x1a0
> [   68.387551][ T8223]  ? kvmalloc_node+0x189/0x1a0
> [   68.388051][ T8223]  ? kvmalloc_node+0x18a/0x1a0
> [   68.388537][ T8223]  ? kvmalloc_node+0x189/0x1a0
> [   68.389038][ T8223]  bpf_uprobe_multi_link_attach+0x436/0xfb0

It seems a big attr->link_create.uprobe_multi.cnt is passed to
bpf_uprobe_multi_link_attach(). Could you please try the first patch in
the following patch set ?

https://lore.kernel.org/bpf/20231211112843.4147157-1-houtao@huaweicloud.com/T/#t
> [   68.389633][ T8223]  ? __might_fault+0x13f/0x1a0
> [   68.390129][ T8223]  ? bpf_kprobe_multi_link_attach+0x10/0x10

SNIP
>   res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x20000140ul, /*size=*/0x90ul);
>   if (res != -1) r[0] = res;
>   memcpy((void*)0x20000000, "./file0\000", 8);
>   syscall(__NR_creat, /*file=*/0x20000000ul, /*mode=*/0ul);
>   *(uint32_t*)0x20000340 = r[0];
>   *(uint32_t*)0x20000344 = 0;
>   *(uint32_t*)0x20000348 = 0x30;
>   *(uint32_t*)0x2000034c = 0;
>   *(uint64_t*)0x20000350 = 0x20000080;
>   memcpy((void*)0x20000080, "./file0\000", 8);

0x20000350 is the address of attr->link_create.uprobe_multi.path.
>   *(uint64_t*)0x20000358 = 0x200000c0;
>   *(uint64_t*)0x200000c0 = 0;
>   *(uint64_t*)0x20000360 = 0;
>   *(uint64_t*)0x20000368 = 0;
>   *(uint32_t*)0x20000370 = 0xffffff1f;

The value of attr->link_create.uprobe_multi.cnt is 0xffffff1f, so 
0xffffff1f * sizeof(bpf_uprobe) will be greater than INT_MAX, and
triggers the warning in mm/util.c:

        /* Don't even allow crazy sizes */
        if (unlikely(size > INT_MAX)) {
                WARN_ON_ONCE(!(flags & __GFP_NOWARN));
                return NULL;
        }

Adding __GFP_NOWARN when doing kvcalloc() can fix the warning.
>   *(uint32_t*)0x20000374 = 0;
>   *(uint32_t*)0x20000378 = 0;
>   syscall(__NR_bpf, /*cmd=*/0x1cul, /*arg=*/0x20000340ul, /*size=*/0x40ul);
>   return 0;
> }
>
> =* repro.txt =*
> r0 = bpf$PROG_LOAD(0x5, &(0x7f0000000140)={0x2, 0x3,
> &(0x7f0000000200)=@framed, &(0x7f0000000240)='GPL\x00', 0x0, 0x0, 0x0,
> 0x0, 0x0, '\x00', 0x0, 0x30, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> 0x0, 0x0, 0x0, 0x0, 0x0}, 0x90)
> creat(&(0x7f0000000000)='./file0\x00', 0x0)
> bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000340)={r0, 0x0, 0x30, 0x0,
> @val=@uprobe_multi={&(0x7f0000000080)='./file0\x00',
> &(0x7f00000000c0)=[0x0], 0x0, 0x0, 0xffffff1f}}, 0x40
>
>
> See aslo https://gist.github.com/xrivendell7/15d43946c73aa13247b4b20b68798aaa
>
> .


