Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C86A503C
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 01:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjB1Api (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 19:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1Aph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 19:45:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4564235
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 16:45:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy6so33328309edb.5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doSUGXBUdFo8BFnWr95Xsn+CnBFILEKwjB9DHedFt0E=;
        b=Y15vRbJrgfVyh/biMGA9CVjrlzLp563LNY33j6ghg89fII2k6proyxWQX/e6mQuvk9
         uNltm7I/z7IVvwK7UKPQwiiyuLN7sO2mxIAm81VuE3uLvHbVG78UYj9sjds8oaSPQhQf
         OErp/9qCGYNjw9ymrwCqDMLZL3r6y0ZgAU7t2RnrBM6qC33nH/bLRgAnN9YI/ANV4rOf
         KAUKmxuq5I3klEferPHJfkKyFy+CJCvJAHIs1t3UH2tdVXPpYWVr0bTD8mD4l/47ZyKK
         uf+wVq0KrH/ykRncErA2Ku3RnV/tvNeCeLTSnD63F/tJglAGK6LIBsc9FbT0PJPZN0uI
         JZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doSUGXBUdFo8BFnWr95Xsn+CnBFILEKwjB9DHedFt0E=;
        b=WgYZ9CWEUpTxEhDJ+MAiWtfxLPvsSG/KnzScad2n7QJ2qdIMnXivG2eHUCyRQRDBJO
         R694M6bxFI8YnBTwIkoFU4SHHxq8NTUs5OMDfmYG+pNGYdEssaRKtPsjmvV+BcxVWUfF
         0MDQLViDxhzonfSZKxagcK5217s4CeBsaXnldwKeZVVzJ81kEElVnGXhEg+t/FC5pOHJ
         TVkr4Nljuaw1yJz1fF50shv4eJd3+uPqurrxopqdkVJl1gyeP4jnrylRENZB1j/6Eu4T
         9MDiXxhmt+h3nBfr+tKYjlA1r3H9ht4cDJ7pfWuPGhvpv6kyC9bXH3xFj+jIyw2L7BrX
         7zjA==
X-Gm-Message-State: AO0yUKWjZPsxdhXah75V57y7G/c6Err9iVFcyYDj4dgOfPEpwdI+hG6k
        mqofwoinqj6EvC8RDJvCQnQPuYxqf/hrS6zggT7Gd1Mo
X-Google-Smtp-Source: AK7set/krm+EDEinsxb13BsdgXsIjUrLzSFEe4y8cpzZ9EIw83pQPzYYUUzk3CEo5gDkwyYU1jDbXaS1BHu8xvnKQ7s=
X-Received: by 2002:a17:906:c2d5:b0:8b1:79ef:6923 with SMTP id
 ch21-20020a170906c2d500b008b179ef6923mr264958ejb.15.1677545134680; Mon, 27
 Feb 2023 16:45:34 -0800 (PST)
MIME-Version: 1.0
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
 <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com> <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
 <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com> <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
 <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
 <CAEf4BzZUySu10OnsdoyTVXYS_2Ggn2i5KA177RA=v75oquq9TQ@mail.gmail.com> <199e5475333f49eeebfee6e34571638e4dd9d737.camel@gmail.com>
In-Reply-To: <199e5475333f49eeebfee6e34571638e4dd9d737.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 16:45:22 -0800
Message-ID: <CAEf4BzbGA=wSeoPpg+mKp-nh7qRPb6Bp+DfWgvSaWtPaWC7+nA@mail.gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 4:41=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-02-27 at 13:13 -0800, Andrii Nakryiko wrote:
> > On Wed, Feb 22, 2023 at 11:51 AM Eduard Zingerman <eddyz87@gmail.com> w=
rote:
> > >
> > > On Wed, 2023-02-22 at 10:11 -0800, Alexei Starovoitov wrote:
> > > [...]
> > > > > > > What do you think about something like "debug_type_tag" or
> > > > > > > "debug_type_annotation" (and a similar update for the decl ta=
gs)?
> > > > > > > The translation into BTF records would be the same, but the D=
WARF info
> > > > > > > would stand on its own without being tied to BTF.
> > > > > > >
> > > > > > > (Naming is a bit tricky since terms like 'tag' are already in=
 use by
> > > > > > > DWARF, e.g. "type tag" in the context of DWARF DIEs makes me =
think of
> > > > > > > DW_TAG_xxxx_type...)
> > > > > > >
> > > > > > > As far as I understand, early proposals for the tags were mor=
e generic
> > > > > > > but the LLVM reviewers wished for something more specific due=
 to the
> > > > > > > relatively limited use of the tags at the time. Now that the =
tags and
> > > > > > > their DWARF format have matured I think a good case can be ma=
de to
> > > > > > > make these generic. We'd be happy to help push for such chang=
e.
> > > > > >
> > > > > > On the other hand, BTF is a thing we are using this annotation =
for.
> > > > > > Any other tool can reuse DW_TAG_LLVM_annotation, but it will ne=
ed a
> > > > > > way to distinguish it's annotations from BTF annotations. And t=
his can
> > > > > > be done by using a different DW_AT_name. So, it seems logical t=
o
> > > > > > retain "btf" in the DW_AT_name. What do you think?
> > > > >
> > > > > OK I can understand keeping it BTF specific.
> > > > >
> > > > > Other than that, I don't come up with any significantly different=
 idea
> > > > > than to use the ":v2" suffix, so let's go with "btf_type_tag:v2"?
> > > >
> > > > I don't like v2 suffix either.
> > > > Please come up with something else.
> > >
> > > Nothing particularly good comes to mind:
> > > - btf_type_tag:wrapper
> > > - btf_type_tag:outer
> > > - btf_type_tag:own
> > > - exterior_btf_type_tag
> > > - outer_btf_tag
> > > - btf_type_prefix
> > > - btf_type_qualifier (as in const/volatile)
> > >
> > > Or might as well use btf_type_tag:gcc, as you suggested earlier,
> > > but it is as confusing as the others.
> >
> > btf.type_tag or btf:type_tag or btf/type_tag (you get the idea, it's
> > "BTF scoped")?
>
> `btf/type_tag` is nice but might be somewhat confusing when DWARF is insp=
ected:
> - both old-style and new-style tags would be present in DWARF for some
>   time for backwards compatibility;
> - old-style tag has name "btf_type_tag".

old-style tag will be deprecated and removed eventually, so I'd
optimize for the new-style naming, as that's what we'll be dealing
with the most going forward

>
> Thus, the following C code:
>
>   #define __tag1 __attribute__((btf_type_tag("tag1")))
>   #define __tag2 __attribute__((btf_type_tag("tag2")))
>
>   int __tag1 * __tag2 g;
>
> Would be encoded in DWARF as:
>
>   0x29:   DW_TAG_pointer_type
>             DW_AT_type      (0x35 "int")
>
>   0x2e:     DW_TAG_LLVM_annotation
>               DW_AT_name    ("btf/type_tag:")
>               DW_AT_const_value     ("tag2")
>
>   0x31:     DW_TAG_LLVM_annotation
>               DW_AT_name    ("btf_type_tag")
>               DW_AT_const_value     ("tag1")
>
>   0x34:     NULL
>
>   0x35:   DW_TAG_base_type
>             DW_AT_name      ("int")
>             DW_AT_encoding  (DW_ATE_signed)
>             DW_AT_byte_size (0x04)
>
>   0x39:     DW_TAG_LLVM_annotation
>               DW_AT_name    ("btf/type_tag:")
>               DW_AT_const_value     ("tag1")
>
>   0x3c:     NULL
>
> Which is not very helpful.
>
> In my opinion "btf_type_tag:v2" is the least confusing option, but if
> Alexei does not like it, let's use "btf_type_tag:parent" and move on.
>
> Thanks,
> Eduard
>
