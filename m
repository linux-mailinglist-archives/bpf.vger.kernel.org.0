Return-Path: <bpf+bounces-40468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D498923B
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 02:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6FF1C22E64
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 00:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730EA94A;
	Sun, 29 Sep 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh4D+pj9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319503FC7;
	Sun, 29 Sep 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727571544; cv=none; b=kzktg6yA/4eov5BWlhBW46UM83Y7diNTRJWIfJJLzjawoLVlbfCQM60tIp96jcz+LiPIDk/hpOLMpHfi7XPbkG7Neib5Rnp9PNqFsb0YgY8IHM217CAB1wtbJN3NsSCn17ysmNkjt7yn7p3XnKT/5bpDES6mLGsEEJ7BVObadHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727571544; c=relaxed/simple;
	bh=7L0Y9JGQG6xXBo0/yWFtfYGMzLEkRCuQUV5Bf4zpFCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+VIBuGTCU4tJMgxxIAlcoA/UJEi0U6L84AtDxcwYb0Zn69xE6Wdh4ygq9wXQDO3U4TublPE1WxHQ92jETF3fHlbVI/YvlyICwvZ1/ijluqasFYYjkJ6gLLb5QZhyYUTnW3oDvWweFW3n93JogFcqfC1ZfHzc/QR6oxdbffP+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh4D+pj9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71788bfe60eso2564568b3a.1;
        Sat, 28 Sep 2024 17:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727571542; x=1728176342; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CEj6xG+ReV1xwKr6ft0gHBve+9SE79mtuHBwZ3BvA+g=;
        b=Gh4D+pj928wPXyl03M42tlId8Dxj1Z7YPkTg+jSBhazBiqalFaSjrV9KyPfnOcjWqg
         KsOSkUAFG6N7Sl0sD3GKQRGWIZV32JNn4wZdchw3MJEtfgFd4fMc0CsWkIB/sJ+c7JJ7
         Kevm+jTy8Kps8koWmFzNN9EiwXireG5S5GiFUT3hVV57j3T6zZScGdzSIMtcpVC9IFJl
         oXdmxk7vG5785fNYRcwiNhGjbHe5ryNOh7n5nsMo0V2cYredruUGdXc7BS3ctG5aS+oI
         ps/eSuOsWn5yhzt3OHh53py2sC0hmRVYe//yR936ddQujNpwzKoIOuvjWUx8ZwZBsRJN
         LXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727571542; x=1728176342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEj6xG+ReV1xwKr6ft0gHBve+9SE79mtuHBwZ3BvA+g=;
        b=rOcCz/NaIGT8UYhezo/uAtHZ1E7iN1kdA04sqkjInaakBrOumQCPUStvJf8Tr5/z5a
         3MCcyH6cBkfl6Iu5zrpG0FIQ/5AxE91IXqO6yjbRIvOGCRLjAUPVLE3rfH5CWY4WhT0n
         nfTTqJhLG9Ua5BWiBu0PEcAd95Zz+0E4XOnzNB2/sFA+Sj5kPB/scgElgcqIGJsiKs6U
         PeYWPJkl4XSCGpLbO8NAM4m+9CHH6+Hz1eaKy4TehHo4LEBPW+N+KjO4xE9pEiA9wzS/
         CcJx/s4/4fDbLIyqozrtA7V/HpXpsosirMPhb8kwAeDNMRFo+jTjv2mQ2IxKmiHsbnJ9
         Azyg==
X-Forwarded-Encrypted: i=1; AJvYcCUzRVJWyLEEm3z7yQoCDWWYb6ffXAFPfP1e/EQe94UQaGDws2DHUnNsL0eZqujgJHWW9Jnyr25W@vger.kernel.org, AJvYcCVQWz1jQMKSRNvHQ4SgS4/YCICk3vnpuEofzPYjlUsYV8FZDT8GjpqtfDPy2tPbrvGYwjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDr+wPOYtOr9DoOLXPLoTiqP6y7j5LDbaUlT/1IfXtCeF7ILpg
	T0VBUg6sg5blaLj10/fB7WKuTlVplqSUrYwOWdeUheuwHNJ1JjE3zgqZ
X-Google-Smtp-Source: AGHT+IE7YdAVrTBcyZrWFgZCBeRWpqpsmaz8u1S6YB9Dxd0jnQFNiKu3EN5WH8jOILllP9h09WvLJA==
X-Received: by 2002:a05:6a20:d704:b0:1cc:9f25:54d4 with SMTP id adf61e73a8af0-1d4fa78a484mr11649480637.38.1727571542272;
        Sat, 28 Sep 2024 17:59:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264aad33sm3867647b3a.10.2024.09.28.17.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 17:59:01 -0700 (PDT)
Date: Sat, 28 Sep 2024 17:59:00 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "Sergey V. Lobanov" <sergey@lobanov.in>,
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: BUG: Kernel OOPS in __bpf_prog_offload_destroy (6.10, 6.11,
 bpf-next, x86_64/aarch64)
Message-ID: <ZvimVOSJ_vNM6cif@mini-arch>
References: <2194F884-8028-4018-AA64-848405757119@lobanov.in>
 <94203662-8792-456f-a9a1-dea3c4154d47@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94203662-8792-456f-a9a1-dea3c4154d47@linux.dev>

On 09/27, Martin KaFai Lau wrote:
> On 9/19/24 11:40 AM, Sergey V. Lobanov wrote:
> > Hi,
> > 
> > I've found kernel oops during device deletion (ip link del veth0) after attaching and detaching device bounded XDP bpf program. When this oops happens, host doesn’t function correctly (new processes can’t start, can’t login via ssh and so on).
> 
> bpf selftests also exercises a similar veth add/del path but didn't hit this
> issue. Is it reproducible very time?
> 
> cc: Stanislav if something obvious can be spotted.

