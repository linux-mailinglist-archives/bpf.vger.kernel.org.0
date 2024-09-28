Return-Path: <bpf+bounces-40455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE2988D3B
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 02:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31A91F22794
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 00:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272212E4A;
	Sat, 28 Sep 2024 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T753S3Z6"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29342111AA
	for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727484851; cv=none; b=bn8gmtwhn1tb8LyjPeQLi0ZDTvMIXVWqe7obfCWxXwIbDMFWAJhi6jUqGAri1BYbXX4liMIUumZSqHFabRQaoVv53ODL9Hdv5RsZbCfXxtIXRHVqkksNKbx0688eNNpyBJLzPCL0HJZilyoI+oVHB9/PUIWx4MKMPfjB/LoLZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727484851; c=relaxed/simple;
	bh=Uxg6Y3FgGH5pJK1RfnDbwS5Jj2PL9vMcxNWJS7eeXzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIGLjv8beextkUmzVMRYSbrSSoxe5VP5F9BM94Y5qtAEW6jENGjm9WVXlFBUvyOd4j2pm0dvSIXeS/BDghkygyHxToXGMPHPdQ1sRbm1t14iLxjiTddXRZunM7DrjDn50Zu9vMP9S6sEcBKKp2Fl/ot9/D7hw7Xmhrdc2//DIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T753S3Z6; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94203662-8792-456f-a9a1-dea3c4154d47@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727484847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjT+1Hd9+q3m7yQRUpng3/RRW9THcwDn/YcnP/j06iw=;
	b=T753S3Z63Ug0gKhzxdpr0zVSz8VSSBu8/9rzPkz7HNn69mYpBIwyNNUDZzC+FTX1Vki4EQ
	vqq5tIPJdmcsF4t+D2rd6EwVRJcMW43GPW/pPB/RU4/9d+zTHwoy7kWQ1wNCQrfYoKpF3q
	mvui8ZPui07Cch5VL1vav+cSMPcMy2c=
Date: Fri, 27 Sep 2024 17:53:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BUG: Kernel OOPS in __bpf_prog_offload_destroy (6.10, 6.11,
 bpf-next, x86_64/aarch64)
To: "Sergey V. Lobanov" <sergey@lobanov.in>
Cc: Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <2194F884-8028-4018-AA64-848405757119@lobanov.in>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <2194F884-8028-4018-AA64-848405757119@lobanov.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/19/24 11:40 AM, Sergey V. Lobanov wrote:
> Hi,
> 
> I've found kernel oops during device deletion (ip link del veth0) after attaching and detaching device bounded XDP bpf program. When this oops happens, host doesn’t function correctly (new processes can’t start, can’t login via ssh and so on).

bpf selftests also exercises a similar veth add/del path but didn't hit this 
issue. Is it reproducible very time?

cc: Stanislav if something obvious can be spotted.

