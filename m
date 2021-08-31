Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE643FC6CD
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhHaLvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 07:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhHaLvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 07:51:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F0AC061575;
        Tue, 31 Aug 2021 04:50:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m9so2805347wrb.1;
        Tue, 31 Aug 2021 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KeTUAwtb7J7R1GnrmeTkWgueRyZh566eMg2APxrUefE=;
        b=RyuJpEaqHtTq8s9f6CYcKcHnM+aBAi6QaUzHWiErBMoEwWr4ipUUOF8YKLUJcfOdso
         zxnd7jfx2+QPjLHoDSfVs8aC4Sdxohs5Seg/zKQb8sa8QAA9996TEbgwGj6N2hvBMMtD
         qlfYy1IfSSt12zV6OAqD+jvV8F2mgpdYZOAQu8fTIZrM/xOXPYMbUVH+x2GuZ8+Ic0uL
         XpAkE/jXreho9tvqiUxZxwxtu0ktcDDN7jWeeFaF3vUEKBomo7Mkl7uFAgi+UIv+jVY2
         RZZzx8RJtNNO0pUxUmYeT2ZLQryiaDL9bJbgpqqir34+7ewlPdUz+PBxFESSytajiQoE
         6syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KeTUAwtb7J7R1GnrmeTkWgueRyZh566eMg2APxrUefE=;
        b=UM4MHkIxhRRpG6K+hVw/9BEJC9PxgoZscVkbvdswMfrbWLIxp4/0BAVWabvjoXyPLB
         y2dYvQfMHJ8Zaf1fSwu+g5ptG8Cth7S/fXy3mjaZ15rpYdg2Fi6/ZoLJl/e+hQ61JggW
         g2Bt+39KYqIH4oIP92HJi2SWAGhOEJ2apJurqByy7YkhM3HxKjU9UnZ9KzFy2WuPVtQV
         98CKqNvg/w5f1/7X0yER+8TPyewYgPVrL6sQeJdGdn1xzAiNaLRHUer1d99ve7TUmj5z
         8s0V4g7SgpUK7mute0Xnh9h57mRKYvX7Q3mG8h0kXwPMKlGlrTjUwZ7mhqhXBHiEZKEs
         kmYg==
X-Gm-Message-State: AOAM533NIiKJ26ChcbFNaH49ICU33/eb7m947Fs7Des4iXXdBIzaX6Fb
        yM/010GWXyR+RjtY2ZC/XsI=
X-Google-Smtp-Source: ABdhPJzHX3wJcvV7IXBOUTZBByZLmoHRN2UpdiDbFmEhbDQ5J57Sg0e0YcoMCk+a2qTYBLeD2pbQ0g==
X-Received: by 2002:adf:9f0c:: with SMTP id l12mr32166334wrf.146.1630410657738;
        Tue, 31 Aug 2021 04:50:57 -0700 (PDT)
Received: from [192.168.8.197] ([148.252.133.138])
        by smtp.gmail.com with ESMTPSA id x9sm2199164wmi.30.2021.08.31.04.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 04:50:57 -0700 (PDT)
Subject: Re: [syzbot] general protection fault in sock_from_file
To:     Hao Xu <haoxu@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+f9704d1878e290eddf73@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dvyukov@google.com,
        io-uring@vger.kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
References: <00000000000059117905cacce99e@google.com>
 <7949b7a0-fec1-34a7-aaf5-cbe07c6127ed@kernel.dk>
 <d881d3fa-4df5-1862-bc2b-9420649ba3c8@linux.alibaba.com>
 <407ce02f-7a0a-4eb2-b242-188fc605012c@gmail.com>
 <6df81737-38d8-4c91-358a-79bc5d5f9074@linux.alibaba.com>
 <fb5821b5-3bb2-4c1a-acdb-816e639cb210@gmail.com>
 <6a0ac681-3741-373c-6001-20af97aa5ea8@linux.alibaba.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <66b01fec-9555-87b6-840a-ce01fd8955f1@gmail.com>
