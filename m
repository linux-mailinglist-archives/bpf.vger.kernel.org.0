Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05C053AF8D
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 00:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiFAU4O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiFAU4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 16:56:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C841FA7
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 13:56:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251IbY7Q008407
        for <bpf@vger.kernel.org>; Wed, 1 Jun 2022 13:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ISZTSov+VbtkkWLimJwz0aGkaJWXaQ5M/SkYnHQvNlg=;
 b=AMPo+UNWBWeWo1h0fCIfmsh0cM54+yYQHxEPJsZKReUUljetw378JAXVVDTm0pEbIbi+
 7V/tbLkqc5pmzlbZ/QhlCDpWOJhdUq1dn8s4O+HlBNZZ4Oc/1wUfysBciNprcgzPwjy5
 P/Q1QaD3qL5/HQkByqcIhaBb8QW4H8Epl6M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge5vcm05k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 13:19:48 -0700
Received: from twshared18317.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 13:19:47 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id E19A3D254C26; Wed,  1 Jun 2022 13:16:54 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <edumazet@google.com>, <kafai@fb.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <testing@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
        <syzbot+015d756bbd1f8b5c8f09@syzkaller.appspotmail.com>,
        Eric Dumazet <edumzet@google.com>
Subject: [PATCH net-next v1 resend 1/2] net: Update bhash2 when socket's rcv saddr changes
Date:   Wed, 1 Jun 2022 13:14:33 -0700
Message-ID: <20220601201434.1710931-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601201434.1710931-1-joannekoong@fb.com>
References: <20220601201434.1710931-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: o25g5JbZMa95h-YsGYP25CDgrnvxTRh-
X-Proofpoint-ORIG-GUID: o25g5JbZMa95h-YsGYP25CDgrnvxTRh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_07,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

Commit d5a42de8bdbe ("net: Add a second bind table hashed by port and
address") added a second bind table, bhash2, that hashes by a socket's po=
rt
and rcv address.

However, there are two cases where the socket's rcv saddr can change
after it has been binded:

1) The case where there is a bind() call on "::" (IPADDR_ANY) and then
a connect() call. The kernel will assign the socket an address when it
handles the connect()

2) In inet_sk_reselect_saddr(), which is called when rerouting fails
when rebuilding the sk header (invoked by inet_sk_rebuild_header)

In these two cases, we need to update the bhash2 table by removing the
entry for the old address, and adding a new entry reflecting the updated
address.

Reported-by: syzbot+015d756bbd1f8b5c8f09@syzkaller.appspotmail.com
Fixes: d5a42de8bdbe ("net: Add a second bind table hashed by port and add=
ress")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Eric Dumazet <edumzet@google.com>
---
 include/net/inet_hashtables.h |  6 ++-
 include/net/ipv6.h            |  2 +-
 net/dccp/ipv4.c               | 10 +++--
 net/dccp/ipv6.c               |  4 +-
 net/ipv4/af_inet.c            |  7 +++-
 net/ipv4/inet_hashtables.c    | 69 ++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_ipv4.c           |  8 +++-
 net/ipv6/inet6_hashtables.c   |  4 +-
 net/ipv6/tcp_ipv6.c           |  4 +-
 9 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
index a0887b70967b..2c331ce6ca73 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -448,11 +448,13 @@ static inline void sk_rcv_saddr_set(struct sock *sk=
, __be32 addr)
 }
=20
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
-			struct sock *sk, u64 port_offset,
+			struct sock *sk, u64 port_offset, bool prev_inaddr_any,
 			int (*check_established)(struct inet_timewait_death_row *,
 						 struct sock *, __u16,
 						 struct inet_timewait_sock **));
=20
 int inet_hash_connect(struct inet_timewait_death_row *death_row,
-		      struct sock *sk);
+		      struct sock *sk, bool prev_inaddr_any);
+
+int inet_bhash2_update_saddr(struct sock *sk);
 #endif /* _INET_HASHTABLES_H */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 5b38bf1a586b..6a50aca56d50 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1187,7 +1187,7 @@ int inet6_compat_ioctl(struct socket *sock, unsigne=
d int cmd,
 		unsigned long arg);
