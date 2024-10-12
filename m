Return-Path: <bpf+bounces-41794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29299B030
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2E81C2191F
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 02:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4D182BD;
	Sat, 12 Oct 2024 02:43:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCDE1CA84;
	Sat, 12 Oct 2024 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701001; cv=none; b=uj2MhXQ7Oh08ejJxme0ycQWoyDIgiweWUjMJFAtw6kK7hyXLSvRjhNZ3Pq3TKJARmUMXALFkCyj5tQxQlhKntLGlhQcc1X5EbGXZsO8hvroaGLN8NCZ1qwkqvJgAvX4EtXGYffqx1ud8PXmYKvUbIQjGj920ntAahfUzUO75ga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701001; c=relaxed/simple;
	bh=wACWfPaklFKPN8cXUAX3GlUaouTnIs874H/o2+vKfrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T83oqJn2+bw1+RpaIlb+wsgvb1f4BQhA/aTnKAduaH/ei+Su/7+9sRpD1gXSQXrapTOQObNpPTPx9ZjR+ehF4dZxsCdNcQLg2EfTybyaFokjHSL2pd6b/EKFae6HUx03mSA376I4OzwbZDByFH/GrURIudzM0DZEn1A0USd1AkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XQSTX5JXbz4f3lCf;
	Sat, 12 Oct 2024 10:42:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 70A001A06DA;
	Sat, 12 Oct 2024 10:43:14 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with SMTP id Syh0CgC3Nlw14glnqkFfDw--.43203S2;
	Sat, 12 Oct 2024 10:43:12 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	song@kernel.org,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH -next v4 0/2] perf stat: Support inherit events for bperf
Date: Sat, 12 Oct 2024 02:32:23 +0000
Message-Id: <20241012023225.151084-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3Nlw14glnqkFfDw--.43203S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1DJryUtr1kAr4fZF1UKFg_yoW8Zr4UpF
	4akry3Kw1F9F13twnxAanrWFyavr1fuFy5Gwn7trWfGF4DZr1UZrWxKFWYqF15XryxGry0
	vw1qgr1DuFZ5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jeLvtUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

Here is the 4th version of the series to support inherit events for bperf.
This version adds an `inherit` flag to bperf to control inherit behavior.
Considering future scalability, wrap the `inherit` flag with a new struct
`bpf_stat_opts` before passing it to bpf_counter__load().


bperf (perf-stat --bpf-counter) has not supported inherit events during
fork() since it was first introduced.

This patch series tries to add this support by:
 1) adding two new bpf programs to monitor task lifecycle;
 2) recording new tasks in the filter map dynamically;
 3) reusing `accum_key` of parent task for new tasks.

Thanks,
Tengda


Changelog:
---------
v4: (Address comments from Song and Namhyung, thanks)
 * Add an `inherit` flag to bperf to control inherit behavior

v3: https://lore.kernel.org/all/20240916014318.267709-1-wutengda@huaweicloud.com/
 * Use pid or tgid based on filter type in new_task prog
 * Add comments to explain pid usage for TGID type in exit_task prog

v2: https://lore.kernel.org/all/20240905115918.772234-1-wutengda@huaweicloud.com/
 * Remove the unused init_filter_entries in follower bpf, declare
   a global filter_entry_count in bpf_counter instead
 * Attach on_newtask and on_exittask progs only if the filter type
   is either PID or TGID

v1: https://lore.kernel.org/all/20240904123103.732507-1-wutengda@huaweicloud.com/


Tengda Wu (2):
  perf stat: Support inherit events during fork() for bperf
  perf test: Use sqrtloop workload to test bperf event

 tools/perf/builtin-stat.c                     |  4 +-
 tools/perf/tests/shell/stat_bpf_counters.sh   |  2 +-
 tools/perf/util/bpf_counter.c                 | 57 +++++++++---
 tools/perf/util/bpf_counter.h                 | 13 ++-
 tools/perf/util/bpf_counter_cgroup.c          |  3 +-
 tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
 tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
 7 files changed, 146 insertions(+), 25 deletions(-)

-- 
2.34.1


