Return-Path: <bpf+bounces-77503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1EDCE8D80
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 08:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81FA3015867
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC762FDC37;
	Tue, 30 Dec 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvKP1nYc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935D2FDC26
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767077534; cv=none; b=et/tfOqIjoKE86FlP+/CWZCa4H2pXMwlopSQpL0mgfrsybxNv8vOXVemPdCBXa4QrmYg4gXRNvqnukEm9ugHRmhymp9HZVEqpQYfTlMAAaZpnqSy1dLi5AUBHgckIHA1H0WYXioNkiIP/N7s0x0OMZAHLsr8+xlTCaVELpjnOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767077534; c=relaxed/simple;
	bh=r36mY7/Ys8InSAZAijap1nJetdcGUHHqspG5cX6FUOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pixvnHA9ts2OR8g2oSPWWqjGCMPQQJBf5H5wwqeTvEiy7f7mVi8fZEpOnSU7eKgqIWDCU4AyJfXyF7SSKuy/FieZl/DWz0rtYNs9mlzy9UHSgs83y8h/f3CXAfjYyX4bR+2INoIGfBFObG2v32i4qKyLKl0eBi84Vtw9PCnMw+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvKP1nYc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29efd139227so128292205ad.1
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 22:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767077532; x=1767682332; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6U9rLwZNIYS9DVA5ViRqLHmiyAVD8oKnKmSgx7+9CoU=;
        b=ZvKP1nYcAly1zG6g5VYoUsqa2hUglnvvOa20Mh6yrb7DYTHHxvsgNsbg8Br0iDkpiC
         oFweZcIJ3ApZZ5Eki7xHZTnScyq79z3REdXDad4jDo5uhSqfSV4c5MHyud2ckdCIIfpR
         YOZ3S8UGJHp0Q8ZNNz0BJ5URyPnTH0lpKOj0dAJNCKOlOtHtLxfJifxy8yEeWbH6iVaZ
         IAXAYehn0WoPX2eQ+SdevsrZyGFcurVy9DDX9gUVDodqTaQcgwsa/XTdUYFwZIwQelRJ
         QmJXroOQp94dS+u9BgYECbZLKrpf8TlKYEJfsP2XtFUUyVR7sxog2nDzPTUngm7LjM1c
         mV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767077532; x=1767682332;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6U9rLwZNIYS9DVA5ViRqLHmiyAVD8oKnKmSgx7+9CoU=;
        b=cx03WRKHs2d2JH/uSjkN5yumUx16Z1G+yKXzcPqM2+v8rMnC1ESNzWtvHu4k7cQDtq
         c0DRISAb18pqHWg2AeCBvbF1+n3VGQZ9st/kgcxCKr9xSbkohCop5pjldKY8Hx7pEuUK
         8iQHGfCZppwao1RINUFin3nZgJmimwEaThwPPSXGIslbo2v0HkmMA5cil2giOdNhJJ5X
         BVovoetHi1FZqTnY1d5BWlxRQLPlYAD1umTT6LC5NA5Ngbtc26uNyPeEx9XWpDqtM/vj
         Y7M+oQti33mRE+4lQ4cE+li6S57ZyL86T3/o9BSSBFsxbu/JnVzvnnh1zNQVaiSngiBu
         Shxg==
X-Forwarded-Encrypted: i=1; AJvYcCXfV19tvutnm2QImWRgDFhR/rpx/NMdsLDeTDdcWct3OVL+vwZIcfNQ93crOqkZhDuDLT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hylGHClAuBq67yNNwt8nAXC2QSxQA/0scvVH+DcnUV8Kop4v
	8ff6ynFseFpTDQiD2Tp56xLp2d2IrwwbkApkrr+jOGR8LekRyZpOQGGh
X-Gm-Gg: AY/fxX7atOWexLBZgMujSGSk/nM5zjAYybs+ymhnO4QgP8JrUL6sRrURSmJkiBw7Ej8
	1Dy2ujqoUXRR2HgDcpERhmcTHhBKlp5GVd1xWDCrmyHQmyU5EGdNmBN4jnz1zCMwq7mQ0GrHbVu
	Ae3vPw9lS0mndavYPjjRpPJh/sbIrtU1RQEb6wZvgCHvjT3D6YP+jr8GovTyY2CQfUrM9ulNBBY
	0ZnAO3b+WH8exOFvEdCJbIDn/leq4/cLhhExVI8K+tS/82whL3NoYukK6va+ksCo4IR741eHbqM
	6qx7bfBJSqoomQp25WmVptdXeQf/PziYwW3TKsxnb8+O38JPmVaM0zcJBx/d5C/0ENHHuZTiAYo
	31SXKLK4j2AEiLAx2PyBT3/FPAZ9HqGhsdeBc9kfGaPVy6HNTpUUOxmAOALRyFdJxaN8bV+IOZ7
	4ZMicglY8V
