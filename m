Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDEC628B96
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiKNVuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNVuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:50:54 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175C312D34
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:50:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f27so31712017eje.1
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi/+WhhMdzhAnOoPAur0yPUPudYFpfaYFXrNP1YptI4=;
        b=LrIaBFgfeYzGB4jrMnn5NRb6h8W3+kc0DhJXNxyCmn0KiglAnAqti/rSFekCzp+RlH
         eA7dMSbUXHX4SBb5/V3XD2LDZem7qnn2VFhWUXc4Letpo/hMhNBHY2rIDaRcoXjw5Ovc
         FAL/PWrleR3vpXFyMG1EF6n08ZzYOeZ7bW+kBCb8iJjM7eoX87dNtPwYeg5OxmiEfp2+
         fFpGa2ya4lNvAFmdYbkpsgxp6byY/Cphh/T7bsPZdV+3lNjXZuM+Ko4yu1U2Rm3W+Lx1
         mzR1aFDBo6hGxBWNF6NtyI7vGCNiuZ9BEarfxbrwO8KDBrCooDm1tzGmcjCwwz/w3EXX
         NOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fi/+WhhMdzhAnOoPAur0yPUPudYFpfaYFXrNP1YptI4=;
        b=tgIgreBklnUVtR5sKR0K2qdisieJZXjbOut6tx2aY5ovR09NH0v6Qq4qq0e7SisuSx
         iX40SqCrg98C/FHHhfgFFjAaqiaqEYfMsPg2ttrHduVm1fwmjmhf9+uFOaKi7EjNObjr
         cummdneLseEyG4F+Bwo6Xi5jAEFyrr3EbG7NFbPRDklgiW3ab8UOU1AqE548oaeFWLcK
         w7nJX9Bn6NIE5v7usPwTjWmYk1nLbylBVjlfkSxYw1cw1pO98g5I4sfyvzyJvSppMlCW
         OIOEqV+wPszaBGi01DHNqXUmidY0qG2X3clduryGa77kC6Bq9dgGgNvu/HPMo3QZlcE5
         W9eg==
X-Gm-Message-State: ANoB5pmhr/fRKgYusDMmPmkryCiORlQyh+ycNddR5iLxmANkrJc0ptIP
        HkHsxnHWwrbWw6hJ7abimdG4nbzsblzl8f6eSjQ=
X-Google-Smtp-Source: AA0mqf6oGEryk5LXl5eaYv9rojy9KmQjM2kN+Ukv4kFIHrJ2Rruz+dDsBCkm7Y9jZLrNgBMRlw6P+JoeGvyV9lFzXJg=
X-Received: by 2002:a17:906:9c93:b0:7ae:dc58:ffe7 with SMTP id
 fj19-20020a1709069c9300b007aedc58ffe7mr8493702ejc.58.1668462650444; Mon, 14
 Nov 2022 13:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com> <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
 <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com> <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
 <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com> <806f02669ee8930a2f5c5e3f2d5cb0b3166832bb.camel@gmail.com>
 <67c5d476-b8f4-9007-ca00-a8a9c111c826@meta.com> <e001c117fc2f7c202e34a68007abdd4f7744c0e1.camel@gmail.com>
In-Reply-To: <e001c117fc2f7c202e34a68007abdd4f7744c0e1.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Nov 2022 13:50:38 -0800
Message-ID: <CAADnVQLTetCdDetVGNBDddnfPEAhmhU+gXtWsZuVNeP0wbcOnA@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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

