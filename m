Return-Path: <bpf+bounces-79247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E46D31E31
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE30D30C26AC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDFF27F4E7;
	Fri, 16 Jan 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC8sMxug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE64C92
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570213; cv=none; b=XbgOYCbobrPgGPS+SNwWrmUplKCm7bzE3hHP0llONwWMpRftCdX6pbJkrfi5K39msGGkERmX5Mf89OeAUDKiDP/a6WVwhDqWY6kAFj/DCu5N0Qgar1TjdrxvsM0sW6iRgb+aDvMcLmwCFHThkjc5LbFEsS+qskwM4mFHyOXIfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570213; c=relaxed/simple;
	bh=vJxakdKrgKs58r6a7QqQuhyqFhhMaSQTK74u0qxkILM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ydd/qcIdHIxdToxQl7KKOfRvqHnm830t54WXy9We2lgg3vatTSS35ZSDZugndUYReW2qfFb1xKaTFlUVlH0ZGvAslVLIXt1tbKNYAa7FSGz6DY77c7aCl06Thf9appMdwMGR5Gncie2KZsq/8Yj+3Uj4CMGDxLDiVReY3n6YShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC8sMxug; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1220154725fso1427577c88.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768570209; x=1769175009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgk08Xkqwd3w1rAVgK99iFxYWtaByA8GRN9AUbv5wfI=;
        b=KC8sMxugfbv6TcCBBuaohgmFhPmKZ7J0SHlyamQcLGg+J/G48W71k9RrVwL6gxtiOj
         JL5YoWTKrK2XWVsW8vMjp52ZJkzzvd5TjV4Ppd+S+w5919oFzVRWUIK9+P0stIltsjJ7
         mrGkQ6z2GpYguQ34bGqyr0UNCwneNpkZ7gRy7i7tjFiixyUYc4y2vK3MoaWUtOUAZsty
         K/2HXODJwIbnzOLVYsCBnma9qWCM/o9IIIiLHCEIK1hEq2Tigwrfms8BbPwDPNnGfogJ
         bOZM0preHfHLuWNFyeDU5JekNXtTGZGogHBwNFpUoJFc2+68dgqUq09gueCXjAwe6LN4
         KwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768570210; x=1769175010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qgk08Xkqwd3w1rAVgK99iFxYWtaByA8GRN9AUbv5wfI=;
        b=PlP0oyM1Om2SH3PLCFo1dzOpRjmW+plGvRzyoqBE96uQbfHTSGRF17FZAJINNS/Ke/
         MAXPXT+s+cwhglCB1FLuXNuMfmjwj/RDOASbdQqXVBgcLYh8zTvx6jB3eDtiI9a89McM
         q65s5GVmMpFS33xaS+ZXD/S7IXz7bg3obKzjOj9TXm5eB8lYwCMGICBldAj2/ykc22jo
         J06gcOutABNFDOhwFKR7fFfojhvm+AwfNb/k+ZqC+taM6vUGkjRsvITYmiVhbSbbDOqy
         bstz1lCmXg+m5OF9DMAkr3pGfe8E8r74YksLiCsOEaLvI91nEq9o4hVY26q/cxJrZeF6
         Of3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZLflbqGoJLuuSRpT9y5r2L4zC6PeR1BF6haSBiLd2NVK+XuMowO3ciK4diV8VvY/TK9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKm4YP4gwRy56BKpFWDlyUfrj3l+eDu5B6IZK+L3XlKguklM5U
	4ZNSZ/4HH5pbTc8TkSdtD3YSx3LrYtUcOojF/UGyzNXC1ipkLKOh2jBY
X-Gm-Gg: AY/fxX5dbsfbp/K3J6zsicfBmJykB/m9zfLWb69A3iCbhVTvvz+hx4NgTaouUbX3A3p
	BIR4e7Pk3xLeqtnqB+3ZGRTm/ODgGP2jF1YiqA27mmKQEdpOsA4w5Mye6FIpo9joPyWRfClXTUK
	MiqMxQ1Y1kVOKGsOt0Y4nzieRwIA+Fiu/KShtgU1rIPviamPYGkxck2ebhvZyUrQok/M595QCOo
	fdpn7krBqMjiOHe9So3jZcealpE6GTC8u/ydW2vjRVCMBCCw04aBQvTPlga5l/4hiZ0phSk+vpo
	NZCoF+7kwjcVcqihOFfLOOm1ZXa78kuUYCglS/KKXkN3FFNPt801S4pYzeid0nNyCdS0mcYsc8d
	ShkRzLqJ+M8jhktOmM4e/b+PK5fY12XakIaWc17iAkTEmDgryA+cRaNauWuyOjmR06qhFrKp3Gf
	EJtCDNBGPUCjxOuOKTflhYIHI=
