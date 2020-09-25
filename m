Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188B5277E56
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 05:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgIYDEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 23:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgIYDEc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 23:04:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B870C0613CE;
        Thu, 24 Sep 2020 20:04:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so1780214pfp.11;
        Thu, 24 Sep 2020 20:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaLV707zQzZoN9QVLmaV1M3bCDM0wWxg5z+B0UkLQGg=;
        b=EkPvPefRxz0sWEd3UPVC8kxM159CSTntHac6+Inlv5wOG9OZKkrjEyYag0K/as/E90
         7/A8BO8/EMphA9rdWDdLvSqLMScFNaqeHSCoOjoxxk96OPWS/dsZJvpUpfhzF0hm9Wbu
         bxeJAeIytZ+L0UjGyHr5XwO9aWCNz6Uc7werwqPxqZb2h174LSOVhEN3r2JO9qsDWEjT
         51QW0j/7qWIcXrGktJhy0zW4hDUMQIh9S72MKexreLM7bqYYQyOA7OD7O6bnM8H4worb
         IxkMkB3DJeDa5gzfcRV5a6Q95pSRYUx1p0jD0qdyrfUtqdUf2LmfclyKPeFfWSU0QWss
         WYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaLV707zQzZoN9QVLmaV1M3bCDM0wWxg5z+B0UkLQGg=;
        b=W7EoILJm4zKPgRs/+E0yd5A3c2K8YVPmL9xIOLPHX4YJKS9Tvrq129tFsQtu/66sRC
         cUcrQyq9TtfJzdR6o/uk/eBJH4HR7lYZV1hTZ+yld1x8CzCedH1laPlLKUOIefc5CWJC
         Cjuo87a8J3h2KI50fXKBYCQy3/W2wEOladJd6Wo0jhHhcztGO5tqf+kQkS7gfmI6uI/B
         KaFv2Em1IQCTNRrXbhAEVmmmStLHPZe9PwXnJ88L5FLF4k3q/nREsrem9IYrRzdnE67M
         JHNVJQUq/et8MqcCDA3P6pSm0zNM+pK2ZJ/CejWUZNZUE9+A6dYFXZPV8PSURatUWbAb
         viVw==
X-Gm-Message-State: AOAM530DRJjEA/S4q2cEh0iwRwmO3+pPvbsSXoyUU8sFTrcsFL54xX+x
        BQcEL8q1Wq+J1Hnrd/vFSMCxdPQA9O0pKCS9pSM=
X-Google-Smtp-Source: ABdhPJzjiyeuGOlQoK/hG6jcimUOzcy7CQEv7zxwO869et/v35NnPEJvv3NMxcXCfGmNr9BcSNz8lzE/nTu7SbOgZ3k=
X-Received: by 2002:aa7:9491:0:b029:142:2501:396b with SMTP id
 z17-20020aa794910000b02901422501396bmr2144153pfk.48.1601003071283; Thu, 24
 Sep 2020 20:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <c14518ba563d4c6bb75b9fac63b69cd4c82f9dcc.1600951211.git.yifeifz2@illinois.edu>
 <202009241601.FFC0CF68@keescook>
In-Reply-To: <202009241601.FFC0CF68@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 22:04:20 -0500
Message-ID: <CABqSeARb7GNU9+sVgGzgqqOmpQNpxq1JsMrZJvS2EC05AyfAVw@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[resending this, forgot to hit reply all...]

On Thu, Sep 24, 2020 at 6:25 PM Kees Cook <keescook@chromium.org> wrote:
> I'm not interested in seccomp having a config option for this. It should
> entire exist or not, and that depends on the per-architecture support.
> You mentioned in another thread that you wanted it to let people play
> with this support in some way. Can you elaborate on this? My perspective
> is that of distro and vendor kernels: there is _one_ config and end
> users can't really do anything about it without rolling their own
> kernels.

That's one. The other is to allow future optional extensions, like
syscall-argument-capable accelerators.

Distro / vendor kernels will keep defaults anyways, no?

> So, as Jann pointed out, using NR_syscalls only accidentally works --
> they're actually different sizes and there isn't strictly any reason to
> expect one to be smaller than another. So, we need to either choose the
> max() in asm/linux/seccomp.h or be more efficient with space usage and
> use explicitly named bitmaps (how my v1 does things).

Right.

> This isn't used in this patch; likely leftover/in need of moving?

Correct. Will remove.

