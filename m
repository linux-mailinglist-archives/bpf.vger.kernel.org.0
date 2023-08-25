Return-Path: <bpf+bounces-8559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1747884F9
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757B5281806
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246ECCA54;
	Fri, 25 Aug 2023 10:32:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B0ED2EC
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3AEC433C7;
	Fri, 25 Aug 2023 10:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692959574;
	bh=rJmtd4AoEg8qpdbmr/J69QEcfU7pcYSpKFVRCPpe/Js=;
	h=From:To:Cc:Subject:Date:From;
	b=BM+GM9bM9SM9xPdQtUlBM7AAgc3ZWcfCiaIOW9UuluA2QM9JovGZZUS3tdJo+sAVu
	 hChGeOTU4Ofk1bb+b7DQ9TKqEdI2J+afOXf7am2Ot0faMuJoGmxEiGrXgPlrxLR0Gp
	 dPtH1QvH1hKdm0ksS24UjB9fSaGXiJ/9BpXPZK0mo3PtquOoOdy3GN7DUbO+GCDJ1X
	 lPjGuPABMUr+7fldXVE7pvDl6zGyiVX3WniB9vmNR9exnR6WBq7b5ecErqPncwdFuA
	 hPLfvN1yRyu0g7B6MLmgHXEA648PSJeNsMi3OWoMDBAoVyBAiL5O4VTRromBGclSX/
	 78RcaqV96ryiQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Subject: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
Date: Fri, 25 Aug 2023 12:32:51 +0200
Message-ID: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
selftests on bpf-next 9e3b47abeb8f.

I'm able to reproduce the hang by multiple runs of:
 | ./test_progs -a link_api -a linked_list
I'm currently investigating that.

But! Sometimes (every blue moon) I get a warn_on_once hit:
 | ------------[ cut here ]------------
 | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342 bpf_mem_refill+0x1=
fc/0x206
 | Modules linked in: bpf_testmod(OE)
 | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G           OE    N 6.5.0=
-rc5-01743-gdcb152bb8328 #2
 | Hardware name: riscv-virtio,qemu (DT)
 | epc : bpf_mem_refill+0x1fc/0x206
 |  ra : irq_work_single+0x68/0x70
 | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff2000000001be20
 |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 0000000000046600
 |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff2000000001be70
 |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff600003fef4b000
 |  a2 : 000000000000003f a3 : ffffffff80008250 a4 : 0000000000000060
 |  a5 : 0000000000000080 a6 : 0000000000000000 a7 : 0000000000735049
 |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 0000000000001000
 |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : ffffffff82d6bd30
 |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 000000000000ffff
 |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 0000000000000000
 |  t5 : ff6000008fd28278 t6 : 0000000000040000
 | status: 0000000200000100 badaddr: 0000000000000000 cause: 00000000000000=
03
 | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
 | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
 | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
 | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
 | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
 | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
 | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
 | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
 | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
 | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
 | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
 | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
 | [<ffffffff812b6904>] do_irq+0x66/0x98
 | ---[ end trace 0000000000000000 ]---

Code:
 | static void free_bulk(struct bpf_mem_cache *c)
 | {
 | 	struct bpf_mem_cache *tgt =3D c->tgt;
 | 	struct llist_node *llnode, *t;
 | 	unsigned long flags;
 | 	int cnt;
 |=20
 | 	WARN_ON_ONCE(tgt->unit_size !=3D c->unit_size);
 | ...

I'm not well versed in the memory allocator; Before I dive into it --
has anyone else hit it? Ideas on why the warn_on_once is hit?


Bj=C3=B6rn

