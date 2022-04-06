Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7E04F6DCC
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 00:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiDFWZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 18:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiDFWZU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 18:25:20 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB51CC400
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 15:23:21 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k25so4709778iok.8
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 15:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwlyXuHmKUbRGaEis2vNRZrgSNXnFnAI4wqDRunnvcY=;
        b=hBVc99n5is3vVCJdVOuEwwTK3yZGKJZiXkuQdwXLrDLh6N8nXdP0B75auSAgrBQ7qs
         T8EbizOD7F9u3mkYn8xP0C9FKHMFYPR/2ebl2kypbtkS+F11JJDPixtFPrFtIFxJMMzB
         LXRm+7ND7MNskeLlgn2M6qDVnaC6VMJw2ZXRgQ6zYX0SznG2B8m0o/HTImh3KV0CXYVU
         P6xghQjmd+3Ilt5Z0gBVBx9nGbWOsrLMGGl2DusbJd4NIvYcr4GJnlWksQo0fiDJTwGx
         Hm9jkKh9lgOYbROmO7T66uh8u96jEJrS145GdVXGqfJhZ3fwVqg6AT+NjGm1wuYok0wm
         pcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwlyXuHmKUbRGaEis2vNRZrgSNXnFnAI4wqDRunnvcY=;
        b=Uqg7oopCcTzIHNTkwFVBslbBLZSNNzjJU3ZWSXrnHt5Gy4DuSYe4gfY1qL75HJH/A9
         +i4JLHyVweqL9G0ioS+l0iN/yneoGf+uxr38gWlI/EOJi3DHSCeNhcGJYtDbEGXDXw6p
         7EWNNpMj5zZjNnS25BTQCxrqOlJkh0XwgFM551NQ9721vzqIZJUV1RKWgyP65WxN4kRb
         EITYkOzJvFwleaUtZZ60kPFLymQNj+JtaLKH5tBvbuV75NA3WsXpDNqyilm0QUkRYejC
         Ohi5lIvdCfSIfN3IL8uA1Em2KnMgnyjTpgxh43MrDXhkltmXKdCoFOOu+xqmU6gi9ELK
         hH6g==
X-Gm-Message-State: AOAM531E0A5cqpjQgClxGr9xiHm8UFwskv2RyiVNR8mqC6sIQ9uCUGbo
        ZNgzvUcXKDUv1Mp7iqsuZRUMXafbUHJy7HzILe13g1tUllM=
X-Google-Smtp-Source: ABdhPJytlJ2E2wiFVZxeaD94tzZlU6vp2WcW801zAJTwn6iSZsa7U78d70GfraaQ0imfOsaSL/jXtbb3l0vxmc+PHao=
X-Received: by 2002:a05:6638:772:b0:319:e4eb:adb with SMTP id
 y18-20020a056638077200b00319e4eb0adbmr5782963jad.237.1649283800264; Wed, 06
 Apr 2022 15:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-4-joannekoong@fb.com>
