Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE8620353
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiKGXJd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKGXJc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:09:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E771FCD6
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:09:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so34218743ejc.4
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayhK4uUG9nDhkYW0271GbtTzx/2u6sp8RjwLfUFCWPo=;
        b=Ao/8O7aSMF1JoZHWHcsWlKPLthzWax/utphc3yPpUomXgFYpvr8rFzvz+o9PI9Rpg/
         H+3CzC89FASBtDM5yZJZLBxZXgWfdzlxUZDbkyLnyri8671sVKh3PCK5/s6sjRsq04l/
         7QD+4919imh1rZupRbM8PWgiNcOgtbl0j+t+hWH9mxZc5kJdtdtscnlIBvwjb3bj7etv
         DJ4iuNZBeYvCLCcumZk0IaAMM3F/J74Dzlby5BW5CWRTUZdBjjYWtJpz7nEB8eEXVKMu
         77KjpoAnIe714gubquqoZ/ofRx5UiflFXxugVbJAVK9TBUkpHsNV8Q6qjAfVyxzGZk9W
         fosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayhK4uUG9nDhkYW0271GbtTzx/2u6sp8RjwLfUFCWPo=;
        b=7xX+Zs9M0VM+o6s5u0ak6akaJEIYXvAHnEZjFI+fmHz5NP4yunVWQ2B4fgzzfE4/eb
         aeyJ1vHLQDadLJdFSBMi4Oo9uWwIcfVV3GpgA4eXVPCcnwvrymhh54nM4Z+YQ0ImaSRk
         dtAcivOy4+sOhokp4jsGSQfU/fvGWpfYJaGWsVaURc4F7nEloU7WOBdop+rMb+8Cm1R+
         ajNvJ/0FqvHRKkBu0nlqzHuqrV2cJEvyRsIZyLOt7zyeSAYnUaooxWY4R+PzaU14aWSb
         VjH3/YkSHruS9ZGCNJL4gG6VZZ7W9qQwcfRfkt7pzR/cVwhaxqzOEAT7HVUg8nTZmu92
         4uqA==
X-Gm-Message-State: ACrzQf2etbXWJ+ulZqI96NzODZeX6zMePldcHT4JFNiOhlXv2qhRY/vQ
        zjor+P4sKcaLYOQ7XRvCiDxxHz4rj8cGYx51Qso=
X-Google-Smtp-Source: AMsMyM4mZ/IuU1Y1nDDSaIlip7NJ0w4Z8L3WiHCiI76I+zuRxDSC95fGlv7QKnU9M8Vt1QWO49UPPTqDQZ3TZLSm0QY=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr30786263eja.545.1667862569906; Mon, 07
 Nov 2022 15:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20221103134522.2764601-1-eddyz87@gmail.com> <CAEf4Bzb9dcBy5JEWzphkfr=wzvcT8gXcCjA5UYPPKAywh=k_Fg@mail.gmail.com>
 <e54ee0f0528ad7b9e59c39b3e7da1144ed45cbba.camel@gmail.com>
In-Reply-To: <e54ee0f0528ad7b9e59c39b3e7da1144ed45cbba.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Nov 2022 15:09:17 -0800
Message-ID: <CAEf4BzYzVLTojnbx-qK6BchBYj599yK7fohssfDX=nSbHUJRwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: __attribute__((btf_decl_tag("...")))
 for btf dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
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

