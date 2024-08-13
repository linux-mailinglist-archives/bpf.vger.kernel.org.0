Return-Path: <bpf+bounces-36977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461C94FB09
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 03:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC45B281E73
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342DE29B0;
	Tue, 13 Aug 2024 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnxI9lEc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5F79C2
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512228; cv=none; b=GS84fSrH0dYndnk8tCnDOrzHwHiEN+y8Pj+Lb1f7tjzI267GYoWnl/TW+IZrsM3uRtpi/IoX5MWxl0OMBDczQyTTFEl9R2Umg5E9oBYu8XouAQ3PP10+D4DuhdJZ4jA0uJFdeRBGphkGD9ENaQmWNRCrmqChrHAjep3qIH/q03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512228; c=relaxed/simple;
	bh=UJLfGkNw+9r8yDntn/Tqhg96NAhoYeH7aSXVxxEknl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJbMUKjcZJUGqffLgpBEST7olMfEyYHu5rislJy/urCotffJaZ4wGrZEv8Um2uCG+2uR/eTdt5Rgzbzo0M9Lgqb5yDSHtZjI0uMUGpRfUSYwP50bYnoZhRdwB6MB1MLMjv259TVcmakbIW+/pvZg/k18WQRjKWaddHTUhP7xK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnxI9lEc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e1915e18so34292975e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723512225; x=1724117025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYFs5wKeIPsacXeea/5dKhOb6SZTx91b8ExjppX8zzc=;
        b=nnxI9lEcCO4XmVzOCHrkM+UUO5FAALOSzJjvk/J0B2PiNDvLW633c9uz31nE8aqA+q
         xrPQPOGweTd8x5uraIvW7rBNgvIJC8ZbyZ+5gkqf/BrVK+x1u7XKeVL7tFVPc4YNlzLM
         rImEITVwgYV2Wti5whs/HtlCaRvJza+M+HoAYANGD/H1elJs+JKpZMkYKC4QZC3QxayO
         NPHkXel3t+ZJz0IWU66VTghs8mOTXqjvGYLxaqnOXbQgssNn5vMGPPzWrluJjtErE72y
         SYgMxWJq57/1hoaBSUK0CyZWaO70SW01UK1TmOwmILSDxg+QLHg99bjuy71EagSzfMpo
         QHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723512225; x=1724117025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYFs5wKeIPsacXeea/5dKhOb6SZTx91b8ExjppX8zzc=;
        b=v1tYuGfTboKuppBcbUjTzUp7leRMjwV1SO6DXoVBVlxxxjHkqROHwx89d2k3UVlo35
         85a/KVVvrigF9ag3a3xzFTix8EaZVpMuBVJwXb2SK9vFfkssj7rPxINo61iQd5+vud4x
         chTcrRAUInHuhYUOjkLIe7aMEH7X0dwVo+itszbc3TPr16VmH8NgERb7o4cKOVYoacNW
         Vs0n0IpAWpYOujNFRilB1RCAers9s4cEJS63RNag7VIxoW5YC9WI9UrUWI0GoViaYfz+
         cxnjWosF8iCZIwFWvq5IbHNPGhKbHwj9eomxUsV6dqLx9v2tXPdbcr2FiuqIVRAyGLSb
         PzWw==
X-Gm-Message-State: AOJu0Yx74PsRB4H2RYcKDN1SzynjNTxaq60azijt/sMPx3SeYJiHCEXw
	DRsY5hilWXiDzmkT3kxBfp7GHUYhxTLrLBBz1oxIKNXobNG7muJOM1KWO1J/OPPTINCVmMoZB/Z
	19/qkFcinbLBQhiMKTGq6xTzV5L0=
X-Google-Smtp-Source: AGHT+IEQtgZ7xspiImAvbXvir+I7gcPxTJla/2y5puSt7diySdBogZpw/LvgpalYgPQ93PSDHu3xrGpzweByMP2jUNg=
X-Received: by 2002:a05:600c:a45:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-429d481e85amr14818095e9.17.1723512224925; Mon, 12 Aug 2024
 18:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812214847.213612-1-yonghong.song@linux.dev>
