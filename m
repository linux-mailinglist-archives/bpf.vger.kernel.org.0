Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4841D213D
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 23:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgEMVjZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 17:39:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10084 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729581AbgEMVjZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 17:39:25 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DLdIgw025598
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 14:39:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=b9zRi1lmt5c53KDcEV4l+nQlRWbczYfmP1CXbSr493o=;
 b=G9/u0zZPZPR7SplVb5NHXmBML+8pVHlckbtQUfvlsRlG5az9JEgGet7ziWI406oirHGr
 4b7bG+aIRlKN6JObrSiEaxFOlbUX+CiAVmKGybaMq9Qy0P4L9gDKD/APupWNntXBKrPM
 1vJrEJssZDQSnVchiDflom5jPRXXiqDCgyg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x6yhp2-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 14:39:23 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 14:39:16 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 5FF3F370094C; Wed, 13 May 2020 14:39:10 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: Test for sk helpers in cgroup skb
Date:   Wed, 13 May 2020 14:38:40 -0700
Message-ID: <646dff71848bd93780581cf4e0f5a70f7f386966.1589405669.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589405669.git.rdna@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=13 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130185
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test bpf_sk_lookup_tcp, bpf_sk_release, bpf_sk_cgroup_id and
bpf_sk_ancestor_cgroup_id helpers from cgroup skb program.

The test creates a testing cgroup, starts a TCPv6 server inside the
cgroup and creates two client sockets: one inside testing cgroup and one
outside.

Then it attaches cgroup skb program to the cgroup that checks all TCP
segments coming to the server and allows only those coming from the
cgroup of the server. If a segment comes from a peer outside of the
cgroup, it'll be dropped.

Finally the test checks that client from inside testing cgroup can
successfully connect to the server, but client outside the cgroup fails
to connect by timeout.

The main goal of the test is to check newly introduced
bpf_sk_{,ancestor_}cgroup_id helpers.

It also checks a couple of socket lookup helpers (tcp & release), but
lookup helpers were introduced much earlier and covered by other tests.
Here it's mostly checked that they can be called from cgroup skb.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 .../bpf/prog_tests/cgroup_skb_sk_lookup.c     |  99 +++++++++++++++++
 .../bpf/progs/cgroup_skb_sk_lookup_kern.c     | 105 ++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_=
lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_sk_looku=
p_kern.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.=
c b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
new file mode 100644
index 000000000000..7ae0f49a2118
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+
+#include <test_progs.h>
+
+#include "network_helpers.h"
+#include "cgroup_skb_sk_lookup_kern.skel.h"
+
+static void run_lookup_test(int map_fd, int out_sk)
+{
+	int serv_sk =3D -1, in_sk =3D -1, serv_in_sk =3D -1, err;
+	__u32 serv_port_key =3D 0, duration =3D 0;
+	struct sockaddr_in6 addr =3D {};
+	socklen_t addr_len =3D sizeof(addr);
+
+	serv_sk =3D start_server(AF_INET6, SOCK_STREAM);
+	if (CHECK(serv_sk < 0, "start_server", "failed to start server\n"))
+		return;
+
+	err =3D getsockname(serv_sk, (struct sockaddr *)&addr, &addr_len);
+	if (CHECK(err, "getsockname", "errno %d\n", errno))
+		goto cleanup;
+
+	err =3D bpf_map_update_elem(map_fd, &serv_port_key, &addr.sin6_port, 0)=
;
+	if (CHECK(err < 0, "map_update", "errno %d", errno))
+		goto cleanup;
+
+	/* Client outside of test cgroup should fail to connect by timeout. */
+	err =3D connect_fd_to_fd(out_sk, serv_sk);
+	if (CHECK(!err || errno !=3D EINPROGRESS, "connect_fd_to_fd",
+		  "unexpected result err %d errno %d\n", err, errno))
+		goto cleanup;
+
+	err =3D connect_wait(out_sk);
+	if (CHECK(err, "connect_wait", "unexpected result %d\n", err))
+		goto cleanup;
+
+	/* Client inside test cgroup should connect just fine. */
+	in_sk =3D connect_to_fd(AF_INET6, SOCK_STREAM, serv_sk);
+	if (CHECK(in_sk < 0, "connect_to_fd", "errno %d\n", errno))
+		goto cleanup;
+
+	serv_in_sk =3D accept(serv_sk, NULL, NULL);
+	if (CHECK(serv_in_sk < 0, "accept", "errno %d\n", errno))
+		goto cleanup;
+
+cleanup:
+	close(serv_in_sk);
+	close(in_sk);
+	close(serv_sk);
+}
+
+static void run_cgroup_bpf_test(const char *cg_path, const char *bpf_fil=
e,
+				int out_sk)
+{
+	struct cgroup_skb_sk_lookup_kern *skel;
+	struct bpf_link *link;
+	__u32 duration =3D 0;
+	int cgfd =3D -1;
+
+	skel =3D cgroup_skb_sk_lookup_kern__open_and_load();
+	if (CHECK(!skel, "skel_open_load", "open_load failed\n"))
+		return;
+
+	cgfd =3D test__join_cgroup(cg_path);
+	if (CHECK(cgfd < 0, "cgroup_join", "cgroup setup failed\n"))
+		goto cleanup;
+
+	link =3D bpf_program__attach_cgroup(skel->progs.ingress_lookup, cgfd);
+	if (CHECK(IS_ERR(link), "cgroup_attach", "err: %ld\n", PTR_ERR(link)))
+		goto cleanup;
+
+	run_lookup_test(bpf_map__fd(skel->maps.serv_port), out_sk);
+
+	bpf_link__destroy(link);
+
+cleanup:
+	close(cgfd);
+	cgroup_skb_sk_lookup_kern__destroy(skel);
+}
+
+void test_cgroup_skb_sk_lookup(void)
+{
+	const char *bpf_file =3D "cgroup_skb_sk_lookup_kern.o";
+	const char *cg_path =3D "/foo";
+	int out_sk;
+
+	/* Create a socket before joining testing cgroup so that its cgroup id
+	 * differs from that of testing cgroup. Moving selftests process to
+	 * testing cgroup won't change cgroup id of an already created socket.
+	 */
+	out_sk =3D socket(AF_INET6, SOCK_STREAM | SOCK_NONBLOCK, 0);
+	if (CHECK_FAIL(out_sk < 0))
+		return;
+
+	run_cgroup_bpf_test(cg_path, bpf_file, out_sk);
+
+	close(out_sk);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.=
c b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
new file mode 100644
index 000000000000..759ee1ff8bd5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+
+#include <linux/bpf.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+int _version SEC("version") =3D 1;
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u16);
+} serv_port SEC(".maps");
+
+
+static inline void set_ip(__u32 *dst, const struct in6_addr *src)
+{
+	dst[0] =3D src->in6_u.u6_addr32[0];
+	dst[1] =3D src->in6_u.u6_addr32[1];
+	dst[2] =3D src->in6_u.u6_addr32[2];
+	dst[3] =3D src->in6_u.u6_addr32[3];
+}
+
+static inline void set_tuple(struct bpf_sock_tuple *tuple,
+			     const struct ipv6hdr *ip6h,
+			     const struct tcphdr *tcph)
+{
+	set_ip(tuple->ipv6.saddr, &ip6h->daddr);
+	set_ip(tuple->ipv6.daddr, &ip6h->saddr);
+	tuple->ipv6.sport =3D tcph->dest;
+	tuple->ipv6.dport =3D tcph->source;
+}
+
+static inline int is_allowed_peer_cg(struct __sk_buff *skb,
+				     const struct ipv6hdr *ip6h,
+				     const struct tcphdr *tcph)
+{
+	__u64 cgid, acgid, peer_cgid, peer_acgid;
+	struct bpf_sock_tuple tuple;
+	size_t tuple_len =3D sizeof(tuple.ipv6);
+	struct bpf_sock *peer_sk;
+
+	set_tuple(&tuple, ip6h, tcph);
+
+	peer_sk =3D bpf_sk_lookup_tcp(skb, &tuple, tuple_len,
+				    BPF_F_CURRENT_NETNS, 0);
+	if (!peer_sk)
+		return 0;
+
+	cgid =3D bpf_skb_cgroup_id(skb);
+	peer_cgid =3D bpf_sk_cgroup_id(peer_sk);
+
+	acgid =3D bpf_skb_ancestor_cgroup_id(skb, 2);
+	peer_acgid =3D bpf_sk_ancestor_cgroup_id(peer_sk, 2);
+
+	bpf_sk_release(peer_sk);
+
+	return cgid && cgid =3D=3D peer_cgid && acgid && acgid =3D=3D peer_acgi=
d;
+}
+
+SEC("cgroup_skb/ingress")
+int ingress_lookup(struct __sk_buff *skb)
+{
+	__u32 serv_port_key =3D 0;
+	__u16 *serv_port_val;
+	struct ipv6hdr ip6h;
+	struct tcphdr tcph;
+
+	if (skb->protocol !=3D bpf_htons(ETH_P_IPV6))
+		return 1;
+
+	/* For SYN packets coming to listening socket skb->remote_port will be
+	 * zero, so IPv6/TCP headers are loaded to identify remote peer
+	 * instead.
+	 */
+	if (bpf_skb_load_bytes(skb, 0, &ip6h, sizeof(ip6h)))
+		return 1;
+
+	if (ip6h.nexthdr !=3D IPPROTO_TCP)
+		return 1;
+
+	if (bpf_skb_load_bytes(skb, sizeof(ip6h), &tcph, sizeof(tcph)))
+		return 1;
+
+	serv_port_val =3D bpf_map_lookup_elem(&serv_port, &serv_port_key);
+	if (!serv_port_val || !*serv_port_val)
+		return 0;
+
+	if (tcph.dest !=3D *serv_port_val)
+		return 1;
+
+	return is_allowed_peer_cg(skb, &ip6h, &tcph);
+}
--=20
2.24.1

