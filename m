Return-Path: <bpf+bounces-30080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B18CA5EF
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03902282706
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3ED51E;
	Tue, 21 May 2024 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh3yV43a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F0D51D;
	Tue, 21 May 2024 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255816; cv=none; b=IQnszRfrF4MT4hpWN3Y7esrHWbLJuGkD6Yz+YetM2ebQ9dqLS2KyiBJuyxQrvzzh1aIAAnIvnal/OTZI7lMilHWkZrerjFMZcMkM1lCHjhQkD4X/nD49GcOMzBkBDN6Dml/aWuH0/2s8rWAx31jFvhl9RkLsfKhqHRCCc06PLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255816; c=relaxed/simple;
	bh=b8/pOzGm0bnaY4/Tn8GAKxa29GpVcZPdYDKXDY8JK4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqwEZHrfifkKXM9apTXpbFP//GLxfU757ERovAhoth+Vswc14Y6gvMS4PLsBvDBzNjLhYqnEmVuAtUSLhS11z0sYBZeMdD7ixgqExr1bLGINOW7W+gHCV9+PFa76fhztMIQ1S8D2PHYz3/mW/IWYvyXwpP/8Uno3y2oVV9TYjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh3yV43a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-351ae94323aso2471943f8f.0;
        Mon, 20 May 2024 18:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716255812; x=1716860612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBkyGa0YE9Bj+j3vIJoNZvwD8AvG8LIeP5vyy7tZ1zU=;
        b=Lh3yV43asBkpQH5MLe+M0sThoTgiW0IYrCa5u/c/JR/LpkqF+9e7/0F2ivYhJYjzjQ
         yk1f4si9nXWl/iWcAb722wTB5KL1PjnPm7DvjvVWi6gYfyw7FvgXbfQpfvVqq1vacZbj
         C4ae110dSTyuXtPL1YHHVGGN4rwDRaLqoQQIX97SeLPPU514942BOM9NVxQSUO/7qJll
         c5aOv7uzp3WyZL3je3DnWkTvjHLwG4XVtt6gJ/EXwKkodTGVHuUIAh1oKNISe0JN0SnH
         ly4+BHM7YvBIcjJ2jkiuqwwXnV3FRqmkcObFWeZPe78cdK01IUFGnddmI2kroY5m+7hS
         yF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716255812; x=1716860612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBkyGa0YE9Bj+j3vIJoNZvwD8AvG8LIeP5vyy7tZ1zU=;
        b=ETF/ZBleakO+V0SNZ2A3zasbg59HiGljA3r1pQbZOLYKlQX9A2km3cPXtunyfJucg2
         p2VyVj6YSKgInlw1QTIDY7FhGFCcahbgg3oqlqtarQN477w5qTlxMlSvipjwvh0Z0WYZ
         HtnOM2bnW1wNsxcTHNRENNSuN1iMNxRinPAZ3QLWFiTuREjiLaRs05RtbOIRg8z8Hsp6
         nWSmTscNaOzyZDOoTFPE5ECNAGY0S/Db3GCX3zKgPUFs9wJRBT4xjIWtpSeqmAFpL2e5
         BV3kzWO5ZiSe9GO2ahTIPI3NslvChsrg+O86XhSXBY4VCT6va93avoprwnZoZHTySiwN
         Jfxg==
X-Forwarded-Encrypted: i=1; AJvYcCXEjbtlM0HZP7Z1WFbKf6isHfO47xlfgSTjO4wRLawLsjxGxEzumkvqmwKoH1Aj9k89vYPlKW7qp0roWA32czy7cQZYzx5Tq0ZNsNp8k5HN0fB/VcDR9LBFyLJC+m/wy0VFRRjWSBPj
X-Gm-Message-State: AOJu0Yw9jP7zvzcdwFXGOzVpxu5eiV5CsGcZb13/O5KXkcC5N2OElepL
	2w77GjCGfd48wqMZQtpx5Uka+HpAvwVdFQHIttDyF/xBtp/V90OdQfw1J9pGgGx/HG69+b48hXH
	Dc2i52HbWBGGDhMr+HEf+XmpEzns=
X-Google-Smtp-Source: AGHT+IG+8T6fzAgaNQf7yG3ZGe5hBOoiMxiVK92J1RYKsaNUTRbrR55O3ROaq9kcsJWQ+oGqD5oqVWnXT6lJl79iVqM=
X-Received: by 2002:a05:6000:1968:b0:34d:12c3:ffb0 with SMTP id
 ffacd0b85a97d-3504a61c6b7mr20986255f8f.9.1716255812250; Mon, 20 May 2024
 18:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716026761.git.lorenzo@kernel.org> <46168ffdeb2b57b4331c75f95d27b747c2ccc517.1716026761.git.lorenzo@kernel.org>
