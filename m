Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725873D001E
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhGTQmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 12:42:13 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:34768
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhGTQmG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Jul 2021 12:42:06 -0400
Received: from localhost (1.general.khfeng.us.vpn [10.172.68.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3BFD84190E;
        Tue, 20 Jul 2021 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626801755;
        bh=5YmhnRLdqZyFJAvdBy/8Yt8zIQhoQiJZyrRN8A2vmhU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=UB35vx9InXtWTrgVgrM7Pl9pS9Mk61ouKzs2KcQpYgan7/mjq7QO2LkhKzvCBFFbJ
         XVZODl+NI9ccNN6d13JUhG4LiD4XWX/7wCkaY6f/P7UT/n+7fFSuhzoLETGWD4Ltiv
         7IX9Lt6YVFpt5ZYjXhTBmxk0EOudw7QccS5pltW7xXKEuXIlDDdZ3w4WpiRPE1DDfp
         937SfjkEd5g6Wkdkm5yKpPox3JRxQ2qM4tvt1kIU1EjkEB4U0vpTdgViiU7MF2CCSZ
         Y+M6XYiEwnGTJqf+ce9U2DQ3DwhHya+/Vjr0jfvIdTURftpNlDP55/pF7aOiiNLZ54
         hJlo7YGyJZjhA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Evan Quan <evan.quan@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH] drm/amdgpu/acp: Make PM domain really work
Date:   Wed, 21 Jul 2021 01:22:15 +0800
Message-Id: <20210720172216.59613-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Devices created by mfd_add_hotplug_devices() don't really increase the
index of its name, so get_mfd_cell_dev() cannot find any device, hence a
NULL dev is passed to pm_genpd_add_device():
[   56.974926] (NULL device *): amdgpu: device acp_audio_dma.0.auto added t=
o pm domain
[   56.974933] (NULL device *): amdgpu: Failed to add dev to genpd
[   56.974941] [drm:amdgpu_device_ip_init [amdgpu]] *ERROR* hw_init of IP b=
lock <acp_ip> failed -22
[   56.975810] amdgpu 0000:00:01.0: amdgpu: amdgpu_device_ip_init failed
[   56.975839] amdgpu 0000:00:01.0: amdgpu: Fatal error during GPU init
[   56.977136] ------------[ cut here ]------------
[   56.977143] kernel BUG at mm/slub.c:4206!
[   56.977158] invalid opcode: 0000 [#1] SMP NOPTI
[   56.977167] CPU: 1 PID: 1648 Comm: modprobe Not tainted 5.12.0-051200rc8=
-generic #202104182230
[   56.977175] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/FM2A68M-HD+, BIOS P5.20 02/13/2019
[   56.977180] RIP: 0010:kfree+0x3bf/0x410
[   56.977195] Code: 89 e7 48 d3 e2 f7 da e8 5f 0d 02 00 80 e7 02 75 3e 44 =
89 ee 4c 89 e7 e8 ef 5f fd ff e9 fa fe ff ff 49 8b 44 24 08 a8 01 75 b7 <0f=
> 0b 4c 8b 4d b0 48 8b 4d a8 48 89 da 4c 89 e6 41 b8 01 00 00 00
[   56.977202] RSP: 0018:ffffa48640ff79f0 EFLAGS: 00010246
[   56.977210] RAX: 0000000000000000 RBX: ffff9286127d5608 RCX: 00000000000=
00000
[   56.977215] RDX: 0000000000000000 RSI: ffffffffc099d0fb RDI: ffff9286127=
d5608
[   56.977220] RBP: ffffa48640ff7a48 R08: 0000000000000001 R09: 00000000000=
00001
[   56.977224] R10: 0000000000000000 R11: ffff9286087d8458 R12: fffff3ae044=
9f540
[   56.977229] R13: 0000000000000000 R14: dead000000000122 R15: dead0000000=
00100
[   56.977234] FS:  00007f9de5929540(0000) GS:ffff928612e80000(0000) knlGS:=
0000000000000000
[   56.977240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.977245] CR2: 00007f697dd97160 CR3: 00000001110f0000 CR4: 00000000001=
506e0
[   56.977251] Call Trace:
[   56.977261]  amdgpu_dm_encoder_destroy+0x1b/0x30 [amdgpu]
[   56.978056]  drm_mode_config_cleanup+0x4f/0x2e0 [drm]
[   56.978147]  ? kfree+0x3dd/0x410
[   56.978157]  ? drm_managed_release+0xc8/0x100 [drm]
[   56.978232]  drm_mode_config_init_release+0xe/0x10 [drm]
[   56.978311]  drm_managed_release+0x9d/0x100 [drm]
[   56.978388]  devm_drm_dev_init_release+0x4d/0x70 [drm]
[   56.978450]  devm_action_release+0x15/0x20
[   56.978459]  release_nodes+0x77/0xc0
[   56.978469]  devres_release_all+0x3f/0x50
[   56.978477]  really_probe+0x245/0x460
[   56.978485]  driver_probe_device+0xe9/0x160
[   56.978492]  device_driver_attach+0xab/0xb0
[   56.978499]  __driver_attach+0x8f/0x150
[   56.978506]  ? device_driver_attach+0xb0/0xb0
[   56.978513]  bus_for_each_dev+0x7e/0xc0
[   56.978521]  driver_attach+0x1e/0x20
[   56.978528]  bus_add_driver+0x135/0x1f0
[   56.978534]  driver_register+0x91/0xf0
[   56.978540]  __pci_register_driver+0x54/0x60
[   56.978549]  amdgpu_init+0x77/0x1000 [amdgpu]
[   56.979246]  ? 0xffffffffc0dbc000
[   56.979254]  do_one_initcall+0x48/0x1d0
[   56.979265]  ? kmem_cache_alloc_trace+0x120/0x230
[   56.979274]  ? do_init_module+0x28/0x280
[   56.979282]  do_init_module+0x62/0x280
[   56.979288]  load_module+0x71c/0x7a0
[   56.979296]  __do_sys_finit_module+0xc2/0x120
[   56.979305]  __x64_sys_finit_module+0x1a/0x20
[   56.979311]  do_syscall_64+0x38/0x90
[   56.979319]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   56.979328] RIP: 0033:0x7f9de54f989d
[   56.979335] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   56.979342] RSP: 002b:00007ffe3c395a28 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   56.979350] RAX: ffffffffffffffda RBX: 0000560df3ef4330 RCX: 00007f9de54=
f989d
[   56.979355] RDX: 0000000000000000 RSI: 0000560df3a07358 RDI: 00000000000=
0000f
[   56.979360] RBP: 0000000000040000 R08: 0000000000000000 R09: 00000000000=
00000
[   56.979365] R10: 000000000000000f R11: 0000000000000246 R12: 0000560df3a=
07358
[   56.979369] R13: 0000000000000000 R14: 0000560df3ef4460 R15: 0000560df3e=
f4330
[   56.979377] Modules linked in: amdgpu(+) iommu_v2 gpu_sched drm_ttm_help=
er ttm drm_kms_helper cec rc_core i2c_algo_bit fb_sys_fops syscopyarea sysf=
illrect sysimgblt nft_counter xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntr=
ack iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_m=
angle iptable_raw iptable_security ip_set nf_tables libcrc32c nfnetlink ip6=
_tables iptable_filter bpfilter input_leds binfmt_misc edac_mce_amd kvm_amd=
 ccp kvm snd_hda_codec_realtek snd_hda_codec_generic crct10dif_pclmul snd_h=
