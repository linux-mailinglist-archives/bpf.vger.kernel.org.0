Return-Path: <bpf+bounces-8931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBF378CC19
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CB528122F
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED7818019;
	Tue, 29 Aug 2023 18:30:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9C18035
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:30:16 +0000 (UTC)
Received: from out-244.mta0.migadu.com (out-244.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED45FCC9
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 11:30:05 -0700 (PDT)
Message-ID: <2e260b7c-2a89-2d0c-afb5-708c34230db2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693333802; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9qhS9JnvDdEoGnT4EeYHMwTRSvFUoem4eApRVql4dg=;
	b=KvMhiKrMJ6fsV4goHvB6nER+PmVpg5unIoRCmrDH4ZmWWXrBjkIpdDB65S4iFAYEtizr4Z
	RA17fWrCt12qth1jWM2Kh66m/RxGUmAfndvPWH4dCAIyo27MqFcJ5hZP5+RvHDeoDlcBQF
	K00WKUc1/1seLt1xEoDhDPpRM6IE7e0=
Date: Tue, 29 Aug 2023 14:29:56 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in bpf_percpu_array_update /
 bpf_percpu_array_update (2)
To: syzbot <syzbot+97522333291430dd277f@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yhs@fb.com
References: <000000000000d87a7f06040c970c@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <000000000000d87a7f06040c970c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/29/23 5:39 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136f39dfa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dea9c2ce3f646a25
> dashboard link: https://syzkaller.appspot.com/bug?extid=97522333291430dd277f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9923a023ab11/disk-727dbda1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/650dbc695d77/vmlinux-727dbda1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/361da71276bf/bzImage-727dbda1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update
> 
> write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
>   bpf_long_memcpy include/linux/bpf.h:428 [inline]
>   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>   copy_map_value_long include/linux/bpf.h:464 [inline]
>   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>   __sys_bpf+0x28a/0x780
>   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
>   bpf_long_memcpy include/linux/bpf.h:428 [inline]
>   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>   copy_map_value_long include/linux/bpf.h:464 [inline]
>   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>   __sys_bpf+0x28a/0x780
>   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x0000000000000000 -> 0xfffffff000002788
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 8268 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> ==================================================================

This case is with two tasks doing bpf_map batch update together for the
same map and key.
   > write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
   > write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:

So concurrency is introduced by user applications.
In my opinion, this probably not an issue from kernel perspective.

> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

