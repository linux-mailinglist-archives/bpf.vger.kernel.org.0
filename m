Return-Path: <bpf+bounces-20009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9BE8365BC
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 15:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B44E28B828
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5203D56D;
	Mon, 22 Jan 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf+cVOry"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222EB3D0A8;
	Mon, 22 Jan 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934649; cv=none; b=bgtZMNRgwzQKZR3Mko5FlytyIP56fUsOq/OAZWgX7EumUKXoniARRqdZFfiNJFXg5stDRVZp8yYIEtmBjSK2A2KBG7gppB7/ziZZGHeYO8U+pxoqux083+SJ1qCGbgBgt0abwBpNmtJTlTPN2A74+h1eulSr7cYOywOuQw9Mfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934649; c=relaxed/simple;
	bh=n4icWO+A2WRRsZQtgnXM+zFZavAGdHbVHdwWTbDEN0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKv7fv9xREMCJU5f6ean0cmhujRYlpswR1V4or0l851u5mV+YBT8Kw4KnzOdSwzZRCX9rscazubayQeOSUd2Q+FuzQ+/iRdgFXW7i1csIw3m/yYWWcHve86LN+AttG4tDZifZDcYtqwt5xCIJhycyjHFpbO67OGezfKkeamBXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf+cVOry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429A0C433C7;
	Mon, 22 Jan 2024 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705934648;
	bh=n4icWO+A2WRRsZQtgnXM+zFZavAGdHbVHdwWTbDEN0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rf+cVOryp1l0k/LbLFLRL93XODDyFzoqKCS+plSPspoSJLaDT2Ffb5MmHvpb7aOLC
	 qSGObe4TVzceKhKnvnkCgB2Jd+KevEymgx56DvjT8j/S67GkCD98gTWIgXQTsVKCfB
	 doegGsHpCaBYTN1vyfb3rI5jQ2ULK1PVYERudp0o2f4mgyD3UUQdKraOZ3mwhlGEwK
	 Me0GOuqShNSiXsgGYOQN3ZYhH1+OiGxtrQIn9Wn2KcDepfC9/RYf9hfQKxkOSJBoHZ
	 eXYh8os1tFFp/I+qCmL5+71jO7KUDF2AMsZW6ABScVjOXCjBOWvHbJ40OxnTQrv3Ww
	 GAoqiK6Lg+N1Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH RESEND bpf-next v3 0/6] Zbb support and code
 simplification for RV64 JIT
In-Reply-To: <baffbab8-721f-462a-8b58-64972f5eae70@huaweicloud.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <87il3lqvye.fsf@all.your.base.are.belong.to.us>
 <baffbab8-721f-462a-8b58-64972f5eae70@huaweicloud.com>
Date: Mon, 22 Jan 2024 15:44:05 +0100
Message-ID: <878r4hqvgq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2024/1/22 22:33, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
>>> Meanwhile, adjust the code for unification and simplification. Tests
>>> test_bpf.ko and test_verifier have passed, as well as the relative
>>> testcases of test_progs*.
>>>
>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/b=
itmanip-1.0.0-38-g865e7a7.pdf [0]
>>>
>>> v3 resend:
>>> - resend for mail be treated as spam.
>>>
>>> v3:
>>> - Change to early-exit code style and make code more explicit.
>>=20
>> Lehui,
>>=20
>> Sorry for the delay. I'm chasing a struct_ops RISC-V BPF regression in
>> 6.8-rc1, I will need to wrap my head around that prior reviewing
>> properly.
>>=20
>
> Oh, I also found the problem with struct ops and fixed it

Awesome, I just started bisecting the following test_progs sub-test
fails on 6.8-rc1:

