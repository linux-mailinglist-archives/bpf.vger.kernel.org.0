Return-Path: <bpf+bounces-71840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3290BFDE69
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE4EF358E64
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120A34FF55;
	Wed, 22 Oct 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQZ+o5oS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970BC34E761
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158478; cv=none; b=umspDpvmMph7IRdXQGX8aJ/OHHI3lVJboVX98vKZald/kFvMIrM79Frc4jamWoyF1ek4qzsSR3lAZMcDON1Nyu9UW84UK+h+xXqhQOH28ALhYImQdUYLDlfww9GXkqaEF39qoT1ijCTH2qsS20vVUOhEk4MKqWFBXcSClnpdwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158478; c=relaxed/simple;
	bh=Srdz0YdwKP8fBJdp00SvYH14YKC7endGqxbblYxmxmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqJWWmchQxNgilpln/VezPaEw6e5mQW8QvDF3hq7eTmXDPRZwFYCR//sCUfslMWQG1DLVJewjy1h/E7SRxTmEP1T8Mr5Ad2YP/IinpHh58Eu4vWgw+a2jOrkz7bp0qyUbKfa5cVTvjWQtBUjTni2w94x2PkFlyPyjmfXiYKsF70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQZ+o5oS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290d4d421f6so58165665ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761158475; x=1761763275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MwSSsIMdPEv7A4eQ3QmSWhovEg7spF/mgUkKOL7vAOA=;
        b=WQZ+o5oScuY8GhK9TUDT+8rodUBgEbEDs1/ItuAbO1infVuX7KrbQedR7KH/BtGAkT
         2R/vvIIlAGIj4DW9+vD0YIC+NLAItoBnsurvN3W4kTeMfjQe3TRKNSVkQTc/WXBMlGC2
         DHH4HxAgmPLhltBL4NR3Ox6SybFeYNsZHrijZXvqTOnyMiyGUyd99p2JnA3U0WkV5MG4
         qqMqSnTfSefIpNDOL3H+JS41rM/6e2GuhtwZvvsgNZOR1f5ZcdhPv/xHOcOEc2Mu9m1+
         V2bxWmZ9fcAtKOQ8+lxsRWz0KLiEtu+cvZSETaTgU+3iGDQDxhJqM62QJPYfKHuLoaai
         zZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158475; x=1761763275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwSSsIMdPEv7A4eQ3QmSWhovEg7spF/mgUkKOL7vAOA=;
        b=Uu6Kaw+L1GcUhMx4ReuirXBL1h0LOdaQEYsOkg1QyEZAQZYEQertcwoRPb/X3feSC/
         0mcR+PYqCS0jbJaqvszNyQpnQhXGXtwV6IkQPj9dR7ahGvlwpl5jmSX9nPHVegnALkMq
         bApmvcXftIku7PlXB1dVq0GIBXugAQHlHp7FIzf9dDjpMhqGZok+eymtudgyGVBVS8+m
         aRf9rLqT+mgfS1lxjgbVWERp7WsU2bBkLgJ0CLR7BbKxf10JlZg8m8eSWuVPDON6D7H9
         nCS3QYIsfRamZSbAd54CWXcA6I/DQR0SI1MxxkvMvyg5rKRIDTZhAqAv8Qpq8aOdhZu0
         /wqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUboP1fmOt7vuAWL/+mhwGYwQAag4pcY2dfgInmbGWLlS5j0lXK+1cEcsjywYfWMnuKfP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFASLeMuCJ/a0kOb7cYYLBQ2W0oIk7UgY5q7YGxMM8+UOnKpn
	rZA7N1zdk3yhzEG7UmwqwwK856k4/ncXMUsTzuI9CDXS476Y65Bmf1Xd
