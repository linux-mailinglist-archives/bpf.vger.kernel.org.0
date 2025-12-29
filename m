Return-Path: <bpf+bounces-77476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7901CE8021
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 684B130245F2
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70982874FF;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw2tHTrY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB0257828
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035467; cv=none; b=h0oVpLyw1JlOgDDP/GALgfZitB8q8RfoNMFqSRMe60yKH+0cNQ2ztMVB18lsvOOi269T84jlRMXfsrX5daASK/pjCFtQbQEjeAXKupepB1jBhbJhS+GOCiYnpY974Qt8Y2FU9GO8HI24S+sdPxsA4vNnTO8lpL4x2r9AINy4pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035467; c=relaxed/simple;
	bh=5emx6InSRAO8f8gOELQsjTytzVZtQhbi+7UIVYpwZBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kljke5STja7Uq/B4tei21K8ipldDERPaIQ2V6VEAioTHAQaN444r+jSIQPhvh2kCP48LIibo1eKGYowsPykewT7vizuKPh/phRvuAK01z2DLHmSUk9u+rZogIwxtcB3uzCTHbDlKLQhao8RaKiW527Z8OuHCrNQpTyTzzycR/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw2tHTrY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7baf61be569so9681123b3a.3
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767035465; x=1767640265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2AZ9m7h1UPWuF2rcZ+hzHCkQjCYWEBt8UfyYAn7WS8M=;
        b=jw2tHTrYWFkjWAXZPHzDTEOdK+KFK96/kApMjjysdKSYa926bFO/sQFs87/MUYtVHy
         Zj8z3UJxGcMdkNsUdV3ZRpQtdwjJ3TKTtUiY/h/t3o7z6jJW1kLzDEvVfxqGjjBwqOmM
         pWsVegQA0eCzJ46Epz7oCqDusHg3dM6EWS3/eBdArSRQPuGXCk44GF0VXhXjFCW4ftgW
         MO1IrQyDeN/Wp2YKI58ijnGH8WOS21+Te1VvSyK8Un0QCW8w6MhvCxAtLQOx/HqFOKR3
         x5MuExD/7Bj+sp4qJI7wukk3J4JFV8P0ZV/937gmrWa5vhxsJe37pDHwAvHMFWhdjccx
         x/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767035465; x=1767640265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AZ9m7h1UPWuF2rcZ+hzHCkQjCYWEBt8UfyYAn7WS8M=;
        b=pfx0SFgEZD5x2+Z9CxQnZ2ahHlsjZkZ4FgG5toRQQGLJX3est/85Zj61LCDVa+L/sB
         8BmkTxIvrZNTmMUNVfuXR/iw1iLxLJfrNi5tm2k1UPamRH6WBjHpyJFXNVGMS3OKNeUM
         15+VMzIUpgTHHzKfQ+wsEM8An9oFjWuL7U7jZUyPPGDHNRapS04vPjz62vvMoHA8j492
         dZ0CMhkVFGVKOHbLOEML+fkSD7G0n4sDKSToVzzonV/GsUVqr+71h2ZRmXnsbqG4vjke
         BbBc77r8nMbpYAocv6U7V76anZj6/1m7k9iqTUJhAB2MF2p9PK4EWRshM/OhpHRpUMfj
         YJrA==
X-Gm-Message-State: AOJu0YyTjMf/qysfnhbiy8VPX9/LDVjj8C1BznH6ZcFdFOAgfgR4QQTx
	kFsmPXXwI76DsFOlmhJrBPGH+2lH03mebNeJcKAqTSzt4ID89YaStdYs
