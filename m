Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C462C50927D
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 00:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbiDTWJ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 18:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241241AbiDTWJ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 18:09:26 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A11902A
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 15:06:38 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id c125so3384974iof.9
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/V7olZlzc4sP790qI6SBNhhvfICx0h8CS74oEhc9lik=;
        b=OadvCVyxNJnX61VvkCWjLoLl3Ewl11b3H3bUwAcGEG1nchNwLmEmuJgsYKxPnOfNah
         nebJKl5O8/ekkE2Pw3ydzUu91HQ7ViLRAMWvgSIAcwaw8RUslF1SeRCgo3Eyuf3Sgu1v
         ViB6uLqctQNVs05ie1Y9W9p8//zK/fAorfsa0jGUNtHHgUANKe64ta5ar33zvqbJgtl/
         PQtIBzsB4zxi8oCu/TiWRtRY8CbJOBbLoyYt9SXHCRKU65PoLwCZt5/bPxYONp5K9mPa
         7vnqi+lcRnD2ticY66I+8iIi3pH0mEuHc/5Rn4TZD3I007SxAi+2NmgWAmRiCNQK5ktu
         azIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/V7olZlzc4sP790qI6SBNhhvfICx0h8CS74oEhc9lik=;
        b=zrn6ElwJrspRr0tkAl78LMMXgiEs4vY7Y9ujNgKCfVajjaNT0nR61OCoh66JXFWWeq
         KvPdckrGgvjNRVn2UHPvnkNUrsrIlfssrzEzqpxhW6wRCjIBEGlMSuoQyWglzu9qyHUi
         M9bPO44bLwjbQ+OXUYsbD3qocBAD38HqpYZ+6ML/9ogRACygb1tXg5/Xu3P+E7j594Pd
         j7zZTzaePHLW57zoq/9EJ9afXS7ZYKkOkAUoOujD+OB4qxeoX695l18+3JIpNwSOfpu7
         ZoNmOIV9cOkn2SpbVZZKFEGpjzXCETJ8PJP7STR2biC1V7qxqpc7QEf+yVMWKxYYMWs0
         VRsA==
X-Gm-Message-State: AOAM530CD64gEWwKWo3NMGY3fEOGWv02gQuoaJcWYS0FDJQVXpAs1mE0
        22ic/zM2K3ttnCbtJ2g/pJnP+KWa/U6OiynD9AM=
X-Google-Smtp-Source: ABdhPJwL7l3Mg6r1e51nqyv6XK5Y9pVGH/w4+wTEr4h5wVVma1JJinR1lZhM/zZ1jJhUo18xmZbQPSz8EAYKlsZhM4M=
X-Received: by 2002:a05:6638:16c9:b0:328:5569:fe94 with SMTP id
 g9-20020a05663816c900b003285569fe94mr11267877jat.145.1650492398102; Wed, 20
 Apr 2022 15:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220418013136.26098-1-fankaixi.li@bytedance.com>
 <20220418013136.26098-3-fankaixi.li@bytedance.com> <CAADnVQLb6OgsUU-2=uksX8kTTxsmqwHd3C3wCfftLszffX5ELQ@mail.gmail.com>
 <CAEEdnKFMH_6V2rVm8JxX=JUR+XQb1CowrZdfiT41sDVAj86qVg@mail.gmail.com>
In-Reply-To: <CAEEdnKFMH_6V2rVm8JxX=JUR+XQb1CowrZdfiT41sDVAj86qVg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 15:06:26 -0700
Message-ID: <CAEf4BzZhEV6FQRyXhCwNgJO5fpFnkxpYFjxa5u9O1B2g1NycsQ@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v4 2/3] selftests/bpf: move vxlan
 tunnel testcases to test_progs
