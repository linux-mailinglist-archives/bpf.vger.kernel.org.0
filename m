Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A064025F
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 09:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiLBIjp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 03:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiLBIjQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 03:39:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF2FE1
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 00:39:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A7BEB8210D
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 08:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FF7C433D7
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669970339;
        bh=OQj2RdSG+g9kHrqQXz6JdFh2L923aPaG2AapH6vQw7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YzLV3QVbZqzdlPfkxH7ykUAn1NwcnRAUjuZnZV3I/GorFQoParZmxj1kK8sCiUbJn
         flkHMOA/Pv6kpIjn8C/cQkCNdaC5C/YaVFJvzVwdRmK3NKSZlphIhrRcN07F0AvCgV
         Un7XP2z3FyDB6J8G4Z3Qt5IeeAHuI4hJPpiabk8AOrPO/FiGJy74l5pGzbPldPn4XY
         odJ6o9Z5nVWG/Xyl6l72g/xC/iC8pKxcdVxNUsXtDRCSU7fkUMNFC8J4rBphasZFym
         uUlANu7THsScnSR+oHTi3U8ZxQhmwEc7RDojuWdGNxOHeiQ++UhkbXgMpaXIWBdB+1
         g/ltAzBMsfW8w==
Received: by mail-ed1-f52.google.com with SMTP id d14so610992edj.11
        for <bpf@vger.kernel.org>; Fri, 02 Dec 2022 00:38:59 -0800 (PST)
X-Gm-Message-State: ANoB5pnFJZ9l67W6aqxYfyKL9dAWm+clMzF/fpezQzEjoMZLU1SUyCzo
        fJtPEKGOskliTDA1A8wpNH49WBmUZh4M1U3wMkc=
X-Google-Smtp-Source: AA0mqf4JKfe++A3IGRWObi6GLw7nINrk27DN0AaVySi0wIYrJ4mBaSEIOLmHhirCZQcgYKJKCA5aELJXuT/NuO3Gg7o=
X-Received: by 2002:aa7:d496:0:b0:46b:e7c0:9313 with SMTP id
 b22-20020aa7d496000000b0046be7c09313mr6634536edr.412.1669970338011; Fri, 02
 Dec 2022 00:38:58 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx> <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx>
In-Reply-To: <87k03ar3e3.ffs@tglx>
From:   Song Liu <song@kernel.org>
Date:   Fri, 2 Dec 2022 00:38:45 -0800
X-Gmail-Original-Message-ID: <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
Message-ID: <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Thomas,

Thanks for all these suggestions!

On Thu, Dec 1, 2022 at 5:38 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>

[...] (everything snipped here makes perfect sense).

>
> You have to be aware, that the rodata space needs to be page granular
> while text and data can really aggregate below the page alignment, but
> again might have different alignment requirements.

I don't quite follow why rodata space needs to be page granular. If text can
go below page granular, rodata should also do that, no?

>
> So you need a configuration mechanism which allows to specify per type:
>
>    - Initial mapping type (RX, RWX, RW)
>    - Alignment
>    - Granularity
>    - Address space restrictions

[...]

>
> Step 1:
>

These steps are really helpful. Thanks!
[...]
>
> For text that's obviously module_write_text(), but for the [ro]data
> mappings memcpy() is still fine. For the rodata mapping you need
> set_memory_ro() right in the module prepare stage and for the
> ro_after_init_data() you do that after the module init function returns
> success, which is pretty much what the code does today.

I guess this is related to rodata needs to be page granular? But I
don't think I got the idea. Do we allow rodata and rwdata share the
same 2MB page? ro_after_init_data seems trickier.

>
> Step 5:
>
[...]

>
> Linus once said:
>
>   "Bad programmers worry about the code. Good programmers worry about
>    data structures and their relationships."
>
> He's absolutely right. Here is my version of it:
>
>   The order of things to worry about:
>
>       1) Problem analysis
>       2) Concepts
>       3) Data structures and their relationships
>       4) Code
>
>       #1 You need to understand the problem fully to come up with
>          concepts
>
>       #2 Once you understand the problem fully you can talk about
>          concepts to solve it
>
>       #3 Maps the concept to data structures and forms relationships
>
>       #4 Is the logical consequence of #1 + #2 + #3 and because your
>          concept makes sense, the data structures and their
>          relationships are understandable, the code becomes
>          understandable too.
>
>       If any of the steps finds a gap in the previous ones, then you
>       have to go back and solve those first.
>
> Any attempt to reorder the above is putting the cart before the horse
> and a guarantee for failure.

Thanks for these advices! They would help me for many years.

>
> Now go back and carefully read up on what I wrote above and in my
> previous mail.
>
> The previous mail was mostly about #1 to explain the problem as broad as
> possible and an initial stab at #2 suggesting concepts to solve it.
>
> This one is still covering some aspects of #1, but it is mostly about #2
> and more focussed on particular aspects of the concept. If you look at
> it carefully then you find some bits which map to #3 but still at the
> conceptual level.
>
> Did I talk about code or implementation details?
>
> Not at all and I'm not going to do so before #1 and #2 are agreed
> on. The above pseudo code snippets are just for illustration and I used
> them because I was too lazy to write a novel, but they all are still at
> the conceptual level.
>
> Now you can rightfully argue that if you stich those snippets together
> then they form a picture which outlines the implementation, but that's
> the whole purpose of this exercise, right?

I guess I will do my homework, and come back with as much information
as possible for #1 + #2 + #3. Then, we can discuss whether it makes
sense at all.

Does this sound like the right approach?

Thanks,
Song
