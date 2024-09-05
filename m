Return-Path: <bpf+bounces-39010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA296D7F1
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3E71F242DF
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74B919ADBF;
	Thu,  5 Sep 2024 12:10:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654B19AD87;
	Thu,  5 Sep 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538219; cv=none; b=FfPcXBqAQcAapZ+dBLa+iiXX+OTuxbosN4HkeB+qew4X+yclmGb2XcNTAqa0IYvqMyPp9qQg9O/KrS1qesAuUrDD3VAHtvQHHXuJyGCpj/sCxGNzUMDBg0uffkwL1rGNLQ3lnMvfv2Ghw0pSNZCOgKIml4VcnFCQu0Zrp85OCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538219; c=relaxed/simple;
	bh=FJm4MYAt2+ZJPcqMtMsR5Yex53gHjT2gT5lGYS/t2eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KlzwltQy6ONUp9tMAd/nOLJZoZ+7cF0XU3VxLAD7K4PdIWMhq+REo0jAmiPetZqoUqsR5QMj/i7Jbnr1KexdjNrSXdCWPf/fXA7/Lv8LZs/yADm1vCM8e/RN+pTaAUQ8lUgDdIcQXSF6nPY53nenbBUL+sNdD83D/AGNY+BMwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wzypy55YVz4f3kKd;
	Thu,  5 Sep 2024 20:10:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 133891A1123;
	Thu,  5 Sep 2024 20:10:13 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP1 (Coremail) with SMTP id cCh0CgBXgi6In9lmBpPPAQ--.58346S2;
	Thu, 05 Sep 2024 20:10:11 +0800 (CST)
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
Subject: [PATCH -next v2 0/2] perf stat: Support inherit events for bperf
Date: Thu,  5 Sep 2024 11:59:16 +0000
Message-Id: <20240905115918.772234-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXgi6In9lmBpPPAQ--.58346S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy5XFyfurW8tw4xAF4ktFb_yoWkArc_CF
	yIqa4ktrWkAF97ta47KF1rAr95JFWfZry8Ja1kWFWUCw13XF18WF4kZryUAryrXF48Xrsx
	twn5tryrua42gjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUI5fHUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

bperf (perf-stat --bpf-counter) has not supported inherit events
during fork() since it was first introduced.

This patch series tries to add this support by:
 1) adding two new bpf programs to monitor task lifecycle;
 2) recording new tasks in the filter map dynamically;
 3) reusing `accum_key` of parent task for new tasks.

Thanks,
Tengda


Changelog:
---------
v2: (Address comments from Namhyung)
 * Remove the unused init_filter_entries in follower bpf, declare
   a global filter_entry_count in bpf_counter instead
 * Attach on_newtask and on_exittask progs only if the filter type
   is either PID or TGID

v1: https://lore.kernel.org/all/20240904123103.732507-1-wutengda@huaweicloud.com/


Tengda Wu (2):
  perf stat: Support inherit events during fork() for bperf
  perf test: Use sqrtloop workload to test bperf event

 tools/perf/tests/shell/stat_bpf_counters.sh   |  2 +-
 tools/perf/util/bpf_counter.c                 | 32 +++++++--
 tools/perf/util/bpf_skel/bperf_follower.bpf.c | 70 +++++++++++++++++--
 tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
 4 files changed, 95 insertions(+), 14 deletions(-)

-- 
2.34.1


