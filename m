Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480025B341A
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 11:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiIIJhf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 05:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiIIJhe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 05:37:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF1C95ACF
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 02:37:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d2so1800251wrn.1
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=uYmnvfFRLOEP6akjYf/SrkrfOz3oSv+esiWsNGMaERU=;
        b=zSNMOuk8eQblOApofFE79Mkx3G96dzDFijVl5sjpJCX2MfdGnLDS/e9ONT7u3vEcSh
         u70KgE55GlZgYlGIbp60IN6zlTMiel0ImssOcSSJ6wZ8wRQ056aCGOtSzy6MYIqxkzfA
         MuNSN6uftRMH+zU+qmhgHYd6drfVI7Onw6JgJ4Amxoqiyl0W5C/DZtZHSL+wOypjb9yi
         y6aiOwDB56hDd4JxB9mrY/2NPd/r2mF/pzDp+MFrcCfnsh42n0Joppi5fXSxSncR9gzD
         3AUYaHhijbJpQhjzHTsEYrA12Bs0SbThRa420j8WpzyvdLYaXtvR+llWK/B+1ru1/Z+D
         o6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uYmnvfFRLOEP6akjYf/SrkrfOz3oSv+esiWsNGMaERU=;
        b=RGMYt0CKtqKue1bTZ+S+Z0c/rA7buupFCc6Lg2iFB0f3Zcfi0TMD6yNzY0HUcuARMO
         zn37ZJHRNSD3pBGFJfF0PMEnUP87uibnxnSatOBaualxwMeNkkQ/iLCuaPGSf90BYGuB
         Ilp3s2dyHzToWO+0KQ7nEagl7cKNQmjARrcgVxuYDPNK9M3Z+suOD0OK7lPy+Sm1aC5O
         +HhYxhDFxpI1IFwEY7wEWjYdOUmRCwdcIxBgtYL6JOU7vm7TxQvLHLbIprxxIz7w2+p/
         w6VY+VsMd8nc+t89MCSj+H0amBxeDY5wXCZlzNX39iNgpY4esN/pZ6oy115dP/I0uL12
         OSDA==
X-Gm-Message-State: ACgBeo2jzvzjqX6d8vVnepjEIghP9tab48B8oqrv4PHpMUOwGGtaHVLk
        yX+VW8RzbtKbqS4j2wXTKCr9dg==
X-Google-Smtp-Source: AA6agR4pKL58qzqFB+st2a6zNX3mCpEPekpYePhI3Pced0GGjOBepmT3fkZSKsiR2Zem8Cjw0DT3Pw==
X-Received: by 2002:adf:dfcd:0:b0:228:d923:873a with SMTP id q13-20020adfdfcd000000b00228d923873amr7685653wrn.256.1662716249786;
        Fri, 09 Sep 2022 02:37:29 -0700 (PDT)
Received: from lavr ([2a02:168:f656:0:fb4d:a38e:b8a0:8fae])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003a342933727sm131456wmo.3.2022.09.09.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:37:28 -0700 (PDT)
Date:   Fri, 9 Sep 2022 11:37:25 +0200
From:   Anton Protopopov <aspsk@isovalent.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Martynas Pumputis <m@lambda.lt>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Eric Torng <torng@msu.edu>
Subject: Re: [RFC PATCH] bpf: introduce new bpf map type BPF_MAP_TYPE_WILDCARD
Message-ID: <YxsJVYuBc0Cg52Xo@lavr>
References: <20220907080140.290413-1-aspsk@isovalent.com>
 <YxkknQJC1vWmU/o9@google.com>
 <YxmsVB3CSPvGGEhP@lavr>
 <Yxpun3tl9ZhozYe9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yxpun3tl9ZhozYe9@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 22/09/08 03:37, sdf@google.com wrote:
