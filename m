Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07146100BC
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiJ0SxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiJ0SxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 14:53:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3245C959
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 11:53:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sc25so7242993ejc.12
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gxPWf9T53DPidzg2Zg60KxPnc7jcfJR2RskTbpXHtF4=;
        b=Bpb4uYAKKqThWWUryK201jZTd4dh1C/jc0DvEy2oOTfcp1Po5Oi2dD6Bl2OpBNFFsy
         Evpc1OeMbxxQN1DISlx8sRHXHhUGqqm9cjzYeHPFbmH8sJ9liH2wkLLmw8GIhGFSaQgI
         3N4VXhjJ12A/vFubQmgUv4crdp9pG+Z/qmpeynwPejDF32u2/xOQSnbLCWYxWpmhHON7
         Bri/panG1mjjDQeXEZPTbjmMC1HDbpbPQbOZ8VqGtSR1tNJ4F8nazH7CFBleCl/RomEc
         mFFD+n8q5Msz4w3oICn/v958GwYEQRXadUAEtQlGXpRmFnCtaUsm/cj0HaJ4pdXbPXvI
         hzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxPWf9T53DPidzg2Zg60KxPnc7jcfJR2RskTbpXHtF4=;
        b=DRmJZmgZaFYCZPMNrfnAEFobwm9GPJHWJeaqbkdSrULtG0T3aIODs0i6bsI50JcEIS
         CKhOO47BvRZRNw7UuwM6Ajovt21oFrizmbWJlt/4BuCcMyvLHxLktkyFllQtdwrEM+OG
         oq2rFFeAA02Zkb5xcPFTDj2crxMZDzw283M/yiQxZZ+Yt40QafmZBuS6jcugItmLYWsY
         c/eckr0eRf3Thn4yxTx/aXOOwMsR8CRPFVFC63P/Suy141U+8eNPylJ+Q/rmr+Mz197Q
         naaCwp0FySDzGvU7JCV9U2KpYDk3UZMV6OTJxyvZ3pc9TEUwq/BZE0su41IN2oxL5TZq
         CQLA==
X-Gm-Message-State: ACrzQf0AgIE3djfCjBBl9JbY40uxgyLcZuzNizClnX1nuezgS4n/L3Ld
        IJLOOk78K/mG9oQzhyfqTw+0rL2AVAKjKDPsQdc=
X-Google-Smtp-Source: AMsMyM5dclv60eg0FhxlpKc7tQ/HBSyf8hL1b3fH6o9R1DiSyrOlMDzhw/ggfw3QeKUs1ecWHbK2eXxFTAKPcFBTt6M=
X-Received: by 2002:a17:907:75e6:b0:7a1:848:20cb with SMTP id
 jz6-20020a17090775e600b007a1084820cbmr26278525ejc.745.1666896786306; Thu, 27
 Oct 2022 11:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com> <a4eaa33b-016e-b880-cfe6-16ccef7d2141@dotat.at>
In-Reply-To: <a4eaa33b-016e-b880-cfe6-16ccef7d2141@dotat.at>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 11:52:54 -0700
Message-ID: <CAEf4Bzaj_fUp7z=pERqX5rXrDVSORSXn3m64KKs78MoNy2jNPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Tony Finch <dot@dotat.at>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
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

On Wed, Oct 19, 2022 at 10:01 AM Tony Finch <dot@dotat.at> wrote:
>
> Hello all,
>
> I have just found out about this qp-trie work, and I'm pleased to hear
> that it is looking promising for you!
>

This is a very nice data structure, so thank you for doing a great job
explaining it in your post!

> I have a few very broad observations:
>
> The "q" in qp-trie doesn't have to stand for "quadbit". There's a tradeoff
> between branch factor, maximum key length, and size of branch node. The
> greater the branch factor, the fewer indirections needed to traverse the
> tree; but if you go too wide then prefetching is less effective and branch
> nodes get bigger. I found that 5 bits was the sweet spot (32 wide bitmap,
> 30ish bit key length) - indexing 5 bit mouthfuls out of the key is HORRID
> but it was measurably faster than 4 bits. 6 bits (64 bits of bitmap) grew
> nodes from 16 bytes to 24 bytes, and it ended up slower.
>
> Your interior nodes are much bigger than mine, so you might find the
> tradeoff is different. I encourage you to try it out.

