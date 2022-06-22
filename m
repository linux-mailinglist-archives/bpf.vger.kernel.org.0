Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FAE555241
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355627AbiFVRWh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344588AbiFVRWg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 13:22:36 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22EF220F6
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 10:22:34 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CC8E824010B
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655918551; bh=l3GBkispLZ7lK/5W8fBxxG6tV/qI/QOCLSdsB0kS5TQ=;
        h=Date:From:To:Cc:Subject:From;
        b=U5w3jvLSB+Bfgt3InkubZvVUALJBQqac8GxTxflKRLEf5Cp2+wr3DgHATUp7CWeb6
         MVXMIym5ny/Pt4fswHDnFEBNgP6vmJwIMoSkjRjWa0UYdQo8pNUWybEevJw6wx5NX0
         e9JM8jSH/Gge6nFHY8WYd8tTfoiQeYBLmvKs3wDdbqjcdAz28Z7g3tDL/n0Tw58vTT
         UfO7As90sgAaccGb86UJNnb9nfj45p4eRCczF3haji/e14tHoplcEXiHOSA2S8IwXr
         DY+enDGNnDff88ignpBJkeDw3PMFjg+Oq15OLkvTA/WTRvOvGMWR8V+auUZtocLeIT
         i6RyW+zNQgVHg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LSqvS4smzz6tmp;
        Wed, 22 Jun 2022 19:22:28 +0200 (CEST)
Date:   Wed, 22 Jun 2022 17:22:24 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 3/7] bpf: Add type match support
Message-ID: <20220622172224.4curfsv7h7gfjwh5@muellerd-fedora-MJ0AC3F3>
References: <20220620231713.2143355-1-deso@posteo.net>
 <20220620231713.2143355-4-deso@posteo.net>
 <CAJnrk1YL9E2GJN+8Gnr9Db=yAHDOm2nwLb_LUQTEuStkm1jHEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YL9E2GJN+8Gnr9Db=yAHDOm2nwLb_LUQTEuStkm1jHEg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 12:41:22PM -0700, Joanne Koong wrote:
>  On Mon, Jun 20, 2022 at 4:25 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change implements the kernel side of the "type matches" support.
> > Please refer to the next change ("libbpf: Add type match support") for
> > more details on the relation. This one is first in the stack because
> > the follow-on libbpf changes depend on it.
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  include/linux/btf.h |   5 +
> >  kernel/bpf/btf.c    | 267 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 272 insertions(+)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 1bfed7..7376934 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -242,6 +242,11 @@ static inline u8 btf_int_offset(const struct btf_type *t)
> >         return BTF_INT_OFFSET(*(u32 *)(t + 1));
> >  }
> >
> > +static inline u8 btf_int_bits(const struct btf_type *t)
> > +{
> > +       return BTF_INT_BITS(*(__u32 *)(t + 1));
> nit: u32 here instead of __u32

Ah yeah, changed!

> > +}
> > +
> >  static inline u8 btf_int_encoding(const struct btf_type *t)
> >  {
> >         return BTF_INT_ENCODING(*(u32 *)(t + 1));
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index f08037..3790b4 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7524,6 +7524,273 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
> >                                            MAX_TYPES_ARE_COMPAT_DEPTH);
> >  }
> >
> > +#define MAX_TYPES_MATCH_DEPTH 2
> > +
> > +static bool bpf_core_names_match(const struct btf *local_btf, u32 local_id,
> > +                                const struct btf *targ_btf, u32 targ_id)
> > +{
> > +       const struct btf_type *local_t, *targ_t;
> > +       const char *local_n, *targ_n;
> > +       size_t local_len, targ_len;
> > +
> > +       local_t = btf_type_by_id(local_btf, local_id);
> > +       targ_t = btf_type_by_id(targ_btf, targ_id);
> > +       local_n = btf_str_by_offset(local_btf, local_t->name_off);
> > +       targ_n = btf_str_by_offset(targ_btf, targ_t->name_off);
> > +       local_len = bpf_core_essential_name_len(local_n);
> > +       targ_len = bpf_core_essential_name_len(targ_n);
> nit: i personally think this would be a little visually easier to read
> if there was a line space between targ_t and local_n, and between
> targ_n and local_len

Will add spaces as you suggest. I've also changed the signature to pass in the
actual btf_type pointer directly, which is trivially available at the call site.
That makes the block a bit shorter.

> > +
> > +       return local_len == targ_len && strncmp(local_n, targ_n, local_len) == 0;
> Does calling "return !strcmp(local_n, targ_n);" do the same thing here?

I think it does. Changed. Thanks!

> > +}
> > +
> > +static int bpf_core_enums_match(const struct btf *local_btf, const struct btf_type *local_t,
> I find the return values a bit confusing here.  The convention in
> linux is to return 0 for the success case. Maybe I'm totally missing
> something here, but is there a reason this doesn't just return a
> boolean?

I basically took bpf_core_types_are_compat() as the guiding function for the
signature, because bpf_core_enums_match() is used in the same contexts alongside
it. The reason it uses int, from what I can tell, is because it merges error
returns in there as well (-EINVAL). Given that we do the same, I think we should
stick to the same signature as well.

> > +                               const struct btf *targ_btf, const struct btf_type *targ_t)
> > +{
> > +       u16 local_vlen = btf_vlen(local_t);
> > +       u16 targ_vlen = btf_vlen(targ_t);
> > +       int i, j;
> > +
> > +       if (local_t->size != targ_t->size)
> > +               return 0;
> > +
> > +       if (local_vlen > targ_vlen)
> > +               return 0;
> > +
> > +       /* iterate over the local enum's variants and make sure each has
> > +        * a symbolic name correspondent in the target
> > +        */
> > +       for (i = 0; i < local_vlen; i++) {
> > +               bool matched = false;
> > +               const char *local_n;
> > +               __u32 local_n_off;
> nit: u32 instead of __u32 :)

As per discussion with Alexei I have deduplicated this function (between kernel
and userspace) and moved it into relo_core.c. Unfortunately, this file insists
on usage of __32 (for better or worse):

  xxxx:yyy:zz: error: attempt to use poisoned "u32"

> > +               size_t local_len;
> > +
> > +               local_n_off = btf_is_enum(local_t) ? btf_type_enum(local_t)[i].name_off :
> > +                                                    btf_type_enum64(local_t)[i].name_off;
> > +
> > +               local_n = btf_name_by_offset(local_btf, local_n_off);
> > +               local_len = bpf_core_essential_name_len(local_n);
> > +
> > +               for (j = 0; j < targ_vlen; j++) {
> > +                       const char *targ_n;
> > +                       __u32 targ_n_off;
> > +                       size_t targ_len;
> > +
> > +                       targ_n_off = btf_is_enum(targ_t) ? btf_type_enum(targ_t)[j].name_off :
> > +                                                          btf_type_enum64(targ_t)[j].name_off;
> > +                       targ_n = btf_name_by_offset(targ_btf, targ_n_off);
> > +
> > +                       if (str_is_empty(targ_n))
> > +                               continue;
> > +
> > +                       targ_len = bpf_core_essential_name_len(targ_n);
> > +
> > +                       if (local_len == targ_len && strncmp(local_n, targ_n, local_len) == 0) {
> same question here - does strcmp suffice?

I believe it does. Changed.

> > +                               matched = true;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               if (!matched)
> > +                       return 0;
> > +       }
> > +       return 1;
> > +}
> > +
> > +static int __bpf_core_types_match(const struct btf *local_btf, u32 local_id,
> > +                                 const struct btf *targ_btf, u32 targ_id, int level);
> > +
> > +static int bpf_core_composites_match(const struct btf *local_btf, const struct btf_type *local_t,
> Same question here - is there a reason this doesn't use a boolean as
> its return value?

Same explanation as above. Please let me know if you disagree with the
reasoning.

> > +                                    const struct btf *targ_btf, const struct btf_type *targ_t,
> > +                                    int level)
> > +{
> > +       /* check that all local members have a match in the target */
> > +       const struct btf_member *local_m = btf_members(local_t);
> > +       u16 local_vlen = btf_vlen(local_t);
> > +       u16 targ_vlen = btf_vlen(targ_t);
> > +       int i, j, err;
> > +
> > +       if (local_vlen > targ_vlen)
> > +               return 0;
> > +
> > +       for (i = 0; i < local_vlen; i++, local_m++) {
> > +               const char *local_n = btf_name_by_offset(local_btf, local_m->name_off);
> > +               const struct btf_member *targ_m = btf_members(targ_t);
> > +               bool matched = false;
> > +
> > +               for (j = 0; j < targ_vlen; j++, targ_m++) {
> > +                       const char *targ_n = btf_name_by_offset(targ_btf, targ_m->name_off);
> > +
> > +                       if (str_is_empty(targ_n))
> > +                               continue;
> > +
> > +                       if (strcmp(local_n, targ_n) != 0)
> > +                               continue;
> > +
> > +                       err = __bpf_core_types_match(local_btf, local_m->type, targ_btf,
> > +                                                    targ_m->type, level - 1);
> > +                       if (err > 0) {
> > +                               matched = true;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               if (!matched)
> > +                       return 0;
> > +       }
> > +       return 1;
> > +}
> > +
> > +static int __bpf_core_types_match(const struct btf *local_btf, u32 local_id,
> I personally think it's cleaner (though more verbose) if a boolean
> return arg is passed in to denote whether there's a match, instead of
> returning error, 0 for not a match, and 1 for a match

It basically gets back to the points raised earlier already of us just copying
the signature of existing functionality for consistency while also having the
potential for error returns.

I don't know whether it's good practice, but I do feel that if we change this
function we should change bpf_core_types_are_compat() (and if we go with bool
we'd loose information about potential errors).

> > +                                 const struct btf *targ_btf, u32 targ_id, int level)
> > +{
> > +       const struct btf_type *local_t, *targ_t, *prev_local_t;
> > +       int depth = 32; /* max recursion depth */
> > +       __u16 local_k;
> nit: u16 and elsewhere in this function

I do have the same comment as above. Once moved to relo_core.c, u16 is flagged
by the compiler :-|

> > +
> > +       if (level <= 0)
> > +               return -EINVAL;
> > +
> > +       local_t = btf_type_by_id(local_btf, local_id);
> > +       targ_t = btf_type_by_id(targ_btf, targ_id);
> > +
> > +recur:
> > +       depth--;
> > +       if (depth < 0)
> > +               return -EINVAL;
> > +
> > +       prev_local_t = local_t;
> > +
> > +       local_t = btf_type_skip_modifiers(local_btf, local_id, &local_id);
> > +       targ_t = btf_type_skip_modifiers(targ_btf, targ_id, &targ_id);
> > +       if (!local_t || !targ_t)
> > +               return -EINVAL;
> > +
> > +       if (!bpf_core_names_match(local_btf, local_id, targ_btf, targ_id))
> > +               return 0;
> > +
> > +       local_k = btf_kind(local_t);
> > +
> > +       switch (local_k) {
> > +       case BTF_KIND_UNKN:
> > +               return local_k == btf_kind(targ_t);
> > +       case BTF_KIND_FWD: {
> > +               bool local_f = btf_type_kflag(local_t);
> > +               __u16 targ_k = btf_kind(targ_t);
> > +
> > +               if (btf_is_ptr(prev_local_t)) {
> > +                       if (local_k == targ_k)
> > +                               return local_f == btf_type_kflag(local_t);
> > +
> > +                       return (targ_k == BTF_KIND_STRUCT && !local_f) ||
> > +                              (targ_k == BTF_KIND_UNION && local_f);
> I think it'd be helpful if a comment was included here that the kind
> flag for BTF_KIND_FWD is 0 for struct and 1 for union

Makes sense. Added.

> > +               } else {
> > +                       if (local_k != targ_k)
> > +                               return 0;
> > +
> > +                       /* match if the forward declaration is for the same kind */
> > +                       return local_f == btf_type_kflag(local_t);
> > +               }
> > +       }
> > +       case BTF_KIND_ENUM:
> > +       case BTF_KIND_ENUM64:
> > +               if (!btf_is_any_enum(targ_t))
> > +                       return 0;
> > +
> > +               return bpf_core_enums_match(local_btf, local_t, targ_btf, targ_t);
> > +       case BTF_KIND_STRUCT:
> > +       case BTF_KIND_UNION: {
> > +               __u16 targ_k = btf_kind(targ_t);
> > +
> > +               if (btf_is_ptr(prev_local_t)) {
> > +                       bool targ_f = btf_type_kflag(local_t);
> Did you mean btf_type_kflag(targ_t)?

I did! Good catch. Changed it.

> > +
> > +                       if (local_k == targ_k)
> > +                               return 1;
> Why don't we need to check if bpf_core_composites_match() in this case?

We basically agreed that once we reach a composite type that is behind a
pointer, we should stop performing a full member match-up and just check name
and kind and be done. bpf_core_composites_match() would perform the full check
and so we don't use it in this branch.

> > +
> > +                       if (targ_k != BTF_KIND_FWD)
> > +                               return 0;
> Can there be the case where targ_k is a BTF_KIND_PTR to the same struct/union?

If I understand what you are asking correctly then yes, this case can happen,
but it should not result in a match.

I believe we could hit this case when trying to match up
  a_struct* x
with
  a_struct** x

We do want to make sure that the same number of indirections are present for a
match to be recorded.

> > +
> > +                       return (local_k == BTF_KIND_UNION) == targ_f;
> > +               } else {
> > +                       if (local_k != targ_k)
> > +                               return 0;
> > +
> > +                       return bpf_core_composites_match(local_btf, local_t, targ_btf, targ_t,
> > +                                                        level);
> > +               }
> > +       }
> > +       case BTF_KIND_INT: {
> > +               __u8 local_sgn;
> > +               __u8 targ_sgn;
> > +
> > +               if (local_k != btf_kind(targ_t))
> > +                       return 0;
> > +
> > +               local_sgn = btf_int_encoding(local_t) & BTF_INT_SIGNED;
> > +               targ_sgn = btf_int_encoding(targ_t) & BTF_INT_SIGNED;
> > +
> > +               return btf_int_bits(local_t) == btf_int_bits(targ_t) && local_sgn == targ_sgn;
> > +       }
> > +       case BTF_KIND_PTR:
> > +               if (local_k != btf_kind(targ_t))
> > +                       return 0;
> > +
> > +               local_id = local_t->type;
> > +               targ_id = targ_t->type;
> > +               goto recur;
> > +       case BTF_KIND_ARRAY: {
> > +               const struct btf_array *local_array = btf_type_array(local_t);
> > +               const struct btf_array *targ_array = btf_type_array(targ_t);
> > +
> > +               if (local_k != btf_kind(targ_t))
> > +                       return 0;
> > +
> > +               if (local_array->nelems != targ_array->nelems)
> > +                       return 0;
> > +
> > +               local_id = local_array->type;
> > +               targ_id = targ_array->type;
> > +               goto recur;
> > +       }
> > +       case BTF_KIND_FUNC_PROTO: {
> > +               struct btf_param *local_p = btf_params(local_t);
> > +               struct btf_param *targ_p = btf_params(targ_t);
> > +               u16 local_vlen = btf_vlen(local_t);
> > +               u16 targ_vlen = btf_vlen(targ_t);
> > +               int i, err;
> > +
> > +               if (local_k != btf_kind(targ_t))
> > +                       return 0;
> > +
> > +               if (local_vlen != targ_vlen)
> > +                       return 0;
> > +
> > +               for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
> > +                       err = __bpf_core_types_match(local_btf, local_p->type, targ_btf,
> > +                                                    targ_p->type, level - 1);
> > +                       if (err <= 0)
> > +                               return err;
> > +               }
> > +
> > +               /* tail recurse for return type check */
> > +               local_id = local_t->type;
> > +               targ_id = targ_t->type;
> > +               goto recur;
> > +       }
> > +       default:
> Do BTF_KIND_FLOAT and BTF_KIND_TYPEDEF need to be checked as well?

Lack of BTF_KIND_TYPEDEF is a good question. I don't know why it's missing from
bpf_core_types_are_compat() as well, which I took as a template. I will do some
testing to better understand if we can hit this case or whether there is some
magic going on that would have resolved typedefs already at this point (which is
my suspicion).
My understanding why we don't cover floats is because we do not allow floating
point operations in kernel code (right?).

> > +               return 0;
> > +       }
> > +}
> > +
> > +int bpf_core_types_match(const struct btf *local_btf, u32 local_id,
> > +                        const struct btf *targ_btf, u32 targ_id)
> > +{
> > +       return __bpf_core_types_match(local_btf, local_id,
> > +                                     targ_btf, targ_id,
> > +                                     MAX_TYPES_MATCH_DEPTH);
> > +}
> Also, btw, thanks for the thorough cover letter - its high-level
> overview made it easier to understand the patches

Thanks!

Daniel
