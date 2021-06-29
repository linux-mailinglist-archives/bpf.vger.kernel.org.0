Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B683D3B7668
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhF2Q2P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 12:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhF2Q2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 12:28:14 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD6C061766
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 09:25:46 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id a11so21423774ilf.2
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwCxgB3/FyZOTgeZocqAjYOgiLXA9Mwd3bMPQk//pm0=;
        b=maT755aKPvqesIHxDTB50d8pPBy9MoWg3uUz63QxA32LBNENf1iSLLytKA0h5qxddW
         6SBvttFm5iO+MaT0ZHHEQIWD+YgEj4ck9LLOn4xNW/3mjLoaL41mbjQUH1eDTLggKUCc
         KwgWHqTTJD8vQ8VCtmgzU1Cwv4A92qFGZReEF1zBH8O9qrAl+w9x33SSUFG9FZcXzXfV
         MD62jRF1LX161zCqOO3hVRHz+GvS3kfb3poOchIJ1mdFZ+hN5uo+e/mWO8X+2zshFSVW
         jcudJFYUgkYLHzPSA0HtFZdcRGCJjfwTc8EguxO++SwcCefMbZzNStRXE/h41YdaTjWk
         mUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwCxgB3/FyZOTgeZocqAjYOgiLXA9Mwd3bMPQk//pm0=;
        b=kuW2XdnKZiBa70usxb/65Vz6TmkHVGqr1I6dDAeUqWh7/5Dg0jZI9O/x2WQw9xWTU7
         0meAg8QNwy9xxHQd0QdU+gaDy070ca79pNbmVW3elVGLSYDUOvsd9dRZ3RQA+pcKFnEP
         aD5aS6zjIarrzgurZ+IFWrkLR7r8VUd711GS1hdJtfQ2xskHwljC99fCKVjM0gI1eYLh
         lzb0ZIT+zdezMAQHDxpIaKjvrPvFfIupe7T9rsUagTBXsptDQadTwXsKKU2dqmMRcOH8
         qvHMOQq68avmmd6il5Ujk4kppgpomxFhoFwRomYkRpuL7xyybb+VDtYL13EcaWtp9O/T
         hoHg==
X-Gm-Message-State: AOAM531Wl8jYVaz8oUelGGuuS7lrbjMdz3wxeSjeHVGS0USuBN4XWGFm
        K5huFwZfvcKC+APTxvSVr+FMxK+xckHJfHsjqt/aOA==
X-Google-Smtp-Source: ABdhPJwyhkPXJhJp/yW9jJCZBx8EHDK51V8ColAfcvx+E1Lo6465xWVBQnbA55E2QlyObjKmxG1Yb9q3dj0DODohpi4=
X-Received: by 2002:a92:6f07:: with SMTP id k7mr11850088ilc.276.1624983945366;
 Tue, 29 Jun 2021 09:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210202135002.4024825-1-jackmanb@google.com> <YNiadhIbJBBPeOr6@krava>
 <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava> <YNtEcjYvSvk8uknO@krava>
In-Reply-To: <YNtEcjYvSvk8uknO@krava>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 29 Jun 2021 18:25:33 +0200
Message-ID: <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 29 Jun 2021 at 18:04, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
> > On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:
> > > On Sun, 27 Jun 2021 at 17:34, Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Tue, Feb 02, 2021 at 01:50:02PM +0000, Brendan Jackman wrote:
[snip]
> > > Hmm, is the test prog from atomic_bounds.c getting JITed there (my
> > > dumb guess at what '0xc0000000119efb30 (unreliable)' means)? That
> > > shouldn't happen - should get 'eBPF filter atomic op code %02x (@%d)
> > > unsupported\n' in dmesg instead. I wonder if I missed something in
> > > commit 91c960b0056 (bpf: Rename BPF_XADD and prepare to encode other
>
> I see that for all the other atomics tests:
>
> [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 21
> #21/p BPF_ATOMIC_AND without fetch FAIL
> Failed to load prog 'Unknown error 524'!
> verification time 32 usec
> stack depth 8
> processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> Summary: 0 PASSED, 0 SKIPPED, 2 FAILED

Hm that's also not good - failure to JIT shouldn't mean failure to
load. Are there other test_verifier failures or is it just the atomics
ones?

> console:
>
>         [   51.850952] eBPF filter atomic op code db (@2) unsupported
>         [   51.851134] eBPF filter atomic op code db (@2) unsupported
>
>
> [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 22
> #22/u BPF_ATOMIC_AND with fetch FAIL
> Failed to load prog 'Unknown error 524'!
> verification time 38 usec
> stack depth 8
> processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> #22/p BPF_ATOMIC_AND with fetch FAIL
> Failed to load prog 'Unknown error 524'!
> verification time 26 usec
> stack depth 8
> processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
>
> console:
>         [  223.231420] eBPF filter atomic op code db (@3) unsupported
>         [  223.231596] eBPF filter atomic op code db (@3) unsupported
>
> ...
>
>
> but no such console output for:
>
> [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 24
> #24/u BPF_ATOMIC bounds propagation, mem->reg OK
>
>
> > > atomics in .imm). Any idea if this test was ever passing on PowerPC?
> > >
> >
> > hum, I guess not.. will check
>
> nope, it locks up the same:

Do you mean it locks up at commit 91c960b0056 too?