> I moved this up in the structure to see if I could benefit from cache
> line sharing. In either case, we must verify (with "pahole") that we do
> not induce massive padding in the struct.
>
> But yes, attaching this to the filter is the right way to go.

Right. I don't think it would cause massive padding with all I know
about padding learnt from [1].

I'm used to use gdb to look at structure layout, and this is what I see:
(gdb) ptype /o struct seccomp_filter
/* offset    |  size */  type = struct seccomp_filter {
/*    0      |     4 */    refcount_t refs;
/*    4      |     4 */    refcount_t users;
/*    8      |     1 */    bool log;
/* XXX  7-byte hole  */
/*   16      |     8 */    struct seccomp_filter *prev;
[...]
/*  264      |   112 */    struct seccomp_cache_filter_data {
/*  264      |   112 */        unsigned long syscall_ok[2][7];

                               /* total size (bytes):  112 */
                           } cache;

                           /* total size (bytes):  376 */
                         }

The bitmaps are long-aligned; so is the prev-pointer. If we want we
can put the cache struct right before prev and that should not
introduce any new holes. It's the refcounts and the bool that's not
cooperative.

> nit: "ok" is too vague. We mean either "constant action" or "allow" (or
> "filter" in the negative case).

Right.

> Why is this split out? (i.e. why is it not just a self-contained loop
> the way Jann wrote it?)

Because my brain thinks like a finite state machine and this function
is a state transition. ;) Though yeah I agree a loop is probably more
readable.

> I appreciate the -errno intent, but it actually risks making these
> changes break existing userspace filters: if something is unhandled in
> the emulator in a way we don't find during design and testing, the
> filter load will actually _fail_ instead of just falling back to "run
> filter". Failures should be reported (WARN_ON_ONCE()), but my v1
> intentionally lets this continue.

Right.

> This version appears to have removed all the comments; I liked Jann's
> comments and I had rearranged things a bit to make it more readable
> (IMO) for people that do not immediate understand BPF. :)

Right.

> > +/**
> > + * seccomp_cache_prepare - emulate the filter to find cachable syscalls
> > + * @sfilter: The seccomp filter
> > + *
> > + * Returns 0 if successful or -errno if error occurred.
> > + */
> > +int seccomp_cache_prepare(struct seccomp_filter *sfilter)
> > +{
> > +     struct sock_fprog_kern *fprog = sfilter->prog->orig_prog;
> > +     struct sock_filter *filter = fprog->filter;
> > +     int arch, nr, res = 0;
> > +
> > +     for (arch = 0; arch < ARRAY_SIZE(syscall_arches); arch++) {
> > +             for (nr = 0; nr < NR_syscalls; nr++) {
> > +                     struct seccomp_emu_env env = {0};

Btw, do you know what is the initial state of the A register at the
start of BPF execution? In my RFC I assumed it's unknown but then in
v1 after the "reg_known" removal the register is assumed to be 0. Idk
if it is correct to assume so.

> I don't really like the complexity here, passing around syscall_ok, etc.
> I feel like seccomp_emu_step() should be self-contained to say "allow or
> filter" directly.

Ok.

> I also prefer an inversion to the logic: if we start bitmaps as "default
> allow", we only ever increase the filtering cases: we can never
> accidentally ADD an allow to the bitmap. (This was an intentional design
> in the RFC and v1 to do as much as possible to fail safe.)

Wait why? If it's default allow, what if you hit an error? You can
accidentally not remove an allow from the bitmap, and that is much
more of an issue than accidentally not add an allow. I don't
understand your reasoning of "accidentally ADD an allow", an action
will only occur when everything is right, but an action might not
occur if some random shenanigans happen. Hence, the non-action /
default side should be the fail-safe side, rather than the action
side.

> Why do the prepare here instead of during attach? (And note that it
> should not be written to fail.)

Right.

> And, as per being as defensive as I can imagine, this should be a
> one-way mask: we can only remove bits from syscall_ok, never add them.
> sfilter must be constructed so that it can only ever have fewer or the
> same bits set as prev.

Right.

> In the RFC I did this inherit earlier (in the emulation stage) to
> benefit from the RET_KILL results, but that's not very useful any more.
> However, I think it's still code-locality better to keep the bit
> manipulation logic as close together as possible for readability.

Right.

[1] http://www.catb.org/esr/structure-packing/#_structure_alignment_and_padding

YiFei Zhu
