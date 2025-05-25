Return-Path: <bpf+bounces-58911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E0AC3755
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 00:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6AF3B3C5C
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 22:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849841C4A20;
	Sun, 25 May 2025 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="n+UZrT8i"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D113A86C;
	Sun, 25 May 2025 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748213316; cv=none; b=Cw4qZaQgBd3ak4Spogcj2lCyYSi6RLV7kiAl3RXXiYSW8cUpQK5849y+FYBm3QjY0YngW+UnPMoH+mqmaMz21ddtdp2jvp8pITx3Ynq+kHftoaT/0uW8Q3pL+Wh/igoVPRcnNTVeiJc1ITQCv4keL7HEWOiUCPtA4m1BzzxxmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748213316; c=relaxed/simple;
	bh=OthrtTMefQvAmwKEN7u6uegZMX5JD/Op86AbCwXJEQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHP5Q9iIOseHBODIv7ixFQvobFhWOHoQ0B8tbNeH3CrCP2415zpM+s5AhgZHzW7n1+cWdEN09VJVDcTRZZBjOix5Qjw/BlvSJKUKcPCqnbDj9HkiRtGLLUrvJYDbiMccYB8mPQjXv5WjBoCFF4UtQjQD7a311s/Ns39KJh+9K5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=n+UZrT8i; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748213266; x=1748818066; i=spasswolf@web.de;
	bh=0kJ761GxaFPwhvyiSXXAZNhysEl6OjbO0LYFyeNUTIs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n+UZrT8iAGDE+F+xC31MDCeFjFp0h9slpYnOd8NZ30skCiH/l/83UJWSkumKzatm
	 FewDSR9VQKnIpuMZI/pH6YruvT7MDopfU58RNUpyC+gOUbssHa5llz907yOLT9Ouj
	 ue0fJ/oAQNaPwOGEFwH+HV7DZnaQc7/W87Y9RhcRvItBl4u3mLE5cJfdQLc2R+k7H
	 bi7lyYZmLpZrE28EYxuI30CkGo/NodElugUK5uJCPBYNXgH7BRReWHanxDcr85/52
	 B5D7rMWHQmrM/v9ZOzYbDhgB57SCT2rixFMDrIHnTnCM4tRc8/K2ymR4qUaFM7R7z
	 TvIZB279Maur687BCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N6K1l-1uymuO1dQP-011Czz; Mon, 26 May 2025 00:47:45 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>
Subject: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
Date: Mon, 26 May 2025 00:47:42 +0200
Message-ID: <20250525224744.9640-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: 20250525121424.15517-1-spasswolf@web.de
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lKOHuVzeVtkdutPs2gLShnV1kktJGAFWO860YMLuWYX+2bM5mt8
 NRbFV4iiife5P+dycriO4QrQZoZmNSit0wx4m7bzrBDY7s8ow9y+mcqQZbdQPjUNSERLdEi
 TaxMo6kYBy5VIcmPpnAEIcV1rj7jMGJadQ3mvQPSRTmHOepNs6+7rVQvf2MDfCnb6jM4XYD
 4C7sJUrh7mQTgZPacrBOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QR12uPAAG/Q=;757ZA1WTjOFASr5dGZCWH5Ku4gs
 PRwcEPVa4cu+ZCOixliv3VDbk4JNoRVLbwMLbDJyXOA8OHW1KXj4rs3Yk0DCEEqIi5gcsHuIU
 /vCO+PgWGp0TeH/KQ2k0U1LxKBpwvrvQ1q0QQEaSBBjFJbYrlUUrFuXpz1dtCOWDxx33q7sh6
 oPR6TVT/wGrFuiRiTaab+IfloamflH/v6piWTt5Q8bPAQobWmld+jKChypGREliI5DWxTFDHe
 ZrBZKJ2AkGj8edO4dqeo1jMVpQZoKyj30DoqGerjeOmrcWvV/TRT6p3wvthg4DqKvwZLEYbru
 ghJmONVGfEyEElM7HimxJGGrekW+UzgunMa80+9ETtlBrBW/Vr5goEvD485IjSqHJOzFi9mWL
 VfwAdYrnpxbqdxd8GKywdZEe+JndJ388urfg4MURaag0oloTw1Jtgqv+3ykpaMGTYz9rP6Vim
 utZ2cEbxMRG4EtuwKp9iiXpN/qWbBiuPbxB3MqQKTLsIioSxdNNgiIPPB293omBGuVeSiYD40
 4daEqI9NnO9AcGOpEXpCHhkJZytfoXqKQOECSDFjz4vZqStwLKbL1FFndXoVFeV2BmTpP3ikP
 CgFta46kh+H7ZbPoShd71yAGei3rty8cuAiw9OcW5Xe9RdZm9MTjQYaR3Eb6SbjYrbv12MYob
 sf8eaA1tRkJEQBP9/Q9Uakr1UzpCAH9KGsIhhRuH+/RH9uEEEI7VXHkWtuOHivpfcv1N6ivQs
 2RYmZK4qDrb1hpxI/c378QMHCM+yTWQztZiqO8NjjEkQECDrGgDa2lJeZf33kFDde8swbmiM/
 gUWurLgP28SX62Jk1fm7UK3LhOKDKsixBy3NnazG5Wb2HbaGiKiQI+JUyNOaJX/9tRTwE6VRo
 mgOoq4ml85KseiTyyjWIspPmeDw7I3ipM9SZmHK0mVUw4lCIKhyy72AF70dHYYW+Qt/c0peTr
 aoTF9lUT1h/cfpx6R7Vc3wOWEn4akInMdEeyLyX46FzfSLI8bEzTfjgBHzkG6tg2r/jznZKR0
 QV4zzgQFtX+k2UIkC6pXo1YF9k14UT8MDVja9SDrhvcOz6vc1A7OZ6DCSjZPa4e786Zwyf3bE
 YBDSCqQsfHEfULkvw4D7erh+9U4lNmisuulGU69fq7qTKJ4+aiKua1Bhly6fpt8JFEd2stazg
 rhnWMOp+PdQI7Eta5UgSlweOCpATsgSE6VmB9HAjBtfjmep6uVZzw3m/fTwwsYC7ApLUkLfOQ
 g0xoVs/ZAkt35fNGoVvCHz13ee5hV7xkiU8Wf+bZ59W4Ws49RC3QWSSf2Hrm06GsoihpubKD2
 z2lNWEMKnuOayDd9cA7gExtcgI+aGQRdUgIOkMmKrmbTJZreLIhLS2EIdBsYibt7+OQKQML2y
 r3qNyMyoHECpwCjvNzN9Z15Or1kHGWmek/zZwXgKH+mnakzKnYcxiT+gg2EPHr++qXnoEqlw+
 iNE3mVQ==

Now I've compiled next-2025023 with CONFIG_LOCKDEP=3Dy. This seems to avoid=
 the
lockups while still giving lots of warnings. Here are the warnings from one
run of tools/testing/selftests/bpf/test_progs:=20

[ T2899] bpf_testmod: loading out-of-tree module taints kernel.
[ T1113] wlp4s0: disconnect from AP 54:67:51:3d:a2:e0 for new auth to 54:67=
:51:3d:a2:d2
[ T1113] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (local address=3Dc8:94=
:02:c1:bd:69)
[ T1113] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[   T12] wlp4s0: authenticated
[   T12] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/3)
[   T12] wlp4s0: RX ReassocResp from 54:67:51:3d:a2:d2 (capab=3D0x511 statu=
s=3D0 aid=3D1)
[   T12] wlp4s0: associated
[   T12] wlp4s0: deauthenticated from 54:67:51:3d:a2:d2 (Reason: 15=3D4WAY_=
HANDSHAKE_TIMEOUT)
[ T1113] wlp4s0: authenticate with 54:67:51:3d:a2:e0 (local address=3Dc8:94=
:02:c1:bd:69)
[ T1113] wlp4s0: send auth to 54:67:51:3d:a2:e0 (try 1/3)
[   T12] wlp4s0: authenticated
[   T12] wlp4s0: associate with 54:67:51:3d:a2:e0 (try 1/3)
[   T12] wlp4s0: RX AssocResp from 54:67:51:3d:a2:e0 (capab=3D0x1411 status=
=3D17 aid=3D2)
[   T12] wlp4s0: 54:67:51:3d:a2:e0 denied association (code=3D17)
[ T1113] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (local address=3Dc8:94=
:02:c1:bd:69)
[ T1113] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[  T149] wlp4s0: authenticated
[  T149] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/3)
[  T159] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2 (capab=3D0x511 status=
=3D0 aid=3D1)
[  T159] wlp4s0: associated
[ T2916] TCP: bpf_incompl_ops does not implement required ops
[ T2916] TCP: tcp_ca_wrong not registered or non-unique key
[ T2916] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T2916] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2916, name:=
 test_progs
[ T2916] preempt_count: 1, expected: 0
[ T2916] RCU nest depth: 2, expected: 2
[ T2916] 4 locks held by test_progs/2916:
[ T2916]  #0: ffffffffa3732de0 (rcu_read_lock_trace){....}-{0:0}, at: sysca=
ll_trace_enter+0x18e/0x260
[ T2916]  #1: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: bpf_trace_r=
un2+0x8c/0x260
[ T2916]  #2: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: task_get_cg=
roup1+0x2a/0x340
[ T2916]  #3: ffffffffa3756878 (css_set_lock){+.+.}-{3:3}, at: task_get_cgr=
oup1+0xe8/0x340
[ T2916] Preemption disabled at:
[ T2916] [<ffffffffa2190acd>] fd_install+0x3d/0x360
[ T2916] CPU: 11 UID: 0 PID: 2916 Comm: test_progs Tainted: G           O  =
      6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2916] Tainted: [O]=3DOOT_MODULE
[ T2916] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2916] Call Trace:
[ T2916]  <TASK>
[ T2916]  dump_stack_lvl+0x6d/0xb0
[ T2916]  __might_resched.cold+0xfa/0x135
[ T2916]  rt_spin_lock+0x5f/0x190
[ T2916]  ? task_get_cgroup1+0xe8/0x340
[ T2916]  task_get_cgroup1+0xe8/0x340
[ T2916]  bpf_task_get_cgroup1+0xe/0x20
[ T2916]  bpf_prog_8d22669ef1ee8049_on_enter+0x62/0x1d4
[ T2916]  bpf_trace_run2+0xd3/0x260
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  __bpf_trace_sys_enter+0x37/0x60
[ T2916]  syscall_trace_enter+0x1c7/0x260
[ T2916]  do_syscall_64+0x395/0xfa0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2916] RIP: 0033:0x7f01bf2f0779
[ T2916] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T2916] RSP: 002b:00007ffe4a37c8c8 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0141
[ T2916] RAX: ffffffffffffffda RBX: 00007ffe4a37d058 RCX: 00007f01bf2f0779
[ T2916] RDX: 0000000000000040 RSI: 00007ffe4a37c940 RDI: 000000000000001c
[ T2916] RBP: 00007ffe4a37c8e0 R08: 00007ffe4a37c940 R09: 00007ffe4a37c940
[ T2916] R10: 000055edadecff39 R11: 0000000000000202 R12: 0000000000000000
[ T2916] R13: 00007ffe4a37d068 R14: 00007f01bf925000 R15: 000055edb0606890
[ T2916]  </TASK>
[ T2916] BUG: scheduling while atomic: test_progs/2916/0x00000002
[ T2916] 5 locks held by test_progs/2916:
[ T2916]  #0: ffffffffa3732de0 (rcu_read_lock_trace){....}-{0:0}, at: sysca=
ll_trace_enter+0x18e/0x260
[ T2916]  #1: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: bpf_trace_r=
un2+0x8c/0x260
[ T2916]  #2: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_=
enter_recur+0x22/0x120
[ T2916]  #3: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: task_get_cg=
roup1+0x2a/0x340
[ T2916]  #4: ffffffffa3756878 (css_set_lock){+.+.}-{3:3}, at: task_get_cgr=
oup1+0xe8/0x340
[ T2916] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer sn=
d_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bne=
p snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_co=
mponent snd_hda_codec_hdmi nls_ascii nls_cp437 vfat fat snd_acp3x_pdm_dma s=
nd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_core btintel btbcm btmtk bluet=
ooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec=
 videobuf2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core videobuf2_v4=
l2 snd_pcm_oss videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd=
_acp_config msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi snd_timer wmi_bmo=
f edac_mce_amd snd k10temp snd_pci_acp3x soundcore ccp battery ac button jo=
ydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro=
_3d hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_b=
uf industrialio evdev hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt=
7921_common mt792x_lib mt76_connac_lib mt76 mac80211
[ T2916]  libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs=
 nfnetlink efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo=
_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_help=
er drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_display_h=
elper usbcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_core hid_multi=
touch hid_generic serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hi=
d_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform i2c_designwa=
re_core [last unloaded: bpf_testmod(O)]
[ T2916] Preemption disabled at:
[ T2916] [<ffffffffa2190acd>] fd_install+0x3d/0x360
[ T2916] CPU: 7 UID: 0 PID: 2916 Comm: test_progs Tainted: G        W  O   =
     6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2916] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2916] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2916] Call Trace:
[ T2916]  <TASK>
[ T2916]  dump_stack_lvl+0x6d/0xb0
[ T2916]  ? fd_install+0x3d/0x360
[ T2916]  __schedule_bug.cold+0x8c/0x9a
[ T2916]  __schedule+0x167e/0x1ca0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? lock_acquire+0xca/0x300
[ T2916]  ? find_held_lock+0x2b/0x80
[ T2916]  ? rtlock_slowlock_locked+0x6a0/0x1d00
[ T2916]  ? rtlock_slowlock_locked+0x6a0/0x1d00
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  schedule_rtlock+0x21/0x40
[ T2916]  rtlock_slowlock_locked+0x635/0x1d00
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? lock_acquire+0xca/0x300
[ T2916]  rt_spin_lock+0x99/0x190
[ T2916]  task_get_cgroup1+0xe8/0x340
[ T2916]  bpf_task_get_cgroup1+0xe/0x20
[ T2916]  bpf_prog_1fa93f2af9548028_on_update+0x47/0x134
[ T2916]  bpf_trampoline_6442503153+0x57/0xcf
[ T2916]  bpf_local_storage_update+0x9/0x6f0
[ T2916]  bpf_cgrp_storage_get+0xfa/0x130
[ T2916]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x9f/0x128
[ T2916]  bpf_trace_run2+0xd3/0x260
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  __bpf_trace_sys_enter+0x37/0x60
[ T2916]  syscall_trace_enter+0x1c7/0x260
[ T2916]  do_syscall_64+0x395/0xfa0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2916] RIP: 0033:0x7f01bf2f0779
[ T2916] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T2916] RSP: 002b:00007ffe4a37cd18 EFLAGS: 00000246 ORIG_RAX: 000000000000=
00ba
[ T2916] RAX: ffffffffffffffda RBX: 00007ffe4a37d058 RCX: 00007f01bf2f0779
[ T2916] RDX: 0000000000000000 RSI: 000000000000005f RDI: 000055edbc9b91f0
[ T2916] RBP: 00007ffe4a37cd70 R08: 00000000ffffffff R09: 000055edbcbc90b8
[ T2916] R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000000000
[ T2916] R13: 00007ffe4a37d068 R14: 00007f01bf925000 R15: 000055edb0606890
[ T2916]  </TASK>
[ T2604] BUG: scheduling while atomic: Timer/2604/0x00000002
[ T2604] 4 locks held by Timer/2604:
[ T2604]  #0: ffffffffa3732de0 (rcu_read_lock_trace){....}-{0:0}, at: sysca=
ll_trace_enter+0x18e/0x260
[ T2604]  #1: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: bpf_trace_r=
un2+0x8c/0x260
[ T2604]  #2: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: task_get_cg=
roup1+0x2a/0x340
[ T2604]  #3: ffffffffa3756878 (css_set_lock){+.+.}-{3:3}, at: task_get_cgr=
oup1+0xe8/0x340
[ T2604] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer sn=
d_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bne=
p snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_co=
mponent snd_hda_codec_hdmi nls_ascii nls_cp437 vfat fat snd_acp3x_pdm_dma s=
nd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_core btintel btbcm btmtk bluet=
ooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec=
 videobuf2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core videobuf2_v4=
l2 snd_pcm_oss videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd=
_acp_config msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi snd_timer wmi_bmo=
f edac_mce_amd snd k10temp snd_pci_acp3x soundcore ccp battery ac button jo=
ydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro=
_3d hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_b=
uf industrialio evdev hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt=
7921_common mt792x_lib mt76_connac_lib mt76 mac80211
[ T2604]  libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs=
 nfnetlink efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo=
_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_help=
er drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_display_h=
elper usbcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_core hid_multi=
touch hid_generic serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hi=
d_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform i2c_designwa=
re_core [last unloaded: bpf_testmod(O)]
[ T2604] Preemption disabled at:
[ T2604] [<ffffffffa1dda00d>] migrate_enable+0x8d/0x110
[ T2604] CPU: 2 UID: 1000 PID: 2604 Comm: Timer Tainted: G        W  O     =
   6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2604] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2604] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2604] Call Trace:
[ T2604]  <TASK>
[ T2604]  dump_stack_lvl+0x6d/0xb0
[ T2604]  ? migrate_enable+0x8d/0x110
[ T2604]  __schedule_bug.cold+0x8c/0x9a
[ T2604]  __schedule+0x167e/0x1ca0
[ T2604]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2604]  ? lock_acquire+0xca/0x300
[ T2604]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2604]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2604]  ? mark_held_locks+0x40/0x70
[ T2604]  schedule_rtlock+0x21/0x40
[ T2604]  rtlock_slowlock_locked+0x635/0x1d00
[ T2604]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2604]  ? lock_acquire+0xca/0x300
[ T2604]  rt_spin_lock+0x99/0x190
[ T2604]  task_get_cgroup1+0xe8/0x340
[ T2604]  bpf_task_get_cgroup1+0xe/0x20
[ T2604]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2604]  bpf_trace_run2+0xd3/0x260
[ T2604]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2604]  __bpf_trace_sys_enter+0x37/0x60
[ T2604]  syscall_trace_enter+0x1c7/0x260
[ T2604]  do_syscall_64+0x395/0xfa0
[ T2604]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2604]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2604] RIP: 0033:0x7f93ae8a99ee
[ T2604] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c =
89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2=
e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[ T2604] RSP: 002b:00007f939d07c438 EFLAGS: 00000246 ORIG_RAX: 000000000000=
00ca
[ T2604] RAX: ffffffffffffffda RBX: 00007f939d07d6c0 RCX: 00007f93ae8a99ee
[ T2604] RDX: 00000000000018db RSI: 0000000000000089 RDI: 00007f93ae5bdafc
[ T2604] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffffff
[ T2604] R10: 00007f939d07c548 R11: 0000000000000246 R12: 00007f93ae5bdaa8
[ T2604] R13: 00007f93ae5bdafc R14: 00000000000031dd R15: 00007f93ae5bdad8
[ T2604]  </TASK>
[ T2233] BUG: scheduling while atomic: Softwar~cThread/2233/0x00000002
[ T2233] 4 locks held by Softwar~cThread/2233:
[ T2233]  #0: ffffffffa3732de0 (rcu_read_lock_trace){....}-{0:0}, at: sysca=
ll_trace_enter+0x18e/0x260
[ T2233]  #1: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: bpf_trace_r=
un2+0x8c/0x260
[ T2233]  #2: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: task_get_cg=
roup1+0x2a/0x340
[ T2233]  #3: ffffffffa3756878 (css_set_lock){+.+.}-{3:3}, at: task_get_cgr=
oup1+0xe8/0x340
[ T2233] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer sn=
d_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bne=
p snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_co=
mponent snd_hda_codec_hdmi nls_ascii nls_cp437 vfat fat snd_acp3x_pdm_dma s=
nd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_core btintel btbcm btmtk bluet=
ooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec=
 videobuf2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core videobuf2_v4=
l2 snd_pcm_oss videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd=
_acp_config msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi snd_timer wmi_bmo=
f edac_mce_amd snd k10temp snd_pci_acp3x soundcore ccp battery ac button jo=
ydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro=
_3d hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_b=
uf industrialio evdev hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt=
7921_common mt792x_lib mt76_connac_lib mt76 mac80211
[ T2233]  libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs=
 nfnetlink efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo=
_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_help=
er drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_display_h=
elper usbcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_core hid_multi=
touch hid_generic serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hi=
d_acpi i2c_hid hid
[ T2247] BUG: scheduling while atomic: Compositor/2247/0x00000002
[ T2233]  i2c_piix4
[ T2233]  i2c_smbus
[ T2247] 4 locks held by Compositor/2247:
[ T2233]  i2c_designware_platform i2c_designware_core
[ T2247]  #0: ffffffffa3732de0
[ T2233]  [last unloaded: bpf_testmod(O)]
[ T2247]  (
[ T2233]=20
[ T2247] rcu_read_lock_trace
[ T2233] Preemption disabled at:
[ T2247] ){....}-{0:0}
[ T2233] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2247] , at: syscall_trace_enter+0x18e/0x260
[ T2247]  #1: ffffffffa3733880 (rcu_read_lock
[ T2233] CPU: 10 UID: 1000 PID: 2233 Comm: Softwar~cThread Tainted: G      =
  W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2247] ){....}-{1:3}, at: bpf_trace_run2+0x8c/0x260
[ T2247]  #2:=20
[ T2233] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2247] ffffffffa3733880
[ T2233] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2247]  (rcu_read_lock
[ T2233] Call Trace:
[ T2247] ){....}-{1:3}, at: task_get_cgroup1+0x2a/0x340
[ T2233]  <TASK>
[ T2247]  #3: ffffffffa3756878 (css_set_lock
[ T2233]  dump_stack_lvl+0x6d/0xb0
[ T2247] ){+.+.}-{3:3}, at: task_get_cgroup1+0xe8/0x340
[ T2247] Modules linked in: bpf_testmod(O)
[ T2233]  ? futex_private_hash_put+0x32/0x100
[ T2247]  ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event
[ T2233]  __schedule_bug.cold+0x8c/0x9a
[ T2247]  snd_rawmidi snd_seq snd_seq_device rfcomm bnep
[ T2233]  __schedule+0x167e/0x1ca0
[ T2247]  snd_ctl_led
[ T2247]  snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compon=
ent snd_hda_codec_hdmi nls_ascii
[ T2233]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2247]  nls_cp437
[ T2247]  vfat fat snd_acp3x_pdm_dma
[ T2233]  ? lock_acquire+0xca/0x300
[ T2247]  snd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_core btintel
[ T2233]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2247]  btbcm
[ T2386] BUG: scheduling while atomic: WRRende~ckend#1/2386/0x00000002
[ T2247]  btmtk bluetooth ecdh_generic
[ T2386] 4 locks held by WRRende~ckend#1/2386:
[ T2247]  ecc
[ T2386]  #0:=20
[ T2247]  snd_hda_intel snd_intel_dspcfg
[ T2386] ffffffffa3732de0
[ T2247]  uvcvideo
[ T2233]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  (
[ T2247]  snd_hda_codec
[ T2386] rcu_read_lock_trace
[ T2247]  videobuf2_vmalloc
[ T2386] ){....}-{0:0}
[ T2233]  ? mark_held_locks+0x40/0x70
[ T2247]  videobuf2_memops snd_hwdep uvc
[ T2386] , at: syscall_trace_enter+0x18e/0x260
[ T2247]  snd_hda_core videobuf2_v4l2
[ T2386]  #1:=20
[ T2247]  snd_pcm_oss
[ T2386] ffffffffa3733880
[ T2247]  videodev
[ T2386]  (rcu_read_lock
[ T2247]  snd_rn_pci_acp3x snd_mixer_oss
[ T2386] ){....}-{1:3}
[ T2247]  videobuf2_common
[ T2233]  schedule_rtlock+0x21/0x40
[ T2247]  snd_acp_config
[ T2386] , at: bpf_trace_run2+0x8c/0x260
[ T2247]  msi_wmi snd_pcm
[ T2386]  #2:=20
[ T2247]  mc
[ T2386] ffffffffa3733880
[ T2247]  sparse_keymap
[ T2386]  (
[ T2233]  rtlock_slowlock_locked+0x635/0x1d00
[ T2247]  snd_soc_acpi
[ T2386] rcu_read_lock
[ T2247]  snd_timer
[ T2386] ){....}-{1:3}
[ T2247]  wmi_bmof edac_mce_amd
[ T2386] , at: task_get_cgroup1+0x2a/0x340
[ T2247]  snd k10temp
[ T2386]  #3:=20
[ T2247]  snd_pci_acp3x
[ T2386] ffffffffa3756878
[ T2233]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2247]  soundcore
[ T2386]  (
[ T2247]  ccp
[ T2386] css_set_lock
[ T2247]  battery
[ T2386] ){+.+.}-{3:3}
[ T2233]  ? lock_acquire+0xca/0x300
[ T2247]  ac button
[ T2386] , at: task_get_cgroup1+0xe8/0x340
[ T2247]  joydev
[ T2386] Modules linked in:
[ T2247]  hid_sensor_magn_3d hid_sensor_prox
[ T2386]  bpf_testmod(O)
[ T2247]  hid_sensor_accel_3d hid_sensor_gyro_3d
[ T2386]  ccm
[ T2247]  hid_sensor_als
[ T2386]  snd_seq_dummy snd_hrtimer
[ T2247]  hid_sensor_trigger industrialio_triggered_buffer
[ T2386]  snd_seq_midi snd_seq_midi_event
[ T2247]  kfifo_buf industrialio
[ T2386]  snd_rawmidi snd_seq
[ T2247]  evdev hid_sensor_iio_common
[ T2386]  snd_seq_device rfcomm
[ T2247]  amd_pmc sch_fq_codel
[ T2386]  bnep snd_ctl_led
[ T2247]  mt7921e mt7921_common
[ T2386]  snd_hda_codec_realtek
[ T2247]  mt792x_lib
[ T2386]  snd_hda_codec_generic
[ T2233]  rt_spin_lock+0x99/0x190
[ T2386]  snd_hda_scodec_component
[ T2247]  mt76_connac_lib
[ T2247]  mt76
[ T2386]  snd_hda_codec_hdmi
[ T2386]  nls_ascii
[ T2247]  mac80211
[ T2386]  nls_cp437
[ T2247]  libarc4
[ T2386]  vfat
[ T2247]  cfg80211
[ T2386]  fat
[ T2247]  rfkill
[ T2386]  snd_acp3x_pdm_dma
[ T2247]  msr
[ T2386]  snd_soc_dmic
[ T2247]  nvme_fabrics
[ T2386]  snd_acp3x_rn
[ T2233]  task_get_cgroup1+0xe8/0x340
[ T2247]  fuse
[ T2386]  btusb
[ T2247]  efi_pstore
[ T2386]  btrtl
[ T2247]  configfs
[ T2386]  snd_soc_core
[ T2247]  nfnetlink
[ T2386]  btintel
[ T2247]  efivarfs
[ T2386]  btbcm
[ T2247]  autofs4
[ T2386]  btmtk
[ T2233]  bpf_task_get_cgroup1+0xe/0x20
[ T2247]  ext4
[ T2386]  bluetooth
[ T2247]  mbcache
[ T2386]  ecdh_generic
[ T2247]  jbd2
[ T2386]  ecc
[ T2386]  snd_hda_intel
[ T2247]  usbhid
[ T2247]  amdgpu
[ T2386]  snd_intel_dspcfg
[ T2233]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2386]  uvcvideo
[ T2247]  amdxcp i2c_algo_bit
[ T2386]  snd_hda_codec videobuf2_vmalloc
[ T2247]  drm_client_lib
[ T2386]  videobuf2_memops
[ T2247]  drm_ttm_helper ttm
[ T2386]  snd_hwdep uvc
[ T2247]  drm_exec
[ T2233]  bpf_trace_run2+0xd3/0x260
[ T2386]  snd_hda_core
[ T2247]  gpu_sched drm_suballoc_helper
[ T2386]  videobuf2_v4l2 snd_pcm_oss
[ T2247]  drm_panel_backlight_quirks cec
[ T2386]  videodev
[ T2233]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_rn_pci_acp3x
[ T2247]  xhci_pci
[ T2386]  snd_mixer_oss
[ T2247]  drm_buddy
[ T2386]  videobuf2_common
[ T2247]  xhci_hcd
[ T2386]  snd_acp_config
[ T2247]  drm_display_helper
[ T2386]  msi_wmi
[ T2247]  usbcore
[ T2386]  snd_pcm
[ T2247]  hid_sensor_hub
[ T2386]  mc
[ T2247]  drm_kms_helper
[ T2386]  sparse_keymap
[ T2247]  psmouse
[ T2386]  snd_soc_acpi
[ T2384] BUG: scheduling while atomic: WRScene~ilder#1/2384/0x00000002
[ T2247]  nvme
[ T2386]  snd_timer
[ T2247]  mfd_core
[ T2384] 4 locks held by WRScene~ilder#1/2384:
[ T2247]  hid_multitouch
[ T2233]  __bpf_trace_sys_enter+0x37/0x60
[ T2386]  wmi_bmof
[ T2247]  hid_generic
[ T2386]  edac_mce_amd
[ T2384]  #0:=20
[ T2386]  snd
[ T2247]  serio_raw
[ T2386]  k10temp
[ T2384] ffffffffa3732de0
[ T2386]  snd_pci_acp3x
[ T2247]  nvme_core r8169
[ T2386]  soundcore
[ T2384]  (
[ T2233]  syscall_trace_enter+0x1c7/0x260
[ T2386]  ccp
[ T2247]  usb_common
[ T2384] rcu_read_lock_trace
[ T2247]  amd_sfh
[ T2386]  battery
[ T2386]  ac
[ T2247]  crc16
[ T2384] ){....}-{0:0}
[ T2247]  i2c_hid_acpi
[ T2386]  button joydev
[ T2247]  i2c_hid hid
[ T2386]  hid_sensor_magn_3d
[ T2384] , at: syscall_trace_enter+0x18e/0x260
[ T2386]  hid_sensor_prox
[ T2247]  i2c_piix4
[ T2233]  do_syscall_64+0x395/0xfa0
[ T2247]  i2c_smbus
[ T2386]  hid_sensor_accel_3d
[ T2384]  #1:=20
[ T2386]  hid_sensor_gyro_3d
[ T2247]  i2c_designware_platform i2c_designware_core
[ T2386]  hid_sensor_als
[ T2384] ffffffffa3733880
[ T2233]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2247]  [last unloaded: bpf_testmod(O)]
[ T2386]  hid_sensor_trigger
[ T2247]=20
[ T2384]  (
[ T2247] Preemption disabled at:
[ T2384] rcu_read_lock
[ T2386]  industrialio_triggered_buffer
[ T2386]  kfifo_buf
[ T2384] ){....}-{1:3}
[ T2386]  industrialio
[ T2384] RSP: 002b:00007f1f3a5fc318 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0018
[ T2384] RAX: ffffffffffffffda RBX: 00007f1f24eba000 RCX: 00007f1f6d7ed8c7
[ T2384] RDX: 0000000000005d42 RSI: 0000000000002ea1 RDI: 00007f1f3a5fcf60
[ T2384] RBP: 0000000000000007 R08: 00007f1f3bce7ee0 R09: 000000000000000d
[ T2384] R10: 38ad0568aa6a9412 R11: 0000000000000202 R12: 0000000000000001
[ T2384] R13: 0000000000000000 R14: 00007f1f3bffb600 R15: 0000000000005d44
[ T2386] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2386] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2386] Call Trace:
[ T2386]  __schedule_bug.cold+0x8c/0x9a
[ T2386]  ? mark_held_locks+0x40/0x70
[ T2386]  rtlock_slowlock_locked+0x635/0x1d00
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  ? lock_acquire+0xca/0x300
[ T2386]  rt_spin_lock+0x99/0x190
[ T2386]  task_get_cgroup1+0xe8/0x340
[ T2386]  bpf_task_get_cgroup1+0xe/0x20
[ T2386]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  __bpf_trace_sys_enter+0x37/0x60
[ T2386]  syscall_trace_enter+0x1c7/0x260
[ T2386]  do_syscall_64+0x395/0xfa0
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2386] RIP: 0033:0x7f1f6dca8a0e
[ T2386] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T2386] RSP: 002b:00007f1f3a1f68b0 EFLAGS: 00000297 ORIG_RAX: 000000000000=
00e4
[ T2386] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1f6dca8a0e
[ T2386] RDX: 0000000000000002 RSI: 00007f1f3a1f6ac0 RDI: 0000000000000001
[ T2386] RBP: 00007f1f3a1f68b0 R08: 0000000000000000 R09: 00007f1f6dca2000
[ T2386] R10: 00007f1f25673b10 R11: 0000000000000297 R12: 00007f1f2da29be0
[ T2386] R13: 00007f1f2da29b88 R14: 00007f1f3af3f9a0 R15: 00007f1f24f37550
[ T2386]  </TASK>
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T2977] 4 locks held by dmesg/2977:
[ T2977]  #0: ffffffffa3732de0 (rcu_read_lock_trace){....}-{0:0}, at: sysca=
ll_trace_enter+0x18e/0x260
[ T2977]  #1: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: bpf_trace_r=
un2+0x8c/0x260
[ T2977]  #2: ffffffffa3733880 (rcu_read_lock){....}-{1:3}, at: task_get_cg=
roup1+0x2a/0x340
[ T2977]  #3: ffffffffa3756878 (css_set_lock){+.+.}-{3:3}, at: task_get_cgr=
oup1+0xe8/0x340
[ T2977] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer sn=
d_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bne=
p snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T2977]  snd_hda_scodec_component snd_hda_codec_hdmi
[  T555] 4 locks held by systemd-journal/555:
[ T2977]  nls_ascii
[ T2977]  nls_cp437
[  T555]  #0:=20
[ T2977]  vfat fat
[  T555] ffffffffa3732de0
[ T2977]  snd_acp3x_pdm_dma snd_soc_dmic
[  T555]  (
[ T2977]  snd_acp3x_rn
[  T555] rcu_read_lock_trace
[ T2977]  btusb btrtl
[  T555] ){....}-{0:0}
[ T2977]  snd_soc_core btintel btbcm btmtk
[  T555] , at: syscall_trace_enter+0x18e/0x260
[ T2977]  bluetooth ecdh_generic ecc
[  T555]  #1:=20
[ T2977]  snd_hda_intel
[ T2977]  snd_intel_dspcfg
[  T555] ffffffffa3733880
[ T2977]  uvcvideo snd_hda_codec
[  T555]  (
[ T2977]  videobuf2_vmalloc
[  T555] rcu_read_lock
[ T2977]  videobuf2_memops
[  T555] ){....}-{1:3}
[ T2977]  snd_hwdep uvc snd_hda_core
[  T555] , at: bpf_trace_run2+0x8c/0x260
[ T2977]  videobuf2_v4l2 snd_pcm_oss
[  T555]  #2:=20
[ T2977]  videodev
[  T555] ffffffffa3733880
[ T2977]  snd_rn_pci_acp3x
[  T555]  (
[ T2977]  videobuf2_common snd_acp_config
[  T555] , at: task_get_cgroup1+0x2a/0x340
[  T555]  #3:=20
[ T2977]  wmi_bmof edac_mce_amd
[  T555] ){+.+.}-{3:3}
[  T555] Modules linked in:
[  T555]  ccm
[  T555]  snd_seq_dummy
[ T2977]  hid_sensor_trigger
[  T555]  snd_seq_midi_event
[  T555]  snd_seq
[  T555]  rfcomm bnep
[ T2977]  mt76_connac_lib mt76
[  T555]  snd_hda_scodec_component snd_hda_codec_hdmi
[ T2977]  rfkill msr
[  T555]  snd_soc_dmic
[  T555]  btrtl snd_soc_core
[  T555]  btbcm btmtk
[  T555]  ecdh_generic
[  T555]  snd_intel_dspcfg uvcvideo
[  T555]  snd_hda_codec
[  T555]  videobuf2_vmalloc videobuf2_memops
[ T2977]  drm_panel_backlight_quirks
[  T555]  snd_hda_core
[ T2977]  drm_buddy
[  T555]  snd_rn_pci_acp3x
[  T555]  videobuf2_common
[  T555]  msi_wmi
[ T2977]  hid_multitouch
[  T555]  snd_timer wmi_bmof
[ T2977]  usb_common
[ T2977]  i2c_hid_acpi i2c_hid
[ T2977]  i2c_piix4 i2c_smbus
[  T555]  hid_sensor_magn_3d hid_sensor_prox
[  T555]  hid_sensor_accel_3d hid_sensor_gyro_3d
[  T555]  hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer k=
fifo_buf industrialio
[ T2977] [<0000000000000000>] 0x0
[  T555]  hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt7921_common
[  T555]  mt792x_lib mt76_connac_lib mt76 mac80211
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  libarc4
[  T555]  cfg80211
[ T2977] Call Trace:
[ T2977]  <TASK>
[  T555]  nfnetlink efivarfs autofs4 ext4 mbcache jbd2 usbhid
[  T555]  amdgpu amdxcp i2c_algo_bit drm_client_lib
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? lock_acquire+0xca/0x300
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_multitouch hid_generic serio_raw
[ T2977]  schedule_rtlock+0x21/0x40
[  T555] Preemption disabled at:
[  T555] [<ffffffffa21386bd>] count_memcg_events+0x4d/0x280
[ T2977]  ? lock_acquire+0xca/0x300
[ T2977]  rt_spin_lock+0x99/0x190
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs=
 nfnetlink efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo=
_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_help=
er drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_display_h=
elper usbcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_core hid_multi=
touch hid_generic serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hi=
d_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform i2c_designwa=
re_core [last unloaded: bpf_testmod(O)]
[ T1155] Preemption disabled at:
[ T1155] [<ffffffffa215f33f>] fput+0x1f/0x90
[ T1155] CPU: 1 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? fput+0x1f/0x90
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_acquire+0xca/0x300
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700afb88 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 00000000000423ee
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 000000000007b559 R15: 000055f047b7b880
[ T1155]  </TASK>
[ T2916] check_preemption_disabled: 116 callbacks suppressed
[ T2916] BUG: using smp_processor_id() in preemptible [00000000] code: test=
_progs/2916
[ T2604] BUG: assuming non migratable context at kernel/bpf/bpf_cgrp_storag=
e.c:29
[ T2916] caller is bpf_mem_cache_alloc_flags+0x19/0x160
[ T2604] in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 26=
04, name: Timer
[ T2604] 2 locks held by Timer/2604:
[ T2916] CPU: 7 UID: 0 PID: 2916 Comm: test_progs Tainted: G        W  O   =
     6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2604]  #0: ffffffffa3732de0
