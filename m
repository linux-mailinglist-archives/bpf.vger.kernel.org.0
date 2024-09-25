Return-Path: <bpf+bounces-40281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB69854F2
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74621F23A69
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290C158D81;
	Wed, 25 Sep 2024 08:03:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B96155393;
	Wed, 25 Sep 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251403; cv=none; b=QKJId8xWJPpnJsUjVKuVGokfz0g4sTV/5rLOqUouWf05qCou09VUo5z4AN7h4cRClIwGZBjFsugWea0WWMgE1q6rFjKv24QaHCQY6WAkNu6dM9DGJSZ+YiRa/y57qSXAAp70FgT7Rh7RMz+PVrinv1iAlEkHpQdpSKcrJaoo6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251403; c=relaxed/simple;
	bh=GfgCJD1+Lh3Rabp5DUKteK6uXZdxzDzdLe9UZgZIacU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3yZe9q1DneDiqKM/Lqkfmq1FPnjbuV9r10+g/3h4IaaClE1hwXSk/OAkhrzQ/J2isgENTrH7ZhFp1TUQjIwL2mF3tNKVJQMS85qMslJg2N3TVfqOVJGrsZhmLz6nJKKB3ufC3V3DiZHNnabmGJ3CJilJEgGSmuMlwFjNc4gU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XD8N71qbrz2DcYY;
	Wed, 25 Sep 2024 16:02:31 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 73A991401F4;
	Wed, 25 Sep 2024 16:03:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Sep 2024 16:03:18 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH net v2 0/2] fix two bugs related to page_pool
Date: Wed, 25 Sep 2024 15:57:05 +0800
Message-ID: <20240925075707.3970187-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Patch 1 fix a possible time window problem for page_pool.
Patch 2 fix the kernel crash problem at iommu_get_dma_domain
reported in [1].

When page_pool_put_unrefed_netmem() is called with allow_direct
being true, there is only a newly added checking overhead
introduced in patch 1, which seem to be no noticeable performance
impact.

When page_pool_put_unrefed_netmem() is called with allow_direct
being false, there is an added rcu read lock overhead introduced in
patch 1, and the overhead is about 13ns using the below test code,
but 'time_bench_page_pool02_ptr_ring' only show about 2ns overhead,
which is about 2% degradation.

+static int time_bench_rcu(
+       struct time_bench_record *rec, void *data)
+{
+       uint64_t loops_cnt = 0;
+       int i;
+
+       time_bench_start(rec);
+       /** Loop to measure **/
+       for (i = 0; i < rec->loops; i++) {
+               rcu_read_lock();
+               loops_cnt++;
+               barrier(); /* avoid compiler to optimize this loop */
+               rcu_read_unlock();
+       }
+       time_bench_stop(rec, loops_cnt);
+       return loops_cnt;
+}

When page_pool need to be refilled from or flushed to the page allocator,
the added overhead is the page_pool_item_add() and page_pool_item_del()
calling overhead, using below patch to enable Jesper's testing running in
arm64, the overhead is 0~20ns, which is quite variable 

Before this patchset:
root@(none)$ taskset -c 1 insmod bench_page_pool_simple.ko
[  136.641453] bench_page_pool_simple: Loaded
[  136.722560] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076968720 sec time_interval:76968720) - (invoke count:100000000 tsc_interval:7696855)
[  137.317006] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.771 ns (step:0) - (measurement period time:0.577164350 sec time_interval:577164350) - (invoke count:100000000 tsc_interval:57716429)
[  137.480852] time_bench: Type:lock Per elem: 1 cycles(tsc) 14.621 ns (step:0) - (measurement period time:0.146218730 sec time_interval:146218730) - (invoke count:10000000 tsc_interval:14621868)
[  138.842377] time_bench: Type:rcu Per elem: 1 cycles(tsc) 13.444 ns (step:0) - (measurement period time:1.344419820 sec time_interval:1344419820) - (invoke count:100000000 tsc_interval:134441975)
[  138.859656] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  139.132102] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 26.315 ns (step:0) - (measurement period time:0.263151430 sec time_interval:263151430) - (invoke count:10000000 tsc_interval:26315135)
[  139.150769] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  139.910642] time_bench: Type:no-softirq-page_pool02 Per elem: 7 cycles(tsc) 75.066 ns (step:0) - (measurement period time:0.750663200 sec time_interval:750663200) - (invoke count:10000000 tsc_interval:75066312)
[  139.929312] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  141.673951] time_bench: Type:no-softirq-page_pool03 Per elem: 17 cycles(tsc) 173.578 ns (step:0) - (measurement period time:1.735781610 sec time_interval:1735781610) - (invoke count:10000000 tsc_interval:173578155)
[  141.692970] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  141.700874] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  141.973638] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 26.364 ns (step:0) - (measurement period time:0.263645150 sec time_interval:263645150) - (invoke count:10000000 tsc_interval:26364508)
[  141.992912] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  142.531745] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 52.980 ns (step:0) - (measurement period time:0.529801250 sec time_interval:529801250) - (invoke count:10000000 tsc_interval:52980119)
[  142.550933] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  144.297646] time_bench: Type:tasklet_page_pool03_slow Per elem: 17 cycles(tsc) 173.802 ns (step:0) - (measurement period time:1.738029000 sec time_interval:1738029000) - (invoke count:10000000 tsc_interval:173802894)

