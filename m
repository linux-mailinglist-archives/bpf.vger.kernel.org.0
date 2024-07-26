Return-Path: <bpf+bounces-35699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5DC93CCFD
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC2C1F21A4B
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C922616;
	Fri, 26 Jul 2024 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PDDy3jIZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11E2C684
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964465; cv=none; b=uCTXU333aEf5DIs0vWKxwy3dmsHfPZm4c8a75O2ezCfr1/qWLPF4QEfr3ubt+XocOZS45Ydxv8z2hUNvvrLl+WeYA6hvTzH4RY1ucrlxunlF3dNugPDRPc7+4KRFC+5U4vldNY7ZuhwLF0bo7TSiV1GfljZhhB/ItfZwNdjLF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964465; c=relaxed/simple;
	bh=K2bKskfyomfGujP0ijhJzpzW2ISEF484Qra0+Cv+9Pg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XvpVvZ+yjATfhfOeXeJHBQyCCAzdyKHlbIJhiA8GMmg4IXPic1AYoDLzF7y1lY2rsLhn5ZwLrtmbG4834aKb4hSwHj95AHybiJK1AoHOssLA2sbdb6TCbcQ80Ex2iMkDCzxxvB22o0l1imVTfeh8/8z8q2FV/odAfOu0a0BDfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PDDy3jIZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721964461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuchE5x2xoKotjm9PZqH157q39zaIrVBW2zkCF4cDYE=;
	b=PDDy3jIZStNNnie27uq0q0hTN/QjWGwF2Acwvj/oD5YOX3AUaRJLyJLo/r9PS8CrYG4TDY
	QfJggVctcceZHKNaEI+Yx4wsBmcltw+Guba51Tw8D3w+hYUEKQFMsp5Oazz4wJWLG/PVdZ
	SYoITwNvKlEo1LM4mgMIhYqPomQn3Mo=
Date: Fri, 26 Jul 2024 03:27:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: leon.hwang@linux.dev
Message-ID: <603c6bac4236b4e6632b00dbe222d5213ff8b9e7@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix updating attached freplace prog to
 PROG_ARRAY map
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
In-Reply-To: <181a9753-717c-4eb4-b788-74468f68c0ff@linux.dev>
References: <20240725003251.37855-1-leon.hwang@linux.dev>
 <20240725003251.37855-2-leon.hwang@linux.dev>
 <181a9753-717c-4eb4-b788-74468f68c0ff@linux.dev>
X-Migadu-Flow: FLOW_OUT

26 July 2024 at 04:58, "Yonghong Song" <yonghong.song@linux.dev> wrote:



>=20
>=20On 7/24/24 5:32 PM, Leon Hwang wrote:
>=20
>=20>=20
>=20> The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
> >=20
>=20>  resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed the following pa=
nic,
> >=20
>=20>  which was caused by updating attached freplace prog to PROG_ARRAY =
map.
> >=20
>=20
> I am confused here. You mentioned that commit f7866c3587337731
>=20
>=20fixed the panic below. But looking at commit message:
>=20
>=20 https://lore.kernel.org/bpf/20240711145819.254178-2-wutengda@huaweic=
loud.com
>=20
>=20it does not seem the case.

The commit fixed this panic meanwhile.

This panic seems confusing. I'll remove it in patch v2.

>=20
>=20>=20
>=20> But, it does not support updating attached freplace prog to PROG_AR=
RAY
> >=20
>=20>  map.
> >=20
>=20
> This seems true since this patch itself intends fixing this issue.

Yes, it is to fix this issue.

