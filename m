Return-Path: <bpf+bounces-47125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8389F4FB5
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 16:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2214B7A200C
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A51F75A6;
	Tue, 17 Dec 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU5CdzPV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF081F7572;
	Tue, 17 Dec 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450232; cv=none; b=squZIYW9+A48DhhWHvO5tsgwYoTYAWtWOSFyCw85JoofjFSDAbP6Nc/kNsqVNH6ZO/mTTnCWS7nJbHlt9jbmsCbzjRPKeLPmPwAHc3z4OwqLRH+XdXWuy59o6RcUe+cqo0k91ca8gmH/Rz09np8ouHhqCkQY0qLhaCvaAoADmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450232; c=relaxed/simple;
	bh=ZwVFELC71dzFSNCZimKgBWaJEA4Y5NkhJ2hwLvlGU/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=McQBjEql1C1PfE8PMa/1TIlyLzVkCS306pIZB5w8yLgXowC7DVQglNuCJb+LiWfjq4i2O6w+Rj20ywquBPyZ3NhfwMHAuu5HeHyIIs2Q+dmmFAZy3uzYC0A89QystQKP3q6yQ7gZBEapCo2edf9liZYxKO0BiNDjU4aa0jLVHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU5CdzPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A839AC4CED6;
	Tue, 17 Dec 2024 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450232;
	bh=ZwVFELC71dzFSNCZimKgBWaJEA4Y5NkhJ2hwLvlGU/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lU5CdzPVHWwtUmTW2srGDqV3xpYk/1KqcXvrPHBaWOi1E8TXRWJHZf0MTs+o/eKe9
	 B3mmm1PeAP07cpBVZ1+4C7zc27+tCuHqbH94XbYZVARogDeOewScoVSKr6gRtKKECh
	 1qY98ZsvXpmzSNTAIzWvkBL4ptbvZBDjgP9ipXZoGLR8A6O0S9VhGRWl0O59gRMEOF
	 DHTX3Pr+F1BqGKUQIVnKoCrNhJFr22jTamNMHi1nlyjOgLgR5Rhx9AvvEqoSyd36xc
	 dzncCefvOQE5aOOwCa0BmcMj2SdUaRhld7tg8XuYdUq2bLwAsXSeKo731yILF8BmAB
	 TJ0xMwIS1EvtQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Levi Zim <rsworktech@outlook.com>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
In-Reply-To: <MEYP282MB2312EE60BC5A38AEB4D77BA9C6372@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <Z0+qA4Lym/TWOoSh@pop-os.localdomain>
 <MEYP282MB2312EE60BC5A38AEB4D77BA9C6372@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 17 Dec 2024 16:43:48 +0100
Message-ID: <87y10e1fij.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Levi Zim <rsworktech@outlook.com> writes:

> On 2024-12-04 09:01, Cong Wang wrote:
>> On Sun, Dec 01, 2024 at 09:42:08AM +0800, Levi Zim wrote:
>>> On 2024-11-30 21:38, Levi Zim via B4 Relay wrote:
>>>> I found that bpf kselftest sockhash::test_txmsg_cork_hangs in
>>>> test_sockmap.c triggers a kernel NULL pointer dereference:
>> Interesting, I also ran this test recently and I didn't see such a
>> crash.
>
> I am also curious about why other people or the CI didn't hit such crash.

FWIW, I'm hitting it on RISC-V:

  |  Unable to handle kernel access to user memory without uaccess routines=
 at virtual address 0000000000000008
  |  Oops [#1]
  |  Modules linked in: sch_fq_codel drm fuse drm_panel_orientation_quirks =
backlight
  |  CPU: 7 UID: 0 PID: 732 Comm: test_sockmap Not tainted 6.13.0-rc3-00017=
-gf44d154d6e3d #1
  |  Hardware name: riscv-virtio qemu/qemu, BIOS 2025.01-rc3-00042-gacab6e7=
8aca7 01/01/2025
  |  epc : splice_to_socket+0x376/0x49a
  |   ra : splice_to_socket+0x37c/0x49a
  |  epc : ffffffff803d9ffc ra : ffffffff803da002 sp : ff20000001c3b8b0
  |   gp : ffffffff827aefa8 tp : ff60000083450040 t0 : ff6000008a12d001
  |   t1 : 0000100100001001 t2 : 0000000000000000 s0 : ff20000001c3bae0
  |   s1 : ffffffffffffefff a0 : ff6000008245e200 a1 : ff60000087dd0450
  |   a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
  |   a5 : 0000000000000000 a6 : ff20000001c3b450 a7 : ff6000008a12c004
  |   s2 : 000000000000000f s3 : ff6000008245e2d0 s4 : ff6000008245e280
  |   s5 : 0000000000000000 s6 : 0000000000000002 s7 : 0000000000001001
  |   s8 : 0000000000003001 s9 : 0000000000000002 s10: 0000000000000002
  |   s11: ff6000008245e200 t3 : ffffffff8001e78c t4 : 0000000000000000
  |   t5 : 0000000000000000 t6 : ff6000008869f230
  |  status: 0000000200000120 badaddr: 0000000000000008 cause: 000000000000=
000d
  |  [<ffffffff803d9ffc>] splice_to_socket+0x376/0x49a
  |  [<ffffffff803d8bc0>] direct_splice_actor+0x44/0x216
  |  [<ffffffff803d8532>] splice_direct_to_actor+0xb6/0x1e8
  |  [<ffffffff803d8780>] do_splice_direct+0x70/0xa2
  |  [<ffffffff80392e40>] do_sendfile+0x26e/0x2d4
  |  [<ffffffff803939d4>] __riscv_sys_sendfile64+0xf2/0x10e
  |  [<ffffffff80fdfb64>] do_trap_ecall_u+0x1f8/0x26c
  |  [<ffffffff80fedaee>] _new_vmalloc_restore_context_a0+0xc6/0xd2
  |  Code: c5d8 9e35 c590 8bb3 40db eb01 6998 b823 0005 856e (6718) 2d05=20
  |  ---[ end trace 0000000000000000 ]---
  |  Kernel panic - not syncing: Fatal exception
  |  SMP: stopping secondary CPUs
  |  ---[ end Kernel panic - not syncing: Fatal exception ]---

This is commit f44d154d6e3d ("Merge tag 'soc-fixes-6.13' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc").

(Yet to bisect!)


Bj=C3=B6rn