bpf_iter_setsockopt:
Unable to handle kernel NULL pointer dereference at virtual address 0000000=
000000000
Oops [#1]
Modules linked in: bpf_testmod(OE) drm fuse i2c_core dm_mod drm_panel_orien=
tation_quirks backlight configfs ip_tables x_tables
CPU: 1 PID: 458 Comm: test_progs Tainted: G           OE      6.8.0-rc1-kse=
lftest_plain #1
Hardware name: riscv-virtio,qemu (DT)
epc : 0x0
 ra : tcp_set_ca_state+0x2c/0x9a
epc : 0000000000000000 ra : ffffffff80cdc6b2 sp : ff2000000000b910
 gp : ffffffff82587b60 tp : ff60000087ea8040 t0 : 0000000000000000
 t1 : ffffffff801ed15e t2 : 0000000000000000 s0 : ff2000000000b930
 s1 : ff600000879296c0 a0 : ff20000000497000 a1 : 0000000000000008
 a2 : 0000000000000001 a3 : ff60000087ea83a0 a4 : 0000000000000000
 a5 : 0000000000000106 a6 : 0000000000000021 a7 : 0000000000000000
 s2 : 0000000000000000 s3 : ff60000086878008 s4 : ff60000082ce2f40
 s5 : ff60000084f56040 s6 : ff60000087929040 s7 : ff60000086878008
 s8 : ff2000000000ba5f s9 : ff60000087928a00 s10: 0000000000000002
 s11: ff60000087928040 t3 : 000000000001ffff t4 : 0100000000000000
 t5 : 0000000000000000 t6 : ff6000008792a118
status: 0000000200000120 badaddr: 0000000000000000 cause: 000000000000000c
Code: Unable to access instruction at 0xffffffffffffffec.
---[ end trace 0000000000000000 ]---

bpf_tcp_ca:
Unable to handle kernel paging request at virtual address ff60000088554500
Oops [#1]
Modules linked in: iptable_raw xt_connmark bpf_testmod(OE) drm fuse i2c_cor=
e drm_panel_orientation_quirks backlight dm_mod configfs ip_tables x_tables=
 [last unloaded: bpf_testmod(OE)]
CPU: 3 PID: 458 Comm: test_progs Tainted: G           OE      6.8.0-rc1-kse=
lftest_plain #1
Hardware name: riscv-virtio,qemu (DT)
epc : 0xff60000088554500
 ra : tcp_ack+0x288/0x1232
epc : ff60000088554500 ra : ffffffff80cc7166 sp : ff2000000117ba50
 gp : ffffffff82587b60 tp : ff60000087be0040 t0 : ff60000088554500
 t1 : ffffffff801ed24e t2 : 0000000000000000 s0 : ff2000000117bbc0
 s1 : 0000000000000500 a0 : ff20000000691000 a1 : 0000000000000018
 a2 : 0000000000000001 a3 : ff60000087be03a0 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000021 a7 : ffffffff8263f880
 s2 : 000000004ac3c13b s3 : 000000004ac3c13a s4 : 0000000000008200
 s5 : 0000000000000001 s6 : 0000000000000104 s7 : ff2000000117bb00
 s8 : ff600000885544c0 s9 : 0000000000000000 s10: ff60000086ff0b80
 s11: 000055557983a9c0 t3 : 0000000000000000 t4 : 000000000000ffc4
 t5 : ffffffff8154f170 t6 : 0000000000000030
status: 0000000200000120 badaddr: ff60000088554500 cause: 000000000000000c
Code: c796 67d7 0000 0000 0052 0002 c13b 4ac3 0000 0000 (0001) 0000=20
---[ end trace 0000000000000000 ]---

dummy_st_ops:
Unable to handle kernel access to user memory without uaccess routines at v=
irtual address 0000000000043022
Oops [#1]
Modules linked in: iptable_raw xt_connmark bpf_testmod(OE) drm fuse i2c_cor=
e drm_panel_orientation_quirks backlight dm_mod configfs ip_tables x_tables=
 [last unloaded: bpf_testmod(OE)]
CPU: 1 PID: 452 Comm: test_progs Tainted: G           OE      6.8.0-rc1-kse=
lftest_plain #1
Hardware name: riscv-virtio,qemu (DT)
epc : 0x43022
 ra : bpf_struct_ops_test_run+0x188/0x37a
epc : 0000000000043022 ra : ffffffff80c75d1a sp : ff200000002a3ce0
 gp : ffffffff82587b60 tp : ff6000008356b840 t0 : 0000000000043023
 t1 : ffffffff801ed062 t2 : 000000000000ff00 s0 : ff200000002a3d40
 s1 : ffffffff78207000 a0 : fffffffff2f3f4f5 a1 : 0000000000000008
 a2 : 0000000000000001 a3 : ff6000008356bba0 a4 : 0000000000000000
 a5 : fffffffff2f3f4f5 a6 : 0000000000000021 a7 : 0000000052464e43
 s2 : 0000000000000000 s3 : ff60000080b33b80 s4 : 0000000000000084
 s5 : ff60000083334c00 s6 : ff60000084861580 s7 : 00007ffff0887668
 s8 : 00007fffaa859030 s9 : 0000000000000000 s10: 000055556631ca4c
 s11: 000055556631c9c0 t3 : 000000000000000f t4 : 0000000000000800
 t5 : 0001000000000000 t6 : ff6000008adb9bf8
status: 0000000200000120 badaddr: 0000000000043022 cause: 000000000000000c
Code: Unable to access instruction at 0x000000000004300e.
---[ end trace 0000000000000000 ]---

Environment: OpenSBI 1.4, Qemu 8.2.0, U-boot UEFI

Is that the same that you see?

I'll take your patch for a spin!


Bj=C3=B6rn

