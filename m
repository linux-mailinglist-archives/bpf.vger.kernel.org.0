Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADE162039A
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiKGXR1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiKGXR0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:17:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9826577
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:17:25 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v7so7800862wmn.0
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cuFzs9UQEOq8EQW+xLlP7cIGN0RBexlaYXkx//iOGa0=;
        b=PFOS7fxXu0ixGSFUY8fMxHAcTsHvaN141dRmfL3/wxh5CLftecLkBarD7q6BgqTQG+
         uVT+xQxwvDZOZXlorRXGsFS/pj7ljXj8cdqAvNbBEruStaHiRQpFNo8PR2Q/2LaU1+Yn
         j9vskyCngpsieQ7ymu5sPKAf2ODgmU9anrosnJWWCByqf3YgpTHPXZtZMnJ2fIqwD5WQ
         lP3yQfNzJAwrrORvRVoWHdU1mCd3qYo9MVLV1aTblSlE7iWYI0x+qqfPx8UQCA8xnVH7
         yIVkrUHPZSy7jMJ/YCmieOsP6zyh11ruBut5Jd9ZfxfU23ISMDOLCnqqOLhcffrtldqL
         j+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuFzs9UQEOq8EQW+xLlP7cIGN0RBexlaYXkx//iOGa0=;
        b=wOzRVImbMQhfP6BBBGMXt7RiOhlvHUFv4fr6q29KieeByZdBTXba6WnDdFso/aC7Z3
         ZTzDf0uET/zcogGAi1ZMfDu8a9zm4QE+GBlokz7cS59LMZ8lD2UlxWSmsOHfAYYSG7eS
         pcBxRFdzOiqko35dDskHbusrGpJxLak7NszeZrVgCXNsyHlfyI+T7XQCIbTqQeEp4Ww0
         aPhqdF3O8lyb1MWZEm7pp2Rh2cQ/DJo3/xxKCxr/AZ9Rx64i+VAvZlz7Z1tb7cnkPdr+
         VOiefh6fC248daUwMOnZ2oTUZb48vG4v6TgoNBKrgPH5pYoMvN1kH0TgzMWBpbd67blU
         Vwsg==
X-Gm-Message-State: ACrzQf3OUaBiH4myYo4GBWTc/4ZA/xZDxd8x4hpbMT7SfEbS3T0ln/TS
        CXCLAme1I6oQTndBrmqyVrU=
X-Google-Smtp-Source: AMsMyM5Tr+z8EnS1jOeZppC7AyhEhOmawSpYqz027ET/rhD1XujcSKb2v5vR6vyV7xXzsWEaPTzsmA==
X-Received: by 2002:a7b:c84c:0:b0:3cf:670e:6410 with SMTP id c12-20020a7bc84c000000b003cf670e6410mr32457016wml.21.1667863043652;
        Mon, 07 Nov 2022 15:17:23 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600003c900b0022e6178bd84sm8618372wrg.8.2022.11.07.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:17:23 -0800 (PST)
Message-ID: <726d3b01f69ddb158ff79e648f29bed5c9b27e0e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf:
 __attribute__((btf_decl_tag("..."))) for btf dump in C format
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
Date:   Tue, 08 Nov 2022 01:17:21 +0200
In-Reply-To: <CAEf4BzYzVLTojnbx-qK6BchBYj599yK7fohssfDX=nSbHUJRwA@mail.gmail.com>
References: <20221103134522.2764601-1-eddyz87@gmail.com>
         <CAEf4Bzb9dcBy5JEWzphkfr=wzvcT8gXcCjA5UYPPKAywh=k_Fg@mail.gmail.com>
         <e54ee0f0528ad7b9e59c39b3e7da1144ed45cbba.camel@gmail.com>
         <CAEf4BzYzVLTojnbx-qK6BchBYj599yK7fohssfDX=nSbHUJRwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-11-07 at 15:09 -0800, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 7:35 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > On Fri, 2022-11-04 at 13:54 -0700, Andrii Nakryiko wrote:
