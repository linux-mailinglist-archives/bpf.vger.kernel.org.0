Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C826A2EC222
	for <lists+bpf@lfdr.de>; Wed,  6 Jan 2021 18:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbhAFR1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jan 2021 12:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbhAFR1N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5621BC061575
        for <bpf@vger.kernel.org>; Wed,  6 Jan 2021 09:26:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h205so8283210lfd.5
        for <bpf@vger.kernel.org>; Wed, 06 Jan 2021 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nw9pX4tKK4Xy+tAx1g21Bx3as/8D5yiXRppFnbFJZss=;
        b=JRgV/anS5j1XDczUUpuyh8Bi4P9fy/Ip4kmNBOL5xDt2GzB+4KRiAsQqw2DioCSN/o
         ALN/D0lixknWzwrVj7of75x5C7K8peeszG41Ms4jwsFQoTy6Z/ujK56FRyX1o0tifCcb
         qtRHATtx0Cq1o6t36zfVdiSRj9aZt3+7sM3JCLr4IIB01Pkj+cySo/Mb9NjuT+8Wzcsh
         YcYFdNAUA7J/VuN3dC4dPb33aHlVbWLX9Q9McR2OLClpZGQ9du/ISwGty7wgPSsQGise
         xX2B1pqC9LCmTkTrVzM3HleyPoKBed0yHzgkyIak2KprSONaKExKI5m3HLSfU7FP16pp
         P3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nw9pX4tKK4Xy+tAx1g21Bx3as/8D5yiXRppFnbFJZss=;
        b=i5FQmIn/2pERK4lpDH1qvLLq8pplBwjYWjA9zsrUpLmPGMkJLdmoATRkV8KdpeHB7y
         d8zzyvCsBp3Qi2kKyDdGtEFkkDy3+1b5SawqfKx1H3TLE4Rq8ihTyagvgwD1ia0PaIjx
         6cTlB8SUiJEFKybQQgHdJwvLWiRPwKTOWCD5o14KIRT34xj6lufTg6c1G9leFebACeQi
         Jqzagkc4ppG/+yckQsdBeoOJvjk0dPMShWch0zYn/s9HgKPwLlsXG+KYZCfaS3mgH0ZQ
         NqpEvlgJfe3IQnSZdbqSe7IRu7h5BDgbXMiwcWUBH//UBctwkUcVgnReHXjQbjZE07pa
         YIOQ==
X-Gm-Message-State: AOAM530hbgRnckGibXVNjOysMcMGnXfK70oWaYPhXZv9KeeBSQRwr2OA
        l3mN0XmKmN6nBP7UNFhMqjwhcSd+PeerOIqkHp8=
X-Google-Smtp-Source: ABdhPJwpkFS9oznKihGHEZ31dxDpBLQMyQqhknOigfH0gFGRVsEiU1DRpifo4Ol+hPD791KdRAwX3Vj0SdQbIX+HbxM=
X-Received: by 2002:ac2:5497:: with SMTP id t23mr2150995lfk.534.1609953991781;
 Wed, 06 Jan 2021 09:26:31 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com>
 <CANaYP3H0RfcRK=bnNbvnKWe7cvnf0XD36JGWJVTDNUjPtHk6Fg@mail.gmail.com>
In-Reply-To: <CANaYP3H0RfcRK=bnNbvnKWe7cvnf0XD36JGWJVTDNUjPtHk6Fg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Jan 2021 09:26:19 -0800
Message-ID: <CAADnVQKkixx3+WWqp5uQ2kxYK_AAx9NiMG38bvwKhgTKBsKWUg@mail.gmail.com>
Subject: Re: BPF Kernel OOPS - NULL pointer dereference
To:     Gilad Reti <gilad.reti@gmail.com>, KP Singh <kpsingh@google.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 6, 2021 at 2:18 AM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> Hello all,
>
> Hope you had a great new year vacation.
>
> Sorry for bumping up the thread, but I believe that it is an important one.

Thanks for bumping.
KP, please take a look.

