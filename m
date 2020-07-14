Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77BF21E6A4
	for <lists+bpf@lfdr.de>; Tue, 14 Jul 2020 06:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgGNEGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jul 2020 00:06:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59524 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgGNEGx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jul 2020 00:06:53 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06E3xAgw003391
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 21:06:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2ZYkTBgcrKeuJMvhIvFc6k2w4bbLuTASMZOYeQAT9ME=;
 b=Cq0ixfjHxCkBkIOWYHPnPZRhcTWVEqlyvzue+TDfWNaqNSmkHOhrq3qMgQktY0igM/83
 4y1uCphdc3/97NUe5JZMHtOrHaCjKN7mQmJdt3hmBG2cgQPgGU2yxZKKxt8tFnDgU+GJ
 IjSq5Rwau6xHQ9O4DiHfgxYy/zjpaXUJq3M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 327b8hu5ab-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 21:06:51 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 13 Jul 2020 21:06:49 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 932FC2EC402C; Mon, 13 Jul 2020 21:06:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <dsahern@gmail.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Takshak Chahande <ctakshak@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 1/8] bpf, xdp: maintain info on attached XDP BPF programs in net_device
Date:   Mon, 13 Jul 2020 21:06:36 -0700
Message-ID: <20200714040643.1135876-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200714040643.1135876-1-andriin@fb.com>
References: <20200714040643.1135876-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_17:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 mlxlogscore=999 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140029
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of delegating to drivers, maintain information about which BPF
programs are attached in which XDP modes (generic/skb, driver, or hardwar=
e)
locally in net_device. This effectively obsoletes XDP_QUERY_PROG command.

Such re-organization simplifies existing code already. But it also allows=
 to
further add bpf_link-based XDP attachments without drivers having to know
about any of this at all, which seems like a good setup.
XDP_SETUP_PROG/XDP_SETUP_PROG_HW are just low-level commands to driver to
install/uninstall active BPF program. All the higher-level concerns about
prog/link interaction will be contained within generic driver-agnostic lo=
gic.

All the XDP_QUERY_PROG calls to driver in dev_xdp_uninstall() were remove=
d.
It's not clear for me why dev_xdp_uninstall() were passing previous prog_=
flags
when resetting installed programs. That seems unnecessary, plus most driv=
ers
don't populate prog_flags anyways. Having XDP_SETUP_PROG vs XDP_SETUP_PRO=
G_HW
should be enough of an indicator of what is required of driver to correct=
ly
reset active BPF program. dev_xdp_uninstall() is also generalized as an
iteration over all three supported mode.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/netdevice.h |  17 +++-
 net/core/dev.c            | 158 +++++++++++++++++++++-----------------
 net/core/rtnetlink.c      |   5 +-
 3 files changed, 105 insertions(+), 75 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 39e28e11863c..d5630e535836 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -887,6 +887,17 @@ struct netlink_ext_ack;
 struct xdp_umem;
 struct xdp_dev_bulk_queue;