In-Reply-To: <46168ffdeb2b57b4331c75f95d27b747c2ccc517.1716026761.git.lorenzo@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 May 2024 18:43:21 -0700
Message-ID: <CAADnVQ+bnnUJaK2Jr2KecKLW+FZx2ZY26b0T6amDZ5+66imrhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add selftest for
 bpf_xdp_flow_offload_lookup kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman <horms@kernel.org>, donhunte@redhat.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 3:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> Introduce e2e selftest for bpf_xdp_flow_offload_lookup kfunc through
> xdp_flowtable utility.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |  10 +-
>  tools/testing/selftests/bpf/config            |   4 +
>  .../selftests/bpf/progs/xdp_flowtable.c       | 141 +++++++++++++++++
>  .../selftests/bpf/test_xdp_flowtable.sh       | 112 ++++++++++++++
>  tools/testing/selftests/bpf/xdp_flowtable.c   | 142 ++++++++++++++++++
>  5 files changed, 407 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c
>  create mode 100755 tools/testing/selftests/bpf/test_xdp_flowtable.sh
>  create mode 100644 tools/testing/selftests/bpf/xdp_flowtable.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index e0b3887b3d2df..7361c429bed62 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -133,7 +133,8 @@ TEST_PROGS :=3D test_kmod.sh \
>         test_bpftool_metadata.sh \
>         test_doc_build.sh \
>         test_xsk.sh \
> -       test_xdp_features.sh
> +       test_xdp_features.sh \
> +       test_xdp_flowtable.sh
>
>  TEST_PROGS_EXTENDED :=3D with_addr.sh \
>         with_tunnels.sh ima_setup.sh verify_sig_setup.sh \
> @@ -144,7 +145,7 @@ TEST_GEN_PROGS_EXTENDED =3D test_skb_cgroup_id_user \
>         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_=
user \
>         test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod=
.ko \
>         xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metada=
ta \
> -       xdp_features bpf_test_no_cfi.ko
> +       xdp_features bpf_test_no_cfi.ko xdp_flowtable
>
>  TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mul=
ti
>
> @@ -476,6 +477,7 @@ test_usdt.skel.h-deps :=3D test_usdt.bpf.o test_usdt_=
multispec.bpf.o
>  xsk_xdp_progs.skel.h-deps :=3D xsk_xdp_progs.bpf.o
>  xdp_hw_metadata.skel.h-deps :=3D xdp_hw_metadata.bpf.o
>  xdp_features.skel.h-deps :=3D xdp_features.bpf.o
> +xdp_flowtable.skel.h-deps :=3D xdp_flowtable.bpf.o
>
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKEL=
S),$($(skel)-deps)))
>
> @@ -710,6 +712,10 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/net=
work_helpers.o $(OUTPUT)/xdp
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> +$(OUTPUT)/xdp_flowtable: xdp_flowtable.c $(OUTPUT)/xdp_flowtable.skel.h =
| $(OUTPUT)
> +       $(call msg,BINARY,,$@)
> +       $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
> +
>  # Make sure we are able to include and link libbpf against c++.
>  $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPF=
OBJ)
>         $(call msg,CXX,,$@)
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index eeabd798bc3ae..1a9aea01145f7 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -82,6 +82,10 @@ CONFIG_NF_CONNTRACK=3Dy
>  CONFIG_NF_CONNTRACK_MARK=3Dy
>  CONFIG_NF_DEFRAG_IPV4=3Dy
>  CONFIG_NF_DEFRAG_IPV6=3Dy
> +CONFIG_NF_TABLES=3Dy
> +CONFIG_NETFILTER_INGRESS=3Dy
> +CONFIG_NF_FLOW_TABLE=3Dy
> +CONFIG_NF_FLOW_TABLE_INET=3Dy
>  CONFIG_NF_NAT=3Dy
>  CONFIG_RC_CORE=3Dy
>  CONFIG_SECURITY=3Dy
> diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/te=
sting/selftests/bpf/progs/xdp_flowtable.c
> new file mode 100644
> index 0000000000000..888ac87790f90
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +#define MAX_ERRNO      4095
> +
> +#define ETH_P_IP       0x0800
> +#define ETH_P_IPV6     0x86dd
> +#define IP_MF          0x2000  /* "More Fragments" */
> +#define IP_OFFSET      0x1fff  /* "Fragment Offset" */
> +#define AF_INET                2
> +#define AF_INET6       10
> +
> +struct flow_offload_tuple_rhash *
> +bpf_xdp_flow_offload_lookup(struct xdp_md *,
> +                           struct bpf_fib_lookup *) __ksym;
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __type(key, __u32);
> +       __type(value, __u32);
> +       __uint(max_entries, 1);
> +} stats SEC(".maps");
> +
> +static __always_inline bool
> +xdp_flowtable_offload_check_iphdr(struct iphdr *iph)