X-Gm-Gg: AY/fxX5FpdOf2SR5Jt/lVPLIRVFBBAFswkXh/DZsp//j82sA54se/3E33Y1TGsKDE1Q
	UPEwfrgBSSEu9B865rw03ZDdiktKzqWvxcJEps/MGHPyD6RO+XcKuXg+e6mpOPPdhN0GjAQQu7A
	Y/dHt1TC26mGUEvwGmilxq+ACw9/7rfmkPFEyT6qwowcJPsspSG6z+trRB73VAaMOsFXmeqgDh4
	4wYMtLRF4QQP+GDGpOI03su+Ik0S+QkauK7YzoPyHoA6M2/FFVnJhvgbeuuqrVSN/KA1zSwosGI
	x9xkCSUiC2iIHgdtKz2m2PGglSqeF40uJKFuJwCcV+bk0VIrR2pYruEzH7vNjlYmYL6PBu+KzA5
	nxw98kvXnafYmWySKuU9nsqb3BFAVUbbpXvONns6mh1iNy2kxNr+w8RkKKv61J2bgzf/hQyBKvP
	ULyOB3fARiCKH3lsJpqsgg8bJOXkccaPqClyyf
X-Google-Smtp-Source: AGHT+IFE5Zzq/vfliYaRi/lpF0noUrhUE1p7c4vrfJfPl2Ufc9wBXip7pqpUW5++ViMqP8i2727CXw==
X-Received: by 2002:a05:6a00:2992:b0:7e8:4471:ae70 with SMTP id d2e1a72fcca58-7ff6804a92dmr25812452b3a.60.1767035464526;
        Mon, 29 Dec 2025 11:11:04 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac6b:d5ad:83fe:6cca? ([2620:10d:c090:500::2:1bc9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab841sm30135480b3a.35.2025.12.29.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 11:11:04 -0800 (PST)
Message-ID: <627164f397958b30454fa388a20c452eab44ffd8.camel@gmail.com>
Subject: Re: [BUG] bpf: verifier: False warning for helpers in speculative
 branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Yinhao Hu <dddddd@hust.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, dzm91@hust.edu.cn, M202472210@hust.edu.cn, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, 	martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, 	sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 
	hust-os-kernel-patches@googlegroups.com
Date: Mon, 29 Dec 2025 11:11:01 -0800
In-Reply-To: <874ipcdl53.fsf@fau.de>
References: <7678017d-b760-4053-a2d8-a6879b0dbeeb@hust.edu.cn>
	 <874ipcdl53.fsf@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-27 at 16:01 +0100, Luis Gerhorst wrote:
> Yinhao Hu <dddddd@hust.edu.cn> writes:
>=20
> > Our fuzzer discovered a verifier bug in the BPF subsystem. The warning
> > triggers when Spectre mitigation is enabled and a write-performing
> > helper call is placed in a speculatively-executed branch.
> >=20
> > The BPF verifier assumes `insn_aux->nospec_result` is only set for
> > direct memory writes (e.g., `*(u32*)(r1+off) =3D r2`). However, it fail=
s
> > to account for helper calls (e.g., `bpf_skb_load_bytes_relative`) that
> > perform writes to stack memory.
> >=20
> > The problem: `BPF_CALL` instructions have `BPF_CLASS(insn->code) =3D=3D
> > BPF_JMP`, which triggers the warning check. The code comment states:
> >=20
> > ```c
> > /* "This can currently never happen because nospec_result is only
> >  *  used for the write-ops `*(size*)(dst_reg+off)=3Dsrc_reg|imm32`
> >  *  which must never skip the following insn."
> >  */
> > ```
> >=20
> > However, helper calls break this assumption:
> > - Helpers like `bpf_skb_load_bytes_relative` write to stack memory
> > - `check_helper_call()` loops through `meta.access_size`, calling
> > `check_mem_access(..., BPF_WRITE)`
> > - `check_stack_write()` sets `insn_aux->nospec_result =3D 1`
> > - Since `BPF_CALL` is encoded as `BPF_JMP | BPF_CALL`, the warning fire=
s
>=20
> Thank you very much for the report. I think we just have to make the
> check more precise as this is a false-positive warning. The nospec after
> the helper call should still have the desired effect.
>=20
> I can check the call graph to make sure there are no other ways
> check_stack_write() can be called and send a patch in the new year.

Fixing it this way makes sense to me.
Beside matching exact opcode, another option might be checking the
result of the bpf_insn_successors() call to see if there are multiple
successors. (But please measure on some selftest if that is not too
expensive).

> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> >=20
> > ### Trigger Condition
> >=20
> > The warning occurs when both flags are set:
> > 1. `state->speculative =3D 1` =E2=80=94 Verifier processes a branch tha=
t won't
> > execute (marked during `check_cond_jmp_op`)
> > 2. `insn_aux->nospec_result =3D 1` =E2=80=94 A helper performs stack wr=
ites (set
> > during `check_helper_call`)
> >=20
> > ### Execution Flow
> >=20
> > ```
> > 1. Drop capabilities =E2=86=92 Enable Spectre mitigation
> > 2. Load BPF program
> >    =E2=94=94=E2=94=80> do_check()
> >        =E2=94=9C=E2=94=80> check_cond_jmp_op() =E2=86=92 Marks dead bra=
nch as speculative
> >        =E2=94=82   =E2=94=94=E2=94=80> push_stack(..., speculative=3Dtr=
ue)
> >        =E2=94=9C=E2=94=80> pop_stack() =E2=86=92 state->speculative =3D=
 1
> >        =E2=94=9C=E2=94=80> check_helper_call() =E2=86=92 Processes help=
er in dead branch
> >        =E2=94=82   =E2=94=94=E2=94=80> check_mem_access(..., BPF_WRITE)
> >        =E2=94=82       =E2=94=94=E2=94=80> insn_aux->nospec_result =3D =
1
> >        =E2=94=94=E2=94=80> Checks: state->speculative && insn_aux->nosp=
ec_result
> >            =E2=94=94=E2=94=80> BPF_CLASS(insn->code) =3D=3D BPF_JMP =E2=
=86=92 WARNING
> > ```
> >=20
> > ### Warning
> >=20
> > ```yaml
> > ------------[ cut here ]------------
> > verifier bug: speculation barrier after jump instruction may not have
> > the desired effect (BPF_CLASS(insn->code) =3D=3D BPF_JMP ||
> > BPF_CLASS(insn->code) =3D=3D BPF_JMP32)
> > WARNING: CPU: 0 PID: 9956 at kernel/bpf/verifier.c:20536 do_check
> > kernel/bpf/verifier.c:20536 [inline]
> > WARNING: CPU: 0 PID: 9956 at kernel/bpf/verifier.c:20536
> > do_check_common+0xac7b/0xb200 kernel/bpf/verifier.c:23784
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 9956 Comm: syz-executor206 Not tainted
> > 6.18.0-rc4-g93ce3bee311d #3 PREEMPT(full)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> > 04/01/2014
> > RIP: 0010:do_check kernel/bpf/verifier.c:20536 [inline]
> > RIP: 0010:do_check_common+0xac7b/0xb200 kernel/bpf/verifier.c:23784
> > Code: 00 e9 2b 84 ff ff e8 f4 ea 4c 00 e9 31 83 ff ff e8 6a 47 e0 ff c6
> > 05 b3 8d 6c 0f 01 90 48 c7 c7 c0 ab 76 8b e8 a6 64 9f ff 90 <0f> 0b 90
> > 90 e9 96 83 ff ff e8 c7 ea 4c 00 e9 29 89 ff ff e8 1d eb
> > RSP: 0018:ffa00000080df5e0 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817acafe
> > RDX: ff11000108f0ca00 RSI: ffffffff817acb0b RDI: 0000000000000001
> > RBP: 0000000000000017 R08: 0000000000000001 R09: ffe21c00142c4841
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: ff11000024320000 R15: dffffc0000000000
> > FS:  000055558abb53c0(0000) GS:ff1100010ccd0000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000200000000040 CR3: 0000000028fc5000 CR4: 0000000000753ef0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  do_check_main kernel/bpf/verifier.c:23867 [inline]
> >  bpf_check+0x9382/0xb930 kernel/bpf/verifier.c:25174
> >  bpf_prog_load+0x17a6/0x2960 kernel/bpf/syscall.c:3095
> >  __sys_bpf+0x1971/0x5390 kernel/bpf/syscall.c:6171
> >  __do_sys_bpf kernel/bpf/syscall.c:6281 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:6279 [inline]
> >  __x64_sys_bpf+0x7d/0xc0 kernel/bpf/syscall.c:6279
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xcb/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f13824ac64d
> > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89
> > f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> > f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffc6d73d488 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 00007ffc6d73d698 RCX: 00007f13824ac64d
> > RDX: 0000000000000094 RSI: 0000200000000a00 RDI: 0000000000000005
> > RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffc6d73d688 R14: 00007f1382529530 R15: 0000000000000001
> >  </TASK>
> > ```
> >=20
> > ### Proof of Concept
> >=20
> > Tested on:
> > - Linux next 6.19.0-rc1-next-20251219 (commit
> > cc3aa43b44bdb43dfbac0fcb51c56594a11338a8)
> > - bpf next (commit ac1c5bc7c4c7e20e2070e6eaa673fc3e11619dbb)
> >=20
> > ```c
> > #define _GNU_SOURCE
> > #include <linux/bpf.h>
> > #include <linux/filter.h>
> > #include <stdio.h>
> > #include <string.h>
> > #include <sys/syscall.h>
> > #include <unistd.h>
> > #include <stdint.h>
> >=20
> > int main(void)
> > {
> >     /* Setup memory for capset (optional for most systems) */
> >     syscall(__NR_mmap, 0x200000000000ul, 0x1000000ul, 7, 0x32, -1, 0);
> >=20
> >     /* Drop capabilities to enable Spectre mitigation */
> >     *(uint32_t*)0x200000000040 =3D 0x20080522;  /*
> > _LINUX_CAPABILITY_VERSION_3 */
> >     *(uint32_t*)0x200000000044 =3D 0;
> >     memset((void*)0x200000000080, 0, 24);
> >     syscall(__NR_capset, 0x200000000040ul, 0x200000000080ul);
> >=20
> >     /* BPF program: write-performing helper in dead branch */
> >     struct bpf_insn prog[] =3D {
> >         /* r0 =3D 0 */
> >         { .code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg =3D BPF_REG_0=
,
> > .imm =3D 0,},
> >         /* if r0 !=3D 1 goto +6 */
> >         {.code =3D BPF_JMP | BPF_JNE | BPF_K, .dst_reg =3D BPF_REG_0, .=
imm =3D
> > 1, .off =3D 6,},
> >         /* R2 =3D offset */
> >         {.code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg =3D BPF_REG_2,=
 .imm
> > =3D 0,},
> >         /* R3 =3D R10 - 16 */
> >         {.code =3D BPF_ALU64 | BPF_MOV | BPF_X, .dst_reg =3D BPF_REG_3,
> > .src_reg =3D BPF_REG_10,},
> >         {.code =3D BPF_ALU64 | BPF_ADD | BPF_K, .dst_reg =3D BPF_REG_3,=
 .imm
> > =3D -16,},
> >         /* R4 =3D 4 */
> >         {.code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg =3D BPF_REG_4,=
 .imm
> > =3D 4,},
> >         /* R5 =3D flags */
> >         {.code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg =3D BPF_REG_5,=
 .imm
> > =3D 0,},
> >         /* call helper 68 */
> >         {.code =3D BPF_JMP | BPF_CALL, .imm =3D
> > BPF_FUNC_skb_load_bytes_relative,},
> >         /* exit */
> >         {.code =3D BPF_JMP | BPF_EXIT,},
> >     };
> >=20
> >     char log_buf[65536] =3D {0};
> >     union bpf_attr attr =3D {
> >         .prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
> >         .insns =3D (uint64_t)prog,
> >         .insn_cnt =3D sizeof(prog) / sizeof(prog[0]),
> >         .license =3D (uint64_t)"GPL",
> >         .log_buf =3D (uint64_t)log_buf,
> >         .log_size =3D sizeof(log_buf),
> >         .log_level =3D 2,
> >     };
> >=20
> >     int fd =3D syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> >     if (fd < 0) {
> >         perror("bpf");
> >         fprintf(stderr, "\nVerifier log:\n%s\n", log_buf);
> >         return 1;
> >     }
> >=20
> >     printf("Loaded (fd=3D%d) =E2=80=94 Check dmesg for WARNING\n", fd);
> >     close(fd);
> >     return 0;
> > }
> > ```
> >=20
> > [2. text/plain; config-linux-next]...

