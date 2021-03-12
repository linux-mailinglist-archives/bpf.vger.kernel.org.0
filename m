Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4313397AE
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 20:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhCLTrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 14:47:11 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:47834 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhCLTqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 14:46:47 -0500
Date:   Fri, 12 Mar 2021 19:46:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1615578405; bh=y08+KCobzV3SDgaQzIT4dZTOPDT0bHx83vakd/J4zjY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=S0XaeNhkp47S4IbdlzhxcdlXwqjbSHSyUcdS9dNLTu+DNLzeNWCzH7u662yWvqXAb
         yTZU4NAcUlHixxZW1t52HQa26w0CL/dDIa+ElRKqVyC5o5/i8EPwC06LgQKTAJBUfJ
         v13WEBLK4gym+jNrsdZO51RSs/spqZpxsrWEhlHiRYMD1aiToD3APhLjQdSUIoCzJR
         WLNAifIgcJRy4ZhRzJhiBLbHE0l+xpQhbBVRpM3kp4U9Bkh8IiH0mTIM2s+eYznCxi
         AdtHHt9XF85DDMi4H/NmdWf92xFC4gwWm+xOgswPuncgrfTYmn9ihBOE9VmCkB1JNI
         tmunWDYqQ8Lew==
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kevin Hao <haokexin@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Dexuan Cui <decui@microsoft.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Wang Qing <wangqing@vivo.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH net-next 3/6] flow_dissector: constify raw input @data argument
Message-ID: <20210312194538.337504-4-alobakin@pm.me>
In-Reply-To: <20210312194538.337504-1-alobakin@pm.me>
References: <20210312194538.337504-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Flow Dissector code never modifies the input buffer, neither skb nor
raw data.
Make @data argument const for all of the Flow dissector's functions.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 include/linux/skbuff.h       | 15 ++++++-------
 include/net/flow_dissector.h |  2 +-
 net/core/flow_dissector.c    | 41 +++++++++++++++++++-----------------
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d93ab74063e5..7873f24c0ae5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1292,10 +1292,10 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, =
bool is_l4)
 void __skb_get_hash(struct sk_buff *skb);
 u32 __skb_get_hash_symmetric(const struct sk_buff *skb);
 u32 skb_get_poff(const struct sk_buff *skb);
-u32 __skb_get_poff(const struct sk_buff *skb, void *data,
+u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
 =09=09   const struct flow_keys_basic *keys, int hlen);
 __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_pr=
oto,
-=09=09=09    void *data, int hlen_proto);
+=09=09=09    const void *data, int hlen_proto);

 static inline __be32 skb_flow_get_ports(const struct sk_buff *skb,
 =09=09=09=09=09int thoff, u8 ip_proto)