Please do not use __always_inline in bpf code.
It was needed 10 years ago. Not any more.

> +{
> +       /* ip fragmented traffic */
> +       if (iph->frag_off & bpf_htons(IP_MF | IP_OFFSET))
> +               return false;
> +
> +       /* ip options */
> +       if (iph->ihl * 4 !=3D sizeof(*iph))
> +               return false;
> +
> +       if (iph->ttl <=3D 1)
> +               return false;
> +
> +       return true;
> +}
> +
> +static __always_inline bool
> +xdp_flowtable_offload_check_tcp_state(void *ports, void *data_end, u8 pr=
oto)
> +{
> +       if (proto =3D=3D IPPROTO_TCP) {
> +               struct tcphdr *tcph =3D ports;
> +
> +               if (tcph + 1 > data_end)
> +                       return false;
> +
> +               if (tcph->fin || tcph->rst)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +SEC("xdp.frags")
> +int xdp_flowtable_do_lookup(struct xdp_md *ctx)
> +{
> +       void *data_end =3D (void *)(long)ctx->data_end;
> +       struct flow_offload_tuple_rhash *tuplehash;
> +       struct bpf_fib_lookup tuple =3D {
> +               .ifindex =3D ctx->ingress_ifindex,
> +       };
> +       void *data =3D (void *)(long)ctx->data;
> +       struct ethhdr *eth =3D data;
> +       struct flow_ports *ports;
> +       __u32 *val, key =3D 0;
> +
> +       if (eth + 1 > data_end)
> +               return XDP_DROP;
> +
> +       switch (eth->h_proto) {
> +       case bpf_htons(ETH_P_IP): {
> +               struct iphdr *iph =3D data + sizeof(*eth);
> +
> +               ports =3D (struct flow_ports *)(iph + 1);
> +               if (ports + 1 > data_end)
> +                       return XDP_PASS;
> +
> +               /* sanity check on ip header */
> +               if (!xdp_flowtable_offload_check_iphdr(iph))
> +                       return XDP_PASS;
> +
> +               if (!xdp_flowtable_offload_check_tcp_state(ports, data_en=
d,
> +                                                          iph->protocol)=
)
> +                       return XDP_PASS;
> +
> +               tuple.family            =3D AF_INET;
> +               tuple.tos               =3D iph->tos;
> +               tuple.l4_protocol       =3D iph->protocol;
> +               tuple.tot_len           =3D bpf_ntohs(iph->tot_len);
> +               tuple.ipv4_src          =3D iph->saddr;
> +               tuple.ipv4_dst          =3D iph->daddr;
> +               tuple.sport             =3D ports->source;
> +               tuple.dport             =3D ports->dest;
> +               break;
> +       }
> +       case bpf_htons(ETH_P_IPV6): {
> +               struct in6_addr *src =3D (struct in6_addr *)tuple.ipv6_sr=
c;
> +               struct in6_addr *dst =3D (struct in6_addr *)tuple.ipv6_ds=
t;
> +               struct ipv6hdr *ip6h =3D data + sizeof(*eth);
> +
> +               ports =3D (struct flow_ports *)(ip6h + 1);
> +               if (ports + 1 > data_end)
> +                       return XDP_PASS;
> +
> +               if (ip6h->hop_limit <=3D 1)
> +                       return XDP_PASS;
> +
> +               if (!xdp_flowtable_offload_check_tcp_state(ports, data_en=
d,
> +                                                          ip6h->nexthdr)=
)
> +                       return XDP_PASS;
> +
> +               tuple.family            =3D AF_INET6;
> +               tuple.l4_protocol       =3D ip6h->nexthdr;
> +               tuple.tot_len           =3D bpf_ntohs(ip6h->payload_len);
> +               *src                    =3D ip6h->saddr;
> +               *dst                    =3D ip6h->daddr;
> +               tuple.sport             =3D ports->source;
> +               tuple.dport             =3D ports->dest;
> +               break;
> +       }
> +       default:
> +               return XDP_PASS;
> +       }
> +
> +       tuplehash =3D bpf_xdp_flow_offload_lookup(ctx, &tuple);
> +       if (!tuplehash)
> +               return XDP_PASS;
> +
> +       val =3D bpf_map_lookup_elem(&stats, &key);
> +       if (val)
> +               __sync_add_and_fetch(val, 1);
> +
> +       return XDP_PASS;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/test_xdp_flowtable.sh b/tools/te=
sting/selftests/bpf/test_xdp_flowtable.sh
> new file mode 100755
> index 0000000000000..1a8a40aebbdf1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_xdp_flowtable.sh

Sorry shell scripts are not allowed.
Integrate it into test_progs.

pw-bot: cr