[ T2916] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2604]  (
[ T2916] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2916] Call Trace:
[ T2604] rcu_read_lock_trace){....}-{0:0}
[ T2916]  <TASK>
[ T2604] , at: syscall_trace_enter+0x18e/0x260
[ T2916]  dump_stack_lvl+0x6d/0xb0
[ T2604]  #1: ffffffffa3733880 (rcu_read_lock
[ T2916]  check_preemption_disabled+0xd6/0xe0
[ T2604] ){....}-{1:3}, at: bpf_trace_run2+0x8c/0x260
[ T2916]  bpf_mem_cache_alloc_flags+0x19/0x160
[ T2916]  bpf_selem_alloc+0x161/0x270
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  bpf_local_storage_update+0xe9/0x6f0
[ T2916]  bpf_cgrp_storage_get+0xfa/0x130
[ T2916]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x9f/0x128
[ T2916]  bpf_trace_run2+0xd3/0x260
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2233] BUG: using smp_processor_id() in preemptible [00000000] code: Soft=
war~cThread/2233
[ T2916]  __bpf_trace_sys_enter+0x37/0x60
[ T2916]  syscall_trace_enter+0x1c7/0x260
[ T2233] caller is rcu_is_watching+0x12/0x60
[ T2916]  do_syscall_64+0x395/0xfa0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2916] RIP: 0033:0x7f01bf2f0779
[ T2916] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T2916] RSP: 002b:00007ffe4a37cd18 EFLAGS: 00000246 ORIG_RAX: 000000000000=
00ba
[ T2916] RAX: ffffffffffffffda RBX: 00007ffe4a37d058 RCX: 00007f01bf2f0779
[ T2247] BUG: using smp_processor_id() in preemptible [00000000] code: Comp=
ositor/2247
[ T2916] RDX: 0000000000000000 RSI: 000000000000005f RDI: 000055edbc9b91f0
[ T2916] RBP: 00007ffe4a37cd70 R08: 00000000ffffffff R09: 000055edbcbc90b8
[ T2916] R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000000000
[ T2916] R13: 00007ffe4a37d068 R14: 00007f01bf925000 R15: 000055edb0606890
[ T2247] caller is rcu_is_watching+0x12/0x60
[ T2010] BUG: scheduling while atomic: xfce4-terminal/2010/0x00000002
[ T2916]  </TASK>
[ T2010] 4 locks held by xfce4-terminal/2010:
[ T2010]  #0:=20
[ T2247] CPU: 15 UID: 1000 PID: 2247 Comm: Compositor Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2010] ffffffffa3732de0 (
[ T2916] BUG: using smp_processor_id() in preemptible [00000000] code: test=
_progs/2916
[ T2010] rcu_read_lock_trace
[ T2247] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2010] ){....}-{0:0}
[ T2247] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2916] caller is rcu_is_watching+0x12/0x60
[ T2247] Call Trace:
[ T2010] , at: syscall_trace_enter+0x18e/0x260
[ T2247]  <TASK>
[ T2010]  #1: ffffffffa3733880
[ T2247]  dump_stack_lvl+0x6d/0xb0
[ T2010]  (
[ T2386] BUG: using smp_processor_id() in preemptible [00000000] code: WRRe=
nde~ckend#1/2386
[ T2010] rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x8c/0x260
[ T2386] caller is rcu_is_watching+0x12/0x60
[ T2247]  check_preemption_disabled+0xd6/0xe0
[ T2010]  #2: ffffffffa3733880 (rcu_read_lock){....}-{1:3}
[  T555] BUG: using smp_processor_id() in preemptible [00000000] code: syst=
emd-journal/555
[ T2010]  mc sparse_keymap
[  T555] caller is rcu_is_watching+0x12/0x60
[ T2010]  snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T2247]  </TASK>
[ T2010]  snd k10temp
[ T2010]  snd_pci_acp3x
[ T2010]  soundcore
[ T2916] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2916] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2916]  <TASK>
[ T2010]  joydev hid_sensor_magn_3d
[ T2916]  dump_stack_lvl+0x6d/0xb0
[ T2010]  hid_sensor_prox
[ T2247] Modules linked in:
[ T2010]  hid_sensor_accel_3d
[ T2247]  bpf_testmod(O)
[ T2247]  snd_seq_dummy
[ T2010]  hid_sensor_trigger
[ T2247]  snd_hrtimer
[ T2916]  rcu_is_watching+0x12/0x60
[ T2247]  snd_rawmidi snd_seq
[ T2010]  hid_sensor_iio_common amd_pmc
[ T2916]  ? syscall_trace_enter+0x1d5/0x260
[ T2010]  sch_fq_codel
[ T2916]  lock_release+0x21b/0x2e0
[ T2247]  snd_ctl_led
[ T2010]  mt7921_common mt792x_lib
[ T2247]  snd_hda_codec_realtek snd_hda_codec_generic
[ T2010]  mt76_connac_lib mt76
[ T2247]  snd_hda_scodec_component
[ T2916]  syscall_trace_enter+0x1da/0x260
[ T2247]  snd_hda_codec_hdmi
[ T2010]  mac80211 libarc4
[ T2247]  nls_ascii nls_cp437
[ T2010]  cfg80211
[ T2916]  do_syscall_64+0x395/0xfa0
[ T2010]  rfkill
[ T2247]  vfat fat
[ T2010]  msr
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2247]  snd_acp3x_pdm_dma
[ T2010]  nvme_fabrics fuse
[ T2247]  snd_soc_dmic snd_acp3x_rn
[ T2010]  efi_pstore
[ T2916]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2247]  btusb
[ T2010]  configfs
[ T2010]  nfnetlink
[ T2247]  btrtl
[ T2247]  snd_soc_core
[ T2010]  efivarfs
[ T2916] RIP: 0033:0x7f01bf2f0779
[ T2010]  autofs4
[ T2247]  btintel
[ T2916] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T2247]  btbcm
[ T2010]  ext4 mbcache
[ T2247]  btmtk
[ T2916] RSP: 002b:00007ffe4a37cd18 EFLAGS: 00000246 ORIG_RAX: 000000000000=
00ba
[ T2010]  jbd2
[ T2247]  bluetooth
[ T2916] RAX: ffffffffffffffda RBX: 00007ffe4a37d058 RCX: 00007f01bf2f0779
[ T2247]  ecdh_generic
[ T2010]  usbhid amdgpu
[ T2247]  ecc
[ T2916] RDX: 0000000000000000 RSI: 000000000000005f RDI: 000055edbc9b91f0
[ T2010]  amdxcp
[ T2247]  snd_hda_intel
[ T2916] RBP: 00007ffe4a37cd70 R08: 00000000ffffffff R09: 000055edbcbc90b8
[ T2247]  uvcvideo
[ T2010]  drm_ttm_helper ttm
[ T2247]  snd_hda_codec videobuf2_vmalloc
[ T2010]  drm_exec gpu_sched
[ T2010]  drm_suballoc_helper
[ T2247]  uvc
[ T2247]  videobuf2_v4l2
[ T2010]  xhci_pci drm_buddy
[ T2247]  snd_pcm_oss videodev
[ T2010]  xhci_hcd
[ T1155] CPU: 1 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2247]  snd_rn_pci_acp3x
[ T2010]  drm_display_helper usbcore
[ T2247]  snd_mixer_oss videobuf2_common
[ T2010]  hid_sensor_hub
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2010]  drm_kms_helper
[ T2247]  snd_acp_config
[ T2010]  psmouse
[ T1155] Call Trace:
[ T2247]  msi_wmi snd_pcm
[ T2010]  nvme
[ T1155]  <TASK>
[ T2247]  mc
[ T2010]  mfd_core
[ T2247]  sparse_keymap
[ T2010]  hid_multitouch
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T2247]  snd_soc_acpi
[ T2010]  hid_generic
[ T2247]  snd_timer
[ T2010]  serio_raw
[ T2247]  wmi_bmof
[ T2010]  nvme_core
[ T2247]  edac_mce_amd
[ T1155]  check_preemption_disabled+0xd6/0xe0
[ T2010]  r8169
[ T2247]  snd
[ T2010]  usb_common amd_sfh
[ T2247]  k10temp
[ T1155]  ? syscall_trace_enter+0x1d5/0x260
[ T2010]  crc16
[ T2247]  snd_pci_acp3x soundcore
[ T2010]  i2c_hid_acpi i2c_hid
[ T2247]  ccp
[ T1155]  rcu_is_watching+0x12/0x60
[ T2010]  hid
[ T2247]  battery ac
[ T2010]  i2c_piix4 i2c_smbus
[ T2247]  button
[ T1155]  ? syscall_trace_enter+0x1d5/0x260
[ T2010]  i2c_designware_platform
[ T2247]  joydev hid_sensor_magn_3d
[ T2010]  i2c_designware_core
[ T1155]  lock_release+0x21b/0x2e0
[ T2010]  [last unloaded: bpf_testmod(O)]
[ T2010]=20
[ T1155]  syscall_trace_enter+0x1da/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T2247]  sch_fq_codel mt7921e mt7921_common mt792x_lib
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2247]  rfkill msr nvme_fabrics
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T2247]  fuse
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[ T2247]  efi_pstore configfs
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700afb88 RCX: 00007fc77f05c7f9
[ T2247]  efivarfs autofs4
[ T2247]  usbhid
[ T2247]  amdgpu amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_=
exec gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[ T1155]  </TASK>
[ T2233] CPU: 12 UID: 1000 PID: 2233 Comm: Softwar~cThread Tainted: G      =
  W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2247]  usbcore hid_sensor_hub drm_kms_helper
[ T2233] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2247]  nvme
[ T2247]  serio_raw nvme_core r8169
[ T2233]  check_preemption_disabled+0xd6/0xe0
[ T2247]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2233]  rcu_is_watching+0x12/0x60
[ T2233]  ? syscall_trace_enter+0x1d5/0x260
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[  T555] RSP: 002b:00007fff31d4e980 EFLAGS: 00000297 ORIG_RAX: 000000000000=
00e4
[  T555] RAX: ffffffffffffffda RBX: 0000000000000088 RCX: 00007fd47309ea0e
[  T555] RDX: 0000000000000002 RSI: 00007fff31d4e9a0 RDI: 0000000000000001
[  T555] RBP: 00007fff31d4e980 R08: 0000000000000000 R09: 00007fd473098000
[  T555] R10: 3a5d08eb4dccc7bb R11: 0000000000000297 R12: 0000000000000000
[  T555] R13: 000055b3d567d3b0 R14: 00007fff31d4eaf0 R15: 000000000962acd9
[  T555]  </TASK>
[ T1155] CPU: 1 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer sn=
d_seq_midi
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  rfcomm bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_gener=
ic
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  nls_cp437 vfat fat snd_acp3x_pdm_dma
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  snd_soc_dmic snd_acp3x_rn btusb
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  btrtl snd_soc_core btintel btbcm btmtk bluetooth
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  ecdh_generic ecc snd_hda_intel snd_intel_dspcfg
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  uvcvideo snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwd=
ep
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  uvc snd_hda_core
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  videobuf2_common snd_acp_config msi_wmi snd_pcm
[ T1155] RIP: 0033:0x7fc77f05c7f9
[  T555]  mc sparse_keymap snd_soc_acpi
[  T555]  snd_timer
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[  T555]  wmi_bmof
[ T1155]  ORIG_RAX: 0000000000000060
[  T555]  edac_mce_amd snd
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700b0a28 RCX: 00007fc77f05c7f9
[  T555]  k10temp
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[  T555]  snd_pci_acp3x
[  T555]  soundcore ccp
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[  T555]  battery
[ T1155] R13: 00007fc77e6b02e0 R14: 000000000007b605 R15: 000055f047b7b880
[  T555]  ac button joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_ac=
cel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industrialio_tr=
iggered_buffer
[ T1155]  </TASK>
[  T555]  kfifo_buf industrialio evdev
[ T2604] CPU: 2 UID: 1000 PID: 2604 Comm: Timer Tainted: G        W  O     =
   6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555]  hid_sensor_iio_common amd_pmc
[ T2604] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  sch_fq_codel mt7921e
[ T2604] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555]  mt7921_common
[ T2604] Call Trace:
[  T555]  mt792x_lib
[ T2604]  <TASK>
[  T555]  mt76_connac_lib mt76 mac80211
[ T2604]  dump_stack_lvl+0x6d/0xb0
[  T555]  libarc4 cfg80211 rfkill msr
[ T2604]  check_preemption_disabled+0xd6/0xe0
[  T555]  nvme_fabrics fuse efi_pstore configfs
[ T2604]  ? syscall_trace_enter+0x1d5/0x260
[  T555]  nfnetlink efivarfs autofs4 ext4
[ T2604]  rcu_is_watching+0x12/0x60
[ T2604]  ? syscall_trace_enter+0x1d5/0x260
[ T2604]  lock_release+0x21b/0x2e0
[  T555]  drm_client_lib drm_ttm_helper ttm
[ T2386] BUG: scheduling while atomic: WRRende~ckend#1/2386/0x00000002
[  T555]  drm_exec gpu_sched
[ T2386] INFO: lockdep is turned off.
[  T555]  drm_suballoc_helper
[ T2386] Modules linked in:
[  T555]  drm_panel_backlight_quirks
[ T2386]  bpf_testmod(O)
[  T555]  cec
[ T2604]  do_syscall_64+0x395/0xfa0
[  T555]  xhci_hcd
[ T2386]  snd_seq_midi
[  T555]  usbcore
[ T2386]  snd_seq_midi_event
[  T555]  hid_sensor_hub
[ T1157]  bpf_testmod(O)
[ T2386]  rfcomm
[  T555]  hid_multitouch
[ T2386]  snd_hda_codec_realtek
[ T2010] Modules linked in:
[ T1157]  snd_seq_midi_event
[  T555]  nvme_core
[ T2386]  snd_hda_codec_generic
[ T2010]  bpf_testmod(O)
[ T2604] RSP: 002b:00007f939d07c438 EFLAGS: 00000246
[ T1157]  snd_rawmidi
[  T555]  r8169
[ T2386]  snd_hda_scodec_component
[ T2010]  ccm
[ T2604]  ORIG_RAX: 00000000000000ca
[ T2604] RAX: ffffffffffffffda RBX: 00007f939d07d6c0 RCX: 00007f93ae8a99ee
[  T555]  amd_sfh
[ T2386]  nls_ascii
[ T2010]  snd_seq_midi
[ T1157]  rfcomm
[  T555]  crc16
[ T2386]  nls_cp437
[  T555]  i2c_hid_acpi
[ T2386]  vfat
[ T2010]  snd_rawmidi
[ T2386]  fat
[ T2010]  snd_seq
[ T1157]  snd_hda_codec_realtek
[ T2604]  gpu_sched
[ T2977]  ORIG_RAX: 0000000000000001
[ T2386] Preemption disabled at:
[ T2604]  drm_panel_backlight_quirks
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2604]  cec
[ T1157]  i2c_designware_core
[ T2977] RDX: 000000000000008d RSI: 000055e375e787e0 RDI: 0000000000000001
[ T1157]  [last unloaded: bpf_testmod(O)]
[ T2604]  drm_buddy
[ T2977] RBP: 000055e375e787e0 R08: 0000000000000000 R09: 0000000000000000
[ T1157]=20
[ T2604]  usbcore
[ T2604]  psmouse nvme mfd_core hid_multitouch hid_generic serio_raw nvme_c=
ore r8169 usb_common amd_sfh crc16
[ T2977]  </TASK>
[ T2604]  i2c_smbus i2c_designware_platform i2c_designware_core
[ T2010] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2604]=20
[ T2010] Call Trace:
[ T2010]  <TASK>
[ T2604] [<ffffffffa1dda00d>] migrate_enable+0x8d/0x110
[ T2010]  dump_stack_lvl+0x6d/0xb0
[ T2010]  ? fput+0x1f/0x90
[ T2010]  __schedule_bug.cold+0x8c/0x9a
[ T2010]  __schedule+0x167e/0x1ca0
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2010]  ? lock_release+0x21b/0x2e0
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  rt_spin_lock+0x99/0x190
[ T2010]  task_get_cgroup1+0xe8/0x340
[ T2010]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2010]  bpf_trace_run2+0xd3/0x260
[ T2010]  __bpf_trace_sys_enter+0x37/0x60
[ T2010]  syscall_trace_enter+0x1c7/0x260
[ T2010]  do_syscall_64+0x395/0xfa0
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2010] RIP: 0033:0x7f0e4bf16a0e
[ T2010] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T2010] RSP: 002b:00007ffc276f5140 EFLAGS: 00000297 ORIG_RAX: 000000000000=
00e4
[ T2010] RAX: ffffffffffffffda RBX: 000055766d04c910 RCX: 00007f0e4bf16a0e
[ T2010] RDX: 0000000000000002 RSI: 00007ffc276f51b0 RDI: 0000000000000001
[ T2010] RBP: 00007ffc276f5140 R08: 0000000000000000 R09: 00007f0e4bf10000
[ T2010] R10: 0000000000000001 R11: 0000000000000297 R12: 000000007fffffff
[ T2010] R13: 000055766d04b0b0 R14: 000055766d04c910 R15: 000055766d04b0b0
[ T2010]  </TASK>
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[  T555]  ? count_memcg_events+0x4d/0x280
[  T555]  __schedule_bug.cold+0x8c/0x9a
[  T555]  __schedule+0x167e/0x1ca0
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? lock_release+0x21b/0x2e0
[  T555]  schedule_rtlock+0x21/0x40
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  rt_spin_lock+0x99/0x190
[  T555]  task_get_cgroup1+0xe8/0x340
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  bpf_trace_run2+0xd3/0x260
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  syscall_trace_enter+0x1c7/0x260
[  T555]  do_syscall_64+0x395/0xfa0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555] RIP: 0033:0x7fd472b0fad7
[  T555] Code: 73 01 c3 48 8b 0d 21 53 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 ba 00 00 00 0f 05 <c3> 0f 1=
f 84 00 00 00 00 00 b8 ea 00 00 00 0f 05 48 3d 01 f0 ff ff
[  T555] RSP: 002b:00007fff31d51828 EFLAGS: 00000202 ORIG_RAX: 000000000000=
00ba
[  T555] RAX: ffffffffffffffda RBX: 000000000000022b RCX: 00007fd472b0fad7
[  T555] RDX: 00000000ffffffff RSI: 00007fd472ecafd0 RDI: 00007fd473095cc8
[  T555] RBP: 000055b3d5668660 R08: 0000000000000000 R09: 000055b3d5667488
[  T555] R10: 00007fff31d518a0 R11: 0000000000000202 R12: 000055b3d5668660
[  T555] R13: ffffffffffffffff R14: 0000000000000000 R15: 00007fff31d51890
[  T555]  </TASK>
[ T1157] CPU: 5 UID: 0 PID: 1157 Comm: rs:main Q:Reg Tainted: G        W  O=
        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1157] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1157] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1157] Call Trace:
[ T1157]  <TASK>
[ T1157]  dump_stack_lvl+0x6d/0xb0
[ T1157]  ? futex_private_hash_put+0x32/0x100
[ T1157]  __schedule_bug.cold+0x8c/0x9a
[ T1157]  __schedule+0x167e/0x1ca0
[ T1157]  ? rcu_is_watching+0x12/0x60
[ T1157]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  ? rcu_is_watching+0x12/0x60
[ T1157]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in:
[ T1157]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  bpf_testmod(O) ccm snd_seq_dummy
[ T1157]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_hrtimer snd_seq_midi snd_seq_midi_event
[ T1157]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_rawmidi
[  T555]  snd_seq snd_seq_device
[ T1157]  ? lock_release+0x21b/0x2e0
[  T555]  rfcomm bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_gener=
ic snd_hda_scodec_component
[ T1157]  schedule_rtlock+0x21/0x40
[  T555]  snd_hda_codec_hdmi nls_ascii nls_cp437 vfat
[ T1157]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  fat
[  T555]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn
[ T1157]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_hda_intel snd_intel_dspcfg uvcvideo
[ T2977]  snd_hda_codec videobuf2_vmalloc videobuf2_memops
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  snd_hwdep uvc
[ T2386] BUG: scheduling while atomic: WRRende~ckend#1/2386/0x00000002
[ T2977]  snd_hda_core videobuf2_v4l2 snd_pcm_oss
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386] INFO: lockdep is turned off.
[ T2977]  videodev
[ T2386] Modules linked in:
[ T2977]  snd_rn_pci_acp3x
[ T2977]  snd_mixer_oss
[ T2386]  bpf_testmod(O)
[ T2977]  videobuf2_common snd_acp_config
[ T2386]  ccm
[ T2977]  msi_wmi snd_pcm
[ T2386]  snd_seq_dummy
[ T2977]  mc sparse_keymap
[ T2386]  snd_hrtimer
[ T2977]  snd_soc_acpi
[ T2386]  snd_seq_midi
[ T2977]  snd_timer
[ T2386]  snd_seq_midi_event
[  T555]  rt_spin_lock+0x99/0x190
[ T2977]  wmi_bmof edac_mce_amd
[ T2386]  snd_rawmidi
[ T2977]  snd
[ T2386]  snd_seq
[ T2977]  k10temp
[ T2386]  snd_seq_device
[ T2977]  snd_pci_acp3x
[  T555]  task_get_cgroup1+0xe8/0x340
[ T2977]  ccp
[ T2386]  snd_ctl_led
[ T2977]  battery
[ T2386]  snd_hda_codec_realtek
[ T2977]  ac
[ T2386]  snd_hda_codec_generic
[ T2977]  button
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T2386]  snd_hda_scodec_component
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2386]  nls_ascii
[ T2977]  hid_sensor_gyro_3d
[ T2386]  nls_cp437
[ T2977]  hid_sensor_als hid_sensor_trigger
[ T2386]  vfat
[ T2977]  industrialio_triggered_buffer
[  T555]  bpf_trace_run2+0xd3/0x260
[ T2977]  kfifo_buf
[ T2386]  fat
[ T2977]  industrialio
[ T2386]  snd_acp3x_pdm_dma
[ T2977]  evdev
[ T2386]  snd_soc_dmic
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  hid_sensor_iio_common
[ T2386]  snd_acp3x_rn
[ T2386]  btusb
[ T2977]  sch_fq_codel
[ T2386]  btrtl
[ T2386]  snd_soc_core
[ T2386]  btintel
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  mt76 mac80211
[ T2386]  bluetooth
[ T2386]  ecdh_generic
[ T2386]  ecc
[ T2386]  snd_hda_intel
[ T2977]  fuse
[ T2386]  snd_intel_dspcfg
[ T2977]  efi_pstore configfs
[ T2386]  uvcvideo
[ T2977]  nfnetlink
[  T555]  do_syscall_64+0x395/0xfa0
[ T2386]  snd_hda_codec
[ T2977]  autofs4 ext4
[ T2386]  videobuf2_vmalloc
[ T2977]  mbcache
[ T2386]  snd_hwdep
[ T2977]  amdxcp
[ T2386]  uvc
[ T2386]  snd_hda_core
[ T2977]  drm_client_lib
[ T2386]  videobuf2_v4l2
[ T2977]  drm_ttm_helper ttm
[ T2386]  snd_pcm_oss
[ T2977]  gpu_sched
[ T2386]  videodev
[  T555] RSP: 002b:00007fff31d516e0 EFLAGS: 00000297
[ T2386]  snd_rn_pci_acp3x
[ T2977]  drm_suballoc_helper drm_panel_backlight_quirks
[  T555]  ORIG_RAX: 00000000000000e4
[ T2386]  snd_mixer_oss
[ T2977]  cec
[  T555] RAX: ffffffffffffffda RBX: 000055b3d56687b0 RCX: 00007fd47309ea0e
[  T555] RDX: 0000000000000002 RSI: 00007fff31d51700 RDI: 0000000000000001
[ T2977]  xhci_hcd
[  T555] R10: ffffffffffffffff R11: 0000000000000297 R12: 0000000000000001
[ T2977]  hid_sensor_hub
[ T2977]  drm_kms_helper
[ T2977]  mfd_core hid_multitouch
[ T2977]  hid_generic
[ T2386]  wmi_bmof
[ T2977]  serio_raw nvme_core
[ T2386]  edac_mce_amd
[  T555]  </TASK>
[ T2977]  r8169
[ T2386]  soundcore
[ T2386]  button joydev
[ T2386]  hid_sensor_magn_3d
[ T2977] Preemption disabled at:
[ T2977] [<0000000000000000>] 0x0
[ T2386]  hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer k=
fifo_buf
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2386]  industrialio evdev hid_sensor_iio_common
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2386]  amd_pmc
[ T2977] Call Trace:
[ T2386]  sch_fq_codel mt7921e
[ T2977]  <TASK>
[ T2386]  mt7921_common mt792x_lib
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T2386]  mt76_connac_lib mt76 mac80211 libarc4
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T2386]  cfg80211 rfkill
[ T2977]  __schedule+0x167e/0x1ca0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  efi_pstore configfs
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2386]  nfnetlink efivarfs autofs4
[ T2386]  ext4 mbcache
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2386]  jbd2 usbhid
[ T2386]  amdgpu amdxcp i2c_algo_bit
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  drm_client_lib
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  gpu_sched drm_suballoc_helper
[ T2977]  ? lock_release+0x21b/0x2e0
[ T2386]  drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd
[ T2977]  schedule_rtlock+0x21/0x40
[ T2386]  drm_display_helper usbcore
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T2386]  hid_sensor_hub drm_kms_helper psmouse
[ T2977]  ? preempt_count_sub+0x96/0xd0
[ T2386]  nvme mfd_core hid_multitouch
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  hid_generic serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2=
c_hid_acpi
[ T2977]  rt_spin_lock+0x99/0x190
[ T2386]  i2c_hid hid i2c_piix4 i2c_smbus
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2386]  i2c_designware_platform i2c_designware_core [last unloaded: bpf_t=
estmod(O)]
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T2386] Preemption disabled at:
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2386] [<0000000000000000>] 0x0
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  usbcore
[  T555]  videobuf2_common
[ T2977] Call Trace:
[ T2977]  <TASK>
[ T1157]  drm_kms_helper
[  T555]  snd_pcm
[ T1157]  psmouse
[  T555]  mc
[ T2977]  dump_stack_lvl+0x6d/0xb0
[  T555]  sparse_keymap
[ T1157]  nvme
[  T555]  snd_soc_acpi
[ T1157]  mfd_core
[  T555]  snd_timer
[ T1157]  hid_multitouch
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[  T555]  wmi_bmof
[ T1157]  hid_generic
[  T555]  edac_mce_amd
[ T1157]  serio_raw
[  T555]  snd k10temp
[ T1157]  nvme_core
[ T2977]  __schedule+0x167e/0x1ca0
[  T555]  snd_pci_acp3x
[ T1157]  r8169
[  T555]  soundcore ccp
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  usb_common
[  T555]  battery
[ T1157]  amd_sfh
[  T555]  ac
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1157]  crc16
[  T555]  button joydev
[ T1157]  i2c_hid_acpi
[  T555]  hid_sensor_magn_3d
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_prox
[ T1157]  i2c_hid
[  T555]  hid_sensor_accel_3d
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  hid_sensor_gyro_3d
[ T1157]  hid
[  T555]  hid_sensor_als
[ T1157]  i2c_piix4
[  T555]  hid_sensor_trigger
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  i2c_smbus
[  T555]  industrialio_triggered_buffer
[ T1157]  i2c_designware_platform
[  T555]  kfifo_buf
[ T1157]  i2c_designware_core
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  industrialio evdev
[ T1157]  [last unloaded: bpf_testmod(O)]
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  hid_sensor_iio_common
[ T1157]=20
[  T555]  amd_pmc
[ T1157] Preemption disabled at:
[  T555]  sch_fq_codel
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  mt7921e mt7921_common
[ T1157] [<ffffffffa215f33f>] fput+0x1f/0x90
[  T555]  mt792x_lib
[ T2977]  ? lock_release+0x21b/0x2e0
[  T555]  mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill
[ T2977]  schedule_rtlock+0x21/0x40
[  T555]  msr nvme_fabrics fuse
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  efi_pstore configfs nfnetlink efivarfs
[ T2977]  ? preempt_count_sub+0x96/0xd0
[  T555]  autofs4 ext4 mbcache jbd2
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper t=
tm drm_exec gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[ T2977]  rt_spin_lock+0x99/0x190
[  T555]  cec xhci_pci drm_buddy xhci_hcd drm_display_helper
[ T2977]  task_get_cgroup1+0xe8/0x340
[  T555]  usbcore hid_sensor_hub drm_kms_helper psmouse nvme
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  mfd_core hid_multitouch hid_generic serio_raw
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  nvme_core r8169 usb_common amd_sfh
[ T2977]  bpf_trace_run2+0xd3/0x260
[  T555]  crc16 i2c_hid_acpi i2c_hid hid
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  i2c_piix4 i2c_smbus i2c_designware_platform i2c_designware_core [=
last unloaded: bpf_testmod(O)]
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[  T555] Preemption disabled at:
[  T555] [<ffffffffa21386bd>] count_memcg_events+0x4d/0x280
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0000
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[ T2977]  </TASK>
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T2065] BUG: scheduling while atomic: glean.dispatche/2065/0x00000002
[  T555]  ? count_memcg_events+0x4d/0x280
[ T2065] INFO: lockdep is turned off.
[ T2065] Modules linked in:
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T2065]  bpf_testmod(O) ccm
[  T555]  __schedule+0x167e/0x1ca0
[ T2065]  snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_raw=
midi
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2065]  snd_seq snd_seq_device
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2065]  rfcomm bnep snd_ctl_led
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2065]  snd_hda_codec_realtek
[ T2065]  snd_hda_codec_generic snd_hda_scodec_component
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2065]  snd_hda_codec_hdmi nls_ascii nls_cp437
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2065]  vfat fat snd_acp3x_pdm_dma
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2065]  snd_soc_dmic snd_acp3x_rn btusb
[  T555]  ? lock_release+0x21b/0x2e0
[ T2065]  btrtl snd_soc_core btintel btbcm btmtk bluetooth
[  T555]  schedule_rtlock+0x21/0x40
[ T2065]  ecdh_generic ecc snd_hda_intel
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T2065]  snd_intel_dspcfg uvcvideo snd_hda_codec videobuf2_vmalloc
[  T555]  ? lock_release+0x21b/0x2e0
[ T2065]  videobuf2_memops snd_hwdep uvc
[  T555]  ? fput+0x3f/0x90
[ T2065]  snd_hda_core videobuf2_v4l2 snd_pcm_oss
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_mixer_oss
[ T2065] RSP: 002b:00007f1f5f4f5a98 EFLAGS: 00000202
[ T1155]  videobuf2_common snd_acp_config
[ T2065]  ORIG_RAX: 0000000000000018
[ T1155]  msi_wmi
[ T2065] RAX: ffffffffffffffda RBX: 00007f1f60e68240 RCX: 00007f1f6d7ed8c7
[ T1155]  snd_pcm mc
[ T2065] RDX: 0000000000000001 RSI: 00007f1f5f4f5c10 RDI: 00007f1f60e68240
[ T1155]  sparse_keymap
[ T2065] RBP: 000000003b9aca00 R08: 0000000000000000 R09: 0000000000000001
[ T1155]  snd_soc_acpi snd_timer
[ T2065] R10: 00007f1f31d924e0 R11: 0000000000000202 R12: 00007f1f6d7ed8c0
[ T1155]  wmi_bmof edac_mce_amd
[ T2065] R13: 00007f1f6d4a0400 R14: 00007f1f5f4f5c10 R15: 0000000000000008
[ T1155]  snd k10temp snd_pci_acp3x soundcore ccp battery ac button joydev =
hid_sensor_magn_3d
[ T2065]  </TASK>
[ T1155]  hid_sensor_prox
[ T1155]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_=
trigger industrialio_triggered_buffer kfifo_buf industrialio evdev hid_sens=
or_iio_common amd_pmc sch_fq_codel mt7921e mt7921_common mt792x_lib mt76_co=
nnac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_ps=
tore configfs nfnetlink efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu am=
dxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched drm_=
suballoc_helper drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd =
drm_display_helper usbcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_c=
ore hid_multitouch hid_generic serio_raw nvme_core r8169 usb_common amd_sfh=
 crc16 i2c_hid_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform=
 i2c_designware_core
