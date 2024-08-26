Return-Path: <bpf+bounces-38061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C995E9E5
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7351F236BD
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09112C491;
	Mon, 26 Aug 2024 07:06:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77F80BEC
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655981; cv=none; b=ijLPupVAfJ9liRstbOBA2thKBRq9STm/wkH6GX0YGMaSVmgk7AFqWJGyjQRMYRCtKiIR8jvbHYcSTogjfkZENqUTvnf/VtpRQV4gmxD55yUsK8gMHsJfXJJ0lTWGiWB1KuHjYb0F+SUz9fKItbt8sh7jY/YlzWcRagh/D4PRcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655981; c=relaxed/simple;
	bh=LCgMmkz3x1axnx2rU9sq5QNnNOs6CS/sOkW8w/+BBZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1isN++Z0mid+W3FzuZw3kgdWqLkOLT2+uTrEJZwAKB9PoJp9GxfE/8heSz+epmRKmyFDYvp3tJ3LUWRy6HPu28n7Uj9WDzC/Hx8batgBnlsMOjN0ShRxax9OdgxPjHFztgrTj8OsQrULnLvPg1Gms5peSUgkmXjVTfbW651HLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WshXm5kwRz4f3jXS
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:06:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 419791A058E
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:06:15 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgAH8L5jKcxmTz_5Cg--.20237S4;
	Mon, 26 Aug 2024 15:06:13 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Leon Hwang <hffilwlqm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH bpf-next 2/2] bpf, arm64: Avoid blindly saving/restoring all callee-saved registers
Date: Mon, 26 Aug 2024 15:16:24 +0800
Message-Id: <20240826071624.350108-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826071624.350108-1-xukuohai@huaweicloud.com>
References: <20240826071624.350108-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAH8L5jKcxmTz_5Cg--.20237S4
X-Coremail-Antispam: 1UD129KBjvAXoWftw4rGr13Cw1xCFW3GryxAFb_yoW8Kr45uo
	WfurW5Zw48Cry8ZFyfKw1UArW3Wa1Ikw17Cw45WFs8Z3WYqay5Zr4xGa1fAr4YqrW5Ca4D
	uFWft3WDCFs8Cr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYL7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8fWrJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The arm64 jit blindly saves/restores all callee-saved registers, making
