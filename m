Return-Path: <bpf+bounces-71355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD331BEF80E
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C874E4EC849
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 06:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D2E2D8DCA;
	Mon, 20 Oct 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWlWmZj5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806317BED0
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942547; cv=none; b=iJvRdl1xfLk5OaJdKvFCjVpkgwjWEygJvkYFv8zUef90e286ILzMoQQN+hfAVgZ1xJpNZkANxlvRu0gZSxQWR+bwIYFM5rFH8Y0w72tVSyVVWnzsMwRWD2OQQUhjwuttgO3bMwACe4EWf9oqc3N/qcKxiPHdnRCxNWn/aw05YWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942547; c=relaxed/simple;
	bh=TSwON4X4whoDoVGwtMYFzkKsa6BYzRo/31c2NgSWoyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1nOuq9/QW+5cyAKdEuKtgIIoQdA/n3dewJhE4S40yQAK39pRVQ6c5mO6WrxANq38IbTaY65yLg4xHr9xrj/xsh5UFKREC0LwfNbP+ZVs8tHjD4YgYPPdaCu4Su+L0QN24kzfdnM4reDuooLWregSLKJ/bZwCV5dLDlZfezJ0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWlWmZj5; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso23578295ab.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760942545; x=1761547345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ishMfoGh/EcFlfdPk63knfNyW1edfHKoV/fNcZ+bx3I=;
        b=MWlWmZj5TaTw9Hviy+3WcE9DTZ0fyF6yxLsOSAkOOMkMNnEnAP2RAaS1QAG/YnmVLx
         E6XBi/nS4z9xLLabHChwdqpLueZsux4nwnDGlct68GItdWjiiUc/ynDJrRyGlmm7P5P/
         3rYFFPmRlB01z5x83BL/emM1EADOGhMLJiy//6yavgpSm0NJSpovla0R1an1Grc1HNwY
         p15zwGUyXdKJvEkeA1G09lhzzVEbdPV4gPyAmse4SEj0FBFKOXsv3OFNYSDkrJy3MjEp
         vrXzMV5M3PRVf3a0RHcJMxR4fyp5KXFO7pkv7H1D8EoP4jt++5HQKcJ3eFWfKhQyaMDr
         CPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760942545; x=1761547345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ishMfoGh/EcFlfdPk63knfNyW1edfHKoV/fNcZ+bx3I=;
        b=RISLiCqfb9fY4GxeEsbWODgqESicQ/IRdPol7aF7PSrMwWLJmVcpWJFr+r+tQ9KMYU
         UNs+O6FHBtDvXYnL7k3HwY4tn5JVUdPvzsVvbeMc3MNRdeCTlnN82BtcCawIB0/JDLlS
         PMnNHlp/31hK7f22ceEKRSzKSZJWbHzXe9w2hWAXdVULXvUWqYi89JrKZcViCjb2dSNf
         j5WJJUppHOjw/rh74ubxxks1cGbsNL/qoHCFGj4QHcjSU0wKrSQAm2avC1zdKWUoel2R
         kC8/F+YJWNsSkvsuqDbjIHIIb+QibWT7qnCpSSVt95vUjYU8YfXLDsIYKyBYTU87Wkh7
         fv4w==
X-Forwarded-Encrypted: i=1; AJvYcCUdF2OslA1bgCRrV8Vaiab7qQjcMEtcNE5qalpu2KGB7mXhBcoHLfvhDmdKY12GUwkJVwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw39ivoAjQivgK4poeVHbnrTBao7BNu4UfHy/kWJakW/6qYq2k
	aQTqGs4Ri3wWI7LJ+wfg9YIJxvAl6oGxk7qphU4t0svdqyjPYppOv23i19+vWlCrFfEl5Xnq4pR
	v2EUOiaRLOjluXt/RGFS49CXK2nb8d8zXFV657b4=
X-Gm-Gg: ASbGncvR+cVmz4DNvW8JJBUhFmcf9UDK2Xe5Aumphad1CQp2SorGpnUe4KYsUWHwr9g
	qbLmJBQFF3+A9LHMVwoNmluBXb+pplUf2RHd3VlmlWA/bUbaU2dqY7uyI0iM3ggXjKnx6hFEMa1
	nr/RrKeW6tMeWG3ytoOy2v2n2W9wDly5a3IfQ+a1vKt3k5ezxyFIg6u0HlKsUAYjsLRqLGKFZgg
	uipeYmTNMWsw+tCb4q47ayUnYDVXwvF8qihUXuKYMj2OKl03CvNtPdHFcB/WTmi4Amrjbw=
