Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293556B8620
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCMXfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCMXfn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 19:35:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BAC848F0;
        Mon, 13 Mar 2023 16:35:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f16so14292431ljq.10;
        Mon, 13 Mar 2023 16:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678750539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E7Ozr/dKw0VzyxgOBsFMtcGJgOPj4b0Gs2zXpszZekM=;
        b=W89XNdlieQtt3EVATdurl4QZopyCQbDTLpUtPb6rPMc7uU6y5ZixpyiAwB0WghX+c9
         CWqqnrfvt0v+LILDrN8SpJqIjuxxwV5kUlH7+Ei8lRMX7J/2mpmfpxuPrvoooFlVX2do
         NVoU8IWRC8yTSUFImG+Ro1kLOzXMgsiludRdJ2DVMml7TrNkogyJyvBT5BGOMaE+l8Qb
         9NbBcdbIRhJi9zIJH2Q0Voe4x3reozZtWIjHhGeNsHzgFjL1jKuNZ+OU/Oo6WllSm3ap
         Z8JYSUk+bMv2XwEZDVHg7XYYr6EUj1GgDWnKLVaD73SWgNaKvjHukTqdJpaLsI3IrGuh
         0mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678750539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7Ozr/dKw0VzyxgOBsFMtcGJgOPj4b0Gs2zXpszZekM=;
        b=YB3io4RthLDEQNWNhrw3heA/yqd1lgtUBSN70yu0cEBBYrjCh19MuYfEt+kPYlGUrz
         m7NYxooB9hCUHSk+j3BZHu07KHTKlWB0PSrQOj2oXBP+hYefDEci+zojK5nq2LxGzBvI
         tCgFBJhRoUvMNhrzzQ56/4NSOFZ1p9Td1jt1k3OGaMzE2hwigHl5BtMvQc8ei1nq07QP
         eVRjyIqW8r3+B1xGmBjPQOcCt25/QYargdZIyUUi9ogMbvl2pYODvWVYDbvoV+2nU7lp
         qpjJJDwSnDDdi337GnZir/ImGba1VFEU6cnXMtYvcy0AJ8zCw8o9UKUtCDd+iiQ5rUnC
         Mp6A==
X-Gm-Message-State: AO0yUKUgZq1KCIguB3fffYPYlc/HP4qDPjWC2vQMakietm8v1hgFOZ43
        dWEygLa8NocCZhrm6X3im2I=
X-Google-Smtp-Source: AK7set+OP0WxayPsD5LNtgJ2l7wAQ5WW95pMz/BVrY1yeu5GecjRZNHstqkvCkrky/X+IuosQthzZg==
X-Received: by 2002:a05:651c:2326:b0:295:93c8:496f with SMTP id bi38-20020a05651c232600b0029593c8496fmr10018385ljb.9.1678750539359;
        Mon, 13 Mar 2023 16:35:39 -0700 (PDT)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k5-20020a2e8885000000b00295989df708sm195395lji.28.2023.03.13.16.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 16:35:38 -0700 (PDT)
Message-ID: <2232e368e55eb401bde45ce1b20fb710e379ae9c.camel@gmail.com>
Subject: Re: [PATCH dwarves 0/1] Support for new btf_type_tag encoding
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com
Date:   Tue, 14 Mar 2023 01:35:37 +0200
In-Reply-To: <ZA+Ibs4GBwv5mHPC@kernel.org>
References: <20230313021744.406197-1-eddyz87@gmail.com>
         <ZA+Ibs4GBwv5mHPC@kernel.org>
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