[ T1157] BUG: scheduling while atomic: rs:main Q:Reg/1157/0x00000002
[ T1155]  [last unloaded: bpf_testmod(O)]
[ T1157] INFO: lockdep is turned off.
[ T1155] Preemption disabled at:
[ T1157] Modules linked in: bpf_testmod(O)
[ T1155] [<ffffffffa29f1017>] preempt_schedule_irq+0x27/0x70
[ T1157]  ccm
[ T1157]  snd_seq_dummy snd_hrtimer
[ T1155] CPU: 8 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1157]  snd_seq_midi snd_seq_midi_event
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1157]  snd_rawmidi
[ T1155] Call Trace:
[ T1157]  snd_seq snd_seq_device
[ T1155]  <TASK>
[ T1157]  rfcomm bnep
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1157]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T1155]  ? preempt_schedule_irq+0x27/0x70
[ T1157]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1157]  nls_cp437 vfat
[ T1155]  __schedule+0x167e/0x1ca0
[ T1157]  fat snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1157]  snd_acp3x_rn btusb btrtl
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  snd_soc_core btintel btbcm
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1157]  btmtk bluetooth
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  ecdh_generic ecc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  snd_hda_intel
[ T1157]  snd_intel_dspcfg
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1157]  uvcvideo
[ T1157]  snd_hda_codec videobuf2_vmalloc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  videobuf2_memops snd_hwdep
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1157]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T1155]  schedule_rtlock+0x21/0x40
[ T1157]  videodev snd_rn_pci_acp3x
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1157]  snd_mixer_oss videobuf2_common snd_acp_config
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  msi_wmi snd_pcm
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1157]  mc sparse_keymap snd_soc_acpi
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  snd_timer wmi_bmof edac_mce_amd snd k10temp snd_pci_acp3x soundco=
re ccp
[ T1155]  rt_spin_lock+0x99/0x190
[ T1157]  battery ac button joydev
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1157]  hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1157]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1157]  industrialio_triggered_buffer kfifo_buf industrialio
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1157]  evdev hid_sensor_iio_common amd_pmc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  sch_fq_codel mt7921e mt7921_common mt792x_lib
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1157]  mt76_connac_lib mt76 mac80211 libarc4
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1157]  cfg80211 rfkill msr nvme_fabrics
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1157]  fuse
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  efi_pstore configfs nfnetlink efivarfs
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1157]  autofs4 ext4 mbcache jbd2
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1157]  usbhid amdgpu
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1157]  amdxcp i2c_algo_bit
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[ T1157]  drm_client_lib
[ T1155]  ORIG_RAX: 0000000000000060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700a4b08 RCX: 00007fc77f05c7f9
[ T1157]  drm_ttm_helper ttm
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1157]  drm_exec
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 00000000000423fa
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1157]  gpu_sched
[ T1155] R13: 00007fc77e6b02e0 R14: 000000000007bc45 R15: 000055f047b7b880
[ T1157]  drm_suballoc_helper
[ T1157]  drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_di=
splay_helper usbcore
[ T1155]  </TASK>
[ T2013]  rt_spin_lock+0x99/0x190
[ T2977]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industrialio=
_triggered_buffer kfifo_buf
[ T2977]  sch_fq_codel mt7921e mt7921_common
[ T2977]  mt792x_lib mt76_connac_lib mt76 mac80211
[ T2977]  libarc4 cfg80211 rfkill
[ T2013]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  autofs4 ext4 mbcache jbd2
[ T2013]  syscall_trace_enter+0x1c7/0x260
[ T2977]  usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib
[ T2013]  do_syscall_64+0x395/0xfa0
[ T2977]  drm_ttm_helper ttm drm_exec
[ T2013]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks cec
[ T2013]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  xhci_pci drm_buddy xhci_hcd drm_display_helper
[ T2013] RIP: 0033:0x7f1f6dca8a0e
[ T2977]  usbcore hid_sensor_hub
[ T2013] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T2977]  drm_kms_helper psmouse
[ T2013] RSP: 002b:00007ffe34ff9d70 EFLAGS: 00000297
[ T2977]  nvme
[ T2013]  ORIG_RAX: 00000000000000e4
[ T2977]  mfd_core hid_multitouch
[ T2013] RAX: ffffffffffffffda RBX: 00007f1f60e3d200 RCX: 00007f1f6dca8a0e
[ T2977]  hid_generic
[ T2977]  serio_raw nvme_core
[ T2013] RBP: 00007ffe34ff9d70 R08: 0000000000000000 R09: 00007f1f6dca2000
[ T2977]  r8169 usb_common
[ T2013] R10: 0000000000000001 R11: 0000000000000297 R12: 000000007fffffff
[ T2977]  amd_sfh
[ T2977]  crc16 i2c_hid_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_designware=
_platform i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2977] Preemption disabled at:
[ T2013]  </TASK>
[ T2977] [<0000000000000000>] 0x0
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977] Call Trace:
[ T2977]  <TASK>
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T2013] BUG: scheduling while atomic: firefox-esr/2013/0x00000002
[ T2977]  __schedule+0x167e/0x1ca0
[ T2013] INFO: lockdep is turned off.
[ T2013] Modules linked in:
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2013]  bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2013]  snd_seq_midi snd_seq_midi_event
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2013]  snd_rawmidi snd_seq snd_seq_device rfcomm
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2013]  bnep snd_ctl_led snd_hda_codec_realtek
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2013]  snd_hda_codec_generic snd_hda_scodec_component
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2013]  snd_hda_codec_hdmi nls_ascii nls_cp437 vfat
[ T2013]  fat snd_acp3x_pdm_dma
[ T2977]  ? lock_release+0x21b/0x2e0
[ T2013]  snd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_core btintel
[ T2977]  schedule_rtlock+0x21/0x40
[ T2013]  btbcm btmtk bluetooth ecdh_generic
[ T2013]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2013]  snd_hda_codec videobuf2_vmalloc
[ T2010] BUG: scheduling while atomic: xfce4-terminal/2010/0x00000002
[ T2013]  snd_acp_config
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2013]  snd_timer
[ T2013]  edac_mce_amd
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T2013]  k10temp snd_pci_acp3x
[ T2010]  snd_seq_midi
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2013]  soundcore
[ T2010]  snd_seq_midi_event
[ T2013]  ccp
[ T2010]  snd_rawmidi snd_seq
[ T2013]  battery ac
[ T2010]  snd_seq_device
[ T2013]  button
[ T2010]  rfcomm
[ T2010]  bnep
[ T2010]  snd_ctl_led
[ T2013]  hid_sensor_gyro_3d
[ T2010]  snd_hda_codec_generic
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2013]  hid_sensor_als
[ T2010]  snd_hda_codec_hdmi
[ T2010]  nls_ascii nls_cp437
[ T2013]  kfifo_buf
[ T2013]  industrialio
[ T2010]  fat
[ T2013]  hid_sensor_iio_common
[ T2010]  snd_acp3x_pdm_dma
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0000
[ T2013]  amd_pmc
[ T2010]  snd_soc_dmic
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2010]  snd_acp3x_rn
[ T2013]  mt7921e
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2010]  btusb
[ T2010]  btrtl
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T2013]  mt792x_lib
[ T2010]  snd_soc_core
[ T2013]  mt76_connac_lib
[ T2010]  btintel
[ T2013]  mt76 mac80211
[ T2013]  cfg80211 rfkill
[ T2013]  msr
[ T2010]  ecdh_generic
[ T2010]  ecc
[ T2013]  fuse
[ T2010]  snd_hda_intel
[ T2010]  snd_intel_dspcfg uvcvideo
[ T2013]  nfnetlink efivarfs
[ T2010]  videobuf2_vmalloc
[ T2013]  mbcache
[ T2010]  uvc
[ T2010]  snd_pcm_oss
[ T2013]  drm_client_lib
[ T2013]  drm_ttm_helper ttm
[ T2010]  snd_mixer_oss
[ T2013]  gpu_sched drm_suballoc_helper
[ T2010]  videobuf2_common snd_acp_config
[ T2013]  drm_panel_backlight_quirks cec
[ T2010]  msi_wmi
[ T2010]  snd_pcm
[ T2013]  drm_buddy
[ T2010]  snd_soc_acpi
[ T2013]  hid_sensor_hub drm_kms_helper
[ T2010]  wmi_bmof
[ T2010]  edac_mce_amd
[ T2010]  snd
[ T2013]  hid_generic
[ T2013]  crc16
[ T2010]  hid_sensor_prox
[ T2010]  hid_sensor_gyro_3d
[ T2010]  industrialio_triggered_buffer
[ T1157] INFO: lockdep is turned off.
[ T2013] [<0000000000000000>] 0x0
[ T2010]  industrialio
[ T1157]  bpf_testmod(O) ccm
[ T2010]  evdev
[ T2010]  hid_sensor_iio_common
[ T2977]  i2c_piix4
[ T1157]  ccp
[ T2977]  i2c_designware_platform
[ T1157]  battery ac
[ T2977]  i2c_designware_core
[ T2010]  bpf_testmod(O)
[ T1157]  button
[ T2977]  [last unloaded: bpf_testmod(O)]
[ T2010]  ccm
[ T1157]  joydev
[ T2977]=20
[ T2010]  snd_seq_dummy
[ T2977] Preemption disabled at:
[ T2010]  snd_hrtimer
[ T1157]  hid_sensor_prox
[ T2010]  snd_seq_midi
[ T1157]  hid_sensor_accel_3d
[ T2977] [<0000000000000000>] 0x0
[ T1157]  hid_sensor_gyro_3d
[ T2010]  snd_seq_midi_event
[ T1157]  hid_sensor_als
[ T2010]  snd_rawmidi
[ T1157]  hid_sensor_trigger
[ T2010]  snd_seq
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1157]  industrialio_triggered_buffer
[ T2010]  snd_seq_device
[ T1157]  kfifo_buf
[ T2010]  rfcomm bnep
[ T1157]  industrialio
[ T2010]  snd_ctl_led
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1157]  evdev hid_sensor_iio_common
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2010]  snd_hda_codec_realtek
[ T1157]  amd_pmc
[ T2977] Call Trace:
[ T2010]  snd_hda_codec_generic
[ T1157]  sch_fq_codel
[ T2010]  snd_hda_scodec_component
[ T2977]  <TASK>
[ T1157]  mt7921_common
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T2010]  nls_cp437 vfat
[ T1157]  mt76_connac_lib mt76
[ T2010]  fat
[ T1157]  mac80211
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T1157]  libarc4
[ T2977]  __schedule+0x167e/0x1ca0
[ T1157]  msr
[ T1157]  nvme_fabrics fuse
[ T2010]  btintel
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  efi_pstore
[ T2010]  btbcm btmtk
[ T1157]  configfs
[ T2010]  bluetooth
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  nfnetlink
[ T2010]  ecdh_generic
[ T1157]  efivarfs autofs4
[ T2010]  ecc
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1157]  ext4
[ T1157]  mbcache
[ T2010]  snd_intel_dspcfg
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  uvcvideo
[ T1157]  jbd2 usbhid
[ T2010]  snd_hda_codec videobuf2_vmalloc
[ T1157]  amdgpu
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  amdxcp
[ T2010]  videobuf2_memops
[ T1157]  i2c_algo_bit
[ T2010]  snd_hwdep
[ T1157]  drm_client_lib
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2010]  uvc
[ T1157]  drm_ttm_helper
[ T2010]  snd_hda_core
[ T1157]  ttm
[ T2010]  videobuf2_v4l2
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1157]  drm_exec
[ T2010]  snd_pcm_oss
[ T1157]  gpu_sched
[ T2977]  ? lock_release+0x21b/0x2e0
[ T2010]  videodev
[ T1157]  drm_suballoc_helper
[ T2010]  snd_rn_pci_acp3x
[ T1157]  drm_panel_backlight_quirks
[ T1157]  cec
[ T2010]  snd_mixer_oss
[ T2010]  videobuf2_common
[ T1157]  xhci_pci
[ T2977]  schedule_rtlock+0x21/0x40
[ T1157]  drm_buddy
[ T2010]  msi_wmi
[ T2010]  mc sparse_keymap
[ T2010]  snd_soc_acpi
[ T2010]  wmi_bmof
[ T1157]  mfd_core
[ T2010]  edac_mce_amd
[ T1157]  hid_multitouch
[ T2010]  snd
[ T1157]  hid_generic
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  k10temp
[ T1157]  serio_raw
[ T2010]  snd_pci_acp3x soundcore
[ T1157]  nvme_core r8169
[ T2010]  ccp battery
[ T1157]  usb_common
[ T2010]  ac
[ T1157]  amd_sfh crc16
[ T2010]  button joydev
[ T1157]  i2c_hid_acpi i2c_hid
[ T2010]  hid_sensor_magn_3d
[ T2977]  rt_spin_lock+0x99/0x190
[ T1157]  hid
[ T2010]  hid_sensor_prox
[ T1157]  i2c_piix4
[ T2010]  hid_sensor_accel_3d hid_sensor_gyro_3d
[ T1157]  i2c_smbus i2c_designware_platform
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2010]  hid_sensor_als
[ T1157]  i2c_designware_core
[ T2010]  hid_sensor_trigger
[ T1157]  [last unloaded: bpf_testmod(O)]
[ T2010]  industrialio_triggered_buffer
[ T1157]=20
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T1157] Preemption disabled at:
[ T2010]  kfifo_buf industrialio evdev
[ T1157] [<ffffffffa215f33f>] fput+0x1f/0x90
[ T2010]  hid_sensor_iio_common
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2010]  amd_pmc sch_fq_codel mt7921e
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T2010]  mt7921_common mt792x_lib mt76_connac_lib mt76
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T2010]  fuse efi_pstore configfs nfnetlink efivarfs
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T2010]  autofs4 ext4 mbcache jbd2
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2010]  usbhid amdgpu amdxcp
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2010]  gpu_sched drm_suballoc_helper
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2010]  drm_panel_backlight_quirks cec xhci_pci
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2010]  drm_buddy
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202
[ T2010]  xhci_hcd drm_display_helper
[ T2977]  ORIG_RAX: 0000000000000000
[ T2010]  usbcore
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2010]  hid_sensor_hub drm_kms_helper
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2010]  psmouse nvme
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700288e8 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004240a
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 000000000007df5c R15: 000055f047b7b880
[ T2010] BUG: scheduling while atomic: xfce4-terminal/2010/0x00000002
[ T2010] INFO: lockdep is turned off.
[ T1155]  </TASK>
[ T2010] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer sn=
d_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bne=
p snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_co=
mponent snd_hda_codec_hdmi nls_ascii nls_cp437 vfat fat snd_acp3x_pdm_dma s=
nd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_core btintel btbcm btmtk bluet=
ooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T2010]  uvcvideo snd_hda_codec
[ T2977] INFO: lockdep is turned off.
[ T2010]  videobuf2_vmalloc
[ T2977] Modules linked in:
[ T2010]  videobuf2_memops snd_hwdep
[ T2977]  bpf_testmod(O) ccm
[ T2010]  uvc snd_hda_core
[ T2977]  snd_seq_dummy snd_hrtimer
[ T2010]  videobuf2_v4l2 snd_pcm_oss
[ T2977]  snd_seq_midi
[ T2010]  videodev
[ T2977]  snd_seq_midi_event
[ T2010]  snd_rn_pci_acp3x
[ T2977]  snd_rawmidi
[ T2010]  snd_mixer_oss
[ T2977]  snd_seq
[ T2010]  videobuf2_common
[ T2977]  snd_seq_device
[ T2010]  snd_acp_config
[ T2977]  rfcomm bnep
[ T2010]  msi_wmi
[ T2977]  snd_ctl_led
[ T2010]  snd_pcm
[ T2977]  snd_hda_codec_realtek
[ T2010]  mc sparse_keymap
[ T2977]  snd_hda_codec_generic
[ T2010]  snd_soc_acpi
[ T2977]  snd_hda_scodec_component
[ T2977]  snd_hda_codec_hdmi
[ T2010]  snd_timer wmi_bmof
[ T2977]  nls_ascii nls_cp437
[ T2010]  edac_mce_amd snd
[ T2977]  vfat fat
[ T2010]  k10temp snd_pci_acp3x
[ T2977]  snd_acp3x_pdm_dma snd_soc_dmic
[ T2010]  soundcore ccp
[ T2977]  snd_acp3x_rn btusb
[ T2010]  battery ac
[ T2977]  btrtl snd_soc_core
[ T2010]  button joydev
[ T2977]  btintel btbcm
[ T2010]  hid_sensor_magn_3d
[ T2977]  btmtk
[ T2010]  hid_sensor_prox
[ T2977]  bluetooth
[ T2010]  hid_sensor_accel_3d
[ T2010]  hid_sensor_gyro_3d
[ T2977]  ecdh_generic
[ T2977]  ecc
[ T2010]  hid_sensor_als hid_sensor_trigger
[ T2977]  snd_hda_intel snd_intel_dspcfg
[ T2010]  industrialio_triggered_buffer kfifo_buf
[ T2977]  uvcvideo snd_hda_codec
[ T2010]  industrialio
[ T2977]  videobuf2_vmalloc
[ T2010]  evdev
[ T2010]  hid_sensor_iio_common
[ T2977]  videobuf2_memops snd_hwdep
[ T2010]  amd_pmc sch_fq_codel
[ T2977]  uvc snd_hda_core
[ T2010]  mt7921e mt7921_common
[ T2977]  videobuf2_v4l2 snd_pcm_oss
[ T2010]  mt792x_lib
[ T2977]  videodev
[ T2010]  mt76_connac_lib
[ T2977]  snd_rn_pci_acp3x
[ T2010]  mt76 mac80211
[ T2977]  snd_mixer_oss videobuf2_common
[ T2010]  libarc4 cfg80211
[ T2977]  snd_acp_config msi_wmi
[ T2010]  rfkill msr
[ T2977]  snd_pcm mc
[ T2010]  nvme_fabrics fuse
[ T2977]  sparse_keymap snd_soc_acpi
[ T2010]  efi_pstore configfs
[ T2977]  snd_timer
[ T2010]  nfnetlink
[ T2977]  wmi_bmof edac_mce_amd
[ T2010]  efivarfs
[ T2977]  snd
[ T2010]  autofs4 ext4
[ T2977]  k10temp
[ T2010]  mbcache
[ T2977]  snd_pci_acp3x soundcore
[ T2010]  jbd2 usbhid
[ T2977]  ccp battery
[ T2010]  amdgpu
[ T2977]  ac
[ T2010]  amdxcp
[ T2977]  button
[ T2010]  i2c_algo_bit
[ T2977]  joydev hid_sensor_magn_3d
[ T2010]  drm_client_lib drm_ttm_helper
[ T2977]  hid_sensor_prox hid_sensor_accel_3d
[ T2010]  ttm drm_exec
[ T2977]  hid_sensor_gyro_3d hid_sensor_als
[ T2010]  gpu_sched drm_suballoc_helper
[ T2977]  hid_sensor_trigger industrialio_triggered_buffer
[ T2010]  drm_panel_backlight_quirks
[ T2977]  kfifo_buf
[ T2010]  cec
[ T2977]  industrialio
[ T2010]  xhci_pci drm_buddy
[ T2977]  evdev hid_sensor_iio_common
[ T2010]  xhci_hcd drm_display_helper
[ T2977]  amd_pmc sch_fq_codel
[ T2010]  usbcore hid_sensor_hub
[ T2977]  mt7921e mt7921_common
[ T2010]  drm_kms_helper
[ T2977]  mt792x_lib
[ T2010]  psmouse
[ T2977]  mt76_connac_lib
[ T2010]  nvme
[ T2977]  mt76
[ T2010]  mfd_core
[ T2977]  mac80211
[ T2010]  hid_multitouch hid_generic
[ T2977]  libarc4 cfg80211
[ T2010]  serio_raw nvme_core
[ T2977]  rfkill msr
[ T2010]  r8169
[ T2977]  nvme_fabrics
[ T2010]  usb_common
[ T2977]  fuse
[ T2010]  amd_sfh
[ T2977]  efi_pstore configfs
[ T2010]  crc16 i2c_hid_acpi
[ T2977]  nfnetlink efivarfs
[ T2010]  i2c_hid hid
[ T2977]  autofs4 ext4
[ T2010]  i2c_piix4 i2c_smbus
[ T2977]  mbcache jbd2
[ T2010]  i2c_designware_platform
[ T2977]  usbhid
[ T2010]  i2c_designware_core
[ T2977]  amdgpu
[ T2010]  [last unloaded: bpf_testmod(O)]
[ T2977]  amdxcp i2c_algo_bit
[ T2010]=20
[ T2977]  drm_client_lib
[ T2010] Preemption disabled at:
[ T2977]  drm_ttm_helper ttm
[ T2010] [<ffffffffa215f33f>] fput+0x1f/0x90
[ T1155] Call Trace:
[ T2977]  evdev
[ T1155]  <TASK>
[ T2977]  hid_sensor_iio_common amd_pmc sch_fq_codel
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T2977]  mt7921e mt7921_common mt792x_lib mt76_connac_lib
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  mt76 mac80211 libarc4
[ T1155]  __schedule+0x167e/0x1ca0
[ T2977]  cfg80211 rfkill msr nvme_fabrics
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  fuse efi_pstore configfs nfnetlink
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  efivarfs autofs4 ext4
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  mbcache jbd2 usbhid amdgpu
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  amdxcp i2c_algo_bit drm_client_lib
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  drm_ttm_helper ttm drm_exec
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  cec xhci_pci
[ T1155]  ? lock_release+0x21b/0x2e0
[ T2977]  drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_=
kms_helper
[ T1155]  schedule_rtlock+0x21/0x40
[ T2977]  psmouse nvme mfd_core hid_multitouch
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  hid_generic serio_raw nvme_core
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  r8169 usb_common amd_sfh
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  crc16 i2c_hid_acpi i2c_hid hid
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  i2c_piix4 i2c_smbus i2c_designware_platform i2c_designware_core [=
last unloaded: bpf_testmod(O)]
[ T2977] Preemption disabled at:
[ T2977] [<0000000000000000>] 0x0
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc77008edf8 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 0000000000042410
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 000000000007edf0 R15: 000055f047b7b880
[ T1155]  </TASK>
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977] Call Trace:
[ T2977]  <TASK>
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T2010] BUG: scheduling while atomic: xfce4-terminal/2010/0x00000002
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T2010] INFO: lockdep is turned off.
[ T2010] Modules linked in: bpf_testmod(O) ccm
[ T2977]  __schedule+0x167e/0x1ca0
[ T2010]  snd_seq_dummy snd_hrtimer snd_seq_midi
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  snd_seq_midi_event snd_rawmidi snd_seq
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  snd_seq_device
[ T2010]  rfcomm bnep
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2010]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii nls_cp437
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  vfat fat
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2010]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  btrtl snd_soc_core
[ T2977]  ? lock_release+0x21b/0x2e0
[ T2010]  btintel btbcm btmtk bluetooth ecdh_generic ecc
[ T2977]  schedule_rtlock+0x21/0x40
[ T2010]  snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T2010]  videobuf2_vmalloc videobuf2_memops snd_hwdep uvc
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2010]  videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  snd_acp_config msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi snd_=
timer wmi_bmof edac_mce_amd snd
[ T2977]  rt_spin_lock+0x99/0x190
[ T2010]  k10temp snd_pci_acp3x soundcore ccp battery ac
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2010]  button joydev hid_sensor_magn_3d hid_sensor_prox
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T2010]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_=
trigger
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2010]  industrialio_triggered_buffer kfifo_buf industrialio evdev
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T2010]  hid_sensor_iio_common amd_pmc sch_fq_codel
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T2010]  libarc4 cfg80211 rfkill msr nvme_fabrics
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T2010]  fuse efi_pstore configfs nfnetlink efivarfs
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2010]  autofs4 ext4 mbcache
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  jbd2 usbhid amdgpu amdxcp
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2010]  i2c_algo_bit drm_client_lib drm_ttm_helper ttm
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2010]  drm_exec gpu_sched
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2010]  drm_suballoc_helper drm_panel_backlight_quirks
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202
[ T2010]  cec
[ T2977]  ORIG_RAX: 0000000000000000
[ T2010]  xhci_pci
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2010]  drm_buddy xhci_hcd
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2010]  drm_display_helper
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[ T2010]  usbcore hid_sensor_hub
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T2010]  drm_kms_helper
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[ T2010]  psmouse nvme mfd_core hid_multitouch hid_generic serio_raw nvme_c=
ore r8169 usb_common amd_sfh crc16
[ T2977]  </TASK>
[ T2010]  i2c_hid_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platf=
orm i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2010] Preemption disabled at:
[ T2010] [<ffffffffa215f33f>] fput+0x1f/0x90
[ T2010] CPU: 9 UID: 1000 PID: 2010 Comm: xfce4-terminal Tainted: G        =
W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2010] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2010] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2010] Call Trace:
[ T2010]  <TASK>
[ T2010]  dump_stack_lvl+0x6d/0xb0
[ T2010]  ? fput+0x1f/0x90
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T2977] INFO: lockdep is turned off.
[ T2977] Modules linked in:
[ T2010]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  bpf_testmod(O) ccm snd_seq_dummy
[ T2010]  __schedule+0x167e/0x1ca0
[ T2977]  snd_hrtimer snd_seq_midi snd_seq_midi_event
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_rawmidi snd_seq snd_seq_device rfcomm bnep
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_ctl_led snd_hda_codec_realtek
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  nls_ascii nls_cp437 vfat fat
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2977]  btusb btrtl snd_soc_core
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  btintel btbcm btmtk
[ T2010]  ? lock_release+0x21b/0x2e0
[ T2977]  bluetooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg uvcvideo
[ T2010]  schedule_rtlock+0x21/0x40
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T2977]  snd_hda_codec
[ T2977]  videobuf2_vmalloc
[ T1155] INFO: lockdep is turned off.
[ T2977]  videobuf2_memops
[ T1155] Modules linked in:
[ T2010]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  snd_hwdep uvc
[ T1155]  bpf_testmod(O)
[ T2977]  snd_hda_core
[ T1155]  ccm
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  videobuf2_v4l2
[ T1155]  snd_seq_dummy snd_hrtimer
[ T2977]  snd_pcm_oss
[ T2010]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  videodev
[ T1155]  snd_seq_midi snd_seq_midi_event
[ T2977]  snd_rn_pci_acp3x snd_mixer_oss
[ T1155]  snd_rawmidi
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  videobuf2_common
[ T1155]  snd_seq snd_seq_device
[ T2977]  snd_acp_config msi_wmi
[ T1155]  rfcomm bnep
[ T2977]  snd_pcm mc
[ T1155]  snd_ctl_led snd_hda_codec_realtek
[ T2977]  sparse_keymap snd_soc_acpi
[ T1155]  snd_hda_codec_generic snd_hda_scodec_component
[ T2977]  snd_timer wmi_bmof
[ T1155]  snd_hda_codec_hdmi
[ T2010]  rt_spin_lock+0x99/0x190
[ T2977]  edac_mce_amd
[ T1155]  nls_ascii
[ T2977]  snd
[ T1155]  nls_cp437
[ T2977]  k10temp
[ T1155]  vfat
[ T2010]  task_get_cgroup1+0xe8/0x340
[ T2977]  snd_pci_acp3x
[ T1155]  fat
[ T2977]  soundcore
[ T1155]  snd_acp3x_pdm_dma snd_soc_dmic
[ T2977]  ccp
[ T1155]  snd_acp3x_rn
[ T2010]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  battery
[ T1155]  btusb
[ T2977]  ac button
[ T1155]  btrtl
[ T2977]  joydev
[ T2010]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  snd_soc_core
[ T2977]  hid_sensor_magn_3d
[ T1155]  btintel btbcm
[ T2977]  hid_sensor_prox hid_sensor_accel_3d
[ T1155]  btmtk
[ T2010]  bpf_trace_run2+0xd3/0x260
[ T2977]  hid_sensor_gyro_3d
[ T1155]  bluetooth ecdh_generic
[ T2977]  hid_sensor_als
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  hid_sensor_trigger
[ T1155]  ecc snd_hda_intel
[ T2977]  industrialio_triggered_buffer
[ T1155]  snd_intel_dspcfg
[ T2977]  kfifo_buf
[ T1155]  uvcvideo
[ T2977]  industrialio
[ T1155]  snd_hda_codec
[ T2010]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  evdev
[ T1155]  videobuf2_vmalloc videobuf2_memops
[ T2977]  hid_sensor_iio_common amd_pmc
[ T1155]  snd_hwdep uvc
[ T2977]  sch_fq_codel
[ T2010]  syscall_trace_enter+0x1c7/0x260
[ T1155]  snd_hda_core
[ T2977]  mt7921e mt7921_common
[ T1155]  videobuf2_v4l2
[ T2977]  mt792x_lib
[ T1155]  snd_pcm_oss videodev
[ T2010]  do_syscall_64+0x395/0xfa0
[ T2977]  mt76_connac_lib mt76
[ T1155]  snd_rn_pci_acp3x snd_mixer_oss
[ T2977]  mac80211
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  videobuf2_common
[ T2977]  libarc4 cfg80211
[ T1155]  snd_acp_config
[ T2977]  rfkill
[ T1155]  msi_wmi snd_pcm
[ T2010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  msr
[ T1155]  mc
[ T2977]  nvme_fabrics fuse
[ T1155]  sparse_keymap snd_soc_acpi
[ T2010]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  videodev
[ T1155]  snd_rn_pci_acp3x snd_mixer_oss
[ T2010]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  videobuf2_common snd_acp_config msi_wmi snd_pcm
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  mc sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd snd=
 k10temp snd_pci_acp3x soundcore ccp
[ T2010]  rt_spin_lock+0x99/0x190
[ T1155]  battery ac button joydev hid_sensor_magn_3d
[ T2010]  task_get_cgroup1+0xe8/0x340
[ T1155]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als
[ T2010]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
[ T2010]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  industrialio evdev hid_sensor_iio_common amd_pmc
[ T2010]  bpf_trace_run2+0xd3/0x260
[ T1155]  sch_fq_codel mt7921e mt7921_common
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211
[ T2010]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  rfkill msr nvme_fabrics fuse efi_pstore
[ T2010]  syscall_trace_enter+0x1c7/0x260
[ T1155]  configfs nfnetlink efivarfs autofs4 ext4
[ T2010]  do_syscall_64+0x395/0xfa0
[ T1155]  mbcache jbd2
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib
[ T2010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  drm_ttm_helper ttm drm_exec
[ T2010] RIP: 0033:0x7f0e4bf16a0e
[ T1155]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[ T2010] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T1155]  cec
[ T2010] RSP: 002b:00007ffc276f5140 EFLAGS: 00000297
[ T1155]  xhci_pci drm_buddy
[ T2010]  ORIG_RAX: 00000000000000e4
[ T1155]  xhci_hcd
[ T2010] RAX: ffffffffffffffda RBX: 000055766d941690 RCX: 00007f0e4bf16a0e
[ T1155]  drm_display_helper usbcore
[ T2010] RDX: 0000000000000002 RSI: 00007ffc276f51b0 RDI: 0000000000000001
[ T1155]  hid_sensor_hub
[ T2010] RBP: 00007ffc276f5140 R08: 0000000000000000 R09: 00007f0e4bf10000
[ T1155]  drm_kms_helper psmouse
[ T2010] R10: 0000000000000001 R11: 0000000000000297 R12: 000000007fffffff
[ T1155]  nvme
[ T2010] R13: 000055766d04b0b0 R14: 000055766d941690 R15: 000055766d04b0b0
[ T1155]  mfd_core hid_multitouch hid_generic serio_raw nvme_core r8169 usb=
_common amd_sfh crc16 i2c_hid_acpi i2c_hid
[ T2010]  </TASK>
[ T1155]  hid i2c_piix4 i2c_smbus i2c_designware_platform i2c_designware_co=
re [last unloaded: bpf_testmod(O)]
[ T1155] Preemption disabled at:
[ T1155] [<0000000000000000>] 0x0
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010] BUG: scheduling while atomic: xfce4-terminal/2010/0x00000002
[ T2010] INFO: lockdep is turned off.
[ T2010] Modules linked in:
[ T1155]  ? lock_release+0x21b/0x2e0
[ T2010]  bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer snd_seq_midi
[ T1155]  schedule_rtlock+0x21/0x40
[ T2010]  snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T2010]  rfcomm bnep snd_ctl_led snd_hda_codec_realtek
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2010]  nls_ascii nls_cp437 vfat
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  fat
[ T2010]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_c=
ore btintel btbcm btmtk bluetooth
[ T1155]  rt_spin_lock+0x99/0x190
[ T2010]  ecdh_generic ecc snd_hda_intel snd_intel_dspcfg uvcvideo
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T2010]  snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T2010]  uvc
[ T2010]  snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2010]  videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T2010]  snd_acp_config msi_wmi snd_pcm
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  mc sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T2010]  snd k10temp snd_pci_acp3x soundcore ccp
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T2010]  battery ac button joydev hid_sensor_magn_3d
[ T1155]  do_syscall_64+0x395/0xfa0
[ T2010]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer k=
fifo_buf
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2010]  industrialio
[ T2010]  evdev hid_sensor_iio_common
[ T1155] RIP: 0033:0x7fc77ec79bdb
[ T2010]  amd_pmc sch_fq_codel mt7921e
[ T1155] Code: 37 75 f3 83 e1 03 83 f9 02 0f 84 10 01 00 00 41 80 f1 81 49 =
8d 7c 10 20 45 31 d2 ba 01 00 00 00 44 89 ce b8 ca 00 00 00 0f 05 <48> 3d 0=
0 f0 ff ff 0f 87 19 01 00 00 48 83 c4 08 31 c0 5b 5d c3 41
[ T2010]  mt7921_common mt792x_lib
[ T1155] RSP: 002b:00007fc77e6b01f0 EFLAGS: 00000246
[ T2010]  mt76_connac_lib
[ T1155]  ORIG_RAX: 00000000000000ca
[ T1155] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc77ec79bdb
[ T1155] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 000055f047b83d68
[ T1155] RBP: 0000000000000001 R08: 000055f047b83d48 R09: 0000000000000081
[ T1155] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[ T1155] R13: 0000000000000004 R14: 000055f047b7c808 R15: 000055f047b7c7f0
[ T2010]  mt76 mac80211
[ T1155]  </TASK>
[ T2010]  libarc4
[ T2010]  cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs nfnetli=
nk efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bit drm=
_client_lib drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_p=
anel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_display_helper us=
bcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_core hid_multitouch hi=
d_generic serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i=
2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform i2c_designware_core =
[last unloaded: bpf_testmod(O)]
[ T2010] Preemption disabled at:
[ T2010] [<0000000000000000>] 0x0
[ T2010] CPU: 9 UID: 1000 PID: 2010 Comm: xfce4-terminal Tainted: G        =
W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2010] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2010] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2010] Call Trace:
[ T2010]  <TASK>
[ T2010]  dump_stack_lvl+0x6d/0xb0
[ T2010]  __schedule_bug.cold+0x8c/0x9a
[ T2010]  __schedule+0x167e/0x1ca0
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T1155] INFO: lockdep is turned off.
[ T1155] Modules linked in: bpf_testmod(O)
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ccm snd_seq_dummy snd_hrtimer
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_seq_midi snd_seq_midi_event snd_rawmidi
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_seq snd_seq_device rfcomm
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  bnep snd_ctl_led snd_hda_codec_realtek
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  nls_ascii nls_cp437 vfat
[ T2010]  ? lock_release+0x21b/0x2e0
[ T1155]  fat snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb btrtl
[ T2010]  schedule_rtlock+0x21/0x40
[ T1155]  snd_soc_core btintel btbcm
[ T2010]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  btmtk bluetooth ecdh_generic ecc
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_hda_intel snd_intel_dspcfg uvcvideo
[ T2010]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_a=
cp3x snd_mixer_oss videobuf2_common snd_acp_config msi_wmi
[ T2010]  rt_spin_lock+0x99/0x190
[ T1155]  snd_pcm mc sparse_keymap snd_soc_acpi snd_timer
[ T2010]  task_get_cgroup1+0xe8/0x340
[ T1155]  wmi_bmof edac_mce_amd snd k10temp snd_pci_acp3x
[ T2010]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  soundcore ccp battery
[ T2010]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  ac button joydev
[ T2010]  bpf_trace_run2+0xd3/0x260
[ T1155]  hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industrialio=
_triggered_buffer kfifo_buf industrialio
[ T2010]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  evdev hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e
[ T2010]  syscall_trace_enter+0x1c7/0x260
[ T1155]  mt7921_common mt792x_lib mt76_connac_lib mt76
[ T2010]  do_syscall_64+0x395/0xfa0
[ T1155]  mac80211 libarc4 cfg80211
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rfkill msr nvme_fabrics fuse efi_pstore
[ T2010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  configfs nfnetlink efivarfs
[ T2010] RIP: 0033:0x7f0e4bf16a0e
[ T1155]  autofs4 ext4
[ T2010] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T1155]  mbcache jbd2
[ T2010] RSP: 002b:00007ffc276f5140 EFLAGS: 00000297
[ T1155]  usbhid amdgpu
[ T2010]  ORIG_RAX: 00000000000000e4
[ T1155]  amdxcp
[ T2010] RAX: ffffffffffffffda RBX: 000055766d32b5c0 RCX: 00007f0e4bf16a0e
[ T1155]  i2c_algo_bit
[ T2010] RDX: 0000000000000002 RSI: 00007ffc276f51b0 RDI: 0000000000000001
[ T1155]  drm_client_lib drm_ttm_helper
[ T2010] RBP: 00007ffc276f5140 R08: 0000000000000000 R09: 00007f0e4bf10000
[ T1155]  ttm
[ T2010] R10: 0000000000000001 R11: 0000000000000297 R12: 000000007fffffff
[ T1155]  drm_exec
[ T2010] R13: 000055766d04b0b0 R14: 000055766d32b5c0 R15: 000055766d04b0b0
[ T1155]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks cec xhci=
_pci drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_kms_h=
elper
[ T2010]  </TASK>
[ T1155]  psmouse nvme mfd_core hid_multitouch hid_generic serio_raw nvme_c=
ore r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid hid i2c_piix4 i2c_s=
mbus i2c_designware_platform i2c_designware_core [last unloaded: bpf_testmo=
d(O)]
[ T1155] Preemption disabled at:
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  hid_multitouch
[ T2233]  ext4
[ T2010]  kfifo_buf
[ T1155]  hid_generic
[ T1155]  serio_raw
[ T2010]  industrialio evdev
[ T1155]  nvme_core
[ T2233]  jbd2
[ T1155]  r8169
[ T2233]  usbhid
[ T2010]  amd_pmc
[ T2233]  amdgpu
[ T2010]  sch_fq_codel
[ T1155]  amd_sfh
[ T2233]  amdxcp
[ T1155]  crc16
[ T2233]  i2c_algo_bit
[ T2010]  mt7921_common
[ T1155]  i2c_hid_acpi
[ T2233]  drm_client_lib
[ T2010]  mt792x_lib
[ T1155]  i2c_hid
[ T2233]  drm_ttm_helper
[ T2010]  mt76_connac_lib
[ T2233]  ttm
[ T1155]  i2c_piix4
[ T2010]  mt76
[ T1155]  i2c_smbus
[ T2010]  mac80211
[ T2233]  drm_exec
[ T1155]  i2c_designware_platform
[ T2010]  libarc4
[ T2010]  cfg80211
[ T2233]  gpu_sched
[ T1155]  i2c_designware_core
[ T2010]  rfkill
[ T1155]  [last unloaded: bpf_testmod(O)]
[ T2233]  drm_suballoc_helper
[ T2010]  msr
[ T1155]=20
[ T2233]  drm_panel_backlight_quirks
[ T1155] Preemption disabled at:
[ T2010]  nvme_fabrics
[ T2233]  cec
[ T2233]  xhci_pci
[ T2010]  fuse efi_pstore
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2233]  drm_buddy
[ T2010]  autofs4
[ T2233]  usbcore
[ T2010]  ext4 mbcache
[ T2010]  usbhid
[ T2233]  drm_kms_helper
[ T1155] Call Trace:
[ T2010]  amdgpu
[ T2233]  psmouse
[ T2010]  amdxcp
[ T1155]  <TASK>
[ T2233]  nvme
[ T2010]  i2c_algo_bit drm_client_lib
[ T2233]  mfd_core
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T2010]  drm_ttm_helper
[ T2233]  hid_multitouch
[ T2010]  ttm drm_exec
[ T2233]  hid_generic
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T2010]  gpu_sched drm_suballoc_helper
[ T2233]  serio_raw
[ T2010]  drm_panel_backlight_quirks
[ T2233]  nvme_core
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T2010]  cec
[ T2233]  r8169
[ T2010]  xhci_pci
[ T2233]  usb_common
[ T2010]  drm_buddy
[ T1155]  __schedule+0x167e/0x1ca0
[ T2010]  xhci_hcd
[ T2233]  amd_sfh
[ T2010]  drm_display_helper
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2010]  usbcore
[ T2233]  crc16
[ T2010]  hid_sensor_hub
[ T2233]  i2c_hid_acpi
[ T2010]  drm_kms_helper
[ T2233]  i2c_hid
[ T2010]  psmouse
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2233]  hid
[ T2010]  nvme
[ T2233]  i2c_piix4
[ T2010]  mfd_core
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2010]  hid_multitouch
[ T2233]  i2c_smbus
[ T2010]  hid_generic
[ T2233]  i2c_designware_platform
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  serio_raw
[ T2233]  i2c_designware_core
[ T2010]  nvme_core
[ T2233]  [last unloaded: bpf_testmod(O)]
[ T2010]  r8169
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  usb_common
[ T2233]=20
[ T2010]  amd_sfh
[ T2233] Preemption disabled at:
[ T2010]  crc16
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2010]  i2c_hid_acpi i2c_hid hid
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2233] [<0000000000000000>] 0x0
[ T2010]  i2c_piix4
[ T2010]  i2c_smbus i2c_designware_platform
[ T1155]  ? lock_release+0x21b/0x2e0
[ T2010]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2010] Preemption disabled at:
[ T2010] [<ffffffffa215f33f>] fput+0x1f/0x90
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700b14b8 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 0000000000042416
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 000000000007f8e6 R15: 000055f047b7b880
[ T1155]  </TASK>
[ T2010] CPU: 9 UID: 1000 PID: 2010 Comm: xfce4-terminal Tainted: G        =
W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2010] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2010] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2010] Call Trace:
[ T2010]  <TASK>
[ T2010]  dump_stack_lvl+0x6d/0xb0
[ T2010]  ? fput+0x1f/0x90
[ T2010]  __schedule_bug.cold+0x8c/0x9a
[ T2010]  __schedule+0x167e/0x1ca0
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? lock_release+0x21b/0x2e0
[ T2010]  schedule_rtlock+0x21/0x40
[ T1155]  mbcache
[ T1155]  jbd2
[ T2010]  ccp
[ T2010]  battery ac
[ T2010]  button joydev
[ T1155]  drm_client_lib drm_ttm_helper
[ T2010]  hid_sensor_magn_3d hid_sensor_prox
[ T1155]  ttm drm_exec
[ T2010]  hid_sensor_accel_3d
[ T1155]  gpu_sched
[ T2010]  hid_sensor_gyro_3d hid_sensor_als
[ T1155]  drm_suballoc_helper drm_panel_backlight_quirks
[ T2010]  hid_sensor_trigger
[ T1155]  cec
[ T2010]  industrialio_triggered_buffer
[ T2010]  kfifo_buf
[ T1155]  xhci_pci
[ T1155]  drm_buddy
[ T2010]  industrialio evdev
[ T1155]  xhci_hcd drm_display_helper
[ T2010]  hid_sensor_iio_common
[ T1155]  usbcore
[ T2010]  amd_pmc sch_fq_codel
[ T1155]  hid_sensor_hub
[ T2010]  mt7921e
[ T1155]  drm_kms_helper psmouse
[ T2010]  mt7921_common mt792x_lib
[ T1155]  nvme mfd_core
[ T2010]  mt76_connac_lib mt76
[ T1155]  hid_multitouch
[ T2010]  mac80211
[ T1155]  hid_generic serio_raw
[ T2010]  libarc4 cfg80211
[ T1155]  nvme_core r8169
[ T2010]  rfkill
[ T1155]  usb_common
[ T2010]  msr nvme_fabrics
[ T1155]  amd_sfh
[ T2010]  fuse
[ T1155]  crc16 i2c_hid_acpi
[ T2010]  efi_pstore configfs
[ T1155]  i2c_hid hid
[ T2010]  nfnetlink
[ T1155]  i2c_piix4
[ T2010]  efivarfs
[ T1155]  i2c_smbus
[ T2010]  jbd2 usbhid
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2010]  drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2010]  drm_panel_backlight_quirks cec
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2010]  xhci_pci drm_buddy
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2010]  xhci_hcd
[ T1155] Call Trace:
[ T2010]  drm_display_helper usbcore
[ T1155]  <TASK>
[ T2010]  hid_sensor_hub drm_kms_helper psmouse
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T2010]  nvme
[ T2010]  mfd_core hid_multitouch hid_generic
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T2010]  serio_raw nvme_core r8169 usb_common
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T2010]  amd_sfh crc16 i2c_hid_acpi i2c_hid
[ T1155]  __schedule+0x167e/0x1ca0
[ T2010]  hid i2c_piix4 i2c_smbus
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  i2c_designware_platform i2c_designware_core [last unloaded: bpf_t=
estmod(O)]
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2010]=20
[ T2010] Preemption disabled at:
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010] [<ffffffffa215f33f>] fput+0x1f/0x90
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? rt_mutex_slowunlock+0x3ee/0x490
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc770005978 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004241a
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 00000000000800fa R15: 000055f047b7b880
[ T1155]  </TASK>
[ T2010] CPU: 9 UID: 1000 PID: 2010 Comm: xfce4-terminal Tainted: G        =
W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2010] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2010] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2010] Call Trace:
[ T2010]  <TASK>
[ T2010]  dump_stack_lvl+0x6d/0xb0
[ T2010]  ? fput+0x1f/0x90
[ T2010]  __schedule_bug.cold+0x8c/0x9a
[ T2010]  __schedule+0x167e/0x1ca0
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? rcu_is_watching+0x12/0x60
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? lock_release+0x21b/0x2e0
[ T2010]  schedule_rtlock+0x21/0x40
[ T2010]  rtlock_slowlock_locked+0x635/0x1d00
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  rt_spin_lock+0x99/0x190
[ T2010]  task_get_cgroup1+0xe8/0x340
[ T2010]  bpf_task_get_cgroup1+0xe/0x20
[ T2010]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2010]  bpf_trace_run2+0xd3/0x260
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  __bpf_trace_sys_enter+0x37/0x60
[ T2010]  syscall_trace_enter+0x1c7/0x260
[ T2010]  do_syscall_64+0x395/0xfa0
[ T2010]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2010] RIP: 0033:0x7f0e4ab709ee
[ T1155]  snd_hda_codec videobuf2_vmalloc videobuf2_memops
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155]  snd_hwdep
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  uvc
[  T555] Call Trace:
[ T1155]  snd_hda_core
[  T555]  <TASK>
[ T1155]  videobuf2_v4l2 snd_pcm_oss videodev
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T1155]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_config ms=
i_wmi
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  snd_pcm mc sparse_keymap
[  T555]  __schedule+0x167e/0x1ca0
[ T1155]  snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd k10temp snd_pci_acp3x soundcore
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ccp battery ac
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1155]  button joydev hid_sensor_magn_3d hid_sensor_prox
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1155]  industrialio evdev hid_sensor_iio_common
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  amd_pmc
[ T1155]  sch_fq_codel mt7921e
[  T555]  ? lock_release+0x21b/0x2e0
[ T1155]  mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4
[  T555]  schedule_rtlock+0x21/0x40
[ T1155]  cfg80211 rfkill msr
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  nvme_fabrics fuse efi_pstore configfs
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  nfnetlink efivarfs autofs4
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ext4 mbcache jbd2
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper t=
tm drm_exec gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[  T555]  rt_spin_lock+0x99/0x190
[ T1155]  cec xhci_pci drm_buddy xhci_hcd drm_display_helper usbcore
[  T555]  task_get_cgroup1+0xe8/0x340
[ T1155]  hid_sensor_hub drm_kms_helper psmouse nvme
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  mfd_core hid_multitouch hid_generic serio_raw nvme_core r8169
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  usb_common amd_sfh crc16 i2c_hid_acpi
[  T555]  bpf_trace_run2+0xd3/0x260
[ T1155]  i2c_hid
[ T1155]  hid i2c_piix4 i2c_smbus
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  i2c_designware_platform i2c_designware_core [last unloaded: bpf_t=
estmod(O)]
[ T1155] Preemption disabled at:
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T1155] [<0000000000000000>] 0x0
[  T555]  syscall_trace_enter+0x1c7/0x260
[  T555]  do_syscall_64+0x395/0xfa0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555] RIP: 0033:0x7fd472a989ee
[  T555] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c =
89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2=
e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  T555] RSP: 002b:00007fff31d516d8 EFLAGS: 00000246 ORIG_RAX: 000000000000=
00e8
[  T555] RAX: ffffffffffffffda RBX: 00007fd471f87980 RCX: 00007fd472a989ee
[  T555] RDX: 000000000000008e RSI: 000055b3d56da960 RDI: 0000000000000007
[  T555] RBP: 000000000000008e R08: 0000000000000000 R09: 0000000000000000
[  T555] R10: ffffffffffffffff R11: 0000000000000246 R12: 000055b3d56da960
[  T555] R13: ffffffffffffffff R14: 0000000000000050 R15: 0000000000000007
[  T555]  </TASK>
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977] INFO: lockdep is turned off.
[ T2977] Modules linked in:
[ T1155] Call Trace:
[ T2977]  bpf_testmod(O)
[ T1155]  <TASK>
[ T2977]  ccm snd_seq_dummy snd_hrtimer
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T2977]  snd_seq_midi snd_seq_midi_event snd_rawmidi
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  snd_seq snd_seq_device rfcomm bnep
[ T1155]  __schedule+0x167e/0x1ca0
[ T2977]  snd_ctl_led snd_hda_codec_realtek
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_hda_codec_generic snd_hda_scodec_component
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_hda_codec_hdmi nls_ascii nls_cp437
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  vfat fat snd_acp3x_pdm_dma
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_soc_dmic snd_acp3x_rn
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  btusb btrtl snd_soc_core
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  btintel btbcm
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  btmtk bluetooth
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ecdh_generic ecc
[ T1155]  ? lock_release+0x21b/0x2e0
[ T2977]  snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec
[ T1155]  schedule_rtlock+0x21/0x40
[ T2977]  videobuf2_vmalloc videobuf2_memops snd_hwdep
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  uvc snd_hda_core videobuf2_v4l2
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_pcm_oss videodev
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_acp_config msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi snd_=
timer wmi_bmof
[ T1155]  rt_spin_lock+0x99/0x190
[ T2977]  edac_mce_amd snd k10temp snd_pci_acp3x
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T2977]  soundcore ccp battery ac button
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
[ T2977]  drm_buddy xhci_hcd
[ T2977]  drm_display_helper
[ T1155] R13: 0000000000000004 R14: 000055f047b7c808 R15: 000055f047b7c7f0
[ T2977]  usbcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_core hid_m=
ultitouch hid_generic serio_raw nvme_core r8169
[ T1155]  </TASK>
[ T2977]  usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T2977]  hid
[ T2977]  i2c_piix4
[  T555] INFO: lockdep is turned off.
[ T2977]  i2c_smbus
[  T555] Modules linked in:
[  T555]  ccm
[  T555]  snd_seq_dummy
[ T2977]=20
[  T555]  snd_hrtimer
[ T2977] Preemption disabled at:
[  T555]  snd_seq_midi snd_seq_midi_event snd_rawmidi
[ T2977] [<0000000000000000>] 0x0
[  T555]  snd_seq snd_seq_device rfcomm bnep
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  snd_hda_scodec_component
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555]  snd_hda_codec_hdmi
[ T2977] Call Trace:
[  T555]  nls_ascii
[ T2977]  <TASK>
[  T555]  nls_cp437 vfat fat
[ T2977]  dump_stack_lvl+0x6d/0xb0
[  T555]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb btrtl
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[  T555]  snd_soc_core btintel btbcm
[ T2977]  __schedule+0x167e/0x1ca0
[  T555]  btmtk bluetooth ecdh_generic ecc
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_intel snd_intel_dspcfg
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  uvcvideo snd_hda_codec
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  videobuf2_vmalloc videobuf2_memops snd_hwdep
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  uvc snd_hda_core videobuf2_v4l2
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_pcm_oss videodev
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_acp_config
[ T2977]  ? lock_release+0x21b/0x2e0
[  T555]  msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi
[ T2977]  schedule_rtlock+0x21/0x40
[  T555]  snd_timer wmi_bmof edac_mce_amd
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  snd k10temp snd_pci_acp3x
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  soundcore ccp
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  battery ac button
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d hid=
_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industrialio_triggered_bu=
ffer
[ T2977]  rt_spin_lock+0x99/0x190
[  T555]  kfifo_buf
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  bpf_trace_run2+0xd3/0x260
[  T555]  industrialio evdev
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt7921_common
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  mt792x_lib mt76_connac_lib mt76
[ T2977]  syscall_trace_enter+0x1c7/0x260
[  T555]  mac80211 libarc4 cfg80211
[ T2977]  do_syscall_64+0x395/0xfa0
[  T555]  rfkill msr
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  nvme_fabrics fuse efi_pstore configfs
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  nfnetlink efivarfs
[ T2977] RIP: 0033:0x7fdfbd29a687
[  T555]  autofs4 ext4
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  T555]  mbcache jbd2
[ T2977] RSP: 002b:00007ffc24356240 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0001
[  T555]  usbhid
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[  T555]  amdgpu
[ T2977] RDX: 0000000000000036 RSI: 000055e375e787e0 RDI: 0000000000000001
[  T555]  amdxcp
[ T2977] RBP: 000055e375e787e0 R08: 0000000000000000 R09: 0000000000000000
[  T555]  i2c_algo_bit drm_client_lib
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000036
[ T2977] R13: 00007fdfbd3f35c0 R14: 00007fdfbd3f0e80 R15: 00007ffc24356740
[  T555]  drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_pan=
el_backlight_quirks cec xhci_pci
[ T2977]  </TASK>
[  T555]  drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_=
kms_helper psmouse nvme mfd_core hid_multitouch hid_generic serio_raw nvme_=
core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid hid i2c_piix4 i2c_=
smbus i2c_designware_platform i2c_designware_core [last unloaded: bpf_testm=
od(O)]
[  T555] Preemption disabled at:
[  T555] [<0000000000000000>] 0x0
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] INFO: lockdep is turned off.
[ T1155] Modules linked in: bpf_testmod(O)
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155]  ccm
[ T1155]  snd_seq_dummy
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  snd_hrtimer
[  T555] Call Trace:
[ T1155]  snd_seq_midi snd_seq_midi_event snd_rawmidi
[  T555]  <TASK>
[ T1155]  snd_seq snd_seq_device rfcomm
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T1155]  bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_=
hda_scodec_component
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  snd_hda_codec_hdmi nls_ascii nls_cp437 vfat fat snd_acp3x_pdm_dma
[  T555]  __schedule+0x167e/0x1ca0
[ T1155]  snd_soc_dmic snd_acp3x_rn btusb btrtl
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_soc_core btintel btbcm btmtk bluetooth ecdh_generic
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo
[  T555]  amd_sfh
[ T2977]  snd_pcm_oss
[ T2977]  videodev snd_rn_pci_acp3x
[  T555]  i2c_hid hid
[ T2977]  snd_mixer_oss
[  T555]  i2c_piix4
[ T2977]  videobuf2_common
[  T555]  i2c_smbus
[ T2977]  snd_acp_config
[  T555]  i2c_designware_platform
[ T2977]  msi_wmi snd_pcm
[  T555]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2977]  mc sparse_keymap
[  T555]=20
[ T2977]  snd_soc_acpi
[  T555] Preemption disabled at:
[ T2977]  snd_timer wmi_bmof edac_mce_amd
[  T555] [<0000000000000000>] 0x0
[ T2977]  snd k10temp snd_pci_acp3x soundcore
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977]  ccp battery ac
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977]  button
[ T2977]  joydev
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[ T2977]  hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[  T555]  <TASK>
[ T2977]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T2977]  industrialio_triggered_buffer kfifo_buf industrialio evdev
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt7921_common
[  T555]  __schedule+0x167e/0x1ca0
[ T2977]  mt792x_lib
[ T2977]  mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  msr nvme_fabrics fuse efi_pstore
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  configfs
[ T2977]  nfnetlink efivarfs autofs4 ext4
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  mbcache jbd2 usbhid amdgpu amdxcp
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  i2c_algo_bit
[ T2977]  drm_client_lib drm_ttm_helper ttm
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  drm_exec
[ T2977]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  cec xhci_pci drm_buddy
[  T555]  ? lock_release+0x21b/0x2e0
[ T2977]  xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_kms_helper=
 psmouse nvme
