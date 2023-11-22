Return-Path: <bpf+bounces-15680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E27F4EED
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12811C20A13
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CF58ABD;
	Wed, 22 Nov 2023 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xpB40NVB"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B661AB
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:08:21 -0800 (PST)
Message-ID: <2e8a1584-a289-4b2e-800c-8b463e734bcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700676498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkmu2QNTXywYsvTk8qqoTYTvDp8Kovdyg0Qu8cukpRg=;
	b=xpB40NVBp20q1oQpIg4W0RksB+YW3ZZIGJC2yKfYKIhzfn0UCWQbtt9FgZxX0EhuRG7OVC
	FpSEGO5xRn7O6UPH++1HWOGpX7bocA8PxmA04AljWD2jI6NWxpgpoqUv1kaP1rbf1fmD9p
	r6KfmmhKAJSLXry/0EzM/hZLXxKC250=
Date: Wed, 22 Nov 2023 10:08:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] C inlined assembly for reproducing max<min
Content-Language: en-GB
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, martin.lau@linux.dev,
 mathias.payer@nebelwelt.net, meng.xu.cs@uwaterloo.ca,
 sanidhya.kashyap@epfl.ch, song@kernel.org
References: <d3a518de-ada3-45e8-be3e-df942c2208b5@linux.dev>
 <20231122144018.4047232-1-tao.lyu@epfl.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231122144018.4047232-1-tao.lyu@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/22/23 9:40 AM, Tao Lyu wrote:
> Hi Yonghong,
>
> Thanks for your reply.
> The C inlined assembly code is attached.
> I'm using clang-16, but it still fails.
>
> Best,
> Tao
>
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>   .../selftests/bpf/prog_tests/verifier.c       |  2 ++
>   .../selftests/bpf/progs/verifier_range.c      | 25 +++++++++++++++++++
>   2 files changed, 27 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_range.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index e5c61aa6604a..3a5d746f392d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -77,6 +77,7 @@
>   #include "verifier_xadd.skel.h"
>   #include "verifier_xdp.skel.h"
>   #include "verifier_xdp_direct_packet_access.skel.h"
> +#include "verifier_range.skel.h"
>   
>   #define MAX_ENTRIES 11
>   
> @@ -184,6 +185,7 @@ void test_verifier_var_off(void)              { RUN(verifier_var_off); }
>   void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
>   void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
>   void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
> +void test_verifier_range(void)                { RUN(verifier_range); }
>   
>   static int init_test_val_map(struct bpf_object *obj, char *map_name)
>   {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_range.c b/tools/testing/selftests/bpf/progs/verifier_range.c
> new file mode 100644
> index 000000000000..27597eb8135c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_range.c
> @@ -0,0 +1,25 @@
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("?tc")
> +__log_level(2)
> +int test_verifier_range(void)
> +{
> +    asm volatile (
> +        "r5 = 100; \
> +        r5 /= 3; \
> +        w5 >>= 7; \
> +        r5 &= -386969681; \
> +        r5 -= -884670597; \
> +        w0 = w5; \
> +        if w0 & 0x894b6a55 goto +2; \

So actually it is 'if w0 & 0x894b6a55 goto +2' failed
the compilation.

Indeed, the above operation is not supported in llvm.
See
   https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/BPFInstrFormats.td#L62-L74
the missing BPFJumpOp<0x4> which corresponds to JSET.

The following llvm patch (on top of llvm-project main branch):

diff --git a/llvm/lib/Target/BPF/BPFInstrFormats.td b/llvm/lib/Target/BPF/BPFInstrFormats.td
index 841d97efc01c..6ed83d877ac0 100644
--- a/llvm/lib/Target/BPF/BPFInstrFormats.td
+++ b/llvm/lib/Target/BPF/BPFInstrFormats.td
@@ -63,6 +63,7 @@ def BPF_JA   : BPFJumpOp<0x0>;
  def BPF_JEQ  : BPFJumpOp<0x1>;
  def BPF_JGT  : BPFJumpOp<0x2>;
  def BPF_JGE  : BPFJumpOp<0x3>;
+def BPF_JSET : BPFJumpOp<0x4>;
  def BPF_JNE  : BPFJumpOp<0x5>;
  def BPF_JSGT : BPFJumpOp<0x6>;
  def BPF_JSGE : BPFJumpOp<0x7>;
diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td b/llvm/lib/Target/BPF/BPFInstrInfo.td
index 305cbbd34d27..9e75f35efe70 100644
--- a/llvm/lib/Target/BPF/BPFInstrInfo.td
+++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
@@ -246,6 +246,70 @@ class JMP_RI_32<BPFJumpOp Opc, string OpcodeStr, PatLeaf Cond>
    let BPFClass = BPF_JMP32;
  }
  
+class JSET_RR<string OpcodeStr>
+    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_X.Value,
+                   (outs),
+                   (ins GPR:$dst, GPR:$src, brtarget:$BrDst),
+                   "if $dst "#OpcodeStr#" $src goto $BrDst",
+                   []> {
+  bits<4> dst;
+  bits<4> src;
+  bits<16> BrDst;
+
+  let Inst{55-52} = src;
+  let Inst{51-48} = dst;
+  let Inst{47-32} = BrDst;
+  let BPFClass = BPF_JMP;
+}
+
+class JSET_RI<string OpcodeStr>
+    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_K.Value,
+                   (outs),
+                   (ins GPR:$dst, i64imm:$imm, brtarget:$BrDst),
+                   "if $dst "#OpcodeStr#" $imm goto $BrDst",
+                   []> {
+  bits<4> dst;
+  bits<16> BrDst;
+  bits<32> imm;
+
+  let Inst{51-48} = dst;
+  let Inst{47-32} = BrDst;
+  let Inst{31-0} = imm;
+  let BPFClass = BPF_JMP;
+}
+
+class JSET_RR_32<string OpcodeStr>
+    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_X.Value,
+                   (outs),
+                   (ins GPR32:$dst, GPR32:$src, brtarget:$BrDst),
+                   "if $dst "#OpcodeStr#" $src goto $BrDst",
+                   []> {
+  bits<4> dst;
+  bits<4> src;
+  bits<16> BrDst;
+
+  let Inst{55-52} = src;
+  let Inst{51-48} = dst;
+  let Inst{47-32} = BrDst;
+  let BPFClass = BPF_JMP32;
+}
+
+class JSET_RI_32<string OpcodeStr>
+    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_K.Value,
+                   (outs),
+                   (ins GPR32:$dst, i32imm:$imm, brtarget:$BrDst),
+                   "if $dst "#OpcodeStr#" $imm goto $BrDst",
+                   []> {
+  bits<4> dst;
+  bits<16> BrDst;
+  bits<32> imm;
+
+  let Inst{51-48} = dst;
+  let Inst{47-32} = BrDst;
+  let Inst{31-0} = imm;
+  let BPFClass = BPF_JMP32;
+}
+
  multiclass J<BPFJumpOp Opc, string OpcodeStr, PatLeaf Cond, PatLeaf Cond32> {
    def _rr : JMP_RR<Opc, OpcodeStr, Cond>;
    def _ri : JMP_RI<Opc, OpcodeStr, Cond>;
@@ -265,6 +329,10 @@ defm JULT : J<BPF_JLT, "<", BPF_CC_LTU, BPF_CC_LTU_32>;
  defm JULE : J<BPF_JLE, "<=", BPF_CC_LEU, BPF_CC_LEU_32>;
  defm JSLT : J<BPF_JSLT, "s<", BPF_CC_LT, BPF_CC_LT_32>;
  defm JSLE : J<BPF_JSLE, "s<=", BPF_CC_LE, BPF_CC_LE_32>;
+def JSET_RR    : JSET_RR<"&">;
+def JSET_RI    : JSET_RI<"&">;
+def JSET_RR_32 : JSET_RR_32<"&">;
+def JSET_RI_32 : JSET_RI_32<"&">;
  }
  
  // ALU instructions

can solve your inline asm issue. We will discuss whether llvm compiler
should be implementing this instruction from source or not.


> +        r2 = 1; \
> +        r2 = 1; \
> +        r0 = 0; \
> +        "
> +    );
> +    return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