X-Google-Smtp-Source: AGHT+IF3k88LUWABPDfUYC3vs9PAoLPKuXKyHNtWKF4Vso3FFmyJXSrzwOxEZx6JM4j+ZKookkvH20EoB6u/KrLJ9zE=
X-Received: by 2002:a05:6e02:1809:b0:430:ce86:1208 with SMTP id
 e9e14a558f8ab-430ce861345mr134703585ab.28.1760942544967; Sun, 19 Oct 2025
 23:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
In-Reply-To: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 20 Oct 2025 14:41:47 +0800
X-Gm-Features: AS18NWBKDrWBgCLQcGNm5Atj6LjXmOd5IK4c_uT5YzI7CPktptQ5PqesskT18zk
Message-ID: <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: mc36 <csmate@nop.hu>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 1118437@bugs.debian.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 20, 2025 at 12:50=E2=80=AFPM mc36 <csmate@nop.hu> wrote:
>
> hi,
>
> freertr.org xsk dataplane is triggering a null pointer de-reference after=
 sending
>
> a single ip packet from user space to an xsk socket bound to a veth inter=
face.
>
> the same code works fine when using physical interfaces to send packets t=
o...
>
> it does not matter if an ip address is assigned to the veth pair or not..=
.
>
> please find below the reproducer code with some comments on how to use it=
...
>
> tldr: create a veth pair, bring them up, compile and run the c code...
>
> this happens 10/10 on host or in qemu-system-x86_64-kvm running 6.16.12 o=
r 6.17.2...

Thanks for the report.

I'm wondering if you have time to bisect which recent commit has
brought this problem. It looks like it never happens before 6.16?

Thanks,
Jason

>
> if it does not belongs here, just let me know....
>
> have a nice day,
>
> csaba
>
>
> ------------------------------------------------------[cut]--------------=
-------------------------------------------
>
>
> p4emu login: [  119.074634] BUG: kernel NULL pointer dereference, address=
: 0000000000000000
> [  119.076747] #PF: supervisor read access in kernel mode
> [  119.078334] #PF: error_code(0x0000) - not-present page
> [  119.079855] PGD 0 P4D 0
> [  119.080648] Oops: Oops: 0000 [#1] SMP NOPTI
> [  119.081993] CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12=
+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> [  119.085247] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-debian-1.17.0-1 04/01/2014
> [  119.088065] RIP: 0010:xsk_destruct_skb+0xd0/0x180
> [  119.089502] Code: 40 10 48 89 cf 89 28 e8 9e 7e 07 00 48 89 df 48 83 c=
4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c8 cc da ff 48 8b 7b 30 4c 8d 5b 30 <=
48> 8b 07 4c 8d 67 f8 4c 8d 70
> f8 49 39 fb 74 b7 48 89 5c 24 10 4c
> [  119.094947] RSP: 0018:ffffcd5b4012cd48 EFLAGS: 00010002
> [  119.096499] RAX: ffffcd5b40fcf000 RBX: ffff898e05dfcf00 RCX: ffff898e0=
43cf9e8
> [  119.098612] RDX: ffff898e048ccc80 RSI: 0000000000000246 RDI: 000000000=
0000000
> [  119.100687] RBP: 0000000000000001 R08: 0000000000000000 R09: ffff898e0=
1d21900
> [  119.102794] R10: 0000000000000000 R11: ffff898e05dfcf30 R12: ffff898e0=
5f95000
> [  119.104880] R13: ffff898e043cf900 R14: ffff898e7dd32bd0 R15: 000000000=
0000002
> [  119.107000] FS:  00007f0cd9e0a6c0(0000) GS:ffff898ede530000(0000) knlG=
S:0000000000000000
> [  119.109358] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  119.111080] CR2: 0000000000000000 CR3: 00000000043ba003 CR4: 000000000=
0372ef0
> [  119.113175] Call Trace:
> [  119.113996]  <IRQ>
> [  119.114662]  ? napi_complete_done+0x7a/0x1a0
> [  119.115952]  ip_rcv_core+0x1bb/0x340
> [  119.117050]  ip_rcv+0x30/0x1f0
> [  119.118014]  __netif_receive_skb_one_core+0x85/0xa0
> [  119.119468]  process_backlog+0x87/0x130
> [  119.120617]  __napi_poll+0x28/0x180
> [  119.121685]  net_rx_action+0x339/0x420
> [  119.122850]  handle_softirqs+0xdc/0x320
> [  119.124003]  ? handle_edge_irq+0x90/0x1e0
> [  119.125218]  do_softirq.part.0+0x3b/0x60
> [  119.126422]  </IRQ>
> [  119.127085]  <TASK>
> [  119.127753]  __local_bh_enable_ip+0x60/0x70
> [  119.128998]  __dev_direct_xmit+0x14e/0x1f0
> [  119.130128]  __xsk_generic_xmit+0x482/0xb70
> [  119.131184]  ? __remove_hrtimer+0x41/0xa0
> [  119.132199]  ? __xsk_generic_xmit+0x51/0xb70
> [  119.133300]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> [  119.134637]  xsk_sendmsg+0xda/0x1c0
> [  119.135580]  __sys_sendto+0x1ee/0x200
> [  119.136509]  __x64_sys_sendto+0x24/0x30
> [  119.137493]  do_syscall_64+0x84/0x2f0
> [  119.138452]  ? __pfx_pollwake+0x10/0x10
> [  119.139454]  ? __rseq_handle_notify_resume+0xad/0x4c0
> [  119.140718]  ? restore_fpregs_from_fpstate+0x3c/0x90
> [  119.141999]  ? switch_fpu_return+0x5b/0xe0
> [  119.143023]  ? do_syscall_64+0x204/0x2f0
> [  119.144007]  ? do_syscall_64+0x204/0x2f0
> [  119.144990]  ? do_syscall_64+0x204/0x2f0
> [  119.146022]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  119.147278] RIP: 0033:0x7f0cde0a49ee
> [  119.148217] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 8=
9 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <=
c3> 66 2e 0f 1f 84 00 00 00 00
> 00 0f 1f 80 00 00 00 00 48 83 ec 08
> [  119.152877] RSP: 002b:00007f0cd9e09c98 EFLAGS: 00000246 ORIG_RAX: 0000=
00000000002c
> [  119.154774] RAX: ffffffffffffffda RBX: 00007f0cd9e0a6c0 RCX: 00007f0cd=
e0a49ee
> [  119.156526] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000029
> [  119.158317] RBP: 0000000000000005 R08: 0000000000000000 R09: 000000000=
0000000
> [  119.160078] R10: 0000000000000040 R11: 0000000000000246 R12: 000000000=
0000405
> [  119.161893] R13: 00007f0ccc055ce0 R14: 0000000000000001 R15: 00007f0cd=
e8db900
> [  119.163646]  </TASK>
> [  119.164243] Modules linked in: veth intel_rapl_msr intel_rapl_common i=
osf_mbi binfmt_misc kvm_intel kvm irqbypass ghash_clmulni_intel sha512_ssse=
3 sha1_ssse3 aesni_intel rapl
> button evdev sg efi_pstore configfs nfnetlink vsock_loopback vmw_vsock_vi=
rtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg i=
p_tables x_tables autofs4 sd_mod
> sr_mod cdrom ata_generic ata_piix libata virtio_net scsi_mod net_failover=
 serio_raw failover scsi_common
