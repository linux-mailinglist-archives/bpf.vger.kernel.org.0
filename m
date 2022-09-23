Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC9B5E865A
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiIWXil (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiIWXik (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:38:40 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E2D120BF0
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:38:39 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-3450990b0aeso14079417b3.12
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yH5+vwr1SDi3f2gyE0VCMe5Klom0CaSSZbmRXgSpGmg=;
        b=fGO8fqLjXvieB3S1HqhJJX704VuUMK9s1GwJ/TV4TRsSlP03e2l08cLv+VkkwoVjgB
         pA4sj4U7v9YoAOXXKZH/kJWEGrBhO6Bouw2ZBgMpfyJdqA8fT4Hyv90FVaTVvy/b4lSR
         BHOe4yucDdF+5zINtzKIToma/a4gs7L3T3QgX7W2aQVNh2bfc1MJTb4awWYqUOsl8Y5F
         HW6yvuSH5m1G7DWQtlSBRmXB2EP0PA3TGkHR6kTVHyUm56qGQa7V4+24eAfAOzCB7W3I
         iPw9/mBrmoF0M2bC7Dd1ynexteAZRMgEGb5LnPM72hOW87hMsDYttYGC9pPkTLu/TBP/
         liEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yH5+vwr1SDi3f2gyE0VCMe5Klom0CaSSZbmRXgSpGmg=;
        b=tF9XFhMHGLhkn9khspGYz6NCPCc0+2pkOYfed102tO5psW18wQIuFiiydmFkI4XYoc
         2R9f+t8uUHwPLtn2Rr6FJiP/PsJA7D9YivIgCoF8ZuFx+iziUVxJlV2az1k1XOSH0bV7
         T3UmWwyYZcdxsBPM7hrmrBr3L6ZcmRhBqrrsoWNcSYhy9mbXAiWQno4OmIk7scWqHFXt
         co94Y3TWhTg9k/3U+sSP6BGbdZbTrcIojOfcQAqliky9rK2yIfWUBm4EVi5o7tMBh0Zg
         PKfAH9Lj7jDt6+nf3FMpZegvpLfy/CU2YmCXXudZ6LqYBd6lP1kZA0NKnuAxJwzPg53S
         m/Tg==
X-Gm-Message-State: ACrzQf0HzWVYngkYO22Y5aAFRMLWDNCx+U3YU+CFuwZJLSVSiwtr7lKM
        +EpGBkulHC/QbSeJzcXN0w5ZiF32pTZ+MdJ/WbgNgTDP
X-Google-Smtp-Source: AMsMyM7RmDbMXkgnjODLiKg8Pqgtr1EzNHByv51Z2IaZqYbwjfFGjliSFzFwDtCHos5SR/FVdU5zrqTzAJwWMt9WV2o=
X-Received: by 2002:a81:6782:0:b0:345:3ffb:cdd4 with SMTP id
 b124-20020a816782000000b003453ffbcdd4mr11231319ywc.118.1663976318977; Fri, 23
 Sep 2022 16:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAP01T752ZOX68V0hnCDAXT0tso7+i0BV0kDbXdvjYHNGM18Y2g@mail.gmail.com>
 <CAEf4BzZ1xxoibbdZ1c3cvv_E7y0T8UASoH4W=XiSfEJ5VZstQg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ1xxoibbdZ1c3cvv_E7y0T8UASoH4W=XiSfEJ5VZstQg@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 24 Sep 2022 01:38:03 +0200
Message-ID: <CAP01T76zowA75yGxdZqPT3ePTtkTsYEnL_+NNr-U5c+5p2eVAQ@mail.gmail.com>
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

On Sat, 24 Sept 2022 at 01:20, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 23, 2022 at 3:32 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Hi,
> > For the following example:
> >
> > kkd@Legion ~/src/linux
> >  ; cat bpf.c
> > #define tag __attribute__((btf_decl_tag("tag")))
> >
> > int a tag;
> > int b tag;
> >
> > int main() {
> >         return a + b;
> > }
> >
> > --
> >
> > When I compile using:
> > clang -target bpf -O2 -g -c bpf.c
> >
> > For the BTF dump, I see:
> > [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> > [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > [3] FUNC 'main' type_id=1 linkage=global
> > [4] VAR 'a' type_id=2, linkage=global
> > [5] DECL_TAG 'tag' type_id=4 component_idx=-1
> > [6] VAR 'b' type_id=2, linkage=global
> > [7] DECL_TAG 'tag' type_id=6 component_idx=-1
> > [8] DATASEC '.bss' size=0 vlen=2
> >         type_id=4 offset=0 size=4 (VAR 'a')
> >         type_id=6 offset=0 size=4 (VAR 'b')
> >
> > There are two issues that I hit:
> >
> > 1. The component_idx=-1 makes it a little inconvenient to correlate
> > the tag applied to a VAR in a DATASEC. In case of structs the index
> > can be matched with component_idx, in case of DATASEC we have to match
> > VAR's type_id. So the code has to be different. If it also had
> > component_idx set it would be possible to make the code same for both
> > inside the kernel's field parsing routine.
>
> This is expected and documented in UAPI:
>
>   "If component_idx == -1, the tag is applied to a struct, union,
> variable or function."
>
> Variable is an independent entity and tag applies to it. I don't
> know/remember why we did it this way, but it's probably easier for
> Clang to generate it this way. And it probably is easier for BPF
> static linker as well. Note that you don't merge two structs together,
> while static linker does merge variables between DATASECs.
>
> In short, DATASEC+VAR is sufficiently different from STRUCT+fields, so
> is treated differently.
>

I see, thanks. In that case I'll add this description as a comment
where the code matches the tag to the VAR.

> >
> > 2. The second issue is that the offset is always 0 for DATASEC VARs.
> > That makes it difficult to ensure proper alignment of the variables.
>
> That's also expected (even if unfortunate) behavior of Clang. Good
> news is that libbpf's static linker API is normalizing this. Libbpf
> itself also normalizes it internally if passed .bpf.o file straight
> from Clang's output.
>
> In short, if you run `bpftool gen object my_normalized.bpf.o
> my_clang.bpf.o` you'll get offsets in my_normalized.bpf.o's BTF.
>

I see. It would be better if this was fixed up by clang itself, but I
don't know enough about the BPF backend to comment whether that would
make sense.

It's unlikely people will run it through libbpf's linker when they're
not statically linking more than one object (or even be using libbpf,
but that's a separate thing), and it's very hard to correlate the
errors to their cause when failure happens during MAP_CREATE (I guess
eventually it should support a log buffer like btf load and prog
load), so in the end it would be confusing for users.

However we do need to ensure the offsets are correct to detect proper
alignment. So adding some checks looks inevitable.
I guess for the first VAR, we can assume offset==0 is fine, but from
the next VAR, we should return an error if we see offset==0 again?
This should catch the not normalized case in case of DATASEC vlen > 1
(== 1 should still be ok). wdyt?

> >
> > I would like to know if these are expected behaviors or bugs?
>
> Features ;)
>
> > Thanks
> > --
> >  ; clang --version
> > Ubuntu clang version
> > 16.0.0-++20220813052912+eaf0aa1f1fbd-1~exp1~20220813173018.344
