Return-Path: <bpf+bounces-79422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E6D39E4B
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 07:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CDD302E074
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3732550D5;
	Mon, 19 Jan 2026 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="en/xpdBF"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B0F4FA
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803619; cv=none; b=TP9+ogYJFXVAfXKHdVI5BwRb/bLWBD12UiLXgWCYXIqwd99jV+pFc4IvvAsS5yVemEmJ1wr28ijQH7kr45onlNGUv+iTjDBlOsYBiXD+tYrao8HFEZsFAhWVH1QHEOhX1LHWJxB30Mjx+MacAjy4hUR5cnxEQMc24GbyjVhdn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803619; c=relaxed/simple;
	bh=7a8YIXwiNZGuh5meHtu6Cq2tNne8eg7W2FrbfG3eSW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It2/jCd4fAcnb3MxKSTLKK4GeiOmOrZGEgEdi3/9FV9weF2V7DmO2TrHR3PTkvybY9AurRIOOk+MLdByrACKr3erVZbM7qNWCNUaHE89Flb4rc81gCsRQENXgY2Po4f47rIXVWC86CEzMzmVDNPBSuxUuII9WEq3bmKy9VGoXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=en/xpdBF; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <930f735f-cb35-41b9-9ab9-b3ee558b27ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768803614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPAkRhKrJ3wuV/Ldg8/mIpSQiRLkSQoFLRwQ7F++HWo=;
	b=en/xpdBFZhXQGC1SxFx3vGhcmPklknjqGG1lWanUztkwX5hKM5FdvtjqZu8j5hYNVBttVD
	gQdyrBeE2uBRNgvjeFd7z0GdUK+h/AJbGpASKWFLfJY0xq8GDYaCAf4YQ2Ief/tHJPl+jL
	4Skmeqanju73/RmKWJ/jb+rxmLqa97E=
Date: Sun, 18 Jan 2026 22:20:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] bpf/verifier: optimize precision backtracking by
 skipping precise bits
Content-Language: en-GB
To: Qiliang Yuan <realwujing@gmail.com>, eddyz87@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, song@kernel.org, yuanql9@chinatelecom.cn
References: <aa4cc54a3a0796b16d2d5e13142d104fa5a483e1.camel@gmail.com>
 <20260117100922.38459-1-realwujing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260117100922.38459-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/17/26 2:09 AM, Qiliang Yuan wrote:
