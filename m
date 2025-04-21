Return-Path: <bpf+bounces-56291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F4A94B35
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 04:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F73C7A296B
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 02:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130D8256C90;
	Mon, 21 Apr 2025 02:53:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD97256C7B;
	Mon, 21 Apr 2025 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204005; cv=none; b=dXvQ70Gys248267kr+xknBu9KxpN7MatGu8nOQO9GBavWDKgvaxDJStHFIXrSvbG2XJLJhfYGmtxvhN80svg4bv2hc6fEm6zUU+Pq3dM9sKvF2Hnohi2UhUvcvoxXuFoa9CubpnFPIj6SwHpZNef4WiGAzQG7UCARr6qXjpN3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204005; c=relaxed/simple;
	bh=ohoYy81jPOBHi3Kl/yJ0GpN9kR2CeXImpedVkpQqUl8=;
	h=To:From:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=RQN7Gcc9PEhOteCZXWnDmTdCmhIiPMAzLezINQ1tcA6GPf/YHnnNWOpwMA8aB9n+KLVbI5jVxVfjDqceqHZqgBEUC9n9F+STQyi7+xdT65cxID4De/s446JQpek7aYF+8Au7JYm1gtEew3mWI8jhH7p1LG8TB71pygfAgyXgq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxieAaswVoDy_DAA--.16802S3;
	Mon, 21 Apr 2025 10:53:15 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDx_MQUswVoS6yNAA--.21709S3;
	Mon, 21 Apr 2025 10:53:13 +0800 (CST)
To: yangtiezhu <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Cc: bpf@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: BUG: bpf test case fails to run on LoongArch
Message-ID: <32989acf-93ef-b90f-c3ba-2a3c07dee4a3@loongson.cn>
Date: Mon, 21 Apr 2025 10:52:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMDx_MQUswVoS6yNAA--.21709S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyrKFyUJry3tFW8KF1fXwc_yoW5tr4xpr
	y3Jr1UGr4kJr17Ar1UJr1UJr15J3ZrAF18Jr1UJryUCr15Gr1UJr1UtrW7JryUJr4UJr17
	Jw1Dtr1Utr1DGwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
	sqAUUUUU=

Hi,

When I run built-in bpf test case with lib/test_bpf.c,
it reports such error, I do not know whether it is a problem.

  test_bpf: #843 ALU32_RSH_X: all shift values jited:1 239 PASS
  test_bpf: #844 ALU32_ARSH_X: all shift values jited:1 237 PASS
  test_bpf: #845 ALU64_LSH_X: all shift values with the same register
  ------------[ cut here ]------------
  kernel BUG at lib/test_bpf.c:794!
  Oops - BUG[#1]:
  CPU: 15 UID: 0 PID: 2323 Comm: insmod Not tainted 6.15.0-rc2+ #297 
PREEMPT(full)
  Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
  pc ffff80000272c0e0 ra ffff80000272bf90 tp 900000013defc000 sp 
900000013deffb40
  a0 0000000000000000 a1 900000013deffb80 a2 900000010aa4fbf8 a3 
900000013deffb88
  a4 900000013deffb80 a5 900000010aa4fbf0 a6 0000000000000218 a7 
8000000000000000
  t0 00000000000000c0 t1 0000000000000c10 t2 00000000000000c0 t3 
0000000000000000
  t4 0000000000000095 t5 0000000000000c08 t6 00000000000000c0 t7 
00000001000000b7
  t8 0000000000000183 u0 0000000000010000 s9 0000000000000040 s0 
0000000000000c00
  s1 0000000000000181 s2 0000000000000000 s3 0000000000000040 s4 
000000000001211d
  s5 0000000000000218 s6 0000000000000011 s7 00000000000001b7 s8 
900000010aa4f000
    ra: ffff80000272bf90 __bpf_fill_alu_shift_same_reg+0x118/0x298 
[test_bpf]
    ERA: ffff80000272c0e0 __bpf_fill_alu_shift_same_reg+0x268/0x298 
[test_bpf]
   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
   PRMD: 00000004 (PPLV0 +PIE -PWE)
   EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
   ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
  ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
   PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
  Modules linked in: test_bpf(+) snd_seq_dummy snd_seq snd_seq_device 
rfkill vfat fat virtio_net virtio_gpu net_failover virtio_balloon 
failover virtio_dma_buf efi_pstore virtio_scsi pstore dm_multipath fuse 
nfnetlink efivarfs
  Process insmod (pid: 2323, threadinfo=000000006d91be37, 
task=00000000064df522)
  Stack : 9000000002018bc0 0000000000000060 000000000000006f 
000000000000006c
          0000000000000183 ffff800002ba1c40 8000000000000000 
0000000000000218
          8000000000000000 545a35de324f71ab 900000013deffbb8 
ffff800002808080
          9000000002018bc0 0000000000000000 0000000000000000 
000000000000034d
          0000000000000000 ffff80001d438000 ffff800002ba0b08 
ffff800002ba2c40
          000000000000034d ffff8000027807e8 0000000000000001 
0000000000000341
          ffff800002808100 0000000000000341 00000000000003e8 
0000000000000001
          ffff800002ba1b09 ffff800002ba1bb4 9000000002c30140 
9000000002b240b8
          0000000000000000 0000000000000000 ffff80001d438000 
0000000000000000
          0000000000000000 545a35de324f71ab 0000000000000000 
000000000000002f
          ...
  Call Trace:
  [<ffff80000272c0e0>] __bpf_fill_alu_shift_same_reg+0x268/0x298 [test_bpf]
  [<ffff8000027807e4>] test_bpf_init+0x39c/0x3bb8 [test_bpf]
  [<9000000000240154>] do_one_initcall+0x74/0x200
  [<9000000000327764>] do_init_module+0x54/0x2a0
  [<9000000000329ccc>] __do_sys_init_module+0x204/0x2a8
  [<90000000015b17a0>] do_syscall+0xa0/0x188
  [<90000000002413b8>] handle_syscall+0xb8/0x158

  Code: 03400000  03400000  03400000 <002a0001> 29c28076  29c26077 
29c24078  29c1e07b  29c1c07c

  ---[ end trace 0000000000000000 ]---