On Mon, Nov 7, 2022 at 7:35 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2022-11-04 at 13:54 -0700, Andrii Nakryiko wrote:
> > On Thu, Nov 3, 2022 at 6:45 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > Clang's `__attribute__((btf_decl_tag("...")))` is represented in BTF
> > > as a record of kind BTF_KIND_DECL_TAG with `type` field pointing to
> > > the type annotated with this attribute. This commit adds
> > > reconstitution of such attributes for BTF dump in C format.
> > >
> > > BTF doc says that BTF_KIND_DECL_TAGs should follow a target type but
> > > this is not enforced and tests don't honor this restriction.
> > > This commit uses hashmap to map types to the list of decl tags.
> > > The hashmap is filled by `btf_dump_assign_decl_tags` function called
> > > from `btf_dump__new`.
> > >
> > > It is assumed that total number of types annotated with decl tags is
> > > relatively small, thus some space is saved by using hashmap instead of
> > > adding a new field to `struct btf_dump_type_aux_state`.
> > >
> > > It is assumed that list of decl tags associated with a single type is
> > > small. Thus the list is represented by an array which grows linearly.
> > >
> > > To accommodate older Clang versions decl tags are dumped using the
> > > following macro:
> > >
> > >  #if __has_attribute(btf_decl_tag)
> > >  #  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
> > >  #else
> > >  #  define __btf_decl_tag(x)
> > >  #endif
> > >
> > > The macro definition is emitted upon first call to `btf_dump__dump_type`.
> > >
> > > Clang allows to attach btf_decl_tag attributes to the following kinds
> > > of items:
> > > - struct/union         supported
> > > - struct/union field   supported
> > > - typedef              supported
> > > - function             not applicable
> > > - function parameter   not applicable
> > > - variable             not applicable
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  tools/lib/bpf/btf_dump.c | 163 ++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 160 insertions(+), 3 deletions(-)
> > >
> >
> > Functions and their args can also have tags. This works:
> >
> > diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > index 7a5af8b86065..75fcabe700cd 100644
> > --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > @@ -54,7 +54,7 @@ struct root_struct {
> >
> >  /* ------ END-EXPECTED-OUTPUT ------ */
> >
> > -int f(struct root_struct *s)
> > +int f(struct root_struct *s __btf_decl_tag("func_arg_tag"))
> > __btf_decl_tag("func_tag")
> >  {
> >         return 0;
> >  }
> >
> > And I see correct BTF:
> >
> > [26] FUNC 'f' type_id=25 linkage=global
> > [27] DECL_TAG 'func_arg_tag' type_id=26 component_idx=0
> > [28] DECL_TAG 'func_tag' type_id=26 component_idx=-1
> >
> > So let's add support and test for that case as well. btf_dump
> > shouldn't assume vmlinux.h-only case.
> >
> > Also, please check if DATASEC and VARs can have decl_tags associated with them.
>
> I see that right now decl tags are saved for:
> - BTF_KIND_VAR
> - BTF_KIND_FUNC
> - BTF_KIND_FUNC arguments
>
> Decl tags are lost but legal for:
> - BTF_KIND_FUNC_PROTO arguments

ah, that's unfortunate and even DECL_TAGS example I showed above seems
like a bug. FUNC itself doesn't have args, I implicitly assumed that
all DECL_TAG will be actually associated with underlying FUNC_PROTO.

Yonghong, is this by design or a bug?

>
> I have not found a way to attach decl tag to DATASEC.
>
> For BTF_KIND_FUNC_PROTO  arguments it would  be great to  update clang
> first. Then  it would be  possible to keep all  decl tags checks  as a
> single  `btf_dump_test_case`.  On  the   other  hand  this  will  make
> testsuite dependent on the latest clang version, which is not great. I
> can add a test with hand-crafted BTF instead. Which way is preferable?

let's figure out if current state is accidental or by design.

From practical standpoint, I'd still implement the code for FUNC_PROTO
and its args, but I wouldn't go all the way to hand-craft BTF
programmatically. As you said, btf_dump tests are way more ergonomic
because we rely on compiler to do the heavy lifting.

As for the dependency on latest clang for some tests, I think that's
totally fine and unavoidable. Worst case some subtests will fail on
old kernels, they can be denylisted on systems with old compiler. All
that won't break the build (which is much worse and inconvenient).

>
> BTF_KIND_FUNC is ignored by `btf_dump__dump_type_data`
> (via `btf_dump_unsupported_data`).
>
> BTF_KIND_VAR is dumped but current  testing infrastructure is not very
> convenient, it only checks for  some variables defined in vmlinux BTF.
> I can write a  test that accepts a custom built BTF  but this is still
> inferior   to  what   `test_btf_dump_case`  provides.   I've  extended
> `test_btf_dump_case` to print DATASEC  with subordinate vars alongside
> the type definitions instead.
>

dumping DATASEC/VAR and FUNC is something that seems useful in
general, but we should treat it as a separate problem. Seeing DATASEC
variables and FUNCs in a familiar C syntax would be nice, but it
probably should be guarded behind a bpftool option or something.

So in summary, let's figure out the situation with FUNC and FUNC_PROTO
first, and let's not due too laborious selftests yet

> ------
>
> $ cat test.c
> #define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
>
> int var __btf_decl_tag("var_tag");
>
> struct root {
>   int a;
>   int (*b)(int x __btf_decl_tag("arg_tag_proto")) __btf_decl_tag("field_tag");
> };
>
> int foo(struct root *x __btf_decl_tag("arg_tag_fn")) __btf_decl_tag("func_tag_fn") {
>   return 0;
> }
> $ clang -g -O2 -mcpu=v3 -target bpf -c test.c -o test.o
> $ bpftool btf dump file test.o
> [1] PTR '(anon)' type_id=2
> [2] STRUCT 'root' size=16 vlen=2
>         'a' type_id=3 bits_offset=0
>         'b' type_id=4 bits_offset=64
> [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [4] PTR '(anon)' type_id=5
> [5] FUNC_PROTO '(anon)' ret_type_id=3 vlen=1
>         '(anon)' type_id=3
> [6] DECL_TAG 'field_tag' type_id=2 component_idx=1
> [7] FUNC_PROTO '(anon)' ret_type_id=3 vlen=1
>         'x' type_id=1
> [8] FUNC 'foo' type_id=7 linkage=global
> [9] DECL_TAG 'arg_tag_fn' type_id=8 component_idx=0
> [10] DECL_TAG 'func_tag_fn' type_id=8 component_idx=-1
> [11] VAR 'var' type_id=3, linkage=global
> [12] DECL_TAG 'var_tag' type_id=11 component_idx=-1
> [13] DATASEC '.bss' size=0 vlen=1
>         type_id=11 offset=0 size=4 (VAR 'var')
>
> > [...]
> >

[...]
