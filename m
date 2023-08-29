Return-Path: <bpf+bounces-8932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF00B78CC80
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 20:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F6281224
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325CB1801C;
	Tue, 29 Aug 2023 18:54:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D71643E
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:54:02 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D9ADB
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 11:54:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so704265e9.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693335240; x=1693940040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JxoXdXddMrqBuLVzxYADekKZgXJq+UPAkX92FvzECH8=;
        b=S7J0a0kV7tRlrY+0VxzdAXYgySgnwP9XtPYajM8bmigGEQuoXuYlvQR4ZI+syk5+5Q
         dbc44ofsIzO7/hybExE/UDXy2kIlRWqx12mYkglO5a6VetRiapDQ7FwQZkXjt9T1owiZ
         gD2rQ3c6OrPTC1Xd6fBvpZYl5xFEUSrPYmwIYeSWEnoouxqN9YjYbRsGtfoXwSTsaqo8
         kx3mg7ezpwLp3fBgLgeMLN590yG05DxZoWCvO6AcVtngMNHmDKLDo3cD1RmZZwJaaQ4/
         D0NWHoWzNAeYiLxpf99LcJd4fUROGV1AXitPfjW6Aj5iz8hwFlxy7yfRfubIX35yFeED
         TJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335240; x=1693940040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxoXdXddMrqBuLVzxYADekKZgXJq+UPAkX92FvzECH8=;
        b=BVyJ73yNiIIHZM+QFm8DThimTLf9CO6CutdaVgZIqA77Kj6hrNXE9PhYxZwOL1QbIQ
         3JbiaVlXz02h0QHg0viW1hwLybtyEgy4ko9UxhKxshAVhjnZ6mtQ5Mq3h2xjoZRZIzKD
         1EAPTG06avxS97Yv8Lc/pgDy8X2ibgkLAtx4WXicP4vHw16fD9N3jDG13cOePXpaxNay
         NzbRuTYDpEv8wdGs5fTkEEanBmP4kg2mqbtNvmJXubGFkLf8wAk2DuBVPP7hY4vQTuBE
         Gd96QNGTTGiwI9efG5gyqbScM+lt+9ObnjTKYPMedMEA+SAeFxHczO7bRaI6soXzoKFz
         v3Yw==
X-Gm-Message-State: AOJu0YzbzspIwWulXJsCwmOcaBQvUFYvmv1v4k31f4y03uoDec1mYLWS
	4kMJfaXr9fr1L72MBguikGYHEy0cBgwrjZPR8J0bbA==
X-Google-Smtp-Source: AGHT+IE8mgr71+gNiwepT2zsv8WoaSK0iZRhPsH7OzlxlMDaZTrYXJXOyICQg+Zia/KSqav2HLC/kBgTuVZTKkarNsA=
X-Received: by 2002:a05:600c:228f:b0:401:b3a5:ec04 with SMTP id
 15-20020a05600c228f00b00401b3a5ec04mr79903wmf.16.1693335239562; Tue, 29 Aug
 2023 11:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d87a7f06040c970c@google.com> <2e260b7c-2a89-2d0c-afb5-708c34230db2@linux.dev>
In-Reply-To: <2e260b7c-2a89-2d0c-afb5-708c34230db2@linux.dev>
From: Marco Elver <elver@google.com>
Date: Tue, 29 Aug 2023 20:53:22 +0200
Message-ID: <CANpmjNOG4f-NnGX6rpA-X8JtRtTkUH8PiLvMj_WJsp+sbq6PNg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in bpf_percpu_array_update /
 bpf_percpu_array_update (2)
To: yonghong.song@linux.dev
Cc: syzbot <syzbot+97522333291430dd277f@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 29 Aug 2023 at 20:30, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
>
> On 8/29/23 5:39 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=136f39dfa80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dea9c2ce3f646a25
> > dashboard link: https://syzkaller.appspot.com/bug?extid=97522333291430dd277f
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9923a023ab11/disk-727dbda1.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/650dbc695d77/vmlinux-727dbda1.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/361da71276bf/bzImage-727dbda1.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update
> >
> > write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
> >   bpf_long_memcpy include/linux/bpf.h:428 [inline]
> >   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
> >   copy_map_value_long include/linux/bpf.h:464 [inline]
> >   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
> >   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
> >   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
> >   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
> >   __sys_bpf+0x28a/0x780
> >   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
> >   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
> >   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
> >   bpf_long_memcpy include/linux/bpf.h:428 [inline]
> >   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
> >   copy_map_value_long include/linux/bpf.h:464 [inline]
> >   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
> >   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
> >   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
> >   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
> >   __sys_bpf+0x28a/0x780
> >   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
> >   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
> >   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > value changed: 0x0000000000000000 -> 0xfffffff000002788
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 8268 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> > ==================================================================
>
> This case is with two tasks doing bpf_map batch update together for the
> same map and key.
>    > write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
>    > write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
>
> So concurrency is introduced by user applications.
> In my opinion, this probably not an issue from kernel perspective.

Perhaps not, but I recall there being a discussion about making KCSAN
aware of memory accesses done by BPF programs (memcpy being a tiny
subset of those). Not sure if the above data race qualifies as
something we might want to still detect, i.e. a kernel dev testing
their kernel might be interested in such a report.

Regardless, in this case we should teach syzkaller to ignore KCSAN
data races that originate from bpf user operations whatever the
origin.

