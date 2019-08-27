Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82979F239
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2019 20:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfH0SUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Aug 2019 14:20:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35813 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfH0SUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Aug 2019 14:20:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so176389lje.2
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2019 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7xS2mqUmvfGD2gYBNRoaIo8kgj9r996SvDAa7dChXk=;
        b=HJV5MwkgE3yttMYSBa59EVU6tp+BwgqjIlk5WFxmqNGKTCBptwbmnY27Hmxyr4hwIX
         cbZ7Q/pNUoE+vUwqz3sa9MPpEKqUg12bSn2649W6iRXUy24oB47tPw7FiSh909BGYfr/
         /h2DSbYRCGRH/ELVVLkKeThsoITDAIFxOhn1KW2x30U7AV/CSdrNumcSKdn3284QGdwn
         /ElkiDtYEYXBe1DC+8kp/ZXhcPTNGOTLs91AY4KPG+DirAq8vXq76YZ0iLMwH2cBfUQP
         VNr0QaIB5vGvKfK8rtw6YwWHCXpSnG4ESKxqROyk7qgoHRQwWWdwY0zyuUm58ZJP6DS4
         knew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7xS2mqUmvfGD2gYBNRoaIo8kgj9r996SvDAa7dChXk=;
        b=XZZvDpJl/Cno3jbqtF7A0fPAfygz8S9nzT6j6tGVyNUeG/me0GXo3Z8cDb8Vetm5G0
         p7WDbw/5jbpFNQdm2HJoUY4cv9MSVPGBKSWwlC+9y+qUEDPf5DimqCajm7aUzvnWUkge
         PmLAABXEg/j2UIBQfBJ7ZVfRz60vO/uu/bXo8gCFQ7NkHVSFJyq+TRI0XyWsLPHlWSKp
         ANxSzIKO6WA+XCjwwHIEY+PU1bCug3ueP7UNqdP+mHGVS30PJrfBuGyEF2ycljCqrbAN
         AncO2jUWAv3j4vQxTKV/9tAmRWETCWHZFgiM3KX4brenncxcE5OoPBTQdm7KOyXLRq0m
         T2XQ==
X-Gm-Message-State: APjAAAUZYPcp2zOUFoxoJaicj26wcKUvQYZnrmKLLsPpYK2YLhKSZzu2
        NUtqrsauIUhMGJvo3lA2vFXlgQo4cgmBuJaz+Cq31jvIbl43+w==
X-Google-Smtp-Source: APXvYqzPRomdbuGktnoZnpmq6HvS6vCJCu0m5j1NEF6f5iLxMo0P7SFjO9Nn7cjZdV7v/1LNkF1nY7KNt7+VIvLd6HY=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr15164737ljj.56.1566930006341;
 Tue, 27 Aug 2019 11:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190725225231.195090-1-sdf@google.com> <20190725225231.195090-8-sdf@google.com>
 <c1cec8df-e3c5-8d34-c3b3-44eae4f10e9b@gmail.com>
