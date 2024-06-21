Return-Path: <bpf+bounces-32730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED03912827
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A4B2A7C6
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5934383A2;
	Fri, 21 Jun 2024 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GGEN+wYG"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D0374FF
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980807; cv=none; b=ONMJ1bkTt8Lp5b6rRsjekglI4mLOdFfSHDGh16sZleeRj0xt+cLFOHfLLZ9f4uz3HTpSFmrA12pCvBvFk6EaHAHUJCUvPBd1hG8NkNh80bMxQWJj5eCuoRaj7QSk0AiyLhAiIjQMMCyiwG116ntkUY0ES9u4SvppZlM0v7meKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980807; c=relaxed/simple;
	bh=NbIY79fOS0V0qD+tp87WsVRBr9peyg8yqANF4enkn6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pzgMuZypQByU5FHQP2ySN/0aLu8xXp0tk9kSxsGh+cNrvxbCmD+YZxtomYfJnABaphQvGX7jp7iaUtiWPbIGXE0NctRdT3InCvcY3Wkp4LzChVuZYSNCTeQpuQtUi2FBSYE8+dWHVhQbGObmyBMpJz6ojQINPCVaa646HUhYJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GGEN+wYG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8fxV3n42om9XbYIukRrWbliOg7Ni/Z1uVCYVzjTzi6o=; b=GGEN+wYGmsHIxBqUU5xDzOI3wV
	H1NN27LeUc57BzMhH6w08SpVpZoNHEM1FQjyF87CWERn+90sOEtYgKcoYzTOPuDozJCcZb8Yet+rj
	GFwSdcN0Xnqfu7UJfTWaEvvfJB/fP3NYZxRSSF8AMsz4w3Gcu/FYL5hhj6itgt/GvwQnBSUJAO15n
	0Bo18OjgzDSYFn+0D+zS7mH5j1gvRu7Kn+xII8frVpsdoce+LAkAnvDbE0vXxW90g0Cvju/FkOKWX
	0ggxcyBG2oCdeXwl1w3SErI88CNj744ji6fsG1VPhEY/5EjW8mJP/otWFrFoio1fONN9obO4khgOc
	xiO3jhWA==;
Received: from 18.248.197.178.dynamic.cust.swisscom.net ([178.197.248.18] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sKewH-000CiQ-UZ; Fri, 21 Jun 2024 16:08:30 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v3 1/2] bpf: Fix overrunning reservations in ringbuf
Date: Fri, 21 Jun 2024 16:08:27 +0200
Message-Id: <20240621140828.18238-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27313/Fri Jun 21 10:28:08 2024)

The BPF ring buffer internally is implemented as a power-of-2 sized circular
buffer, with two logical and ever-increasing counters: consumer_pos is the
consumer counter to show which logical position the consumer consumed the
data, and producer_pos which is the producer counter denoting the amount of
data reserved by all producers.

Each time a record is reserved, the producer that "owns" the record will
successfully advance producer counter. In user space each time a record is
read, the consumer of the data advanced the consumer counter once it finished
processing. Both counters are stored in separate pages so that from user
space, the producer counter is read-only and the consumer counter is read-write.

One aspect that simplifies and thus speeds up the implementation of both
producers and consumers is how the data area is mapped twice contiguously
back-to-back in the virtual memory, allowing to not take any special measures
for samples that have to wrap around at the end of the circular buffer data
area, because the next page after the last data page would be first data page
again, and thus the sample will still appear completely contiguous in virtual
memory.

Each record has a struct bpf_ringbuf_hdr { u32 len; u32 pg_off; } header for
book-keeping the length and offset, and is inaccessible to the BPF program.
Helpers like bpf_ringbuf_reserve() return `(void *)hdr + BPF_RINGBUF_HDR_SZ`
for the BPF program to use. Bing-Jhong and Muhammad reported that it is however
possible to make a second allocated memory chunk overlapping with the first
chunk and as a result, the BPF program is now able to edit first chunk's
header.

