Return-Path: <bpf+bounces-4285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FD874A30A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A47281314
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E3BE49;
	Thu,  6 Jul 2023 17:25:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4928C18
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:25:19 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB5E1BE8
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:25:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-262fa79e97fso564011a91.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688664316; x=1691256316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9thjSYmHT3ZTJf6CrPRfXwdO3O4SSv98vn4jdjV7eQw=;
        b=rCMfAB/BYl8iHAQul+H2xPkPbtsVUwP3Zu/7eypPZ0yma/+xGUAhva35TYXKL4se+d
         OOLdUufPmKCAm5Q1BuaHcr0EDpXiUnqtbW+vUD6IKV0elBPoKiSM0whfk7zEeiRwKfiu
         Qgq9ZfYAhArOQ/rVvuoOQ7/c4uW7DfthiXSjGUI/S8dCQdeuvnWFjmy8VpiHy6T5eJ3T
         thOGMzoVMa0UhgBq9bJiqImTUgB1CH4UPA6swXyFctBeBryofl3jFlwTD7ayf6WSpv7v
         sGcQF5v90LMJmk/IvgGmtB9rKUCVIGM5RTUXjizDP4hREDCSQvTpa29upyrJJIuvupoJ
         huqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688664316; x=1691256316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9thjSYmHT3ZTJf6CrPRfXwdO3O4SSv98vn4jdjV7eQw=;
        b=Dfuf63+KTFt26XHPvKi/FrN/ZI9jC5K6RxCbIm6W20Au1QdbMELstuR49GAqVRZrt/
         1guU9YHELM9ereXnEHxrLQwa9fyXyb7HBNxlt9ALJH8SKGsT8SaMy62SvbrCBty7v5wv
         jM11AfW9Sto/As/4SHli3SCRpuxOm36idlw50BT5TcPq1/LxlU/QrIiNue3juqoS/pJN
         vFMKCP8/i1ukwitNC78Q1HUZkFjKATGHsvwVbO0umx6Q475RDVXfJrRqaSB1HYfwN48/
         PjDk8RAa9/YhXIT4WGl25EhF0uoF04AJSvtMaLA8gWdOt2mIcgLhvnU0Rb9bugO0vP/d
         YE+g==
X-Gm-Message-State: ABy/qLYtOGak/sBdQTGoad8K0gJtAe/zo66i5OGB61beacdkT9OI21RV
	O7lcVkKP6iOy4ANwewbxWEM9pbHubntKOBV/hetgww==
X-Google-Smtp-Source: APBJJlHPCV3AENJZ/65tW8Aj8utmndVQkfbvnrTUEuMFBAxS0bBv4aKWoUMB3vRwR6aWA51+uKpjnx/LY/EWTRGQEEY=
X-Received: by 2002:a17:90a:fa17:b0:263:fccf:8f6 with SMTP id
 cm23-20020a17090afa1700b00263fccf08f6mr1810191pjb.14.1688664315893; Thu, 06
 Jul 2023 10:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-19-larysa.zaremba@intel.com> <ZKWq142tp/tI6NI3@google.com>
 <ZKbLd8brydTvSocG@lincoln>
In-Reply-To: <ZKbLd8brydTvSocG@lincoln>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 6 Jul 2023 10:25:04 -0700
Message-ID: <CAKH8qBukk2fpJjSj2cghZxuwUB0Ey2qmE+R=Bg=0FUMdrHYG9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 18/20] selftests/bpf: Use AF_INET for TX in xdp_metadata
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 7:15=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> On Wed, Jul 05, 2023 at 10:39:35AM -0700, Stanislav Fomichev wrote:
> > On 07/03, Larysa Zaremba wrote:
> > > The easiest way to simulate stripped VLAN tag in veth is to send a pa=
cket
> > > from VLAN interface, attached to veth. Unfortunately, this approach i=
s
> > > incompatible with AF_XDP on TX side, because VLAN interfaces do not h=
ave
> > > such feature.
> > >
> > > Replace AF_XDP packet generation with sending the same datagram via
> > > AF_INET socket.
> > >
> > > This does not change the packet contents or hints values with one not=
able
> > > exception: rx_hash_type, which previously was expected to be 0, now i=
s
> > > expected be at least XDP_RSS_TYPE_L4.
> > >
> > > Also, usage of AF_INET requires a little more complicated namespace s=
etup,
> > > therefore open_netns() helper function is divided into smaller reusab=
le
> > > pieces.
> >
> > Ack, it's probably OK for now, but, FYI, I'm trying to extend this part
> > with TX metadata:
> > https://lore.kernel.org/bpf/20230621170244.1283336-10-sdf@google.com/
> >
> > So probably long-term I'll switch it back to AF_XDP but will add
> > support for requesting vlan TX "offload" from the veth.
> >
>
> My bad for not reading your series. Amazing work as always!
>
> So, 'requesting vlan TX "offload"' with new hints capabilities? This woul=
d be
> pretty neat.
>
> But you think AF_INET TX is worth keeping for now, until TX hints are mat=
ure?

