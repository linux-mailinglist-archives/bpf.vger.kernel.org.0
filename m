Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF7604E03
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJSRBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiJSRBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 13:01:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CE18D828
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 10:01:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A2B6A5C00C9;
        Wed, 19 Oct 2022 13:01:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 19 Oct 2022 13:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dotat.at; h=cc
        :cc:content-id:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1666198898; x=1666285298; bh=PP
        JPxXmzqatNs+C3loQjRJLa5ZEHiL5Io2kUn5Ys/gQ=; b=T1RVU/8U8UXZfHn2XP
        LF7py10tAD77VEFFJQ+J3E6bAAiEXvuLCqtQNdsb1AncnVfz2jwU54hk9kYR9tCN
        S90ngWW6yywTiV3T+5RmOmYo9eMUDBilMCP8oRCpZvwbyYlFctnhC17WZqo72t4r
        dkUvJJiNA1dlve+duA+YrnpSomsyaNBTsj3cz4e25kaBFZsn9xl7OZUHnwYxO9c0
        QOPeVGg6znYs1UsqVzAMt06PA9fGFRN1RkqBL9Rbi5ebXabFX4APKUvOAqTjecEX
        XRTNtsJWjWF7IxLK1vtNiS9qqTbHDkzg7mr+cOxob/tDKUfYoz7gL6Ixk3rfBvwR
        zKYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-id:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666198898; x=1666285298; bh=PPJPxXmzqatNs
        +C3loQjRJLa5ZEHiL5Io2kUn5Ys/gQ=; b=muiu7E91//rxgKtmh0NzYfXoWl09h
        8ZPciQqcpBrtubVbjwAQeAnM5pkpai0G1/Ae+vnSVk4aa/8En6els4gD5lLl52jK
        Y86n9RURJ3MqlgW+WAExMbs1ebdbuvyX15dVzOU/Ciul63lcH8j5AgPYSRPml3He
        7vz4Y0NsMuxtSV6aYUuw0llMfCjpbIQI49asK46zhNLoYKqrVLTw/Riq115JJRh9
        qfRdD0iNFMaoppbU1k+kD1Tn96kytuOmaC1HDGyyosDu7q36m6Y6kyAvI7P/saQS
        rsTN8X1OwJX0Mnj61mLUNXBLtKDf3TbUU062SBdoXm8ncqbumnG04typQ==
X-ME-Sender: <xms:cC1QYxEsQafwDs6KlVw_EswlydyJph1gHUz32Mg9z16VnReDIMJJ-w>
    <xme:cC1QY2Ul-Wl1IM8U6UzdNEAwJRGelXHfiEl7waVjfYOlsD6Tz3m_nyAcb0peA_W2w
    n39FMmU6ac1uvs>
X-ME-Received: <xmr:cC1QYzICKv3rZiaDSvgb9--9L44aC7FzTH73rbk7cfUwPDMZTtdvPfnKPJi8fN0dNe2ly9DGbAgdN7mmelH6NAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhepvfhonhih
    ucfhihhntghhuceoughothesughothgrthdrrghtqeenucggtffrrghtthgvrhhnpeduje
    ehieeuheelgeeuhfeiudehffejfeefgfelffegueegheeuteeltedvueekfeenucffohhm
    rghinhepughothgrthdrrghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepughothesughothgrthdrrght
X-ME-Proxy: <xmx:cC1QY3FH1y_sb1rRGBs_hJcnC2t6jRS3UDw9DHQ6XFQdXQBA0A0XCA>
    <xmx:cC1QY3W1SN9X_LZSYXuW6P-xGuovj8gNQM2EuLVVROy3xfmGIT3TUw>
    <xmx:cC1QYyP9vqOyNMfkggrVf3r2DpDo9DyYpuBLA7H3H8RoGhuE1x80uw>
    <xmx:ci1QYwX6ccAir7ZrMoaL65NbkRFWDewQZlm2aj2YIXgLnT4B8mhvew>
Feedback-ID: i7158435c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Oct 2022 13:01:34 -0400 (EDT)
Date:   Wed, 19 Oct 2022 18:01:31 +0100
From:   Tony Finch <dot@dotat.at>
To:     Hou Tao <houtao@huaweicloud.com>
cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
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
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr
 key
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
Message-ID: <a4eaa33b-016e-b880-cfe6-16ccef7d2141@dotat.at>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <fbc79686-8d4e-b397-4748-e78971506f84@cb4.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello all,

I have just found out about this qp-trie work, and I'm pleased to hear
that it is looking promising for you!

I have a few very broad observations:

The "q" in qp-trie doesn't have to stand for "quadbit". There's a tradeoff
between branch factor, maximum key length, and size of branch node. The
greater the branch factor, the fewer indirections needed to traverse the
tree; but if you go too wide then prefetching is less effective and branch
nodes get bigger. I found that 5 bits was the sweet spot (32 wide bitmap,
30ish bit key length) - indexing 5 bit mouthfuls out of the key is HORRID
but it was measurably faster than 4 bits. 6 bits (64 bits of bitmap) grew
nodes from 16 bytes to 24 bytes, and it ended up slower.

Your interior nodes are much bigger than mine, so you might find the
tradeoff is different. I encourage you to try it out.

I saw there has been some discussion about locking and RCU. My current
project is integrating a qp-trie into BIND, with the aim of replacing its
old red-black tree for searching DNS records. It's based on a concurrent
qp-trie that I prototyped in NSD (a smaller and simpler DNS server than
BIND). My strategy is based on a custom allocator for interior nodes. This
has two main effects:

  * Node references are now 32 bit indexes into the allocator's pool,
    instead of 64 bit pointers; nodes are 12 bytes instead of 16 bytes.

  * The allocator supports copy-on-write and safe memory reclamation with
    a fairly small overhead, 3 x 32 bit counters per memory chunk (each
    chunk is roughly page sized).

I wrote some notes when the design was new, but things have changed since
then.

https://dotat.at/@/2021-06-23-page-based-gc-for-qp-trie-rcu.html

For memory reclamation the interior nodes get moved / compacted. It's a
kind of garbage collector, but easy-mode because the per-chunk counters
accurately indicate when compaction is worthwhile. I've written some notes
on my several failed GC experiments; the last / current attempt seems (by
and large) good enough.

https://dotat.at/@/2022-06-22-compact-qp.html

For exterior / leaf nodes, I'm using atomic refcounts to know when they
can be reclaimed. The caller is responsible for COWing its leaves when
necessary.

Updates to the tree are transactional in style, and do not block readers:
a single writer gets the write mutex, makes whatever changes it needs
(copying as required), then commits by flipping the tree's root. After a
commit it can free unused chunks. (Compaction can be part of an update
transaction or a transaction of its own.)

I'm currently using a reader-writer lock for the tree root, but I designed
it with liburcu in mind, while trying to keep things simple.

This strategy is very heavily biased in favour of readers, which suits DNS
servers. I don't know enough about BPF to have any idea what kind of
update traffic you need to support.

At the moment I am reworking and simplifying my transaction and
reclamation code and it's all very broken. I guess this isn't the best
possible time to compare notes on qp-trie variants, but I'm happy to hear
from others who have code and ideas to share.

-- 
Tony Finch  <dot@dotat.at>  https://dotat.at/
Mull of Kintyre to Ardnamurchan Point: East or southeast 4 to 6,
increasing 6 to gale 8 for a time. Smooth or slight in eastern
shelter, otherwise slight or moderate. Rain or showers. Good,
occasionally poor.
