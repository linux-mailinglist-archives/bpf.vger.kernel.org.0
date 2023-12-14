Return-Path: <bpf+bounces-17794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1CD812835
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A78D1F21AF3
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36D1D285;
	Thu, 14 Dec 2023 06:33:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F142B9
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 22:33:46 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SrMxX05MBz4f3lVh
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 14:33:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 06A1F1A0910
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 14:33:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAnPLq+oXplDogwDg--.58522S2;
	Thu, 14 Dec 2023 14:33:37 +0800 (CST)
Subject: Re: [Syzkaller & bisect] There is KASAN: global-out-of-bounds Read in
 bpf_link_show_fdinfo in v6.7-rc5
To: Pengfei Xu <pengfei.xu@intel.com>, jolsa@kernel.org
Cc: bpf@vger.kernel.org, heng.su@intel.com, andrii@kernel.org,
 laoar.shao@gmail.com, yonghong.song@linux.dev, ast@kernel.org, lkp@intel.com
References: <ZXptoKRSLspnk2ie@xpf.sh.intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <09058391-0016-77b5-a44e-fffad18b52cb@huaweicloud.com>
Date: Thu, 14 Dec 2023 14:33:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZXptoKRSLspnk2ie@xpf.sh.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAnPLq+oXplDogwDg--.58522S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGw13Wr4kWw17ZF1UZr18Zrb_yoWDCw45pF
	1kGFWxKr48ZryUJr18Ja15Wr15Kw4UZa4UXw1fJr48Zw48uFs8Ary8J34UJFnFg3WkArsr
	Jw1DZw4rtr1UJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/14/2023 10:51 AM, Pengfei Xu wrote:
> Hi Jiri Olsa,
>
> Greeting!
>
> There is KASAN: global-out-of-bounds Read in bpf_link_show_fdinfo in v6.7-rc5
> kernel in vm.