X-Gm-Gg: ASbGncvPH5cQnjDjMsDSmtHCVuGC1nw+x4E86DWPYAf5hCOjTW1WxToUclAPAESnrfe
	gdLqARzqGmZAwe2KXSAZKTIXorWwIdla4IeK0eH3TZcY0IvxM3be823dNeNrqdUn5Fnt7v5yQFr
	3UaYUvuyWkL1AklGJlAubF14+ahSy6duvzNV2YRX1jVtPWQbqrscGiglf7FTdz3DTmQBt27zpR1
	XbZj1DOBkVbQ0J0PuMJffrvzj0Tg7GB1z3zDDflIGlIYzZxeyVucObwFXMskv4F+1cKkRjV3S3i
	GVmatXdBj3KxGj8p4lBO8xOhkdC0rw+qnGLcE3G6Ri6zc1UK4pMlGGruk+G+uElvCCQSgrW0HYZ
	Epxd4H8RifPYb+zWoX8PL29ddLgvK9vwMbY+pUoJGBw0MdRvCteQL+OuQt6FjQLvxBNzFUi3RX0
	zPRWl+fDZPV9Xv8vY=
X-Google-Smtp-Source: AGHT+IHzrkR8kQC2JkBfpPS5AblvPCgWlm5WoPllvAcMI7Ncjl9ri4KHEv/uC8RZ1oR6PgS00gPyww==
X-Received: by 2002:a17:902:e944:b0:290:a3b9:d4c6 with SMTP id d9443c01a7336-290caf831b6mr285229685ad.36.1761158474775;
        Wed, 22 Oct 2025 11:41:14 -0700 (PDT)
