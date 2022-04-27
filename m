Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F30510FA6
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 05:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357508AbiD0Dvv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 23:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357483AbiD0Dvu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 23:51:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD7C6A43C
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 20:48:40 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p62so1403902iod.0
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 20:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0TZcauTkShvNIzPwQO0A1YOn0WCG/41C65K4l2SUeMU=;
        b=jKeJzv5lCfuNCesC8HBS9VPyGIYER26RBdjduyXt57tDSKJK6PiMTSwZekkM65QVKX
         JySAyLDXjSquGmEcDXhBcOxCVXGyjmdxQqrEYMFvvwL7tr4HvB2C3FDC6RdJDOxX+66N
         fZRSxVifQWoD4/A8/xEin+FztGzhtRetRLPm+DzxrvdX6j9Cp05H8eKK4HRJECOurJnd
         8OANVJoeGUdBHXWj2X/U0pIV6VT1IMVA0QUIt7mh4TfghNI2k+EgmLgeeoESlLtouekR
         WJ8scEymw6KavOLXm4DhYo0dUoqt32k1j55+V0Inct5wtkBIzvVWCMfDLVb34D0cpD9N
         aGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0TZcauTkShvNIzPwQO0A1YOn0WCG/41C65K4l2SUeMU=;
        b=M+hbcV7Hk9drBm6L9RPKC1wDUSOU/8ITIF3OYvSCbe8qTDvyaJoY++9MjwbWpPqx/j
         iN08+r+GtA0gfSO9ylEASA83xPEfyTGGV+gQR/FIdUDUloDrnaCCMSWHchczEY4sXqXX
         YWGXlaxuMMid+eMwGwUzNtgXP5YZTrwZy23zBoBKHENM67s4vcHKIw2R5ym6O7DqL9TG
         kdHy+p/CcBlp5i/FUiMIMfFiuKNuaoEPkldasE9qCUVSVMMJ4kGodTLuz+2oSbVuCkDM
         sXd6o9Xt978PmeUotDSCQIK8W4h1EQld6asGKHHUEMdgGIaZTiZmfAerQf1IZmI1WNAr
         yGPw==
X-Gm-Message-State: AOAM532wW3hziAN4J/TCv3DcXvNE2swFMD4BxN04gJaw5OqMw58wg8lr
        hOURjjoGJBmskqGPMAE/QFOnqcw9/GjPIKqjbik=
X-Google-Smtp-Source: ABdhPJypPX5VcPzpPpx2/2sdSK8kj18ea1XP7RsOm/mMvbMwEpuHKScSLfrT78snMyeQbNGhyQNZ7nLY8Vw1VoVyAzY=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr10022016ilb.305.1651031320139; Tue, 26
 Apr 2022 20:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com> <20220422025212.n4c25z23rj2pp3yu@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAJnrk1ZczWZi4SAGTqoY1764oei8gCzcEA9a7608R4H2XkisrA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZczWZi4SAGTqoY1764oei8gCzcEA9a7608R4H2XkisrA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Apr 2022 20:48:29 -0700