=20
 int inet6_hash_connect(struct inet_timewait_death_row *death_row,
-			      struct sock *sk);
+		       struct sock *sk, bool prev_inaddr_any);
 int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
 int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		  int flags);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index da6e3b20cd75..37a8bc3ee49e 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -47,12 +47,13 @@ int dccp_v4_connect(struct sock *sk, struct sockaddr =
*uaddr, int addr_len)
 	const struct sockaddr_in *usin =3D (struct sockaddr_in *)uaddr;
 	struct inet_sock *inet =3D inet_sk(sk);
 	struct dccp_sock *dp =3D dccp_sk(sk);
+	struct ip_options_rcu *inet_opt;
 	__be16 orig_sport, orig_dport;
+	bool prev_inaddr_any =3D false;
 	__be32 daddr, nexthop;
 	struct flowi4 *fl4;
 	struct rtable *rt;
 	int err;
-	struct ip_options_rcu *inet_opt;
=20
 	dp->dccps_role =3D DCCP_ROLE_CLIENT;
=20
@@ -89,8 +90,11 @@ int dccp_v4_connect(struct sock *sk, struct sockaddr *=
uaddr, int addr_len)
 	if (inet_opt =3D=3D NULL || !inet_opt->opt.srr)
 		daddr =3D fl4->daddr;
=20
-	if (inet->inet_saddr =3D=3D 0)
+	if (inet->inet_saddr =3D=3D 0) {
 		inet->inet_saddr =3D fl4->saddr;
+		prev_inaddr_any =3D true;
+	}
+
 	sk_rcv_saddr_set(sk, inet->inet_saddr);
 	inet->inet_dport =3D usin->sin_port;
 	sk_daddr_set(sk, daddr);
@@ -105,7 +109,7 @@ int dccp_v4_connect(struct sock *sk, struct sockaddr =
*uaddr, int addr_len)
 	 * complete initialization after this.
 	 */
 	dccp_set_state(sk, DCCP_REQUESTING);
-	err =3D inet_hash_connect(&dccp_death_row, sk);
+	err =3D inet_hash_connect(&dccp_death_row, sk, prev_inaddr_any);
 	if (err !=3D 0)
 		goto failure;