> On 09/08, Anton Protopopov wrote:
> > On 22/09/07 04:09, sdf@google.com wrote:
> > > [sorry for the noise, got a bounce from the list, resend with the
> > > message trimmed]
> > >
> > > On 09/07, Anton Protopopov wrote:
> > > > Add a new map, BPF_MAP_TYPE_WILDCARD, which provides means to
> > implement
> > > > generic
> > > > online packet classification. Here "online" stands for "fast lookups
> > and
> > > > fast
> > > > updates", and "generic" means that a user can create maps with custom
> > > > lookup
> > > > schemes—different numbers of fields and different interpretation of
> > > > individual
> > > > fields (prefix bitmasks, ranges, and direct matches).
> > >
> > > > In particular, in Cilium we have several use cases for such a map:
> > >
> > > >    * XDP Prefilter is a simple XDP-based DDoS mitigation system
> > provided by
> > > >      Cilium. At the moment it only supports filtering by source CIDRs.
> > > > It would
> > > >      benefit from using this new map, as it allows to utilize wildcard
> > > > rules
> > > >      without big penalty comparing to one hash or LPM lookup
> > utilized now.
> > >
> > > >    * XDP Packet Recorder (see
> > > > https://lpc.events/event/11/contributions/953/)
> > >
> > > >    * K8S and Cilium Network Policies: as of k8s 1.25 port ranges are
> > > > considered
> > > >      to be a stable feature, and this map allows to implement this
> > > > easily (and
> > > >      also to provide more sophisticated filtering for Cilium Network
> > > > Policies)
> > >
> > > > Keys for wildcard maps are defined using the struct wildcard_key
> > > > structure.
> > > > Besides the type field, it contains the data field of an arbitrary
> > size.
> > > > To
> > > > educate map about what's contained inside the data field, two
> > additional
> > > > structures are used. The first one, struct wildcard_desc, also of
> > > > arbitrary
> > > > size, tells how many fields are contained inside data, and the struct
> > > > wildcard_rule_desc structure defines how individual fields look like.
> > >
> > > > Fields (rules) can be of three types:
> > > > BPF_WILDCARD_RULE_{PREFIX,RANGE,MATCH}.
> > >
> > > [..]
> > >
> > > > The PREFIX rule means that inside data we have a binary value and a
> > binary
> > > > (prefix) mask:
> > >
> > > >                 size             u32
> > > >          <----------------> <----------->
> > > >     ... |    rule value    |   prefix   | ...
> > >
> > > > Here rule value is a binary value, e.g., 123.324.128.0, and prefix
> > is a
> > > > u32 bit
> > > > variable; we only use lower 8 bits of it. We allow 8, 16, 32, 64, and
> > > > 128 bit
> > > > values for PREFIX rules.
> > >
> > > I haven't looked at the code, so pardon stupid questions. This sounds
> > > like optimized LPM-trie?
> > >
> > > If not, what's the difference?
> 
> > First, this map provides more generic API than LPM. Namely, we allow not
> > one,
> > but multiple prefixes (say, to specify both source and destination
> > prefix), and
> > also not only prefixes, but ranges. See the example I've just posted in
> > reply
> > to Daniel, but in short, we can specify rules like
> 
> >    (192.68.0.0/16, 10.0.0.0/24, *, 22)
> 
> > We are also not limited by 4-tuples, we can create any combination of
> > rules.
> 
> Ah, ok, that seems useful. But fundamentally looks like a
> map-in-a-map-in-a-map-in-a-map? So, in theory, at least the ip prefix
> lookups
> already can be implemented with LPM (albeit slower)?

Well, this is just a single map :)

We have a use case for one prefix lookups in Cilium. The XDP prefilter uses
either a hash or an LPM (hash is used if only precise match rules specified,
and LPM - if there are CIDR rules):

  https://github.com/cilium/cilium/blob/master/bpf/bpf_xdp.c#L60-L68

Here the new map works faster than LPM (e.g., for 5000K rules this is about
120ns vs. 80ns for an [IPv6] map lookup on AMD Ryzen 9). With the new map we
also will be able to specify more sophisticated rules for the XDP prefilter,
not only source CIDRs.

> 
> > Second, the [tuple merge implementation of this] map uses hash tables to
> > do
> > lookups, not tries.
> 
> > I also should have mentioned that I have a talk on Plumbers next Tuesday
> > about
> > this map, I will talk about API and algorithms there, and provide some
> > numbers.
> > See https://lpc.events/event/16/contributions/1356/
> 
> Awesome, hopefully I'll be there as well, will come say hi :-)

Unluckily, I will be remote this time

> From that link, regarding the following:
>   Thus, both of algorithms are [nearly?] impossible to implement in "pure"
>   BPF due to lack of functionality and also due to verifier complexity
> limits.
> 
> There is a natural question here: what's missing? Can we extend the
> bpf machinery to lift some of these restrictions? Verifier complexity
> limits are pretty different now compared to even 2 years ago..

The complexity, in fact, is a big concern for us in Cilium - we already have
rather large programs. Adding, at least, a few hundreds lines vs. just doing a
single map lookup is a big deal. (We also have to support older kernels.)

