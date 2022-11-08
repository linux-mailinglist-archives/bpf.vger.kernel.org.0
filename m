Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644362056A
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 01:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiKHAyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 19:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiKHAyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 19:54:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEDECE1
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 16:54:17 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d26so34590122eje.10
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 16:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xanQMj5nhv/yS8HoyKJmQq0AyCL5tJVD6BkEKMBUp+c=;
        b=f+2EdNyN0f0x31eAw631uTBr29fg+R4soJ/x3X7pZSeAlBoAB2iZkO6MxQjOm/1BSK
         lrYrADOQsiFkKX49cdGYI1DEncQ3H8PWMsXPNYQLKfXP962DOX9xZe5SzPGKbD0EmfMK
         6vLDAnyDk2YN3upxB9dGFNxdYPSxg0OvgRD80rdreyfU0JSMgVBBvSZmeAq1lp9n321x
         CcgH9OmXMQ9RG/KAZ5XxR+nKVSdC18PASg4/Yseihkigg4VGu3J4yEpE2yEzTfyl202n
         QIiK4Ldz2Mh3ALVz4xZh6YOEmbyWSGyk0yrHzIoOnaDGacl9wGQhD6gxno5UCK4CWVJ0
         LEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xanQMj5nhv/yS8HoyKJmQq0AyCL5tJVD6BkEKMBUp+c=;
        b=inhGktIjSPdp9GJVImRw5RZV83CebhGBGybmc5sy1pc6F8Qswasp+D69+wxlJJqcu0
         5zYomIRpDYMGVGTCgIZ1OgQGtBK/Pj/HkonpLAfGUDnajImyBdcNV70RsHllGCWwoi++
         OM2233Q2JzHyjInRH8p4MAgxORYyuNjGPwV/UcCCMALtpbhLUVNr+q3558+Zx5tPmOmL
         jMAOFat2qwEdoB+gnAoyi5G/dkHGyzrHB448387kWw3GVOO0oQFOTkb/ZoYk6zuwcefY
         EZ/YUfrAU2wLEYhoDUEbh4z+6zP5LAcr8X6E9fD+F0UxPTPE6P1WKn2Tnk6Z4RuBTqcl
         FxZA==
X-Gm-Message-State: ACrzQf1DfWNeLsCnfSW0XTDpMX2vDWdzGiEt39yzHNzBARqwoRp6cf7c
        mNRxQg7oomxXWpluCwkUicreo2PXITBigajcv0EMkdKi
X-Google-Smtp-Source: AMsMyM4fEih4hvNdbW1IC4zOfjsBbV0zcceNihyN0uU3+VINvMFc2ad4hPBiAh5YPRb2A9zS/gzJGENFESGjFZIIvhs=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr31150499eja.545.1667868856133; Mon, 07
 Nov 2022 16:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20221103134522.2764601-1-eddyz87@gmail.com> <CAEf4Bzb9dcBy5JEWzphkfr=wzvcT8gXcCjA5UYPPKAywh=k_Fg@mail.gmail.com>
 <e54ee0f0528ad7b9e59c39b3e7da1144ed45cbba.camel@gmail.com>
 <CAEf4BzYzVLTojnbx-qK6BchBYj599yK7fohssfDX=nSbHUJRwA@mail.gmail.com> <726d3b01f69ddb158ff79e648f29bed5c9b27e0e.camel@gmail.com>
In-Reply-To: <726d3b01f69ddb158ff79e648f29bed5c9b27e0e.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Nov 2022 16:54:03 -0800
Message-ID: <CAEf4BzbGTjPa+brkJ63DjBwFZ95EjYyqPbDXQbCvD6rECqYW5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: __attribute__((btf_decl_tag("...")))
 for btf dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com
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

