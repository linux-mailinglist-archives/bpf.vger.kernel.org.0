Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5700D6A5050
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 01:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjB1A5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 19:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1A5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 19:57:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD312940A
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 16:57:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j3so5385223wms.2
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677545832;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+mIWsm0JyMMONBfbjFgw8yyn88yaGUWenvy/jY16lU=;
        b=Mgm7mdYy9j+/I7l0dbCn8gQihUI7txE6T/uwxbT1+KGPL7dohFLNTjpYMk3A2g5xiy
         RUF/Whzodj9oWz0ptTOtYTBEVoXHj1Chewe46rbpO4LVVasT+pMZGcUvgdHXAuh3xIm3
         wXTxSE9wDdcodnkPZagm02ktqQs3Jj2PcUwx5esu1StyAkk/fCdas7HuAhQ/NupHMp8r
         NUAnXVuPd8YEFQmhXnz6CzGSLeBVkvw/2JaVvZveL8RzEC5xp5Q/8iBOxFyKAr1QL2zm
         MES7WEDpPFUzxJvRE+uUXXs8ja5jsVC5OXseskNa0Xi+V7PQ5UXRxZeF/ABk7dyC5KO8
         Lc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677545832;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+mIWsm0JyMMONBfbjFgw8yyn88yaGUWenvy/jY16lU=;
        b=HMAIPsIio3vHNasriEfEdMGJMC0Q+mncogbV2gOkx+33pj9312eYo+khuwzmz91jN6
         mB6Af+k/3ak/VQIRxYSvEXER4HeOEdBxqpmc/njLLXwBD7sz6jiCz2OzY1f+NlfaUeZ9
         2IxNdFFY0i2GcLAEN4nevO3J4kGtEDUB+/+mBU2MIvov0Wgks94vj9cgdUrCRImcTEFt
         rUwaytv5dy8S3pGLsNzoZce5PHl/gNVmUytsXhaVFBec+YFm3k56KDg9HbBwM3svoUGz
         qnIOLEb1nTQ8BZ+QefO4G1GDjWuSFBZN3SR7npy1KSsWrJY5bBcR1LLyoIG7Jh9XgaBT
         N1/Q==
X-Gm-Message-State: AO0yUKXCOrxIZ24XFSkNkJPjkmC0NlAmhqmMQxvu8Sl8CmVKospfrvad
        Ej+CKDJ7GXU3GAPYOp0l6HQ=
X-Google-Smtp-Source: AK7set92ZySRbuX/s7T3XYrg2gNpMhfs/7ZvtDqy+yl7QWDMX/oczGCfdNxO6HjuMOvfK+gnZeO/Yg==
X-Received: by 2002:a05:600c:4687:b0:3ea:f73e:9d8a with SMTP id p7-20020a05600c468700b003eaf73e9d8amr688230wmo.30.1677545832240;
        Mon, 27 Feb 2023 16:57:12 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b003eb192787bfsm11029179wmq.25.2023.02.27.16.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 16:57:11 -0800 (PST)
Message-ID: <a6e526ec1408ec4c833b19f8d482ace57dc30c11.camel@gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Date:   Tue, 28 Feb 2023 02:57:10 +0200
In-Reply-To: <CAEf4BzbGA=wSeoPpg+mKp-nh7qRPb6Bp+DfWgvSaWtPaWC7+nA@mail.gmail.com>
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
         <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
         <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com>
         <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
         <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com>
         <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
         <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
         <CAEf4BzZUySu10OnsdoyTVXYS_2Ggn2i5KA177RA=v75oquq9TQ@mail.gmail.com>
         <199e5475333f49eeebfee6e34571638e4dd9d737.camel@gmail.com>
         <CAEf4BzbGA=wSeoPpg+mKp-nh7qRPb6Bp+DfWgvSaWtPaWC7+nA@mail.gmail.com>
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

On Mon, 2023-02-27 at 16:45 -0800, Andrii Nakryiko wrote:
> On Mon, Feb 27, 2023 at 4:41=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2023-02-27 at 13:13 -0800, Andrii Nakryiko wrote:
> > > On Wed, Feb 22, 2023 at 11:51 AM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
> > > >=20
> > > > On Wed, 2023-02-22 at 10:11 -0800, Alexei Starovoitov wrote:
> > > > [...]
> > > > > > > > What do you think about something like "debug_type_tag" or
> > > > > > > > "debug_type_annotation" (and a similar update for the decl =
tags)?
> > > > > > > > The translation into BTF records would be the same, but the=
 DWARF info
