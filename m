Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629907425F
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2019 01:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfGXXw5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 19:52:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35315 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfGXXw4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 19:52:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so22617354plp.2
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X7CPKA/7VNTFh6d9AkXcUKh1Nf/gOxE8Xsvsg0BefTU=;
        b=aLwAtQ4dSBxFn0VOec3Dd3bN+FmY4qhQwiRMTOeyDb2WeTSDZ2bMMIVP2MF6cNWzXJ
         60jUqrYya1QirTludUaQJ6xD4/MxiEGGC+hJ/LNzmUwBvKfBmiNkO/QXNgDjcWGqFPaw
         GbzHgFAE3kAaWke895d6JiMDrrO1SrpYyGID48yu2szNkhbbZVzqae4f8B73AU5tNCIH
         vBZuMvD7eVvHzwyBGhtVzaWfNdDco0GcOnZRG0TmoMVgj4vVyMoWoEHQNP9SKJ+dV/1q
         mXRUQa2zL2b9a/HoW3ob+qgxX0L/xNpMd7Uz4MRFzjKzfoNfWPgZvXBmcyo/yU3Aqb9p
         b/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X7CPKA/7VNTFh6d9AkXcUKh1Nf/gOxE8Xsvsg0BefTU=;
        b=U4Kj1Svqv5oYLInb/JyHyDkNMz29kmIpReRL5EfDC9o3D5N547KrArEQL1aeROrsz3
         qSrrJeMyHBjnZWEL2YQDVxjjeHR3LEXIH4qoVDc6ByhLdAtKQyxblVNUjMIZBGgCLcRI
         m4XwZ27Xb0MeN8DhGuvoLaSmw7fUWOIiw6/OMKzeU5t5NZCCOPUS4Bxv5uPEK7BX0WRn
         SDXMe12zG1Xc9pYcuUVH/Ah+ieGdIkvhnpODLivZzNe/ZKLDb1VkQk09a7MiS4MYnYQq
         sKvpPtBE9a8GnCHWF0f8dmXEGsIn9LgtZZosXo09C0VE2E+hGey1MkisrXQWHjJTgmBj
         Nk1g==
X-Gm-Message-State: APjAAAWTHi3LFLgCmdPnjaBt5fZmEF0PZJ3/0xYxwHDy12V1xQnnTLS+
        xQ3YrOsHVxVgj1cGf4dWEPU=
X-Google-Smtp-Source: APXvYqyV/4Z7Ybdj80lk+JO+W9hKdBlP8iaZIP7tWy9aCibs12CKEm88mwlwuwfsugVZc2CiQEKz0Q==
X-Received: by 2002:a17:902:a514:: with SMTP id s20mr83544886plq.162.1564012375838;
        Wed, 24 Jul 2019 16:52:55 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id s43sm61451855pjb.10.2019.07.24.16.52.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:52:55 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:52:54 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>
Subject: Re: [PATCH bpf-next 5/7] sefltests/bpf: support
 FLOW_DISSECTOR_F_PARSE_1ST_FRAG
Message-ID: <20190724235254.GB3500@mini-arch>
References: <20190724170018.96659-1-sdf@google.com>
 <20190724170018.96659-6-sdf@google.com>
 <CAPhsuW6Z2Bx66ZDOV-9jW+hsxKbZJxY-YFgP0rL_4QipAuptQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6Z2Bx66ZDOV-9jW+hsxKbZJxY-YFgP0rL_4QipAuptQA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/24, Song Liu wrote:
> On Wed, Jul 24, 2019 at 10:11 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > bpf_flow.c: exit early unless FLOW_DISSECTOR_F_PARSE_1ST_FRAG is passed
> > in flags. Also, set ip_proto earlier, this makes sure we have correct
> > value with fragmented packets.
> >
> > Add selftest cases to test ipv4/ipv6 fragments and skip eth_get_headlen
> > tests that don't have FLOW_DISSECTOR_F_PARSE_1ST_FRAG flag.
> >
> > eth_get_headlen calls flow dissector with
> > FLOW_DISSECTOR_F_PARSE_1ST_FRAG flag so we can't run tests that
> > have different set of input flags against it.
> >
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Petar Penkov <ppenkov@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/flow_dissector.c | 129 ++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_flow.c  |  28 +++-
> >  2 files changed, 151 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > index c938283ac232..966cb3b06870 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > @@ -5,6 +5,10 @@
> >  #include <linux/if_tun.h>
> >  #include <sys/uio.h>
> >
> > +#ifndef IP_MF
> > +#define IP_MF 0x2000
> > +#endif
> > +
> >  #define CHECK_FLOW_KEYS(desc, got, expected)                           \
> >         CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) != 0,           \
> >               desc,                                                     \
> > @@ -49,6 +53,18 @@ struct ipv6_pkt {
> >         struct tcphdr tcp;
> >  } __packed;
> >
> > +struct ipv6_frag_pkt {
> > +       struct ethhdr eth;
> > +       struct ipv6hdr iph;
> > +       struct frag_hdr {
> > +               __u8 nexthdr;
> > +               __u8 reserved;
> > +               __be16 frag_off;
> > +               __be32 identification;
> > +       } ipf;
> > +       struct tcphdr tcp;
> > +} __packed;
> > +
> >  struct dvlan_ipv6_pkt {
> >         struct ethhdr eth;
> >         __u16 vlan_tci;
> > @@ -65,9 +81,11 @@ struct test {
> >                 struct ipv4_pkt ipv4;
> >                 struct svlan_ipv4_pkt svlan_ipv4;
> >                 struct ipv6_pkt ipv6;
> > +               struct ipv6_frag_pkt ipv6_frag;
> >                 struct dvlan_ipv6_pkt dvlan_ipv6;
> >         } pkt;
> >         struct bpf_flow_keys keys;
> > +       __u32 flags;
> >  };
> >
> >  #define VLAN_HLEN      4
> > @@ -143,6 +161,102 @@ struct test tests[] = {
> >                         .n_proto = __bpf_constant_htons(ETH_P_IPV6),
> >                 },
> >         },
> > +       {
> > +               .name = "ipv4-frag",
> > +               .pkt.ipv4 = {
> > +                       .eth.h_proto = __bpf_constant_htons(ETH_P_IP),
> > +                       .iph.ihl = 5,
> > +                       .iph.protocol = IPPROTO_TCP,
> > +                       .iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
> > +                       .iph.frag_off = __bpf_constant_htons(IP_MF),
> > +                       .tcp.doff = 5,
> > +                       .tcp.source = 80,
> > +                       .tcp.dest = 8080,
> > +               },
> > +               .keys = {
> > +                       .flags = FLOW_DISSECTOR_F_PARSE_1ST_FRAG,
> > +                       .nhoff = ETH_HLEN,
> > +                       .thoff = ETH_HLEN + sizeof(struct iphdr),
> > +                       .addr_proto = ETH_P_IP,
> > +                       .ip_proto = IPPROTO_TCP,
> > +                       .n_proto = __bpf_constant_htons(ETH_P_IP),
> > +                       .is_frag = true,
> > +                       .is_first_frag = true,
> > +                       .sport = 80,
> > +                       .dport = 8080,
> > +               },
> > +               .flags = FLOW_DISSECTOR_F_PARSE_1ST_FRAG,
> > +       },
> > +       {
> > +               .name = "ipv4-no-frag",
> > +               .pkt.ipv4 = {
> > +                       .eth.h_proto = __bpf_constant_htons(ETH_P_IP),
> > +                       .iph.ihl = 5,
> > +                       .iph.protocol = IPPROTO_TCP,
> > +                       .iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
> > +                       .iph.frag_off = __bpf_constant_htons(IP_MF),
> > +                       .tcp.doff = 5,
> > +                       .tcp.source = 80,
> > +                       .tcp.dest = 8080,
> > +               },
> > +               .keys = {
> > +                       .nhoff = ETH_HLEN,
> > +                       .thoff = ETH_HLEN + sizeof(struct iphdr),
> > +                       .addr_proto = ETH_P_IP,
> > +                       .ip_proto = IPPROTO_TCP,
> > +                       .n_proto = __bpf_constant_htons(ETH_P_IP),
> > +                       .is_frag = true,
> > +                       .is_first_frag = true,
> > +               },
> > +       },
> > +       {
> > +               .name = "ipv6-frag",
> > +               .pkt.ipv6_frag = {
> > +                       .eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
> > +                       .iph.nexthdr = IPPROTO_FRAGMENT,
> > +                       .iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
> > +                       .ipf.nexthdr = IPPROTO_TCP,
> > +                       .tcp.doff = 5,
> > +                       .tcp.source = 80,
> > +                       .tcp.dest = 8080,
> > +               },
> > +               .keys = {
> > +                       .flags = FLOW_DISSECTOR_F_PARSE_1ST_FRAG,
> > +                       .nhoff = ETH_HLEN,
> > +                       .thoff = ETH_HLEN + sizeof(struct ipv6hdr) +
> > +                               sizeof(struct frag_hdr),
> > +                       .addr_proto = ETH_P_IPV6,
> > +                       .ip_proto = IPPROTO_TCP,
> > +                       .n_proto = __bpf_constant_htons(ETH_P_IPV6),
> > +                       .is_frag = true,
> > +                       .is_first_frag = true,
> > +                       .sport = 80,
> > +                       .dport = 8080,
> > +               },
> > +               .flags = FLOW_DISSECTOR_F_PARSE_1ST_FRAG,
> > +       },
> > +       {
> > +               .name = "ipv6-no-frag",
> > +               .pkt.ipv6_frag = {
> > +                       .eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
> > +                       .iph.nexthdr = IPPROTO_FRAGMENT,
> > +                       .iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
> > +                       .ipf.nexthdr = IPPROTO_TCP,
> > +                       .tcp.doff = 5,
> > +                       .tcp.source = 80,
> > +                       .tcp.dest = 8080,
> > +               },
> > +               .keys = {
> > +                       .nhoff = ETH_HLEN,
> > +                       .thoff = ETH_HLEN + sizeof(struct ipv6hdr) +
> > +                               sizeof(struct frag_hdr),
> > +                       .addr_proto = ETH_P_IPV6,
> > +                       .ip_proto = IPPROTO_TCP,
> > +                       .n_proto = __bpf_constant_htons(ETH_P_IPV6),
> > +                       .is_frag = true,
> > +                       .is_first_frag = true,
> > +               },
> > +       },
> >  };
> >
> >  static int create_tap(const char *ifname)
> > @@ -225,6 +339,13 @@ void test_flow_dissector(void)
> >                         .data_size_in = sizeof(tests[i].pkt),
> >                         .data_out = &flow_keys,
> >                 };
> > +               static struct bpf_flow_keys ctx = {};
> > +
> > +               if (tests[i].flags) {
> > +                       tattr.ctx_in = &ctx;
> > +                       tattr.ctx_size_in = sizeof(ctx);
> > +                       ctx.flags = tests[i].flags;
> > +               }
> >
> >                 err = bpf_prog_test_run_xattr(&tattr);
> >                 CHECK_ATTR(tattr.data_size_out != sizeof(flow_keys) ||
> > @@ -255,6 +376,14 @@ void test_flow_dissector(void)
> >                 struct bpf_prog_test_run_attr tattr = {};
> >                 __u32 key = 0;
> >
> > +               /* Don't run tests that are not marked as
> > +                * FLOW_DISSECTOR_F_PARSE_1ST_FRAG; eth_get_headlen
> > +                * sets this flag.
> > +                */
> > +
> > +               if (tests[i].flags != FLOW_DISSECTOR_F_PARSE_1ST_FRAG)
> > +                       continue;
> 
> Maybe test flags & FLOW_DISSECTOR_F_PARSE_1ST_FRAG == 0 instead?
> It is not necessary now, but might be useful in the future.
I'm not sure about this one. We want flags here to match flags
from eth_get_headlen:

	const unsigned int flags = FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
	...
	if (!skb_flow_dissect_flow_keys_basic(..., flags))

Otherwise the test might break unexpectedly. So I'd rather manually
adjust a test here if eth_get_headlen flags change.

Maybe I should clarify the comment to signify that dependency? Because
currently it might be read as if we only care about
FLOW_DISSECTOR_F_PARSE_1ST_FRAG, but we really care about all flags
in eth_get_headlen; it just happens that it only has one right now.
