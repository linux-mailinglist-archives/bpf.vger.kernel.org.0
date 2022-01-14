Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA448E7FD
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 11:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiANKAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 05:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiANKAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 05:00:33 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C109C061574
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 02:00:33 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id m15so16016695uap.6
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 02:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ik+d1VerK2J5nI/SF03A3JF05qDphK36UdnS9sqSqEA=;
        b=CGOD2tx9n7TdnWjw7fXIBJ/+lBMDM/h1Lln2RR4DShsfcuByrNDsdZsPAzhB/ITshw
         IqwbwJdjr11ez8INZcCW1ajhrbCq38P3gpZXvR+tYxNPJ50dDUuJfX3SiNiF7X7ZBHPQ
         6JiT/1ic9GMtehL9+vHkABfldEefGWZHo3JeWBI3OBVbf/SFZ2xMzh/Fjo2yqMeYvUel
         QP3hM1kpkgVmpMZsdTNkQYDB3AhqcYFZm+1G7zCW9M+lwwquW7ae1rXG7VKcsCrO1BIn
         A3mfcNQogqEmuP9VJtSJ5yP7vK6eG4FBT+AWCzqxABTb3yULJFWgZBxmjRxoPp7NaSJX
         XF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ik+d1VerK2J5nI/SF03A3JF05qDphK36UdnS9sqSqEA=;
        b=JQm+qY92FUasHbXO1qTopLM07Tkn8TkToYwe5tJ+aQRps8OLRqS2hx52N3bSjsKHVQ
         nQP32yX0yEjrXRcQqFSlnndwKB88fjPF1gwOQbAy/UvEBNUcgg4nyk7KRFQPm1nNJNtF
         kO6capVX2WofVCxu7Bv8xgqHhsoPQdmnFnHDaVGq7afwsMxrw/L0YrvvEOO6RN1vQRxx
         wPjrhK4dk9suLrZibH3eMI5HaxclChDIU02DZ2PPHPsZ+MfxSU09VN26ZAP3IDjTA67J
         aZ/BF1CSgDD0VmAvPDHylJg7Xkd2/CHVM4XZhE0X7mllxKEklsIkZUPf+by1wZc14vaJ
         YMmA==
X-Gm-Message-State: AOAM533IBYVm1RFlTem8+oVcjjpoe/e6MdGt7x4TNMAkX1z2PRVejo4Z
        TBP3oqGix8WQUBpojTd8gm36jYVwTs5A57QHcoc=
X-Google-Smtp-Source: ABdhPJxhFAzfQ4yKlj/jETxWFPsGqzDJOIKtlH+4Q+iZTx9GI/QFBF38RIAba/GmMRsLOz90L0S8pEl3y5Nizqwl5Rw=
X-Received: by 2002:a67:e144:: with SMTP id o4mr89146vsl.4.1642154432354; Fri,
 14 Jan 2022 02:00:32 -0800 (PST)
MIME-Version: 1.0
References: <CAGnuNNtdvbk+wp8uYDPK3weGm5PVmM7hqEaD=Mg2nBT-dKtNHw@mail.gmail.com>
 <20220113233708.1682225-1-kennyyu@fb.com>
In-Reply-To: <20220113233708.1682225-1-kennyyu@fb.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Fri, 14 Jan 2022 10:00:21 +0000
Message-ID: <CAGnuNNsVxz+Cd51Es=Hd1sXvCTX7ZH4Pq0RRBmdSKgOz_vC0OQ@mail.gmail.com>
Subject: Re: Proposal: bpf_copy_from_user_remote
To:     Kenny Yu <kennyyu@fb.com>
Cc:     ast@kernel.org, bpf <bpf@vger.kernel.org>, daniel@iogearbox.net,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kenny

Your patch series looks neat! I haven't come across access_process_vm
during my source exploration. Indeed, passing a process descriptor
seems like a good idea. I presume one would then use, e.g.,
find_task_by_pid_ns to convert a pid+ns to a struct task_struct.

My use cases are about general observability into runtimes like
Python. For profiling, I would like to make a BPF version of Austin.
There is a variant for Linux that can be used to collect native
(including kernel) stacks (see
https://github.com/P403n1x87/austin#native-frame-stack), but this
works in a "traditional" way, using ptrace via libunwind. My idea is
to implement Python stack unwinding as a BPF program so that native
and runtime stacks could be both collected and then interleaved, like
austinp currently does. I think that, perhaps, I'd need a sleepable
version of the perf_event section to achieve this.

I have debugging use cases for Python in mind too, in particular for
native extensions. I believe these are similar to your C++ use cases.
I don't expect to be needing to iterate over all running tasks, so as
long as the new helper can be used against specific processes that can
be identified via pid (and namespace) then I'm totally fine with your
patch series.

Cheers,
Gab

On Thu, 13 Jan 2022 at 23:37, Kenny Yu <kennyyu@fb.com> wrote:
>
> Hi Gabriele,
>
> I just submitted a patch series that adds a similar helper to read
> userspace memory from a remote process, please see: https://lore.kernel.o=
rg/bpf/20220113233158.1582743-1-kennyyu@fb.com/T/#ma0646f96bccf0b957793054d=
e7404115d321079d
>
> In my patch series, I added a bpf helper to wrap `access_process_vm`
> which takes a `struct task_struct` argument instead of a pid.
>
> In your patch series, one issue would be it is not clear which pid namesp=
ace
> the pid belongs to, whereas passing a `struct task_struct` is unambiguous=
.
> I think the helper signature in my patch series also provides more flexib=
ility,
> as the bpf program can also provide different flags on how to read
> userspace memory.
>
> Our use case at Meta for this change is to use a bpf task iterator progra=
m
> to read debug information from a running process in production, e.g.,
> extract C++ async stack traces from a running program.
>
> A few questions:
> * What is your use case for adding this helper?
> * Do you have a specific requirement that requires using a pid, or would =
a
>   helper using `struct task_struct` be sufficient?
> * Are you ok with these changes? If so, I will proceed with my patch seri=
es.
>
> Thanks,
> Kenny Yu



--=20
"Egli =C3=A8 scritto in lingua matematica, e i caratteri son triangoli,
cerchi, ed altre figure
geometriche, senza i quali mezzi =C3=A8 impossibile a intenderne umanamente=
 parola;
senza questi =C3=A8 un aggirarsi vanamente per un oscuro laberinto."

-- G. Galilei, Il saggiatore.
