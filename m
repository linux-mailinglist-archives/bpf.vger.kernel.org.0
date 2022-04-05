Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F284F5506
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 07:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbiDFFYy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 01:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1848129AbiDFCUo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 22:20:44 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D03B278C4C
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 16:42:01 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id k15so789036ils.0
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+s4EBg6oNjINCUsGVa2xLDsL/rTh43KO7vKQHBTY1w=;
        b=QGAm/b+DRGAJpXn8Urp3046EdFT0SPPUW2QrxVT59HL4zWFu3f9bOn0fJ9kju4i8vH
         0YpJ42KGCTQuXHLnnpm4LM2qo2BxwDWZ5Ks4IBoNoLoCnk4Ic2WoiS5F7JuA77TVGKxT
         5x0gsqBZF1yN5TKLsy703GJyvRTLgcwRSnzSzdtesQkHHw+ehCaCMRIHyv0CyE6oTkUn
         sZyZoqEJouhcIYXB1+yZJH8+0SzxBNP8j6XqhIVBFuN126QcQgGWUPa4R9hJumvSfcxs
         xSvg24C+yPHVgyZSHqqQ1RG6YGJtJXM8003heEKjsxEUQqY6Qi1GI4sbZX0weOeCjDsK
         h6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+s4EBg6oNjINCUsGVa2xLDsL/rTh43KO7vKQHBTY1w=;
        b=r8dYPP1EML7dNjVwGqXkzfwLu5rRLvzOWMJJLJf/i3jW9VewyyrBeGKCtlaDEiBK1F
         T3P5teb5FduRGoguBC80u26VmGR1/62BYXGe9YNeDjCA1QLUoIWVre+p1GMawM85G3Uh
         QzQIk0cBvwSpTM/ls8nqcU+rQbPKrMUO985TEwZI2tkxqbggi/blf8qIaqHUw5h8VhuJ
         n+tRSnDCTenQd9dGbV7bwCS9pTEBEmleJf0wx0dPIrX+UyN23aO6FOFMTuEEq0T61LSL
         tTknHk1MM5XmamTKuhgRwr7ufte2alJ76oRrwiJ14ztDnGaJv54k1hKSbyr7xA6NUdf4
         WjqA==
X-Gm-Message-State: AOAM531vAq1k1rt9lSBk50kk8apMxow3P5se36fteH+CgrLiNkWZA4k1
        nYgcmb9QhUWxsxbmprpZSSzl+eTEJAZnPKP5ZA4CNQk1lHI=
X-Google-Smtp-Source: ABdhPJwS+dXujA+vha6f3AKms8yQWauIUM6gSae85wanezfpBl1XuEQhS3GpQ5AmwVrG880igjvx8kRn8hMQeHeUjT0=
X-Received: by 2002:a05:6e02:1562:b0:2ca:50f1:72f3 with SMTP id
 k2-20020a056e02156200b002ca50f172f3mr2802623ilu.71.1649202116430; Tue, 05 Apr
 2022 16:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220402002944.382019-1-andrii@kernel.org> <20220402002944.382019-3-andrii@kernel.org>
 <22359fb1-33a2-ee2c-4300-a07b175825e6@fb.com> <CAEf4BzYdhnGE7HZLrjF0E2-XFwVrQf7G=uVaWJd7p2qaQMsvTg@mail.gmail.com>
 <5b7e5a08-a2aa-72dd-8bb2-7b10e7ff32b4@fb.com>
