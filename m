Return-Path: <bpf+bounces-11332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C177B75B0
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 02:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id F09FD1F21A96
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071EF376;
	Wed,  4 Oct 2023 00:18:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E17E
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 00:18:17 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC28E
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 17:18:15 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393KV7vo005284
	for <bpf@vger.kernel.org>; Tue, 3 Oct 2023 17:18:15 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tg7byr2p0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 17:18:14 -0700
Received: from twshared15338.14.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 3 Oct 2023 17:18:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 0B25A39214DF8; Tue,  3 Oct 2023 17:17:53 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: fix compiler warnings reported in -O2 mode
Date: Tue, 3 Oct 2023 17:17:48 -0700
Message-ID: <20231004001750.2939898-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8CBsvlVMQ9swDfOLWlCN2geIXP0xHhEq
X-Proofpoint-ORIG-GUID: 8CBsvlVMQ9swDfOLWlCN2geIXP0xHhEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_19,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix a bunch of potentially unitialized variable usage warnings that are
reported by GCC in -O2 mode. Also silence overzealous stringop-truncation
class of warnings.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                      | 4 +++-
 .../selftests/bpf/map_tests/map_in_map_batch_ops.c        | 4 ++--
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c | 4 ++--
 tools/testing/selftests/bpf/prog_tests/connect_ping.c     | 4 ++--
 tools/testing/selftests/bpf/prog_tests/linked_list.c      | 2 +-
 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h      | 3 ++-
 tools/testing/selftests/bpf/prog_tests/queue_stack_map.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c    | 8 ++++----
 tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h  | 2 +-
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c   | 4 ++--
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c     | 2 +-
 tools/testing/selftests/bpf/test_loader.c                 | 4 ++--
 tools/testing/selftests/bpf/xdp_features.c                | 4 ++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c             | 2 +-
 tools/testing/selftests/bpf/xskxceiver.c                  | 2 +-
 15 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 47365161b6fc..a25e262dbc69 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -27,7 +27,9 @@ endif
 BPF_GCC		?=3D $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=3D
 SAN_LDFLAGS	?=3D $(SAN_CFLAGS)
-CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
+CFLAGS +=3D -g -O0 -rdynamic						\
+	  -Wall -Werror 						\
+	  $(GENFLAGS) $(SAN_CFLAGS)					\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS +=3D $(SAN_LDFLAGS)
diff --git a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c=
 b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
