Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625AE50973F
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 08:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384653AbiDUGQW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiDUGQV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 02:16:21 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C33A13CE7
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 23:13:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y85so4274218iof.3
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KONlZNdf5QFIemCpjdqqAhLkSWWbJEOods7Lxw/EgCQ=;
        b=hDN/xXH59NY5RoXTW3xhto+Rw43wOrxW0cfYfE+en2v0LrPsFbnLV2vrOhVATSvjlI
         Wq+0icCEEnTQIFhs/iaQBi5YHL8Wkeg84UAbQpwH5wpNQmnuXfrzD91apUfi339mOevJ
         XCYCs6E5BSvDJN9CNvn2oGkXQchoc4u/X/Q6stizrofaGHqCG11Clt7R8f2LEq1e3uX2
         2B+IqbMRFDNYvnyHZv01yEHkNCDdEtjhzjvDBLAs7IHNzm68s5MFm6m3fc1iXdBuNEs6
         Ud9U8nbMEeItThpmsYovz6gR6pUb2S3mScz9/HRvrDUxBvOEf5yT27Dq7aUtGZ/dCyFF
         3eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KONlZNdf5QFIemCpjdqqAhLkSWWbJEOods7Lxw/EgCQ=;
        b=5nqfaj6PjsdCqXQhYGRDXOgXhrYQ/Dm+r5kkjflv2CL5ul+iQ/R8FCs0stUxEEqtHX
         zmD/cnnwrrz02pNLszUS4F62vhHEOzx+4HzBZKd7zyMzsiefjHWkyHerxKk9Nx6toOW/
         9Af6uTu2xC5e9q/GkK4Zo258gcdh70zMGUHirM3HUvNld9W5yLtg+fFKW+uPlVy1z2PR
         iC3P28vs/hnpoAxJ2lEKoKA0w3DQNfy5aSdQGTCrY5j+0y3aI8uPgRGSAO2cX5v/kEhH
         3OAtzoE28Fy9JvgPCOmCvFHOeO0lHEzWzo1I6Jzb1Embpz5uMPROjWVNXNb5zFtsm7lu
         L1wg==
X-Gm-Message-State: AOAM531mcof6zUtyudcb6i3Csd5w+KZdD5WLniV/BxtLDxwd/1EyD863
        IQisnL6P19jfOfd7OrPUQuSiYQDA3JJ2W7NjhD+4JcQffHoEHQ==
X-Google-Smtp-Source: ABdhPJzGSZwY8TxZVoZ1Qt2+pGxk0nt01IArndFdBu5fabwBdtVe/nvOoTvj/SInPrTyAqOdZMv2KLv4UM09RqD9sWI=
X-Received: by 2002:a05:6638:d01:b0:323:cefe:f1b8 with SMTP id
 q1-20020a0566380d0100b00323cefef1b8mr11706198jaj.292.1650521610265; Wed, 20
 Apr 2022 23:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220418013136.26098-1-fankaixi.li@bytedance.com>
 <20220418013136.26098-3-fankaixi.li@bytedance.com> <CAADnVQLb6OgsUU-2=uksX8kTTxsmqwHd3C3wCfftLszffX5ELQ@mail.gmail.com>
 <CAEEdnKFMH_6V2rVm8JxX=JUR+XQb1CowrZdfiT41sDVAj86qVg@mail.gmail.com> <CAEf4BzZhEV6FQRyXhCwNgJO5fpFnkxpYFjxa5u9O1B2g1NycsQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZhEV6FQRyXhCwNgJO5fpFnkxpYFjxa5u9O1B2g1NycsQ@mail.gmail.com>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Thu, 21 Apr 2022 14:13:19 +0800
Message-ID: <CAEEdnKHMBraHHOcqHei3cBXL4qoTj5YOhGYyQeZtZW-8mVbD6w@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v4 2/3] selftests/bpf: move vxlan
 tunnel testcases to test_progs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=
