Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17AA4FCC29
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 04:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiDLCIS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 22:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiDLCIR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 22:08:17 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8285A338A6
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 19:06:01 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p135so14924196iod.2
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 19:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IoosfZpx4pzhjsGqQ4u+dMrJHYU/w31IsD3IBnp5To=;
        b=WAfgwKOte2KFuZjk7mTJ/4kgYloGKakPVabha2h0LKmKpLnq7/6IqyPt5Y/RINbkKU
         qJ6NhMd8l8r0TTvZDb67ztjKJOoO+P3rK1LGqS1N+DaD36JEYO3E8Qvdj+igLTajiXL9
         pPzHEBgwkrO6Xy/dHenkCWI/a2fVjrCF4pwDZizmqOWU7upy0dhJw5KorB05HU0+LZ3m
         2G0M7y1IlusdbLsz6Q6/qk6dqxQHXTtDDf/enh9/MlIUsAvC4aDYb8aFjmOSs6uXh9FW
         on6tpteQNP/ybcXJcgfAIVfQjzQxu5fdu+tzDLkZW4zBIiA8Qsea+KXXcQOAPEAK69Qb
         +1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IoosfZpx4pzhjsGqQ4u+dMrJHYU/w31IsD3IBnp5To=;
        b=y8X7Mx9Kl3qntN6V3yW6q0PX+WTwnkGjOl+1TWI/WvW6fRTOy/XUKIBkPLtjKmVMSD
         BxNA66cK0CSBOqeiQuhJuhYjbKKb45IIHHbT+EDS7b+6blXfSUmYYJbLxApnelVSmSVJ
         yC/hqwFROlDymb5qB4BP/WCgTKE9rf76sR/ZTAYI/tYW2r/PiEyw3VXHAIgoXC188faq
         U6d7s0FATlWhF7S6bCLWPiN7+78aQiXXZD4PxXeqJV+wWSo45ADf1ANkj0zscg8W8YyI
         De1nc9xFNBl0qA8ThbNYwOsatQ0nV2uyf+CkkNRChAfzMi2wxqjzz253QEhUB6WUUSU2
         lhjg==
X-Gm-Message-State: AOAM530qT0qRR2uKqMQy8SDFcnVx32JcmW94zAMM2J4o6OAUN9q+VUJ7
        l3PT++bvF1fB/usTW8cIXPOAtyDgolxTuBsdr+c=
X-Google-Smtp-Source: ABdhPJwmKvvZyG9ea4fWiB1/LfqPAL6Mrg+Ur2L4YML1iAxTEoNSAFjRtmabJwPvPOiK0isttgpFkjcn8M+7qSrizrA=
X-Received: by 2002:a05:6638:2104:b0:326:1e94:efa6 with SMTP id
 n4-20020a056638210400b003261e94efa6mr6106536jaj.234.1649729160794; Mon, 11
 Apr 2022 19:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-4-joannekoong@fb.com>
 <CAEf4BzbRsA+JTP+4mqWpjRd_KEtaaM74ihz7RKGgpu_outhxTg@mail.gmail.com>
 <CAJnrk1Y8nE7n6PY9f7KBHH-P_ji3vAnuH5UP0r1fAk4OUTUZtQ@mail.gmail.com>
 <CAEf4Bzbp=91iYC5Ggm2W6gd3m_=wYXUXrZ7XLnGU5i=STcVAWA@mail.gmail.com> <CAJnrk1bxi9Ax0RBCGEz61tH0v2DCZwy=R132R4BS5737-WMN9Q@mail.gmail.com>
