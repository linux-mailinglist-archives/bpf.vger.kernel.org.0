Return-Path: <bpf+bounces-8771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B754C789C10
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85391C2094D
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C83111D;
	Sun, 27 Aug 2023 08:11:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44453EBC
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 08:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E935C433C7;
	Sun, 27 Aug 2023 08:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693123888;
	bh=a7gvVdvjt2McMEtENvLa0Q/lHREJXWh8ZYndPgK9RuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OS0Ktsoim8Fs8DR7r22wvZRiiJw/lt8rJ6u2s8o8vxQjs7c0CmMG9VCAEJapyZ1NR
	 FkbiYU75I4lUmyVv8h57H6cDstXw7BAwvfMPUZfZW413gLyAfRVr6HEiviGTC16AXY
	 8o2VstFWRBudj5jo1UBhTu3KrHYEX4fYksbex9tDTL5FItxlTPyGzEw0cZmeMJC4PH
	 OPEsDNj7xL3b3SleICmqaUY+F3d/eP/KR2uTrbQ3uWgeH1W71PU76mAKgDJM8uiRT0
	 nPYHZOieXl7VhED/BNRfLRMUge1BJmjMqvqGKtU3vEzUKT4642g5+wCdp1MZrwXb7D
	 K56Kt56H6ZLOg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Nam Cao <namcaov@gmail.com>
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
 bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
 yonghong.song@linux.dev, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
In-Reply-To: <ZOpAjkTtA4jYtuIa@nam-dell>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <87v8d19aun.fsf@all.your.base.are.belong.to.us>
 <ZOpAjkTtA4jYtuIa@nam-dell>
Date: Sun, 27 Aug 2023 10:11:25 +0200
Message-ID: <87cyz8sy4y.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nam,

Nam Cao <namcaov@gmail.com> writes:

> On Sat, Aug 26, 2023 at 03:44:48PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>=20
>> > I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
>> > selftests on bpf-next 9e3b47abeb8f.
>> >
>> > I'm able to reproduce the hang by multiple runs of:
>> >  | ./test_progs -a link_api -a linked_list
>> > I'm currently investigating that.
>>=20
>> +Guo for uprobe
>>=20
>> This was an interesting bug. The hang is an ebreak (RISC-V breakpoint),
>> that puts the kernel into an infinite loop.
>>=20
>> To reproduce, simply run the BPF selftest:
>> ./test_progs -v -a link_api -a linked_list
>>=20
>> First the link_api test is being run, which exercises the uprobe
>> functionality. The link_api test completes, and test_progs will still
>> have the uprobe active/enabled. Next the linked_list test triggered a
>> WARN_ON (which is implemented via ebreak as well).
>>=20
>> Now, handle_break() is entered, and the uprobe_breakpoint_handler()
>> returns true exiting the handle_break(), which returns to the WARN
>> ebreak, and we have merry-go-round.
>>=20
>> Lucky for the RISC-V folks, the BPF memory handler had a WARN that
>> surfaced the bug! ;-)
>
> Thanks for the analysis.
>
> I couldn't reproduce the problem, so I am just taking a guess here. The p=
roblem
> is bebcause uprobes didn't find a probe point at that ebreak instruction.=
 However,
> it also doesn't think a ebreak instruction is there, then it got confused=
 and just
> return back to the ebreak instruction, then everything repeats.
>
> The reason why uprobes didn't think there is a ebreak instruction is beca=
use
> is_trap_insn() only returns true if it is a 32-bit ebreak, or 16-bit c.eb=
reak if
> C extension is available, not both. So a 32-bit ebreak is not correctly r=
ecognized
> as a trap instruction.
>
> If my guess is correct, the following should fix it. Can you please try i=
f it works?
>
> (this is the first time I send a patch this way, so please let me know if=
 you can't apply)
>
> Best regards,
> Nam
>
> ---
>  arch/riscv/kernel/probes/uprobes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probe=
s/uprobes.c
> index 194f166b2cc4..91f4ce101cd1 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -3,6 +3,7 @@
>  #include <linux/highmem.h>
>  #include <linux/ptrace.h>
>  #include <linux/uprobes.h>
> +#include <asm/insn.h>
>=20=20
>  #include "decode-insn.h"
>=20=20
> @@ -17,6 +18,15 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
>  #endif
>  }
>=20=20
> +bool is_trap_insn(uprobe_opcode_t *insn)
> +{
> +#ifdef CONFIG_RISCV_ISA_C
> +	if (riscv_insn_is_c_ebreak(*insn))
> +		return true;
> +#endif
> +	return riscv_insn_is_ebreak(*insn);
> +}
> +
>  unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
>  {
>  	return instruction_pointer(regs);
> --=20
> 2.34.1

The default implementation of is_trap_insn() which RISC-V is using calls
is_swbp_insn(), which is doing what your patch does. Your patch does not
address the issue.

We're taking an ebreak trap from kernel space. In this case we should
never look for a userland (uprobe) handler at all, only the kprobe
handlers should be considered.

In this case, the TIF_UPROBE is incorrectly set, and incorrectly (not)
handled in the "common entry" exit path, which takes us to the infinite
loop.


Bj=C3=B6rn