=8821=E6=97=A5=E5=91=A8=E5=9B=9B 06:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 20, 2022 at 1:23 AM =E8=8C=83=E5=BC=80=E5=96=9C <fankaixi.li@=
bytedance.com> wrote:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=
=B44=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=89 00:58=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Sun, Apr 17, 2022 at 6:32 PM <fankaixi.li@bytedance.com> wrote:
> > > >
> > > > From: Kaixi Fan <fankaixi.li@bytedance.com>
> > > >
> > > > Move vxlan tunnel testcases from test_tunnel.sh to test_progs.
> > > > And add vxlan tunnel source testcases also. Other tunnel testcases
> > > > will be moved to test_progs step by step in the future.
> > > > Rename bpf program section name as SEC("tc") because test_progs
> > > > bpf loader could not load sections with name SEC("gre_set_tunnel").
> > > > Because of this, add bpftool to load bpf programs in test_tunnel.sh=
.
> > > >
> > > > Signed-off-by: Kaixi Fan <fankaixi.li@bytedance.com>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 461 ++++++++++++++=
++++
> > > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 155 ++++--
> > > >  tools/testing/selftests/bpf/test_tunnel.sh    | 124 +----
> > > >  3 files changed, 577 insertions(+), 163 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tun=
nel.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b=
/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > new file mode 100644
> > > > index 000000000000..8d3efe163f68
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > > @@ -0,0 +1,461 @@
> > > > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > > > +
> > > > +/*
> > > > + * End-to-end eBPF tunnel test suite
> > > > + *   The file tests BPF network tunnel implementation.
> > > > + *
> > > > + * Topology:
> > > > + * ---------
> > > > + *     root namespace   |     at_ns0 namespace
> > > > + *                       |
> > > > + *       -----------     |     -----------
> > > > + *       | tnl dev |     |     | tnl dev |  (overlay network)
> > > > + *       -----------     |     -----------
> > > > + *       metadata-mode   |     native-mode
> > > > + *        with bpf       |
> > > > + *                       |
> > > > + *       ----------      |     ----------
> > > > + *       |  veth1  | --------- |  veth0  |  (underlay network)
> > > > + *       ----------    peer    ----------
> > > > + *
> > > > + *
> > > > + *  Device Configuration
> > > > + *  --------------------
> > > > + *  root namespace with metadata-mode tunnel + BPF
> > > > + *  Device names and addresses:
> > > > + *     veth1 IP 1: 172.16.1.200, IPv6: 00::22 (underlay)
> > > > + *             IP 2: 172.16.1.20, IPv6: 00::bb (underlay)
> > > > + *     tunnel dev <type>11, ex: gre11, IPv4: 10.1.1.200, IPv6: 1::=
22 (overlay)
> > > > + *
> > > > + *  Namespace at_ns0 with native tunnel
> > > > + *  Device names and addresses:
> > > > + *     veth0 IPv4: 172.16.1.100, IPv6: 00::11 (underlay)
> > > > + *     tunnel dev <type>00, ex: gre00, IPv4: 10.1.1.100, IPv6: 1::=
11 (overlay)
> > > > + *
> > > > + *
> > > > + * End-to-end ping packet flow
> > > > + *  ---------------------------
> > > > + *  Most of the tests start by namespace creation, device configur=
ation,
> > > > + *  then ping the underlay and overlay network.  When doing 'ping =
10.1.1.100'
> > > > + *  from root namespace, the following operations happen:
> > > > + *  1) Route lookup shows 10.1.1.100/24 belongs to tnl dev, fwd to=
 tnl dev.
> > > > + *  2) Tnl device's egress BPF program is triggered and set the tu=
nnel metadata,
> > > > + *     with local_ip=3D172.16.1.200, remote_ip=3D172.16.1.100. BPF=
 program choose
> > > > + *     the primary or secondary ip of veth1 as the local ip of tun=
nel. The
> > > > + *     choice is made based on the value of bpf map local_ip_map.
> > > > + *  3) Outer tunnel header is prepended and route the packet to ve=
th1's egress.
> > > > + *  4) veth0's ingress queue receive the tunneled packet at namesp=
ace at_ns0.
> > > > + *  5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet.
> > > > + *  6) Forward the packet to the overlay tnl dev.
> > > > + */
> > > > +
> > > > +#include <arpa/inet.h>
> > > > +#include <linux/if.h>
> > > > +#include <linux/if_tun.h>
> > > > +#include <linux/limits.h>
> > > > +#include <linux/sysctl.h>
> > > > +#include <linux/time_types.h>
> > > > +#include <linux/net_tstamp.h>
> > > > +#include <stdbool.h>
> > > > +#include <stdio.h>
> > > > +#include <sys/stat.h>
> > > > +#include <unistd.h>
> > > > +
> > > > +#include "test_progs.h"
> > > > +#include "network_helpers.h"
> > > > +#include "test_tunnel_kern.skel.h"
> > > > +
> > > > +#define IP4_ADDR_VETH0 "172.16.1.100"
> > > > +#define IP4_ADDR1_VETH1 "172.16.1.200"
> > > > +#define IP4_ADDR2_VETH1 "172.16.1.20"
> > > > +#define IP4_ADDR_TUNL_DEV0 "10.1.1.100"
> > > > +#define IP4_ADDR_TUNL_DEV1 "10.1.1.200"
> > > > +
> > > > +#define IP6_ADDR_VETH0 "::11"
> > > > +#define IP6_ADDR1_VETH1 "::22"
> > > > +#define IP6_ADDR2_VETH1 "::bb"
> > > > +
> > > > +#define IP4_ADDR1_HEX_VETH1 0xac1001c8
> > > > +#define IP4_ADDR2_HEX_VETH1 0xac100114
> > > > +#define IP6_ADDR1_HEX_VETH1 0x22
> > > > +#define IP6_ADDR2_HEX_VETH1 0xbb
> > > > +
> > > > +#define MAC_TUNL_DEV0 "52:54:00:d9:01:00"
> > > > +#define MAC_TUNL_DEV1 "52:54:00:d9:02:00"
> > > > +
> > > > +#define VXLAN_TUNL_DEV0 "vxlan00"
> > > > +#define VXLAN_TUNL_DEV1 "vxlan11"
> > > > +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> > > > +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> > > > +
> > > > +#define INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/tunnel/test_tunnel_i=
ngress"
> > > > +#define EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/tunnel/test_tunnel_eg=
ress"
> > > > +
> > > > +#define PING_ARGS "-c 3 -w 10 -q"
> > > > +
> > > > +#define SYS(fmt, ...)                                          \
> > > > +       ({                                                      \
> > > > +               char cmd[1024];                                 \
> > > > +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
> > > > +               if (!ASSERT_OK(system(cmd), cmd))               \
> > > > +                       goto fail;                              \
> > > > +       })
> > > > +
> > > > +#define SYS_NOFAIL(fmt, ...)                                   \
> > > > +       ({                                                      \
> > > > +               char cmd[1024];                                 \
> > > > +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
> > > > +               system(cmd);                                    \
> > > > +       })
> > > > +
> > > > +static int config_device(void)
> > > > +{
> > > > +       SYS("ip netns add at_ns0");
> > > > +       SYS("ip link add veth0 type veth peer name veth1");
> > > > +       SYS("ip link set veth0 netns at_ns0");
> > > > +       SYS("ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
> > > > +       SYS("ip link set dev veth1 up mtu 1500");
> > > > +       SYS("ip netns exec at_ns0 ip addr add " IP4_ADDR_VETH0 "/24=
 dev veth0");
> > > > +       SYS("ip netns exec at_ns0 ip link set dev veth0 up mtu 1500=
");
> > > > +
> > > > +       return 0;
> > > > +fail:
> > > > +       return -1;
> > > > +}
> > > > +
> > > > +static void cleanup(void)
> > > > +{
> > > > +       SYS_NOFAIL("rm -rf " INGRESS_PROG_PIN_FILE);
> > > > +       SYS_NOFAIL("rm -rf " EGRESS_PROG_PIN_FILE);
> > > > +       SYS_NOFAIL("rm -rf /sys/fs/bpf/tc/tunnel");
> > > > +
> > > > +       SYS_NOFAIL("ip netns delete at_ns0");
> > > > +       SYS_NOFAIL("ip link del veth1 2> /dev/null");
> > > > +       SYS_NOFAIL("ip link del vxlan11 2> /dev/null");
> > > > +       SYS_NOFAIL("ip link del ip6vxlan11 2> /dev/null");
> > > > +}
> > > > +
> > > > +static int add_vxlan_tunnel(char *veth1_ip)
> > > > +{
> > > > +       /*
> > > > +        * Set static ARP entry here because iptables set-mark work=
s
> > > > +        * on L3 packet, as a result not applying to ARP packets,
> > > > +        * causing errors at get_tunnel_{key/opt}.
> > > > +        */
> > > > +
> > > > +       /* at_ns0 namespace */
> > > > +       SYS("ip netns exec at_ns0 ip link add dev %s type vxlan id =
2 dstport 4789 gbp local %s remote %s",
> > > > +           VXLAN_TUNL_DEV0, IP4_ADDR_VETH0, veth1_ip);
> > > > +       SYS("ip netns exec at_ns0 ip link set dev %s address %s up"=
,
> > > > +           VXLAN_TUNL_DEV0, MAC_TUNL_DEV0);
> > > > +       SYS("ip netns exec at_ns0 ip addr add dev %s %s/24",
> > > > +           VXLAN_TUNL_DEV0, IP4_ADDR_TUNL_DEV0);
> > > > +       SYS("ip netns exec at_ns0 ip neigh add %s lladdr %s dev %s"=
,
> > > > +           IP4_ADDR_TUNL_DEV1, MAC_TUNL_DEV1, VXLAN_TUNL_DEV0);
> > > > +       SYS("ip netns exec at_ns0 iptables -A OUTPUT -j MARK --set-=
mark 0x800FF");
> > >
> > > BPF CI is failing here:
> > >
> > > add_vxlan_tunnel:FAIL:ip netns exec at_ns0 iptables -A OUTPUT -j MARK
> > > --set-mark 0x800FF unexpected error: 512 (errno 0)
> > > test_vxlan_tunnel:FAIL:add vxlan tunnel unexpected error: -1 (errno 0=
)
> > > See
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20220418013136.2=
6098-3-fankaixi.li@bytedance.com/
> > > bpf/vmtest-bpf-next-VM_Test-1 link.
> >
> > The reason is that iptables v1.8.5 (legacy): unknown option "--set-mark=
".
> > How to build and load xt_mark kernel module in the BPF CI environment ?
> > Thanks.
>
> I think our current setup doesn't support extra kernel modules. But if
> this can be built-in, we can just update kernel config (is it
> CONFIG_NETFILTER_XT_MARK?)

Thanks. I fount that it's better to use another bpf kernel prog to set
mark in namespace at_ns0 instead of iptables command.
Because only vxlan tunnel metadata sets mark. Iptables command is only
useful for vxlan tunnel.
