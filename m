Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9121E6A7
	for <lists+bpf@lfdr.de>; Tue, 14 Jul 2020 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgGNEHA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jul 2020 00:07:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60632 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgGNEG6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jul 2020 00:06:58 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06E3xAvj003376
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 21:06:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Asba2ucUje8aALmwiyywXzw973B7/t+mWE8E1HX0bT0=;
 b=NzqUWRVln6AJqRFM9dk3bVARo1K1tVR++vp+ZSPY8wP6MgxqjyXdetQV3tMMC2FnyoYq
 EvNgKs8595LH/ceKbZcwL2IbK8Z2DaBJ45QSqgFIiAkhZmr01dnt49uVv6Tb4JbcuIXF
 45Hwj+23U9k+bTw8Jts2lqI36O+S4MPSkus= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 327b8hu5aq-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 21:06:57 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 13 Jul 2020 21:06:56 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 1B6062EC402C; Mon, 13 Jul 2020 21:06:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <dsahern@gmail.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Takshak Chahande <ctakshak@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 4/8] bpf, xdp: implement LINK_UPDATE for BPF XDP link
Date:   Mon, 13 Jul 2020 21:06:39 -0700
Message-ID: <20200714040643.1135876-5-andriin@fb.com>
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
 mlxlogscore=700 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140029
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for LINK_UPDATE command for BPF XDP link to enable reliable
replacement of underlying BPF program.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 net/core/dev.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4a9a9d53d844..7c2935d567c4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8989,9 +8989,52 @@ static void bpf_xdp_link_dealloc(struct bpf_link *=
link)
 	kfree(xdp_link);
 }
=20
+static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *n=
ew_prog,
+			       struct bpf_prog *old_prog)
+{
+	struct bpf_xdp_link *xdp_link =3D container_of(link, struct bpf_xdp_lin=
k, link);
+	enum bpf_xdp_mode mode;
+	bpf_op_t bpf_op;
+	int err =3D 0;
+
+	rtnl_lock();
+
+	/* link might have been auto-released already, so fail */
+	if (!xdp_link->dev) {
+		err =3D -ENOLINK;
+		goto out_unlock;
+	}
+
+	if (old_prog && link->prog !=3D old_prog) {
+		err =3D -EPERM;
+		goto out_unlock;
+	}
+	old_prog =3D link->prog;
+	if (old_prog =3D=3D new_prog) {
+		/* no-op, don't disturb drivers */
+		bpf_prog_put(new_prog);
+		goto out_unlock;
+	}
+
+	mode =3D dev_xdp_mode(xdp_link->flags);
+	bpf_op =3D dev_xdp_bpf_op(xdp_link->dev, mode);
+	err =3D dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
+			      xdp_link->flags, new_prog);
+	if (err)
+		goto out_unlock;
+
+	old_prog =3D xchg(&link->prog, new_prog);
+	bpf_prog_put(old_prog);
+
+out_unlock:
+	rtnl_unlock();
+	return err;
+}
+
 static const struct bpf_link_ops bpf_xdp_link_lops =3D {
 	.release =3D bpf_xdp_link_release,
 	.dealloc =3D bpf_xdp_link_dealloc,
+	.update_prog =3D bpf_xdp_link_update,
 };
=20
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pro=
g)
--=20
2.24.1