I saw this one and I even run xdp_dev_bound_only.c with an explicit
'link del dev' prior to netns dismantle and got nothing :-(

Sergey, maybe you can do faddr2line and post on
__bpf_prog_offload_destroy+0x24/0xc8? So we at least get an idea
were exactly it fails. 'paging request at virtual address
ffff80008b565038' looks too broken to me.

> > BPF compiler is GCC 14.2.0. CXX is compiler (for loader) is GCC 14.2.0
> > 
> > It happens in kernels: 6.10.9, 6.11.0, bpf-next master branch (commit 5277d130947ba8c0d54c16eed89eb97f0b6d2e5a) on x86_64 and aarch64 hosts.
> > 
> > Call trace (kernel 6.11.0, aarch64):
> > [  584.364169] Unable to handle kernel paging request at virtual address ffff80008b565038
> > [  584.364236] Mem abort info:
> > [  584.364242]   ESR = 0x0000000096000007
> > [  584.364248]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [  584.364256]   SET = 0, FnV = 0
> > [  584.364270]   EA = 0, S1PTW = 0
> > [  584.364276]   FSC = 0x07: level 3 translation fault
> > [  584.364283] Data abort info:
> > [  584.364289]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> > [  584.364297]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [  584.364305]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [  584.364313] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000015ab5d000
> > [  584.364323] [ffff80008b565038] pgd=100000015bdf0003, p4d=100000015bdf0003, pud=100000015bdf1003, pmd=10000000ab84a003, pte=0000000000000000
> > [  584.364360] Internal error: Oops: 0000000096000007 [#1] SMP
> > [  584.364387] Modules linked in: veth xt_nat xt_tcpudp xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter bridge stp llc overlay qrtr cfg80211 binfmt_misc virtio_snd snd_pcm snd_timer nls_iso8859_1 snd soundcore input_leds joydev apple_mfi_fastcharge dm_multipath efi_pstore nfnetlink dmi_sysfs virtiofs ip_tables x_tables autofs4 hid_generic usbhid hid btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq libcrc32c raid1 raid0 crct10dif_ce polyval_ce polyval_generic ghash_ce sm4 sha3_ce sha2_ce sha256_arm64 sha1_ce virtio_rng virtio_gpu xhci_pci virtio_dma_buf xhci_pci_renesas aes_neon_bs aes_neon_blk aes_ce_blk aes_ce_cipher
> > [  584.364667] CPU: 1 UID: 0 PID: 6070 Comm: ip Not tainted 6.11.0-061100-generic #202409151536
> > [  584.364678] Hardware name: Apple Inc. Apple Virtualization Generic Platform, BIOS 2020.41.1.0.0 10/04/2023
> > [  584.364691] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > [  584.364701] pc : __bpf_prog_offload_destroy+0x24/0xc8
> > [  584.364745] lr : __bpf_offload_dev_netdev_unregister+0x318/0x438
> > [  584.364754] sp : ffff80008b64b1b0
> > [  584.364766] x29: ffff80008b64b1b0 x28: ffff0000c0355e00 x27: 0000000000000008
> > [  584.364781] x26: ffff80008394bcf8 x25: 0000000000000008 x24: ffff0000c6b71058
> > [  584.364791] x23: ffff0000c6b71000 x22: ffff0000c0d95018 x21: 0000000000000000
> > [  584.364802] x20: ffff80008b565000 x19: ffff0000c0d94ff8 x18: ffff80008b61d0a0
> > [  584.364813] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [  584.364823] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > [  584.364834] x11: 0000000000000000 x10: 949c93cdb28287d2 x9 : ffff8000803abc30
> > [  584.364844] x8 : ffff000042c844a8 x7 : 0000000000000000 x6 : 0000000000000000
> > [  584.364854] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > [  584.364865] x2 : 0000000000000000 x1 : ffff0000c0270500 x0 : ffff80008b565000
> > [  584.364875] Call trace:
> > [  584.364881]  __bpf_prog_offload_destroy+0x24/0xc8
> > [  584.364889]  __bpf_offload_dev_netdev_unregister+0x318/0x438
> > [  584.364898]  bpf_dev_bound_netdev_unregister+0x8c/0x138
> > [  584.364906]  unregister_netdevice_many_notify+0x1f0/0x760
> > [  584.364928]  rtnl_dellink+0x1b4/0x3e8
> > [  584.364935]  rtnetlink_rcv_msg+0x140/0x420
> > [  584.364944]  netlink_rcv_skb+0x6c/0x160
> > [  584.364978]  rtnetlink_rcv+0x24/0x50
> > [  584.364985]  netlink_unicast+0x340/0x3a0
> > [  584.364993]  netlink_sendmsg+0x270/0x480
> > [  584.365007]  __sock_sendmsg+0x80/0x108
> > [  584.365018]  ____sys_sendmsg+0x294/0x360
> > [  584.365025]  ___sys_sendmsg+0xbc/0x140
> > [  584.365033]  __sys_sendmsg+0x94/0x120
> > [  584.365041]  __arm64_sys_sendmsg+0x30/0x60
> > [  584.365052]  invoke_syscall+0x70/0x120
> > [  584.365071]  el0_svc_common.constprop.0+0x4c/0x140
> > [  584.365079]  do_el0_svc+0x28/0x60
> > [  584.365086]  el0_svc+0x44/0x1b0
> > [  584.365097]  el0t_64_sync_handler+0x148/0x160
> > [  584.365106]  el0t_64_sync+0x1b0/0x1b8
> > [  584.365113] Code: 910003fd a90153f3 aa0003f4 f90013f5 (f9401c00)
> > [  584.365123] ---[ end trace 0000000000000000 ]—
> > 
> > --
> > Sergey
> 