index 16f1671e4bde..66191ae9863c 100644
--- a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
@@ -33,11 +33,11 @@ static void create_inner_maps(enum bpf_map_type map_t=
ype,
 {
 	int map_fd, map_index, ret;
 	__u32 map_key =3D 0, map_id;
-	char map_name[15];
+	char map_name[16];
=20
 	for (map_index =3D 0; map_index < OUTER_MAP_ENTRIES; map_index++) {
 		memset(map_name, 0, sizeof(map_name));
-		sprintf(map_name, "inner_map_fd_%d", map_index);
+		snprintf(map_name, sizeof(map_name), "inner_map_fd_%d", map_index);
 		map_fd =3D bpf_map_create(map_type, map_name, sizeof(__u32),
 					sizeof(__u32), 1, NULL);
 		CHECK(map_fd < 0,
diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/=
tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index d2d9e965eba5..053f4d6da77a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -193,8 +193,8 @@ static int setup_progs(struct bloom_filter_map **out_=
skel, __u32 **out_rand_vals
=20
 void test_bloom_filter_map(void)
 {
-	__u32 *rand_vals, nr_rand_vals;
-	struct bloom_filter_map *skel;
+	__u32 *rand_vals =3D NULL, nr_rand_vals =3D 0;
+	struct bloom_filter_map *skel =3D NULL;
 	int err;
=20
 	test_fail_cases();
diff --git a/tools/testing/selftests/bpf/prog_tests/connect_ping.c b/tool=
s/testing/selftests/bpf/prog_tests/connect_ping.c
index 289218c2216c..40fe571f2fe7 100644
--- a/tools/testing/selftests/bpf/prog_tests/connect_ping.c
+++ b/tools/testing/selftests/bpf/prog_tests/connect_ping.c
@@ -28,9 +28,9 @@ static void subtest(int cgroup_fd, struct connect_ping =
*skel,
 		.sin6_family =3D AF_INET6,
 		.sin6_addr =3D IN6ADDR_LOOPBACK_INIT,
 	};
-	struct sockaddr *sa;
+	struct sockaddr *sa =3D NULL;
 	socklen_t sa_len;
-	int protocol;
+	int protocol =3D -1;
 	int sock_fd;
=20
 	switch (family) {
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index db3bf6bbe01a..69dc31383b78 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -268,7 +268,7 @@ static struct btf *init_btf(void)
=20
 static void list_and_rb_node_same_struct(bool refcount_field)
 {
-	int bpf_rb_node_btf_id, bpf_refcount_btf_id, foo_btf_id;
+	int bpf_rb_node_btf_id, bpf_refcount_btf_id =3D 0, foo_btf_id;
 	struct btf *btf;
 	int id, err;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools=
/testing/selftests/bpf/prog_tests/lwt_helpers.h
index 61333f2a03f9..e9190574e79f 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
@@ -49,7 +49,8 @@ static int open_tuntap(const char *dev_name, bool need_=
mac)
 		return -1;
=20
 	ifr.ifr_flags =3D IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
-	memcpy(ifr.ifr_name, dev_name, IFNAMSIZ);
+	strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);
+	ifr.ifr_name[IFNAMSIZ - 1] =3D '\0';
=20
 	err =3D ioctl(fd, TUNSETIFF, &ifr);
 	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/t=
ools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index 722c5f2a7776..a043af9cd6d9 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -14,7 +14,7 @@ static void test_queue_stack_map_by_type(int type)
 	int i, err, prog_fd, map_in_fd, map_out_fd;
 	char file[32], buf[128];
 	struct bpf_object *obj;
-	struct iphdr iph;
+	struct iphdr iph =3D {};
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in =3D &pkt_v4,
 		.data_size_in =3D sizeof(pkt_v4),
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 064cc5e8d9ad..2535d0653cc8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -359,7 +359,7 @@ static void test_sockmap_progs_query(enum bpf_attach_=
type attach_type)
 static void test_sockmap_skb_verdict_shutdown(void)
 {
 	struct epoll_event ev, events[MAX_EVENTS];
-	int n, err, map, verdict, s, c1, p1;
+	int n, err, map, verdict, s, c1 =3D -1, p1 =3D -1;
 	struct test_sockmap_pass_prog *skel;
 	int epollfd;
 	int zero =3D 0;
@@ -414,9 +414,9 @@ static void test_sockmap_skb_verdict_shutdown(void)
 static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 {
 	int expected, zero =3D 0, sent, recvd, avail;
-	int err, map, verdict, s, c0, c1, p0, p1;
-	struct test_sockmap_pass_prog *pass;
-	struct test_sockmap_drop_prog *drop;
+	int err, map, verdict, s, c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
+	struct test_sockmap_pass_prog *pass =3D NULL;
+	struct test_sockmap_drop_prog *drop =3D NULL;
 	char buf[256] =3D "0123456789";
=20
 	if (pass_prog) {
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/t=
ools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 36d829a65aa4..e880f97bc44d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -378,7 +378,7 @@ static inline int enable_reuseport(int s, int progfd)
 static inline int socket_loopback_reuseport(int family, int sotype, int =
progfd)
 {
 	struct sockaddr_storage addr;
-	socklen_t len;
+	socklen_t len =3D 0;
 	int err, s;
=20
 	init_addr_loopback(family, &addr, &len);
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 8df8cbb447f1..e08e590b2cf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -73,7 +73,7 @@ static void test_insert_bound(struct test_sockmap_liste=
n *skel __always_unused,
 			      int family, int sotype, int mapfd)
 {
 	struct sockaddr_storage addr;
-	socklen_t len;
+	socklen_t len =3D 0;
 	u32 key =3D 0;
 	u64 value;
 	int err, s;
@@ -871,7 +871,7 @@ static void test_msg_redir_to_listening(struct test_s=
ockmap_listen *skel,
=20
 static void redir_partial(int family, int sotype, int sock_map, int pars=
er_map)
 {
-	int s, c0, c1, p0, p1;
+	int s, c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
 	int err, n, key, value;
 	char buf[] =3D "abc";
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tool=
s/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 626c461fa34d..4439ba9392f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -226,7 +226,7 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	__u64 comp_addr;
 	void *data;
 	__u64 addr;
-	__u32 idx;
+	__u32 idx =3D 0;
 	int ret;
=20
 	ret =3D recvfrom(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NU=
LL, NULL);
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
index b4edd8454934..37ffa57f28a1 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -69,7 +69,7 @@ static int tester_init(struct test_loader *tester)
 {
 	if (!tester->log_buf) {
 		tester->log_buf_sz =3D TEST_LOADER_LOG_BUF_SZ;
-		tester->log_buf =3D malloc(tester->log_buf_sz);
+		tester->log_buf =3D calloc(tester->log_buf_sz, 1);
 		if (!ASSERT_OK_PTR(tester->log_buf, "tester_log_buf"))
 			return -ENOMEM;
 	}
@@ -538,7 +538,7 @@ void run_subtest(struct test_loader *tester,
 		 bool unpriv)
 {
 	struct test_subspec *subspec =3D unpriv ? &spec->unpriv : &spec->priv;
-	struct bpf_program *tprog, *tprog_iter;
+	struct bpf_program *tprog =3D NULL, *tprog_iter;
 	struct test_spec *spec_iter;
 	struct cap_state caps =3D {};
 	struct bpf_object *tobj;
diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/s=
elftests/bpf/xdp_features.c
index b449788fbd39..595c79141cf3 100644
--- a/tools/testing/selftests/bpf/xdp_features.c
+++ b/tools/testing/selftests/bpf/xdp_features.c
@@ -360,9 +360,9 @@ static int recv_msg(int sockfd, void *buf, size_t buf=
size, void *val,
 static int dut_run(struct xdp_features *skel)
 {
 	int flags =3D XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE;
-	int state, err, *sockfd, ctrl_sockfd, echo_sockfd;
+	int state, err =3D 0, *sockfd, ctrl_sockfd, echo_sockfd;
 	struct sockaddr_storage ctrl_addr;
-	pthread_t dut_thread;
+	pthread_t dut_thread =3D 0;
 	socklen_t addrlen;
=20
 	sockfd =3D start_reuseport_server(AF_INET6, SOCK_STREAM, NULL,
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testin=
g/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..17c980138796 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -234,7 +234,7 @@ static int verify_metadata(struct xsk *rx_xsk, int rx=
q, int server_fd, clockid_t
 	struct pollfd fds[rxq + 1];
 	__u64 comp_addr;
 	__u64 addr;
-	__u32 idx;
+	__u32 idx =3D 0;
 	int ret;
 	int i;
=20
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
index 43e0a5796929..b0ee1307a63b 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1023,7 +1023,7 @@ static int receive_pkts(struct test_spec *test, str=
uct pollfd *fds)
 	pkt =3D pkt_stream_get_next_rx_pkt(pkt_stream, &pkts_sent);
 	while (pkt) {
 		u32 frags_processed =3D 0, nb_frags =3D 0, pkt_len =3D 0;
-		u64 first_addr;
+		u64 first_addr =3D 0;
=20
 		ret =3D gettimeofday(&tv_now, NULL);
 		if (ret)
--=20
2.34.1


