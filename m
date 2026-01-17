Return-Path: <bpf+bounces-79363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB7D38D95
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 11:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0CEF300A7B8
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C81332918;
	Sat, 17 Jan 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9WWDkZ5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452F2C0284
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768644593; cv=none; b=tlvUclWr2EtcsHtOummgQfb98sAUj7EG4letX3+9rIop1u+E7UAxHlNbcB+VtVKLXoljZVaAbhcGWLtDuefOBrqcoYYQRvBQarnhRvrgWVqPMqcU88fOUDo5r6ROZmHY24Ckys5yenOhPl4T2puO3asiSSJWAYdwPVuv32oTz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768644593; c=relaxed/simple;
	bh=ILGfYOXnBd2SedZINJ1vZqXThkv4zHeV+jRFjhqO+ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gp737Nv4kJ9joYUKrAQJmu159NDy0pPrYxsj4qSghCrcsCQLn9I4+RS1PX5A5k0JHAMLaNociMrTWD8tKDzX0nSYAcGyQjAms5kIGeHWVNZMgButKpE+0T+t+ODsdHbFetDVtIIywufj08R0CXk2sFNZsaTdQH6h80hUmkogBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9WWDkZ5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0a33d0585so17758015ad.1
        for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 02:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768644592; x=1769249392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpLRIydUf332u62HkHeb5lB6bp3zwgBaw2oGbRiHoKI=;
        b=U9WWDkZ5S8w74Qrs1RiJlnI0PpGl0uDxDfma4zAlLNDJk4UtKga9qOVVPLdqUXXJeW
         KnNmr7C8xeSAquejUfXBK+8uvY68xuJNrJoLTNXnqFUWYsqg33kdFkswEh+0Be6ndOT7
         1xvHwIQ67o9fnZBvpaJWRWMAzatPbGwYcoHHY8Yl6NMvzXsE6lfgtWgnv2Xv9XTwjvk/
         a2H2x80wSUZvAlmjBNjrLk77RobvuUmdAVueN0PSE/o8OSH3QVEEq1t5HlU/0tNA8849
         wQmMzNkvpN6bIrNFJ8tkQAG2z/GL7lErRDifEPde237I/r1jFwBz3rVN0CUOrSSQACKo
         1hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768644592; x=1769249392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpLRIydUf332u62HkHeb5lB6bp3zwgBaw2oGbRiHoKI=;
        b=bX0ml/QsZLZXmZ6pEoibGqYDG4P9iLyS0/aLkDumtz5YILQEaz+vlFAkhuFZcEoTSL
         vTpsue/rchcmR9+6D/wGQCzSsnNoV3f54AYCWmf61ohy0t2FKA367GAO8YX7n4s6lg5T
         i90cbvzx1FqQOdr0B4Y6yMlQ8DV6jTGJKxQbEP4GMgRNj0V+lmnw/9uhatHRa1Steh3M
         1ktixs1aVJfGC4y5dEwvMuQfXnTEFBsYqO8ycJSnRI0Q51tn2CFbCf6pyUYfUEtJaWIc
         Je7koEOCFMyY9lUB76ln/ab0FZrgYa+IX4bxXSRqjETfX0UtO2o4r4vrroJbtYtyuaXI
         aI2w==
X-Forwarded-Encrypted: i=1; AJvYcCW6niuR4eDdhEvE0dYphFoTt4UyY3zZWFvoKJ4CFzaRUNtE+5UtjvwSQxFr7nIDYKqkUQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/lJV5GAo4uZLBu+g0xrPjBVeV4qAHTy2gti4R2/rK7Kn1COQP
	2P2z20qzLFYtSo7lFCxJo2eoF3E1aLlJp+BVDyTt0EzHk8S9Qa5OUqIL
X-Gm-Gg: AY/fxX5OMEWfSAxyn2fAdHFaGRhBElrI7Tt3BXjsr9HNvowE+LBY5KSUNCVPpNtzntl
	ftUzUY9UeaMAAhch6bSUMi6kh68WDDBcZzkQxckSwj2aeimLMZCyQ9TWToQgnzfFuZmUIX2iC46
	BKd74bNV7C5NoKGVgE14HpPNYpD1x5Pp2Eg7t2GI7bvp3PxXklpsYZQzAsfUmctGd10KvMtwFjj
	nzmWwnhSmd1Cw4vFqSy/e4jiC/WvJJIfdNjo4Gs1c7boh8oEQIeK+PVEntFIgMUuiwE994Rz4mR
	4q+4VlG6p7s7slH3u1Jflqe+avi0bQ0ID9YgLhWWPqZctnJjtYLMvfeeN9/XJsPWbDB9u2rAjnM
	a2wtYd7NOupFveKcyxmcl9fpS9YlkRas3p6okSk9jONU652K2ON8YA3hPpQPSwAKx8COlOcYRRk
	n67Rt5vZ/fg7lVimnYnFjWkeg=
