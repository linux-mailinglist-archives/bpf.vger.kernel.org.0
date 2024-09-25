Return-Path: <bpf+bounces-40313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54793986153
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F294A1F27866
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69D61B4C32;
	Wed, 25 Sep 2024 14:06:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954511B3F3E;
	Wed, 25 Sep 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273201; cv=none; b=IZkYfzVf365nxpTchjcnrF8yXbi4HK0Tnf5l5Kxj/WUPmcLXzC1FRzfwQoyVAOaMssApWwsbZpbIctRdSYqy+SuOuzcUpN2jV3mW5E8/ia31jxuvps6lS/GDOvJrHcBMUBx5xP8mTQKtmw+Xl6b6aEOIB3MzlJrz9/gWn6Cm60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273201; c=relaxed/simple;
	bh=X2lPzjfCfv1KuQ2t48jGTVr/WPoj/wwdy2lWQNASttY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKjo7JO5nczgsDrbmU++T/InK0O1v5ExOcHD2lLpp1dN0CWc6F5y6cE0Aya91mpzYgsSZg6tK9/ua090gB27NBndJPxPB7Znf9sG1oMPDNgaaJT+dnzaQzlKl2pT8siYTBH1GY6S9RMbnhcBrIKZlYHHyd3mAU3zxdwCAlC9osQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XDJRt11D0z4f3lV7;
	Wed, 25 Sep 2024 22:06:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 148281A0568;
	Wed, 25 Sep 2024 22:06:35 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgBHfMjLGPRmMo9HCQ--.17785S4;
	Wed, 25 Sep 2024 22:06:34 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: song@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH -next 2/2] perf stat: Fix incorrect display of bperf when event count is 0
Date: Wed, 25 Sep 2024 13:55:23 +0000
Message-Id: <20240925135523.367957-3-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925135523.367957-1-wutengda@huaweicloud.com>
References: <20240925135523.367957-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHfMjLGPRmMo9HCQ--.17785S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4UGr1rJF1UXw13Cr4UJwb_yoW5KFyDpa
	n3Cry7KryrXrWDZwn8ZwsFgay09w1fW3yag3s5KrWrAFsxX3ZrXry8Ja12y345XrnYyFya
	qw4q9r47ArW3ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

There are 2 possible reasons for the event count being 0: not
supported and not counted. Perf distinguishes between these two
possibilities through `evsel->supported`, but in bperf, this value
is always false. This is because bperf is prematurely break or
continue in the evlist__for_each_cpu loop under __run_perf_stat(),
skipping the `counter->supported` assignment, resulting in bperf
incorrectly displaying <not supported> when the count is 0.

The most direct way to fix it is to do `evsel->supported` assignment
when opening an event in bperf. However, since bperf only opens
events when loading the leader, the followers are not aware of
whether the event is supported or not. Therefore, we store the
`evsel->supported` value in a common location, which is the
`perf_event_attr_map`, to achieve synchronization of event support
across perf sessions.

Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/lib/perf/include/perf/bpf_perf.h |  1 +
 tools/perf/util/bpf_counter.c          | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/include/perf/bpf_perf.h b/tools/lib/perf/include/perf/bpf_perf.h
index e7cf6ba7b674..64c8d211726d 100644
--- a/tools/lib/perf/include/perf/bpf_perf.h
+++ b/tools/lib/perf/include/perf/bpf_perf.h
@@ -23,6 +23,7 @@
 struct perf_event_attr_map_entry {
 	__u32 link_id;
 	__u32 diff_map_id;
+	__u8 supported;
 };
 
 /* default attr_map name */
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 3346129c20cf..c04b274c3c45 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -425,18 +425,19 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	diff_map_fd = bpf_map__fd(skel->maps.diff_readings);
 	entry->link_id = bpf_link_get_id(link_fd);
 	entry->diff_map_id = bpf_map_get_id(diff_map_fd);
-	err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, entry, BPF_ANY);
-	assert(err == 0);
-
-	evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry->link_id);
-	assert(evsel->bperf_leader_link_fd >= 0);
-
 	/*
 	 * save leader_skel for install_pe, which is called within
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
-	evsel__open_per_cpu(evsel, all_cpu_map, -1);
+	if (!evsel__open_per_cpu(evsel, all_cpu_map, -1))
+		entry->supported = true;
+
+	err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, entry, BPF_ANY);
+	assert(err == 0);
+
+	evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry->link_id);
+	assert(evsel->bperf_leader_link_fd >= 0);
 
 out:
 	bperf_leader_bpf__destroy(skel);
@@ -446,7 +447,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 
 static int bperf__load(struct evsel *evsel, struct target *target)
 {
-	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
+	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff, false};
 	int attr_map_fd, diff_map_fd = -1, err;
 	enum bperf_filter_type filter_type;
 	__u32 filter_entry_cnt, i;
@@ -494,6 +495,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 		err = -1;
 		goto out;
 	}
+	evsel->supported = entry.supported;
 	/*
 	 * The bpf_link holds reference to the leader program, and the
 	 * leader program holds reference to the maps. Therefore, if
-- 
2.34.1


