Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932AD497101
	for <lists+bpf@lfdr.de>; Sun, 23 Jan 2022 11:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiAWKrx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jan 2022 05:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiAWKrw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Jan 2022 05:47:52 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1FBC06173B
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 02:47:52 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id f24so25362124uab.11
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1WqfefZv9JkeK5XDesTQDaffZc67Tcc6rsEDQuWKQk=;
        b=ByOwRFKVlCtU0DKknvAXDdxCXqTbp/ldX2r6YE9eI5sajIO1VmKul6stO4d/krLY6q
         2rr5RQQlYuGAMXZu60bIaR6Rvp6DF2e09hw1z0LgGnGVe5Fmd/olCG1JQ8APSBS60xgf
         4lwEZlGXgKb48iaF/9jOO0bRDqOB6gI53P10+8qAI+7dLdRLAurhwfSRygMtq6+oME5Z
         TuDBQFMKwN7Pns2zGQHGuLtyjDU2VGNOqRp1I8zARcjMMPDiS/tvgdhMUezbxAU1fwzN
         Qa+gzzIZXGpjomQ+EazaHDvkNEwAybgIPkBIDFZ+b3+bv/2XbrmgwOBm1oAztivo/ksZ
         T7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1WqfefZv9JkeK5XDesTQDaffZc67Tcc6rsEDQuWKQk=;
        b=SDOH1Ssp2F8t7jumXnxok3izAqlJS8hp55yLS9fG6/hqZBm2V6w3uSwC1oxiZum66K
         GLlbFUhfkrCA79OXjNAB86C1rUnYObLxx1rF/MXxv4fSTr0Xp/Y2dnN9u96TStXPPORU
         xy+BCjgR9gDkmWuMGkmiWz/C33oxKlNuZtUfgLC4MLa8aVdAOBUAdrbLG73JXqS1Qxyz
         JindCA1AY+4Wp69cwxA0iypJ2vCA3r8KK0aiyH4HavbZrKwAFB/UVzPg/ojHUSU0+Ode
         Vu3E2jZq/KKLsZYZPwbH9Eq+k3AKKDkj1tOU3eve0MRJ+C7wCaRZknQ+e8dB/W1ZbOm2
         O71w==
X-Gm-Message-State: AOAM530VEat7xMaYhziT1B4pkhn06iD4vUQvdZ302GtJ1O2zIYE//742
        Hh4+x5K/ArMtbqNhpElriVEEfBAQcXaj7vM7Z5o=
X-Google-Smtp-Source: ABdhPJwzge+c85/eZBunTdcXWRot5peV3s3AHnxWL2vy25qC/lEfx9pKdwYBVR5RORReuAtAPA1KO89l66XEJgVBkUg=
X-Received: by 2002:a05:6102:7a3:: with SMTP id x3mr2383364vsg.4.1642934871105;
 Sun, 23 Jan 2022 02:47:51 -0800 (PST)
MIME-Version: 1.0
References: <YeadK5ykhh7slnXL@debian.home> <CAADnVQ+SqfhWP_wG8N3d-LH_ZZKAbudTnmBbOhCV2f-nJax_BQ@mail.gmail.com>
 <CAGnuNNtC0y02d02dM-g1RC0DP4JmV+if+H=cz3UqbkDpse11uQ@mail.gmail.com> <CAADnVQ+afo+VPusoxOMQR+gY1v-+NrtZoVkTX+97b85uenX=sA@mail.gmail.com>
In-Reply-To: <CAADnVQ+afo+VPusoxOMQR+gY1v-+NrtZoVkTX+97b85uenX=sA@mail.gmail.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Sun, 23 Jan 2022 10:47:40 +0000
Message-ID: <CAGnuNNsn9HOpTP9pB_0MbS812y4teJALDDBqRHgDBkSnPXwvmA@mail.gmail.com>
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

On Fri, 21 Jan 2022 at 02:09, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> How would bpf prog know the pid of the python interpreter?
> Then how would it know the pids of the threads?
> I'm not against exposing find_get_task_by_vpid(), but
> we need to understand the real usage first.
> If we do end up exposing find_get_task_by_vpid(), it's probably
> best to do via refcnt-ed kfunc approach (unstable helpers).
> For example: https://lore.kernel.org/all/20220114163953.1455836-7-memxor@gmail.com/

This is a simple but somewhat unrealistic example but hopefully it
will give the idea. Suppose we are tracing sys_kill on entry and that
we have an application that uses it to check if a process exists by
sending the 0 signal to its PID. During the handling of this event, we
might want to read a certain area of the VM (which we would have
identified a priori from user-space) of the process identified by the
PID passed to the syscall.