>=20
>=20>=20
>=20> [309049.036402] BUG: kernel NULL pointer dereference, address: 0000=
000000000004
> >=20
>=20>  [309049.036419] #PF: supervisor read access in kernel mode
> >=20
>=20>  [309049.036426] #PF: error_code(0x0000) - not-present page
> >=20
>=20>  [309049.036432] PGD 0 P4D 0
> >=20
>=20>  [309049.036437] Oops: 0000 [#1] PREEMPT SMP NOPTI
> >=20
>=20>  [309049.036444] CPU: 2 PID: 788148 Comm: test_progs Not tainted 6.=
8.0-31-generic #31-Ubuntu
> >=20
>=20>  [309049.036465] Hardware name: VMware, Inc. VMware20,1/440BX Deskt=
op Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
> >=20
>=20>  [309049.036477] RIP: 0010:bpf_prog_map_compatible+0x2a/0x140
> >=20
>=20>  [309049.036488] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89=
 fe 41 55 41 54 53 44 8b 6e 04 48 89 f3 41 83 fd 1c 75 0c 48 8b 46 38 48 =
8b 40 70 <44> 8b 68 04 f6 43 03 01 75 1c 48 8b 43 38 44 0f b6 a0 89 00 00=
 00
> >=20
>=20>  [309049.036505] RSP: 0018:ffffb2e080fd7ce0 EFLAGS: 00010246
> >=20
>=20>  [309049.036513] RAX: 0000000000000000 RBX: ffffb2e0807c1000 RCX: 0=
000000000000000
> >=20
>=20>  [309049.036521] RDX: 0000000000000000 RSI: ffffb2e0807c1000 RDI: f=
fff990290259e00
> >=20
>=20>  [309049.036528] RBP: ffffb2e080fd7d08 R08: 0000000000000000 R09: 0=
000000000000000
> >=20
>=20>  [309049.036536] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff990290259e00
> >=20
>=20>  [309049.036543] R13: 000000000000001c R14: ffff990290259e00 R15: f=
fff99028e29c400
> >=20
>=20>  [309049.036551] FS: 00007b82cbc28140(0000) GS:ffff9903b3f00000(000=
0) knlGS:0000000000000000
> >=20
>=20>  [309049.036559] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >=20
>=20>  [309049.036566] CR2: 0000000000000004 CR3: 0000000101286002 CR4: 0=
0000000003706f0
> >=20
>=20>  [309049.036573] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> >=20
>=20>  [309049.036581] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> >=20
>=20>  [309049.036588] Call Trace:
> >=20
>=20>  [309049.036592] <TASK>
> >=20
>=20>  [309049.036597] ? show_regs+0x6d/0x80
> >=20
>=20>  [309049.036604] ? __die+0x24/0x80
> >=20
>=20>  [309049.036619] ? page_fault_oops+0x99/0x1b0
> >=20
>=20>  [309049.036628] ? do_user_addr_fault+0x2ee/0x6b0
> >=20
>=20>  [309049.036634] ? exc_page_fault+0x83/0x1b0
> >=20
>=20>  [309049.036641] ? asm_exc_page_fault+0x27/0x30
> >=20
>=20>  [309049.036649] ? bpf_prog_map_compatible+0x2a/0x140
> >=20
>=20>  [309049.036656] prog_fd_array_get_ptr+0x2c/0x70
> >=20
>=20>  [309049.036664] bpf_fd_array_map_update_elem+0x37/0x130
> >=20
>=20>  [309049.036671] bpf_map_update_value+0x1d3/0x260
> >=20
>=20>  [309049.036677] map_update_elem+0x1fa/0x360
> >=20
>=20>  [309049.036683] __sys_bpf+0x54c/0xa10
> >=20
>=20>  [309049.036689] __x64_sys_bpf+0x1a/0x30
> >=20
>=20>  [309049.036694] x64_sys_call+0x1936/0x25c0
> >=20
>=20>  [309049.036700] do_syscall_64+0x7f/0x180
> >=20
>=20>  [309049.036706] ? do_syscall_64+0x8c/0x180
> >=20
>=20>  [309049.036712] ? do_syscall_64+0x8c/0x180
> >=20
>=20>  [309049.036717] ? irqentry_exit+0x43/0x50
> >=20
>=20>  [309049.036723] ? common_interrupt+0x54/0xb0
> >=20
>=20>  [309049.036729] entry_SYSCALL_64_after_hwframe+0x73/0x7b
> >=20
>=20
> I actually tried your selftest (patch 2/2) without patch 1/1, I got the
>=20
>=20following error:
>=20
>=20All error logs:
>=20
>=20tester_init:PASS:tester_log_buf 0 nsec
>=20
>=20process_subtest:PASS:obj_open_mem 0 nsec
>=20
>=20process_subtest:PASS:specs_alloc 0 nsec
>=20
>=20test_tailcall_freplace:PASS:open fr_skel 0 nsec
>=20
>=20test_tailcall_freplace:PASS:open tc_skel 0 nsec
>=20
>=20test_tailcall_freplace:PASS:tc_skel entry prog_id 0 nsec
>=20
>=20test_tailcall_freplace:PASS:set_attach_target 0 nsec
>=20
>=20test_tailcall_freplace:PASS:load fr_skel 0 nsec
>=20
>=20test_tailcall_freplace:PASS:attach_freplace 0 nsec
>=20
>=20test_tailcall_freplace:PASS:fr_skel entry prog_fd 0 nsec
>=20
>=20test_tailcall_freplace:PASS:fr_skel jmp_table map_fd 0 nsec
>=20
>=20test_tailcall_freplace:FAIL:update jmp_table unexpected error: -22 (e=
rrno 22)
>=20
>=20#328/25 tailcalls/tailcall_freplace:FAIL
>=20
>=20#328 tailcalls:FAIL
>=20
>=20I didn't see kernel panic.

Indeed.

>=20
>=20>=20
>=20> Since commit 1c123c567fb138eb ("bpf: Resolve fext program type when
> >=20
>=20>  checking map compatibility"), freplace prog can be used as tail-ca=
llee
> >=20
>=20>  of its target prog.
> >=20
>=20
> the tailcall target can be a freplace prog.

Ack.

>=20
>=20>=20
>=20> And the commit 3aac1ead5eb6b76f ("bpf: Move prog->aux->linked_prog =
and
> >=20
>=20>  trampoline into bpf_link on attach") sets prog->aux->dst_prog as N=
ULL
> >=20
>=20>  when attach freplace prog to its target.
> >=20
>=20
> when attach -> after attaching

Ack.

>=20
>=20>=20
>=20> Then, as for following example:
> >=20
>=20>  tailcall_freplace.c:
> >=20
>=20>  // SPDX-License-Identifier: GPL-2.0
> >=20
>=20>  \#include <linux/bpf.h>
> >=20
>=20>  \#include <bpf/bpf_helpers.h>
> >=20
>=20>  \#include "bpf_legacy.h"
> >=20
>=20>  struct {
> >=20
>=20>  __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> >=20
>=20>  __uint(max_entries, 1);
> >=20
>=20>  __uint(key_size, sizeof(__u32));
> >=20
>=20>  __uint(value_size, sizeof(__u32));
> >=20
>=20>  } jmp_table SEC(".maps");
> >=20
>=20>  int count =3D 0;
> >=20
>=20>  __noinline int
> >=20
>=20>  subprog(struct __sk_buff *skb)
> >=20
>=20>  {
> >=20
>=20>  volatile int ret =3D 1;
> >=20
>=20>  count++;
> >=20
>=20>  bpf_tail_call_static(skb, &jmp_table, 0);
> >=20
>=20>  return ret;
> >=20
>=20>  }
> >=20
>=20
> This subprog is not needed and could be misleading,
>=20
>=20just inline subprog into entry prog, it should be okay.

Ack.

>=20
>=20>=20
>=20> SEC("freplace")
> >=20
>=20>  int entry(struct __sk_buff *skb)
> >=20
>=20>  {
> >=20
>=20>  return subprog(skb);
> >=20
>=20>  }
> >=20
>=20>  char __license[] SEC("license") =3D "GPL";
> >=20
>=20>  tc_bpf2bpf.c:
> >=20
>=20>  // SPDX-License-Identifier: GPL-2.0
> >=20
>=20>  \#include <linux/bpf.h>
> >=20
>=20>  \#include <bpf/bpf_helpers.h>
> >=20
>=20>  \#include "bpf_legacy.h"
> >=20
>=20>  __noinline int
> >=20
>=20>  subprog(struct __sk_buff *skb)
> >=20
>=20>  {
> >=20
>=20>  volatile int ret =3D 1;
> >=20
>=20>  return ret;
> >=20
>=20>  }
> >=20
>=20>  SEC("tc")
> >=20
>=20>  int entry(struct __sk_buff *skb)
> >=20
>=20>  {
> >=20
>=20>  return subprog(skb);
> >=20
>=20>  }
> >=20
>=20>  char __license[] SEC("license") =3D "GPL";
> >=20
>=20>  And freplace entry prog's target is the tc subprog.
> >=20
>=20>  After loading, the freplace jmp_table's owner type is
> >=20
>=20>  BPF_PROG_TYPE_SCHED_CLS.
> >=20
>=20>  Next, after attaching freplace prog to tc subprog, its prog->aux->
> >=20
>=20>  dst_prog is NULL.
> >=20
>=20>  Next, when update freplace prog to jmp_table, bpf_prog_map_compati=
ble()
> >=20
>=20>  returns false because resolve_prog_type() returns BPF_PROG_TYPE_EX=
T instead
> >=20
>=20>  of BPF_PROG_TYPE_SCHED_CLS.
> >=20
>=20>  With this patch, resolve_prog_type() returns BPF_PROG_TYPE_SCHED_C=
LS to
> >=20
>=20>  support updating attached freplace prog to PROG_ARRY map for this
> >=20
>=20>  example.
> >=20
>=20>  Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve=
_prog_type() for BPF_PROG_TYPE_EXT")
> >=20
>=20>  Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >=20
>=20>  Cc: Martin KaFai Lau <martin.lau@kernel.org>
> >=20
>=20>  Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  include/linux/bpf_verifier.h | 4 ++--
> >=20
>=20>  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
>=20>  diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_veri=
fier.h
> >=20
>=20>  index 5cea15c81b8a8..387e034e73d0e 100644
> >=20
>=20>  --- a/include/linux/bpf_verifier.h
> >=20
>=20>  +++ b/include/linux/bpf_verifier.h
> >=20
>=20>  @@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
> >=20
>=20>  /* only use after check_attach_btf_id() */
> >=20
>=20>  static inline enum bpf_prog_type resolve_prog_type(const struct bp=
f_prog *prog)
> >=20
>=20>  {
> >=20
>=20>  - return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->dst_pr=
og) ?
> >=20
>=20>  - prog->aux->dst_prog->type : prog->type;
> >=20
>=20>  + return prog->type =3D=3D BPF_PROG_TYPE_EXT ?
> >=20
>=20>  + prog->aux->saved_dst_prog_type : prog->type;
> >=20
>=20
> If prog->aux->dst_prog is NULL, is it possible that prog->aux->saved_ds=
t_prog_type
>=20
>=20(0, corresponding to BPF_PROG_TYPE_UNSPEC) could be returned? Do we n=
eed to do
>=20
>=20 return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->saved_dst_=
prog_type) ?
>=20
>=20 prog->aux->saved_dst_prog_type : prog->type;
>=20
>=20Maybe I missed something here?

It seems better to check prog->aux->saved_dst_prog_type. But I don't thin=
k so.

prog->aux->saved_dst_prog_type is set in check_attach_btf_id(). And there=
 is no
resolve_prog_type() before check_attach_btf_id() in bpf_check().

Therefore, resolve_prog_type() must be called after check_attach_btf_id()=
.

Thanks,
Leon

>=20
>=20>=20
>=20> }
> >=20
>=20>  > static inline bool bpf_prog_check_recur(const struct bpf_prog *p=
rog)
> >
>