The Tuple Merge implementation uses a [custom] hash table underneath. The
difference with the normal hash table is that we actually have multiple hash
tables inside one - we split rules in several "tables" and do a hash lookup for
each table (and to resolve collisions hash table elements know to which table
they do belong).

> > > If yes, can this be special cased/optimized in the existing LPM-trie
> > > optimization? I think we've tried in the past, mostly gave up and
> > > "fixed" by caching the state in the socket local storage.
> > >
> > > Also, fixed 8/16/32/64 prefixes seems like a big limitation? At least if
> > > I were to store ipv4 from the classless (cidr) world..
> 
> > This is not for prefixes, but for the field lengths. The basic use case
> > for
> > this map is to filter packets, so we can create 4- or 5-tuple IPv4 or IPv6
> > maps. In the first case our field lengths will be (32, 32, 16, 16), in the
> > second - (128, 128, 16, 16). Prefixes can be of any length from 0 up to
> > the
> > field size.
> 
> Understood, thx.
> 
> > > > The RANGE rule is determined by two binary values: minimum and
> > maximum,
> > > > treated
> > > > as unsigned integers of appropriate size:
> > >
> > > >                 size               size
> > > >          <----------------> <---------------->
> > > >     ... |  min rule value  |  max rule value  | ...
> > >
> > > > We only allow the 8, 16, 32, and 64-bit for RANGE rules.
> > >
> > > That seems useful. I was thinking about similar 'rangemap' where
> > > we can effectively store and lookup [a,b] ranges. Might be useful
> > > in firewalls for storing lists of ports efficiently. So why not
> > > a separate map instead? Are you able to share a lot of code with
> > > the general matching map?
> 
> > Yes, all is included inside one map. For firewalls users can create
> > individual
> > maps with different specifications. Say, one can filter 4-tuples, or
> > 5-tuples,
> > or (src, dst, dst port), or (flow-label, dest port), etc.
> 
> > > > The MATCH rule is determined by one binary value, and is basically the
> > > > same as
> > > > (X,sizeof(X)*8) PREFIX rule, but can be processed a bit faster:
> > >
> > > >                 size
> > > >          <---------------->
> > > >     ... |    rule value    | ...
> > >
> > > > To speed up processing all the rules, including the prefix field,
> > should
> > > > be
> > > > stored in host byte order, and all elements in network byte order.
> > 16-byte
> > > > fields are stored as {lo,hi}—lower eight bytes, then higher eight
> > bytes.
> > >
> > > > For elements only values are stored.
> > >
> > > Can these optimization be auto-magically derived whenever PREFIX map
> > > with the right values is created? Why put this decision on the users?
> 
> > Thanks for pointing this out. I am not really proud of this particular
> > interface...
> 
> > For packet filtering values tend to appear in network byte order, so we
> > can
> > just assume this. We definitely can optimize values to the right order for
> > rules internally when bpf_map_update_elem is called.
> 
> > We also can add a map flag to process values in host byte order. This
> > can be
> > helpful for a non-networking usage, when values appear in host byte order
> > naturally.
> 
> Yeah, it seems like the less uapi we export - the better. Maybe some of
> that endiannes can be deduced via BTF (be32 vs u32) so we can
> transparently apply these optimizations?

I am not sure how to do this automatically. Say, users can define an IPv4
address as __u32, or __u8[4], or __be32. And they can also legally mix the
definitions, as bpf(2) only says "gimme a void *key".

Users don't have problems with specifying, say, LPM keys or socket options in
network byte order, so can we just say: use network byte order for your values?

