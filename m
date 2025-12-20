Return-Path: <bpf+bounces-77237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CFFCD29E1
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 08:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA02B30019F1
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE79525B30E;
	Sat, 20 Dec 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HeyY+W2S"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F6023C503
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766216079; cv=none; b=FK74amKSv1AkbD7iJqenlZ14/JB7ViFXwXgcXFeCxDjEP5roA/lQ7fZdWEm5YMqdFgS3qzU6/u6KchzDPCZWt157Wqf5TT5fHLMV0DoRzTF7kxGcax43o7aSqc/uSH0DxpKKq1FrpKB1B1peyTx6EswEDa0PQYysPQUfyP/T1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766216079; c=relaxed/simple;
	bh=XUzXaXgAsgoDGDRQtOHCa3FfJDiAccBSyNkpwKM3LNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxOfLboxTnZJyWfaq5peSRT3g0Lzs/Rk78UsF0QJesczEH9lVxR1JiMHpBUNapGEwXEtHc1MUZ5njsnnQbrXu3T/QnqWxPbhjjFVe5AgGWIc585bWkCyBnxFYACXPkOuop74hxXVcz09fLVMHwSR9rVldbOZTPCt+Ft7C9QxWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HeyY+W2S; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766216061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S91jpqXqsg0Jhi5+sYGwbVyxcd6hPUpwSC+NwxrECyc=;
	b=HeyY+W2S4IlGyi42CgeG9vVBzjsFsJ67uIQQZ7TAghIE8ud81U6CuHRBCmHAPcCWX78aRA
	a2YBH5bXwtw83cTHp/1M/5tCVBn1cqLNWzYN6JO3eKrKIBa9aF3poFQ+Hu+zbB0qyYdphy
	K0vH8DouyMMx4ZNMWBPTQWyv+ML2t4M=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, schwab@linux-m68k.org,
 Pu Lehui <pulehui@huawei.com>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2] riscv,
 bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
Date: Sat, 20 Dec 2025 15:33:58 +0800
Message-ID: <8619181.T7Z3S40VBb@7950hx>
In-Reply-To: <33977244-1266-4590-af38-e3be3e46d7f4@huawei.com>
References:
 <20251219142948.204312-1-dongml2@chinatelecom.cn>
 <33977244-1266-4590-af38-e3be3e46d7f4@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/20 10:59, Pu Lehui wrote:
> 
> On 2025/12/19 22:29, Menglong Dong wrote:
> > The usage of BPF_TRAMP_F_ORIG_STACK in __arch_prepare_bpf_trampoline() is
> > wrong, and it should be BPF_TRAMP_F_CALL_ORIG, which caused crash as
> > Andreas reported:
> > 
> >    Insufficient stack space to handle exception!
> >    Task stack:     [0xff20000000010000..0xff20000000014000]
> >    Overflow stack: [0xff600000ffdad070..0xff600000ffdae070]
> >    CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)
> >    Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
> >    epc : copy_from_kernel_nofault+0xa/0x198
> >     ra : bpf_probe_read_kernel+0x20/0x60
> >    epc : ffffffff802b732a ra : ffffffff801e6070 sp : ff2000000000ffe0
> >     gp : ffffffff82262ed0 tp : 0000000000000000 t0 : ffffffff80022320
> >     t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : ff20000000010040
> >     s1 : 0000000000000008 a0 : ff20000000010050 a1 : ff60000083b3d320
> >     a2 : 0000000000000008 a3 : 0000000000000097 a4 : 0000000000000000
> >     a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000000003
> >     s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : ff60000083b3d340
> >     s5 : ff20000000010060 s6 : 0000000000000000 s7 : ff20000000013aa8
> >     s8 : 0000000000000000 s9 : 0000000000008000 s10: 000000000058dcb0
> >     s11: 000000000058dca7 t3 : 000000006925116d t4 : ff6000008090f026
> >     t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
> >    status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000005
> >    Kernel panic - not syncing: Kernel stack overflow
> >    CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)
> >    Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
> >    Call Trace:
> >    [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
> >    [<ffffffff80002502>] show_stack+0x3a/0x50
> >    [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
> >    [<ffffffff80012300>] dump_stack+0x18/0x22
> >    [<ffffffff80002abe>] vpanic+0xf6/0x328
> >    [<ffffffff80002d2e>] panic+0x3e/0x40
> >    [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
> >    [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x60
> > 
> > Just fix it.
> > 
> > Fixes: 47c9214dcbea ("bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME")
> > Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> > Closes: https://lore.kernel.org/bpf/874ipnkfvt.fsf@igel.home/
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - merge the code
> > ---
> >   arch/riscv/net/bpf_jit_comp64.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> > index 5f9457e910e8..37888abee70c 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@ -1133,10 +1133,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> >   
> >   	store_args(nr_arg_slots, args_off, ctx);
> >   
> > -	/* skip to actual body of traced function */
> > -	if (flags & BPF_TRAMP_F_ORIG_STACK)
> 
> Oh, how did this weird flags get in here...

It's my fault. I wanted to use BPF_TRAMP_F_CALL_ORIG here, and
a copy-paste mistake happen. They look a little similar :(

> 
> > -		orig_call += RV_FENTRY_NINSNS * 4;
> > -
> >   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> >   		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
> >   		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
> > @@ -1171,6 +1167,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> >   	}
> >   
> >   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +		/* skip to actual body of traced function */
> > +		orig_call += RV_FENTRY_NINSNS * 4;
> 
> 
> LGTM, let's revert it.
> 
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> 
> >   		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
> >   		restore_stack_args(nr_arg_slots - RV_MAX_REG_ARGS, args_off, stk_arg_off, ctx);
> >   		ret = emit_call((const u64)orig_call, true, ctx);

Andreas suggested that we remove the variable "orig_call" and use
"func_addr + RV_FENTRY_NINSNS * 4" directly here. But I saw the V2
is already applied. Hmm...I think it doesn't matter.

Thanks!
Menglong Dong

> 
> 





