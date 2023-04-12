Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8286DF5EF
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjDLMpX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjDLMpD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 08:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC57EFF
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681303398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cip69uvEtYr/5frxYNZac25fuawKyNR+cs4ZJgFBxs=;
        b=iSQoRfMG7hF80Wr/Wt2xFDq4bJ+JKkmg19hwSLshjrI676S9Clc7Nnqa4qNsk5D6y9cuZS
        aNb0hHAgeUHS8ZmVouqOWhtvoI1/tJu0NyvhyNZWLT+z53VWuwf4A96Yfd7NWQezhycq/H
        jwxc4Yipxo3Eziqcv87GzyvMXzyh8wQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-i-jHLEqEMHGnt4iqOT0Nhw-1; Wed, 12 Apr 2023 08:43:15 -0400
X-MC-Unique: i-jHLEqEMHGnt4iqOT0Nhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB313800B23;
        Wed, 12 Apr 2023 12:43:13 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6422A40C6E71;
        Wed, 12 Apr 2023 12:43:13 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id AB4EC307372E8;
        Wed, 12 Apr 2023 14:43:12 +0200 (CEST)
Subject: [PATCH bpf V8 7/7] selftests/bpf: Adjust bpf_xdp_metadata_rx_hash for
 new arg
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net, tariqt@nvidia.com, saeedm@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 12 Apr 2023 14:43:12 +0200
Message-ID: <168130339265.150247.18079994022961741945.stgit@firesoul>
In-Reply-To: <168130333143.150247.11159481574477358816.stgit@firesoul>
References: <168130333143.150247.11159481574477358816.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update BPF selftests to use the new RSS type argument for kfunc
bpf_xdp_metadata_rx_hash.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c        |    2 ++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   11 +++++------
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |    6 +++---
 tools/testing/selftests/bpf/progs/xdp_metadata2.c  |    7 ++++---
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |    6 +++++-
 tools/testing/selftests/bpf/xdp_metadata.h         |    4 ++++
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index aa4beae99f4f..8c5e98da9ae9 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -273,6 +273,8 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
+	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
+
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index a07ef7534013..829b7c3354ba 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -31,8 +31,8 @@ volatile __u64 pkts_redir = 0;
 
 extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
-extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx,
-				    __u32 *hash) __ksym;
+extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
+				    enum xdp_rss_hash_type *rss_type) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -96,10 +96,9 @@ int rx(struct xdp_md *ctx)
 	else
 		meta->rx_timestamp = 0; /* Used by AF_XDP as not avail signal */
 
-	if (!bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash))
-		bpf_printk("populated rx_hash with %u", meta->rx_hash);
-	else
-		meta->rx_hash = 0; /* Used by AF_XDP as not avail signal */
+	ret = bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
+	if (ret < 0)
+		meta->rx_hash_err = ret; /* Used by AF_XDP as no hash signal */
 
 	pkts_redir++;
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 77678b034389..d151d406a123 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -21,8 +21,8 @@ struct {
 
 extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
-extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx,
-				    __u32 *hash) __ksym;
+extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
+				    enum xdp_rss_hash_type *rss_type) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -56,7 +56,7 @@ int rx(struct xdp_md *ctx)
 	if (timestamp == 0)
 		meta->rx_timestamp = 1;
 
-	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash);
+	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata2.c b/tools/testing/selftests/bpf/progs/xdp_metadata2.c
index cf69d05451c3..85f88d9d7a78 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata2.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata2.c
@@ -5,17 +5,18 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx,
-				    __u32 *hash) __ksym;
+extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
+				    enum xdp_rss_hash_type *rss_type) __ksym;
 
 int called;
 
 SEC("freplace/rx")
 int freplace_rx(struct xdp_md *ctx)
 {
+	enum xdp_rss_hash_type type = 0;
 	u32 hash = 0;
 	/* Call _any_ metadata function to make sure we don't crash. */
-	bpf_xdp_metadata_rx_hash(ctx, &hash);
+	bpf_xdp_metadata_rx_hash(ctx, &hash, &type);
 	called++;
 	return XDP_PASS;
 }
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3b942ef7297b..987cf0db5ebc 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -141,7 +141,11 @@ static void verify_xdp_metadata(void *data)
 	meta = data - sizeof(*meta);
 
 	printf("rx_timestamp: %llu\n", meta->rx_timestamp);
-	printf("rx_hash: %u\n", meta->rx_hash);
+	if (meta->rx_hash_err < 0)
+		printf("No rx_hash err=%d\n", meta->rx_hash_err);
+	else
+		printf("rx_hash: 0x%X with RSS type:0x%X\n",
+		       meta->rx_hash, meta->rx_hash_type);
 }
 
 static void verify_skb_metadata(int fd)
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index f6780fbb0a21..0c4624dc6f2f 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -12,4 +12,8 @@
 struct xdp_meta {
 	__u64 rx_timestamp;
 	__u32 rx_hash;
+	union {
+		__u32 rx_hash_type;
+		__s32 rx_hash_err;
+	};
 };