In-Reply-To: <CAJnrk1bxi9Ax0RBCGEz61tH0v2DCZwy=R132R4BS5737-WMN9Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Apr 2022 19:05:49 -0700
Message-ID: <CAEf4BzbA1mrEOaX0KYmM7EkCiZNZw=aF5dXPun_B-iWxjEefxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Add bpf_dynptr_from_mem, bpf_malloc, bpf_free
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Fri, Apr 8, 2022 at 4:37 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Fri, Apr 8, 2022 at 3:46 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 8, 2022 at 3:04 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > On Wed, Apr 6, 2022 at 3:23 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
> > > > >
> > > > > From: Joanne Koong <joannelkoong@gmail.com>
> > > > >
> > > > > This patch adds 3 new APIs and the bulk of the verifier work for
> > > > > supporting dynamic pointers in bpf.
> > > > >
> > > > > There are different types of dynptrs. This patch starts with the most
> > > > > basic ones, ones that reference a program's local memory
> > > > > (eg a stack variable) and ones that reference memory that is dynamically
> > > > > allocated on behalf of the program. If the memory is dynamically
> > > > > allocated by the program, the program *must* free it before the program
> > > > > exits. This is enforced by the verifier.
> > > > >
> > > > > The added APIs are:
> > > > >
> > > > > long bpf_dynptr_from_mem(void *data, u32 size, struct bpf_dynptr *ptr);
> > > > > long bpf_malloc(u32 size, struct bpf_dynptr *ptr);
> > > > > void bpf_free(struct bpf_dynptr *ptr);
> > > > >
> > > > > This patch sets up the verifier to support dynptrs. Dynptrs will always
> > > > > reside on the program's stack frame. As such, their state is tracked
> > > > > in their corresponding stack slot, which includes the type of dynptr
> > > > > (DYNPTR_LOCAL vs. DYNPTR_MALLOC).
> > > > >
> > > > > When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
> > > > > MEM_UNINIT), the stack slots corresponding to the frame pointer
> > > > > where the dynptr resides at is marked as STACK_DYNPTR. For helper functions
> > > > > that take in iniitalized dynptrs (such as the next patch in this series
> > > > > which supports dynptr reads/writes), the verifier enforces that the
> > > > > dynptr has been initialized by checking that their corresponding stack
> > > > > slots have been marked as STACK_DYNPTR. Dynptr release functions
> > > > > (eg bpf_free) will clear the stack slots. The verifier enforces at program
> > > > > exit that there are no dynptr stack slots that need to be released.
> > > > >
> > > > > There are other constraints that are enforced by the verifier as
> > > > > well, such as that the dynptr cannot be written to directly by the bpf
> > > > > program or by non-dynptr helper functions. The last patch in this series
> > > > > contains tests that trigger different cases that the verifier needs to
> > > > > successfully reject.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > > >  include/linux/bpf.h            |  74 ++++++++-
> > > > >  include/linux/bpf_verifier.h   |  18 +++
> > > > >  include/uapi/linux/bpf.h       |  40 +++++
> > > > >  kernel/bpf/helpers.c           |  88 +++++++++++
> > > > >  kernel/bpf/verifier.c          | 266 ++++++++++++++++++++++++++++++++-
> > > > >  scripts/bpf_doc.py             |   2 +
> > > > >  tools/include/uapi/linux/bpf.h |  40 +++++
> > > > >  7 files changed, 521 insertions(+), 7 deletions(-)
> > > > >

[...]

> > > > > + *     Description
> > > > > + *             Dynamically allocate memory of *size* bytes.
> > > > > + *
> > > > > + *             Every call to bpf_malloc must have a corresponding
> > > > > + *             bpf_free, regardless of whether the bpf_malloc
> > > > > + *             succeeded.
> > > > > + *
> > > > > + *             The maximum *size* supported is DYNPTR_MAX_SIZE.
> > > > > + *     Return
> > > > > + *             0 on success, -ENOMEM if there is not enough memory for the
> > > > > + *             allocation, -EINVAL if the size is 0 or exceeds DYNPTR_MAX_SIZE.
> > > > > + *
> > > > > + * void bpf_free(struct bpf_dynptr *ptr)
> > > >
> > > > thinking about the next patch set that will add storing this malloc
> > > > dynptr into the map, bpf_free() will be a lie, right? As it will only
> > > > decrement a refcnt, not necessarily free it, right? So maybe just
> > > > generic bpf_dynptr_put() or bpf_malloc_put() or something like that is
> > > > a bit more "truthful"?
> > > I like the simplicity of bpf_free(), but I can see how that might be
> > > confusing. What are your thoughts on "bpf_dynptr_free()"? Since when
> > > we get into dynptrs that are stored in maps vs. dynptrs stored
> > > locally, calling bpf_dynptr_free() frees (invalidates) your local
> > > dynptr even if it doesn't free the underlying memory if it still has
> > > valid refcounts on it? To me, "malloc" and "_free" go more intuitively
> > > together as a pair.
> >
> > Sounds good to me (though let's use _dynptr() as a suffix
> > consistently). I also just realized that maybe we should call
> > bpf_malloc() a bpf_malloc_dynptr() instead. I can see how we might
> > want to enable plain bpf_malloc() with statically known size (similar
> > to statically known bpf_ringbuf_reserve()) for temporary local malloc
> > with direct memory access? So bpf_malloc_dynptr() would be a
> > dynptr-enabled counterpart to fixed-sized bpf_malloc()? And then
> > bpf_free() will work with direct pointer returned from bpf_malloc(),
> > while bpf_free_dynptr() will work with dynptr returned from
> > bpf_malloc_dynptr().
> I see! What is the advantage of a plain bpf_malloc()? Is it that it's
> a more ergonomic API (you get back a direct pointer to the data
> instead of getting back a dynptr and then having to call
> bpf_dynptr_data to get direct access) and you don't have to allocate
> extra bytes for refcounting?
>