In-Reply-To: <5b7e5a08-a2aa-72dd-8bb2-7b10e7ff32b4@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Apr 2022 16:41:45 -0700
Message-ID: <CAEf4BzYbiy+ch8Q_rZW0BhWmm7-7zzk8tJDXBNo9u6PjdMObWg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/7] libbpf: wire up USDT API and bpf_link integration
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 4, 2022 at 6:00 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 4/4/22 12:18 AM, Andrii Nakryiko wrote:
> > On Sun, Apr 3, 2022 at 8:12 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >>
> >> On 4/1/22 8:29 PM, Andrii Nakryiko wrote:
> >>> Wire up libbpf USDT support APIs without yet implementing all the
> >>> nitty-gritty details of USDT discovery, spec parsing, and BPF map
> >>> initialization.
> >>>
> >>> User-visible user-space API is simple and is conceptually very similar
> >>> to uprobe API.
> >>>
> >>> bpf_program__attach_usdt() API allows to programmatically attach given
> >>> BPF program to a USDT, specified through binary path (executable or
> >>> shared lib), USDT provider and name. Also, just like in uprobe case, PID
> >>> filter is specified (0 - self, -1 - any process, or specific PID).
> >>> Optionally, USDT cookie value can be specified. Such single API
> >>> invocation will try to discover given USDT in specified binary and will
> >>> use (potentially many) BPF uprobes to attach this program in correct
> >>> locations.
> >>>
> >>> Just like any bpf_program__attach_xxx() APIs, bpf_link is returned that
> >>> represents this attachment. It is a virtual BPF link that doesn't have
> >>> direct kernel object, as it can consist of multiple underlying BPF
> >>> uprobe links. As such, attachment is not atomic operation and there can
> >>> be brief moment when some USDT call sites are attached while others are
> >>> still in the process of attaching. This should be taken into
> >>> consideration by user. But bpf_program__attach_usdt() guarantees that
> >>> in the case of success all USDT call sites are successfully attached, or
> >>> all the successfuly attachments will be detached as soon as some USDT
> >>> call sites failed to be attached. So, in theory, there could be cases of
> >>> failed bpf_program__attach_usdt() call which did trigger few USDT
> >>> program invocations. This is unavoidable due to multi-uprobe nature of
> >>> USDT and has to be handled by user, if it's important to create an
> >>> illusion of atomicity.
> >>
> >> It would be useful to be able to control the behavior in response to attach
> >> failure in bpf_program__attach_usdt. Specifically I'd like to be able to
> >> choose between existing "all attaches succeed or entire operation fails" and
> >> "_any_ attach succeeds or entire operation fails". Few reasons for this:
> >>
> >>  * Tools like BOLT were not playing nicely with USDTs for some time ([0],[1])
> >>  * BCC's logic was changed to support more granular 'attach failure' logic ([2])
> >>  * At FB I still see some multi-probe USDTs with incorrect-looking locations on
> >>    some of the probes
> >>
> >> Note that my change for 2nd bullet was to handle ".so in shortlived process"
> >> usecase, which this lib handles by properly supporting pid = -1. But it's since
> >> come in handy to avoid 3rd bullet's issue from causing trouble.
> >>
> >> Production tracing tools would be less brittle if they could control this attach
> >> failure logic.
> >>
> >
> > So, we have bpf_usdt_opts for that and can add this in the future. The
> > reason I didn't do it from the outset is that no other attach API
> > currently has this partial success behavior. For example, multi-attach
> > kprobe that we recently added is also an all-or-nothing API. So I
> > wanted to start out with this stricter approach and only allow to
> > change that if/when we have a clear case where this is objectively not
> > enough. The BOLT case you mentioned normally should have been solved
> > by fixing BOLT tooling itself, not by sloppier attach behavior in
> > kernel or libbpf.
>
> Re: BOLT - agreed that it's better to find the root cause and fix that. But for
> some time before root fix is deployed there will be binaries with some incorrect
> USDT notes, and tracing programs will still want to use valid USDT notes to
> collect data. I think this happens fairly often.
>
> In fact I found an example last week while investigating something unrelated.
> Here's a (snipped) 'readelf -n' from a binary in a prod env:
>
>   stapsdt              0x0000007f       NT_STAPSDT (SystemTap probe descriptors)
>     Provider: thrift
>     Name: thread_manager_task_stats
>     Location: 0x0000000000000077, Base: 0x0000000000000000, Semaphore: 0x0000000000000000
>     Arguments: -8@-256(%rbp) -8@-248(%rbp) -8@-240(%rbp) -8@-232(%rbp) -8@-224(%rbp)
>   stapsdt              0x0000007f       NT_STAPSDT (SystemTap probe descriptors)
>     Provider: thrift
>     Name: thread_manager_task_stats
>     Location: 0x0000000002bd1eb3, Base: 0x0000000000000000, Semaphore: 0x0000000000000000
>     Arguments: -8@-272(%rbp) -8@-264(%rbp) -8@-256(%rbp) -8@-248(%rbp) -8@-240(%rbp)
>
> Coming from thrift [0]. Note that this is an ET_EXEC ELF, so the first probe's
> location is certainly invalid. Second looks reasonable. IIUC if I wanted to
> attach to this USDT, find_elf_seg would fail to find a segment for first probe,
> causing collect_usdt_targets to error out as well. BCC complains about this
> ([1]) but continues.
>
>   [0]: https://github.com/facebook/fbthrift/blob/main/thrift/lib/cpp/concurrency/ThreadManager.cpp#L1003
>   [1]: https://github.com/iovisor/bcc/blob/master/src/cc/bcc_elf.c#L127
>