It seems that the out-of-bound access is due to
BPF_LINK_TYPE_UPROBE_MULTI and other link types don't define
BPF_LINK_TYPE(type, name) in linux/bpf_types.h, so the content and the
length of bpf_link_type_strs array is unexpected. But I will leave the
fixes to Jiri and I have to continue on the fix of the warning during
bpf ma initialization.
>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/231213_090512_bpf_link_show_fdinfo
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/repro.c
> Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/repro.prog
> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/bisect_info.log
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/a39b6ac3781d46ba18193c9dbb2110f31e9bffe9_dmesg.log
> bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/231213_090512_bpf_link_show_fdinfo/bzImage_a39b6ac3781d46ba18193c9dbb2110f31e9bffe9.tar.gz
>
> Bisected and related commit is as follows:
> "
> 0b779b61f651 bpf: Add cookies support for uprobe_multi link
> "
> Make the revert the commit on top of v6.7-rc5 kernel failed, could not double
> confirm for the suspected commit.
>
>
> [   20.624445] repro[731]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
> [   20.625349] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.631427] repro[734]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> [   20.632325] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.665797] repro[737]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
> [   20.666718] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.671614] ==================================================================
> [   20.672115] BUG: KASAN: global-out-of-bounds in bpf_link_show_fdinfo+0x30b/0x330
> [   20.672598] Read of size 8 at addr ffffffff8593c9e0 by task systemd-coredum/732
> [   20.673066] 
> [   20.673179] CPU: 0 PID: 732 Comm: systemd-coredum Not tainted 6.7.0-rc5-a39b6ac3781d+ #1
> [   20.673687] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   20.674381] Call Trace:
> [   20.674552]  <TASK>
> [   20.674701]  dump_stack_lvl+0xaa/0x110
> [   20.674964]  print_report+0xcf/0x620
> [   20.675209]  ? bpf_link_show_fdinfo+0x30b/0x330
> [   20.675514]  ? kasan_addr_to_slab+0x11/0xb0
> [   20.675794]  ? bpf_link_show_fdinfo+0x30b/0x330
> [   20.676103]  kasan_report+0xcd/0x110
> [   20.676342]  ? bpf_link_show_fdinfo+0x30b/0x330
> [   20.676651]  __asan_report_load8_noabort+0x18/0x20
> [   20.676960]  bpf_link_show_fdinfo+0x30b/0x330
> [   20.677253]  ? __pfx_bpf_link_show_fdinfo+0x10/0x10
> [   20.677569]  ? locks_remove_file+0x6d0/0x790
> [   20.677861]  ? __pfx_bpf_link_show_fdinfo+0x10/0x10
> [   20.678169]  seq_show+0x581/0x890
> [   20.678402]  seq_read_iter+0x51a/0x1300
> [   20.678672]  ? iov_iter_init+0x55/0x200
> [   20.678939]  seq_read+0x171/0x210
> [   20.679172]  ? __pfx_seq_read+0x10/0x10
> [   20.679438]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   20.679784]  ? fsnotify_perm.part.0+0x260/0x5f0
> [   20.680087]  ? security_file_permission+0xc5/0xf0
> [   20.680399]  vfs_read+0x202/0x930
> [   20.680626]  ? __pfx_seq_read+0x10/0x10
> [   20.680884]  ? __pfx_vfs_read+0x10/0x10
> [   20.681137]  ? __pfx_lock_release+0x10/0x10
> [   20.681398]  ? ktime_get_coarse_real_ts64+0x4d/0xf0
> [   20.681706]  ? __this_cpu_preempt_check+0x21/0x30
> [   20.681997]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [   20.682379]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   20.682722]  ksys_read+0x14f/0x290
> [   20.682956]  ? __pfx_ksys_read+0x10/0x10
> [   20.683226]  __x64_sys_read+0x7b/0xc0
> [   20.683473]  ? syscall_enter_from_user_mode+0x53/0x70
> [   20.683790]  do_syscall_64+0x42/0xf0
> [   20.684027]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   20.684327] RIP: 0033:0x7f688893eaf2
> [   20.684556] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ca 0c 08 00 e8 35 eb 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> [   20.685647] RSP: 002b:00007ffde2a29e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   20.686108] RAX: ffffffffffffffda RBX: 0000562b794752d0 RCX: 00007f688893eaf2
> [   20.686527] RDX: 0000000000000400 RSI: 0000562b79475530 RDI: 0000000000000006
> [   20.686964] RBP: 00007f68889f75e0 R08: 0000000000000006 R09: 00007f68889b14e0
> [   20.687401] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f688863c9c8
> [   20.687837] R13: 0000000000000d68 R14: 00007f68889f69e0 R15: 0000000000000d68
> [   20.688309]  </TASK>
> [   20.688465] 
> [   20.688571] The buggy address belongs to the variable:
> [   20.688885]  bpf_link_type_strs+0x60/0x80
> [   20.689145] 
> [   20.689251] The buggy address belongs to the physical page:
> [   20.689611] page:00000000449bb84f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x593c
> [   20.690184] flags: 0xfffffc0004000(reserved|node=0|zone=1|lastcpupid=0x1fffff)
> [   20.690601] page_type: 0xffffffff()
> [   20.690824] raw: 000fffffc0004000 ffffea0000164f08 ffffea0000164f08 0000000000000000
> [   20.691307] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [   20.691795] page dumped because: kasan: bad access detected
> [   20.692152] 
> [   20.692254] Memory state around the buggy address:
> [   20.692552]  ffffffff8593c880: 04 f9 f9 f9 f9 f9 f9 f9 05 f9 f9 f9 f9 f9 f9 f9
> [   20.693008]  ffffffff8593c900: 00 05 f9 f9 f9 f9 f9 f9 00 03 f9 f9 f9 f9 f9 f9
> [   20.693432] >ffffffff8593c980: 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
> [   20.693877]                                                        ^
> [   20.694265]  ffffffff8593ca00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   20.694707]  ffffffff8593ca80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   20.695158] ==================================================================
> [   20.695666] Disabling lock debugging due to kernel taint
> [   20.720062] repro[741]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
> [   20.720827] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.724913] repro[744]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> [   20.725791] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.732282] repro[747]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> [   20.733148] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.770165] repro[750]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> [   20.771018] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.820152] repro[757]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> [   20.820984] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.837880] repro[760]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> [   20.838815] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   20.839423] repro[755]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
> [   20.840255] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   21.068187] Pid 786(repro) over core_pipe_limit
> [   21.068503] Skipping core dump
>
> I hope it's helpful.
>
> ---
>
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
>
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
> Best Regards,
> Thanks!
>
> .


