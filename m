Return-Path: <bpf+bounces-8531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEC7787B5A
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 00:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092CC1C20E3E
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 22:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D93AAD31;
	Thu, 24 Aug 2023 22:17:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8AA93E
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 22:17:13 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B7E1BF7
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 15:17:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76da819edc7so63877185a.1
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692915428; x=1693520228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/hoJKBh6Oygh/RwQvOwEtq33xQQIh43c3nkg+RzXCs=;
        b=BLMw3Hgzo5aar4bxN1sRG8EqWeBaICQ7Wvzh5qljJziI8idk5so+qRC0Q7YRcs4e80
         laiPPmJlT8V38PudyJNONmpxpewdn9d+v0HBicn/rTz81Lfs6zBbS8Q8CZzw+L3CqATy
         mCPa68lTUPIi0DwVF5LtM7Vlk/qnwACyojtw/6b9R7nT/huDqmIPb8GvnmIAFqXQ899i
         otOA+UmxoFUhMnfvJQHZOPh8oLd2o56oXqZiyW8RvjtqCEv0xrPNIeHizVweEZpnrW4C
         FpoTnAt0oJ8w5qPCj79TH2B9lHx7dww4LfjaxqH9fDliAG3ceDehYPuvrvCtx4gKmkw6
         x1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692915428; x=1693520228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/hoJKBh6Oygh/RwQvOwEtq33xQQIh43c3nkg+RzXCs=;
        b=fwTRsBOPqHN7A0LlEj0NmrEtg+iiqWF5jAPZc0moiHeTbYZZJkNWN9JpVpewue/uc+
         Jz3PnxCAc2eO7CgOckah0fSkeXKhWN8x9HxEesMaQ3iZQ/exqAzVvZ5E+wEQzFbT8ceG
         iuH1k2lZaWUzwE9stBClEGGKLxwv4IEV0Fm6xa6x2xvcClJhDgbAEB9KorrMS5Bg66es
         KyuV8zhR8OyJnt9Rpq5S3mjIuNIv4ukW5bXt0skTAocGSdz0/XBT4lKVWk2N8hvSQbV5
         vnsQ+B80AJW15udoPSjoYgs2zTN2p7dWLqggfwpg5bxktCGg5+Xy/pGdtNaU1XMtpYQX
         e9Rg==
X-Gm-Message-State: AOJu0YzBPz6cFypytyhRaUopuq8mWdHGKREHWYlUvaEGX3A/72pGE1y2
	PeIqV9FjzdRR1RjiD/klOufXUNkKTzEGDHc5
X-Google-Smtp-Source: AGHT+IGYpbz12FRsog9+Nw6NZz0rpPZkBDrQ4r7lU2v2nyhU4K1FKIVIRrlj1Juptl8QaXt6Xz3/tw==
X-Received: by 2002:a05:620a:d8b:b0:76e:4df3:1dcd with SMTP id q11-20020a05620a0d8b00b0076e4df31dcdmr6345767qkl.11.1692915428263;
        Thu, 24 Aug 2023 15:17:08 -0700 (PDT)
Received: from pc.tail5bae4.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a10b300b0076cc8033692sm122923qkk.12.2023.08.24.15.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:17:07 -0700 (PDT)
From: Andrew Werner <awerner32@gmail.com>
To: bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	olsajiri@gmail.com,
	houtao@huaweicloud.com,
	void@manifault.com,
	Andrew Werner <awerner32@gmail.com>
Subject: [PATCH bpf-next v3] libbpf: handle producer position overflow
Date: Thu, 24 Aug 2023 18:09:08 -0400
Message-Id: <20230824220907.1172808-1-awerner32@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before this patch, the producer position could overflow `unsigned
long`, in which case libbpf would forever stop processing new writes to
the ringbuf. Similarly, overflows of the producer position could result
in __bpf_user_ringbuf_peek not discovering available data. This patch
addresses that bug by computing using the signed delta between the
consumer and producer position to determine if data is available; the
delta computation is robust to overflow.

A more defensive check could be to ensure that the delta is within
the allowed range, but such defensive checks are neither present in
the kernel side code nor in libbpf. The overflow that this patch
handles can occur while the producer and consumer follow a correct
protocol.

