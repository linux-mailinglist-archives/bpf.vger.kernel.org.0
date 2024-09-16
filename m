Return-Path: <bpf+bounces-39968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4DA9799DE
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 03:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134C61F22AC8
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 01:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C227D2F5;
	Mon, 16 Sep 2024 01:53:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D4DDA0;
	Mon, 16 Sep 2024 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726451632; cv=none; b=Ybik9cB7rP8RDA0z7sp2QYLtzxBNtgpFHAC38Frpdxwp4H+srmUM6Wi61/R98PwJJjdWti2mBi4fxp0ZabJQ8I+6XYIrjy2h2upcCr899qIe7+uo5ncD5h6r3cAWr2KXsC9z6Xxj/MoK+bF5Fmnn2kzDjzXHv9T9PM6bCviPS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726451632; c=relaxed/simple;
	bh=EZg8BP7QEEFnaOpqNdGInDilki197PnDw4R3LeTnKcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WKFy/bmX8rdzrLzD0+tECkyiKN3nhv5oloUCLSxA/uVczZyzU+5VGOugEevZSQDslM1sXHeAamhF+mpgyXfYTgI9rOAE/WGxyVZuEZjLaIF/w85OKPg1YrL7G08nzfuKjH/uskB+RmIuaTHvkYJ5Cp5jVcybFQNbc9vizdc0fYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X6ScL1LxJz4f3kvl;
	Mon, 16 Sep 2024 09:53:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A623A1A08FC;
	Mon, 16 Sep 2024 09:53:38 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgCXy8eZj+dmP_LGBQ--.63146S2;
	Mon, 16 Sep 2024 09:53:36 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: song@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH -next v3 0/2] perf stat: Support inherit events for bperf
Date: Mon, 16 Sep 2024 01:43:16 +0000
Message-Id: <20240916014318.267709-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXy8eZj+dmP_LGBQ--.63146S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1DXFy5Kr48uF13GF4UArb_yoW8Xw4UpF
	43C3y3KwnYgF1aywnxAa17W3W5Wrn5CFy5Grn7trWfKF4DZry7urWxKFy5tFy5urWxJFW0
	vr1qgw45uas8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

Here is the 3th version of the series to support inherit events for bperf.
This version add pid or tgid selection based on filter type in new_task
prog to avoid memory waste and potential count loss.


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
v3: (Address comments from Namhyung, thanks)
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

 tools/perf/tests/shell/stat_bpf_counters.sh   |  2 +-
 tools/perf/util/bpf_counter.c                 | 32 +++++--
 tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
 tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
 4 files changed, 112 insertions(+), 14 deletions(-)

-- 
2.34.1