[  T555]  schedule_rtlock+0x21/0x40
[ T2977]  mfd_core
[ T2977]  hid_multitouch hid_generic serio_raw nvme_core
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  r8169
[ T2977]  usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  hid i2c_piix4 i2c_smbus i2c_designware_platform
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2977] Preemption disabled at:
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977] [<0000000000000000>] 0x0
[  T555]  rt_spin_lock+0x99/0x190
[  T555]  task_get_cgroup1+0xe8/0x340
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  bpf_trace_run2+0xd3/0x260
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  syscall_trace_enter+0x1c7/0x260
[  T555]  do_syscall_64+0x395/0xfa0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555] RIP: 0033:0x7fd47309ea0e
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[  T555] RSP: 002b:00007fff31d516e0 EFLAGS: 00000297 ORIG_RAX: 000000000000=
00e4
[  T555] RAX: ffffffffffffffda RBX: 000055b3d56687b0 RCX: 00007fd47309ea0e
[  T555] RDX: 0000000000000001 RSI: 00007fff31d51700 RDI: 0000000000000000
[  T555] RBP: 00007fff31d516e0 R08: 0000000000000000 R09: 00007fd473098000
[  T555] R10: ffffffffffffffff R11: 0000000000000297 R12: 0000000000000001
[  T555] R13: ffffffffffffffff R14: 0000000000000050 R15: 0000000000000007
[  T555]  </TASK>
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977] Call Trace:
[ T2977]  <TASK>
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  __schedule+0x167e/0x1ca0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? lock_release+0x21b/0x2e0
[ T2977]  schedule_rtlock+0x21/0x40
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  rt_spin_lock+0x99/0x190
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0000
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  uvc snd_hda_core videobuf2_v4l2
[  T555]  ? lock_release+0x21b/0x2e0
[ T2977]  snd_pcm_oss videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_com=
mon snd_acp_config msi_wmi
[  T555]  schedule_rtlock+0x21/0x40
[ T2977]  snd_pcm mc sparse_keymap snd_soc_acpi snd_timer
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  wmi_bmof edac_mce_amd snd k10temp
[  T555]  ? fput+0x3f/0x90
[ T2977]  snd_pci_acp3x soundcore ccp battery
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ac button joydev hid_sensor_magn_3d
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industriali=
o evdev hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt7921_common
[  T555]  rt_spin_lock+0x99/0x190
[ T2977]  mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill
[  T555]  task_get_cgroup1+0xe8/0x340
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  nfnetlink efivarfs autofs4 ext4 mbcache
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  jbd2 usbhid amdgpu amdxcp i2c_algo_bit
[  T555]  bpf_trace_run2+0xd3/0x260
[ T2977]  drm_client_lib drm_ttm_helper ttm drm_exec
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks cec xhci=
_pci drm_buddy xhci_hcd drm_display_helper
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  usbcore hid_sensor_hub drm_kms_helper psmouse nvme
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T2977]  mfd_core hid_multitouch hid_generic serio_raw nvme_core
[  T555]  do_syscall_64+0x395/0xfa0
[ T2977]  r8169 usb_common amd_sfh
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  crc16 i2c_hid_acpi i2c_hid hid i2c_piix4
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  i2c_smbus i2c_designware_platform i2c_designware_core [last unloa=
ded: bpf_testmod(O)]
[  T555] RIP: 0033:0x7fd47309ea0e
[ T2977] Preemption disabled at:
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T2977] [<0000000000000000>] 0x0
[  T555] RSP: 002b:00007fff31d4e980 EFLAGS: 00000297 ORIG_RAX: 000000000000=
00e4
[  T555] RAX: ffffffffffffffda RBX: 0000000000000063 RCX: 00007fd47309ea0e
[  T555] RDX: 0000000000000002 RSI: 00007fff31d4e9a0 RDI: 0000000000000001
[  T555] RBP: 00007fff31d4e980 R08: 0000000000000000 R09: 00007fd473098000
[  T555] R10: dad5e00e056e111e R11: 0000000000000297 R12: 0000000000000000
[  T555] R13: 000055b3d567d3b0 R14: 00007fff31d4eaf0 R15: 000000000962acd9
[  T555]  </TASK>
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] INFO: lockdep is turned off.
[ T2977] Call Trace:
[ T1155] Modules linked in: bpf_testmod(O)
[ T2977]  <TASK>
[ T1155]  ccm snd_seq_dummy
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T1155]  snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  snd_seq snd_seq_device rfcomm bnep
[ T2977]  __schedule+0x167e/0x1ca0
[ T1155]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii nls_cp437
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  vfat fat snd_acp3x_pdm_dma
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_soc_dmic snd_acp3x_rn btusb
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  btrtl snd_soc_core btintel
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  btbcm btmtk bluetooth
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  ecdh_generic ecc snd_hda_intel snd_intel_dspcfg
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  uvcvideo snd_hda_codec
[ T2977]  ? lock_release+0x21b/0x2e0
[ T1155]  videobuf2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core vid=
eobuf2_v4l2
[ T2977]  schedule_rtlock+0x21/0x40
[ T1155]  snd_pcm_oss videodev snd_rn_pci_acp3x snd_mixer_oss
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  videobuf2_common snd_acp_config msi_wmi
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_pcm mc sparse_keymap
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  snd_soc_acpi snd_timer wmi_bmof
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  edac_mce_amd
[ T1155]  snd k10temp snd_pci_acp3x soundcore ccp battery ac button joydev =
hid_sensor_magn_3d
[ T2977]  rt_spin_lock+0x99/0x190
[ T1155]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als hid_sensor_trigger
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T1155]  industrialio_triggered_buffer kfifo_buf industrialio evdev
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  hid_sensor_iio_common amd_pmc sch_fq_codel
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  mt7921e mt7921_common mt792x_lib mt76_connac_lib
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T1155]  mt76 mac80211 libarc4 cfg80211
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rfkill msr nvme_fabrics fuse efi_pstore configfs
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  nfnetlink efivarfs autofs4 ext4 mbcache
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T1155]  jbd2 usbhid amdgpu amdxcp i2c_algo_bit
[ T2977]  do_syscall_64+0x395/0xfa0
[ T1155]  drm_client_lib drm_ttm_helper
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ttm drm_exec gpu_sched drm_suballoc_helper
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  drm_panel_backlight_quirks cec xhci_pci
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T1155]  drm_buddy
[ T1155]  xhci_hcd drm_display_helper
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T1155]  usbcore
[ T2977] RSP: 002b:00007ffc24356240 EFLAGS: 00000202
[ T1155]  hid_sensor_hub drm_kms_helper
[ T2977]  ORIG_RAX: 0000000000000001
[ T1155]  psmouse
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T1155]  nvme
[ T2977] RDX: 0000000000000036 RSI: 000055e375e787e0 RDI: 0000000000000001
[ T1155]  mfd_core hid_multitouch
[ T2977] RBP: 000055e375e787e0 R08: 0000000000000000 R09: 0000000000000000
[ T1155]  hid_generic
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000036
[ T1155]  serio_raw
[ T2977] R13: 00007fdfbd3f35c0 R14: 00007fdfbd3f0e80 R15: 00007ffc24356740
[ T1155]  nvme_core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid hid=
 i2c_piix4 i2c_smbus i2c_designware_platform
[ T2977]  </TASK>
[ T1155]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T1155] Preemption disabled at:
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T2977] INFO: lockdep is turned off.
[ T2977] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T2977]  snd_seq_device rfcomm bnep snd_ctl_led snd_hda_codec_realtek snd_=
hda_codec_generic
[ T1155]  do_syscall_64+0x395/0xfa0
[ T2977]  snd_hda_scodec_component snd_hda_codec_hdmi
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  nls_ascii nls_cp437 vfat fat snd_acp3x_pdm_dma
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  snd_soc_dmic snd_acp3x_rn btusb btrtl
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T2977]  snd_soc_core btintel btbcm
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T2977]  btmtk bluetooth
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[ T2977]  ecdh_generic ecc
[ T1155]  ORIG_RAX: 0000000000000060
[ T2977]  snd_hda_intel
[ T1155] RAX: ffffffffffffffda RBX: 00007fc770005978 RCX: 00007fc77f05c7f9
[ T2977]  snd_intel_dspcfg uvcvideo
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T2977]  snd_hda_codec
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 0000000000042426
[ T2977]  videobuf2_vmalloc videobuf2_memops
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T2977]  snd_hwdep
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000081456 R15: 000055f047b7b880
[ T2977]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_a=
cp3x snd_mixer_oss videobuf2_common snd_acp_config msi_wmi snd_pcm
[ T1155]  </TASK>
[ T2977]  mc sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd snd=
 k10temp snd_pci_acp3x soundcore ccp battery ac button joydev hid_sensor_ma=
gn_3d hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als=
 hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio ev=
dev hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt7921_common mt792x=
_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics=
 fuse efi_pstore configfs nfnetlink efivarfs autofs4 ext4 mbcache jbd2 usbh=
id amdgpu amdxcp
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T2977]  i2c_algo_bit
[ T1155] INFO: lockdep is turned off.
[ T2977]  drm_client_lib
[ T1155] Modules linked in:
[ T2977]  drm_ttm_helper
[ T1155]  bpf_testmod(O)
[ T2977]  ttm drm_exec
[ T1155]  ccm
[ T2977]  gpu_sched
[ T1155]  snd_seq_dummy
[ T2977]  drm_suballoc_helper
[ T1155]  snd_hrtimer
[ T1155]  snd_seq_midi
[ T2977]  drm_panel_backlight_quirks cec
[ T1155]  snd_seq_midi_event
[ T2977]  xhci_pci
[ T1155]  snd_rawmidi snd_seq
[ T2977]  drm_buddy xhci_hcd
[ T1155]  snd_seq_device rfcomm
[ T2977]  drm_display_helper usbcore
[ T1155]  bnep snd_ctl_led
[ T2977]  hid_sensor_hub
[ T1155]  snd_hda_codec_realtek
[ T2977]  drm_kms_helper psmouse
[ T1155]  snd_hda_codec_generic
[ T2977]  nvme
[ T1155]  snd_hda_scodec_component
[ T2977]  mfd_core
[ T1155]  snd_hda_codec_hdmi
[ T2977]  hid_multitouch
[ T1155]  nls_ascii nls_cp437
[ T2977]  hid_generic serio_raw
[ T1155]  vfat fat
[ T2977]  nvme_core r8169
[ T1155]  snd_acp3x_pdm_dma
[ T2977]  usb_common
[ T1155]  snd_soc_dmic
[ T2977]  amd_sfh
[ T1155]  snd_acp3x_rn
[ T2977]  crc16
[ T1155]  btusb
[ T2977]  i2c_hid_acpi i2c_hid
[ T1155]  btrtl snd_soc_core
[ T2977]  hid i2c_piix4
[ T1155]  btintel btbcm
[ T2977]  i2c_smbus i2c_designware_platform
[ T1155]  btmtk bluetooth
[ T2977]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T1155]  ecdh_generic ecc
[ T2977]=20
[ T1155]  snd_hda_intel
[ T2977] Preemption disabled at:
[ T1155]  snd_intel_dspcfg uvcvideo
[ T2977] [<0000000000000000>] 0x0
[ T1155]  snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155]  uvc snd_hda_core videobuf2_v4l2
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155]  snd_pcm_oss
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  videodev
[ T2977] Call Trace:
[ T1155]  snd_rn_pci_acp3x
[ T2977]  <TASK>
[ T1155]  snd_mixer_oss videobuf2_common snd_acp_config
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T1155]  msi_wmi snd_pcm mc sparse_keymap
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T2977]  __schedule+0x167e/0x1ca0
[ T1155]  snd k10temp snd_pci_acp3x
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  soundcore ccp
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  battery
[ T1155]  ac button joydev
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industrialio=
_triggered_buffer
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  kfifo_buf industrialio evdev
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_sensor_iio_common amd_pmc
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  sch_fq_codel
[ T1155]  mt7921e mt7921_common
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  mt792x_lib
[ T1155]  mt76_connac_lib mt76
[ T2977]  ? lock_release+0x21b/0x2e0
[ T1155]  mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics
[ T2977]  schedule_rtlock+0x21/0x40
[ T1155]  fuse efi_pstore configfs
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  nfnetlink efivarfs autofs4 ext4
[ T2977]  ? preempt_count_sub+0x96/0xd0
[ T1155]  mbcache jbd2 usbhid amdgpu
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gp=
u_sched drm_suballoc_helper drm_panel_backlight_quirks cec xhci_pci
[ T2977]  rt_spin_lock+0x99/0x190
[ T1155]  drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor_hub
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T1155]  drm_kms_helper psmouse nvme mfd_core hid_multitouch
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  hid_generic serio_raw nvme_core
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  r8169 usb_common amd_sfh crc16
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T1155]  i2c_hid_acpi i2c_hid hid i2c_piix4
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  i2c_smbus i2c_designware_platform i2c_designware_core [last unloa=
ded: bpf_testmod(O)]
[ T1155] Preemption disabled at:
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0000
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[ T2977]  </TASK>
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in: bpf_testmod(O) ccm
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_raw=
midi
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  snd_seq snd_seq_device rfcomm bnep snd_ctl_led
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compon=
ent
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  snd_hda_codec_hdmi nls_ascii nls_cp437 vfat
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  fat snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_acp3x_rn btusb btrtl snd_soc_core btintel btbcm
[ T2977]  [last unloaded: bpf_testmod(O)]
[ T2977] Preemption disabled at:
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155]  fuse efi_pstore
[ T1155]  configfs
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  nfnetlink
[ T2977] Call Trace:
[ T1155]  efivarfs autofs4
[ T2977]  <TASK>
[ T1155]  ext4 mbcache jbd2
[ T1155]  usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  drm_ttm_helper ttm drm_exec
[ T2977]  __schedule+0x167e/0x1ca0
[ T1155]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  cec xhci_pci drm_buddy
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  xhci_hcd drm_display_helper usbcore hid_sensor_hub
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  drm_kms_helper psmouse nvme
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  mfd_core hid_multitouch hid_generic
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  serio_raw nvme_core r8169
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  usb_common amd_sfh crc16
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  i2c_hid_acpi i2c_hid hid
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  i2c_piix4 i2c_smbus i2c_designware_platform
[ T2977]  ? lock_release+0x21b/0x2e0
[ T1155]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T1155] Preemption disabled at:
[ T2977]  schedule_rtlock+0x21/0x40
[ T1155] [<ffffffffa1d86334>] irq_enter_rcu+0x14/0xb0
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  ? preempt_count_sub+0x96/0xd0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  rt_spin_lock+0x99/0x190
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0000
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[ T2977]  </TASK>
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? irq_enter_rcu+0x14/0xb0
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in:
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  bpf_testmod(O) ccm snd_seq_dummy
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hrtimer snd_seq_midi snd_seq_midi_event
[ T1155]  ? lock_release+0x21b/0x2e0
[  T555]  snd_rawmidi snd_seq snd_seq_device rfcomm bnep snd_ctl_led snd_hd=
a_codec_realtek snd_hda_codec_generic
[ T1155]  schedule_rtlock+0x21/0x40
[  T555]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii nls_cp437 v=
fat
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  fat snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb btrtl
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_soc_core btintel btbcm
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  btmtk bluetooth ecdh_generic
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec videobu=
f2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core videobuf2_v4l2
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  snd_pcm_oss videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_com=
mon snd_acp_config
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  snd_timer wmi_bmof edac_mce_amd snd
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  k10temp
[  T555]  snd_pci_acp3x soundcore ccp battery ac
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  button joydev hid_sensor_magn_3d hid_sensor_prox
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_=
trigger industrialio_triggered_buffer kfifo_buf industrialio evdev
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e mt7921_common
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  mt792x_lib mt76_connac_lib mt76 mac80211
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  libarc4 cfg80211 rfkill
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  msr nvme_fabrics fuse efi_pstore configfs
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  nfnetlink efivarfs autofs4 ext4 mbcache
[ T1155] RIP: 0033:0x7fc77f05c7f9
[  T555]  jbd2 usbhid amdgpu
[ T2977]  rt_spin_lock+0x99/0x190
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T1155]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T1155]  videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_=
config msi_wmi
[ T1155]  snd_pcm mc sparse_keymap snd_soc_acpi snd_timer
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T1155]  kfifo_buf industrialio
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202
[ T1155]  evdev
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T1155]  mt7921e
[ T1155]  mt7921_common mt792x_lib
[ T1155]  mt76_connac_lib mt76
[ T1155]  mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore=
 configfs nfnetlink
[ T2977]  </TASK>
[ T1155]  efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_=
bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helpe=
r drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_display_he=
lper usbcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_core hid_multit=
ouch hid_generic serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hid=
_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform i2c_designwar=
e_core [last unloaded: bpf_testmod(O)]
[ T1155] Preemption disabled at:
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? futex_private_hash_put+0x32/0x100
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in:
[  T555]  bpf_testmod(O) ccm snd_seq_dummy
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_soc_dmic snd_acp3x_rn btusb
[  T555]  btbcm btmtk
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  ccp battery ac button joydev hid_sensor_magn_3d
[  T555]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  industrialio evdev hid_sensor_iio_common amd_pmc
[  T555]  mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  drm_panel_backlight_quirks cec xhci_pci
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[  T555]  drm_buddy
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[  T555]  xhci_hcd drm_display_helper
[ T1155]  ORIG_RAX: 0000000000000060
[  T555]  usbcore
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700b2528 RCX: 00007fc77f05c7f9
[  T555]  hid_sensor_hub drm_kms_helper
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[  T555]  psmouse nvme
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004242e
[  T555]  mfd_core hid_multitouch
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[  T555]  hid_generic serio_raw
[ T1155] R13: 00007fc77e6b02e0 R14: 00000000000824a5 R15: 000055f047b7b880
[  T555]  nvme_core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid hid=
 i2c_piix4 i2c_smbus i2c_designware_platform i2c_designware_core [last unlo=
aded: bpf_testmod(O)]
[ T1155]  </TASK>
[  T555] Preemption disabled at:
[  T555] [<0000000000000000>] 0x0
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T2977] INFO: lockdep is turned off.
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977] Modules linked in: bpf_testmod(O) ccm
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977]  snd_seq_dummy
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977]  snd_hrtimer snd_seq_midi
[  T555] Call Trace:
[ T2977]  snd_seq_midi_event
[  T555]  <TASK>
[ T2977]  snd_rawmidi snd_seq snd_seq_device
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T2977]  rfcomm bnep snd_ctl_led snd_hda_codec_realtek
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi=
 nls_ascii
[  T555]  __schedule+0x167e/0x1ca0
[ T2977]  nls_cp437 vfat fat snd_acp3x_pdm_dma snd_soc_dmic
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_acp3x_rn btusb
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  btrtl snd_soc_core btintel
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  btbcm btmtk bluetooth ecdh_generic
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ecc snd_hda_intel
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_intel_dspcfg uvcvideo snd_hda_codec videobuf2_vmalloc
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  videobuf2_memops snd_hwdep
[  T555]  ? lock_release+0x21b/0x2e0
[ T2977]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_a=
cp3x snd_mixer_oss
[  T555]  schedule_rtlock+0x21/0x40
[  T555] Modules linked in: bpf_testmod(O)
[ T1155]  ? lock_release+0x21b/0x2e0
[  T555]  ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd=
_rawmidi
[ T1155]  schedule_rtlock+0x21/0x40
[  T555]  snd_seq snd_seq_device rfcomm
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  nls_cp437 vfat fat snd_acp3x_pdm_dma
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_core btintel btbcm =
btmtk bluetooth ecdh_generic ecc
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec videobuf2_v=
malloc
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  videobuf2_memops snd_hwdep uvc snd_hda_core
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  videobuf2_v4l2 snd_pcm_oss videodev
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_config
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  msi_wmi snd_pcm mc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd snd k1=
0temp
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  snd_pci_acp3x soundcore ccp
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  battery ac button joydev hid_sensor_magn_3d
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  hid_sensor_prox hid_sensor_accel_3d
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  industrialio_triggered_buffer kfifo_buf
[ T1155] RIP: 0033:0x7fc77ec79bdb
[  T555]  industrialio evdev
[ T1155] Code: 37 75 f3 83 e1 03 83 f9 02 0f 84 10 01 00 00 41 80 f1 81 49 =
8d 7c 10 20 45 31 d2 ba 01 00 00 00 44 89 ce b8 ca 00 00 00 0f 05 <48> 3d 0=
0 f0 ff ff 0f 87 19 01 00 00 48 83 c4 08 31 c0 5b 5d c3 41
[  T555]  hid_sensor_iio_common amd_pmc
[ T1155] RSP: 002b:00007fc77e6b01f0 EFLAGS: 00000246 ORIG_RAX: 000000000000=
00ca
[  T555]  sch_fq_codel
[ T1155] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc77ec79bdb
[  T555]  mt7921e mt7921_common
[ T1155] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 000055f047b83d68
[  T555]  mt792x_lib
[ T1155] RBP: 0000000000000001 R08: 000055f047b83d48 R09: 0000000000000081
[  T555]  mt76_connac_lib
[ T1155] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[ T1155] R13: 0000000000000004 R14: 000055f047b7c808 R15: 000055f047b7c7f0
[  T555]  mt76 mac80211 libarc4 cfg80211 rfkill msr
[ T1155]  </TASK>
[  T555]  nvme_fabrics fuse efi_pstore configfs nfnetlink efivarfs autofs4 =
ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib drm_ttm_=
helper ttm drm_exec gpu_sched drm_suballoc_helper drm_panel_backlight_quirk=
s cec xhci_pci drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor_hub=
 drm_kms_helper psmouse nvme
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[  T555]  mfd_core hid_multitouch
[ T2977] INFO: lockdep is turned off.
[  T555]  hid_generic
[ T2977] Modules linked in:
[  T555]  serio_raw nvme_core
[ T2977]  bpf_testmod(O) ccm
[  T555]  r8169 usb_common
[ T2977]  snd_seq_dummy snd_hrtimer
[  T555]  amd_sfh crc16
[ T2977]  snd_seq_midi snd_seq_midi_event
[  T555]  i2c_hid_acpi i2c_hid
[ T2977]  snd_rawmidi snd_seq
[  T555]  hid i2c_piix4
[ T2977]  bnep snd_ctl_led
[ T2977]  snd_hda_codec_realtek
[ T2977]  snd_hda_codec_generic snd_hda_scodec_component
[  T555] Preemption disabled at:
[  T555] [<0000000000000000>] 0x0
[ T2977]  vfat fat snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977]  btusb btrtl snd_soc_core
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977]  btintel
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977]  btmtk
[  T555] Call Trace:
[ T2977]  ecdh_generic ecc snd_hda_intel
[ T2977]  snd_intel_dspcfg uvcvideo snd_hda_codec videobuf2_vmalloc videobu=
f2_memops
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  snd_hwdep uvc snd_hda_core
[ T2977]  videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_acp3x
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_mixer_oss videobuf2_common snd_acp_config msi_wmi
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  sparse_keymap snd_soc_acpi snd_timer wmi_bmof
[ T2977]  edac_mce_amd snd k10temp
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  battery ac button
[ T2977]  joydev hid_sensor_magn_3d hid_sensor_prox
[  T555]  ? lock_release+0x21b/0x2e0
[  T555]  schedule_rtlock+0x21/0x40
[ T2977]  kfifo_buf industrialio evdev hid_sensor_iio_common
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  amd_pmc sch_fq_codel mt7921e
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  mt76 mac80211 libarc4 cfg80211
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  rt_spin_lock+0x99/0x190
[ T2977]  mbcache jbd2 usbhid amdgpu amdxcp
[ T2977]  i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec
[ T2977]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks cec
[  T555]  bpf_trace_run2+0xd3/0x260
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  drm_kms_helper psmouse nvme mfd_core hid_multitouch hid_generic
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  serio_raw nvme_core r8169 usb_common
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T2977]  amd_sfh crc16 i2c_hid_acpi i2c_hid hid
[ T2977]  i2c_piix4 i2c_smbus i2c_designware_platform
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2977] Preemption disabled at:
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977] [<0000000000000000>] 0x0
[ T3068]  drm_panel_backlight_quirks cec
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T3068]  xhci_pci
[ T2594] [<ffffffffa215f33f>] fput+0x1f/0x90
[ T3068]  drm_buddy
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T3068]  xhci_hcd drm_display_helper usbcore
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T3068]  hid_sensor_hub drm_kms_helper
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3068]  psmouse nvme mfd_core hid_multitouch hid_generic
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T3068]  serio_raw nvme_core r8169 usb_common
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T3068]  amd_sfh crc16 i2c_hid_acpi
[ T1155]  do_syscall_64+0x395/0xfa0
[ T3068]  i2c_hid hid
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3068]  i2c_piix4 i2c_smbus i2c_designware_platform
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T3068]  i2c_designware_core
[ T3068]  [last unloaded: bpf_testmod(O)]
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T3068] Preemption disabled at:
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T3068] [<ffffffffa1dda00d>] migrate_enable+0x8d/0x110
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc770000c98 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004243a
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000083c1b R15: 000055f047b7b880
[ T1155]  </TASK>
[ T3068] CPU: 10 UID: 1000 PID: 3068 Comm: MediaSu~isor #1 Tainted: G      =
  W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T3068] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T3068] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T3068] Call Trace:
[ T3068]  <TASK>
[ T3068]  dump_stack_lvl+0x6d/0xb0
[ T3068]  ? migrate_enable+0x8d/0x110
[ T3068]  __schedule_bug.cold+0x8c/0x9a
[ T3068]  __schedule+0x167e/0x1ca0
[ T3068]  ? rcu_is_watching+0x12/0x60
[ T3068]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3068]  ? rcu_is_watching+0x12/0x60
[ T3068]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3068]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[ T3068]  ? rcu_is_watching+0x12/0x60
[ T1155] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy
[ T3068]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_hrtimer
[ T1155]  snd_seq_midi snd_seq_midi_event snd_rawmidi
[ T3068]  ? lock_release+0x21b/0x2e0
[ T1155]  snd_seq snd_seq_device rfcomm bnep snd_ctl_led
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  snd_hda_codec_realtek snd_hda_codec_generic
[  T555] INFO: lockdep is turned off.
[ T3068]  schedule_rtlock+0x21/0x40
[  T555] Modules linked in:
[ T1155]  snd_hda_scodec_component snd_hda_codec_hdmi
[  T555]  bpf_testmod(O) ccm
[ T1155]  nls_ascii
[  T555]  snd_seq_dummy
[ T1155]  nls_cp437
[ T3068]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  snd_hrtimer
[ T1155]  vfat
[  T555]  snd_seq_midi
[ T1155]  fat
[  T555]  snd_seq_midi_event
[ T1155]  snd_acp3x_pdm_dma
[  T555]  snd_rawmidi
[ T1155]  snd_soc_dmic
[ T3068]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_seq
[ T1155]  snd_acp3x_rn
[  T555]  snd_seq_device
[ T1155]  btusb
[ T1155]  btrtl
[  T555]  rfcomm
[ T3068]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  snd_soc_core
[  T555]  bnep snd_ctl_led
[ T1155]  btintel btbcm
[  T555]  snd_hda_codec_realtek snd_hda_codec_generic
[ T1155]  btmtk
[ T3068]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_scodec_component
[ T1155]  bluetooth ecdh_generic
[  T555]  snd_hda_codec_hdmi
[ T1155]  ecc
[  T555]  nls_ascii
[ T1155]  snd_hda_intel
[  T555]  nls_cp437
[ T1155]  snd_intel_dspcfg
[  T555]  vfat
[ T1155]  uvcvideo
[  T555]  fat snd_acp3x_pdm_dma
[ T1155]  snd_hda_codec videobuf2_vmalloc
[  T555]  snd_soc_dmic snd_acp3x_rn
[ T1155]  videobuf2_memops snd_hwdep
[  T555]  btusb
[ T3068]  rt_spin_lock+0x99/0x190
[  T555]  btrtl
[ T1155]  uvc
[ T1155]  snd_hda_core
[  T555]  snd_soc_core
[  T555]  btintel
[ T1155]  videobuf2_v4l2 snd_pcm_oss
[  T555]  btbcm btmtk
[ T1155]  videodev
[  T555]  bluetooth
[ T3068]  task_get_cgroup1+0xe8/0x340
[ T1155]  snd_rn_pci_acp3x snd_mixer_oss
[  T555]  ecdh_generic ecc
[ T1155]  videobuf2_common snd_acp_config
[  T555]  snd_hda_intel
[ T3068]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  snd_intel_dspcfg
[ T1155]  msi_wmi snd_pcm
[  T555]  uvcvideo snd_hda_codec
[ T1155]  mc
[  T555]  videobuf2_vmalloc
[ T1155]  sparse_keymap
[ T3068]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  videobuf2_memops
[ T1155]  snd_soc_acpi
[  T555]  snd_hwdep
[ T1155]  snd_timer wmi_bmof
[  T555]  uvc snd_hda_core
[ T1155]  edac_mce_amd snd
[  T555]  videobuf2_v4l2
[ T3068]  bpf_trace_run2+0xd3/0x260
[ T1155]  k10temp
[  T555]  snd_pcm_oss
[ T1155]  snd_pci_acp3x
[  T555]  videodev
[ T1155]  soundcore
[  T555]  snd_rn_pci_acp3x
[ T1155]  ccp
[ T3068]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_mixer_oss
[ T1155]  battery
[  T555]  videobuf2_common
[ T1155]  ac
[  T555]  snd_acp_config
[ T1155]  button
[  T555]  msi_wmi
[ T1155]  joydev
[  T555]  snd_pcm
[ T1155]  hid_sensor_magn_3d
[ T2977]  bnep snd_ctl_led
[ T1155]  xhci_pci
[ T1155]  drm_buddy
[ T2977]  snd_hda_codec_realtek
[ T1155]  xhci_hcd
[ T2977]  snd_hda_codec_generic
[ T2977]  snd_hda_scodec_component
[ T1155]  drm_display_helper
[ T2234]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  usbcore
[ T2977]  snd_hda_codec_hdmi
[ T1155]  hid_sensor_hub
[ T2977]  nls_ascii nls_cp437
[ T1155]  drm_kms_helper psmouse
[ T2977]  vfat fat
[ T1155]  nvme mfd_core
[ T2977]  snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  hid_multitouch hid_generic
[ T2977]  snd_acp3x_rn
[ T2234]  rt_spin_lock+0x99/0x190
[ T1155]  serio_raw
[ T2977]  btusb btrtl
[ T1155]  nvme_core r8169
[ T2977]  snd_soc_core
[ T1155]  usb_common
[ T2977]  btintel
[ T2234]  task_get_cgroup1+0xe8/0x340
[ T1155]  amd_sfh
[ T2977]  btbcm
[ T1155]  crc16
[ T2977]  btmtk bluetooth
[ T1155]  i2c_hid_acpi
[ T2234]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  i2c_hid
[ T2977]  ecdh_generic ecc
[ T1155]  hid i2c_piix4
[ T2977]  snd_hda_intel
[ T2234]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  i2c_smbus
[ T2977]  snd_intel_dspcfg
[ T1155]  i2c_designware_platform
[ T2977]  uvcvideo
[ T2977]  snd_hda_codec
[ T1155]  i2c_designware_core
[ T2234]  bpf_trace_run2+0xd3/0x260
[ T1155]  [last unloaded: bpf_testmod(O)]
[ T2977]  videobuf2_memops
[ T2977]  uvc
[ T2234]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  snd_mixer_oss videobuf2_common snd_acp_config msi_wmi
[ T2234]  syscall_trace_enter+0x1c7/0x260
[ T2977]  snd_pcm mc sparse_keymap snd_soc_acpi snd_timer
[ T2234]  do_syscall_64+0x395/0xfa0
[ T2977]  wmi_bmof edac_mce_amd snd
[ T2234]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  k10temp snd_pci_acp3x soundcore ccp battery
[ T2234]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  ac button joydev hid_sensor_magn_3d
[ T2977]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d
[ T2234] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T2977]  hid_sensor_als hid_sensor_trigger
[ T2234] RSP: 002b:00007f1f537fd418 EFLAGS: 00000246
[ T2977]  industrialio_triggered_buffer kfifo_buf
[ T2234]  ORIG_RAX: 00000000000000ca
[ T2977]  industrialio
[ T2234] RAX: ffffffffffffffda RBX: 00007f1f6d470100 RCX: 00007f1f6d803779
[ T2977]  evdev
[ T2234] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 00007f1f60e5bae8
[ T2977]  hid_sensor_iio_common amd_pmc
[ T2234] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000080000
[ T2977]  sch_fq_codel
[ T2234] R10: 00007f1f5f4f5c10 R11: 0000000000000246 R12: 00007f1f26332400
[ T2977]  mt7921e
[ T2977]  mt7921_common
[ T2234] R13: 00007f1f537fd600 R14: 0000000000000000 R15: 0000000000000008
[ T2977]  mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill =
msr nvme_fabrics fuse efi_pstore
[ T2234]  </TASK>
[ T2977]  configfs nfnetlink efivarfs
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977]  autofs4 ext4
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977]  mbcache
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977]  jbd2 usbhid
[  T555] INFO: lockdep is turned off.
[ T1155] Call Trace:
[ T2977]  amdgpu
[  T555] Modules linked in:
[ T1155]  <TASK>
[ T2977]  amdxcp i2c_algo_bit
[ T1155]  dump_stack_lvl+0x6d/0xb0
[  T555]  snd_seq_dummy
[ T2977]  ttm
[  T555]  snd_seq_midi
[ T2977]  gpu_sched
[ T2977]  drm_suballoc_helper drm_panel_backlight_quirks
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[  T555]  snd_rawmidi
[ T2977]  cec
[ T1155]  __schedule+0x167e/0x1ca0
[ T2977]  drm_buddy
[  T555]  bnep
[ T2977]  usbcore
[  T555]  snd_hda_codec_realtek snd_hda_codec_generic
[  T555]  snd_hda_scodec_component snd_hda_codec_hdmi
[ T2977]  psmouse
[  T555]  nls_ascii
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  nvme_core r8169
[  T555]  snd_soc_core
[ T2977]  crc16
[  T555]  bluetooth
[  T555]  snd_hda_intel snd_intel_dspcfg
[ T2977]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[  T555]  uvcvideo snd_hda_codec
[ T2977]=20
[ T1155]  schedule_rtlock+0x21/0x40
[ T2977] Preemption disabled at:
[  T555]  videobuf2_memops snd_hwdep
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  videodev snd_rn_pci_acp3x snd_mixer_oss
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  videobuf2_common snd_acp_config msi_wmi snd_pcm
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  mc sparse_keymap snd_soc_acpi snd_timer
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  wmi_bmof edac_mce_amd snd
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  k10temp snd_pci_acp3x
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  soundcore ccp battery
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ac button joydev hid_sensor_magn_3d
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  industrialio
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  evdev hid_sensor_iio_common amd_pmc sch_fq_codel
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  mt7921e mt7921_common mt792x_lib
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1387]  cfg80211 rfkill
[ T2977] Call Trace:
[ T1387]  msr
[ T2977]  <TASK>
[ T1387]  nvme_fabrics fuse
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T1387]  efi_pstore configfs nfnetlink efivarfs autofs4
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T1387]  ext4 mbcache jbd2
[ T2977]  __schedule+0x167e/0x1ca0
[ T1387]  usbhid amdgpu amdxcp i2c_algo_bit
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  drm_client_lib drm_ttm_helper ttm
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  drm_exec gpu_sched drm_suballoc_helper
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1387]  drm_panel_backlight_quirks cec xhci_pci drm_buddy
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  xhci_hcd drm_display_helper usbcore
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  hid_sensor_hub drm_kms_helper psmouse
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1387]  nvme mfd_core hid_multitouch
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  hid_generic serio_raw nvme_core
[ T2977]  ? lock_release+0x21b/0x2e0
[ T1387]  r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid
[ T2977]  schedule_rtlock+0x21/0x40
[ T1387]  hid i2c_piix4 i2c_smbus
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T1387]  i2c_designware_platform i2c_designware_core [last unloaded: bpf_t=
estmod(O)]
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]=20
[ T1387] Preemption disabled at:
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1387] [<ffffffffa215f33f>] fput+0x1f/0x90
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  rt_spin_lock+0x99/0x190
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0000
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[ T2977]  </TASK>
[ T1387] CPU: 8 UID: 1000 PID: 1387 Comm: Xorg Tainted: G        W  O      =
  6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1387] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1387] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1387] Call Trace:
[ T1387]  <TASK>
[ T1387]  dump_stack_lvl+0x6d/0xb0
[ T1387]  ? fput+0x1f/0x90
[ T1387]  __schedule_bug.cold+0x8c/0x9a
[ T1387]  __schedule+0x167e/0x1ca0
[ T1387]  ? unix_stream_sendmsg+0x5ff/0x670
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  ? rcu_is_watching+0x12/0x60
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  ? rcu_is_watching+0x12/0x60
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  ? lock_release+0x21b/0x2e0
[ T1387]  schedule_rtlock+0x21/0x40
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T2977] INFO: lockdep is turned off.
[ T1387]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_devic=
e rfcomm bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T2977]  snd_hda_scodec_component
[ T1387]  rt_spin_lock+0x99/0x190
[ T2977]  snd_hda_codec_hdmi
[ T1155] INFO: lockdep is turned off.
[ T2977]  nls_ascii
[ T1155] Modules linked in:
[ T2977]  nls_cp437 vfat
[ T1155]  bpf_testmod(O)
[ T1387]  task_get_cgroup1+0xe8/0x340
[ T2977]  fat snd_acp3x_pdm_dma
[ T1155]  ccm
[ T2977]  snd_soc_dmic
[ T1155]  snd_seq_dummy snd_hrtimer
[ T2977]  snd_acp3x_rn
[ T1387]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  snd_seq_midi
[ T2977]  btusb
[ T1155]  snd_seq_midi_event
[ T2977]  btrtl snd_soc_core
[ T1155]  snd_rawmidi
[ T1387]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  btintel
[ T1155]  snd_seq
[ T2977]  btbcm
[ T1155]  snd_seq_device
[ T2977]  btmtk
[ T1387]  bpf_trace_run2+0xd3/0x260
[ T1155]  rfcomm
[ T2977]  bluetooth
[ T1155]  bnep
[ T1155]  snd_ctl_led
[ T2977]  ecdh_generic
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_hda_codec_realtek
[ T2977]  ecc
[ T1155]  snd_hda_codec_generic
[ T2977]  snd_hda_intel
[ T1155]  snd_hda_scodec_component
[ T2977]  snd_intel_dspcfg
[ T1155]  snd_hda_codec_hdmi
[ T2977]  uvcvideo
[ T1387]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  nls_ascii
[ T1155]  nls_cp437
[ T2977]  snd_hda_codec
[ T2977]  videobuf2_vmalloc
[ T1155]  vfat fat
[ T2977]  videobuf2_memops
[ T1387]  syscall_trace_enter+0x1c7/0x260
[ T2977]  snd_hwdep
[ T1155]  snd_acp3x_pdm_dma
[ T2977]  uvc
[ T1155]  snd_soc_dmic
[ T2977]  snd_hda_core
[ T1155]  snd_acp3x_rn
[ T1387]  do_syscall_64+0x395/0xfa0
[ T2977]  videobuf2_v4l2
[ T1155]  btusb btrtl
[ T2977]  snd_pcm_oss
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  videodev
[ T1155]  snd_soc_core btintel
[ T2977]  snd_rn_pci_acp3x
[ T1155]  btbcm
[ T2977]  snd_mixer_oss
[ T1155]  btmtk
[ T1387]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  videobuf2_common
[ T1155]  bluetooth ecdh_generic
[ T2977]  snd_acp_config msi_wmi
[ T1155]  ecc
[ T2977]  snd_pcm
[ T1155]  snd_hda_intel
[ T1387] RIP: 0033:0x7f732c2af9ee
[ T2977]  mc sparse_keymap
[ T1155]  snd_intel_dspcfg
[ T1387] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c =
89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2=
e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[ T2977]  snd_soc_acpi
[ T1155]  uvcvideo
[ T2977]  snd_timer
[ T1155]  snd_hda_codec
[ T1387] RSP: 002b:00007ffefbcb5f18 EFLAGS: 00000246
[ T1155]  videobuf2_vmalloc
[ T2977]  wmi_bmof
[ T1387]  ORIG_RAX: 000000000000002f
[ T1155]  videobuf2_memops
[ T2977]  edac_mce_amd
[ T1387] RAX: ffffffffffffffda RBX: 00007f732bfa0b00 RCX: 00007f732c2af9ee
[ T1155]  snd_hwdep
[ T2977]  snd
[ T1387] RDX: 0000000000000000 RSI: 00007ffefbcb5fa0 RDI: 000000000000002f
[ T1155]  uvc
[ T2977]  k10temp
[ T1387] RBP: 0000000000004000 R08: 0000000000000000 R09: 0000000000000000
[ T2977]  snd_pci_acp3x
[ T1155]  snd_hda_core videobuf2_v4l2
[ T1387] R10: 0000000000000000 R11: 0000000000000246 R12: 00005633f0420c40
[ T2977]  soundcore ccp
[ T1155]  snd_pcm_oss
[ T1387] R13: 00005633efad56a0 R14: 0000000000000000 R15: 0000000000000000
[ T2977]  battery
[ T1155]  videodev snd_rn_pci_acp3x
[ T2977]  ac button
[ T1155]  snd_mixer_oss videobuf2_common
[ T2977]  joydev hid_sensor_magn_3d
[ T1155]  snd_acp_config
[ T2977]  hid_sensor_prox
[ T1155]  msi_wmi snd_pcm
[ T2977]  hid_sensor_accel_3d hid_sensor_gyro_3d
[ T1155]  mc
[ T1387]  </TASK>
[ T2977]  hid_sensor_als
[ T1155]  sparse_keymap snd_soc_acpi
[ T2977]  hid_sensor_trigger
[ T1155]  snd_timer
[ T2977]  industrialio_triggered_buffer
[ T1155]  wmi_bmof
[ T2977]  kfifo_buf
[ T1155]  edac_mce_amd
[ T2977]  industrialio
[ T1155]  snd
[ T2977]  evdev
[ T1155]  k10temp
[ T2977]  hid_sensor_iio_common
[ T1155]  snd_pci_acp3x
[ T2977]  amd_pmc
[ T1155]  soundcore ccp
[ T2977]  sch_fq_codel mt7921e
[ T1155]  battery ac
[ T2977]  mt7921_common mt792x_lib
[ T1155]  button joydev
[ T2977]  mt76_connac_lib mt76
[ T1155]  hid_sensor_magn_3d hid_sensor_prox
[ T2977]  mac80211 libarc4
[ T1155]  hid_sensor_accel_3d
[ T2977]  cfg80211
[ T1155]  hid_sensor_gyro_3d hid_sensor_als
[ T2977]  rfkill msr
[ T1155]  hid_sensor_trigger industrialio_triggered_buffer
[ T2977]  nvme_fabrics
[ T1155]  kfifo_buf
[ T2977]  fuse
[ T2977]  efi_pstore
[ T1155]  industrialio evdev
[ T2977]  configfs
[ T1155]  hid_sensor_iio_common
[ T2977]  nfnetlink efivarfs
[ T1155]  amd_pmc sch_fq_codel
[ T2977]  autofs4 ext4
[ T1155]  mt7921e
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T2977]  mbcache
[ T1155]  mt7921_common
[ T2977]  jbd2
[  T555] INFO: lockdep is turned off.
[ T2977]  usbhid
[ T1155]  mt792x_lib
[  T555] Modules linked in:
[ T2977]  amdgpu
[ T1155]  mt76_connac_lib
[  T555]  bpf_testmod(O)
[ T2977]  amdxcp
[ T1155]  mt76
[ T2977]  i2c_algo_bit
[ T1155]  mac80211
[  T555]  ccm
[ T1155]  libarc4
[  T555]  snd_seq_dummy
[ T2977]  drm_client_lib
[ T1155]  cfg80211
[  T555]  snd_hrtimer
[ T2977]  drm_ttm_helper
[ T1155]  rfkill
[  T555]  snd_seq_midi
[ T2977]  ttm
[ T2977]  drm_exec
[  T555]  snd_seq_midi_event
[ T1155]  msr nvme_fabrics
[ T2977]  gpu_sched
[  T555]  snd_rawmidi
[ T1155]  fuse
[ T2977]  drm_suballoc_helper
[  T555]  snd_seq
[ T1155]  efi_pstore
[ T2977]  drm_panel_backlight_quirks
[  T555]  snd_seq_device
[ T1155]  configfs
[ T2977]  cec
[  T555]  rfcomm
[ T1155]  nfnetlink
[  T555]  bnep
[ T1155]  efivarfs
[ T2977]  xhci_pci drm_buddy
[  T555]  snd_ctl_led
[ T1155]  autofs4
[ T2977]  xhci_hcd
[  T555]  snd_hda_codec_realtek
[ T1155]  ext4 mbcache
[ T2977]  drm_display_helper
[  T555]  snd_hda_codec_generic snd_hda_scodec_component
[ T1155]  jbd2
[ T2977]  usbcore hid_sensor_hub
[  T555]  snd_hda_codec_hdmi
[ T1155]  usbhid
[ T2977]  drm_kms_helper
[ T1155]  amdgpu
[  T555]  nls_ascii
[ T2977]  psmouse
[ T1155]  amdxcp
[  T555]  nls_cp437 vfat
[ T2977]  nvme
[ T1155]  i2c_algo_bit
[  T555]  fat
[ T1155]  drm_client_lib
[ T2977]  mfd_core
[  T555]  snd_acp3x_pdm_dma
[ T1155]  drm_ttm_helper
[ T2977]  hid_multitouch
[  T555]  snd_soc_dmic
[ T2977]  hid_generic
[ T1155]  ttm
[  T555]  snd_acp3x_rn
[ T1155]  drm_exec
[ T2977]  serio_raw
[  T555]  btusb
[ T1155]  gpu_sched
[ T2977]  nvme_core
[  T555]  btrtl
[ T1155]  drm_suballoc_helper
[ T2977]  r8169
[  T555]  snd_soc_core
[ T2977]  usb_common
[ T1155]  drm_panel_backlight_quirks cec
[  T555]  btintel
[ T2977]  amd_sfh
[ T1155]  xhci_pci
[  T555]  btbcm
[ T2977]  crc16
[ T1155]  drm_buddy
[ T2977]  i2c_hid_acpi
[  T555]  btmtk bluetooth
[ T1155]  xhci_hcd
[ T2977]  i2c_hid hid
[  T555]  ecdh_generic
[ T1155]  drm_display_helper usbcore
[  T555]  ecc
[ T2977]  i2c_piix4
[ T1155]  hid_sensor_hub
[  T555]  snd_hda_intel
[ T2977]  i2c_smbus
[  T555]  snd_intel_dspcfg
[ T2977]  i2c_designware_platform
[ T1155]  drm_kms_helper psmouse
[ T2977]  i2c_designware_core
[  T555]  uvcvideo
[ T1155]  nvme
[  T555]  snd_hda_codec
[ T2977]  [last unloaded: bpf_testmod(O)]
[ T1155]  mfd_core
[ T2977]=20
[  T555]  videobuf2_vmalloc
[ T1155]  hid_multitouch
[  T555]  videobuf2_memops
[ T2977] Preemption disabled at:
[ T1155]  hid_generic
[  T555]  snd_hwdep
[ T1155]  serio_raw
[  T555]  uvc
[ T2977] [<0000000000000000>] 0x0
[ T1155]  nvme_core
[  T555]  snd_hda_core
[ T1155]  r8169 usb_common
[  T555]  videobuf2_v4l2 snd_pcm_oss
[ T1155]  amd_sfh
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155]  crc16
[  T555]  videodev snd_rn_pci_acp3x
[ T1155]  i2c_hid_acpi
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  snd_mixer_oss
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  i2c_hid hid
[  T555]  videobuf2_common
[ T2977] Call Trace:
[ T1155]  i2c_piix4
[  T555]  snd_acp_config
[ T2977]  <TASK>
[ T1155]  i2c_smbus
[  T555]  msi_wmi
[ T1155]  i2c_designware_platform
[  T555]  snd_pcm
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T1155]  i2c_designware_core
[  T555]  mc
[ T1155]  [last unloaded: bpf_testmod(O)]
[  T555]  sparse_keymap snd_soc_acpi
[ T1155]=20
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T1155] Preemption disabled at:
[  T555]  snd_timer wmi_bmof edac_mce_amd
[ T2977]  __schedule+0x167e/0x1ca0
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[  T555]  snd k10temp
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_pci_acp3x soundcore ccp battery
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ac button
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  industrialio_triggered_buffer kfifo_buf industrialio
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  evdev hid_sensor_iio_common amd_pmc
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  sch_fq_codel mt7921e
[ T2977]  ? lock_release+0x21b/0x2e0
[  T555]  mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cf=
g80211
[ T2977]  schedule_rtlock+0x21/0x40
[  T555]  rfkill msr nvme_fabrics
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  fuse efi_pstore configfs nfnetlink
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  efivarfs autofs4 ext4
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  mbcache jbd2 usbhid amdgpu
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gp=
u_sched drm_suballoc_helper drm_panel_backlight_quirks cec xhci_pci
[ T2977]  rt_spin_lock+0x99/0x190
[  T555]  drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_=
kms_helper
[ T2977]  task_get_cgroup1+0xe8/0x340
[  T555]  psmouse nvme mfd_core hid_multitouch
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  hid_generic serio_raw nvme_core r8169
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  usb_common amd_sfh crc16 i2c_hid_acpi
[ T2977]  bpf_trace_run2+0xd3/0x260
[  T555]  i2c_hid hid i2c_piix4
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  i2c_smbus
[  T555]  i2c_designware_platform i2c_designware_core [last unloaded: bpf_t=
estmod(O)]
[  T555] Preemption disabled at:
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[  T555] [<0000000000000000>] 0x0
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T2977]  do_syscall_64+0x395/0xfa0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0000
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[ T2977]  </TASK>
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387] BUG: scheduling while atomic: Xorg/1387/0x00000002
[ T1387] INFO: lockdep is turned off.
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1387] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy
[ T1155] RIP: 0033:0x7fc77ec77f13
[ T1387]  snd_hrtimer snd_seq_midi
[ T1155] Code: 81 00 00 00 b8 ca 00 00 00 0f 05 c3 66 66 2e 0f 1f 84 00 00 =
00 00 00 40 80 f6 81 45 31 d2 ba 01 00 00 00 b8 ca 00 00 00 0f 05 <c3> 66 2=
e 0f 1f 84 00 00 00 00 00 66 90 48 8b 05 61 70 15 00 48 89
[ T1387]  snd_seq_midi_event
[ T1155] RSP: 002b:00007fc77e6b0248 EFLAGS: 00000246
[ T1387]  snd_rawmidi snd_seq
[ T1155]  ORIG_RAX: 00000000000000ca
[ T1387]  snd_seq_device
[ T1155] RAX: ffffffffffffffda RBX: 000055f047b76d90 RCX: 00007fc77ec77f13
[ T1387]  rfcomm
[ T1155] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 000055f047b83c70
[ T1387]  bnep snd_ctl_led
[ T1155] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ T1387]  snd_hda_codec_realtek
[ T1155] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc7700b03a0
[ T1387]  snd_hda_codec_generic
[ T1155] R13: 0000000000000004 R14: 0000000000085c89 R15: 000055f047b7b880
[ T1387]  snd_hda_scodec_component
[ T1387]  snd_hda_codec_hdmi nls_ascii nls_cp437 vfat fat snd_acp3x_pdm_dma=
 snd_soc_dmic snd_acp3x_rn btusb
[ T1155]  </TASK>
[ T1387]  btrtl snd_soc_core btintel btbcm
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1387]  btmtk bluetooth
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1387]  ecdh_generic
[ T1387]  ecc
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1387]  snd_hda_intel
[  T555] Call Trace:
[ T1387]  snd_intel_dspcfg
[  T555]  <TASK>
[ T1387]  uvcvideo snd_hda_codec videobuf2_vmalloc
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T1387]  videobuf2_memops snd_hwdep uvc snd_hda_core
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T1387]  videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_acp3x
[  T555]  __schedule+0x167e/0x1ca0
[ T1387]  snd_mixer_oss videobuf2_common snd_acp_config
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1387]  msi_wmi
[ T1387]  snd_pcm mc sparse_keymap snd_soc_acpi
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  snd_timer wmi_bmof
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1387]  edac_mce_amd
[ T1387]  snd k10temp snd_pci_acp3x
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  soundcore ccp battery
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  ac button joydev
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1387]  hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  hid_sensor_gyro_3d hid_sensor_als
[  T555]  ? lock_release+0x21b/0x2e0
[ T1387]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indust=
rialio evdev hid_sensor_iio_common
[  T555]  schedule_rtlock+0x21/0x40
[ T1387]  amd_pmc sch_fq_codel mt7921e
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T1387]  mt7921_common mt792x_lib mt76_connac_lib
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1387]  mt76
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  mac80211
[ T1155] INFO: lockdep is turned off.
[ T1387]  libarc4
[ T1155] Modules linked in:
[ T1387]  cfg80211
[ T1155]  bpf_testmod(O)
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1387]  rfkill
[ T1155]  ccm
[ T1387]  msr nvme_fabrics
[ T1155]  snd_seq_dummy
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  fuse
[ T1155]  snd_hrtimer snd_seq_midi
[ T1387]  efi_pstore configfs
[ T1155]  snd_seq_midi_event snd_rawmidi
[ T1387]  nfnetlink efivarfs
[ T1155]  snd_seq snd_seq_device
[ T1387]  autofs4 ext4
[ T1155]  rfcomm
[ T1387]  mbcache
[ T1155]  bnep snd_ctl_led
[  T555]  rt_spin_lock+0x99/0x190
[ T1387]  jbd2
[ T1155]  snd_hda_codec_realtek
[ T1387]  usbhid amdgpu
[ T1155]  snd_hda_codec_generic snd_hda_scodec_component
[ T1387]  amdxcp i2c_algo_bit
[ T1155]  snd_hda_codec_hdmi
[  T555]  task_get_cgroup1+0xe8/0x340
[ T1387]  drm_client_lib
[ T1155]  nls_ascii
[ T1387]  drm_ttm_helper
[ T1387]  ttm
[ T1155]  nls_cp437 vfat
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T1387]  drm_exec
[ T1155]  fat
[ T1387]  gpu_sched drm_suballoc_helper
[ T1155]  snd_acp3x_pdm_dma snd_soc_dmic
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1387]  drm_panel_backlight_quirks
[ T1155]  snd_acp3x_rn
[ T1387]  cec
[ T1155]  btusb
[ T1155]  btrtl
[ T1387]  xhci_pci
[  T555]  bpf_trace_run2+0xd3/0x260
[ T1155]  snd_soc_core
[ T1387]  drm_buddy xhci_hcd
[ T1155]  btintel btbcm
[ T1387]  drm_display_helper
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  btmtk
[ T1387]  usbcore
[ T1155]  bluetooth
[ T1387]  hid_sensor_hub
[ T1155]  ecdh_generic ecc
[ T1387]  drm_kms_helper psmouse
[ T1155]  snd_hda_intel
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T1387]  nvme
[ T1155]  snd_intel_dspcfg
[ T1387]  mfd_core
[ T1155]  uvcvideo
[ T1387]  hid_multitouch
[ T1155]  snd_hda_codec
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T1155]  videobuf2_vmalloc
[ T1387]  hid_generic serio_raw
[ T1155]  videobuf2_memops snd_hwdep
[ T1387]  nvme_core
[ T1155]  uvc
[ T1387]  r8169
[  T555]  do_syscall_64+0x395/0xfa0
[ T1387]  usb_common
[ T1155]  snd_hda_core
[ T1387]  amd_sfh
[ T1155]  videobuf2_v4l2
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1387]  crc16
[ T1155]  snd_pcm_oss
[ T1387]  i2c_hid_acpi
[ T1387]  i2c_hid
[ T1155]  videodev snd_rn_pci_acp3x
[ T1387]  hid
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1387]  i2c_piix4
[ T1155]  snd_mixer_oss videobuf2_common
[ T1387]  i2c_smbus i2c_designware_platform
[ T1155]  snd_acp_config
[  T555] RIP: 0033:0x7fd47309ea0e
[ T1387]  i2c_designware_core
[ T1155]  msi_wmi snd_pcm
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T1387]  [last unloaded: bpf_testmod(O)]
[ T1155]  mc
[ T1155]  sparse_keymap
[ T1387]=20
[  T555] RSP: 002b:00007fff31d516e0 EFLAGS: 00000297
[ T1387] Preemption disabled at:
[ T1155]  snd_soc_acpi
[  T555]  ORIG_RAX: 00000000000000e4
[ T1155]  snd_timer
[  T555] RAX: ffffffffffffffda RBX: 000055b3d56687b0 RCX: 00007fd47309ea0e
[ T1155]  wmi_bmof
[ T1155]  edac_mce_amd
[ T1387] [<0000000000000000>] 0x0
[  T555] RDX: 0000000000000080 RSI: 00007fff31d51700 RDI: 0000000000000007
[ T1155]  snd
[  T555] RBP: 00007fff31d516e0 R08: 0000000000000000 R09: 00007fd473098000
[ T1155]  k10temp snd_pci_acp3x
[  T555] R10: ffffffffffffffff R11: 0000000000000297 R12: 0000000000000001
[ T1155]  soundcore
[  T555] R13: ffffffffffffffff R14: 0000000000000050 R15: 0000000000000007
[ T1155]  ccp battery ac button joydev hid_sensor_magn_3d hid_sensor_prox h=
id_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als
[  T555]  </TASK>
[ T1155]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indust=
rialio
[ T1387] CPU: 8 UID: 1000 PID: 1387 Comm: Xorg Tainted: G        W  O      =
  6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155]  evdev hid_sensor_iio_common amd_pmc
[ T1387] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155]  sch_fq_codel
[ T1387] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  mt7921e
[ T1387] Call Trace:
[ T1155]  mt7921_common mt792x_lib
[ T1387]  <TASK>
[ T1155]  mt76_connac_lib
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  mt76 mac80211
[  T555] INFO: lockdep is turned off.
[ T1387]  dump_stack_lvl+0x6d/0xb0
[  T555] Modules linked in:
[ T1155]  libarc4
[  T555]  bpf_testmod(O)
[ T1155]  cfg80211
[  T555]  ccm
[ T1155]  rfkill
[ T1387]  __schedule_bug.cold+0x8c/0x9a
[  T555]  snd_seq_dummy
[ T1155]  msr nvme_fabrics
[  T555]  snd_hrtimer snd_seq_midi
[ T1155]  fuse
[ T1387]  __schedule+0x167e/0x1ca0
[ T1155]  efi_pstore
[  T555]  snd_seq_midi_event snd_rawmidi
[ T1155]  configfs nfnetlink
[  T555]  snd_seq
[ T1387]  ? rcu_is_watching+0x12/0x60
[ T1155]  efivarfs
[  T555]  snd_seq_device rfcomm
[ T1155]  autofs4 ext4
[  T555]  bnep
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  mbcache
[  T555]  snd_ctl_led snd_hda_codec_realtek
[ T1155]  jbd2 usbhid
[  T555]  snd_hda_codec_generic
[ T1387]  ? rcu_is_watching+0x12/0x60
[ T1155]  amdgpu
[  T555]  snd_hda_scodec_component
[ T1155]  amdxcp i2c_algo_bit
[  T555]  snd_hda_codec_hdmi
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  nls_ascii
[ T1155]  drm_client_lib
[  T555]  nls_cp437
[ T1155]  drm_ttm_helper ttm
[  T555]  vfat
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  drm_exec
[  T555]  fat
[ T1155]  gpu_sched
[  T555]  snd_acp3x_pdm_dma
[ T1387]  ? rcu_is_watching+0x12/0x60
[ T1155]  drm_suballoc_helper
[  T555]  snd_soc_dmic snd_acp3x_rn
[ T1155]  drm_panel_backlight_quirks
[  T555]  btusb
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  cec
[  T555]  btrtl
[ T1155]  xhci_pci
[ T1387]  ? lock_release+0x21b/0x2e0
[  T555]  snd_soc_core
[ T1155]  drm_buddy
[  T555]  btintel
[ T1155]  xhci_hcd
[  T555]  btbcm
[ T1155]  drm_display_helper
[  T555]  btmtk
[ T1155]  usbcore
[  T555]  bluetooth
[ T1387]  schedule_rtlock+0x21/0x40
[ T1155]  hid_sensor_hub
[  T555]  ecdh_generic
[ T1155]  drm_kms_helper
[  T555]  ecc snd_hda_intel
[ T1155]  psmouse
[ T1387]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  nvme
[  T555]  snd_intel_dspcfg uvcvideo
[ T1155]  mfd_core hid_multitouch
[  T555]  snd_hda_codec
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_generic
[  T555]  videobuf2_vmalloc videobuf2_memops
[ T1155]  serio_raw
[  T555]  snd_hwdep
[ T1387]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  nvme_core
[  T555]  uvc
[ T1155]  r8169 usb_common
[  T555]  snd_hda_core
[ T1155]  amd_sfh
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  videobuf2_v4l2
[ T1155]  crc16
[  T555]  snd_pcm_oss
[ T1155]  i2c_hid_acpi
[  T555]  videodev
[ T1155]  i2c_hid hid
[  T555]  snd_rn_pci_acp3x snd_mixer_oss
[ T1155]  i2c_piix4 i2c_smbus
[  T555]  videobuf2_common snd_acp_config
[ T1155]  i2c_designware_platform i2c_designware_core
[  T555]  msi_wmi
[ T1387]  rt_spin_lock+0x99/0x190
[ T1155]  [last unloaded: bpf_testmod(O)]
[  T555]  snd_pcm mc
[ T1155]=20
[  T555]  sparse_keymap
[ T1155] Preemption disabled at:
[  T555]  snd_soc_acpi
[ T1387]  task_get_cgroup1+0xe8/0x340
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[  T555]  snd_timer wmi_bmof edac_mce_amd snd
[ T1387]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  k10temp snd_pci_acp3x soundcore
[ T1387]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  ccp battery ac button
[ T1387]  bpf_trace_run2+0xd3/0x260
[  T555]  joydev hid_sensor_magn_3d hid_sensor_prox
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_=
trigger industrialio_triggered_buffer kfifo_buf
[ T1387]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  industrialio evdev hid_sensor_iio_common amd_pmc sch_fq_codel
[ T1387]  syscall_trace_enter+0x1c7/0x260
[  T555]  mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76
[ T1387]  do_syscall_64+0x395/0xfa0
[  T555]  mac80211 libarc4
[ T1387]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  cfg80211 rfkill msr nvme_fabrics fuse
[ T1387]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  efi_pstore configfs nfnetlink efivarfs
[ T1387] RIP: 0033:0x7f732c2f8da7
[  T555]  autofs4 ext4
[ T1387] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 =
6f 00 00 00 0f 05 c3 0f 1f 84 00 00 00 00 00 b8 27 00 00 00 0f 05 <c3> 0f 1=
f 84 00 00 00 00 00 b8 6e 00 00 00 0f 05 c3 0f 1f 84 00 00
[  T555]  mbcache jbd2
[ T1387] RSP: 002b:00007ffefbcb6118 EFLAGS: 00000202
[  T555]  usbhid amdgpu
[ T1387]  ORIG_RAX: 0000000000000027
[  T555]  amdxcp
[ T1387] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f732c2f8da7
[  T555]  i2c_algo_bit drm_client_lib
[ T1387] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005633ee91eb00
[  T555]  drm_ttm_helper
[ T1387] RBP: 00005633ee91eb00 R08: 0000000000000001 R09: 0000000000000001
[  T555]  ttm drm_exec
[ T1387] R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000000000
[  T555]  gpu_sched
[ T1387] R13: 0000000000000000 R14: 00005633d5592b18 R15: 00005633ee762bc0
[  T555]  drm_suballoc_helper
[  T555]  drm_panel_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_di=
splay_helper usbcore hid_sensor_hub drm_kms_helper psmouse
[ T1387]  </TASK>
[  T555]  nvme mfd_core hid_multitouch
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555]  hid_generic serio_raw
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  nvme_core
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555]  r8169 usb_common
[ T1155] Call Trace:
[  T555]  amd_sfh
[ T1155]  <TASK>
[  T555]  crc16 i2c_hid_acpi i2c_hid
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T1155]  dump_stack_lvl+0x6d/0xb0
[  T555]  hid i2c_piix4
[ T2977] INFO: lockdep is turned off.
[  T555]  i2c_smbus
[ T2977] Modules linked in:
[  T555]  i2c_designware_platform
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T2977]  bpf_testmod(O) ccm
[  T555]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2977]  snd_seq_dummy
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  snd_hrtimer
[  T555]=20
[  T555] Preemption disabled at:
[ T2977]  snd_seq_midi snd_seq_midi_event
[ T1155]  __schedule+0x167e/0x1ca0
[ T2977]  snd_rawmidi
[  T555] [<0000000000000000>] 0x0
[ T2977]  snd_seq snd_seq_device
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  rfcomm bnep snd_ctl_led snd_hda_codec_realtek
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_hda_codec_generic snd_hda_scodec_component
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_hda_codec_hdmi
[ T2977]  nls_ascii nls_cp437 vfat
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  fat snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_acp3x_rn btusb btrtl
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_soc_core btintel btbcm btmtk
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  bluetooth ecdh_generic
[ T1155]  ? lock_release+0x21b/0x2e0
[ T2977]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec videobu=
f2_vmalloc
[ T1155]  schedule_rtlock+0x21/0x40
[ T2977]  videobuf2_memops snd_hwdep uvc
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  snd_acp_config msi_wmi snd_pcm
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  mc sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd snd=
 k10temp snd_pci_acp3x soundcore ccp
[ T1155]  rt_spin_lock+0x99/0x190
[ T2977]  battery ac button joydev hid_sensor_magn_3d hid_sensor_prox
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T2977]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_=
trigger
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  industrialio_triggered_buffer kfifo_buf industrialio evdev
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  hid_sensor_iio_common amd_pmc sch_fq_codel
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T2977]  mt7921e mt7921_common mt792x_lib
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  nvme_fabrics fuse efi_pstore configfs nfnetlink
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T2977]  efivarfs autofs4 ext4 mbcache
[ T1155]  do_syscall_64+0x395/0xfa0
[ T2977]  jbd2 usbhid amdgpu
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  drm_exec gpu_sched drm_suballoc_helper
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T2977]  drm_panel_backlight_quirks cec xhci_pci
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T2977]  drm_buddy xhci_hcd
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[ T2977]  drm_display_helper
[ T1155]  ORIG_RAX: 0000000000000060
[ T2977]  usbcore
[ T1155] RAX: ffffffffffffffda RBX: 00007fc770000c98 RCX: 00007fc77f05c7f9
[ T2977]  hid_sensor_hub drm_kms_helper
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T2977]  psmouse nvme
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 0000000000042448
[ T2977]  mfd_core
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T2977]  hid_multitouch hid_generic
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000085c8e R15: 000055f047b7b880
[ T2977]  serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i=
2c_hid hid i2c_piix4
[ T1155]  </TASK>
[ T2977]  i2c_smbus i2c_designware_platform i2c_designware_core
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977]  [last unloaded: bpf_testmod(O)]
[ T2977]=20
[ T2977] Preemption disabled at:
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[ T2977] [<0000000000000000>] 0x0
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[  T555]  __schedule_bug.cold+0x8c/0x9a
[  T555]  __schedule+0x167e/0x1ca0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? lock_release+0x21b/0x2e0
[  T555]  schedule_rtlock+0x21/0x40
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  rt_spin_lock+0x99/0x190
[  T555]  task_get_cgroup1+0xe8/0x340
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  bpf_trace_run2+0xd3/0x260
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  syscall_trace_enter+0x1c7/0x260
[  T555]  do_syscall_64+0x395/0xfa0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555] RIP: 0033:0x7fd47309ea0e
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[  T555] RSP: 002b:00007fff31d51730 EFLAGS: 00000297 ORIG_RAX: 000000000000=
00e4
[  T555] RAX: ffffffffffffffda RBX: 000055b3c0476728 RCX: 00007fd47309ea0e
[  T555] RDX: 0000000000000002 RSI: 00007fff31d51750 RDI: 0000000000000001
[  T555] RBP: 00007fff31d51730 R08: 0000000000000000 R09: 00007fd473098000
[  T555] R10: 00007fff31d517e0 R11: 0000000000000297 R12: 0000000000000353
[  T555] R13: 000055b3c0476728 R14: 000055b3d5668660 R15: 0000000000000000
[  T555]  </TASK>
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977] Call Trace:
[ T2977]  <TASK>
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  __schedule+0x167e/0x1ca0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155] Modules linked in: bpf_testmod(O) ccm
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_seq_dummy snd_hrtimer snd_seq_midi
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_seq_midi_event snd_rawmidi snd_seq
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_seq_device rfcomm bnep
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_ctl_led snd_hda_codec_realtek
[ T2977]  ? lock_release+0x21b/0x2e0
[ T1155]  snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi=
 nls_ascii nls_cp437