It's fine to replace current af_xdp tx with whatever you're suggesting.
I can bring it back later for tx when it's ready.


> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  tools/testing/selftests/bpf/network_helpers.c |  37 +++-
> > >  tools/testing/selftests/bpf/network_helpers.h |   3 +
> > >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 175 +++++++---------=
--
> > >  3 files changed, 98 insertions(+), 117 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/te=
sting/selftests/bpf/network_helpers.c
> > > index a105c0cd008a..19463230ece5 100644
> > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > @@ -386,28 +386,51 @@ char *ping_command(int family)
> > >     return "ping";
> > >  }
> > >
> > > +int get_cur_netns(void)
> > > +{
> > > +   int nsfd;
> > > +
> > > +   nsfd =3D open("/proc/self/ns/net", O_RDONLY);
> > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > +   return nsfd;
> > > +}
> > > +
> > > +int get_netns(const char *name)
> > > +{
> > > +   char nspath[PATH_MAX];
> > > +   int nsfd;
> > > +
> > > +   snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name)=
;
> > > +   nsfd =3D open(nspath, O_RDONLY | O_CLOEXEC);
> > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > +   return nsfd;
> > > +}
> > > +
> > > +int set_netns(int netns_fd)
> > > +{
> > > +   return setns(netns_fd, CLONE_NEWNET);
> > > +}
> >
> > We have open_netns/close_netns in network_helpers.h that provide simila=
r
> > functionality, let's use them instead?
> >
>
> I have divided open_netns() into smaller pieces (see below), because the =
code I
> have added into xdp_metadata looked better with those smaller pieces (I h=
ad to
> switch namespace several times).
>
> > > +
> > >  struct nstoken {
> > >     int orig_netns_fd;
> > >  };
> > >
> > >  struct nstoken *open_netns(const char *name)
> > >  {
> > > +   struct nstoken *token;
> > >     int nsfd;
> > > -   char nspath[PATH_MAX];
> > >     int err;
> > > -   struct nstoken *token;
> > >
> > >     token =3D calloc(1, sizeof(struct nstoken));
> > >     if (!ASSERT_OK_PTR(token, "malloc token"))
> > >             return NULL;
> > >
> > > -   token->orig_netns_fd =3D open("/proc/self/ns/net", O_RDONLY);
> > > -   if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net")=
)
> > > +   token->orig_netns_fd =3D get_cur_netns();
> > > +   if (token->orig_netns_fd < 0)
> > >             goto fail;
> > >
> > > -   snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name)=
;
> > > -   nsfd =3D open(nspath, O_RDONLY | O_CLOEXEC);
> > > -   if (!ASSERT_GE(nsfd, 0, "open netns fd"))
> > > +   nsfd =3D get_netns(name);
> > > +   if (nsfd < 0)
> > >             goto fail;
> > >
> > >     err =3D setns(nsfd, CLONE_NEWNET);
> > > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/te=
sting/selftests/bpf/network_helpers.h
> > > index 694185644da6..b18b9619595c 100644
> > > --- a/tools/testing/selftests/bpf/network_helpers.h
> > > +++ b/tools/testing/selftests/bpf/network_helpers.h
> > > @@ -58,6 +58,8 @@ int make_sockaddr(int family, const char *addr_str,=
 __u16 port,
> > >  char *ping_command(int family);
> > >  int get_socket_local_port(int sock_fd);
> > >
> > > +int get_cur_netns(void);
> > > +int get_netns(const char *name);
> > >  struct nstoken;
> > >  /**
> > >   * open_netns() - Switch to specified network namespace by name.
> > > @@ -67,4 +69,5 @@ struct nstoken;
> > >   */
> > >  struct nstoken *open_netns(const char *name);
> > >  void close_netns(struct nstoken *token);
> > > +int set_netns(int netns_fd);
> > >  #endif
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/=
tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > index 626c461fa34d..53b32a641e8e 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > @@ -20,7 +20,7 @@
> > >
> > >  #define UDP_PAYLOAD_BYTES 4
> > >
> > > -#define AF_XDP_SOURCE_PORT 1234
> > > +#define UDP_SOURCE_PORT 1234
> > >  #define AF_XDP_CONSUMER_PORT 8080
> > >
> > >  #define UMEM_NUM 16
> > > @@ -33,6 +33,12 @@
> > >  #define RX_ADDR "10.0.0.2"
> > >  #define PREFIX_LEN "8"
> > >  #define FAMILY AF_INET
> > > +#define TX_NETNS_NAME "xdp_metadata_tx"
> > > +#define RX_NETNS_NAME "xdp_metadata_rx"
> > > +#define TX_MAC "00:00:00:00:00:01"
> > > +#define RX_MAC "00:00:00:00:00:02"
> > > +
> > > +#define XDP_RSS_TYPE_L4 BIT(3)
> > >
> > >  struct xsk {
> > >     void *umem_area;
> > > @@ -119,90 +125,28 @@ static void close_xsk(struct xsk *xsk)
> > >     munmap(xsk->umem_area, UMEM_SIZE);
> > >  }
> > >
> > > -static void ip_csum(struct iphdr *iph)
> > > +static int generate_packet_udp(void)
> > >  {
> > > -   __u32 sum =3D 0;
> > > -   __u16 *p;
> > > -   int i;
> > > -
> > > -   iph->check =3D 0;
> > > -   p =3D (void *)iph;
> > > -   for (i =3D 0; i < sizeof(*iph) / sizeof(*p); i++)
> > > -           sum +=3D p[i];
> > > -
> > > -   while (sum >> 16)
> > > -           sum =3D (sum & 0xffff) + (sum >> 16);
> > > -
> > > -   iph->check =3D ~sum;
> > > -}
> > > -
> > > -static int generate_packet(struct xsk *xsk, __u16 dst_port)
> > > -{
> > > -   struct xdp_desc *tx_desc;
> > > -   struct udphdr *udph;
> > > -   struct ethhdr *eth;
> > > -   struct iphdr *iph;
> > > -   void *data;
> > > -   __u32 idx;
> > > -   int ret;
> > > -
> > > -   ret =3D xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> > > -   if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
> > > -           return -1;
> > > -
> > > -   tx_desc =3D xsk_ring_prod__tx_desc(&xsk->tx, idx);
> > > -   tx_desc->addr =3D idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
> > > -   printf("%p: tx_desc[%u]->addr=3D%llx\n", xsk, idx, tx_desc->addr)=
;
> > > -   data =3D xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> > > -
> > > -   eth =3D data;
> > > -   iph =3D (void *)(eth + 1);
> > > -   udph =3D (void *)(iph + 1);
> > > -
> > > -   memcpy(eth->h_dest, "\x00\x00\x00\x00\x00\x02", ETH_ALEN);
> > > -   memcpy(eth->h_source, "\x00\x00\x00\x00\x00\x01", ETH_ALEN);
> > > -   eth->h_proto =3D htons(ETH_P_IP);
> > > -
> > > -   iph->version =3D 0x4;
> > > -   iph->ihl =3D 0x5;
> > > -   iph->tos =3D 0x9;
> > > -   iph->tot_len =3D htons(sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD=
_BYTES);
> > > -   iph->id =3D 0;
> > > -   iph->frag_off =3D 0;
> > > -   iph->ttl =3D 0;
> > > -   iph->protocol =3D IPPROTO_UDP;
> > > -   ASSERT_EQ(inet_pton(FAMILY, TX_ADDR, &iph->saddr), 1, "inet_pton(=
TX_ADDR)");
> > > -   ASSERT_EQ(inet_pton(FAMILY, RX_ADDR, &iph->daddr), 1, "inet_pton(=
RX_ADDR)");
> > > -   ip_csum(iph);
> > > -
> > > -   udph->source =3D htons(AF_XDP_SOURCE_PORT);
> > > -   udph->dest =3D htons(dst_port);
> > > -   udph->len =3D htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
> > > -   udph->check =3D 0;
> > > -
> > > -   memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
> > > -
> > > -   tx_desc->len =3D sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UD=
P_PAYLOAD_BYTES;
> > > -   xsk_ring_prod__submit(&xsk->tx, 1);
> > > -
> > > -   ret =3D sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT=
, NULL, 0);
> > > -   if (!ASSERT_GE(ret, 0, "sendto"))
> > > -           return ret;
> > > -
> > > -   return 0;
> > > -}
> > > -
> > > -static void complete_tx(struct xsk *xsk)
> > > -{
> > > -   __u32 idx;
> > > -   __u64 addr;
> > > -
> > > -   if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_r=
ing_cons__peek")) {
> > > -           addr =3D *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> > > -
> > > -           printf("%p: complete tx idx=3D%u addr=3D%llx\n", xsk, idx=
, addr);
> > > -           xsk_ring_cons__release(&xsk->comp, 1);
> > > -   }
> > > +   char udp_payload[UDP_PAYLOAD_BYTES];
> > > +   struct sockaddr_in rx_addr;
> > > +   int sock_fd, err =3D 0;
> > > +
> > > +   /* Build a packet */
> > > +   memset(udp_payload, 0xAA, UDP_PAYLOAD_BYTES);
> > > +   rx_addr.sin_addr.s_addr =3D inet_addr(RX_ADDR);
> > > +   rx_addr.sin_family =3D AF_INET;
> > > +   rx_addr.sin_port =3D htons(UDP_SOURCE_PORT);
> > > +
> > > +   sock_fd =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> > > +   if (!ASSERT_GE(sock_fd, 0, "socket(AF_INET, SOCK_DGRAM, IPPROTO_U=
DP)"))
> > > +           return sock_fd;
> > > +
> > > +   err =3D sendto(sock_fd, udp_payload, UDP_PAYLOAD_BYTES, MSG_DONTW=
AIT,
> > > +                (void *)&rx_addr, sizeof(rx_addr));
> > > +   ASSERT_GE(err, 0, "sendto");
> > > +
> > > +   close(sock_fd);
> > > +   return err;
> > >  }
> > >
> > >  static void refill_rx(struct xsk *xsk, __u64 addr)
> > > @@ -268,7 +212,8 @@ static int verify_xsk_metadata(struct xsk *xsk)
> > >     if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
> > >             return -1;
> > >
> > > -   ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
> > > +   if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash=
_type"))
> > > +           return -1;
> > >
> > >     xsk_ring_cons__release(&xsk->rx, 1);
> > >     refill_rx(xsk, comp_addr);
> > > @@ -281,40 +226,46 @@ void test_xdp_metadata(void)
> > >     struct xdp_metadata2 *bpf_obj2 =3D NULL;
> > >     struct xdp_metadata *bpf_obj =3D NULL;
> > >     struct bpf_program *new_prog, *prog;
> > > -   struct nstoken *tok =3D NULL;
> > > +   int prev_netns, rx_netns, tx_netns;
> > >     __u32 queue_id =3D QUEUE_ID;
> > >     struct bpf_map *prog_arr;
> > > -   struct xsk tx_xsk =3D {};
> > >     struct xsk rx_xsk =3D {};
> > >     __u32 val, key =3D 0;
> > >     int retries =3D 10;
> > >     int rx_ifindex;
> > > -   int tx_ifindex;
> > >     int sock_fd;
> > >     int ret;
> > >
> > > -   /* Setup new networking namespace, with a veth pair. */
> > > +   /* Setup new networking namespaces, with a veth pair. */
> > >
> > > -   SYS(out, "ip netns add xdp_metadata");
> > > -   tok =3D open_netns("xdp_metadata");
> > > +   SYS(out, "ip netns add " TX_NETNS_NAME);
> > > +   SYS(out, "ip netns add " RX_NETNS_NAME);
> > > +   prev_netns =3D get_cur_netns();
> > > +   tx_netns =3D get_netns(TX_NETNS_NAME);
> > > +   rx_netns =3D get_netns(RX_NETNS_NAME);
> > > +   if (prev_netns < 0 || tx_netns < 0 || rx_netns < 0)
> > > +           goto close_ns;
> > > +
> > > +   set_netns(tx_netns);
> > >     SYS(out, "ip link add numtxqueues 1 numrxqueues 1 " TX_NAME
> > >         " type veth peer " RX_NAME " numtxqueues 1 numrxqueues 1");
> > > -   SYS(out, "ip link set dev " TX_NAME " address 00:00:00:00:00:01")=
;
> > > -   SYS(out, "ip link set dev " RX_NAME " address 00:00:00:00:00:02")=
;
> > > +   SYS(out, "ip link set " RX_NAME " netns " RX_NETNS_NAME);
> > > +
> > > +   SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
> > >     SYS(out, "ip link set dev " TX_NAME " up");
> > > -   SYS(out, "ip link set dev " RX_NAME " up");
> > >     SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> > > -   SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
> > >
> > > +   /* Avoid ARP calls */
> > > +   SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_=
NAME);
> > > +
> > > +   set_netns(rx_netns);
> > > +   SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
> > > +   SYS(out, "ip link set dev " RX_NAME " up");
> > > +   SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
> > >     rx_ifindex =3D if_nametoindex(RX_NAME);
> > > -   tx_ifindex =3D if_nametoindex(TX_NAME);
> > >
> > >     /* Setup separate AF_XDP for TX and RX interfaces. */
> > >
> > > -   ret =3D open_xsk(tx_ifindex, &tx_xsk);
> > > -   if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
> > > -           goto out;
> > > -
> > >     ret =3D open_xsk(rx_ifindex, &rx_xsk);
> > >     if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
> > >             goto out;
> > > @@ -355,17 +306,16 @@ void test_xdp_metadata(void)
> > >             goto out;
> > >
> > >     /* Send packet destined to RX AF_XDP socket. */
> > > -   if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> > > -                  "generate AF_XDP_CONSUMER_PORT"))
> > > +   set_netns(tx_netns);
> > > +   if (!ASSERT_GE(generate_packet_udp(), 0, "generate UDP packet"))
> > >             goto out;
> > >
> > >     /* Verify AF_XDP RX packet has proper metadata. */
> > > +   set_netns(rx_netns);
> > >     if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk), 0,
> > >                    "verify_xsk_metadata"))
> > >             goto out;
> > >
> > > -   complete_tx(&tx_xsk);
> > > -
> > >     /* Make sure freplace correctly picks up original bound device
> > >      * and doesn't crash.
> > >      */
> > > @@ -384,10 +334,11 @@ void test_xdp_metadata(void)
> > >             goto out;
> > >
> > >     /* Send packet to trigger . */
> > > -   if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> > > -                  "generate freplace packet"))
> > > +   set_netns(tx_netns);
> > > +   if (!ASSERT_GE(generate_packet_udp(), 0, "generate freplace packe=
t"))
> > >             goto out;
> > >
> > > +   set_netns(rx_netns);
> > >     while (!retries--) {
> > >             if (bpf_obj2->bss->called)
> > >                     break;
> > > @@ -397,10 +348,14 @@ void test_xdp_metadata(void)
> > >
> > >  out:
> > >     close_xsk(&rx_xsk);
> > > -   close_xsk(&tx_xsk);
> > >     xdp_metadata2__destroy(bpf_obj2);
> > >     xdp_metadata__destroy(bpf_obj);
> > > -   if (tok)
> > > -           close_netns(tok);
> > > -   SYS_NOFAIL("ip netns del xdp_metadata");
> > > +   set_netns(prev_netns);
> > > +close_ns:
> > > +   close(prev_netns);
> > > +   close(tx_netns);
> > > +   close(rx_netns);
> > > +
> > > +   SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
> > > +   SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
> > >  }
> > > --
> > > 2.41.0
> > >

