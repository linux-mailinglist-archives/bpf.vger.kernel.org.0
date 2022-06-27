Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5255CC77
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiF0V2q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbiF0V2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:28:45 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C58B1EA
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:28:43 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EFB0B240029
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 23:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656365322; bh=K6DgMMPmUfLIDULJTueDnOJKMc5VVYtoBafnar0XsZE=;
        h=Date:From:To:Cc:Subject:From;
        b=Tuvla14rYSZcuGuuoPN6nO0+gbzBgTggxXp8w7Xcnk2LTWUKMiFkCcDM+PwAKQIQ5
         BJlYHiprnqgWWGWkjHBu/QPnCMS+VmK7mW+5X+CKAlfOlP7P+edJNkaabyB1p3y2oW
         Y8KTWO/euv1TMTK4edBGdN/QTZXu2rWHRvKkfJHGIF0zelt2lw+8MEKHKYm2fTv2Fp
         ynNOCzBhTa48gv0vNAoa9MVVm0Rc9inUtLmQ4VkkltHlxWxvOJaBfqNmxuaHLkF9ua
         y2ShKbPFewUA/zr3BTfo9KtilcMomPh+rJY516b1O+eenc2uZ2Gvf1E/OkFmpS15mE
         sF+FiBzD/vU0Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LX17C1pchz6tmR;
        Mon, 27 Jun 2022 23:28:39 +0200 (CEST)
Date:   Mon, 27 Jun 2022 21:28:35 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] libbpf: Add type match support
Message-ID: <20220627212835.ymcgpalreldvipkb@muellerd-fedora-MJ0AC3F3>
References: <20220623212205.2805002-1-deso@posteo.net>
 <20220623212205.2805002-5-deso@posteo.net>
 <CAEf4BzZA43SMt1_ex6LzLHWO2=P_G=YJbocejyEP2WU2atRHQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZA43SMt1_ex6LzLHWO2=P_G=YJbocejyEP2WU2atRHQA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 02:39:00PM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 23, 2022 at 2:22 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > This patch adds support for the proposed type match relation to
> > relo_core where it is shared between userspace and kernel. A bit more
> > plumbing is necessary and will arrive with subsequent changes to
> > actually use it -- this patch only introduces the main matching
> > algorithm.
> >
> > The matching relation is defined as follows (copy from source):
> > - modifiers and typedefs are stripped (and, hence, effectively ignored)
> > - generally speaking types need to be of same kind (struct vs. struct, union
> >   vs. union, etc.)
> >   - exceptions are struct/union behind a pointer which could also match a
> >     forward declaration of a struct or union, respectively, and enum vs.
> >     enum64 (see below)
> > Then, depending on type:
> > - integers:
> >   - match if size and signedness match
> > - arrays & pointers:
> >   - target types are recursively matched
> > - structs & unions:
> >   - local members need to exist in target with the same name
> >   - for each member we recursively check match unless it is already behind a
> >     pointer, in which case we only check matching names and compatible kind
> > - enums:
> >   - local variants have to have a match in target by symbolic name (but not
> >     numeric value)
> >   - size has to match (but enum may match enum64 and vice versa)
> > - function pointers:
> >   - number and position of arguments in local type has to match target
> >   - for each argument and the return value we recursively check match
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  tools/lib/bpf/relo_core.c | 276 ++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/relo_core.h |   2 +
> >  2 files changed, 278 insertions(+)
> >
> > diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> > index 6ad3c3..bc5b060 100644
> > --- a/tools/lib/bpf/relo_core.c
> > +++ b/tools/lib/bpf/relo_core.c
> > @@ -1330,3 +1330,279 @@ int bpf_core_calc_relo_insn(const char *prog_name,
> >
> >         return 0;
> >  }
> > +
> > +static bool bpf_core_names_match(const struct btf *local_btf, const struct btf_type *local_t,
> > +                                const struct btf *targ_btf, const struct btf_type *targ_t)
> > +{
> > +       const char *local_n, *targ_n;
> > +
> > +       local_n = btf__name_by_offset(local_btf, local_t->name_off);
> > +       targ_n = btf__name_by_offset(targ_btf, targ_t->name_off);
> > +
> > +       return !strncmp(local_n, targ_n, bpf_core_essential_name_len(local_n));
> > +}
> > +
> 
> we have similar check in existing code in at least two other places
> (search for strncmp in relo_core.c). But it doesn't always work with
> btf_type, it sometimes is field name, sometimes is part of core_spec.
> 
> so it's confusing that we have this helper used in *one* place, and
> other places open-code this logic. We can probably have a helper, but
> it will have to be taking const char * arguments and doing
> bpf_core_essential_name_len() for both

