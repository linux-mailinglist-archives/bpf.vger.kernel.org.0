Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD36A532A
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 07:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjB1Gxc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 01:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB1Gxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 01:53:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875721258C
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 22:53:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so35636708edb.9
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 22:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbiUkVDV+/p0aCue4XhYbrctaVNewyx+qjv/k7Iwzss=;
        b=YTAFU3t6zHzPr/vjhB6T/y6aAtkMX7B3BfVNmVer2SDam3geWOXIwLqA++tSUgLwOy
         rtXi+05RWU4ob5meEnMrGt3/t2hXkkYH+9G430iDagxBq+fQ8DMUKKWy6hjCcWnfcpYJ
         5mBbDXMy7mgBPXzjJGHpaiXXTG0fP6/IgMsXmxeF2ChH07sIqCMExpM08OJcztTkm1q1
         anMezr9kvWp1ndRX9KcsIEOXEHb9iGVS9U89/Ixt+WEmWupLDax+gWIsUY+zMldyL20n
         T/NWJ5y/MCaoA/dZJWCCoq9rQ03SiLsracCCPzT9DDh1kaudrUWFwebVih5m/ZD4h64T
         TYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbiUkVDV+/p0aCue4XhYbrctaVNewyx+qjv/k7Iwzss=;
        b=Fgk3o2ZApeuWknwPVeLAS/Wd8dI4bwy0hVZytBuJkCVaIBqRemMAKHOh/obWh9Dk1k
         0KJRX/Jrxf6Gh74nQ82jBLgywoqb85tTY3uGZwyKiObXnANbmyda0hWs/SBrt24icEx5
         9xz8QxzhSM0UfYQQzaa+Qfwo+ZUWb6YGHkNzgSVSpnt8254QvG0we7THnxmLx3Hkw2Zx
         YlEAq+fseRBW5WnXxmwJT4X8aqoPn0rLirESlgt8zbVGnLlfV3D1+hBTIHu6IiUI8+dA
         pcgA4T3BtzlsNQZcsFt427pPNaVhflCp9AHvrkL82z248Hfrb2NYhgpAFtIZzc71XBqG
         RO9w==
X-Gm-Message-State: AO0yUKVqQOOyl8URGMbXbblStQOXjwHrbkJ8pSSzzZgZaX88b32IPq7G
        6OrdsJJVRkwD/preOy9vFq+LvI6k/63XDnErREk=
X-Google-Smtp-Source: AK7set8VCjoxpZH+eI5ZOnjAEKKjcRURUkXaN2wxvw5epw4rrn/yq8Ju1fte07nXuM85jBNWtpWJxo0y11IbAtfadd0=
X-Received: by 2002:a50:c007:0:b0:4ab:4933:225b with SMTP id
 r7-20020a50c007000000b004ab4933225bmr1141894edb.6.1677567208866; Mon, 27 Feb
 2023 22:53:28 -0800 (PST)
MIME-Version: 1.0
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
 <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com> <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
 <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com> <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
 <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
 <CAEf4BzZUySu10OnsdoyTVXYS_2Ggn2i5KA177RA=v75oquq9TQ@mail.gmail.com>
 <199e5475333f49eeebfee6e34571638e4dd9d737.camel@gmail.com>
 <CAEf4BzbGA=wSeoPpg+mKp-nh7qRPb6Bp+DfWgvSaWtPaWC7+nA@mail.gmail.com>
 <a6e526ec1408ec4c833b19f8d482ace57dc30c11.camel@gmail.com>
 <CAADnVQLrvEzabkJjerAwdOgbnA=ERYinYqboN2--jqaeDm4Ygg@mail.gmail.com> <CAEf4Bza-GGjpDbUHtoVto+P9hWi7TFf1-SPqdLm4SiBSXFbONw@mail.gmail.com>
In-Reply-To: <CAEf4Bza-GGjpDbUHtoVto+P9hWi7TFf1-SPqdLm4SiBSXFbONw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 27 Feb 2023 22:53:17 -0800
Message-ID: <CAADnVQKMMUBscHeiOpSoE2a2hzK3ywaTRRmHcNaym75jj=K0LQ@mail.gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
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

On Mon, Feb 27, 2023 at 9:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 27, 2023 at 6:44=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 27, 2023 at 4:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > I still think that presence of a literal string "bty_type_tag" might
> > > make some grepping easier but whatever. If there are no further
> > > objections I'll post the changes using "btf:type_tag" literal tomorro=
w.
> > > Andrii, thanks for the input.
> >
> > I don't think there is precedent for using ':' inside DW_AT_name.
>
> I don't think there are any restrictions on string pointed to be
> DW_AT_name. It is used when describing source code location (so
> definitely has '/' on Linux, and ":/" on Windows). But I just checked
> Rust-emitted DWARF:
>
> 0x0002825e:   DW_TAG_pointer_type
>                 DW_AT_type      (0x00026fc9
> "core::option::Option<alloc::string::String>")
>                 DW_AT_name      ("*const
> core::option::Option<alloc::string::String>")
>                 DW_AT_address_class     (0x00000000)
>
> So I'm not too bothered about this. After all, it's just a string.
>
> But `btf:<something>` allows us to generalize this to other
> annotations, e.g., we can have "msan:initialized" or something, and it
> will be done in C using some generic __attribute__((annotate("msan",
> "initialized"))).
>
> > Can we actually use the same "btf_type_tag" name?
> > Aren't we gonna use a different container than DW_TAG_LLVM_annotation ?
>
> I think that was the point to reuse existing DW_TAG_LLVM_annotation
> (and I assume from GCC's side it would be called
> DW_TAG_GNU_annotation, but it will use the same ID, so effectively we
> might as well call it just DW_TAG_annotation), so using "btf_type_tag"
> becomes ambiguous.

I see. Then 'btf:type_tag' makes the most sense.
