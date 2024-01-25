Return-Path: <bpf+bounces-20339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4850083CA89
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 19:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CAF2969ED
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9CE133997;
	Thu, 25 Jan 2024 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGU/dTIa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FCF130E52;
	Thu, 25 Jan 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205958; cv=none; b=sAbTl4srfRGDDD9n8QZxHxq1cKP8y3U1U+ZRNFlJpLsla+naV0/hDPOxN8ndMDbHnDVregUn3JpIXaIrXOLXtk70YBKY/fIjKVRFn4mu3nm1L6hvY2IkHDhBfOqMcMsrumPfAFxpIRbC804toOV/OCNRJXBRkXN3S7Sg0Z0bnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205958; c=relaxed/simple;
	bh=ApOCe1jf2XuQIgtYNy/gdNK9pc+iETIat//GJzItDng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJNAiP2q+TXjquTtr3GGRW4+2uFeOKm1YSvkObimxs6Ys5wxGO/XP2tOYkrFiXAyvsb06xlnsjmeCXZupWbejxUcYYPNBwVP9AeSFFf5Gt5pD8DitsyQGUaaLV4144DCdFFAEYGaBn17h6wKArc6jYbXlxZ1W7/DchRctHVLk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGU/dTIa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f0629e67f4so74027547b3.3;
        Thu, 25 Jan 2024 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706205956; x=1706810756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mpe4gom6m8Lte0CROkurnB5K2+Lam3sS1FZ2M/1843M=;
        b=VGU/dTIaVsj5KXmIQbz6R7JcKflj8al2kFM8Ex0WM/GxX+P0r8rCuQ+MUC5SBJ4UBW
         GE0XRQX6hwJlgG72j3ZszgyCIZroCaAqVjo3ufItX/ligo5dD8FLY0UVr5f94v/8TAst
         7PLT3uMoBubs3HpegsWC4cRkQGGWEXtaSHUZdFbT9e2ll3ElMhmMBRpnABQXUjMCutsD
         h9Fj2bLmNZjgJ6c4u+7Xn2aNfYtgNkiMoC7ujxsm9lI1wSdgOWl9AsguVdOA4KKgX5Ad
         QY5dHiwrnygO/ObDkP61borw8S/GKnvnRtH/RhTCwlM9YDLtB/aeTYxT2X0c/zAjJD5Z
         ZZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205956; x=1706810756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mpe4gom6m8Lte0CROkurnB5K2+Lam3sS1FZ2M/1843M=;
        b=w7rKRXs81zym0vBCeamq2tSA3LxTdcBHvwjDHlMJY311Ig7qEeRewbBqbBobO/YWk0
         zx5APKSw9usEBW6Vm37DNtjFZuoGhSCOOe2DqFJzLn+VNcVRyhA5viGRNOby3V9fc16c
         m2jLtrNCXoAWxeLJFLO/58TIaLPY2A9r+w5i6NVPSwSXW7Uyd2WLDCHFgXcwEKcPMlyZ
         uJTwwvxUnVr2nit39AJcsEaEpDey5plrcdkMb+L56LuYxqNuwucpS8OJyAVTgzE0R67T
         x4KWhBpb+DMmYUKqff9S77zmCBdUzKJXFf4LFmmv16Un1H4dUjPxNL28/rllXW0ZvPmF
         4hqQ==
X-Gm-Message-State: AOJu0YyeaJW99Dg8gnNayyx53927VM0vYym/JFvzefQUhL0XRoWukD/p
	W7zAU/Rn3LwSs5yeb0kwytegMXmyU6sxazkLKQJ0jRg+qbGyljzo
X-Google-Smtp-Source: AGHT+IE+O7Cvhgyx71dY11ZWCnN2Hz414GCToTRHXEMVb3icMz4scLz8xII78oqSp7cQEfE25uB/bg==
X-Received: by 2002:a05:690c:f05:b0:5ff:88d2:631e with SMTP id dc5-20020a05690c0f0500b005ff88d2631emr266394ywb.90.1706205955662;
        Thu, 25 Jan 2024 10:05:55 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:5100:fbae:e50d:52c9? ([2600:1700:6cf8:1240:5100:fbae:e50d:52c9])
        by smtp.gmail.com with ESMTPSA id ey1-20020a05690c300100b00600352c4fa0sm806906ywb.31.2024.01.25.10.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 10:05:55 -0800 (PST)
Message-ID: <8a090e68-d0e8-482f-ba87-a0a91ea59d32@gmail.com>
Date: Thu, 25 Jan 2024 10:05:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] general protection fault in btf_is_module
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: syzbot <syzbot+1336f3d4b10bcda75b89@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <00000000000026353b060fc21c07@google.com>
 <d6de99ca-64ca-4b21-958d-686efcd3acd8@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <d6de99ca-64ca-4b21-958d-686efcd3acd8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/25/24 10:02, Martin KaFai Lau wrote:
> On 1/25/24 1:50 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    d47b9f68d289 libbpf: Correct bpf_core_read.h comment 
>> wrt b..
>> git tree:       bpf-next
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=104b1ef7e80000
>> kernel config:  
>> https://syzkaller.appspot.com/x/.config?x=719e6acaf392d56b
>> dashboard link: 
>> https://syzkaller.appspot.com/bug?extid=1336f3d4b10bcda75b89
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils 
>> for Debian) 2.40
>> syz repro:      
>> https://syzkaller.appspot.com/x/repro.syz?x=10c1a53be80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1052cec3e80000
>>
>> Downloadable assets:
>> disk image: 
>> https://storage.googleapis.com/syzbot-assets/1a9b4a5622fb/disk-d47b9f68.raw.xz
>> vmlinux: 
>> https://storage.googleapis.com/syzbot-assets/dd68baeac4fd/vmlinux-d47b9f68.xz
>> kernel image: 
>> https://storage.googleapis.com/syzbot-assets/811ba9dc9ddf/bzImage-d47b9f68.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the 
>> commit:
>> Reported-by: syzbot+1336f3d4b10bcda75b89@syzkaller.appspotmail.com
>>
>> general protection fault, probably for non-canonical address 
>> 0xdffffc000000001b: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
>> CPU: 0 PID: 5064 Comm: syz-executor334 Not tainted 
>> 6.7.0-syzkaller-12348-gd47b9f68d289 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, 
>> BIOS Google 11/17/2023
>> RIP: 0010:btf_is_module+0x26/0x80 kernel/bpf/btf.c:7441
>> Code: 00 eb f0 90 66 0f 1f 00 55 53 48 89 fb e8 92 24 de ff 48 8d bb 
>> d8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 
>> 04 02 84 c0 74 02 7e 48 0f b6 ab d8 00 00 00 31 ff 89 ee e8
>> RSP: 0018:ffffc900039ff828 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81a07f47
>> RDX: 000000000000001b RSI: ffffffff81a9fcfe RDI: 00000000000000d8
>> RBP: ffffc900039ffaf0 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000004 R11: ffffffff8aa0008b R12: ffffc90000ae6038
>> R13: ffffc90000ae6000 R14: 0000000000000000 R15: 0000000000000000
>> FS:  000055555660b380(0000) GS:ffff8880b9800000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000001b6b398 CR3: 000000001aaae000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   check_struct_ops_btf_id kernel/bpf/verifier.c:20302 [inline]
> 
> Kui-Feng, it should be due to the commit e3f87fdfed7b ("bpf: hold module 
> refcnt in bpf_struct_ops map creation and prog verification."). I think 
> it needs a NULL check on the return value from bpf_get_btf_vmlinux().
> 
> Please take a look. Thanks.

Sure!

> 
> 
>>   check_attach_btf_id kernel/bpf/verifier.c:20730 [inline]
>>   bpf_check+0x6cfe/0x9df0 kernel/bpf/verifier.c:20898
>>   bpf_prog_load+0x14dc/0x2310 kernel/bpf/syscall.c:2769
>>   __sys_bpf+0xbf7/0x4a00 kernel/bpf/syscall.c:5463
>>   __do_sys_bpf kernel/bpf/syscall.c:5567 [inline]
>>   __se_sys_bpf kernel/bpf/syscall.c:5565 [inline]
>>   __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5565
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> RIP: 0033:0x7f4dbbe514a9
>> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 
>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 
>> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffe76acbe18 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>> RAX: ffffffffffffffda RBX: 00007ffe76acbff8 RCX: 00007f4dbbe514a9
>> RDX: 00000000000000a0 RSI: 00000000200009c0 RDI: 0000000000000005
>> RBP: 00007f4dbbec4610 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>> R13: 00007ffe76acbfe8 R14: 0000000000000001 R15: 0000000000000001
>>   </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:btf_is_module+0x26/0x80 kernel/bpf/btf.c:7441
>> Code: 00 eb f0 90 66 0f 1f 00 55 53 48 89 fb e8 92 24 de ff 48 8d bb 
>> d8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 
>> 04 02 84 c0 74 02 7e 48 0f b6 ab d8 00 00 00 31 ff 89 ee e8
>> RSP: 0018:ffffc900039ff828 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81a07f47
>> RDX: 000000000000001b RSI: ffffffff81a9fcfe RDI: 00000000000000d8
>> RBP: ffffc900039ffaf0 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000004 R11: ffffffff8aa0008b R12: ffffc90000ae6038
>> R13: ffffc90000ae6000 R14: 0000000000000000 R15: 0000000000000000
>> FS:  000055555660b380(0000) GS:ffff8880b9800000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000001b6b398 CR3: 000000001aaae000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess):
>>     0:    00 eb                    add    %ch,%bl
>>     2:    f0 90                    lock nop
>>     4:    66 0f 1f 00              nopw   (%rax)
>>     8:    55                       push   %rbp
>>     9:    53                       push   %rbx
>>     a:    48 89 fb                 mov    %rdi,%rbx
>>     d:    e8 92 24 de ff           call   0xffde24a4
>>    12:    48 8d bb d8 00 00 00     lea    0xd8(%rbx),%rdi
>>    19:    48 b8 00 00 00 00 00     movabs $0xdffffc0000000000,%rax
>>    20:    fc ff df
>>    23:    48 89 fa                 mov    %rdi,%rdx
>>    26:    48 c1 ea 03              shr    $0x3,%rdx
>> * 2a:    0f b6 04 02              movzbl (%rdx,%rax,1),%eax <-- 
>> trapping instruction
>>    2e:    84 c0                    test   %al,%al
>>    30:    74 02                    je     0x34
>>    32:    7e 48                    jle    0x7c
>>    34:    0f b6 ab d8 00 00 00     movzbl 0xd8(%rbx),%ebp
>>    3b:    31 ff                    xor    %edi,%edi
>>    3d:    89 ee                    mov    %ebp,%esi
>>    3f:    e8                       .byte 0xe8
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
> 
> 

