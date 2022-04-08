Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965FB4F9F78
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiDHWHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiDHWHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 18:07:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6B103BA3
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:04:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o16so7254469ljp.3
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAxAYM7H/KSd6xrHPHJEUMV0Q3QllEgoPqXLHY4N+7U=;
        b=FeGl0tpifMOUd8XLUNMpbiaF6Eu8HJqgsVnpnlknTFvLlIo3R1dvAx9+d90+XhbUfD
         su1PSAAMUY8SwdN8yI9hy3aL849KhZ8xeRNW5nC5g1O+hSepqxaOz6MSUQd1/0XU4rkQ
         07Ev+cOpXS5XPnUtv8zYogE1CKoB7S6DNbKB1VAoaETttfQ3mEzr5XgaReNjI+rADIz7
         VMp8rpNCX8pKgiPdN+UNtYLWzTnQkQ6kRmKlKszsEU1UDs5EHcJ9+V8qPIKoX/V4/ezx
         Rl3CZlmtA+ow59dJvSf7y/Afv8pzCX3Us7fmv+73ALS4nG3bnUvXyjjlWYVKmidIypjA
         ecnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAxAYM7H/KSd6xrHPHJEUMV0Q3QllEgoPqXLHY4N+7U=;
        b=PW/X+4nk0M4DBQaIsBecTUbTjbusfuxaTDstB0HusR37G600tH++HGUtvw4XXQlEuf
         vQx90M6UnBq9l0D5xv1sTcJ5uyidGL0/RpUww5uwUseGg3OT3LLxNMyXYpYLs8ngb3gP
         8mwTtEjQupvw015t16MtMTVT8ioOsvQxkekPTxn4OrZs12MpGOCCOl3NDNhwW+Vz3nSW
         WR1NWW87LMqjZV4kaCRm35ObJJnrhoGyi9uK9DweZMzY/vFofFjRr2HVmjQiC7eUVlJK
         K9Y+XpeMpN3LVnMprUC3goVE000ddu2ndwf48U7Fo+ZnPb35X6DPwOpjwD80RdwkKRvf
         igcw==
X-Gm-Message-State: AOAM532ybmf+/5TvDald9BJsiF6MCdOrjPuEjOzHX30J20iVTq8OulVA
        2ZC3ArYEvMRhwaOirqIoszdTHEfbgaMbphqua577gziEKbQ=
X-Google-Smtp-Source: ABdhPJzl7QJjMwnUFeKY/CqRK4pHnPY0pETFhD5l2p1aYLEV/dT7/TiVGIQOU0shJLM4LkL9HXed4Bcv7xrslpzZr60=
X-Received: by 2002:a2e:5845:0:b0:24b:56a7:48f2 with SMTP id
 x5-20020a2e5845000000b0024b56a748f2mr766646ljd.420.1649455492484; Fri, 08 Apr
 2022 15:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-4-joannekoong@fb.com>
 <CAEf4BzbRsA+JTP+4mqWpjRd_KEtaaM74ihz7RKGgpu_outhxTg@mail.gmail.com>
