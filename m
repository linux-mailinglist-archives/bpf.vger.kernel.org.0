Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838285E8643
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIWXUd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiIWXUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:20:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED8A10651A
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:20:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so3609768ejn.3
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fUxa2e9NUfqf5etJcicjpGlgn8VD8iIcHFiHBEyXgkU=;
        b=W8i2DsA2FY0fhJ+tnYP659h62rQzJrVJkbdkzYGqseqtr5lcVQBxgJg4y8E6HVWv9S
         P5TrbA8+N+GIeeoFyj5Lvoqv3sPwzMGorwdYafNIZSsS0pdkuNEttFFhaLVN8i6l0gZp
         +tiqpwL3sGNSsvcFwLVq/7VQIsGXwLUbfKP4IuyvcAd17Z22nOID3GFP+FmwrDYZyq3B
         SAXHnq23caLYHCGoh6Iq/HWddY7ankaGyWaeDQwPuyhhVemcmLdxDYynQVOtdJ0Mn+nD
         hPdEq69tw8vMWsnJqgjfcbLzONltZzcTjKNDuQbnSB2kIEV6KBb6yHzWEzNeMGEC7kXN
         LvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fUxa2e9NUfqf5etJcicjpGlgn8VD8iIcHFiHBEyXgkU=;
        b=bVEDFzIR8dL9CMIetFhh1PCa/kXoRXf5eDYsP6E5L9fcGPhCa0JnosUQQ/cvW7UgvZ
         0hCeqrr7pRjcrOrUcGVEPeOMf81fcVkiFv//60seBegFBrlejJUkKoLL7MN+tcdeCrLw
         AY1ERW/aMb9bCUm1vxAKy9nz3sIUKe8b2SCb/UXqbk/aiAV6lw3bW8mlIsrroQBw8xcG
         EmTCNV2mgbBnzv0LUikFfEDLLBLEVT7hMHrYFNlI4QZ64aaP0PQa7I1WU7uiHe5N6UkV
         v9ND8NRGBn2zVpcLD9/adUy9orEEpltEdfb9hQl5xiKlKrQAA5TPJCg2wDQOGQ9Pswq5
         ORkA==
X-Gm-Message-State: ACrzQf3ERKkdyQ2eNXxHSgGhbxyiOFBTM7fYUcoqxizjbdEYb62dIjhD
        f8ssLTMr6MzNOUAuFYVP7haIIfDwyLbGItKsTgVpB5FvS2s=
X-Google-Smtp-Source: AMsMyM5rgeYH6vVEXBZhJGPCFWMwB0W2HdzLveXpeebQL+yx6mCoA4nF+K1HkhIROROXAnIfEnvb9r+0xYdjMEKnztk=
X-Received: by 2002:a17:907:984:b0:77f:4d95:9e2f with SMTP id
 bf4-20020a170907098400b0077f4d959e2fmr9381635ejc.176.1663975229350; Fri, 23
 Sep 2022 16:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAP01T752ZOX68V0hnCDAXT0tso7+i0BV0kDbXdvjYHNGM18Y2g@mail.gmail.com>
In-Reply-To: <CAP01T752ZOX68V0hnCDAXT0tso7+i0BV0kDbXdvjYHNGM18Y2g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 16:20:18 -0700
Message-ID: <CAEf4BzZ1xxoibbdZ1c3cvv_E7y0T8UASoH4W=XiSfEJ5VZstQg@mail.gmail.com>
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

On Fri, Sep 23, 2022 at 3:32 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Hi,
> For the following example:
>
> kkd@Legion ~/src/linux
>  ; cat bpf.c
> #define tag __attribute__((btf_decl_tag("tag")))
>
> int a tag;
> int b tag;
>
> int main() {
>         return a + b;
> }
>
> --
>
> When I compile using:
> clang -target bpf -O2 -g -c bpf.c
>
> For the BTF dump, I see:
> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] FUNC 'main' type_id=1 linkage=global
> [4] VAR 'a' type_id=2, linkage=global
> [5] DECL_TAG 'tag' type_id=4 component_idx=-1
> [6] VAR 'b' type_id=2, linkage=global
> [7] DECL_TAG 'tag' type_id=6 component_idx=-1
> [8] DATASEC '.bss' size=0 vlen=2
>         type_id=4 offset=0 size=4 (VAR 'a')
>         type_id=6 offset=0 size=4 (VAR 'b')
>
> There are two issues that I hit:
>
> 1. The component_idx=-1 makes it a little inconvenient to correlate
> the tag applied to a VAR in a DATASEC. In case of structs the index
> can be matched with component_idx, in case of DATASEC we have to match
> VAR's type_id. So the code has to be different. If it also had
> component_idx set it would be possible to make the code same for both
> inside the kernel's field parsing routine.

This is expected and documented in UAPI:

  "If component_idx == -1, the tag is applied to a struct, union,
variable or function."

Variable is an independent entity and tag applies to it. I don't
know/remember why we did it this way, but it's probably easier for
Clang to generate it this way. And it probably is easier for BPF
static linker as well. Note that you don't merge two structs together,
while static linker does merge variables between DATASECs.

In short, DATASEC+VAR is sufficiently different from STRUCT+fields, so
is treated differently.

>
> 2. The second issue is that the offset is always 0 for DATASEC VARs.
> That makes it difficult to ensure proper alignment of the variables.

That's also expected (even if unfortunate) behavior of Clang. Good
news is that libbpf's static linker API is normalizing this. Libbpf
itself also normalizes it internally if passed .bpf.o file straight
from Clang's output.

In short, if you run `bpftool gen object my_normalized.bpf.o
my_clang.bpf.o` you'll get offsets in my_normalized.bpf.o's BTF.

>
> I would like to know if these are expected behaviors or bugs?

Features ;)

> Thanks
> --
>  ; clang --version
> Ubuntu clang version
> 16.0.0-++20220813052912+eaf0aa1f1fbd-1~exp1~20220813173018.344
