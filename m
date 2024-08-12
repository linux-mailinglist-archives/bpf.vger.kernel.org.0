Return-Path: <bpf+bounces-36916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90F94F601
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5A9282B72
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084F188CB0;
	Mon, 12 Aug 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA3kQCsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EC187872
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484710; cv=none; b=iX45T0D8XOPyIIz9ICiSQsp6YVat/lUP9IXV+yquLP9UsTCzKamaA4X1sIKBLwXJvl6CZqUdmNjCkH1UHpwpW0T7B4dXTivvdNO47HlfjePWFBdEOyfi4WvdVHHuqDZMCj0ZPm0T9PPMCQN+auPxI9QJP/Ib0Q4cg5vA+zRChm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484710; c=relaxed/simple;
	bh=+m2ZkJts+OeHXLgZZfG4rF+u6VNZPOIxNDS0xPhBEJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8CtZYjER9KotmKdx4aaRYjpmOB4ou7NL/oqpXpI8rakciPzoZAlH85eC/PR7pQaFAvEhiyifdjzac5RKHd8XSFIKksL/6M8whNlayQAHhSBqX7vhbLL/Xd3P6MOXqzhs+bUDVmj4lnNBNt4y3dHRd02BaD+9QeJvx9cUcV8Db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA3kQCsV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3685b9c8998so2245750f8f.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723484707; x=1724089507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGZGolVus7tjVq3GBR1AQ5rup81fffPA82y/5B0rK6g=;
        b=lA3kQCsV264qQCihthNaaLyLdMNTxqEfWmSxQaKK30s+H0edRNdNdRY40TiMoQhfvL
         X65Mdy36jkTLa7OsAYjY+UEB/Kg9ONGRdAltSk6Ck5J1nJx9Xr7sxN6oHr4zhTdeWKbs
         +GWaP/6ObEQjILdvuiTrQ74Tvwd7IOPrCp7MWCG47qORoBTMvt2vAkFR2wGWxCbs2l+t
         YHcF4MipwIFbM26Fp0fnvyJe67y7vYVuHViRc9fe/BSFsJckPadle3W2Swvi9pwli+MK
         9nzo4e4VmR9tsJMzdAVpBnP2dmGYfDNcHPR938xcFBnqOilFg4nLIktWIJQ4MCpDEqds
         ExVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484707; x=1724089507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGZGolVus7tjVq3GBR1AQ5rup81fffPA82y/5B0rK6g=;
        b=KAdNOglAWm0uJJwnLGH7oM5Y2Vfz93++dSFOlfZdwNckgso2WAMXWK41gHt1x2r6BK
         wLb9exGsgOnyC/rlhxbf34NrjvWuHy8grVYQY1hKz3oyhzB91UgDinkB4w1k796mrKXE
         yWQedVE4AIEUIQH/1Smrr34XtNocJjRd+IfPNfrxRGqFDPWtSrm2tm94WCPvCAa84U8A
         UHEsz7tckUlh4ciOYjvm8ggibnK1XgbPSmmycy+KV/N+tXLmFX7XQgqut6rIgrVzX2Z6
         2JXDQ+jjyR1cfIUZDSWke93pTQjqqpJXlDJhmlt/MlAydlsywdW/R0tzuFNLJUAwBCO+
         a15Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4Rilh/2Mq70r226el/BEUvK/pTTpQSeAML2cuujpHcXYOwWUd7q3V6/cNe3DZC3Jw9tly+VEopBMJgkptTnNnMJxY
X-Gm-Message-State: AOJu0Yyi7V9QfItU2InoWtqULsXVJ4wTayJASubolMu/M5OyBJ5aV3cL
	sN/dVKUt/PxNF/h7d6uKJyNdqtfVzIA3+aJLujoXkI2FW8ybXeZqlEyoi1fZ2muy0Nabp8bqmMm
	5OWJ+FPeYM0P306HSqBA3Ovwhbhee0gyZ
X-Google-Smtp-Source: AGHT+IHn1PCURZooFlEDLUwdNQNwhkF/6Y9aA2y0vef3ucCSUE9rNLm7KzmydaO2tqhiMbKDtDQ43uwQtsCIymlqvPU=
X-Received: by 2002:a05:6000:1f88:b0:368:3731:1613 with SMTP id
 ffacd0b85a97d-3716ccdc9f7mr964656f8f.13.1723484706858; Mon, 12 Aug 2024
 10:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812052106.3980303-1-yonghong.song@linux.dev> <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