[ T2977]  schedule_rtlock+0x21/0x40
[ T1155]  vfat fat snd_acp3x_pdm_dma snd_soc_dmic
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  snd_acp3x_rn btusb btrtl
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_soc_core
[ T1155]  btintel btbcm
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  btmtk bluetooth ecdh_generic ecc
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec videobuf2_v=
malloc videobuf2_memops snd_hwdep uvc snd_hda_core videobuf2_v4l2 snd_pcm_o=
ss
[ T2977]  rt_spin_lock+0x99/0x190
[ T1155]  videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_=
config
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T1155]  msi_wmi snd_pcm mc sparse_keymap
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  snd k10temp snd_pci_acp3x soundcore
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T1155]  ccp battery ac button
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d hid=
_sensor_gyro_3d hid_sensor_als
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indust=
rialio
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T1155]  evdev hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e
[ T2977]  do_syscall_64+0x395/0xfa0
[ T1155]  mt7921_common mt792x_lib
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  mt76_connac_lib mt76 mac80211 libarc4 cfg80211
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  rfkill msr nvme_fabrics fuse
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T1155]  efi_pstore configfs
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T1155]  nfnetlink efivarfs
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202
[ T1155]  autofs4 ext4
[ T2977]  ORIG_RAX: 0000000000000000
[ T1155]  mbcache
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T1155]  jbd2 usbhid
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T1155]  amdgpu
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[ T1155]  amdxcp i2c_algo_bit
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T1155]  drm_client_lib
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[ T1155]  drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_pan=
el_backlight_quirks cec xhci_pci drm_buddy xhci_hcd drm_display_helper
[ T2977]  </TASK>
[ T1155]  usbcore hid_sensor_hub drm_kms_helper psmouse nvme mfd_core hid_m=
ultitouch hid_generic serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2=
c_hid_acpi i2c_hid hid
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  i2c_piix4 i2c_smbus
[  T555] INFO: lockdep is turned off.
[ T1155]  i2c_designware_platform
[  T555] Modules linked in:
[ T1155]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[  T555]  bpf_testmod(O) ccm
[ T1155]=20
[  T555]  snd_seq_dummy
[ T1155] Preemption disabled at:
[  T555]  snd_hrtimer snd_seq_midi
[ T1155] [<ffffffffa29f1017>] preempt_schedule_irq+0x27/0x70
[  T555]  snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555]  rfcomm bnep snd_ctl_led
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  snd_hda_codec_realtek
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555]  snd_hda_codec_generic
[ T1155] Call Trace:
[  T555]  snd_hda_scodec_component
[ T1155]  <TASK>
[  T555]  snd_hda_codec_hdmi nls_ascii nls_cp437
[ T1155]  dump_stack_lvl+0x6d/0xb0
[  T555]  vfat fat snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  ? preempt_schedule_irq+0x27/0x70
[  T555]  snd_acp3x_rn btusb btrtl
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[  T555]  snd_soc_core btintel btbcm btmtk
[ T1155]  __schedule+0x167e/0x1ca0
[  T555]  bluetooth ecdh_generic ecc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_intel snd_intel_dspcfg uvcvideo
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_codec videobuf2_vmalloc videobuf2_memops
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_hwdep uvc snd_hda_core videobuf2_v4l2
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_pcm_oss videodev snd_rn_pci_acp3x
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_mixer_oss videobuf2_common snd_acp_config
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  msi_wmi snd_pcm mc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  sparse_keymap snd_soc_acpi snd_timer
[ T1155]  ? lock_release+0x21b/0x2e0
[  T555]  wmi_bmof edac_mce_amd snd k10temp snd_pci_acp3x soundcore
[ T1155]  schedule_rtlock+0x21/0x40
[  T555]  ccp battery ac button
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industrialio=
_triggered_buffer
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  kfifo_buf industrialio evdev hid_sensor_iio_common amd_pmc sch_fq=
_codel mt7921e mt7921_common mt792x_lib mt76_connac_lib
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  mt76 mac80211 libarc4 cfg80211 rfkill msr
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  nvme_fabrics fuse efi_pstore configfs
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  nfnetlink efivarfs autofs4 ext4
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  mbcache jbd2 usbhid amdgpu
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  amdxcp i2c_algo_bit drm_client_lib
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_pan=
el_backlight_quirks
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  cec xhci_pci drm_buddy xhci_hcd drm_display_helper
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  usbcore hid_sensor_hub drm_kms_helper psmouse nvme
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  mfd_core hid_multitouch hid_generic
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  serio_raw nvme_core r8169 usb_common
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  amd_sfh crc16 i2c_hid_acpi i2c_hid
[ T1155] RIP: 0033:0x7fc77f05c7f9
[  T555]  hid i2c_piix4 i2c_smbus
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[  T555]  i2c_designware_platform i2c_designware_core
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[  T555]  [last unloaded: bpf_testmod(O)]
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700b04a8 RCX: 00007fc77f05c7f9
[  T555] Preemption disabled at:
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 0000000000042448
[  T555] [<0000000000000000>] 0x0
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000085c97 R15: 000055f047b7b880
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T2977] INFO: lockdep is turned off.
[ T2977] Modules linked in: bpf_testmod(O) ccm
[ T1155]  </TASK>
[ T2977]  snd_seq_dummy snd_hrtimer snd_seq_midi
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977]  snd_seq_midi_event snd_rawmidi snd_seq
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977]  snd_seq_device
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977]  rfcomm
[  T555] Call Trace:
[ T2977]  bnep
[  T555]  <TASK>
[ T2977]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T2977]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii nls_cp437 v=
fat
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  fat snd_acp3x_pdm_dma snd_soc_dmic
[  T555]  __schedule+0x167e/0x1ca0
[ T2977]  snd_acp3x_rn btusb btrtl snd_soc_core
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  btintel btbcm btmtk
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  bluetooth ecdh_generic
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_hda_codec videobuf2_vmalloc videobuf2_memops
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_hwdep uvc snd_hda_core
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  videobuf2_v4l2 snd_pcm_oss videodev
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common
[  T555]  ? lock_release+0x21b/0x2e0
[ T2977]  snd_acp_config msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi
[  T555]  schedule_rtlock+0x21/0x40
[ T2977]  snd_timer wmi_bmof edac_mce_amd
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  snd k10temp snd_pci_acp3x soundcore
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ccp battery ac
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  button joydev hid_sensor_magn_3d
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industriali=
o evdev hid_sensor_iio_common amd_pmc
[  T555]  rt_spin_lock+0x99/0x190
[ T2977]  sch_fq_codel mt7921e mt7921_common mt792x_lib mt76_connac_lib
[  T555]  task_get_cgroup1+0xe8/0x340
[ T2977]  mt76 mac80211 libarc4 cfg80211 rfkill
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  msr
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T2977]  nvme_fabrics
[ T1155] INFO: lockdep is turned off.
[ T2977]  fuse
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155] Modules linked in:
[ T2977]  efi_pstore configfs
[ T1155]  bpf_testmod(O)
[ T2977]  nfnetlink
[ T1155]  ccm
[  T555]  bpf_trace_run2+0xd3/0x260
[ T2977]  efivarfs
[ T1155]  snd_seq_dummy
[ T2977]  autofs4
[ T1155]  snd_hrtimer
[ T1155]  snd_seq_midi
[ T2977]  ext4
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  mbcache
[ T1155]  snd_seq_midi_event
[ T2977]  jbd2
[ T1155]  snd_rawmidi snd_seq
[ T2977]  usbhid amdgpu
[ T1155]  snd_seq_device
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  amdxcp
[ T1155]  rfcomm
[ T1155]  bnep
[ T2977]  i2c_algo_bit
[ T2977]  drm_client_lib
[ T1155]  snd_ctl_led snd_hda_codec_realtek
[ T2977]  drm_ttm_helper
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T1155]  snd_hda_codec_generic
[ T2977]  ttm
[ T1155]  snd_hda_scodec_component
[ T1155]  snd_hda_codec_hdmi
[ T2977]  drm_exec gpu_sched
[ T1155]  nls_ascii
[  T555]  do_syscall_64+0x395/0xfa0
[ T2977]  drm_suballoc_helper
[ T1155]  nls_cp437
[ T2977]  drm_panel_backlight_quirks
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  cec
[ T1155]  vfat fat
[ T2977]  xhci_pci drm_buddy
[ T1155]  snd_acp3x_pdm_dma snd_soc_dmic
[ T2977]  xhci_hcd
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  drm_display_helper
[ T1155]  snd_acp3x_rn btusb
[ T2977]  usbcore
[ T1155]  btrtl
[  T555] RIP: 0033:0x7fd47309ea0e
[ T2977]  hid_sensor_hub
[ T1155]  snd_soc_core
[ T2977]  drm_kms_helper psmouse
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T1155]  btintel
[ T2977]  nvme
[ T1155]  btbcm
[ T2977]  mfd_core
[  T555] RSP: 002b:00007fff31d51840 EFLAGS: 00000297
[ T2977]  hid_multitouch
[ T1155]  btmtk
[ T2977]  hid_generic
[  T555]  ORIG_RAX: 00000000000000e4
[ T1155]  bluetooth
[ T2977]  serio_raw
[  T555] RAX: ffffffffffffffda RBX: 000055b3d5666e00 RCX: 00007fd47309ea0e
[ T1155]  ecdh_generic
[ T2977]  nvme_core
[ T1155]  ecc
[ T2977]  r8169
[  T555] RDX: 0000000000000001 RSI: 00007fff31d51860 RDI: 0000000000000000
[ T1155]  snd_hda_intel
[ T2977]  usb_common
[  T555] RBP: 00007fff31d51840 R08: 0000000000000000 R09: 00007fd473098000
[ T1155]  snd_intel_dspcfg
[ T2977]  amd_sfh
[  T555] R10: 0000000000000001 R11: 0000000000000297 R12: 00007fff31d518a0
[ T1155]  uvcvideo
[ T2977]  crc16 i2c_hid_acpi
[  T555] R13: 00007fff31d51898 R14: 0000000000000000 R15: 00007fff31d51890
[ T1155]  snd_hda_codec
[ T2977]  i2c_hid
[ T1155]  videobuf2_vmalloc videobuf2_memops
[ T2977]  hid i2c_piix4
[ T1155]  snd_hwdep uvc
[ T2977]  i2c_smbus
[ T1155]  snd_hda_core
[ T2977]  i2c_designware_platform
[ T1155]  videobuf2_v4l2
[ T2977]  i2c_designware_core
[ T1155]  snd_pcm_oss
[ T2977]  [last unloaded: bpf_testmod(O)]
[  T555]  </TASK>
[ T1155]  videodev
[ T2977]=20
[ T1155]  snd_rn_pci_acp3x
[ T2977] Preemption disabled at:
[ T1155]  snd_mixer_oss videobuf2_common snd_acp_config msi_wmi
[ T2977] [<0000000000000000>] 0x0
[ T1155]  snd_pcm mc sparse_keymap snd_soc_acpi
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155]  snd_timer wmi_bmof
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155]  edac_mce_amd
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  snd k10temp
[ T2977] Call Trace:
[ T1155]  snd_pci_acp3x
[ T2977]  <TASK>
[ T2386] BUG: scheduling while atomic: WRRende~ckend#1/2386/0x00000002
[ T1155]  soundcore ccp battery
[ T2386] INFO: lockdep is turned off.
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ac
[ T2386] Modules linked in:
[ T1155]  button
[ T2386]  bpf_testmod(O)
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  joydev
[ T2386]  ccm snd_seq_dummy
[ T1155]  hid_sensor_magn_3d
[ T2386]  snd_hrtimer
[ T1155]  hid_sensor_prox
[ T2977]  __schedule+0x167e/0x1ca0
[ T1155]  hid_sensor_accel_3d
[ T2386]  snd_seq_midi
[ T1155]  hid_sensor_gyro_3d
[ T2386]  snd_seq_midi_event
[ T1155]  hid_sensor_als
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_rawmidi
[ T1155]  hid_sensor_trigger
[ T2386]  snd_seq
[ T1155]  industrialio_triggered_buffer
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_seq_device
[ T1155]  kfifo_buf
[ T2386]  rfcomm
[ T1155]  industrialio
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2386]  bnep
[ T1155]  evdev hid_sensor_iio_common
[ T2386]  snd_ctl_led snd_hda_codec_realtek
[ T1155]  amd_pmc
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_hda_codec_generic
[ T1155]  sch_fq_codel mt7921e
[ T2386]  snd_hda_scodec_component
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  mt7921_common
[ T2386]  snd_hda_codec_hdmi
[ T1155]  mt792x_lib
[ T2386]  nls_ascii nls_cp437
[ T1155]  mt76_connac_lib
[ T2977]  ? rcu_is_watching+0x12/0x60
[ T2386]  vfat
[ T1155]  mt76
[ T2386]  fat
[ T1155]  mac80211 libarc4
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  cfg80211
[ T2977]  ? lock_release+0x21b/0x2e0
[ T2386]  snd_acp3x_rn
[ T1155]  rfkill
[ T1155]  msr
[ T2386]  btusb
[ T2386]  btrtl
[ T1155]  nvme_fabrics fuse
[ T2386]  snd_soc_core
[ T1155]  efi_pstore
[ T2977]  schedule_rtlock+0x21/0x40
[ T1155]  configfs
[ T2386]  btintel btbcm
[ T1155]  nfnetlink efivarfs
[ T2386]  btmtk
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  autofs4
[ T2386]  bluetooth
[ T1155]  ext4
[ T2386]  ecdh_generic
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  mbcache
[ T2386]  ecc
[ T1155]  jbd2
[ T2386]  snd_hda_intel
[ T2386]  snd_intel_dspcfg
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  usbhid
[ T2386]  uvcvideo
[ T1155]  amdgpu
[ T1155]  amdxcp
[ T2386]  snd_hda_codec
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  i2c_algo_bit
[ T2386]  videobuf2_vmalloc
[ T2386]  videobuf2_memops
[ T1155]  drm_client_lib
[ T1155]  drm_ttm_helper
[ T2386]  snd_hwdep
[ T1155]  ttm
[ T2386]  uvc
[ T1155]  drm_exec
[ T2386]  snd_hda_core
[ T1155]  gpu_sched
[ T2386]  videobuf2_v4l2
[ T1155]  drm_suballoc_helper
[ T2386]  snd_pcm_oss
[ T1155]  drm_panel_backlight_quirks
[ T2386]  videodev snd_rn_pci_acp3x
[ T2977]  rt_spin_lock+0x99/0x190
[ T1155]  cec xhci_pci
[ T2386]  snd_mixer_oss videobuf2_common
[ T1155]  drm_buddy xhci_hcd
[ T2386]  snd_acp_config msi_wmi
[ T2977]  task_get_cgroup1+0xe8/0x340
[ T1155]  drm_display_helper
[ T2386]  snd_pcm
[ T1155]  usbcore
[ T1155]  hid_sensor_hub
[ T2386]  mc
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[ T2386]  sparse_keymap
[ T1155]  drm_kms_helper psmouse
[ T2386]  snd_soc_acpi
[ T1155]  nvme
[ T2386]  snd_timer
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  mfd_core
[ T2386]  wmi_bmof edac_mce_amd
[ T1155]  hid_multitouch
[ T2386]  snd
[ T1155]  hid_generic
[ T2977]  bpf_trace_run2+0xd3/0x260
[ T2386]  k10temp
[ T1155]  serio_raw nvme_core
[ T2386]  snd_pci_acp3x soundcore
[ T1155]  r8169
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  ccp
[ T1155]  usb_common amd_sfh
[ T2386]  battery ac
[ T1155]  crc16 i2c_hid_acpi
[ T2386]  button joydev
[ T1155]  i2c_hid
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[ T2386]  hid_sensor_magn_3d
[ T1155]  hid i2c_piix4
[ T2386]  hid_sensor_prox
[ T1155]  i2c_smbus i2c_designware_platform
[ T2386]  hid_sensor_accel_3d
[ T2977]  syscall_trace_enter+0x1c7/0x260
[ T1155]  i2c_designware_core
[ T2386]  hid_sensor_gyro_3d hid_sensor_als
[ T1155]  [last unloaded: bpf_testmod(O)]
[ T2386]  hid_sensor_trigger
[ T1155]=20
[ T2977]  do_syscall_64+0x395/0xfa0
[ T1155] Preemption disabled at:
[ T2386]  industrialio_triggered_buffer kfifo_buf
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  industrialio
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2386]  evdev hid_sensor_iio_common amd_pmc
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2386]  sch_fq_codel mt7921e mt7921_common mt792x_lib
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2386]  mt76_connac_lib mt76
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2386]  mac80211 libarc4
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202
[ T2386]  cfg80211
[ T2977]  ORIG_RAX: 0000000000000000
[ T2386]  rfkill msr
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2386]  nvme_fabrics
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[ T2386]  fuse efi_pstore
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[ T2386]  configfs nfnetlink
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[ T2386]  efivarfs
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[ T2386]  autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bit drm_c=
lient_lib drm_ttm_helper ttm
[ T2977]  </TASK>
[ T2386]  drm_exec gpu_sched drm_suballoc_helper
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2386]  drm_panel_backlight_quirks cec
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2386]  xhci_pci
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2386]  drm_buddy
[ T1155] Call Trace:
[ T2386]  xhci_hcd drm_display_helper
[ T1155]  <TASK>
[ T2386]  usbcore hid_sensor_hub
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T2386]  drm_kms_helper psmouse nvme mfd_core
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T2386]  hid_multitouch hid_generic serio_raw
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T2386]  nvme_core r8169 usb_common amd_sfh
[ T1155]  __schedule+0x167e/0x1ca0
[ T2386]  crc16 i2c_hid_acpi i2c_hid
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2386]  hid i2c_piix4 i2c_smbus i2c_designware_platform
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2386] Preemption disabled at:
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386] [<ffffffffa29f0b46>] schedule+0x36/0x130
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in:
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  bpf_testmod(O)
[  T555]  ccm snd_seq_dummy
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_hrtimer snd_seq_midi snd_seq_midi_event
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_rawmidi snd_seq snd_seq_device
[ T1155]  ? lock_release+0x21b/0x2e0
[  T555]  rfcomm bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_gener=
ic snd_hda_scodec_component
[ T1155]  schedule_rtlock+0x21/0x40
[  T555]  snd_hda_codec_hdmi nls_ascii nls_cp437
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  vfat fat snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_acp3x_rn btusb btrtl
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  snd_soc_core btintel btbcm
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  btmtk
[  T555]  bluetooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg uvcvide=
o snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_config ms=
i_wmi
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  snd_pcm mc sparse_keymap
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  snd k10temp snd_pci_acp3x
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  soundcore ccp battery ac button joydev hid_sensor_magn_3d
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indust=
rialio evdev
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  hid_sensor_iio_common amd_pmc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  sch_fq_codel mt7921e mt7921_common mt792x_lib mt76_connac_lib
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  mt76 mac80211 libarc4
[ T1155] RIP: 0033:0x7fc77f05c7f9
[  T555]  cfg80211
[  T555]  rfkill msr
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[  T555]  nvme_fabrics
[  T555]  fuse
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[  T555]  efi_pstore
[ T1155]  ORIG_RAX: 0000000000000060
[  T555]  configfs nfnetlink
[ T1155] RAX: ffffffffffffffda RBX: 00007fc770090428 RCX: 00007fc77f05c7f9
[  T555]  efivarfs
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[  T555]  autofs4 ext4
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004244a
[  T555]  mbcache
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[  T555]  jbd2 usbhid
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000085ca7 R15: 000055f047b7b880
[  T555]  amdgpu amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_=
exec gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[ T1155]  </TASK>
[  T555]  cec xhci_pci drm_buddy
[ T2386] CPU: 8 UID: 1000 PID: 2386 Comm: WRRende~ckend#1 Tainted: G       =
 W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555]  xhci_hcd drm_display_helper usbcore
[ T2386] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  hid_sensor_hub drm_kms_helper
[ T2386] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555]  psmouse
[ T2386] Call Trace:
[  T555]  nvme
[ T2386]  <TASK>
[  T555]  mfd_core hid_multitouch hid_generic
[ T2386]  dump_stack_lvl+0x6d/0xb0
[  T555]  serio_raw nvme_core r8169 usb_common
[ T2386]  ? schedule+0x36/0x130
[  T555]  amd_sfh crc16 i2c_hid_acpi
[ T2386]  __schedule_bug.cold+0x8c/0x9a
[  T555]  i2c_hid hid i2c_piix4 i2c_smbus
[ T2386]  __schedule+0x167e/0x1ca0
[  T555]  i2c_designware_platform i2c_designware_core [last unloaded: bpf_t=
estmod(O)]
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] Preemption disabled at:
[  T555] [<0000000000000000>] 0x0
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  ? rcu_is_watching+0x12/0x60
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  ? rcu_is_watching+0x12/0x60
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155] Modules linked in: bpf_testmod(O)
[ T2386]  ? lock_release+0x21b/0x2e0
[ T1155]  ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd=
_rawmidi
[ T2386]  schedule_rtlock+0x21/0x40
[ T1155]  snd_seq snd_seq_device rfcomm bnep
[ T2386]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T2386]  ? futex_unqueue+0xa0/0x170
[ T1155]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii nls_cp437
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  vfat fat snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb btrtl =
snd_soc_core btintel btbcm
[ T2386]  rt_spin_lock+0x99/0x190
[ T1155]  btmtk bluetooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg
[ T2386]  task_get_cgroup1+0xe8/0x340
[ T1155]  uvcvideo snd_hda_codec videobuf2_vmalloc videobuf2_memops
[ T2386]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  snd_hwdep uvc snd_hda_core
[ T2386]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_acp3x
[ T2386]  bpf_trace_run2+0xd3/0x260
[ T1155]  snd_mixer_oss videobuf2_common snd_acp_config msi_wmi
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_pcm mc sparse_keymap snd_soc_acpi snd_timer wmi_bmof
[ T2386]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  edac_mce_amd snd k10temp snd_pci_acp3x
[ T2386]  syscall_trace_enter+0x1c7/0x260
[ T1155]  soundcore
[ T1155]  ccp battery ac button
[ T2386]  do_syscall_64+0x395/0xfa0
[ T1155]  joydev hid_sensor_magn_3d hid_sensor_prox
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_=
trigger
[ T2386]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  industrialio_triggered_buffer kfifo_buf industrialio evdev hid_se=
nsor_iio_common
[ T2386] RIP: 0033:0x7f1f6d7ed8c7
[ T1155]  amd_pmc sch_fq_codel mt7921e
[ T2386] Code: 73 01 c3 48 8b 0d 31 e5 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 18 00 00 00 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 01 e5 0e 00 f7 d8 64 89 01 48
[ T1155]  mt7921_common mt792x_lib
[ T2386] RSP: 002b:00007f1f3a1fa1d8 EFLAGS: 00000202
[ T1155]  mt76_connac_lib
[ T2386]  ORIG_RAX: 0000000000000018
[ T1155]  mt76
[ T2386] RAX: ffffffffffffffda RBX: 00007f1f3a1fa1e8 RCX: 00007f1f6d7ed8c7
[ T1155]  mac80211 libarc4
[ T2386] RDX: 0000000000007e88 RSI: 0000000000003f44 RDI: 00007f1f3bffa600
[ T1155]  cfg80211 rfkill
[ T2386] RBP: 0000000000000007 R08: 0000000000000007 R09: e5e5e5e5e5e5e5e5
[ T1155]  msr
[ T2386] R10: 0000000000000007 R11: 0000000000000202 R12: 00007f1f3a1fa61c
[ T1155]  nvme_fabrics fuse
[ T2386] R13: 00007f1f3a1fa380 R14: 00007f1f3a1fa2d0 R15: 00007f1f3a1fa218
[ T1155]  efi_pstore configfs nfnetlink efivarfs autofs4 ext4 mbcache jbd2 =
usbhid amdgpu amdxcp
[ T2386]  </TASK>
[ T1155]  i2c_algo_bit drm_client_lib
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155]  drm_ttm_helper ttm drm_exec
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155]  gpu_sched
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  drm_suballoc_helper
[ T2977] INFO: lockdep is turned off.
[  T555] Call Trace:
[ T1155]  drm_panel_backlight_quirks
[ T2977] Modules linked in:
[  T555]  <TASK>
[ T1155]  cec
[ T2977]  bpf_testmod(O)
[ T1155]  xhci_pci
[ T2977]  ccm
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T2977]  snd_seq_dummy
[ T1155]  drm_buddy
[ T2977]  snd_hrtimer
[ T2977]  snd_seq_midi
[ T1155]  xhci_hcd
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  drm_display_helper
[ T2977]  snd_seq_midi_event
[ T1155]  usbcore
[ T2977]  snd_rawmidi
[ T2977]  snd_seq
[ T1155]  hid_sensor_hub
[ T2977]  snd_seq_device
[  T555]  __schedule+0x167e/0x1ca0
[ T1155]  drm_kms_helper psmouse
[ T2977]  rfcomm bnep
[ T1155]  nvme
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_ctl_led
[ T1155]  mfd_core
[ T1155]  hid_multitouch
[ T2977]  snd_hda_codec_realtek
[ T2977]  snd_hda_codec_generic
[ T1155]  hid_generic serio_raw
[ T2977]  snd_hda_scodec_component
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  nvme_core
[ T2977]  snd_hda_codec_hdmi
[ T1155]  r8169 usb_common
[ T2977]  nls_ascii
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1155]  amd_sfh
[ T2977]  nls_cp437
[ T1155]  crc16 i2c_hid_acpi
[ T2977]  vfat
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  i2c_hid
[ T2977]  fat snd_acp3x_pdm_dma
[ T1155]  hid i2c_piix4
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_soc_dmic snd_acp3x_rn
[ T1155]  i2c_smbus i2c_designware_platform
[ T2977]  btusb
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2977]  btrtl
[ T1155]  i2c_designware_core
[ T2977]  snd_soc_core
[ T1155]  [last unloaded: bpf_testmod(O)]
[ T2977]  btintel
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]=20
[ T2977]  btbcm
[ T1155] Preemption disabled at:
[ T2977]  btmtk
[  T555]  ? lock_release+0x21b/0x2e0
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2977]  bluetooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg
[  T555]  schedule_rtlock+0x21/0x40
[ T2977]  uvcvideo snd_hda_codec videobuf2_vmalloc videobuf2_memops
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  snd_hwdep uvc snd_hda_core videobuf2_v4l2
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  snd_pcm_oss videodev
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_config
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  msi_wmi snd_pcm mc sparse_keymap snd_soc_acpi snd_timer wmi_bmof =
edac_mce_amd snd k10temp snd_pci_acp3x
[  T555]  rt_spin_lock+0x99/0x190
[ T2977]  soundcore ccp battery ac button joydev
[  T555]  task_get_cgroup1+0xe8/0x340
[ T2977]  hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d hid_sensor=
_gyro_3d
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  kfifo_buf industrialio evdev hid_sensor_iio_common
[  T555]  bpf_trace_run2+0xd3/0x260
[ T2977]  amd_pmc sch_fq_codel mt7921e
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cf=
g80211
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  rfkill msr nvme_fabrics fuse efi_pstore
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T2977]  configfs nfnetlink efivarfs autofs4 ext4
[  T555]  do_syscall_64+0x395/0xfa0
[ T2977]  mbcache jbd2
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  drm_ttm_helper ttm drm_exec
[  T555] RIP: 0033:0x7fd47309ea0e
[ T2977]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T2977]  cec xhci_pci
[  T555] RSP: 002b:00007fff31d516e0 EFLAGS: 00000297
[ T2977]  drm_buddy
[  T555]  ORIG_RAX: 00000000000000e4
[ T2977]  xhci_hcd
[  T555] RAX: ffffffffffffffda RBX: 000055b3d56687b0 RCX: 00007fd47309ea0e
[ T2977]  drm_display_helper usbcore
[  T555] RDX: 0000000000000080 RSI: 00007fff31d51700 RDI: 0000000000000007
[ T2977]  hid_sensor_hub
[  T555] RBP: 00007fff31d516e0 R08: 0000000000000000 R09: 00007fd473098000
[ T2977]  drm_kms_helper psmouse
[  T555] R10: ffffffffffffffff R11: 0000000000000297 R12: 0000000000000001
[ T2977]  nvme mfd_core
[  T555] R13: ffffffffffffffff R14: 0000000000000050 R15: 0000000000000007
[ T2977]  hid_multitouch hid_generic serio_raw nvme_core r8169 usb_common a=
md_sfh crc16 i2c_hid_acpi i2c_hid
[  T555]  </TASK>
[ T2977]  hid i2c_piix4 i2c_smbus
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977]  i2c_designware_platform i2c_designware_core
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977]  [last unloaded: bpf_testmod(O)]
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977]=20
[ T1155] Call Trace:
[ T2977] Preemption disabled at:
[ T1155]  <TASK>
[ T2977] [<0000000000000000>] 0x0
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc77002a378 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004244a
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000085cb0 R15: 000055f047b7b880
[ T1155]  </TASK>
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977] Call Trace:
[ T2977]  <TASK>
[ T2977]  dump_stack_lvl+0x6d/0xb0
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  __schedule+0x167e/0x1ca0
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[  T555] INFO: lockdep is turned off.
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] Modules linked in: bpf_testmod(O) ccm
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_seq_dummy snd_hrtimer snd_seq_midi
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  rfcomm bnep
[ T2977]  ? lock_release+0x21b/0x2e0
[  T555]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_s=
codec_component snd_hda_codec_hdmi nls_ascii
[ T2977]  schedule_rtlock+0x21/0x40
[  T555]  nls_cp437 vfat fat
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  btrtl snd_soc_core btintel
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  btbcm btmtk bluetooth ecdh_generic
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec videobu=
f2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core videobuf2_v4l2
[ T2977]  rt_spin_lock+0x99/0x190
[  T555]  snd_pcm_oss videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_com=
mon
[ T2977]  task_get_cgroup1+0xe8/0x340
[  T555]  snd_acp_config msi_wmi snd_pcm mc sparse_keymap
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  snd k10temp snd_pci_acp3x soundcore
[ T2977]  bpf_trace_run2+0xd3/0x260
[  T555]  ccp battery ac
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  button joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel=
_3d hid_sensor_gyro_3d
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer k=
fifo_buf industrialio
[ T2977]  syscall_trace_enter+0x1c7/0x260
[  T555]  evdev hid_sensor_iio_common amd_pmc sch_fq_codel
[ T2977]  do_syscall_64+0x395/0xfa0
[  T555]  mt7921e mt7921_common mt792x_lib
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  mt76_connac_lib mt76 mac80211 libarc4
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977] RIP: 0033:0x7fdfbd29a687
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ T2977] RSP: 002b:00007ffc24356240 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0001
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[ T2977] RDX: 000000000000004a RSI: 000055e375e787e0 RDI: 0000000000000001
[ T2977] RBP: 000055e375e787e0 R08: 0000000000000000 R09: 0000000000000000
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000004a
[  T555]  cfg80211 rfkill
[ T2977] R13: 00007fdfbd3f35c0 R14: 00007fdfbd3f0e80 R15: 00007ffc24356740
[  T555]  msr nvme_fabrics fuse efi_pstore configfs nfnetlink efivarfs auto=
fs4 ext4
[ T2977]  </TASK>
[  T555]  mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib drm=
_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_panel_backlight_=
quirks cec xhci_pci drm_buddy xhci_hcd drm_display_helper usbcore hid_senso=
r_hub drm_kms_helper psmouse nvme mfd_core hid_multitouch hid_generic serio=
_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid hid i2c_=
piix4 i2c_smbus i2c_designware_platform i2c_designware_core [last unloaded:=
 bpf_testmod(O)]
[  T555] Preemption disabled at:
[  T555] [<0000000000000000>] 0x0
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[  T555]  __schedule_bug.cold+0x8c/0x9a
[  T555]  __schedule+0x167e/0x1ca0
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155] Modules linked in: bpf_testmod(O) ccm
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_seq_dummy snd_hrtimer snd_seq_midi
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_seq_midi_event snd_rawmidi snd_seq
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_seq_device
[ T1155]  rfcomm bnep
[  T555]  ? lock_release+0x21b/0x2e0
[ T1155]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_s=
codec_component snd_hda_codec_hdmi
[  T555]  schedule_rtlock+0x21/0x40
[ T1155]  nls_ascii nls_cp437 vfat fat
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  btrtl snd_soc_core btintel
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  btbcm btmtk bluetooth
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ecdh_generic ecc snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_=
codec videobuf2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core
[  T555]  rt_spin_lock+0x99/0x190
[ T1155]  videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_acp3x snd_mixer_oss
[  T555]  task_get_cgroup1+0xe8/0x340
[ T1155]  videobuf2_common snd_acp_config msi_wmi snd_pcm mc
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  sparse_keymap snd_soc_acpi snd_timer
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  wmi_bmof
[ T1155]  edac_mce_amd snd k10temp snd_pci_acp3x
[  T555]  bpf_trace_run2+0xd3/0x260
[ T1155]  soundcore ccp battery
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ac button joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_ac=
cel_3d
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industrialio=
_triggered_buffer kfifo_buf
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T1155]  industrialio evdev hid_sensor_iio_common amd_pmc
[  T555]  do_syscall_64+0x395/0xfa0
[ T1155]  sch_fq_codel mt7921e mt7921_common
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  mt792x_lib mt76_connac_lib mt76 mac80211 libarc4
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  cfg80211 rfkill msr
[  T555] RIP: 0033:0x7fd472a989ee
[ T1155]  nvme_fabrics fuse efi_pstore
[  T555] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c =
89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2=
e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[ T1155]  configfs nfnetlink
[  T555] RSP: 002b:00007fff31d4edc8 EFLAGS: 00000246
[ T1155]  efivarfs
[  T555]  ORIG_RAX: 0000000000000000
[ T1155]  autofs4
[  T555] RAX: ffffffffffffffda RBX: 00007fd471f87980 RCX: 00007fd472a989ee
[ T1155]  ext4 mbcache
[  T555] RDX: 0000000000002000 RSI: 00007fff31d4f770 RDI: 0000000000000008
[ T1155]  jbd2
[  T555] RBP: 000055b3d5668660 R08: 0000000000000000 R09: 0000000000000000
[ T1155]  usbhid amdgpu
[  T555] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff31d517e0
[ T1155]  amdxcp
[  T555] R13: 00007fff31d4f770 R14: 0000000000000000 R15: 0000000000000000
[ T1155]  i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched=
 drm_suballoc_helper drm_panel_backlight_quirks cec xhci_pci drm_buddy
[  T555]  </TASK>
[ T1155]  xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_kms_helper=
 psmouse nvme mfd_core hid_multitouch hid_generic serio_raw nvme_core r8169=
 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_=
designware_platform i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T1155] Preemption disabled at:
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in: bpf_testmod(O)
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  ccm
[  T555]  snd_seq_dummy snd_hrtimer snd_seq_midi
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_seq_midi_event snd_rawmidi snd_seq
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_seq_device rfcomm bnep snd_ctl_led
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compon=
ent
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_codec_hdmi nls_ascii nls_cp437
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  vfat fat snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_acp3x_rn btusb
[ T1155]  ? lock_release+0x21b/0x2e0
[  T555]  btrtl snd_soc_core btintel btbcm btmtk bluetooth
[ T1155]  schedule_rtlock+0x21/0x40
[  T555]  ecdh_generic ecc snd_hda_intel snd_intel_dspcfg
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  uvcvideo snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwd=
ep
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_a=
cp3x snd_mixer_oss videobuf2_common snd_acp_config msi_wmi snd_pcm
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  mc sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  snd k10temp snd_pci_acp3x soundcore
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  ccp battery ac button
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  industrialio_triggered_buffer
[  T555]  kfifo_buf industrialio evdev hid_sensor_iio_common amd_pmc sch_fq=
_codel
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  mac80211 libarc4 cfg80211 rfkill
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  msr nvme_fabrics fuse
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  efi_pstore configfs nfnetlink efivarfs autofs4
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  ext4 mbcache jbd2 usbhid
[ T1155] RIP: 0033:0x7fc77ec77f13
[  T555]  amdgpu amdxcp i2c_algo_bit
[ T1155] Code: 81 00 00 00 b8 ca 00 00 00 0f 05 c3 66 66 2e 0f 1f 84 00 00 =
00 00 00 40 80 f6 81 45 31 d2 ba 01 00 00 00 b8 ca 00 00 00 0f 05 <c3> 66 2=
e 0f 1f 84 00 00 00 00 00 66 90 48 8b 05 61 70 15 00 48 89
[  T555]  drm_client_lib drm_ttm_helper
[ T1155] RSP: 002b:00007fc77e6b0248 EFLAGS: 00000246
[  T555]  ttm
[ T1155]  ORIG_RAX: 00000000000000ca
[  T555]  drm_exec
[ T1155] RAX: ffffffffffffffda RBX: 000055f047b76d90 RCX: 00007fc77ec77f13
[  T555]  gpu_sched
[ T1155] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 000055f047b83c70
[  T555]  drm_suballoc_helper
[ T1155] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  T555]  drm_panel_backlight_quirks cec
[ T1155] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc7700287e0
[  T555]  xhci_pci drm_buddy
[ T1155] R13: 0000000000000004 R14: 0000000000085cc7 R15: 000055f047b7b880
[  T555]  xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_kms_helper=
 psmouse nvme mfd_core hid_multitouch hid_generic