X-Google-Smtp-Source: AGHT+IE7BtGrFnYI1+11/OPd3n1RonH59q1b/ieOCO6kQiGVmtM2/imlmpBdRIen73GP9K9gq8nVrw==
X-Received: by 2002:a17:903:41cd:b0:298:55c8:eb8d with SMTP id d9443c01a7336-2a2f272bd8fmr294469855ad.35.1767077532151;
        Mon, 29 Dec 2025 22:52:12 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d20dsm291184545ad.67.2025.12.29.22.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 22:52:11 -0800 (PST)
Message-ID: <e3c26c7c9a74240b1fad2237ea0b4e205f3c1f0d.camel@gmail.com>
Subject: Re: [QUESTION] KASAN: invalid-access in
 bpf_patch_insn_data+0x22c/0x2f0
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jeongho Choi <jh1012.choi@samsung.com>, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Cc: joonki.min@samsung.com, hajun.sung@samsung.com
Date: Mon, 29 Dec 2025 22:52:08 -0800
In-Reply-To: <20251229110431.GA2243991@tiffany>
References: 
	<CGME20251229105858epcas2p26c433715e7955d20072e72964e83c3e7@epcas2p2.samsung.com>
	 <20251229110431.GA2243991@tiffany>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-29 at 20:05 +0900, Jeongho Choi wrote:
> Hello
> I'm jeongho Choi from samsung System LSI.
> I'm developing kernel BSP for exynos SoC.
>=20
> I'm asking a question because I've recently been experiencing=20
> issues after enable SW KASAN in Android17 kernel 6.18 environment.

Hi Jeongho,

I'd like to reproduce this locally, is this particular kernel version
open source? Could you please post a link to git repository and a
commit hash you see the error at?
Is the BPF program being loaded open source?

(Also, could you please post the output of
 scripts/decode_stacktrace.sh for the stack trace you attached?).

> Context:
>  - Kernel version: v6.18
>  - Architecture: ARM64
>=20
> Question:
> When SW tag KASAN is enabled, we got kernel crash from bpf/verifier.
> I found that it occurred only from 6.18, not 6.12 LTS we're working on.

I don't think that commit "bpf: use realloc in bpf_patch_insn_data"
had been backported to 6.12, it is a performance optimization,
not a security fix.

Thanks,
Eduard