On Mon, Nov 7, 2022 at 3:17 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Mon, 2022-11-07 at 15:09 -0800, Andrii Nakryiko wrote:
> > On Mon, Nov 7, 2022 at 7:35 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Fri, 2022-11-04 at 13:54 -0700, Andrii Nakryiko wrote:
> > > > On Thu, Nov 3, 2022 at 6:45 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > >
> > > > > Clang's `__attribute__((btf_decl_tag("...")))` is represented in BTF
> > > > > as a record of kind BTF_KIND_DECL_TAG with `type` field pointing to
> > > > > the type annotated with this attribute. This commit adds
> > > > > reconstitution of such attributes for BTF dump in C format.
> > > > >
> > > > > BTF doc says that BTF_KIND_DECL_TAGs should follow a target type but
> > > > > this is not enforced and tests don't honor this restriction.
> > > > > This commit uses hashmap to map types to the list of decl tags.
> > > > > The hashmap is filled by `btf_dump_assign_decl_tags` function called
> > > > > from `btf_dump__new`.
> > > > >
> > > > > It is assumed that total number of types annotated with decl tags is
> > > > > relatively small, thus some space is saved by using hashmap instead of
> > > > > adding a new field to `struct btf_dump_type_aux_state`.
> > > > >
> > > > > It is assumed that list of decl tags associated with a single type is
> > > > > small. Thus the list is represented by an array which grows linearly.
> > > > >
> > > > > To accommodate older Clang versions decl tags are dumped using the
> > > > > following macro:
> > > > >
> > > > >  #if __has_attribute(btf_decl_tag)
> > > > >  #  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
> > > > >  #else
> > > > >  #  define __btf_decl_tag(x)
> > > > >  #endif
> > > > >
> > > > > The macro definition is emitted upon first call to `btf_dump__dump_type`.
> > > > >
> > > > > Clang allows to attach btf_decl_tag attributes to the following kinds
> > > > > of items:
> > > > > - struct/union         supported
> > > > > - struct/union field   supported
> > > > > - typedef              supported
> > > > > - function             not applicable
> > > > > - function parameter   not applicable
> > > > > - variable             not applicable
> > > > >
> > > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > > ---
> > > > >  tools/lib/bpf/btf_dump.c | 163 ++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 160 insertions(+), 3 deletions(-)
> > > > >
> > > >
> > > > Functions and their args can also have tags. This works:
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > > > b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > > > index 7a5af8b86065..75fcabe700cd 100644
> > > > --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > > > +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > > > @@ -54,7 +54,7 @@ struct root_struct {
> > > >
> > > >  /* ------ END-EXPECTED-OUTPUT ------ */
> > > >
> > > > -int f(struct root_struct *s)
> > > > +int f(struct root_struct *s __btf_decl_tag("func_arg_tag"))
> > > > __btf_decl_tag("func_tag")
> > > >  {
> > > >         return 0;
> > > >  }
> > > >
> > > > And I see correct BTF:
> > > >
> > > > [26] FUNC 'f' type_id=25 linkage=global
> > > > [27] DECL_TAG 'func_arg_tag' type_id=26 component_idx=0
> > > > [28] DECL_TAG 'func_tag' type_id=26 component_idx=-1
> > > >
> > > > So let's add support and test for that case as well. btf_dump
> > > > shouldn't assume vmlinux.h-only case.
> > > >
> > > > Also, please check if DATASEC and VARs can have decl_tags associated with them.
> > >
> > > I see that right now decl tags are saved for:
> > > - BTF_KIND_VAR
> > > - BTF_KIND_FUNC
> > > - BTF_KIND_FUNC arguments
> > >
> > > Decl tags are lost but legal for:
> > > - BTF_KIND_FUNC_PROTO arguments
> >
> > ah, that's unfortunate and even DECL_TAGS example I showed above seems
> > like a bug. FUNC itself doesn't have args, I implicitly assumed that
> > all DECL_TAG will be actually associated with underlying FUNC_PROTO.
> >
> > Yonghong, is this by design or a bug?
> >
> > >
> > > I have not found a way to attach decl tag to DATASEC.
> > >
> > > For BTF_KIND_FUNC_PROTO  arguments it would  be great to  update clang
> > > first. Then  it would be  possible to keep all  decl tags checks  as a
> > > single  `btf_dump_test_case`.  On  the   other  hand  this  will  make
> > > testsuite dependent on the latest clang version, which is not great. I
> > > can add a test with hand-crafted BTF instead. Which way is preferable?
> >
> > let's figure out if current state is accidental or by design.
> >
> > From practical standpoint, I'd still implement the code for FUNC_PROTO
> > and its args, but I wouldn't go all the way to hand-craft BTF
> > programmatically. As you said, btf_dump tests are way more ergonomic
> > because we rely on compiler to do the heavy lifting.
> >
> > As for the dependency on latest clang for some tests, I think that's
> > totally fine and unavoidable. Worst case some subtests will fail on
> > old kernels, they can be denylisted on systems with old compiler. All
> > that won't break the build (which is much worse and inconvenient).
> >
> > >
> > > BTF_KIND_FUNC is ignored by `btf_dump__dump_type_data`
> > > (via `btf_dump_unsupported_data`).
> > >
> > > BTF_KIND_VAR is dumped but current  testing infrastructure is not very
> > > convenient, it only checks for  some variables defined in vmlinux BTF.
> > > I can write a  test that accepts a custom built BTF  but this is still
> > > inferior   to  what   `test_btf_dump_case`  provides.   I've  extended
> > > `test_btf_dump_case` to print DATASEC  with subordinate vars alongside
> > > the type definitions instead.
> > >
> >
> > dumping DATASEC/VAR and FUNC is something that seems useful in
> > general, but we should treat it as a separate problem. Seeing DATASEC
> > variables and FUNCs in a familiar C syntax would be nice, but it
> > probably should be guarded behind a bpftool option or something.
> >
> > So in summary, let's figure out the situation with FUNC and FUNC_PROTO
> > first, and let's not due too laborious selftests yet
>
> Actually, to test the decl tag attachment for VAR I already implemented
> a change to the `test_btf_dump_case`. It can be separated as a different
> kind of tests but I don't see a point as it would be very similar to
> `test_btf_dump_case`.
>
> And manually creating BTF to attach decl tag to function proto parameter
> highlighted an issue that `btf_dump_assign_decl_tags` is only called once.
> So, the incremental scenario is not supported.
>
> I can post v2 with the change to `test_btf_dump_case`, support for
> decl tags on VARs and a fix for incremental dump behavior.

sounds good, just didn't want you to spend too much time on something
that shouldn't be needed once compiler gets fixed

>
> >
> > > ------
> > >
> > > $ cat test.c
> > > #define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
> > >
> > > int var __btf_decl_tag("var_tag");
> > >
> > > struct root {
> > >   int a;
> > >   int (*b)(int x __btf_decl_tag("arg_tag_proto")) __btf_decl_tag("field_tag");
> > > };
> > >
> > > int foo(struct root *x __btf_decl_tag("arg_tag_fn")) __btf_decl_tag("func_tag_fn") {
> > >   return 0;
> > > }
> > > $ clang -g -O2 -mcpu=v3 -target bpf -c test.c -o test.o
> > > $ bpftool btf dump file test.o
> > > [1] PTR '(anon)' type_id=2
> > > [2] STRUCT 'root' size=16 vlen=2
> > >         'a' type_id=3 bits_offset=0
> > >         'b' type_id=4 bits_offset=64
> > > [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > [4] PTR '(anon)' type_id=5
> > > [5] FUNC_PROTO '(anon)' ret_type_id=3 vlen=1
> > >         '(anon)' type_id=3
> > > [6] DECL_TAG 'field_tag' type_id=2 component_idx=1
> > > [7] FUNC_PROTO '(anon)' ret_type_id=3 vlen=1
> > >         'x' type_id=1
> > > [8] FUNC 'foo' type_id=7 linkage=global
> > > [9] DECL_TAG 'arg_tag_fn' type_id=8 component_idx=0
> > > [10] DECL_TAG 'func_tag_fn' type_id=8 component_idx=-1
> > > [11] VAR 'var' type_id=3, linkage=global
> > > [12] DECL_TAG 'var_tag' type_id=11 component_idx=-1
> > > [13] DATASEC '.bss' size=0 vlen=1
> > >         type_id=11 offset=0 size=4 (VAR 'var')
> > >
> > > > [...]
> > > >
> >
> > [...]
>