[ T1155]  </TASK>
[  T555]  serio_raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i=
2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform i2c_designware_core =
[last unloaded: bpf_testmod(O)]
[  T555] Preemption disabled at:
[  T555] [<0000000000000000>] 0x0
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[  T555]  __schedule_bug.cold+0x8c/0x9a
[  T555]  __schedule+0x167e/0x1ca0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? lock_release+0x21b/0x2e0
[  T555]  schedule_rtlock+0x21/0x40
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  rt_spin_lock+0x99/0x190
[  T555]  task_get_cgroup1+0xe8/0x340
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  bpf_trace_run2+0xd3/0x260
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  syscall_trace_enter+0x1c7/0x260
[  T555]  do_syscall_64+0x395/0xfa0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555] RIP: 0033:0x7fd47309ea0e
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[  T555] RSP: 002b:00007fff31d516e0 EFLAGS: 00000297 ORIG_RAX: 000000000000=
00e4
[  T555] RAX: ffffffffffffffda RBX: 000055b3d56687b0 RCX: 00007fd47309ea0e
[  T555] RDX: 0000000000000001 RSI: 00007fff31d51700 RDI: 0000000000000000
[  T555] RBP: 00007fff31d516e0 R08: 0000000000000000 R09: 00007fd473098000
[  T555] R10: ffffffffffffffff R11: 0000000000000297 R12: 0000000000000001
[  T555] R13: ffffffffffffffff R14: 0000000000000050 R15: 0000000000000007
[  T555]  </TASK>
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[ T1155] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer sn=
d_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bne=
p snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_co=
mponent snd_hda_codec_hdmi nls_ascii nls_cp437 vfat fat snd_acp3x_pdm_dma s=
nd_soc_dmic snd_acp3x_rn
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  btusb
[  T555] INFO: lockdep is turned off.
[ T1155]  btrtl
[  T555] Modules linked in:
[ T1155]  snd_soc_core btintel
[  T555]  bpf_testmod(O) ccm
[ T1155]  btbcm btmtk
[  T555]  snd_seq_dummy snd_hrtimer
[ T1155]  bluetooth
[  T555]  snd_seq_midi
[ T1155]  ecdh_generic ecc
[  T555]  snd_seq_midi_event snd_rawmidi
[ T1155]  snd_hda_intel snd_intel_dspcfg
[  T555]  snd_seq snd_seq_device
[ T1155]  uvcvideo snd_hda_codec
[  T555]  rfcomm bnep
[ T1155]  videobuf2_vmalloc
[  T555]  snd_ctl_led
[ T1155]  videobuf2_memops
[  T555]  snd_hda_codec_realtek
[ T1155]  snd_hwdep uvc
[  T555]  snd_hda_codec_generic snd_hda_scodec_component
[ T1155]  snd_hda_core videobuf2_v4l2
[  T555]  snd_hda_codec_hdmi nls_ascii
[ T1155]  snd_pcm_oss videodev
[  T555]  nls_cp437 vfat
[ T1155]  snd_rn_pci_acp3x snd_mixer_oss
[  T555]  fat
[ T1155]  videobuf2_common
[  T555]  snd_acp3x_pdm_dma
[ T1155]  snd_acp_config
[  T555]  snd_soc_dmic
[ T1155]  msi_wmi snd_pcm
[  T555]  snd_acp3x_rn btusb
[ T1155]  mc
[  T555]  btrtl
[ T1155]  sparse_keymap snd_soc_acpi
[  T555]  snd_soc_core btintel
[ T1155]  snd_timer wmi_bmof
[  T555]  btbcm btmtk
[ T1155]  edac_mce_amd snd
[  T555]  bluetooth
[ T1155]  k10temp
[  T555]  ecdh_generic ecc
[ T1155]  snd_pci_acp3x soundcore
[  T555]  snd_hda_intel
[ T1155]  ccp
[  T555]  snd_intel_dspcfg uvcvideo
[ T1155]  battery
[  T555]  snd_hda_codec
[ T1155]  ac
[  T555]  videobuf2_vmalloc
[ T1155]  button
[  T555]  videobuf2_memops
[ T1155]  joydev
[  T555]  snd_hwdep uvc
[ T1155]  hid_sensor_magn_3d hid_sensor_prox
[  T555]  snd_hda_core videobuf2_v4l2
[ T1155]  hid_sensor_accel_3d
[  T555]  snd_pcm_oss
[ T1155]  hid_sensor_gyro_3d
[  T555]  videodev
[ T1155]  hid_sensor_als hid_sensor_trigger
[  T555]  snd_rn_pci_acp3x snd_mixer_oss
[ T1155]  industrialio_triggered_buffer
[  T555]  videobuf2_common
[ T1155]  kfifo_buf industrialio
[  T555]  snd_acp_config msi_wmi
[ T1155]  evdev hid_sensor_iio_common
[  T555]  snd_pcm mc
[ T1155]  amd_pmc
[  T555]  sparse_keymap
[ T1155]  sch_fq_codel mt7921e
[  T555]  snd_soc_acpi snd_timer
[ T1155]  mt7921_common
[  T555]  wmi_bmof
[ T1155]  mt792x_lib mt76_connac_lib
[  T555]  edac_mce_amd snd
[ T1155]  mt76 mac80211
[  T555]  k10temp snd_pci_acp3x
[ T1155]  libarc4 cfg80211
[  T555]  soundcore ccp
[ T1155]  rfkill msr
[  T555]  battery ac
[ T1155]  nvme_fabrics fuse
[  T555]  button joydev
[ T1155]  efi_pstore configfs
[  T555]  hid_sensor_magn_3d hid_sensor_prox
[ T1155]  nfnetlink efivarfs
[  T555]  hid_sensor_accel_3d hid_sensor_gyro_3d
[ T1155]  autofs4 ext4
[  T555]  hid_sensor_als
[ T1155]  mbcache
[  T555]  hid_sensor_trigger
[ T1155]  jbd2
[  T555]  industrialio_triggered_buffer
[ T1155]  usbhid
[  T555]  kfifo_buf
[ T1155]  amdgpu
[  T555]  industrialio
[ T1155]  amdxcp
[  T555]  evdev
[ T1155]  i2c_algo_bit
[  T555]  hid_sensor_iio_common
[ T1155]  drm_client_lib
[  T555]  amd_pmc
[ T1155]  drm_ttm_helper
[  T555]  sch_fq_codel
[ T1155]  ttm
[  T555]  mt7921e
[ T1155]  drm_exec
[  T555]  mt7921_common
[ T1155]  gpu_sched drm_suballoc_helper
[  T555]  mt792x_lib mt76_connac_lib
[ T1155]  drm_panel_backlight_quirks
[  T555]  mt76
[ T1155]  cec xhci_pci
[  T555]  mac80211
[ T1155]  drm_buddy
[  T555]  libarc4 cfg80211
[ T1155]  xhci_hcd drm_display_helper
[  T555]  rfkill msr
[ T1155]  usbcore hid_sensor_hub
[  T555]  nvme_fabrics fuse
[ T1155]  drm_kms_helper psmouse
[  T555]  efi_pstore configfs
[ T1155]  nvme mfd_core
[  T555]  nfnetlink efivarfs
[ T1155]  hid_multitouch hid_generic
[  T555]  autofs4
[ T1155]  serio_raw
[  T555]  ext4
[  T555]  mbcache
[ T1155]  nvme_core r8169
[  T555]  jbd2 usbhid
[ T1155]  usb_common
[  T555]  amdgpu
[ T1155]  amd_sfh crc16
[  T555]  amdxcp i2c_algo_bit
[ T1155]  i2c_hid_acpi
[  T555]  drm_client_lib
[ T1155]  i2c_hid hid
[  T555]  drm_ttm_helper ttm
[ T1155]  i2c_piix4
[  T555]  drm_exec
[ T1155]  i2c_smbus
[  T555]  gpu_sched
[ T1155]  i2c_designware_platform i2c_designware_core
[  T555]  drm_suballoc_helper drm_panel_backlight_quirks
[ T1155]  [last unloaded: bpf_testmod(O)]
[  T555]  cec xhci_pci
[ T1155] Preemption disabled at:
[  T555]  drm_buddy
[ T1155] [<ffffffffa21386bd>] count_memcg_events+0x4d/0x280
[  T555]  xhci_hcd drm_display_helper usbcore hid_sensor_hub
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555]  drm_kms_helper
[  T555]  psmouse nvme
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  mfd_core
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555]  hid_multitouch hid_generic
[ T1155] Call Trace:
[  T555]  serio_raw
[ T1155]  <TASK>
[  T555]  nvme_core r8169 usb_common
[ T1155]  dump_stack_lvl+0x6d/0xb0
[  T555]  amd_sfh crc16 i2c_hid_acpi
[ T1155]  ? count_memcg_events+0x4d/0x280
[  T555]  i2c_hid hid i2c_piix4 i2c_smbus
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[  T555]  i2c_designware_platform i2c_designware_core [last unloaded: bpf_t=
estmod(O)]
[ T1155]  __schedule+0x167e/0x1ca0
[  T555]=20
[  T555] Preemption disabled at:
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555] [<0000000000000000>] 0x0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc77001e928 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004244c
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000085ce1 R15: 000055f047b7b880
[ T1155]  </TASK>
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[  T555]  __schedule_bug.cold+0x8c/0x9a
[  T555]  __schedule+0x167e/0x1ca0
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? lock_release+0x21b/0x2e0
[  T555]  schedule_rtlock+0x21/0x40
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  rt_spin_lock+0x99/0x190
[  T555]  task_get_cgroup1+0xe8/0x340
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[ T1155] Modules linked in:
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_testmod(O) ccm snd_seq_dummy
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi
[  T555]  bpf_trace_run2+0xd3/0x260
[ T1155]  snd_seq snd_seq_device rfcomm
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  bnep
[ T1155]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_s=
codec_component snd_hda_codec_hdmi nls_ascii
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  nls_cp437 vfat fat snd_acp3x_pdm_dma
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T1155]  snd_soc_dmic snd_acp3x_rn btusb btrtl snd_soc_core
[  T555]  do_syscall_64+0x395/0xfa0
[ T1155]  btintel btbcm btmtk
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  bluetooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  uvcvideo snd_hda_codec videobuf2_vmalloc
[  T555] RIP: 0033:0x7fd472a989ee
[ T1155]  videobuf2_memops snd_hwdep uvc
[  T555] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c =
89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2=
e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[ T1155]  snd_hda_core
[  T555] RSP: 002b:00007fff31d4edc8 EFLAGS: 00000246
[ T1155]  videobuf2_v4l2
[ T1155]  snd_pcm_oss
[  T555]  ORIG_RAX: 0000000000000000
[ T1155]  videodev
[  T555] RAX: ffffffffffffffda RBX: 00007fd471f87980 RCX: 00007fd472a989ee
[ T1155]  snd_rn_pci_acp3x snd_mixer_oss
[  T555] RDX: 0000000000002000 RSI: 00007fff31d4f770 RDI: 0000000000000008
[ T1155]  videobuf2_common
[  T555] RBP: 000055b3d5668660 R08: 0000000000000000 R09: 0000000000000000
[ T1155]  snd_acp_config msi_wmi
[  T555] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff31d517e0
[ T1155]  snd_pcm mc
[  T555] R13: 00007fff31d4f770 R14: 0000000000000000 R15: 0000000000000000
[ T1155]  sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd snd k1=
0temp snd_pci_acp3x soundcore ccp
[  T555]  </TASK>
[ T1155]  battery ac button joydev hid_sensor_magn_3d hid_sensor_prox hid_s=
ensor_accel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industr=
ialio_triggered_buffer kfifo_buf industrialio evdev hid_sensor_iio_common a=
md_pmc sch_fq_codel mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76 m=
ac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore configfs n=
fnetlink efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  amdxcp
[  T555] INFO: lockdep is turned off.
[ T1155]  i2c_algo_bit
[  T555] Modules linked in:
[ T1155]  drm_client_lib
[  T555]  bpf_testmod(O)
[ T1155]  drm_ttm_helper
[  T555]  ccm
[ T1155]  ttm drm_exec
[  T555]  snd_seq_dummy
[ T1155]  gpu_sched
[  T555]  snd_hrtimer
[ T1155]  drm_suballoc_helper
[  T555]  snd_seq_midi
[ T1155]  drm_panel_backlight_quirks
[  T555]  snd_seq_midi_event
[ T1155]  cec
[  T555]  snd_rawmidi
[ T1155]  xhci_pci
[  T555]  snd_seq snd_seq_device
[ T1155]  drm_buddy
[  T555]  rfcomm
[ T1155]  xhci_hcd
[  T555]  bnep
[ T1155]  drm_display_helper usbcore
[  T555]  snd_ctl_led snd_hda_codec_realtek
[ T1155]  hid_sensor_hub drm_kms_helper
[  T555]  snd_hda_codec_generic snd_hda_scodec_component
[ T1155]  psmouse nvme
[  T555]  snd_hda_codec_hdmi nls_ascii
[ T1155]  mfd_core hid_multitouch
[  T555]  nls_cp437 vfat
[ T1155]  hid_generic serio_raw
[  T555]  fat snd_acp3x_pdm_dma
[ T1155]  nvme_core
[  T555]  snd_soc_dmic
[ T1155]  r8169
[ T1155]  usb_common
[  T555]  snd_acp3x_rn btusb
[ T1155]  amd_sfh crc16
[  T555]  btrtl snd_soc_core
[ T1155]  i2c_hid_acpi i2c_hid
[  T555]  btintel btbcm
[ T1155]  hid i2c_piix4
[  T555]  btmtk bluetooth
[ T1155]  i2c_smbus i2c_designware_platform
[  T555]  ecdh_generic ecc
[ T1155]  i2c_designware_core
[  T555]  snd_hda_intel
[ T1155]  [last unloaded: bpf_testmod(O)]
[  T555]  snd_intel_dspcfg uvcvideo
[ T1155] Preemption disabled at:
[  T555]  snd_hda_codec
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[  T555]  videobuf2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555]  videobuf2_v4l2 snd_pcm_oss
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555]  videodev
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555]  snd_rn_pci_acp3x
[ T1155] Call Trace:
[  T555]  snd_mixer_oss videobuf2_common
[ T1155]  <TASK>
[  T555]  snd_acp_config msi_wmi
[ T1155]  dump_stack_lvl+0x6d/0xb0
[  T555]  snd_pcm mc sparse_keymap snd_soc_acpi
[ T1155]  ? futex_private_hash_put+0x32/0x100
[  T555]  snd_timer wmi_bmof edac_mce_amd snd
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[  T555]  k10temp snd_pci_acp3x soundcore
[ T1155]  __schedule+0x167e/0x1ca0
[  T555]  ccp battery ac button
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  industrialio_triggered_buffer kfifo_buf industrialio evdev
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  hid_sensor_iio_common amd_pmc sch_fq_codel
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  mt7921e mt7921_common mt792x_lib
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  mt76_connac_lib mt76 mac80211
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  libarc4
[  T555]  cfg80211 rfkill
[ T1155]  ? lock_release+0x21b/0x2e0
[  T555]  msr nvme_fabrics fuse efi_pstore configfs nfnetlink
[ T1155]  schedule_rtlock+0x21/0x40
[  T555]  efivarfs autofs4 ext4 mbcache
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  jbd2 usbhid amdgpu amdxcp
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  i2c_algo_bit drm_client_lib
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  drm_ttm_helper
[  T555]  ttm drm_exec gpu_sched
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  drm_suballoc_helper drm_panel_backlight_quirks cec xhci_pci drm_b=
uddy xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_kms_helper psmo=
use
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  nvme mfd_core hid_multitouch hid_generic serio_raw
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  nvme_core r8169 usb_common amd_sfh crc16
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  i2c_hid_acpi i2c_hid hid
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  i2c_piix4
[  T555]  i2c_smbus i2c_designware_platform i2c_designware_core
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  [last unloaded: bpf_testmod(O)]
[  T555] Preemption disabled at:
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] [<0000000000000000>] 0x0
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700b07a8 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004244c
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000085ced R15: 000055f047b7b880
[ T1155]  </TASK>
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[  T555]  __schedule_bug.cold+0x8c/0x9a
[  T555]  __schedule+0x167e/0x1ca0
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[  T555]  ? rcu_is_watching+0x12/0x60
[ T1155] Modules linked in: bpf_testmod(O) ccm
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_seq_dummy snd_hrtimer snd_seq_midi
[  T555]  ? lock_release+0x21b/0x2e0
[ T1155]  snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm
[  T555]  schedule_rtlock+0x21/0x40
[ T1155]  bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  nls_cp437 vfat fat
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  btrtl snd_soc_core btintel btbcm btmtk bluetooth ecdh_generic ecc=
 snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec
[  T555]  rt_spin_lock+0x99/0x190
[ T1155]  videobuf2_vmalloc videobuf2_memops snd_hwdep uvc snd_hda_core
[  T555]  task_get_cgroup1+0xe8/0x340
[ T1155]  videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_acp3x
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  snd_mixer_oss videobuf2_common snd_acp_config msi_wmi
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  snd_pcm mc sparse_keymap snd_soc_acpi
[  T555]  bpf_trace_run2+0xd3/0x260
[ T1155]  snd_timer wmi_bmof edac_mce_amd
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd
[ T1155]  k10temp snd_pci_acp3x soundcore ccp battery ac
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  button joydev hid_sensor_magn_3d hid_sensor_prox
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T1155]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_=
trigger industrialio_triggered_buffer
[  T555]  do_syscall_64+0x395/0xfa0
[ T1155]  kfifo_buf industrialio
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  evdev hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  mt7921_common mt792x_lib mt76_connac_lib mt76
[  T555] RIP: 0033:0x7fd472b0fad7
[ T1155]  mac80211 libarc4
[  T555] Code: 73 01 c3 48 8b 0d 21 53 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 ba 00 00 00 0f 05 <c3> 0f 1=
f 84 00 00 00 00 00 b8 ea 00 00 00 0f 05 48 3d 01 f0 ff ff
[ T1155]  cfg80211 rfkill
[  T555] RSP: 002b:00007fff31d51828 EFLAGS: 00000202
[ T1155]  msr
[  T555]  ORIG_RAX: 00000000000000ba
[ T1155]  nvme_fabrics
[  T555] RAX: ffffffffffffffda RBX: 000000000000022b RCX: 00007fd472b0fad7
[ T1155]  fuse
[  T555] RDX: 00000000ffffffff RSI: 00007fd472ecafd0 RDI: 00007fd473095cc8
[  T555] RBP: 000055b3d5668660 R08: 0000000000000000 R09: 000055b3d5667488
[  T555] R10: 00007fff31d518a0 R11: 0000000000000202 R12: 000055b3d5668660
[  T555] R13: ffffffffffffffff R14: 0000000000000000 R15: 00007fff31d51890
[ T1155]  efi_pstore configfs nfnetlink efivarfs autofs4 ext4 mbcache
[  T555]  </TASK>
[ T1155]  jbd2 usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib drm_ttm_hel=
per ttm drm_exec gpu_sched drm_suballoc_helper drm_panel_backlight_quirks c=
ec xhci_pci drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor_hub dr=
m_kms_helper psmouse nvme mfd_core hid_multitouch hid_generic serio_raw nvm=
e_core r8169
[ T2977] BUG: scheduling while atomic: dmesg/2977/0x00000002
[ T1155]  usb_common amd_sfh
[ T2977] INFO: lockdep is turned off.
[ T1155]  crc16
[ T2977] Modules linked in:
[ T1155]  i2c_hid_acpi
[ T2977]  bpf_testmod(O)
[ T1155]  i2c_hid
[ T2977]  ccm snd_seq_dummy
[ T1155]  hid i2c_piix4
[ T2977]  snd_hrtimer snd_seq_midi
[ T1155]  i2c_smbus i2c_designware_platform
[ T2977]  snd_seq_midi_event snd_rawmidi
[ T1155]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T2977]  snd_seq snd_seq_device
[ T1155]=20
[ T2977]  rfcomm
[ T1155] Preemption disabled at:
[ T2977]  bnep
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2977]  snd_ctl_led
[ T2977]  snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compon=
ent
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977]  snd_hda_codec_hdmi nls_ascii nls_cp437
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977]  vfat
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977]  fat snd_acp3x_pdm_dma
[ T1155] Call Trace:
[ T2977]  snd_soc_dmic
[ T1155]  <TASK>
[ T2977]  snd_acp3x_rn btusb btrtl
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T2977]  snd_soc_core btintel btbcm
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T2977]  btmtk bluetooth ecdh_generic ecc
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T2977]  snd_hda_intel snd_intel_dspcfg uvcvideo
[ T1155]  __schedule+0x167e/0x1ca0
[ T2977]  snd_hda_codec videobuf2_vmalloc videobuf2_memops
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_hwdep uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  videodev snd_rn_pci_acp3x
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  snd_mixer_oss videobuf2_common snd_acp_config
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  msi_wmi
[ T2977]  snd_pcm mc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  sparse_keymap snd_soc_acpi snd_timer
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T2977]  wmi_bmof edac_mce_amd snd
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  k10temp snd_pci_acp3x soundcore
[ T1155]  ? lock_release+0x21b/0x2e0
[ T2977]  ccp battery ac button joydev hid_sensor_magn_3d
[ T1155]  schedule_rtlock+0x21/0x40
[ T2977]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T2977]  hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  kfifo_buf
[ T2977]  industrialio evdev
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2977]  hid_sensor_iio_common amd_pmc sch_fq_codel mt7921e
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cf=
g80211 rfkill msr nvme_fabrics fuse
[ T1155]  rt_spin_lock+0x99/0x190
[ T2977]  efi_pstore configfs nfnetlink efivarfs autofs4
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T2977]  ext4 mbcache jbd2 usbhid
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T2977]  amdgpu amdxcp i2c_algo_bit drm_client_lib
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2977]  drm_ttm_helper ttm drm_exec gpu_sched
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T2977]  drm_suballoc_helper drm_panel_backlight_quirks cec
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  xhci_pci drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor=
_hub drm_kms_helper
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T2977]  psmouse nvme mfd_core hid_multitouch
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T2977]  hid_generic serio_raw nvme_core r8169 usb_common
[ T1155]  do_syscall_64+0x395/0xfa0
[ T2977]  amd_sfh crc16 i2c_hid_acpi
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2977]  i2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2977]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T2977] Preemption disabled at:
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T2977] [<0000000000000000>] 0x0
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc770005978 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004244c
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000085cf5 R15: 000055f047b7b880
[ T1155]  </TASK>
[ T2977] CPU: 11 UID: 1000 PID: 2977 Comm: dmesg Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2977] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2977] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2977] Call Trace:
[ T2977]  <TASK>
[ T2977]  dump_stack_lvl+0x6d/0xb0
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T2977]  __schedule_bug.cold+0x8c/0x9a
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in: bpf_testmod(O)
[ T2977]  __schedule+0x167e/0x1ca0
[  T555]  ccm snd_seq_dummy snd_hrtimer
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_seq_midi
[  T555]  snd_seq_midi_event snd_rawmidi
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_seq snd_seq_device rfcomm
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  nls_cp437 vfat fat
[ T2977]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  btusb btrtl
[ T2977]  ? lock_release+0x21b/0x2e0
[  T555]  snd_soc_core btintel btbcm btmtk bluetooth ecdh_generic
[ T2977]  schedule_rtlock+0x21/0x40
[  T555]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo
[ T2977]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  uvc snd_hda_core
[ T2977]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  videobuf2_v4l2 snd_pcm_oss videodev snd_rn_pci_acp3x
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_mixer_oss videobuf2_common snd_acp_config msi_wmi snd_pcm mc =
sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T2977]  rt_spin_lock+0x99/0x190
[  T555]  snd k10temp snd_pci_acp3x soundcore ccp battery
[ T2977]  task_get_cgroup1+0xe8/0x340
[  T555]  ac button joydev hid_sensor_magn_3d
[ T2977]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als
[ T2977]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indust=
rialio
[ T2977]  bpf_trace_run2+0xd3/0x260
[  T555]  evdev hid_sensor_iio_common amd_pmc
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  sch_fq_codel mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76
[ T2977]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  mac80211 libarc4 cfg80211 rfkill msr
[ T2977]  syscall_trace_enter+0x1c7/0x260
[  T555]  nvme_fabrics fuse efi_pstore configfs
[ T2977]  do_syscall_64+0x395/0xfa0
[  T555]  nfnetlink efivarfs autofs4
[ T2977]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ext4 mbcache jbd2 usbhid amdgpu
[ T2977]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper
[ T2977] RIP: 0033:0x7fdfbd29a687
[  T555]  ttm drm_exec
[ T2977] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0=
f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  T555]  gpu_sched drm_suballoc_helper
[ T2977] RSP: 002b:00007ffc24356670 EFLAGS: 00000202
[  T555]  drm_panel_backlight_quirks
[ T2977]  ORIG_RAX: 0000000000000000
[  T555]  cec
[  T555]  xhci_pci
[ T2977] RAX: ffffffffffffffda RBX: 00007fdfbd208740 RCX: 00007fdfbd29a687
[  T555]  drm_buddy
[ T2977] RDX: 00000000000007ff RSI: 000055e34b7d80a8 RDI: 0000000000000003
[  T555]  xhci_hcd drm_display_helper
[ T2977] RBP: 000055e34b7d80a8 R08: 0000000000000000 R09: 0000000000000000
[  T555]  usbcore
[ T2977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc243568e8
[  T555]  hid_sensor_hub drm_kms_helper
[ T2977] R13: 000055e34b7d2b80 R14: 000055e34b7d6ea0 R15: ffffffffffffffff
[  T555]  psmouse nvme mfd_core hid_multitouch hid_generic serio_raw nvme_c=
ore r8169 usb_common amd_sfh
[ T2977]  </TASK>
[  T555]  crc16 i2c_hid_acpi i2c_hid hid i2c_piix4 i2c_smbus i2c_designware=
_platform i2c_designware_core [last unloaded: bpf_testmod(O)]
[  T555] Preemption disabled at:
[  T555] [<0000000000000000>] 0x0
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[  T555]  __schedule_bug.cold+0x8c/0x9a
[  T555]  __schedule+0x167e/0x1ca0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? lock_release+0x21b/0x2e0
[  T555]  schedule_rtlock+0x21/0x40
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  rt_spin_lock+0x99/0x190
[  T555]  task_get_cgroup1+0xe8/0x340
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  bpf_trace_run2+0xd3/0x260
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  syscall_trace_enter+0x1c7/0x260
[  T555]  do_syscall_64+0x395/0xfa0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555] RIP: 0033:0x7fd47309ea0e
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[  T555] RSP: 002b:00007fff31d516e0 EFLAGS: 00000297 ORIG_RAX: 000000000000=
00e4
[  T555] RAX: ffffffffffffffda RBX: 000055b3d56687b0 RCX: 00007fd47309ea0e
[  T555] RDX: 0000000000000001 RSI: 00007fff31d51700 RDI: 0000000000000000
[  T555] RBP: 00007fff31d516e0 R08: 0000000000000000 R09: 00007fd473098000
[  T555] R10: ffffffffffffffff R11: 0000000000000297 R12: 0000000000000001
[  T555] R13: ffffffffffffffff R14: 0000000000000050 R15: 0000000000000007
[  T555]  </TASK>
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[ T1155] Modules linked in: bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer sn=
d_seq_midi snd_seq_midi_event snd_rawmidi
[ T2247] BUG: scheduling while atomic: Compositor/2247/0x00000002
[ T1155]  snd_seq snd_seq_device rfcomm
[ T2247] INFO: lockdep is turned off.
[ T1155]  bnep
[ T2247] Modules linked in:
[ T1155]  snd_ctl_led snd_hda_codec_realtek
[ T2247]  bpf_testmod(O)
[ T1155]  snd_hda_codec_generic
[ T2247]  ccm snd_seq_dummy
[ T1155]  snd_hda_scodec_component snd_hda_codec_hdmi
[ T2247]  snd_hrtimer
[ T1155]  nls_ascii
[ T2247]  snd_seq_midi
[ T1155]  nls_cp437 vfat
[ T2247]  snd_seq_midi_event
[ T1155]  fat snd_acp3x_pdm_dma
[ T2247]  snd_rawmidi
[ T1155]  snd_soc_dmic
[ T2247]  snd_seq
[ T1155]  snd_acp3x_rn
[ T2247]  snd_seq_device
[ T1155]  btusb
[ T2247]  rfcomm
[ T1155]  btrtl
[ T2247]  bnep
[ T1155]  snd_soc_core
[ T2247]  snd_ctl_led
[ T1155]  btintel
[ T2247]  snd_hda_codec_realtek
[ T1155]  btbcm
[ T2247]  snd_hda_codec_generic
[ T1155]  btmtk
[ T2247]  snd_hda_scodec_component
[ T1155]  bluetooth
[ T2247]  snd_hda_codec_hdmi
[ T1155]  ecdh_generic
[ T2247]  nls_ascii
[ T1155]  ecc
[ T2247]  nls_cp437 vfat
[ T1155]  snd_hda_intel snd_intel_dspcfg
[ T2247]  fat
[ T1155]  uvcvideo
[ T2247]  snd_acp3x_pdm_dma
[ T1155]  snd_hda_codec
[ T2247]  snd_soc_dmic
[ T1155]  videobuf2_vmalloc
[ T2247]  snd_acp3x_rn btusb
[ T1155]  videobuf2_memops snd_hwdep
[ T2247]  btrtl
[ T1155]  uvc
[ T2247]  snd_soc_core
[ T1155]  snd_hda_core
[ T2247]  btintel
[ T1155]  videobuf2_v4l2
[ T2247]  btbcm
[ T1155]  snd_pcm_oss videodev
[ T2247]  btmtk
[ T1155]  snd_rn_pci_acp3x
[ T2247]  bluetooth
[ T1155]  snd_mixer_oss videobuf2_common
[ T2247]  ecdh_generic
[ T1155]  snd_acp_config
[ T2247]  ecc
[ T1155]  msi_wmi snd_pcm
[ T2247]  snd_hda_intel
[ T1155]  mc
[ T2247]  snd_intel_dspcfg
[ T1155]  sparse_keymap
[ T2247]  uvcvideo
[ T1155]  snd_soc_acpi
[ T2247]  snd_hda_codec
[ T1155]  snd_timer
[ T2247]  videobuf2_vmalloc
[ T1155]  wmi_bmof
[ T2247]  videobuf2_memops
[ T1155]  edac_mce_amd snd
[ T2247]  snd_hwdep
[ T1155]  k10temp
[ T2247]  uvc
[ T1155]  snd_pci_acp3x
[ T2247]  snd_hda_core
[ T1155]  soundcore
[ T2247]  videobuf2_v4l2
[ T1155]  ccp
[ T2247]  snd_pcm_oss
[ T1155]  battery
[ T2247]  videodev
[ T1155]  ac
[ T2247]  snd_rn_pci_acp3x
[ T1155]  button
[ T2247]  snd_mixer_oss
[ T1155]  joydev
[ T2247]  videobuf2_common
[ T1155]  hid_sensor_magn_3d
[ T2247]  snd_acp_config
[ T1155]  hid_sensor_prox
[ T2247]  msi_wmi
[ T1155]  hid_sensor_accel_3d
[ T2247]  snd_pcm mc
[ T1155]  hid_sensor_gyro_3d hid_sensor_als
[ T2247]  sparse_keymap
[ T1155]  hid_sensor_trigger
[ T2247]  snd_soc_acpi
[ T1155]  industrialio_triggered_buffer
[ T2247]  snd_timer wmi_bmof
[ T1155]  kfifo_buf industrialio
[ T2247]  edac_mce_amd
[ T1155]  evdev
[ T2247]  snd
[ T1155]  hid_sensor_iio_common amd_pmc
[ T2247]  k10temp
[ T1155]  sch_fq_codel
[ T2247]  snd_pci_acp3x
[ T1155]  mt7921e
[ T2247]  soundcore
[ T1155]  mt7921_common
[ T2247]  ccp
[ T1155]  mt792x_lib
[ T2247]  battery
[ T1155]  mt76_connac_lib
[ T2247]  ac button
[ T1155]  mt76 mac80211
[ T2247]  joydev
[ T1155]  libarc4
[ T2247]  hid_sensor_magn_3d
[ T1155]  cfg80211 rfkill
[ T2247]  hid_sensor_prox
[ T1155]  msr nvme_fabrics
[ T2247]  hid_sensor_accel_3d
[ T1155]  fuse
[ T2247]  hid_sensor_gyro_3d
[ T1155]  efi_pstore
[ T2247]  hid_sensor_als
[ T1155]  configfs
[ T2247]  hid_sensor_trigger
[ T1155]  nfnetlink
[ T2247]  industrialio_triggered_buffer
[ T1155]  efivarfs
[ T2247]  kfifo_buf
[ T1155]  autofs4
[ T2247]  industrialio
[ T1155]  ext4
[ T2247]  evdev
[ T1155]  mbcache
[ T2247]  hid_sensor_iio_common
[ T1155]  jbd2
[ T2247]  amd_pmc
[ T1155]  usbhid
[ T2247]  sch_fq_codel
[ T1155]  amdgpu
[ T2247]  mt7921e
[ T1155]  amdxcp
[ T2247]  mt7921_common
[ T1155]  i2c_algo_bit
[ T2247]  mt792x_lib
[ T1155]  drm_client_lib
[ T2247]  mt76_connac_lib
[ T1155]  drm_ttm_helper
[ T2247]  mt76
[ T1155]  ttm
[ T2247]  mac80211
[ T1155]  drm_exec
[ T2247]  libarc4
[ T1155]  gpu_sched
[ T2247]  cfg80211
[ T1155]  drm_suballoc_helper
[ T2247]  rfkill
[ T1155]  drm_panel_backlight_quirks
[ T2247]  msr
[ T1155]  cec
[ T2247]  nvme_fabrics
[ T1155]  xhci_pci
[ T2247]  fuse
[ T1155]  drm_buddy
[ T2247]  efi_pstore
[ T1155]  xhci_hcd
[ T2247]  configfs
[ T1155]  drm_display_helper
[ T2247]  nfnetlink
[ T1155]  usbcore
[ T2247]  efivarfs
[ T1155]  hid_sensor_hub
[ T2247]  autofs4
[ T1155]  drm_kms_helper
[ T2247]  ext4
[ T1155]  psmouse
[ T2247]  mbcache
[ T1155]  nvme
[ T2247]  jbd2
[ T1155]  mfd_core
[ T2247]  usbhid
[ T1155]  hid_multitouch
[ T2247]  amdgpu
[ T1155]  hid_generic
[ T2247]  amdxcp
[ T1155]  serio_raw
[ T2247]  i2c_algo_bit
[ T1155]  nvme_core
[ T2247]  drm_client_lib
[ T1155]  r8169
[ T2247]  drm_ttm_helper
[ T1155]  usb_common
[ T2247]  ttm
[ T1155]  amd_sfh
[ T2247]  drm_exec gpu_sched
[ T1155]  crc16 i2c_hid_acpi
[ T2247]  drm_suballoc_helper
[ T1155]  i2c_hid
[ T2247]  drm_panel_backlight_quirks
[ T1155]  hid i2c_piix4
[ T2247]  cec
[ T1155]  i2c_smbus
[ T2247]  xhci_pci
[ T1155]  i2c_designware_platform
[ T2247]  drm_buddy
[ T1155]  i2c_designware_core
[ T2247]  xhci_hcd drm_display_helper
[ T1155]  [last unloaded: bpf_testmod(O)]
[ T2247]  usbcore
[ T1155] Preemption disabled at:
[ T2247]  hid_sensor_hub drm_kms_helper
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2247]  psmouse nvme mfd_core hid_multitouch
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2247]  hid_generic serio_raw nvme_core
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2247]  r8169
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T2247]  usb_common amd_sfh
[ T1155]  <TASK>
[ T2247]  crc16 i2c_hid_acpi
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T2247]  i2c_hid hid i2c_piix4
[ T1155]  ? futex_private_hash_put+0x32/0x100
[ T2247]  i2c_smbus i2c_designware_platform i2c_designware_core
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T2247]  [last unloaded: bpf_testmod(O)]
[ T2247] Preemption disabled at:
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2247] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? lock_release+0x21b/0x2e0
[ T1155]  schedule_rtlock+0x21/0x40
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  ? rt_mutex_slowunlock+0x3ee/0x490
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rt_spin_lock+0x99/0x190
[ T1155]  task_get_cgroup1+0xe8/0x340
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  bpf_trace_run2+0xd3/0x260
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  syscall_trace_enter+0x1c7/0x260
[ T1155]  do_syscall_64+0x395/0xfa0
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] RIP: 0033:0x7fc77f05c7f9
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297 ORIG_RAX: 000000000000=
0060
[ T1155] RAX: ffffffffffffffda RBX: 00007fc770004fa8 RCX: 00007fc77f05c7f9
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 0000000000042458
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000086fb2 R15: 000055f047b7b880
[ T1155]  </TASK>
[ T2247] CPU: 8 UID: 1000 PID: 2247 Comm: Compositor Tainted: G        W  O=
        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2247] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2247] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2247] Call Trace:
[ T2247]  <TASK>
[ T2247]  dump_stack_lvl+0x6d/0xb0
[ T2247]  ? futex_private_hash_put+0x32/0x100
[ T2247]  __schedule_bug.cold+0x8c/0x9a
[ T2247]  __schedule+0x167e/0x1ca0
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[ T1155] Modules linked in:
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  bpf_testmod(O) ccm snd_seq_dummy snd_hrtimer
[ T2247]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  rfcomm bnep snd_ctl_led
[ T2247]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_hda_codec_realtek
[ T1155]  snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  nls_ascii
[ T1155]  nls_cp437 vfat fat snd_acp3x_pdm_dma
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd_soc_dmic snd_acp3x_rn btusb btrtl
[ T2247]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_soc_core btintel btbcm btmtk
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  bluetooth ecdh_generic ecc
[ T2247]  ? lock_release+0x21b/0x2e0
[ T1155]  snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec videobuf2_v=
malloc videobuf2_memops snd_hwdep
[ T2247]  schedule_rtlock+0x21/0x40
[ T1155]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss
[ T2247]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_=
config
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  msi_wmi snd_pcm mc
[ T2247]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T1155]  sparse_keymap
[ T1155]  snd_soc_acpi snd_timer wmi_bmof edac_mce_amd
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  snd k10temp snd_pci_acp3x soundcore ccp battery ac button joydev =
hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d h=
id_sensor_als
[ T2247]  rt_spin_lock+0x99/0x190
[ T1155]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indust=
rialio evdev hid_sensor_iio_common
[ T2247]  task_get_cgroup1+0xe8/0x340
[ T1155]  amd_pmc sch_fq_codel mt7921e mt7921_common mt792x_lib mt76_connac=
_lib
[ T2247]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  mt76 mac80211 libarc4 cfg80211 rfkill
[ T2247]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  msr nvme_fabrics fuse efi_pstore configfs
[ T2247]  bpf_trace_run2+0xd3/0x260
[ T1155]  nfnetlink efivarfs autofs4 ext4 mbcache
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  jbd2 usbhid amdgpu amdxcp i2c_algo_bit drm_client_lib drm_ttm_hel=
per ttm
[ T2247]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  drm_exec gpu_sched drm_suballoc_helper drm_panel_backlight_quirks=
 cec