=20
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index fd44638ec16b..03013522acab 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -824,6 +824,7 @@ static int dccp_v6_connect(struct sock *sk, struct so=
ckaddr *uaddr,
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
 	struct dccp_sock *dp =3D dccp_sk(sk);
 	struct in6_addr *saddr =3D NULL, *final_p, final;
+	bool prev_inaddr_any =3D false;
 	struct ipv6_txoptions *opt;
 	struct flowi6 fl6;
 	struct dst_entry *dst;
@@ -936,6 +937,7 @@ static int dccp_v6_connect(struct sock *sk, struct so=
ckaddr *uaddr,
 	if (saddr =3D=3D NULL) {
 		saddr =3D &fl6.saddr;
 		sk->sk_v6_rcv_saddr =3D *saddr;
+		prev_inaddr_any =3D true;
 	}
=20
 	/* set the source address */
@@ -951,7 +953,7 @@ static int dccp_v6_connect(struct sock *sk, struct so=
ckaddr *uaddr,
 	inet->inet_dport =3D usin->sin6_port;
=20
 	dccp_set_state(sk, DCCP_REQUESTING);
-	err =3D inet6_hash_connect(&dccp_death_row, sk);
+	err =3D inet6_hash_connect(&dccp_death_row, sk, prev_inaddr_any);
 	if (err)
 		goto late_failure;
=20
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 93da9f783bec..ad627a99ff9d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1221,10 +1221,11 @@ static int inet_sk_reselect_saddr(struct sock *sk=
)
 	struct inet_sock *inet =3D inet_sk(sk);
 	__be32 old_saddr =3D inet->inet_saddr;
 	__be32 daddr =3D inet->inet_daddr;
+	struct ip_options_rcu *inet_opt;
 	struct flowi4 *fl4;
 	struct rtable *rt;
 	__be32 new_saddr;
-	struct ip_options_rcu *inet_opt;
+	int err;
=20
 	inet_opt =3D rcu_dereference_protected(inet->inet_opt,
 					     lockdep_sock_is_held(sk));
@@ -1253,6 +1254,10 @@ static int inet_sk_reselect_saddr(struct sock *sk)
=20
 	inet->inet_saddr =3D inet->inet_rcv_saddr =3D new_saddr;
=20
+	err =3D inet_bhash2_update_saddr(sk);
+	if (err)
+		return err;
+
 	/*
 	 * XXX The only one ugly spot where we need to
 	 * XXX really change the sockets identity after
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e8de5e699b3f..0b43a30b6363 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -826,6 +826,54 @@ inet_bind2_bucket_find(struct inet_hashinfo *hinfo, =
struct net *net,
 	return bhash2;
 }
=20
+/* the lock for the socket's corresponding bhash entry must be held */
+int __inet_bhash2_update_saddr(struct sock *sk, struct inet_hashinfo *hi=
nfo,
+			       struct net *net, int port, int l3mdev)
+{
+	struct inet_bind2_hashbucket *head2;
+	struct inet_bind2_bucket *tb2;
+
+	tb2 =3D inet_bind2_bucket_find(hinfo, net, port, l3mdev, sk,
+				     &head2);
+	if (!tb2) {
+		tb2 =3D inet_bind2_bucket_create(hinfo->bind2_bucket_cachep,
+					       net, head2, port, l3mdev, sk);
+		if (!tb2)
+			return -ENOMEM;
+	}
+
+	/* Remove the socket's old entry from bhash2 */
+	__sk_del_bind2_node(sk);
+
+	sk_add_bind2_node(sk, &tb2->owners);
+	inet_csk(sk)->icsk_bind2_hash =3D tb2;
+
+	return 0;
+}
+
+/* This should be called if/when a socket's rcv saddr changes after it h=
as
+ * been binded.
+ */
+int inet_bhash2_update_saddr(struct sock *sk)
+{
+	struct inet_hashinfo *hinfo =3D sk->sk_prot->h.hashinfo;
+	int l3mdev =3D inet_sk_bound_l3mdev(sk);
+	struct inet_bind_hashbucket *head;
+	int port =3D inet_sk(sk)->inet_num;
+	struct net *net =3D sock_net(sk);
+	int err;
+
+	head =3D &hinfo->bhash[inet_bhashfn(net, port, hinfo->bhash_size)];
+
+	spin_lock_bh(&head->lock);
+
+	err =3D __inet_bhash2_update_saddr(sk, hinfo, net, port, l3mdev);
+
+	spin_unlock_bh(&head->lock);
+
+	return err;
+}
+
 /* RFC 6056 3.3.4.  Algorithm 4: Double-Hash Port Selection Algorithm
  * Note that we use 32bit integers (vs RFC 'short integers')
  * because 2^16 is not a multiple of num_ephemeral and this
@@ -840,7 +888,7 @@ inet_bind2_bucket_find(struct inet_hashinfo *hinfo, s=
truct net *net,
 static u32 *table_perturb;
=20
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
-		struct sock *sk, u64 port_offset,
+		struct sock *sk, u64 port_offset, bool prev_inaddr_any,
 		int (*check_established)(struct inet_timewait_death_row *,
 			struct sock *, __u16, struct inet_timewait_sock **))
 {
@@ -858,11 +906,24 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
 	int l3mdev;
 	u32 index;
=20
+	l3mdev =3D inet_sk_bound_l3mdev(sk);
+
 	if (port) {
 		head =3D &hinfo->bhash[inet_bhashfn(net, port,
 						  hinfo->bhash_size)];
 		tb =3D inet_csk(sk)->icsk_bind_hash;
+
 		spin_lock_bh(&head->lock);
+
+		if (prev_inaddr_any) {
+			ret =3D __inet_bhash2_update_saddr(sk, hinfo, net, port,
+							 l3mdev);
+			if (ret) {
+				spin_unlock_bh(&head->lock);
+				return ret;
+			}
+		}
+
 		if (sk_head(&tb->owners) =3D=3D sk && !sk->sk_bind_node.next) {
 			inet_ehash_nolisten(sk, NULL, NULL);
 			spin_unlock_bh(&head->lock);
@@ -875,8 +936,6 @@ int __inet_hash_connect(struct inet_timewait_death_ro=
w *death_row,
 		return ret;
 	}
=20
-	l3mdev =3D inet_sk_bound_l3mdev(sk);
-
 	inet_get_local_port_range(net, &low, &high);
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	remaining =3D high - low;
@@ -987,13 +1046,13 @@ int __inet_hash_connect(struct inet_timewait_death=
_row *death_row,
  * Bind a port for a connect operation and hash it.
  */
 int inet_hash_connect(struct inet_timewait_death_row *death_row,
-		      struct sock *sk)
+		      struct sock *sk, bool prev_inaddr_any)
 {
 	u64 port_offset =3D 0;
=20
 	if (!inet_sk(sk)->inet_num)
 		port_offset =3D inet_sk_port_offset(sk);
-	return __inet_hash_connect(death_row, sk, port_offset,
+	return __inet_hash_connect(death_row, sk, port_offset, prev_inaddr_any,
 				   __inet_check_established);
 }
 EXPORT_SYMBOL_GPL(inet_hash_connect);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index dac2650f3863..adf8d750933d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -203,6 +203,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *=
uaddr, int addr_len)
 	struct inet_sock *inet =3D inet_sk(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	__be16 orig_sport, orig_dport;
+	bool prev_inaddr_any =3D false;
 	__be32 daddr, nexthop;
 	struct flowi4 *fl4;
 	struct rtable *rt;
@@ -246,8 +247,11 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr =
*uaddr, int addr_len)
 	if (!inet_opt || !inet_opt->opt.srr)
 		daddr =3D fl4->daddr;
=20
-	if (!inet->inet_saddr)
+	if (!inet->inet_saddr) {
 		inet->inet_saddr =3D fl4->saddr;
+		prev_inaddr_any =3D true;
+	}
+
 	sk_rcv_saddr_set(sk, inet->inet_saddr);
=20
 	if (tp->rx_opt.ts_recent_stamp && inet->inet_daddr !=3D daddr) {
@@ -273,7 +277,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *=
uaddr, int addr_len)
 	 * complete initialization after this.
 	 */
 	tcp_set_state(sk, TCP_SYN_SENT);
-	err =3D inet_hash_connect(tcp_death_row, sk);
+	err =3D inet_hash_connect(tcp_death_row, sk, prev_inaddr_any);
 	if (err)
 		goto failure;
=20
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 7d53d62783b1..c87c5933f3be 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -317,13 +317,13 @@ static u64 inet6_sk_port_offset(const struct sock *=
sk)
 }
=20
 int inet6_hash_connect(struct inet_timewait_death_row *death_row,
-		       struct sock *sk)
+		       struct sock *sk, bool prev_inaddr_any)
 {
 	u64 port_offset =3D 0;
=20
 	if (!inet_sk(sk)->inet_num)
 		port_offset =3D inet6_sk_port_offset(sk);
-	return __inet_hash_connect(death_row, sk, port_offset,
+	return __inet_hash_connect(death_row, sk, port_offset, prev_inaddr_any,
 				   __inet6_check_established);
 }
 EXPORT_SYMBOL_GPL(inet6_hash_connect);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f37dd4aa91c6..81e3312c2a97 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -152,6 +152,7 @@ static int tcp_v6_connect(struct sock *sk, struct soc=
kaddr *uaddr,
 	struct ipv6_pinfo *np =3D tcp_inet6_sk(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct in6_addr *saddr =3D NULL, *final_p, final;
+	bool prev_inaddr_any =3D false;
 	struct ipv6_txoptions *opt;
 	struct flowi6 fl6;
 	struct dst_entry *dst;
@@ -289,6 +290,7 @@ static int tcp_v6_connect(struct sock *sk, struct soc=
kaddr *uaddr,
 	if (!saddr) {
 		saddr =3D &fl6.saddr;
 		sk->sk_v6_rcv_saddr =3D *saddr;
+		prev_inaddr_any =3D true;
 	}
=20
 	/* set the source address */
@@ -309,7 +311,7 @@ static int tcp_v6_connect(struct sock *sk, struct soc=
kaddr *uaddr,
=20
 	tcp_set_state(sk, TCP_SYN_SENT);
 	tcp_death_row =3D sock_net(sk)->ipv4.tcp_death_row;
-	err =3D inet6_hash_connect(tcp_death_row, sk);
+	err =3D inet6_hash_connect(tcp_death_row, sk, prev_inaddr_any);
 	if (err)
 		goto late_failure;
=20
--=20
2.30.2

