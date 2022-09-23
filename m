Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA25E8667
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiIWX73 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiIWX72 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:59:28 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1868813A3B2
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:59:27 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-3450a7358baso14277967b3.13
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=V90JZc7AxqTr3O/a7BjTVb2lO2iHX9uK470oTdgHkeU=;
        b=EHpJON1MIA2ttm4KbJd89NUQMdzwVJgUJKZerS/fSaNJiwKgwQtsy3CT2Ui+6gcpMh
         CZNmlSOtu7mz3xboKiT2rjynS2tF11v2r4nr18V0h5otzjqGTs0GD6dlmTSbLsbmsRb9
         3BSti33k22aGzl4dcXHTRUlymdmfnE5O6gABe0d9srKY201+gF6TCc2F2z6kPAygNgt0
         TPIg1FQ3pQsrubPkkAXvVPkx3Ky05ShNNVgs1n23F3KQqNfkuIZuj92bFQs1CmoKzFTv
         Z8YXuHchxdwJrNMXGh3RB7sZZfe+1m4Sxac9ZAeWleWUl1JZs8dpJGLCngNoQkgthf6D
         S0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V90JZc7AxqTr3O/a7BjTVb2lO2iHX9uK470oTdgHkeU=;
        b=jQRRkRiZ5TyNoMHO70qEJO/KF66C+c/K+gBjdkto6/uJxoBqVZnZgG0JE1hmj2Y8JW
         usGx2ydv6sV8thDU/D4aANeDei+mm3xpXMLZf0jfKekOgFx5DVmpjJlbcmVzZ61Ihte2
         O2NG3i884Pc7Acf4Dg5oFPsVBkAhQbYb5cP1DtjLzqsFP8RLDBmp7xSPchgn/ME5sYlR
         C5xDsTlo7tq1XTetd7wVAleNYukW1JmKtblCxuJ6FiLrThiz7rqxgnqtwI1AaBEgojqD
         /V0pChMp1K4U29a2yR+SI1aZEKU/HYNnZkMeklnNJvC8B1Oew7xrCk3dT/oqq0wHe81w
         7ZOA==
X-Gm-Message-State: ACrzQf3BaUeC7SgslGejH/7Wd2cLT8FfHP4kpfwFNQcEMOwrBDOTYn6E
        Kuw1c0sa+Ls5g8C+kWfwx+mr1u3tIggqUeBjeG0=
X-Google-Smtp-Source: AMsMyM4pvxyTe4a6ZzxlqGKW9SgNbTMs1SQ4qTioST7nxaipHhnwC2i4Cdyq1/xZQfCy7G7zcnef0oBSF8jNqSidth0=
X-Received: by 2002:a0d:e815:0:b0:345:4:e358 with SMTP id r21-20020a0de815000000b003450004e358mr11415813ywe.291.1663977566119;
 Fri, 23 Sep 2022 16:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAP01T752ZOX68V0hnCDAXT0tso7+i0BV0kDbXdvjYHNGM18Y2g@mail.gmail.com>
 <CAEf4BzZ1xxoibbdZ1c3cvv_E7y0T8UASoH4W=XiSfEJ5VZstQg@mail.gmail.com>
 <CAP01T76zowA75yGxdZqPT3ePTtkTsYEnL_+NNr-U5c+5p2eVAQ@mail.gmail.com> <CAEf4BzZZb70X8GXBRgS+0=9b5h=A59bw8s0x7Gra_-rC=xVvEw@mail.gmail.com>
In-Reply-To: <CAEf4BzZZb70X8GXBRgS+0=9b5h=A59bw8s0x7Gra_-rC=xVvEw@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 24 Sep 2022 01:58:50 +0200
Message-ID: <CAP01T758+AhWkE_g9CG6zdf0oY6GEPdZ3rhf_kKQEqGjSMQGNw@mail.gmail.com>
Subject: Re: Possible bugs in generated DATASEC BTF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, "yhs@fb.com" <yhs@fb.com>,
        andrii@kernel.org
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

