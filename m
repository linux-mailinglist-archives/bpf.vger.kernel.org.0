Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B356A5037
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 01:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjB1Alt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 19:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB1Als (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 19:41:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A21C7F0
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 16:41:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h14so8061258wru.4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 16:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677544906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zVB1JUCUSoVKO5jMdY/CNGs8QiqUID/qLhe6HPqwQ20=;
        b=Bf3zFM2iiLXXVA2pjiyF8Ze9wg+ykIX9VpDlU3Px9FBmeRR6oUI4lF3G3cRGqMHdtm
         8sJn64Yx/F1Tw8HMp7fa7vHX5s9GzZUa+Swm81txLHegc4VDrI5vkm03ZISM5RQuulw5
         7t4DkEZwtU6hSRrLxrbvPOFUy+M66NMCWkuy1WDv5NMrqqD1Nnw2zs0JbGMjspoJQFwa
         EiiivYkVuJOk4y44VEi7lqAj7L+QJmzuPy0JCN+HqofnGLtAph2cPFPx3UUc2fFEeVjJ
         A9h3RymOgCRByiAnebad2hsgm5izPfwwF76JuY5SmMScD3Pdeyw2bojH+LJddgZrqiLH
         uioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677544906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVB1JUCUSoVKO5jMdY/CNGs8QiqUID/qLhe6HPqwQ20=;
        b=ti0MTHmSwnnns2LzEoNyBI2IVwWwtnBOMRR6qeGmCs3+lpaz6eBwQ+KpHLTn0O9G+Z
         /vXPtsqsMCoAp22uVx4qtoragvoVyynfiwS8UpC+npNTZIlCH5YYVGwH9qtXUVFbMmZH
         slHOB8DiyRhbFmzjmv+SO5baQcNt8v5U8FVICSxSIVciL5A+92wYy/P/7fKoltpPM85+
         RV8Fw2bdHIVzcG5xG4mOXf3c4HCt4jXka08PztMXZ56Fkmhq1Az0t3RLM5ggcZT6/8KS
         0FTC9j6v792BbqfgEY1qs9LNRYts/RsKfYG5HSEtu+WT4+rLhexFOjZk42wTHi2LCrGf
         NcfA==
X-Gm-Message-State: AO0yUKUrOotNr6CG8QEUX038doKDYd4Ht1FKb5c7eStGgajyeXH9MWRL
        vsaN35uvmOPp28r7Oxbi2zI=
X-Google-Smtp-Source: AK7set+kCfiq85a5EEOudA19n2ftCnSXPcES2aUgaMGUPY3fNEg33A/7s3qzaJnuXELjfIGcVXdiYw==
X-Received: by 2002:adf:e8d1:0:b0:2c7:1c08:1224 with SMTP id k17-20020adfe8d1000000b002c71c081224mr598158wrn.29.1677544905973;
        Mon, 27 Feb 2023 16:41:45 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003dc4fd6e624sm11319545wmq.19.2023.02.27.16.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 16:41:45 -0800 (PST)
Message-ID: <199e5475333f49eeebfee6e34571638e4dd9d737.camel@gmail.com>
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
Date:   Tue, 28 Feb 2023 02:41:44 +0200
In-Reply-To: <CAEf4BzZUySu10OnsdoyTVXYS_2Ggn2i5KA177RA=v75oquq9TQ@mail.gmail.com>
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
         <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
         <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com>
         <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
         <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com>
         <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
         <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
         <CAEf4BzZUySu10OnsdoyTVXYS_2Ggn2i5KA177RA=v75oquq9TQ@mail.gmail.com>
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

On Mon, 2023-02-27 at 13:13 -0800, Andrii Nakryiko wrote:
> On Wed, Feb 22, 2023 at 11:51 AM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> >=20
> > On Wed, 2023-02-22 at 10:11 -0800, Alexei Starovoitov wrote:
> > [...]
> > > > > > What do you think about something like "debug_type_tag" or
> > > > > > "debug_type_annotation" (and a similar update for the decl tags=
)?
> > > > > > The translation into BTF records would be the same, but the DWA=
RF info
> > > > > > would stand on its own without being tied to BTF.
> > > > > >=20
> > > > > > (Naming is a bit tricky since terms like 'tag' are already in u=
se by
> > > > > > DWARF, e.g. "type tag" in the context of DWARF DIEs makes me th=
ink of
> > > > > > DW_TAG_xxxx_type...)
> > > > > >=20
> > > > > > As far as I understand, early proposals for the tags were more =
generic
> > > > > > but the LLVM reviewers wished for something more specific due t=
o the
> > > > > > relatively limited use of the tags at the time. Now that the ta=
gs and
> > > > > > their DWARF format have matured I think a good case can be made=
 to
> > > > > > make these generic. We'd be happy to help push for such change.
> > > > >=20
> > > > > On the other hand, BTF is a thing we are using this annotation fo=
r.
> > > > > Any other tool can reuse DW_TAG_LLVM_annotation, but it will need=
 a
> > > > > way to distinguish it's annotations from BTF annotations. And thi=
s can
> > > > > be done by using a different DW_AT_name. So, it seems logical to
> > > > > retain "btf" in the DW_AT_name. What do you think?
> > > >=20
> > > > OK I can understand keeping it BTF specific.
> > > >=20
> > > > Other than that, I don't come up with any significantly different i=
dea
> > > > than to use the ":v2" suffix, so let's go with "btf_type_tag:v2"?
> > >=20
> > > I don't like v2 suffix either.
> > > Please come up with something else.
> >=20
> > Nothing particularly good comes to mind:
> > - btf_type_tag:wrapper
> > - btf_type_tag:outer
> > - btf_type_tag:own
> > - exterior_btf_type_tag
> > - outer_btf_tag
> > - btf_type_prefix
> > - btf_type_qualifier (as in const/volatile)
> >=20
> > Or might as well use btf_type_tag:gcc, as you suggested earlier,
> > but it is as confusing as the others.
>=20
> btf.type_tag or btf:type_tag or btf/type_tag (you get the idea, it's
> "BTF scoped")?

`btf/type_tag` is nice but might be somewhat confusing when DWARF is inspec=
ted:
- both old-style and new-style tags would be present in DWARF for some
  time for backwards compatibility;
- old-style tag has name "btf_type_tag".

Thus, the following C code:

  #define __tag1 __attribute__((btf_type_tag("tag1")))
  #define __tag2 __attribute__((btf_type_tag("tag2")))

  int __tag1 * __tag2 g;

Would be encoded in DWARF as:

  0x29:   DW_TAG_pointer_type
            DW_AT_type      (0x35 "int")
 =20
  0x2e:     DW_TAG_LLVM_annotation
              DW_AT_name    ("btf/type_tag:")
              DW_AT_const_value     ("tag2")
 =20
  0x31:     DW_TAG_LLVM_annotation
              DW_AT_name    ("btf_type_tag")
              DW_AT_const_value     ("tag1")
 =20
  0x34:     NULL
 =20
  0x35:   DW_TAG_base_type
            DW_AT_name      ("int")
            DW_AT_encoding  (DW_ATE_signed)
            DW_AT_byte_size (0x04)
 =20
  0x39:     DW_TAG_LLVM_annotation
              DW_AT_name    ("btf/type_tag:")
              DW_AT_const_value     ("tag1")
 =20
  0x3c:     NULL
 =20
Which is not very helpful.

In my opinion "btf_type_tag:v2" is the least confusing option, but if
Alexei does not like it, let's use "btf_type_tag:parent" and move on.

Thanks,
Eduard

