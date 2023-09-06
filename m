Return-Path: <bpf+bounces-9335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02EF793E1B
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 15:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9237F2814C4
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37C10795;
	Wed,  6 Sep 2023 13:54:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A084417;
	Wed,  6 Sep 2023 13:54:22 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29EAD7;
	Wed,  6 Sep 2023 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fqok/3jKrEPgsVKbu43hosJItr8yKWGUpMwO247ox2s=; b=Y6cLwSx7LC3u8E7UwH4T3Y2Sd3
	As8QKrh6yeNlVhgCGxjmMBk+ceIXNodSGh7+jlbw79Sdb1NgWq8CyAnMhZM3Fey+VSKdc2H12mWJm
	lkbxN9H/1SVXYqxfBdG9jJpinKv+YBqdypfe9SZjnF4ztK90wiBV9AOFj3Zc7lyVDSGSnq0la440t
	A2IzHF19MXU0/sCUJOFnDLvyN/9fIq82obDY6sRoK9VpGRqt8jeG+Zcq0BWA0Hqhnc6r+er0HUndh
	gJ5jFoMXdtL9vkVlyV7oPcSegKmwroEJp8BAXvbWy9L21b99dM3hdXnEig4i8PqV1VsoluEG6TOsp
	SAar4snw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qdsz0-000PSX-CP; Wed, 06 Sep 2023 15:54:15 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qdsyz-0008Yt-VN; Wed, 06 Sep 2023 15:54:14 +0200
Subject: Re: [syzbot] [bpf?] general protection fault in
 bpf_prog_offload_verifier_prep
To: Eduard Zingerman <eddyz87@gmail.com>,
 syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev, horms@kernel.org
References: <000000000000d97f3c060479c4f8@google.com>
 <ef4b96a75ff8fa87a82a35d4d050338d0bd9cce1.camel@gmail.com>
 <f3eacce9566d14141cb591dc8364123b809841cb.camel@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e99cbc33-67f0-c766-7089-df7c120ac6e4@iogearbox.net>
Date: Wed, 6 Sep 2023 15:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f3eacce9566d14141cb591dc8364123b809841cb.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27023/Wed Sep  6 09:38:27 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[ Also adding Simon to Cc ]