For example, consider the creation of a BPF_MAP_TYPE_RINGBUF map with size
of 0x4000. Next, the consumer_pos is modified to 0x3000 /before/ a call to
bpf_ringbuf_reserve() is made. This will allocate a chunk A, which is in
[0x0,0x3008], and the BPF program is able to edit [0x8,0x3008]. Now, lets
allocate a chunk B with size 0x3000. This will succeed because consumer_pos
was edited ahead of time to pass the `new_prod_pos - cons_pos > rb->mask`
check. Chunk B will be in range [0x3008,0x6010], and the BPF program is able
to edit [0x3010,0x6010]. Due to the ring buffer memory layout mentioned
earlier, the ranges [0x0,0x4000] and [0x4000,0x8000] point to the same data
pages. This means that chunk B at [0x4000,0x4008] is chunk A's header.
bpf_ringbuf_submit() / bpf_ringbuf_discard() use the header's pg_off to then
locate the bpf_ringbuf itself via bpf_ringbuf_restore_from_rec(). Once chunk
B modified chunk A's header, then bpf_ringbuf_commit() refers to the wrong
page and could cause a crash.

Fix it by calculating the oldest pending_pos and check whether the range
from the oldest outstanding record to the newest would span beyond the ring
buffer size. If that is the case, then reject the request. We've tested with
the ring buffer benchmark in BPF selftests (./benchs/run_bench_ringbufs.sh)
before/after the fix and while it seems a bit slower on some benchmarks, it
is still not significantly enough to matter.

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
Co-developed-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - Move pending_pos to the same cacheline as producer_pos
   - Force compiler to read hdr->len only once

 kernel/bpf/ringbuf.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 0ee653a936ea..87466de8316a 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -51,7 +51,8 @@ struct bpf_ringbuf {
 	 * This prevents a user-space application from modifying the
 	 * position and ruining in-kernel tracking. The permissions of the
 	 * pages depend on who is producing samples: user-space or the
-	 * kernel.
+	 * kernel. Note that the pending counter is placed in the same
+	 * page as the producer, so that it shares the same cacheline.
 	 *
 	 * Kernel-producer
 	 * ---------------
@@ -70,6 +71,7 @@ struct bpf_ringbuf {
 	 */
 	unsigned long consumer_pos __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
+	unsigned long pending_pos;
 	char data[] __aligned(PAGE_SIZE);
 };
 
@@ -179,6 +181,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	rb->mask = data_sz - 1;
 	rb->consumer_pos = 0;
 	rb->producer_pos = 0;
+	rb->pending_pos = 0;
 
 	return rb;
 }
@@ -404,9 +407,10 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr *hdr)
 
 static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 {
-	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
-	u32 len, pg_off;
+	unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
 	struct bpf_ringbuf_hdr *hdr;
+	u64 tmp_size, hdr_len;
+	u32 len, pg_off;
 
 	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
 		return NULL;
@@ -424,13 +428,29 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 		spin_lock_irqsave(&rb->spinlock, flags);
 	}
 
+	pend_pos = rb->pending_pos;
 	prod_pos = rb->producer_pos;
 	new_prod_pos = prod_pos + len;
 
-	/* check for out of ringbuf space by ensuring producer position
-	 * doesn't advance more than (ringbuf_size - 1) ahead
+	while (pend_pos < prod_pos) {
+		hdr = (void *)rb->data + (pend_pos & rb->mask);
+		hdr_len = READ_ONCE(hdr->len);
+		if (hdr_len & BPF_RINGBUF_BUSY_BIT)
+			break;
+		tmp_size = hdr_len & ~BPF_RINGBUF_DISCARD_BIT;
+		tmp_size = round_up(tmp_size + BPF_RINGBUF_HDR_SZ, 8);
+		pend_pos += tmp_size;
+	}
+	rb->pending_pos = pend_pos;
+
+	/* check for out of ringbuf space:
+	 * - by ensuring producer position doesn't advance more than
+	 *   (ringbuf_size - 1) ahead
+	 * - by ensuring oldest not yet committed record until newest
+	 *   record does not span more than (ringbuf_size - 1)
 	 */
-	if (new_prod_pos - cons_pos > rb->mask) {
+	if ((new_prod_pos - cons_pos > rb->mask) ||
+	    (new_prod_pos - pend_pos > rb->mask)) {
 		spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}
-- 
2.43.0


