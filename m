Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87385075F5
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 19:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiDSRG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351107AbiDSRGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 13:06:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483376366
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:58:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r83so4475621pgr.2
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OW0nGnF98pZ4njAibwudvInpKengLLH5Dkv8AYb+vUU=;
        b=pG2xcoZBTJLS7FXyxS9U7hBli21AxI9JXtgOt7Kn08ketOhYU5NMf17WdYaOjm7+p2
         QhDj6t5jQSkFRowTau0hlXty7EMDghkCToxQ/VjihrkO8+2rNqIXRyowkxLQf2mmnOaa
         ZzseZ4GTQq0oZ102zUItPZeJReAPKSVtdhL+kPeqJati1Un6CDsmyolVMMFCR5dE25f4
         eV3F9A7thpCVK/aqsGaW9DLmQQVM9mJRQ2f2cZrAvSZRbSeXog1U9FiTxDKrcJ5rmEe7
         e17wumJdCGOAGSGGw0fuhTnYEM+yYW1Nj/FkvcyM6xgZXL4nKRM235S3Dg5bAnPdQXtS
         GxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OW0nGnF98pZ4njAibwudvInpKengLLH5Dkv8AYb+vUU=;
        b=e9FUpFAr6oPcpTGwFHDn9svpD5PKHw9/UVEAGgchW22WY8oTplPvSAtU2TFhulkfUO
         4l2pRvoQL51iD4Y4RwgnfeUUhj2VAtjAVZBHFRKXcy1KSr5AclWs0oLYlbNB49g4j+SK
         JtUpImCSNdKiUuStsMCLZOUMnKW9grbapRTs1Ryq04GRPDebtD5m7sfQKaEKl4tiILKT
         K6x++gqA9mmi5Sa31nf32xn8ndu90aF0trugBtEcqRffPUS9TDu48C/g7qoiam3Pyko2
         XI6V6uWM/PyZW95BEcl/4jlg6Ulc5VQyjoK/BjImRlOl/gzO0LhamhN9dX6t0FH/hJE5
         xdGA==
X-Gm-Message-State: AOAM531xObR3DrPap3T7NUJhYUTwWEVSWiO1zvLPmetodN1hd9PkmfQ0
        0NRdfV2UBEo9b11aKQDqHcay7zipzlR9AzMW7q8=
X-Google-Smtp-Source: ABdhPJzIH3jfqOflBWjqQ+pNoXxFksigTltP+xwDsJaJkGsvN1SotaMZ1YlSURvL3bBq0IvDJPiwgHdMFg2sIJC9hgc=
X-Received: by 2002:a65:6e41:0:b0:39c:c97b:2aef with SMTP id
 be1-20020a656e41000000b0039cc97b2aefmr15956140pgb.473.1650387536717; Tue, 19
 Apr 2022 09:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220418013136.26098-1-fankaixi.li@bytedance.com> <20220418013136.26098-3-fankaixi.li@bytedance.com>
In-Reply-To: <20220418013136.26098-3-fankaixi.li@bytedance.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Apr 2022 09:58:45 -0700
Message-ID: <CAADnVQLb6OgsUU-2=uksX8kTTxsmqwHd3C3wCfftLszffX5ELQ@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v4 2/3] selftests/bpf: move vxlan
 tunnel testcases to test_progs