Date:   Tue, 31 Aug 2021 12:50:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6a0ac681-3741-373c-6001-20af97aa5ea8@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/31/21 12:48 PM, Hao Xu wrote:
> 在 2021/8/31 下午7:26, Pavel Begunkov 写道:
>> On 8/31/21 12:05 PM, Hao Xu wrote:
>>> 在 2021/8/31 下午5:42, Pavel Begunkov 写道:
>>>> On 8/31/21 10:19 AM, Hao Xu wrote:
>>>>> 在 2021/8/31 上午10:14, Jens Axboe 写道:
>>>>>> On 8/30/21 2:45 PM, syzbot wrote:
>>>>>>> syzbot has found a reproducer for the following issue on:
>>>>>>>
>>>>>>> HEAD commit:    93717cde744f Add linux-next specific files for 20210830
>>>>>>> git tree:       linux-next
>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15200fad300000
>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c643ef5289990dd1
>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=f9704d1878e290eddf73
>>>>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111f5f9d300000
>>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1651a415300000
>>>>>>>
>>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>>> Reported-by: syzbot+f9704d1878e290eddf73@syzkaller.appspotmail.com
>>>>>>>
>>>>>>> general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
>>>>>>> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>>>>>>> CPU: 0 PID: 6548 Comm: syz-executor433 Not tainted 5.14.0-next-20210830-syzkaller #0
>>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>>>>>> RIP: 0010:sock_from_file+0x20/0x90 net/socket.c:505
>>>>>>> Code: f5 ff ff ff c3 0f 1f 44 00 00 41 54 53 48 89 fb e8 85 e9 62 fa 48 8d 7b 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 4f 45 31 e4 48 81 7b 28 80 f1 8a 8a 74 0c e8 58 e9
>>>>>>> RSP: 0018:ffffc90002caf8e8 EFLAGS: 00010206
>>>>>>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>>>>> RDX: 0000000000000005 RSI: ffffffff8713203b RDI: 0000000000000028
>>>>>>> RBP: ffff888019fc0780 R08: ffffffff899aee40 R09: ffffffff81e21978
>>>>>>> R10: 0000000000000027 R11: 0000000000000009 R12: dffffc0000000000
>>>>>>> R13: 1ffff110033f80f9 R14: 0000000000000003 R15: ffff888019fc0780
>>>>>>> FS:  00000000013b5300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> CR2: 00000000004ae0f0 CR3: 000000001d355000 CR4: 00000000001506f0
>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>> Call Trace:
>>>>>>>     io_sendmsg+0x98/0x640 fs/io_uring.c:4681
>>>>>>>     io_issue_sqe+0x14de/0x6ba0 fs/io_uring.c:6578
>>>>>>>     __io_queue_sqe+0x90/0xb50 fs/io_uring.c:6864
>>>>>>>     io_req_task_submit+0xbf/0x1b0 fs/io_uring.c:2218
>>>>>>>     tctx_task_work+0x166/0x610 fs/io_uring.c:2143
>>>>>>>     task_work_run+0xdd/0x1a0 kernel/task_work.c:164
>>>>>>>     tracehook_notify_signal include/linux/tracehook.h:212 [inline]
>>>>>>>     handle_signal_work kernel/entry/common.c:146 [inline]
>>>>>>>     exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>>>>>>>     exit_to_user_mode_prepare+0x256/0x290 kernel/entry/common.c:209
>>>>>>>     __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>>>>>>>     syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>>>>>>>     do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>>>>>>>     entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>>> RIP: 0033:0x43fd49
>>>>>>
>>>>>> Hao, this is due to:
>>>>>>
>>>>>> commit a8295b982c46d4a7c259a4cdd58a2681929068a9
>>>>>> Author: Hao Xu <haoxu@linux.alibaba.com>
>>>>>> Date:   Fri Aug 27 17:46:09 2021 +0800
>>>>>>
>>>>>>        io_uring: fix failed linkchain code logic
>>>>>>
>>>>>> which causes some weirdly super long chains from that single sqe.
>>>>>> Can you take a look, please?
>>>>> Sure, I'm working on this.
>>>>
>>>> Ah, saw it after sending a patch. It's nothing too curious, just
>>>> a small error in logic. More interesting that we don't have a
>>>> test case covering it, we should definitely add something.
>>>>
>>> Saw your patch after coding my fix..😂
>>> Since my email client doesn't receive your patch(only saw it in
>>> webpage https://lore.kernel.org/), I put my comment here:
>>
>> Hmm, does it happen often? I'll CC you
> Uncommon, somestimes there is delay.
>>
>>
>>>>   fs/io_uring.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index 473a977c7979..a531c7324ea8 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -6717,6 +6717,8 @@ static inline void io_queue_sqe(struct io_kiocb *req)
>>>>       if (likely(!(req->flags & (REQ_F_FORCE_ASYNC | REQ_F_FAIL)))) {
>>>>           __io_queue_sqe(req);
>>>>       } else if (req->flags & REQ_F_FAIL) {
>>>> +        /* fail all, we don't submit */
>>>> +        req->flags &= ~REQ_F_HARDLINK;
>>> maybe set REQ_F_LINK here?
>>
>> if (unlikely((req->flags & REQ_F_FAIL) &&
>>          !(req->flags & REQ_F_HARDLINK))) {
>>     posted |= (req->link != NULL);
>>     io_fail_links(req);
>> }
>>
>> The problem is hardlink, normal will be failed. But there is indeed
>> a problem with both patches,
>>
>> if (req->flags & (REQ_F_LINK | REQ_F_HARDLINK))
>>     // kill linked
> Yeah, if we don't have REQ_F_LINK, io_req_complete_post() won't go to
> the disarm branch

Ah, that's what you meant, right. Good catch!


>>
>> Will resend with some tests on top
>>
>>
>>>>           io_req_complete_failed(req, req->result);
>>>>       } else {
>>>>           int ret = io_req_prep_async(req);
>>
> 

-- 
Pavel Begunkov
