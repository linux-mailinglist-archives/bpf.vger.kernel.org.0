Return-Path: <bpf+bounces-3323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8668973C44C
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 00:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73CF1C21385
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE36D6138;
	Fri, 23 Jun 2023 22:55:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A26131
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 22:55:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57A26B5
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687560927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rBMqYSyv/4ZPCkVQAGQaA6Fc9mkJmC9WKrulhUVyYg=;
	b=ew1BfP6IDH0kmYetIID2zo+6rn0jpLftBdj8KbQvnyuwnPWrBlZT9wqnOV99Y12s4k1BF/
	7P9HxGThUVqgRphznMaWI2USbYY6/r+5zd/o+obgQ0HB/xaW6vHQhCbMHKn5XPXzQYonm6
	V+w74uESDBn1WamtzgYf9FdDSkQQlKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-XZyhTNHGPUuH2-31Her6VQ-1; Fri, 23 Jun 2023 18:55:24 -0400
X-MC-Unique: XZyhTNHGPUuH2-31Her6VQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA74E185A78F;
	Fri, 23 Jun 2023 22:55:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 518A01121314;
	Fri, 23 Jun 2023 22:55:19 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	bpf@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 01/16] tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage
Date: Fri, 23 Jun 2023 23:54:58 +0100
Message-ID: <20230623225513.2732256-2-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As MSG_SENDPAGE_NOTLAST is being phased out along with sendpage(), don't
use it further in than the sendpage methods, but rather translate it to
MSG_MORE and use that instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: Bernard Metzler <bmt@zurich.ibm.com>
cc: Jason Gunthorpe <jgg@ziepe.ca>
cc: Leon Romanovsky <leon@kernel.org>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Sitnicki <jakub@cloudflare.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: David Ahern <dsahern@kernel.org>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Karsten Graul <kgraul@linux.ibm.com>
cc: Wenjia Zhang <wenjia@linux.ibm.com>
cc: Jan Karcher <jaka@linux.ibm.com>
cc: "D. Wythe" <alibuda@linux.alibaba.com>
cc: Tony Lu <tonylu@linux.alibaba.com>
cc: Wen Gu <guwen@linux.alibaba.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: Steffen Klassert <steffen.klassert@secunet.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: netdev@vger.kernel.org
cc: bpf@vger.kernel.org
cc: linux-s390@vger.kernel.org
cc: linux-rdma@vger.kernel.org
---

Notes:
    ver #3)
     - In tcp_bpf, reset msg_flags on each iteration to clear MSG_MORE.
     - In tcp_bpf, set MSG_MORE if there's more data in the sk_msg.

 drivers/infiniband/sw/siw/siw_qp_tx.c |  5 ++---
 net/ipv4/tcp_bpf.c                    |  5 +++--
 net/smc/smc_tx.c                      |  6 ++++--
 net/tls/tls_device.c                  |  4 ++--
 net/xfrm/espintcp.c                   | 10 ++++++----
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index ffb16beb6c30..7c7a51d36d0c 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -325,8 +325,7 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
 {
 	struct bio_vec bvec;
 	struct msghdr msg = {
-		.msg_flags = (MSG_MORE | MSG_DONTWAIT | MSG_SENDPAGE_NOTLAST |
-			      MSG_SPLICE_PAGES),
+		.msg_flags = (MSG_MORE | MSG_DONTWAIT | MSG_SPLICE_PAGES),
 	};
 	struct sock *sk = s->sk;
 	int i = 0, rv = 0, sent = 0;
@@ -335,7 +334,7 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
 		size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
 
 		if (size + offset <= PAGE_SIZE)
-			msg.msg_flags &= ~MSG_SENDPAGE_NOTLAST;
+			msg.msg_flags &= ~MSG_MORE;
 
 		tcp_rate_check_app_limited(sk);
 		bvec_set_page(&bvec, page[i], bytes, offset);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 5a84053ac62b..31d6005cea9b 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -88,9 +88,9 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 			int flags, bool uncharge)
 {
+	struct msghdr msghdr = {};
 	bool apply = apply_bytes;
 	struct scatterlist *sge;
-	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 	struct page *page;
 	int size, ret = 0;
 	u32 off;
@@ -107,11 +107,12 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 
 		tcp_rate_check_app_limited(sk);
 retry:
+		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
 		if (has_tx_ulp)
 			msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;
 
-		if (flags & MSG_SENDPAGE_NOTLAST)
+		if (size < sge->length && msg->sg.start != msg->sg.end)
 			msghdr.msg_flags |= MSG_MORE;
 
 		bvec_set_page(&bvec, page, size, off);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 45128443f1f1..9b9e0a190734 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -168,8 +168,7 @@ static bool smc_tx_should_cork(struct smc_sock *smc, struct msghdr *msg)
 	 * should known how/when to uncork it.
 	 */
 	if ((msg->msg_flags & MSG_MORE ||
-	     smc_tx_is_corked(smc) ||
-	     msg->msg_flags & MSG_SENDPAGE_NOTLAST) &&
+	     smc_tx_is_corked(smc)) &&
 	    atomic_read(&conn->sndbuf_space))
 		return true;
 
@@ -306,6 +305,9 @@ int smc_tx_sendpage(struct smc_sock *smc, struct page *page, int offset,
 	struct kvec iov;
 	int rc;
 
+	if (flags & MSG_SENDPAGE_NOTLAST)
+		msg.msg_flags |= MSG_MORE;
+
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, size);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index b82770f68807..975299d7213b 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -449,7 +449,7 @@ static int tls_push_data(struct sock *sk,
 		return -sk->sk_err;
 
 	flags |= MSG_SENDPAGE_DECRYPTED;
-	tls_push_record_flags = flags | MSG_SENDPAGE_NOTLAST;
+	tls_push_record_flags = flags | MSG_MORE;
 
 	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 	if (tls_is_partially_sent_record(tls_ctx)) {
@@ -532,7 +532,7 @@ static int tls_push_data(struct sock *sk,
 		if (!size) {
 last_record:
 			tls_push_record_flags = flags;
-			if (flags & (MSG_SENDPAGE_NOTLAST | MSG_MORE)) {
+			if (flags & MSG_MORE) {
 				more = true;
 				break;
 			}
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 3504925babdb..d3b3f9e720b3 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -205,13 +205,15 @@ static int espintcp_sendskb_locked(struct sock *sk, struct espintcp_msg *emsg,
 static int espintcp_sendskmsg_locked(struct sock *sk,
 				     struct espintcp_msg *emsg, int flags)
 {
-	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
+	struct msghdr msghdr = {
+		.msg_flags = flags | MSG_SPLICE_PAGES | MSG_MORE,
+	};
 	struct sk_msg *skmsg = &emsg->skmsg;
+	bool more = flags & MSG_MORE;
 	struct scatterlist *sg;
 	int done = 0;
 	int ret;
 
-	msghdr.msg_flags |= MSG_SENDPAGE_NOTLAST;
 	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
 		struct bio_vec bvec;
@@ -221,8 +223,8 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 
 		emsg->offset = 0;
 
-		if (sg_is_last(sg))
-			msghdr.msg_flags &= ~MSG_SENDPAGE_NOTLAST;
+		if (sg_is_last(sg) && !more)
+			msghdr.msg_flags &= ~MSG_MORE;
 
 		p = sg_page(sg);
 retry:


