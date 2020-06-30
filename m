Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54DE20F7F1
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 17:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbgF3PLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgF3PLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 11:11:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD35C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:11:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so15827359qts.5
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:message-id:date
         :to;
        bh=KQ6gr29d/5+jXmz6sVRFgEVXBkDgsGJg63eNJKo4rkM=;
        b=nEowNO0xC7cTbD41ouWF/XhQZq0L4hS2iYt4UkkHPhU0uo1ZVqSwTTY7SuY0/fFhd5
         rT16zgpz8JDN9dcsxvFwY07ogTdUAXciV5tvJfbxO6YW+Wkk0TtJJtfZrYqb1SX50Zkz
         Zvi15/PFlk92bBnHwU2JdgXpKGtE5hAZ9zKZ1RPMV9Xq+BpxqPDkbXKNn6g80Ypxh5Nv
         0WG/JPVctIXI44EYF46/e+XpPPacRAZVEyQAILgFOmJfICkNZ7CJsPlXqN/Ryr2QNp4q
         hE1b8CteCJFmBxSYam4zxWDjHmaK/Kn1LJirOMIFOo24JCf4PoU7H6v0s7Bwd64IHah0
         k8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:message-id:date:to;
        bh=KQ6gr29d/5+jXmz6sVRFgEVXBkDgsGJg63eNJKo4rkM=;
        b=fzE9sX/KskE5TFsVm4xdP5qWDVcfQUHNoDUo3kFq7vc799ZsuuPNo1/E+sRick6rpQ
         DuMyhuOixft7e8gwMlKBVe+Bed4l3TxorlMklOe/M1InrqCwUipqB42hqy3Zc+for4h1
         T9zv5+ZIKnwt1aSn0/AMIUxDYZuw1q0DBFpn0Gb/NALWQ+ehQ0mok7A11gOome9wa3uL
         WSU3hB8THlP4gjnCdIm4Qzi9ezx2C1dgjvOmGdUICFJTB3MWS75Du8Cs5hhPIvJ5KLm5
         vNYqxAZ0qFdxOs5wObT7qoSDEzRXMBtvG1GsRIPd8JDFC+S8HrIQUkqJeiBku+SrSNel
         tKBg==
X-Gm-Message-State: AOAM533I4QdzvWo0ArrP9eZrLrZpQTNjbI/AFnoaCr/KckH08K8ADD4r
        qNjYUjMhtjYMSNEwMI3YpZoidmTAOQ==
X-Google-Smtp-Source: ABdhPJz8tJ71R2JwLQ5W6eqTXAMp+iQP3TCTxZE9219Xm5hwUnKti8+W6GlzlSAEombIzFj+5ZoJ0g==
X-Received: by 2002:ac8:1bad:: with SMTP id z42mr22039848qtj.110.1593529881250;
        Tue, 30 Jun 2020 08:11:21 -0700 (PDT)
Received: from [10.6.1.102] ([212.102.33.102])
        by smtp.gmail.com with ESMTPSA id j52sm3501311qtc.49.2020.06.30.08.11.18
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 08:11:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Rudi Ratloser <reimth@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re:  BUG: kernel NULL pointer dereference in __cgroup_bpf_run_filter_skb
Message-Id: <92DF6A0A-6EFD-4D5A-B2A4-367ADB8B4979@gmail.com>
Date:   Tue, 30 Jun 2020 17:11:17 +0200
To:     bpf@vger.kernel.org
X-Mailer: iPhone Mail (17A878)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=EF=BB=BF
> We have experienced a kernel BPF null pointer dereference issue on all
> our machines since mid of June. It might be related to an upgrade of
> libvirt/kvm/qemu at that point of time. But we=E2=80=99re not sure.
...
> We experienced the kernel freeze on following Arch Linux kernels:
> - 5.7.0 (5.7.0-3-MANJARO x64)
> - 5.6.16 (5.6.16-1-MANJARO x64)
> - 5.4.44 (5.4.44-1-MANJARO x64)
> - 4.19.126 (4.19.126-1-MANJARO x64)
> - 4.14.183 (4.14.183-1-MANJARO x64)
> Kernel configs can be taken from https://gitlab.manjaro.org/packages/core.=

>=20
> Subsequent e-mails will contain the relevant extracts from journal or
> netconsole logs.

Kernel 5.7.0 (5.7.0-3-MANJARO x64)