> > > On Thu, Nov 3, 2022 at 6:45 AM Eduard Zingerman <eddyz87@gmail.com> w=
rote:
> > > >=20
> > > > Clang's `__attribute__((btf_decl_tag("...")))` is represented in BT=
F
> > > > as a record of kind BTF_KIND_DECL_TAG with `type` field pointing to
> > > > the type annotated with this attribute. This commit adds
> > > > reconstitution of such attributes for BTF dump in C format.
> > > >=20
> > > > BTF doc says that BTF_KIND_DECL_TAGs should follow a target type bu=
t
> > > > this is not enforced and tests don't honor this restriction.
> > > > This commit uses hashmap to map types to the list of decl tags.
> > > > The hashmap is filled by `btf_dump_assign_decl_tags` function calle=
d
> > > > from `btf_dump__new`.
> > > >=20
> > > > It is assumed that total number of types annotated with decl tags i=
s
> > > > relatively small, thus some space is saved by using hashmap instead=
 of
> > > > adding a new field to `struct btf_dump_type_aux_state`.
> > > >=20
> > > > It is assumed that list of decl tags associated with a single type =
is
> > > > small. Thus the list is represented by an array which grows linearl=
y.
> > > >=20
> > > > To accommodate older Clang versions decl tags are dumped using the
> > > > following macro:
> > > >=20
> > > >  #if __has_attribute(btf_decl_tag)
> > > >  #  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
> > > >  #else
> > > >  #  define __btf_decl_tag(x)
> > > >  #endif
> > > >=20
> > > > The macro definition is emitted upon first call to `btf_dump__dump_=
type`.
> > > >=20
> > > > Clang allows to attach btf_decl_tag attributes to the following kin=
ds
> > > > of items:
> > > > - struct/union         supported
> > > > - struct/union field   supported
> > > > - typedef              supported
> > > > - function             not applicable
> > > > - function parameter   not applicable
> > > > - variable             not applicable
> > > >=20
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/btf_dump.c | 163 +++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 160 insertions(+), 3 deletions(-)
> > > >=20
> > >=20
> > > Functions and their args can also have tags. This works:
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_dec=
l_tag.c
> > > b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > > index 7a5af8b86065..75fcabe700cd 100644
> > > --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > > +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> > > @@ -54,7 +54,7 @@ struct root_struct {
> > >=20
> > >  /* ------ END-EXPECTED-OUTPUT ------ */
> > >=20
> > > -int f(struct root_struct *s)
> > > +int f(struct root_struct *s __btf_decl_tag("func_arg_tag"))
> > > __btf_decl_tag("func_tag")
> > >  {
> > >         return 0;
> > >  }
> > >=20
> > > And I see correct BTF:
> > >=20
> > > [26] FUNC 'f' type_id=3D25 linkage=3Dglobal
> > > [27] DECL_TAG 'func_arg_tag' type_id=3D26 component_idx=3D0
> > > [28] DECL_TAG 'func_tag' type_id=3D26 component_idx=3D-1
> > >=20
> > > So let's add support and test for that case as well. btf_dump
> > > shouldn't assume vmlinux.h-only case.
> > >=20
> > > Also, please check if DATASEC and VARs can have decl_tags associated =
with them.
> >=20
> > I see that right now decl tags are saved for:
> > - BTF_KIND_VAR
> > - BTF_KIND_FUNC
> > - BTF_KIND_FUNC arguments
> >=20
> > Decl tags are lost but legal for:
> > - BTF_KIND_FUNC_PROTO arguments
>=20
> ah, that's unfortunate and even DECL_TAGS example I showed above seems
> like a bug. FUNC itself doesn't have args, I implicitly assumed that
> all DECL_TAG will be actually associated with underlying FUNC_PROTO.
>=20
> Yonghong, is this by design or a bug?
>=20
> >=20
> > I have not found a way to attach decl tag to DATASEC.
> >=20
> > For BTF_KIND_FUNC_PROTO  arguments it would  be great to  update clang
> > first. Then  it would be  possible to keep all  decl tags checks  as a
> > single  `btf_dump_test_case`.  On  the   other  hand  this  will  make
> > testsuite dependent on the latest clang version, which is not great. I
> > can add a test with hand-crafted BTF instead. Which way is preferable?
>=20
> let's figure out if current state is accidental or by design.
>=20
> From practical standpoint, I'd still implement the code for FUNC_PROTO
> and its args, but I wouldn't go all the way to hand-craft BTF
> programmatically. As you said, btf_dump tests are way more ergonomic
> because we rely on compiler to do the heavy lifting.
>=20
> As for the dependency on latest clang for some tests, I think that's
> totally fine and unavoidable. Worst case some subtests will fail on
> old kernels, they can be denylisted on systems with old compiler. All
> that won't break the build (which is much worse and inconvenient).
>=20
> >=20
> > BTF_KIND_FUNC is ignored by `btf_dump__dump_type_data`
> > (via `btf_dump_unsupported_data`).
> >=20
> > BTF_KIND_VAR is dumped but current  testing infrastructure is not very
> > convenient, it only checks for  some variables defined in vmlinux BTF.
> > I can write a  test that accepts a custom built BTF  but this is still
> > inferior   to  what   `test_btf_dump_case`  provides.   I've  extended
> > `test_btf_dump_case` to print DATASEC  with subordinate vars alongside
> > the type definitions instead.
> >=20
>=20
> dumping DATASEC/VAR and FUNC is something that seems useful in
> general, but we should treat it as a separate problem. Seeing DATASEC
> variables and FUNCs in a familiar C syntax would be nice, but it
> probably should be guarded behind a bpftool option or something.
>=20
> So in summary, let's figure out the situation with FUNC and FUNC_PROTO
> first, and let's not due too laborious selftests yet

Actually, to test the decl tag attachment for VAR I already implemented
a change to the `test_btf_dump_case`. It can be separated as a different
kind of tests but I don't see a point as it would be very similar to
`test_btf_dump_case`.

And manually creating BTF to attach decl tag to function proto parameter
highlighted an issue that `btf_dump_assign_decl_tags` is only called once.
So, the incremental scenario is not supported.

I can post v2 with the change to `test_btf_dump_case`, support for
decl tags on VARs and a fix for incremental dump behavior.

>=20
> > ------
> >=20
> > $ cat test.c
> > #define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
> >=20
> > int var __btf_decl_tag("var_tag");
> >=20
> > struct root {
> >   int a;
> >   int (*b)(int x __btf_decl_tag("arg_tag_proto")) __btf_decl_tag("field=
_tag");
> > };
> >=20
> > int foo(struct root *x __btf_decl_tag("arg_tag_fn")) __btf_decl_tag("fu=
nc_tag_fn") {
> >   return 0;
> > }
> > $ clang -g -O2 -mcpu=3Dv3 -target bpf -c test.c -o test.o
> > $ bpftool btf dump file test.o
> > [1] PTR '(anon)' type_id=3D2
> > [2] STRUCT 'root' size=3D16 vlen=3D2
> >         'a' type_id=3D3 bits_offset=3D0
> >         'b' type_id=3D4 bits_offset=3D64
> > [3] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> > [4] PTR '(anon)' type_id=3D5
> > [5] FUNC_PROTO '(anon)' ret_type_id=3D3 vlen=3D1
> >         '(anon)' type_id=3D3
> > [6] DECL_TAG 'field_tag' type_id=3D2 component_idx=3D1
> > [7] FUNC_PROTO '(anon)' ret_type_id=3D3 vlen=3D1
> >         'x' type_id=3D1
> > [8] FUNC 'foo' type_id=3D7 linkage=3Dglobal
> > [9] DECL_TAG 'arg_tag_fn' type_id=3D8 component_idx=3D0
> > [10] DECL_TAG 'func_tag_fn' type_id=3D8 component_idx=3D-1
> > [11] VAR 'var' type_id=3D3, linkage=3Dglobal
> > [12] DECL_TAG 'var_tag' type_id=3D11 component_idx=3D-1
> > [13] DATASEC '.bss' size=3D0 vlen=3D1
> >         type_id=3D11 offset=3D0 size=3D4 (VAR 'var')
> >=20
> > > [...]
> > >=20
>=20
> [...]

