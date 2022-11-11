Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C806263F1
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 22:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiKKVzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 16:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKKVzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 16:55:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442B4AF13
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 13:55:45 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d6so10143291lfs.10
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 13:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WtM4SkC1oehiDgYng/anegIXe3P8ZHmh/FFCGmvMN1w=;
        b=Gbwj62oNvFIALeRy5Z5ZMQdd3pjM0SmOHsyO7NgwcuMnAZf6bXLc8YAYoAVI5twK5f
         ZvtyD2weMbddmEpt4NQQKdmY1ysy632DJaWGJDogXvWuWPXimjZoi5i4Oq+Ixk0YEwB7
         RRqJedo9mL0L5HpigX3Vz8TH4h35z+zykjJJ2JtoQDRlqmMkAuuJ6q3r5A2M9wfO9ibN
         1P6fu0jVSCZ0cYBClwpsbuLPedVjsxbMcRAuQ3XrgMsIK/vzQaPeqy+b+oplyc+vQw7W
         MQ/X5KFNy0Y4EH8pHsv9zpl+A1+KsLbgcRuLtqfAprseTGPK3vequLKZqiPPh9OFzFJ3
         wa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtM4SkC1oehiDgYng/anegIXe3P8ZHmh/FFCGmvMN1w=;
        b=fB//MPotass6+H3l2nR6viWxgiVpe6qdQv+rmsNLfxOov2CMBNbfMhW8FZUJCEWAF+
         VSZJ/YYmJFd8g+oyLjmC35jI6eAfG68B78Lp4QkPSasfu79EjIHSX6g86Svj/O1Pjtx4
         4fdYfifTZYhFKoHgz97OSE9H606YMuia4SjyIYQ+p3wVco0/+y7M59MIBYThkqsigHvw
         NBrhPCTFevZKdy8PiLiqsfRSiv7W9dPvTzvgc4kIAi1lRPON20tGjzFohaDoMlUnxP+4
         ag0GJDVLAP/eIILGNZ0bjLcZQgKYixAha939XzJUugJCSx0GMq66Tdmv7g1UcPW/0dan
         OlFg==
X-Gm-Message-State: ANoB5pktWDdgPe4N+dcstVKF5JYvhLj7Nwgd5I8teB5Y0ZwHIGrwWzNk
        YEkRVQ1lX+ygVU+X1ZLo+tw=
X-Google-Smtp-Source: AA0mqf7s7bRhSwDjQnc1aqSu2uHYTDQoBRU9tqAK0GkrCcYwCvphuPL3ufZTNzJXn+NIIVXlPvyfiw==
X-Received: by 2002:a05:6512:2803:b0:4a6:2ff6:f32f with SMTP id cf3-20020a056512280300b004a62ff6f32fmr1551835lfb.1.1668203743196;
        Fri, 11 Nov 2022 13:55:43 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512114500b004979db5aa5bsm522227lfg.223.2022.11.11.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:55:42 -0800 (PST)
Message-ID: <806f02669ee8930a2f5c5e3f2d5cb0b3166832bb.camel@gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Yonghong Song <yhs@meta.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
Date:   Fri, 11 Nov 2022 23:55:41 +0200
In-Reply-To: <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
         <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com>
         <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
         <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
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

On Fri, 2022-10-28 at 11:56 -0700, Yonghong Song wrote:
> > > [...]
> >=20
> > Ok, could we change the problem to detecting if some type is defined.
> > Would it be possible to have something like
> >=20
> > #if !__is_type_defined(struct abc)
> > struct abc {
> > };
> > #endif
> >=20
> > I think we talked about this and there were problems with this
> > approach, but I don't remember details and how insurmountable the
> > problem is. Having a way to check whether some type is defined would
> > be very useful even outside of -target bpf parlance, though, so maybe
> > it's the problem worth attacking?
>=20
> Yes, we discussed this before. This will need to add additional work
> in preprocessor. I just made a discussion topic in llvm discourse
>=20
> https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defined-ty=
pe/66268
>=20
> Let us see whether we can get some upstream agreement or not.

I did a small investigation of this feature.

The main pre-requirement is construction of the symbol table during
source code pre-processing, which implies necessity to parse the
source code at the same time. It is technically possible in clang, as
lexing, pre-processing and AST construction happens at the same time
when in compilation mode.

The prototype is available here [1], it includes:
- Change in the pre-processor that adds an optional callback
  "IsTypeDefinedFn" & necessary parsing of __is_type_defined
  construct.
- Change in Sema module (responsible for parsing/AST & symbol table)
  that installs the appropriate "IsTypeDefinedFn" in the pre-processor
  instance.

