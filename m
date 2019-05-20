Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED09244C7
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 01:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfETXxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 May 2019 19:53:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47216 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfETXxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 May 2019 19:53:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KNiicA157571;
        Mon, 20 May 2019 23:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id :
 mime-version : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=nsVYcJhBHE0MCxil9cQ6DL7qZC57z9pYUm8jRrBLYs8=;
 b=MSjTdtlwDKm3vwdmcRXDPCWBtB9QzGfeOTeCf2g8oA/0A2DEk+PbqZ6aNAVnpmcUsjF/
 JHvjvvj5Nf3QiGRwTMCXtNL5yVkweneqZla2XCJuk2wZPTy2/Ndb1TuUPYXCsxs5diYc
 rIzRkhx/N3tVmDOn4SNdCESfJbZnOZd4x+x2j3YstxBcBI8ZU+Uj9QGFtE8PmZ5qZFeh
 mZ3DoEA86e+7cdI8jClXjjomurFqLAIrq7jUm1/lO7rz2a+/HTqCt4QwnY3oN/hivWgG
 acysfxR99GibU3WDcy7OCGQ+/GSj2imYybiaj/ygGdpS3Q9hhpxhSEERqupgDpV8DksH xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2sj9fta39m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 23:52:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KNq3JF129709;
        Mon, 20 May 2019 23:52:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2sks1j4kux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 May 2019 23:52:33 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4KNqXHH130450;
        Mon, 20 May 2019 23:52:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sks1j4kut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 23:52:33 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4KNqWYI006444;
        Mon, 20 May 2019 23:52:32 GMT
Message-Id: <201905202352.x4KNqWYI006444@userv0122.oracle.com>
Received: from localhost (/10.159.211.99) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Mon, 20 May 2019 23:52:31 +0000
MIME-Version: 1.0
Date:   Mon, 20 May 2019 23:52:32 +0000 (UTC)
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        dtrace-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, acme@kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Subject: [RFC PATCH 08/11] perf: add perf_output_begin_forward_in_page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200146
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Right now, BPF programs can only write to a perf event ring buffer by
constructing a sample (as an arbitrary chunk of memory of a given size),
and calling perf_event_output() to have it written to the ring buffer.

A new implementation of DTrace (based on BPF) avoids constructing the
data sample prior to writing it to the ring buffer.  Instead, it expects
to be able to reserve a block of memory of a given size, write to that
memory region as it sees fit, and then finalize the written data (making
it available for reading from userspace).

This can (in part) be accomplished as follows:
1. reserve buffer space
    Call perf_output_begin_forward_in_page(&handle, event, size) passing
    in a handle to be used for this data output session, an event that
    identifies the output buffer, and the size (in bytes) to set aside.

2. write data
    Perform store operations to the buffer space that was set aside.
    The buffer is a writable buffer in the BPF program context, which
    means that operations like *(u32 *)&buf[offset] = val can be used.

3. finalize the output session
    Call perf_output_end(&handle) to finalize the output and make the
    new data available for reading from userspace by updating the head
    of the ring buffer.

The one caveat is that ring buffers may be allocated from non-contiguous
pages in kernel memory.  This means that a reserved block of memory could
be spread across two non-consecutive pages, and accessing the buffer
space using buf[offset] is no longer safe.  Forcing the ring buffer to be
allocated using vmalloc would avoid this problem, but that would impose
a limitation on all perf event output buffers which is not an acceptable
cost.

The solution implemented here adds a flag to the __perf_output_begin()
function that performs the reserving of buffer space.  The new flag
(stay_in_page) indicates whether the requested chunk of memory must be
on a single page.  In this case, the requested size cannot exceed the
page size.  If the request cannot be satisfied within the current page,
the unused portion of the current page is filled with 0s.

A new function perf_output_begin_forward_in_page() is to be used to
commence output that cannot cross page boundaries.

