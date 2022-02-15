Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99C84B7551
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 21:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiBOUcR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 15:32:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiBOUcR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 15:32:17 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28EC89CD4
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 12:32:06 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 139so883pge.1
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 12:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2xvumnxAEB9SWgnIvTv5R5ZIuNGcs5VEN62m+h7DiDM=;
        b=Kgv785HSAeT3QcQTW27CVet9PsYEyZ0mwnYQEr6YxaSbgKN4UZcCySiDMcKIRaWfPI
         Z7iQoeGvMk96bJBrTlTikhTCsBx3tRjUtcmA0L4Q0i0MAtvlctQXHBOw9Tdim9Dov61D
         j8m2QyBSYbOBNZJXs62xcrsyvHK0h7qrFe2lulknTC7sYxoHD4RZRpzHgssuZgB9Zpc4
         jNx///wN7XQuC7SxASnT8rE+hZnhrTs2mvAoZpQV7oVhJkVoZaURpvlDfJXL7hpH51xs
         OX+WigKvQBaZ0XhzvL6rvscSRNx22C7Vja4LLCAdvzGtYN4ljxRo9v4J7BJmFqcJ+DM8
         PgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2xvumnxAEB9SWgnIvTv5R5ZIuNGcs5VEN62m+h7DiDM=;
        b=Eu/w/hK/rKiQ1IxWtn44IIUjI9+kxY1zea1e8duGUfy7Icms2kpWdDpYcHZKGWsI9H
         BA4Yv9HSJVvep/2h5q2FlFYTsN1KfBxlLlnQvAQtDv/lC6+Z4PRh+w1uQBMUWB16GN6m
         4MSO13m+ttFUXDzZYG4x3Emk4ZyjVftiUirCJ9+TT9D7v/DMk/Gk0nvvqFWCyrUdVPVL
         3MCsBmsM+g5OfhELl7oCM601nkgRRMDWeZJmqWPUDfHa6U1GVQ7U95oSwSyZY0DlG1Oh
         wsU/mcGh43mo8Ag4gbqUOQHHElUvItEeVaGPh1jHeeKa8W2R4or7LniXEFPlxjxgTvfv
         QShg==
X-Gm-Message-State: AOAM533NVmzgb5lvfSoiQJ1MTLl7jRRf96M0fq3sUyeriWZ18zGguygJ
        27J683adv+FWEEAZNmr4gRI=
X-Google-Smtp-Source: ABdhPJwYpSNF9el/WitZ2LQ5BID3vvksxh85KOU1CuTvniJ8qdRnovRwnp5EmOZ1myyWj4TF4m7FcQ==
X-Received: by 2002:a63:4e:: with SMTP id 75mr509056pga.461.1644957126248;
        Tue, 15 Feb 2022 12:32:06 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id y20sm22052154pfi.87.2022.02.15.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:32:05 -0800 (PST)
Date:   Wed, 16 Feb 2022 02:02:03 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Subject: Re: BTF type tag not emitted to BTF in some cases
Message-ID: <20220215203203.uoinzfn3wa6ath5g@apollo.legion>
References: <20220210232411.pmhzj7v5uptqby7r@apollo.legion>
 <bf1d4051-ae3b-c61e-131d-d6df9002529d@fb.com>
 <a7a8ade2-593c-957b-8748-b726b6127a30@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7a8ade2-593c-957b-8748-b726b6127a30@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 15, 2022 at 09:18:45PM IST, Yonghong Song wrote:
>
>
> On 2/10/22 4:31 PM, Yonghong Song wrote:
> >
> >
> > On 2/10/22 3:24 PM, Kumar Kartikeya Dwivedi wrote:
> > > Hello,
> > >
> > > I was trying to use BTF type tags, but I noticed that when I apply
> > > it to a
> > > non-builtin type, it isn't emitted in the 'PTR' -> 'TYPE_TAG' ->
> > > <TYPE> chain.
> > >
> > > Consider the following two cases:
> > >
> > >   ; cat tag_good.c
> > > #define __btf_id __attribute__((btf_type_tag("btf_id")))
> > > #define __ref    __attribute__((btf_type_tag("ref")))
> > >
> > > struct map_value {
> > >          long __btf_id __ref *ptr;
> > > };
> > >
> > > void func(struct map_value *, long *);
> > >
> > > int main(void)
> > > {
> > >          struct map_value v = {};
> > >
> > >          func(&v, v.ptr);
> > > }
> > >
> > > ; cat tag_bad.c
> > > #define __btf_id __attribute__((btf_type_tag("btf_id")))
> > > #define __ref    __attribute__((btf_type_tag("ref")))
> > >
> > > struct foo {
> > >          int i;
> > > };
> > >
> > > struct map_value {
> > >          struct foo __btf_id __ref *ptr;
> > > };
> > >
> > > void func(struct map_value *, struct foo *);
> > >
> > > int main(void)
> > > {
> > >          struct map_value v = {};
> > >
> > >          func(&v, v.ptr);
> > > }
> > >
> > > --
> > >
> > > In the first case, it is applied to a long, in the second, it is
> > > applied to
> > > struct foo.
> > >
> > > For the first case, we see:
> > >
> > > [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> > > [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > [3] FUNC 'main' type_id=1 linkage=global
> > > [4] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
> > >          '(anon)' type_id=5
> > >          '(anon)' type_id=11
> > > [5] PTR '(anon)' type_id=6
> > > [6] STRUCT 'map_value' size=8 vlen=1
> > >          'ptr' type_id=9 bits_offset=0
> > > [7] TYPE_TAG 'btf_id' type_id=10
> > > [8] TYPE_TAG 'ref' type_id=7
> > > [9] PTR '(anon)' type_id=8
> > > [10] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > > [11] PTR '(anon)' type_id=10
> > > [12] FUNC 'func' type_id=4 linkage=extern
> > >
> > > For the second, there is no TYPE_TAG:
> > >
> > >   ; ../linux/tools/bpf/bpftool/bpftool btf dump file tag_bad.o
> > > [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> > > [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > [3] FUNC 'main' type_id=1 linkage=global
> > > [4] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
> > >          '(anon)' type_id=5
> > >          '(anon)' type_id=8
> > > [5] PTR '(anon)' type_id=6
> > > [6] STRUCT 'map_value' size=8 vlen=1
> > >          'ptr' type_id=7 bits_offset=0
> > > [7] PTR '(anon)' type_id=9
> > > [8] PTR '(anon)' type_id=9
> > > [9] STRUCT 'foo' size=4 vlen=1
> > >          'i' type_id=2 bits_offset=0
> > > [10] FUNC 'func' type_id=4 linkage=extern
> > >
> > > --
> > >
> > > Is there anything I am missing here? When I do llvm-dwarfdump for
> > > both, I see
> > > that the tag annotation is present for both:
> >
> > Thanks for trying and reporting! This should be a llvm bpf backend bug.
> > Will fix it soon.
>
> The issue is fixed in https://reviews.llvm.org/D119799 and
> the patch is merged in llvm-project main branch.
> Could you take a look again? Thanks!
>

Thanks for the quick fix Yonghong! I tested it out and it seems to work fine
now. Thanks a lot!

> >
> > >
> > > For the good case:
> > >
> > > 0x00000067:   DW_TAG_pointer_type
> > >                  DW_AT_type      (0x00000073 "long")
> > >
> > > 0x0000006c:     DW_TAG_unknown_6000
> > >                    DW_AT_name    ("btf_type_tag")
> > >                    DW_AT_const_value     ("btf_id")
> >
> > BTW, if you use the same llvm-dwarfdump from 15.0.0,
> > $ llvm-dwarfdump --version
> > LLVM (http://llvm.org/ ):
> >    LLVM version 15.0.0git
> >    Optimized build with assertions.
> >    Default target: x86_64-unknown-linux-gnu
> >    Host CPU: skylake-avx512
> >
> > You should see
> > 0x0000006c:     DW_TAG_LLVM_annotation
> >                    DW_AT_name    ("btf_type_tag")
> >                    DW_AT_const_value     ("btf_id")
> >
> > instead of
> >          DW_TAG_unknown_6000
> >
> > >
> > > 0x0000006f:     DW_TAG_unknown_6000
> > >                    DW_AT_name    ("btf_type_tag")
> > >                    DW_AT_const_value     ("ref")
> > >
> > > For the bad case:
> > >
> > > 0x00000067:   DW_TAG_pointer_type
> > >                  DW_AT_type      (0x00000073 "foo")
> > >
> > > 0x0000006c:     DW_TAG_unknown_6000
> > >                    DW_AT_name    ("btf_type_tag")
> > >                    DW_AT_const_value     ("btf_id")
> > >
> > > 0x0000006f:     DW_TAG_unknown_6000
> > >                    DW_AT_name    ("btf_type_tag")
> > >                    DW_AT_const_value     ("ref")
> > >
> > > My clang version is a very recent compile:
> > > clang version 15.0.0 (https://github.com/llvm/llvm-project.git
> > > 9e08e9298059651e4f42eb608c3de9d4ad8004b2)
> > >
> > > Thanks
> > > --
> > > Kartikeya

--
Kartikeya