> On Sun, Dec 20, 2020 at 12:16 PM Gilad Reti <gilad.reti@gmail.com> wrote:
> >
> > Hello there,
> >
> > During experimenting with the new inode local storage I have stumbled
> > across an invalid pointer dereference that passed through the
> > verifier.
> >
> > After investigating, I think that it happens in the
> > bpf_inode_storage_get helper, and in particular in the following line:
> > https://elixir.bootlin.com/linux/v5.10.1/source/include/linux/bpf_lsm.h#L32
> >
> > I have a single bpf lsm probe in the security_inode_rename probe, and
> > I have called bpf_inode_storage_get on the inode of the "new_dentry"
> > argument. This inode may be null in cases where renameat(2) is called
> > to move a file from one path to a new path which didn't exist before.
> >
> > As can be seen, inode is dereferenced without first checking that it
> > is not NULL.
> > I don't know what should be the correct behavior, but I believe that
> > either the helper should check the validity of passed pointers, or the
> > verifier should treat fields of BTF pointers (PTR_TO_BTF_ID) as
> > PTR_TO_BTF_ID_OR_NULL.
> >
> > I am attaching a minimal program example, along with the kernel demsg
> > output. To reproduce, load the probe and run "mv file1 file2" where
> > file2 does not exist.
> >
> > Thanks,
> > Gilad Reti
> >
> > inode_oops.c:
> >
> > // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > /* Copyright (c) 2020 Facebook */
> > #include <argp.h>
> > #include <signal.h>
> > #include <stdio.h>
> > #include <time.h>
> > #include <unistd.h>
> > #include <sys/resource.h>
> > #include <bpf/libbpf.h>
> >
> > #include "inode_oops.skel.h"
> >
> > static volatile bool exiting = false;
> >
> > static void sig_handler(int sig)
> > {
> >     exiting = true;
> > }
> >
> > int main(int argc, char **argv)
> > {
> >     struct inode_oops_bpf *skel;
> >
> >     int err;
> >
> >     /* Cleaner handling of Ctrl-C */
> >     signal(SIGINT, sig_handler);
> >     signal(SIGTERM, sig_handler);
> >
> >     /* Load and verify BPF application */
> >     skel = inode_oops_bpf__open_and_load();
> >     if (!skel)
> >     {
> >         fprintf(stderr, "Failed to open and load BPF skeleton\n");
> >         goto cleanup;
> >     }
> >
> >     /* Attach tracepoints */
> >     err = inode_oops_bpf__attach(skel);
> >     if (err)
> >     {
> >         fprintf(stderr, "Failed to attach BPF skeleton\n");
> >         goto cleanup;
> >     }
> >
> >     while (!exiting)
> >     {
> >     }
> > cleanup:
> >     /* Clean up */
> >     inode_oops_bpf__destroy(skel);
> >
> >     return err < 0 ? -err : 0;
> > }
> >
> > inode_oops.bpf.c
> >
> > #include "vmlinux.h"
> > #include <bpf/bpf_core_read.h>
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_tracing.h>
> >
> > struct dummy_storage
> > {
> >     __u32 value;
> > };
> >
> > struct
> > {
> >     __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
> >     __uint(map_flags, BPF_F_NO_PREALLOC);
> >     __type(key, int);
> >     __type(value, struct dummy_storage);
> > } inode_storage_map SEC(".maps");
> >
> > SEC("lsm/inode_rename")
> > int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
> >              struct inode *new_dir, struct dentry *new_dentry,
> >              unsigned int flags)
> > {
> >
> >     bpf_inode_storage_get(&inode_storage_map, new_dentry->d_inode, 0,
> > BPF_LOCAL_STORAGE_GET_F_CREATE);
> >
> >     return 0;
> > }
> >
> > Dmesg -T:
> >
> > [Thu Dec 17 11:35:37 2020] BUG: kernel NULL pointer dereference,
> > address: 0000000000000038
> > [Thu Dec 17 11:35:37 2020] #PF: supervisor read access in kernel mode
> > [Thu Dec 17 11:35:37 2020] #PF: error_code(0x0000) - not-present page
> > [Thu Dec 17 11:35:37 2020] PGD 0 P4D 0
> > [Thu Dec 17 11:35:37 2020] Oops: 0000 [#1] SMP PTI
> > [Thu Dec 17 11:35:37 2020] CPU: 0 PID: 4437 Comm: bash Not tainted 5.10.0 #17
> > [Thu Dec 17 11:35:37 2020] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> > [Thu Dec 17 11:35:37 2020] RIP: 0010:bpf_inode_storage_get+0x1f/0xa0
> > [Thu Dec 17 11:35:37 2020] Code: 65 f8 c9 c3 0f 1f 80 00 00 00 00 0f
> > 1f 44 00 00 48 f7 c1 fe ff ff ff 74 03 31 c0 c3 55 48 89 e5 41 56 41
> > 55 41 54 49 89 f4 53 <48> 8b 46 38 48 85 c0 74 41 49 89 d6 48 63 15 e6
> > d7 28 01 48 01 d0
> > [Thu Dec 17 11:35:37 2020] RSP: 0018:ffff9866433335f8 EFLAGS: 00010246
> > [Thu Dec 17 11:35:37 2020] RAX: 0000000000000000 RBX: 0000000000000001
> > RCX: 0000000000000000
> > [Thu Dec 17 11:35:37 2020] RDX: 0000000000000000 RSI: 0000000000000000
> > RDI: ffff8959e2db9e00
> > [Thu Dec 17 11:35:37 2020] RBP: ffff986643333618 R08: 0000000000000007
> > R09: 0000000000000003
> > [Thu Dec 17 11:35:37 2020] R10: ffff9866433336c3 R11: 0000000000000000
> > R12: 0000000000000000
> > [Thu Dec 17 11:35:37 2020] R13: ffff8959e2373428 R14: ffff8959e24b3d40
> > R15: 0000000000000008
> > [Thu Dec 17 11:35:37 2020] FS:  00007fa878948740(0000)
> > GS:ffff895cede00000(0000) knlGS:0000000000000000
> > [Thu Dec 17 11:35:37 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [Thu Dec 17 11:35:37 2020] CR2: 0000000000000038 CR3: 0000000121f34001
> > CR4: 00000000003706f0
> > [Thu Dec 17 11:35:37 2020] Call Trace:
> > [Thu Dec 17 11:35:37 2020]  bpf_prog_f2cb36e361a3c858_inode_rename+0x88c/0xf38
> > [Thu Dec 17 11:35:37 2020]  ? security_capable+0x3d/0x60
> > [Thu Dec 17 11:35:37 2020]  ? from_kgid+0x12/0x20
> > [Thu Dec 17 11:35:37 2020]  ? capable_wrt_inode_uidgid+0x6f/0x80
> > [Thu Dec 17 11:35:37 2020]  bpf_trampoline_22333+0x30/0x1000
> > [Thu Dec 17 11:35:37 2020]  bpf_lsm_inode_rename+0x5/0x10
> > [Thu Dec 17 11:35:37 2020]  ? security_inode_rename+0x88/0xb0
> > [Thu Dec 17 11:35:37 2020]  vfs_rename+0x11b/0xb60
> > [Thu Dec 17 11:35:37 2020]  ovl_copy_up_one+0x461/0xfc0 [overlay]
> > [Thu Dec 17 11:35:37 2020]  ? remove_wait_queue+0x47/0x50
> > [Thu Dec 17 11:35:37 2020]  ? fput+0x13/0x20
> > [Thu Dec 17 11:35:37 2020]  ? poll_freewait+0x4a/0xa0
> > [Thu Dec 17 11:35:37 2020]  ovl_copy_up_flags+0xb0/0xf0 [overlay]
> > [Thu Dec 17 11:35:37 2020]  ovl_copy_up+0x10/0x20 [overlay]
> > [Thu Dec 17 11:35:37 2020]  ovl_create_or_link+0x40/0x8c0 [overlay]
> > [Thu Dec 17 11:35:37 2020]  ? security_inode_alloc+0x4b/0x90
> > [Thu Dec 17 11:35:37 2020]  ? inode_init_always+0x137/0x210
> > [Thu Dec 17 11:35:37 2020]  ? alloc_inode+0x35/0xc0
> > [Thu Dec 17 11:35:37 2020]  ? new_inode+0x74/0xc0
> > [Thu Dec 17 11:35:37 2020]  ovl_create_object+0xe1/0x110 [overlay]
> > [Thu Dec 17 11:35:37 2020]  ovl_create+0x23/0x30 [overlay]
> > [Thu Dec 17 11:35:37 2020]  path_openat+0xdec/0x1130
> > [Thu Dec 17 11:35:37 2020]  ? __check_object_size+0x13f/0x150
> > [Thu Dec 17 11:35:37 2020]  do_filp_open+0x8c/0x130
> > [Thu Dec 17 11:35:37 2020]  ? __check_object_size+0x13f/0x150
> > [Thu Dec 17 11:35:37 2020]  do_sys_openat2+0x9b/0x150
> > [Thu Dec 17 11:35:37 2020]  __x64_sys_openat+0x56/0x90
> > [Thu Dec 17 11:35:37 2020]  do_syscall_64+0x38/0x90
> > [Thu Dec 17 11:35:37 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [Thu Dec 17 11:35:37 2020] RIP: 0033:0x7fa878018d5e
> > [Thu Dec 17 11:35:37 2020] Code: 25 00 00 41 00 3d 00 00 41 00 74 48
> > 48 8d 05 91 0c 2e 00 8b 00 85 c0 75 69 89 f2 b8 01 01 00 00 48 89 fe
> > bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 a6 00 00 00 48 8b 4c 24
> > 28 64 48 33 0c 25
> > [Thu Dec 17 11:35:37 2020] RSP: 002b:00007ffead706e80 EFLAGS: 00000246
> > ORIG_RAX: 0000000000000101
> > [Thu Dec 17 11:35:37 2020] RAX: ffffffffffffffda RBX: 0000557d910892e0
> > RCX: 00007fa878018d5e
> > [Thu Dec 17 11:35:37 2020] RDX: 0000000000000241 RSI: 0000557d910892e0
> > RDI: 00000000ffffff9c
> > [Thu Dec 17 11:35:37 2020] RBP: 0000000000000001 R08: 00007fa8782f68b0
> > R09: 00007fa878948740
> > [Thu Dec 17 11:35:37 2020] R10: 0000000000000180 R11: 0000000000000246
> > R12: 0000000000000000
> > [Thu Dec 17 11:35:37 2020] R13: 00007ffead707150 R14: 0000557d8f8cfcc0
> > R15: 0000000000000000
> > [Thu Dec 17 11:35:37 2020] Modules linked in: xt_nat veth vxlan
> > ip6_udp_tunnel udp_tunnel xt_policy xt_mark xt_u32 xt_tcpudp
> > xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo
> > nft_counter xt_addrtype nft_compat nft_chain_nat nf_nat nf_conntrack
> > nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c nfnetlink
> > br_netfilter bridge stp llc intel_rapl_msr intel_rapl_common
> > crct10dif_pclmul ghash_clmulni_intel snd_ens1371 overlay aesni_intel
> > crypto_simd snd_ac97_codec vmw_balloon cryptd vsock_loopback gameport
> > vmw_vsock_virtio_transport_common ac97_bus glue_helper snd_pcm
> > vmw_vsock_vmci_transport vsock rapl snd_seq_midi snd_seq_midi_event
> > snd_rawmidi snd_seq joydev input_leds serio_raw snd_seq_device
> > snd_timer binfmt_misc snd soundcore vmw_vmci mac_hid sch_fq_codel
> > vmwgfx ttm drm_kms_helper cec rc_core drm fb_sys_fops syscopyarea
> > sysfillrect sysimgblt parport_pc ppdev lp parport ip_tables x_tables
> > autofs4 hid_generic usbhid hid psmouse mptspi crc32_pclmul mptscsih
> > mptbase e1000 i2c_piix4 pata_acpi
> > [Thu Dec 17 11:35:37 2020]  ahci libahci scsi_transport_spi
> > [Thu Dec 17 11:35:37 2020] CR2: 0000000000000038
> > [Thu Dec 17 11:35:37 2020] ---[ end trace fe83c4e3d6415215 ]---
> > [Thu Dec 17 11:35:37 2020] RIP: 0010:bpf_inode_storage_get+0x1f/0xa0
> > [Thu Dec 17 11:35:37 2020] Code: 65 f8 c9 c3 0f 1f 80 00 00 00 00 0f
> > 1f 44 00 00 48 f7 c1 fe ff ff ff 74 03 31 c0 c3 55 48 89 e5 41 56 41
> > 55 41 54 49 89 f4 53 <48> 8b 46 38 48 85 c0 74 41 49 89 d6 48 63 15 e6
> > d7 28 01 48 01 d0
> > [Thu Dec 17 11:35:37 2020] RSP: 0018:ffff9866433335f8 EFLAGS: 00010246
> > [Thu Dec 17 11:35:37 2020] RAX: 0000000000000000 RBX: 0000000000000001
> > RCX: 0000000000000000
> > [Thu Dec 17 11:35:37 2020] RDX: 0000000000000000 RSI: 0000000000000000
> > RDI: ffff8959e2db9e00
> > [Thu Dec 17 11:35:37 2020] RBP: ffff986643333618 R08: 0000000000000007
> > R09: 0000000000000003
> > [Thu Dec 17 11:35:37 2020] R10: ffff9866433336c3 R11: 0000000000000000
> > R12: 0000000000000000
> > [Thu Dec 17 11:35:37 2020] R13: ffff8959e2373428 R14: ffff8959e24b3d40
> > R15: 0000000000000008
> > [Thu Dec 17 11:35:37 2020] FS:  00007fa878948740(0000)
> > GS:ffff895cede00000(0000) knlGS:0000000000000000
> > [Thu Dec 17 11:35:37 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [Thu Dec 17 11:35:37 2020] CR2: 0000000000000038 CR3: 0000000121f34001
> > CR4: 00000000003706f0
