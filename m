Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36B9633365
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKVCgk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKVCgj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:36:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E6BC4B50
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:36:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1686DCE1AFB
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48638C433D7
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669084595;
        bh=4HRkze2p1dS+fcP8t8HSF/4QK8O7VUQBHu+nh1jzLUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iRntpO6J+p2JwdqCr3cd/wbLuB9QKSCVQ1ZlGbfoi5GGyd2j2omaeIxXtcME729eR
         URBXOcxLCpC2GmBnx1JIy54UYmtQD9P+gmMYTw1wqgf+iBfQqzyb47lVCn08fHNO6+
         o3NAPd07Wq18hYbtO+wA6FXBllPGFVaC07BAy0LEOINf436JJ7c5ulr4EgEqysbbZ1
         PXC0QFa+hQvOzXvcBCwUNOxuimUYbqOdAqnnaOEcskMOi1euo2/OO8cY3AXBOxRGdt
         Iyf1+ihH8tYlbKaJC+8zIkeDhAAJooMzWsoFQ2U0sY3kvmZRrBZZUEkitT92IYG0v1
         g4wQHBnAtlSrA==
Received: by mail-ed1-f46.google.com with SMTP id v8so7754913edi.3
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:36:35 -0800 (PST)
X-Gm-Message-State: ANoB5pnhUXAVlaStS5BWeh8rzxI5TAB6BHxqfegtrPjCyV2sHJouKuW7
        da/cT6Z+kZdoiI/Kg+VoeaDUnb6jrCYf30XoD2I=
X-Google-Smtp-Source: AA0mqf5WsFPLU1rP7tNZ8kJ+tQtOPjEJmV5ye9QanQG+tpT/1VWYmaM1RFMIlKJ7VKQ+tjcGyBpXByzqfTCMSsveosE=
X-Received: by 2002:aa7:cd91:0:b0:469:2f36:fd with SMTP id x17-20020aa7cd91000000b004692f3600fdmr4897293edv.385.1669084593490;
 Mon, 21 Nov 2022 18:36:33 -0800 (PST)
MIME-Version: 1.0
References: <Y3vbwMptiNP6aJDh@bombadil.infradead.org> <Y3vdkuR9aeU/k/xX@bombadil.infradead.org>
In-Reply-To: <Y3vdkuR9aeU/k/xX@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Nov 2022 19:36:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ejraDjOq-C2ScUJ+DD73b26V_1YCW8E4S-hXgh=Gt_w@mail.gmail.com>
Message-ID: <CAPhsuW4ejraDjOq-C2ScUJ+DD73b26V_1YCW8E4S-hXgh=Gt_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, rppt@kernel.org, willy@infradead.org,
        dave@stgolabs.net, a.manzanares@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 1:20 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Nov 21, 2022 at 12:12:49PM -0800, Luis Chamberlain wrote:
> > On Thu, Nov 17, 2022 at 12:23:16PM -0800, Song Liu wrote:
> > > Based on our experiments [5], we measured ~0.6% performance improvement
> > > from bpf_prog_pack. This patchset further boosts the improvement to ~0.8%.
> >
> > I'd prefer we leave out arbitrary performance data, as it does not help much.
>
> I'd like to clarify what I mean by this, as Linus has suggested before, you are
> missing the opportunity to present "actual numbers on real loads. (not
> some artificial benchmark)"
>
> [0] https://lkml.kernel.org/r/CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com

Unless I made some serious mistakes, Linus' concern with performance was
addressed by the exact performance results above. [5]

Thanks,
Song

[5] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/
