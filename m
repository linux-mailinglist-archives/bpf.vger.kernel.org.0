Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104EA5B162D
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIHIDW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIHIDV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 04:03:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031F4CEB33
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 01:03:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m1so23111580edb.7
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=q5FjlxjJJSlG9e6HSbQz2R73ZeE8ouGWflFVUN4rOd4=;
        b=BjAhIeBe/svWmtiGVfr86PeD7ccvPVHkRcqGXT8fZUGoiZbb7tVRrLUSz4vFs6vAMg
         vWOw3Z7/Fh6v3XdNtmR2x5IZwQXW+L2iW+bo+I5F+mm/d/+fczHVaz2ppvr5v21RBEqX
         sRTkuP4fIcdvDTir1phJAJzcKyXuFgSGyCqXDH49BIToIKvCiVrBZg+V0szivR7j3TmP
         cmRppJ4ZMxPGr/3wb2cwnde7Yoo/uBydSfBwVmHIt9mDfrIg1Sl4WKOpNH6/9JwoBNvh
         wYd/QTqomZpdx3pfa+XKS2vkk+9qAH5US/wVNfWgD3Vjayd7Nq5lu39YSp6798wSK39z
         H17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q5FjlxjJJSlG9e6HSbQz2R73ZeE8ouGWflFVUN4rOd4=;
        b=J7mSDRvUQIgXhX5RcT8RIBdbNMVKX0UHWJiEoqhB5wDMG1GqEocy+NgDHkcMd8uGqr
         W9Xp38n6wAxS40hIE6YiGuEvJssgf3ixdcFEtlLl+2HT7ITM9jRd5DRc6PaiuAb+laU0
         3zggYomsfRUwT/ngOJ0iDrLmyYypmuIK8uuFeAgldZwBx8pIZBJcZUh45dSpEfchrEP9
         BAhBySao0MoksH4jqXfrEU27ZDOOOc/mSNkpg9M8W1LE0r0Ufj/wtvbqjhnuy3XhbAHs
         FLJpS1/00mMIwTS8Z+u1rVmXfdddKUjut8qvVzDDevwmDPlmKWqAyFt+9LrppVVFHolo
         BMNQ==
X-Gm-Message-State: ACgBeo2mn8snhG+l9ag9D2tDBmjIdQZf2qwo1sfeL++ZyERpTVsFMVUr
        PNxu4j59cKJToGk8zjN8DSgZpw==
X-Google-Smtp-Source: AA6agR7nH161VCI7No6X2dtxsn5MhwiwYY5/e96dYWEqa6seT+ZiZkM9Iq1ty5SUfEN2EXEQNyiFvQ==
X-Received: by 2002:a05:6402:42d4:b0:443:4b8:8cba with SMTP id i20-20020a05640242d400b0044304b88cbamr6164472edc.3.1662624197815;
        Thu, 08 Sep 2022 01:03:17 -0700 (PDT)
Received: from lavr ([2a02:168:f656:0:7ea4:c965:3c:be66])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709063e0b00b0076f0ab9591esm896394eji.125.2022.09.08.01.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:03:17 -0700 (PDT)
Date:   Thu, 8 Sep 2022 10:03:15 +0200
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
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
Message-ID: <Yxmhwx7jKZs5IgHu@lavr>
References: <20220907080140.290413-1-aspsk@isovalent.com>
 <20220908012241.bbqy2m2sky3vx5vs@kashmir.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220908012241.bbqy2m2sky3vx5vs@kashmir.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 22/09/07 07:22, Daniel Xu wrote:
> Hi Anton,

Hi Daniel,