BUG: kernel NULL pointer dereference, address: 0000000000000010
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 1 PID: 1132 Comm: nfsd Not tainted 5.7.0-3-MANJARO #1
Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
RIP: 0010:__cgroup_bpf_run_filter_skb+0x196/0x230
Code: 48 89 73 18 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 31 c0 c3 c3 e=
8 d8 cb ec ff e8 93 12 f2 ff 48 8b 85 38 06 00 00 31 ed <48> 8b 78 10 4c 8d 7=
0 10 48 85 ff 74 34 49 8b 46 08 65 48 89 05 01
RSP: 0018:ffffaddac09eba20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff93e20832d0e0 RCX: 0000000000000034
RDX: 0000000000000000 RSI: ffff93e1f0af0000 RDI: ffffffff9b7f6888
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff93e20fe80000(0000) knlGS:0000000000000000=

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 00000003d158e004 CR4: 00000000001626e0
Call Trace:
ip_finish_output+0x68/0xa0
ip_output+0x76/0x130
? __ip_finish_output+0x1e0/0x1e0
__ip_queue_xmit+0x186/0x440
? __switch_to_asm+0x34/0x70
? __switch_to_asm+0x40/0x70
__tcp_transmit_skb+0x53e/0xbf0
? __switch_to_asm+0x34/0x70
tcp_write_xmit+0x391/0x11b0
__tcp_push_pending_frames+0x32/0xf0
tcp_sendmsg_locked+0xa3c/0xb50
tcp_sendmsg+0x28/0x40
sock_sendmsg+0x57/0x60
xprt_sock_sendmsg+0xe8/0x2b0 [sunrpc]
? nfsd_destroy+0x60/0x60 [nfsd]
svc_tcp_sendto+0x77/0xd0 [sunrpc]
svc_send+0x80/0x1f0 [sunrpc]
nfsd+0xed/0x150 [nfsd]
kthread+0x13e/0x160
? __kthread_bind_mask+0x60/0x60
ret_from_fork+0x35/0x40
Modules linked in: rpcsec_gss_krb5 scsi_transport_iscsi veth xt_CHECKSUM vho=
st_net vhost tap vhost_iotlb tun ebtable_filter ebtables ip6table_filter ip6=
_tables xt_MASQUERADE xt_recent xt_comment ipt_REJECT nf_reject_ipv4 xt_addr=
type br_netfilter xt_physdev iptable_nat xt_mark iptable_mangle xt_TCPMSS xt=
_hashlimit xt_tcpudp xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_l=
og xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic n=
f_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323 nf_nat_ftp nf=
_nat_amanda ts_kmp nf_conntrack_amanda nf_nat nf_conntrack_sane nf_conntrack=
_tftp nf_conntrack_sip nf_conntrack_pptp nf_conntrack_netlink nfnetlink nf_c=
onntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h32=
3 nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter=
 bridge stp llc fuse nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat inte=
l_rapl_msr intel_rapl_common snd_hda_codec_hdmi x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pcl=
mul ghash_clmulni_intel ofpart cmdlinepart intel_spi_platform intel_spi mei_=
hdcp i915 eeepc_wmi spi_nor asus_wmi mtd iTCO_wdt iTCO_vendor_support batter=
y snd_hda_codec_realtek sparse_keymap wmi_bmof rfkill snd_hda_codec_generic a=
esni_intel ledtrig_audio crypto_simd snd_hda_intel snd_intel_dspcfg cryptd g=
lue_helper i2c_algo_bit snd_hda_codec intel_cstate intel_uncore snd_hda_core=
 snd_hwdep drm_kms_helper r8169 intel_rapl_perf snd_pcm joydev realtek i2c_i=
801 libphy snd_timer mousedev cec snd rc_core mei_me input_leds intel_gtt sy=
scopyarea sysfillrect e1000e lpc_ich sysimgblt mei soundcore fb_sys_fops wmi=
 evdev mac_hid nfsd usbip_host drm usbip_core nfs_acl auth_rpcgss lockd grac=
e uinput crypto_user sunrpc agpgart ip_tables x_tables ext4 crc16 mbcache jb=
d2 hid_logitech_hidpp hid_logitech_dj hid_generic usbhid hid dm_thin_pool dm=
_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio dm_mod
crc32c_intel sr_mod cdrom xhci_pci xhci_hcd ehci_pci ehci_hcd
CR2: 0000000000000010
---[ end trace 6fe9bf5a0db7a0b9 ]---
RIP: 0010:__cgroup_bpf_run_filter_skb+0x196/0x230
Code: 48 89 73 18 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 31 c0 c3 c3 e=
8 d8 cb ec ff e8 93 12 f2 ff 48 8b 85 38 06 00 00 31 ed <48> 8b 78 10 4c 8d 7=
0 10 48 85 ff 74 34 49 8b 46 08 65 48 89 05 01
RSP: 0018:ffffaddac09eba20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff93e20832d0e0 RCX: 0000000000000034
RDX: 0000000000000000 RSI: ffff93e1f0af0000 RDI: ffffffff9b7f6888
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff93e20fe80000(0000) knlGS:0000000000000000=

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 00000003d158e004 CR4: 00000000001626e0
note: nfsd[1132] exited with preempt_count 1
-- Reboot --