=20
+enum bpf_xdp_mode {
+	XDP_MODE_SKB =3D 0,
+	XDP_MODE_DRV =3D 1,
+	XDP_MODE_HW =3D 2,
+	__MAX_XDP_MODE
+};
+
+struct bpf_xdp_entity {
+	struct bpf_prog *prog;
+};
+
 struct netdev_bpf {
 	enum bpf_netdev_command command;
 	union {
@@ -2134,6 +2145,9 @@ struct net_device {
 	/* MACsec management functions */
 	const struct macsec_ops *macsec_ops;
 #endif
+
+	/* protected by rtnl_lock */
+	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
=20
@@ -3809,8 +3823,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff =
*skb, struct net_device *dev,
 typedef int (*bpf_op_t)(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *ex=
tack,
 		      int fd, int expected_fd, u32 flags);
-u32 __dev_xdp_query(struct net_device *dev, bpf_op_t xdp_op,
-		    enum bpf_netdev_command cmd);
+u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 int xdp_umem_query(struct net_device *dev, u16 queue_id);
=20
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index c02bae927812..e568b1cac37f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8713,84 +8713,103 @@ int dev_change_proto_down_generic(struct net_dev=
ice *dev, bool proto_down)
 }
 EXPORT_SYMBOL(dev_change_proto_down_generic);
=20
-u32 __dev_xdp_query(struct net_device *dev, bpf_op_t bpf_op,
-		    enum bpf_netdev_command cmd)
+static enum bpf_xdp_mode dev_xdp_mode(u32 flags)
 {
-	struct netdev_bpf xdp;
+	if (flags & XDP_FLAGS_HW_MODE)
+		return XDP_MODE_HW;
+	if (flags & XDP_FLAGS_DRV_MODE)
+		return XDP_MODE_DRV;
+	return XDP_MODE_SKB;
+}
=20
-	if (!bpf_op)
-		return 0;
+static bpf_op_t dev_xdp_bpf_op(struct net_device *dev, enum bpf_xdp_mode=
 mode)
+{
+	switch (mode) {
+	case XDP_MODE_SKB:
+		return generic_xdp_install;
+	case XDP_MODE_DRV:
+	case XDP_MODE_HW:
+		return dev->netdev_ops->ndo_bpf;
+	default:
+		return NULL;
+	};
+}
=20
-	memset(&xdp, 0, sizeof(xdp));
-	xdp.command =3D cmd;
+static struct bpf_prog *dev_xdp_prog(struct net_device *dev,
+				     enum bpf_xdp_mode mode)
+{
+	return dev->xdp_state[mode].prog;
+}
+
+u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
+{
+	struct bpf_prog *prog =3D dev_xdp_prog(dev, mode);
=20
-	/* Query must always succeed. */
-	WARN_ON(bpf_op(dev, &xdp) < 0 && cmd =3D=3D XDP_QUERY_PROG);
+	return prog ? prog->aux->id : 0;
+}
=20
-	return xdp.prog_id;
+static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode m=
ode,
+			     struct bpf_prog *prog)
+{
+	dev->xdp_state[mode].prog =3D prog;
 }
=20
-static int dev_xdp_install(struct net_device *dev, bpf_op_t bpf_op,
-			   struct netlink_ext_ack *extack, u32 flags,
-			   struct bpf_prog *prog)
+static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mod=
e,
+			   bpf_op_t bpf_op, struct netlink_ext_ack *extack,
+			   u32 flags, struct bpf_prog *prog)
 {
-	bool non_hw =3D !(flags & XDP_FLAGS_HW_MODE);
-	struct bpf_prog *prev_prog =3D NULL;
 	struct netdev_bpf xdp;
 	int err;
=20
-	if (non_hw) {
-		prev_prog =3D bpf_prog_by_id(__dev_xdp_query(dev, bpf_op,
-							   XDP_QUERY_PROG));
-		if (IS_ERR(prev_prog))
-			prev_prog =3D NULL;
-	}
-
 	memset(&xdp, 0, sizeof(xdp));
-	if (flags & XDP_FLAGS_HW_MODE)
-		xdp.command =3D XDP_SETUP_PROG_HW;
-	else
-		xdp.command =3D XDP_SETUP_PROG;
+	xdp.command =3D mode =3D=3D XDP_MODE_HW ? XDP_SETUP_PROG_HW : XDP_SETUP=
_PROG;
 	xdp.extack =3D extack;
 	xdp.flags =3D flags;
 	xdp.prog =3D prog;
=20
+	/* Drivers assume refcnt is already incremented (i.e, prog pointer is
+	 * "moved" into driver), so they don't increment it on their own, but
+	 * they do decrement refcnt when program is detached or replaced.
+	 * Given net_device also owns link/prog, we need to bump refcnt here
+	 * to prevent drivers from underflowing it.
+	 */
+	if (prog)
+		bpf_prog_inc(prog);
 	err =3D bpf_op(dev, &xdp);
-	if (!err && non_hw)
-		bpf_prog_change_xdp(prev_prog, prog);
+	if (err) {
+		if (prog)
+			bpf_prog_put(prog);
+		return err;
+	}
=20
-	if (prev_prog)
-		bpf_prog_put(prev_prog);
+	if (mode !=3D XDP_MODE_HW)
+		bpf_prog_change_xdp(dev_xdp_prog(dev, mode), prog);
=20
-	return err;
+	return 0;
 }
=20
 static void dev_xdp_uninstall(struct net_device *dev)
 {
-	struct netdev_bpf xdp;
-	bpf_op_t ndo_bpf;
+	struct bpf_prog *prog;
+	enum bpf_xdp_mode mode;
+	bpf_op_t bpf_op;
=20
-	/* Remove generic XDP */
-	WARN_ON(dev_xdp_install(dev, generic_xdp_install, NULL, 0, NULL));
+	ASSERT_RTNL();
=20
-	/* Remove from the driver */
-	ndo_bpf =3D dev->netdev_ops->ndo_bpf;
-	if (!ndo_bpf)
-		return;
+	for (mode =3D XDP_MODE_SKB; mode < __MAX_XDP_MODE; mode++) {
+		prog =3D dev_xdp_prog(dev, mode);
+		if (!prog)
+			continue;
=20
-	memset(&xdp, 0, sizeof(xdp));
-	xdp.command =3D XDP_QUERY_PROG;
-	WARN_ON(ndo_bpf(dev, &xdp));
-	if (xdp.prog_id)
-		WARN_ON(dev_xdp_install(dev, ndo_bpf, NULL, xdp.prog_flags,
-					NULL));
+		bpf_op =3D dev_xdp_bpf_op(dev, mode);
+		if (!bpf_op)
+			continue;
=20
-	/* Remove HW offload */
-	memset(&xdp, 0, sizeof(xdp));
-	xdp.command =3D XDP_QUERY_PROG_HW;
-	if (!ndo_bpf(dev, &xdp) && xdp.prog_id)
-		WARN_ON(dev_xdp_install(dev, ndo_bpf, NULL, xdp.prog_flags,
-					NULL));
+		WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
+
+		bpf_prog_put(prog);
+		dev_xdp_set_prog(dev, mode, NULL);
+	}
 }