> 
> On Wed, Sep 07, 2022 at 10:01:40AM +0200, Anton Protopopov wrote:
> > Add a new map, BPF_MAP_TYPE_WILDCARD, which provides means to implement generic
> > online packet classification. Here "online" stands for "fast lookups and fast
> > updates", and "generic" means that a user can create maps with custom lookup
> > schemes—different numbers of fields and different interpretation of individual
> > fields (prefix bitmasks, ranges, and direct matches).
> > 
> > In particular, in Cilium we have several use cases for such a map:
> > 
> >   * XDP Prefilter is a simple XDP-based DDoS mitigation system provided by
> >     Cilium. At the moment it only supports filtering by source CIDRs. It would
> >     benefit from using this new map, as it allows to utilize wildcard rules
> >     without big penalty comparing to one hash or LPM lookup utilized now.
> > 
> >   * XDP Packet Recorder (see https://lpc.events/event/11/contributions/953/)
> > 
> >   * K8S and Cilium Network Policies: as of k8s 1.25 port ranges are considered
> >     to be a stable feature, and this map allows to implement this easily (and
> >     also to provide more sophisticated filtering for Cilium Network Policies)
> > 
> > Keys for wildcard maps are defined using the struct wildcard_key structure.
> > Besides the type field, it contains the data field of an arbitrary size. To
> > educate map about what's contained inside the data field, two additional
> > structures are used. The first one, struct wildcard_desc, also of arbitrary
> > size, tells how many fields are contained inside data, and the struct
> > wildcard_rule_desc structure defines how individual fields look like.
> > 
> > Fields (rules) can be of three types: BPF_WILDCARD_RULE_{PREFIX,RANGE,MATCH}.
> > The PREFIX rule means that inside data we have a binary value and a binary
> > (prefix) mask:
> > 
> >                size             u32
> >         <----------------> <----------->
> >    ... |    rule value    |   prefix   | ...
> > 
> > Here rule value is a binary value, e.g., 123.324.128.0, and prefix is a u32 bit
> > variable; we only use lower 8 bits of it. We allow 8, 16, 32, 64, and 128 bit
> > values for PREFIX rules.
> > 
> > The RANGE rule is determined by two binary values: minimum and maximum, treated
> > as unsigned integers of appropriate size:
> > 
> >                size               size
> >         <----------------> <---------------->
> >    ... |  min rule value  |  max rule value  | ...
> > 
> > We only allow the 8, 16, 32, and 64-bit for RANGE rules.
> > 
> > The MATCH rule is determined by one binary value, and is basically the same as
> > (X,sizeof(X)*8) PREFIX rule, but can be processed a bit faster:
> > 
> >                size
> >         <---------------->
> >    ... |    rule value    | ...
> > 
> > To speed up processing all the rules, including the prefix field, should be
> > stored in host byte order, and all elements in network byte order. 16-byte
> > fields are stored as {lo,hi}—lower eight bytes, then higher eight bytes.
> > 
> > For elements only values are stored.
> > 
> > To simplify definition of key structures, the BPF_WILDCARD_DESC_{1,2,3,4,5}
> > macros should be used. For example, one can define an IPv4 4-tuple keys as
> > follows:
> > 
> >    BPF_WILDCARD_DESC_4(
> >         capture4_wcard,
> >         BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
> >         BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
> >         BPF_WILDCARD_RULE_RANGE, __u16, sport,
> >         BPF_WILDCARD_RULE_RANGE, __u16, dport
> >    );
> > 
> > This macro will define the following structure:
> > 
> >    struct capture4_wcard_key {
> >         __u32 type;
> >         __u32 priority;
> >         union {
> >             struct {
> >                     __u32 saddr;
> >                     __u32 saddr_prefix;
> >                     __u32 daddr;
> >                     __u32 daddr_prefix;
> >                     __u16 sport_min;
> >                     __u16 sport_max;
> >                     __u16 dport_min;
> >                     __u16 dport_max;
> >             } __packed rule;
> >             struct {
> >                     __u32 saddr;
> >                     __u32 daddr;
> >                     __u16 sport;
> >                     __u16 dport;
> >             } __packed;
> >         };
> >    } __packed;
> > 
> > Here type field should contain either BPF_WILDCARD_KEY_RULE or
> > BPF_WILDCARD_KEY_ELEM so that kernel can differentiate between rules and
> > elements. The rule structure is used to define (and lookup) rules, the unnamed
> > structure can be used to specify elements when matching them with rules.
> > 
> > In order to simplify definition of a corresponding struct wildcard_desc, the
> > BPF_WILDCARD_DESC_* macros will create yet another structure:
> > 
> >    struct capture4_wcard_desc {
> >         __uint(n_rules, 4);
> >         struct {
> >                 __uint(type, BPF_WILDCARD_RULE_PREFIX);
> >                 __uint(size, sizeof(__u32));
> >         } saddr;
> >         struct {
> >                 __uint(type, BPF_WILDCARD_RULE_PREFIX);
> >                 __uint(size, sizeof(__u32));
> >         } daddr;
> >         struct {
> >                 __uint(type, BPF_WILDCARD_RULE_RANGE);
> >                 __uint(size, sizeof(__u16));
> >         } sport;
> >         struct {
> >                 __uint(type, BPF_WILDCARD_RULE_RANGE);
> >                 __uint(size, sizeof(__u16));
> >         } dport;
> >    };
> > 
> > This structure can be used in a (BTF) map definition as follows:
> > 
> >     __type(wildcard_desc, struct capture4_wcard_desc);
> > 
> > Then libbpf will create a corresponding struct wildcard_desc and pass it to
> > kernel in bpf_attr using new map_extra_data/map_extra_data_size fields.
> > 
> > The map implementation allows users to specify which algorithm to use to store
> > rules and lookup packets. Currently, three algorithms are supported:
> > 
> >   * Brute Force (suitable for map sizes of about 32 or below elements)
> > 
> >   * Tuple Merge (a variant of the Tuple Merge algorithm described in the
> >     "TupleMerge: Fast Software Packet Processing for Online Packet
> >     Classification" white paper, see https://nonsns.github.io/paper/rossi19ton.pdf.
> >     The Tuple Merge algorithm is not protected by any patents.)
> > 
> >   * Static Tuple Merge (a variant of Tuple Merge where a set of lookup tables
> >     is directly provided by a user)
> > 
> > To select a specific algorithm one should set a flag in the map_extra field,
> > see examples below.
> > 
> > Example 1. The following defines a brute force map to match IPv4
> > source/destination CIDRs:
> > 
> >     BPF_WILDCARD_DESC_2(
> >             capture4_l3,
> >             BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
> >             BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
> >     );
> > 
> >     struct {
> >             __uint(type, BPF_MAP_TYPE_WILDCARD);
> >             __type(key, struct capture4_l3_key);
> >             __type(value, __u64);
> >             __uint(max_entries, 16);
> >             __uint(map_flags, BPF_F_NO_PREALLOC);
> >             __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_BF);
> >             __type(wildcard_desc, struct capture4_l3_desc);
> >     } filter_v4_bf __section(".maps");
> > 
> > Example 2. The only change requred for the previous example to use Tuple Merge
> > is to select a different algorithm:
> > 
> >     struct {
> >             __uint(type, BPF_MAP_TYPE_WILDCARD);
> >             __type(key, struct capture4_l3_key);
> >             __type(value, __u64);
> >             __uint(max_entries, 16);
> >             __uint(map_flags, BPF_F_NO_PREALLOC);
> >             __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_TM);
> >             __type(wildcard_desc, struct capture4_l3_desc);
> >     } filter_v4_tm __section(".maps");
> > 
> > Example 3. Let's update the previous example to use Static Tuple Merge:
> > 
> >     BPF_WILDCARD_TM_OPTS(
> >             capture4_l3,
> >             BPF_WILDCARD_TM_TABLES_3(saddr, 16, 0, 16);
> >             BPF_WILDCARD_TM_TABLES_3(daddr, 16, 16, 0);
> >     );
> > 
> >     struct {
> >             __uint(type, BPF_MAP_TYPE_WILDCARD);
> >             __type(key, struct capture4_l3_key);
> >             __type(value, __u64);
> >             __uint(max_entries, 100000);
> >             __uint(map_flags, BPF_F_NO_PREALLOC);
> >             __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_TM |
> >                               BPF_WILDCARD_F_TM_STATIC_POOL |
> >                               BPF_WILDCARD_F_TM_POOL_LIST);
> >             __type(wildcard_tm_opts, struct capture4_l3_opts);
> >     } filter_v4_bf __section(".maps");
> > 
> > Here we set new flags to specify that a pool of tables should be used to select
> > new tables from (BPF_WILDCARD_F_TM_STATIC_POOL), and that the field
> > wildcard_tm_opts contains a list of tables to use (BPF_WILDCARD_F_TM_POOL_LIST,
> > an alternative is to use a Cartesian product of arrays provided). The
> > capture4_l3_opts is defined by a helper macro BPF_WILDCARD_TM_OPTS, where for
> > each field we define a list of prefixes to use.  If a field is missing, then it
> > will be always ignored.
> > 
> > The following changes and are not part of this RFC, but planned to be added before v1:
> > 
> >   * implement priorities, i.e., users will be able to specify rule priority as
> >     u32 and rules with lower priorities will be matched first
> > 
> >   * implement !BPF_F_NO_PREALLOC: right now we always kalloc both elements and
> >     new tables
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  include/linux/bpf_types.h       |    1 +
> >  include/uapi/linux/bpf.h        |  127 +++
> >  kernel/bpf/Makefile             |    2 +-
> >  kernel/bpf/syscall.c            |   51 +-
> >  kernel/bpf/wildcard.c           | 1526 +++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h  |  129 ++-
> >  tools/lib/bpf/bpf.c             |    8 +
> >  tools/lib/bpf/bpf.h             |    5 +-
> >  tools/lib/bpf/libbpf.c          |  423 +++++++++
> >  tools/lib/bpf/libbpf_internal.h |    5 +-
> >  10 files changed, 2269 insertions(+), 8 deletions(-)
> >  create mode 100644 kernel/bpf/wildcard.c
> > 
> 
> I'm interested in the goal of your patch but I'm having a grokking how
> the map is actually used.
> 
> Is there any chance you could include a selftest or example?

