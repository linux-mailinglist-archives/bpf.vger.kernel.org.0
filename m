Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7842662B0F7
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 03:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKPCBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 21:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiKPCB3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 21:01:29 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7F2B271
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:01:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso461722wms.4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Ola4EvlKxLZ7g39o8M7jNYbK0zAOf9c0zCiY7WJnUc=;
        b=F0Jfkg641ERpOW6ObWa/esGOHXmGvm8F2rC38CgilA7P7Hv6tMxctEVYMxjIk8pyoc
         j6jpQhXAlkNRoAup6sAzGeh24/+JJqg1U5ncgtwXV507KzjEvajn506mlo16aScCuQY8
         dkcaECYK2z8SvxHFgux3sMCOlsBCc49ytMjshVNwRNghDo16SBap/sYR8LruSduL7Srj
         bxzLR71mcQPGBVD5+9f3MvEa37mMhllodZBqWqjQu+nonX51W20/VyT4U8AA1BGiBCEv
         fbcdqr3mcF0s8PhRV+u4n3nFIloEcjts1Uwrskr+TAO6OQFQDLzntxg1wsC11jo4HmKA
         RsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Ola4EvlKxLZ7g39o8M7jNYbK0zAOf9c0zCiY7WJnUc=;
        b=Clqb0td1cBwau2U6WXg+cUhRPn2UaOwLWH/uoANBJ9DnvwGVMtScS81wzbBCA/dGmL
         Ys2sCj2l43LyWs9GV2XwsRCNm5+EXbE74GWW4gGE6N0unCKici8BRfvFhu6evWLKdQdC
         1tzmDn8/RSIx5y7XkVmXO/B+z2275C7r6+F0BeM6s4RHJjzjxntH2RSTOGzEEKR5aUHI
         n6LgBDR7YIc2Z7QEDwLRHFaJ0LleNUq/74wHzixddHhGiuxAOMA2PNZl3Ub3RFhiI8Q8
         UpJeUK5KXkJWmoqFK2DL3kh5+7UVh7/ZtP58cJ00xxpkWJFv7hS0cbYT6cMBCSS6inYy
         Gzxg==
X-Gm-Message-State: ANoB5pka5CIe/7WmR84LT245FcaEeLkP0QqdjIoDxFHinGDxZdiy//xR
        rh9vfphjHqeUpzIPuKsQBRrmQdO5yztc5P2D
X-Google-Smtp-Source: AA0mqf5O7EsmOw3Tc4Xd5MySayTG82TI8byBQ6BmUIdLoFxnJP4vVceamcCakafr+Po8X5/m31ni2g==
X-Received: by 2002:a05:600c:a10:b0:3cf:75f4:794a with SMTP id z16-20020a05600c0a1000b003cf75f4794amr592828wmp.16.1668564085906;
        Tue, 15 Nov 2022 18:01:25 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003b47b80cec3sm411580wms.42.2022.11.15.18.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:01:23 -0800 (PST)
Message-ID: <b91d6e23211e2ababfd284fdadd13c771203e525.camel@gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Date:   Wed, 16 Nov 2022 04:01:21 +0200
In-Reply-To: <CAADnVQLTetCdDetVGNBDddnfPEAhmhU+gXtWsZuVNeP0wbcOnA@mail.gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
         <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com>
         <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
         <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
         <806f02669ee8930a2f5c5e3f2d5cb0b3166832bb.camel@gmail.com>
         <67c5d476-b8f4-9007-ca00-a8a9c111c826@meta.com>
         <e001c117fc2f7c202e34a68007abdd4f7744c0e1.camel@gmail.com>
         <CAADnVQLTetCdDetVGNBDddnfPEAhmhU+gXtWsZuVNeP0wbcOnA@mail.gmail.com>
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

On Mon, 2022-11-14 at 13:50 -0800, Alexei Starovoitov wrote:
> On Mon, Nov 14, 2022 at 1:13 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > On Sun, 2022-11-13 at 23:52 -0800, Yonghong Song wrote:
> > >=20
> > > On 11/11/22 1:55 PM, Eduard Zingerman wrote:
> > > > On Fri, 2022-10-28 at 11:56 -0700, Yonghong Song wrote:
> > > > > > > [...]
> > > > > >=20
> > > > > > Ok, could we change the problem to detecting if some type is de=
fined.
> > > > > > Would it be possible to have something like
> > > > > >=20
> > > > > > #if !__is_type_defined(struct abc)
> > > > > > struct abc {
> > > > > > };
> > > > > > #endif
> > > > > >=20
> > > > > > I think we talked about this and there were problems with this
> > > > > > approach, but I don't remember details and how insurmountable t=
he
> > > > > > problem is. Having a way to check whether some type is defined =
would
> > > > > > be very useful even outside of -target bpf parlance, though, so=
 maybe