In-Reply-To: <c1cec8df-e3c5-8d34-c3b3-44eae4f10e9b@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 27 Aug 2019 11:19:53 -0700
Message-ID: <CAKH8qBsJH80mAYnVP9xgey+_CChgCfSb8uS-RX=rum5gJ+S0_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 7/7] selftests/bpf: support BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yeah, I've sent the fix upstream yesterday, will backport.
Feel free to ignore the following patches:
https://screenshot.googleplex.com/DOQKAzGDksV
They are all blocked on this nhoff defined twice :-( I'll backport them

On Tue, Aug 27, 2019 at 11:04 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 7/26/19 12:52 AM, Stanislav Fomichev wrote:
> > Exit as soon as we found that packet is encapped when
> > BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP is passed.
> > Add appropriate selftest cases.
> >
> > v2:
> > * Subtract sizeof(struct iphdr) from .iph_inner.tot_len (Willem de Bruijn)
> >
> > Acked-by: Petar Penkov <ppenkov@google.com>
> > Acked-by: Willem de Bruijn <willemb@google.com>
> > Acked-by: Song Liu <songliubraving@fb.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Petar Penkov <ppenkov@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/flow_dissector.c | 64 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_flow.c  |  8 +++
> >  2 files changed, 72 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > index ef83f145a6f1..700d73d2f22a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> > @@ -41,6 +41,13 @@ struct ipv4_pkt {
> >       struct tcphdr tcp;
> >  } __packed;
> >
> > +struct ipip_pkt {
> > +     struct ethhdr eth;
> > +     struct iphdr iph;
> > +     struct iphdr iph_inner;
> > +     struct tcphdr tcp;
> > +} __packed;
> > +
> >  struct svlan_ipv4_pkt {
> >       struct ethhdr eth;
> >       __u16 vlan_tci;
> > @@ -82,6 +89,7 @@ struct test {
> >       union {
> >               struct ipv4_pkt ipv4;
> >               struct svlan_ipv4_pkt svlan_ipv4;
> > +             struct ipip_pkt ipip;
> >               struct ipv6_pkt ipv6;
> >               struct ipv6_frag_pkt ipv6_frag;
> >               struct dvlan_ipv6_pkt dvlan_ipv6;
> > @@ -303,6 +311,62 @@ struct test tests[] = {
> >               },
> >               .flags = BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
> >       },
> > +     {
> > +             .name = "ipip-encap",
> > +             .pkt.ipip = {
> > +                     .eth.h_proto = __bpf_constant_htons(ETH_P_IP),
> > +                     .iph.ihl = 5,
> > +                     .iph.protocol = IPPROTO_IPIP,
> > +                     .iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
> > +                     .iph_inner.ihl = 5,
> > +                     .iph_inner.protocol = IPPROTO_TCP,
> > +                     .iph_inner.tot_len =
> > +                             __bpf_constant_htons(MAGIC_BYTES) -
> > +                             sizeof(struct iphdr),
> > +                     .tcp.doff = 5,
> > +                     .tcp.source = 80,
> > +                     .tcp.dest = 8080,
> > +             },
> > +             .keys = {
> > +                     .nhoff = 0,
> > +                     .nhoff = ETH_HLEN,
>
> clang emits a warning because nhoff is defined twice.
>
> > +                     .thoff = ETH_HLEN + sizeof(struct iphdr) +
> > +                             sizeof(struct iphdr),
> > +                     .addr_proto = ETH_P_IP,
> > +                     .ip_proto = IPPROTO_TCP,
> > +                     .n_proto = __bpf_constant_htons(ETH_P_IP),
> > +                     .is_encap = true,
> > +                     .sport = 80,
> > +                     .dport = 8080,
> > +             },
> > +     },
> > +     {
> > +             .name = "ipip-no-encap",
> > +             .pkt.ipip = {
> > +                     .eth.h_proto = __bpf_constant_htons(ETH_P_IP),
> > +                     .iph.ihl = 5,
> > +                     .iph.protocol = IPPROTO_IPIP,
> > +                     .iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
> > +                     .iph_inner.ihl = 5,
> > +                     .iph_inner.protocol = IPPROTO_TCP,
> > +                     .iph_inner.tot_len =
> > +                             __bpf_constant_htons(MAGIC_BYTES) -
> > +                             sizeof(struct iphdr),
> > +                     .tcp.doff = 5,
> > +                     .tcp.source = 80,
> > +                     .tcp.dest = 8080,
> > +             },
> > +             .keys = {
> > +                     .flags = BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP,
> > +                     .nhoff = ETH_HLEN,
> > +                     .thoff = ETH_HLEN + sizeof(struct iphdr),
> > +                     .addr_proto = ETH_P_IP,
> > +                     .ip_proto = IPPROTO_IPIP,
> > +                     .n_proto = __bpf_constant_htons(ETH_P_IP),
> > +                     .is_encap = true,
> > +             },
> > +             .flags = BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP,
> > +     },
> >  };
> >
> >  static int create_tap(const char *ifname)
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
> > index 7fbfa22f33df..08bd8b9d58d0 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_flow.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
> > @@ -167,9 +167,15 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
> >               return export_flow_keys(keys, BPF_OK);
> >       case IPPROTO_IPIP:
> >               keys->is_encap = true;
> > +             if (keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP)
> > +                     return export_flow_keys(keys, BPF_OK);
> > +
> >               return parse_eth_proto(skb, bpf_htons(ETH_P_IP));
> >       case IPPROTO_IPV6:
> >               keys->is_encap = true;
> > +             if (keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP)
> > +                     return export_flow_keys(keys, BPF_OK);
> > +
> >               return parse_eth_proto(skb, bpf_htons(ETH_P_IPV6));
> >       case IPPROTO_GRE:
> >               gre = bpf_flow_dissect_get_header(skb, sizeof(*gre), &_gre);
> > @@ -189,6 +195,8 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
> >                       keys->thoff += 4; /* Step over sequence number */
> >
> >               keys->is_encap = true;
> > +             if (keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP)
> > +                     return export_flow_keys(keys, BPF_OK);
> >
> >               if (gre->proto == bpf_htons(ETH_P_TEB)) {
> >                       eth = bpf_flow_dissect_get_header(skb, sizeof(*eth),
> >