In-Reply-To: <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 10:44:55 -0700
Message-ID: <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:38=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Sun, 2024-08-11 at 22:21 -0700, Yonghong Song wrote:
> > Daniel Hodges reported a kernel verifier crash when playing with sched-=
ext.
> > The crash dump looks like below:
> >
> >   [   65.874474] BUG: kernel NULL pointer dereference, address: 0000000=
000000088
> >   [   65.888406] #PF: supervisor read access in kernel mode
> >   [   65.898682] #PF: error_code(0x0000) - not-present page
> >   [   65.908957] PGD 0 P4D 0
> >   [   65.914020] Oops: 0000 [#1] SMP
> >   [   65.920300] CPU: 19 PID: 9364 Comm: scx_layered Kdump: loaded Tain=
ted: G S          E      6.9.5-g93cea04637ea-dirty #7
> >   [   65.941874] Hardware name: Quanta Delta Lake MP 29F0EMA01D0/Delta =
Lake-Class1, BIOS F0E_3A19 04/27/2023
> >   [   65.960664] RIP: 0010:states_equal+0x3ee/0x770
> >   [   65.969559] Code: 33 85 ed 89 e8 41 0f 48 c7 83 e0 f8 89 e9 29 c1 =
48 63 c1 4c 89 e9 48 c1 e1 07 49 8d 14 08 0f
> >                  b6 54 10 78 49 03 8a 58 05 00 00 <3a> 54 08 78 0f 85 6=
0 03 00 00 49 c1 e5 07 43 8b 44 28 70 83 e0 03
> >   [   66.007120] RSP: 0018:ffffc9000ebeb8b8 EFLAGS: 00010202
> >   [   66.017570] RAX: 0000000000000000 RBX: ffff888149719680 RCX: 00000=
00000000010
> >   [   66.031843] RDX: 0000000000000000 RSI: ffff88907f4e0c08 RDI: ffff8=
881572f0000
> >   [   66.046115] RBP: 0000000000000000 R08: ffff8883d5014000 R09: fffff=
fff83065d50
> >   [   66.060386] R10: ffff8881bf9a1800 R11: 0000000000000002 R12: 00000=
00000000000
> >   [   66.074659] R13: 0000000000000000 R14: ffff888149719a40 R15: 00000=
00000000007
> >   [   66.088932] FS:  00007f5d5da96800(0000) GS:ffff88907f4c0000(0000) =
knlGS:0000000000000000
> >   [   66.105114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [   66.116606] CR2: 0000000000000088 CR3: 0000000388261001 CR4: 00000=
000007706f0
> >   [   66.130873] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> >   [   66.145145] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> >   [   66.159416] PKRU: 55555554
> >   [   66.164823] Call Trace:
> >   [   66.169709]  <TASK>
> >   [   66.173906]  ? __die_body+0x66/0xb0
> >   [   66.180890]  ? page_fault_oops+0x370/0x3d0
> >   [   66.189082]  ? console_unlock+0xb5/0x140
> >   [   66.196926]  ? exc_page_fault+0x4f/0xb0
> >   [   66.204597]  ? asm_exc_page_fault+0x22/0x30
> >   [   66.212974]  ? states_equal+0x3ee/0x770
> >   [   66.220643]  ? states_equal+0x529/0x770
> >   [   66.228312]  do_check+0x60f/0x5240
> >   [   66.235114]  do_check_common+0x388/0x840
> >   [   66.242960]  do_check_subprogs+0x101/0x150
> >   [   66.251150]  bpf_check+0x5d5/0x4b60
> >   [   66.258134]  ? __mod_memcg_state+0x79/0x110
> >   [   66.266506]  ? pcpu_alloc+0x892/0xba0
> >   [   66.273829]  bpf_prog_load+0x5bb/0x660
> >   [   66.281324]  ? bpf_prog_bind_map+0x1e1/0x290
> >   [   66.289862]  __sys_bpf+0x29d/0x3a0
> >   [   66.296664]  __x64_sys_bpf+0x18/0x20
> >   [   66.303811]  do_syscall_64+0x6a/0x140
> >   [   66.311133]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >
> > Forther investigation shows that the crash is due to invalid memory acc=
ess in stacksafe().
> > More specifically, it is the following code:
> >
> >     if (exact !=3D NOT_EXACT &&
> >         old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
> >         cur->stack[spi].slot_type[i % BPF_REG_SIZE])
> >             return false;
> >
> > If cur->allocated_stack is 0, cur->stack will be a ZERO_SIZE_PTR. If th=
is happens,
> > cur->stack[spi].slot_type[i % BPF_REG_SIZE] will crash the kernel as th=
e memory
> > address is illegal. This is exactly what happened in the above crash du=
mp.
> > If cur->allocated_stack is not 0, the above code could trigger array ou=
t-of-bound
> > access.
> >
> > The patch added a condition 'i < cur->allocated_stack' to ensure
> > cur->stack[spi].slot_type[i % BPF_REG_SIZE] memory access always legal.
> >
> > Fixes: 2793a8b015f7 ("bpf: exact states comparison for iterator converg=
ence checks")
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Reported-by: Daniel Hodges <hodgesd@meta.com>
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
>
> My bad, for some reason I thought that 'if (i >=3D cur->allocated_stack) =
return false;'
> check below would be sufficient. (Which is obviously not true, sigh...).
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Should we move the check up instead?

if (i >=3D cur->allocated_stack)
          return false;

Checking it twice looks odd.

