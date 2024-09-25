Return-Path: <bpf+bounces-40312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73236986152
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392EC28629E
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94611B3F2B;
	Wed, 25 Sep 2024 14:06:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840BB1B3B35;
	Wed, 25 Sep 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273197; cv=none; b=mS+7kC/SFchgwTF6w6nyxbJLF3EpvePiGfMqKmXcNh8YfKS4MrU/QlO0hpWVs6zz2eaaTVgJTyGiiBkpysAgdiZ9AaIXnJMBmOldkdO2cNRqWweuHjJsINTN291AEuvbc8vhg1SSkJSXPvUrsx/55nWUQcehKPUc9PduT3KYC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273197; c=relaxed/simple;
	bh=T0BxJmlX9J/ax3CKbvhZNZFj2huk3UBFdSAh5Ebn3sE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=enYfT5NpHawjz4mWo89H+dxvMmGviP4KImsb1mRzbXC4zQplOCq+Et+9vnthM+KPy1a9yj5YwrkXKlLvM7NQx7MOtWcVGVNCzJq7wpOUnfe0wtzb1ywhvpXi3iso0HGzcyQy/+vKdsqTsOFDqiP2mnPUxqxB9WVZ2SneRF2AT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XDJRv2dlhz4f3jq9;
	Wed, 25 Sep 2024 22:06:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8F5291A17CC;
	Wed, 25 Sep 2024 22:06:30 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgBHfMjLGPRmMo9HCQ--.17785S2;
	Wed, 25 Sep 2024 22:06:30 +0800 (CST)
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
Subject: [PATCH -next 0/2] perf stat: a set of small fixes for bperf
Date: Wed, 25 Sep 2024 13:55:21 +0000
Message-Id: <20240925135523.367957-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHfMjLGPRmMo9HCQ--.17785S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4DuF4fAF4DJF48Zr45GFg_yoWDAwc_Ca
	yIy34kZrWUZa1qyasrK3WYqry0grWrAry8JF95Ka17J34rXrn8u3WkC393X3y0qa1UXrn0
	krn3Xw1fAw4akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

This is a set of small fixes for bperf (perf-stat --bpf-counters).

It aims to fix the following two issues:
  1) bperf limited the number of events to a maximum of 16, which
     caused failures in some scenarios and lacked friendly prompts. 
  2) bperf failed to correctly handle whether events were supported,
     resulting in the incorrect display when the event count was 0.

The reason for fixing these issues is that bperf is very useful in
some cost-sensitive scenarios, such as top-down analysis scenarios.
Increasing the attr map size can allow these scenarios to collect
more events at the same time, making it possible to gather enough
information to perform complex metric calculations in top-down.

Thanks,
Tengda

Tengda Wu (2):
  perf stat: Increase perf_attr_map entries
  perf stat: Fix incorrect display of bperf when event count is 0

 tools/lib/perf/include/perf/bpf_perf.h |  1 +
 tools/perf/util/bpf_counter.c          | 26 +++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.34.1