Good thing is that we have an easy way to add these options (opts
struct), but let me first investigate what's going on here and try to
root cause it. Giving a too easy "way out" for cases like this
disincentivizes root causing and fixing the actual underlying issue.
I'll leave this relaxed option as a follow up based on additional
production rollout results.

> >
> > For the [2], if you re-read comments, I've suggested to allow adding
> > one USDT at a time instead of the "partial failure is ok" option,
> > which you ended up doing. So your initial frustration was from
> > suboptimal BCC API. After you added init_usdt() call that allowed to
> > generate code for each individual binary+USDT target, you had all the
> > control you needed, right? So here, bpf_program__attach_usdt() is a
> > logical equivalent of that init_usdt() call from BCC, so should be all
> > good. If bpf_program__attach_usdt() fails for some process/binary that
> > is now gone, you can just ignore and continue attaching for other
> > binaries, right?
>
> You're right, goal of that BCC PR was to relax strictness at USDT level, not
> probe level. I included it to demonstrate that giving users more control over
> attach behavior has been useful in the past. If BCC had similar strictness
> at probe level I would've sent a PR to address that as well, as it would've
> broken a tracing daemon by now.
>
> >>   [0]: https://github.com/facebookincubator/BOLT/commit/ea49a61463c65775aa796a9ef7a1199f20d2a698
> >>   [1]: https://github.com/facebookincubator/BOLT/commit/93860e02a19227be4963a68aa99ea0e09771052b
> >>   [2]: https://github.com/iovisor/bcc/pull/2476
> >>
> >>> USDT BPF programs themselves are marked in BPF source code as either
> >>> SEC("usdt"), in which case they won't be auto-attached through
> >>> skeleton's <skel>__attach() method, or it can have a full definition,
> >>> which follows the spirit of fully-specified uprobes:
> >>> SEC("usdt/<path>:<provider>:<name>"). In the latter case skeleton's
> >>> attach method will attempt auto-attachment. Similarly, generic
> >>> bpf_program__attach() will have enought information to go off of for
> >>> parameterless attachment.
> >>>
> >>> USDT BPF programs are actually uprobes, and as such for kernel they are
> >>> marked as BPF_PROG_TYPE_KPROBE.
> >>>
> >>> Another part of this patch is USDT-related feature probing:
> >>>   - BPF cookie support detection from user-space;
> >>>   - detection of kernel support for auto-refcounting of USDT semaphore.
> >>>
> >>> The latter is optional. If kernel doesn't support such feature and USDT
> >>> doesn't rely on USDT semaphores, no error is returned. But if libbpf
> >>> detects that USDT requires setting semaphores and kernel doesn't support
> >>> this, libbpf errors out with explicit pr_warn() message. Libbpf doesn't
> >>> support poking process's memory directly to increment semaphore value,
> >>> like BCC does on legacy kernels, due to inherent raciness and danger of
> >>> such process memory manipulation. Libbpf let's kernel take care of this
> >>> properly or gives up.
> >>>
> >>> Logistically, all the extra USDT-related infrastructure of libbpf is put
> >>> into a separate usdt.c file and abstracted behind struct usdt_manager.
> >>> Each bpf_object has lazily-initialized usdt_manager pointer, which is
> >>> only instantiated if USDT programs are attempted to be attached. Closing
> >>> BPF object frees up usdt_manager resources. usdt_manager keeps track of
> >>> USDT spec ID assignment and few other small things.
> >>>
> >>> Subsequent patches will fill out remaining missing pieces of USDT
> >>> initialization and setup logic.
> >>>
> >>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>> ---
> >>>  tools/lib/bpf/Build             |   3 +-
> >>>  tools/lib/bpf/libbpf.c          | 100 +++++++-
> >>>  tools/lib/bpf/libbpf.h          |  31 +++
> >>>  tools/lib/bpf/libbpf.map        |   1 +
> >>>  tools/lib/bpf/libbpf_internal.h |  19 ++
> >>>  tools/lib/bpf/usdt.c            | 426 ++++++++++++++++++++++++++++++++
> >>>  6 files changed, 571 insertions(+), 9 deletions(-)
> >>>  create mode 100644 tools/lib/bpf/usdt.c
> >>

[...]
