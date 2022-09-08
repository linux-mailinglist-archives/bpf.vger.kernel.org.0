Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D85B1213
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 03:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIHBWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIHBWq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 21:22:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EAE1BE93
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 18:22:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C26185C00EC;
        Wed,  7 Sep 2022 21:22:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 07 Sep 2022 21:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662600164; x=
        1662686564; bh=FRWrW29Upy1b3Zc5/YEfebo6fuR1KQDcK/Lhp88WY0A=; b=a
        N4PcQq1MH+hoKQa9jDOolQqUwW1+b9Oh4bUSiNY7gaBa+gc6iKwindwQAhrq7xNv
        n+tdUGyv1kf7sSNkYP4qlfTimj64nClmlX1En5BmyNmzRzZjEew3HCXQ9mi8mq5F
        DmXLjGGIi6cjTa+Tsupes3QYAsU6lgGLzhqTqw+CDBkugjgHbwqViUAeYy0wA8K7
        36PIYT/ZuybsxojWUbw33Hje9HzxvwHXWmAxFNWSe0GoL5WTfkl92/f64RXhD4b2
        xiyDn6NiGMRM1pyj55u7I0WX5OnHVoRYhmEaI9ZQfvPnFe+12OJBauZjUyXUEFtM
        mPrnf1MzU/+SACIz2Gdzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662600164; x=
        1662686564; bh=FRWrW29Upy1b3Zc5/YEfebo6fuR1KQDcK/Lhp88WY0A=; b=u
        VjfGS4ejWjGbdgsYEjXurzoHDo3vnZthAdQC4ZJBSmhZY3iOq9TKmslxFHh6ZvPl
        yNUmZ7LQfD5pKYmcJtrFEW9hA4ZTgLhazoFSWsTKaiLYUpgjPkuc6h79k2r98gXX
        DNaz0uzOxI4dYBgECzL9NdGI1yZdP9KNI0Jp5W2+NDibSnElwIsTfQZovzVayQDl
        M4gWTyOylMWpnH7eGHe8oWbxgO+P5CsL+9Ls1ptCurwZXu+OOjzOwxnJyYeEtxlY
        V34xklwT+7HTWBuoHpJiP9/IpOjkkLBvLmV1o0Dfu16/MY/XbHd6XV7GbZwMMjBY
        E4JByrw2SJcIU5N/bssTA==
X-ME-Sender: <xms:40MZY7dn4rNOhYwV8hoeVKg8cX5Zy-czKv-RWs1tBT6LiznPvOxG6g>
    <xme:40MZYxOvPpfBFXnzkjrhFxXl2PuD7fnVULKrwqRnda7S-9pMruU6VscTJ3CGRyRrM
    xIdmvgzo-Dvbj9Atg>
X-ME-Received: <xmr:40MZY0j1343eUgCS7chJ_vxFScdI4X7kdeBVyFiuVzmopCae4z-J91USAHf0omficgDescul6OXW7kgp2iCkxxSbT4yFDweNLluH06E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnegfrhhlucfvnfffucdludejmdenucfj
    ughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepffgrnhhivg
    hlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeetveet
    vddvteefteetvedvveeggfefueegvdejfeeifedtjeeutdetvdevffetgeenucffohhmrg
    hinheplhhptgdrvghvvghnthhspdhgihhthhhusgdrihhonecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:5EMZY8-L_XG3BHshLledq26IjR1hgdGvm4lULA-JI_Iu5N4gq8vW4A>
    <xmx:5EMZY3tFqPUxGEsIk4wqSAlnWydCt8r1Gw7mbTdF9dXr_VpB5qQgXg>
    <xmx:5EMZY7GzXP8Vl7nxjr_B5DLP08XImUZvNspp4tnOlmwldPUsFWungA>
    <xmx:5EMZY1I-WQNVE1nAeX4GpjVbRw8-GSVohavP9QEErA0_86bdyoXfLQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 21:22:43 -0400 (EDT)
Date:   Wed, 7 Sep 2022 19:22:41 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martynas Pumputis <m@lambda.lt>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Eric Torng <torng@msu.edu>
Subject: Re: [RFC PATCH] bpf: introduce new bpf map type BPF_MAP_TYPE_WILDCARD
Message-ID: <20220908012241.bbqy2m2sky3vx5vs@kashmir.localdomain>
References: <20220907080140.290413-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220907080140.290413-1-aspsk@isovalent.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Anton,