[ T2247]  syscall_trace_enter+0x1c7/0x260
[ T1155]  xhci_pci drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor=
_hub
[ T2247]  do_syscall_64+0x395/0xfa0
[ T1155]  drm_kms_helper psmouse nvme mfd_core
[ T2247]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  hid_multitouch hid_generic serio_raw nvme_core r8169 usb_common
[ T2247]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155]  amd_sfh crc16 i2c_hid_acpi i2c_hid hid i2c_piix4
[ T2247] RIP: 0033:0x7f1f6dca8a0e
[ T1155]  i2c_smbus i2c_designware_platform i2c_designware_core
[ T2247] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T1155]  [last unloaded: bpf_testmod(O)]
[ T2247] RSP: 002b:00007f1f533bb810 EFLAGS: 00000297
[ T1155]=20
[ T1155] Preemption disabled at:
[ T2247]  ORIG_RAX: 00000000000000e4
[ T1155] [<ffffffffa1ead6a2>] futex_private_hash_put+0x32/0x100
[ T2247] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1f6dca8a0e
[ T2247] RDX: 0000000000000002 RSI: 00007f1f533bb830 RDI: 0000000000000001
[ T2247] RBP: 00007f1f533bb810 R08: 0000000000000000 R09: 00007f1f6dca2000
[ T2247] R10: 0000000000000000 R11: 0000000000000297 R12: 0000002385309ebb
[ T2247] R13: 00000000ffffffff R14: 00007f1f3bce4eb0 R15: 0000000000000000
[ T2247]  </TASK>
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155] Call Trace:
[ T1155]  <TASK>
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in:
[ T1155]  dump_stack_lvl+0x6d/0xb0
[  T555]  bpf_testmod(O) ccm snd_seq_dummy
[ T1155]  ? futex_private_hash_put+0x32/0x100
[  T555]  snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[  T555]  snd_seq snd_seq_device rfcomm bnep
[ T1155]  __schedule+0x167e/0x1ca0
[  T555]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_hda_scodec_component snd_hda_codec_hdmi nls_ascii nls_cp437 v=
fat
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  fat snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_acp3x_rn btusb btrtl
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_soc_core btintel btbcm
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  btmtk bluetooth ecdh_generic
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  ecc snd_hda_intel snd_intel_dspcfg uvcvideo
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_hda_codec videobuf2_vmalloc
[ T1155]  ? lock_release+0x21b/0x2e0
[  T555]  videobuf2_memops snd_hwdep uvc snd_hda_core videobuf2_v4l2 snd_pc=
m_oss
[ T1155]  schedule_rtlock+0x21/0x40
[  T555]  videodev snd_rn_pci_acp3x snd_mixer_oss videobuf2_common
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  snd_acp_config msi_wmi snd_pcm
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  mc sparse_keymap snd_soc_acpi
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  snd_timer wmi_bmof edac_mce_amd snd
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  k10temp snd_pci_acp3x soundcore ccp battery ac button joydev hid_=
sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger industrialio=
_triggered_buffer kfifo_buf
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  industrialio evdev hid_sensor_iio_common amd_pmc sch_fq_codel
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  mt7921e mt7921_common mt792x_lib
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  mt76_connac_lib mt76 mac80211 libarc4
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  cfg80211 rfkill msr nvme_fabrics
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  fuse efi_pstore configfs nfnetlink efivarfs autofs4
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  ext4 mbcache jbd2 usbhid amdgpu
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  drm_exec gpu_sched
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  drm_suballoc_helper drm_panel_backlight_quirks cec xhci_pci drm_b=
uddy
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  xhci_hcd drm_display_helper usbcore hid_sensor_hub
[ T1155] RIP: 0033:0x7fc77f05c7f9
[  T555]  drm_kms_helper psmouse nvme
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[  T555]  mfd_core
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[  T555]  hid_multitouch hid_generic
[ T1155]  ORIG_RAX: 0000000000000060
[  T555]  serio_raw
[ T1155] RAX: ffffffffffffffda RBX: 00007fc770000fe8 RCX: 00007fc77f05c7f9
[  T555]  nvme_core r8169
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[  T555]  usb_common
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 0000000000042458
[  T555]  amd_sfh crc16
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[  T555]  i2c_hid_acpi
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000086fb4 R15: 000055f047b7b880
[  T555]  i2c_hid hid i2c_piix4 i2c_smbus i2c_designware_platform i2c_desig=
nware_core [last unloaded: bpf_testmod(O)]
[  T555] Preemption disabled at:
[ T1155]  </TASK>
[  T555] [<0000000000000000>] 0x0
[ T2386] BUG: scheduling while atomic: WRRende~ckend#1/2386/0x00000002
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2386] INFO: lockdep is turned off.
[ T2386] Modules linked in: bpf_testmod(O)
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2386]  ccm
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[ T2386]  snd_seq_dummy snd_hrtimer
[  T555]  <TASK>
[ T2386]  snd_seq_midi snd_seq_midi_event snd_rawmidi
[  T555]  dump_stack_lvl+0x6d/0xb0
[ T2386]  snd_seq snd_seq_device rfcomm
[  T555]  __schedule_bug.cold+0x8c/0x9a
[ T2386]  bnep snd_ctl_led snd_hda_codec_realtek
[  T555]  __schedule+0x167e/0x1ca0
[ T2386]  snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2386]  nls_ascii nls_cp437 vfat fat
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_acp3x_pdm_dma snd_soc_dmic
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2386]  snd_acp3x_rn btusb btrtl
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_soc_core btintel
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  btbcm btmtk bluetooth
[  T555]  ? rcu_is_watching+0x12/0x60
[ T2386]  ecdh_generic ecc
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_hda_intel snd_intel_dspcfg
[  T555]  ? lock_release+0x21b/0x2e0
[ T2386]  uvcvideo snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwd=
ep
[  T555]  schedule_rtlock+0x21/0x40
[ T2386]  uvc snd_hda_core videobuf2_v4l2
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[ T2386]  snd_pcm_oss videodev snd_rn_pci_acp3x
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  snd_mixer_oss videobuf2_common snd_acp_config
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T2386]  msi_wmi snd_pcm
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  mc sparse_keymap snd_soc_acpi snd_timer wmi_bmof edac_mce_amd snd=
 k10temp snd_pci_acp3x
[  T555]  rt_spin_lock+0x99/0x190
[ T2386]  soundcore ccp battery ac button
[  T555]  task_get_cgroup1+0xe8/0x340
[ T2386]  joydev hid_sensor_magn_3d hid_sensor_prox
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[ T2386]  hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_als
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T2386]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indust=
rialio
[  T555]  bpf_trace_run2+0xd3/0x260
[ T2386]  evdev hid_sensor_iio_common
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  amd_pmc sch_fq_codel mt7921e mt7921_common mt792x_lib
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[ T2386]  mt76_connac_lib mt76 mac80211 libarc4
[  T555]  syscall_trace_enter+0x1c7/0x260
[ T2386]  cfg80211 rfkill msr nvme_fabrics
[  T555]  do_syscall_64+0x395/0xfa0
[ T2386]  fuse efi_pstore
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2386]  configfs nfnetlink efivarfs autofs4
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2386]  ext4 mbcache jbd2
[  T555] RIP: 0033:0x7fd47309ea0e
[ T2386]  usbhid amdgpu amdxcp
[  T555] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 01 c2 48 89 16 =
48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0f 05 <5d> c3 c=
c 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[ T2386]  i2c_algo_bit
[  T555] RSP: 002b:00007fff31d516e0 EFLAGS: 00000297
[ T2386]  drm_client_lib
[  T555]  ORIG_RAX: 00000000000000e4
[ T2386]  drm_ttm_helper
[  T555] RAX: ffffffffffffffda RBX: 000055b3d56687b0 RCX: 00007fd47309ea0e
[ T2386]  ttm
[  T555] RDX: 0000000000000080 RSI: 00007fff31d51700 RDI: 0000000000000007
[ T2386]  drm_exec
[  T555] RBP: 00007fff31d516e0 R08: 0000000000000000 R09: 00007fd473098000
[ T2386]  gpu_sched drm_suballoc_helper
[  T555] R10: ffffffffffffffff R11: 0000000000000297 R12: 0000000000000001
[ T2386]  drm_panel_backlight_quirks
[  T555] R13: ffffffffffffffff R14: 0000000000000050 R15: 0000000000000007
[ T2386]  cec
[  T555]  </TASK>
[ T2386]  xhci_pci drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor=
_hub drm_kms_helper psmouse nvme mfd_core hid_multitouch hid_generic serio_=
raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid hid i2c_p=
iix4 i2c_smbus i2c_designware_platform i2c_designware_core [last unloaded: =
bpf_testmod(O)]
[ T2386] Preemption disabled at:
[ T2386] [<ffffffffa29f0b46>] schedule+0x36/0x130
[ T2386] CPU: 8 UID: 1000 PID: 2386 Comm: WRRende~ckend#1 Tainted: G       =
 W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] BUG: scheduling while atomic: in:imklog/1155/0x00000002
[ T1155] INFO: lockdep is turned off.
[ T2386] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Modules linked in:
[ T2386] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155]  bpf_testmod(O) ccm
[ T2386] Call Trace:
[ T1155]  snd_seq_dummy snd_hrtimer
[ T2386]  <TASK>
[ T1155]  snd_seq_midi snd_seq_midi_event
[ T2386]  dump_stack_lvl+0x6d/0xb0
[ T1155]  snd_rawmidi
[ T1155]  snd_seq snd_seq_device rfcomm bnep
[ T2386]  ? schedule+0x36/0x130
[ T1155]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_s=
codec_component
[ T2386]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  snd_hda_codec_hdmi nls_ascii nls_cp437 vfat
[ T2386]  __schedule+0x167e/0x1ca0
[ T1155]  fat snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn btusb
[ T2386]  ? rcu_is_watching+0x12/0x60
[ T1155]  btrtl snd_soc_core btintel btbcm btmtk
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  bluetooth ecdh_generic ecc snd_hda_intel
[ T2386]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_intel_dspcfg uvcvideo snd_hda_codec videobuf2_vmalloc
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  videobuf2_memops snd_hwdep uvc snd_hda_core
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  videobuf2_v4l2 snd_pcm_oss videodev
[ T2386]  ? rcu_is_watching+0x12/0x60
[ T1155]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_config
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  msi_wmi snd_pcm mc sparse_keymap
[ T2386]  ? lock_release+0x21b/0x2e0
[ T1155]  snd_soc_acpi snd_timer wmi_bmof edac_mce_amd snd k10temp snd_pci_=
acp3x
[ T2386]  schedule_rtlock+0x21/0x40
[ T1155]  soundcore ccp battery ac button
[ T2386]  rtlock_slowlock_locked+0x635/0x1d00
[ T1155]  joydev hid_sensor_magn_3d hid_sensor_prox hid_sensor_accel_3d hid=
_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  industrialio_triggered_buffer kfifo_buf industrialio evdev hid_se=
nsor_iio_common amd_pmc sch_fq_codel mt7921e mt7921_common mt792x_lib mt76_=
connac_lib mt76 mac80211
[ T2386]  rt_spin_lock+0x99/0x190
[ T1155]  libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pstore
[ T2386]  task_get_cgroup1+0xe8/0x340
[ T1155]  configfs nfnetlink efivarfs autofs4 ext4
[ T2386]  bpf_task_get_cgroup1+0xe/0x20
[ T1155]  mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bit
[ T2386]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[ T1155]  drm_client_lib drm_ttm_helper ttm drm_exec
[ T2386]  bpf_trace_run2+0xd3/0x260
[ T1155]  gpu_sched drm_suballoc_helper drm_panel_backlight_quirks cec xhci=
_pci
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor_hub drm_=
kms_helper psmouse
[ T2386]  __bpf_trace_sys_enter+0x37/0x60
[ T1155]  nvme mfd_core hid_multitouch hid_generic serio_raw nvme_core
[ T2386]  syscall_trace_enter+0x1c7/0x260
[ T1155]  r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid
[ T2386]  do_syscall_64+0x395/0xfa0
[ T1155]  hid i2c_piix4 i2c_smbus i2c_designware_platform
[ T2386]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[ T1155] Preemption disabled at:
[ T2386]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1155] [<ffffffffa29f1017>] preempt_schedule_irq+0x27/0x70
[ T2386] RIP: 0033:0x7f1f6d7ed8c7
[ T2386] Code: 73 01 c3 48 8b 0d 31 e5 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 18 00 00 00 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 01 e5 0e 00 f7 d8 64 89 01 48
[ T2386] RSP: 002b:00007f1f3a1fa1d8 EFLAGS: 00000206 ORIG_RAX: 000000000000=
0018
[ T2386] RAX: ffffffffffffffda RBX: 00007f1f3a1fa1e8 RCX: 00007f1f6d7ed8c7
[ T2386] RDX: 0000000000007e8a RSI: 0000000000003f45 RDI: 00007f1f3bffa600
[ T2386] RBP: 0000000000000009 R08: 0000000000000007 R09: e5e5e5e5e5e5e5e5
[ T2386] R10: 0000000000000007 R11: 0000000000000206 R12: 00007f1f3a1fa61c
[ T2386] R13: 00007f1f3a1fa380 R14: 00007f1f3a1fa2d0 R15: 00007f1f3a1fa218
[ T2386]  </TASK>
[ T1155] CPU: 6 UID: 0 PID: 1155 Comm: in:imklog Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T1155] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T1155] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T1155] Call Trace:
[ T1155]  <TASK>
[ T1155]  dump_stack_lvl+0x6d/0xb0
[ T1155]  ? preempt_schedule_irq+0x27/0x70
[ T1155]  __schedule_bug.cold+0x8c/0x9a
[ T1155]  __schedule+0x167e/0x1ca0
[ T1155]  ? rcu_is_watching+0x12/0x60
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555] BUG: scheduling while atomic: systemd-journal/555/0x00000002
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555] INFO: lockdep is turned off.
[  T555] Modules linked in:
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  bpf_testmod(O) ccm snd_seq_dummy
[ T1155]  ? rcu_is_watching+0x12/0x60
[  T555]  snd_hrtimer snd_seq_midi snd_seq_midi_event
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_rawmidi snd_seq snd_seq_device
[ T1155]  ? lock_release+0x21b/0x2e0
[  T555]  rfcomm bnep snd_ctl_led snd_hda_codec_realtek snd_hda_codec_gener=
ic snd_hda_scodec_component
[ T1155]  schedule_rtlock+0x21/0x40
[  T555]  snd_hda_codec_hdmi nls_ascii nls_cp437
[ T1155]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  vfat fat snd_acp3x_pdm_dma snd_soc_dmic
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  snd_acp3x_rn btusb btrtl
[ T1155]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  snd_soc_core btintel btbcm
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  btmtk bluetooth ecdh_generic ecc snd_hda_intel snd_intel_dspcfg u=
vcvideo snd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep
[ T1155]  rt_spin_lock+0x99/0x190
[  T555]  uvc snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev
[ T1155]  task_get_cgroup1+0xe8/0x340
[  T555]  snd_rn_pci_acp3x snd_mixer_oss videobuf2_common snd_acp_config ms=
i_wmi
[ T1155]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  snd_pcm mc sparse_keymap snd_soc_acpi
[ T1155]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  snd_timer wmi_bmof edac_mce_amd
[ T1155]  bpf_trace_run2+0xd3/0x260
[  T555]  snd k10temp snd_pci_acp3x soundcore
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ccp battery ac button joydev hid_sensor_magn_3d
[ T1155]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor=
_als
[ T1155]  syscall_trace_enter+0x1c7/0x260
[  T555]  hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indust=
rialio evdev
[ T1155]  do_syscall_64+0x395/0xfa0
[  T555]  hid_sensor_iio_common amd_pmc
[ T1155]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  sch_fq_codel mt7921e mt7921_common mt792x_lib mt76_connac_lib
[ T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555]  mt76 mac80211 libarc4 cfg80211 rfkill
[ T1155] RIP: 0033:0x7fc77f05c7f9
[  T555]  msr nvme_fabrics
[ T1155] Code: 01 00 00 89 16 8b 80 d4 01 00 00 89 46 04 eb c8 81 3d 1b 98 =
ff ff ff ff ff 7f 74 4d f3 90 e9 07 ff ff ff b8 60 00 00 00 0f 05 <eb> ae 4=
8 0f ba e2 3e 73 0b 4c 89 d8 48 d3 e8 e9 53 ff ff ff 48 21
[  T555]  fuse
[  T555]  efi_pstore
[ T1155] RSP: 002b:00007fc77e6b02c8 EFLAGS: 00000297
[  T555]  configfs nfnetlink
[ T1155]  ORIG_RAX: 0000000000000060
[  T555]  efivarfs
[ T1155] RAX: ffffffffffffffda RBX: 00007fc7700b04a8 RCX: 00007fc77f05c7f9
[  T555]  autofs4
[ T1155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fc77e6b02e0
[  T555]  ext4 mbcache
[ T1155] RBP: 00007fc77e6b02d0 R08: 0000000000000000 R09: 000000000004245a
[  T555]  jbd2
[ T1155] R10: 00007fc77f056000 R11: 0000000000000297 R12: 0000000000000000
[  T555]  usbhid amdgpu
[ T1155] R13: 00007fc77e6b02e0 R14: 0000000000086fc1 R15: 000055f047b7b880
[  T555]  amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gp=
u_sched drm_suballoc_helper drm_panel_backlight_quirks cec
[ T1155]  </TASK>
[  T555]  xhci_pci drm_buddy xhci_hcd drm_display_helper usbcore hid_sensor=
_hub drm_kms_helper psmouse nvme mfd_core hid_multitouch hid_generic serio_=
raw nvme_core r8169 usb_common amd_sfh crc16 i2c_hid_acpi i2c_hid hid i2c_p=
iix4 i2c_smbus i2c_designware_platform i2c_designware_core [last unloaded: =
bpf_testmod(O)]
[  T555] Preemption disabled at:
[  T555] [<0000000000000000>] 0x0
[  T555] CPU: 3 UID: 0 PID: 555 Comm: systemd-journal Tainted: G        W  =
O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[  T555] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  T555] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[  T555] Call Trace:
[  T555]  <TASK>
[  T555]  dump_stack_lvl+0x6d/0xb0
[  T555]  __schedule_bug.cold+0x8c/0x9a
[  T555]  __schedule+0x167e/0x1ca0
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? rcu_is_watching+0x12/0x60
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? lock_release+0x21b/0x2e0
[  T555]  schedule_rtlock+0x21/0x40
[  T555]  rtlock_slowlock_locked+0x635/0x1d00
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  rt_spin_lock+0x99/0x190
[  T555]  task_get_cgroup1+0xe8/0x340
[  T555]  bpf_task_get_cgroup1+0xe/0x20
[  T555]  bpf_prog_1b41d68a2f9ed9f4_on_enter+0x47/0x128
[  T555]  bpf_trace_run2+0xd3/0x260
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  __bpf_trace_sys_enter+0x37/0x60
[  T555]  syscall_trace_enter+0x1c7/0x260
[  T555]  do_syscall_64+0x395/0xfa0
[  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T555] RIP: 0033:0x7fd472b0fad7
[  T555] Code: 73 01 c3 48 8b 0d 21 53 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 ba 00 00 00 0f 05 <c3> 0f 1=
f 84 00 00 00 00 00 b8 ea 00 00 00 0f 05 48 3d 01 f0 ff ff
[  T555] RSP: 002b:00007fff31d51828 EFLAGS: 00000202 ORIG_RAX: 000000000000=
00ba
[  T555] RAX: ffffffffffffffda RBX: 000000000000022b RCX: 00007fd472b0fad7
[  T555] RDX: 00000000ffffffff RSI: 00007fd472ecafd0 RDI: 00007fd473095cc8
[  T555] RBP: 000055b3d5668660 R08: 0000000000000000 R09: 000055b3d5667488
[  T555] R10: 00007fff31d518a0 R11: 0000000000000202 R12: 000055b3d5668660
[  T555] R13: ffffffffffffffff R14: 0000000000000000 R15: 00007fff31d51890
[  T555]  </TASK>
[ T4362] tun: Universal TUN/TAP device driver, 1.6
[ T4373] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T4373] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 4373, name:=
 test_progs
[ T4373] preempt_count: 1, expected: 0
[ T4373] RCU nest depth: 0, expected: 0
[ T4373] INFO: lockdep is turned off.
[ T4373] irq event stamp: 0
[ T4373] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ T4373] hardirqs last disabled at (0): [<ffffffffa1d785ee>] copy_process+0=
xa0e/0x2110
[ T4373] softirqs last  enabled at (0): [<ffffffffa1d785ee>] copy_process+0=
xa0e/0x2110
[ T4373] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ T4373] Preemption disabled at:
[ T4373] [<ffffffffa1fc3089>] __bpf_async_init+0x69/0x2f0
[ T4373] CPU: 1 UID: 0 PID: 4373 Comm: test_progs Tainted: G        W  O   =
     6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T4373] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T4373] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T4373] Call Trace:
[ T4373]  <TASK>
[ T4373]  dump_stack_lvl+0x6d/0xb0
[ T4373]  __might_resched.cold+0xfa/0x135
[ T4373]  rt_spin_lock+0x5f/0x190
[ T4373]  ? ___slab_alloc.isra.0+0x73/0xb00
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  ? lock_acquire+0x282/0x300
[ T4373]  ___slab_alloc.isra.0+0x73/0xb00
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  ? rcu_is_watching+0x12/0x60
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  ? enqueue_hrtimer+0xb1/0x100
[ T4373]  ? start_dl_timer+0x102/0x1e0
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  ? rcu_is_watching+0x12/0x60
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  ? psi_task_change+0x89/0x140
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  ? bpf_map_kmalloc_node+0x72/0x220
[ T4373]  __kmalloc_node_noprof+0xfb/0x490
[ T4373]  bpf_map_kmalloc_node+0x72/0x220
[ T4373]  __bpf_async_init+0x125/0x2f0
[ T4373]  bpf_timer_init+0x33/0x40
[ T4373]  bpf_prog_e1400c375a5ffab1_start_cb+0x5d/0x91
[ T4373]  bpf_prog_c49dd2c33b6fb3ba_start_timer+0x65/0x8a
[ T4373]  bpf_prog_test_run_syscall+0x103/0x290
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  ? fput+0x3f/0x90
[ T4373]  __sys_bpf+0xd33/0x26d0
[ T4373]  ? preempt_count_sub+0x96/0xd0
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  ? futex_wake+0xb2/0x1d0
[ T4373]  __x64_sys_bpf+0x21/0x30
[ T4373]  do_syscall_64+0x7a/0xfa0
[ T4373]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4373]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T4373] RIP: 0033:0x7f01bf2f0779
[ T4373] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T4373] RSP: 002b:00007f01af7fd878 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0141
[ T4373] RAX: ffffffffffffffda RBX: 00007f01af7fecdc RCX: 00007f01bf2f0779
[ T4373] RDX: 0000000000000050 RSI: 00007f01af7fd8b0 RDI: 000000000000000a
[ T4373] RBP: 00007f01af7fd890 R08: 0000000000000004 R09: 00007f01af7fd8b0
[ T4373] R10: 00007ffe4a37cd20 R11: 0000000000000202 R12: 0000000000000020
[ T4373] R13: 000000000000005f R14: 00007ffe4a37cb10 R15: 00007f01aeffe000
[ T4373]  </TASK>
[   C15] hrtimer: interrupt took 2384976 ns
[ T6472] NET: Registered PF_VSOCK protocol family
[ T2916] bpf getsockopt: ignoring program buffer with optlen=3D4097 (max_op=
tlen=3D4096)
[ T2916] bpf setsockopt: ignoring program buffer with optlen=3D4097 (max_op=
tlen=3D4096)
[   T23] perf: interrupt took too long (2566 > 2500), lowering kernel.perf_=
event_max_sample_rate to 77000
[   T23] perf: interrupt took too long (4060 > 4025), lowering kernel.perf_=
event_max_sample_rate to 49000
[ T2916] struct_ops for bpf_test_no_cfi_ops has no cfi_stubs
[ T2916] bpf_testmod: oh no, recursing into test_1, recursion_misses 1
[ T7256] loop: module loaded
[ T7255] loop0: detected capacity change from 0 to 20480
[    C4] operation not supported error, dev loop0, sector 20352 op 0x9:(WRI=
TE_ZEROES) flags 0x10000800 phys_seg 0 prio class 0
[ T7271] EXT4-fs (loop0): mounting ext2 file system using the ext4 subsystem
[ T7271] EXT4-fs (loop0): mounted filesystem 200ff9cb-ef7f-4c69-ab8c-84155b=
84800e r/w without journal. Quota mode: disabled.
[ T7296] EXT4-fs (loop0): unmounting filesystem 200ff9cb-ef7f-4c69-ab8c-841=
55b84800e.
[ T2916] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T2916] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2916, name:=
 new_name
[ T2916] preempt_count: 1, expected: 0
[ T2916] RCU nest depth: 1, expected: 1
[ T2916] INFO: lockdep is turned off.
[ T2916] irq event stamp: 23480570
[ T2916] hardirqs last  enabled at (23480569): [<ffffffffa1ccc16f>] dump_st=
ack_lvl+0x3f/0xb0
[ T2916] hardirqs last disabled at (23480570): [<ffffffffa1ccc15c>] dump_st=
ack_lvl+0x2c/0xb0
[ T2916] softirqs last  enabled at (23480156): [<ffffffffa1d8616e>] __local=
_bh_enable_ip+0xee/0x170
[ T2916] softirqs last disabled at (23480150): [<ffffffffa1f8dc1a>] bpf_raw=
_tp_link_attach+0x11a/0x220
[ T2916] Preemption disabled at:
[ T2916] [<ffffffffa1fc3089>] __bpf_async_init+0x69/0x2f0
[ T2916] CPU: 7 UID: 0 PID: 2916 Comm: new_name Tainted: G        W  O     =
   6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2916] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2916] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2916] Call Trace:
[ T2916]  <TASK>
[ T2916]  dump_stack_lvl+0x6d/0xb0
[ T2916]  __might_resched.cold+0xfa/0x135
[ T2916]  rt_spin_lock+0x5f/0x190
[ T2916]  ? ___slab_alloc.isra.0+0x73/0xb00
[ T2916]  ? rcu_is_watching+0x12/0x60
[ T2916]  ___slab_alloc.isra.0+0x73/0xb00
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? is_bpf_text_address+0x65/0x120
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? rcu_is_watching+0x12/0x60
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? is_bpf_text_address+0x6f/0x120
[ T2916]  ? bpf_map_kmalloc_node+0x72/0x220
[ T2916]  __kmalloc_node_noprof+0xfb/0x490
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  bpf_map_kmalloc_node+0x72/0x220
[ T2916]  __bpf_async_init+0x125/0x2f0
[ T2916]  bpf_timer_init+0x33/0x40
[ T2916]  bpf_prog_208954fba389149b_test1+0x87/0x16f
[ T2916]  bpf_trampoline_6442502617+0x43/0xa7
[ T2916]  bpf_fentry_test1+0x9/0x20
[ T2916]  bpf_prog_test_run_tracing+0x147/0x2f0
[ T2916]  ? fput+0x3f/0x90
[ T2916]  __sys_bpf+0xd33/0x26d0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? lock_release+0x21b/0x2e0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  __x64_sys_bpf+0x21/0x30
[ T2916]  do_syscall_64+0x7a/0xfa0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2916] RIP: 0033:0x7f01bf2f0779
[ T2916] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T2916] RSP: 002b:00007ffe4a37c9b8 EFLAGS: 00000206 ORIG_RAX: 000000000000=
0141
[ T2916] RAX: ffffffffffffffda RBX: 00007ffe4a37d058 RCX: 00007f01bf2f0779
[ T2916] RDX: 0000000000000050 RSI: 00007ffe4a37c9f0 RDI: 000000000000000a
[ T2916] RBP: 00007ffe4a37c9d0 R08: 00000000ffffffff R09: 00007ffe4a37c9f0
[ T2916] R10: 0000000000000064 R11: 0000000000000206 R12: 0000000000000000
[ T2916] R13: 00007ffe4a37d068 R14: 00007f01bf925000 R15: 000055edb0606890
[ T2916]  </TASK>
[ T7350] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T7350] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 7350, name:=
 new_name
[ T7350] preempt_count: 1, expected: 0
[ T7350] RCU nest depth: 0, expected: 0
[ T7350] INFO: lockdep is turned off.
[ T7350] irq event stamp: 0
[ T7350] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ T7350] hardirqs last disabled at (0): [<ffffffffa1d785ee>] copy_process+0=
xa0e/0x2110
[ T7350] softirqs last  enabled at (0): [<ffffffffa1d785ee>] copy_process+0=
xa0e/0x2110
[ T7350] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ T7350] Preemption disabled at:
[ T7350] [<ffffffffa1fc3089>] __bpf_async_init+0x69/0x2f0
[ T7350] CPU: 5 UID: 0 PID: 7350 Comm: new_name Tainted: G        W  O     =
   6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T7350] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T7350] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T7350] Call Trace:
[ T7350]  <TASK>
[ T7350]  dump_stack_lvl+0x6d/0xb0
[ T7350]  __might_resched.cold+0xfa/0x135
[ T7350]  rt_spin_lock+0x5f/0x190
[ T7350]  ? ___slab_alloc.isra.0+0x73/0xb00
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  ? rcu_is_watching+0x12/0x60
[ T7350]  ___slab_alloc.isra.0+0x73/0xb00
[ T7350]  ? rcu_is_watching+0x12/0x60
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  ? lock_release+0x21b/0x2e0
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  ? is_bpf_text_address+0x6f/0x120
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  ? kernel_text_address+0x70/0xd0
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  ? __kernel_text_address+0x12/0x40
[ T7350]  ? bpf_map_kmalloc_node+0x72/0x220
[ T7350]  __kmalloc_node_noprof+0xfb/0x490
[ T7350]  bpf_map_kmalloc_node+0x72/0x220
[ T7350]  __bpf_async_init+0x125/0x2f0
[ T7350]  bpf_timer_init+0x33/0x40
[ T7350]  bpf_prog_6ca587954a1650c7_race+0x9c/0xe1
[ T7350]  bpf_prog_test_run_syscall+0x103/0x290
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  ? fput+0x3f/0x90
[ T7350]  __sys_bpf+0xd33/0x26d0
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  ? lock_release+0x21b/0x2e0
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  __x64_sys_bpf+0x21/0x30
[ T7350]  do_syscall_64+0x7a/0xfa0
[ T7350]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T7350]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T7350] RIP: 0033:0x7f01bf2f0779
[ T7350] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T7350] RSP: 002b:00007f01ad7f9898 EFLAGS: 00000206 ORIG_RAX: 000000000000=
0141
[ T7350] RAX: ffffffffffffffda RBX: 00007f01ad7facdc RCX: 00007f01bf2f0779
[ T7350] RDX: 0000000000000050 RSI: 00007f01ad7f98d0 RDI: 000000000000000a
[ T7350] RBP: 00007f01ad7f98b0 R08: 00007f01ad7fa6c0 R09: 00007f01ad7f98d0
[ T7350] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000020
[ T7350] R13: 000000000000005f R14: 00007ffe4a37c8d0 R15: 00007f01acffa000
[ T7350]  </TASK>
[ T2916] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T2916] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2916, name:=
 new_name
[ T2916] preempt_count: 1, expected: 0
[ T2916] RCU nest depth: 1, expected: 1
[ T2916] INFO: lockdep is turned off.
[ T2916] irq event stamp: 23480570
[ T2916] hardirqs last  enabled at (23480569): [<ffffffffa1ccc16f>] dump_st=
ack_lvl+0x3f/0xb0
[ T2916] hardirqs last disabled at (23480570): [<ffffffffa1ccc15c>] dump_st=
ack_lvl+0x2c/0xb0
[ T2916] softirqs last  enabled at (23480156): [<ffffffffa1d8616e>] __local=
_bh_enable_ip+0xee/0x170
[ T2916] softirqs last disabled at (23480150): [<ffffffffa1f8dc1a>] bpf_raw=
_tp_link_attach+0x11a/0x220
[ T2916] Preemption disabled at:
[ T2916] [<ffffffffa1fc3089>] __bpf_async_init+0x69/0x2f0
[ T2916] CPU: 7 UID: 0 PID: 2916 Comm: new_name Tainted: G        W  O     =
   6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2916] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2916] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2916] Call Trace:
[ T2916]  <TASK>
[ T2916]  dump_stack_lvl+0x6d/0xb0
[ T2916]  __might_resched.cold+0xfa/0x135
[ T2916]  rt_spin_lock+0x5f/0x190
[ T2916]  ? ___slab_alloc.isra.0+0x73/0xb00
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ___slab_alloc.isra.0+0x73/0xb00
[ T2916]  ? rcu_is_watching+0x12/0x60
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? is_bpf_text_address+0x65/0x120
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? rcu_is_watching+0x12/0x60
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? bpf_map_kmalloc_node+0x72/0x220
[ T2916]  __kmalloc_node_noprof+0xfb/0x490
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  bpf_map_kmalloc_node+0x72/0x220
[ T2916]  __bpf_async_init+0x125/0x2f0
[ T2916]  bpf_timer_init+0x33/0x40
[ T2916]  bpf_prog_a5e8b38bc982b60e_test1+0xc8/0x12e
[ T2916]  bpf_trampoline_6442502617+0x43/0xa7
[ T2916]  bpf_fentry_test1+0x9/0x20
[ T2916]  bpf_prog_test_run_tracing+0x147/0x2f0
[ T2916]  ? fput+0x3f/0x90
[ T2916]  __sys_bpf+0xd33/0x26d0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? lock_release+0x21b/0x2e0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  __x64_sys_bpf+0x21/0x30
[ T2916]  do_syscall_64+0x7a/0xfa0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2916] RIP: 0033:0x7f01bf2f0779
[ T2916] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T2916] RSP: 002b:00007ffe4a37ca18 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0141
[ T2916] RAX: ffffffffffffffda RBX: 00007ffe4a37d058 RCX: 00007f01bf2f0779
[ T2916] RDX: 0000000000000050 RSI: 00007ffe4a37ca50 RDI: 000000000000000a
[ T2916] RBP: 00007ffe4a37ca30 R08: 00000000ffffffff R09: 00007ffe4a37ca50
[ T2916] R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000000
[ T2916] R13: 00007ffe4a37d068 R14: 00007f01bf925000 R15: 000055edb0606890
[ T2916]  </TASK>
[ T7479] ipip: IPv4 and MPLS over IPv4 tunneling driver
[ T7610] Initializing XFRM netlink socket
[ T2916] ref_ctr_offset mismatch. inode: 0x1c06467 offset: 0x95a816 ref_ctr=
_offset(old): 0x6effc12 ref_ctr_offset(new): 0x6effc10
[ T4821] pci_bus 0000:03: Allocating resources
[  T111] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[  T111] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[  T111] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 fo=
r PSP TMR
[  T111] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not ava=
ilable
[  T111] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay=
 ta ucode is not available
[  T111] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  T111] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f,=
 smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b=
3100 (59.49.0)
[  T111] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[  T111] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[  T111] [drm] kiq ring mec 2 pipe 1 q 0
[  T111] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: vers=
ion=3D0x02020020
[  T111] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[  T111] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on h=
ub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on h=
ub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on =
hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on =
hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on =
hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on =
hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on =
hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on =
hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on=
 hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on=
 hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 o=
n hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub 0
[  T111] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on h=
ub 8
[  T111] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on=
 hub 8
[  T111] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on=
 hub 8
[  T111] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hu=
b 8
[  T111] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T4828] pci_bus 0000:03: Allocating resources
[  T361] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[  T361] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[  T361] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 fo=
r PSP TMR
[  T361] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not ava=
ilable
[  T361] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay=
 ta ucode is not available
[  T361] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  T361] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f,=
 smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b=
3100 (59.49.0)
[  T361] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[  T361] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[  T361] [drm] kiq ring mec 2 pipe 1 q 0
[  T361] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: vers=
ion=3D0x02020020
[  T361] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[  T361] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on h=
ub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on h=
ub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on =
hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on =
hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on =
hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on =
hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on =
hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on =
hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on=
 hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on=
 hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 o=
n hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub 0
[  T361] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on h=
ub 8
[  T361] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on=
 hub 8
[  T361] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on=
 hub 8
[  T361] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hu=
b 8
[  T361] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T3942] pci_bus 0000:03: Allocating resources
[ T3942] pci_bus 0000:03: Allocating resources
[ T4828] pci_bus 0000:03: Allocating resources
[ T7393] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T7393] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T7393] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 fo=
r PSP TMR
[ T7393] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not ava=
ilable
[ T7393] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay=
 ta ucode is not available
[ T7393] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T7393] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f,=
 smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b=
3100 (59.49.0)
[ T7393] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T7393] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T7393] [drm] kiq ring mec 2 pipe 1 q 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: vers=
ion=3D0x02020020
[ T7393] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on h=
ub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on h=
ub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on =
hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on =
hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on =
hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on =
hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on =
hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on =
hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on=
 hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on=
 hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 o=
n hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub 0
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on h=
ub 8
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on=
 hub 8
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on=
 hub 8
[ T7393] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hu=
b 8
[ T7393] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T4821] pci_bus 0000:03: Allocating resources
[ T5525] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T5525] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T3942] pci_bus 0000:03: Allocating resources
[ T5525] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 fo=
r PSP TMR
[ T5525] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not ava=
ilable
[ T5525] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay=
 ta ucode is not available
[ T5525] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T5525] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f,=
 smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b=
3100 (59.49.0)
[ T5525] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T5525] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T5525] [drm] kiq ring mec 2 pipe 1 q 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: vers=
ion=3D0x02020020
[ T5525] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on h=
ub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on h=
ub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on =
hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on =
hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on =
hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on =
hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on =
hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on =
hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on=
 hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on=
 hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 o=
n hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub 0
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on h=
ub 8
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on=
 hub 8
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on=
 hub 8
[ T5525] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hu=
b 8
[ T5525] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T4828] pci_bus 0000:03: Allocating resources
[ T5513] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T5513] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T4821] pci_bus 0000:03: Allocating resources
[ T5513] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 fo=
r PSP TMR
[ T5513] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not ava=
ilable
[ T5513] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay=
 ta ucode is not available
[ T5513] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T5513] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f,=
 smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b=
3100 (59.49.0)
[ T5513] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T5513] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T5513] [drm] kiq ring mec 2 pipe 1 q 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: vers=
ion=3D0x02020020
[ T5513] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on h=
ub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on h=
ub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on =
hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on =
hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on =
hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on =
hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on =
hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on =
hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on=
 hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on=
 hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 o=
n hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub 0
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on h=
ub 8
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on=
 hub 8
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on=
 hub 8
[ T5513] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hu=
b 8
[ T5513] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T2916] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T2916] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2916, name:=
 new_name
[ T2916] preempt_count: 1, expected: 0
[ T2916] RCU nest depth: 3, expected: 3
[ T2916] INFO: lockdep is turned off.
[ T2916] irq event stamp: 23480570
[ T2916] hardirqs last  enabled at (23480569): [<ffffffffa1ccc16f>] dump_st=
ack_lvl+0x3f/0xb0
[ T2916] hardirqs last disabled at (23480570): [<ffffffffa1ccc15c>] dump_st=
ack_lvl+0x2c/0xb0
[ T2916] softirqs last  enabled at (23480156): [<ffffffffa1d8616e>] __local=
_bh_enable_ip+0xee/0x170
[ T2916] softirqs last disabled at (23480150): [<ffffffffa1f8dc1a>] bpf_raw=
_tp_link_attach+0x11a/0x220
[ T2916] Preemption disabled at:
[ T2916] [<ffffffffa1fc3089>] __bpf_async_init+0x69/0x2f0
[ T2916] CPU: 10 UID: 0 PID: 2916 Comm: new_name Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT,(full)}=20
[ T2916] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T2916] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T2916] Call Trace:
[ T2916]  <TASK>
[ T2916]  dump_stack_lvl+0x6d/0xb0
[ T2916]  __might_resched.cold+0xfa/0x135
[ T2916]  rt_spin_lock+0x5f/0x190
[ T2916]  ? ___slab_alloc.isra.0+0x73/0xb00
[ T2916]  ___slab_alloc.isra.0+0x73/0xb00
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? rcu_is_watching+0x12/0x60
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? rt_mutex_slowunlock+0x3ee/0x490
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? rtlock_slowlock_locked+0x55/0x1d00
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? bpf_map_kmalloc_node+0x72/0x220
[ T2916]  __kmalloc_node_noprof+0xfb/0x490
[ T2916]  bpf_map_kmalloc_node+0x72/0x220
[ T2916]  __bpf_async_init+0x125/0x2f0
[ T2916]  bpf_prog_90ea96a459b64173_test_call_array_sleepable+0xb3/0x10e
[ T2916]  bpf_test_run+0x1fb/0x400
[ T2916]  ? bpf_test_run+0x115/0x400
[ T2916]  ? migrate_enable+0xd6/0x110
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? rcu_is_watching+0x12/0x60
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? migrate_enable+0xd6/0x110
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? rcu_is_watching+0x12/0x60
[ T2916]  ? kmem_cache_alloc_noprof+0x21e/0x2b0
[ T2916]  bpf_prog_test_run_skb+0x37b/0x7c0
[ T2916]  ? fput+0x3f/0x90
[ T2916]  __sys_bpf+0xd33/0x26d0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  ? lock_release+0x21b/0x2e0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  __x64_sys_bpf+0x21/0x30
[ T2916]  do_syscall_64+0x7a/0xfa0
[ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T2916]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T2916] RIP: 0033:0x7f01bf2f0779
[ T2916] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T2916] RSP: 002b:00007ffe4a37c518 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0141
[ T2916] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f01bf2f0779
[ T2916] RDX: 0000000000000050 RSI: 00007ffe4a37c550 RDI: 000000000000000a
[ T2916] RBP: 00007ffe4a37c530 R08: 00000000ffffffff R09: 00007ffe4a37c550
[ T2916] R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000000
[ T2916] R13: 00007ffe4a37d068 R14: 00007f01bf925000 R15: 000055edb0606890
[ T2916]  </TASK>

Bert Karwatzki