After this patchset:
root@(none)$ taskset -c 1 insmod bench_page_pool_simple.ko
[  149.865799] bench_page_pool_simple: Loaded
[  149.946907] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076965620 sec time_interval:76965620) - (invoke count:100000000 tsc_interval:7696556)
[  150.722282] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 7.580 ns (step:0) - (measurement period time:0.758094660 sec time_interval:758094660) - (invoke count:100000000 tsc_interval:75809459)
[  150.886335] time_bench: Type:lock Per elem: 1 cycles(tsc) 14.640 ns (step:0) - (measurement period time:0.146405830 sec time_interval:146405830) - (invoke count:10000000 tsc_interval:14640578)
[  152.249454] time_bench: Type:rcu Per elem: 1 cycles(tsc) 13.460 ns (step:0) - (measurement period time:1.346009570 sec time_interval:1346009570) - (invoke count:100000000 tsc_interval:134600951)
[  152.266734] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  152.537046] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 26.100 ns (step:0) - (measurement period time:0.261007670 sec time_interval:261007670) - (invoke count:10000000 tsc_interval:26100761)
[  152.555714] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  153.342212] time_bench: Type:no-softirq-page_pool02 Per elem: 7 cycles(tsc) 77.729 ns (step:0) - (measurement period time:0.777293380 sec time_interval:777293380) - (invoke count:10000000 tsc_interval:77729331)
[  153.360881] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  155.287747] time_bench: Type:no-softirq-page_pool03 Per elem: 19 cycles(tsc) 191.800 ns (step:0) - (measurement period time:1.918007990 sec time_interval:1918007990) - (invoke count:10000000 tsc_interval:191800791)
[  155.306766] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  155.314670] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  155.584313] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 26.052 ns (step:0) - (measurement period time:0.260524810 sec time_interval:260524810) - (invoke count:10000000 tsc_interval:26052476)
[  155.603588] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  156.183214] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 57.059 ns (step:0) - (measurement period time:0.570594850 sec time_interval:570594850) - (invoke count:10000000 tsc_interval:57059478)
[  156.202402] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  158.045594] time_bench: Type:tasklet_page_pool03_slow Per elem: 18 cycles(tsc) 183.450 ns (step:0) - (measurement period time:1.834507700 sec time_interval:1834507700) - (invoke count:10000000 tsc_interval:183450764)

Patch for time_bench.h enable the out of tree testing on arm64 system:
@@ -101,6 +101,7 @@ struct time_bench_cpu {
  *  CPUID clears the high 32-bits of all (rax/rbx/rcx/rdx)
  */
 static __always_inline uint64_t tsc_start_clock(void) {
+#if defined(__i386__) || defined(__x86_64__)
        /* See: Intel Doc #324264 */
        unsigned hi, lo;
        asm volatile (
@@ -111,9 +112,13 @@ static __always_inline uint64_t tsc_start_clock(void) {
                "%rax", "%rbx", "%rcx", "%rdx");
        //FIXME: on 32bit use clobbered %eax + %edx
        return ((uint64_t)lo) | (((uint64_t)hi) << 32);
+#else
+       return get_cycles();
+#endif
 }

 static __always_inline uint64_t tsc_stop_clock(void) {
+#if defined(__i386__) || defined(__x86_64__)
        /* See: Intel Doc #324264 */
        unsigned hi, lo;
        asm volatile(
@@ -123,6 +128,9 @@ static __always_inline uint64_t tsc_stop_clock(void) {
                "CPUID\n\t": "=r" (hi), "=r" (lo)::
                "%rax", "%rbx", "%rcx", "%rdx");
        return ((uint64_t)lo) | (((uint64_t)hi) << 32);
+#else
+       return get_cycles();
+#endif
 }

 /* Notes for RDTSC and RDTSCP
@@ -186,10 +194,14 @@ enum {

 static __always_inline unsigned long long p_rdpmc(unsigned in)
 {
+#if defined(__i386__) || defined(__x86_64__)
        unsigned d, a;

        asm volatile("rdpmc" : "=d" (d), "=a" (a) : "c" (in) : "memory");
        return ((unsigned long long)d << 32) | a;
+#else
+       return 0;
+#endif
 }

 /* These PMU counter needs to be enabled, but I don't have the
@@ -216,7 +228,11 @@ static __always_inline unsigned long long pmc_clk(void)
 #define MSR_IA32_PCM2 0x400000C3
 inline uint64_t msr_inst(unsigned long long *msr_result)
 {
+#if defined(__i386__) || defined(__x86_64__)
        return rdmsrl_safe(MSR_IA32_PCM0, msr_result);
+#else
+       return 0;
+#endif
 }

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>

Change log:
V2:
  1. Add a item_full stat.
  2. Use container_of() for page_pool_to_pp().

Yunsheng Lin (2):
  page_pool: fix timing for checking and disabling napi_local
  page_pool: fix IOMMU crash when driver has already unbound

 drivers/net/ethernet/freescale/fec_main.c     |   8 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  14 +-
 drivers/net/ethernet/intel/libeth/rx.c        |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   3 +-
 drivers/net/netdevsim/netdev.c                |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +-
 include/linux/mm_types.h                      |   2 +-
 include/linux/skbuff.h                        |   1 +
 include/net/libeth/rx.h                       |   3 +-
 include/net/netmem.h                          |  10 +-
 include/net/page_pool/helpers.h               |   7 +
 include/net/page_pool/types.h                 |  17 +-
 net/core/devmem.c                             |   4 +-
 net/core/netmem_priv.h                        |   5 +-
 net/core/page_pool.c                          | 190 +++++++++++++++---
 net/core/page_pool_priv.h                     |  10 +-
 net/core/skbuff.c                             |   3 +-
 net/core/xdp.c                                |   3 +-
 19 files changed, 238 insertions(+), 58 deletions(-)

-- 
2.33.0