On Wed, Sep 07, 2022 at 10:01:40AM +0200, Anton Protopopov wrote:
> Add a new map, BPF_MAP_TYPE_WILDCARD, which provides means to implement generic
> online packet classification. Here "online" stands for "fast lookups and fast
> updates", and "generic" means that a user can create maps with custom lookup
> schemes—different numbers of fields and different interpretation of individual
> fields (prefix bitmasks, ranges, and direct matches).
> 
> In particular, in Cilium we have several use cases for such a map:
> 
>   * XDP Prefilter is a simple XDP-based DDoS mitigation system provided by
>     Cilium. At the moment it only supports filtering by source CIDRs. It would
>     benefit from using this new map, as it allows to utilize wildcard rules
>     without big penalty comparing to one hash or LPM lookup utilized now.
> 
>   * XDP Packet Recorder (see https://lpc.events/event/11/contributions/953/)
> 
>   * K8S and Cilium Network Policies: as of k8s 1.25 port ranges are considered
>     to be a stable feature, and this map allows to implement this easily (and
>     also to provide more sophisticated filtering for Cilium Network Policies)
> 
> Keys for wildcard maps are defined using the struct wildcard_key structure.
> Besides the type field, it contains the data field of an arbitrary size. To
> educate map about what's contained inside the data field, two additional
> structures are used. The first one, struct wildcard_desc, also of arbitrary
> size, tells how many fields are contained inside data, and the struct
> wildcard_rule_desc structure defines how individual fields look like.
> 
> Fields (rules) can be of three types: BPF_WILDCARD_RULE_{PREFIX,RANGE,MATCH}.
> The PREFIX rule means that inside data we have a binary value and a binary
> (prefix) mask:
> 
>                size             u32
>         <----------------> <----------->
>    ... |    rule value    |   prefix   | ...
> 
> Here rule value is a binary value, e.g., 123.324.128.0, and prefix is a u32 bit
> variable; we only use lower 8 bits of it. We allow 8, 16, 32, 64, and 128 bit
> values for PREFIX rules.
> 
> The RANGE rule is determined by two binary values: minimum and maximum, treated
> as unsigned integers of appropriate size:
> 
>                size               size
>         <----------------> <---------------->
>    ... |  min rule value  |  max rule value  | ...
> 
> We only allow the 8, 16, 32, and 64-bit for RANGE rules.
> 
> The MATCH rule is determined by one binary value, and is basically the same as
> (X,sizeof(X)*8) PREFIX rule, but can be processed a bit faster:
> 
>                size
>         <---------------->
>    ... |    rule value    | ...
> 
> To speed up processing all the rules, including the prefix field, should be
> stored in host byte order, and all elements in network byte order. 16-byte
> fields are stored as {lo,hi}—lower eight bytes, then higher eight bytes.
> 
> For elements only values are stored.
> 
> To simplify definition of key structures, the BPF_WILDCARD_DESC_{1,2,3,4,5}
> macros should be used. For example, one can define an IPv4 4-tuple keys as
> follows:
> 
>    BPF_WILDCARD_DESC_4(
>         capture4_wcard,
>         BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
>         BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
>         BPF_WILDCARD_RULE_RANGE, __u16, sport,
>         BPF_WILDCARD_RULE_RANGE, __u16, dport
>    );
> 
> This macro will define the following structure:
> 
>    struct capture4_wcard_key {
>         __u32 type;
>         __u32 priority;
>         union {
>             struct {
>                     __u32 saddr;
>                     __u32 saddr_prefix;
>                     __u32 daddr;
>                     __u32 daddr_prefix;
>                     __u16 sport_min;
>                     __u16 sport_max;
>                     __u16 dport_min;
>                     __u16 dport_max;
>             } __packed rule;
>             struct {
>                     __u32 saddr;
>                     __u32 daddr;
>                     __u16 sport;
>                     __u16 dport;
>             } __packed;
>         };
>    } __packed;
> 
> Here type field should contain either BPF_WILDCARD_KEY_RULE or
> BPF_WILDCARD_KEY_ELEM so that kernel can differentiate between rules and
> elements. The rule structure is used to define (and lookup) rules, the unnamed
> structure can be used to specify elements when matching them with rules.
> 
> In order to simplify definition of a corresponding struct wildcard_desc, the
> BPF_WILDCARD_DESC_* macros will create yet another structure:
> 
>    struct capture4_wcard_desc {
>         __uint(n_rules, 4);
>         struct {
>                 __uint(type, BPF_WILDCARD_RULE_PREFIX);
>                 __uint(size, sizeof(__u32));
>         } saddr;
>         struct {
>                 __uint(type, BPF_WILDCARD_RULE_PREFIX);
>                 __uint(size, sizeof(__u32));
>         } daddr;
>         struct {
>                 __uint(type, BPF_WILDCARD_RULE_RANGE);
>                 __uint(size, sizeof(__u16));
>         } sport;
>         struct {
>                 __uint(type, BPF_WILDCARD_RULE_RANGE);
>                 __uint(size, sizeof(__u16));
>         } dport;
>    };
> 
> This structure can be used in a (BTF) map definition as follows:
> 
>     __type(wildcard_desc, struct capture4_wcard_desc);
> 
> Then libbpf will create a corresponding struct wildcard_desc and pass it to
> kernel in bpf_attr using new map_extra_data/map_extra_data_size fields.
> 
> The map implementation allows users to specify which algorithm to use to store
> rules and lookup packets. Currently, three algorithms are supported:
> 
>   * Brute Force (suitable for map sizes of about 32 or below elements)
> 
>   * Tuple Merge (a variant of the Tuple Merge algorithm described in the
>     "TupleMerge: Fast Software Packet Processing for Online Packet
>     Classification" white paper, see https://nonsns.github.io/paper/rossi19ton.pdf.
>     The Tuple Merge algorithm is not protected by any patents.)
> 
>   * Static Tuple Merge (a variant of Tuple Merge where a set of lookup tables
>     is directly provided by a user)
> 
> To select a specific algorithm one should set a flag in the map_extra field,
> see examples below.
> 
> Example 1. The following defines a brute force map to match IPv4
> source/destination CIDRs:
> 
>     BPF_WILDCARD_DESC_2(
>             capture4_l3,
>             BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
>             BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
>     );
> 
>     struct {
>             __uint(type, BPF_MAP_TYPE_WILDCARD);
>             __type(key, struct capture4_l3_key);
>             __type(value, __u64);
>             __uint(max_entries, 16);
>             __uint(map_flags, BPF_F_NO_PREALLOC);
>             __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_BF);
>             __type(wildcard_desc, struct capture4_l3_desc);
>     } filter_v4_bf __section(".maps");
> 
> Example 2. The only change requred for the previous example to use Tuple Merge
> is to select a different algorithm:
> 
>     struct {
>             __uint(type, BPF_MAP_TYPE_WILDCARD);
>             __type(key, struct capture4_l3_key);
>             __type(value, __u64);
>             __uint(max_entries, 16);
>             __uint(map_flags, BPF_F_NO_PREALLOC);
>             __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_TM);
>             __type(wildcard_desc, struct capture4_l3_desc);
>     } filter_v4_tm __section(".maps");
> 
> Example 3. Let's update the previous example to use Static Tuple Merge:
> 
>     BPF_WILDCARD_TM_OPTS(
>             capture4_l3,
>             BPF_WILDCARD_TM_TABLES_3(saddr, 16, 0, 16);
>             BPF_WILDCARD_TM_TABLES_3(daddr, 16, 16, 0);
>     );
> 
>     struct {
>             __uint(type, BPF_MAP_TYPE_WILDCARD);
>             __type(key, struct capture4_l3_key);
>             __type(value, __u64);
>             __uint(max_entries, 100000);
>             __uint(map_flags, BPF_F_NO_PREALLOC);
>             __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_TM |
>                               BPF_WILDCARD_F_TM_STATIC_POOL |
>                               BPF_WILDCARD_F_TM_POOL_LIST);
>             __type(wildcard_tm_opts, struct capture4_l3_opts);
>     } filter_v4_bf __section(".maps");
> 
> Here we set new flags to specify that a pool of tables should be used to select
> new tables from (BPF_WILDCARD_F_TM_STATIC_POOL), and that the field
> wildcard_tm_opts contains a list of tables to use (BPF_WILDCARD_F_TM_POOL_LIST,
> an alternative is to use a Cartesian product of arrays provided). The
> capture4_l3_opts is defined by a helper macro BPF_WILDCARD_TM_OPTS, where for
> each field we define a list of prefixes to use.  If a field is missing, then it
> will be always ignored.
> 
> The following changes and are not part of this RFC, but planned to be added before v1:
> 
>   * implement priorities, i.e., users will be able to specify rule priority as
>     u32 and rules with lower priorities will be matched first
> 
>   * implement !BPF_F_NO_PREALLOC: right now we always kalloc both elements and
>     new tables
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/linux/bpf_types.h       |    1 +
>  include/uapi/linux/bpf.h        |  127 +++
>  kernel/bpf/Makefile             |    2 +-
>  kernel/bpf/syscall.c            |   51 +-
>  kernel/bpf/wildcard.c           | 1526 +++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h  |  129 ++-
>  tools/lib/bpf/bpf.c             |    8 +
>  tools/lib/bpf/bpf.h             |    5 +-
>  tools/lib/bpf/libbpf.c          |  423 +++++++++
>  tools/lib/bpf/libbpf_internal.h |    5 +-
>  10 files changed, 2269 insertions(+), 8 deletions(-)
>  create mode 100644 kernel/bpf/wildcard.c
> 

I'm interested in the goal of your patch but I'm having a grokking how
the map is actually used.

Is there any chance you could include a selftest or example?

Thanks,
Daniel

[...]