Message-ID: <CAEf4BzZ3a5b-t16MvbE-URfPE9ZK0LKTCev8gPJAQm9sAy9UeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Tue, Apr 26, 2022 at 4:45 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Thu, Apr 21, 2022 at 7:52 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Apr 15, 2022 at 11:34:25PM -0700, Joanne Koong wrote:
> > > This patch adds 3 new APIs and the bulk of the verifier work for
> > > supporting dynamic pointers in bpf.
> > >
> > > There are different types of dynptrs. This patch starts with the most
> > > basic ones, ones that reference a program's local memory
> > > (eg a stack variable) and ones that reference memory that is dynamically
> > > allocated on behalf of the program. If the memory is dynamically
> > > allocated by the program, the program *must* free it before the program
> > > exits. This is enforced by the verifier.
> > >
> > > The added APIs are:
> > >
> > > long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_dynptr *ptr);
> > > long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
> > > void bpf_dynptr_put(struct bpf_dynptr *ptr);
> > >
> > > This patch sets up the verifier to support dynptrs. Dynptrs will always
> > > reside on the program's stack frame. As such, their state is tracked
> > > in their corresponding stack slot, which includes the type of dynptr
> > > (DYNPTR_LOCAL vs. DYNPTR_MALLOC).
> > >
> > > When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
> > > MEM_UNINIT), the stack slots corresponding to the frame pointer
> > > where the dynptr resides at are marked as STACK_DYNPTR. For helper functions
> > > that take in initialized dynptrs (such as the next patch in this series
> > > which supports dynptr reads/writes), the verifier enforces that the
> > > dynptr has been initialized by checking that their corresponding stack
> > > slots have been marked as STACK_DYNPTR. Dynptr release functions
> > > (eg bpf_dynptr_put) will clear the stack slots. The verifier enforces at
> > > program exit that there are no acquired dynptr stack slots that need
> > > to be released.
> > >
> > > There are other constraints that are enforced by the verifier as
> > > well, such as that the dynptr cannot be written to directly by the bpf
> > > program or by non-dynptr helper functions. The last patch in this series
> > > contains tests that trigger different cases that the verifier needs to
> > > successfully reject.
> > >
> > > For now, local dynptrs cannot point to referenced memory since the
> > > memory can be freed anytime. Support for this will be added as part
> > > of a separate patchset.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  include/linux/bpf.h            |  68 +++++-
> > >  include/linux/bpf_verifier.h   |  28 +++
> > >  include/uapi/linux/bpf.h       |  44 ++++
> > >  kernel/bpf/helpers.c           | 110 ++++++++++
> > >  kernel/bpf/verifier.c          | 372 +++++++++++++++++++++++++++++++--
> > >  scripts/bpf_doc.py             |   2 +
> > >  tools/include/uapi/linux/bpf.h |  44 ++++
> > >  7 files changed, 654 insertions(+), 14 deletions(-)
> > >
> [...]
> > > +     for (i = 0; i < BPF_REG_SIZE; i++) {
> > > +             state->stack[spi].slot_type[i] = STACK_INVALID;
> > > +             state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> > > +     }
> > > +
> > > +     state->stack[spi].spilled_ptr.dynptr.type = 0;
> > > +     state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
> > > +
> > > +     state->stack[spi].spilled_ptr.dynptr.first_slot = 0;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int mark_as_dynptr_data(struct bpf_verifier_env *env, const struct bpf_func_proto *fn,
> > > +                            struct bpf_reg_state *regs)
> > > +{
> > > +     struct bpf_func_state *state = cur_func(env);
> > > +     struct bpf_reg_state *reg, *mem_reg = NULL;
> > > +     enum bpf_arg_type arg_type;
> > > +     u64 mem_size;
> > > +     u32 nr_slots;
> > > +     int i, spi;
> > > +
> > > +     /* We must protect against the case where a program tries to do something
> > > +      * like this:
> > > +      *
> > > +      * bpf_dynptr_from_mem(&ptr, sizeof(ptr), 0, &local);
> > > +      * bpf_dynptr_alloc(16, 0, &ptr);
> > > +      * bpf_dynptr_write(&local, 0, corrupt_data, sizeof(ptr));
> > > +      *
> > > +      * If ptr is a variable on the stack, we must mark the stack slot as
> > > +      * dynptr data when a local dynptr to it is created.
> > > +      */
> > > +     for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > > +             arg_type = fn->arg_type[i];
> > > +             reg = &regs[BPF_REG_1 + i];
> > > +
> > > +             if (base_type(arg_type) == ARG_PTR_TO_MEM) {
> > > +                     if (base_type(reg->type) == PTR_TO_STACK) {
> > > +                             mem_reg = reg;
> > > +                             continue;
> > > +                     }
> > > +                     /* if it's not a PTR_TO_STACK, then we don't need to
> > > +                      * mark anything since it can never be used as a dynptr.
> > > +                      * We can just return here since there will always be
> > > +                      * only one ARG_PTR_TO_MEM in fn.
> > > +                      */
> > > +                     return 0;
> >
> > I think the assumption here that NO_OBJ_REF flag reduces ARG_PTR_TO_MEM
> > to be stack, a pointer to packet or map value, right?
> > Since dynptr can only be on stack, map value and packet memory
> > cannot be used to store dynptr.
> > So bpf_dynptr_alloc(16, 0, &ptr); is not possible where &ptr
> > points to packet or map value?
> > So that's what 'return 0' above doing?
> > That's probably ok.
> >
> > Just thinking out loud:
> > bpf_dynptr_from_mem(&ptr, sizeof(ptr), 0, &local);
> > where &local is a dynptr on stack, but &ptr is a map value?
> > The lifetime of the memory tracked by dynptr is not going
> > to outlive program execution.
> > Probably ok too.
> >
> After our conversation, I will remove local dynptrs for now.


bpf_dynptr_from_mem(&ptr, sizeof(ptr), 0, &local) where ptr is
PTR_TO_MAP_VALUE is still ok. So it's only a special case of ptr being
PTR_TO_STACK that will be disallowed, right? It's still LOCAL type of
dynptr, it just can't point to memory on the stack.

> > > +             } else if (arg_type_is_mem_size(arg_type)) {
> > > +                     mem_size = roundup(reg->var_off.value, BPF_REG_SIZE);
> > > +             }
> > > +     }
> > > +
> > > +     if (!mem_reg || !mem_size) {
> > > +             verbose(env, "verifier internal error: invalid ARG_PTR_TO_MEM args for %s\n", __func__);
> > > +             return -EFAULT;
> > > +     }
> > > +
> > > +     spi = get_spi(mem_reg->off);
> > > +     if (!is_spi_bounds_valid(state, spi, mem_size)) {
> > > +             verbose(env, "verifier internal error: variable not initialized on stack in %s\n", __func__);
> > > +             return -EFAULT;
> > > +     }
> > > +
> > > +     nr_slots = mem_size / BPF_REG_SIZE;
> > > +     for (i = 0; i < nr_slots; i++)
> > > +             state->stack[spi - i].spilled_ptr.is_dynptr_data = true;
> >

[...]