However, this prototype builds a backward dependency between
pre-processor and semantic analysis. There are currently no such
dependencies in the clang code base.

This makes it impossible to do pre-processing and compilation
separately, e.g. consider the following example:

$ cat test.c

  struct foo { int x; };
 =20
  #if __is_type_defined(foo)
    const int x =3D 1;
  #else
    const int x =3D 2;
  #endif
 =20
$ clang -cc1 -ast-print test.c -o -

  struct foo {
      int x;
  };
  const int x =3D 1;

$ clang -E test.c -o -

  # ... some line directives ...
  struct foo { int x; };
  const int x =3D 2;

Note that __is_type_defined is computed to different value in the
first and second calls. This is so because semantic analysis (AST,
symbol table) is not done for -E.

It also breaks that C11 standard which clearly separates
pre-processing and semantic analysis phases, see [2] 5.1.1.2.

So, my conclusion is as follows: this is technically possible in clang
but has no chance to reach llvm upstream.

Thanks,
Eduard

[1] https://github.com/llvm/llvm-project/compare/main...eddyz87:llvm-projec=
t:is-type-defined-experiment
[2] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf


>=20
> >=20
> > >=20
> > > >=20
> > > > BTW, I suggest splitting libbpf btf_dedup and btf_dump changes into=
 a
> > > > separate series and sending them as non-RFC sooner. Those improveme=
nts
> > > > are independent of all the header guards stuff, let's get them land=
ed
> > > > sooner.
> > > >=20
> > > > > After some discussion with Alexei and Yonghong I'd like to reques=
t
> > > > > your comments regarding a somewhat brittle and partial solution t=
o
> > > > > this issue that relies on adding `#ifndef FOO_H ... #endif` guard=
s in
> > > > > the generated `vmlinux.h`.
> > > > >=20
> > > >=20
> > > > [...]
> > > >=20
> > > > > Eduard Zingerman (12):
> > > > >     libbpf: Deduplicate unambigous standalone forward declaration=
s
> > > > >     selftests/bpf: Tests for standalone forward BTF declarations
> > > > >       deduplication
> > > > >     libbpf: Support for BTF_DECL_TAG dump in C format
> > > > >     selftests/bpf: Tests for BTF_DECL_TAG dump in C format
> > > > >     libbpf: Header guards for selected data structures in vmlinux=
.h
> > > > >     selftests/bpf: Tests for header guards printing in BTF dump
> > > > >     bpftool: Enable header guards generation
> > > > >     kbuild: Script to infer header guard values for uapi headers
> > > > >     kbuild: Header guards for types from include/uapi/*.h in kern=
el BTF
> > > > >     selftests/bpf: Script to verify uapi headers usage with vmlin=
ux.h
> > > > >     selftests/bpf: Known good uapi headers for test_uapi_headers.=
py
> > > > >     selftests/bpf: script for infer_header_guards.pl testing
> > > > >=20
> > > > >    scripts/infer_header_guards.pl                | 191 +++++
> > > > >    scripts/link-vmlinux.sh                       |  13 +-
> > > > >    tools/bpf/bpftool/btf.c                       |   4 +-
> > > > >    tools/lib/bpf/btf.c                           | 178 ++++-
> > > > >    tools/lib/bpf/btf.h                           |   7 +-
> > > > >    tools/lib/bpf/btf_dump.c                      | 232 +++++-
> > > > >    .../selftests/bpf/good_uapi_headers.txt       | 677 ++++++++++=
++++++++
> > > > >    tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
> > > > >    .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
> > > > >    .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
> > > > >    .../progs/btf_dump_test_case_header_guards.c  |  94 +++
> > > > >    .../bpf/test_uapi_header_guards_infer.sh      |  33 +
> > > > >    .../selftests/bpf/test_uapi_headers.py        | 197 +++++
> > > > >    13 files changed, 1816 insertions(+), 12 deletions(-)
> > > > >    create mode 100755 scripts/infer_header_guards.pl
> > > > >    create mode 100644 tools/testing/selftests/bpf/good_uapi_heade=
rs.txt
> > > > >    create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_=
test_case_decl_tag.c
> > > > >    create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_=
test_case_header_guards.c
> > > > >    create mode 100755 tools/testing/selftests/bpf/test_uapi_heade=
r_guards_infer.sh
> > > > >    create mode 100755 tools/testing/selftests/bpf/test_uapi_heade=
rs.py
> > > > >=20
> > > > > --
> > > > > 2.34.1
> > > > >=20

