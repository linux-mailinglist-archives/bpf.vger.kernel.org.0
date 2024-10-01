Return-Path: <bpf+bounces-40658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9398BB13
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5EC2842FA
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE7719CC0F;
	Tue,  1 Oct 2024 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unformed.ru header.i=@unformed.ru header.b="QMSBXE1O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEEqjFTO"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DE3201
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782251; cv=none; b=DfrHdKojaP2Gao9nIlu+Z6wnm8IhhQlOyY2SCtyU7ravmvi0F0tC/55ZyxtbjUDtARfAvHxyLUMZ3hCQkVCtkFNUykw1ldVvFu75EnJ6/pvpSJlksM/ykJI1V0Y+9u8G6pbHhnycRGUWUUh9MGXfmFKfJYRJ0S09m6botp0BjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782251; c=relaxed/simple;
	bh=Bjm4iGK+Lm85UtBtqacMaq7AwFZH37OtPFxfYs0eDxk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=r2UMg3dWbmXkiFHRhpKBaRlTRnPVsQ07hy9X1hU4P9eU5o57+st9L24aUXZK9xMMmSl2NmxzEUDsNyHyUMkov3qQ85VmFrXreBTVckLHG7mj0DCoAwC3qALaqQ/JCn3RLyMfsVlV9cICs1PNY6qeV3Vn3Rusw77ggRMQZ4AR5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unformed.ru; spf=pass smtp.mailfrom=unformed.ru; dkim=pass (2048-bit key) header.d=unformed.ru header.i=@unformed.ru header.b=QMSBXE1O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEEqjFTO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unformed.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unformed.ru
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C60D1381FE5;
	Tue,  1 Oct 2024 07:30:40 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-02.internal (MEProxy); Tue, 01 Oct 2024 07:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unformed.ru; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1727782240; x=1727868640; bh=hj
	WUTGaDlSephSqJ+HhldNCGStmg9vCXunyNUH/yLww=; b=QMSBXE1OQYLLIrspma
	3WERwRHS3g/W5S9fJbsSbj5eXonMMaqATl62ugPhcJtRsQ2OQasJbCT7vB2nw4YV
	31PtN9+YIlT6lXwCfSYKPqquNO6cH17e37vjd8CttCDaJZGVZG7BHnmEX7x8A1kY
	P31ZWL70qFY9HWs7Igbo+AGXb2gQasnwXIC7ZR7r1koOjmV2iD7KAfdrDkiaGLri
	5MPuVeltBwwfyvUiJxvVazW6ONYpTlbeDV5jrEwUenqo+EFP+E0FsdFpMQJwpHG6
	cWLHwxDYGqCLH19q+G7C0NplEQykveweuqJhytCtKza1j+7OvVCxPhQTXdmkt34R
	XAGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727782240; x=1727868640; bh=hjWUTGaDlSeph
	SqJ+HhldNCGStmg9vCXunyNUH/yLww=; b=FEEqjFTOj6Z1p8uvMBGeSLk1fSRl2
	JHUrHbxJkL1Gy7vebmhmjBFFunftoHOfaYpWDOTQ+jMXEeGdI2ZeUlWvKOlOnUEL
	8d2yy6r4+Ar8dpFJ7zd4+22XY53NKnJzBbA0yVns7PoQvsOaaW4okLkXvS4/9x31
	FHwPx5ivK20AOypPZ5jGW1wmUGEeFgv9WVXjEfGZN0Q0wVrHKRDLco2C9xOQN4us
	xtB9gSt06kM93dKkRSK5Rt6jPcotppjAc+I7ExKr3AiuqriEbm7j6HrlTiF48WK7
	JcvdYNFsFW4nn9+S4j/nWnq9JKJ7hTWB+GqiD8gw9uMh5knp1I3CQA9vQ==
X-ME-Sender: <xms:X937ZrJHu9xD7c6cDzD6Bygcf_KEPjAxw_T0K07YV6LXouIyEGa47A>
    <xme:X937ZvKONfqrP_9QyAuf_dz3l0oyYiIy62wftijSTi9QZ719J6s8mPBjXEQYTUpTz
    5T7QqSBJJHJGChjBkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkufgtgfesthhqredtredttdenucfhrhhomhepfdgjuhhrhicugghoshhtrhhikhho
    vhdfuceomhhonhesuhhnfhhorhhmvggurdhruheqnecuggftrfgrthhtvghrnhepteejge
    dvheefhfekjeeuheduiedtfefgvedtuedthfehheehkeegfeeugefhveffnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhonhesuhhnfhhorh
    hmvggurdhruhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegsph
    hfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YN37Zjuhs0Et03G9gBL9X33XKWh6yOwRFeJQpv3ism4zmIC1Q9nzAQ>
    <xmx:YN37ZkYUnm1cSsrapdVOKUluM6j5J5C88JFJihCqwX_yF1qhkXxEVQ>
    <xmx:YN37ZiZKUVOTnrEcibyk2ldGlOVIvuHOfstoIBLP1JrXyHWzxpJwJw>
    <xmx:YN37ZoBSKVKYkteHkXxNY9wsY_nZD4sJBTXyRxt909wCoK_5v-9oqg>
    <xmx:YN37ZlwibdNq_R4-SmamCKqH51s54Ru4qNa40pQSNCxA1e90y0WUnKcD>
