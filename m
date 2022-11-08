Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129EA622065
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 00:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiKHXju (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 18:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKHXjt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 18:39:49 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0FD56562
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 15:39:48 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id k5so15177900pjo.5
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 15:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEe+i1Eq30j+5kzNT8U9PVFkxGYtvVKNECzGRcfLFNA=;
        b=FeCckHSE3ZbVfYTvX8oPCrIv3x3iDYrQzSztWRKbwPTnQ8oevxIJoYniC4w3/bwwUl
         Y8Ms9Q6VmJxR0uro97yMcz2rPgCJuGvKYZPvZQbdnZQelyxU8g8mbaUE6mJv/78C97/u
         oUxJ2ApGPnjpZBERUYTJUKQCacn19ibPIFDc8KB4Brb/gH5MQTaeKfEsXkQP06S+LjB/
         Lxkjz4+gm8wNdtwiHBdvoJbV7LtkmQ9Pf6ae56kiVYL27jqx5TMoOaVD3Zn0Qpgf1JT4
         fdhLv+3LhnLjXaeGvjnpcoenW24nXLz2Qo6RpSRpgRziPKRYj6CiI/R9GLQBQVAwVsPU
         XI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEe+i1Eq30j+5kzNT8U9PVFkxGYtvVKNECzGRcfLFNA=;
        b=VjSvEAswOoFUVSEb+gh/RMEuwcdEHm6ouJ4W8dT1xuhOX8hv718Zm4CqZdhdeoOer1
         PGT501tK5wFuwgQV296GdwFXDFt90PKTSIM1ARnAYHutAamklqKj1Sm/m0Hs8TIdExX8
         nJ6EIpxxJ31GLJEzbSuaSC9LWu0W3Kj+TKTI0FBxe1tWqXxgHXLxvT1cfT/cbL8iP9y8
         5gVwc31D3KCn8xwvXwqGTmhqK0Xs6hvpslFK9sv7JY8P0XkFW22rX1d4CunqvssazjFJ
         DVuksgMmJjHreemNxv9wCb61eaCwIPy/A5xRbQIyYol6R2FEBmtLYfSeuKLxwSuKzPqY
         J2sA==
X-Gm-Message-State: ACrzQf3+jU2GDMHAHhXwGxpbqIJ/dfinrDIyEu3SmKY3xaG8lOftkFtv
        WeufHB17acsoqMRoEtGhq1s=
X-Google-Smtp-Source: AMsMyM4fBrfiZECJon0bwvLfl+aTuE0CzWg1vBUZs43dbHw3uV6eTf2h8920bB1YrmzYWL8NrtsDvw==
X-Received: by 2002:a17:902:d591:b0:186:fe2d:f3b7 with SMTP id k17-20020a170902d59100b00186fe2df3b7mr59325196plh.68.1667950787523;
        Tue, 08 Nov 2022 15:39:47 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id a3-20020aa795a3000000b0056cea9530b9sm6885628pfk.200.2022.11.08.15.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 15:39:47 -0800 (PST)
Date:   Wed, 9 Nov 2022 05:09:44 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 03/25] bpf: Support bpf_list_head in map
 values
Message-ID: <20221108233944.o6ktnoinaggzir7t@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-4-memxor@gmail.com>
 <CAEf4Bza6R67US05R6Oh-FY9Kit8abH6eiJ33Z6TnSSpC_n5FBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza6R67US05R6Oh-FY9Kit8abH6eiJ33Z6TnSSpC_n5FBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 04:31:52AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Add the support on the map side to parse, recognize, verify, and build
