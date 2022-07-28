Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433AB584507
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiG1R3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiG1R27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 13:28:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298E63E76A
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:28:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso2835786pjd.3
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L7zmhvmmg53yhzzlqglcFNKZOkVBLt7Rby/pdfIW4M0=;
        b=ITb8Gndu3m81+fv68CmpWO/LRJqX31mUA5riUWaURBFuSVGrPJFNYRToIRKzIJsdzf
         ZZHziGrjZrSnXK/TsazBPd8n/x5SG/nHyk/a7y5J54LqTHSSkDx5VoqbJydVkc8XpfL1
         7aweQRce5/voFKQok5gyNseDHuIR98RMySM9nUoHPIMOLnU8n8PUTBd2/wWSXP0odiPl
         qzqYrLsk0m2bSCLu4/SJ2bHhfq7Buh5xotP5PhaTvOKNxitnLHkDuAH5uyr+mbcfLkzx
         mynGzs35t5yFmVtputBzyli+ZkGo0l0LcJ8Y3txIry9GvsG0+k85qRXXPu+n+dinhMty
         geqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L7zmhvmmg53yhzzlqglcFNKZOkVBLt7Rby/pdfIW4M0=;
        b=WJt8rtY5CtyxKI6LcmV7GrO30scm8JJzKS4PWFO0qRf1d5fsvtHx2ru0Hg4lf79c32
         jt6a/T/I/y73gIir9chLpxX2IAcJOBcEdtbCvSRrp3dvf3++DuYKe8heORpRfO9ZG5Mv
         CfntOl2X6WHyYVMMuUlllFZy0VbPRLK4wF7NITCrf/jjvxykV/uwCsJFyWgqc6eSGJGd
         B9tshBvydX/GxN6l/oBw7pEb7kIwwYw9l/Qckuhu0LeYzyoBfWwalR8ra09ramOk6Omq
         KegWB6cP6sCEjqFRmPpA0laJdNCSgXibMIcfiyEw8dM/j9lijv4R1LSpMo7T+ACh6vqq
         cvpQ==
X-Gm-Message-State: AJIora+CDhdEJc7guYSW9Y3u1b8KPUUs+mz69FNYrXAn9o+kkP0oYGfc
        32nMXHLIwFWu4UHWry3NOOIFZk19tthaTR86fDoBJw==
X-Google-Smtp-Source: AGRyM1uzyJvMmkPfn7N2uQpQVSIGkxzDCyoFtOuKuipUZMmQ1lXZLW8m86kqK9A142HJ5wNGNbAjkIRKf5VtKnopFkU=
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e951 with SMTP id
 n17-20020a170903111100b0016aacf4e951mr27214508plh.72.1659029337146; Thu, 28
 Jul 2022 10:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <YuFyVwiFkrKjSmFN@google.com>
 <CAJnrk1YiaMg1mFzJCrnAWXRQNbdacEZWDPJKBnfHhLiz013BxA@mail.gmail.com>
