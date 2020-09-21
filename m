Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D2F272A0E
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgIUP2I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIUP2I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 11:28:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5DC061755;
        Mon, 21 Sep 2020 08:28:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id bw23so4830662pjb.2;
        Mon, 21 Sep 2020 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kw9zFapd9SW+zuhwhTuJ3eJHqglSccYNB3MuySBWWOw=;
        b=bk12Y9q2B0Yk1G4hAcboUYdVUipOX+HSabhDsdDoCKeQHx4hzhs8ZeG8Ky6OzIRACn
         N9MQ2+LUmeXhucWq64AZK3D7AcmK45BP1ww0Si+5AFxsEouRn393+QfiTsvR2zh7N+Pu
         gbF59YFFdg3ceSCXB/QQu3aMi8CSeF5pT88rJE9eKevU+LcoIh1l1b5gxmjxTHIWGjGm
         gzeKWuKpgEr63E8eDJQKWbjNCSqlY+vkU60pSygLvNRgvioJPP+WY+85MfCmv0vZCu20
         /WfpqPvF1PuXAKceJGN30HmWyzb1yv7v1p/+3EKmHadog59uqEehLONBKasaC4lHF3gV
         iKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kw9zFapd9SW+zuhwhTuJ3eJHqglSccYNB3MuySBWWOw=;
        b=p+XW0pkh99SU0rauz9J9E5WdkC/jcy/H6Jb3m2DPFnKCNUwMrhlVRGOCJol03Y9WJp
         QCu4YH4to7sAMSpIXeFL44hH3QLDgjEsKLWs3scPxArXCKdMbjc2dsqgLhv14manK+3W
         dtkF+x3whHx0c9PeTzw8YX7ftzfWZ+Q/CJJsGzBRjHyBufGTOWxnfRjOlR+t0jE3QtYI
         lrAmS9CpEh31Y2UMK/WGY4xHc7P5rvqopIrFuQmpqKu/8vPHbqipE9i3RkeJp9QLseuM
         YaclwzRbBgfbECYZCCtysadlIqH/Yr/ueoYt4FiHi1utmAP+JsBuxAvvuv0/C9wdjD3p
         ++tg==
X-Gm-Message-State: AOAM5321T33X0oWcToj5OILAvBCHAMKsJ0VPCFvsjywhDu81SZrkk0c0
        IEbEXPe/lQI2FegYNoNjLyqaCeszgEKSlAAiViE=
X-Google-Smtp-Source: ABdhPJwZERAoWm+O+z1FTngCRBN7/Z4B8FPp1WhzJzSrBw1Ub2E2itWQa4qGm4rwDpcB1kATf93CuS2kaBKJoFs/9D0=
X-Received: by 2002:a17:90b:4b82:: with SMTP id lr2mr287928pjb.184.1600702087931;
 Mon, 21 Sep 2020 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <20200921135115.GC3794348@cisco>
In-Reply-To: <20200921135115.GC3794348@cisco>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 21 Sep 2020 10:27:56 -0500
Message-ID: <CABqSeASEw=Qr2CroKEpTyWMRXQkamKVUzXiEe2UsoQTCcv_99A@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>, bpf@vger.kernel.org,
        Tianyin Xu <tyxu@illinois.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 8:51 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> One problem with a kernel config setting is that it's for all tasks.
> While docker and systemd may make decsisions based on syscall number,
> other applications may have more nuanced filters, and this cache would
> yield incorrect results.
>
> You could work around this by making this a filter flag instead;
> filter authors would generally know whether their filter results can
> be cached and probably be motivated to opt in if their users are
> complaining about slow syscall execution.
>
> Tycho

Yielding incorrect results should not be possible. The purpose of the
"emulator" (for the lack of a better term) is to determine whether the
filter reads any syscall arguments. A read from a syscall argument
must go through the BPF_LD | BPF_ABS instruction, where the 32 bit
multiuse field "k" is an offset to struct seccomp_data.

struct seccomp_data contains four components [1]: syscall number,
architecture number, instruction pointer at the time of syscall, and
syscall arguments. The syscall number is enumerated by the emulator.
The arch number is treated by the cache as 'if arch number is
different from cached arch number, flush cache' (this is in
seccomp_cache_check). The last two (ip and args) are treated exactly
the same way in this patch: if the filter loads the arguments at all,
the syscall is marked non-cacheable for any architecture number.