That, but also I was thinking it would be good to have a simple way
for temporary (active for the duration of a single BPF program run)
buffer, instead of having to rely on per-CPU array, that would work
even in the presence of CPU migrations (per-cpu array won't) for
sleepable BPF programs. But then I recalled that we disable migrations
for sleepable, so there are not many real advantages of such form of
malloc/free. So please disregard.

> I will rename this to bpf_malloc_dynptr() and bpf_free_dynptr().
> >
> > > >
> > > > > + *     Description
> > > > > + *             Free memory allocated by bpf_malloc.
> > > > > + *
> > > > > + *             After this operation, *ptr* will be an invalidated dynptr.
> > > > > + *     Return
> > > > > + *             Void.
> > > > >   */

[...]

> > > > > @@ -5572,6 +5758,40 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > > >                 bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
> > > > >
> > > > >                 err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> > > > > +       } else if (arg_type_is_dynptr(arg_type)) {
> > > > > +               bool initialized = check_dynptr_init(env, reg, arg_type);
> > > > > +
> > > > > +               if (type_is_uninit_mem(arg_type)) {
> > > > > +                       if (initialized) {
> > > > > +                               verbose(env, "Arg #%d dynptr cannot be an initialized dynptr\n",
> > > > > +                                       arg + 1);
> > > > > +                               return -EINVAL;
> > > > > +                       }
> > > > > +                       meta->raw_mode = true;
> > > > > +                       err = check_helper_mem_access(env, regno, BPF_DYNPTR_SIZE, false, meta);
> > > > > +                       /* For now, we do not allow dynptrs to point to existing
> > > > > +                        * refcounted memory
> > > > > +                        */
> > > > > +                       if (reg_type_may_be_refcounted_or_null(regs[BPF_REG_1].type)) {
> > > >
> > > > hard-coded BPF_REG_1?
> > >
> > > I'm viewing this as a temporary line because one of the patches in a
> > > later dynptr patchset will enable support for local dynptrs to point
> > > to existing refcounted memory. The alternative is to add a new
> > > bpf_type_flag like NO_REFCOUNT and then remove that flag later. What
> > > are your thoughts?
> >
> > my concern and confusion was that it's a hard-coded BPF_REG_1 instead
> > of using arg to derive register itself. Why making unnecessary
> > assumptions about this always being a first argument?
> I think otherwise we need to add a temporary bpf_type_flag that
> specifies that an arg cannot be refcounted, and then when we allow
> local dynptrs to point to refcounted memory later on, we'll need to
> remove this flag and the verifier checks associated with it. But
> overall, I agree with you that we should just add this bpf_type_flag
> to this patchset rather than using BPF_REG_1 as a temporary solution -
> I will make this change for v2!

Ok, I'll wait for v2 as I still can't understand this bit, tbh.

> >
> > > >
> > > > > +                               verbose(env, "Arg #%d dynptr memory cannot be potentially refcounted\n",
> > > > > +                                       arg + 1);
> > > > > +                               return -EINVAL;
> > > > > +                       }
> > > > > +               } else {
> > > > > +                       if (!initialized) {
> > > > > +                               char *err_extra = "";
> > > >

[...]