In-Reply-To: <CAJnrk1YiaMg1mFzJCrnAWXRQNbdacEZWDPJKBnfHhLiz013BxA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 28 Jul 2022 10:28:45 -0700
Message-ID: <CAKH8qBszdhwN2WvU=7fHsDXhwyhBnMsuEJyudvXsNfKcatUrng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 28, 2022 at 9:49 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Wed, Jul 27, 2022 at 10:14 AM <sdf@google.com> wrote:
> >
> > On 07/26, Joanne Koong wrote:
> > > Add skb dynptrs, which are dynptrs whose underlying pointer points
> > > to a skb. The dynptr acts on skb data. skb dynptrs have two main
> > > benefits. One is that they allow operations on sizes that are not
> > > statically known at compile-time (eg variable-sized accesses).
> > > Another is that parsing the packet data through dynptrs (instead of
> > > through direct access of skb->data and skb->data_end) can be more
> > > ergonomic and less brittle (eg does not need manual if checking for
> > > being within bounds of data_end).
> >
> > > For bpf prog types that don't support writes on skb data, the dynptr is
> > > read-only (writes and data slices are not permitted). For reads on the
> > > dynptr, this includes reading into data in the non-linear paged buffers
> > > but for writes and data slices, if the data is in a paged buffer, the
> > > user must first call bpf_skb_pull_data to pull the data into the linear
> > > portion.
> >
> > > Additionally, any helper calls that change the underlying packet buffer
> > > (eg bpf_skb_pull_data) invalidates any data slices of the associated
> > > dynptr.
> >
> > > Right now, skb dynptrs can only be constructed from skbs that are
> > > the bpf program context - as such, there does not need to be any
> > > reference tracking or release on skb dynptrs.
> >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >   include/linux/bpf.h            |  8 ++++-
> > >   include/linux/filter.h         |  4 +++
> > >   include/uapi/linux/bpf.h       | 42 ++++++++++++++++++++++++--
> > >   kernel/bpf/helpers.c           | 54 +++++++++++++++++++++++++++++++++-
> > >   kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++----
> > >   net/core/filter.c              | 53 ++++++++++++++++++++++++++++++---
> > >   tools/include/uapi/linux/bpf.h | 42 ++++++++++++++++++++++++--
> > >   7 files changed, 229 insertions(+), 17 deletions(-)
> >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 20c26aed7896..7fbd4324c848 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -407,11 +407,14 @@ enum bpf_type_flag {
> > >       /* Size is known at compile time. */
> > >       MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > > +     /* DYNPTR points to sk_buff */
> > > +     DYNPTR_TYPE_SKB         = BIT(11 + BPF_BASE_TYPE_BITS),
> > > +
> > >       __BPF_TYPE_FLAG_MAX,
> > >       __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
> > >   };
> >
> > > -#define DYNPTR_TYPE_FLAG_MASK        (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF)
> > > +#define DYNPTR_TYPE_FLAG_MASK        (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF |
> > > DYNPTR_TYPE_SKB)
> >
> > >   /* Max number of base types. */
> > >   #define BPF_BASE_TYPE_LIMIT (1UL << BPF_BASE_TYPE_BITS)
> > > @@ -2556,12 +2559,15 @@ enum bpf_dynptr_type {
> > >       BPF_DYNPTR_TYPE_LOCAL,
> > >       /* Underlying data is a ringbuf record */
> > >       BPF_DYNPTR_TYPE_RINGBUF,
> > > +     /* Underlying data is a sk_buff */
> > > +     BPF_DYNPTR_TYPE_SKB,
> > >   };
> >
> > >   void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
> > >                    enum bpf_dynptr_type type, u32 offset, u32 size);
> > >   void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
> > >   int bpf_dynptr_check_size(u32 size);
> > > +void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
> >
> > >   #ifdef CONFIG_BPF_LSM
> > >   void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index a5f21dc3c432..649063d9cbfd 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -1532,4 +1532,8 @@ static __always_inline int
> > > __bpf_xdp_redirect_map(struct bpf_map *map, u32 ifind
> > >       return XDP_REDIRECT;
> > >   }
> >
> > > +int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void
> > > *to, u32 len);
> > > +int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void
> > > *from,
> > > +                       u32 len, u64 flags);
> > > +
> > >   #endif /* __LINUX_FILTER_H__ */
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 59a217ca2dfd..0730cd198a7f 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -5241,11 +5241,22 @@ union bpf_attr {
> > >    *  Description
> > >    *          Write *len* bytes from *src* into *dst*, starting from *offset*
> > >    *          into *dst*.
> > > - *           *flags* is currently unused.
> > > + *
> > > + *           *flags* must be 0 except for skb-type dynptrs.
> > > + *
> > > + *           For skb-type dynptrs:
> > > + *               *  if *offset* + *len* extends into the skb's paged buffers, the
> > > user
> > > + *                  should manually pull the skb with bpf_skb_pull and then try
> > > again.
> > > + *
> > > + *               *  *flags* are a combination of **BPF_F_RECOMPUTE_CSUM**
> > > (automatically
> > > + *                   recompute the checksum for the packet after storing the bytes) and
> > > + *                   **BPF_F_INVALIDATE_HASH** (set *skb*\ **->hash**, *skb*\
> > > + *                   **->swhash** and *skb*\ **->l4hash** to 0).
> > >    *  Return
> > >    *          0 on success, -E2BIG if *offset* + *len* exceeds the length
> > >    *          of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
> > > - *           is a read-only dynptr or if *flags* is not 0.
> > > + *           is a read-only dynptr or if *flags* is not correct, -EAGAIN if for
> > > + *           skb-type dynptrs the write extends into the skb's paged buffers.
> > >    *
> > >    * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
> > >    *  Description
> > > @@ -5253,10 +5264,19 @@ union bpf_attr {
> > >    *
> > >    *          *len* must be a statically known value. The returned data slice
> > >    *          is invalidated whenever the dynptr is invalidated.
> > > + *
> > > + *           For skb-type dynptrs:
> > > + *               * if *offset* + *len* extends into the skb's paged buffers,
> > > + *                 the user should manually pull the skb with bpf_skb_pull and
> > > then
> > > + *                 try again.
> > > + *
> > > + *               * the data slice is automatically invalidated anytime a
> > > + *                 helper call that changes the underlying packet buffer
> > > + *                 (eg bpf_skb_pull) is called.
> > >    *  Return
> > >    *          Pointer to the underlying dynptr data, NULL if the dynptr is
> > >    *          read-only, if the dynptr is invalid, or if the offset and length
> > > - *           is out of bounds.
> > > + *           is out of bounds or in a paged buffer for skb-type dynptrs.
> > >    *
> > >    * s64 bpf_tcp_raw_gen_syncookie_ipv4(struct iphdr *iph, struct tcphdr
> > > *th, u32 th_len)
> > >    *  Description
> > > @@ -5331,6 +5351,21 @@ union bpf_attr {
> > >    *          **-EACCES** if the SYN cookie is not valid.
> > >    *
> > >    *          **-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
> > > + *
> > > + * long bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags, struct
> > > bpf_dynptr *ptr)
> > > + *   Description
> > > + *           Get a dynptr to the data in *skb*. *skb* must be the BPF program
> > > + *           context. Depending on program type, the dynptr may be read-only,
> > > + *           in which case trying to obtain a direct data slice to it through
> > > + *           bpf_dynptr_data will return an error.
> > > + *
> > > + *           Calls that change the *skb*'s underlying packet buffer
> > > + *           (eg bpf_skb_pull_data) do not invalidate the dynptr, but they do
> > > + *           invalidate any data slices associated with the dynptr.
> > > + *
> > > + *           *flags* is currently unused, it must be 0 for now.
> > > + *   Return
> > > + *           0 on success or -EINVAL if flags is not 0.
> > >    */
> > >   #define __BPF_FUNC_MAPPER(FN)               \
> > >       FN(unspec),                     \
> > > @@ -5541,6 +5576,7 @@ union bpf_attr {
> > >       FN(tcp_raw_gen_syncookie_ipv6), \
> > >       FN(tcp_raw_check_syncookie_ipv4),       \
> > >       FN(tcp_raw_check_syncookie_ipv6),       \
> > > +     FN(dynptr_from_skb),            \
> > >       /* */
> >
> > >   /* integer value in 'imm' field of BPF_CALL instruction selects which
> > > helper
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 1f961f9982d2..21a806057e9e 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -1425,11 +1425,21 @@ static bool bpf_dynptr_is_rdonly(struct
> > > bpf_dynptr_kern *ptr)
> > >       return ptr->size & DYNPTR_RDONLY_BIT;
> > >   }
> >
> > > +void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
> > > +{
> > > +     ptr->size |= DYNPTR_RDONLY_BIT;
> > > +}
> > > +
> > >   static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum
> > > bpf_dynptr_type type)
> > >   {
> > >       ptr->size |= type << DYNPTR_TYPE_SHIFT;
> > >   }
> >
> > > +static enum bpf_dynptr_type bpf_dynptr_get_type(const struct
> > > bpf_dynptr_kern *ptr)
> > > +{
> > > +     return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
> > > +}
> > > +
> > >   static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
> > >   {
> > >       return ptr->size & DYNPTR_SIZE_MASK;
> > > @@ -1500,6 +1510,7 @@ static const struct bpf_func_proto
> > > bpf_dynptr_from_mem_proto = {
> > >   BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct
> > > bpf_dynptr_kern *, src,
> > >          u32, offset, u64, flags)
> > >   {
> > > +     enum bpf_dynptr_type type;
> > >       int err;
> >
> > >       if (!src->data || flags)
> > > @@ -1509,6 +1520,11 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len,
> > > struct bpf_dynptr_kern *, src
> > >       if (err)
> > >               return err;
> >
> > > +     type = bpf_dynptr_get_type(src);
> > > +
> > > +     if (type == BPF_DYNPTR_TYPE_SKB)
> > > +             return __bpf_skb_load_bytes(src->data, src->offset + offset, dst, len);
> > > +
> > >       memcpy(dst, src->data + src->offset + offset, len);
> >
> > >       return 0;
> > > @@ -1528,15 +1544,38 @@ static const struct bpf_func_proto
> > > bpf_dynptr_read_proto = {
> > >   BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset,
> > > void *, src,
> > >          u32, len, u64, flags)
> > >   {
> > > +     enum bpf_dynptr_type type;
> > >       int err;
> >
> > > -     if (!dst->data || flags || bpf_dynptr_is_rdonly(dst))
> > > +     if (!dst->data || bpf_dynptr_is_rdonly(dst))
> > >               return -EINVAL;
> >
> > >       err = bpf_dynptr_check_off_len(dst, offset, len);
> > >       if (err)
> > >               return err;
> >
> > > +     type = bpf_dynptr_get_type(dst);
> > > +
> > > +     if (flags) {
> > > +             if (type == BPF_DYNPTR_TYPE_SKB) {
> > > +                     if (flags & ~(BPF_F_RECOMPUTE_CSUM | BPF_F_INVALIDATE_HASH))
> > > +                             return -EINVAL;
> > > +             } else {
> > > +                     return -EINVAL;
> > > +             }
> > > +     }
> > > +
> > > +     if (type == BPF_DYNPTR_TYPE_SKB) {
> > > +             struct sk_buff *skb = dst->data;
> > > +
> > > +             /* if the data is paged, the caller needs to pull it first */
> > > +             if (dst->offset + offset + len > skb->len - skb->data_len)
> >
> > Use skb_headlen instead of 'skb->len - skb->data_len' ?
> Awesome, will replace this (and the one in bpf_dynptr_data) with
> skb_headlen() for v2. thanks!
> >
> > > +                     return -EAGAIN;
> > > +
> > > +             return __bpf_skb_store_bytes(skb, dst->offset + offset, src, len,
> > > +                                          flags);
> > > +     }
> > > +
> > >       memcpy(dst->data + dst->offset + offset, src, len);
> >
> > >       return 0;
> > > @@ -1555,6 +1594,7 @@ static const struct bpf_func_proto
> > > bpf_dynptr_write_proto = {
> >
> > >   BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset,
> > > u32, len)
> > >   {
> > > +     enum bpf_dynptr_type type;
> > >       int err;
> >
> > >       if (!ptr->data)
> > > @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern
> > > *, ptr, u32, offset, u32, len
> > >       if (bpf_dynptr_is_rdonly(ptr))
> > >               return 0;
> >
> > > +     type = bpf_dynptr_get_type(ptr);
> > > +
> > > +     if (type == BPF_DYNPTR_TYPE_SKB) {
> > > +             struct sk_buff *skb = ptr->data;
> > > +
> > > +             /* if the data is paged, the caller needs to pull it first */
> > > +             if (ptr->offset + offset + len > skb->len - skb->data_len)
> > > +                     return 0;
> >
> > Same here?
> >
> > > +
> > > +             return (unsigned long)(skb->data + ptr->offset + offset);
> > > +     }
> > > +
> > >       return (unsigned long)(ptr->data + ptr->offset + offset);
> > >   }
> >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 0d523741a543..0838653eeb4e 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -263,6 +263,7 @@ struct bpf_call_arg_meta {
> > >       u32 subprogno;
> > >       struct bpf_map_value_off_desc *kptr_off_desc;
> > >       u8 uninit_dynptr_regno;
> > > +     enum bpf_dynptr_type type;
> > >   };
> >
> > >   struct btf *btf_vmlinux;
> > > @@ -678,6 +679,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum
> > > bpf_arg_type arg_type)
> > >               return BPF_DYNPTR_TYPE_LOCAL;
> > >       case DYNPTR_TYPE_RINGBUF:
> > >               return BPF_DYNPTR_TYPE_RINGBUF;
> > > +     case DYNPTR_TYPE_SKB:
> > > +             return BPF_DYNPTR_TYPE_SKB;
> > >       default:
> > >               return BPF_DYNPTR_TYPE_INVALID;
> > >       }
> > > @@ -5820,12 +5823,14 @@ int check_func_arg_reg_off(struct
> > > bpf_verifier_env *env,
> > >       return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> > >   }
> >
> > > -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct
> > > bpf_reg_state *reg)
> > > +static void stack_slot_get_dynptr_info(struct bpf_verifier_env *env,
> > > struct bpf_reg_state *reg,
> > > +                                    struct bpf_call_arg_meta *meta)
> > >   {
> > >       struct bpf_func_state *state = func(env, reg);
> > >       int spi = get_spi(reg->off);
> >
> > > -     return state->stack[spi].spilled_ptr.id;
> > > +     meta->ref_obj_id = state->stack[spi].spilled_ptr.id;
> > > +     meta->type = state->stack[spi].spilled_ptr.dynptr.type;
> > >   }
> >
> > >   static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > @@ -6052,6 +6057,9 @@ static int check_func_arg(struct bpf_verifier_env
> > > *env, u32 arg,
> > >                               case DYNPTR_TYPE_RINGBUF:
> > >                                       err_extra = "ringbuf ";
> > >                                       break;
> > > +                             case DYNPTR_TYPE_SKB:
> > > +                                     err_extra = "skb ";
> > > +                                     break;
> > >                               default:
> > >                                       break;
> > >                               }
> > > @@ -6065,8 +6073,10 @@ static int check_func_arg(struct bpf_verifier_env
> > > *env, u32 arg,
> > >                                       verbose(env, "verifier internal error: multiple refcounted args in
> > > BPF_FUNC_dynptr_data");
> > >                                       return -EFAULT;
> > >                               }
> > > -                             /* Find the id of the dynptr we're tracking the reference of */
> > > -                             meta->ref_obj_id = stack_slot_get_id(env, reg);
> > > +                             /* Find the id and the type of the dynptr we're tracking
> > > +                              * the reference of.
> > > +                              */
> > > +                             stack_slot_get_dynptr_info(env, reg, meta);
> > >                       }
> > >               }
> > >               break;
> > > @@ -7406,7 +7416,11 @@ static int check_helper_call(struct
> > > bpf_verifier_env *env, struct bpf_insn *insn
> > >               regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
> > >       } else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
> > >               mark_reg_known_zero(env, regs, BPF_REG_0);
> > > -             regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > > +             if (func_id == BPF_FUNC_dynptr_data &&
> > > +                 meta.type == BPF_DYNPTR_TYPE_SKB)
> > > +                     regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;
> > > +             else
> > > +                     regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > >               regs[BPF_REG_0].mem_size = meta.mem_size;
> > >       } else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
> > >               const struct btf_type *t;
> > > @@ -14132,6 +14146,25 @@ static int do_misc_fixups(struct
> > > bpf_verifier_env *env)
> > >                       goto patch_call_imm;
> > >               }
> >
> >
> > [..]
> >
> > > +             if (insn->imm == BPF_FUNC_dynptr_from_skb) {
> > > +                     if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
> > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, true);
> > > +                     else
> > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, false);
> > > +                     insn_buf[1] = *insn;
> > > +                     cnt = 2;
> > > +
> > > +                     new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > > +                     if (!new_prog)
> > > +                             return -ENOMEM;
> > > +
> > > +                     delta += cnt - 1;
> > > +                     env->prog = new_prog;
> > > +                     prog = new_prog;
> > > +                     insn = new_prog->insnsi + i + delta;
> > > +                     goto patch_call_imm;
> > > +             }
> >
> > Would it be easier to have two separate helpers:
> > - BPF_FUNC_dynptr_from_skb
> > - BPF_FUNC_dynptr_from_skb_readonly
> >
> > And make the verifier rewrite insn->imm to
> > BPF_FUNC_dynptr_from_skb_readonly when needed?
> >
> > if (insn->imm == BPF_FUNC_dynptr_from_skb) {
> >         if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
> >                 insn->imm = BPF_FUNC_dynptr_from_skb_readonly;
> > }
> >
> > Or it's also ugly because we'd have to leak that new helper into UAPI?
> > (I wonder whether that hidden 4th argument is too magical, but probably
> > fine?)
> To me, having 2 separate helpers feels more cluttered and having to
> expose it in the uapi (though I think there is probably some way to
> avoid this by doing some sort of ad hoc processing) doesn't seem
> ideal. If you feel strongly about this though, I am happy to change
> this to use two separate helpers. We do this sort of manual
> instruction patching for the sleepable flags in
> bpf_task/sk/inode_storage_get and for the callback args in
> bpf_timer_set_callback as well - if we use separate helpers here, we
> should do that for the other cases as well to maintain consistency.

No, I don't feel strongly, let's keep it, especially if there is prior art :-)
I am just wondering whether there is some better alternative, but
extra helpers also have their downsides.