=20
 /**
@@ -8807,29 +8826,22 @@ int dev_change_xdp_fd(struct net_device *dev, str=
uct netlink_ext_ack *extack,
 		      int fd, int expected_fd, u32 flags)
 {
 	const struct net_device_ops *ops =3D dev->netdev_ops;
-	enum bpf_netdev_command query;
+	enum bpf_xdp_mode mode =3D dev_xdp_mode(flags);
+	bool offload =3D mode =3D=3D XDP_MODE_HW;
 	u32 prog_id, expected_id =3D 0;
-	bpf_op_t bpf_op, bpf_chk;
 	struct bpf_prog *prog;
-	bool offload;
+	bpf_op_t bpf_op;
 	int err;
=20
 	ASSERT_RTNL();
=20
-	offload =3D flags & XDP_FLAGS_HW_MODE;
-	query =3D offload ? XDP_QUERY_PROG_HW : XDP_QUERY_PROG;
-
-	bpf_op =3D bpf_chk =3D ops->ndo_bpf;
-	if (!bpf_op && (flags & (XDP_FLAGS_DRV_MODE | XDP_FLAGS_HW_MODE))) {
+	bpf_op =3D dev_xdp_bpf_op(dev, mode);
+	if (!bpf_op) {
 		NL_SET_ERR_MSG(extack, "underlying driver does not support XDP in nati=
ve mode");
 		return -EOPNOTSUPP;
 	}
-	if (!bpf_op || (flags & XDP_FLAGS_SKB_MODE))
-		bpf_op =3D generic_xdp_install;
-	if (bpf_op =3D=3D bpf_chk)
-		bpf_chk =3D generic_xdp_install;
=20
-	prog_id =3D __dev_xdp_query(dev, bpf_op, query);
+	prog_id =3D dev_xdp_prog_id(dev, mode);
 	if (flags & XDP_FLAGS_REPLACE) {
 		if (expected_fd >=3D 0) {
 			prog =3D bpf_prog_get_type_dev(expected_fd,
@@ -8847,8 +8859,11 @@ int dev_change_xdp_fd(struct net_device *dev, stru=
ct netlink_ext_ack *extack,
 		}
 	}
 	if (fd >=3D 0) {
-		if (!offload && __dev_xdp_query(dev, bpf_chk, XDP_QUERY_PROG)) {
-			NL_SET_ERR_MSG(extack, "native and generic XDP can't be active at the=
 same time");
+		enum bpf_xdp_mode other_mode =3D mode =3D=3D XDP_MODE_SKB
+					       ? XDP_MODE_DRV : XDP_MODE_SKB;
+
+		if (!offload && dev_xdp_prog_id(dev, other_mode)) {
+			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the=
 same time");
 			return -EEXIST;
 		}
=20
@@ -8863,7 +8878,7 @@ int dev_change_xdp_fd(struct net_device *dev, struc=
t netlink_ext_ack *extack,
 			return PTR_ERR(prog);
=20
 		if (!offload && bpf_prog_is_dev_bound(prog->aux)) {
-			NL_SET_ERR_MSG(extack, "using device-bound program without HW_MODE fl=
ag is not supported");
+			NL_SET_ERR_MSG(extack, "Using device-bound program without HW_MODE fl=
ag is not supported");
 			bpf_prog_put(prog);
 			return -EINVAL;
 		}
@@ -8885,11 +8900,14 @@ int dev_change_xdp_fd(struct net_device *dev, str=
uct netlink_ext_ack *extack,
 		prog =3D NULL;
 	}
=20
-	err =3D dev_xdp_install(dev, bpf_op, extack, flags, prog);
-	if (err < 0 && prog)
+	err =3D dev_xdp_install(dev, mode, bpf_op, extack, flags, prog);
+	if (err < 0 && prog) {
 		bpf_prog_put(prog);
+		return err;
+	}
+	dev_xdp_set_prog(dev, mode, prog);
=20
-	return err;
+	return 0;
 }
=20
 /**
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9aedc15736ad..754fdfafacb0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1416,13 +1416,12 @@ static u32 rtnl_xdp_prog_skb(struct net_device *d=
ev)
=20
 static u32 rtnl_xdp_prog_drv(struct net_device *dev)
 {
-	return __dev_xdp_query(dev, dev->netdev_ops->ndo_bpf, XDP_QUERY_PROG);
+	return dev_xdp_prog_id(dev, XDP_MODE_DRV);
 }
=20
 static u32 rtnl_xdp_prog_hw(struct net_device *dev)
 {
-	return __dev_xdp_query(dev, dev->netdev_ops->ndo_bpf,
-			       XDP_QUERY_PROG_HW);
+	return dev_xdp_prog_id(dev, XDP_MODE_HW);
 }
=20
 static int rtnl_xdp_report_one(struct sk_buff *skb, struct net_device *d=
ev,
--=20
2.24.1

