Return-Path: <bpf+bounces-77453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EADCDFE31
	for <lists+bpf@lfdr.de>; Sat, 27 Dec 2025 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E6423009750
	for <lists+bpf@lfdr.de>; Sat, 27 Dec 2025 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932C246BCD;
	Sat, 27 Dec 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="E1svQRST"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7AD17A300
	for <bpf@vger.kernel.org>; Sat, 27 Dec 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766848224; cv=none; b=nkFGPBiIKVfuu6beqM4OL/KD84bTFOFA+OfJusTD7lFKql1SzDAYX4G/AN7oqezPnxl3NnWTjxWDl3bZuPRRkBkBe6MxmKU6HS0P5iiQ4UxCCeCKvrHrNl9eLKnuHyOjkrAXysOaS7zc+bhn1n3gk/K0I+y689B8DU0zPJ7tvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766848224; c=relaxed/simple;
	bh=L17oew4F2GzE+DDrHbXSpCSi/UvQ+kp9qXKwi7zqQKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ju8sUnm9ZOFK33H4Kz6+FG5XjYJZo0Vcis+kb3RCLsZt5aM3gV+b8lJhPFP+19FMeq80muUcYetzAQi2/v0Za7IX0J/0xqJRaeJp9srkGchrD/nLHBZ+QLiHVrCD3GlTsmibHf08evyJd90J0bkAwSo783UteRcN+cUjguYyed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=E1svQRST; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1766847677; bh=WZ/Ch+BnvS3ybArPnYe8us+TGnqltOahd2uOGg1cVag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=E1svQRSTXMQkwz1r0a2d904C5wqo+te/K/NL8Lo2kWrCimCuiOCyY2hzcF7InRDli
	 QsaQzmoz3EzX2qxyRMIDxV5T9LhgRlmS046Qe69v1DuayGxF/5gwy1izNSeEw5G29v
	 9C81Ah1ae39+n4ZT8Z8Q2hoatkUL68rhqgCXtKra2dOqM4nZ/pjiAjwm/i70mVFXj0
	 LPZ10SHgit0bn/Q2ORv7iA69Gilyz4/8gU5SGTY89v0ip91pdK36dWL61Zc32gmX3D
	 CjrvnShF3wa7aOA9qkOJ45mLR4gzb6gDtMKqUGZGZuBr71FrQLponKHx0olxWml3EO
	 nN01fcibAhSkA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ddlzx04rRz8sZW;
	Sat, 27 Dec 2025 16:01:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a01:e0a:21e:9f90:a64d:7c4b:a6cb:4137
