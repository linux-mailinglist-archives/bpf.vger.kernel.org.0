Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B34363C660
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 18:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiK2R1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 12:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiK2R1P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 12:27:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95C1C11A
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 09:27:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DE661842
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 17:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8066C433C1
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669742833;
        bh=iid/8vh3EUYIxDWJZP5JTT0Tm2R53NAd0jgrlsysLt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CHnMrLzyUZTrk8KiopgmFxgjd16a/ofzqqYNhgTOZ0wOT3CST29eTVT9MivKAbOG1
         DBgY//ObUdC5L8RCtbFlICdgcBgdSyb+8sHyntupdNt7wDbJ56YOhRoW5LpzszFqUw
         I5uYdjofysBODji2zt2YNOZOK2glMoVvZT7oegtZPKhZL19cuwrQMc8UCnq/cZ8iQh
         PflWUUNIAcWwBQs1E1Bgva8gBtJWqeCp1lAERzECnHyB5SQIOQAMepqydU77ueILZc
         L2F815YH0CaaGSNZeZWZ0/ErOmb9KnUtblfyf4fa0d7Ruc3iaQFXpckYE2q0cVh0fN
         ubXtQidDIO3Og==
Received: by mail-ed1-f45.google.com with SMTP id r26so18643945edc.10
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 09:27:13 -0800 (PST)
X-Gm-Message-State: ANoB5pmWlxOJKVMUV+RNTJWHOAbgvkIip/gZRBuvjjl5r9YwkmjdiexQ
        dF6Amly0FILHR6/2oePjDOJYpkuQDLehHaCuZv4=
X-Google-Smtp-Source: AA0mqf5dCdcR2tfMGRyKt2WnqriIbdenku692I8TWK4kvHn6DPldz13+W5XJOMhYP4ocZfMXGwsuX54wPrM8MB3iAHg=
X-Received: by 2002:a05:6402:240c:b0:462:2c1c:8791 with SMTP id
 t12-20020a056402240c00b004622c1c8791mr39316292eda.29.1669742832053; Tue, 29
 Nov 2022 09:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <87lenuukj0.ffs@tglx>
In-Reply-To: <87lenuukj0.ffs@tglx>
From:   Song Liu <song@kernel.org>
Date:   Tue, 29 Nov 2022 09:26:58 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7BoJbRi7Tqck=cW1n0xdESOkwqU=PMAdL9LvCun47Y+w@mail.gmail.com>
Message-ID: <CAPhsuW7BoJbRi7Tqck=cW1n0xdESOkwqU=PMAdL9LvCun47Y+w@mail.gmail.com>
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

Thanks for your comments.

On Tue, Nov 29, 2022 at 2:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Nov 14 2022 at 17:30, Song Liu wrote:
> > On Mon, Nov 7, 2022 at 2:41 PM Song Liu <song@kernel.org> wrote:
> > Currently, I have got the following action items for v3:
> > 1. Add unify API to allocate text memory to motivation;
> > 2. Update Documentation/x86/x86_64/mm.rst;
> > 3. Allow none PMD_SIZE allocation for powerpc.
> >
> > 1 and 2 are relatively simple. We can probably do 3 in a follow up patch
> > (as I don't have powerpc environments for testing). Did I miss anything?
> >
> > Besides these, does this set look reasonable? Andrew and Peter, could
> > you please share your comments on this?
>
> This is a step into the right direction, but is it a solution which has
> a broader benefit? I don't think so.
>
> While you are so concerned about (i)TLB usage for BPF, I'm way more
> concerned about modules. Just from a random server class workstation:
>
> Total module memory:    12.4609 MB
> Number of 4k PTEs:         3190
>
> The above would nicely fit into 7 or 8 2M mappings.
>
> Guess how much memory is occupied by BPF on that machine and how much
> BPF contributes to iTLB pressure? In comparison to the above very close
> to zero.
>
> Modules have exactly the same problem as BPF, just an order of magnitude
> larger.
>
> So we don't need a "works" for BPF solution which comes with the
> handwaving assumption that it could be used for modules too. We need
> something which demonstrates that it solves the entire problem class.
>
> Modules are the obvious starting point. Once that is solved pretty much
> everything else falls into place including BPF.
>
> Without modules support this whole exercise is pointless and not going
> anywhere near x86.

I am not sure I fully understand your point here. Do you mean

1) There is something wrong with this solution, that makes it not suitable
for modules;
   or
2) The solution is in the right direction and it will very likely work
for modules.
But we haven't finished module support. ?

If it is 1), I would like to understand what are the issues that make it not
suitable for modules. If it is 2), I think a solid, mostly like working small
step toward the right direction is the better way as it makes code reviews
a lot easier and has much lower risks. Does this make sense?

I would also highlight that part of the benefit of this work comes from
reducing direct map fragmentations. While BPF programs consume less
memory, they are more dynamic and can cause more direct map
fragmentations. bpf_prog_pack in upstream kernel already covers this
part, but this set is a better solution than bpf_prog_pack.

Finally, I would like to point out that 5/6 and 6/6 of (v5) the set let BPF
programs share a 2MB page with static kernel text. Therefore, even
for systems without many BPF programs, we should already see some
reduction in iTLB misses.

Thanks,
Song