da_codec_hdmi ledtrig_audio ghash_clmulni_intel aesni_intel snd_hda_intel s=
nd_intel_dspcfg snd_seq_midi crypto_simd snd_intel_sdw_acpi cryptd snd_hda_=
codec snd_seq_midi_event snd_rawmidi snd_hda_core snd_hwdep snd_seq fam15h_=
power k10temp snd_pcm snd_seq_device snd_timer snd mac_hid soundcore sch_fq=
_codel nct6775 hwmon_vid drm ip_tables x_tables autofs4 dm_mirror dm_region=
_hash dm_log hid_generic usbhid hid uas usb_storage r8169 crc32_pclmul real=
tek ahci xhci_pci i2c_piix4
[   56.979521]  xhci_pci_renesas libahci video
[   56.979541] ---[ end trace cb8f6a346f18da7b ]---

Instead of finding MFD hotplugged device by its name, simply iterate
over the child devices to avoid the issue.

BugLink: https://bugs.launchpad.net/bugs/1920674
Fixes: 25030321ba28 ("drm/amd: add pm domain for ACP IP sub blocks")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 49 +++++++++++++------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_acp.c
index b8655ff73a658..8522f46d5d725 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -160,17 +160,28 @@ static int acp_poweron(struct generic_pm_domain *genp=
d)
 	return 0;
 }
=20
-static struct device *get_mfd_cell_dev(const char *device_name, int r)
+static int acp_genpd_add_device(struct device *dev, void *data)
 {
-	char auto_dev_name[25];
-	struct device *dev;
+	struct generic_pm_domain *gpd =3D data;
+	int ret;
+
+	ret =3D pm_genpd_add_device(gpd, dev);
+	if (ret)
+		dev_err(dev, "Failed to add dev to genpd %d\n", ret);
=20
-	snprintf(auto_dev_name, sizeof(auto_dev_name),
-		 "%s.%d.auto", device_name, r);
-	dev =3D bus_find_device_by_name(&platform_bus_type, NULL, auto_dev_name);
-	dev_info(dev, "device %s added to pm domain\n", auto_dev_name);
+	return ret;
+}
=20
-	return dev;
+static int acp_genpd_remove_device(struct device *dev, void *data)
+{
+	int ret;
+
+	ret =3D pm_genpd_remove_device(dev);
+	if (ret)
+		dev_err(dev, "Failed to remove dev from genpd %d\n", ret);
+
+	/* Continue to remove */
+	return 0;
 }
=20
 /**
@@ -341,15 +352,10 @@ static int acp_hw_init(void *handle)
 	if (r)
 		goto failure;
=20
-	for (i =3D 0; i < ACP_DEVS ; i++) {
-		dev =3D get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
-		r =3D pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
-		if (r) {
-			dev_err(dev, "Failed to add dev to genpd\n");
-			goto failure;
-		}
-	}
-
+	r =3D device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
+				  acp_genpd_add_device);
+	if (r)
+		goto failure;
=20
 	/* Assert Soft reset of ACP */
 	val =3D cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
@@ -458,13 +464,8 @@ static int acp_hw_fini(void *handle)
 		udelay(100);
 	}
=20
-	for (i =3D 0; i < ACP_DEVS ; i++) {
-		dev =3D get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
-		ret =3D pm_genpd_remove_device(dev);
-		/* If removal fails, dont giveup and try rest */
-		if (ret)
-			dev_err(dev, "remove dev from genpd failed\n");
-	}
+	device_for_each_child(adev->acp.parent, NULL,
+			      acp_genpd_remove_device);
=20
 	mfd_remove_devices(adev->acp.parent);
 	kfree(adev->acp.acp_res);
--=20
2.31.1