Here is an example in which we create a 4-tuple wildcard map. This means that
users can specify rules like

  (192.168.0.0/16,     10.0.0.0/8, 1-1024, 1-1024)
  (192.168.0.0/16, 192.168.0.0/16,      *,     22)

In the bpf part we create a map and an XDP program which matches packets:

    #include <linux/if_ether.h>
    #include <linux/bpf.h>
    #include <linux/ip.h>
    #include <netinet/in.h>
    #include <bpf/bpf_helpers.h>

    BPF_WILDCARD_DESC_4(
        capture4_wcard,
        BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
        BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
        BPF_WILDCARD_RULE_RANGE, __u16, sport,
        BPF_WILDCARD_RULE_RANGE, __u16, dport
        );

    struct {
        __uint(type, BPF_MAP_TYPE_WILDCARD);
        __type(key, struct capture4_wcard_key);
        __type(value, __u64);
        __uint(max_entries, 100000);
        __uint(map_flags, BPF_F_NO_PREALLOC);
        __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_TM);
        __type(wildcard_desc, struct capture4_wcard_desc);
    } filter_v4_tm_dynamic __section(".maps");

    __section("xdp")
    int xdp_foo(struct xdp_md *ctx)
    {
        void *data_end = (void *)(long)ctx->data_end;
        void *data = (void *)(long)ctx->data;
        struct capture4_wcard_key key = {};
        struct iphdr *ip4;
        __u64 *match;
        void *l4;

        if (data + sizeof(struct ethhdr) > data_end)
            return XDP_ABORTED;

        ip4 = data + sizeof(struct ethhdr);
        if ((void*)(ip4 + 1) > data_end)
            return XDP_ABORTED;

        if (ip4->protocol != IPPROTO_TCP)
            return XDP_PASS;

        l4 = (void*)ip4 + ip4->ihl * 4;
        if (l4 + 4 > data_end)
            return XDP_ABORTED;

        key.type = BPF_WILDCARD_KEY_ELEM;
        key.saddr = ip4->saddr;
        key.daddr = ip4->daddr;
        __builtin_memcpy(&key.sport, l4, 4); /* copy both ports */
        match = bpf_map_lookup_elem(&filter_v4_tm_dynamic, &key);
        if (match)
            return XDP_DROP;

        return XDP_PASS;
    }

    char LICENSE[] __section("license") = "GPL";

