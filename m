Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04F36220AC
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiKIAXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIAXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:23:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E0C20354
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:23:07 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v27so24978318eda.1
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fvgfMIlcvi+WB7Ds99mNlTHRz35LWxPECBxkSKqWvHI=;
        b=bPLzYlwHsBVX0fUH0kUv8MayGhwqvqZKhwneXH+417+ptU+YWyj0MtRbr4FnkrE5nP
         nTBz0jDyKNavWt25rJLN2Yebhx5zgpr2JYztq/tRzD1H+5pWBNd7SxyaBIMepZaR27oK
         Zh9haVqu9lWbzFQejxhqI4V3N1nHQBxyFpWNNbjlhviGEy2RSgHjBpAg9ECZcNelCV1X
         sbKYbZz5Z5Gxl8MQYxHM+moXPJkEeHu2SnR4ob6L1dYKgew6cT2gXEhdp7WcXbKfzKHP
         aVzOUQZlmdnwCqeqFYytc1XapdX/+QqiYHxqg8EtrrDe1A1NJXdyeKE9D7+IQjk45m2S
         EkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvgfMIlcvi+WB7Ds99mNlTHRz35LWxPECBxkSKqWvHI=;
        b=O+ZDsoBMqRA0Wv2FqGH1W8YqjmTAB25opw5KdVkMfnQoDNqKVQ2QtVYxfQspTQaVR3
         tRUj+xOkIB0gu+kb7u9DC9xiZBptArLDDXVJlnrNqFtMNyWkgH1lfe7kabI4xZNpeXDU
         ya1E359zsWX+G/yg0q0MghCiCyzB79yGYFXQkyclT60AYcEPgwBHS7jCh4+C9KsM3dyc
         oYI1Lrw42kDVF8Ghfg2ID/O70LXdJrBr0t3iL6F3Szk+lrBtQ2ujkB4TodaEMweVGsEB
         YmO/P8+Mas7orWlqwIXilZwmum95b2W7sFWzNzu/LqX4t724YEALWaV0mEXtx64lL3Bt
         D/rQ==
X-Gm-Message-State: ACrzQf2RB/DLuPBoqCsNslaueyj2YVkHFX+Hi79UyN12sKSaprVuvHjr
        rZUOzmWIX/2Gev9COrMSpX+Wx92mqrkN8E6o6k5tbLLN
X-Google-Smtp-Source: AMsMyM5BIX3iVNOWyuvFRaObWBrWHzKRrjR0oUvZGVrdiVjf4NY3PTg/wldf3psAPsKE2DqKzc77ZkgWuN794oPYhLs=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr59068373edq.14.1667953386242; Tue, 08
 Nov 2022 16:23:06 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-4-memxor@gmail.com>
 <CAEf4Bza6R67US05R6Oh-FY9Kit8abH6eiJ33Z6TnSSpC_n5FBA@mail.gmail.com> <20221108233944.o6ktnoinaggzir7t@apollo>
In-Reply-To: <20221108233944.o6ktnoinaggzir7t@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 16:22:54 -0800
Message-ID: <CAEf4BzbBNSsqvJnD8Sy4EzzOQOSuVb-g8HecCcBdJy1J2c09-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 03/25] bpf: Support bpf_list_head in map values
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Tue, Nov 8, 2022 at 3:39 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, Nov 09, 2022 at 04:31:52AM IST, Andrii Nakryiko wrote:
> > On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > Add the support on the map side to parse, recognize, verify, and build
> > > metadata table for a new special field of the type struct bpf_list_head.
> > > To parameterize the bpf_list_head for a certain value type and the
> > > list_node member it will accept in that value type, we use BTF
> > > declaration tags.
> > >
> > > The definition of bpf_list_head in a map value will be done as follows:
> > >
> > > struct foo {
> > >         struct bpf_list_node node;
> > >         int data;
> > > };
> > >
> > > struct map_value {
> > >         struct bpf_list_head head __contains(foo, node);
> > > };
> > >
> > > Then, the bpf_list_head only allows adding to the list 'head' using the
> > > bpf_list_node 'node' for the type struct foo.
> > >
> > > The 'contains' annotation is a BTF declaration tag composed of four
> > > parts, "contains:name:node" where the name is then used to look up the
> > > type in the map BTF, with its kind hardcoded to BTF_KIND_STRUCT during
> > > the lookup. The node defines name of the member in this type that has
> > > the type struct bpf_list_node, which is actually used for linking into
> > > the linked list. For now, 'kind' part is hardcoded as struct.
> > >
> > > This allows building intrusive linked lists in BPF, using container_of
> > > to obtain pointer to entry, while being completely type safe from the
> > > perspective of the verifier. The verifier knows exactly the type of the
> > > nodes, and knows that list helpers return that type at some fixed offset
> > > where the bpf_list_node member used for this list exists. The verifier
> > > also uses this information to disallow adding types that are not
> > > accepted by a certain list.
> > >
> > > For now, no elements can be added to such lists. Support for that is
> > > coming in future patches, hence draining and freeing items is done with
> > > a TODO that will be resolved in a future patch.
> > >
> > > Note that the bpf_list_head_free function moves the list out to a local
> > > variable under the lock and releases it, doing the actual draining of
> > > the list items outside the lock. While this helps with not holding the
> > > lock for too long pessimizing other concurrent list operations, it is
> > > also necessary for deadlock prevention: unless every function called in
> > > the critical section would be notrace, a fentry/fexit program could
> > > attach and call bpf_map_update_elem again on the map, leading to the
> > > same lock being acquired if the key matches and lead to a deadlock.
> > > While this requires some special effort on part of the BPF programmer to
> > > trigger and is highly unlikely to occur in practice, it is always better
> > > if we can avoid such a condition.
> > >
> > > While notrace would prevent this, doing the draining outside the lock
> > > has advantages of its own, hence it is used to also fix the deadlock
> > > related problem.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h            |  17 ++++
> > >  include/uapi/linux/bpf.h       |  10 +++
> > >  kernel/bpf/btf.c               | 143 ++++++++++++++++++++++++++++++++-
> > >  kernel/bpf/helpers.c           |  32 ++++++++
> > >  kernel/bpf/syscall.c           |  22 ++++-
> > >  kernel/bpf/verifier.c          |   7 ++
> > >  tools/include/uapi/linux/bpf.h |  10 +++
> > >  7 files changed, 237 insertions(+), 4 deletions(-)
> > >
> >
> > [...]
> >
> > >  struct bpf_offload_dev;
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 94659f6b3395..dd381086bad9 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6887,6 +6887,16 @@ struct bpf_dynptr {
> > >         __u64 :64;
> > >  } __attribute__((aligned(8)));
> > >
> > > +struct bpf_list_head {
> > > +       __u64 :64;
> > > +       __u64 :64;
> > > +} __attribute__((aligned(8)));
> > > +
> > > +struct bpf_list_node {
> > > +       __u64 :64;
> > > +       __u64 :64;
> > > +} __attribute__((aligned(8)));
> >
> > Dave mentioned that this `__u64 :64` trick makes vmlinux.h lose the
> > alignment information, as the struct itself is empty, and so there is
> > nothing indicating that it has to be 8-byte aligned.
> >
> > So what if we have
> >
> > struct bpf_list_node {
> >     __u64 __opaque[2];
> > } __attribute__((aligned(8)));
> >
> > ?
> >
>
> Yep, can do that. Note that it's also potentially an issue for existing cases,
> like bpf_spin_lock, bpf_timer, bpf_dynptr, etc. Not completely sure if changing
> things now is possible, but if it is, we should probably make it for all of
> them?