True, but I think for (at least initial) simplicity, sticking to
half-bytes would simplify the code and let us figure out BPF and
kernel-specific issues without having to worry about the correctness
of the qp-trie core logic itself.

>
> I saw there has been some discussion about locking and RCU. My current
> project is integrating a qp-trie into BIND, with the aim of replacing its
> old red-black tree for searching DNS records. It's based on a concurrent
> qp-trie that I prototyped in NSD (a smaller and simpler DNS server than
> BIND). My strategy is based on a custom allocator for interior nodes. This
> has two main effects:
>
>   * Node references are now 32 bit indexes into the allocator's pool,
>     instead of 64 bit pointers; nodes are 12 bytes instead of 16 bytes.
>
>   * The allocator supports copy-on-write and safe memory reclamation with
>     a fairly small overhead, 3 x 32 bit counters per memory chunk (each
>     chunk is roughly page sized).
>
> I wrote some notes when the design was new, but things have changed since
> then.
>
> https://dotat.at/@/2021-06-23-page-based-gc-for-qp-trie-rcu.html
>
> For memory reclamation the interior nodes get moved / compacted. It's a
> kind of garbage collector, but easy-mode because the per-chunk counters
> accurately indicate when compaction is worthwhile. I've written some notes
> on my several failed GC experiments; the last / current attempt seems (by
> and large) good enough.
>
> https://dotat.at/@/2022-06-22-compact-qp.html
>
> For exterior / leaf nodes, I'm using atomic refcounts to know when they
> can be reclaimed. The caller is responsible for COWing its leaves when
> necessary.
>
> Updates to the tree are transactional in style, and do not block readers:
> a single writer gets the write mutex, makes whatever changes it needs
> (copying as required), then commits by flipping the tree's root. After a
> commit it can free unused chunks. (Compaction can be part of an update
> transaction or a transaction of its own.)
>
> I'm currently using a reader-writer lock for the tree root, but I designed
> it with liburcu in mind, while trying to keep things simple.
>
> This strategy is very heavily biased in favour of readers, which suits DNS
> servers. I don't know enough about BPF to have any idea what kind of
> update traffic you need to support.

These are some nice ideas, I did a quick read on your latest blog
posts, missed those updates since last time I checked your blog.

One limitation that we have in the BPF world is that BPF programs can
be run in extremely restrictive contexts (e.g., NMI), in which things
that user-space can assume will almost always succeed (like memory
allocation), are not allowed. We do have BPF-specific memory
allocator, but even it can fail to allocate memory, depending on
allocation patterns. So we need to think if this COW approach is
acceptable. I'd love for Hou Tao to think about this and chime in,
though, as he spent a lot of time thinking about particulars.

But very basically, ultimate memory and performance savings are
perhaps less important in trying to fit qp-trie into BPF framework. We
can iterate after with optimizations and improvements, but first we
need to get the things correct and well-behaved.

>
> At the moment I am reworking and simplifying my transaction and
> reclamation code and it's all very broken. I guess this isn't the best
> possible time to compare notes on qp-trie variants, but I'm happy to hear
> from others who have code and ideas to share.

It would be great if you can lend your expertise in reviewing at least
generic qp-trie parts, but also in helping to figure out the overall
concurrency approach we can take in kernel/BPF land (depending on your
familiarity with kernel specifics, of course).

Thanks for offering the latest on qp-trie, exciting to see more
production applications of qp-trie and that you are still actively
working on this!

>
> --
> Tony Finch  <dot@dotat.at>  https://dotat.at/
> Mull of Kintyre to Ardnamurchan Point: East or southeast 4 to 6,
> increasing 6 to gale 8 for a time. Smooth or slight in eastern
> shelter, otherwise slight or moderate. Rain or showers. Good,
> occasionally poor.
