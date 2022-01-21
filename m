Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23443495821
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 03:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378453AbiAUCJp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 21:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbiAUCJo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 21:09:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C6C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 18:09:44 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n11so7059925plf.4
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 18:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOp8VJ/o7uqNyMkGtLexwu4rzM4v81l+ZqUa3g8ONkE=;
        b=dinWVmjoN9ZC4VjlKzamckF6tjOqsoFEb9ZIutc9gma+r/fC1wQHT9hRHTYhPaq8PK
         7Hh51oKx36CCgtKT7gp0aM1WSCTKtnYJerdc2iYcGbudfg+tUgf/mUuPqZENOkoJCfo2
         iDj0QE9Y2eWt4grzWkb90XpnC+TXDHlHcJ5xnBto7z47Y7A4jLBJVC/MeMxiDHYE8QRP
         7qr/FEmDVJ7N0fcfrxHXLuHRMvmLrHWGddeB+rStzz7vToTU4+yBHy0PCe64xXf8IqGZ
         TCf7vvrSJwfekhDUPJQGJhrArv3vpEMU7J3Wj3MQov23xToxv1tsa+X6CUm1UFbAzszg
         5XZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOp8VJ/o7uqNyMkGtLexwu4rzM4v81l+ZqUa3g8ONkE=;
        b=TFE/rUz6zddYGYrUim+5ZxK0eB3LrgmHu1KvZgOFiaFGW/gYFRzigdShk7Dul2/yb/
         NZnYm1TtWl+ovzy2MPigBUYjLW8F36xLUoRkZNmsX85zQeGfppOFCevRDvvclkMNChWF
         XGVc/JUyWyS1EWnS1kN7vWpxZjIZuRPcoc31KQ2rugIErOkkJ0i7b8Nph77/xwpC1G/8
         4UC0D7GD5ntqpyLSvVbplLwKmG38DYsA71jIkF1lKSU86VyE4b58k55Vx6g/Tovw37Ne
         4ZcqwFnPS1AAasPwuNveJkKfYaaeXAT6I/QN4k7bsXdcjzYEFA7VNRO4V/wdpW0VRTdy
         C77A==
X-Gm-Message-State: AOAM5301ec1+q4By7/uHjz2p8X6j9pRMYbYkFA7n7fpNG82kfU7IDp1q
        FkexmGAnAJOzVqZeLfSAvaBBCFX3Hxhuf/mUNDs=
X-Google-Smtp-Source: ABdhPJy+Du1w9uBFMCwdVFz2G4X34MT8rqDMkZjFXCtmj5qx8/15FYN5+pUd8jOolQlHyxUPmnDMDCKtbJCJCQKxNWA=
X-Received: by 2002:a17:90a:de8e:: with SMTP id n14mr14114234pjv.122.1642730983914;
 Thu, 20 Jan 2022 18:09:43 -0800 (PST)
MIME-Version: 1.0
References: <YeadK5ykhh7slnXL@debian.home> <CAADnVQ+SqfhWP_wG8N3d-LH_ZZKAbudTnmBbOhCV2f-nJax_BQ@mail.gmail.com>
 <CAGnuNNtC0y02d02dM-g1RC0DP4JmV+if+H=cz3UqbkDpse11uQ@mail.gmail.com>
In-Reply-To: <CAGnuNNtC0y02d02dM-g1RC0DP4JmV+if+H=cz3UqbkDpse11uQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Jan 2022 18:09:32 -0800
Message-ID: <CAADnVQ+afo+VPusoxOMQR+gY1v-+NrtZoVkTX+97b85uenX=sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Add bpf_copy_from_user_remote to read a
 process VM given its PID.
To:     Gabriele <phoenix1987@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 8:56 AM Gabriele <phoenix1987@gmail.com> wrote:
>
> On Wed, 19 Jan 2022 at 21:44, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > So how exactly is it going to be used with a pid provided by a tool?
> >
> > I'm guessing if bpf prog attaches to some syscall it will filter out
> > all events that don't match the pid.
> > Then when current_pid == user_provided_pid it will read memory.
> > In such case the prog can use bpf_get_current_task_btf()
> > and Kenny's bpf_access_process_vm(), right?
>
> Hi Alexei
>
> If I understand your suggestion correctly, one would call
> bpf_get_current_pid_tgid to get the pid and match it to the one passed
> by the user-space part of the BPF program, and then get the current
> task to pass to Kenny's helper (but wouldn't the existing
> bpf_copy_from_user be enough in this case?).
>
> I've had some further thoughts about my current and future use cases
> and I think they can be summarised in two scenarios:
>
> Scenario 1: A pid is passed to the user-space part of a BPF program
> and used to filter out as suggested above in kernel-space. Then
> Kenny's helper is enough.

Right. The existing bpf_copy_from_user will do here.

> Scenario 2: A pid != current_pid is derived in the kernel part of BPF
> from somewhere in user-space and extra information needs to be
> retrieved from the remote process "represented" by this pid.
>
> I would expect many observability tools to fall within Scenario 1.
> However, a debugger might be an example of a tool that falls under
> Scenario 2 too. E.g. a function that takes a pid as an argument is
> traced and one wants to collect information from the VM of the process
> "identified" by it. Then the filtering out described above does not
> apply and we need either a helper like the one I'm proposing, or to
> expose find_get_task_by_vpid to BPF. More concretely, we might be
> tracing a native binary application that refers to a runtime like
> Python by pid and we might want to be able to return, e.g., the number
> of sub-interpreters or Python threads that are currently running, from
> events triggered for the native binary.

How would bpf prog know the pid of the python interpreter?
Then how would it know the pids of the threads?
I'm not against exposing find_get_task_by_vpid(), but
we need to understand the real usage first.
If we do end up exposing find_get_task_by_vpid(), it's probably
best to do via refcnt-ed kfunc approach (unstable helpers).
For example: https://lore.kernel.org/all/20220114163953.1455836-7-memxor@gmail.com/
