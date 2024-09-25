Return-Path: <bpf+bounces-40315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C81F98635D
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 17:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B81B30E86
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B281940B3;
	Wed, 25 Sep 2024 14:16:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4A1862BB;
	Wed, 25 Sep 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273784; cv=none; b=l+QD3qqfH4pwFEBcfUDYjHm/wQ63TIhJ6Ow51U3w+5GrXbC2uZjkp0jq+bHTWnEQFn3vp4VBL9XxKzQyT6RFHuWSKtidG+c7YKf37O836ZiOYIHU6K/IzLQgo4uvFRBlIhRalsOl8sjwUauHYc7pOJ/69l8S1q1fPQEyT81nPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273784; c=relaxed/simple;
	bh=8LIWN1G9h1ViNeS7Fdb4rbeb8tkJ0QIJSte2LzZAifk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VsZ/UofZw1KB6ajXItrMzO8d1RsuK/gHmqpmE5Hugvpk4q4RhuHsdqYRQxFyTbLjeVlEx+P69c+jMU6fo8ufZW2ptPyBYVOGX2ArmB5oHPPiwpTdJ/GK3/7Mbo9gjXC17sXsQatzRJaPVC70GyUJnK3PyrBM/XbHfcLpJHfGa60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XDJg54tJJz4f3lW1;
	Wed, 25 Sep 2024 22:16:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 97F671A06D7;
	Wed, 25 Sep 2024 22:16:18 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgBnB4QwG_Rm1pv2CA--.13706S2;
	Wed, 25 Sep 2024 22:16:18 +0800 (CST)
Message-ID: <729eef63-6aed-44db-b18a-eb4bf96aeaab@huaweicloud.com>
Date: Wed, 25 Sep 2024 22:16:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 0/2] perf stat: Support inherit events for bperf
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>
Cc: song@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240916014318.267709-1-wutengda@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20240916014318.267709-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnB4QwG_Rm1pv2CA--.13706S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fXrykWFWUuF4kXw1DWrg_yoW8AFy7pF
	43C39xKwnYqF12ywnxAa17u3W5Wrn3CFy5Krn7trWSkF4DZr1UurWxKFy5tF98ZrWxJFWI
	vw4qgw43W398ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hello,

Sorry for pinging again. Is there any other suggestion with this patch set?
If there is, please let me know.

Thanks,
Tengda

On 2024/9/16 9:43, Tengda Wu wrote:
> Hi,
> 
> Here is the 3th version of the series to support inherit events for bperf.
> This version add pid or tgid selection based on filter type in new_task
> prog to avoid memory waste and potential count loss.
> 
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
> v3: (Address comments from Namhyung, thanks)
>  * Use pid or tgid based on filter type in new_task prog
>  * Add comments to explain pid usage for TGID type in exit_task prog
> 
> v2: https://lore.kernel.org/all/20240905115918.772234-1-wutengda@huaweicloud.com/
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
>  tools/perf/util/bpf_counter.c                 | 32 +++++--
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
>  4 files changed, 112 insertions(+), 14 deletions(-)
> 