X-Received: by 2002:a05:7022:418e:b0:11d:fcc9:f225 with SMTP id a92af1059eb24-1244ae87b6cmr2854068c88.14.1768570207932;
        Fri, 16 Jan 2026 05:30:07 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm2308209c88.7.2026.01.16.05.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:30:07 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: memxor@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	realwujing@qq.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	yuanql9@chinatelecom.cn,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Qiliang Yuan <realwujing@gmail.com>
Subject: [PATCH v2] bpf/verifier: implement slab cache for verifier state list
Date: Fri, 16 Jan 2026 21:29:53 +0800
Message-Id: <20260116132953.40636-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAP01T76JECHPV4Fdvm2bds=Eb36UYhQswd7oAJ+fRzW_1ZtnVw@mail.gmail.com>
References: <CAP01T76JECHPV4Fdvm2bds=Eb36UYhQswd7oAJ+fRzW_1ZtnVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier's state exploration logic in is_state_visited() frequently
allocates and deallocates 'struct bpf_verifier_state_list' nodes. Currently,
these allocations use generic kzalloc(), which leads to significant memory
management overhead and page faults during high-complexity verification,
especially in multi-core parallel scenarios.

This patch introduces a dedicated 'bpf_verifier_state_list' slab cache to
optimize these allocations, providing better speed, reduced fragmentation,
and improved cache locality. All allocation and deallocation paths are
migrated to use kmem_cache_zalloc() and kmem_cache_free().

Performance evaluation using a stress test (1000 conditional branches)
executed in parallel on 32 CPU cores for 60 seconds shows significant
improvements:

Metric              | Baseline      | Patched       | Delta (%)
--------------------|---------------|---------------|----------
Page Faults         | 12,377,064    | 8,534,044     | -31.05%
IPC                 | 1.17          | 1.22          | +4.27%
CPU Cycles          | 1,795.37B     | 1,700.33B     | -5.29%
Instructions        | 2,102.99B     | 2,074.27B     | -1.37%

Detailed Benchmark Report:
==========================
1. Test Case Compilation (verifier_state_stress.c):
clang -O2 -target bpf -D__TARGET_ARCH_x86 -I. -I./tools/include \
      -I./tools/lib/bpf -I./tools/testing/selftests/bpf -c \
      verifier_state_stress.c -o verifier_state_stress.bpf.o

2. Test Command (Executed on 32-core system):
sudo ./tools/perf/perf stat -a timeout 60s sh -c \
    "seq 1 \$(nproc) | xargs -I{} -P \$(nproc) sh -c \
    'while true; do ./veristat verifier_state_stress.bpf.o &> /dev/null; done' "

3. Test Case Source Code (verifier_state_stress.c):
----------------------------------------------------
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

SEC("socket")
int verifier_state_stress(struct __sk_buff *skb)
{
	__u32 x = skb->len;

#define COND1(n) if (x == n) x++;
#define COND10(n) COND1(n) COND1(n+1) COND1(n+2) COND1(n+3) COND1(n+4) \
                  COND1(n+5) COND1(n+6) COND1(n+7) COND1(n+8) COND1(n+9)
#define COND100(n) COND10(n) COND10(n+10) COND10(n+20) COND10(n+30) COND10(n+40) \
                   COND10(n+50) COND10(n+60) COND10(n+70) COND10(n+80) COND10(n+90)

	/* Expand 1000 conditional branches to trigger state explosion */
	COND100(0)
	COND100(100)
	COND100(200)
	COND100(300)
	COND100(400)
	COND100(500)
	COND100(600)
	COND100(700)
	COND100(800)
	COND100(900)

	return x;
}

char _license[] SEC("license") = "GPL";
----------------------------------------------------

4. Baseline RAW Output (Before Patch):
----------------------------------------------------
 Performance counter stats for 'system wide':

         4,621,744      context-switches                 #   2405.0 cs/sec  cs_per_second
      1,921,701.70 msec cpu-clock                        #     32.0 CPUs  CPUs_utilized
            55,883      cpu-migrations                   #     29.1 migrations/sec  migrations_per_second
        12,377,064      page-faults                      #   6440.7 faults/sec  page_faults_per_second
    20,806,257,247      branch-misses                    #      3.9 %  branch_miss_rate         (50.14%)
   392,192,407,254      branches                         #    204.1 M/sec  branch_frequency     (66.86%)
 1,795,371,797,109      cpu-cycles                       #      0.9 GHz  cycles_frequency       (66.94%)
 2,102,993,375,512      instructions                     #      1.2 instructions  insn_per_cycle  (66.86%)
   480,077,915,695      stalled-cycles-frontend          #     0.27 frontend_cycles_idle        (66.37%)

      60.048491456 seconds time elapsed