> [  119.174216] CR2: 0000000000000000
> [  119.175068] ---[ end trace 0000000000000000 ]---
> [  119.176224] RIP: 0010:xsk_destruct_skb+0xd0/0x180
> [  119.177432] Code: 40 10 48 89 cf 89 28 e8 9e 7e 07 00 48 89 df 48 83 c=
4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c8 cc da ff 48 8b 7b 30 4c 8d 5b 30 <=
48> 8b 07 4c 8d 67 f8 4c 8d 70
> f8 49 39 fb 74 b7 48 89 5c 24 10 4c
> [  119.182155] RSP: 0018:ffffcd5b4012cd48 EFLAGS: 00010002
> [  119.183462] RAX: ffffcd5b40fcf000 RBX: ffff898e05dfcf00 RCX: ffff898e0=
43cf9e8
> [  119.185237] RDX: ffff898e048ccc80 RSI: 0000000000000246 RDI: 000000000=
0000000
> [  119.187022] RBP: 0000000000000001 R08: 0000000000000000 R09: ffff898e0=
1d21900
> [  119.188872] R10: 0000000000000000 R11: ffff898e05dfcf30 R12: ffff898e0=
5f95000
> [  119.190693] R13: ffff898e043cf900 R14: ffff898e7dd32bd0 R15: 000000000=
0000002
> [  119.192655] FS:  00007f0cd9e0a6c0(0000) GS:ffff898ede530000(0000) knlG=
S:0000000000000000
> [  119.194681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  119.196244] CR2: 0000000000000000 CR3: 00000000043ba003 CR4: 000000000=
0372ef0
> [  119.198034] Kernel panic - not syncing: Fatal exception in interrupt
> [  119.199761] Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
> [  119.202403] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---
>
>
> ------------------------------------------------------[cut]--------------=
-------------------------------------------
>
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
> #include <pthread.h>
> #include <arpa/inet.h>
> #include <sys/socket.h>
> #include <netinet/in.h>
> #include <poll.h>
> #include <linux/if_link.h>
> #include <xdp/xsk.h>
>
> ////// gcc xskInt.c -lxdp
> ////// sudo ip link add veth1 type veth
> ////// sudo ip link set veth0 up
> ////// sudo ip link set veth1 up
> ////// sudo ./a.out
>
> void err(char*buf) {
>      printf("%s\n", buf);
>      _exit(1);
> }
>
>
>
>
> int main(int argc, char **argv) {
>
>      int bpf_flag =3D XDP_FLAGS_SKB_MODE;
>
>      char ifaceName[] =3D "veth0";
>      printf("opening interface %s\n", ifaceName);
>
> #define framesNum 1024
>
> struct xsk_umem *ifaceUmem;
> struct xsk_socket *ifaceXsk;
> struct xsk_ring_prod ifaceFq;
> struct xsk_ring_cons ifaceCq;
> struct xsk_ring_cons ifaceRx;
> struct xsk_ring_prod ifaceTx;
> char *ifaceBuf;
> struct pollfd ifacePfd;
>
>      posix_memalign((void**)&ifaceBuf, getpagesize(), XSK_UMEM__DEFAULT_F=
RAME_SIZE * 2 * framesNum);
>      if (ifaceBuf =3D=3D NULL) err("error allocating buffer");
>
>      if (xsk_umem__create(&ifaceUmem, ifaceBuf, XSK_UMEM__DEFAULT_FRAME_S=
IZE * 2 * framesNum, &ifaceFq, &ifaceCq, NULL) !=3D 0) err("error creating =
umem");
>
>      struct xsk_socket_config cfg;
>      memset(&cfg, 0, sizeof(cfg));
>      cfg.rx_size =3D XSK_RING_CONS__DEFAULT_NUM_DESCS;
>      cfg.tx_size =3D XSK_RING_PROD__DEFAULT_NUM_DESCS;
>      cfg.xdp_flags =3D bpf_flag;
>      if (xsk_socket__create(&ifaceXsk, ifaceName, 0, ifaceUmem, &ifaceRx,=
 &ifaceTx, &cfg) !=3D 0) err("error creating xsk");
>
>      unsigned int i =3D 0;
>      xsk_ring_prod__reserve(&ifaceFq, framesNum, &i);
>      for (i=3D0; i < framesNum; i++) *xsk_ring_prod__fill_addr(&ifaceFq, =
i) =3D i * XSK_UMEM__DEFAULT_FRAME_SIZE;
>      xsk_ring_prod__submit(&ifaceFq, framesNum);
>
>      memset(&ifacePfd, 0, sizeof (ifacePfd));
>      ifacePfd.fd =3D xsk_socket__fd(ifaceXsk);
>      ifacePfd.events =3D POLLIN | POLLERR;
>
>      setgid(1);
>      setuid(1);
>      printf("serving others\n");
>
>
> unsigned char bufD[] =3D {0x3a, 0x10, 0x5c, 0x53, 0xb3, 0x5c, 0x0, 0x1e, =
0x11, 0x4c, 0x7e, 0x66, 0x8, 0x0, 0x45, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x0,=
 0xff, 0x1, 0xb7, 0xa0, 0x1, 0x1,
> 0x1, 0xd, 0x1, 0x1, 0x1, 0xe, 0x8, 0x0, 0xa5, 0xfd, 0x16, 0x3b, 0x3b, 0xc=
7, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
};
> int bufS =3D sizeof(bufD);
>
>          unsigned int idx;
>          idx =3D xsk_ring_cons__peek(&ifaceCq, 16, &idx);
>          xsk_ring_cons__release(&ifaceCq, idx);
>          if (xsk_ring_prod__reserve(&ifaceTx, 1, &idx) < 1) err("error ge=
tting index");
>          struct xdp_desc *dsc =3D xsk_ring_prod__tx_desc(&ifaceTx, idx);
>          dsc->addr =3D (framesNum + (idx % framesNum)) * XSK_UMEM__DEFAUL=
T_FRAME_SIZE;
>          dsc->options =3D 0;
>          dsc->len =3D bufS;
>          memcpy(ifaceBuf + dsc->addr, bufD, bufS);
>          xsk_ring_prod__submit(&ifaceTx, 1);
>          if (!xsk_ring_prod__needs_wakeup(&ifaceTx)) err("error waking up=
");
>          sendto(xsk_socket__fd(ifaceXsk), NULL, 0, MSG_DONTWAIT, NULL, 0)=
;
>
>      sleep(10);
> }
>
>