In-Reply-To: <20220402015826.3941317-4-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 15:23:09 -0700
Message-ID: <CAEf4BzbRsA+JTP+4mqWpjRd_KEtaaM74ihz7RKGgpu_outhxTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Add bpf_dynptr_from_mem, bpf_malloc, bpf_free
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> This patch adds 3 new APIs and the bulk of the verifier work for
> supporting dynamic pointers in bpf.
>
> There are different types of dynptrs. This patch starts with the most
> basic ones, ones that reference a program's local memory
> (eg a stack variable) and ones that reference memory that is dynamically
> allocated on behalf of the program. If the memory is dynamically
> allocated by the program, the program *must* free it before the program
> exits. This is enforced by the verifier.
>
> The added APIs are:
>
> long bpf_dynptr_from_mem(void *data, u32 size, struct bpf_dynptr *ptr);
> long bpf_malloc(u32 size, struct bpf_dynptr *ptr);
> void bpf_free(struct bpf_dynptr *ptr);
>
> This patch sets up the verifier to support dynptrs. Dynptrs will always
> reside on the program's stack frame. As such, their state is tracked
> in their corresponding stack slot, which includes the type of dynptr
> (DYNPTR_LOCAL vs. DYNPTR_MALLOC).
>
> When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
> MEM_UNINIT), the stack slots corresponding to the frame pointer
> where the dynptr resides at is marked as STACK_DYNPTR. For helper functions
> that take in iniitalized dynptrs (such as the next patch in this series
> which supports dynptr reads/writes), the verifier enforces that the
> dynptr has been initialized by checking that their corresponding stack
> slots have been marked as STACK_DYNPTR. Dynptr release functions
> (eg bpf_free) will clear the stack slots. The verifier enforces at program
> exit that there are no dynptr stack slots that need to be released.
>
> There are other constraints that are enforced by the verifier as
> well, such as that the dynptr cannot be written to directly by the bpf
> program or by non-dynptr helper functions. The last patch in this series
> contains tests that trigger different cases that the verifier needs to
> successfully reject.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            |  74 ++++++++-
>  include/linux/bpf_verifier.h   |  18 +++
>  include/uapi/linux/bpf.h       |  40 +++++
>  kernel/bpf/helpers.c           |  88 +++++++++++
>  kernel/bpf/verifier.c          | 266 ++++++++++++++++++++++++++++++++-
>  scripts/bpf_doc.py             |   2 +
>  tools/include/uapi/linux/bpf.h |  40 +++++
>  7 files changed, 521 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cb9f42866cde..e0fcff9f2aee 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -346,7 +346,13 @@ enum bpf_type_flag {
>
>         MEM_RELEASE             = BIT(6 + BPF_BASE_TYPE_BITS),
>
> -       __BPF_TYPE_LAST_FLAG    = MEM_RELEASE,
> +       /* DYNPTR points to a program's local memory (eg stack variable). */
> +       DYNPTR_TYPE_LOCAL       = BIT(7 + BPF_BASE_TYPE_BITS),
> +
> +       /* DYNPTR points to dynamically allocated memory. */
> +       DYNPTR_TYPE_MALLOC      = BIT(8 + BPF_BASE_TYPE_BITS),
> +
> +       __BPF_TYPE_LAST_FLAG    = DYNPTR_TYPE_MALLOC,
>  };
>
>  /* Max number of base types. */
> @@ -390,6 +396,7 @@ enum bpf_arg_type {
>         ARG_PTR_TO_STACK,       /* pointer to stack */
>         ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
>         ARG_PTR_TO_TIMER,       /* pointer to bpf_timer */
> +       ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for dynptr type */
>         __BPF_ARG_TYPE_MAX,
>
>         /* Extended arg_types. */
> @@ -2396,4 +2403,69 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
>                         u32 **bin_buf, u32 num_args);
>  void bpf_bprintf_cleanup(void);
>
> +/* the implementation of the opaque uapi struct bpf_dynptr */
> +struct bpf_dynptr_kern {
> +       u8 *data;

nit: u8 * is too specific, it's not always "bytes" of data. Let's use `void *`?

> +       /* The upper 4 bits are reserved. Bit 29 denotes whether the
> +        * dynptr is read-only. Bits 30 - 32 denote the dynptr type.
> +        */

not essential, but I think using highest bit for read-only and then
however many next upper bits for dynptr kind is a bit cleaner
approach.

also it seems like normally bits are zero-indexed, so, pedantically,
there is no bit 32, it's bit #31

> +       u32 size;
> +       u32 offset;

Let's document the semantics of offset and size. E.g., if I have
offset 4 and size 20, does it mean there were 24 bytes, but we ignore
first 4 and can address next 20, or does it mean that there is 20
bytes, we skip first 4 and have 16 addressable. Basically, usable size
is just size of size - offset? That will change how/whether the size
is adjusted when offset is moved.

> +} __aligned(8);
> +
> +enum bpf_dynptr_type {

it's a good idea to have default zero value to be BPF_DYNPTR_TYPE_INVALID

> +       /* Local memory used by the bpf program (eg stack variable) */
> +       BPF_DYNPTR_TYPE_LOCAL,
> +       /* Memory allocated dynamically by the kernel for the dynptr */
> +       BPF_DYNPTR_TYPE_MALLOC,
> +};
> +
> +/* The upper 4 bits of dynptr->size are reserved. Consequently, the
> + * maximum supported size is 2^28 - 1.
> + */
> +#define DYNPTR_MAX_SIZE        ((1UL << 28) - 1)
> +#define DYNPTR_SIZE_MASK       0xFFFFFFF
> +#define DYNPTR_TYPE_SHIFT      29