> Optimize __mark_chain_precision() by skipping registers or stack slots
> that are already marked as precise. This prevents redundant history
> walks when multiple verification paths converge on the same state.
>
> Centralizing this check in __mark_chain_precision() improves efficiency
> for all entry points (mark_chain_precision, propagate_precision) and
> simplifies call-site logic.
>
> Performance Results (Extreme Stress Test on 32-core system):
> Under system-wide saturation (32 parallel veristat instances) using a
> high-stress backtracking payload (~290k insns, 34k states), this
> optimization demonstrated significant micro-architectural gains:
>
> - Total Retired Instructions:  -82.2 Billion (-1.94%)
> - Total CPU Cycles:            -161.3 Billion (-3.11%)
> - Avg. Insns per Verify:       -17.2 Million (-2.84%)
> - Page Faults:                 -39.90% (Significant reduction in memory pressure)
>
> The massive reduction in page faults suggests that avoiding redundant
> backtracking significantly lowers memory subsystem churn during deep
> state history walks.
>
> Verified that total instruction and state counts (per veristat) remain
> identical across all tests, confirming logic equivalence.
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
> On Fri, Jan 16, 2026 at 11:27 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> As I said before, this is a useful change.
>>
>>> 4. bpf/verifier: optimize precision backtracking by skipping precise bits
>>>     (https://lore.kernel.org/all/20260115152037.449362-1-realwujing@gmail.com/)
>>>     Following your suggestion to refactor the logic into the core engine for
>>>     better coverage and clarity, I have provided a v2 version of this patch here:
>>>     (https://lore.kernel.org/all/20260116045839.23743-1-realwujing@gmail.com/)
>>>     This v2 version specifically addresses your feedback by centralizing the
>>>     logic and includes a comprehensive performance comparison (veristat results)
>>>     in the commit log. It reduces the complexity of redundant backtracking
>>>     requests from O(D) (where D is history depth) to O(1) by utilizing the
>>>     'precise' flag to skip already-processed states.
>> Same as with #1: using veristat duration metric, especially for such
>> small programs, is not a reasonable performance analysis.
> Link: https://lore.kernel.org/all/75807149f7de7a106db0ccda88e5d4439b94a1e7.camel@gmail.com/
>
> Hi Eduard,
>
> Acknowledged. To provide a more robust performance analysis, I have moved away
> from veristat duration and instead used hardware performance counters (perf stat)
> under system-wide saturation with a custom backtracking stress test. This
> demonstrates the optimization's hardware-level efficiency (retired instructions
> and page faults) more reliably.
>
> Best regards,
> Qiliang
>
> Test case (backtrack_stress.c):
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
>
> struct {
>      __uint(type, BPF_MAP_TYPE_ARRAY);
>      __uint(max_entries, 1);
>      __type(key, __u32);
>      __type(value, __u64);
> } dummy_map SEC(".maps");
>
> SEC("tc")
> int backtrack_stress(struct __sk_buff *skb)
> {
>      __u32 key = 0;
>      __u64 *val = bpf_map_lookup_elem(&dummy_map, &key);
>      if (!val) return 0;
>      __u64 x = *val;
>      
>      /* 1. Create a deep dependency chain to fill history for 'x' */
>      x += 1; x *= 2; x -= 1; x ^= 0x55;
>      x += 1; x *= 2; x -= 1; x ^= 0xAA;
>      x += 1; x *= 2; x -= 1; x ^= 0x55;
>      x += 1; x *= 2; x -= 1; x ^= 0xAA;
>
>      /* 2. Create many states via conditional branches */
> #define CHECK_X(n) if (x == n) { x += 1; } if (x == n + 1) { x -= 1; }
> #define CHECK_X10(n)  CHECK_X(n) CHECK_X(n+2) CHECK_X(n+4) CHECK_X(n+6) CHECK_X(n+8) \
>                        CHECK_X(n+10) CHECK_X(n+12) CHECK_X(n+14) CHECK_X(n+16) CHECK_X(n+18)
> #define CHECK_X100(n) CHECK_X10(n) CHECK_X10(n+20) CHECK_X10(n+40) CHECK_X10(n+60) CHECK_X10(n+80) \
>                        CHECK_X10(n+100) CHECK_X10(n+120) CHECK_X10(n+140) CHECK_X10(n+160) CHECK_X10(n+180)
>
>      CHECK_X100(0)
>      CHECK_X100(200)
>      CHECK_X100(400)
>      CHECK_X100(600)
>      CHECK_X100(800)
>      CHECK_X100(1000)
>
>      /* 3. Trigger mark_chain_precision() multiple times on 'x' */
>      #pragma clang loop unroll(full)
>      for (int i = 0; i < 500; i++) {
>          if (x == (2000 + i)) {
>              x += 1;
>          }
>      }
>
>      return x;
> }
>
> char _license[] SEC("license") = "GPL";
>
> How to Test:
> -----------
> 1. Compile the BPF program (from kernel root):
>     clang -O2 -target bpf \
>           -I./tools/testing/selftests/bpf/ \
>           -I./tools/lib/ \
>           -I./tools/include/uapi/ \
>           -I./tools/testing/selftests/bpf/include \
>           -c backtrack_stress.c -o backtrack_stress.bpf.o
>
> 2. System-wide saturation profiling (32 cores):
>     # Start perf in background
>     sudo perf stat -a -- sleep 60 &
>     # Start 32 parallel loops of veristat
>     for i in {1..32}; do (while true; do ./veristat backtrack_stress.bpf.o > /dev/null; done &); done
>
> Raw Performance Data:
> ---------------------
> Baseline (6.19.0-rc5-baseline, git commit 944aacb68baf):
> File                    Program           Verdict  Duration (us)   Insns  States  Program size  Jited size
> ----------------------  ----------------  -------  -------------  ------  ------  ------------  ----------
> backtrack_stress.bpf.o  backtrack_stress  success         197924  289939   34331          5437       28809
> ----------------------  ----------------  -------  -------------  ------  ------  ------------  ----------
>
>           1,388,149      context-switches                 #    722.5 cs/sec  cs_per_second
>        1,921,399.69 msec cpu-clock                        #     32.0 CPUs  CPUs_utilized
>              25,113      cpu-migrations                   #     13.1 migrations/sec  migrations_per_second
>           8,108,516      page-faults                      #   4220.1 faults/sec  page_faults_per_second
>      97,445,724,421      branch-misses                    #      8.1 %  branch_miss_rate         (50.07%)
>     903,852,287,721      branches                         #    470.4 M/sec  branch_frequency     (66.76%)
>   5,190,519,089,751      cpu-cycles                       #      2.7 GHz  cycles_frequency       (66.81%)
>   4,230,500,391,043      instructions                     #      0.8 instructions  insn_per_cycle  (66.76%)
>   1,853,856,616,836      stalled-cycles-frontend          #     0.36 frontend_cycles_idle        (66.52%)
>
>        60.031936126 seconds time elapsed
>
> Patched (6.19.0-rc5-optimized):
> File                    Program           Verdict  Duration (us)   Insns  States  Program size  Jited size
> ----------------------  ----------------  -------  -------------  ------  ------  ------------  ----------
> backtrack_stress.bpf.o  backtrack_stress  success         214600  289939   34331          5437       28809
> ----------------------  ----------------  -------  -------------  ------  ------  ------------  ----------
>
>           1,433,270      context-switches                 #    745.9 cs/sec  cs_per_second
>        1,921,604.54 msec cpu-clock                        #     32.0 CPUs  CPUs_utilized
>              22,795      cpu-migrations                   #     11.9 migrations/sec  migrations_per_second
>           4,873,895      page-faults                      #   2536.4 faults/sec  page_faults_per_second
>      97,038,959,375      branch-misses                    #      8.1 %  branch_miss_rate         (50.07%)
>     890,170,312,491      branches                         #    463.2 M/sec  branch_frequency     (66.76%)
>   5,029,192,994,167      cpu-cycles                       #      2.6 GHz  cycles_frequency       (66.81%)
>   4,148,237,426,723      instructions                     #      0.8 instructions  insn_per_cycle  (66.77%)
>   1,818,457,318,301      stalled-cycles-frontend          #     0.36 frontend_cycles_idle        (66.51%)
>
>        60.032523872 seconds time elapsed
>
>   kernel/bpf/verifier.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3135643d5695..250f1dc0298e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4765,14 +4765,37 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
>   	 * slot, but don't set precise flag in current state, as precision
>   	 * tracking in the current state is unnecessary.
>   	 */
> -	func = st->frame[bt->frame];
>   	if (regno >= 0) {
> -		reg = &func->regs[regno];
> +		reg = &st->frame[bt->frame]->regs[regno];
>   		if (reg->type != SCALAR_VALUE) {
>   			verifier_bug(env, "backtracking misuse");
>   			return -EFAULT;
>   		}
> +		if (reg->precise)
> +			return 0;
>   		bt_set_reg(bt, regno);
> +	} else {
> +		for (fr = bt->frame; fr >= 0; fr--) {
> +			u32 reg_mask = bt_frame_reg_mask(bt, fr);
> +			u64 stack_mask = bt_frame_stack_mask(bt, fr);
> +			DECLARE_BITMAP(mask, 64);
> +
> +			func = st->frame[fr];
> +			if (reg_mask) {
> +				bitmap_from_u64(mask, reg_mask);
> +				for_each_set_bit(i, mask, 32) {
> +					if (func->regs[i].precise)
> +						bt_clear_frame_reg(bt, fr, i);
> +				}
> +			}
> +			if (stack_mask) {
> +				bitmap_from_u64(mask, stack_mask);
> +				for_each_set_bit(i, mask, 64) {
> +					if (func->stack[i].spilled_ptr.precise)
> +						bt_clear_frame_slot(bt, fr, i);
> +				}
> +			}
> +		}
>   	}
>   
>   	if (bt_empty(bt))

Here is another data point. I applied this patch to latest bpf-next
and adding printk()'s like below:
...
+               if (reg->precise) {
+                       printk("%s %s %d\n", __FILE__, __func__, __LINE__);
+                       return 0;
+               }
...
+               for (fr = bt->frame; fr >= 0; fr--) {
+                       u32 reg_mask = bt_frame_reg_mask(bt, fr);
+                       u64 stack_mask = bt_frame_stack_mask(bt, fr);
+                       DECLARE_BITMAP(mask, 64);
+
+                       func = st->frame[fr];
+                       if (reg_mask) {
+                               bitmap_from_u64(mask, reg_mask);
+                               for_each_set_bit(i, mask, 32) {
+                                       if (func->regs[i].precise) {
+                                               printk("%s %s %d\n", __FILE__, __func__, __LINE__);
+                                               bt_clear_frame_reg(bt, fr, i);
+                                       }
+                               }
+                       }
+                       if (stack_mask) {
+                               bitmap_from_u64(mask, stack_mask);
+                               for_each_set_bit(i, mask, 64) {
+                                       if (func->stack[i].spilled_ptr.precise) {
+                                               printk("%s %s %d\n", __FILE__, __func__, __LINE__);
+                                               bt_clear_frame_slot(bt, fr, i);
+                                       }
+                               }
+                       }

I run through the bpf selftests, and didn't see a single printk dump in the above.
So looks like this patch is a noop for me.