On Mon, 2023-03-13 at 17:32 -0300, Arnaldo Carvalho de Melo wrote:
[...]
> >   @ -72998,8 +73022,8 @ struct sock {
> >           /* --- cacheline 19 boundary (1216 bytes) --- */
> >           int                        (*sk_backlog_rcv)(struct sock *, s=
truct sk_buff *); /*  1216     8 */
> >           void                       (*sk_destruct)(struct sock *); /* =
 1224     8 */
> >   -       rcu *                      sk_reuseport_cb;      /*  1232    =
 8 */
> >   -       rcu *                      sk_bpf_storage;       /*  1240    =
 8 */
> >   +       <ERROR                    > sk_reuseport_cb;     /*  1232    =
 8 */
> >   +       <ERROR                    > sk_bpf_storage;      /*  1240    =
 8 */
> >=20
> > (Also DWARF names refer to TYPE_TAG, not actual type name, fixed in pah=
ole-new).
> >=20
> > Warn #1: pahole-next complains about unexpected child tags generated
> > by clang, e.g.:
> >=20
> >   die__create_new_tag: unspecified_type WITH children!
> >   die__create_new_base_type: DW_TAG_base_type WITH children!

Hi Arnaldo,
=20
> Sure, we can remove those if the children is the expected one, leaving
> the warning maybe for debug sessions.

Yes, I handle it in the pahole-new. Warnings are not reported for
DW_TAG_LLVM_annotation children when these are applicable.

>=20
> Thanks for the detailed implementation notes, references and tests
> performed, please consider breaking it up into smaller pieces or
> ellaborate on why you think can't be done.


I can split the patch into several parts,
it would be a bit stretched, though:
1. change in btf_loader / dwarves_fprintf to correctly print names for
   types with type tags;
2. consolidation of `struct btf_type_tag_type` and `struct llvm_annotation`=
;
3. the logic to handle "btf:type_tags";
4. support for "void __tag*" as unspecified type.

Part #3 would still be quite big, +500 LoC or something like this.
Will submit v2 today or tomorrow.

Thanks,
Eduard

>=20
> Thanks!
>=20
> - Arnaldo
> =20
> >=20
> > Performance impact
> > ------------------
> >=20
> > The update to `struct tag` might raise concerns regarding memory
> > usage, additional steps in recode phase might raise concerns regarding
> > execution time. Below is statistics collected for Kernel BTF
> > generation.
> >=20
> > LLVM-new / LLVM-new / pahole-new:
> >=20
> > $ /usr/bin/time -v pahole -J --btf_gen_floats -j --lang_exclude=3Drust =
.tmp_vmlinux.btf
> >     ...
> > 	User time (seconds): 22.29
> > 	System time (seconds): 0.47
> > 	Percent of CPU this job got: 483%
> >     ...
> > 	Maximum resident set size (kbytes): 714524
> >     ...
> >=20
> > LLVM-new / LLVM-new / pahole-next:
> >=20
> > $ /usr/bin/time -v pahole -J --btf_gen_floats -j --lang_exclude=3Drust =
.tmp_vmlinux.btf
> >     ...
> > 	User time (seconds): 20.96
> > 	System time (seconds): 0.44
> > 	Percent of CPU this job got: 473%
> >     ...
> > 	Maximum resident set size (kbytes): 700848
> >     ...
> >=20
> > Links & revisions
> > -----------------
> >=20
> > [1] Mailing list discussion regarding `btf:type_tag`
> >     https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/
> > [2] Suggestion to use btfdiff
> >     https://lore.kernel.org/dwarves/ZAKpZGSHTvsS4r8E@kernel.org/T/#mddb=
fe661e339485fb2b0e706b31329b46bf61bda
> > [3] f759275c1c8e ("[AMDGPU] Regenerate sdwa-peephole.ll")
> > [4] a9498899109d ("dwarf_loader: Support for btf:type_tag")
> > [5] 49b5300f1f8f ("Merge branch 'Support stashing local kptrs with bpf_=
kptr_xchg'")
> > [6] LLVM changes to generate btf:type_tag, revisions stack:
> >     https://reviews.llvm.org/D143966
> >     https://reviews.llvm.org/D143967
> >     https://reviews.llvm.org/D145891
> >=20
> > Eduard Zingerman (1):
> >   dwarf_loader: Support for btf:type_tag
> >=20
> >  btf_encoder.c     |  13 +-
> >  btf_loader.c      |  15 +-
> >  dwarf_loader.c    | 763 +++++++++++++++++++++++++++++++++++++---------
> >  dwarves.c         |   1 +
> >  dwarves.h         |  68 +++--
> >  dwarves_fprintf.c |  13 +
> >  6 files changed, 693 insertions(+), 180 deletions(-)
> >=20
> > --=20
> > 2.39.1
> >=20
>=20

