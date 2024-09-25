Return-Path: <bpf+bounces-40314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D19D986155
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 16:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D728AD3D
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34E71922CC;
	Wed, 25 Sep 2024 14:06:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD21922C6;
	Wed, 25 Sep 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273206; cv=none; b=cPEpvSm0onYQ5g+nf1pDZK2/MDqAxIwSqT508N4j7hzvZTdqMzwZpezNBk6xS74rdlPgkvGeiajj0phHNnjGmVbZ+0Zpre3HeGQ+8cxMtQMekSV+vgdfFk0IDQOGY6l3hD4e6OYmOkLrXYKIJMPHwhu+GH2BlOWUffTFnUzG9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273206; c=relaxed/simple;
	bh=SzO8X16jZRvAUKwUC7XqsRzeE7wXfOxIoUul93xnJtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCiWKWDx7Wd/VgOQ3ypfTKDVT2Y517scKrUqTqCClr3fGBLSu8xkBAfAnxIxIQ+Bxb/L/hweSl20EhZ24GgyTBx4pKl/XIRFsto3nVbBQ24/75Z62Pfujkeq7O4ZZHcUy6LGedb+AhRYkmnUYqaTAxb5AvqkeOga6ArCZcAu9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XDJRs6dLfz4f3jHn;
	Wed, 25 Sep 2024 22:06:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 23F921A0568;
	Wed, 25 Sep 2024 22:06:34 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgBHfMjLGPRmMo9HCQ--.17785S3;
	Wed, 25 Sep 2024 22:06:32 +0800 (CST)
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
Subject: [PATCH -next 1/2] perf stat: Increase perf_attr_map entries
Date: Wed, 25 Sep 2024 13:55:22 +0000
Message-Id: <20240925135523.367957-2-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHfMjLGPRmMo9HCQ--.17785S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UCF1fJF47Kw15Jry3XFb_yoW8Ww1kpF
	4DCrW7tr15Ww18Jw1DAwsxWas0g3y3uFW3Wr1fKw4FyFnaqwn3KayxWFyYqF15XrZ2934F
	qr1qgr4UuayUuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

bperf restricts the size of perf_attr_map's entries to 16, which
cannot hold all events in many scenarios. A typical example is
when the user specifies `-a -ddd` ([0]). And in other cases such as
top-down analysis, which often requires a set of more than 16 PMUs
to be collected simultaneously.

Fix this by increase perf_attr_map entries to 100, and an event
number check has been introduced when bperf__load() to ensure that
users receive a more friendly prompt when the event limit is reached.

  [0] https://lore.kernel.org/all/20230104064402.1551516-3-namhyung@kernel.org/

Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/bpf_counter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 7a8af60e0f51..3346129c20cf 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -28,7 +28,7 @@
 #include "bpf_skel/bperf_leader.skel.h"
 #include "bpf_skel/bperf_follower.skel.h"
 
-#define ATTR_MAP_SIZE 16
+#define ATTR_MAP_SIZE 100
 
 static inline void *u64_to_ptr(__u64 ptr)
 {
@@ -451,6 +451,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	enum bperf_filter_type filter_type;
 	__u32 filter_entry_cnt, i;
 
+	if (evsel->evlist->core.nr_entries > ATTR_MAP_SIZE) {
+		pr_err("Too many events, please limit to %d or less\n",
+			ATTR_MAP_SIZE);
+		return -1;
+	}
+
 	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
 		return -1;
 
-- 
2.34.1


