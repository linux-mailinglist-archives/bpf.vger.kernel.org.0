Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178114CB539
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 04:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiCCDFx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 22:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiCCDFx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 22:05:53 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E964D24D
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 19:05:08 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t14so3354103pgr.3
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 19:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aV1tl+iqj7SLdK+mIoSDEKSKSu1znNwYK3wlOHn9KoU=;
        b=HCVyx7xZOTP/yai7zk0odvz+VlpH+g0jgGyyfPDCX0tdgqi3UA+fg+uKtVJmadWuMw
         g2jW4R3Mbtz6VhSnJLSmjgrRilyZzjbFvFAgBPXMPy/yiJlUI8sQ6A0zXyBrK4TZKydn
         al8hy2kxz266tsNeiVXbWuROI3P/nYqYydaac6PG6TSTwMHyrybnvV3hh3BghDJP/2Bm
         dhlBdQT+NlE/+tINxy/gzDbRZmL+/GCLOonU/UDJmvEzWzm+SS3dOnFdp3L1nFl0kNrs
         HZNPDiarE4ENPgX9XB11YxofmQFakdmoFkMTQk4WkG/AZD0kZNIi8WTCn+UDMvh3GcFk
         CamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aV1tl+iqj7SLdK+mIoSDEKSKSu1znNwYK3wlOHn9KoU=;
        b=fVkOvB4xBQFbrwPP2K6UQQAIC7lcvp9a0chq3GecD9kBnMem43Xh8BFNsdPvCE0IAH
         7UfNFcND5675lPTG5tHZAKMsv9UdRCarZqXIdzlGQecO9H+l9H5vd9vqoWPZhxmUOlwa
         MJ5qWmhq7vdJfTJf/rJ988Z9YRzLsdwoNV2lP290YNlYVvz+IXG7Mtz0NOsoayQExAs8
         OJaFQCqJhLMjoxALPTNFzIzRuY5n+sTrdROehox7wUm+uHtFGAxeNwFHjJDWGvJC3zgZ
         7Y7UNSzne28/4KDCWXOEq53hrAZumBA0a4kl2T88kPkC3WGY7MHmIeocXH5lsKrhIFU+
         JBiQ==
X-Gm-Message-State: AOAM531T8NNbGMezn8wQzt1HfkAvXreECsGBUCmwQZJy9dgV3zld6jS9
        xuVq8x/y/zhIo6l29KOlNfAtwbjc4UY=
X-Google-Smtp-Source: ABdhPJwyRq7o9hVK0cC8oUhrU0rOr4nR+8jkFM+fx7Xh0DbZ0btb4mYKWchurL+G0x2CQcbm+G5tAw==
X-Received: by 2002:a63:3481:0:b0:372:f3e7:6f8c with SMTP id b123-20020a633481000000b00372f3e76f8cmr28773482pga.336.1646276708175;
        Wed, 02 Mar 2022 19:05:08 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id x23-20020a63fe57000000b0036490068f12sm470445pgj.90.2022.03.02.19.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 19:05:07 -0800 (PST)
Date:   Thu, 3 Mar 2022 08:35:05 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Subject: Re: BTF type tags not emitted properly when using macros
Message-ID: <20220303030505.vpjcucrdyczat7mt@apollo.legion>
References: <20220220071333.sltv4jrwniool2qy@apollo.legion>
 <11b93216-2592-adfa-1a0b-d8d870144f90@fb.com>
 <6bbb282c-2944-5e22-0869-af1905fa6ced@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bbb282c-2944-5e22-0869-af1905fa6ced@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 22, 2022 at 12:25:58PM IST, Yonghong Song wrote:
>
>
> On 2/20/22 11:22 AM, Yonghong Song wrote:
> >
> >
> > On 2/19/22 11:13 PM, Kumar Kartikeya Dwivedi wrote:
> > > Hi list,
> > >
> > > I noticed another problem in LLVM HEAD wrt BTF type tags.
> > >
> > > When I have a file like bad.c:
> > >
> > >   ; cat bad.c
> > > #define __kptr __attribute__((btf_type_tag("btf_id")))
> > > #define __kptr_ref __kptr __attribute__((btf_type_tag("ref")))
> > > #define __kptr_percpu __kptr __attribute__((btf_type_tag("percpu")))
> > > #define __kptr_user __kptr __attribute__((btf_type_tag("user")))
> > >
> > > struct map_value {
> > >          int __kptr *a;
> > >          int __kptr_ref *b;
> > >          int __kptr_percpu *c;
> > >          int __kptr_user *d;
> > > };
> > >
> > > struct map_value *func(void);
> > >
> > > int main(void)
> > > {
> > >          struct map_value *p = func();
> > >          return *p->a + *p->b + *p->c + *p->d;
> > > }
> > >
> > > All tags are not emitted to BTF (neither are they there in
> > > llvm-dwarfdump output):
> > >
> > >   ; ./src/linux/kptr-map/tools/bpf/bpftool/bpftool btf dump file
> > > bad.o format raw
> > > [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> > > [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > [3] FUNC 'main' type_id=1 linkage=global
> > > [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=0
> > > [5] PTR '(anon)' type_id=6
> > > [6] STRUCT 'map_value' size=32 vlen=4
> > >          'a' type_id=8 bits_offset=0
> > >          'b' type_id=11 bits_offset=64
> > >          'c' type_id=11 bits_offset=128
> > >          'd' type_id=11 bits_offset=192
> > > [7] TYPE_TAG 'btf_id' type_id=2
> > > [8] PTR '(anon)' type_id=7
> > > [9] TYPE_TAG 'btf_id' type_id=2
> > > [10] TYPE_TAG 'ref' type_id=9
> > > [11] PTR '(anon)' type_id=10
> > > [12] FUNC 'func' type_id=4 linkage=extern
> > >
> > > Notice that only btf_id (__kptr) and btf_id + ref (__kptr_ref) are
> > > emitted
> > > properly, and then rest of members use type_id=11, instead of
> > > emitting more type
> > > tags.
> >
> > Thanks for reporting. I think clang frontend may have bugs in handling
> > nested macros. Will debug this.
>
> I just submitted a clang patch to fix this issue.
> See https://reviews.llvm.org/D120296
>
> It should fix your above test case like
>   struct map_value {
>           int __kptr *a;
>           int __kptr_ref *b;
>           int __kptr_percpu *c;
>           int __kptr_user *d;
>   };
> or
>   struct map_value {
>           int __attribute__((btf_type_tag("btf_id"))) *a;
>           int __attribute__((btf_type_tag("btf_id")))
> __attribute__((btf_type_tag("ref"))) *b;
>           ...
>   }
> etc.
>
> It should work with the pure or mix of macro-defined-attribute and/or
> raw-attribute. Please give a try. Thanks!
>

Thanks, and sorry for the delay, I just gave it a spin today, and it seems to
fix the problem.

> >
> > >
> > > When I use a mix of macro and direct attributes, or just attributes,
> > > it does work:
> > >
> > > ; cat good.c
> > > #define __kptr __attribute__((btf_type_tag("btf_id")))
> > >
> > > struct map_value {
> > >          int __kptr *a;
> > >          int __kptr __attribute__((btf_type_tag("ref"))) *b;
> > >          int __kptr __attribute__((btf_type_tag("percpu"))) *c;
> > >          int __kptr __attribute__((btf_type_tag("user"))) *d;
> > > };
> > >
> [...]

--
Kartikeya