To:     fankaixi.li@bytedance.com
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 17, 2022 at 6:32 PM <fankaixi.li@bytedance.com> wrote:
>
> From: Kaixi Fan <fankaixi.li@bytedance.com>
>
> Move vxlan tunnel testcases from test_tunnel.sh to test_progs.
> And add vxlan tunnel source testcases also. Other tunnel testcases
> will be moved to test_progs step by step in the future.
> Rename bpf program section name as SEC("tc") because test_progs
> bpf loader could not load sections with name SEC("gre_set_tunnel").
> Because of this, add bpftool to load bpf programs in test_tunnel.sh.
>
> Signed-off-by: Kaixi Fan <fankaixi.li@bytedance.com>
> ---
>  .../selftests/bpf/prog_tests/test_tunnel.c    | 461 ++++++++++++++++++
>  .../selftests/bpf/progs/test_tunnel_kern.c    | 155 ++++--
>  tools/testing/selftests/bpf/test_tunnel.sh    | 124 +----
>  3 files changed, 577 insertions(+), 163 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> new file mode 100644
> index 000000000000..8d3efe163f68
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> @@ -0,0 +1,461 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +
> +/*
> + * End-to-end eBPF tunnel test suite
> + *   The file tests BPF network tunnel implementation.
> + *
> + * Topology:
> + * ---------
> + *     root namespace   |     at_ns0 namespace
> + *                       |
> + *       -----------     |     -----------
> + *       | tnl dev |     |     | tnl dev |  (overlay network)
> + *       -----------     |     -----------
> + *       metadata-mode   |     native-mode
> + *        with bpf       |
> + *                       |
> + *       ----------      |     ----------
> + *       |  veth1  | --------- |  veth0  |  (underlay network)
> + *       ----------    peer    ----------
> + *
> + *
> + *  Device Configuration
> + *  --------------------
> + *  root namespace with metadata-mode tunnel + BPF
> + *  Device names and addresses:
> + *     veth1 IP 1: 172.16.1.200, IPv6: 00::22 (underlay)
> + *             IP 2: 172.16.1.20, IPv6: 00::bb (underlay)
> + *     tunnel dev <type>11, ex: gre11, IPv4: 10.1.1.200, IPv6: 1::22 (overlay)
> + *
> + *  Namespace at_ns0 with native tunnel
> + *  Device names and addresses:
> + *     veth0 IPv4: 172.16.1.100, IPv6: 00::11 (underlay)
> + *     tunnel dev <type>00, ex: gre00, IPv4: 10.1.1.100, IPv6: 1::11 (overlay)
> + *
> + *
> + * End-to-end ping packet flow
> + *  ---------------------------
> + *  Most of the tests start by namespace creation, device configuration,
> + *  then ping the underlay and overlay network.  When doing 'ping 10.1.1.100'
> + *  from root namespace, the following operations happen:
> + *  1) Route lookup shows 10.1.1.100/24 belongs to tnl dev, fwd to tnl dev.
> + *  2) Tnl device's egress BPF program is triggered and set the tunnel metadata,
> + *     with local_ip=172.16.1.200, remote_ip=172.16.1.100. BPF program choose
> + *     the primary or secondary ip of veth1 as the local ip of tunnel. The
> + *     choice is made based on the value of bpf map local_ip_map.
> + *  3) Outer tunnel header is prepended and route the packet to veth1's egress.
> + *  4) veth0's ingress queue receive the tunneled packet at namespace at_ns0.
> + *  5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet.
> + *  6) Forward the packet to the overlay tnl dev.
> + */
> +
> +#include <arpa/inet.h>
> +#include <linux/if.h>
> +#include <linux/if_tun.h>
> +#include <linux/limits.h>
> +#include <linux/sysctl.h>
> +#include <linux/time_types.h>
> +#include <linux/net_tstamp.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "test_tunnel_kern.skel.h"
> +
> +#define IP4_ADDR_VETH0 "172.16.1.100"
> +#define IP4_ADDR1_VETH1 "172.16.1.200"
> +#define IP4_ADDR2_VETH1 "172.16.1.20"
> +#define IP4_ADDR_TUNL_DEV0 "10.1.1.100"
> +#define IP4_ADDR_TUNL_DEV1 "10.1.1.200"
> +
> +#define IP6_ADDR_VETH0 "::11"
> +#define IP6_ADDR1_VETH1 "::22"
> +#define IP6_ADDR2_VETH1 "::bb"
> +
> +#define IP4_ADDR1_HEX_VETH1 0xac1001c8
> +#define IP4_ADDR2_HEX_VETH1 0xac100114
> +#define IP6_ADDR1_HEX_VETH1 0x22
> +#define IP6_ADDR2_HEX_VETH1 0xbb
> +
> +#define MAC_TUNL_DEV0 "52:54:00:d9:01:00"
> +#define MAC_TUNL_DEV1 "52:54:00:d9:02:00"
> +
> +#define VXLAN_TUNL_DEV0 "vxlan00"
> +#define VXLAN_TUNL_DEV1 "vxlan11"
> +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> +
> +#define INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/tunnel/test_tunnel_ingress"
> +#define EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/tunnel/test_tunnel_egress"
> +
> +#define PING_ARGS "-c 3 -w 10 -q"
> +
> +#define SYS(fmt, ...)                                          \
> +       ({                                                      \
> +               char cmd[1024];                                 \
> +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
> +               if (!ASSERT_OK(system(cmd), cmd))               \
> +                       goto fail;                              \
> +       })
> +
> +#define SYS_NOFAIL(fmt, ...)                                   \
> +       ({                                                      \
> +               char cmd[1024];                                 \
> +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
> +               system(cmd);                                    \
> +       })
> +
> +static int config_device(void)
> +{
> +       SYS("ip netns add at_ns0");
> +       SYS("ip link add veth0 type veth peer name veth1");
> +       SYS("ip link set veth0 netns at_ns0");
> +       SYS("ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
> +       SYS("ip link set dev veth1 up mtu 1500");
> +       SYS("ip netns exec at_ns0 ip addr add " IP4_ADDR_VETH0 "/24 dev veth0");
> +       SYS("ip netns exec at_ns0 ip link set dev veth0 up mtu 1500");
> +
> +       return 0;
> +fail:
> +       return -1;
> +}
> +
> +static void cleanup(void)
> +{
> +       SYS_NOFAIL("rm -rf " INGRESS_PROG_PIN_FILE);
> +       SYS_NOFAIL("rm -rf " EGRESS_PROG_PIN_FILE);
> +       SYS_NOFAIL("rm -rf /sys/fs/bpf/tc/tunnel");
> +
> +       SYS_NOFAIL("ip netns delete at_ns0");
> +       SYS_NOFAIL("ip link del veth1 2> /dev/null");
> +       SYS_NOFAIL("ip link del vxlan11 2> /dev/null");
> +       SYS_NOFAIL("ip link del ip6vxlan11 2> /dev/null");
> +}
> +
> +static int add_vxlan_tunnel(char *veth1_ip)
> +{
> +       /*
> +        * Set static ARP entry here because iptables set-mark works
> +        * on L3 packet, as a result not applying to ARP packets,
> +        * causing errors at get_tunnel_{key/opt}.
> +        */
> +
> +       /* at_ns0 namespace */
> +       SYS("ip netns exec at_ns0 ip link add dev %s type vxlan id 2 dstport 4789 gbp local %s remote %s",
> +           VXLAN_TUNL_DEV0, IP4_ADDR_VETH0, veth1_ip);
> +       SYS("ip netns exec at_ns0 ip link set dev %s address %s up",
> +           VXLAN_TUNL_DEV0, MAC_TUNL_DEV0);
> +       SYS("ip netns exec at_ns0 ip addr add dev %s %s/24",
> +           VXLAN_TUNL_DEV0, IP4_ADDR_TUNL_DEV0);
> +       SYS("ip netns exec at_ns0 ip neigh add %s lladdr %s dev %s",
> +           IP4_ADDR_TUNL_DEV1, MAC_TUNL_DEV1, VXLAN_TUNL_DEV0);
> +       SYS("ip netns exec at_ns0 iptables -A OUTPUT -j MARK --set-mark 0x800FF");

BPF CI is failing here:

add_vxlan_tunnel:FAIL:ip netns exec at_ns0 iptables -A OUTPUT -j MARK
--set-mark 0x800FF unexpected error: 512 (errno 0)
test_vxlan_tunnel:FAIL:add vxlan tunnel unexpected error: -1 (errno 0)
See
https://patchwork.kernel.org/project/netdevbpf/patch/20220418013136.26098-3-fankaixi.li@bytedance.com/
bpf/vmtest-bpf-next-VM_Test-1 link.