Sure.

> > +static int bpf_core_enums_match(const struct btf *local_btf, const struct btf_type *local_t,
> > +                               const struct btf *targ_btf, const struct btf_type *targ_t)
> > +{
> > +       __u16 local_vlen = btf_vlen(local_t);
> > +       __u16 targ_vlen = btf_vlen(targ_t);
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
> > +               size_t local_len;
> > +
> > +               local_n_off = btf_is_enum(local_t) ? btf_enum(local_t)[i].name_off :
> > +                                                    btf_enum64(local_t)[i].name_off;
> > +
> > +               local_n = btf__name_by_offset(local_btf, local_n_off);
> > +               local_len = bpf_core_essential_name_len(local_n);
> > +
> > +               for (j = 0; j < targ_vlen; j++) {
> > +                       const char *targ_n;
> > +                       __u32 targ_n_off;
> > +
> > +                       targ_n_off = btf_is_enum(targ_t) ? btf_enum(targ_t)[j].name_off :
> > +                                                          btf_enum64(targ_t)[j].name_off;
> > +                       targ_n = btf__name_by_offset(targ_btf, targ_n_off);
> > +
> > +                       if (str_is_empty(targ_n))
> > +                               continue;
> > +
> > +                       if (!strncmp(local_n, targ_n, local_len)) {
> 
> and here you open-code name check instead of using your helper ;) but
> also shouldn't you calculate "essential name len" for target enum as
> well?.. otherwise local whatever___abc will match whatever123, which
> won't be right
> 
> and I'm not hard-core enough to easily understand !strncmp() (as I
> also mentioned in another email), I think explicit == 0 is easier to
> follow for str[n]cmp() APIs.

Done.

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
> > +static int bpf_core_composites_match(const struct btf *local_btf, const struct btf_type *local_t,
> > +                                    const struct btf *targ_btf, const struct btf_type *targ_t,
> > +                                    int level)
> > +{
> > +       const struct btf_member *local_m = btf_members(local_t);
> > +       __u16 local_vlen = btf_vlen(local_t);
> > +       __u16 targ_vlen = btf_vlen(targ_t);
> > +       int i, j, err;
> > +
> > +       if (local_vlen > targ_vlen)
> > +               return 0;
> > +
> > +       /* check that all local members have a match in the target */
> > +       for (i = 0; i < local_vlen; i++, local_m++) {
> > +               const char *local_n = btf__name_by_offset(local_btf, local_m->name_off);
> > +               const struct btf_member *targ_m = btf_members(targ_t);
> > +               bool matched = false;
> > +
> > +               for (j = 0; j < targ_vlen; j++, targ_m++) {
> > +                       const char *targ_n = btf__name_by_offset(targ_btf, targ_m->name_off);
> > +
> > +                       if (str_is_empty(targ_n))
> > +                               continue;
> > +
> > +                       if (strcmp(local_n, targ_n) != 0)
> > +                               continue;
> 
> let's have the essential_len logic used consistently for all these
> field and type name checks?

Sounds good.

[...]

> > +       depth--;
> > +       if (depth < 0)
> > +               return -EINVAL;
> > +
> > +       prev_local_t = local_t;
> > +
> > +       local_t = skip_mods_and_typedefs(local_btf, local_id, &local_id);
> > +       targ_t = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
> > +       if (!local_t || !targ_t)
> > +               return -EINVAL;
> > +
> > +       if (!bpf_core_names_match(local_btf, local_t, targ_btf, targ_t))
> > +               return 0;
> > +
> > +       local_k = btf_kind(local_t);
> > +
> > +       switch (local_k) {
> > +       case BTF_KIND_UNKN:
> > +               return local_k == btf_kind(targ_t);
> > +       case BTF_KIND_FWD: {
> > +               bool local_f = BTF_INFO_KFLAG(local_t->info);
> > +               __u16 targ_k = btf_kind(targ_t);
> > +
> > +               if (btf_is_ptr(prev_local_t)) {
> 
> this doesn't work in general, you can have PTR -> CONST -> FWD, you
> need to just remember that you saw PTR in the chain of types

Fair enough; will adjust.

[...]

Thanks,
Daniel
