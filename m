Return-Path: <bpf+bounces-39888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA4978E90
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271A71F24B83
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 06:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4B1CDA13;
	Sat, 14 Sep 2024 06:58:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C5720328;
	Sat, 14 Sep 2024 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726297101; cv=none; b=dtoL9gQI42DXCVbq8cTPf6xfHgnzSRH4OmnUbnKnJvdzWCqPIQvx0YvKyYwJayaUhFUkHAm+zsc/E8F5lfKkVWvWUU9/XuxmgjrwGdgfohGUrciK6r8h+XDxOqzNhui/9poB4mufxPDkmTmilVfJ/iumfBegJi10MscZbrUgaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726297101; c=relaxed/simple;
	bh=76/NlTo2FJWz02hzNbiFQBHEOZ3d7GE73yzvs/WKS6c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AXZQUB+A08Kmnw3T4+mXKsganGG49mr5am2JWOubIXMBtxHS9CMAG1C9ctjWHo7nzF6sWexpnzlFADvAhmr9s61CsYl0qhrV4AzENrqIdhv+EcQ1bWpWUgS9Dk2g9mBcfugMQQVYooo6eg+9YBXeOLngBbD81pg7YQqrBJZFIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X5MSb38KXz4f3kvf;
	Sat, 14 Sep 2024 14:57:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CB3701A018D;
	Sat, 14 Sep 2024 14:58:07 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgBXi2D8M+Vms30aBQ--.9992S2;
	Sat, 14 Sep 2024 14:58:05 +0800 (CST)
Message-ID: <1f1a9b07-0818-4e82-9690-0b3ae3d33433@huaweicloud.com>
Date: Sat, 14 Sep 2024 14:58:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 0/2] perf stat: Support inherit events for bperf
From: Tengda Wu <wutengda@huaweicloud.com>
To: Song Liu <song@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240905115918.772234-1-wutengda@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20240905115918.772234-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXi2D8M+Vms30aBQ--.9992S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWDtrWrtry3Kr4xKrW5GFg_yoW8XryDpF
	43C39Igw1rKF1akwnxAwsruF1Yqr93CFy5Gr1kKrWxJF4kZr1DWrZ7KFW5tF98XryxCFy0
	vw4qgw45WFZ8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Song and Numhyung,

Gentle ping.

This patch set provides event inheritance support for bperf during fork(). Currently, based on numhyung's feedback, the v2 version has been modified. Could you please take a look?

Any comment or suggestion is appreciated.

Thanks!
Tengda

On 2024/9/5 19:59, Tengda Wu wrote:
> Hi,
> 
> bperf (perf-stat --bpf-counter) has not supported inherit events
> during fork() since it was first introduced.
> 
> This patch series tries to add this support by:
>  1) adding two new bpf programs to monitor task lifecycle;
>  2) recording new tasks in the filter map dynamically;
>  3) reusing `accum_key` of parent task for new tasks.
> 
> Thanks,
> Tengda
> 
> 
> Changelog:
> ---------
> v2: (Address comments from Namhyung)
>  * Remove the unused init_filter_entries in follower bpf, declare
>    a global filter_entry_count in bpf_counter instead
>  * Attach on_newtask and on_exittask progs only if the filter type
>    is either PID or TGID
> 
> v1: https://lore.kernel.org/all/20240904123103.732507-1-wutengda@huaweicloud.com/
> 
> 
> Tengda Wu (2):
>   perf stat: Support inherit events during fork() for bperf
>   perf test: Use sqrtloop workload to test bperf event
> 
>  tools/perf/tests/shell/stat_bpf_counters.sh   |  2 +-
>  tools/perf/util/bpf_counter.c                 | 32 +++++++--
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 70 +++++++++++++++++--
>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
>  4 files changed, 95 insertions(+), 14 deletions(-)
> 