In-Reply-To: <20240812214847.213612-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 18:23:33 -0700
Message-ID: <CAADnVQJS2MnWFK7U6HYyBAKEPz9bSt5_SjMW3ixFDuUcS_Az9w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix a kernel verifier crash in stacksafe()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 2:49=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Daniel Hodges reported a kernel verifier crash when playing with sched-ex=
t.
> The crash dump looks like below:
>
>   [   65.874474] BUG: kernel NULL pointer dereference, address: 000000000=
0000088
>   [   65.888406] #PF: supervisor read access in kernel mode
>   [   65.898682] #PF: error_code(0x0000) - not-present page
>   [   65.908957] PGD 0 P4D 0
>   [   65.914020] Oops: 0000 [#1] SMP
>   [   65.920300] CPU: 19 PID: 9364 Comm: scx_layered Kdump: loaded Tainte=
d: G S          E      6.9.5-g93cea04637ea-dirty #7
>   [   65.941874] Hardware name: Quanta Delta Lake MP 29F0EMA01D0/Delta La=
ke-Class1, BIOS F0E_3A19 04/27/2023
>   [   65.960664] RIP: 0010:states_equal+0x3ee/0x770
>   [   65.969559] Code: 33 85 ed 89 e8 41 0f 48 c7 83 e0 f8 89 e9 29 c1 48=
 63 c1 4c 89 e9 48 c1 e1 07 49 8d 14 08 0f
>                  b6 54 10 78 49 03 8a 58 05 00 00 <3a> 54 08 78 0f 85 60 =
03 00 00 49 c1 e5 07 43 8b 44 28 70 83 e0 03
>   [   66.007120] RSP: 0018:ffffc9000ebeb8b8 EFLAGS: 00010202
>   [   66.017570] RAX: 0000000000000000 RBX: ffff888149719680 RCX: 0000000=
000000010
>   [   66.031843] RDX: 0000000000000000 RSI: ffff88907f4e0c08 RDI: ffff888=
1572f0000
>   [   66.046115] RBP: 0000000000000000 R08: ffff8883d5014000 R09: fffffff=
f83065d50
>   [   66.060386] R10: ffff8881bf9a1800 R11: 0000000000000002 R12: 0000000=
000000000
>   [   66.074659] R13: 0000000000000000 R14: ffff888149719a40 R15: 0000000=
000000007
>   [   66.088932] FS:  00007f5d5da96800(0000) GS:ffff88907f4c0000(0000) kn=
lGS:0000000000000000
>   [   66.105114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [   66.116606] CR2: 0000000000000088 CR3: 0000000388261001 CR4: 0000000=
0007706f0
>   [   66.130873] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
>   [   66.145145] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
>   [   66.159416] PKRU: 55555554
>   [   66.164823] Call Trace:
>   [   66.169709]  <TASK>
>   [   66.173906]  ? __die_body+0x66/0xb0
>   [   66.180890]  ? page_fault_oops+0x370/0x3d0
>   [   66.189082]  ? console_unlock+0xb5/0x140
>   [   66.196926]  ? exc_page_fault+0x4f/0xb0
>   [   66.204597]  ? asm_exc_page_fault+0x22/0x30
>   [   66.212974]  ? states_equal+0x3ee/0x770
>   [   66.220643]  ? states_equal+0x529/0x770
>   [   66.228312]  do_check+0x60f/0x5240
>   [   66.235114]  do_check_common+0x388/0x840
>   [   66.242960]  do_check_subprogs+0x101/0x150
>   [   66.251150]  bpf_check+0x5d5/0x4b60
>   [   66.258134]  ? __mod_memcg_state+0x79/0x110
>   [   66.266506]  ? pcpu_alloc+0x892/0xba0
>   [   66.273829]  bpf_prog_load+0x5bb/0x660
>   [   66.281324]  ? bpf_prog_bind_map+0x1e1/0x290
>   [   66.289862]  __sys_bpf+0x29d/0x3a0
>   [   66.296664]  __x64_sys_bpf+0x18/0x20
>   [   66.303811]  do_syscall_64+0x6a/0x140
>   [   66.311133]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

This stack trace doesn't really help to understand the issue.
So I removed it.

> Forther investigation shows that the crash is due to invalid memory acces=
s in stacksafe().

further.

> More specifically, it is the following code:
>
>     if (exact !=3D NOT_EXACT &&
>         old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
>         cur->stack[spi].slot_type[i % BPF_REG_SIZE])
>             return false;
>
> If cur->allocated_stack is 0, cur->stack will be a ZERO_SIZE_PTR. If this=
 happens,
> cur->stack[spi].slot_type[i % BPF_REG_SIZE] will crash the kernel as the =
memory
> address is illegal. This is exactly what happened in the above crash dump=
.
> If cur->allocated_stack is not 0, the above code could trigger array out-=
of-bound
> access.

And reworded this paragraph, since ZERO_SIZE_PTR detail is a distraction.

> The patch added a condition 'i >=3D cur->allocated_stack' such that if
> the condition is true, stacksafe() should fail. Otherwise,
> cur->stack[spi].slot_type[i % BPF_REG_SIZE] memory access is always legal=
.

and reformatted everything to fit 75 char line.

We've been sloppy with commit log line width.
It's better to align to 75 char as the rest of the kernel does.

> Fixes: 2793a8b015f7 ("bpf: exact states comparison for iterator convergen=
ce checks")
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Reported-by: Daniel Hodges <hodgesd@meta.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Applied to bpf tree.

