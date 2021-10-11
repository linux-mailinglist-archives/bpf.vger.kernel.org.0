Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E8428CC5
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhJKMOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 08:14:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:36940 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhJKMOr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 08:14:47 -0400
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mZuAg-000Edu-KS; Mon, 11 Oct 2021 14:12:46 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     roopa@nvidia.com, dsahern@kernel.org, m@lambda.lt,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next 2/4] net, neigh: Enable state migration between NUD_PERMANENT and NTF_USE
Date:   Mon, 11 Oct 2021 14:12:36 +0200
Message-Id: <20211011121238.25542-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211011121238.25542-1-daniel@iogearbox.net>
References: <20211011121238.25542-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26319/Mon Oct 11 10:18:47 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, it is not possible to migrate a neighbor entry between NUD_PERMANENT
state and NTF_USE flag with a dynamic NUD state from a user space control plane.
Similarly, it is not possible to add/remove NTF_EXT_LEARNED flag from an existing
neighbor entry in combination with NTF_USE flag.

This is due to the latter directly calling into neigh_event_send() without any
meta data updates as happening in __neigh_update(). Thus, to enable this use
case, extend the latter with a NEIGH_UPDATE_F_USE flag where we break the
NUD_PERMANENT state in particular so that a latter neigh_event_send() is able
to re-resolve a neighbor entry.

Before fix, NUD_PERMANENT -> NUD_* & NTF_USE:

  # ./ip/ip n replace 192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a PERMANENT
  [...]
  # ./ip/ip n replace 192.168.178.30 dev enp5s0 use extern_learn
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a PERMANENT
  [...]

As can be seen, despite the admin-triggered replace, the entry remains in the
NUD_PERMANENT state.

After fix, NUD_PERMANENT -> NUD_* & NTF_USE:

  # ./ip/ip n replace 192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a PERMANENT
  [...]
  # ./ip/ip n replace 192.168.178.30 dev enp5s0 use extern_learn
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a extern_learn REACHABLE
  [...]
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a extern_learn STALE
  [...]
  # ./ip/ip n replace 192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a PERMANENT
  [...]

After the fix, the admin-triggered replace switches to a dynamic state from
the NTF_USE flag which triggered a new neighbor resolution. Likewise, we can
transition back from there, if needed, into NUD_PERMANENT.

Similar before/after behavior can be observed for below transitions:

Before fix, NTF_USE -> NTF_USE | NTF_EXT_LEARNED -> NTF_USE:

  # ./ip/ip n replace 192.168.178.30 dev enp5s0 use
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a REACHABLE
  [...]
  # ./ip/ip n replace 192.168.178.30 dev enp5s0 use extern_learn
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a REACHABLE
  [...]

After fix, NTF_USE -> NTF_USE | NTF_EXT_LEARNED -> NTF_USE:

  # ./ip/ip n replace 192.168.178.30 dev enp5s0 use
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a REACHABLE
  [...]
  # ./ip/ip n replace 192.168.178.30 dev enp5s0 use extern_learn
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a extern_learn REACHABLE
  [...]
  # ./ip/ip n replace 192.168.178.30 dev enp5s0 use
  # ./ip/ip n
  192.168.178.30 dev enp5s0 lladdr f4:8c:50:5e:71:9a REACHABLE
  [..]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Roopa Prabhu <roopa@nvidia.com>
---
 include/net/neighbour.h |  1 +
 net/core/neighbour.c    | 22 +++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 22ced1381ede..eb2a7c03a5b0 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -253,6 +253,7 @@ static inline void *neighbour_priv(const struct neighbour *n)
 #define NEIGH_UPDATE_F_OVERRIDE			0x00000001
 #define NEIGH_UPDATE_F_WEAK_OVERRIDE		0x00000002
 #define NEIGH_UPDATE_F_OVERRIDE_ISROUTER	0x00000004
+#define NEIGH_UPDATE_F_USE			0x10000000
 #define NEIGH_UPDATE_F_EXT_LEARNED		0x20000000
 #define NEIGH_UPDATE_F_ISROUTER			0x40000000
 #define NEIGH_UPDATE_F_ADMIN			0x80000000
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 8457d5f97022..3e58037a8ae6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1217,7 +1217,7 @@ static void neigh_update_hhs(struct neighbour *neigh)
 				lladdr instead of overriding it
 				if it is different.
 	NEIGH_UPDATE_F_ADMIN	means that the change is administrative.
-
+	NEIGH_UPDATE_F_USE	means that the entry is user triggered.
 	NEIGH_UPDATE_F_OVERRIDE_ISROUTER allows to override existing
 				NTF_ROUTER flag.
 	NEIGH_UPDATE_F_ISROUTER	indicates if the neighbour is known as
@@ -1255,6 +1255,12 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 		goto out;
 
 	ext_learn_change = neigh_update_ext_learned(neigh, flags, &notify);
+	if (flags & NEIGH_UPDATE_F_USE) {
+		new = old & ~NUD_PERMANENT;
+		neigh->nud_state = new;
+		err = 0;
+		goto out;
+	}
 
 	if (!(new & NUD_VALID)) {
 		neigh_del_timer(neigh);
@@ -1963,22 +1969,20 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (protocol)
 		neigh->protocol = protocol;
-
 	if (ndm->ndm_flags & NTF_EXT_LEARNED)
 		flags |= NEIGH_UPDATE_F_EXT_LEARNED;
-
 	if (ndm->ndm_flags & NTF_ROUTER)
 		flags |= NEIGH_UPDATE_F_ISROUTER;
+	if (ndm->ndm_flags & NTF_USE)
+		flags |= NEIGH_UPDATE_F_USE;
 
-	if (ndm->ndm_flags & NTF_USE) {
+	err = __neigh_update(neigh, lladdr, ndm->ndm_state, flags,
+			     NETLINK_CB(skb).portid, extack);
+	if (!err && ndm->ndm_flags & NTF_USE) {
 		neigh_event_send(neigh, NULL);
 		err = 0;
-	} else
-		err = __neigh_update(neigh, lladdr, ndm->ndm_state, flags,
-				     NETLINK_CB(skb).portid, extack);
-
+	}
 	neigh_release(neigh);
-
 out:
 	return err;
 }
-- 
2.27.0