Feedback-ID: i2649496d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E32581F00073; Tue,  1 Oct 2024 07:30:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Oct 2024 13:30:13 +0200
From: "Yury Vostrikov" <mon@unformed.ru>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org
Message-Id: <5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com>
Subject: NULL pointer deref inside xdp_do_flush due to
 bpf_net_ctx_get_all_used_flush_lists
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I stumbled upon a NULL pointer derefence inside BPF code. The triggering=
 condition is=20
message from OOM killer + netconsole. The crash happens at=20

	u32 kern_flags =3D bpf_net_ctx->ri.kern_flags;

line of bpf_net_ctx_get_all_used_flush_lists() function. bpf_net_ctx is =
NULL here. With trivial fix

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7d7578a8eac1..cba16bf307f7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -844,6 +844,9 @@ static inline void bpf_net_ctx_get_all_used_flush_li=
sts(struct list_head **lh_ma
                                                        struct list_head=
 **lh_xsk)
 {
        struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+       WARN_ON(bpf_net_ctx =3D=3D NULL);
+       if (bpf_net_ctx =3D=3D NULL)
+               return;
        u32 kern_flags =3D bpf_net_ctx->ri.kern_flags;
        struct list_head *lh;
=20
I get the following backtrace instead of crash:

[  177.216427] ------------[ cut here ]------------
[  177.216428] WARNING: CPU: 25 PID: 4584 at include/linux/filter.h:847 =
xdp_do_flush+0x7b/0x80
[  177.216430] Modules linked in: veth snd_hrtimer snd_seq bridge stp ll=
c nfnetlink overlay netconsole configfs nfs lockd grace netfs sunrpc af_=
packet 8021q nls_iso8859_1 nls_cp866 vfat fat i2c_dev cpuid edac_mce_amd=
 edac_core snd_hda_codec_realtek kvm_amd snd_hda_codec_generic snd_hda_s=
codec_component snd_hda_codec_hdmi kvm uvcvideo sha512_ssse3 snd_usb_aud=
io videobuf2_vmalloc sha512_generic snd_hda_intel videobuf2_memops uvc s=
nd_intel_dspcfg sha256_ssse3 videobuf2_v4l2 snd_hwdep snd_hda_codec aesn=
i_intel snd_usbmidi_lib sfc_siena videodev snd_hda_core snd_rawmidi gf12=
8mul videobuf2_common snd_seq_device crypto_simd mdio snd_pcm mc i2c_des=
ignware_platform cryptd wmi_bmof i2c_piix4 ahci ptp efi_pstore snd_timer=
 i2c_designware_core k10temp i2c_smbus libahci pps_core snd soundcore cc=
p sha1_generic rng_core efivarfs hid_logitech_hidpp hid_lenovo hid_logit=
ech_dj input_leds led_class hid_generic usbhid hid dm_mod amdgpu i2c_alg=
o_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper amdxcp mfd
[  177.216455]  drm_display_helper drm_kms_helper xhci_pci xhci_hcd drm =
cec thermal video wmi evdev
[  177.216458] CPU: 25 UID: 0 PID: 4584 Comm: spill Not tainted 6.12.0-r=
c1-00031-ge32cde8d2bd7-dirty #3
[  177.216459] Hardware name: Gigabyte Technology Co., Ltd. B650M AORUS =
ELITE AX/B650M AORUS ELITE AX, BIOS F32b 09/03/2024
[  177.216459] RIP: 0010:xdp_do_flush+0x7b/0x80
[  177.216460] Code: db 74 16 48 89 df 5b e9 e3 9b af ff 85 c9 74 09 48 =
8b 40 40 48 39 c3 75 e5 5b c3 cc cc cc cc 48 85 ff 74 f5 5b e9 15 7e af =
ff <0f> 0b eb c6 90 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca
[  177.216460] RSP: 0000:ffff8881b892f818 EFLAGS: 00010046
[  177.216461] RAX: 0000000000000000 RBX: ffff88810a603030 RCX: 00000000=
0000000f
[  177.216461] RDX: ffff888109fe88c0 RSI: 0000000000000000 RDI: ffff8881=
b892f838
[  177.216461] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000=
00000000
[  177.216462] R10: 2c545830061c0544 R11: 1ced901e1303e22e R12: ffff8881=
0a603480
[  177.216462] R13: ffff88810a603000 R14: ffff888109fe88c0 R15: ffff8881=
0a603980
[  177.216462] FS:  00000000004d9790(0000) GS:ffff888ffe440000(0000) knl=
GS:0000000000000000
[  177.216463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  177.216463] CR2: 0000000000489418 CR3: 00000001c457a000 CR4: 00000000=
00350ef0
[  177.216464] Call Trace:
[  177.216464]  <TASK>
[  177.216465]  ? __warn+0x81/0x110
[  177.216467]  ? xdp_do_flush+0x7b/0x80
[  177.216468]  ? report_bug+0x14c/0x170
[  177.216469]  ? handle_bug+0x53/0x90
[  177.216470]  ? exc_invalid_op+0x13/0x60
[  177.216471]  ? asm_exc_invalid_op+0x16/0x20
[  177.216472]  ? xdp_do_flush+0x7b/0x80
[  177.216474]  efx_poll+0x178/0x380 [sfc_siena]
[  177.216479]  netpoll_poll_dev+0x118/0x1b0
[  177.216481]  __netpoll_send_skb+0x1ae/0x240
[  177.216482]  netpoll_send_udp+0x2e5/0x400
[  177.216484]  write_msg+0xeb/0x100 [netconsole]
[  177.216486]  console_flush_all+0x261/0x440
[  177.216489]  console_unlock+0x71/0xf0
[  177.216490]  vprintk_emit+0x251/0x2b0
[  177.216491]  _printk+0x48/0x50
[  177.216492]  seq_buf_do_printk+0x62/0xb0
[  177.216493]  mem_cgroup_print_oom_meminfo+0xc6/0x130
[  177.216494]  dump_header+0x52/0x1a0
[  177.216495]  oom_kill_process+0xf2/0x1e0
[  177.216496]  out_of_memory+0xec/0x2f0
[  177.216497]  mem_cgroup_out_of_memory+0x118/0x130
[  177.216498]  try_charge_memcg+0x43a/0x5f0
[  177.216499]  charge_memcg+0x2f/0x70
[  177.216499]  __mem_cgroup_charge+0x2c/0x80
[  177.216500]  filemap_add_folio+0x33/0xc0
[  177.216501]  __filemap_get_folio+0x165/0x2c0
[  177.216502]  filemap_fault+0x5c2/0xc70
[  177.216502]  __do_fault+0x2e/0xb0
[  177.216503]  __handle_mm_fault+0xf13/0x14b0
[  177.216504]  ? copy_fpstate_to_sigframe+0x26e/0x2b0
[  177.216505]  handle_mm_fault+0x1a9/0x2f0
[  177.216506]  do_user_addr_fault+0x1fb/0x600
[  177.216507]  exc_page_fault+0x69/0x110
[  177.216507]  asm_exc_page_fault+0x22/0x30
[  177.216508] RIP: 0033:0x44ace6
[  177.216509] Code: 89 d6 48 c1 ea 0c 81 e6 ff 0f 00 00 48 c1 ee 08 48 =
8d 14 92 48 c1 e2 02 48 03 91 98 00 00 00 0f 1f 44 00 00 48 83 fe 10 73 =
73 <8b> 3a 0f b6 54 32 04 01 fa eb 02 89 fa 48 8b b1 88 00 00 00 8d 7a
[  177.216509] RSP: 002b:000000c00000f310 EFLAGS: 00010287
[  177.216509] RAX: 0000000000046ae0 RBX: 000000c00000f398 RCX: 00000000=
004d5840
[  177.216510] RDX: 0000000000489418 RSI: 000000000000000a RDI: 00000000=
00447ae0
[  177.216510] RBP: 000000c00000f320 R08: 0000000000000000 R09: 00000000=
00000001
[  177.216510] R10: 0000000000000000 R11: 0000000000000041 R12: 00000000=
00000400
[  177.216510] R13: 00007f0b4b43f468 R14: 000000c000006000 R15: 00ffffff=
ffffffff
[  177.216511]  </TASK>
[  177.216511] ---[ end trace 0000000000000000 ]---

I'm out of my depth figuring out why bpf_net_ctx_get() returns NULL. For=
 now I'm simply running with NULL check enabled.