Secondarily, the type used to represent the positions in the
user_ring_buffer functions in both libbpf and the kernel has been
changed from u64 to unsigned long to match the type used in the
kernel's representation of the structure. The change occurs in the
same patch because it's required to align the data availability
calculations between the userspace producing ringbuf and the bpf
producing ringbuf.

Not included in this patch, a selftest was written to demonstrate the
bug, and indeed this patch allows the test to continue to make progress
past the overflow. The shape of the self test was as follows:

 a) Set up ringbuf of 2GB size (the maximum permitted size).
 b) reserve+commit maximum-sized records (ULONG_MAX/4) constantly as
    fast as possible.

With 1 million records per second repro time should be about 4.7 hours.
Such a test duration is impractical to run, hence the omission.

Additionally, this patch adds commentary around a separate point to note
that the modular arithmetic is valid in the face of overflows, as that
fact may not be obvious to future readers.

v2->v3:
  - Changed the representation of the consumer and producer positions
    from u64 to unsigned long in user_ring_buffer functions. 
  - Addressed overflow in __bpf_user_ringbuf_peek.
  - Changed data availability computations to use the signed delta
    between the consumer and producer positions rather than merely
    checking whether their values were unequal.
v1->v2:
  - Fixed comment grammar.
  - Properly formatted subject line.

Signed-off-by: Andrew Werner <awerner32@gmail.com>
---
 kernel/bpf/ringbuf.c    | 11 ++++++++---
 tools/lib/bpf/ringbuf.c | 16 +++++++++++++---
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index f045fde632e5..0c48673520fb 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -658,7 +658,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 {
 	int err;
 	u32 hdr_len, sample_len, total_len, flags, *hdr;
-	u64 cons_pos, prod_pos;
+	unsigned long cons_pos, prod_pos;
 
 	/* Synchronizes with smp_store_release() in user-space producer. */
 	prod_pos = smp_load_acquire(&rb->producer_pos);
@@ -667,7 +667,12 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 
 	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
-	if (cons_pos >= prod_pos)
+
+	/* Check if there's data available by computing the signed delta between
+	 * cons_pos and prod_pos; a negative delta indicates that the consumer has
+	 * not caught up. This formulation is robust to prod_pos wrapping around.
+	 */
+	if ((long)(cons_pos - prod_pos) >= 0)
 		return -ENODATA;
 
 	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
@@ -711,7 +716,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 
 static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
 {
-	u64 consumer_pos;
+	unsigned long consumer_pos;
 	u32 rounded_size = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
 
 	/* Using smp_load_acquire() is unnecessary here, as the busy-bit
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db13..141030a89370 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -237,7 +237,13 @@ static int64_t ringbuf_process_ring(struct ring *r)
 	do {
 		got_new_data = false;
 		prod_pos = smp_load_acquire(r->producer_pos);
-		while (cons_pos < prod_pos) {
+
+		/* Check if there's data available by computing the signed delta
+		 * between cons_pos and prod_pos; a negative delta indicates that the
+		 * consumer has not caught up. This formulation is robust to prod_pos
+		 * wrapping around.
+		 */
+		while ((long)(cons_pos - prod_pos) < 0) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = smp_load_acquire(len_ptr);
 
@@ -482,8 +488,7 @@ void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample)
 void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
 {
 	__u32 avail_size, total_size, max_size;
-	/* 64-bit to avoid overflow in case of extreme application behavior */
-	__u64 cons_pos, prod_pos;
+	unsigned long cons_pos, prod_pos;
 	struct ringbuf_hdr *hdr;
 
 	/* The top two bits are used as special flags */
@@ -498,6 +503,11 @@ void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
 	prod_pos = smp_load_acquire(rb->producer_pos);
 
 	max_size = rb->mask + 1;
+
+	/* Note that this formulation is valid in the face of overflow of
+	 * prod_pos so long as the delta between prod_pos and cons_pos is
+	 * no greater than max_size.
+	 */
 	avail_size = max_size - (prod_pos - cons_pos);
 	/* Round up total size to a multiple of 8. */
 	total_size = (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
-- 
2.39.2


