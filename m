Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851B058F173
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiHJRTV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiHJRSx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:18:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDF567D7AD;
        Wed, 10 Aug 2022 10:18:52 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-37-153.rev.numericable.fr [85.170.37.153])
        by linux.microsoft.com (Postfix) with ESMTPSA id CE516210C8B3;
        Wed, 10 Aug 2022 10:18:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE516210C8B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660151932;
        bh=brMrGS9cxZ9EjO8aqeA3Nvft1BpDlDaAvUz41MtO/YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3krHHEkoaDZqeZf1fasdaqyIAVWG2pDH3HOD7auhRSOJkQyv5wJ/9vO4+pp/ml8c
         /wRkbvJsaWgwSzOP2tPS6aQpl7tWe2FL/lY0dxMLT40AewBNSEI5AH8+Nzfk4O82SY
         U6MnRwhlmaCrKPI39iyCh8QAd9OpMTan4sEM1v1M=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [RFC PATCH v1 3/3] libbpf: Make bpf ring buffer overwritable.
Date:   Wed, 10 Aug 2022 19:16:54 +0200
Message-Id: <20220810171702.74932-4-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810171702.74932-1-flaniel@linux.microsoft.com>
References: <20220810171702.74932-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch permits using over writable feature for BPF ring buffer from
userspace.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 tools/include/uapi/linux/bpf.h |  3 +++
 tools/lib/bpf/ringbuf.c        | 35 +++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ef78e0e1a754..19c7039265d8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1226,6 +1226,9 @@ enum {

 /* Create a map that is suitable to be an inner map with dynamic max entries */
 	BPF_F_INNER_MAP		= (1U << 12),
+
+/* Create an over writable BPF_RINGBUF */
+	BFP_F_RB_OVER_WRITABLE	= (1U << 13),
 };

 /* Flags for BPF_PROG_QUERY. */
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 8bc117bcc7bc..2bd584f7250b 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -23,6 +23,8 @@

 struct ring {
 	ring_buffer_sample_fn sample_cb;
+	__u8 over_writable: 1,
+	     __reserved:    7;
 	void *ctx;
 	void *data;
 	unsigned long *consumer_pos;
@@ -95,6 +97,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	r->sample_cb = sample_cb;
 	r->ctx = ctx;
 	r->mask = info.max_entries - 1;
+	r->over_writable = !!(info.map_flags & BFP_F_RB_OVER_WRITABLE);

 	/* Map writable consumer page */
 	tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
@@ -202,6 +205,11 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }

+static inline bool is_over_writable(struct ring *r)
+{
+	return !!r->over_writable;
+}
+
 static int64_t ringbuf_process_ring(struct ring* r)
 {
 	int *len_ptr, len, err;
@@ -209,12 +217,25 @@ static int64_t ringbuf_process_ring(struct ring* r)
 	int64_t cnt = 0;
 	unsigned long cons_pos, prod_pos;
 	bool got_new_data;
+	int rounded_len;
 	void *sample;

 	cons_pos = smp_load_acquire(r->consumer_pos);
 	do {
 		got_new_data = false;
 		prod_pos = smp_load_acquire(r->producer_pos);
+
+		/*
+		 * If the difference between the producrer position and that of
+		 * the consumer is higher than the buffer size, it means the
+		 * producer already looped over the buffer.
+		 * So, data at consumer position were already over written.
+		 * We can then bump consumer position to be that of the producer
+		 * minus the buffer size.
+		 */
+		if (is_over_writable(r) && prod_pos - cons_pos > r->mask)
+			cons_pos = prod_pos - (r->mask + 1);
+
 		while (cons_pos < prod_pos) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = smp_load_acquire(len_ptr);
@@ -224,7 +245,19 @@ static int64_t ringbuf_process_ring(struct ring* r)
 				goto done;

 			got_new_data = true;
-			cons_pos += roundup_len(len);
+			rounded_len = roundup_len(len);
+			cons_pos += rounded_len;
+
+			/*
+			 * rounded_len is rounded to be divisible by 8, but a
+			 * length divisible by 8 can be not divisible by 4096.
+			 * So, we need to round again to avoid writing at new
+			 * places.
+			 * See kernel implementation for more details.
+			 */
+			if (is_over_writable(r)) {
+				cons_pos -= (cons_pos & r->mask) % rounded_len;
+			}

 			if ((len & BPF_RINGBUF_DISCARD_BIT) == 0) {
 				sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
--
2.25.1