Why not? We are not removing anything or changing sizes, so it's
backwards compatible. But I have a suspicion Alexei might not like
this __opaque field, so let's see what he says.

>
> > > +
> > >  struct bpf_sysctl {
> > >         __u32   write;          /* Sysctl is being read (= 0) or written (= 1).
> > >                                  * Allows 1,2,4-byte read, but no write.
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >
> > [...]
> >
> > > @@ -3284,6 +3347,12 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
> > >                         goto end;
> > >                 }
> > >         }
> > > +       if (field_mask & BPF_LIST_HEAD) {
> > > +               if (!strcmp(name, "bpf_list_head")) {
> > > +                       type = BPF_LIST_HEAD;
> > > +                       goto end;
> > > +               }
> > > +       }
> > >         /* Only return BPF_KPTR when all other types with matchable names fail */
> > >         if (field_mask & BPF_KPTR) {
> > >                 type = BPF_KPTR_REF;
> > > @@ -3317,6 +3386,8 @@ static int btf_find_struct_field(const struct btf *btf,
> > >                         return field_type;
> > >
> > >                 off = __btf_member_bit_offset(t, member);
> > > +               if (i && !off)
> > > +                       return -EFAULT;
> >
> > why? why can't my struct has zero-sized field in the beginning? This
> > seems like a very incomplete and unnecessary check to me.
> >
>
> Right, I will drop it for the struct case.
>
> > >                 if (off % 8)
> > >                         /* valid C code cannot generate such BTF */
> > >                         return -EINVAL;
> > > @@ -3339,6 +3410,12 @@ static int btf_find_struct_field(const struct btf *btf,
> > >                         if (ret < 0)
> > >                                 return ret;
> > >                         break;
> > > +               case BPF_LIST_HEAD:
> > > +                       ret = btf_find_list_head(btf, t, member_type, i, off, sz,
> > > +                                                idx < info_cnt ? &info[idx] : &tmp);
> > > +                       if (ret < 0)
> > > +                               return ret;
> > > +                       break;
> > >                 default:
> > >                         return -EFAULT;
> > >                 }
> > > @@ -3373,6 +3450,8 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> > >                         return field_type;
> > >
> > >                 off = vsi->offset;
> > > +               if (i && !off)
> > > +                       return -EFAULT;
> >
> > similarly, I'd say that either we'd need to calculate the exact
> > expected offset, or just not do anything here?
> >
>
> This thread is actually what prompted this check:
> https://lore.kernel.org/bpf/CAEf4Bza7ga2hEQ4J7EtgRHz49p1vZtaT4d2RDiyGOKGK41Nt=Q@mail.gmail.com
>
> Unless loaded using libbpf all offsets are zero. So I think we need to reject it
> here, but I think the same zero sized field might be an issue for this as well,
> so maybe we remember the last field size and check whether it was zero or not?
>
> I'll also include some more tests for these cases.

The question is whether this affects correctness from the verifier
standpoint? If it does, there must be some other place where this will
cause problem and should be caught and reported.

My main objection is that it's half a check, we check that it's
non-zero, but we don't check that it is correct in stricter sense. So
I'd rather drop it altogether, or go all the way to check that it is
correct offset (taking into account sizes of previous vars).
