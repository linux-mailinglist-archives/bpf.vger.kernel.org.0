Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB85EE9BF
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 00:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiI1Wy3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 18:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiI1Wy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 18:54:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072D115A4D
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:54:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id 13so30067346ejn.3
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xsnMmd9MoWk9mxkrtvhQRULtDaqQiufQsauV59rAz7Q=;
        b=GRZmyVS78SGZZirb64+7sWIEm9ElRjBe5fMrmNYGLesxfvIVHeYEUN+GfKKpDS6eML
         nAIfuFj8M2JMjx7wedn94mew2QnPRuzeESm39GvQGW6Y5+z7tPhArEOgV5SEnb40RZfW
         knPnlOG4H7mo5gHaDiY64XGhjjq0L+ziYK8aye+E0O+xorfSV3tPrmCdwlUY0LPLWk0p
         /yHGSBo7cHedbhDQ71tzE5Hchlc0Y6kgVXlQkJqH91k2cIe7OnzZT0ySDdWPakdih2Tl
         bkDxdzowivZRFaWCoR6u2GdtU8p13+ZL4sSDUXhL2srs+tFo8xFRTlTVjdsExqMCCST1
         DyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xsnMmd9MoWk9mxkrtvhQRULtDaqQiufQsauV59rAz7Q=;
        b=Vfjq++qrEorii2Bo+jkoemwY3PkHzoTatUl3R+qClre6PiP9GRrMXBE9Mg2e3tzEuV
         xbFGSS0F+3L0zbHNFnp+6KaIrKrvGfHceij0Av0cIXhMosnG/l6c/wJPmmJbsO8G+hI3
         v/i1BtyF9z8qmqlEbrelVIluTtQ38AcTttgkQNuHocR8K58hFrNzWynVkGrzeKRZzRoe
         8nros5Q6WkqL4Ped05h0uaB3gvn2w/Vbh/3M3v46Gz1QtpwppFHhBk5aci6Yd1/1Z1a6
         Kq2H70labXvQw2kV25SF8lQlTpFGd6aY/9DrFgqj2gd0z6weuiONFw0oFhC7B1bSDiTd
         idOg==
X-Gm-Message-State: ACrzQf0oHVkfcc5EMOyjBb/iccVbAh6RkP8AKnYzMNyta+BSgaPjx3cX
        Qmhe3f1q0iJPeQtjm0p/9TRamVTg7wX9VAFoArY=
X-Google-Smtp-Source: AMsMyM4kt2ObH++FxP1AubLFhkfFK7uZbr0BDTgQ+Z1a1TUlFZOSDMlnficQKNTYO59f77EFtI5eqdkH5nq8z4xlKMc=
X-Received: by 2002:a17:907:2bd8:b0:770:77f2:b7af with SMTP id
 gv24-20020a1709072bd800b0077077f2b7afmr149019ejc.545.1664405664867; Wed, 28
 Sep 2022 15:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAP01T752ZOX68V0hnCDAXT0tso7+i0BV0kDbXdvjYHNGM18Y2g@mail.gmail.com>
 <CAEf4BzZ1xxoibbdZ1c3cvv_E7y0T8UASoH4W=XiSfEJ5VZstQg@mail.gmail.com>
 <CAP01T76zowA75yGxdZqPT3ePTtkTsYEnL_+NNr-U5c+5p2eVAQ@mail.gmail.com>
 <CAEf4BzZZb70X8GXBRgS+0=9b5h=A59bw8s0x7Gra_-rC=xVvEw@mail.gmail.com> <CAP01T758+AhWkE_g9CG6zdf0oY6GEPdZ3rhf_kKQEqGjSMQGNw@mail.gmail.com>
