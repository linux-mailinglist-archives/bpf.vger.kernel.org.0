Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5883955D9BA
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiF0Qul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiF0Quk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 12:50:40 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E08F5B6
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 09:50:39 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 1674A240028
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 18:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656348638; bh=h2HR5niklgwTRvmb0Zl6lHgpHzruhub6r34JQ69V9M8=;
        h=Date:From:To:Cc:Subject:From;
        b=LuKeECc2jomND35mDsEpDQkssO3hm5N/gfwVa2VBJf8SiV39dWtqw06ASULVY5Bi5
         P4EAa68mxiYMiEwA9Fq1LIg4P9otgbsxkVJOradaxPHMESA0yjeyk+H0+6gWMD4L7s
         ECoZqR5iY23zmBdQQC2+2w0pC+lJMkV+kZSukFmuhHMVRZzIM+oX21R8Mnd9hWDmPe
         NY6zVD8qp8Cr3/uhPcHGvs56dSAAQZ2r/VKMI3IQsYkGz8NaaH7bL2QDmHnO6TZOfw
         jCC56Uy5az4uViwg/1wjCk9cVbwwPGFfeyBTuE0c12+ie1GZQwMnjDNMFd31vfTivX
         iEicWm4Iy3Gmg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LWtyL6LWJz6tmm;
        Mon, 27 Jun 2022 18:50:34 +0200 (CEST)
Date:   Mon, 27 Jun 2022 16:50:31 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next v2 2/9] bpftool: Honor BPF_CORE_TYPE_MATCHES
 relocation
Message-ID: <20220627165031.pkn4rzx2wxghqi7e@muellerd-fedora-MJ0AC3F3>
References: <20220623212205.2805002-1-deso@posteo.net>
 <20220623212205.2805002-3-deso@posteo.net>
 <CAEf4BzasPaUkz9=1NwUp7MSeCM28W-24BBB_jrO9WDeXXTtOeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzasPaUkz9=1NwUp7MSeCM28W-24BBB_jrO9WDeXXTtOeQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 02:25:50PM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 23, 2022 at 2:22 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > bpftool needs to know about the newly introduced BPF_CORE_TYPE_MATCHES
> > relocation for its 'gen min_core_btf' command to work properly in the
> > present of this relocation.
> > Specifically, we need to make sure to mark types and fields so that they
> > are present in the minimized BTF for "type match" checks to work out.
> > However, contrary to the existing btfgen_record_field_relo, we need to
> > rely on the BTF -- and not the spec -- to find fields. With this change
> > we handle this new variant correctly. The functionality will be tested
> > with follow on changes to BPF selftests, which already run against a
> > minimized BTF created with bpftool.
> >
> > Cc: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  tools/bpf/bpftool/gen.c | 107 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 480cbd8..6cd0ed 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -1856,6 +1856,111 @@ static int btfgen_record_field_relo(struct btfgen_info *info, struct bpf_core_sp
> >         return 0;
> >  }
> >
> > +/* Mark types, members, and member types. Compared to btfgen_record_field_relo,
> > + * this function does not rely on the target spec for inferring members, but
> > + * uses the associated BTF.
> > + *
> > + * The `behind_ptr` argument is used to stop marking of composite types reached
> > + * through a pointer. This way, we keep can keep BTF size in check while
> > + * providing reasonable match semantics.
> > + */
> > +static int btfgen_mark_types_match(struct btfgen_info *info, __u32 type_id, bool behind_ptr)
> > +{
> > +       const struct btf_type *btf_type;
> > +       struct btf *btf = info->src_btf;
> > +       struct btf_type *cloned_type;
> > +       int i, err;
> > +
> > +       if (type_id == 0)
> > +               return 0;
> > +
> > +       btf_type = btf__type_by_id(btf, type_id);
> > +       /* mark type on cloned BTF as used */
> > +       cloned_type = (struct btf_type *)btf__type_by_id(info->marked_btf, type_id);
> > +       cloned_type->name_off = MARKED;
> > +
> > +       switch (btf_kind(btf_type)) {
> > +       case BTF_KIND_UNKN:
> > +       case BTF_KIND_INT:
> > +       case BTF_KIND_FLOAT:
> > +       case BTF_KIND_ENUM:
> > +       case BTF_KIND_ENUM64:
> > +               break;
> > +       case BTF_KIND_STRUCT:
> > +       case BTF_KIND_UNION: {
> > +               struct btf_member *m = btf_members(btf_type);
> > +               __u16 vlen = btf_vlen(btf_type);
> > +
> > +               if (behind_ptr)
> > +                       break;
> > +
> > +               for (i = 0; i < vlen; i++, m++) {
> > +                       /* mark member */
> > +                       btfgen_mark_member(info, type_id, i);
> > +
> > +                       /* mark member's type */
> > +                       err = btfgen_mark_types_match(info, m->type, false);
> > +                       if (err)
> > +                               return err;
> > +               }
> > +               break;
> > +       }
> > +       case BTF_KIND_CONST:
> > +       case BTF_KIND_FWD:
> > +       case BTF_KIND_VOLATILE:
> > +       case BTF_KIND_TYPEDEF:
> 
> BTF_KIND_RESTRICT is missing?

Good catch. It's missing in btfgen_mark_type as well. Will add it.

> > +               return btfgen_mark_types_match(info, btf_type->type, false);
> > +       case BTF_KIND_PTR:
> > +               return btfgen_mark_types_match(info, btf_type->type, true);
> > +       case BTF_KIND_ARRAY: {
> > +               struct btf_array *array;
> > +
> > +               array = btf_array(btf_type);
> > +               /* mark array type */
> > +               err = btfgen_mark_types_match(info, array->type, false);
> > +               /* mark array's index type */
> > +               err = err ? : btfgen_mark_types_match(info, array->index_type, false);
> > +               if (err)
> > +                       return err;
> > +               break;
> > +       }
> 
> [...]