Received: from chandna.localdomain ([106.222.229.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm145578975ad.7.2025.10.22.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:41:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:10:59 +0530
From: Sahil Chandna <chandna.sahil@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, listout@listout.xyz,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Message-ID: <aPklOxw0W-xUbMEI@chandna.localdomain>
References: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
 <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>

On Wed, Oct 22, 2025 at 09:57:22AM -0700, Yonghong Song wrote:
>
>
>On 10/20/25 2:08 PM, syzbot wrote:
>>Hello,
>>
>>syzbot found the following issue on:
>>
>>HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 'off' as d..
>>git tree:       bpf
>>console output: https://syzkaller.appspot.com/x/log.txt?x=12d21de2580000
>>kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
>>dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
>>compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160cf542580000
>>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128d5c58580000
>>
>>Downloadable assets:
>>disk image: https://storage.googleapis.com/syzbot-assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
>>vmlinux: https://storage.googleapis.com/syzbot-assets/873984cfc71e/vmlinux-a1e83d4c.xz
>>kernel image: https://storage.googleapis.com/syzbot-assets/16711d84070c/bzImage-a1e83d4c.xz
>>
>>The issue was bisected to:
>>
>>commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
>>Author: Sahil Chandna <chandna.sahil@gmail.com>
>>Date:   Tue Oct 14 18:56:35 2025 +0000
>>
>>     bpf: Do not disable preemption in bpf_test_run().
>>
>>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172fe492580000
>>final oops:     https://syzkaller.appspot.com/x/report.txt?x=14afe492580000
>>console output: https://syzkaller.appspot.com/x/log.txt?x=10afe492580000
>>
>>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
>>Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in bpf_test_run().")
>>
>>------------[ cut here ]------------
>>WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>
>Okay, the warning is due to the following WARN_ON_ONCE:
>
>static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
>static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>
>int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>{
>        int nest_level;
>
>        nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>        if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>                this_cpu_dec(bpf_bprintf_nest_level);
>                return -EBUSY;
>        }
>        *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>
>        return 0;
>}
>
>Basically without preempt disable, at process level, it is possible
>more than one process may trying to take bpf_bprintf_buffers.
>Adding softirq and nmi, it is totally likely to have more than 3
>level for buffers. Also, more than one process with bpf_bprintf_buffers
>will cause problem in releasing buffers, so we need to have
>preempt_disable surrounding bpf_try_get_buffers() and
>bpf_put_buffers().
Right, but using preempt_disable() may impact builds with
CONFIG_PREEMPT_RT=y, similar to bug[1]? Do you think local_lock() could be used here
as nest level is per cpu variable and local lock semantics can work
for both RT and non rt builds ?
>
>There are some kfuncs/helpers need such preempt_disable
>protection, e.g. bpf_stream_printk, bpf_snprintf,
>bpf_trace_printk, bpf_trace_vprintk, bpf_seq_printf.
>But please double check.
>
Sure, thanks!
>
[1] https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
>>Modules linked in:
>>CPU: 1 UID: 0 PID: 6145 Comm: syz.4.53 Not tainted syzkaller #0 PREEMPT(full)
>>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
>>RIP: 0010:bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>RIP: 0010:bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>>Code: ff e9 ce fe ff ff e8 10 ec e0 ff e9 be fe ff ff e8 06 ec e0 ff e9 b4 fe ff ff e8 fc eb e0 ff e9 aa fe ff ff e8 f2 eb e0 ff 90 <0f> 0b 90 65 ff 0d 27 fd b2 10 b8 f0 ff ff ff e9 17 ff ff ff e8 d8
>>RSP: 0018:ffffc90003797840 EFLAGS: 00010293
>>RAX: ffffffff81df57fe RBX: ffffc90003797a10 RCX: ffff888026493c80
>>RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
>>RBP: ffffc90003797970 R08: 0000000000585870 R09: 0000000000000005
>>R10: dffffc0000000000 R11: fffff520006f2f20 R12: dffffc0000000000
>>R13: 0000000000000004 R14: 0000000000000003 R15: 1ffff920006f2f42
>>FS:  00005555805f5500(0000) GS:ffff888125e0c000(0000) knlGS:0000000000000000
>>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>CR2: 0000000000000000 CR3: 000000007c04e000 CR4: 00000000003526f0
>>Call Trace:
>>  <TASK>
>>  ____bpf_trace_printk kernel/trace/bpf_trace.c:372 [inline]
>>  bpf_trace_printk+0xdb/0x190 kernel/trace/bpf_trace.c:362
>>  bpf_prog_bfbd7bf4bf171090+0x41/0x5a
>>  bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
>>  __bpf_prog_run include/linux/filter.h:721 [inline]
>>  bpf_prog_run include/linux/filter.h:728 [inline]
>>  bpf_prog_run_pin_on_cpu include/linux/filter.h:745 [inline]
>>  bpf_flow_dissect+0x225/0x720 net/core/flow_dissector.c:1024
>>  bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1414
>>  bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4688
>>  __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6167
>>  __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
>>  __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
>>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6257
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>RIP: 0033:0x7f25b0f8efc9
>>Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>RSP: 002b:00007ffe036cd5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>>RAX: ffffffffffffffda RBX: 00007f25b11e5fa0 RCX: 00007f25b0f8efc9
>>RDX: 0000000000000050 RSI: 0000200000000180 RDI: 000000000000000a
>>RBP: 00007f25b1011f91 R08: 0000000000000000 R09: 0000000000000000
>>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>R13: 00007f25b11e5fa0 R14: 00007f25b11e5fa0 R15: 0000000000000003
>>  </TASK>
>>
>>
>>---
>>This report is generated by a bot. It may contain errors.
>>See https://goo.gl/tpsmEJ for more information about syzbot.
>>syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>>syzbot will keep track of this issue. See:
>>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>
>>If the report is already addressed, let syzbot know by replying with:
>>#syz fix: exact-commit-title
>>
>>If you want syzbot to run the reproducer, reply with:
>>#syz test: git://repo/address.git branch-or-commit-hash
>>If you attach or paste a git patch, syzbot will apply it before testing.
>>
>>If you want to overwrite report's subsystems, reply with:
>>#syz set subsystems: new-subsystem
>>(See the list of subsystem names on the web dashboard)
>>
>>If the report is a duplicate of another one, reply with:
>>#syz dup: exact-subject-of-another-report
>>
>>If you want to undo deduplication, reply with:
>>#syz undup
>

