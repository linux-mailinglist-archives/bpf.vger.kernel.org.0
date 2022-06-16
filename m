Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EA654E6E1
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377205AbiFPQUn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 12:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377505AbiFPQUm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 12:20:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B70F42A10
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 09:20:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g25so3707653ejh.9
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uw4PLtWEGLGfOE/kAMpGlLOZBa3VwDABOgWaEtWdyws=;
        b=k9Vb9ToXK168Qp5ZJmTfuDDTg2Al5zx7Kqot0OjrjmomMqCgs0+yEB9dXtvR1Rg+VP
         9DjJcrHQhIOpx71PbWdILNdI6mKP4pdG8XDxSX3waeIXlDZ05AlqTRqkehtJadzKVxtG
         xQg3iZr2onSlHvmDr4C0zw4LGRsS6f8ufER/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uw4PLtWEGLGfOE/kAMpGlLOZBa3VwDABOgWaEtWdyws=;
        b=IQjGQwXYlRAReaa7bbi4rALQUyEBtoJcSpOIObFHdBU65ipBkTCqraBAI6zSzzKOkx
         X4RyJQSr4ttetkdnvzvvZkEy4c0wMWeCnmcIyxeKRPQyObd3Jv/3Op+GnQQUxNgQp6Ws
         m0/WWzptXga9Sf+vIhY+Jxf5yUf+LERtv3X2uvNfnZxqKWNv6hvtOhHbddtoSDlzCEef
         Y/ua4u6YTR8YkAUJa1YQee0yWBNh7XxUgTcYo1eUU3sEIupWjMa2950eDBPga/8jHTin
         CrYwUSfS91xQf9awuZ9ffzpgBLxrVCuhIU98SWpr6Cnaww3LB/YaikzcYMt2Y1d1InX0
         /PUg==
X-Gm-Message-State: AJIora95+3WBboLbxaZcbFHu3RxXaNAtMLxnOVJanE2evLcZ2VSt/l6b
        xdr3FarfiilCZ1se5siMVEPTZp8PWoTN+A==
X-Google-Smtp-Source: AGRyM1tPWLR8rppdBEPKe/z3lmUEKWr6PcmnyVnoRvzjx5xDxsj+28U1hHe5FknvKAuXqmZNVwEc7A==
X-Received: by 2002:a17:907:6e0f:b0:706:9a4f:2f3d with SMTP id sd15-20020a1709076e0f00b007069a4f2f3dmr5202919ejc.413.1655396439534;
        Thu, 16 Jun 2022 09:20:39 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id w9-20020a170906b18900b006fec27575f1sm956935ejy.123.2022.06.16.09.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:20:39 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        kernel-team@cloudflare.com
Subject: [PATCH bpf-next v2 1/2] bpf, x86: Fix tail call count offset calculation on bpf2bpf call
Date:   Thu, 16 Jun 2022 18:20:36 +0200
Message-Id: <20220616162037.535469-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616162037.535469-1-jakub@cloudflare.com>
References: <20220616162037.535469-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On x86-64 the tail call count is passed from one BPF function to another
through %rax. Additionally, on function entry, the tail call count value is
stored on stack right after the BPF program stack, due to register
shortage.

The stored count is later loaded from stack either when performing a tail
call - to check if we have not reached the tail call limit - or before
calling another BPF function call in order to pass it via %rax.

In the latter case, we miscalculate the offset at which the tail call count
was stored on function entry. The JIT does not take into account that the
allocated BPF program stack is always a multiple of 8 on x86, while the
actual stack depth does not have to be.

This leads to a load from an offset that belongs to the BPF stack, as shown
in the example below:

SEC("tc")
int entry(struct __sk_buff *skb)
{
	/* Have data on stack which size is not a multiple of 8 */
	volatile char arr[1] = {};
	return subprog_tail(skb);
}

int entry(struct __sk_buff * skb):
   0: (b4) w2 = 0
   1: (73) *(u8 *)(r10 -1) = r2
   2: (85) call pc+1#bpf_prog_ce2f79bb5f3e06dd_F
   3: (95) exit

int entry(struct __sk_buff * skb):
   0xffffffffa0201788:  nop    DWORD PTR [rax+rax*1+0x0]
   0xffffffffa020178d:  xor    eax,eax
   0xffffffffa020178f:  push   rbp
   0xffffffffa0201790:  mov    rbp,rsp
   0xffffffffa0201793:  sub    rsp,0x8
   0xffffffffa020179a:  push   rax
   0xffffffffa020179b:  xor    esi,esi
   0xffffffffa020179d:  mov    BYTE PTR [rbp-0x1],sil
   0xffffffffa02017a1:  mov    rax,QWORD PTR [rbp-0x9]	!!! tail call count
   0xffffffffa02017a8:  call   0xffffffffa02017d8       !!! is at rbp-0x10
   0xffffffffa02017ad:  leave
   0xffffffffa02017ae:  ret

Fix it by rounding up the BPF stack depth to a multiple of 8, when
calculating the tail call count offset on stack.

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 arch/x86/net/bpf_jit_comp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f298b18a9a3d..c98b8c0ed3b8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1420,8 +1420,9 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL:
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
+				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 				EMIT3_off32(0x48, 0x8B, 0x85,
-					    -(bpf_prog->aux->stack_depth + 8));
+					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
 				if (!imm32 || emit_call(&prog, func, image + addrs[i - 1] + 7))
 					return -EINVAL;
 			} else {
-- 
2.35.3