> After some tests, I found that the device is booted when 2 commits are re=
verted.
>=20
> bpf: potential double-free of env->insn_aux_data
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Db13448dd64e27752fad252cec7da1a50ab9f0b6f
>=20
> bpf: use realloc in bpf_patch_insn_data
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D77620d1267392b1a34bfc437d2adea3006f95865
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   79.419177] [4:     netbpfload:  825] BUG: KASAN: invalid-access in bp=
f_patch_insn_data+0x22c/0x2f0
> [   79.419415] [4:     netbpfload:  825] Write of size 27896 at addr 25ff=
ffc08e6314d0 by task netbpfload/825
> [   79.419984] [4:     netbpfload:  825] Pointer tag: [25], memory tag: [=
fa]
> [   79.425193] [4:     netbpfload:  825]=20
> [   79.427365] [4:     netbpfload:  825] CPU: 4 UID: 0 PID: 825 Comm: net=
bpfload Tainted: G           OE       6.18.0-rc6-android17-0-gd28deb424356-=
4k #1 PREEMPT  92293e52a7788dc6ec1b9dff6625aaee925f3475
> [   79.427374] [4:     netbpfload:  825] Tainted: [O]=3DOOT_MODULE, [E]=
=3DUNSIGNED_MODULE
> [   79.427378] [4:     netbpfload:  825] Hardware name: Samsung ERD9965 b=
oard based on S5E9965 (DT)
> [   79.427382] [4:     netbpfload:  825] Call trace:
> [   79.427385] [4:     netbpfload:  825]  show_stack+0x18/0x28 (C)
> [   79.427394] [4:     netbpfload:  825]  __dump_stack+0x28/0x3c
> [   79.427401] [4:     netbpfload:  825]  dump_stack_lvl+0x7c/0xa8
> [   79.427407] [4:     netbpfload:  825]  print_address_description+0x7c/=
0x20c
> [   79.427414] [4:     netbpfload:  825]  print_report+0x70/0x8c
> [   79.427421] [4:     netbpfload:  825]  kasan_report+0xb4/0x114
> [   79.427427] [4:     netbpfload:  825]  kasan_check_range+0x94/0xa0
> [   79.427432] [4:     netbpfload:  825]  __asan_memmove+0x54/0x88
> [   79.427437] [4:     netbpfload:  825]  bpf_patch_insn_data+0x22c/0x2f0
> [   79.427442] [4:     netbpfload:  825]  bpf_check+0x2b44/0x8c34
> [   79.427449] [4:     netbpfload:  825]  bpf_prog_load+0x8dc/0x990
> [   79.427453] [4:     netbpfload:  825]  __sys_bpf+0x300/0x4c8
> [   79.427458] [4:     netbpfload:  825]  __arm64_sys_bpf+0x48/0x64
> [   79.427465] [4:     netbpfload:  825]  invoke_syscall+0x6c/0x13c
> [   79.427471] [4:     netbpfload:  825]  el0_svc_common+0xf8/0x138
> [   79.427478] [4:     netbpfload:  825]  do_el0_svc+0x30/0x40
> [   79.427484] [4:     netbpfload:  825]  el0_svc+0x38/0x8c
> [   79.427491] [4:     netbpfload:  825]  el0t_64_sync_handler+0x68/0xdc
> [   79.427497] [4:     netbpfload:  825]  el0t_64_sync+0x1b8/0x1bc
> [   79.427502] [4:     netbpfload:  825]=20
> [   79.545586] [4:     netbpfload:  825] The buggy address belongs to a 8=
-page vmalloc region starting at 0x25ffffc08e631000 allocated at bpf_patch_=
insn_data+0x8c/0x2f0
> [   79.558777] [4:     netbpfload:  825] The buggy address belongs to the=
 physical page:
> [   79.565029] [4:     netbpfload:  825] page: refcount:1 mapcount:0 mapp=
ing:0000000000000000 index:0x0 pfn:0x8b308b
> [   79.573710] [4:     netbpfload:  825] memcg:c6ffff882d1d6402
> [   79.577791] [4:     netbpfload:  825] flags: 0x6f80000000000000(zone=
=3D1|kasantag=3D0xbe)
> [   79.584042] [4:     netbpfload:  825] raw: 6f80000000000000 0000000000=
000000 dead000000000122 0000000000000000
> [   79.592460] [4:     netbpfload:  825] raw: 0000000000000000 0000000000=
000000 00000001ffffffff c6ffff882d1d6402
> [   79.600877] [4:     netbpfload:  825] page dumped because: kasan: bad =
access detected
> [   79.607126] [4:     netbpfload:  825]=20
> [   79.609296] [4:     netbpfload:  825] Memory state around the buggy ad=
dress:
> [   79.614766] [4:     netbpfload:  825]  ffffffc08e637f00: 25 25 25 25 2=
5 25 25 25 25 25 25 25 25 25 25 25
> [   79.622665] [4:     netbpfload:  825]  ffffffc08e638000: 25 25 25 25 2=
5 25 25 25 25 25 25 25 25 25 25 25
> [   79.630562] [4:     netbpfload:  825] >ffffffc08e638100: 25 25 25 25 2=
5 25 25 fa fa fa fa fa fa fe fe fe
> [   79.638463] [4:     netbpfload:  825]                                 =
        ^
> [   79.644190] [4:     netbpfload:  825]  ffffffc08e638200: fe fe fe fe f=
e fe fe fe fe fe fe fe fe fe fe fe
> [   79.652089] [4:     netbpfload:  825]  ffffffc08e638300: fe fe fe fe f=
e fe fe fe fe fe fe fe fe fe fe fe
> [   79.659987] [4:     netbpfload:  825] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
> I have a question about the above phenomenon.
> Thanks,
> Jeongho Choi

