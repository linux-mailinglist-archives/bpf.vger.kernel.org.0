Return-Path: <bpf+bounces-8632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04080788C72
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B312818A8
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD049107A9;
	Fri, 25 Aug 2023 15:28:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233210787
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:28:27 +0000 (UTC)
Received: from out-248.mta0.migadu.com (out-248.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F22137
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:28:25 -0700 (PDT)
Message-ID: <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692977303; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADrLm5FOhZF0BsOKum99yg64wr70c47LcebFXo6vRbY=;
	b=suRiEhi9s5GtH5k5XB+bLSj2CG4LmY29+v8rAFBSIX0P0CM5GGPGB2UVUxfIBGSiuI1qC5
	S2KE9mX/bMG7FEA9ljHKBxhlUlZQ72CiiZs/uHp6DJ49TFquhQd9xDwEU2I4IK05E6mzUy
	6m4fAQ/z4am5+Xv/lDatMDd3hLZjsLQ=
Date: Fri, 25 Aug 2023 08:28:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/25/23 3:32 AM, Björn Töpel wrote:
> I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
> selftests on bpf-next 9e3b47abeb8f.
> 
> I'm able to reproduce the hang by multiple runs of:
>   | ./test_progs -a link_api -a linked_list
> I'm currently investigating that.
> 
> But! Sometimes (every blue moon) I get a warn_on_once hit:
>   | ------------[ cut here ]------------
>   | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342 bpf_mem_refill+0x1fc/0x206
>   | Modules linked in: bpf_testmod(OE)
>   | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G           OE    N 6.5.0-rc5-01743-gdcb152bb8328 #2
>   | Hardware name: riscv-virtio,qemu (DT)
>   | epc : bpf_mem_refill+0x1fc/0x206
>   |  ra : irq_work_single+0x68/0x70
>   | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff2000000001be20
>   |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 0000000000046600
>   |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff2000000001be70
>   |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff600003fef4b000
>   |  a2 : 000000000000003f a3 : ffffffff80008250 a4 : 0000000000000060
>   |  a5 : 0000000000000080 a6 : 0000000000000000 a7 : 0000000000735049
>   |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 0000000000001000
>   |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : ffffffff82d6bd30
>   |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 000000000000ffff
>   |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 0000000000000000
>   |  t5 : ff6000008fd28278 t6 : 0000000000040000
>   | status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
>   | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
>   | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
>   | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
>   | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
>   | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
>   | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
>   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
>   | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
>   | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
>   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
>   | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
>   | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
>   | [<ffffffff812b6904>] do_irq+0x66/0x98
>   | ---[ end trace 0000000000000000 ]---
> 
> Code:
>   | static void free_bulk(struct bpf_mem_cache *c)
>   | {
>   | 	struct bpf_mem_cache *tgt = c->tgt;
>   | 	struct llist_node *llnode, *t;
>   | 	unsigned long flags;
>   | 	int cnt;
>   |
>   | 	WARN_ON_ONCE(tgt->unit_size != c->unit_size);
>   | ...
> 
> I'm not well versed in the memory allocator; Before I dive into it --
> has anyone else hit it? Ideas on why the warn_on_once is hit?

Maybe take a look at the patch
   822fb26bdb55  bpf: Add a hint to allocated objects.

In the above patch, we have

+       /*
+        * Remember bpf_mem_cache that allocated this object.
+        * The hint is not accurate.
+        */
+       c->tgt = *(struct bpf_mem_cache **)llnode;

I suspect that the warning may be related to the above.
I tried the above ./test_progs command line (running multiple
at the same time) and didn't trigger the issue.

> 
> 
> Björn
> 

