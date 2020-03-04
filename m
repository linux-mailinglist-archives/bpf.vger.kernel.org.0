Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C050117877B
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 02:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbgCDBIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 20:08:19 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38616 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbgCDBIT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 20:08:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id a16so131225pju.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 17:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2oPr2bCnStcn9BfjbWcrCixY+w+Q4VlTpzBUMNd48ZE=;
        b=W98iNawSUNKH+s74be5MBZwvMxmfhq4SGrxTP6ZXvAo60Rh0oInLzYxlCHjJhLfvVg
         huqrAo6ZL9at5pJZYFvw8ZgHCZ6U54VDaYxwBj8Xr+4gH9d/q5wZVr9Y85M4ix9R6v14
         8LOPJsUBIh5jzH5SxFa/LhogW712EGVZdAjnoYcDd1xrfopbQpfB6NffysZRVEnhEEum
         OivjS4WuIAjp7A+Dr2/CMnumJ/9KKUkl15J+z+miMfF9MIL/qv42m+CkD1EGeNisvgEl
         YbVP6eJW+ijttIj6M4lw9aYgFLtLGVfJHPsxiNtGEsw1oV8BullOFI89VUHRRmPBpoyq
         pu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2oPr2bCnStcn9BfjbWcrCixY+w+Q4VlTpzBUMNd48ZE=;
        b=TGl7jQwQihZx2wNIC9V3QpBIg6Tbyo2B3XDPUbdxEwgx0UY2DoPGStRtFLWYEqfDsk
         fWqqMd3cgYRnDwwMUQJuQyR4R5KPXnXNcZU5j/R5sqa7Te3aq69YpIe9bL/v9HUR+D1M
         plXmKnzvjJLP0mOeqrSoOuKT/2PYfL67avwYbbzP/ZwgkmV0nQ3udiCPq8+IUvOc8nPr
         pSrvr2Wyl2GZUkzzAGjFwGjegNWnmvGADycut33e2KTuBNegTGWexEbNeDfPUhXZN3cB
         UhtfQ61q2Zko6OlkkI8VB3IUdhP/Iz7cDF3+L8+lFt57R82//Jw6YH9aqPzomBN2I9HS
         vMMQ==
X-Gm-Message-State: ANhLgQ3p4orc32whP2Myw3biO2JypmpmIBReUKSS2kIJB8ShZe2rQ+eG
        8aSOvI9ycDtmrRJQe2ZP9vFD3Z7D
X-Google-Smtp-Source: ADFU+vu+CcGEYVnbx2FCemZy6AK4PvJhPrb8enIa6DNGxycFL/uuuBY3iF3XXhlGfGzMpAHd5YxN+w==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20mr675466plo.62.1583284095960;
        Tue, 03 Mar 2020 17:08:15 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:500::4:a0de])
        by smtp.gmail.com with ESMTPSA id r8sm356260pjo.22.2020.03.03.17.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 17:08:15 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:08:12 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix
 bpf_send_signal()/bpf_send_signal_thread() helper in NMI mode
Message-ID: <20200304010811.rfzdhvnyogib3woj@ast-mbp>
References: <20200303231554.2553105-1-yhs@fb.com>
 <20200303231554.2553178-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303231554.2553178-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 03, 2020 at 03:15:54PM -0800, Yonghong Song wrote:
> When experimenting with bpf_send_signal() helper in our production environment,
> we experienced a deadlock in NMI mode:
>    #0 [fffffe000046be58] crash_nmi_callback at ffffffff8103f48b
>    #1 [fffffe000046be60] nmi_handle at ffffffff8101feed
>    #2 [fffffe000046beb8] default_do_nmi at ffffffff8102027e
>    #3 [fffffe000046bed8] do_nmi at ffffffff81020434
>    #4 [fffffe000046bef0] end_repeat_nmi at ffffffff81c01093
>       [exception RIP: queued_spin_lock_slowpath+68]
>       RIP: ffffffff8110be24  RSP: ffffc9002219f770  RFLAGS: 00000002
>       RAX: 0000000000000101  RBX: 0000000000000046  RCX: 000000000000002a
>       RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff88871c96c044
>       RBP: 0000000000000000   R8: ffff88870f11f040   R9: 0000000000000000
>       R10: 0000000000000008  R11: 00000000acd93e4d  R12: ffff88871c96c044
>       R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000001
>       ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   --- <NMI exception stack> ---
>    #5 [ffffc9002219f770] queued_spin_lock_slowpath at ffffffff8110be24
>    #6 [ffffc9002219f770] _raw_spin_lock_irqsave at ffffffff81a43012
>    #7 [ffffc9002219f780] try_to_wake_up at ffffffff810e7ecd
>    #8 [ffffc9002219f7e0] signal_wake_up_state at ffffffff810c7b55
>    #9 [ffffc9002219f7f0] __send_signal at ffffffff810c8602
>   #10 [ffffc9002219f830] do_send_sig_info at ffffffff810ca31a
>   #11 [ffffc9002219f868] bpf_send_signal at ffffffff8119d227
>   #12 [ffffc9002219f988] bpf_overflow_handler at ffffffff811d4140
>   #13 [ffffc9002219f9e0] __perf_event_overflow at ffffffff811d68cf
>   #14 [ffffc9002219fa10] perf_swevent_overflow at ffffffff811d6a09
>   #15 [ffffc9002219fa38] ___perf_sw_event at ffffffff811e0f47
>   #16 [ffffc9002219fc30] __schedule at ffffffff81a3e04d
>   #17 [ffffc9002219fc90] schedule at ffffffff81a3e219
>   #18 [ffffc9002219fca0] futex_wait_queue_me at ffffffff8113d1b9
>   #19 [ffffc9002219fcd8] futex_wait at ffffffff8113e529
>   #20 [ffffc9002219fdf0] do_futex at ffffffff8113ffbc
>   #21 [ffffc9002219fec0] __x64_sys_futex at ffffffff81140d1c
>   #22 [ffffc9002219ff38] do_syscall_64 at ffffffff81002602
>   #23 [ffffc9002219ff50] entry_SYSCALL_64_after_hwframe at ffffffff81c00068
> 
> Basically, when task->pi_lock is taken, a NMI happens, bpf program executes,
> which calls bpf program. The bpf program calls bpf_send_signal() helper,
> which will call group_send_sig_info() in irq_work, which will try to
> grab task->pi_lock again and failed due to deadlock.
> 
> To break the deadlock, group_send_sig_info() call should be delayed
> until it is safe to do.
> 
> This patch registers a task_work callback inside the irq_work so
> group_send_sig_info() in the task_work can be called later safely.
> 
> This patch also fixed a potential issue where the "current"
> task in nmi context is gone when the actual irq_work is triggered.
> Hold a reference to the task and drop the reference inside
> the irq_work to ensure the task is not gone.
> 
> Fixes: 8482941f0906 ("bpf: Add bpf_send_signal_thread() helper")
> Fixes: 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
> Cc: Rik van Riel <riel@surriel.com>
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Yonghong Song <yhs@fb.com>

I don't think that fixes it.
The stack trace is not doing nmi.
It's a sw event and 'if (in_nmi())' is false.
try_to_wake_up() is safe to do from irq_work for both current and other tasks.
I don't think task_work() is necessary here.
It's a very similar issue that was addressed by
commit eac9153f2b58 ("bpf/stackmap: Fix deadlock with rq_lock in bpf_get_stack()")
Imo the same approach will work here.
Please craft a reproducer first though.
I think the one Song did for the above commit may be adopted for this case too.
