Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292982F6242
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 14:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbhANNmI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 14 Jan 2021 08:42:08 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:22631 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729008AbhANNmH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 08:42:07 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-zekNGY1wPamDBjAyrEKhAA-1; Thu, 14 Jan 2021 08:41:11 -0500
X-MC-Unique: zekNGY1wPamDBjAyrEKhAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75D30190A7A1;
        Thu, 14 Jan 2021 13:41:09 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12D3560C47;
        Thu, 14 Jan 2021 13:41:02 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH bpf-next 3/3] perf: Add build id data in mmap2 event
Date:   Thu, 14 Jan 2021 14:40:44 +0100
Message-Id: <20210114134044.1418404-4-jolsa@kernel.org>
In-Reply-To: <20210114134044.1418404-1-jolsa@kernel.org>
References: <20210114134044.1418404-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to carry build id data in mmap2 event.

The build id data replaces maj/min/ino/ino_generation
fields, which are also used to identify map's binary,
so it's ok to replace them with build id data:

  union {
          struct {
                  u32       maj;
                  u32       min;
                  u64       ino;
                  u64       ino_generation;
          };
          struct {
                  u8        build_id_size;
                  u8        __reserved_1;
                  u16       __reserved_2;
                  u8        build_id[20];
          };
  };

Replaced maj/min/ino/ino_generation fields give us size
of 24 bytes. We use 20 bytes for build id data, 1 byte
for size and rest is unused.

There's new misc bit for mmap2 to signal there's build
id data in it:

  #define PERF_RECORD_MISC_MMAP_BUILD_ID   (1 << 14)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/perf_event.h | 42 +++++++++++++++++++++++++++++----
 kernel/events/core.c            | 32 +++++++++++++++++++++----
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b15e3447cd9f..cb6f84103560 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -386,7 +386,8 @@ struct perf_event_attr {
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
-				__reserved_1   : 30;
+				build_id       :  1, /* use build id in mmap2 events */
+				__reserved_1   : 29;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -659,6 +660,22 @@ struct perf_event_mmap_page {
 	__u64	aux_size;
 };
 
+/*
+ * The current state of perf_event_header::misc bits usage:
+ * ('|' used bit, '-' unused bit)
+ *
+ *  012         CDEF
+ *  |||---------||||
+ *
+ *  Where:
+ *    0-2     CPUMODE_MASK
+ *
+ *    C       PROC_MAP_PARSE_TIMEOUT
+ *    D       MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
+ *    E       MMAP_BUILD_ID / EXACT_IP / SCHED_OUT_PREEMPT
+ *    F       (reserved)
+ */
+
 #define PERF_RECORD_MISC_CPUMODE_MASK		(7 << 0)
 #define PERF_RECORD_MISC_CPUMODE_UNKNOWN	(0 << 0)
 #define PERF_RECORD_MISC_KERNEL			(1 << 0)
@@ -690,6 +707,7 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
  *
  *
  * PERF_RECORD_MISC_EXACT_IP:
@@ -699,9 +717,13 @@ struct perf_event_mmap_page {
  *
  * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
  *   Indicates that thread was preempted in TASK_RUNNING state.
+ *
+ * PERF_RECORD_MISC_MMAP_BUILD_ID:
+ *   Indicates that mmap2 event carries build id data.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
+#define PERF_RECORD_MISC_MMAP_BUILD_ID		(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
@@ -915,10 +937,20 @@ enum perf_event_type {
 	 *	u64				addr;
 	 *	u64				len;
 	 *	u64				pgoff;
-	 *	u32				maj;
-	 *	u32				min;
-	 *	u64				ino;
-	 *	u64				ino_generation;
+	 *	union {
+	 *		struct {
+	 *			u32		maj;
+	 *			u32		min;
+	 *			u64		ino;
+	 *			u64		ino_generation;
+	 *		};
+	 *		struct {
+	 *			u8		build_id_size;
+	 *			u8		__reserved_1;
+	 *			u16		__reserved_2;
+	 *			u8		build_id[20];
+	 *		};
+	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
 	 * 	struct sample_id		sample_id;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d18791a72d..c37401e3e5f7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -53,6 +53,7 @@
 #include <linux/min_heap.h>
 #include <linux/highmem.h>
 #include <linux/pgtable.h>
+#include <linux/buildid.h>
 
 #include "internal.h"
 
@@ -397,6 +398,7 @@ static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
 static atomic_t nr_cgroup_events __read_mostly;
 static atomic_t nr_text_poke_events __read_mostly;
+static atomic_t nr_build_id_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4673,6 +4675,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_dec(&nr_mmap_events);
+	if (event->attr.build_id)
+		atomic_dec(&nr_build_id_events);
 	if (event->attr.comm)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
@@ -8046,6 +8050,8 @@ struct perf_mmap_event {
 	u64			ino;
 	u64			ino_generation;
 	u32			prot, flags;
+	u8			build_id[BUILD_ID_SIZE_MAX];
+	u32			build_id_size;
 
 	struct {
 		struct perf_event_header	header;
@@ -8077,6 +8083,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
 	u32 type = mmap_event->event_id.header.type;
+	bool use_build_id;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
@@ -8101,13 +8108,25 @@ static void perf_event_mmap_output(struct perf_event *event,
 	mmap_event->event_id.pid = perf_event_pid(event, current);
 	mmap_event->event_id.tid = perf_event_tid(event, current);
 
+	use_build_id = event->attr.build_id && mmap_event->build_id_size;
+
+	if (event->attr.mmap2 && use_build_id)
+		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
+
 	perf_output_put(&handle, mmap_event->event_id);
 
 	if (event->attr.mmap2) {
-		perf_output_put(&handle, mmap_event->maj);
-		perf_output_put(&handle, mmap_event->min);
-		perf_output_put(&handle, mmap_event->ino);
-		perf_output_put(&handle, mmap_event->ino_generation);
+		if (use_build_id) {
+			u8 size[4] = { (u8) mmap_event->build_id_size, 0, 0, 0 };
+
+			__output_copy(&handle, size, 4);
+			__output_copy(&handle, mmap_event->build_id, BUILD_ID_SIZE_MAX);
+		} else {
+			perf_output_put(&handle, mmap_event->maj);
+			perf_output_put(&handle, mmap_event->min);
+			perf_output_put(&handle, mmap_event->ino);
+			perf_output_put(&handle, mmap_event->ino_generation);
+		}
 		perf_output_put(&handle, mmap_event->prot);
 		perf_output_put(&handle, mmap_event->flags);
 	}
@@ -8236,6 +8255,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
+	if (atomic_read(&nr_build_id_events))
+		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
 		       NULL);
@@ -11172,6 +11194,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_inc(&nr_mmap_events);
+	if (event->attr.build_id)
+		atomic_inc(&nr_build_id_events);
 	if (event->attr.comm)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
-- 
2.26.2