> > > > To simplify definition of key structures, the
> > > > BPF_WILDCARD_DESC_{1,2,3,4,5}
> > > > macros should be used. For example, one can define an IPv4 4-tuple
> > keys as
> > > > follows:
> > >
> > > >     BPF_WILDCARD_DESC_4(
> > > >          capture4_wcard,
> > > >          BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
> > > >          BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
> > > >          BPF_WILDCARD_RULE_RANGE, __u16, sport,
> > > >          BPF_WILDCARD_RULE_RANGE, __u16, dport
> > > >     );
> > >
> > > > This macro will define the following structure:
> > >
> > > >     struct capture4_wcard_key {
> > > >          __u32 type;
> > > >          __u32 priority;
> > > >          union {
> > > >              struct {
> > > >                      __u32 saddr;
> > > >                      __u32 saddr_prefix;
> > > >                      __u32 daddr;
> > > >                      __u32 daddr_prefix;
> > > >                      __u16 sport_min;
> > > >                      __u16 sport_max;
> > > >                      __u16 dport_min;
> > > >                      __u16 dport_max;
> > > >              } __packed rule;
> > > >              struct {
> > > >                      __u32 saddr;
> > > >                      __u32 daddr;
> > > >                      __u16 sport;
> > > >                      __u16 dport;
> > > >              } __packed;
> > > >          };
> > > >     } __packed;
> > >
> > > > Here type field should contain either BPF_WILDCARD_KEY_RULE or
> > > > BPF_WILDCARD_KEY_ELEM so that kernel can differentiate between rules
> > and
> > > > elements. The rule structure is used to define (and lookup) rules, the
> > > > unnamed
> > > > structure can be used to specify elements when matching them with
> > rules.
> > >
> > > > In order to simplify definition of a corresponding struct
> > wildcard_desc,
> > > > the
> > > > BPF_WILDCARD_DESC_* macros will create yet another structure:
> > >
> > > >     struct capture4_wcard_desc {
> > > >          __uint(n_rules, 4);
> > > >          struct {
> > > >                  __uint(type, BPF_WILDCARD_RULE_PREFIX);
> > > >                  __uint(size, sizeof(__u32));
> > > >          } saddr;
> > > >          struct {
> > > >                  __uint(type, BPF_WILDCARD_RULE_PREFIX);
> > > >                  __uint(size, sizeof(__u32));
> > > >          } daddr;
> > > >          struct {
> > > >                  __uint(type, BPF_WILDCARD_RULE_RANGE);
> > > >                  __uint(size, sizeof(__u16));
> > > >          } sport;
> > > >          struct {
> > > >                  __uint(type, BPF_WILDCARD_RULE_RANGE);
> > > >                  __uint(size, sizeof(__u16));
> > > >          } dport;
> > > >     };
> > >
> > > > This structure can be used in a (BTF) map definition as follows:
> > >
> > > >      __type(wildcard_desc, struct capture4_wcard_desc);
> > >
> > > > Then libbpf will create a corresponding struct wildcard_desc and
> > pass it
> > > > to
> > > > kernel in bpf_attr using new map_extra_data/map_extra_data_size
> > fields.
> > >
> > > [..]
> > >
> > > > The map implementation allows users to specify which algorithm to
> > use to
> > > > store
> > > > rules and lookup packets. Currently, three algorithms are supported:
> > >
> > > >    * Brute Force (suitable for map sizes of about 32 or below
> > elements)
> > >
> > > >    * Tuple Merge (a variant of the Tuple Merge algorithm described
> > in the
> > > >      "TupleMerge: Fast Software Packet Processing for Online Packet
> > > >      Classification" white paper, see
> > > > https://nonsns.github.io/paper/rossi19ton.pdf.
> > > >      The Tuple Merge algorithm is not protected by any patents.)
> > >
> > > >    * Static Tuple Merge (a variant of Tuple Merge where a set of
> > lookup
> > > > tables
> > > >      is directly provided by a user)
> > >
> > > As a user that has no clue how this map works, how do I decide which
> > > algorithm to use? What I like with the current maps is that they don't
> > > leak too much of their inner state. These controls seems a bit low
> > > level?
> 
> > The idea to let users to select an algorithm appeared because the map is
> > pretty
> > generic, and some algorithms may work better for some cases. You're
> > right that
> > there shouldn't be need to specify algorithm. (In fact, users can omit the
> > algorithm flag now, and the default algorithm will be used. I also
> > marked to
> > myself to setup the right default algorithm, as now this seems to be the
> > brute
> > force...).
> 
> The reason I ask is: it seems it's just a matter of time until there will be
> an algorithm called BPF_WILDCARD_F_ALGORITHM_BPF where you can pass a BPF
> program that implements a custom one :-)

... which fits the current implementation :)

If we don't let users to specify an algorithm, then do we let them to pass
options for a particular algorithm? For example, if for a particular setup an
option can change a lookup time, say, twice, comparing to the default, then is
this worth to provide such a toggle? If we let users to provide options, then
once we change the default algorithm, those options won't, most probably, have
meaning for the new one.

We actually can do both things here. For a "default" algorithm we won't let
users to specify any non-generic, algorithm-specific, options. But if a user
specifies a particular algorithm, then setting algorithm-specific options will
be allowed.