So the lookup part is pretty simple: we just copy 4-tuple into struct
capture4_wcard_key (defined earlier by the BPF_WILDCARD_DESC_4 macro),
set key type as BPF_WILDCARD_KEY_ELEM, and call bpf_map_lookup_elem().

On the user side we need to configure the map, this is done using
bpf_map_update_elem(), but we pass keys as BPF_WILDCARD_KEY_RULE:

    #include <sys/resource.h>
    #include <bpf/bpf.h>
    #include <arpa/inet.h>
    #include <unistd.h>
    #include <err.h>

    #include "filter.bpf.skel.h"

    #define ARRAY_SIZE(A) (sizeof(A)/sizeof(A[0]))

    BPF_WILDCARD_DESC_4(
            capture4_wcard,
            BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
            BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
            BPF_WILDCARD_RULE_RANGE, __u16, sport,
            BPF_WILDCARD_RULE_RANGE, __u16, dport
            );

    #define RULE(_saddr, _daddr, _spfx, _dpfx, s0, s1, d0, d1) \
    {   .type = BPF_WILDCARD_KEY_RULE, \
        .rule = { .saddr = _saddr, \
            .daddr = _daddr, \
            .saddr_prefix = _spfx, \
            .daddr_prefix = _dpfx, \
            .sport_min = s0, \
            .sport_max = s1, \
            .dport_min = d0, \
            .dport_max = d1, \
        }, }

    #define RULE_IP(x0, x1, x2, x3) ((x0 << 24) | (x1 << 16) | (x2 << 8) | x3)
    static struct capture4_wcard_key rules[] = {
        RULE(RULE_IP(192,168,0,0), RULE_IP(136,182,0,0), 16, 8, 1, 1024, 1, 1024),
        RULE(RULE_IP(192,168,0,0), RULE_IP(192,168,0,0), 16, 16, 0, 0xffff, 22, 22),
    };

    int main(int argc, char **argv)
    {
        struct filter_bpf *skel;
        struct rlimit rlim = {
            .rlim_cur = RLIM_INFINITY,
            .rlim_max = RLIM_INFINITY,
        };
        __u64 val;
        long ret;
        int fd;
        int i;

        setrlimit(RLIMIT_MEMLOCK, &rlim);

        skel = filter_bpf__open_and_load();
        if (!skel)
            err(1, "failed to open and load BPF skeleton");

        fd = bpf_map__fd(skel->maps.filter_v4_tm_dynamic);
        for (i = 0; i < ARRAY_SIZE(rules); i++) {
            ret = bpf_map_update_elem(fd, &rules[i], &val, 0);
            if (ret < 0)
                err(1, "bpf");
        }

        /* ... set up XDP program or pin map ... */

    }

> Thanks,
> Daniel
> 
> [...]