@@ -1314,9 +1314,8 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct b=
pf_flow_dissector *ctx,
 bool __skb_flow_dissect(const struct net *net,
 =09=09=09const struct sk_buff *skb,
 =09=09=09struct flow_dissector *flow_dissector,
-=09=09=09void *target_container,
-=09=09=09void *data, __be16 proto, int nhoff, int hlen,
-=09=09=09unsigned int flags);
+=09=09=09void *target_container, const void *data,
+=09=09=09__be16 proto, int nhoff, int hlen, unsigned int flags);

 static inline bool skb_flow_dissect(const struct sk_buff *skb,
 =09=09=09=09    struct flow_dissector *flow_dissector,
@@ -1338,9 +1337,9 @@ static inline bool skb_flow_dissect_flow_keys(const s=
truct sk_buff *skb,
 static inline bool
 skb_flow_dissect_flow_keys_basic(const struct net *net,
 =09=09=09=09 const struct sk_buff *skb,
-=09=09=09=09 struct flow_keys_basic *flow, void *data,
-=09=09=09=09 __be16 proto, int nhoff, int hlen,
-=09=09=09=09 unsigned int flags)
+=09=09=09=09 struct flow_keys_basic *flow,
+=09=09=09=09 const void *data, __be16 proto,
+=09=09=09=09 int nhoff, int hlen, unsigned int flags)
 {
 =09memset(flow, 0, sizeof(*flow));
 =09return __skb_flow_dissect(net, skb, &flow_keys_basic_dissector, flow,
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index bf00e71816ed..ffd386ea0dbb 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -350,7 +350,7 @@ static inline bool flow_keys_have_l4(const struct flow_=
keys *keys)
 u32 flow_hash_from_keys(struct flow_keys *keys);
 void skb_flow_get_icmp_tci(const struct sk_buff *skb,
 =09=09=09   struct flow_dissector_key_icmp *key_icmp,
-=09=09=09   void *data, int thoff, int hlen);
+=09=09=09   const void *data, int thoff, int hlen);

 static inline bool dissector_uses_key(const struct flow_dissector *flow_di=
ssector,
 =09=09=09=09      enum flow_dissector_key_id key_id)
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2ef2224b3bff..2ed380d096ce 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -114,7 +114,7 @@ int flow_dissector_bpf_prog_attach_check(struct net *ne=
t,
  * is the protocol port offset returned from proto_ports_offset
  */
 __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_pr=
oto,
-=09=09=09    void *data, int hlen)
+=09=09=09    const void *data, int hlen)
 {
 =09int poff =3D proto_ports_offset(ip_proto);

@@ -161,7 +161,7 @@ static bool icmp_has_id(u8 type)
  */
 void skb_flow_get_icmp_tci(const struct sk_buff *skb,
 =09=09=09   struct flow_dissector_key_icmp *key_icmp,
-=09=09=09   void *data, int thoff, int hlen)
+=09=09=09   const void *data, int thoff, int hlen)
 {
 =09struct icmphdr *ih, _ih;

@@ -187,8 +187,8 @@ EXPORT_SYMBOL(skb_flow_get_icmp_tci);
  */
 static void __skb_flow_dissect_icmp(const struct sk_buff *skb,
 =09=09=09=09    struct flow_dissector *flow_dissector,
-=09=09=09=09    void *target_container,
-=09=09=09=09    void *data, int thoff, int hlen)
+=09=09=09=09    void *target_container, const void *data,
+=09=09=09=09    int thoff, int hlen)
 {
 =09struct flow_dissector_key_icmp *key_icmp;

@@ -409,8 +409,8 @@ EXPORT_SYMBOL(skb_flow_dissect_hash);
 static enum flow_dissect_ret
 __skb_flow_dissect_mpls(const struct sk_buff *skb,
 =09=09=09struct flow_dissector *flow_dissector,
-=09=09=09void *target_container, void *data, int nhoff, int hlen,
-=09=09=09int lse_index, bool *entropy_label)
+=09=09=09void *target_container, const void *data, int nhoff,
+=09=09=09int hlen, int lse_index, bool *entropy_label)
 {
 =09struct mpls_label *hdr, _hdr;
 =09u32 entry, label, bos;
@@ -467,7 +467,8 @@ __skb_flow_dissect_mpls(const struct sk_buff *skb,
 static enum flow_dissect_ret
 __skb_flow_dissect_arp(const struct sk_buff *skb,
 =09=09       struct flow_dissector *flow_dissector,
-=09=09       void *target_container, void *data, int nhoff, int hlen)
+=09=09       void *target_container, const void *data,
+=09=09       int nhoff, int hlen)
 {
 =09struct flow_dissector_key_arp *key_arp;
 =09struct {
@@ -523,7 +524,7 @@ static enum flow_dissect_ret
 __skb_flow_dissect_gre(const struct sk_buff *skb,
 =09=09       struct flow_dissector_key_control *key_control,
 =09=09       struct flow_dissector *flow_dissector,
-=09=09       void *target_container, void *data,
+=09=09       void *target_container, const void *data,
 =09=09       __be16 *p_proto, int *p_nhoff, int *p_hlen,
 =09=09       unsigned int flags)
 {
@@ -663,8 +664,8 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 static enum flow_dissect_ret
 __skb_flow_dissect_batadv(const struct sk_buff *skb,
 =09=09=09  struct flow_dissector_key_control *key_control,
-=09=09=09  void *data, __be16 *p_proto, int *p_nhoff, int hlen,
-=09=09=09  unsigned int flags)
+=09=09=09  const void *data, __be16 *p_proto, int *p_nhoff,
+=09=09=09  int hlen, unsigned int flags)
 {
 =09struct {
 =09=09struct batadv_unicast_packet batadv_unicast;
@@ -695,7 +696,8 @@ __skb_flow_dissect_batadv(const struct sk_buff *skb,
 static void
 __skb_flow_dissect_tcp(const struct sk_buff *skb,
 =09=09       struct flow_dissector *flow_dissector,
-=09=09       void *target_container, void *data, int thoff, int hlen)
+=09=09       void *target_container, const void *data,
+=09=09       int thoff, int hlen)
 {
 =09struct flow_dissector_key_tcp *key_tcp;
 =09struct tcphdr *th, _th;
@@ -719,8 +721,8 @@ __skb_flow_dissect_tcp(const struct sk_buff *skb,
 static void
 __skb_flow_dissect_ports(const struct sk_buff *skb,
 =09=09=09 struct flow_dissector *flow_dissector,
-=09=09=09 void *target_container, void *data, int nhoff,
-=09=09=09 u8 ip_proto, int hlen)
+=09=09=09 void *target_container, const void *data,
+=09=09=09 int nhoff, u8 ip_proto, int hlen)
 {
 =09enum flow_dissector_key_id dissector_ports =3D FLOW_DISSECTOR_KEY_MAX;
 =09struct flow_dissector_key_ports *key_ports;
@@ -744,7 +746,8 @@ __skb_flow_dissect_ports(const struct sk_buff *skb,
 static void
 __skb_flow_dissect_ipv4(const struct sk_buff *skb,
 =09=09=09struct flow_dissector *flow_dissector,
-=09=09=09void *target_container, void *data, const struct iphdr *iph)
+=09=09=09void *target_container, const void *data,
+=09=09=09const struct iphdr *iph)
 {
 =09struct flow_dissector_key_ip *key_ip;

@@ -761,7 +764,8 @@ __skb_flow_dissect_ipv4(const struct sk_buff *skb,
 static void
 __skb_flow_dissect_ipv6(const struct sk_buff *skb,
 =09=09=09struct flow_dissector *flow_dissector,
-=09=09=09void *target_container, void *data, const struct ipv6hdr *iph)
+=09=09=09void *target_container, const void *data,
+=09=09=09const struct ipv6hdr *iph)
 {
 =09struct flow_dissector_key_ip *key_ip;

@@ -908,9 +912,8 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf=
_flow_dissector *ctx,
 bool __skb_flow_dissect(const struct net *net,
 =09=09=09const struct sk_buff *skb,
 =09=09=09struct flow_dissector *flow_dissector,
-=09=09=09void *target_container,
-=09=09=09void *data, __be16 proto, int nhoff, int hlen,
-=09=09=09unsigned int flags)
+=09=09=09void *target_container, const void *data,
+=09=09=09__be16 proto, int nhoff, int hlen, unsigned int flags)
 {
 =09struct flow_dissector_key_control *key_control;
 =09struct flow_dissector_key_basic *key_basic;
@@ -1642,7 +1645,7 @@ __u32 skb_get_hash_perturb(const struct sk_buff *skb,
 }
 EXPORT_SYMBOL(skb_get_hash_perturb);

-u32 __skb_get_poff(const struct sk_buff *skb, void *data,
+u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
 =09=09   const struct flow_keys_basic *keys, int hlen)
 {
 =09u32 poff =3D keys->control.thoff;
--
2.30.2


