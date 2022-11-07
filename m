Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DDF61FD95
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 19:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiKGSaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 13:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiKGSaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 13:30:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA571A05B
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 10:30:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B702161252
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 18:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2425FC43146
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667845814;
        bh=o/YCtXWPnRRvkfEvLC2RGV2wHGxZZXcfgU1DXVdalWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KmvozpLhtG5nUW3KxXmhv7tluTCkwfWoTLpkHaH7+J7xeTZSp9Nf6Y6cjQtRrJGxZ
         b8sM/q//O+/yVdqr9mzbh1bh2c35ik/dRIjCRvw3LLhBT5YUOtwClt7hEB7GXuoLT9
         jtcy/O1FJsI1Uw19T61/n8W8gFPic402kjjnr+BeK4DKpD7Q9glUlRD6+v2jH7nFFV
         UvHxUskRoghYeNT6yzw5AGItKcwtYU0ciBHjgKfVVYrpB2MpjRP8TDGyhj4XM+J0j6
         mRQ900WDNCq3XlA1kY3zeqTXD/57x+T/A5c+jHq49OeGO0HOyJaW219sEaVnWtgzOX
         Ha1HkLe2VjYmQ==
Received: by mail-ed1-f50.google.com with SMTP id a5so18948412edb.11
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 10:30:14 -0800 (PST)
X-Gm-Message-State: ACrzQf1yiphiIoL44MP8Leb4ROm39Gn8q9YzSC4aTwz4Muf9ybFx2evm
        Hi2UxTT2nmbw59EcSehfJwtlYow79qn1lxmbQyw=
X-Google-Smtp-Source: AMsMyM6yvL8EBv5HsTSCgTpShLlvGOhe/tgzzJvjhG/rTtLgMeXubj2JsRZW3Ni6upqc/ZiFV+/K7g2Gh43dnSYJbss=
X-Received: by 2002:aa7:d710:0:b0:463:bd7b:2b44 with SMTP id
 t16-20020aa7d710000000b00463bd7b2b44mr35604880edq.385.1667845812235; Mon, 07
 Nov 2022 10:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20221031222541.1773452-1-song@kernel.org> <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org> <Y2ioTodn+mBXdIqp@ziqianlu-desk2>
In-Reply-To: <Y2ioTodn+mBXdIqp@ziqianlu-desk2>
From:   Song Liu <song@kernel.org>
Date:   Mon, 7 Nov 2022 10:30:00 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5E4L-wJXyfDfZzkSXdyo7DKKRdg0aHvJQYL+zNKeH+yg@mail.gmail.com>
Message-ID: <CAPhsuW5E4L-wJXyfDfZzkSXdyo7DKKRdg0aHvJQYL+zNKeH+yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, rppt@kernel.org,
        zhengjun.xing@linux.intel.com, kbusch@kernel.org,
        p.raghav@samsung.com, dave@stgolabs.net, vbabka@suse.cz,
        mgorman@suse.de, willy@infradead.org,
        torvalds@linux-foundation.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Aaron,

On Sun, Nov 6, 2022 at 10:40 PM Aaron Lu <aaron.lu@intel.com> wrote:
>
[...]
> > and that I think is the real golden nugget here.
>
> I'm interested in how this patchset (further) improves direct map
> fragmentation so would like to evaluate it to see if my previous work to
> merge small mappings back in architecture layer[1] is still necessary.
>
> I tried to apply this patchset on v6.1-rc3/2/1 and v6.0 but all failed,
> so I took one step back and evaluated the existing bpf_prog_pack. I'm
> aware of this patchset would make things even better by using order-9
> page to backup the vmalloced range.

The patchset was based on bpf-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/

>
> I used the sample bpf prog: sample/bpf/sockex1 because it looks easy to
> run, feel free to let me know a better way to evaluate this.
>
> - In kernels before bpf_prog_pack(v5.17 and earlier), this prog would
> cause 3 pages to change protection to RO+X from RW+NX; And if the three
> pages are far apart, each would cause a level 3 split then a level 2
> split; Reality is, allocated pages tend to stay close physically so
> actual result will not be this bad.
[...]
>
> - v6.1-rc3
> There is no difference because I can't trigger another pack alloc before
> system is OOMed.
>
> Conclusion: I think bpf_prog_pack is very good at reducing direct map
> fragmentation and this patchset can further improve this situation on
> large machines(with huge amount of memory) or with more large bpf progs
> loaded etc.

Thanks a lot for these experiments! I will include the data in the next
version of the set.

>
> Some imperfect things I can think of are(not related to this patchset):
> 1 Once a split happened, it remains happened. This may not be a big deal
> now with bpf_prog_pack and this patchset because the need to allocate a
> new order-9 page and thus cause a potential split should happen much much
> less;

I think we will need to regroup the direct map for some scenarios. But I
am not aware of such workloads.

> 2 When a new order-9 page has to be allocated, there is no way to tell
> the allocator to allocate this order-9 page from an already splitted PUD
> range to avoid another PUD mapping split;

This would be a good improvement.

> 3 As Mike and others have mentioned, there are other users that can also
> cause direct map split.

Thanks,
Song