> > metadata table for a new special field of the type struct bpf_list_head.
> > To parameterize the bpf_list_head for a certain value type and the
> > list_node member it will accept in that value type, we use BTF
> > declaration tags.
> >
> > The definition of bpf_list_head in a map value will be done as follows:
> >
> > struct foo {
> >         struct bpf_list_node node;
> >         int data;
> > };
> >
> > struct map_value {
> >         struct bpf_list_head head __contains(foo, node);
> > };
> >
> > Then, the bpf_list_head only allows adding to the list 'head' using the
> > bpf_list_node 'node' for the type struct foo.
> >
> > The 'contains' annotation is a BTF declaration tag composed of four
> > parts, "contains:name:node" where the name is then used to look up the
> > type in the map BTF, with its kind hardcoded to BTF_KIND_STRUCT during
> > the lookup. The node defines name of the member in this type that has
> > the type struct bpf_list_node, which is actually used for linking into
> > the linked list. For now, 'kind' part is hardcoded as struct.
> >
> > This allows building intrusive linked lists in BPF, using container_of
> > to obtain pointer to entry, while being completely type safe from the
> > perspective of the verifier. The verifier knows exactly the type of the
> > nodes, and knows that list helpers return that type at some fixed offset
> > where the bpf_list_node member used for this list exists. The verifier
> > also uses this information to disallow adding types that are not
> > accepted by a certain list.
> >
> > For now, no elements can be added to such lists. Support for that is
> > coming in future patches, hence draining and freeing items is done with
> > a TODO that will be resolved in a future patch.
> >
> > Note that the bpf_list_head_free function moves the list out to a local
> > variable under the lock and releases it, doing the actual draining of
> > the list items outside the lock. While this helps with not holding the
> > lock for too long pessimizing other concurrent list operations, it is
> > also necessary for deadlock prevention: unless every function called in
> > the critical section would be notrace, a fentry/fexit program could
> > attach and call bpf_map_update_elem again on the map, leading to the
> > same lock being acquired if the key matches and lead to a deadlock.
> > While this requires some special effort on part of the BPF programmer to
> > trigger and is highly unlikely to occur in practice, it is always better
> > if we can avoid such a condition.
> >
> > While notrace would prevent this, doing the draining outside the lock
> > has advantages of its own, hence it is used to also fix the deadlock
> > related problem.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h            |  17 ++++
> >  include/uapi/linux/bpf.h       |  10 +++
> >  kernel/bpf/btf.c               | 143 ++++++++++++++++++++++++++++++++-
> >  kernel/bpf/helpers.c           |  32 ++++++++
> >  kernel/bpf/syscall.c           |  22 ++++-
> >  kernel/bpf/verifier.c          |   7 ++
> >  tools/include/uapi/linux/bpf.h |  10 +++
> >  7 files changed, 237 insertions(+), 4 deletions(-)
> >
>
> [...]
>
> >  struct bpf_offload_dev;
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 94659f6b3395..dd381086bad9 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6887,6 +6887,16 @@ struct bpf_dynptr {
> >         __u64 :64;
> >  } __attribute__((aligned(8)));
> >
> > +struct bpf_list_head {
> > +       __u64 :64;
> > +       __u64 :64;
> > +} __attribute__((aligned(8)));
> > +
> > +struct bpf_list_node {
> > +       __u64 :64;
> > +       __u64 :64;
> > +} __attribute__((aligned(8)));
>
> Dave mentioned that this `__u64 :64` trick makes vmlinux.h lose the
> alignment information, as the struct itself is empty, and so there is
> nothing indicating that it has to be 8-byte aligned.
>
> So what if we have
>
> struct bpf_list_node {
>     __u64 __opaque[2];
> } __attribute__((aligned(8)));
>
> ?
>

Yep, can do that. Note that it's also potentially an issue for existing cases,
like bpf_spin_lock, bpf_timer, bpf_dynptr, etc. Not completely sure if changing
things now is possible, but if it is, we should probably make it for all of
them?

> > +
> >  struct bpf_sysctl {
> >         __u32   write;          /* Sysctl is being read (= 0) or written (= 1).
> >                                  * Allows 1,2,4-byte read, but no write.
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>
> [...]
>
> > @@ -3284,6 +3347,12 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
> >                         goto end;
> >                 }
> >         }
> > +       if (field_mask & BPF_LIST_HEAD) {
> > +               if (!strcmp(name, "bpf_list_head")) {
> > +                       type = BPF_LIST_HEAD;
> > +                       goto end;
> > +               }
> > +       }
> >         /* Only return BPF_KPTR when all other types with matchable names fail */
> >         if (field_mask & BPF_KPTR) {
> >                 type = BPF_KPTR_REF;
> > @@ -3317,6 +3386,8 @@ static int btf_find_struct_field(const struct btf *btf,
> >                         return field_type;
> >
> >                 off = __btf_member_bit_offset(t, member);
> > +               if (i && !off)
> > +                       return -EFAULT;
>
> why? why can't my struct has zero-sized field in the beginning? This
> seems like a very incomplete and unnecessary check to me.
>

Right, I will drop it for the struct case.

> >                 if (off % 8)
> >                         /* valid C code cannot generate such BTF */
> >                         return -EINVAL;
> > @@ -3339,6 +3410,12 @@ static int btf_find_struct_field(const struct btf *btf,
> >                         if (ret < 0)
> >                                 return ret;
> >                         break;
> > +               case BPF_LIST_HEAD:
> > +                       ret = btf_find_list_head(btf, t, member_type, i, off, sz,
> > +                                                idx < info_cnt ? &info[idx] : &tmp);
> > +                       if (ret < 0)
> > +                               return ret;
> > +                       break;
> >                 default:
> >                         return -EFAULT;
> >                 }
> > @@ -3373,6 +3450,8 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> >                         return field_type;
> >
> >                 off = vsi->offset;
> > +               if (i && !off)
> > +                       return -EFAULT;
>
> similarly, I'd say that either we'd need to calculate the exact
> expected offset, or just not do anything here?
>

This thread is actually what prompted this check:
https://lore.kernel.org/bpf/CAEf4Bza7ga2hEQ4J7EtgRHz49p1vZtaT4d2RDiyGOKGK41Nt=Q@mail.gmail.com

Unless loaded using libbpf all offsets are zero. So I think we need to reject it
here, but I think the same zero sized field might be an issue for this as well,
so maybe we remember the last field size and check whether it was zero or not?

I'll also include some more tests for these cases.