the jited result looks a bit too compliated. For example, for an empty
prog, the jited result is:

   0:   bti jc
   4:   mov     x9, lr
   8:   nop
   c:   paciasp
  10:   stp     fp, lr, [sp, #-16]!
  14:   mov     fp, sp
  18:   stp     x19, x20, [sp, #-16]!
  1c:   stp     x21, x22, [sp, #-16]!
  20:   stp     x26, x25, [sp, #-16]!
  24:   mov     x26, #0
  28:   stp     x26, x25, [sp, #-16]!
  2c:   mov     x26, sp
  30:   stp     x27, x28, [sp, #-16]!
  34:   mov     x25, sp
  38:   bti j 		// tailcall target
  3c:   sub     sp, sp, #0
  40:   mov     x7, #0
  44:   add     sp, sp, #0
  48:   ldp     x27, x28, [sp], #16
  4c:   ldp     x26, x25, [sp], #16
  50:   ldp     x26, x25, [sp], #16
  54:   ldp     x21, x22, [sp], #16
  58:   ldp     x19, x20, [sp], #16
  5c:   ldp     fp, lr, [sp], #16
  60:   mov     x0, x7
  64:   autiasp
  68:   ret

Clearly, there is no need to save/restore unused callee-saved registers.
This patch does this change, making the jited image to only save/restore
the callee-saved registers it uses.

Now the jited result of empty prog is:

   0:   bti jc
   4:   mov     x9, lr
   8:   nop
   c:   paciasp
  10:   stp     fp, lr, [sp, #-16]!
  14:   mov     fp, sp
  18:   stp     xzr, x26, [sp, #-16]!
  1c:   mov     x26, sp
  20:   bti j		// tailcall target
  24:   mov     x7, #0
  28:   ldp     xzr, x26, [sp], #16
  2c:   ldp     fp, lr, [sp], #16
  30:   mov     x0, x7
  34:   autiasp
  38:   ret

Since bpf prog saves/restores its own callee-saved registers as needed,
to make tailcall work correctly, the caller needs to restore its saved
registers before tailcall, and the callee needs to save its callee-saved
registers after tailcall. This extra restoring/saving instructions
increases preformance overhead.

[1] provides 2 benchmarks for tailcall scenarios. Below is the perf
number measured in an arm64 KVM guest. The result indicates that the
performance difference before and after the patch in typical tailcall
scenarios is negligible.

- Before:

 Performance counter stats for './test_progs -t tailcalls' (5 runs):

           4313.43 msec task-clock                       #    0.874 CPUs utilized               ( +-  0.16% )
               574      context-switches                 #  133.073 /sec                        ( +-  1.14% )
                 0      cpu-migrations                   #    0.000 /sec
               538      page-faults                      #  124.727 /sec                        ( +-  0.57% )
       10697772784      cycles                           #    2.480 GHz                         ( +-  0.22% )  (61.19%)
       25511241955      instructions                     #    2.38  insn per cycle              ( +-  0.08% )  (66.70%)
        5108910557      branches                         #    1.184 G/sec                       ( +-  0.08% )  (72.38%)
           2800459      branch-misses                    #    0.05% of all branches             ( +-  0.51% )  (72.36%)
                        TopDownL1                 #     0.60 retiring                    ( +-  0.09% )  (66.84%)
                                                  #     0.21 frontend_bound              ( +-  0.15% )  (61.31%)
                                                  #     0.12 bad_speculation             ( +-  0.08% )  (50.11%)
                                                  #     0.07 backend_bound               ( +-  0.16% )  (33.30%)
        8274201819      L1-dcache-loads                  #    1.918 G/sec                       ( +-  0.18% )  (33.15%)
            468268      L1-dcache-load-misses            #    0.01% of all L1-dcache accesses   ( +-  4.69% )  (33.16%)
            385383      LLC-loads                        #   89.345 K/sec                       ( +-  5.22% )  (33.16%)
             38296      LLC-load-misses                  #    9.94% of all LL-cache accesses    ( +- 42.52% )  (38.69%)
        6886576501      L1-icache-loads                  #    1.597 G/sec                       ( +-  0.35% )  (38.69%)
           1848585      L1-icache-load-misses            #    0.03% of all L1-icache accesses   ( +-  4.52% )  (44.23%)
        9043645883      dTLB-loads                       #    2.097 G/sec                       ( +-  0.10% )  (44.33%)
            416672      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  ( +-  5.15% )  (49.89%)
        6925626111      iTLB-loads                       #    1.606 G/sec                       ( +-  0.35% )  (55.46%)
             66220      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  ( +-  1.88% )  (55.50%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

            4.9372 +- 0.0526 seconds time elapsed  ( +-  1.07% )

 Performance counter stats for './test_progs -t flow_dissector' (5 runs):

          10924.50 msec task-clock                       #    0.945 CPUs utilized               ( +-  0.08% )
               603      context-switches                 #   55.197 /sec                        ( +-  1.13% )
                 0      cpu-migrations                   #    0.000 /sec
               566      page-faults                      #   51.810 /sec                        ( +-  0.42% )
       27381270695      cycles                           #    2.506 GHz                         ( +-  0.18% )  (60.46%)
       56996583922      instructions                     #    2.08  insn per cycle              ( +-  0.21% )  (66.11%)
       10321647567      branches                         #  944.816 M/sec                       ( +-  0.17% )  (71.79%)
           3347735      branch-misses                    #    0.03% of all branches             ( +-  3.72% )  (72.15%)
                        TopDownL1                 #     0.52 retiring                    ( +-  0.13% )  (66.74%)
                                                  #     0.27 frontend_bound              ( +-  0.14% )  (61.27%)
                                                  #     0.14 bad_speculation             ( +-  0.19% )  (50.36%)
                                                  #     0.07 backend_bound               ( +-  0.42% )  (33.89%)
       18740797617      L1-dcache-loads                  #    1.715 G/sec                       ( +-  0.43% )  (33.71%)
          13715669      L1-dcache-load-misses            #    0.07% of all L1-dcache accesses   ( +- 32.85% )  (33.34%)
           4087551      LLC-loads                        #  374.164 K/sec                       ( +- 29.53% )  (33.26%)
            267906      LLC-load-misses                  #    6.55% of all LL-cache accesses    ( +- 23.90% )  (38.76%)
       15811864229      L1-icache-loads                  #    1.447 G/sec                       ( +-  0.12% )  (38.73%)
           2976833      L1-icache-load-misses            #    0.02% of all L1-icache accesses   ( +-  9.73% )  (44.22%)
       20138907471      dTLB-loads                       #    1.843 G/sec                       ( +-  0.18% )  (44.15%)
            732850      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  ( +- 11.18% )  (49.64%)
       15895726702      iTLB-loads                       #    1.455 G/sec                       ( +-  0.15% )  (55.13%)
            152075      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  ( +-  4.71% )  (54.98%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

           11.5613 +- 0.0317 seconds time elapsed  ( +-  0.27% )

- After:

 Performance counter stats for './test_progs -t tailcalls' (5 runs):

           4278.78 msec task-clock                       #    0.871 CPUs utilized               ( +-  0.15% )
               569      context-switches                 #  132.982 /sec                        ( +-  0.58% )
                 0      cpu-migrations                   #    0.000 /sec
               539      page-faults                      #  125.970 /sec                        ( +-  0.43% )
       10588986432      cycles                           #    2.475 GHz                         ( +-  0.20% )  (60.91%)
       25303825043      instructions                     #    2.39  insn per cycle              ( +-  0.08% )  (66.48%)
        5110756256      branches                         #    1.194 G/sec                       ( +-  0.07% )  (72.03%)
           2719569      branch-misses                    #    0.05% of all branches             ( +-  2.42% )  (72.03%)
                        TopDownL1                 #     0.60 retiring                    ( +-  0.22% )  (66.31%)
                                                  #     0.22 frontend_bound              ( +-  0.21% )  (60.83%)
                                                  #     0.12 bad_speculation             ( +-  0.26% )  (50.25%)
                                                  #     0.06 backend_bound               ( +-  0.17% )  (33.52%)
        8163648527      L1-dcache-loads                  #    1.908 G/sec                       ( +-  0.33% )  (33.52%)
            694979      L1-dcache-load-misses            #    0.01% of all L1-dcache accesses   ( +- 30.53% )  (33.52%)
           1902347      LLC-loads                        #  444.600 K/sec                       ( +- 48.84% )  (33.69%)
             96677      LLC-load-misses                  #    5.08% of all LL-cache accesses    ( +- 43.48% )  (39.30%)
        6863517589      L1-icache-loads                  #    1.604 G/sec                       ( +-  0.37% )  (39.17%)
           1871519      L1-icache-load-misses            #    0.03% of all L1-icache accesses   ( +-  6.78% )  (44.56%)
        8927782813      dTLB-loads                       #    2.087 G/sec                       ( +-  0.14% )  (44.37%)
            438237      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  ( +-  6.00% )  (49.75%)
        6886906831      iTLB-loads                       #    1.610 G/sec                       ( +-  0.36% )  (55.08%)
             67568      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  ( +-  3.27% )  (54.86%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

            4.9114 +- 0.0309 seconds time elapsed  ( +-  0.63% )

 Performance counter stats for './test_progs -t flow_dissector' (5 runs):

          10948.40 msec task-clock                       #    0.942 CPUs utilized               ( +-  0.05% )
               615      context-switches                 #   56.173 /sec                        ( +-  1.65% )
                 1      cpu-migrations                   #    0.091 /sec                        ( +- 31.62% )
               567      page-faults                      #   51.788 /sec                        ( +-  0.44% )
       27334194328      cycles                           #    2.497 GHz                         ( +-  0.08% )  (61.05%)
       56656528828      instructions                     #    2.07  insn per cycle              ( +-  0.08% )  (66.67%)
       10270389422      branches                         #  938.072 M/sec                       ( +-  0.10% )  (72.21%)
           3453837      branch-misses                    #    0.03% of all branches             ( +-  3.75% )  (72.27%)
                        TopDownL1                 #     0.52 retiring                    ( +-  0.16% )  (66.55%)
                                                  #     0.27 frontend_bound              ( +-  0.09% )  (60.91%)
                                                  #     0.14 bad_speculation             ( +-  0.08% )  (49.85%)
                                                  #     0.07 backend_bound               ( +-  0.16% )  (33.33%)
       18982866028      L1-dcache-loads                  #    1.734 G/sec                       ( +-  0.24% )  (33.34%)
           8802454      L1-dcache-load-misses            #    0.05% of all L1-dcache accesses   ( +- 52.30% )  (33.31%)
           2612962      LLC-loads                        #  238.661 K/sec                       ( +- 29.78% )  (33.45%)
            264107      LLC-load-misses                  #   10.11% of all LL-cache accesses    ( +- 18.34% )  (39.07%)
       15793205997      L1-icache-loads                  #    1.443 G/sec                       ( +-  0.15% )  (39.09%)
           3930802      L1-icache-load-misses            #    0.02% of all L1-icache accesses   ( +-  3.72% )  (44.66%)
       20097828496      dTLB-loads                       #    1.836 G/sec                       ( +-  0.09% )  (44.68%)
            961757      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  ( +-  3.32% )  (50.15%)
       15838728506      iTLB-loads                       #    1.447 G/sec                       ( +-  0.09% )  (55.62%)
            167652      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  ( +-  1.28% )  (55.52%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

           11.6173 +- 0.0268 seconds time elapsed  ( +-  0.23% )

[1] https://lore.kernel.org/bpf/20200724123644.5096-1-maciej.fijalkowski@intel.com/

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 294 +++++++++++++++++++++-------------
 1 file changed, 183 insertions(+), 111 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 5c9039cf261d..8aa32cb140b9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -76,10 +76,14 @@ struct jit_ctx {
 	int epilogue_offset;
 	int *offset;
 	int exentry_idx;
+	int nr_used_callee_reg;
+	u8 used_callee_reg[8]; /* r6~r9, fp, arena_vm_start */
 	__le32 *image;
 	__le32 *ro_image;
 	u32 stack_size;
 	u64 user_vm_start;
+	u64 arena_vm_start;
+	bool fp_used;
 };
 
 struct bpf_plt {
@@ -270,41 +274,141 @@ static bool is_lsi_offset(int offset, int scale)
 	return true;
 }
 
-/* generated prologue:
+/* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
  *      nop  // POKE_OFFSET
  *      paciasp // if CONFIG_ARM64_PTR_AUTH_KERNEL
  *      stp x29, lr, [sp, #-16]!
  *      mov x29, sp
- *      stp x19, x20, [sp, #-16]!
- *      stp x21, x22, [sp, #-16]!
- *      stp x26, x25, [sp, #-16]!
- *      stp x26, x25, [sp, #-16]!
- *      stp x27, x28, [sp, #-16]!
- *      mov x25, sp
- *      mov tcc, #0
+ *      stp xzr, x26, [sp, #-16]!
+ *      mov x26, sp
  *      // PROLOGUE_OFFSET
+ *	// save callee-saved registers
  */
-
 static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx)
 {
-	const struct bpf_prog *prog = ctx->prog;
-	const bool is_main_prog = !bpf_is_subprog(prog);
+	const bool is_main_prog = !bpf_is_subprog(ctx->prog);
 	const u8 ptr = bpf2a64[TCCNT_PTR];
-	const u8 fp = bpf2a64[BPF_REG_FP];
-	const u8 tcc = ptr;
 
-	emit(A64_PUSH(ptr, fp, A64_SP), ctx);
 	if (is_main_prog) {
 		/* Initialize tail_call_cnt. */
-		emit(A64_MOVZ(1, tcc, 0, 0), ctx);
-		emit(A64_PUSH(tcc, fp, A64_SP), ctx);
+		emit(A64_PUSH(A64_ZR, ptr, A64_SP), ctx);
 		emit(A64_MOV(1, ptr, A64_SP), ctx);
+	} else
+		emit(A64_PUSH(ptr, ptr, A64_SP), ctx);
+}
+
+static void find_used_callee_regs(struct jit_ctx *ctx)
+{
+	int i;
+	const struct bpf_prog *prog = ctx->prog;
+	const struct bpf_insn *insn = &prog->insnsi[0];
+	int reg_used = 0;
+
+	for (i = 0; i < prog->len; i++, insn++) {
+		if (insn->dst_reg == BPF_REG_6 || insn->src_reg == BPF_REG_6)
+			reg_used |= 1;
+
+		if (insn->dst_reg == BPF_REG_7 || insn->src_reg == BPF_REG_7)
+			reg_used |= 2;
+
+		if (insn->dst_reg == BPF_REG_8 || insn->src_reg == BPF_REG_8)
+			reg_used |= 4;
+
+		if (insn->dst_reg == BPF_REG_9 || insn->src_reg == BPF_REG_9)
+			reg_used |= 8;
+
+		if (insn->dst_reg == BPF_REG_FP || insn->src_reg == BPF_REG_FP) {
+			ctx->fp_used = true;
+			reg_used |= 16;
+		}
+	}
+
+	i = 0;
+	if (reg_used & 1)
+		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_6];
+
+	if (reg_used & 2)
+		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_7];
+
+	if (reg_used & 4)
+		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_8];
+
+	if (reg_used & 8)
+		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_9];
+
+	if (reg_used & 16)
+		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_FP];
+
+	if (ctx->arena_vm_start)
+		ctx->used_callee_reg[i++] = bpf2a64[ARENA_VM_START];
+
+	ctx->nr_used_callee_reg = i;
+}
+
+/* Save callee-saved registers */
+static void push_callee_regs(struct jit_ctx *ctx)
+{
+	int reg1, reg2, i;
+
+	/*
+	 * Program acting as exception boundary should save all ARM64
+	 * Callee-saved registers as the exception callback needs to recover
+	 * all ARM64 Callee-saved registers in its epilogue.
+	 */
+	if (ctx->prog->aux->exception_boundary) {
+		emit(A64_PUSH(A64_R(19), A64_R(20), A64_SP), ctx);
+		emit(A64_PUSH(A64_R(21), A64_R(22), A64_SP), ctx);
+		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
+		emit(A64_PUSH(A64_R(25), A64_R(26), A64_SP), ctx);
+		emit(A64_PUSH(A64_R(27), A64_R(28), A64_SP), ctx);
 	} else {
-		emit(A64_PUSH(ptr, fp, A64_SP), ctx);
-		emit(A64_NOP, ctx);
-		emit(A64_NOP, ctx);
+		find_used_callee_regs(ctx);
+		for (i = 0; i + 1 < ctx->nr_used_callee_reg; i += 2) {
+			reg1 = ctx->used_callee_reg[i];
+			reg2 = ctx->used_callee_reg[i + 1];
+			emit(A64_PUSH(reg1, reg2, A64_SP), ctx);
+		}
+		if (i < ctx->nr_used_callee_reg) {
+			reg1 = ctx->used_callee_reg[i];
+			/* keep SP 16-byte aligned */
+			emit(A64_PUSH(reg1, A64_ZR, A64_SP), ctx);
+		}
+	}
+}
+
+/* Restore callee-saved registers */
+static void pop_callee_regs(struct jit_ctx *ctx)
+{
+	struct bpf_prog_aux *aux = ctx->prog->aux;
+	int reg1, reg2, i;
+
+	/*
+	 * Program acting as exception boundary pushes R23 and R24 in addition
+	 * to BPF callee-saved registers. Exception callback uses the boundary
+	 * program's stack frame, so recover these extra registers in the above
+	 * two cases.
+	 */
+	if (aux->exception_boundary || aux->exception_cb) {
+		emit(A64_POP(A64_R(27), A64_R(28), A64_SP), ctx);
+		emit(A64_POP(A64_R(25), A64_R(26), A64_SP), ctx);
+		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
+		emit(A64_POP(A64_R(21), A64_R(22), A64_SP), ctx);
+		emit(A64_POP(A64_R(19), A64_R(20), A64_SP), ctx);
+	} else {
+		i = ctx->nr_used_callee_reg - 1;
+		if (ctx->nr_used_callee_reg % 2 != 0) {
+			reg1 = ctx->used_callee_reg[i];
+			emit(A64_POP(reg1, A64_ZR, A64_SP), ctx);
+			i--;
+		}
+		while (i > 0) {
+			reg1 = ctx->used_callee_reg[i - 1];
+			reg2 = ctx->used_callee_reg[i];
+			emit(A64_POP(reg1, reg2, A64_SP), ctx);
+			i -= 2;
+		}
 	}
 }
 
@@ -315,17 +419,12 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx)
 #define POKE_OFFSET (BTI_INSNS + 1)
 
 /* Tail call offset to jump into */
-#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 10)
+#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 4)
 
-static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
-			  bool is_exception_cb, u64 arena_vm_start)
+static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
-	const u8 r6 = bpf2a64[BPF_REG_6];
-	const u8 r7 = bpf2a64[BPF_REG_7];
-	const u8 r8 = bpf2a64[BPF_REG_8];
-	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const int idx0 = ctx->idx;
@@ -365,19 +464,28 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	emit(A64_MOV(1, A64_R(9), A64_LR), ctx);
 	emit(A64_NOP, ctx);
 
-	if (!is_exception_cb) {
+	if (!prog->aux->exception_cb) {
 		/* Sign lr */
 		if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
 			emit(A64_PACIASP, ctx);
+
 		/* Save FP and LR registers to stay align with ARM64 AAPCS */
 		emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
 		emit(A64_MOV(1, A64_FP, A64_SP), ctx);
 
-		/* Save callee-saved registers */
-		emit(A64_PUSH(r6, r7, A64_SP), ctx);
-		emit(A64_PUSH(r8, r9, A64_SP), ctx);
 		prepare_bpf_tail_call_cnt(ctx);
-		emit(A64_PUSH(A64_R(27), A64_R(28), A64_SP), ctx);
+
+		if (!ebpf_from_cbpf && is_main_prog) {
+			cur_offset = ctx->idx - idx0;
+			if (cur_offset != PROLOGUE_OFFSET) {
+				pr_err_once("PROLOGUE_OFFSET = %d, expected %d!\n",
+						cur_offset, PROLOGUE_OFFSET);
+				return -1;
+			}
+			/* BTI landing pad for the tail call, done with a BR */
+			emit_bti(A64_BTI_J, ctx);
+		}
+		push_callee_regs(ctx);
 	} else {
 		/*
 		 * Exception callback receives FP of Main Program as third
@@ -394,48 +502,23 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
 	}
 
-	/* Set up BPF prog stack base register */
-	emit(A64_MOV(1, fp, A64_SP), ctx);
-
-	if (!ebpf_from_cbpf && is_main_prog) {
-		cur_offset = ctx->idx - idx0;
-		if (cur_offset != PROLOGUE_OFFSET) {
-			pr_err_once("PROLOGUE_OFFSET = %d, expected %d!\n",
-				    cur_offset, PROLOGUE_OFFSET);
-			return -1;
-		}
-
-		/* BTI landing pad for the tail call, done with a BR */
-		emit_bti(A64_BTI_J, ctx);
-	}
-
-	/*
-	 * Program acting as exception boundary should save all ARM64
-	 * Callee-saved registers as the exception callback needs to recover
-	 * all ARM64 Callee-saved registers in its epilogue.
-	 */
-	if (prog->aux->exception_boundary) {
-		/*
-		 * As we are pushing two more registers, BPF_FP should be moved
-		 * 16 bytes
-		 */
-		emit(A64_SUB_I(1, fp, fp, 16), ctx);
-		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
-	}
+	if (ctx->fp_used)
+		/* Set up BPF prog stack base register */
+		emit(A64_MOV(1, fp, A64_SP), ctx);
 
 	/* Stack must be multiples of 16B */
 	ctx->stack_size = round_up(prog->aux->stack_depth, 16);
 
 	/* Set up function call stack */
-	emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
+	if (ctx->stack_size)
+		emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
-	if (arena_vm_start)
-		emit_a64_mov_i64(arena_vm_base, arena_vm_start, ctx);
+	if (ctx->arena_vm_start)
+		emit_a64_mov_i64(arena_vm_base, ctx->arena_vm_start, ctx);
 
 	return 0;
 }
 
-static int out_offset = -1; /* initialized on the first pass of build_body() */
 static int emit_bpf_tail_call(struct jit_ctx *ctx)
 {
 	/* bpf_tail_call(void *prog_ctx, struct bpf_array *array, u64 index) */
@@ -446,10 +529,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	const u8 prg = bpf2a64[TMP_REG_2];
 	const u8 tcc = bpf2a64[TMP_REG_3];
 	const u8 ptr = bpf2a64[TCCNT_PTR];
-	const int idx0 = ctx->idx;
-#define cur_offset (ctx->idx - idx0)
-#define jmp_offset (out_offset - (cur_offset))
 	size_t off;
+	__le32 *branch1 = NULL;
+	__le32 *branch2 = NULL;
+	__le32 *branch3 = NULL;
 
 	/* if (index >= array->map.max_entries)
 	 *     goto out;
@@ -459,17 +542,20 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_LDR32(tmp, r2, tmp), ctx);
 	emit(A64_MOV(0, r3, r3), ctx);
 	emit(A64_CMP(0, r3, tmp), ctx);
-	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
+	branch1 = ctx->image + ctx->idx;
+	emit(A64_NOP, ctx);
 
 	/*
 	 * if ((*tail_call_cnt_ptr) >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
-	 * (*tail_call_cnt_ptr)++;
 	 */
 	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
 	emit(A64_LDR64I(tcc, ptr, 0), ctx);
 	emit(A64_CMP(1, tcc, tmp), ctx);
-	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
+	branch2 = ctx->image + ctx->idx;
+	emit(A64_NOP, ctx);
+
+	/* (*tail_call_cnt_ptr)++; */
 	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
 
 	/* prog = array->ptrs[index];
@@ -481,30 +567,37 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_ADD(1, tmp, r2, tmp), ctx);
 	emit(A64_LSL(1, prg, r3, 3), ctx);
 	emit(A64_LDR64(prg, tmp, prg), ctx);
-	emit(A64_CBZ(1, prg, jmp_offset), ctx);
+	branch3 = ctx->image + ctx->idx;
+	emit(A64_NOP, ctx);
 
 	/* Update tail_call_cnt if the slot is populated. */
 	emit(A64_STR64I(tcc, ptr, 0), ctx);
 
+	/* restore SP */
+	if (ctx->stack_size)
+		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
+
+	pop_callee_regs(ctx);
+
 	/* goto *(prog->bpf_func + prologue_offset); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	emit_a64_mov_i64(tmp, off, ctx);
 	emit(A64_LDR64(tmp, prg, tmp), ctx);
 	emit(A64_ADD_I(1, tmp, tmp, sizeof(u32) * PROLOGUE_OFFSET), ctx);
-	emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 	emit(A64_BR(tmp), ctx);
 
-	/* out: */
-	if (out_offset == -1)
-		out_offset = cur_offset;
-	if (cur_offset != out_offset) {
-		pr_err_once("tail_call out_offset = %d, expected %d!\n",
-			    cur_offset, out_offset);
-		return -1;
+	if (ctx->image) {
+		off = &ctx->image[ctx->idx] - branch1;
+		*branch1 = cpu_to_le32(A64_B_(A64_COND_CS, off));
+
+		off = &ctx->image[ctx->idx] - branch2;
+		*branch2 = cpu_to_le32(A64_B_(A64_COND_CS, off));
+
+		off = &ctx->image[ctx->idx] - branch3;
+		*branch3 = cpu_to_le32(A64_CBZ(1, prg, off));
 	}
+
 	return 0;
-#undef cur_offset
-#undef jmp_offset
 }
 
 #ifdef CONFIG_ARM64_LSE_ATOMICS
@@ -730,37 +823,18 @@ static void build_plt(struct jit_ctx *ctx)
 		plt->target = (u64)&dummy_tramp;
 }
 
-static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
+static void build_epilogue(struct jit_ctx *ctx)
 {
 	const u8 r0 = bpf2a64[BPF_REG_0];
-	const u8 r6 = bpf2a64[BPF_REG_6];
-	const u8 r7 = bpf2a64[BPF_REG_7];
-	const u8 r8 = bpf2a64[BPF_REG_8];
-	const u8 r9 = bpf2a64[BPF_REG_9];
-	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 ptr = bpf2a64[TCCNT_PTR];
 
 	/* We're done with BPF stack */
-	emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
-
-	/*
-	 * Program acting as exception boundary pushes R23 and R24 in addition
-	 * to BPF callee-saved registers. Exception callback uses the boundary
-	 * program's stack frame, so recover these extra registers in the above
-	 * two cases.
-	 */
-	if (ctx->prog->aux->exception_boundary || is_exception_cb)
-		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
+	if (ctx->stack_size)
+		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
-	/* Restore x27 and x28 */
-	emit(A64_POP(A64_R(27), A64_R(28), A64_SP), ctx);
-	/* Restore fs (x25) and x26 */
-	emit(A64_POP(ptr, fp, A64_SP), ctx);
-	emit(A64_POP(ptr, fp, A64_SP), ctx);
+	pop_callee_regs(ctx);
 
-	/* Restore callee-saved register */
-	emit(A64_POP(r8, r9, A64_SP), ctx);
-	emit(A64_POP(r6, r7, A64_SP), ctx);
+	emit(A64_POP(A64_ZR, ptr, A64_SP), ctx);
 
 	/* Restore FP/LR registers */
 	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
@@ -1645,7 +1719,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bool tmp_blinded = false;
 	bool extra_pass = false;
 	struct jit_ctx ctx;
-	u64 arena_vm_start;
 	u8 *image_ptr;
 	u8 *ro_image_ptr;
 
@@ -1663,7 +1736,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = tmp;
 	}
 
-	arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	jit_data = prog->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
@@ -1694,6 +1766,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
+	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 
 	/*
 	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
@@ -1701,8 +1774,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
 	 */
-	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb,
-			   arena_vm_start)) {
+	if (build_prologue(&ctx, was_classic)) {
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1713,7 +1785,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.epilogue_offset = ctx.idx;
-	build_epilogue(&ctx, prog->aux->exception_cb);
+	build_epilogue(&ctx);
 	build_plt(&ctx);
 
 	extable_align = __alignof__(struct exception_table_entry);
@@ -1750,14 +1822,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
 
-	build_prologue(&ctx, was_classic, prog->aux->exception_cb, arena_vm_start);
+	build_prologue(&ctx, was_classic);
 
 	if (build_body(&ctx, extra_pass)) {
 		prog = orig_prog;
 		goto out_free_hdr;
 	}
 
-	build_epilogue(&ctx, prog->aux->exception_cb);
+	build_epilogue(&ctx);
 	build_plt(&ctx);
 
 	/* 3. Extra pass to validate JITed code. */
-- 
2.43.0


