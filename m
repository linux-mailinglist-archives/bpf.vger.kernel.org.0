Return-Path: <bpf+bounces-70522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48DBC2655
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78AEF4F1405
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7082E974E;
	Tue,  7 Oct 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pyq5Yy62"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F42E92C0
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862158; cv=none; b=cck7Q6HJRKUIRGpaO3a+RRozpNyn4eMUhHWd94Dg0M3qlVh4s7G9ugw1qkr+ScNXwfg9h7k3vpimI5wiCouBvinPYcyHMGg8pNZZXWRwZKMCzH0BhwGhws2s8M3YJ3OnHAYjxIRONsGX2Dg8fwj44AlRI+dOPUEZByxo9LtV44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862158; c=relaxed/simple;
	bh=GDD0Di3WzU+69nZZRp6jIZbEhssa4+jL/fuJ9eHBLwk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YsVM7eXKsiCPW7vmj3lZR1PsmLvK414LBNLx4ZIq9Zg7x+NH+LvCbP6ihOjTTiacze+1SYgE1BZdQBPOsD1x+ibkgmuo5/QwLVhu5EMzbj74MWpJXygGpqFAoeyLKF244PlbLysFu9jYNoIY1bQq07xHZPsJwbSoJ+UHfmCk1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pyq5Yy62; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-273a0aeed57so2012805ad.1
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759862156; x=1760466956; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TwxUH/tAFu2qpSP2ntpgkH9KJA0ZKZEet1nykpeQ94=;
        b=Pyq5Yy62QpKlvEzp6ov2SDf702exTsQC7ZFY10iG0NjBvZVTjcmBnd17ac55tDY5gm
         U52vAsJ9bJwXrUWwkdAM+4+oDZ3QscqjlE3e2bnmb3oWx8QI26tQHER3yWmlyN6QCHqn
         byJqJy/+PxbqO5dcdITiZiWKd8O9FaaIZ3yKhW1N0m0rCrgVtGvqXTx3a8fsbfCLVyKc
         bbXstOcocuprpC3kTRT9HC2M+UnXz0HXFAP5LMfNoZzbN2m/4fzILyfFNKvk6IS3gY/e
         SQSME5Ed0dqqaQQcCP4d+vzNa0BbUtUkxO9gb4rQSaCMY/TVD0kLV+/STFp+Ns/Bl02y
         4LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862156; x=1760466956;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TwxUH/tAFu2qpSP2ntpgkH9KJA0ZKZEet1nykpeQ94=;
        b=i4E1c9Z6X6Q7zY+WmjMRyM76H+6MDz2DzGfTP+aRrUGV+xLjz2lDPXY7VysMaAuE88
         DNDG6t827LcCsg7/zBXST2Z6sG+mVwTjFpDhdsGy1a06xek5JBD4k7CCOZ1B//3ZFpoV
         1p1p4nFenWEyRg5g3rmpGpdr7MO4nMAsBrE0neEQ5JduU3X3vKdyfw+T0L+Mv9F7QF4a
         aNpDwYAPUb59SL+NXJf5ep1i1OPeUg4qpTHZWTK8cGd/hEh4APyog45kXxeqi1g3eF/H
         m2FRJlM04YWU8AcpBPzgcPVoJJVWAiSDPJ2OneJYTshK9JrXJj2TD/guFaY8dd2DN2R+
         rdww==
X-Forwarded-Encrypted: i=1; AJvYcCVWzSWrBO1AMshr1fChttl92vurXrO4gwkab6UY0dXCWDFmvV85ZPxKaFnPSKR6qj/NnUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MfTerD4tk55oq4JjgTSvyNZGMlvcnp3yLuybqbLKUlkbAiNc
	fr14zMyEVmpkypX0y8NcFL6vOOTzKDvSFny/Av6T095QyF8KMPnMUS3y7ZQlTzB6
X-Gm-Gg: ASbGncvAC/QQmoX+Hcasb4NKEZci0HZqSM3HZhkyRPkLxSFagKAI30G/5bKOijcWaQX
	EppToiUQ6Pyi8FxFm6z4ShP9kdf92qCTH/e44zNpW3Tz1oj3HlAL8B/fGA5op/opjK1zHDH4NUY
	U25G1Szqd6vb+T79PSaofviUdqupR3Q36ASZpUmQhqVFzg4D0QiXoJ/NADOmWQUnqtaZ0D136Jj
	J8kCuhmdF+2L2243PdZXk3aXksgzSZG/uIMdtvtqyWuVKhIv2fKGrOd/UYliGgnvHMVFAveEOgN
	0OcfwebAi/Xv0FMcMVsto1xPJFC8ETwQoRpmWTlqyp77MJnc9y6uhZJ1s30yXL9RFDp9/PPuvnb
	tpowwKrmC6h68HR8AKtZRrfhKKxYcRjwJfFyzAUIOJhg6yrLYEZ6jbLZ20APwTUWYd4CzvTcm