On 9/6/23 3:50 PM, Eduard Zingerman wrote:
> On Wed, 2023-09-06 at 15:40 +0300, Eduard Zingerman wrote:
>> On Sun, 2023-09-03 at 12:55 -0700, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    fa09bc40b21a igb: disable virtualization features on 82580
>>> git tree:       net
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13382fa8680000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=291100dcb32190ec02a8
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529c448680000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15db0248680000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/7ab461d84992/disk-fa09bc40.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/3ac6d43ab2db/vmlinux-fa09bc40.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/778d096a134e/bzImage-fa09bc40.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
>>>
>>> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
>>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>>> CPU: 1 PID: 5055 Comm: syz-executor625 Not tainted 6.5.0-syzkaller-04012-gfa09bc40b21a #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
>>> RIP: 0010:bpf_prog_offload_verifier_prep+0xaa/0x170 kernel/bpf/offload.c:295
>>> Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a1 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
>>> RSP: 0018:ffffc900039ff7f8 EFLAGS: 00010246
>>> RAX: dffffc0000000000 RBX: ffffc9000156e000 RCX: 0000000000000000
>>> RDX: 0000000000000000 RSI: ffffffff81a8cf76 RDI: ffff888021b25f10
>>> RBP: ffff888021b25f00 R08: 0000000000000001 R09: fffffbfff195203d
>>> R10: ffffffff8ca901ef R11: 0000000000000000 R12: 0000000000000000
>>> R13: 0000000000000005 R14: 0000000000000003 R15: ffffc9000156e060
>>> FS:  0000555556071380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000020000100 CR3: 0000000022f6b000 CR4: 00000000003506e0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>   <TASK>
>>>   bpf_check+0x52f3/0xabd0 kernel/bpf/verifier.c:19762
>>>   bpf_prog_load+0x153a/0x2270 kernel/bpf/syscall.c:2708
>>>   __sys_bpf+0xbb6/0x4e90 kernel/bpf/syscall.c:5335
>>>   __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
>>>   __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
>>>   __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5437
>>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> RIP: 0033:0x7f7c0df78ea9
>>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007ffde3592128 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7c0df78ea9
>>> RDX: 0000000000000090 RSI: 0000000020000940 RDI: 0000000000000005
>>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000100000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>   </TASK>
>>> Modules linked in:
>>> ---[ end trace 0000000000000000 ]---
>>> RIP: 0010:bpf_prog_offload_verifier_prep+0xaa/0x170 kernel/bpf/offload.c:295
>>> Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a1 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
>>> RSP: 0018:ffffc900039ff7f8 EFLAGS: 00010246
>>> RAX: dffffc0000000000 RBX: ffffc9000156e000 RCX: 0000000000000000
>>> RDX: 0000000000000000 RSI: ffffffff81a8cf76 RDI: ffff888021b25f10
>>> RBP: ffff888021b25f00 R08: 0000000000000001 R09: fffffbfff195203d
>>> R10: ffffffff8ca901ef R11: 0000000000000000 R12: 0000000000000000
>>> R13: 0000000000000005 R14: 0000000000000003 R15: ffffc9000156e060
>>> FS:  0000555556071380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000020000100 CR3: 0000000022f6b000 CR4: 00000000003506e0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> ----------------
>>> Code disassembly (best guess), 3 bytes skipped:
>>>     0:	df 48 89             	fisttps -0x77(%rax)
>>>     3:	fa                   	cli
>>>     4:	48 c1 ea 03          	shr    $0x3,%rdx
>>>     8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>>>     c:	0f 85 a1 00 00 00    	jne    0xb3
>>>    12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>>>    19:	fc ff df
>>>    1c:	4c 8b 65 10          	mov    0x10(%rbp),%r12
>>>    20:	4c 89 e2             	mov    %r12,%rdx
>>>    23:	48 c1 ea 03          	shr    $0x3,%rdx
>>> * 27:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>>>    2b:	0f 85 93 00 00 00    	jne    0xc4
>>>    31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>>>    38:	fc ff df
>>>    3b:	4d                   	rex.WRB
>>>    3c:	8b                   	.byte 0x8b
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>
>>> If the bug is already fixed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want syzbot to run the reproducer, reply with:
>>> #syz test: git://repo/address.git branch-or-commit-hash
>>> If you attach or paste a git patch, syzbot will apply it before testing.
>>>
>>> If you want to overwrite bug's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the bug is a duplicate of another bug, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>>
>>
>> I have an explanation of why this error occurs, but I need an advice
>> on how to fix it.
> 
> I think the fix should look as follows:
> 
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 3e4f2ec1af06..302e38bffffa 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -199,12 +199,11 @@ static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *n
>          offload->netdev = netdev;
>   
>          ondev = bpf_offload_find_netdev(offload->netdev);
> +       if (bpf_prog_is_offloaded(prog->aux) && (!ondev || !ondev->offdev)) {
> +               err = -EINVAL;
> +               goto err_free;
> +       }
>          if (!ondev) {
> -               if (bpf_prog_is_offloaded(prog->aux)) {
> -                       err = -EINVAL;
> -                       goto err_free;
> -               }
> -
>                  /* When only binding to the device, explicitly
>                   * create an entry in the hashtable.
>                   */
> 
> With the following reasoning: for offloaded programs offload device
> should exist and it should not be a fake device create in !ondev branch.
> 
> Stanislav, could you please take a look? I think this is related to commit:
> 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
>   
>> Then NULL pointer deference occurs in the following function from offload.c:
>>
>>      int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
>>      {
>>          struct bpf_prog_offload *offload;
>>          int ret = -ENODEV;
>>      
>>          down_read(&bpf_devs_lock);
>>          offload = prog->aux->offload;
>>          if (offload) {
>>              ret = offload->offdev->ops->prepare(prog);
>>                             ^^^^^^
>>                             this pointer is NULL
>>              offload->dev_state = !ret;
>>          }
>>          up_read(&bpf_devs_lock);
>>      
>>          return ret;
>>      }
>>
>> # Short explanation
>>
>> (a) call chain bpf_prog_load -> bpf_prog_dev_bound_init -> __bpf_prog_dev_bound_init
>>                 -> __bpf_offload_dev_netdev_register
>>      might insert an instance of struct bpf_offload_netdev with {.offdev == NULL}
>>      into hash table offload.c:offdevs;
>> (b) call chain bpf_prog_load -> bpf_check -> bpf_prog_offload_verifier_prep
>>      assumes that from (prog->aux->offload != NULL)
>>                follows (prog->aux->offload->offdev != NULL)
>>      which is not the case because of (a).
>>
>> # Long explanation
>>
>> The reproducer generated by testbot has the following structure:
>> - in a loop call function execute_one(), which does the following
>>    system calls in sequence:
>>    - socket(AF_INET6, SOCK_RAW, IPPROTO_IGMP) = <some fd>
>>    - ioctl(3, SIOCGIFINDEX, {ifr_name="batadv_slave_1"}) = 0
>>    - bpf(BPF_PROG_LOAD,
>>          {prog_type=BPF_PROG_TYPE_XDP, ... prog_flags=0x40, prog_ifindex=29, ...}) = -1 EINVAL
>>      (referred to as program #1 below)
>>    - socket(AF_INET6, SOCK_RAW, IPPROTO_IGMP) = <some fd>
>>    - ioctl(4, SIOCGIFINDEX, {ifr_name="batadv_slave_1"}) = 0
>>    - bpf(BPF_PROG_LOAD,
>>          {prog_type=BPF_PROG_TYPE_XDP, ... prog_flags=0, ... prog_ifindex=29}) = -1 EINVAL
>>      (referred to as program #2 below)
>>
>> The error occurs when second bpf call is processed.
>> Interestingly, if sleep(1) is inserted somewhere between first and
>> second bpf calls error does not occur:
>>
>>      @@ -1246,6 +1246,7 @@ void execute_one(void)
>>         *(uint32_t*)0x200009cc = 4;
>>         syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x20000940ul, /*size=*/0x90ul);
>>         res = syscall(__NR_socket, /*domain=*/0xaul, /*type=*/3ul, /*proto=*/2);
>>      +  // sleep(1); /* uncomment to hide the error */
>>         if (res != -1)
>>           r[2] = res;
>>         memcpy((void*)0x20000100, "batadv_slave_1\000\000", 16);
>>
>> ## Control flow when error occurs
>>
>> For program #1:
>> - bpf_prog_load():
>>    - bpf_prog_is_dev_bound(prog->aux) is true
>>      - bpf_prog_dev_bound_init
>>        - prog->aux->offload_requested is 0 (because of 0x40 prog_flags)
>>        - __bpf_prog_dev_bound_init
>>          - netdev is "batadv_slave_1"
>>          - bpf_offload_find_netdev(offload->netdev) == NULL,
>>            (this is a lookup in hash table offload.c:offdevs)
>>            which triggers a call to __bpf_offload_dev_netdev_register
>>            - __bpf_offload_dev_netdev_register(NULL, offload->netdev)
>>              registers struct bpf_offload_netdev with {.offdev = NULL}
>>              for netdev "batadv_slave_1" in offload.c:offdevs hash table.
>>
>> For program #2:
>> - bpf_prog_load():
>>    - bpf_prog_is_dev_bound(prog->aux) is true
>>      - bpf_prog_dev_bound_init
>>        - prog->aux->offload_requested is 1 (because of 0x0 prog_flags)
>>        - __bpf_prog_dev_bound_init
>>          - netdev is "batadv_slave_1"
>>          - bpf_offload_find_netdev(offload->netdev) != NULL,
>>            this is struct bpf_offload_netdev with {.offdev = NULL}
>>            created for program #1
>>          - prog->aux->offload = struct bpf_prog_offload {.offload -> {.offdev = NULL}},
>>            The bpf_prog_offload remembered for prog points to bpf_offload_netdev
>>            with .offdev == NULL.
>>    - ...
>>    - bpf_check
>>      - bpf_prog_offload_verifier_prep
>>        - prog->aux->offload != NULL, but prog->aux->offload->offdev == NULL
>>          => null pointer deference.
>>
>> ## Control flow when error does not occur
>>
>> For program #1:
>> - ... all as in the previous case ...
>>
>> Some worker thread:
>> - kernel/bpf/core.c:bpf_prog_free_deferred, registered for program #1:
>>    - bpf_prog_is_dev_bound(aux) is true
>>    - bpf_prog_dev_bound_destroy
>>      - netdev is "batadv_slave_1"
>>      - (!ondev->offdev && list_empty(&ondev->progs)) is true
>>        - __bpf_offload_dev_netdev_unregister
>>          this removes struct bpf_offload_netdev with {.offdev = NULL}
>>          from offload.c:offdevs hash table.
>>
>> For program #2:
>> - bpf_prog_load():
>>    - bpf_prog_is_dev_bound(prog->aux) is true
>>      - bpf_prog_dev_bound_init
>>        - prog->aux->offload_requested is 1 (because of 0x0 prog_flags)
>>        - __bpf_prog_dev_bound_init
>>          - netdev is "batadv_slave_1"
>>          - bpf_offload_find_netdev(offload->netdev) == NULL
>>          - bpf_prog_is_offloaded(prog->aux) is true
>>          - -EINVAL is returned.