On Mon, Nov 14, 2022 at 1:13 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Sun, 2022-11-13 at 23:52 -0800, Yonghong Song wrote:
> >
> > On 11/11/22 1:55 PM, Eduard Zingerman wrote:
> > > On Fri, 2022-10-28 at 11:56 -0700, Yonghong Song wrote:
> > > > > > [...]
> > > > >
> > > > > Ok, could we change the problem to detecting if some type is defined.
> > > > > Would it be possible to have something like
> > > > >
> > > > > #if !__is_type_defined(struct abc)
> > > > > struct abc {
> > > > > };
> > > > > #endif
> > > > >
> > > > > I think we talked about this and there were problems with this
> > > > > approach, but I don't remember details and how insurmountable the
> > > > > problem is. Having a way to check whether some type is defined would
> > > > > be very useful even outside of -target bpf parlance, though, so maybe
> > > > > it's the problem worth attacking?
> > > >
> > > > Yes, we discussed this before. This will need to add additional work
> > > > in preprocessor. I just made a discussion topic in llvm discourse
> > > >
> > > > https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defined-type/66268
> > > >
> > > > Let us see whether we can get some upstream agreement or not.
> > >
> > > I did a small investigation of this feature.
> > >
> > > The main pre-requirement is construction of the symbol table during
> > > source code pre-processing, which implies necessity to parse the
> > > source code at the same time. It is technically possible in clang, as
> > > lexing, pre-processing and AST construction happens at the same time
> > > when in compilation mode.
> > >
> > > The prototype is available here [1], it includes:
> > > - Change in the pre-processor that adds an optional callback
> > >    "IsTypeDefinedFn" & necessary parsing of __is_type_defined
> > >    construct.
> > > - Change in Sema module (responsible for parsing/AST & symbol table)
> > >    that installs the appropriate "IsTypeDefinedFn" in the pre-processor
> > >    instance.
> > >
> > > However, this prototype builds a backward dependency between
> > > pre-processor and semantic analysis. There are currently no such
> > > dependencies in the clang code base.
> > >
> > > This makes it impossible to do pre-processing and compilation
> > > separately, e.g. consider the following example:
> > >
> > > $ cat test.c
> > >
> > >    struct foo { int x; };
> > >
> > >    #if __is_type_defined(foo)
> > >      const int x = 1;
> > >    #else
> > >      const int x = 2;
> > >    #endif
> > >
> > > $ clang -cc1 -ast-print test.c -o -
> > >
> > >    struct foo {
> > >        int x;
> > >    };
> > >    const int x = 1;
> > >
> > > $ clang -E test.c -o -
> > >
> > >    # ... some line directives ...
> > >    struct foo { int x; };
> > >    const int x = 2;
> >
> > Is it any chance '-E' could output the same one as '-cc1 -ast-print'?
> > That is, even with -E we could do some semantics analysis
> > as well, using either current clang semantics analysis or creating
> > an minimal version of sema analysis in preprocessor itself?
>
> Sema drives consumption of tokens from Preprocessor. Calls to
> Preprocessor are done on a parsing recursive descent. Extracting a
> stream of tokens would require an incremental parser instead.
>
> A minimal version of such parser is possible to implement for C.
> It might be the case that matching open / closing braces and
> identifiers following 'struct' / 'union' / 'enum' keywords might be
> almost sufficient but I need to try to be sure (e.g. it is more
> complex for 'typedef').
>
> I can work on it but I don't think there is a chance to upstream this work.

Right. It's going to be C only.
C++ with namespaces and nested class decls won't work with simple
type parser.

On the other side if we're asking preprocessor to look for
'struct foo' and remember that 'foo' is a type
maybe we can add a regex-search instead?
It would be a bit more generic and will work for basic
union/struct foo definition?
Something like instead of:
#if __is_type_defined(foo)
use:
#if regex(struct[\t]+foo)

enums are harder in this approach, but higher chance to land?

regex() would mean "search for this pattern in the file until this line.

Or some other preprocessor "language" tricks?

For example:
The preprocessor would grep for 'struct *' in a single line
while processing a file and emit #define __secret_prefix_##$1
where $1 would be a capture from "single line regex".
Then later in the same file instead of:
#if __is_type_defined(foo)
use:
#ifdef __secret_prefix_foo

This "single line regex" may look like:
#if regex_in_any_later_line(struct[\t]+[a-zA-Z_]+) define __secret_prefix_$2