X-Received: by 2002:a17:902:d4d2:b0:2a0:acca:f3f0 with SMTP id d9443c01a7336-2a71893cddcmr50870455ad.49.1768644591710;
        Sat, 17 Jan 2026 02:09:51 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fab79sm43676805ad.67.2026.01.17.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 02:09:51 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	realwujing@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	yuanql9@chinatelecom.cn
Subject: [PATCH v3] bpf/verifier: optimize precision backtracking by skipping precise bits
Date: Sat, 17 Jan 2026 18:09:22 +0800
Message-Id: <20260117100922.38459-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <aa4cc54a3a0796b16d2d5e13142d104fa5a483e1.camel@gmail.com>
References: <aa4cc54a3a0796b16d2d5e13142d104fa5a483e1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize __mark_chain_precision() by skipping registers or stack slots
that are already marked as precise. This prevents redundant history
walks when multiple verification paths converge on the same state.

Centralizing this check in __mark_chain_precision() improves efficiency
for all entry points (mark_chain_precision, propagate_precision) and
simplifies call-site logic.

Performance Results (Extreme Stress Test on 32-core system):
Under system-wide saturation (32 parallel veristat instances) using a
high-stress backtracking payload (~290k insns, 34k states), this
optimization demonstrated significant micro-architectural gains:

- Total Retired Instructions:  -82.2 Billion (-1.94%)
- Total CPU Cycles:            -161.3 Billion (-3.11%)
- Avg. Insns per Verify:       -17.2 Million (-2.84%)
- Page Faults:                 -39.90% (Significant reduction in memory pressure)

The massive reduction in page faults suggests that avoiding redundant
backtracking significantly lowers memory subsystem churn during deep
state history walks.

Verified that total instruction and state counts (per veristat) remain
identical across all tests, confirming logic equivalence.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
On Fri, Jan 16, 2026 at 11:27 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> As I said before, this is a useful change.
> 
> > 4. bpf/verifier: optimize precision backtracking by skipping precise bits
> >    (https://lore.kernel.org/all/20260115152037.449362-1-realwujing@gmail.com/)
> >    Following your suggestion to refactor the logic into the core engine for
> >    better coverage and clarity, I have provided a v2 version of this patch here:
> >    (https://lore.kernel.org/all/20260116045839.23743-1-realwujing@gmail.com/)
> >    This v2 version specifically addresses your feedback by centralizing the
> >    logic and includes a comprehensive performance comparison (veristat results)
> >    in the commit log. It reduces the complexity of redundant backtracking
> >    requests from O(D) (where D is history depth) to O(1) by utilizing the
> >    'precise' flag to skip already-processed states.
> 
> Same as with #1: using veristat duration metric, especially for such
> small programs, is not a reasonable performance analysis.

Link: https://lore.kernel.org/all/75807149f7de7a106db0ccda88e5d4439b94a1e7.camel@gmail.com/

Hi Eduard,

Acknowledged. To provide a more robust performance analysis, I have moved away
from veristat duration and instead used hardware performance counters (perf stat)
under system-wide saturation with a custom backtracking stress test. This 
demonstrates the optimization's hardware-level efficiency (retired instructions 
and page faults) more reliably.

Best regards,
Qiliang

Test case (backtrack_stress.c):
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __uint(max_entries, 1);
    __type(key, __u32);
    __type(value, __u64);
} dummy_map SEC(".maps");

SEC("tc")
int backtrack_stress(struct __sk_buff *skb)
{
    __u32 key = 0;
    __u64 *val = bpf_map_lookup_elem(&dummy_map, &key);
    if (!val) return 0;
    __u64 x = *val;
    
    /* 1. Create a deep dependency chain to fill history for 'x' */
    x += 1; x *= 2; x -= 1; x ^= 0x55;
    x += 1; x *= 2; x -= 1; x ^= 0xAA;
    x += 1; x *= 2; x -= 1; x ^= 0x55;
    x += 1; x *= 2; x -= 1; x ^= 0xAA;

    /* 2. Create many states via conditional branches */
#define CHECK_X(n) if (x == n) { x += 1; } if (x == n + 1) { x -= 1; }
#define CHECK_X10(n)  CHECK_X(n) CHECK_X(n+2) CHECK_X(n+4) CHECK_X(n+6) CHECK_X(n+8) \
                      CHECK_X(n+10) CHECK_X(n+12) CHECK_X(n+14) CHECK_X(n+16) CHECK_X(n+18)
#define CHECK_X100(n) CHECK_X10(n) CHECK_X10(n+20) CHECK_X10(n+40) CHECK_X10(n+60) CHECK_X10(n+80) \
                      CHECK_X10(n+100) CHECK_X10(n+120) CHECK_X10(n+140) CHECK_X10(n+160) CHECK_X10(n+180)

    CHECK_X100(0)
    CHECK_X100(200)
    CHECK_X100(400)
    CHECK_X100(600)
    CHECK_X100(800)
    CHECK_X100(1000)

    /* 3. Trigger mark_chain_precision() multiple times on 'x' */
    #pragma clang loop unroll(full)
    for (int i = 0; i < 500; i++) {
        if (x == (2000 + i)) { 
            x += 1;
        }
    }

    return x;
}

