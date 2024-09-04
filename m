Return-Path: <bpf+bounces-38874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B396BC9D
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27E41C21730
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92D1D9D6F;
	Wed,  4 Sep 2024 12:41:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66261D933C;
	Wed,  4 Sep 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453680; cv=none; b=iVmZplSgkI/OYhFi/Ck9fwAC4PliGnwkExHp5xhJLPJlNNy50dlAQ+cjL6/9tK0DWIaf/hyMpE52R0ruoCqr+VcMdT7C9Zjiy5Eq2BiRjieGwwTkRoeW4ssyp3Hl+/VUHvHHEM7Isua0gp89K/Afl+4TxgfHoaytO04GAReue/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453680; c=relaxed/simple;
	bh=7eB/rlYGwMuL7IZpy++WQDT8FnMlscBwvb7t0s8HaqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVfl08tSfOEAjHDGa9c7SQxy6IdWRFuBBo+s9m4qFsEXX5bFAJBGD062FtKsNFWK9Bzto+SQ8+WpeVikGajEOJIotMzSfRrBr+lu3bC3XNyt5YF98ueqHb8loKnZT6VfIGWNWdAAmPp7cvhuwjBRmGez3L0ulobvVMmKzD5uGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzMY60s0Qz4f3lfj;
	Wed,  4 Sep 2024 20:40:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F1F8F1A14D6;
	Wed,  4 Sep 2024 20:41:13 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with SMTP id Syh0CgCHvGFdVdhmhod9AQ--.48162S2;
	Wed, 04 Sep 2024 20:41:13 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH -next 0/2] perf stat: Support inherit events for bperf
Date: Wed,  4 Sep 2024 12:31:01 +0000
Message-Id: <20240904123103.732507-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHvGFdVdhmhod9AQ--.48162S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy5XFyfurW8tw4xAF4ktFb_yoW3Wrb_Ga
	4IqFyqqrWDAF92qa4ak3WrAr93XFWfZry8ta95WF45Cw4Yvr1UZF4kZryUAryrXF4UZrsx
	Jwn5tryfuay3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
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

Tengda Wu (2):
  perf stat: Support inherit events during fork() for bperf
  perf test: Use sqrtloop workload to test bperf event

 tools/perf/tests/shell/stat_bpf_counters.sh   |  2 +-
 tools/perf/util/bpf_counter.c                 |  9 +--
 tools/perf/util/bpf_skel/bperf_follower.bpf.c | 75 +++++++++++++++++--
 tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
 4 files changed, 79 insertions(+), 12 deletions(-)

-- 
2.34.1