In-Reply-To: <CAP01T758+AhWkE_g9CG6zdf0oY6GEPdZ3rhf_kKQEqGjSMQGNw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 15:54:12 -0700
Message-ID: <CAEf4Bza7ga2hEQ4J7EtgRHz49p1vZtaT4d2RDiyGOKGK41Nt=Q@mail.gmail.com>
Subject: Re: Possible bugs in generated DATASEC BTF
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Fri, Sep 23, 2022 at 4:59 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 24 Sept 2022 at 01:49, Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Sep 23, 2022 at 4:38 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Sat, 24 Sept 2022 at 01:20, Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 23, 2022 at 3:32 PM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > > For the following example:
> > > > >
> > > > > kkd@Legion ~/src/linux
> > > > >  ; cat bpf.c
> > > > > #define tag __attribute__((btf_decl_tag("tag")))
> > > > >
> > > > > int a tag;
> > > > > int b tag;
> > > > >
> > > > > int main() {
> > > > >         return a + b;
> > > > > }
> > > > >
> > > > > --
> > > > >
> > > > > When I compile using:
> > > > > clang -target bpf -O2 -g -c bpf.c
> > > > >
> > > > > For the BTF dump, I see:
> > > > > [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> > > > > [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > > > > [3] FUNC 'main' type_id=1 linkage=global
> > > > > [4] VAR 'a' type_id=2, linkage=global
> > > > > [5] DECL_TAG 'tag' type_id=4 component_idx=-1
> > > > > [6] VAR 'b' type_id=2, linkage=global
> > > > > [7] DECL_TAG 'tag' type_id=6 component_idx=-1
> > > > > [8] DATASEC '.bss' size=0 vlen=2
> > > > >         type_id=4 offset=0 size=4 (VAR 'a')
> > > > >         type_id=6 offset=0 size=4 (VAR 'b')
> > > > >
> > > > > There are two issues that I hit:
> > > > >
> > > > > 1. The component_idx=-1 makes it a little inconvenient to correlate
> > > > > the tag applied to a VAR in a DATASEC. In case of structs the index
> > > > > can be matched with component_idx, in case of DATASEC we have to match
> > > > > VAR's type_id. So the code has to be different. If it also had
> > > > > component_idx set it would be possible to make the code same for both
> > > > > inside the kernel's field parsing routine.
> > > >
> > > > This is expected and documented in UAPI:
> > > >
> > > >   "If component_idx == -1, the tag is applied to a struct, union,
> > > > variable or function."
> > > >
> > > > Variable is an independent entity and tag applies to it. I don't
> > > > know/remember why we did it this way, but it's probably easier for
> > > > Clang to generate it this way. And it probably is easier for BPF
> > > > static linker as well. Note that you don't merge two structs together,
> > > > while static linker does merge variables between DATASECs.
> > > >
> > > > In short, DATASEC+VAR is sufficiently different from STRUCT+fields, so
> > > > is treated differently.
> > > >
> > >
> > > I see, thanks. In that case I'll add this description as a comment
> > > where the code matches the tag to the VAR.
> > >
> > > > >
> > > > > 2. The second issue is that the offset is always 0 for DATASEC VARs.
> > > > > That makes it difficult to ensure proper alignment of the variables.
> > > >
> > > > That's also expected (even if unfortunate) behavior of Clang. Good
> > > > news is that libbpf's static linker API is normalizing this. Libbpf
> > > > itself also normalizes it internally if passed .bpf.o file straight
> > > > from Clang's output.
> > > >
> > > > In short, if you run `bpftool gen object my_normalized.bpf.o
> > > > my_clang.bpf.o` you'll get offsets in my_normalized.bpf.o's BTF.
> > > >
> > >
> > > I see. It would be better if this was fixed up by clang itself, but I
> > > don't know enough about the BPF backend to comment whether that would
> > > make sense.
> > >
> > > It's unlikely people will run it through libbpf's linker when they're
> > > not statically linking more than one object (or even be using libbpf,
> > > but that's a separate thing), and it's very hard to correlate the
> > > errors to their cause when failure happens during MAP_CREATE (I guess
> > > eventually it should support a log buffer like btf load and prog
> > > load), so in the end it would be confusing for users.
> > >
> > > However we do need to ensure the offsets are correct to detect proper
> > > alignment. So adding some checks looks inevitable.
> > > I guess for the first VAR, we can assume offset==0 is fine, but from
> > > the next VAR, we should return an error if we see offset==0 again?
> > > This should catch the not normalized case in case of DATASEC vlen > 1
> > > (== 1 should still be ok). wdyt?
> > >
> >
> > It's unclear who's "we", who's loading what, when and where, tbh. So
> > please provide a bit of a context. We started from a simple isolated C
> > example and two questions about BTF, and now I'm not sure what we are
> > talking about at all.
> >
> > Libbpf patches BTF and assigns correct offsets before loading BTF into
> > the kernel. But I assume whatever you are doing doesn't use libbpf?
> >
>
> Sorry :), my bad. So this is about the bpf list series.
>
> struct bpf_list_head head __contains(foo, node); // global variable
> That 'contains' is a declaration tag.
>
> In https://lore.kernel.org/bpf/20220904204145.3089-14-memxor@gmail.com
>
> I was calling btf_find_list_head inside btf_find_datasec_var with
> index == -1 (third argument) which is eventually matched with
> component_idx in btf_find_decl_tag_value.
>
> So that part is something you clarified, but earlier in
> btf_find_datasec_var the code also checks the alignment using the
> offset of the VAR.
>
> What I was trying to say is that we cannot assume libbpf fixes up the
> offsets for the map BTF inside the kernel, a user may load a
> non-normalized BTF with all offsets of DATASEC VARs as 0, so we should
> probably still reject seeing off == 0 after the first VAR in a
> DATASEC, otherwise the off % align check can be bypassed.

Yeah, of course, no assumptions. It probably would be better to reject
something like this only if it can cause problem (e.g., if kernel
actually needs to know variable offsets). But I have not strong
opinion here.

>
> Hopefully it's clearer now.
>
> > > > >
> > > > > I would like to know if these are expected behaviors or bugs?
> > > >
> > > > Features ;)
> > > >
> > > > > Thanks
> > > > > --
> > > > >  ; clang --version
> > > > > Ubuntu clang version
> > > > > 16.0.0-++20220813052912+eaf0aa1f1fbd-1~exp1~20220813173018.344