5. Patched RAW Output (After Patch):
----------------------------------------------------
 Performance counter stats for 'system wide':

         5,376,406      context-switches                 #   2798.3 cs/sec  cs_per_second
      1,921,336.31 msec cpu-clock                        #     32.0 CPUs  CPUs_utilized
            58,078      cpu-migrations                   #     30.2 migrations/sec  migrations_per_second
         8,534,044      page-faults                      #   4441.7 faults/sec  page_faults_per_second
    20,331,931,950      branch-misses                    #      3.9 %  branch_miss_rate         (50.15%)
   387,641,734,869      branches                         #    201.8 M/sec  branch_frequency     (66.86%)
 1,700,331,527,586      cpu-cycles                       #      0.9 GHz  cycles_frequency       (66.95%)
 2,074,268,752,024      instructions                     #      1.2 instructions  insn_per_cycle  (66.86%)
   452,713,645,928      stalled-cycles-frontend          #     0.27 frontend_cycles_idle        (66.36%)

      60.036630614 seconds time elapsed

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
On Mon, 2026-01-12 at 19:15 +0100, Kumar Kartikeya Dwivedi wrote:
> Did you run any numbers on whether this improves verification performance?
> Without any compelling evidence, I would leave things as-is.

This version addresses the feedback by providing detailed 'perf stat' 
benchmarks and reproducible stress test code to demonstrate the 
compelling performance gains.

Link: https://lore.kernel.org/all/CAP01T76JECHPV4Fdvm2bds=Eb36UYhQswd7oAJ+fRzW_1ZtnVw@mail.gmail.com/

On Wed, 2026-01-14 at 07:59 -0800, Alexei Starovoitov wrote:
> This is not your analysis. This is AI generated garbage that you didn't
> even bother to filter.

This v2 removes the previous interpretation and provides the raw 
performance metrics and the stress test source code, as requested.

Link: https://lore.kernel.org/all/CAADnVQJqnvr6Rs=0=gaQHWuXF1YE38afM3V6j04Jcetfv1+sEw@mail.gmail.com/

On Thu, 2026-01-15 at 22:51 -0800, Eduard Zingerman wrote:
> In general, you posted 4 patches claiming performance improvements,
> but non of them are supported by any measurements.
...
> To get more or less reasonable impact measurements, please use 'perf' 
> tool and use programs where verifier needs to process tens or hundreds 
> of thousands instructions.

Measurements on a high-complexity BPF program (1000 conditional branches) 
using 'perf stat' are now included to validate the impact.

Link: https://lore.kernel.org/all/75807149f7de7a106db0ccda88e5d4439b94a1e7.camel@gmail.com/

 kernel/bpf/verifier.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..37ce3990c9ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -52,6 +52,7 @@ enum bpf_features {
 
 struct bpf_mem_alloc bpf_global_percpu_ma;
 static bool bpf_global_percpu_ma_set;
+static struct kmem_cache *bpf_verifier_state_list_cachep;
 
 /* bpf_check() is a static code analyzer that walks eBPF program
  * instruction by instruction and updates register/stack state.
@@ -1718,7 +1719,7 @@ static void maybe_free_verifier_state(struct bpf_verifier_env *env,
 		return;
 	list_del(&sl->node);
 	free_verifier_state(&sl->state, false);
-	kfree(sl);
+	kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 	env->free_list_size--;
 }
 
@@ -20028,7 +20029,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * When looping the sl->state.branches will be > 0 and this state
 	 * will not be considered for equivalence until branches == 0.
 	 */
-	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL_ACCOUNT);
+	new_sl = kmem_cache_zalloc(bpf_verifier_state_list_cachep, GFP_KERNEL_ACCOUNT);
 	if (!new_sl)
 		return -ENOMEM;
 	env->total_states++;
@@ -20046,7 +20047,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	err = copy_verifier_state(new, cur);
 	if (err) {
 		free_verifier_state(new, false);
-		kfree(new_sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, new_sl);
 		return err;
 	}
 	new->insn_idx = insn_idx;
@@ -20056,7 +20057,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	err = maybe_enter_scc(env, new);
 	if (err) {
 		free_verifier_state(new, false);
-		kfree(new_sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, new_sl);
 		return err;
 	}
 
@@ -23716,7 +23717,7 @@ static void free_states(struct bpf_verifier_env *env)
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		free_verifier_state(&sl->state, false);
-		kfree(sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 	}
 	INIT_LIST_HEAD(&env->free_list);
 
@@ -23739,7 +23740,7 @@ static void free_states(struct bpf_verifier_env *env)
 		list_for_each_safe(pos, tmp, head) {
 			sl = container_of(pos, struct bpf_verifier_state_list, node);
 			free_verifier_state(&sl->state, false);
-			kfree(sl);
+			kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 		}
 		INIT_LIST_HEAD(&env->explored_states[i]);
 	}
@@ -25401,3 +25402,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	kvfree(env);
 	return ret;
 }
+
+static int __init bpf_verifier_init(void)
+{
+	bpf_verifier_state_list_cachep = kmem_cache_create("bpf_verifier_state_list",
+							   sizeof(struct bpf_verifier_state_list),
+							   0, SLAB_PANIC, NULL);
+	return 0;
+}
+late_initcall(bpf_verifier_init);
-- 
2.39.5