I'm thinking that maybe we should start with reserving entire upper
byte in size and offset to be on the safer side? And if 16MB of
addressable memory blob isn't enough, we can always relaxed it later.
WDYT?

> +
> +static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
> +{
> +       return ptr->size >> DYNPTR_TYPE_SHIFT;
> +}
> +
> +static inline void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_type type)
> +{
> +       ptr->size |= type << DYNPTR_TYPE_SHIFT;
> +}
> +
> +static inline u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
> +{
> +       return ptr->size & DYNPTR_SIZE_MASK;
> +}
> +
> +static inline int bpf_dynptr_check_size(u32 size)
> +{
> +       if (size == 0)
> +               return -EINVAL;

What's the downside of allowing size 0? Honest question. I'm wondering
why prevent having dynptr pointing to an "empty slice"? It might be a
useful feature in practice.

> +
> +       if (size > DYNPTR_MAX_SIZE)
> +               return -E2BIG;
> +
> +       return 0;
> +}
> +
> +static inline int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
> +{
> +       u32 capacity = bpf_dynptr_get_size(ptr) - ptr->offset;
> +
> +       if (len > capacity || offset > capacity - len)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
> +                    u32 offset, u32 size);
> +
> +void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7a01adc9e13f..bc0f105148f9 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -72,6 +72,18 @@ struct bpf_reg_state {
>
>                 u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
>
> +               /* for dynptr stack slots */
> +               struct {
> +                       enum bpf_dynptr_type dynptr_type;
> +                       /* A dynptr is 16 bytes so it takes up 2 stack slots.
> +                        * We need to track which slot is the first slot
> +                        * to protect against cases where the user may try to
> +                        * pass in an address starting at the second slot of the
> +                        * dynptr.
> +                        */
> +                       bool dynptr_first_slot;
> +               };

why not

struct {
    enum bpf_dynptr_type type;
    bool first_lot;
} dynptr;

? I think it's cleaner grouping

> +
>                 /* Max size from any of the above. */
>                 struct {
>                         unsigned long raw1;
> @@ -174,9 +186,15 @@ enum bpf_stack_slot_type {
>         STACK_SPILL,      /* register spilled into stack */
>         STACK_MISC,       /* BPF program wrote some data into this slot */
>         STACK_ZERO,       /* BPF program wrote constant zero */
> +       /* A dynptr is stored in this stack slot. The type of dynptr
> +        * is stored in bpf_stack_state->spilled_ptr.type
> +        */
> +       STACK_DYNPTR,
>  };
>
>  #define BPF_REG_SIZE 8 /* size of eBPF register in bytes */
> +#define BPF_DYNPTR_SIZE 16 /* size of a struct bpf_dynptr in bytes */
> +#define BPF_DYNPTR_NR_SLOTS 2

#define BPF_DYNPTR_SIZE sizeof(struct bpf_dynptr_kern)
#define BPF_DYNPTR_NR_SLOTS BPF_DYNPTR_SIZE / BPF_REG_SIZE

?

>
>  struct bpf_stack_state {
>         struct bpf_reg_state spilled_ptr;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d14b10b85e51..6a57d8a1b882 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5143,6 +5143,38 @@ union bpf_attr {
>   *             The **hash_algo** is returned on success,
>   *             **-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
>   *             invalid arguments are passed.
> + *
> + * long bpf_dynptr_from_mem(void *data, u32 size, struct bpf_dynptr *ptr)
> + *     Description
> + *             Get a dynptr to local memory *data*.
> + *
> + *             For a dynptr to a dynamic memory allocation, please use bpf_malloc
> + *             instead.
> + *
> + *             The maximum *size* supported is DYNPTR_MAX_SIZE.
> + *     Return
> + *             0 on success or -EINVAL if the size is 0 or exceeds DYNPTR_MAX_SIZE.

Isn't it a -E2BIG for too big size?

> + *
> + * long bpf_malloc(u32 size, struct bpf_dynptr *ptr)

I think at least for bpf_malloc() we should add u64 flags argument for
future extensibility. Also API design-wise, while I get why *ptr is at
the end because it's a out parameter, it feels a bit unnatural to have
flags before the pointer itself. Maybe let's just have ptr as first
argument for all constructor APIs consistently, even though it's an
out parameter?

I'd also add flags to bpf_dynpt_from_mem() as well for extensibility.

> + *     Description
> + *             Dynamically allocate memory of *size* bytes.
> + *
> + *             Every call to bpf_malloc must have a corresponding
> + *             bpf_free, regardless of whether the bpf_malloc
> + *             succeeded.
> + *
> + *             The maximum *size* supported is DYNPTR_MAX_SIZE.
> + *     Return
> + *             0 on success, -ENOMEM if there is not enough memory for the
> + *             allocation, -EINVAL if the size is 0 or exceeds DYNPTR_MAX_SIZE.
> + *
> + * void bpf_free(struct bpf_dynptr *ptr)

thinking about the next patch set that will add storing this malloc
dynptr into the map, bpf_free() will be a lie, right? As it will only
decrement a refcnt, not necessarily free it, right? So maybe just
generic bpf_dynptr_put() or bpf_malloc_put() or something like that is
a bit more "truthful"?

> + *     Description
> + *             Free memory allocated by bpf_malloc.
> + *
> + *             After this operation, *ptr* will be an invalidated dynptr.
> + *     Return
> + *             Void.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5339,6 +5371,9 @@ union bpf_attr {
>         FN(copy_from_user_task),        \
>         FN(skb_set_tstamp),             \
>         FN(ima_file_hash),              \
> +       FN(dynptr_from_mem),            \
> +       FN(malloc),                     \
> +       FN(free),                       \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> @@ -6486,6 +6521,11 @@ struct bpf_timer {
>         __u64 :64;
>  } __attribute__((aligned(8)));
>
> +struct bpf_dynptr {
> +       __u64 :64;
> +       __u64 :64;
> +} __attribute__((aligned(8)));
> +
>  struct bpf_sysctl {
>         __u32   write;          /* Sysctl is being read (= 0) or written (= 1).
>                                  * Allows 1,2,4-byte read, but no write.
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cc6d480c5c23..ed5a7d9d0a18 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1374,6 +1374,88 @@ void bpf_timer_cancel_and_free(void *val)
>         kfree(t);
>  }
>
> +void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
> +                    u32 offset, u32 size)
> +{
> +       ptr->data = data;
> +       ptr->offset = offset;
> +       ptr->size = size;
> +       bpf_dynptr_set_type(ptr, type);
> +}
> +
> +void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
> +{
> +       memset(ptr, 0, sizeof(*ptr));
> +}
> +
> +BPF_CALL_3(bpf_dynptr_from_mem, void *, data, u32, size, struct bpf_dynptr_kern *, ptr)
> +{
> +       int err;
> +
> +       err = bpf_dynptr_check_size(size);
> +       if (err) {
> +               bpf_dynptr_set_null(ptr);
> +               return err;
> +       }
> +
> +       bpf_dynptr_init(ptr, data, BPF_DYNPTR_TYPE_LOCAL, 0, size);
> +
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
> +       .func           = bpf_dynptr_from_mem,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_MEM,

need to think what to do with uninit stack slots. Do we need
bpf_dnptr_from_uninit_mem() or we just allow ARG_PTR_TO_MEM |
MEM_UNINIT here?

> +       .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
> +       .arg3_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
> +};
> +
> +BPF_CALL_2(bpf_malloc, u32, size, struct bpf_dynptr_kern *, ptr)
> +{
> +       void *data;
> +       int err;
> +
> +       err = bpf_dynptr_check_size(size);
> +       if (err) {
> +               bpf_dynptr_set_null(ptr);
> +               return err;
> +       }
> +
> +       data = kmalloc(size, GFP_ATOMIC);

we have this fancy logic now to allow non-atomic allocation inside
sleepable programs, can we use that here as well? In sleepable mode it
would be nice to wait for malloc() to grab necessary memory, if
possible.

> +       if (!data) {
> +               bpf_dynptr_set_null(ptr);
> +               return -ENOMEM;
> +       }
> +

so.... kmalloc() doesn't zero initialize the memory. I think it's a
great property (which we can later modify with flags, if necessary),
so I'd do zero-initialization by default. we can keep calling it
bpf_malloc() instead of bpf_zalloc(), of course.


> +       bpf_dynptr_init(ptr, data, BPF_DYNPTR_TYPE_MALLOC, 0, size);
> +
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_malloc_proto = {
> +       .func           = bpf_malloc,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_ANYTHING,
> +       .arg2_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | MEM_UNINIT,
> +};
> +
> +BPF_CALL_1(bpf_free, struct bpf_dynptr_kern *, dynptr)
> +{
> +       kfree(dynptr->data);
> +       bpf_dynptr_set_null(dynptr);
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_free_proto = {
> +       .func           = bpf_free,
> +       .gpl_only       = false,
> +       .ret_type       = RET_VOID,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | MEM_RELEASE,
> +};
> +
>  const struct bpf_func_proto bpf_get_current_task_proto __weak;
>  const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
>  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> @@ -1426,6 +1508,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_loop_proto;
>         case BPF_FUNC_strncmp:
>                 return &bpf_strncmp_proto;
> +       case BPF_FUNC_dynptr_from_mem:
> +               return &bpf_dynptr_from_mem_proto;
> +       case BPF_FUNC_malloc:
> +               return &bpf_malloc_proto;
> +       case BPF_FUNC_free:
> +               return &bpf_free_proto;
>         default:
>                 break;
>         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 80e53303713e..cb3bcb54d4b4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -479,6 +479,11 @@ static bool type_is_release_mem(u32 type)
>         return type & MEM_RELEASE;
>  }
>
> +static bool type_is_uninit_mem(u32 type)
> +{
> +       return type & MEM_UNINIT;
> +}
> +

ditto about the need for a helper

>  static bool may_be_acquire_function(enum bpf_func_id func_id)
>  {
>         return func_id == BPF_FUNC_sk_lookup_tcp ||
> @@ -583,6 +588,7 @@ static char slot_type_char[] = {
>         [STACK_SPILL]   = 'r',
>         [STACK_MISC]    = 'm',
>         [STACK_ZERO]    = '0',
> +       [STACK_DYNPTR]  = 'd',
>  };
>
>  static void print_liveness(struct bpf_verifier_env *env,
> @@ -598,6 +604,18 @@ static void print_liveness(struct bpf_verifier_env *env,
>                 verbose(env, "D");
>  }
>
> +static inline int get_spi(s32 off)
> +{
> +       return (-off - 1) / BPF_REG_SIZE;
> +}
> +
> +static bool check_spi_bounds(struct bpf_func_state *state, int spi, u32 nr_slots)

"check_xxx"/"validate_xxx" pattern has ambiguity when it comes to
interpreting its return value. In some cases it would be 0 for success
and <0 for error, in this it's true/false where probably true meaning
all good. It's unfortunate to have to think about this when reading
code. If you call it something like "is_stack_range_valid" it would be
much more natural to read and reason about, IMO.

BTW, what does "spi" stand for? "stack pointer index"? slot_idx?

> +{
> +       int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> +
> +       return allocated_slots > spi && nr_slots - 1 <= spi;

ok, this is personal preferences, but it took me considerable time to
try to understand what's being checked here (this backwards grow of
slot indices also threw me off). But seems like we have a range of
slots that are calculated as [spi - nr_slots + 1, spi] and we want to
check that it's within [0, allocated_stack), so most straightforward
way would be:

return spi - nr_slots + 1 >= 0 && spi < allocated_slots;

And I'd definitely leave a comment about this whole index grows
downwards (it's not immediately obvious even if you know that indices
are derived from negative stack offsets)

> +}
> +
>  static struct bpf_func_state *func(struct bpf_verifier_env *env,
>                                    const struct bpf_reg_state *reg)
>  {
> @@ -649,6 +667,133 @@ static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
>         env->scratched_stack_slots = ~0ULL;
>  }
>
> +static int arg_to_dynptr_type(enum bpf_arg_type arg_type, enum bpf_dynptr_type *dynptr_type)
> +{
> +       int type = arg_type & (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_MALLOC);

maybe let's define DYNPTR_TYPE_MASK that can be updated as we add new
types of dynptr?

> +
> +       switch (type) {
> +       case DYNPTR_TYPE_LOCAL:
> +               *dynptr_type = BPF_DYNPTR_TYPE_LOCAL;
> +               break;
> +       case DYNPTR_TYPE_MALLOC:
> +               *dynptr_type = BPF_DYNPTR_TYPE_MALLOC;
> +               break;
> +       default:
> +               /* Can't have more than one type set and can't have no
> +                * type set
> +                */
> +               return -EINVAL;

see above about BPF_DYNPTR_TYPE_INVALID, with that you don't have to
use out parameter, just return enum bpf_dynptr_type directly with
BPF_DYNPTR_TYPE_INVALID marking an error

> +       }
> +
> +       return 0;
> +}
> +
> +static bool dynptr_type_refcounted(struct bpf_func_state *state, int spi)

if you pass enum bpf_dynptr_type directly instead of spi this function
will be more generic and won't combine two separate functions
(fetching stack state and checking if dynptr is refcounter)

> +{
> +       enum bpf_dynptr_type type = state->stack[spi].spilled_ptr.dynptr_type;
> +
> +       return type == BPF_DYNPTR_TYPE_MALLOC;
> +}
> +
> +static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                                  enum bpf_arg_type arg_type)
> +{
> +       struct bpf_func_state *state = cur_func(env);
> +       enum bpf_dynptr_type type;
> +       int spi, i, err;
> +
> +       spi = get_spi(reg->off);
> +
> +       if (!check_spi_bounds(state, spi, BPF_DYNPTR_NR_SLOTS))
> +               return -EINVAL;
> +
> +       err = arg_to_dynptr_type(arg_type, &type);
> +       if (unlikely(err))

why unlikely()? don't micro optimize, let compiler do its job

> +               return err;
> +
> +       for (i = 0; i < BPF_REG_SIZE; i++) {
> +               state->stack[spi].slot_type[i] = STACK_DYNPTR;
> +               state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
> +       }
> +
> +       state->stack[spi].spilled_ptr.dynptr_type = type;
> +       state->stack[spi - 1].spilled_ptr.dynptr_type = type;
> +
> +       state->stack[spi].spilled_ptr.dynptr_first_slot = true;
> +
> +       return 0;
> +}
> +
> +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +{
> +       struct bpf_func_state *state = func(env, reg);
> +       int spi, i;
> +
> +       spi = get_spi(reg->off);
> +
> +       if (!check_spi_bounds(state, spi, BPF_DYNPTR_NR_SLOTS))
> +               return -EINVAL;
> +
> +       for (i = 0; i < BPF_REG_SIZE; i++) {
> +               state->stack[spi].slot_type[i] = STACK_INVALID;
> +               state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> +       }
> +
> +       state->stack[spi].spilled_ptr.dynptr_type = 0;
> +       state->stack[spi].spilled_ptr.dynptr_first_slot = 0;
> +       state->stack[spi - 1].spilled_ptr.dynptr_type = 0;
> +
> +       return 0;
> +}
> +
> +/* Check if the dynptr argument is a proper initialized dynptr */
> +static bool check_dynptr_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                             enum bpf_arg_type arg_type)

is_dynptr_valid()? You are not checking if it's just initialized but
also that it matches arg_type, right? Also see my rambling about
check_xxx naming

> +{
> +       struct bpf_func_state *state = func(env, reg);
> +       enum bpf_dynptr_type expected_type;
> +       int spi, err;
> +
> +       /* Can't pass in a dynptr at a weird offset */
> +       if (reg->off % BPF_REG_SIZE)
> +               return false;
> +
> +       spi = get_spi(reg->off);
> +
> +       if (!check_spi_bounds(state, spi, BPF_DYNPTR_NR_SLOTS))
> +               return false;
> +
> +       if (!state->stack[spi].spilled_ptr.dynptr_first_slot)
> +               return false;
> +
> +       if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
> +               return false;
> +
> +       /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> +       if (arg_type == ARG_PTR_TO_DYNPTR)
> +               return true;
> +
> +       err = arg_to_dynptr_type(arg_type, &expected_type);
> +       if (unlikely(err))
> +               return err;
> +
> +       return state->stack[spi].spilled_ptr.dynptr_type == expected_type;
> +}
> +
> +static bool stack_access_into_dynptr(struct bpf_func_state *state, int spi, int size)
> +{
> +       int nr_slots, i;
> +
> +       nr_slots = min(roundup(size, BPF_REG_SIZE) / BPF_REG_SIZE, spi + 1);
> +

this min(..., spi + 1) looks a bit like papering over access out of
stack... if it's checked somewhere else, we can just assume it's not
happening, if not, we should probably error out with a different
message (it's no about dynptr anymore)

> +       for (i = 0; i < nr_slots; i++) {
> +               if (state->stack[spi - i].slot_type[0] == STACK_DYNPTR)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  /* The reg state of a pointer or a bounded scalar was saved when
>   * it was spilled to the stack.
>   */
> @@ -2885,6 +3030,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>         }
>
>         mark_stack_slot_scratched(env, spi);
> +
> +       if (stack_access_into_dynptr(state, spi, size)) {
> +               verbose(env, "direct write into dynptr is not permitted\n");
> +               return -EINVAL;
> +       }
> +
>         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
>             !register_is_null(reg) && env->bpf_capable) {
>                 if (dst_reg != BPF_REG_FP) {
> @@ -3006,6 +3157,12 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>                 slot = -i - 1;
>                 spi = slot / BPF_REG_SIZE;
>                 stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
> +
> +               if (*stype == STACK_DYNPTR) {
> +                       verbose(env, "direct write into dynptr is not permitted\n");
> +                       return -EINVAL;
> +               }
> +
>                 mark_stack_slot_scratched(env, spi);
>
>                 if (!env->allow_ptr_leaks
> @@ -5153,6 +5310,16 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type type)
>                type == ARG_PTR_TO_LONG;
>  }
>
> +static inline bool arg_type_is_dynptr(enum bpf_arg_type type)
> +{
> +       return base_type(type) == ARG_PTR_TO_DYNPTR;
> +}
> +
> +static inline bool arg_type_is_dynptr_uninit(enum bpf_arg_type type)
> +{
> +       return arg_type_is_dynptr(type) && type & MEM_UNINIT;

please add ( ) around (type & MEM_UNINIT) to make clear operation
priority when combining with &&

> +}
> +
>  static int int_ptr_type_to_size(enum bpf_arg_type type)
>  {
>         if (type == ARG_PTR_TO_INT)
> @@ -5290,6 +5457,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_STACK]              = &stack_ptr_types,
>         [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
>         [ARG_PTR_TO_TIMER]              = &timer_types,
> +       [ARG_PTR_TO_DYNPTR]             = &stack_ptr_types,
>  };
>
>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> @@ -5408,6 +5576,15 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>         return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  }
>
> +/*
> + * Determines whether the id used for reference tracking is held in a stack slot
> + * or in a register
> + */
> +static bool id_in_stack_slot(enum bpf_arg_type arg_type)

is_ or has_ is a good idea for such bool-returning helpers (similarly
for stack_access_into_dynptr above), otherwise it reads like a verb
and command to do something

but looking few lines below, if (arg_type_is_dynptr()) would be
clearer than extra wrapper function, not sure what's the purpose of
the helper

> +{
> +       return arg_type_is_dynptr(arg_type);
> +}
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                           struct bpf_call_arg_meta *meta,
>                           const struct bpf_func_proto *fn)
> @@ -5458,10 +5635,19 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 return err;
>
>         arg_release = type_is_release_mem(arg_type);
> -       if (arg_release && !reg->ref_obj_id) {
> -               verbose(env, "R%d arg #%d is an unacquired reference and hence cannot be released\n",
> -                       regno, arg + 1);
> -               return -EINVAL;
> +       if (arg_release) {
> +               if (id_in_stack_slot(arg_type)) {
> +                       struct bpf_func_state *state = func(env, reg);
> +                       int spi = get_spi(reg->off);
> +
> +                       if (!state->stack[spi].spilled_ptr.id)
> +                               goto unacquired_ref_err;
> +               } else if (!reg->ref_obj_id)  {
> +unacquired_ref_err:

oh, this goto into the middle of else branch is nasty, is it such a
big deal to have this verbose() copied (or even tailored specifically
to dynptr)?

> +                       verbose(env, "R%d arg #%d is an unacquired reference and hence cannot be released\n",
> +                               regno, arg + 1);
> +                       return -EINVAL;
> +               }
>         }
>
>         err = check_func_arg_reg_off(env, reg, regno, arg_type, arg_release);
> @@ -5572,6 +5758,40 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
>
>                 err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> +       } else if (arg_type_is_dynptr(arg_type)) {
> +               bool initialized = check_dynptr_init(env, reg, arg_type);
> +
> +               if (type_is_uninit_mem(arg_type)) {
> +                       if (initialized) {
> +                               verbose(env, "Arg #%d dynptr cannot be an initialized dynptr\n",
> +                                       arg + 1);
> +                               return -EINVAL;
> +                       }
> +                       meta->raw_mode = true;
> +                       err = check_helper_mem_access(env, regno, BPF_DYNPTR_SIZE, false, meta);
> +                       /* For now, we do not allow dynptrs to point to existing
> +                        * refcounted memory
> +                        */
> +                       if (reg_type_may_be_refcounted_or_null(regs[BPF_REG_1].type)) {

hard-coded BPF_REG_1?

> +                               verbose(env, "Arg #%d dynptr memory cannot be potentially refcounted\n",
> +                                       arg + 1);
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       if (!initialized) {
> +                               char *err_extra = "";

const char *

> +
> +                               if (arg_type & DYNPTR_TYPE_LOCAL)
> +                                       err_extra = "local ";
> +                               else if (arg_type & DYNPTR_TYPE_MALLOC)
> +                                       err_extra = "malloc ";
> +                               verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> +                                       err_extra, arg + 1);

what if helper accepts two or more different types of dynptr?

> +                               return -EINVAL;
> +                       }
> +                       if (type_is_release_mem(arg_type))
> +                               err = unmark_stack_slots_dynptr(env, reg);
> +               }
>         } else if (arg_type_is_alloc_size(arg_type)) {
>                 if (!tnum_is_const(reg->var_off)) {
>                         verbose(env, "R%d is not a known constant'\n",

[...]