> 
> BPF compiler is GCC 14.2.0. CXX is compiler (for loader) is GCC 14.2.0
> 
> It happens in kernels: 6.10.9, 6.11.0, bpf-next master branch (commit 5277d130947ba8c0d54c16eed89eb97f0b6d2e5a) on x86_64 and aarch64 hosts.
> 
> Call trace (kernel 6.11.0, aarch64):
> [  584.364169] Unable to handle kernel paging request at virtual address ffff80008b565038
> [  584.364236] Mem abort info:
> [  584.364242]   ESR = 0x0000000096000007
> [  584.364248]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  584.364256]   SET = 0, FnV = 0
> [  584.364270]   EA = 0, S1PTW = 0
> [  584.364276]   FSC = 0x07: level 3 translation fault
> [  584.364283] Data abort info:
> [  584.364289]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> [  584.364297]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  584.364305]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  584.364313] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000015ab5d000
> [  584.364323] [ffff80008b565038] pgd=100000015bdf0003, p4d=100000015bdf0003, pud=100000015bdf1003, pmd=10000000ab84a003, pte=0000000000000000
> [  584.364360] Internal error: Oops: 0000000096000007 [#1] SMP
> [  584.364387] Modules linked in: veth xt_nat xt_tcpudp xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter bridge stp llc overlay qrtr cfg80211 binfmt_misc virtio_snd snd_pcm snd_timer nls_iso8859_1 snd soundcore input_leds joydev apple_mfi_fastcharge dm_multipath efi_pstore nfnetlink dmi_sysfs virtiofs ip_tables x_tables autofs4 hid_generic usbhid hid btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq libcrc32c raid1 raid0 crct10dif_ce polyval_ce polyval_generic ghash_ce sm4 sha3_ce sha2_ce sha256_arm64 sha1_ce virtio_rng virtio_gpu xhci_pci virtio_dma_buf xhci_pci_renesas aes_neon_bs aes_neon_blk aes_ce_blk aes_ce_cipher
> [  584.364667] CPU: 1 UID: 0 PID: 6070 Comm: ip Not tainted 6.11.0-061100-generic #202409151536
> [  584.364678] Hardware name: Apple Inc. Apple Virtualization Generic Platform, BIOS 2020.41.1.0.0 10/04/2023
> [  584.364691] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [  584.364701] pc : __bpf_prog_offload_destroy+0x24/0xc8
> [  584.364745] lr : __bpf_offload_dev_netdev_unregister+0x318/0x438
> [  584.364754] sp : ffff80008b64b1b0
> [  584.364766] x29: ffff80008b64b1b0 x28: ffff0000c0355e00 x27: 0000000000000008
> [  584.364781] x26: ffff80008394bcf8 x25: 0000000000000008 x24: ffff0000c6b71058
> [  584.364791] x23: ffff0000c6b71000 x22: ffff0000c0d95018 x21: 0000000000000000
> [  584.364802] x20: ffff80008b565000 x19: ffff0000c0d94ff8 x18: ffff80008b61d0a0
> [  584.364813] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  584.364823] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [  584.364834] x11: 0000000000000000 x10: 949c93cdb28287d2 x9 : ffff8000803abc30
> [  584.364844] x8 : ffff000042c844a8 x7 : 0000000000000000 x6 : 0000000000000000
> [  584.364854] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [  584.364865] x2 : 0000000000000000 x1 : ffff0000c0270500 x0 : ffff80008b565000
> [  584.364875] Call trace:
> [  584.364881]  __bpf_prog_offload_destroy+0x24/0xc8
> [  584.364889]  __bpf_offload_dev_netdev_unregister+0x318/0x438
> [  584.364898]  bpf_dev_bound_netdev_unregister+0x8c/0x138
> [  584.364906]  unregister_netdevice_many_notify+0x1f0/0x760
> [  584.364928]  rtnl_dellink+0x1b4/0x3e8
> [  584.364935]  rtnetlink_rcv_msg+0x140/0x420
> [  584.364944]  netlink_rcv_skb+0x6c/0x160
> [  584.364978]  rtnetlink_rcv+0x24/0x50
> [  584.364985]  netlink_unicast+0x340/0x3a0
> [  584.364993]  netlink_sendmsg+0x270/0x480
> [  584.365007]  __sock_sendmsg+0x80/0x108
> [  584.365018]  ____sys_sendmsg+0x294/0x360
> [  584.365025]  ___sys_sendmsg+0xbc/0x140
> [  584.365033]  __sys_sendmsg+0x94/0x120
> [  584.365041]  __arm64_sys_sendmsg+0x30/0x60
> [  584.365052]  invoke_syscall+0x70/0x120
> [  584.365071]  el0_svc_common.constprop.0+0x4c/0x140
> [  584.365079]  do_el0_svc+0x28/0x60
> [  584.365086]  el0_svc+0x44/0x1b0
> [  584.365097]  el0t_64_sync_handler+0x148/0x160
> [  584.365106]  el0t_64_sync+0x1b0/0x1b8
> [  584.365113] Code: 910003fd a90153f3 aa0003f4 f90013f5 (f9401c00)
> [  584.365123] ---[ end trace 0000000000000000 ]—
> 
> --
> Sergey


