Return-Path: <bpf+bounces-7070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25691770F1C
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F850282317
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935958BF8;
	Sat,  5 Aug 2023 09:38:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410CB23A2;
	Sat,  5 Aug 2023 09:38:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B374F10CA;
	Sat,  5 Aug 2023 02:38:12 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHyCf4X3rzrRxB;
	Sat,  5 Aug 2023 17:37:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 5 Aug
 2023 17:38:08 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next] bpf, sockmap: add BPF_F_PERMANENTLY flag for skmsg redirect
Date: Sat, 5 Aug 2023 17:42:54 +0800
Message-ID: <20230805094254.1082999-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the sockmap msg redirection function is used only to forward packets
and no other operation, the execution result of the BPF_SK_MSG_VERDICT
program is the same each time. In this case, the BPF program only needs to
be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
bpf_msg_redirect_hash() to implement this ability.

Then we can enable this function in the bpf program as follows:
bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENTLY);

Test results using netperf  TCP_STREAM mode:
for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
done

before:
3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
after:
4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 include/linux/skmsg.h          |  1 +
 include/uapi/linux/bpf.h       |  7 +++++--
 net/core/skmsg.c               |  1 +
 net/core/sock_map.c            |  4 ++--
 net/ipv4/tcp_bpf.c             | 15 +++++++++------
 tools/include/uapi/linux/bpf.h |  7 +++++--
 6 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 054d7911bfc9..b2da9c432f52 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -82,6 +82,7 @@ struct sk_psock {
 	u32				cork_bytes;
 	u32				eval;
 	bool				redir_ingress; /* undefined if sk_redir is null */
+	bool				eval_permanently;
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 70da85200695..cf622ea4f018 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3004,7 +3004,8 @@ union bpf_attr {
  * 		egress interfaces can be used for redirection. The
  * 		**BPF_F_INGRESS** value in *flags* is used to make the
  * 		distinction (ingress path is selected if the flag is present,
- * 		egress path otherwise). This is the only flag supported for now.
+ * 		egress path otherwise). The **BPF_F_PERMANENTLY** value in
+ *		*flags* is used to indicates whether the eBPF result is permanent.
  * 	Return
  * 		**SK_PASS** on success, or **SK_DROP** on error.
  *
@@ -3276,7 +3277,8 @@ union bpf_attr {
  *		egress interfaces can be used for redirection. The
  *		**BPF_F_INGRESS** value in *flags* is used to make the
  *		distinction (ingress path is selected if the flag is present,
- *		egress path otherwise). This is the only flag supported for now.
+ *		egress path otherwise). The **BPF_F_PERMANENTLY** value in
+ *		*flags* is used to indicates whether the eBPF result is permanent.
  *	Return
  *		**SK_PASS** on success, or **SK_DROP** on error.
  *
@@ -5872,6 +5874,7 @@ enum {
 /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
 enum {
 	BPF_F_INGRESS			= (1ULL << 0),
+	BPF_F_PERMANENTLY		= (1ULL << 1),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a29508e1ff35..b2bf9b5c4252 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -875,6 +875,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 	ret = bpf_prog_run_pin_on_cpu(prog, msg);
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
+	psock->eval_permanently = msg->flags & BPF_F_PERMANENTLY;
 	if (ret == __SK_REDIRECT) {
 		if (psock->sk_redir) {
 			sock_put(psock->sk_redir);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 08ab108206bf..6a0c90be7f4f 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -662,7 +662,7 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
 {
 	struct sock *sk;
 
-	if (unlikely(flags & ~(BPF_F_INGRESS)))
+	if (unlikely(flags & ~(BPF_F_INGRESS | BPF_F_PERMANENTLY)))
 		return SK_DROP;
 
 	sk = __sock_map_lookup_elem(map, key);
@@ -1261,7 +1261,7 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
 {
 	struct sock *sk;
 
-	if (unlikely(flags & ~(BPF_F_INGRESS)))
+	if (unlikely(flags & ~(BPF_F_INGRESS | BPF_F_PERMANENTLY)))
 		return SK_DROP;
 
 	sk = __sock_hash_lookup_elem(map, key);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 81f0dff69e0b..81c3d3ad44f7 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -419,8 +419,10 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		if (!psock->apply_bytes) {
 			/* Clean up before releasing the sock lock. */
 			eval = psock->eval;
-			psock->eval = __SK_NONE;
-			psock->sk_redir = NULL;
+			if (!psock->eval_permanently) {
+				psock->eval = __SK_NONE;
+				psock->sk_redir = NULL;
+			}
 		}
 		if (psock->cork) {
 			cork = true;
@@ -434,7 +436,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 					    msg, tosend, flags);
 		sent = origsize - msg->sg.size;
 
-		if (eval == __SK_REDIRECT)
+		if (!psock->eval_permanently && eval == __SK_REDIRECT)
 			sock_put(sk_redir);
 
 		lock_sock(sk);
@@ -460,8 +462,8 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	}
 
 	if (likely(!ret)) {
-		if (!psock->apply_bytes) {
-			psock->eval =  __SK_NONE;
+		if (!psock->apply_bytes && !psock->eval_permanently) {
+			psock->eval = __SK_NONE;
 			if (psock->sk_redir) {
 				sock_put(psock->sk_redir);
 				psock->sk_redir = NULL;
@@ -540,7 +542,8 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			if (psock->cork_bytes && !enospc)
 				goto out_err;
 			/* All cork bytes are accounted, rerun the prog. */
-			psock->eval = __SK_NONE;
+			if (!psock->eval_permanently)
+				psock->eval = __SK_NONE;
 			psock->cork_bytes = 0;
 		}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70da85200695..cf622ea4f018 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3004,7 +3004,8 @@ union bpf_attr {
  * 		egress interfaces can be used for redirection. The
  * 		**BPF_F_INGRESS** value in *flags* is used to make the
  * 		distinction (ingress path is selected if the flag is present,
- * 		egress path otherwise). This is the only flag supported for now.
+ * 		egress path otherwise). The **BPF_F_PERMANENTLY** value in
+ *		*flags* is used to indicates whether the eBPF result is permanent.
  * 	Return
  * 		**SK_PASS** on success, or **SK_DROP** on error.
  *
@@ -3276,7 +3277,8 @@ union bpf_attr {
  *		egress interfaces can be used for redirection. The
  *		**BPF_F_INGRESS** value in *flags* is used to make the
  *		distinction (ingress path is selected if the flag is present,
- *		egress path otherwise). This is the only flag supported for now.
+ *		egress path otherwise). The **BPF_F_PERMANENTLY** value in
+ *		*flags* is used to indicates whether the eBPF result is permanent.
  *	Return
  *		**SK_PASS** on success, or **SK_DROP** on error.
  *
@@ -5872,6 +5874,7 @@ enum {
 /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
 enum {
 	BPF_F_INGRESS			= (1ULL << 0),
+	BPF_F_PERMANENTLY		= (1ULL << 1),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
-- 
2.34.1