To:     =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 20, 2022 at 1:23 AM =E8=8C=83=E5=BC=80=E5=96=9C <fankaixi.li@by=
tedance.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B44=
=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=89 00:58=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, Apr 17, 2022 at 6:32 PM <fankaixi.li@bytedance.com> wrote:
> > >
> > > From: Kaixi Fan <fankaixi.li@bytedance.com>
> > >
> > > Move vxlan tunnel testcases from test_tunnel.sh to test_progs.
> > > And add vxlan tunnel source testcases also. Other tunnel testcases
> > > will be moved to test_progs step by step in the future.
> > > Rename bpf program section name as SEC("tc") because test_progs
> > > bpf loader could not load sections with name SEC("gre_set_tunnel").
> > > Because of this, add bpftool to load bpf programs in test_tunnel.sh.
> > >
> > > Signed-off-by: Kaixi Fan <fankaixi.li@bytedance.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 461 ++++++++++++++++=
++
> > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 155 ++++--
> > >  tools/testing/selftests/bpf/test_tunnel.sh    | 124 +----
> > >  3 files changed, 577 insertions(+), 163 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tunne=
l.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/t=
ools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > new file mode 100644
> > > index 000000000000..8d3efe163f68
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> > > @@ -0,0 +1,461 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > > +
> > > +/*
> > > + * End-to-end eBPF tunnel test suite
> > > + *   The file tests BPF network tunnel implementation.
> > > + *
> > > + * Topology:
> > > + * ---------
> > > + *     root namespace   |     at_ns0 namespace
> > > + *                       |
> > > + *       -----------     |     -----------
> > > + *       | tnl dev |     |     | tnl dev |  (overlay network)
> > > + *       -----------     |     -----------
> > > + *       metadata-mode   |     native-mode
> > > + *        with bpf       |
> > > + *                       |
> > > + *       ----------      |     ----------
> > > + *       |  veth1  | --------- |  veth0  |  (underlay network)
> > > + *       ----------    peer    ----------
> > > + *
> > > + *
> > > + *  Device Configuration
> > > + *  --------------------
> > > + *  root namespace with metadata-mode tunnel + BPF
> > > + *  Device names and addresses:
> > > + *     veth1 IP 1: 172.16.1.200, IPv6: 00::22 (underlay)
> > > + *             IP 2: 172.16.1.20, IPv6: 00::bb (underlay)
> > > + *     tunnel dev <type>11, ex: gre11, IPv4: 10.1.1.200, IPv6: 1::22=
 (overlay)
> > > + *
> > > + *  Namespace at_ns0 with native tunnel
> > > + *  Device names and addresses:
> > > + *     veth0 IPv4: 172.16.1.100, IPv6: 00::11 (underlay)
> > > + *     tunnel dev <type>00, ex: gre00, IPv4: 10.1.1.100, IPv6: 1::11=
 (overlay)
> > > + *
> > > + *
> > > + * End-to-end ping packet flow
> > > + *  ---------------------------
> > > + *  Most of the tests start by namespace creation, device configurat=
ion,
> > > + *  then ping the underlay and overlay network.  When doing 'ping 10=
.1.1.100'
> > > + *  from root namespace, the following operations happen:
> > > + *  1) Route lookup shows 10.1.1.100/24 belongs to tnl dev, fwd to t=
nl dev.
> > > + *  2) Tnl device's egress BPF program is triggered and set the tunn=
el metadata,
> > > + *     with local_ip=3D172.16.1.200, remote_ip=3D172.16.1.100. BPF p=
rogram choose
> > > + *     the primary or secondary ip of veth1 as the local ip of tunne=
l. The
> > > + *     choice is made based on the value of bpf map local_ip_map.
> > > + *  3) Outer tunnel header is prepended and route the packet to veth=
1's egress.
> > > + *  4) veth0's ingress queue receive the tunneled packet at namespac=
e at_ns0.
> > > + *  5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet.
> > > + *  6) Forward the packet to the overlay tnl dev.
> > > + */
> > > +
> > > +#include <arpa/inet.h>
> > > +#include <linux/if.h>
> > > +#include <linux/if_tun.h>
> > > +#include <linux/limits.h>
> > > +#include <linux/sysctl.h>
> > > +#include <linux/time_types.h>
> > > +#include <linux/net_tstamp.h>
> > > +#include <stdbool.h>
> > > +#include <stdio.h>
> > > +#include <sys/stat.h>
> > > +#include <unistd.h>
> > > +
> > > +#include "test_progs.h"
> > > +#include "network_helpers.h"
> > > +#include "test_tunnel_kern.skel.h"
> > > +
> > > +#define IP4_ADDR_VETH0 "172.16.1.100"
> > > +#define IP4_ADDR1_VETH1 "172.16.1.200"
> > > +#define IP4_ADDR2_VETH1 "172.16.1.20"
> > > +#define IP4_ADDR_TUNL_DEV0 "10.1.1.100"
> > > +#define IP4_ADDR_TUNL_DEV1 "10.1.1.200"
> > > +
> > > +#define IP6_ADDR_VETH0 "::11"
> > > +#define IP6_ADDR1_VETH1 "::22"
> > > +#define IP6_ADDR2_VETH1 "::bb"
> > > +
> > > +#define IP4_ADDR1_HEX_VETH1 0xac1001c8
> > > +#define IP4_ADDR2_HEX_VETH1 0xac100114
> > > +#define IP6_ADDR1_HEX_VETH1 0x22
> > > +#define IP6_ADDR2_HEX_VETH1 0xbb
> > > +
> > > +#define MAC_TUNL_DEV0 "52:54:00:d9:01:00"
> > > +#define MAC_TUNL_DEV1 "52:54:00:d9:02:00"
> > > +
> > > +#define VXLAN_TUNL_DEV0 "vxlan00"
> > > +#define VXLAN_TUNL_DEV1 "vxlan11"
> > > +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> > > +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> > > +
> > > +#define INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/tunnel/test_tunnel_ing=
ress"
> > > +#define EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/tunnel/test_tunnel_egre=
ss"
> > > +
> > > +#define PING_ARGS "-c 3 -w 10 -q"
> > > +
> > > +#define SYS(fmt, ...)                                          \
> > > +       ({                                                      \
> > > +               char cmd[1024];                                 \
> > > +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
> > > +               if (!ASSERT_OK(system(cmd), cmd))               \
> > > +                       goto fail;                              \
> > > +       })
> > > +
> > > +#define SYS_NOFAIL(fmt, ...)                                   \
> > > +       ({                                                      \
> > > +               char cmd[1024];                                 \
> > > +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
> > > +               system(cmd);                                    \
> > > +       })
> > > +
> > > +static int config_device(void)
> > > +{
> > > +       SYS("ip netns add at_ns0");
> > > +       SYS("ip link add veth0 type veth peer name veth1");
> > > +       SYS("ip link set veth0 netns at_ns0");
> > > +       SYS("ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
> > > +       SYS("ip link set dev veth1 up mtu 1500");
> > > +       SYS("ip netns exec at_ns0 ip addr add " IP4_ADDR_VETH0 "/24 d=
ev veth0");
> > > +       SYS("ip netns exec at_ns0 ip link set dev veth0 up mtu 1500")=
;
> > > +
> > > +       return 0;
> > > +fail:
> > > +       return -1;
> > > +}
> > > +
> > > +static void cleanup(void)
> > > +{
> > > +       SYS_NOFAIL("rm -rf " INGRESS_PROG_PIN_FILE);
> > > +       SYS_NOFAIL("rm -rf " EGRESS_PROG_PIN_FILE);
> > > +       SYS_NOFAIL("rm -rf /sys/fs/bpf/tc/tunnel");
> > > +
> > > +       SYS_NOFAIL("ip netns delete at_ns0");
> > > +       SYS_NOFAIL("ip link del veth1 2> /dev/null");
> > > +       SYS_NOFAIL("ip link del vxlan11 2> /dev/null");
> > > +       SYS_NOFAIL("ip link del ip6vxlan11 2> /dev/null");
> > > +}
> > > +
> > > +static int add_vxlan_tunnel(char *veth1_ip)
> > > +{
> > > +       /*
> > > +        * Set static ARP entry here because iptables set-mark works
> > > +        * on L3 packet, as a result not applying to ARP packets,
> > > +        * causing errors at get_tunnel_{key/opt}.
> > > +        */
> > > +
> > > +       /* at_ns0 namespace */
> > > +       SYS("ip netns exec at_ns0 ip link add dev %s type vxlan id 2 =
dstport 4789 gbp local %s remote %s",
> > > +           VXLAN_TUNL_DEV0, IP4_ADDR_VETH0, veth1_ip);
> > > +       SYS("ip netns exec at_ns0 ip link set dev %s address %s up",
> > > +           VXLAN_TUNL_DEV0, MAC_TUNL_DEV0);
> > > +       SYS("ip netns exec at_ns0 ip addr add dev %s %s/24",
> > > +           VXLAN_TUNL_DEV0, IP4_ADDR_TUNL_DEV0);
> > > +       SYS("ip netns exec at_ns0 ip neigh add %s lladdr %s dev %s",
> > > +           IP4_ADDR_TUNL_DEV1, MAC_TUNL_DEV1, VXLAN_TUNL_DEV0);
> > > +       SYS("ip netns exec at_ns0 iptables -A OUTPUT -j MARK --set-ma=
rk 0x800FF");
> >
> > BPF CI is failing here:
> >
> > add_vxlan_tunnel:FAIL:ip netns exec at_ns0 iptables -A OUTPUT -j MARK
> > --set-mark 0x800FF unexpected error: 512 (errno 0)
> > test_vxlan_tunnel:FAIL:add vxlan tunnel unexpected error: -1 (errno 0)
> > See
> > https://patchwork.kernel.org/project/netdevbpf/patch/20220418013136.260=
98-3-fankaixi.li@bytedance.com/
> > bpf/vmtest-bpf-next-VM_Test-1 link.
>
> The reason is that iptables v1.8.5 (legacy): unknown option "--set-mark".
> How to build and load xt_mark kernel module in the BPF CI environment ?
> Thanks.

I think our current setup doesn't support extra kernel modules. But if
this can be built-in, we can just update kernel config (is it
CONFIG_NETFILTER_XT_MARK?)