> > > > > > > > would stand on its own without being tied to BTF.
> > > > > > > >=20
> > > > > > > > (Naming is a bit tricky since terms like 'tag' are already =
in use by
> > > > > > > > DWARF, e.g. "type tag" in the context of DWARF DIEs makes m=
e think of
> > > > > > > > DW_TAG_xxxx_type...)
> > > > > > > >=20
> > > > > > > > As far as I understand, early proposals for the tags were m=
ore generic
> > > > > > > > but the LLVM reviewers wished for something more specific d=
ue to the
> > > > > > > > relatively limited use of the tags at the time. Now that th=
e tags and
> > > > > > > > their DWARF format have matured I think a good case can be =
made to
> > > > > > > > make these generic. We'd be happy to help push for such cha=
nge.
> > > > > > >=20
> > > > > > > On the other hand, BTF is a thing we are using this annotatio=
n for.
> > > > > > > Any other tool can reuse DW_TAG_LLVM_annotation, but it will =
need a
> > > > > > > way to distinguish it's annotations from BTF annotations. And=
 this can
> > > > > > > be done by using a different DW_AT_name. So, it seems logical=
 to
> > > > > > > retain "btf" in the DW_AT_name. What do you think?
> > > > > >=20
> > > > > > OK I can understand keeping it BTF specific.
> > > > > >=20
> > > > > > Other than that, I don't come up with any significantly differe=
nt idea
> > > > > > than to use the ":v2" suffix, so let's go with "btf_type_tag:v2=
"?
> > > > >=20
> > > > > I don't like v2 suffix either.
> > > > > Please come up with something else.
> > > >=20
> > > > Nothing particularly good comes to mind:
> > > > - btf_type_tag:wrapper
> > > > - btf_type_tag:outer
> > > > - btf_type_tag:own
> > > > - exterior_btf_type_tag
> > > > - outer_btf_tag
> > > > - btf_type_prefix
> > > > - btf_type_qualifier (as in const/volatile)
> > > >=20
> > > > Or might as well use btf_type_tag:gcc, as you suggested earlier,
> > > > but it is as confusing as the others.
> > >=20
> > > btf.type_tag or btf:type_tag or btf/type_tag (you get the idea, it's
> > > "BTF scoped")?
> >=20
> > `btf/type_tag` is nice but might be somewhat confusing when DWARF is in=
spected:
> > - both old-style and new-style tags would be present in DWARF for some
> >   time for backwards compatibility;
> > - old-style tag has name "btf_type_tag".
>=20
> old-style tag will be deprecated and removed eventually, so I'd
> optimize for the new-style naming, as that's what we'll be dealing
> with the most going forward

I still think that presence of a literal string "bty_type_tag" might
make some grepping easier but whatever. If there are no further
objections I'll post the changes using "btf:type_tag" literal tomorrow.
Andrii, thanks for the input.

Thanks,
Eduard

>=20
> >=20
> > Thus, the following C code:
> >=20
> >   #define __tag1 __attribute__((btf_type_tag("tag1")))
> >   #define __tag2 __attribute__((btf_type_tag("tag2")))
> >=20
> >   int __tag1 * __tag2 g;
> >=20
> > Would be encoded in DWARF as:
> >=20
> >   0x29:   DW_TAG_pointer_type
> >             DW_AT_type      (0x35 "int")
> >=20
> >   0x2e:     DW_TAG_LLVM_annotation
> >               DW_AT_name    ("btf/type_tag:")
> >               DW_AT_const_value     ("tag2")
> >=20
> >   0x31:     DW_TAG_LLVM_annotation
> >               DW_AT_name    ("btf_type_tag")
> >               DW_AT_const_value     ("tag1")
> >=20
> >   0x34:     NULL
> >=20
> >   0x35:   DW_TAG_base_type
> >             DW_AT_name      ("int")
> >             DW_AT_encoding  (DW_ATE_signed)
> >             DW_AT_byte_size (0x04)
> >=20
> >   0x39:     DW_TAG_LLVM_annotation
> >               DW_AT_name    ("btf/type_tag:")
> >               DW_AT_const_value     ("tag1")
> >=20
> >   0x3c:     NULL
> >=20
> > Which is not very helpful.
> >=20
> > In my opinion "btf_type_tag:v2" is the least confusing option, but if
> > Alexei does not like it, let's use "btf_type_tag:parent" and move on.
> >=20
> > Thanks,
> > Eduard
> >=20