In-Reply-To: <CAEf4BzbRsA+JTP+4mqWpjRd_KEtaaM74ihz7RKGgpu_outhxTg@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 8 Apr 2022 15:04:41 -0700
Message-ID: <CAJnrk1Y8nE7n6PY9f7KBHH-P_ji3vAnuH5UP0r1fAk4OUTUZtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Add bpf_dynptr_from_mem, bpf_malloc, bpf_free
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Wed, Apr 6, 2022 at 3:23 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
> >
> > From: Joanne Koong <joannelkoong@gmail.com>
> >
> > This patch adds 3 new APIs and the bulk of the verifier work for
> > supporting dynamic pointers in bpf.
> >
> > There are different types of dynptrs. This patch starts with the most
> > basic ones, ones that reference a program's local memory
> > (eg a stack variable) and ones that reference memory that is dynamically
> > allocated on behalf of the program. If the memory is dynamically
> > allocated by the program, the program *must* free it before the program
> > exits. This is enforced by the verifier.
> >
> > The added APIs are:
> >
> > long bpf_dynptr_from_mem(void *data, u32 size, struct bpf_dynptr *ptr);
> > long bpf_malloc(u32 size, struct bpf_dynptr *ptr);
> > void bpf_free(struct bpf_dynptr *ptr);
> >
> > This patch sets up the verifier to support dynptrs. Dynptrs will always
> > reside on the program's stack frame. As such, their state is tracked
> > in their corresponding stack slot, which includes the type of dynptr
> > (DYNPTR_LOCAL vs. DYNPTR_MALLOC).
> >
> > When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
> > MEM_UNINIT), the stack slots corresponding to the frame pointer
> > where the dynptr resides at is marked as STACK_DYNPTR. For helper functions
> > that take in iniitalized dynptrs (such as the next patch in this series
> > which supports dynptr reads/writes), the verifier enforces that the
> > dynptr has been initialized by checking that their corresponding stack
> > slots have been marked as STACK_DYNPTR. Dynptr release functions
> > (eg bpf_free) will clear the stack slots. The verifier enforces at program
> > exit that there are no dynptr stack slots that need to be released.
> >
> > There are other constraints that are enforced by the verifier as
> > well, such as that the dynptr cannot be written to directly by the bpf
> > program or by non-dynptr helper functions. The last patch in this series
> > contains tests that trigger different cases that the verifier needs to
> > successfully reject.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf.h            |  74 ++++++++-
> >  include/linux/bpf_verifier.h   |  18 +++
> >  include/uapi/linux/bpf.h       |  40 +++++
> >  kernel/bpf/helpers.c           |  88 +++++++++++
> >  kernel/bpf/verifier.c          | 266 ++++++++++++++++++++++++++++++++-
> >  scripts/bpf_doc.py             |   2 +
> >  tools/include/uapi/linux/bpf.h |  40 +++++
> >  7 files changed, 521 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index cb9f42866cde..e0fcff9f2aee 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -346,7 +346,13 @@ enum bpf_type_flag {
> >
> >         MEM_RELEASE             = BIT(6 + BPF_BASE_TYPE_BITS),
> >
> > -       __BPF_TYPE_LAST_FLAG    = MEM_RELEASE,
> > +       /* DYNPTR points to a program's local memory (eg stack variable). */
> > +       DYNPTR_TYPE_LOCAL       = BIT(7 + BPF_BASE_TYPE_BITS),
> > +
> > +       /* DYNPTR points to dynamically allocated memory. */
> > +       DYNPTR_TYPE_MALLOC      = BIT(8 + BPF_BASE_TYPE_BITS),
> > +
> > +       __BPF_TYPE_LAST_FLAG    = DYNPTR_TYPE_MALLOC,
> >  };
> >
> >  /* Max number of base types. */
> > @@ -390,6 +396,7 @@ enum bpf_arg_type {
> >         ARG_PTR_TO_STACK,       /* pointer to stack */
> >         ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
> >         ARG_PTR_TO_TIMER,       /* pointer to bpf_timer */
> > +       ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for dynptr type */
> >         __BPF_ARG_TYPE_MAX,
> >
> >         /* Extended arg_types. */
> > @@ -2396,4 +2403,69 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
> >                         u32 **bin_buf, u32 num_args);
> >  void bpf_bprintf_cleanup(void);
> >
> > +/* the implementation of the opaque uapi struct bpf_dynptr */
> > +struct bpf_dynptr_kern {
> > +       u8 *data;
>
> nit: u8 * is too specific, it's not always "bytes" of data. Let's use `void *`?
Sounds great! My reason for going with u8 * instead of void * is that
void pointer arithmetic in C is invalid - but it seems like this isn't
something we have to worry about here since gcc is the default
compiler for linux and gcc allows it as an extension
>
> > +       /* The upper 4 bits are reserved. Bit 29 denotes whether the
> > +        * dynptr is read-only. Bits 30 - 32 denote the dynptr type.
> > +        */
>
> not essential, but I think using highest bit for read-only and then
> however many next upper bits for dynptr kind is a bit cleaner
> approach.
I'm happy with either - I was thinking if we have the uppermost bits
be dynptr kind, then that makes it easiest to get the dynptr type
(simply size >> DYNPTR_TYPE_SHIFT) whereas if the read-only bit is the
highest bit, then we also need to clear that out. But not a big deal
:)
>
> also it seems like normally bits are zero-indexed, so, pedantically,
> there is no bit 32, it's bit #31
>
> > +       u32 size;
> > +       u32 offset;
>
> Let's document the semantics of offset and size. E.g., if I have
> offset 4 and size 20, does it mean there were 24 bytes, but we ignore
> first 4 and can address next 20, or does it mean that there is 20
> bytes, we skip first 4 and have 16 addressable. Basically, usable size
> is just size of size - offset? That will change how/whether the size
> is adjusted when offset is moved.
>
> > +} __aligned(8);
> > +
> > +enum bpf_dynptr_type {
>
> it's a good idea to have default zero value to be BPF_DYNPTR_TYPE_INVALID
>
> > +       /* Local memory used by the bpf program (eg stack variable) */
> > +       BPF_DYNPTR_TYPE_LOCAL,
> > +       /* Memory allocated dynamically by the kernel for the dynptr */
> > +       BPF_DYNPTR_TYPE_MALLOC,
> > +};
> > +
> > +/* The upper 4 bits of dynptr->size are reserved. Consequently, the
> > + * maximum supported size is 2^28 - 1.
> > + */
> > +#define DYNPTR_MAX_SIZE        ((1UL << 28) - 1)
> > +#define DYNPTR_SIZE_MASK       0xFFFFFFF
> > +#define DYNPTR_TYPE_SHIFT      29
>
> I'm thinking that maybe we should start with reserving entire upper
> byte in size and offset to be on the safer side? And if 16MB of
> addressable memory blob isn't enough, we can always relaxed it later.
> WDYT?
>
This sounds great! I will make this change for v2
> > +
> > +static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
> > +{
> > +       return ptr->size >> DYNPTR_TYPE_SHIFT;
> > +}
> > +
> > +static inline void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_type type)
> > +{
> > +       ptr->size |= type << DYNPTR_TYPE_SHIFT;
> > +}
> > +
> > +static inline u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
> > +{
> > +       return ptr->size & DYNPTR_SIZE_MASK;
> > +}
> > +
> > +static inline int bpf_dynptr_check_size(u32 size)
> > +{
> > +       if (size == 0)
> > +               return -EINVAL;
>
> What's the downside of allowing size 0? Honest question. I'm wondering
> why prevent having dynptr pointing to an "empty slice"? It might be a
> useful feature in practice.
I don't see the use of dynptrs that point to something of size 0, so I
thought it'd be simplest to just return an -EINVAL if the user tries
to create one. I don't have a particular preference for handling this
though - especially if this will be a useful feature in the future,
then I agree we should just let the user create and use empty slices
if they wish to.
>
> > +
> > +       if (size > DYNPTR_MAX_SIZE)
> > +               return -E2BIG;
> > +
> > +       return 0;
> > +}
> > +
> > +static inline int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
> > +{
> > +       u32 capacity = bpf_dynptr_get_size(ptr) - ptr->offset;
> > +
> > +       if (len > capacity || offset > capacity - len)
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> > +void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
> > +                    u32 offset, u32 size);
> > +
> > +void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
> > +
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 7a01adc9e13f..bc0f105148f9 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -72,6 +72,18 @@ struct bpf_reg_state {
> >
> >                 u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> >
> > +               /* for dynptr stack slots */
> > +               struct {
> > +                       enum bpf_dynptr_type dynptr_type;
> > +                       /* A dynptr is 16 bytes so it takes up 2 stack slots.
> > +                        * We need to track which slot is the first slot
> > +                        * to protect against cases where the user may try to
> > +                        * pass in an address starting at the second slot of the
> > +                        * dynptr.
> > +                        */
> > +                       bool dynptr_first_slot;
> > +               };
>
> why not
>
> struct {
>     enum bpf_dynptr_type type;
>     bool first_lot;
> } dynptr;
>
> ? I think it's cleaner grouping
Agreed! I will make this change for v2
>
[...]
>
> > + *     Description
> > + *             Dynamically allocate memory of *size* bytes.
> > + *
> > + *             Every call to bpf_malloc must have a corresponding
> > + *             bpf_free, regardless of whether the bpf_malloc
> > + *             succeeded.
> > + *
> > + *             The maximum *size* supported is DYNPTR_MAX_SIZE.
> > + *     Return
> > + *             0 on success, -ENOMEM if there is not enough memory for the
> > + *             allocation, -EINVAL if the size is 0 or exceeds DYNPTR_MAX_SIZE.
> > + *
> > + * void bpf_free(struct bpf_dynptr *ptr)
>
> thinking about the next patch set that will add storing this malloc
> dynptr into the map, bpf_free() will be a lie, right? As it will only
> decrement a refcnt, not necessarily free it, right? So maybe just
> generic bpf_dynptr_put() or bpf_malloc_put() or something like that is
> a bit more "truthful"?
I like the simplicity of bpf_free(), but I can see how that might be
confusing. What are your thoughts on "bpf_dynptr_free()"? Since when
we get into dynptrs that are stored in maps vs. dynptrs stored
locally, calling bpf_dynptr_free() frees (invalidates) your local
dynptr even if it doesn't free the underlying memory if it still has
valid refcounts on it? To me, "malloc" and "_free" go more intuitively
together as a pair.
>
> > + *     Description
> > + *             Free memory allocated by bpf_malloc.
> > + *
> > + *             After this operation, *ptr* will be an invalidated dynptr.
> > + *     Return
> > + *             Void.
> >   */
[...]
> > +const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
> > +       .func           = bpf_dynptr_from_mem,
> > +       .gpl_only       = false,
> > +       .ret_type       = RET_INTEGER,
> > +       .arg1_type      = ARG_PTR_TO_MEM,
>
> need to think what to do with uninit stack slots. Do we need
> bpf_dnptr_from_uninit_mem() or we just allow ARG_PTR_TO_MEM |
> MEM_UNINIT here?
I think we can just change this to ARG_PTR_TO_MEM | MEM_UNINIT.
>
> > +       .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
> > +       .arg3_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
> > +};
> > +
> > +BPF_CALL_2(bpf_malloc, u32, size, struct bpf_dynptr_kern *, ptr)
> > +{
> > +       void *data;
> > +       int err;
> > +
> > +       err = bpf_dynptr_check_size(size);
> > +       if (err) {
> > +               bpf_dynptr_set_null(ptr);
> > +               return err;
> > +       }
> > +
> > +       data = kmalloc(size, GFP_ATOMIC);
>
> we have this fancy logic now to allow non-atomic allocation inside
> sleepable programs, can we use that here as well? In sleepable mode it
> would be nice to wait for malloc() to grab necessary memory, if
> possible.
Agreed - I'm planning to do this in a later "dynptr optimizations"
patchset (which will also include inlining BPF instructions for some
of the helper functions)
>
> > +       if (!data) {
> > +               bpf_dynptr_set_null(ptr);
> > +               return -ENOMEM;
> > +       }
> > +
>
> so.... kmalloc() doesn't zero initialize the memory. I think it's a
> great property (which we can later modify with flags, if necessary),
> so I'd do zero-initialization by default. we can keep calling it
> bpf_malloc() instead of bpf_zalloc(), of course.
>
[...]
> > +static inline int get_spi(s32 off)
> > +{
> > +       return (-off - 1) / BPF_REG_SIZE;
> > +}
> > +
> > +static bool check_spi_bounds(struct bpf_func_state *state, int spi, u32 nr_slots)
>
> "check_xxx"/"validate_xxx" pattern has ambiguity when it comes to
> interpreting its return value. In some cases it would be 0 for success
> and <0 for error, in this it's true/false where probably true meaning
> all good. It's unfortunate to have to think about this when reading
> code. If you call it something like "is_stack_range_valid" it would be
> much more natural to read and reason about, IMO.
Great point! I'll change this naming for v2
>
> BTW, what does "spi" stand for? "stack pointer index"? slot_idx?
It's not formally documented anywhere but I assume it's short for
"stack pointer index".
>
> > +{
> > +       int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> > +
> > +       return allocated_slots > spi && nr_slots - 1 <= spi;
>
> ok, this is personal preferences, but it took me considerable time to
> try to understand what's being checked here (this backwards grow of
> slot indices also threw me off). But seems like we have a range of
> slots that are calculated as [spi - nr_slots + 1, spi] and we want to
> check that it's within [0, allocated_stack), so most straightforward
> way would be:
>
> return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
>
> And I'd definitely leave a comment about this whole index grows
> downwards (it's not immediately obvious even if you know that indices
> are derived from negative stack offsets)
Awesome, I will make these edits for v2
>
[...]
> > +       switch (type) {
> > +       case DYNPTR_TYPE_LOCAL:
> > +               *dynptr_type = BPF_DYNPTR_TYPE_LOCAL;
> > +               break;
> > +       case DYNPTR_TYPE_MALLOC:
> > +               *dynptr_type = BPF_DYNPTR_TYPE_MALLOC;
> > +               break;
> > +       default:
> > +               /* Can't have more than one type set and can't have no
> > +                * type set
> > +                */
> > +               return -EINVAL;
>
> see above about BPF_DYNPTR_TYPE_INVALID, with that you don't have to
> use out parameter, just return enum bpf_dynptr_type directly with
> BPF_DYNPTR_TYPE_INVALID marking an error
Nice! I love this suggestion - it makes this a lot smoother.
>
> > +       }
> > +
> > +       return 0;
> > +}
> > +
[...]
> > +
> > +/* Check if the dynptr argument is a proper initialized dynptr */
> > +static bool check_dynptr_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                             enum bpf_arg_type arg_type)
>
> is_dynptr_valid()? You are not checking if it's just initialized but
> also that it matches arg_type, right? Also see my rambling about
> check_xxx naming
I will rename this to is_dynptr_init_valid(). is_dynptr_valid() might
be too generic - for example, a valid dynptr should also have its
stack slots marked accordingly, which isn't true here since this
dynptr is uninitialized. I think is_dynptr_init_valid() will be
clearest
>
> > +{
> > +       struct bpf_func_state *state = func(env, reg);
> > +       enum bpf_dynptr_type expected_type;
> > +       int spi, err;
> > +
> > +       /* Can't pass in a dynptr at a weird offset */
> > +       if (reg->off % BPF_REG_SIZE)
> > +               return false;
> > +
> > +       spi = get_spi(reg->off);
> > +
> > +       if (!check_spi_bounds(state, spi, BPF_DYNPTR_NR_SLOTS))
> > +               return false;
> > +
> > +       if (!state->stack[spi].spilled_ptr.dynptr_first_slot)
> > +               return false;
> > +
> > +       if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
> > +               return false;
> > +
> > +       /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> > +       if (arg_type == ARG_PTR_TO_DYNPTR)
> > +               return true;
> > +
> > +       err = arg_to_dynptr_type(arg_type, &expected_type);
> > +       if (unlikely(err))
> > +               return err;
> > +
> > +       return state->stack[spi].spilled_ptr.dynptr_type == expected_type;
> > +}
[...]
> > +/*
> > + * Determines whether the id used for reference tracking is held in a stack slot
> > + * or in a register
> > + */
> > +static bool id_in_stack_slot(enum bpf_arg_type arg_type)
>
> is_ or has_ is a good idea for such bool-returning helpers (similarly
> for stack_access_into_dynptr above), otherwise it reads like a verb
> and command to do something
>
> but looking few lines below, if (arg_type_is_dynptr()) would be
> clearer than extra wrapper function, not sure what's the purpose of
> the helper
My thinking behind this extra wrapper function was that it'd be more
extensible in the future if there are other types that will store
their id in the stack slot. But I think I'm over-optimizing here :)
I'll remove this wrapper function
>
[...]
> > @@ -5572,6 +5758,40 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                 bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
> >
> >                 err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> > +       } else if (arg_type_is_dynptr(arg_type)) {
> > +               bool initialized = check_dynptr_init(env, reg, arg_type);
> > +
> > +               if (type_is_uninit_mem(arg_type)) {
> > +                       if (initialized) {
> > +                               verbose(env, "Arg #%d dynptr cannot be an initialized dynptr\n",
> > +                                       arg + 1);
> > +                               return -EINVAL;
> > +                       }
> > +                       meta->raw_mode = true;
> > +                       err = check_helper_mem_access(env, regno, BPF_DYNPTR_SIZE, false, meta);
> > +                       /* For now, we do not allow dynptrs to point to existing
> > +                        * refcounted memory
> > +                        */
> > +                       if (reg_type_may_be_refcounted_or_null(regs[BPF_REG_1].type)) {
>
> hard-coded BPF_REG_1?

I'm viewing this as a temporary line because one of the patches in a
later dynptr patchset will enable support for local dynptrs to point
to existing refcounted memory. The alternative is to add a new
bpf_type_flag like NO_REFCOUNT and then remove that flag later. What
are your thoughts?
>
> > +                               verbose(env, "Arg #%d dynptr memory cannot be potentially refcounted\n",
> > +                                       arg + 1);
> > +                               return -EINVAL;
> > +                       }
> > +               } else {
> > +                       if (!initialized) {
> > +                               char *err_extra = "";
>
> const char *
>
> > +
> > +                               if (arg_type & DYNPTR_TYPE_LOCAL)
> > +                                       err_extra = "local ";
> > +                               else if (arg_type & DYNPTR_TYPE_MALLOC)
> > +                                       err_extra = "malloc ";
> > +                               verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> > +                                       err_extra, arg + 1);
>
> what if helper accepts two or more different types of dynptr?
Currently, bpf_dynptr_read/write accept any type of dynptr so they
don't set any dynptr type flag, which means this error would just
print "Expected an initialized dynptr as arg...". But you're right
that in the future, there can be some API that accepts only a subset
(eg mallocs and ringbuffers and not local dynptrs); in this case,
maybe the simplest is just to return a generic "Expected an
initialized dynptr as arg...". Do you think this suffices or do you
think it'd be worth the effort to print out the different types of
initialized dynptrs it expects?
>
> > +                               return -EINVAL;
> > +                       }
> > +                       if (type_is_release_mem(arg_type))
> > +                               err = unmark_stack_slots_dynptr(env, reg);
> > +               }
> >         } else if (arg_type_is_alloc_size(arg_type)) {
> >                 if (!tnum_is_const(reg->var_off)) {
> >                         verbose(env, "R%d is not a known constant'\n",
>
> [...]
Thanks for your feedback, Andrii!!
