Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0A621EA6
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 22:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKHVk1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 16:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiKHVkZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 16:40:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A461B80
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 13:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C51B81C96
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 21:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E48C43140
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667943618;
        bh=DG52Qt0X9uCRX4ZMFnlRQ+I0s2VdUOhaMVzB3OcS3is=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IwpsXa1m++OKWum/FHqab2HECstRVHJ3d9f/WLq38YZQhhgNNwXzKYiHucx4RkxvU
         ufNxCSjolRd1BPya53EdgWhXN7ReJJg9BGttma9Yy8Ad51gHn9Gy+Nan6YrhNyA/ge
         7wUFoqE0T4ZzQnQrC0iHZt9ffeBii7LB0gFGZCprbJ/nMdCbsJjniwsQue6RifyHL0
         ECLp3zrEHuuHG+PSuqdlGfsTVUlY2+OX1lmSvWl9hn9Tybb5eQymxk+zoVuKi2Xlum
         LeTKgnL7WhIarVdgyTITHfOywdpG54itAmsqjtws6aMPn2+rlWk+5K+1qf5ripDmKs
         Zom6QKPY20PGw==
Received: by mail-ej1-f54.google.com with SMTP id y14so41981867ejd.9
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 13:40:18 -0800 (PST)
X-Gm-Message-State: ANoB5plsdkPy8wUUmiXyz/rUZ9cl22oA9EK5t53dO5pm8ooovmRgBeFX
        MnM/6/+eAbnVwXe2oFPfwRRBq0lKMK2DcKUYvWs=
X-Google-Smtp-Source: AA0mqf7vWZd1US4JgjryCPXuH+3J1irvG1VGRjt97h/YYupJixqA3kqC6TR1QrcBsLJ//jQPsAGt9UGEfXvqoCgyTew=
X-Received: by 2002:a17:907:2995:b0:7ae:8956:ab56 with SMTP id
 eu21-20020a170907299500b007ae8956ab56mr995385ejc.719.1667943616639; Tue, 08
 Nov 2022 13:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <CAPhsuW7xtUKb7ovjLFDPap-_t1TzPZ0Td+kHparOniZf7cBCSQ@mail.gmail.com> <d0c60ab6-e618-425a-4279-454901a60235@csgroup.eu>
In-Reply-To: <d0c60ab6-e618-425a-4279-454901a60235@csgroup.eu>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Nov 2022 13:40:04 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6w04_zgX=aXFVrXVYX1nnie1KN4oZZBrBNdL32-L1-qg@mail.gmail.com>
Message-ID: <CAPhsuW6w04_zgX=aXFVrXVYX1nnie1KN4oZZBrBNdL32-L1-qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 11:43 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 08/11/2022 =C3=A0 19:41, Song Liu a =C3=A9crit :
> > On Tue, Nov 8, 2022 at 3:27 AM Mike Rapoport <rppt@kernel.org> wrote:
> >>
> >> Hi Song,
> >>
> >> On Mon, Nov 07, 2022 at 02:39:16PM -0800, Song Liu wrote:
> >>> This patchset tries to address the following issues:
> >>>
> >>> 1. Direct map fragmentation
> >>>
> >>> On x86, STRICT_*_RWX requires the direct map of any RO+X memory to be=
 also
> >>> RO+X. These set_memory_* calls cause 1GB page table entries to be spl=
it
> >>> into 2MB and 4kB ones. This fragmentation in direct map results in bi=
gger
> >>> and slower page table, and pressure for both instruction and data TLB=
.
> >>>
> >>> Our previous work in bpf_prog_pack tries to address this issue from B=
PF
> >>> program side. Based on the experiments by Aaron Lu [4], bpf_prog_pack=
 has
> >>> greatly reduced direct map fragmentation from BPF programs.
> >>
> >> Usage of set_memory_* APIs with memory allocated from vmalloc/modules
> >> virtual range does not change the direct map, but only updates the
> >> permissions in vmalloc range. The direct map splits occur in
> >> vm_remove_mappings() when the memory is *freed*.
> >>
> >> That said, both bpf_prog_pack and these patches do reduce the
> >> fragmentation, but this happens because the memory is freed to the sys=
tem
> >> in 2M chunks and there are no splits of 2M pages. Besides, since the s=
ame
> >> 2M page used for many BPF programs there should be way less vfree() ca=
lls.
> >>
> >>> 2. iTLB pressure from BPF program
> >>>
> >>> Dynamic kernel text such as modules and BPF programs (even with curre=
nt
> >>> bpf_prog_pack) use 4kB pages on x86, when the total size of modules a=
nd
> >>> BPF program is big, we can see visible performance drop caused by hig=
h
> >>> iTLB miss rate.
> >>
> >> Like Luis mentioned several times already, it would be nice to see num=
bers.
> >>
> >>> 3. TLB shootdown for short-living BPF programs
> >>>
> >>> Before bpf_prog_pack loading and unloading BPF programs requires glob=
al
> >>> TLB shootdown. This patchset (and bpf_prog_pack) replaces it with a l=
ocal
> >>> TLB flush.
> >>>
> >>> 4. Reduce memory usage by BPF programs (in some cases)
> >>>
> >>> Most BPF programs and various trampolines are small, and they often
> >>> occupies a whole page. From a random server in our fleet, 50% of the
> >>> loaded BPF programs are less than 500 byte in size, and 75% of them a=
re
> >>> less than 2kB in size. Allowing these BPF programs to share 2MB pages
> >>> would yield some memory saving for systems with many BPF programs. Fo=
r
> >>> systems with only small number of BPF programs, this patch may waste =
a
> >>> little memory by allocating one 2MB page, but using only part of it.
> >>
> >> I'm not convinced there are memory savings here. Unless you have hundr=
eds
> >> of BPF programs, most of 2M page will be wasted, won't it?
> >> So for systems that have moderate use of BPF most of the 2M page will =
be
> >> unused, right?
> >
> > There will be some memory waste in such cases. But it will get better w=
ith:
> > 1) With 4/5 and 5/5, BPF programs will share this 2MB page with kernel =
.text
> > section (_stext to _etext);
> > 2) modules, ftrace, kprobe will also share this 2MB page;
> > 3) There are bigger BPF programs in many use cases.
>
> And what I love with this series (for powerpc/32) is that we will likely
> now be able to have bpf, ftrace, kprobe without the performance cost of
> CONFIG_MODULES.

Yeah, I remember reading emails about using tracing tools without
CONFIG_MODULES. We still need more work (beyond this set) to make it
happen for powerpc/32. For example, current powerpc bpf_jit doesn't
support jitting into ROX memory.

Song


>
> Today, CONFIG_MODULES means page mapping, which means handling of kernel
> page in ITLB miss handlers.
>
> By using some of the space between end of rodata and start of inittext,
> we are able to use ROX linear memory which is mapped by blocks. It means
> there is no need to handle kernel text in ITLB handler (You can look at
> https://elixir.bootlin.com/linux/v6.1-rc3/source/arch/powerpc/kernel/head=
_8xx.S#L191
> to better understand what I'm talking about).
>
> Thanks
> Christophe