Signed-off-by: Kris Van Hees <kris.van.hees@oracle.com>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
---
 include/linux/perf_event.h  |  3 ++
 kernel/events/ring_buffer.c | 65 ++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 15a82ff0aefe..2b35d1ce61f8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1291,6 +1291,9 @@ extern int perf_output_begin(struct perf_output_handle *handle,
 extern int perf_output_begin_forward(struct perf_output_handle *handle,
 				    struct perf_event *event,
 				    unsigned int size);
+extern int perf_output_begin_forward_in_page(struct perf_output_handle *handle,
+					     struct perf_event *event,
+					     unsigned int size);
 extern int perf_output_begin_backward(struct perf_output_handle *handle,
 				      struct perf_event *event,
 				      unsigned int size);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 674b35383491..01ba540e3ee0 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -116,9 +116,11 @@ ring_buffer_has_space(unsigned long head, unsigned long tail,
 static __always_inline int
 __perf_output_begin(struct perf_output_handle *handle,
 		    struct perf_event *event, unsigned int size,
-		    bool backward)
+		    bool backward, bool stay_in_page)
 {
 	struct ring_buffer *rb;
+	unsigned int adj_size;
+	unsigned int gap_size;
 	unsigned long tail, offset, head;
 	int have_lost, page_shift;
 	struct {
@@ -144,6 +146,13 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 	}
 
+	page_shift = PAGE_SHIFT + page_order(rb);
+
+	if (unlikely(stay_in_page)) {
+		if (size > (1UL << page_shift))
+			goto out;
+	}
+
 	handle->rb    = rb;
 	handle->event = event;
 
@@ -156,13 +165,24 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	perf_output_get_handle(handle);
 
+	gap_size = 0;
+	adj_size = size;
 	do {
 		tail = READ_ONCE(rb->user_page->data_tail);
 		offset = head = local_read(&rb->head);
+
+		if (unlikely(stay_in_page)) {
+			gap_size = (1UL << page_shift) -
+				   (offset & ((1UL << page_shift) - 1));
+			if (gap_size < size)
+				adj_size += gap_size;
+		}
+
 		if (!rb->overwrite) {
 			if (unlikely(!ring_buffer_has_space(head, tail,
 							    perf_data_size(rb),
-							    size, backward)))
+							    adj_size,
+							    backward)))
 				goto fail;
 		}
 
@@ -179,9 +199,9 @@ __perf_output_begin(struct perf_output_handle *handle,
 		 */
 
 		if (!backward)
-			head += size;
+			head += adj_size;
 		else
-			head -= size;
+			head -= adj_size;
 	} while (local_cmpxchg(&rb->head, offset, head) != offset);
 
 	if (backward) {
@@ -189,6 +209,22 @@ __perf_output_begin(struct perf_output_handle *handle,
 		head = (u64)(-head);
 	}
 
+	/*
+	 * If we had to skip over the remainder of the current page because it
+	 * is not large enough to hold the sample and the sample is not allowed
+	 * to cross a page boundary, we need to clear the remainder of the page
+	 * (fill it with 0s so it is clear we skipped it), and adjust the start
+	 * of the sample (offset).
+	 */
+	if (stay_in_page && gap_size > 0) {
+		int page = (offset >> page_shift) & (rb->nr_pages - 1);
+
+		offset &= (1UL << page_shift) - 1;
+		memset(rb->data_pages[page] + offset, 0, gap_size);
+
+		offset = head - size;
+	}
+
 	/*
 	 * We rely on the implied barrier() by local_cmpxchg() to ensure
 	 * none of the data stores below can be lifted up by the compiler.
@@ -197,8 +233,6 @@ __perf_output_begin(struct perf_output_handle *handle,
 	if (unlikely(head - local_read(&rb->wakeup) > rb->watermark))
 		local_add(rb->watermark, &rb->wakeup);
 
-	page_shift = PAGE_SHIFT + page_order(rb);
-
 	handle->page = (offset >> page_shift) & (rb->nr_pages - 1);
 	offset &= (1UL << page_shift) - 1;
 	handle->addr = rb->data_pages[handle->page] + offset;
@@ -233,13 +267,26 @@ __perf_output_begin(struct perf_output_handle *handle,
 int perf_output_begin_forward(struct perf_output_handle *handle,
 			     struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, false);
+	return __perf_output_begin(handle, event, size, false, false);
+}
+
+/*
+ * Prepare the ring buffer for 'size' bytes of output for the given event.
+ * This particular version is used when the event data is not allowed to cross
+ * a page boundary.  This means size cannot be more than PAGE_SIZE.  It also
+ * ensures that any unused portion of a page is filled with zeros.
+ */
+int perf_output_begin_forward_in_page(struct perf_output_handle *handle,
+				      struct perf_event *event,
+				      unsigned int size)
+{
+	return __perf_output_begin(handle, event, size, false, true);
 }
 
 int perf_output_begin_backward(struct perf_output_handle *handle,
 			       struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, true);
+	return __perf_output_begin(handle, event, size, true, false);
 }
 
 int perf_output_begin(struct perf_output_handle *handle,
@@ -247,7 +294,7 @@ int perf_output_begin(struct perf_output_handle *handle,
 {
 
 	return __perf_output_begin(handle, event, size,
-				   unlikely(is_write_backward(event)));
+				   unlikely(is_write_backward(event)), false);
 }
 
 unsigned int perf_output_copy(struct perf_output_handle *handle,
-- 
2.20.1

