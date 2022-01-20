Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBED4952B7
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 17:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377139AbiATQ4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 11:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbiATQ4c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 11:56:32 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB0C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 08:56:32 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id v192so3983061vkv.4
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 08:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4jZfUY/qRPONIBBgDoVlIjUx5YyA/uc0D6uW1XBFnM=;
        b=KN38RP/FtPyJ2MiSqvW0/gZV41scI7f6+sk2ORPGc/OXg9iz0/A+z6FdS+osVBbZFY
         a1VJW0k/mmKUYdBxCiRzMX5sQilbK+Q1EDLeh1ALPZZiLb0dhfYzwK0eF3qCUMbB5L7A
         1sdn5xhZOpWGcyVi/Ut0Nh72g7Dd/ayNjEUCOLGFhkkgzwDKAdFzczeiuOg48FjqK0Xb
         srv803mLeLqf2k4aS+BQuSIIGsOS44W0P54lvxLcH4D/y79NLVbDZT711j2Y7CbGFTb4
         8opENEPInLJr1PjfrRN6Tomddf9qwHe3hQnly8QCtNp7wu4/9oG2GvPFDUynYArwA29T
         Lwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4jZfUY/qRPONIBBgDoVlIjUx5YyA/uc0D6uW1XBFnM=;
        b=0uf7moB46fJg8m1zpzg+kFc6l8ET1MorKceK9mMdtkbvBKJJDTijMY30NeyOxx8t0t
         ys/SvPdb08Vm8zM523YmEuaEz30I5Tbu9N/lkWR8lOjvk903CO7r5SpAq4SMtlcIuQ7+
         l1L9ZVcVoBUs8mxRzM3PK5B+bGycQGHZHZ6hZHmEOao4WPkWHpJjsEg1U9G79EeurTsI
         dJGLG0uOGu8+dD//FP5jHmkPeLOLoraOA0FTkVnPre5AxRrNBmie1YOM4Em5rp02740D
         ljxNj84LnwcJHY4CMenOlqzZ01Xg5Pyiy2Q5bqEQ074xNVG2xFoAxlavNHuQOcK1yojc
         CkDw==
X-Gm-Message-State: AOAM533ozT7k4W/uAS/mFp7mHaOfjMRdVyRdv56lFX+BOG875mbmIIRX
        TT82pXFvUwZIIiBfpgin+kmlJ9cSvp9qGWEQ/l7KcZ9Yn0eNeg==
X-Google-Smtp-Source: ABdhPJzOKjiKUoOLVwlAQLuisiDlrq63eOJA8UFUvT9JPH7wK/bCk8VjZL2zoBgwT4HrqsyZVecraOI05L6sRjtXPvs=
X-Received: by 2002:a05:6122:90a:: with SMTP id j10mr15025661vka.12.1642697790994;
 Thu, 20 Jan 2022 08:56:30 -0800 (PST)
MIME-Version: 1.0
References: <YeadK5ykhh7slnXL@debian.home> <CAADnVQ+SqfhWP_wG8N3d-LH_ZZKAbudTnmBbOhCV2f-nJax_BQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+SqfhWP_wG8N3d-LH_ZZKAbudTnmBbOhCV2f-nJax_BQ@mail.gmail.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Thu, 20 Jan 2022 16:56:20 +0000
Message-ID: <CAGnuNNtC0y02d02dM-g1RC0DP4JmV+if+H=cz3UqbkDpse11uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Add bpf_copy_from_user_remote to read a
 process VM given its PID.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Jan 2022 at 21:44, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> So how exactly is it going to be used with a pid provided by a tool?
>
> I'm guessing if bpf prog attaches to some syscall it will filter out
> all events that don't match the pid.
> Then when current_pid == user_provided_pid it will read memory.
> In such case the prog can use bpf_get_current_task_btf()
> and Kenny's bpf_access_process_vm(), right?

Hi Alexei

If I understand your suggestion correctly, one would call
bpf_get_current_pid_tgid to get the pid and match it to the one passed
by the user-space part of the BPF program, and then get the current
task to pass to Kenny's helper (but wouldn't the existing
bpf_copy_from_user be enough in this case?).

I've had some further thoughts about my current and future use cases
and I think they can be summarised in two scenarios:

Scenario 1: A pid is passed to the user-space part of a BPF program
and used to filter out as suggested above in kernel-space. Then
Kenny's helper is enough.

Scenario 2: A pid != current_pid is derived in the kernel part of BPF
from somewhere in user-space and extra information needs to be
retrieved from the remote process "represented" by this pid.

I would expect many observability tools to fall within Scenario 1.
However, a debugger might be an example of a tool that falls under
Scenario 2 too. E.g. a function that takes a pid as an argument is
traced and one wants to collect information from the VM of the process
"identified" by it. Then the filtering out described above does not
apply and we need either a helper like the one I'm proposing, or to
expose find_get_task_by_vpid to BPF. More concretely, we might be
tracing a native binary application that refers to a runtime like
Python by pid and we might want to be able to return, e.g., the number
of sub-interpreters or Python threads that are currently running, from
events triggered for the native binary.

Cheers,
Gab