The struct seccomp_data is the only external thing the filter may
access. It is also cBPF so it cannot contain maps to store special
states between runs. Therefore a seccomp filter is pure function. If
we know given some inputs (the syscall number and arch number) the
function will not evaluate any other inputs before returning, then we
can safely cache with just the inputs in concern.

As for the overhead, on my x86_64 with gcc 10.2.0, seccomp_cache_check
compiles into:

    if (unlikely(syscall_nr < 0 || syscall_nr >= NR_syscalls))
        return false;
0xffffffff8120fdb3 <+99>:    movsxd rdx,DWORD PTR [r12]
0xffffffff8120fdb7 <+103>:    cmp    edx,0x1b7
0xffffffff8120fdbd <+109>:    ja     0xffffffff8120fdf9 <__seccomp_filter+169>
    if (unlikely(thread_data->last_filter != sfilter ||
             thread_data->last_arch != sd->arch)) {
0xffffffff8120fdbf <+111>:    mov    rdi,QWORD PTR [rbp-0xb8]
0xffffffff8120fdc6 <+118>:    lea    rsi,[rax+0x6f0]
0xffffffff8120fdcd <+125>:    cmp    rdi,QWORD PTR [rax+0x728]
0xffffffff8120fdd4 <+132>:    jne    0xffffffff812101f0 <__seccomp_filter+1184>
0xffffffff8120fdda <+138>:    mov    ebx,DWORD PTR [r12+0x4]
0xffffffff8120fddf <+143>:    cmp    DWORD PTR [rax+0x730],ebx
0xffffffff8120fde5 <+149>:    jne    0xffffffff812101f0 <__seccomp_filter+1184>
    return test_bit(syscall_nr, thread_data->syscall_ok);
0xffffffff8120fdeb <+155>:    bt     QWORD PTR [rax+0x6f0],rdx
0xffffffff8120fdf3 <+163>:    jb     0xffffffff8120ffb7 <__seccomp_filter+615>
[... unlikely path of cache flush omitted]

and seccomp_cache_insert compiles into:

    if (unlikely(syscall_nr < 0 || syscall_nr >= NR_syscalls))
        return;
0xffffffff8121021b <+1227>:    movsxd rax,DWORD PTR [r12]
0xffffffff8121021f <+1231>:    cmp    eax,0x1b7
0xffffffff81210224 <+1236>:    ja     0xffffffff8120ffb7 <__seccomp_filter+615>
    if (!test_bit(syscall_nr, sfilter->cache.syscall_ok))
        return;
0xffffffff8121022a <+1242>:    mov    rbx,QWORD PTR [rbp-0xb8]
0xffffffff81210231 <+1249>:    mov    rdx,QWORD PTR gs:0x17000
0xffffffff8121023a <+1258>:    bt     QWORD PTR [rbx+0x108],rax
0xffffffff81210242 <+1266>:    jae    0xffffffff8120ffb7 <__seccomp_filter+615>
    set_bit(syscall_nr, thread_data->syscall_ok);
0xffffffff81210248 <+1272>:    lock bts QWORD PTR [rdx+0x6f0],rax
0xffffffff81210251 <+1281>:    jmp    0xffffffff8120ffb7 <__seccomp_filter+615>

In the circumstance of a non-cacheable syscall happening over and
over, the code path would go through the syscall_nr bound check, then
the filter flush check, then the test_bit, then another syscall_nr
bound check and one more test_bit in seccomp_cache_insert. Considering
that they are either stack variables, elements of current task_struct,
and elements of the filter struct, I imagine they would well be in the
CPU data cache and not incur much overhead. The CPU is also free to
branch predict and reorder memory accesses (there are no hardware
memory barriers here) to further increase the efficiency, whereas a
normal filter execution would be impaired by things like retpoline.

If one were to add an additional flag for
does-userspace-want-us-to-cache, it would still be a member of the
filter struct. What would be loaded into the CPU data cache originally
would still be loaded. Correct me if I'm wrong, but I don't think that
check will reduce any significant overhead of the seccomp cache
itself.

That said, I have not profiled the exact number of milliseconds this
patch would incur to uncacheable syscalls, I can report back with
numbers if you would like to see.

Does that answer your concern?

YiFei Zhu

[1] https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/seccomp.h#L60