Received: from localhost (unknown [IPv6:2a01:e0a:21e:9f90:a64d:7c4b:a6cb:4137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+sJfSV0cd89ZIME3lSI+maycyXs0E7bRk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ddlzs4rRtz8sbj;
	Sat, 27 Dec 2025 16:01:13 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: bpf <bpf@vger.kernel.org>,  dzm91@hust.edu.cn,  M202472210@hust.edu.cn,
  ast@kernel.org,  daniel@iogearbox.net,  john.fastabend@gmail.com,
  andrii@kernel.org,  martin.lau@linux.dev,  eddyz87@gmail.com,
  song@kernel.org,  yonghong.song@linux.dev,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,
  hust-os-kernel-patches@googlegroups.com
Subject: Re: [BUG] bpf: verifier: False warning for helpers in speculative
 branches
In-Reply-To: <7678017d-b760-4053-a2d8-a6879b0dbeeb@hust.edu.cn> (Yinhao Hu's
	message of "Tue, 23 Dec 2025 19:03:52 +0800")
References: <7678017d-b760-4053-a2d8-a6879b0dbeeb@hust.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 27 Dec 2025 16:01:12 +0100
Message-ID: <874ipcdl53.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yinhao Hu <dddddd@hust.edu.cn> writes:

> Our fuzzer discovered a verifier bug in the BPF subsystem. The warning
> triggers when Spectre mitigation is enabled and a write-performing
> helper call is placed in a speculatively-executed branch.
>
> The BPF verifier assumes `insn_aux->nospec_result` is only set for
> direct memory writes (e.g., `*(u32*)(r1+off) =3D r2`). However, it fails
> to account for helper calls (e.g., `bpf_skb_load_bytes_relative`) that
> perform writes to stack memory.
>
> The problem: `BPF_CALL` instructions have `BPF_CLASS(insn->code) =3D=3D
> BPF_JMP`, which triggers the warning check. The code comment states:
>
> ```c
> /* "This can currently never happen because nospec_result is only
>  *  used for the write-ops `*(size*)(dst_reg+off)=3Dsrc_reg|imm32`
>  *  which must never skip the following insn."
>  */
> ```
>
> However, helper calls break this assumption:
> - Helpers like `bpf_skb_load_bytes_relative` write to stack memory
> - `check_helper_call()` loops through `meta.access_size`, calling
> `check_mem_access(..., BPF_WRITE)`
> - `check_stack_write()` sets `insn_aux->nospec_result =3D 1`
> - Since `BPF_CALL` is encoded as `BPF_JMP | BPF_CALL`, the warning fires

Thank you very much for the report. I think we just have to make the
check more precise as this is a false-positive warning. The nospec after
the helper call should still have the desired effect.

I can check the call graph to make sure there are no other ways
check_stack_write() can be called and send a patch in the new year.

> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> ### Trigger Condition
>
> The warning occurs when both flags are set:
> 1. `state->speculative =3D 1` =E2=80=94 Verifier processes a branch that =
won't
> execute (marked during `check_cond_jmp_op`)
> 2. `insn_aux->nospec_result =3D 1` =E2=80=94 A helper performs stack writ=
es (set
> during `check_helper_call`)
>
> ### Execution Flow
>
> ```
> 1. Drop capabilities =E2=86=92 Enable Spectre mitigation
> 2. Load BPF program
>    =E2=94=94=E2=94=80> do_check()
>        =E2=94=9C=E2=94=80> check_cond_jmp_op() =E2=86=92 Marks dead branc=
h as speculative
>        =E2=94=82   =E2=94=94=E2=94=80> push_stack(..., speculative=3Dtrue)
>        =E2=94=9C=E2=94=80> pop_stack() =E2=86=92 state->speculative =3D 1
>        =E2=94=9C=E2=94=80> check_helper_call() =E2=86=92 Processes helper=
 in dead branch
>        =E2=94=82   =E2=94=94=E2=94=80> check_mem_access(..., BPF_WRITE)
>        =E2=94=82       =E2=94=94=E2=94=80> insn_aux->nospec_result =3D 1
>        =E2=94=94=E2=94=80> Checks: state->speculative && insn_aux->nospec=
_result
>            =E2=94=94=E2=94=80> BPF_CLASS(insn->code) =3D=3D BPF_JMP =E2=
=86=92 WARNING
> ```
>
> ### Warning
>
> ```yaml
> ------------[ cut here ]------------
> verifier bug: speculation barrier after jump instruction may not have
> the desired effect (BPF_CLASS(insn->code) =3D=3D BPF_JMP ||
> BPF_CLASS(insn->code) =3D=3D BPF_JMP32)
> WARNING: CPU: 0 PID: 9956 at kernel/bpf/verifier.c:20536 do_check
> kernel/bpf/verifier.c:20536 [inline]
> WARNING: CPU: 0 PID: 9956 at kernel/bpf/verifier.c:20536
> do_check_common+0xac7b/0xb200 kernel/bpf/verifier.c:23784
> Modules linked in:
> CPU: 0 UID: 0 PID: 9956 Comm: syz-executor206 Not tainted
> 6.18.0-rc4-g93ce3bee311d #3 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> 04/01/2014
> RIP: 0010:do_check kernel/bpf/verifier.c:20536 [inline]
> RIP: 0010:do_check_common+0xac7b/0xb200 kernel/bpf/verifier.c:23784
> Code: 00 e9 2b 84 ff ff e8 f4 ea 4c 00 e9 31 83 ff ff e8 6a 47 e0 ff c6
> 05 b3 8d 6c 0f 01 90 48 c7 c7 c0 ab 76 8b e8 a6 64 9f ff 90 <0f> 0b 90
> 90 e9 96 83 ff ff e8 c7 ea 4c 00 e9 29 89 ff ff e8 1d eb
> RSP: 0018:ffa00000080df5e0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817acafe
> RDX: ff11000108f0ca00 RSI: ffffffff817acb0b RDI: 0000000000000001
> RBP: 0000000000000017 R08: 0000000000000001 R09: ffe21c00142c4841
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ff11000024320000 R15: dffffc0000000000
> FS:  000055558abb53c0(0000) GS:ff1100010ccd0000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000040 CR3: 0000000028fc5000 CR4: 0000000000753ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  do_check_main kernel/bpf/verifier.c:23867 [inline]
>  bpf_check+0x9382/0xb930 kernel/bpf/verifier.c:25174
>  bpf_prog_load+0x17a6/0x2960 kernel/bpf/syscall.c:3095
>  __sys_bpf+0x1971/0x5390 kernel/bpf/syscall.c:6171
>  __do_sys_bpf kernel/bpf/syscall.c:6281 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6279 [inline]
>  __x64_sys_bpf+0x7d/0xc0 kernel/bpf/syscall.c:6279
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcb/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f13824ac64d
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc6d73d488 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ffc6d73d698 RCX: 00007f13824ac64d
> RDX: 0000000000000094 RSI: 0000200000000a00 RDI: 0000000000000005
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc6d73d688 R14: 00007f1382529530 R15: 0000000000000001
>  </TASK>
> ```
>
> ### Proof of Concept
>
> Tested on:
> - Linux next 6.19.0-rc1-next-20251219 (commit
> cc3aa43b44bdb43dfbac0fcb51c56594a11338a8)
> - bpf next (commit ac1c5bc7c4c7e20e2070e6eaa673fc3e11619dbb)
>
> ```c
> #define _GNU_SOURCE
> #include <linux/bpf.h>
> #include <linux/filter.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <unistd.h>
> #include <stdint.h>
>
> int main(void)
> {
>     /* Setup memory for capset (optional for most systems) */
>     syscall(__NR_mmap, 0x200000000000ul, 0x1000000ul, 7, 0x32, -1, 0);
>
>     /* Drop capabilities to enable Spectre mitigation */
>     *(uint32_t*)0x200000000040 =3D 0x20080522;  /*
> _LINUX_CAPABILITY_VERSION_3 */
>     *(uint32_t*)0x200000000044 =3D 0;
>     memset((void*)0x200000000080, 0, 24);
>     syscall(__NR_capset, 0x200000000040ul, 0x200000000080ul);
>
>     /* BPF program: write-performing helper in dead branch */
>     struct bpf_insn prog[] =3D {
>         /* r0 =3D 0 */
>         { .code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg =3D BPF_REG_0,
> .imm =3D 0,},
>         /* if r0 !=3D 1 goto +6 */
>         {.code =3D BPF_JMP | BPF_JNE | BPF_K, .dst_reg =3D BPF_REG_0, .im=
m =3D
> 1, .off =3D 6,},
>         /* R2 =3D offset */
>         {.code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg =3D BPF_REG_2, .=
imm
> =3D 0,},
>         /* R3 =3D R10 - 16 */
>         {.code =3D BPF_ALU64 | BPF_MOV | BPF_X, .dst_reg =3D BPF_REG_3,
> .src_reg =3D BPF_REG_10,},
>         {.code =3D BPF_ALU64 | BPF_ADD | BPF_K, .dst_reg =3D BPF_REG_3, .=
imm
> =3D -16,},
>         /* R4 =3D 4 */
>         {.code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg =3D BPF_REG_4, .=
imm
> =3D 4,},
>         /* R5 =3D flags */
>         {.code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg =3D BPF_REG_5, .=
imm
> =3D 0,},
>         /* call helper 68 */
>         {.code =3D BPF_JMP | BPF_CALL, .imm =3D
> BPF_FUNC_skb_load_bytes_relative,},
>         /* exit */
>         {.code =3D BPF_JMP | BPF_EXIT,},
>     };
>
>     char log_buf[65536] =3D {0};
>     union bpf_attr attr =3D {
>         .prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
>         .insns =3D (uint64_t)prog,
>         .insn_cnt =3D sizeof(prog) / sizeof(prog[0]),
>         .license =3D (uint64_t)"GPL",
>         .log_buf =3D (uint64_t)log_buf,
>         .log_size =3D sizeof(log_buf),
>         .log_level =3D 2,
>     };
>
>     int fd =3D syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
>     if (fd < 0) {
>         perror("bpf");
>         fprintf(stderr, "\nVerifier log:\n%s\n", log_buf);
>         return 1;
>     }
>
>     printf("Loaded (fd=3D%d) =E2=80=94 Check dmesg for WARNING\n", fd);
>     close(fd);
>     return 0;
> }
> ```
>
> [2. text/plain; config-linux-next]...