char _license[] SEC("license") = "GPL";

How to Test:
-----------
1. Compile the BPF program (from kernel root):
   clang -O2 -target bpf \
         -I./tools/testing/selftests/bpf/ \
         -I./tools/lib/ \
         -I./tools/include/uapi/ \
         -I./tools/testing/selftests/bpf/include \
         -c backtrack_stress.c -o backtrack_stress.bpf.o

2. System-wide saturation profiling (32 cores):
   # Start perf in background
   sudo perf stat -a -- sleep 60 &
   # Start 32 parallel loops of veristat
   for i in {1..32}; do (while true; do ./veristat backtrack_stress.bpf.o > /dev/null; done &); done

Raw Performance Data:
---------------------
Baseline (6.19.0-rc5-baseline, git commit 944aacb68baf):
File                    Program           Verdict  Duration (us)   Insns  States  Program size  Jited size
----------------------  ----------------  -------  -------------  ------  ------  ------------  ----------
backtrack_stress.bpf.o  backtrack_stress  success         197924  289939   34331          5437       28809
----------------------  ----------------  -------  -------------  ------  ------  ------------  ----------

         1,388,149      context-switches                 #    722.5 cs/sec  cs_per_second     
      1,921,399.69 msec cpu-clock                        #     32.0 CPUs  CPUs_utilized       
            25,113      cpu-migrations                   #     13.1 migrations/sec  migrations_per_second
         8,108,516      page-faults                      #   4220.1 faults/sec  page_faults_per_second
    97,445,724,421      branch-misses                    #      8.1 %  branch_miss_rate         (50.07%)
   903,852,287,721      branches                         #    470.4 M/sec  branch_frequency     (66.76%)
 5,190,519,089,751      cpu-cycles                       #      2.7 GHz  cycles_frequency       (66.81%)
 4,230,500,391,043      instructions                     #      0.8 instructions  insn_per_cycle  (66.76%)
 1,853,856,616,836      stalled-cycles-frontend          #     0.36 frontend_cycles_idle        (66.52%)

      60.031936126 seconds time elapsed

Patched (6.19.0-rc5-optimized):
File                    Program           Verdict  Duration (us)   Insns  States  Program size  Jited size
----------------------  ----------------  -------  -------------  ------  ------  ------------  ----------
backtrack_stress.bpf.o  backtrack_stress  success         214600  289939   34331          5437       28809
----------------------  ----------------  -------  -------------  ------  ------  ------------  ----------

         1,433,270      context-switches                 #    745.9 cs/sec  cs_per_second     
      1,921,604.54 msec cpu-clock                        #     32.0 CPUs  CPUs_utilized       
            22,795      cpu-migrations                   #     11.9 migrations/sec  migrations_per_second
         4,873,895      page-faults                      #   2536.4 faults/sec  page_faults_per_second
    97,038,959,375      branch-misses                    #      8.1 %  branch_miss_rate         (50.07%)
   890,170,312,491      branches                         #    463.2 M/sec  branch_frequency     (66.76%)
 5,029,192,994,167      cpu-cycles                       #      2.6 GHz  cycles_frequency       (66.81%)
 4,148,237,426,723      instructions                     #      0.8 instructions  insn_per_cycle  (66.77%)
 1,818,457,318,301      stalled-cycles-frontend          #     0.36 frontend_cycles_idle        (66.51%)

      60.032523872 seconds time elapsed

 kernel/bpf/verifier.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..250f1dc0298e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4765,14 +4765,37 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 	 * slot, but don't set precise flag in current state, as precision
 	 * tracking in the current state is unnecessary.
 	 */
-	func = st->frame[bt->frame];
 	if (regno >= 0) {
-		reg = &func->regs[regno];
+		reg = &st->frame[bt->frame]->regs[regno];
 		if (reg->type != SCALAR_VALUE) {
 			verifier_bug(env, "backtracking misuse");
 			return -EFAULT;
 		}
+		if (reg->precise)
+			return 0;
 		bt_set_reg(bt, regno);
+	} else {
+		for (fr = bt->frame; fr >= 0; fr--) {
+			u32 reg_mask = bt_frame_reg_mask(bt, fr);
+			u64 stack_mask = bt_frame_stack_mask(bt, fr);
+			DECLARE_BITMAP(mask, 64);
+
+			func = st->frame[fr];
+			if (reg_mask) {
+				bitmap_from_u64(mask, reg_mask);
+				for_each_set_bit(i, mask, 32) {
+					if (func->regs[i].precise)
+						bt_clear_frame_reg(bt, fr, i);
+				}
+			}
+			if (stack_mask) {
+				bitmap_from_u64(mask, stack_mask);
+				for_each_set_bit(i, mask, 64) {
+					if (func->stack[i].spilled_ptr.precise)
+						bt_clear_frame_slot(bt, fr, i);
+				}
+			}
+		}
 	}
 
 	if (bt_empty(bt))
-- 
2.39.5