On Sat, 24 Sept 2022 at 01:49, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 23, 2022 at 4:38 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 24 Sept 2022 at 01:20, Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Sep 23, 2022 at 3:32 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > Hi,
> > > > For the following example:
> > > >
> > > > kkd@Legion ~/src/linux
> > > >  ; cat bpf.c
> > > > #define tag __attribute__((btf_decl_tag("tag")))
> > > >
> > > > int a tag;
> > > > int b tag;
> > > >
> > > > int main() {
> > > >         return a + b;
> > > > }
> > > >
> > > > --
> > > >
> > > > When I compile using:
> > > > clang -target bpf -O2 -g -c bpf.c
> > > >
> > > > For the BTF dump, I see:
> > > > [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> > > > [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > [3] FUNC 'main' type_id=1 linkage=global
> > > > [4] VAR 'a' type_id=2, linkage=global
> > > > [5] DECL_TAG 'tag' type_id=4 component_idx=-1
> > > > [6] VAR 'b' type_id=2, linkage=global
> > > > [7] DECL_TAG 'tag' type_id=6 component_idx=-1
> > > > [8] DATASEC '.bss' size=0 vlen=2
> > > >         type_id=4 offset=0 size=4 (VAR 'a')
> > > >         type_id=6 offset=0 size=4 (VAR 'b')
> > > >
> > > > There are two issues that I hit:
> > > >
> > > > 1. The component_idx=-1 makes it a little inconvenient to correlate
> > > > the tag applied to a VAR in a DATASEC. In case of structs the index
> > > > can be matched with component_idx, in case of DATASEC we have to match
> > > > VAR's type_id. So the code has to be different. If it also had
> > > > component_idx set it would be possible to make the code same for both
> > > > inside the kernel's field parsing routine.
> > >
> > > This is expected and documented in UAPI:
> > >
> > >   "If component_idx == -1, the tag is applied to a struct, union,
> > > variable or function."
> > >
> > > Variable is an independent entity and tag applies to it. I don't
> > > know/remember why we did it this way, but it's probably easier for
> > > Clang to generate it this way. And it probably is easier for BPF
> > > static linker as well. Note that you don't merge two structs together,
> > > while static linker does merge variables between DATASECs.
> > >
> > > In short, DATASEC+VAR is sufficiently different from STRUCT+fields, so
> > > is treated differently.
> > >
> >
> > I see, thanks. In that case I'll add this description as a comment
> > where the code matches the tag to the VAR.
> >
> > > >
> > > > 2. The second issue is that the offset is always 0 for DATASEC VARs.
> > > > That makes it difficult to ensure proper alignment of the variables.
> > >
> > > That's also expected (even if unfortunate) behavior of Clang. Good
> > > news is that libbpf's static linker API is normalizing this. Libbpf
> > > itself also normalizes it internally if passed .bpf.o file straight
> > > from Clang's output.
> > >
> > > In short, if you run `bpftool gen object my_normalized.bpf.o
> > > my_clang.bpf.o` you'll get offsets in my_normalized.bpf.o's BTF.
> > >
> >
> > I see. It would be better if this was fixed up by clang itself, but I
> > don't know enough about the BPF backend to comment whether that would
> > make sense.
> >
> > It's unlikely people will run it through libbpf's linker when they're
> > not statically linking more than one object (or even be using libbpf,
> > but that's a separate thing), and it's very hard to correlate the
> > errors to their cause when failure happens during MAP_CREATE (I guess
> > eventually it should support a log buffer like btf load and prog
> > load), so in the end it would be confusing for users.
> >
> > However we do need to ensure the offsets are correct to detect proper
> > alignment. So adding some checks looks inevitable.
> > I guess for the first VAR, we can assume offset==0 is fine, but from
> > the next VAR, we should return an error if we see offset==0 again?
> > This should catch the not normalized case in case of DATASEC vlen > 1
> > (== 1 should still be ok). wdyt?
> >
>
> It's unclear who's "we", who's loading what, when and where, tbh. So
> please provide a bit of a context. We started from a simple isolated C
> example and two questions about BTF, and now I'm not sure what we are
> talking about at all.
>
> Libbpf patches BTF and assigns correct offsets before loading BTF into
> the kernel. But I assume whatever you are doing doesn't use libbpf?
>

Sorry :), my bad. So this is about the bpf list series.

struct bpf_list_head head __contains(foo, node); // global variable
That 'contains' is a declaration tag.

In https://lore.kernel.org/bpf/20220904204145.3089-14-memxor@gmail.com

I was calling btf_find_list_head inside btf_find_datasec_var with
index == -1 (third argument) which is eventually matched with
component_idx in btf_find_decl_tag_value.

So that part is something you clarified, but earlier in
btf_find_datasec_var the code also checks the alignment using the
offset of the VAR.

What I was trying to say is that we cannot assume libbpf fixes up the
offsets for the map BTF inside the kernel, a user may load a
non-normalized BTF with all offsets of DATASEC VARs as 0, so we should
probably still reject seeing off == 0 after the first VAR in a
DATASEC, otherwise the off % align check can be bypassed.

Hopefully it's clearer now.

> > > >
> > > > I would like to know if these are expected behaviors or bugs?
> > >
> > > Features ;)
> > >
> > > > Thanks
> > > > --
> > > >  ; clang --version
> > > > Ubuntu clang version
> > > > 16.0.0-++20220813052912+eaf0aa1f1fbd-1~exp1~20220813173018.344