> > > > > > it's the problem worth attacking?
> > > > >=20
> > > > > Yes, we discussed this before. This will need to add additional w=
ork
> > > > > in preprocessor. I just made a discussion topic in llvm discourse
> > > > >=20
> > > > > https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-de=
fined-type/66268
> > > > >=20
> > > > > Let us see whether we can get some upstream agreement or not.
> > > >=20
> > > > I did a small investigation of this feature.
> > > >=20
> > > > The main pre-requirement is construction of the symbol table during
> > > > source code pre-processing, which implies necessity to parse the
> > > > source code at the same time. It is technically possible in clang, =
as
> > > > lexing, pre-processing and AST construction happens at the same tim=
e
> > > > when in compilation mode.
> > > >=20
> > > > The prototype is available here [1], it includes:
> > > > - Change in the pre-processor that adds an optional callback
> > > >    "IsTypeDefinedFn" & necessary parsing of __is_type_defined
> > > >    construct.
> > > > - Change in Sema module (responsible for parsing/AST & symbol table=
)
> > > >    that installs the appropriate "IsTypeDefinedFn" in the pre-proce=
ssor
> > > >    instance.
> > > >=20
> > > > However, this prototype builds a backward dependency between
> > > > pre-processor and semantic analysis. There are currently no such
> > > > dependencies in the clang code base.
> > > >=20
> > > > This makes it impossible to do pre-processing and compilation
> > > > separately, e.g. consider the following example:
> > > >=20
> > > > $ cat test.c
> > > >=20
> > > >    struct foo { int x; };
> > > >=20
> > > >    #if __is_type_defined(foo)
> > > >      const int x =3D 1;
> > > >    #else
> > > >      const int x =3D 2;
> > > >    #endif
> > > >=20
> > > > $ clang -cc1 -ast-print test.c -o -
> > > >=20
> > > >    struct foo {
> > > >        int x;
> > > >    };
> > > >    const int x =3D 1;
> > > >=20
> > > > $ clang -E test.c -o -
> > > >=20
> > > >    # ... some line directives ...
> > > >    struct foo { int x; };
> > > >    const int x =3D 2;
> > >=20
> > > Is it any chance '-E' could output the same one as '-cc1 -ast-print'?
> > > That is, even with -E we could do some semantics analysis
> > > as well, using either current clang semantics analysis or creating
> > > an minimal version of sema analysis in preprocessor itself?
> >=20
> > Sema drives consumption of tokens from Preprocessor. Calls to
> > Preprocessor are done on a parsing recursive descent. Extracting a
> > stream of tokens would require an incremental parser instead.
> >=20
> > A minimal version of such parser is possible to implement for C.
> > It might be the case that matching open / closing braces and
> > identifiers following 'struct' / 'union' / 'enum' keywords might be
> > almost sufficient but I need to try to be sure (e.g. it is more
> > complex for 'typedef').
> >=20
> > I can work on it but I don't think there is a chance to upstream this w=
ork.
>=20
> Right. It's going to be C only.
> C++ with namespaces and nested class decls won't work with simple
> type parser.
>=20
> On the other side if we're asking preprocessor to look for
> 'struct foo' and remember that 'foo' is a type
> maybe we can add a regex-search instead?
> It would be a bit more generic and will work for basic
> union/struct foo definition?
> Something like instead of:
> #if __is_type_defined(foo)
> use:
> #if regex(struct[\t]+foo)
>=20
> enums are harder in this approach, but higher chance to land?
>=20
> regex() would mean "search for this pattern in the file until this line.
>=20
> Or some other preprocessor "language" tricks?
>=20

I talked to Yonhong today and he suggests to investigate whether pre-proces=
sor
changes could be made BPF target specific. E.g. there are extension points
in the clang pre-processor right now but those for tooling. There might be
a way to extend this mechanism to allow target specific pre-processor behav=
ior.
I'll take a look and write another email here.

> For example:
> The preprocessor would grep for 'struct *' in a single line
> while processing a file and emit #define __secret_prefix_##$1
> where $1 would be a capture from "single line regex".
> Then later in the same file instead of:
> #if __is_type_defined(foo)
> use:
> #ifdef __secret_prefix_foo
>=20
> This "single line regex" may look like:
> #if regex_in_any_later_line(struct[\t]+[a-zA-Z_]+) define __secret_prefix=
_$2