X-Google-Smtp-Source: AGHT+IFY2lJBMldsjgZCh6f494/AOxWTHhnsSBHQz+ADASHMsMujy+hsHBNw+CQ4nO9YIMEEcqVNXw==
X-Received: by 2002:a17:902:e849:b0:267:912b:2b36 with SMTP id d9443c01a7336-29027f257f8mr3732655ad.23.1759862155776;
        Tue, 07 Oct 2025 11:35:55 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d113036sm172499855ad.27.2025.10.07.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:35:55 -0700 (PDT)
Message-ID: <0a5b15d6a4a0115648e955ea642978e467520bfe.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: invalid-access Write in do_bad_area
From: Eduard Zingerman <eddyz87@gmail.com>
To: syzbot <syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Tue, 07 Oct 2025 11:35:53 -0700
In-Reply-To: <68e52a94.a00a0220.298cc0.047c.GAE@google.com>
References: <68e52a94.a00a0220.298cc0.047c.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 07:58 -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>=20
> HEAD commit:    c746c3b51698 Merge tag 'for-6.18-tag' of git://git.kernel=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D149b5a7c58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df49b7d923ce86=
7a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D997752115a851cb=
0cf36
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17ee792f980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D163955cd98000=
0
>=20
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/f=
a3fbcfdac58/non_bootable_disk-c746c3b5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/85796940f78d/vmlinu=
x-c746c3b5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1d82d6550867/I=
mage-c746c3b5.gz.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: invalid-access in __memcpy+0xc/0x54 arch/arm64/lib/memcpy.S:2=
50
> Write at addr f0ff800083d6d268 by task syz.2.17/3596
> Pointer tag: [f0], memory tag: [fe]
>=20
> CPU: 1 UID: 0 PID: 3596 Comm: syz.2.17 Not tainted syzkaller #0 PREEMPT=
=20
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x78/0x90 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x108/0x61c mm/kasan/report.c:482
>  kasan_report+0x88/0xac mm/kasan/report.c:595
>  report_tag_fault arch/arm64/mm/fault.c:326 [inline]
>  do_tag_recovery arch/arm64/mm/fault.c:338 [inline]
>  __do_kernel_fault+0x170/0x1c8 arch/arm64/mm/fault.c:380
>  do_bad_area+0x68/0x78 arch/arm64/mm/fault.c:480
>  do_tag_check_fault+0x34/0x44 arch/arm64/mm/fault.c:853
>  do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:929
>  el1_abort+0x44/0x68 arch/arm64/kernel/entry-common.c:325
>  el1h_64_sync_handler+0x50/0xac arch/arm64/kernel/entry-common.c:459
>  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:591
>  __memcpy+0xc/0x54 arch/arm64/lib/memcpy.S:250 (P)
>  do_misc_fixups+0x174/0x1aac kernel/bpf/verifier.c:22553
>  bpf_check+0x1348/0x2a24 kernel/bpf/verifier.c:24686
>  bpf_prog_load+0x63c/0xcd4 kernel/bpf/syscall.c:3062
>  __sys_bpf+0x2e0/0x1a88 kernel/bpf/syscall.c:6134
>  __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
>  __arm64_sys_bpf+0x24/0x34 kernel/bpf/syscall.c:6242
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x34/0x10c arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:763
>  el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596
>=20
> The buggy address belongs to a 1-page vmalloc region starting at 0xf0ff80=
0083d6d000 allocated at bpf_check+0x8c/0x2a24 kernel/bpf/verifier.c:24529
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x544b=
2
> flags: 0x1fffc0000000000(node=3D0|zone=3D0|lastcpupid=3D0x7ff|kasantag=3D=
0xf)
> raw: 01fffc0000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
>  ffff800083d6d000: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
>  ffff800083d6d100: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 fe fe fe fe
> > ffff800083d6d200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                                      ^
>  ffff800083d6d300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff800083d6d400: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

fwiw, can't reproduce this on x86.

