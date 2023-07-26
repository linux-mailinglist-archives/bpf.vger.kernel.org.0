Return-Path: <bpf+bounces-5919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111BD763091
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421151C21168
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC9CAD50;
	Wed, 26 Jul 2023 08:55:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A81AD4C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:55:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451194495
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690361747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XtYwhjvqgWz9QjsOakEd2O0h4kwm2uV/DxKMgZHITXQ=;
	b=PeHPnouHgtAhAHrUJ4yHbPxCFyqgfwnzhWh7YoF1Y4d+Jt6cm9pnyX/T415x6l2t8+YM12
	uGWkUCaUeUgmxoD5ZsRd1TsA+RCu7vJAQYJZr29SzPpsWV0ry8SnQ+tZYVZAmm96FLlpay
	ilFGBJdw3px7HBIEtD5jeXddLLBJIyA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80--kpPVwcUMIqEd3se6Fhlag-1; Wed, 26 Jul 2023 04:55:42 -0400
X-MC-Unique: -kpPVwcUMIqEd3se6Fhlag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE08D803470;
	Wed, 26 Jul 2023 08:55:41 +0000 (UTC)
Received: from fedora.. (unknown [10.43.17.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4754094DC0;
	Wed, 26 Jul 2023 08:55:40 +0000 (UTC)
From: tglozar@redhat.com
To: linux-kernel@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH RFC net] bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
Date: Wed, 26 Jul 2023 10:50:03 +0200
Message-ID: <20230726085003.261112-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tomas Glozar <tglozar@redhat.com>

Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exist
patchset notes for details).

This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP maps to
BUG (sleeping function called from invalid context) on RT kernels.

preempt_disable was introduced together with lock_sk and rcu_read_lock
in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and update
in parallel") with no comment on why it is necessary.

Remove preempt_disable to fix BUG in sock_map_update_common on RT.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 net/core/sock_map.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 19538d628714..08ab108206bf 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -115,7 +115,6 @@ static void sock_map_sk_acquire(struct sock *sk)
 	__acquires(&sk->sk_lock.slock)
 {
 	lock_sock(sk);
-	preempt_disable();
 	rcu_read_lock();
 }
 
@@ -123,7 +122,6 @@ static void sock_map_sk_release(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
 {
 	rcu_read_unlock();
-	preempt_enable();
 	release_sock(sk);
 }
 

base-commit: 22117b3ae6e37d07225653d9ae5ae86b3a54f99c
-- 
2.39.3


