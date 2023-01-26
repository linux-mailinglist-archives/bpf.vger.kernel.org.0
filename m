Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7967C2C4
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 03:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjAZCWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 21:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAZCWu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 21:22:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156146E8D
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:22:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id v6so1640423ejg.6
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XSWfbYATKVvq3OLEfYLefn484zodCItTGe8t9jQorqc=;
        b=EyTmtbpU7cHyp5mBCeWDldWukvX2ZCCjFFeOAQK1hd6nZi3QC6bhFjjVueQPQaRdpR
         gIVQ9JHaKWFOP0zFeVbeWZkE+Cy4rz2hLMjBFOzmd3U3ZM9KQt/yAFmuJCfyQ9+XIUIn
         UKgWfY8JTtc+FrUJ4d/az1ZZ7sTbbmelI58lxb/nKEEOc4icAC36IAzzEBld0k0t/tx7
         HopyCSFzqgQ1MPx9nwzL8JglggjtNDXRpDXQk8L3ie9Ije6AU1MEsXjCNfK+W6pIx8O7
         zGkJY2sqBoRhqi/OEKIjLg3pSi0BIwf5xr/wBNkBNgZgCIQAlsdxi4aPvAcdfb9R2D4z
         fB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSWfbYATKVvq3OLEfYLefn484zodCItTGe8t9jQorqc=;
        b=BalMj9Q/18zq8WISxGUO4l2Ma/iF7306GqyBY5VGkp0A7mUb5v3iTwipfQ5+4ib9G7
         oCbg3itvmjQXIURub6GcXwTlWFHdstmSYszY0DKVyi1RHp2AzDX6JHdl8Z8ZxprlvGjo
         eycWOxBWUNc198Ea1n574yRausJjqv7xYqqY1PhJ4jv1Kse5t7Io3524gmsKvcPHzODO
         8hV1Jx9uwTDaDBc2TR5I4fs1D3E0HhAZCgdB0XO5cmp1bZASQvCnRkMRSauQOce2JxoQ
         HYeEwz4+I01J71f8/2PUHXC0it8o2aWYcFmQfI+xWeI2ynsJpixmeK1xXxxb20aekxoV
         FG/w==
X-Gm-Message-State: AFqh2kpn84eBzWclHJDz/lzeMvLL0biF+w6HujCKxdl/PmGMOlN0sAuk
        Vcm6wGjgummq3b+5vdp5oqbOtyPYTYpaGr/hIuk=
X-Google-Smtp-Source: AMrXdXt6QD5YiNkcY/CUDM1mGPfk+seuCKdxkfLd1Mh4OdRaq2p+p+jhTk4fXqsAlgansTJdR5DteDxyE525Rb30+5A=
X-Received: by 2002:a17:906:9e95:b0:7c1:98f:c16a with SMTP id
 fx21-20020a1709069e9500b007c1098fc16amr3257822ejc.215.1674699766391; Wed, 25
 Jan 2023 18:22:46 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com> <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
 <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com>
 <CAMy7=ZVpGMOK_kHk1qB4ywxV88Vvtt=rGw4Q-Fi1F7bGU+6prQ@mail.gmail.com>
 <CAADnVQLaKyRJwXnU4wZrih4pRduw_eWarA2uNuc=HssKQUAn_Q@mail.gmail.com>
 <CAMy7=ZU7oEa-VJy1_5WM6+poWsVCyZ0Y7ocQLq3qkFcs2-ftBw@mail.gmail.com>
 <CAADnVQKbi6JA4tX=uBHvNrYEUeMa3jmB=FSb=1LufE3597c86A@mail.gmail.com>
 <CAMy7=ZW7tX4ziwJLhGtqQjbdLyJjqTo=Vi=nQ4sDJHASWMCKgQ@mail.gmail.com>
 <CAADnVQJmpB+bXB_tNXBSVFyG-1KnzKxapLfjUc51_v0-Vho+7w@mail.gmail.com> <CAMy7=ZX+swf7_TzKTHnrMK9d-2PjQK_22vFy_ypBQNsYarqChw@mail.gmail.com>
In-Reply-To: <CAMy7=ZX+swf7_TzKTHnrMK9d-2PjQK_22vFy_ypBQNsYarqChw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Jan 2023 18:22:34 -0800
Message-ID: <CAADnVQ++LzKt9Q-GtGXknVBqyMqY=vLJ3tR3NNGG3P66gvVCFQ@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 11:59 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> > Anyway back to preempt_disable(). Think of it as a giant spin_lock
> > that covers the whole program. In preemptable kernels it hurts
> > tail latency and fairness, and is completely unacceptable in RT.
> > That's why we moved to migrate_disable.
> > Technically we can add bpf_preempt_disable() kfunc, but if we do that
> > we'll be back to square one. The issues with preemptions and RT
> > will reappear. So let's figure out a different solution.
> > Why not use a scratch buffer per program ?
>
> Totally understand the reason for avoiding preemption disable,
> especially in RT kernels.
> I believe the answer for why not to use a scratch buffer per program
> will simply be memory space.
> In our use-case, Tracee [1], we let the user choose whatever events to
> trace for a specific workload.
> This list of events is very big, and we have many BPF programs
> attached to different places of the kernel.
> Let's assume that we have 100 events, and for each event we have a
> different BPF program.
> Then having 32kb per-cpu scratch buffers translates to 3.2MB per one
> cpu, and ~100MB per 32 CPUs, which is more common for our case.

Well, 100 bpf progs consume at least a page each,
so you might want one program attached to all events.

> Since we always add new events to Tracee, this will also not be scalable.
> Yet, if there is no other solution, I believe we will go in that direction
>
> [1] https://github.com/aquasecurity/tracee/blob/main/pkg/ebpf/c/tracee.bpf.c

you're talking about BPF_PERCPU_ARRAY(scratch_map, scratch_t, 1); ?

Insead of scratch_map per program, use atomic per-cpu counter
for recursion.
You'll have 3 levels in the worst case.
So it will be:
BPF_PERCPU_ARRAY(scratch_map, scratch_t, 3);
On prog entry increment the recursion counter, on exit decrement.
And use that particular scratch_t in the prog.
