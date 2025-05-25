Return-Path: <bpf+bounces-58907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96FEAC344C
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 13:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332E7175CA8
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09771F2BB5;
	Sun, 25 May 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="VOy7AmlJ"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46091DF26B;
	Sun, 25 May 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748174109; cv=none; b=kgNSucvyHtsbiQBGHOcaq4MZ4BU1ogeKnGZBiq24/15EMFk2Kam/t4AFDQewUgmdvhsR/fFTIx3GMZoxEWlf/XLY9jnN669yx+Nc0mQNHi67exAl8C8dQEkazIzr79D1Zz+NX0HA2mNppeQp7FKpuIgk5DqHoR8rxMdp+D/5Qlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748174109; c=relaxed/simple;
	bh=YjWZk96XYZTt6E1jewxusAGsKLFicY3r6Q4aQz6YD2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nw6UFUCbQhmbNxiSl7lPigkO6iOA6gzu7cbYsdvXmohvIdrcCGKHDMqa0uvSoWz0cyQlZdTNOGn5IcQbXbjyFhHEFL6LbVYNk4zXEHBrS1qCqzsZe8cXMtZ7Ttcvyqm9YNqYdwmoGUeTXzRknYf9Vbp8p6Zu15ZnXcahGjkrwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=VOy7AmlJ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748174086; x=1748778886; i=spasswolf@web.de;
	bh=zDo2qUQEoBkCdLj2EFYA2QmC0e5zrCeQS6bJfHQTJfQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VOy7AmlJ7629Z3zjfdSobq6FZYZpW5cv9IOpwli4x3mjKKKBQHuZZLr93cbqqBsf
	 XZ/BCW3Neq1ciSPHCOptaFRGsjTpvNeOOem+d4Ol3td/VTqZXJUisreFge1eYoIwK
	 e5g7t3olp1/yyQ44YUgJxdgupxmJyar9kq5kFl/zkNAmchveeheLI9vsxXrVxhyQT
	 dCV7vf968/Rx16SnG4hWHoPQ8W0NDFv1wu6XrxrPok97noa2sTVlKkQrEUPMx0u/H
	 /UZm6/dis3acFEK0Z7s5/z9OjIRD5RYypMmQHuS3eZTNfWQ9dwJhDHc3Ozh5ZUzBv
	 PtcvMQZZgSa+ps03AQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mfc8o-1uqJy93mrQ-00abDb; Sun, 25 May 2025 13:54:46 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-rt-devel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
Date: Sun, 25 May 2025 13:54:42 +0200
Message-ID: <20250525115443.13378-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yx9wMh2Do9oSdPoVBKRyJuLh+qmdyiHhr/ji9RVCYbvgoaliv8F
 FfR1NGp3nmaAID+u+g3SGnfWq/RoJP1htbkWMEOkwyjGfSRVA+ygXsVVulXwz40YTGuqtT1
 aKUGD+l0RaBnmfetAXo5XQM4/GMEHssc6muvC703zdIMM2XlJHLJ7bYrVJuczjg+ItbftpK
 g//195gUg3C5aNLKGVFFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:43Jivoxrw2Y=;4Ix7opDkN0mF/Ih1O+7VjRat9Lw
 WGSq/H0GKFlYIbnA3YhqpjcKz2yWXW/SR49P0/0n6yPM89P56by6FBGkAoXUNUhecY3xeZSek
 FkbCIXytC2z7Ide9nINhAJUMy6KermFdad65vgp0hR87CarHSPwn6o+FCujDn7zOJeeXLSUh7
 PsadW18xoyzaPd96YguuD9Ylc74IMrs4C5+RM+75A9NHPgFGmrmCENbvozh04cIO1Edk8q7Qy
 cev+ha3P2dBMREEQgFc6lonnJIQ12BNHURQf/t9PwUI+wmEstpTnLRI7ehaD1U0ifC/6SJbjB
 0uEH5PBGEeP/jIqmxVfys+R441KEDsncvB8VIvXEyBtVPC0+H+1H7xn1o/Lesg19+1tYyHWiR
 tqCixwuXnd5JY2AIn60G0Z0D1mAwwaOqZJceScRt8nMARHyiPLoSpDxUtyvPrUV3w97vvVHN0
 hh/J92IeCuDpq64l3SRm4QCYLEu2ygSLxMwuAgboDnfuFAvOaY09S4l8vPLn/Pnift8aa3aSL
 0vgrWj5+3Wi+L5i6O98jkhcou4wpn40+9bnnL8A+UKtNXApCZFIXNBsorN4LyRmTFQHOSDZm7
 FvacUzGDbZdnLkUGHaIKNvLItjXhzCUihpE4+oMP0RxNDROl/nsuBrZBmIkQoKdYgiBGR2Xnc
 F+ETMfFB1t1OfXhMhpcl9QCu6OP0mXm61imrVVcvtA8Sa5jbf0EQJoWV5Kw1n5g7Hu/jBHcdx
 JIB9VxXMDm8zYVxmjw2Ugtwx/Bz5ENymO4HgpSgBGxViJ3NC49LiPgGmY1cCg85VDsQnlZmhh
 qvf3If4IuqBrm7kgZlDEsG5wHu0WtTisJh2S41r5oGHuzCWyJuuhFSQbnvqz0/IJrz8Xh/sNF
 nqJORYm4N5wryvtG5DO9wwT57OvN46mYUfGG+d2klC/juc3yrcYbv4N/V3SmZtJaoQ8qlSmYu
 kM2POOoUSIoGgoD/hN1xM0bdv/J30Q4/OlRt+t5qjRtHZdAoWwuFPhzcnlpB6Ysi1yrReSpiX
 LBUGzUTY0R6rhwmUnhQ/GncVf0d/ovRT3b3R2XgegGwfWixr5UzW+PTrzSv5HnIYN1U8uX1xT
 SC+7SPxKbnwzJQLuQJN/Jh6qrWQ8m0SNTDvrYd5lrj8F+NGIqr6UHeCdncO545ZNZXVzPfWP5
 UbURgZk1Id1HcNO/yM4cZVjtUs4WXS7p+FIdiexXcUZrp0S+/Bkk6cZr6w4vCHZpBZb1/E6vb
 QZYg48Ymjq775yNRrjifb/ikAdzW9cRWAWB5cDVGkQ65I3UiA9Eq4KeEaGVTeXVrdHbe92Scg
 04eZw1lMmBOX8v3STBf8w0YSj4e6othRRBtLof2HrEGkJNlpMDHSMkOfKdtV7+ETPaHP7R5uI
 KT4Cdnw3OtafxIojGheDAV9WYQBun4c0f/RHb9E4iMmBaLp2W7dUltlLmCTGnd/QPXwjzgnQd
 R5xMCl1YqHl2dgMdmUzyzv5W+csll+U8ag6tfYPyEKdnSDNNASmg/5podVeyGQR3MtYB2Y3sW
 GlSiFe6TPCuVsWkQP16Kg6OuoHleupbTNN8PGWbR0caTMlm132s9fGzuVg34iWpkpvClSNN1E
 XceUGzW//3WtISllruMqF/pMq2zyBEqGdyJkptGd1IIMVVtwxkL83V923qHR41TjD7BEff9kT
 +pBY8PtzZsn/gVcj5l4USn3jG2jpkj3INAJQBrzR+dr+fHAICJAPzSMSR3NTh7Z2o/9X9mDXS
 ERTGoLn/wts3/kXkIxlNUDG0Wpiw6eJ5bvo0o12/nEmJktRlTkwWREwxUvPRwafim+dLlyklg
 3HDjv/e1O3fL2MAh1LPVdhGwsTVx6ieqOdPVHF7DFC6YdAfL/noMXYA7PuikwWskzDcmgFDnK
 nZQHr5FDPb+f5i+2fZBu8VccCE6ta/tjRzTShbgBjLHXDhgJtJHw8rz4+acZ8QxiOZ6iXb8kq
 hwhgJCdENYEwS8TOPvMQSZB0QrBCRKMZ2GTGzy34kNvW51Z54ZKizRSMXgWW1E7624mt8Xwj4
 sLPO0sN+EZiaEneHM3384BL1bVmkTGK0gscBisFreyiJbvQ/XS4K6nBOyTSV517quiM4anDpY
 u6ZO++8CB5/h6sG8iF6GBGc0E1QUtoHDhNxXCtT9yEkEgDcCcjYGWYlfrBHpqOUhjqDRhtu+z
 fMEerjJdgD0AgspE0e+jBbwqcqcBmwwZJu3jBCbpQwrxIZWPa4xV/71Aaddx32/3bUyRZIadR
 q69glFHkqhYRlbVQQ+VKpZs3eWQxcBrh0p3c2O0PKUg4HpBXOwPWJQrfNHXZvQfoVeHZmvGPB
 l/0Z8bgHBywti4Es1UblUYXBZo8aPjwGW6BA8LnjPTAWq7URkdQeAWGdw1P8VP0FfJcaJrAmi
 +XbTn7DaAnGungQzQ0WEPFOk0Oa7usRBC8Ym5B9zauoGyavb7kf8IA9TU8wWLN6ndPy+9jIw0
 faxB619KiolDKKZ2zr87UwtRHY2Oij+1WIydjzJ/TrfyirLdNvve5AfRVpT1kHECXVXBF5AV3
 yf+FD0BSIJOSV7LpdV+DaDGQMMtNmdVGfXiaAg2FT0QfrUqGkQW6roOS8wtL96692Jcj9qbp2
 K/eaCT6X7v9Gf/oj69EkRYGCDztQy5NZG3a8T2PD0hZTwOd8Q95ZGH04W5qumE0O9qYWVkRPU
 BT0xejoLWvAjUXp6QkywcVhs3T+Lf81OgClMaRAEH1YxEezJpsJVhDrebTYDy8hnoaGk9/4vI
 9oSWfx2xoi9m3xbJy6Zy0VX9Ngv/pMigjseXQ3Pb+Re1CKwi6iD7mjh+OwpII948h76lvV51X
 6GczAIB++FXJUL9741M5BCAxEbF4/7N40XTdDwzN2l+8XeG7rl8hPEICYnU0hm1CWeTUnZ0tf
 G9rG3eLjviZtQtatD4Xd+qlCZCZnLKhEJb3qGxVC3Dh5RdwoqRvXM7WUkE16OcHJWIML4732j
 uyRUgHkQebTUVnfYA4XxJsxp1e/zFXDnJPUD38b4AEYy3ltZXEYLceYjfM8JO4rlVOyt4Fbtj
 oeGVCvAU/mJnE54tTEODREipfEqRGRC8Ro3cEOXuZMKfSPt/na77xWpUFQJkq6TlgAQldvd8y
 gjTGoLCQc5QPA=

When running the bpf selftests while watching a video on youtube on a realt=
ime
enabled kernel (i.e. PREEMPT_RT=3Dy) I get frequent system lockups with the=
 message=20
"BUG: scheduling while atomic".
Affected versions are next-20250523, v6.15-rc7, v6.14, v6.13, v6.12. When c=
ompiling
without PREEMPT_RT=3Dy the bug does not occur.

Here is an error message (captured with netconsole) from next-20250523 (I s=
orted
the messages by thread Id, in the original capture they were mixed up):

[  247.626280][ T2569] BUG: scheduling while atomic: ImageBridgeChld/2569/0=
x00000002
[  247.626285][ T2569] Modules linked in: bpf_testmod(O) netconsole ccm snd=
_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_seq rfcomm bnep =
nls_ascii nls_cp437
[  247.626299][ T2569]  vfat
[  247.626300][ T2569]  fat
[  247.626302][ T2569]  snd_ctl_led
[  247.626303][ T2569]  snd_hda_codec_realtek
[  247.626304][ T2569]  snd_hda_codec_generic
[  247.626306][ T2569]  snd_hda_scodec_component
[  247.626308][ T2569]  snd_hda_codec_hdmi
[  247.626309][ T2569]  snd_usb_audio
[  247.626310][ T2569]  btusb
[  247.626311][ T2569]  snd_hda_intel
[  247.626312][ T2569]  btrtl
[  247.626314][ T2569]  snd_intel_dspcfg
[  247.626315][ T2569]  btintel
[  247.626317][ T2569]  btbcm
[  247.626317][ T2569]  snd_soc_dmic
[  247.626319][ T2569]  snd_acp3x_pdm_dma
[  247.626320][ T2569]  snd_acp3x_rn
[  247.626321][ T2569]  snd_usbmidi_lib
[  247.626322][ T2569]  snd_hda_codec
[  247.626324][ T2569]  uvcvideo
[  247.626326][ T2569]  btmtk
[  247.626327][ T2569]  snd_ump
[  247.626328][ T2569]  snd_soc_core
[  247.626329][ T2569]  videobuf2_vmalloc
[  247.626330][ T2569]  snd_hwdep
[  247.626332][ T2569]  videobuf2_memops
[  247.626333][ T2569]  uvc
[  247.626334][ T2569]  bluetooth
[  247.626335][ T2569]  snd_hda_core
[  247.626337][ T2569]  snd_rawmidi
[  247.626338][ T2569]  videobuf2_v4l2
[  247.626339][ T2569]  snd_seq_device
[  247.626340][ T2569]  snd_pcm_oss
[  247.626341][ T2569]  videodev
[  247.626343][ T2569]  snd_mixer_oss
[  247.626343][ T2569]  snd_rn_pci_acp3x
[  247.626345][ T2569]  ecdh_generic
[  247.626346][ T2569]  snd_pcm
[  247.626347][ T2569]  ecc
[  247.626349][ T2569]  snd_acp_config
[  247.626350][ T2569]  videobuf2_common
[  247.626351][ T2569]  snd_soc_acpi
[  247.626352][ T2569]  msi_wmi
[  247.626353][ T2569]  snd_timer
[  247.626354][ T2569]  mc
[  247.626356][ T2569]  sparse_keymap
[  247.626357][ T2569]  snd
[  247.626358][ T2569]  edac_mce_amd
[  247.626359][ T2569]  wmi_bmof
[  247.626360][ T2569]  k10temp
[  247.626362][ T2569]  snd_pci_acp3x
[  247.626363][ T2569]  soundcore
[  247.626364][ T2569]  ccp
[  247.626365][ T2569]  battery
[  247.626367][ T2569]  ac
[  247.626368][ T2569]  sch_fq_codel
[  247.626370][ T2569]  button
[  247.626371][ T2569]  joydev
[  247.626373][ T2569]  hid_sensor_accel_3d
[  247.626374][ T2569]  hid_sensor_prox
[  247.626375][ T2569]  hid_sensor_gyro_3d
[  247.626376][ T2569]  hid_sensor_als
[  247.626377][ T2569]  hid_sensor_magn_3d
[  247.626379][ T2569]  hid_sensor_trigger
[  247.626380][ T2569]  industrialio_triggered_buffer
[  247.626381][ T2569]  kfifo_buf
[  247.626382][ T2569]  industrialio
[  247.626384][ T2569]  evdev
[  247.626385][ T2569]  amd_pmc
[  247.626387][ T2569]  hid_sensor_iio_common
[  247.626389][ T2569]  mt7921e
[  247.626390][ T2569]  mt7921_common
[  247.626392][ T2569]  mt792x_lib
[  247.626393][ T2569]  mt76_connac_lib
[  247.626395][ T2569]  mt76
[  247.626396][ T2569]  mac80211
[  247.626398][ T2569]  libarc4
[  247.626399][ T2569]  cfg80211
[  247.626400][ T2569]  rfkill
[  247.626402][ T2569]  msr
[  247.626403][ T2569]  fuse
[  247.626404][ T2569]  nvme_fabrics
[  247.626406][ T2569]  efi_pstore
[  247.626408][ T2569]  configfs
[  247.626409][ T2569]  nfnetlink
[  247.626410][ T2569]  efivarfs
[  247.626413][ T2569]  autofs4
[  247.626414][ T2569]  ext4
[  247.626415][ T2569]  mbcache
[  247.626417][ T2569]  jbd2
[  247.626419][ T2569]  usbhid
[  247.626420][ T2569]  amdgpu
[  247.626422][ T2569]  amdxcp
[  247.626423][ T2569]  i2c_algo_bit
[  247.626425][ T2569]  drm_client_lib
[  247.626426][ T2569]  drm_ttm_helper
[  247.626428][ T2569]  ttm
[  247.626429][ T2569]  drm_exec
[  247.626430][ T2569]  gpu_sched
[  247.626432][ T2569]  xhci_pci
[  247.626433][ T2569]  drm_suballoc_helper
[  247.626435][ T2569]  drm_panel_backlight_quirks
[  247.626436][ T2569]  xhci_hcd
[  247.626439][ T2569]  cec
[  247.626440][ T2569]  hid_sensor_hub
[  247.626441][ T2569]  hid_multitouch
[  247.626443][ T2569]  drm_buddy
[  247.626444][ T2569]  mfd_core
[  247.626445][ T2569]  hid_generic
[  247.626446][ T2569]  drm_display_helper
[  247.626448][ T2569]  psmouse
[  247.626449][ T2569]  nvme
[  247.626450][ T2569]  i2c_hid_acpi
[  247.626451][ T2569]  usbcore
[  247.626453][ T2569]  amd_sfh
[  247.626454][ T2569]  i2c_hid
[  247.626456][ T2569]  serio_raw
[  247.626457][ T2569]  drm_kms_helper
[  247.626459][ T2569]  hid
[  247.626462][ T2569]  nvme_core
[  247.626463][ T2569]  r8169
[  247.626465][ T2569]  i2c_piix4
[  247.626466][ T2569]  usb_common
[  247.626468][ T2569]  crc16
[  247.626470][ T2569]  i2c_smbus
[  247.626471][ T2569]  i2c_designware_platform
[  247.626472][ T2569]  i2c_designware_core
[  247.626474][ T2569]  [last unloaded: bpf_testmod(O)]
[  247.626476][ T2569]=20
[  247.626734][ T2569] CPU: 12 UID: 1000 PID: 2569 Comm: ImageBridgeChld Ta=
inted: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{=
RT,(full)}=20
[  247.626739][ T2569] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.626740][ T2569] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.626742][ T2569] Call Trace:
[  247.626742][ T2569]  <TASK>
[  247.626744][ T2569]  dump_stack_lvl+0x6d/0xb0
[  247.626749][ T2569]  __schedule_bug.cold+0x3e/0x4a
[  247.626751][ T2569]  __schedule+0x1440/0x1c90
[  247.626755][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626757][ T2569]  ? ____sys_sendmsg+0x335/0x370
[  247.626759][ T2569]  ? copy_msghdr_from_user+0xea/0x170
[  247.626763][ T2569]  schedule_rtlock+0x30/0xd0
[  247.626765][ T2569]  rtlock_slowlock_locked+0x327/0xfb0
[  247.626771][ T2569]  rt_spin_lock+0x7a/0xd0
[  247.626774][ T2569]  task_get_cgroup1+0x6c/0xf0
[  247.626778][ T2569]  bpf_task_get_cgroup1+0xe/0x20
[  247.626782][ T2569]  bpf_prog_28ba4edb92179f43_on_enter+0x47/0x128
[  247.626784][ T2569]  bpf_trace_run2+0x77/0xf0
[  247.626787][ T2569]  __bpf_trace_sys_enter+0x10/0x30
[  247.626790][ T2569]  syscall_trace_enter+0x157/0x1c0
[  247.626792][ T2569]  do_syscall_64+0x2dc/0xfa0
[  247.626795][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626798][ T2569]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.626800][ T2569] RIP: 0033:0x7fbfd96fd9ee
[  247.626806][ T2569] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d=
7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0=
f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  247.626808][ T2569] RSP: 002b:00007fbfc68ed8f8 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000ca
[  247.626810][ T2569] RAX: ffffffffffffffda RBX: 00007fbfc68ee6c0 RCX: 000=
07fbfd96fd9ee
[  247.626812][ T2569] RDX: 0000000000000faa RSI: 0000000000000189 RDI: 000=
07fbfc6c1f4d0
[  247.626813][ T2569] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
00000ffffffff
[  247.626814][ T2569] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
[  247.626815][ T2569] R13: 00007fbfc6c1f480 R14: 0000000000000fac R15: 000=
0000000001f58
[  247.626820][ T2569]  </TASK>
[  247.626863][ T2569] BUG: scheduling while atomic: ImageBridgeChld/2569/0=
x00000000
[  247.626866][ T2569] Modules linked in:
[  247.626867][ T2569]  bpf_testmod(O)
[  247.626868][ T2569]  netconsole ccm
[  247.626870][ T2569]  snd_seq_dummy
[  247.626871][ T2569]  snd_hrtimer
[  247.626872][ T2569]  snd_seq_midi
[  247.626873][ T2569]  snd_seq_midi_event snd_seq
[  247.626875][ T2569]  rfcomm
[  247.626875][ T2569]  bnep
[  247.626877][ T2569]  nls_ascii
[  247.626878][ T2569]  nls_cp437
[  247.626879][ T2569]  vfat
[  247.626880][ T2569]  fat
[  247.626881][ T2569]  snd_ctl_led
[  247.626882][ T2569]  snd_hda_codec_realtek
[  247.626883][ T2569]  snd_hda_codec_generic
[  247.626884][ T2569]  snd_hda_scodec_component
[  247.626885][ T2569]  snd_hda_codec_hdmi
[  247.626886][ T2569]  snd_usb_audio
[  247.626887][ T2569]  btusb
[  247.626888][ T2569]  snd_hda_intel
[  247.626888][ T2569]  btrtl
[  247.626890][ T2569]  snd_intel_dspcfg
[  247.626891][ T2569]  btintel
[  247.626892][ T2569]  btbcm
[  247.626893][ T2569]  snd_soc_dmic
[  247.626894][ T2569]  snd_acp3x_pdm_dma
[  247.626895][ T2569]  snd_acp3x_rn
[  247.626896][ T2569]  snd_usbmidi_lib
[  247.626911][ T2569]  snd_hda_codec
[  247.626913][ T2569]  uvcvideo
[  247.626914][ T2569]  btmtk
[  247.626915][ T2569]  snd_ump
[  247.626915][ T2569]  snd_soc_core
[  247.626916][ T2569]  videobuf2_vmalloc
[  247.626917][ T2569]  snd_hwdep
[  247.626918][ T2569]  videobuf2_memops
[  247.626919][ T2569]  uvc
[  247.626920][ T2569]  bluetooth
[  247.626921][ T2569]  snd_hda_core snd_rawmidi
[  247.626923][ T2569]  videobuf2_v4l2
[  247.626924][ T2569]  snd_seq_device
[  247.626925][ T2569]  snd_pcm_oss
[  247.626926][ T2569]  videodev
[  247.626926][ T2569]  snd_mixer_oss
[  247.626927][ T2569]  snd_rn_pci_acp3x
[  247.626928][ T2569]  ecdh_generic snd_pcm
[  247.626930][ T2569]  ecc snd_acp_config
[  247.626932][ T2569]  videobuf2_common
[  247.626933][ T2569]  snd_soc_acpi
[  247.626934][ T2569]  msi_wmi
[  247.626935][ T2569]  snd_timer
[  247.626936][ T2569]  mc
[  247.626937][ T2569]  sparse_keymap
[  247.626938][ T2569]  snd
[  247.626939][ T2569]  edac_mce_amd
[  247.626940][ T2569]  wmi_bmof
[  247.626941][ T2569]  k10temp
[  247.626942][ T2569]  snd_pci_acp3x
[  247.626943][ T2569]  soundcore
[  247.626945][ T2569]  ccp
[  247.626946][ T2569]  battery
[  247.626947][ T2569]  ac
[  247.626948][ T2569]  sch_fq_codel
[  247.626949][ T2569]  button
[  247.626950][ T2569]  joydev
[  247.626951][ T2569]  hid_sensor_accel_3d
[  247.626952][ T2569]  hid_sensor_prox
[  247.626953][ T2569]  hid_sensor_gyro_3d
[  247.626954][ T2569]  hid_sensor_als
[  247.626956][ T2569]  hid_sensor_magn_3d
[  247.626957][ T2569]  hid_sensor_trigger
[  247.626959][ T2569]  industrialio_triggered_buffer
[  247.626960][ T2569]  kfifo_buf
[  247.626961][ T2569]  industrialio
[  247.626962][ T2569]  evdev
[  247.626963][ T2569]  amd_pmc
[  247.626965][ T2569]  hid_sensor_iio_common
[  247.626966][ T2569]  mt7921e
[  247.626967][ T2569]  mt7921_common
[  247.626968][ T2569]  mt792x_lib
[  247.626970][ T2569]  mt76_connac_lib
[  247.626971][ T2569]  mt76
[  247.626972][ T2569]  mac80211
[  247.626973][ T2569]  libarc4
[  247.626974][ T2569]  cfg80211
[  247.626976][ T2569]  rfkill
[  247.626977][ T2569]  msr
[  247.626978][ T2569]  fuse
[  247.626979][ T2569]  nvme_fabrics
[  247.626980][ T2569]  efi_pstore
[  247.626982][ T2569]  configfs
[  247.626984][ T2569]  nfnetlink
[  247.626984][ T2569]  efivarfs
[  247.626987][ T2569]  autofs4
[  247.626989][ T2569]  ext4
[  247.626990][ T2569]  mbcache
[  247.626991][ T2569]  jbd2
[  247.626993][ T2569]  usbhid
[  247.626994][ T2569]  amdgpu
[  247.626995][ T2569]  amdxcp
[  247.626997][ T2569]  i2c_algo_bit
[  247.626998][ T2569]  drm_client_lib
[  247.626999][ T2569]  drm_ttm_helper
[  247.627000][ T2569]  ttm
[  247.627002][ T2569]  drm_exec
[  247.627003][ T2569]  gpu_sched
[  247.627005][ T2569]  xhci_pci
[  247.627006][ T2569]  drm_suballoc_helper
[  247.627007][ T2569]  drm_panel_backlight_quirks
[  247.627009][ T2569]  xhci_hcd
[  247.627011][ T2569]  cec
[  247.627012][ T2569]  hid_sensor_hub
[  247.627014][ T2569]  hid_multitouch
[  247.627015][ T2569]  drm_buddy
[  247.627017][ T2569]  mfd_core
[  247.627019][ T2569]  hid_generic
[  247.627020][ T2569]  drm_display_helper
[  247.627021][ T2569]  psmouse
[  247.627022][ T2569]  nvme
[  247.627023][ T2569]  i2c_hid_acpi
[  247.627025][ T2569]  usbcore
[  247.627026][ T2569]  amd_sfh
[  247.627027][ T2569]  i2c_hid
[  247.627029][ T2569]  serio_raw
[  247.627030][ T2569]  drm_kms_helper
[  247.627032][ T2569]  hid
[  247.627033][ T2569]  nvme_core
[  247.627035][ T2569]  r8169
[  247.627036][ T2569]  i2c_piix4
[  247.627037][ T2569]  usb_common
[  247.627038][ T2569]  crc16
[  247.627039][ T2569]  i2c_smbus
[  247.627040][ T2569]  i2c_designware_platform i2c_designware_core
[  247.627042][ T2569]  [last unloaded: bpf_testmod(O)]
[  247.627043][ T2569]=20
[  247.627171][ T2569] CPU: 0 UID: 1000 PID: 2569 Comm: ImageBridgeChld Tai=
nted: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{R=
T,(full)}=20
[  247.627174][ T2569] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.627175][ T2569] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.627176][ T2569] Call Trace:
[  247.627177][ T2569]  <TASK>
[  247.627178][ T2569]  dump_stack_lvl+0x6d/0xb0
[  247.627182][ T2569]  __schedule_bug.cold+0x3e/0x4a
[  247.627184][ T2569]  __schedule+0x1440/0x1c90
[  247.627186][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627188][ T2569]  ? sched_clock_cpu+0x11f/0x1f0
[  247.627190][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627191][ T2569]  ? psi_group_change+0x1c9/0x4b0
[  247.627194][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627195][ T2569]  ? futex_hash_put+0x50/0xa0
[  247.627197][ T2569]  schedule+0x41/0x1a0
[  247.627199][ T2569]  futex_do_wait+0x38/0x70
[  247.627201][ T2569]  __futex_wait+0x91/0x100
[  247.627203][ T2569]  ? __pfx_futex_wake_mark+0x10/0x10
[  247.627206][ T2569]  futex_wait+0x6b/0x110
[  247.627208][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627209][ T2569]  ? futex_wake+0xb2/0x1c0
[  247.627211][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627213][ T2569]  ? __seccomp_filter+0x37/0x590
[  247.627215][ T2569]  do_futex+0xcb/0x190
[  247.627217][ T2569]  __x64_sys_futex+0x10b/0x1c0
[  247.627221][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627223][ T2569]  do_syscall_64+0x6f/0xfa0
[  247.627226][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627229][ T2569]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.627231][ T2569] RIP: 0033:0x7fbfd96fd9ee
[  247.627237][ T2569] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d=
7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0=
f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  247.627239][ T2569] RSP: 002b:00007fbfc68ed8f8 EFLAGS: 00000246
[  247.627241][ T2569]  ORIG_RAX: 00000000000000ca
[  247.627242][ T2569] RAX: ffffffffffffffda RBX: 00007fbfc68ee6c0 RCX: 000=
07fbfd96fd9ee
[  247.627244][ T2569] RDX: 0000000000000fab RSI: 0000000000000189 RDI: 000=
07fbfc6c1f4d4
[  247.627245][ T2569] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
00000ffffffff
[  247.627246][ T2569] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
[  247.627247][ T2569] R13: 00007fbfc6c1f480 R14: 0000000000000fad R15: 000=
0000000001f5b
[  247.627251][ T2569]  </TASK>
[  247.627275][ T2569] ------------[ cut here ]------------
[  247.627277][ T2569] WARNING: CPU: 0 PID: 2569 at kernel/sched/sched.h:24=
90 __pick_next_task+0x187/0x1a0
[  247.627292][ T2569]  snd_ctl_led
[  247.627292][ T2569]  snd_hda_codec_realtek
[  247.627293][ T2569]  snd_hda_codec_generic snd_hda_scodec_component
[  247.627294][ T2569]  snd_hda_codec_hdmi
[  247.627295][ T2569]  snd_usb_audio
[  247.627296][ T2569]  btusb snd_hda_intel
[  247.627297][ T2569]  btrtl
[  247.627298][ T2569]  snd_intel_dspcfg
[  247.627299][ T2569]  btintel btbcm
[  247.627300][ T2569]  snd_soc_dmic
[  247.627301][ T2569]  snd_acp3x_pdm_dma
[  247.627302][ T2569]  snd_acp3x_rn
[  247.627303][ T2569]  snd_usbmidi_lib
[  247.627304][ T2569]  snd_hda_codec
[  247.627305][ T2569]  uvcvideo
[  247.627306][ T2569]  btmtk
[  247.627306][ T2569]  snd_ump
[  247.627307][ T2569]  snd_soc_core
[  247.627308][ T2569]  videobuf2_vmalloc
[  247.627309][ T2569]  snd_hwdep
[  247.627311][ T2569]  videobuf2_memops
[  247.627311][ T2569]  uvc bluetooth
[  247.627313][ T2569]  snd_hda_core
[  247.627314][ T2569]  snd_rawmidi
[  247.627315][ T2569]  videobuf2_v4l2
[  247.627315][ T2569]  snd_seq_device
[  247.627316][ T2569]  snd_pcm_oss
[  247.627317][ T2569]  videodev
[  247.627318][ T2569]  snd_mixer_oss snd_rn_pci_acp3x
[  247.627320][ T2569]  ecdh_generic
[  247.627325][ T2569]  snd_soc_acpi
[  247.627325][ T2569]  msi_wmi
[  247.627326][ T2569]  snd_timer mc
[  247.627328][ T2569]  sparse_keymap
[  247.627329][ T2569]  snd
[  247.627330][ T2569]  edac_mce_amd
[  247.627331][ T2569]  wmi_bmof
[  247.627332][ T2569]  k10temp
[  247.627333][ T2569]  snd_pci_acp3x
[  247.627334][ T2569]  soundcore
[  247.627335][ T2569]  ccp
[  247.627336][ T2569]  battery
[  247.627337][ T2569]  ac
[  247.627339][ T2569]  sch_fq_codel
[  247.627339][ T2569]  button
[  247.627340][ T2569]  joydev
[  247.627341][ T2569]  hid_sensor_accel_3d hid_sensor_prox
[  247.627343][ T2569]  hid_sensor_gyro_3d
[  247.627344][ T2569]  hid_sensor_als
[  247.627345][ T2569]  hid_sensor_magn_3d
[  247.627346][ T2569]  hid_sensor_trigger
[  247.627347][ T2569]  industrialio_triggered_buffer
[  247.627348][ T2569]  kfifo_buf
[  247.627349][ T2569]  industrialio
[  247.627350][ T2569]  evdev
[  247.627351][ T2569]  amd_pmc
[  247.627352][ T2569]  hid_sensor_iio_common mt7921e
[  247.627365][ T2569]  amdxcp i2c_algo_bit drm_client_lib
[  247.627366][ T2569]  drm_ttm_helper
[  247.627367][ T2569]  ttm drm_exec gpu_sched xhci_pci drm_suballoc_helper
[  247.627370][ T2569]  drm_panel_backlight_quirks xhci_hcd cec hid_sensor_=
hub hid_multitouch drm_buddy
[  247.627373][ T2569]  mfd_core hid_generic drm_display_helper psmouse
[  247.627375][ T2569]  nvme i2c_hid_acpi usbcore amd_sfh
[  247.627377][ T2569]  i2c_hid serio_raw drm_kms_helper hid
[  247.627379][ T2569]  nvme_core r8169 i2c_piix4 usb_common crc16 i2c_smbus
[  247.627382][ T2569]  i2c_designware_platform i2c_designware_core [last u=
nloaded: bpf_testmod(O)]
[  247.627385][ T2569] CPU: 0 UID: 1000 PID: 2569 Comm: ImageBridgeChld Tai=
nted: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{R=
T,(full)}=20
[  247.627388][ T2569] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.627389][ T2569] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.627390][ T2569] RIP: 0010:__pick_next_task+0x187/0x1a0
[  247.627392][ T2569] Code: 00 48 8b 04 24 48 83 c4 08 5b 5d 41 5c 41 5d e=
9 8a 54 d7 ff 4c 89 e7 e8 c7 b5 01 00 4d 3b ac 24 88 0a 00 00 0f 84 6c ff f=
f ff <0f> 0b e9 65 ff ff ff 49 8b 9d b0 02 00 00 e9 e8 fe ff ff 0f 0b 90
[  247.627393][ T2569] RSP: 0018:ffffd115542e7c18 EFLAGS: 00010002
[  247.627395][ T2569] RAX: ffff892540ad9080 RBX: ffffffff918a6e98 RCX: 000=
0000000000000
[  247.627396][ T2569] RDX: 0000000000000000 RSI: ffff892541074200 RDI: fff=
f8933ee82c300
[  247.627397][ T2569] RBP: ffffffff918a6f80 R08: 00000000ffff333d R09: 000=
0000000000000
[  247.627398][ T2569] R10: ffff89254242e780 R11: ffff8933ee617ca0 R12: fff=
f8933ee82c300
[  247.627399][ T2569] R13: ffff892541074200 R14: ffff8933ee82c300 R15: 000=
0000000000fab
[  247.627400][ T2569] FS:  00007fbfc68ee6c0(0000) GS:ffff89345be5f000(0000=
) knlGS:0000000000000000
[  247.627402][ T2569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  247.627403][ T2569] CR2: 00001c0b46cd5000 CR3: 0000000195538000 CR4: 000=
0000000750ef0
[  247.627404][ T2569] PKRU: 55555554
[  247.627406][ T2569] Call Trace:
[  247.627407][ T2569]  <TASK>
[  247.627408][ T2569]  ? dequeue_task_fair+0x9b/0x190
[  247.627411][ T2569]  __schedule+0x293/0x1c90
[  247.627414][ T2569]  ? sched_clock_cpu+0x11f/0x1f0
[  247.627416][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627419][ T2569]  ? psi_group_change+0x1c9/0x4b0
[  247.627422][ T2569]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627424][ T2569]  ? futex_hash_put+0x50/0xa0
[  247.627427][ T2569]  schedule+0x41/0x1a0
[  247.627478][ T2569]  </TASK>
[  247.627479][ T2569] ---[ end trace 0000000000000000 ]---
[  247.626298][ T2045] BUG: scheduling while atomic: IPC I/O Parent/2045/0x=
00000002
[  247.626301][ T2045] Modules linked in:
[  247.626302][ T2045]  bpf_testmod(O)
[  247.626303][ T2045]  netconsole
[  247.626305][ T2045]  ccm
[  247.626306][ T2045]  snd_seq_dummy
[  247.626307][ T2045]  snd_hrtimer snd_seq_midi
[  247.626309][ T2045]  snd_seq_midi_event
[  247.626310][ T2045]  snd_seq
[  247.626311][ T2045]  rfcomm bnep
[  247.626313][ T2045]  nls_ascii
[  247.626313][ T2045]  nls_cp437
[  247.626315][ T2045]  vfat
[  247.626316][ T2045]  fat
[  247.626317][ T2045]  snd_ctl_led
[  247.626318][ T2045]  snd_hda_codec_realtek
[  247.626319][ T2045]  snd_hda_codec_generic
[  247.626320][ T2045]  snd_hda_scodec_component
[  247.626320][ T2045]  snd_hda_codec_hdmi
[  247.626321][ T2045]  snd_usb_audio
[  247.626322][ T2045]  btusb
[  247.626323][ T2045]  snd_hda_intel
[  247.626324][ T2045]  btrtl
[  247.626325][ T2045]  snd_intel_dspcfg
[  247.626326][ T2045]  btintel
[  247.626327][ T2045]  btbcm
[  247.626328][ T2045]  snd_soc_dmic
[  247.626329][ T2045]  snd_acp3x_pdm_dma
[  247.626330][ T2045]  snd_acp3x_rn snd_usbmidi_lib
[  247.626331][ T2045]  snd_hda_codec
[  247.626332][ T2045]  uvcvideo
[  247.626334][ T2045]  btmtk
[  247.626335][ T2045]  snd_ump
[  247.626336][ T2045]  snd_soc_core
[  247.626337][ T2045]  videobuf2_vmalloc
[  247.626338][ T2045]  snd_hwdep
[  247.626339][ T2045]  videobuf2_memops
[  247.626340][ T2045]  uvc bluetooth
[  247.626341][ T2045]  snd_hda_core
[  247.626342][ T2045]  snd_rawmidi
[  247.626343][ T2045]  videobuf2_v4l2
[  247.626344][ T2045]  snd_seq_device
[  247.626345][ T2045]  snd_pcm_oss
[  247.626346][ T2045]  videodev
[  247.626347][ T2045]  snd_mixer_oss
[  247.626348][ T2045]  snd_rn_pci_acp3x
[  247.626349][ T2045]  ecdh_generic
[  247.626350][ T2045]  snd_pcm
[  247.626351][ T2045]  ecc
[  247.626352][ T2045]  snd_acp_config
[  247.626353][ T2045]  videobuf2_common
[  247.626354][ T2045]  snd_soc_acpi
[  247.626356][ T2045]  msi_wmi
[  247.626357][ T2045]  snd_timer
[  247.626358][ T2045]  mc
[  247.626360][ T2045]  sparse_keymap
[  247.626361][ T2045]  snd
[  247.626362][ T2045]  edac_mce_amd
[  247.626363][ T2045]  wmi_bmof
[  247.626364][ T2045]  k10temp
[  247.626366][ T2045]  snd_pci_acp3x soundcore
[  247.626368][ T2045]  ccp
[  247.626369][ T2045]  battery
[  247.626370][ T2045]  ac
[  247.626371][ T2045]  sch_fq_codel
[  247.626372][ T2045]  button
[  247.626373][ T2045]  joydev
[  247.626374][ T2045]  hid_sensor_accel_3d
[  247.626375][ T2045]  hid_sensor_prox
[  247.626376][ T2045]  hid_sensor_gyro_3d
[  247.626377][ T2045]  hid_sensor_als
[  247.626379][ T2045]  hid_sensor_magn_3d
[  247.626380][ T2045]  hid_sensor_trigger
[  247.626381][ T2045]  industrialio_triggered_buffer
[  247.626383][ T2045]  kfifo_buf
[  247.626384][ T2045]  industrialio
[  247.626385][ T2045]  evdev
[  247.626386][ T2045]  amd_pmc
[  247.626388][ T2045]  hid_sensor_iio_common
[  247.626389][ T2045]  mt7921e
[  247.626391][ T2045]  mt7921_common
[  247.626392][ T2045]  mt792x_lib
[  247.626393][ T2045]  mt76_connac_lib
[  247.626395][ T2045]  mt76
[  247.626397][ T2045]  mac80211
[  247.626398][ T2045]  libarc4
[  247.626400][ T2045]  cfg80211
[  247.626401][ T2045]  rfkill
[  247.626402][ T2045]  msr
[  247.626403][ T2045]  fuse
[  247.626404][ T2045]  nvme_fabrics
[  247.626406][ T2045]  efi_pstore
[  247.626408][ T2045]  configfs
[  247.626409][ T2045]  nfnetlink
[  247.626411][ T2045]  efivarfs
[  247.626413][ T2045]  autofs4
[  247.626414][ T2045]  ext4
[  247.626416][ T2045]  mbcache
[  247.626418][ T2045]  jbd2
[  247.626419][ T2045]  usbhid
[  247.626420][ T2045]  amdgpu
[  247.626422][ T2045]  amdxcp
[  247.626423][ T2045]  i2c_algo_bit
[  247.626425][ T2045]  drm_client_lib
[  247.626427][ T2045]  drm_ttm_helper
[  247.626428][ T2045]  ttm
[  247.626429][ T2045]  drm_exec
[  247.626431][ T2045]  gpu_sched
[  247.626432][ T2045]  xhci_pci
[  247.626433][ T2045]  drm_suballoc_helper
[  247.626435][ T2045]  drm_panel_backlight_quirks
[  247.626437][ T2045]  xhci_hcd
[  247.626438][ T2045]  cec
[  247.626439][ T2045]  hid_sensor_hub
[  247.626441][ T2045]  hid_multitouch
[  247.626442][ T2045]  drm_buddy
[  247.626443][ T2045]  mfd_core
[  247.626445][ T2045]  hid_generic
[  247.626446][ T2045]  drm_display_helper
[  247.626448][ T2045]  psmouse
[  247.626449][ T2045]  nvme
[  247.626451][ T2045]  i2c_hid_acpi
[  247.626452][ T2045]  usbcore
[  247.626453][ T2045]  amd_sfh
[  247.626455][ T2045]  i2c_hid
[  247.626456][ T2045]  serio_raw
[  247.626457][ T2045]  drm_kms_helper
[  247.626460][ T2045]  hid
[  247.626461][ T2045]  nvme_core
[  247.626462][ T2045]  r8169
[  247.626463][ T2045]  i2c_piix4
[  247.626465][ T2045]  usb_common
[  247.626466][ T2045]  crc16
[  247.626467][ T2045]  i2c_smbus
[  247.626469][ T2045]  i2c_designware_platform
[  247.626470][ T2045]  i2c_designware_core
[  247.626471][ T2045]  [last unloaded: bpf_testmod(O)]
[  247.626472][ T2045]=20
[  247.626477][ T2045] CPU: 2 UID: 1000 PID: 2045 Comm: IPC I/O Parent Tain=
ted: G           O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{RT=
,(full)}=20
[  247.626482][ T2045] Tainted: [O]=3DOOT_MODULE
[  247.626483][ T2045] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.626485][ T2045] Call Trace:
[  247.626490][ T2045]  <TASK>
[  247.626492][ T2045]  dump_stack_lvl+0x6d/0xb0
[  247.626499][ T2045]  __schedule_bug.cold+0x3e/0x4a
[  247.626503][ T2045]  __schedule+0x1440/0x1c90
[  247.626508][ T2045]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626510][ T2045]  ? sched_clock_cpu+0x11f/0x1f0
[  247.626514][ T2045]  ? psi_group_change+0x1c9/0x4b0
[  247.626517][ T2045]  ? dl_server_start+0x3a/0x120
[  247.626521][ T2045]  schedule_rtlock+0x30/0xd0
[  247.626524][ T2045]  rtlock_slowlock_locked+0x327/0xfb0
[  247.626530][ T2045]  rt_spin_lock+0x7a/0xd0
[  247.626533][ T2045]  task_get_cgroup1+0x6c/0xf0
[  247.626537][ T2045]  bpf_task_get_cgroup1+0xe/0x20
[  247.626541][ T2045]  bpf_prog_28ba4edb92179f43_on_enter+0x47/0x128
[  247.626544][ T2045]  bpf_trace_run2+0x77/0xf0
[  247.626547][ T2045]  ? __x64_sys_futex+0x10b/0x1c0
[  247.626553][ T2045]  __bpf_trace_sys_enter+0x10/0x30
[  247.626556][ T2045]  syscall_trace_enter+0x157/0x1c0
[  247.626558][ T2045]  do_syscall_64+0x2dc/0xfa0
[  247.626561][ T2045]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626564][ T2045]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.626566][ T2045] RIP: 0033:0x7f16dd9269ee
[  247.626586][ T2045] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d=
7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0=
f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  247.626587][ T2045] RSP: 002b:00007f16cf4757f8 EFLAGS: 00000246 ORIG_RAX=
: 000000000000002f
[  247.626589][ T2045] RAX: ffffffffffffffda RBX: 00007f16cf4766c0 RCX: 000=
07f16dd9269ee
[  247.626590][ T2045] RDX: 0000000000000040 RSI: 00007f16cf475910 RDI: 000=
0000000000091
[  247.626591][ T2045] RBP: 00007f16cf475910 R08: 0000000000000000 R09: 000=
0000000000000
[  247.626593][ T2045] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
[  247.626594][ T2045] R13: 0000000000000000 R14: 00007f16a1f99020 R15: 000=
0000000000000
[  247.626598][ T2045]  </TASK>
[  247.626866][ T2045] BUG: scheduling while atomic: IPC I/O Parent/2045/0x=
00000000
[  247.626868][ T2045] Modules linked in:
[  247.626869][ T2045]  bpf_testmod(O)
[  247.626870][ T2045]  netconsole ccm
[  247.626872][ T2045]  snd_seq_dummy
[  247.626873][ T2045]  snd_hrtimer
[  247.626874][ T2045]  snd_seq_midi snd_seq_midi_event
[  247.626875][ T2045]  snd_seq
[  247.626876][ T2045]  rfcomm
[  247.626877][ T2045]  bnep
[  247.626878][ T2045]  nls_ascii
[  247.626879][ T2045]  nls_cp437
[  247.626879][ T2045]  vfat fat
[  247.626881][ T2045]  snd_ctl_led
[  247.626882][ T2045]  snd_hda_codec_realtek
[  247.626882][ T2045]  snd_hda_codec_generic snd_hda_scodec_component
[  247.626884][ T2045]  snd_hda_codec_hdmi
[  247.626885][ T2045]  snd_usb_audio
[  247.626885][ T2045]  btusb snd_hda_intel
[  247.626887][ T2045]  btrtl
[  247.626888][ T2045]  snd_intel_dspcfg
[  247.626889][ T2045]  btintel
[  247.626889][ T2045]  btbcm
[  247.626890][ T2045]  snd_soc_dmic
[  247.626891][ T2045]  snd_acp3x_pdm_dma snd_acp3x_rn
[  247.626892][ T2045]  snd_usbmidi_lib
[  247.626893][ T2045]  snd_hda_codec
[  247.626894][ T2045]  uvcvideo
[  247.626895][ T2045]  btmtk
[  247.626896][ T2045]  snd_ump
[  247.626897][ T2045]  snd_soc_core
[  247.626898][ T2045]  videobuf2_vmalloc
[  247.626899][ T2045]  snd_hwdep
[  247.626900][ T2045]  videobuf2_memops uvc
[  247.626901][ T2045]  bluetooth snd_hda_core
[  247.626902][ T2045]  snd_rawmidi videobuf2_v4l2
[  247.626903][ T2045]  snd_seq_device snd_pcm_oss videodev snd_mixer_oss s=
nd_rn_pci_acp3x ecdh_generic snd_pcm
[  247.626907][ T2045]  ecc
[  247.626908][ T2045]  snd_acp_config videobuf2_common snd_soc_acpi msi_wm=
i snd_timer mc sparse_keymap snd
[  247.626912][ T2045]  edac_mce_amd wmi_bmof
[  247.626914][ T2045]  k10temp
[  247.626915][ T2045]  snd_pci_acp3x
[  247.626916][ T2045]  soundcore
[  247.626916][ T2045]  ccp
[  247.626917][ T2045]  battery
[  247.626918][ T2045]  ac
[  247.626919][ T2045]  sch_fq_codel
[  247.626920][ T2045]  button joydev
[  247.626921][ T2045]  hid_sensor_accel_3d
[  247.626922][ T2045]  hid_sensor_prox
[  247.626923][ T2045]  hid_sensor_gyro_3d
[  247.626924][ T2045]  hid_sensor_als
[  247.626925][ T2045]  hid_sensor_magn_3d
[  247.626926][ T2045]  hid_sensor_trigger
[  247.626927][ T2045]  industrialio_triggered_buffer kfifo_buf
[  247.626929][ T2045]  industrialio evdev
[  247.626931][ T2045]  amd_pmc
[  247.626932][ T2045]  hid_sensor_iio_common
[  247.626933][ T2045]  mt7921e
[  247.626934][ T2045]  mt7921_common
[  247.626935][ T2045]  mt792x_lib
[  247.626937][ T2045]  mt76_connac_lib
[  247.626937][ T2045]  mt76
[  247.626938][ T2045]  mac80211
[  247.626940][ T2045]  libarc4
[  247.626941][ T2045]  cfg80211
[  247.626942][ T2045]  rfkill
[  247.626943][ T2045]  msr
[  247.626944][ T2045]  fuse
[  247.626945][ T2045]  nvme_fabrics
[  247.626946][ T2045]  efi_pstore
[  247.626947][ T2045]  configfs
[  247.626948][ T2045]  nfnetlink
[  247.626949][ T2045]  efivarfs
[  247.626951][ T2045]  autofs4
[  247.626952][ T2045]  ext4
[  247.626953][ T2045]  mbcache
[  247.626955][ T2045]  jbd2
[  247.626957][ T2045]  usbhid
[  247.626959][ T2045]  amdgpu
[  247.626960][ T2045]  amdxcp
[  247.626962][ T2045]  i2c_algo_bit
[  247.626964][ T2045]  drm_client_lib
[  247.626965][ T2045]  drm_ttm_helper
[  247.626966][ T2045]  ttm
[  247.626967][ T2045]  drm_exec
[  247.626969][ T2045]  gpu_sched
[  247.626970][ T2045]  xhci_pci
[  247.626971][ T2045]  drm_suballoc_helper
[  247.626973][ T2045]  drm_panel_backlight_quirks
[  247.626974][ T2045]  xhci_hcd
[  247.626976][ T2045]  cec
[  247.626977][ T2045]  hid_sensor_hub
[  247.626978][ T2045]  hid_multitouch
[  247.626980][ T2045]  drm_buddy
[  247.626981][ T2045]  mfd_core
[  247.626982][ T2045]  hid_generic
[  247.626983][ T2045]  drm_display_helper
[  247.626985][ T2045]  psmouse
[  247.626986][ T2045]  nvme
[  247.626987][ T2045]  i2c_hid_acpi
[  247.626988][ T2045]  usbcore
[  247.626990][ T2045]  amd_sfh
[  247.626991][ T2045]  i2c_hid
[  247.626993][ T2045]  serio_raw
[  247.626994][ T2045]  drm_kms_helper
[  247.626995][ T2045]  hid
[  247.626997][ T2045]  nvme_core r8169
[  247.626999][ T2045]  i2c_piix4
[  247.627001][ T2045]  usb_common
[  247.627002][ T2045]  crc16
[  247.627003][ T2045]  i2c_smbus
[  247.627004][ T2045]  i2c_designware_platform
[  247.627006][ T2045]  i2c_designware_core
[  247.627007][ T2045]  [last unloaded: bpf_testmod(O)]
[  247.627009][ T2045]=20
[  247.627011][ T2045] CPU: 2 UID: 1000 PID: 2045 Comm: IPC I/O Parent Tain=
ted: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{RT=
,(full)}=20
[  247.627016][ T2045] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.627017][ T2045] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.627019][ T2045] Call Trace:
[  247.627021][ T2045]  <TASK>
[  247.627023][ T2045]  dump_stack_lvl+0x6d/0xb0
[  247.627028][ T2045]  __schedule_bug.cold+0x3e/0x4a
[  247.627031][ T2045]  __schedule+0x1440/0x1c90
[  247.627035][ T2045]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627038][ T2045]  ? rt_write_lock+0x106/0x270
[  247.627042][ T2045]  schedule+0x41/0x1a0
[  247.627045][ T2045]  schedule_hrtimeout_range_clock+0xfc/0x110
[  247.627049][ T2045]  do_epoll_wait+0x4fe/0x530
[  247.627055][ T2045]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627058][ T2045]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
[  247.627063][ T2045]  __x64_sys_epoll_wait+0x5e/0xf0
[  247.627066][ T2045]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627068][ T2045]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627070][ T2045]  ? syscall_trace_enter+0x157/0x1c0
[  247.627073][ T2045]  do_syscall_64+0x6f/0xfa0
[  247.627076][ T2045]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627079][ T2045]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.627081][ T2045] RIP: 0033:0x7f16dd9269ee
[  247.627087][ T2045] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d=
7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0=
f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  247.627089][ T2045] RSP: 002b:00007f16cf4759c8 EFLAGS: 00000246
[  247.627091][ T2045]  ORIG_RAX: 00000000000000e8
[  247.627092][ T2045] RAX: ffffffffffffffda RBX: 00007f16cf4766c0 RCX: 000=
07f16dd9269ee
[  247.627094][ T2045] RDX: 0000000000000020 RSI: 00007f16dd680680 RDI: 000=
0000000000010
[  247.627095][ T2045] RBP: 00007f16dd677d00 R08: 0000000000000000 R09: 000=
0000000000000
[  247.627096][ T2045] R10: ffffffffffffffff R11: 0000000000000246 R12: 000=
07f16dd680680
[  247.627098][ T2045] R13: 00007f16d0f658c0 R14: 00007f16d0f658c0 R15: 000=
00000ffffffff
[  247.627102][ T2045]  </TASK>
[  247.626311][ T3138] BUG: scheduling while atomic: MediaSu~isor #2/3138/0=
x00000002
[  247.626313][ T3138] Modules linked in:
[  247.626314][ T3138]  bpf_testmod(O)
[  247.626315][ T3138]  netconsole
[  247.626317][ T3138]  ccm
[  247.626318][ T3138]  snd_seq_dummy
[  247.626319][ T3138]  snd_hrtimer
[  247.626320][ T3138]  snd_seq_midi
[  247.626321][ T3138]  snd_seq_midi_event
[  247.626322][ T3138]  snd_seq
[  247.626322][ T3138]  rfcomm
[  247.626324][ T3138]  bnep nls_ascii
[  247.626326][ T3138]  nls_cp437 vfat
[  247.626328][ T3138]  fat
[  247.626329][ T3138]  snd_ctl_led
[  247.626330][ T3138]  snd_hda_codec_realtek
[  247.626331][ T3138]  snd_hda_codec_generic
[  247.626332][ T3138]  snd_hda_scodec_component
[  247.626333][ T3138]  snd_hda_codec_hdmi snd_usb_audio
[  247.626335][ T3138]  btusb
[  247.626337][ T3138]  snd_hda_intel
[  247.626338][ T3138]  btrtl
[  247.626339][ T3138]  snd_intel_dspcfg
[  247.626340][ T3138]  btintel
[  247.626341][ T3138]  btbcm
[  247.626342][ T3138]  snd_soc_dmic
[  247.626343][ T3138]  snd_acp3x_pdm_dma
[  247.626345][ T3138]  snd_acp3x_rn
[  247.626346][ T3138]  snd_usbmidi_lib
[  247.626347][ T3138]  snd_hda_codec
[  247.626348][ T3138]  uvcvideo
[  247.626349][ T3138]  btmtk
[  247.626351][ T3138]  snd_ump
[  247.626352][ T3138]  snd_soc_core
[  247.626353][ T3138]  videobuf2_vmalloc
[  247.626354][ T3138]  snd_hwdep
[  247.626355][ T3138]  videobuf2_memops
[  247.626357][ T3138]  uvc
[  247.626358][ T3138]  bluetooth
[  247.626359][ T3138]  snd_hda_core
[  247.626361][ T3138]  snd_rawmidi
[  247.626362][ T3138]  videobuf2_v4l2
[  247.626363][ T3138]  snd_seq_device
[  247.626365][ T3138]  snd_pcm_oss
[  247.626366][ T3138]  videodev
[  247.626368][ T3138]  snd_mixer_oss
[  247.626369][ T3138]  snd_rn_pci_acp3x
[  247.626371][ T3138]  ecdh_generic
[  247.626372][ T3138]  snd_pcm
[  247.626373][ T3138]  ecc
[  247.626375][ T3138]  snd_acp_config
[  247.626376][ T3138]  videobuf2_common
[  247.626377][ T3138]  snd_soc_acpi
[  247.626378][ T3138]  msi_wmi
[  247.626380][ T3138]  snd_timer
[  247.626381][ T3138]  mc
[  247.626383][ T3138]  sparse_keymap
[  247.626383][ T3138]  snd
[  247.626385][ T3138]  edac_mce_amd
[  247.626386][ T3138]  wmi_bmof
[  247.626387][ T3138]  k10temp
[  247.626388][ T3138]  snd_pci_acp3x
[  247.626389][ T3138]  soundcore
[  247.626390][ T3138]  ccp
[  247.626391][ T3138]  battery
[  247.626392][ T3138]  ac
[  247.626394][ T3138]  sch_fq_codel
[  247.626395][ T3138]  button
[  247.626397][ T3138]  joydev
[  247.626398][ T3138]  hid_sensor_accel_3d
[  247.626399][ T3138]  hid_sensor_prox
[  247.626400][ T3138]  hid_sensor_gyro_3d
[  247.626401][ T3138]  hid_sensor_als
[  247.626403][ T3138]  hid_sensor_magn_3d
[  247.626404][ T3138]  hid_sensor_trigger
[  247.626406][ T3138]  industrialio_triggered_buffer
[  247.626407][ T3138]  kfifo_buf
[  247.626408][ T3138]  industrialio
[  247.626410][ T3138]  evdev
[  247.626411][ T3138]  amd_pmc
[  247.626413][ T3138]  hid_sensor_iio_common
[  247.626414][ T3138]  mt7921e mt7921_common
[  247.626416][ T3138]  mt792x_lib
[  247.626417][ T3138]  mt76_connac_lib
[  247.626419][ T3138]  mt76
[  247.626420][ T3138]  mac80211
[  247.626421][ T3138]  libarc4
[  247.626422][ T3138]  cfg80211
[  247.626424][ T3138]  rfkill
[  247.626425][ T3138]  msr
[  247.626426][ T3138]  fuse
[  247.626427][ T3138]  nvme_fabrics
[  247.626428][ T3138]  efi_pstore
[  247.626429][ T3138]  configfs
[  247.626430][ T3138]  nfnetlink
[  247.626432][ T3138]  efivarfs
[  247.626433][ T3138]  autofs4
[  247.626434][ T3138]  ext4
[  247.626435][ T3138]  mbcache
[  247.626436][ T3138]  jbd2
[  247.626437][ T3138]  usbhid
[  247.626438][ T3138]  amdgpu
[  247.626439][ T3138]  amdxcp
[  247.626440][ T3138]  i2c_algo_bit
[  247.626442][ T3138]  drm_client_lib
[  247.626443][ T3138]  drm_ttm_helper
[  247.626444][ T3138]  ttm
[  247.626446][ T3138]  drm_exec
[  247.626447][ T3138]  gpu_sched
[  247.626449][ T3138]  xhci_pci
[  247.626451][ T3138]  drm_suballoc_helper
[  247.626453][ T3138]  drm_panel_backlight_quirks
[  247.626454][ T3138]  xhci_hcd
[  247.626456][ T3138]  cec
[  247.626457][ T3138]  hid_sensor_hub
[  247.626458][ T3138]  hid_multitouch
[  247.626459][ T3138]  drm_buddy
[  247.626462][ T3138]  mfd_core
[  247.626463][ T3138]  hid_generic
[  247.626465][ T3138]  drm_display_helper
[  247.626467][ T3138]  psmouse
[  247.626468][ T3138]  nvme
[  247.626469][ T3138]  i2c_hid_acpi
[  247.626471][ T3138]  usbcore
[  247.626474][ T3138]  amd_sfh
[  247.626475][ T3138]  i2c_hid
[  247.626476][ T3138]  serio_raw
[  247.626477][ T3138]  drm_kms_helper
[  247.626478][ T3138]  hid
[  247.626480][ T3138]  nvme_core
[  247.626481][ T3138]  r8169
[  247.626482][ T3138]  i2c_piix4
[  247.626484][ T3138]  usb_common
[  247.626485][ T3138]  crc16
[  247.626485][ T3138]  i2c_smbus
[  247.626486][ T3138]  i2c_designware_platform
[  247.626487][ T3138]  i2c_designware_core
[  247.626488][ T3138]  [last unloaded: bpf_testmod(O)]
[  247.626489][ T3138]=20
[  247.626823][ T3138] CPU: 13 UID: 1000 PID: 3138 Comm: MediaSu~isor #2 Ta=
inted: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{=
RT,(full)}=20
[  247.626827][ T3138] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.626829][ T3138] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.626830][ T3138] Call Trace:
[  247.626831][ T3138]  <TASK>
[  247.626833][ T3138]  dump_stack_lvl+0x6d/0xb0
[  247.626837][ T3138]  __schedule_bug.cold+0x3e/0x4a
[  247.626840][ T3138]  __schedule+0x1440/0x1c90
[  247.626843][ T3138]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626845][ T3138]  ? sched_clock_cpu+0x11f/0x1f0
[  247.626847][ T3138]  ? psi_group_change+0x1c9/0x4b0
[  247.626850][ T3138]  ? dl_server_start+0x3a/0x120
[  247.626853][ T3138]  schedule_rtlock+0x30/0xd0
[  247.626856][ T3138]  rtlock_slowlock_locked+0x327/0xfb0
[  247.626861][ T3138]  rt_spin_lock+0x7a/0xd0
[  247.626863][ T3138]  task_get_cgroup1+0x6c/0xf0
[  247.626866][ T3138]  bpf_task_get_cgroup1+0xe/0x20
[  247.626869][ T3138]  bpf_prog_28ba4edb92179f43_on_enter+0x47/0x128
[  247.626871][ T3138]  bpf_trace_run2+0x77/0xf0
[  247.626875][ T3138]  __bpf_trace_sys_enter+0x10/0x30
[  247.626877][ T3138]  syscall_trace_enter+0x157/0x1c0
[  247.626880][ T3138]  do_syscall_64+0x2dc/0xfa0
[  247.626883][ T3138]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626886][ T3138]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.626888][ T3138] RIP: 0033:0x7f9d91191a0e
[  247.626892][ T3138] Code: 9a 3b 41 83 c0 01 48 3d ff c9 9a 3b 77 ee 4c 0=
1 c2 48 89 16 48 89 46 08 5b 31 c0 41 5c 5d c3 cc 5b b8 e4 00 00 00 41 5c 0=
f 05 <5d> c3 cc 41 81 79 04 ff ff ff 7f 0f 84 99 00 00 00 f3 90 e9 4c ff
[  247.626894][ T3138] RSP: 002b:00007f9d7bbcb910 EFLAGS: 00000297
[  247.626896][ T3138]  ORIG_RAX: 00000000000000e4
[  247.626897][ T3138] RAX: ffffffffffffffda RBX: 00007f9d909651f0 RCX: 000=
07f9d91191a0e
[  247.626899][ T3138] RDX: 0000000000000002 RSI: 00007f9d7bbcb930 RDI: 000=
0000000000001
[  247.626900][ T3138] RBP: 00007f9d7bbcb910 R08: 0000000000000000 R09: 000=
07f9d9118b000
[  247.626902][ T3138] R10: 5fb13eea24d73e07 R11: 0000000000000297 R12: 000=
0000000000000
[  247.626903][ T3138] R13: 0000000000000000 R14: 00007f9d7b9fe440 R15: 000=
07f9d7bbcb9c8
[  247.626907][ T3138]  </TASK>
[  247.626930][ T3138] BUG: scheduling while atomic: MediaSu~isor #2/3138/0=
x00000000
[  247.626932][ T3138] Modules linked in:
[  247.626933][ T3138]  bpf_testmod(O)
[  247.626934][ T3138]  netconsole
[  247.626935][ T3138]  ccm
[  247.626936][ T3138]  snd_seq_dummy
[  247.626937][ T3138]  snd_hrtimer
[  247.626938][ T3138]  snd_seq_midi
[  247.626939][ T3138]  snd_seq_midi_event
[  247.626941][ T3138]  snd_seq
[  247.626942][ T3138]  rfcomm
[  247.626944][ T3138]  bnep
[  247.626945][ T3138]  nls_ascii
[  247.626946][ T3138]  nls_cp437
[  247.626947][ T3138]  vfat
[  247.626948][ T3138]  fat
[  247.626949][ T3138]  snd_ctl_led
[  247.626951][ T3138]  snd_hda_codec_realtek
[  247.626952][ T3138]  snd_hda_codec_generic
[  247.626953][ T3138]  snd_hda_scodec_component
[  247.626955][ T3138]  snd_hda_codec_hdmi
[  247.626956][ T3138]  snd_usb_audio
[  247.626958][ T3138]  btusb
[  247.626959][ T3138]  snd_hda_intel
[  247.626961][ T3138]  btrtl
[  247.626963][ T3138]  snd_intel_dspcfg
[  247.626965][ T3138]  btintel
[  247.626966][ T3138]  btbcm
[  247.626967][ T3138]  snd_soc_dmic
[  247.626969][ T3138]  snd_acp3x_pdm_dma
[  247.626970][ T3138]  snd_acp3x_rn
[  247.626971][ T3138]  snd_usbmidi_lib
[  247.626973][ T3138]  snd_hda_codec
[  247.626974][ T3138]  uvcvideo
[  247.626976][ T3138]  btmtk
[  247.626977][ T3138]  snd_ump
[  247.626979][ T3138]  snd_soc_core
[  247.626980][ T3138]  videobuf2_vmalloc
[  247.626982][ T3138]  snd_hwdep
[  247.626983][ T3138]  videobuf2_memops
[  247.626985][ T3138]  uvc
[  247.626987][ T3138]  bluetooth
[  247.626988][ T3138]  snd_hda_core
[  247.626990][ T3138]  snd_rawmidi
[  247.626992][ T3138]  videobuf2_v4l2
[  247.626993][ T3138]  snd_seq_device
[  247.626994][ T3138]  snd_pcm_oss
[  247.626996][ T3138]  videodev
[  247.626998][ T3138]  snd_mixer_oss
[  247.627000][ T3138]  snd_rn_pci_acp3x
[  247.627002][ T3138]  ecdh_generic
[  247.627004][ T3138]  snd_pcm
[  247.627005][ T3138]  ecc
[  247.627008][ T3138]  snd_acp_config
[  247.627009][ T3138]  videobuf2_common
[  247.627011][ T3138]  snd_soc_acpi
[  247.627012][ T3138]  msi_wmi
[  247.627013][ T3138]  snd_timer
[  247.627014][ T3138]  mc
[  247.627016][ T3138]  sparse_keymap
[  247.627017][ T3138]  snd
[  247.627019][ T3138]  edac_mce_amd
[  247.627020][ T3138]  wmi_bmof
[  247.627021][ T3138]  k10temp
[  247.627023][ T3138]  snd_pci_acp3x
[  247.627024][ T3138]  soundcore
[  247.627026][ T3138]  ccp
[  247.627028][ T3138]  battery
[  247.627029][ T3138]  ac
[  247.627030][ T3138]  sch_fq_codel
[  247.627032][ T3138]  button
[  247.627033][ T3138]  joydev
[  247.627035][ T3138]  hid_sensor_accel_3d
[  247.627036][ T3138]  hid_sensor_prox
[  247.627037][ T3138]  hid_sensor_gyro_3d
[  247.627039][ T3138]  hid_sensor_als
[  247.627041][ T3138]  hid_sensor_magn_3d
[  247.627043][ T3138]  hid_sensor_trigger
[  247.627044][ T3138]  industrialio_triggered_buffer
[  247.627045][ T3138]  kfifo_buf
[  247.627047][ T3138]  industrialio
[  247.627048][ T3138]  evdev
[  247.627050][ T3138]  amd_pmc
[  247.627051][ T3138]  hid_sensor_iio_common
[  247.627053][ T3138]  mt7921e
[  247.627054][ T3138]  mt7921_common
[  247.627056][ T3138]  mt792x_lib
[  247.627058][ T3138]  mt76_connac_lib
[  247.627059][ T3138]  mt76
[  247.627060][ T3138]  mac80211
[  247.627062][ T3138]  libarc4
[  247.627063][ T3138]  cfg80211
[  247.627065][ T3138]  rfkill
[  247.627066][ T3138]  msr
[  247.627067][ T3138]  fuse
[  247.627069][ T3138]  nvme_fabrics
[  247.627070][ T3138]  efi_pstore
[  247.627072][ T3138]  configfs
[  247.627073][ T3138]  nfnetlink
[  247.627074][ T3138]  efivarfs
[  247.627076][ T3138]  autofs4
[  247.627078][ T3138]  ext4
[  247.627079][ T3138]  mbcache
[  247.627080][ T3138]  jbd2
[  247.627081][ T3138]  usbhid
[  247.627083][ T3138]  amdgpu
[  247.627084][ T3138]  amdxcp
[  247.627086][ T3138]  i2c_algo_bit
[  247.627087][ T3138]  drm_client_lib
[  247.627089][ T3138]  drm_ttm_helper
[  247.627091][ T3138]  ttm
[  247.627092][ T3138]  drm_exec
[  247.627093][ T3138]  gpu_sched
[  247.627095][ T3138]  xhci_pci
[  247.627096][ T3138]  drm_suballoc_helper
[  247.627097][ T3138]  drm_panel_backlight_quirks xhci_hcd
[  247.627099][ T3138]  cec hid_sensor_hub hid_multitouch drm_buddy
[  247.627102][ T3138]  mfd_core
[  247.627103][ T3138]  hid_generic drm_display_helper psmouse
[  247.627105][ T3138]  nvme
[  247.627106][ T3138]  i2c_hid_acpi usbcore amd_sfh
[  247.627108][ T3138]  i2c_hid
[  247.627109][ T3138]  serio_raw
[  247.627111][ T3138]  drm_kms_helper
[  247.627111][ T3138]  hid nvme_core r8169 i2c_piix4
[  247.627115][ T3138]  usb_common crc16 i2c_smbus i2c_designware_platform
[  247.627118][ T3138]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[  247.627119][ T3138]=20
[  247.627254][ T3138] CPU: 13 UID: 1000 PID: 3138 Comm: MediaSu~isor #2 Ta=
inted: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{=
RT,(full)}=20
[  247.627258][ T3138] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.627259][ T3138] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.627260][ T3138] Call Trace:
[  247.627262][ T3138]  <TASK>
[  247.627263][ T3138]  dump_stack_lvl+0x6d/0xb0
[  247.627267][ T3138]  __schedule_bug.cold+0x3e/0x4a
[  247.627270][ T3138]  __schedule+0x1440/0x1c90
[  247.627274][ T3138]  ? get_nohz_timer_target+0x26/0x180
[  247.627277][ T3138]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627290][ T3138]  futex_do_wait+0x38/0x70
[  247.627294][ T3138]  __futex_wait+0x91/0x100
[  247.627297][ T3138]  ? __pfx_futex_wake_mark+0x10/0x10
[  247.627301][ T3138]  futex_wait+0x6b/0x110
[  247.627304][ T3138]  ? __pfx_hrtimer_wakeup+0x10/0x10
[  247.627308][ T3138]  do_futex+0xcb/0x190
[  247.627311][ T3138]  __x64_sys_futex+0x10b/0x1c0
[  247.627316][ T3138]  do_syscall_64+0x6f/0xfa0
[  247.627324][ T3138] RIP: 0033:0x7f9d90c4c9ee
[  247.627329][ T3138] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d=
7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0=
f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  247.627332][ T3138] RSP: 002b:00007f9d7bbcb7e8 EFLAGS: 00000246
[  247.627333][ T3138]  ORIG_RAX: 00000000000000ca
[  247.627335][ T3138] RAX: ffffffffffffffda RBX: 00007f9d7bbcc6c0 RCX: 000=
07f9d90c4c9ee
[  247.627337][ T3138] RDX: 0000000000000d57 RSI: 0000000000000089 RDI: 000=
07f9d7bbcba14
[  247.627339][ T3138] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
00000ffffffff
[  247.627341][ T3138] R10: 00007f9d7bbcb8f8 R11: 0000000000000246 R12: 000=
07f9d90965210
[  247.627343][ T3138] R13: 00007f9d7bbcba14 R14: 0000000000001ab3 R15: 000=
07f9d7bbcb9f0
[  247.627347][ T3138]  </TASK>
[  247.626353][ T2554] BUG: scheduling while atomic: IPC I/O Child/2554/0x0=
0000002
[  247.626356][ T2554] Modules linked in:
[  247.626357][ T2554]  bpf_testmod(O)
[  247.626358][ T2554]  netconsole
[  247.626359][ T2554]  ccm
[  247.626360][ T2554]  snd_seq_dummy
[  247.626361][ T2554]  snd_hrtimer
[  247.626362][ T2554]  snd_seq_midi
[  247.626363][ T2554]  snd_seq_midi_event
[  247.626365][ T2554]  snd_seq
[  247.626366][ T2554]  rfcomm
[  247.626367][ T2554]  bnep
[  247.626368][ T2554]  nls_ascii
[  247.626369][ T2554]  nls_cp437
[  247.626370][ T2554]  vfat
[  247.626371][ T2554]  fat
[  247.626372][ T2554]  snd_ctl_led
[  247.626373][ T2554]  snd_hda_codec_realtek
[  247.626374][ T2554]  snd_hda_codec_generic
[  247.626375][ T2554]  snd_hda_scodec_component
[  247.626376][ T2554]  snd_hda_codec_hdmi
[  247.626377][ T2554]  snd_usb_audio
[  247.626378][ T2554]  btusb
[  247.626379][ T2554]  snd_hda_intel
[  247.626380][ T2554]  btrtl
[  247.626381][ T2554]  snd_intel_dspcfg
[  247.626382][ T2554]  btintel
[  247.626383][ T2554]  btbcm
[  247.626383][ T2554]  snd_soc_dmic
[  247.626384][ T2554]  snd_acp3x_pdm_dma
[  247.626385][ T2554]  snd_acp3x_rn
[  247.626386][ T2554]  snd_usbmidi_lib
[  247.626387][ T2554]  snd_hda_codec
[  247.626388][ T2554]  uvcvideo
[  247.626389][ T2554]  btmtk
[  247.626390][ T2554]  snd_ump
[  247.626390][ T2554]  snd_soc_core
[  247.626391][ T2554]  videobuf2_vmalloc
[  247.626392][ T2554]  snd_hwdep
[  247.626393][ T2554]  videobuf2_memops
[  247.626393][ T2554]  uvc
[  247.626394][ T2554]  bluetooth
[  247.626395][ T2554]  snd_hda_core
[  247.626396][ T2554]  snd_rawmidi
[  247.626396][ T2554]  videobuf2_v4l2 snd_seq_device
[  247.626398][ T2554]  snd_pcm_oss
[  247.626399][ T2554]  videodev
[  247.626399][ T2554]  snd_mixer_oss
[  247.626400][ T2554]  snd_rn_pci_acp3x
[  247.626401][ T2554]  ecdh_generic
[  247.626402][ T2554]  snd_pcm
[  247.626403][ T2554]  ecc
[  247.626404][ T2554]  snd_acp_config
[  247.626405][ T2554]  videobuf2_common
[  247.626406][ T2554]  snd_soc_acpi
[  247.626407][ T2554]  msi_wmi
[  247.626408][ T2554]  snd_timer
[  247.626408][ T2554]  mc
[  247.626409][ T2554]  sparse_keymap
[  247.626410][ T2554]  snd
[  247.626410][ T2554]  edac_mce_amd
[  247.626411][ T2554]  wmi_bmof
[  247.626412][ T2554]  k10temp
[  247.626413][ T2554]  snd_pci_acp3x
[  247.626414][ T2554]  soundcore
[  247.626415][ T2554]  ccp
[  247.626416][ T2554]  battery
[  247.626417][ T2554]  ac
[  247.626418][ T2554]  sch_fq_codel button
[  247.626419][ T2554]  joydev
[  247.626420][ T2554]  hid_sensor_accel_3d
[  247.626421][ T2554]  hid_sensor_prox
[  247.626422][ T2554]  hid_sensor_gyro_3d
[  247.626423][ T2554]  hid_sensor_als
[  247.626424][ T2554]  hid_sensor_magn_3d
[  247.626425][ T2554]  hid_sensor_trigger
[  247.626425][ T2554]  industrialio_triggered_buffer
[  247.626426][ T2554]  kfifo_buf
[  247.626427][ T2554]  industrialio evdev
[  247.626428][ T2554]  amd_pmc
[  247.626429][ T2554]  hid_sensor_iio_common
[  247.626430][ T2554]  mt7921e
[  247.626431][ T2554]  mt7921_common
[  247.626432][ T2554]  mt792x_lib
[  247.626433][ T2554]  mt76_connac_lib
[  247.626434][ T2554]  mt76
[  247.626435][ T2554]  mac80211
[  247.626436][ T2554]  libarc4
[  247.626437][ T2554]  cfg80211
[  247.626438][ T2554]  rfkill
[  247.626439][ T2554]  msr
[  247.626440][ T2554]  fuse
[  247.626441][ T2554]  nvme_fabrics
[  247.626442][ T2554]  efi_pstore
[  247.626443][ T2554]  configfs
[  247.626444][ T2554]  nfnetlink
[  247.626445][ T2554]  efivarfs
[  247.626446][ T2554]  autofs4
[  247.626447][ T2554]  ext4
[  247.626448][ T2554]  mbcache
[  247.626449][ T2554]  jbd2
[  247.626449][ T2554]  usbhid
[  247.626450][ T2554]  amdgpu
[  247.626451][ T2554]  amdxcp
[  247.626452][ T2554]  i2c_algo_bit
[  247.626453][ T2554]  drm_client_lib drm_ttm_helper
[  247.626455][ T2554]  ttm
[  247.626456][ T2554]  drm_exec
[  247.626457][ T2554]  gpu_sched
[  247.626457][ T2554]  xhci_pci
[  247.626458][ T2554]  drm_suballoc_helper
[  247.626459][ T2554]  drm_panel_backlight_quirks
[  247.626460][ T2554]  xhci_hcd
[  247.626461][ T2554]  cec
[  247.626462][ T2554]  hid_sensor_hub
[  247.626464][ T2554]  hid_multitouch
[  247.626465][ T2554]  drm_buddy
[  247.626465][ T2554]  mfd_core
[  247.626466][ T2554]  hid_generic
[  247.626467][ T2554]  drm_display_helper
[  247.626468][ T2554]  psmouse nvme
[  247.626470][ T2554]  i2c_hid_acpi
[  247.626471][ T2554]  usbcore
[  247.626472][ T2554]  amd_sfh
[  247.626473][ T2554]  i2c_hid
[  247.626473][ T2554]  serio_raw
[  247.626475][ T2554]  drm_kms_helper
[  247.626475][ T2554]  hid
[  247.626476][ T2554]  nvme_core r8169
[  247.626478][ T2554]  i2c_piix4 usb_common
[  247.626479][ T2554]  crc16 i2c_smbus
[  247.626480][ T2554]  i2c_designware_platform
[  247.626481][ T2554]  i2c_designware_core
[  247.626482][ T2554]  [last unloaded: bpf_testmod(O)]
[  247.626483][ T2554]=20
[  247.626600][ T2554] CPU: 6 UID: 1000 PID: 2554 Comm: IPC I/O Child Taint=
ed: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{RT,=
(full)}=20
[  247.626604][ T2554] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.626605][ T2554] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.626605][ T2554] Call Trace:
[  247.626607][ T2554]  <TASK>
[  247.626608][ T2554]  dump_stack_lvl+0x6d/0xb0
[  247.626613][ T2554]  __schedule_bug.cold+0x3e/0x4a
[  247.626615][ T2554]  __schedule+0x1440/0x1c90
[  247.626617][ T2554]  ? __pfx_unix_stream_read_actor+0x10/0x10
[  247.626619][ T2554]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626621][ T2554]  ? sock_recvmsg+0xc0/0xd0
[  247.626623][ T2554]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626625][ T2554]  ? ____sys_recvmsg+0x82/0x1d0
[  247.626627][ T2554]  schedule_rtlock+0x30/0xd0
[  247.626629][ T2554]  rtlock_slowlock_locked+0x327/0xfb0
[  247.626633][ T2554]  rt_spin_lock+0x7a/0xd0
[  247.626635][ T2554]  task_get_cgroup1+0x6c/0xf0
[  247.626638][ T2554]  bpf_task_get_cgroup1+0xe/0x20
[  247.626640][ T2554]  bpf_prog_28ba4edb92179f43_on_enter+0x47/0x128
[  247.626642][ T2554]  bpf_trace_run2+0x77/0xf0
[  247.626644][ T2554]  __bpf_trace_sys_enter+0x10/0x30
[  247.626646][ T2554]  syscall_trace_enter+0x157/0x1c0
[  247.626648][ T2554]  do_syscall_64+0x2dc/0xfa0
[  247.626650][ T2554]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626652][ T2554]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.626654][ T2554] RIP: 0033:0x7fbfd96fd9ee
[  247.626660][ T2554] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d=
7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0=
f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  247.626662][ T2554] RSP: 002b:00007fbfcd1199c8 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000e8
[  247.626664][ T2554] RAX: ffffffffffffffda RBX: 00007fbfcd11a6c0 RCX: 000=
07fbfd96fd9ee
[  247.626665][ T2554] RDX: 0000000000000020 RSI: 00007fbfd947c200 RDI: 000=
000000000000f
[  247.626665][ T2554] RBP: 00007fbfd9435300 R08: 0000000000000000 R09: 000=
0000000000000
[  247.626666][ T2554] R10: ffffffffffffffff R11: 0000000000000246 R12: 000=
07fbfd947c200
[  247.626667][ T2554] R13: 00007fbfd94384a0 R14: 00007fbfd94384a0 R15: 000=
00000ffffffff
[  247.626670][ T2554]  </TASK>
[  247.626947][ T2554] BUG: scheduling while atomic: IPC I/O Child/2554/0x0=
0000000
[  247.626950][ T2554] Modules linked in:
[  247.626952][ T2554]  bpf_testmod(O)
[  247.626954][ T2554]  netconsole
[  247.626955][ T2554]  ccm
[  247.626956][ T2554]  snd_seq_dummy
[  247.626957][ T2554]  snd_hrtimer
[  247.626958][ T2554]  snd_seq_midi
[  247.626959][ T2554]  snd_seq_midi_event
[  247.626960][ T2554]  snd_seq
[  247.626961][ T2554]  rfcomm
[  247.626962][ T2554]  bnep
[  247.626963][ T2554]  nls_ascii
[  247.626965][ T2554]  nls_cp437
[  247.626966][ T2554]  vfat
[  247.626968][ T2554]  fat
[  247.626970][ T2554]  snd_ctl_led
[  247.626971][ T2554]  snd_hda_codec_realtek
[  247.626972][ T2554]  snd_hda_codec_generic
[  247.626974][ T2554]  snd_hda_scodec_component
[  247.626975][ T2554]  snd_hda_codec_hdmi snd_usb_audio
[  247.626977][ T2554]  btusb
[  247.626978][ T2554]  snd_hda_intel
[  247.626979][ T2554]  btrtl
[  247.626980][ T2554]  snd_intel_dspcfg
[  247.626982][ T2554]  btintel
[  247.626983][ T2554]  btbcm
[  247.626984][ T2554]  snd_soc_dmic
[  247.626985][ T2554]  snd_acp3x_pdm_dma
[  247.626987][ T2554]  snd_acp3x_rn
[  247.626988][ T2554]  snd_usbmidi_lib
[  247.626989][ T2554]  snd_hda_codec uvcvideo
[  247.626991][ T2554]  btmtk
[  247.626992][ T2554]  snd_ump
[  247.626993][ T2554]  snd_soc_core
[  247.626994][ T2554]  videobuf2_vmalloc
[  247.626995][ T2554]  snd_hwdep
[  247.626997][ T2554]  videobuf2_memops
[  247.626998][ T2554]  uvc
[  247.626999][ T2554]  bluetooth
[  247.627001][ T2554]  snd_hda_core snd_rawmidi
[  247.627003][ T2554]  videobuf2_v4l2
[  247.627004][ T2554]  snd_seq_device
[  247.627005][ T2554]  snd_pcm_oss
[  247.627006][ T2554]  videodev
[  247.627007][ T2554]  snd_mixer_oss
[  247.627008][ T2554]  snd_rn_pci_acp3x
[  247.627010][ T2554]  ecdh_generic snd_pcm
[  247.627012][ T2554]  ecc
[  247.627012][ T2554]  snd_acp_config
[  247.627013][ T2554]  videobuf2_common
[  247.627014][ T2554]  snd_soc_acpi
[  247.627015][ T2554]  msi_wmi
[  247.627016][ T2554]  snd_timer
[  247.627017][ T2554]  mc
[  247.627018][ T2554]  sparse_keymap
[  247.627020][ T2554]  snd
[  247.627020][ T2554]  edac_mce_amd
[  247.627021][ T2554]  wmi_bmof
[  247.627022][ T2554]  k10temp
[  247.627023][ T2554]  snd_pci_acp3x
[  247.627024][ T2554]  soundcore
[  247.627025][ T2554]  ccp
[  247.627026][ T2554]  battery
[  247.627028][ T2554]  ac
[  247.627029][ T2554]  sch_fq_codel
[  247.627030][ T2554]  button
[  247.627031][ T2554]  joydev
[  247.627031][ T2554]  hid_sensor_accel_3d
[  247.627033][ T2554]  hid_sensor_prox
[  247.627033][ T2554]  hid_sensor_gyro_3d
[  247.627034][ T2554]  hid_sensor_als
[  247.627036][ T2554]  hid_sensor_magn_3d
[  247.627037][ T2554]  hid_sensor_trigger
[  247.627038][ T2554]  industrialio_triggered_buffer
[  247.627039][ T2554]  kfifo_buf
[  247.627041][ T2554]  industrialio
[  247.627042][ T2554]  evdev
[  247.627043][ T2554]  amd_pmc
[  247.627044][ T2554]  hid_sensor_iio_common
[  247.627045][ T2554]  mt7921e
[  247.627046][ T2554]  mt7921_common
[  247.627047][ T2554]  mt792x_lib
[  247.627048][ T2554]  mt76_connac_lib
[  247.627049][ T2554]  mt76 mac80211
[  247.627050][ T2554]  libarc4 cfg80211
[  247.627052][ T2554]  rfkill
[  247.627052][ T2554]  msr
[  247.627053][ T2554]  fuse nvme_fabrics
[  247.627055][ T2554]  efi_pstore
[  247.627056][ T2554]  configfs
[  247.627057][ T2554]  nfnetlink efivarfs
[  247.627058][ T2554]  autofs4 ext4
[  247.627060][ T2554]  mbcache jbd2
[  247.627061][ T2554]  usbhid
[  247.627062][ T2554]  amdgpu amdxcp
[  247.627064][ T2554]  i2c_algo_bit drm_client_lib
[  247.627065][ T2554]  drm_ttm_helper ttm
[  247.627067][ T2554]  drm_exec gpu_sched
[  247.627068][ T2554]  xhci_pci
[  247.627069][ T2554]  drm_suballoc_helper drm_panel_backlight_quirks
[  247.627071][ T2554]  xhci_hcd cec
[  247.627072][ T2554]  hid_sensor_hub hid_multitouch
[  247.627074][ T2554]  drm_buddy
[  247.627075][ T2554]  mfd_core
[  247.627076][ T2554]  hid_generic
[  247.627076][ T2554]  drm_display_helper
[  247.627077][ T2554]  psmouse
[  247.627079][ T2554]  nvme
[  247.627079][ T2554]  i2c_hid_acpi usbcore
[  247.627081][ T2554]  amd_sfh
[  247.627082][ T2554]  i2c_hid serio_raw
[  247.627083][ T2554]  drm_kms_helper
[  247.627084][ T2554]  hid
[  247.627085][ T2554]  nvme_core
[  247.627086][ T2554]  r8169 i2c_piix4
[  247.627088][ T2554]  usb_common crc16
[  247.627090][ T2554]  i2c_smbus i2c_designware_platform
[  247.627091][ T2554]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[  247.627093][ T2554]=20
[  247.627104][ T2554] CPU: 4 UID: 1000 PID: 2554 Comm: IPC I/O Child Taint=
ed: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{RT,=
(full)}=20
[  247.627108][ T2554] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.627108][ T2554] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.627110][ T2554] Call Trace:
[  247.627111][ T2554]  <TASK>
[  247.627112][ T2554]  dump_stack_lvl+0x6d/0xb0
[  247.627116][ T2554]  __schedule_bug.cold+0x3e/0x4a
[  247.627118][ T2554]  __schedule+0x1440/0x1c90
[  247.627121][ T2554]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627123][ T2554]  ? rt_write_lock+0x106/0x270
[  247.627126][ T2554]  schedule+0x41/0x1a0
[  247.627128][ T2554]  schedule_hrtimeout_range_clock+0xfc/0x110
[  247.627131][ T2554]  do_epoll_wait+0x4fe/0x530
[  247.627133][ T2554]  ? futex_wake+0xb2/0x1c0
[  247.627135][ T2554]  ? __seccomp_filter+0x37/0x590
[  247.627137][ T2554]  ? fput+0x3f/0x90
[  247.627139][ T2554]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
[  247.627142][ T2554]  __x64_sys_epoll_wait+0x5e/0xf0
[  247.627144][ T2554]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627145][ T2554]  ? syscall_trace_enter+0x190/0x1c0
[  247.627147][ T2554]  do_syscall_64+0x6f/0xfa0
[  247.627150][ T2554]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627152][ T2554]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.627153][ T2554] RIP: 0033:0x7fbfd96fd9ee
[  247.627158][ T2554] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d=
7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0=
f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  247.627160][ T2554] RSP: 002b:00007fbfcd1199c8 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000e8
[  247.627162][ T2554] RAX: ffffffffffffffda RBX: 00007fbfcd11a6c0 RCX: 000=
07fbfd96fd9ee
[  247.627163][ T2554] RDX: 0000000000000020 RSI: 00007fbfd947c200 RDI: 000=
000000000000f
[  247.627164][ T2554] RBP: 00007fbfd9435300 R08: 0000000000000000 R09: 000=
0000000000000
[  247.627165][ T2554] R10: ffffffffffffffff R11: 0000000000000246 R12: 000=
07fbfd947c200
[  247.627165][ T2554] R13: 00007fbfd94384a0 R14: 00007fbfd94384a0 R15: 000=
00000ffffffff
[  247.627169][ T2554]  </TASK>
[  247.626447][ T6866] BUG: scheduling while atomic: dav1d-worker/6866/0x00=
000002
[  247.626449][ T6866] Modules linked in:
[  247.626450][ T6866]  bpf_testmod(O)
[  247.626451][ T6866]  netconsole
[  247.626453][ T6866]  ccm
[  247.626454][ T6866]  snd_seq_dummy
[  247.626455][ T6866]  snd_hrtimer
[  247.626456][ T6866]  snd_seq_midi
[  247.626458][ T6866]  snd_seq_midi_event
[  247.626459][ T6866]  snd_seq
[  247.626460][ T6866]  rfcomm
[  247.626462][ T6866]  bnep
[  247.626462][ T6866]  nls_ascii
[  247.626464][ T6866]  nls_cp437
[  247.626465][ T6866]  vfat
[  247.626466][ T6866]  fat
[  247.626467][ T6866]  snd_ctl_led
[  247.626468][ T6866]  snd_hda_codec_realtek
[  247.626469][ T6866]  snd_hda_codec_generic
[  247.626470][ T6866]  snd_hda_scodec_component
[  247.626473][ T6866]  snd_hda_codec_hdmi
[  247.626474][ T6866]  snd_usb_audio
[  247.626476][ T6866]  btusb
[  247.626477][ T6866]  snd_hda_intel
[  247.626478][ T6866]  btrtl
[  247.626480][ T6866]  snd_intel_dspcfg
[  247.626481][ T6866]  btintel
[  247.626482][ T6866]  btbcm
[  247.626484][ T6866]  snd_soc_dmic
[  247.626485][ T6866]  snd_acp3x_pdm_dma
[  247.626485][ T6866]  snd_acp3x_rn
[  247.626486][ T6866]  snd_usbmidi_lib
[  247.626487][ T6866]  snd_hda_codec
[  247.626489][ T6866]  uvcvideo
[  247.626489][ T6866]  btmtk
[  247.626490][ T6866]  snd_ump
[  247.626491][ T6866]  snd_soc_core videobuf2_vmalloc snd_hwdep videobuf2_=
memops uvc bluetooth snd_hda_core snd_rawmidi videobuf2_v4l2 snd_seq_device=
 snd_pcm_oss
[  247.626498][ T6866]  videodev snd_mixer_oss snd_rn_pci_acp3x ecdh_generi=
c snd_pcm ecc
[  247.626502][ T6866]  snd_acp_config videobuf2_common snd_soc_acpi msi_wm=
i snd_timer mc sparse_keymap
[  247.626507][ T6866]  snd edac_mce_amd wmi_bmof k10temp snd_pci_acp3x sou=
ndcore
[  247.626510][ T6866]  ccp battery ac sch_fq_codel button joydev
[  247.626514][ T6866]  hid_sensor_accel_3d hid_sensor_prox hid_sensor_gyro=
_3d hid_sensor_als
[  247.626517][ T6866]  hid_sensor_magn_3d hid_sensor_trigger industrialio_=
triggered_buffer kfifo_buf industrialio
[  247.626520][ T6866]  evdev amd_pmc hid_sensor_iio_common mt7921e mt7921_=
common
[  247.626524][ T6866]  mt792x_lib mt76_connac_lib mt76 mac80211
[  247.626526][ T6866]  libarc4
[  247.626527][ T6866]  cfg80211 rfkill msr fuse nvme_fabrics efi_pstore co=
nfigfs nfnetlink
[  247.626532][ T6866]  efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu
[  247.626536][ T6866]  amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper t=
tm drm_exec
[  247.626540][ T6866]  gpu_sched xhci_pci drm_suballoc_helper drm_panel_ba=
cklight_quirks xhci_hcd
[  247.626543][ T6866]  cec hid_sensor_hub hid_multitouch drm_buddy mfd_core
[  247.626546][ T6866]  hid_generic drm_display_helper psmouse nvme i2c_hid=
_acpi usbcore amd_sfh i2c_hid serio_raw
[  247.626552][ T6866]  drm_kms_helper hid nvme_core r8169 i2c_piix4 usb_co=
mmon
[  247.626555][ T6866]  crc16 i2c_smbus i2c_designware_platform
[  247.626557][ T6866]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[  247.626672][ T6866] CPU: 3 UID: 1000 PID: 6866 Comm: dav1d-worker Tainte=
d: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{RT,(=
full)}=20
[  247.626675][ T6866] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.626676][ T6866] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.626676][ T6866] Call Trace:
[  247.626677][ T6866]  <TASK>
[  247.626678][ T6866]  dump_stack_lvl+0x6d/0xb0
[  247.626681][ T6866]  __schedule_bug.cold+0x3e/0x4a
[  247.626683][ T6866]  __schedule+0x1440/0x1c90
[  247.626685][ T6866]  ? sched_clock_cpu+0x11f/0x1f0
[  247.626687][ T6866]  ? rt_spin_unlock+0x12/0x40
[  247.626688][ T6866]  ? migrate_enable+0x115/0x160
[  247.626690][ T6866]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626693][ T6866]  schedule_rtlock+0x30/0xd0
[  247.626695][ T6866]  rtlock_slowlock_locked+0x327/0xfb0
[  247.626699][ T6866]  rt_spin_lock+0x7a/0xd0
[  247.626701][ T6866]  task_get_cgroup1+0x6c/0xf0
[  247.626703][ T6866]  bpf_task_get_cgroup1+0xe/0x20
[  247.626705][ T6866]  bpf_prog_28ba4edb92179f43_on_enter+0x47/0x128
[  247.626706][ T6866]  bpf_trace_run2+0x77/0xf0
[  247.626709][ T6866]  __bpf_trace_sys_enter+0x10/0x30
[  247.626710][ T6866]  syscall_trace_enter+0x157/0x1c0
[  247.626712][ T6866]  do_syscall_64+0x2dc/0xfa0
[  247.626715][ T6866]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.626716][ T6866]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.626718][ T6866] RIP: 0033:0x7f9d90c43bdb
[  247.626723][ T6866] Code: 37 75 f3 83 e1 03 83 f9 02 0f 84 10 01 00 00 4=
1 80 f1 81 49 8d 7c 10 20 45 31 d2 ba 01 00 00 00 44 89 ce b8 ca 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 0f 87 19 01 00 00 48 83 c4 08 31 c0 5b 5d c3 41
[  247.626725][ T6866] RSP: 002b:00007f9d7b7fdd00 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000ca
[  247.626727][ T6866] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000=
07f9d90c43bdb
[  247.626728][ T6866] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 000=
07f9d7ba113c8
[  247.626729][ T6866] RBP: 00007f9d7ba11000 R08: 00007f9d7ba113a8 R09: 000=
0000000000081
[  247.626730][ T6866] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07f9d844a1620
[  247.626731][ T6866] R13: 00007f9d7b100000 R14: 0000000000000000 R15: 000=
07f9d90987fc0
[  247.626734][ T6866]  </TASK>
[  247.627226][ T6866] BUG: scheduling while atomic: dav1d-worker/6866/0x00=
000000
[  247.627237][ T6866] Modules linked in: bpf_testmod(O)
[  247.627239][ T6866]  netconsole
[  247.627240][ T6866]  ccm snd_seq_dummy
[  247.627242][ T6866]  snd_hrtimer
[  247.627243][ T6866]  snd_seq_midi snd_seq_midi_event
[  247.627245][ T6866]  snd_seq
[  247.627246][ T6866]  rfcomm
[  247.627247][ T6866]  bnep nls_ascii nls_cp437 vfat
[  247.627250][ T6866]  fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec=
_generic snd_hda_scodec_component snd_hda_codec_hdmi snd_usb_audio btusb
[  247.627255][ T6866]  snd_hda_intel btrtl snd_intel_dspcfg btintel
[  247.627258][ T6866]  btbcm snd_soc_dmic
[  247.627260][ T6866]  snd_acp3x_pdm_dma
[  247.627261][ T6866]  snd_acp3x_rn snd_usbmidi_lib
[  247.627263][ T6866]  snd_hda_codec uvcvideo btmtk
[  247.627265][ T6866]  snd_ump snd_soc_core videobuf2_vmalloc snd_hwdep vi=
deobuf2_memops
[  247.627269][ T6866]  uvc bluetooth snd_hda_core
[  247.627271][ T6866]  snd_rawmidi
[  247.627272][ T6866]  videobuf2_v4l2 snd_seq_device snd_pcm_oss videodev
[  247.627275][ T6866]  snd_mixer_oss snd_rn_pci_acp3x ecdh_generic
[  247.627278][ T6866]  snd_pcm
[  247.627290][ T6866]  snd_pci_acp3x
[  247.627292][ T6866]  soundcore
[  247.627293][ T6866]  ccp
[  247.627293][ T6866]  battery
[  247.627294][ T6866]  ac
[  247.627295][ T6866]  sch_fq_codel
[  247.627296][ T6866]  button
[  247.627297][ T6866]  joydev
[  247.627298][ T6866]  hid_sensor_accel_3d
[  247.627299][ T6866]  hid_sensor_prox
[  247.627299][ T6866]  hid_sensor_gyro_3d
[  247.627300][ T6866]  hid_sensor_als
[  247.627301][ T6866]  hid_sensor_magn_3d
[  247.627302][ T6866]  hid_sensor_trigger
[  247.627303][ T6866]  industrialio_triggered_buffer kfifo_buf
[  247.627304][ T6866]  industrialio
[  247.627305][ T6866]  evdev
[  247.627306][ T6866]  amd_pmc
[  247.627307][ T6866]  hid_sensor_iio_common
[  247.627308][ T6866]  mt7921e
[  247.627308][ T6866]  mt7921_common
[  247.627309][ T6866]  mt792x_lib
[  247.627310][ T6866]  mt76_connac_lib mt76
[  247.627311][ T6866]  mac80211
[  247.627312][ T6866]  libarc4
[  247.627313][ T6866]  cfg80211 rfkill
[  247.627314][ T6866]  msr
[  247.627315][ T6866]  fuse
[  247.627316][ T6866]  nvme_fabrics
[  247.627317][ T6866]  efi_pstore
[  247.627318][ T6866]  configfs nfnetlink
[  247.627319][ T6866]  efivarfs
[  247.627324][ T6866]  amdxcp
[  247.627325][ T6866]  i2c_algo_bit
[  247.627326][ T6866]  drm_client_lib drm_ttm_helper
[  247.627328][ T6866]  ttm
[  247.627328][ T6866]  drm_exec gpu_sched
[  247.627330][ T6866]  xhci_pci
[  247.627331][ T6866]  drm_suballoc_helper
[  247.627331][ T6866]  drm_panel_backlight_quirks xhci_hcd
[  247.627333][ T6866]  cec
[  247.627334][ T6866]  hid_sensor_hub
[  247.627335][ T6866]  hid_multitouch
[  247.627336][ T6866]  drm_buddy
[  247.627336][ T6866]  mfd_core
[  247.627337][ T6866]  hid_generic
[  247.627338][ T6866]  drm_display_helper
[  247.627339][ T6866]  psmouse
[  247.627339][ T6866]  nvme
[  247.627340][ T6866]  i2c_hid_acpi
[  247.627341][ T6866]  usbcore
[  247.627342][ T6866]  amd_sfh
[  247.627343][ T6866]  i2c_hid
[  247.627344][ T6866]  serio_raw
[  247.627345][ T6866]  drm_kms_helper
[  247.627346][ T6866]  hid
[  247.627347][ T6866]  nvme_core
[  247.627347][ T6866]  r8169
[  247.627348][ T6866]  i2c_piix4
[  247.627349][ T6866]  usb_common
[  247.627350][ T6866]  crc16
[  247.627350][ T6866]  i2c_smbus
[  247.627365][ T6866]  <TASK>
[  247.627367][ T6866]  dump_stack_lvl+0x6d/0xb0
[  247.627370][ T6866]  __schedule_bug.cold+0x3e/0x4a
[  247.627373][ T6866]  __schedule+0x1440/0x1c90
[  247.627375][ T6866]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627377][ T6866]  ? ktime_get+0x3f/0xf0
[  247.627379][ T6866]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627381][ T6866]  ? clockevents_program_event+0xa6/0x130
[  247.627384][ T6866]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627387][ T6866]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.627389][ T6866]  ? hrtimer_interrupt+0x123/0x220
[  247.627393][ T6866]  schedule+0x41/0x1a0
[  247.627396][ T6866]  irqentry_exit_to_user_mode+0x15c/0x220
[  247.627399][ T6866]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  247.627403][ T6866] RIP: 0033:0x7f9d7bfc90c7
[  247.627408][ T6866] Code: e3 fd 00 c0 d8 c4 e2 65 0b dd c4 e2 5d 0b e5 c=
4 e2 7d 0b c5 c5 e5 61 cc c5 e5 69 dc c5 dd 61 d0 c5 dd 69 e0 c4 c1 7a 6f 3=
c 08 <4d> 8d 04 48 c4 c3 45 38 38 01 c5 95 f5 e9 c5 fd 6f cb c5 95 f5 f2
[  247.627410][ T6866] RSP: 002b:00007f9d7b7fd5e8 EFLAGS: 00000202
[  247.627411][ T6866]=20
[  247.627412][ T6866] RAX: 0000000000000008 RBX: 0000000000000001 RCX: 000=
0000000000500
[  247.627414][ T6866] RDX: 00007f9d77c2338d RSI: 0000000000000500 RDI: 000=
07f9d75623390
[  247.627415][ T6866] RBP: 00007f9d7b100000 R08: 00007f9d77c2518d R09: 000=
0000000000004
[  247.627416][ T6866] R10: 00007f9d75624790 R11: fffffffffffffb00 R12: 000=
000000000038c
[  247.627418][ T6866] R13: 0000000000000500 R14: 000000000000000e R15: 000=
0000000000006
[  247.627422][ T6866]  </TASK>
[  247.628011][ T1102] BUG: scheduling while atomic: in:imklog/1102/0x00000=
002
[  247.628013][ T1102] Modules linked in: bpf_testmod(O) netconsole ccm snd=
_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_seq rfcomm bnep =
nls_ascii nls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_code=
c_generic snd_hda_scodec_component snd_hda_codec_hdmi snd_usb_audio btusb s=
nd_hda_intel btrtl snd_intel_dspcfg btintel btbcm snd_soc_dmic snd_acp3x_pd=
m_dma
[  247.628033][ T1102]  snd_acp3x_rn
[  247.628034][ T1102]  snd_usbmidi_lib snd_hda_codec
[  247.628035][ T1102]  uvcvideo
[  247.628036][ T1102]  btmtk
[  247.628038][ T1102]  snd_ump
[  247.628039][ T1102]  snd_soc_core
[  247.628040][ T1102]  videobuf2_vmalloc
[  247.628041][ T1102]  snd_hwdep
[  247.628042][ T1102]  videobuf2_memops
[  247.628055][ T1102]  videobuf2_common
[  247.628056][ T1102]  snd_soc_acpi
[  247.628057][ T1102]  msi_wmi
[  247.628058][ T1102]  snd_timer
[  247.628059][ T1102]  mc
[  247.628060][ T1102]  sparse_keymap
[  247.628060][ T1102]  snd
[  247.628061][ T1102]  edac_mce_amd
[  247.628062][ T1102]  wmi_bmof
[  247.628063][ T1102]  k10temp
[  247.628064][ T1102]  snd_pci_acp3x
[  247.628065][ T1102]  soundcore
[  247.628066][ T1102]  ccp
[  247.628066][ T1102]  battery
[  247.628067][ T1102]  ac
[  247.628068][ T1102]  sch_fq_codel
[  247.628069][ T1102]  button
[  247.628070][ T1102]  joydev
[  247.628070][ T1102]  hid_sensor_accel_3d
[  247.628072][ T1102]  hid_sensor_prox
[  247.628073][ T1102]  hid_sensor_gyro_3d
[  247.628074][ T1102]  hid_sensor_als
[  247.628075][ T1102]  hid_sensor_magn_3d
[  247.628076][ T1102]  hid_sensor_trigger
[  247.628076][ T1102]  industrialio_triggered_buffer
[  247.628077][ T1102]  kfifo_buf
[  247.628079][ T1102]  industrialio
[  247.628079][ T1102]  evdev
[  247.628080][ T1102]  amd_pmc
[  247.628081][ T1102]  hid_sensor_iio_common
[  247.628082][ T1102]  mt7921e
[  247.628083][ T1102]  mt7921_common
[  247.628084][ T1102]  mt792x_lib
[  247.628084][ T1102]  mt76_connac_lib
[  247.628085][ T1102]  mt76
[  247.628122][ T1102]  drm_kms_helper
[  247.628123][ T1102]  hid
[  247.628124][ T1102]  nvme_core
[  247.628125][ T1102]  r8169
[  247.628125][ T1102]  i2c_piix4
[  247.628126][ T1102]  usb_common
[  247.628127][ T1102]  crc16
[  247.628128][ T1102]  i2c_smbus
[  247.628129][ T1102]  i2c_designware_platform
[  247.628130][ T1102]  i2c_designware_core
[  247.628131][ T1102]  [last unloaded: bpf_testmod(O)]
[  247.628132][ T1102]=20
[  247.628134][ T1102] CPU: 13 UID: 0 PID: 1102 Comm: in:imklog Tainted: G =
     D W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{RT,(full)=
}=20
[  247.628138][ T1102] Tainted: [D]=3DDIE, [W]=3DWARN, [O]=3DOOT_MODULE
[  247.628140][ T1102] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.628141][ T1102] Call Trace:
[  247.628142][ T1102]  <TASK>
[  247.628144][ T1102]  dump_stack_lvl+0x6d/0xb0
[  247.628147][ T1102]  __schedule_bug.cold+0x3e/0x4a
[  247.628150][ T1102]  __schedule+0x1440/0x1c90
[  247.628152][ T1102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628155][ T1102]  ? rt_spin_unlock+0x12/0x40
[  247.628157][ T1102]  ? migrate_enable+0x115/0x160
[  247.628160][ T1102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628162][ T1102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628164][ T1102]  ? futex_hash_put+0x50/0xa0
[  247.628167][ T1102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628169][ T1102]  schedule_rtlock+0x30/0xd0
[  247.628172][ T1102]  rtlock_slowlock_locked+0x327/0xfb0
[  247.628177][ T1102]  rt_spin_lock+0x7a/0xd0
[  247.628180][ T1102]  task_get_cgroup1+0x6c/0xf0
[  247.628183][ T1102]  bpf_task_get_cgroup1+0xe/0x20
[  247.628186][ T1102]  bpf_prog_28ba4edb92179f43_on_enter+0x47/0x128
[  247.628188][ T1102]  bpf_trace_run2+0x77/0xf0
[  247.628192][ T1102]  __bpf_trace_sys_enter+0x10/0x30
[  247.628194][ T1102]  syscall_trace_enter+0x157/0x1c0
[  247.628197][ T1102]  do_syscall_64+0x2dc/0xfa0
[  247.628200][ T1102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628202][ T1102]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.628205][ T1102] RIP: 0033:0x7fc559b89f13
[  247.628209][ T1102] Code: 81 00 00 00 b8 ca 00 00 00 0f 05 c3 66 66 2e 0=
f 1f 84 00 00 00 00 00 40 80 f6 81 45 31 d2 ba 01 00 00 00 b8 ca 00 00 00 0=
f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 05 61 70 15 00 48 89
[  247.628211][ T1102] RSP: 002b:00007fc5595c2248 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000ca
[  247.628213][ T1102] RAX: ffffffffffffffda RBX: 00005562d01bad90 RCX: 000=
07fc559b89f13
[  247.628214][ T1102] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 000=
05562d01c7c70
[  247.628215][ T1102] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
0000000000000
[  247.628217][ T1102] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07fc550006cf0
[  247.628218][ T1102] R13: 0000000000000004 R14: 0000000000098eb0 R15: 000=
05562d01bf880
[  247.628222][ T1102]  </TASK>
[  247.628345][ T1102]  videobuf2_vmalloc snd_hwdep videobuf2_memops uvc bl=
uetooth snd_hda_core
[  247.628348][ T1102]  snd_rawmidi videobuf2_v4l2
[  247.628350][ T1102]  snd_seq_device
[  247.628351][ T1102]  snd_pcm_oss videodev
[  247.628352][ T1102]  snd_mixer_oss snd_rn_pci_acp3x ecdh_generic snd_pcm=
 ecc snd_acp_config videobuf2_common snd_soc_acpi msi_wmi snd_timer mc spar=
se_keymap snd edac_mce_amd wmi_bmof k10temp snd_pci_acp3x soundcore ccp bat=
tery ac sch_fq_codel button joydev hid_sensor_accel_3d hid_sensor_prox hid_=
sensor_gyro_3d hid_sensor_als hid_sensor_magn_3d hid_sensor_trigger industr=
ialio_triggered_buffer kfifo_buf industrialio evdev amd_pmc hid_sensor_iio_=
common mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libar=
c4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs nfnetlink efiv=
arfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bit drm_client=
_lib drm_ttm_helper ttm drm_exec gpu_sched xhci_pci drm_suballoc_helper drm=
_panel_backlight_quirks xhci_hcd cec hid_sensor_hub hid_multitouch drm_budd=
y mfd_core hid_generic drm_display_helper
[  247.628392][ T1102]  psmouse nvme i2c_hid_acpi usbcore amd_sfh
[  247.628394][ T1102]  i2c_hid
[  247.628395][ T1102]  serio_raw drm_kms_helper
[  247.628396][ T1102]  hid nvme_core
[  247.628398][ T1102]  r8169
[  247.628398][ T1102]  i2c_piix4 usb_common
[  247.628400][ T1102]  crc16 i2c_smbus
[  247.628401][ T1102]  i2c_designware_platform i2c_designware_core
[  247.628403][ T1102]  [last unloaded: bpf_testmod(O)]
[  247.628404][ T1102]=20
[  247.628406][ T1102] CPU: 15 UID: 0 PID: 1102 Comm: in:imklog Tainted: G =
     D W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{RT,(full)=
}=20
[  247.628409][ T1102] Tainted: [D]=3DDIE, [W]=3DWARN, [O]=3DOOT_MODULE
[  247.628410][ T1102] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.628411][ T1102] Call Trace:
[  247.628413][ T1102]  <TASK>
[  247.628414][ T1102]  dump_stack_lvl+0x6d/0xb0
[  247.628418][ T1102]  __schedule_bug.cold+0x3e/0x4a
[  247.628420][ T1102]  __schedule+0x1440/0x1c90
[  247.628423][ T1102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628425][ T1102]  ? sched_clock_cpu+0x11f/0x1f0
[  247.628427][ T1102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628429][ T1102]  ? psi_group_change+0x1c9/0x4b0
[  247.628431][ T1102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628433][ T1102]  ? futex_hash_put+0x50/0xa0
[  247.628435][ T1102]  schedule+0x41/0x1a0
[  247.628437][ T1102]  futex_do_wait+0x38/0x70
[  247.628439][ T1102]  __futex_wait+0x91/0x100
[  247.628032][  T555] BUG: scheduling while atomic: systemd-journal/555/0x=
00000002
[  247.628034][  T555] Modules linked in:
[  247.628035][  T555]  bpf_testmod(O) netconsole
[  247.628037][  T555]  ccm
[  247.628037][  T555]  snd_seq_dummy
[  247.628038][  T555]  snd_hrtimer snd_seq_midi
[  247.628039][  T555]  snd_seq_midi_event snd_seq
[  247.628041][  T555]  rfcomm
[  247.628042][  T555]  bnep
[  247.628043][  T555]  nls_ascii
[  247.628056][  T555]  snd_acp3x_pdm_dma
[  247.628057][  T555]  snd_acp3x_rn
[  247.628058][  T555]  snd_usbmidi_lib
[  247.628059][  T555]  snd_hda_codec
[  247.628060][  T555]  uvcvideo
[  247.628060][  T555]  btmtk
[  247.628061][  T555]  snd_ump
[  247.628062][  T555]  snd_soc_core videobuf2_vmalloc
[  247.628063][  T555]  snd_hwdep
[  247.628064][  T555]  videobuf2_memops
[  247.628065][  T555]  uvc
[  247.628065][  T555]  bluetooth
[  247.628066][  T555]  snd_hda_core
[  247.628067][  T555]  snd_rawmidi
[  247.628068][  T555]  videobuf2_v4l2
[  247.628069][  T555]  snd_seq_device
[  247.628070][  T555]  snd_pcm_oss
[  247.628070][  T555]  videodev
[  247.628071][  T555]  snd_mixer_oss
[  247.628072][  T555]  snd_rn_pci_acp3x ecdh_generic
[  247.628073][  T555]  snd_pcm ecc
[  247.628074][  T555]  snd_acp_config
[  247.628075][  T555]  videobuf2_common
[  247.628076][  T555]  snd_soc_acpi msi_wmi
[  247.628077][  T555]  snd_timer
[  247.628078][  T555]  mc sparse_keymap
[  247.628079][  T555]  snd
[  247.628080][  T555]  edac_mce_amd
[  247.628081][  T555]  wmi_bmof
[  247.628082][  T555]  k10temp snd_pci_acp3x
[  247.628083][  T555]  soundcore
[  247.628084][  T555]  ccp
[  247.628084][  T555]  battery
[  247.628085][  T555]  ac
[  247.628086][  T555]  sch_fq_codel button
[  247.628122][  T555]  drm_panel_backlight_quirks
[  247.628123][  T555]  xhci_hcd
[  247.628124][  T555]  cec
[  247.628125][  T555]  hid_sensor_hub
[  247.628125][  T555]  hid_multitouch
[  247.628126][  T555]  drm_buddy
[  247.628127][  T555]  mfd_core
[  247.628128][  T555]  hid_generic drm_display_helper
[  247.628129][  T555]  psmouse
[  247.628130][  T555]  nvme
[  247.628131][  T555]  i2c_hid_acpi
[  247.628131][  T555]  usbcore amd_sfh
[  247.628133][  T555]  i2c_hid serio_raw drm_kms_helper hid nvme_core
[  247.628135][  T555]  r8169 i2c_piix4 usb_common crc16 i2c_smbus i2c_desi=
gnware_platform
[  247.628139][  T555]  i2c_designware_core [last unloaded: bpf_testmod(O)]
[  247.628140][  T555]=20
[  247.628392][  T555] ------------[ cut here ]------------
[  247.628393][  T555] WARNING: CPU: 9 PID: 555 at kernel/time/timer.c:1610=
 __timer_delete_sync+0xad/0x190
[  247.628397][  T555] Modules linked in:
[  247.628398][  T555]  bpf_testmod(O)
[  247.628399][  T555]  netconsole
[  247.628399][  T555]  ccm snd_seq_dummy
[  247.628401][  T555]  snd_hrtimer snd_seq_midi
[  247.628402][  T555]  snd_seq_midi_event snd_seq
[  247.628404][  T555]  rfcomm
[  247.628405][  T555]  bnep nls_ascii nls_cp437 vfat fat
[  247.628407][  T555]  snd_ctl_led snd_hda_codec_realtek snd_hda_codec_gen=
eric snd_hda_scodec_component snd_hda_codec_hdmi
[  247.628410][  T555]  snd_usb_audio btusb
[  247.628411][  T555]  snd_hda_intel
[  247.628412][  T555]  btrtl snd_intel_dspcfg btintel
[  247.628414][  T555]  btbcm snd_soc_dmic snd_acp3x_pdm_dma snd_acp3x_rn s=
nd_usbmidi_lib
[  247.628416][  T555]  snd_hda_codec uvcvideo btmtk snd_ump snd_soc_core v=
ideobuf2_vmalloc
[  247.628419][  T555]  snd_hwdep videobuf2_memops uvc bluetooth
[  247.628421][  T555]  snd_hda_core snd_rawmidi videobuf2_v4l2 snd_seq_dev=
ice
[  247.628424][  T555]  snd_pcm_oss
[  247.628424][  T555]  videodev snd_mixer_oss snd_rn_pci_acp3x
[  247.628426][  T555]  ecdh_generic snd_pcm ecc snd_acp_config
[  247.628428][  T555]  videobuf2_common snd_soc_acpi msi_wmi
[  247.628430][  T555]  snd_timer mc sparse_keymap snd
[  247.628432][  T555]  edac_mce_amd wmi_bmof k10temp
[  247.628434][  T555]  snd_pci_acp3x soundcore ccp battery ac
[  247.628436][  T555]  sch_fq_codel button joydev hid_sensor_accel_3d
[  247.628439][  T555]  hid_sensor_prox hid_sensor_gyro_3d hid_sensor_als
[  247.628497][  T555] Call Trace:
[  247.628498][  T555]  <TASK>
[  247.628500][  T555]  uprobe_free_utask+0x3c/0xb0
[  247.628504][  T555]  mm_release+0x12/0x100
[  247.628507][  T555]  do_exit+0x1cf/0xa20
[  247.628510][  T555]  do_group_exit+0x33/0x90
[  247.628513][  T555]  get_signal+0x8bb/0x8c0
[  247.628516][  T555]  ? force_sig_fault+0x5d/0x80
[  247.628519][  T555]  arch_do_signal_or_restart+0x2d/0x240
[  247.628521][  T555]  ? srso_alias_return_thunk+0x5/0xfbef5
[  247.628524][  T555]  irqentry_exit_to_user_mode+0x181/0x220
[  247.628527][  T555]  asm_exc_page_fault+0x26/0x30
[  247.628528][  T555] RIP: 0033:0x7fcc682f971f
[  247.628531][  T555] Code: e3 ff 66 0f 1f 84 00 00 00 00 00 48 8d 4c 24 5=
0 be 01 00 00 00 48 89 df e8 ee fd e3 ff 85 c0 0f 88 f6 fe ff ff 48 8b 44 2=
4 50 <48> 89 68 18 e9 aa fc ff ff 0f 1f 84 00 00 00 00 00 48 3b ab 78 01
[  247.628533][  T555] RSP: 002b:00007ffc27fae8b0 EFLAGS: 00010246
[  247.628534][  T555] RAX: 00007fcc65722480 RBX: 000056544ee8cc30 RCX: 000=
07fcc68435600
[  247.628535][  T555] RDX: 0000000000000000 RSI: 00007fcc65722480 RDI: 000=
056544ee8cc30
[  247.628536][  T555] RBP: 0000000000efe570 R08: 0000000000000071 R09: 000=
056544ee8cc68
[  247.628537][  T555] R10: a500d93530668c6d R11: 0000000000000297 R12: 000=
056544eea3180
[  247.628538][  T555] R13: 00000000001c3a90 R14: 00007ffc27faea98 R15: 000=
07ffc27faea90
[  247.628541][  T555]  </TASK>
[  247.628542][  T555] ---[ end trace 0000000000000000 ]---
[  247.627485][    T0] kernel tried to execute NX-protected page - exploit =
attempt? (uid: 0)
[  247.627486][    T0] BUG: unable to handle page fault for address: ffffff=
ff91fde6d0
[  247.627487][    T0] #PF: supervisor instruction fetch in kernel mode
[  247.627489][    T0] #PF: error_code(0x0011) - permissions violation
[  247.627490][    T0] PGD 480a47067 P4D 480a47067 PUD 480a48063 PMD 800000=
0480a001e3=20
[  247.627493][    T0] Oops: Oops: 0011 [#1] SMP NOPTI
[  247.627495][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/8 Tainted: G     =
   W  O        6.15.0-rc7-next-20250523-gcc-dirty #1 PREEMPT_{RT,(full)}=20
[  247.627497][    T0] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  247.627498][    T0] Hardware name: Micro-Star International Co., Ltd. Al=
pha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  247.627499][    T0] RIP: 0010:acpi_idle_driver+0x150/0xa14
[  247.627501][    T0] Code: 00 00 00 00 00 00 12 00 00 00 00 00 00 00 24 0=
0 00 00 00 4b 25 91 ff ff ff ff 10 49 e1 90 ff ff ff ff 20 4a 25 91 ff ff f=
f ff <43> 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41 43 50 49 20 49
[  247.627503][    T0] RSP: 0018:ffffd115401f7e48 EFLAGS: 00010046
[  247.627504][    T0] RAX: ffff892541074200 RBX: 0000000000000003 RCX: 000=
0000000000000
[  247.627505][    T0] RDX: 0000000000000000 RSI: 0000000055555554 RDI: 000=
0000000000000
[  247.627506][    T0] RBP: 0000000000000003 R08: 0000000000002001 R09: 000=
0000000000000
[  247.627507][    T0] R10: ffff892541074200 R11: ffff8933ee617d40 R12: fff=
fffff91fde580
[  247.627508][    T0] R13: ffff892542528000 R14: 475da8fc8a8e7c00 R15: 000=
00000ee82d0d0
[  247.627509][    T0] FS:  0000000000000000(0000) GS:ffff89345be5f000(0000=
) knlGS:0000000000000000
[  247.627510][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  247.627511][    T0] CR2: ffffffff91fde6d0 CR3: 0000000195538000 CR4: 000=
0000000750ef0
[  247.627512][    T0] PKRU: 55555554
[  247.627512][    T0] Call Trace:
[  247.627513][    T0]  <TASK>
[  247.627514][    T0]  ? cpuidle_enter_state+0x93/0x6c0
[  247.627517][    T0]  ? cpuidle_enter+0x2d/0x40
[  247.627520][    T0]  ? do_idle+0x1df/0x260
[  247.627522][    T0]  ? cpu_startup_entry+0x29/0x30
[  247.627523][    T0]  ? start_secondary+0x125/0x160
[  247.627526][    T0]  ? common_startup_64+0x13e/0x148
[  247.627530][    T0]  </TASK>
[  247.627531][    T0] Modules linked in: bpf_testmod(O) netconsole ccm snd=
_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_seq rfcomm bnep =
nls_ascii nls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_code=
c_generic snd_hda_scodec_component snd_hda_codec_hdmi snd_usb_audio btusb s=
nd_hda_intel btrtl snd_intel_dspcfg btintel btbcm snd_soc_dmic snd_acp3x_pd=
m_dma snd_acp3x_rn snd_usbmidi_lib snd_hda_codec uvcvideo btmtk snd_ump snd=
_soc_core videobuf2_vmalloc snd_hwdep videobuf2_memops uvc bluetooth snd_hd=
a_core snd_rawmidi videobuf2_v4l2 snd_seq_device snd_pcm_oss videodev snd_m=
ixer_oss snd_rn_pci_acp3x ecdh_generic snd_pcm ecc snd_acp_config videobuf2=
_common snd_soc_acpi msi_wmi snd_timer mc sparse_keymap snd edac_mce_amd wm=
i_bmof k10temp snd_pci_acp3x soundcore ccp battery ac sch_fq_codel button j=
oydev hid_sensor_accel_3d hid_sensor_prox hid_sensor_gyro_3d hid_sensor_als=
 hid_sensor_magn_3d hid_sensor_trigger industrialio_triggered_buffer kfifo_=
buf industrialio evdev am
[  247.627577][    T0]  mt7921_common mt792x_lib mt76_connac_lib mt76 mac80=
211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs nfnet=
link efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bit d=
rm_client_lib drm_ttm_helper ttm drm_exec gpu_sched xhci_pci drm_suballoc_h=
elper drm_panel_backlight_quirks xhci_hcd cec hid_sensor_hub hid_multitouch=
 drm_buddy mfd_core hid_generic drm_display_helper psmouse nvme i2c_hid_acp=
i usbcore amd_sfh i2c_hid serio_raw drm_kms_helper hid nvme_core r8169 i2c_=
piix4 usb_common crc16 i2c_smbus i2c_designware_platform i2c_designware_cor=
e [last unloaded: bpf_testmod(O)]
[  247.627604][    T0] CR2: ffffffff91fde6d0
[  247.627605][    T0] ---[ end trace 0000000000000000 ]---
[  247.628268][    T0] BUG: kernel NULL pointer dereference, address: 00000=
00000000000
[  247.628256][    T0] Kernel panic - not syncing: stack-protector: Kernel =
stack is corrupted in: get_record_print_text_size+0x5e/0x60
[  247.628629][    T0] Shutting down cpus with NMI
[  247.628629][    T0] Kernel Offset: 0xf400000 from 0xffffffff81000000 (re=
location range: 0xffffffff80000000-0xffffffffbfffffff)
[  247.628629][    T0] pstore: dump skipped in Panic path because of concur=
rent dump
[  247.628629][    T0] ---[ end Kernel panic - not syncing: stack-protector=
: Kernel stack is corrupted in: get_record_print_text_size+0x5e/0x60 ]---

So I enabled CONFIG_SCHED_STACK_END_CHECK=3Dy and CONFIG_DEBUG_ATOMIC_SLEEP=
=3Dy.
With this I get warnings when running the bpf test_progs (without these con=
fig option
I do not get warnings before the system locks up) even thought I did
not get a lockup/panic this time (I avoided watching a video this time)

[   T16] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[   T16] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 16, name: p=
r/legacy
[   T16] preempt_count: 1, expected: 0
[   T16] RCU nest depth: 2, expected: 2
[   T16] CPU: 15 UID: 0 PID: 16 Comm: pr/legacy Tainted: G           O     =
   6.15.0-rc7-next-20250523-gcc-dirty #2 PREEMPT_{RT,(full)}=20
[   T16] Tainted: [O]=3DOOT_MODULE
[   T16] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[   T16] Call Trace:
[   T16]  <TASK>
[   T16]  dump_stack_lvl+0x6d/0xb0
[   T16]  __might_resched.cold+0xaf/0xbd
[   T16]  rt_spin_lock+0x47/0xf0
[   T16]  ? srso_alias_return_thunk+0x5/0xfbef5
[   T16]  kmem_cache_free+0x13d/0x3b0
[   T16]  skb_release_data+0x149/0x1c0
[   T16]  __kfree_skb+0x29/0x40
[   T16]  zap_completion_queue+0xee/0x110
[   T16]  netpoll_send_skb+0x24f/0x2e0
[   T16]  write_msg+0x12c/0x140 [netconsole]
[   T16]  console_flush_all+0x28f/0x500
[   T16]  __console_flush_and_unlock+0x51/0xf0
[   T16]  ? __pfx_legacy_kthread_func+0x10/0x10
[   T16]  legacy_kthread_func+0x38/0xf0
[   T16]  ? __pfx_autoremove_wake_function+0x10/0x10
[   T16]  kthread+0x119/0x210
[   T16]  ? __pfx_kthread+0x10/0x10
[   T16]  ret_from_fork+0x1d8/0x200
[   T16]  ? __pfx_kthread+0x10/0x10
[   T16]  ret_from_fork_asm+0x1a/0x30
[   T16]  </TASK>
[...]
[   T16] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[   T16] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 16, name: p=
r/legacy
[   T16] preempt_count: 1, expected: 0
[   T16] RCU nest depth: 2, expected: 2
[   T16] CPU: 15 UID: 0 PID: 16 Comm: pr/legacy Tainted: G        W  O     =
   6.15.0-rc7-next-20250523-gcc-dirty #2 PREEMPT_{RT,(full)}=20
[   T16] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[   T16] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[   T16] Call Trace:
[   T16]  <TASK>
[   T16]  dump_stack_lvl+0x6d/0xb0
[   T16]  __might_resched.cold+0xaf/0xbd
[   T16]  rt_spin_lock+0x47/0xf0
[   T16]  ? srso_alias_return_thunk+0x5/0xfbef5
[   T16]  kmem_cache_free+0x13d/0x3b0
[   T16]  skb_release_data+0x149/0x1c0
[   T16]  __kfree_skb+0x29/0x40
[   T16]  zap_completion_queue+0xee/0x110
[   T16]  netpoll_send_skb+0x24f/0x2e0
[   T16]  write_msg+0x12c/0x140 [netconsole]
[   T16]  console_flush_all+0x28f/0x500
[   T16]  __console_flush_and_unlock+0x51/0xf0
[   T16]  ? __pfx_legacy_kthread_func+0x10/0x10
[   T16]  legacy_kthread_func+0x38/0xf0
[   T16]  ? __pfx_autoremove_wake_function+0x10/0x10
[   T16]  kthread+0x119/0x210
[   T16]  ? __pfx_kthread+0x10/0x10
[   T16]  ret_from_fork+0x1d8/0x200
[   T16]  ? __pfx_kthread+0x10/0x10
[   T16]  ret_from_fork_asm+0x1a/0x30
[   T16]  </TASK>
[...]
[ T3289] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T3289] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3289, name:=
 test_progs
[ T3289] preempt_count: 1, expected: 0
[ T3289] RCU nest depth: 2, expected: 2
[ T3289] CPU: 10 UID: 0 PID: 3289 Comm: test_progs Tainted: G        W  O  =
      6.15.0-rc7-next-20250523-gcc-dirty #2 PREEMPT_{RT,(full)}=20
[ T3289] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T3289] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T3289] Call Trace:
[ T3289]  <TASK>
[ T3289]  dump_stack_lvl+0x6d/0xb0
[ T3289]  __might_resched.cold+0xaf/0xbd
[ T3289]  rt_spin_lock+0x47/0xf0
[ T3289]  ? migrate_enable+0x115/0x160
[ T3289]  task_get_cgroup1+0x6c/0xf0
[ T3289]  bpf_task_get_cgroup1+0xe/0x20
[ T3289]  bpf_prog_284ec2fd004dd2fe_on_enter+0x62/0x1d4
[ T3289]  bpf_trace_run2+0x9c/0x120
[ T3289]  __bpf_trace_sys_enter+0x37/0x60
[ T3289]  syscall_trace_enter+0x17f/0x1e0
[ T3289]  do_syscall_64+0x2dc/0xfa0
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T3289] RIP: 0033:0x7f49364f3779
[ T3289] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T3289] RSP: 002b:00007fff31499fe8 EFLAGS: 00000206 ORIG_RAX: 000000000000=
0141
[ T3289] RAX: ffffffffffffffda RBX: 00007fff3149a778 RCX: 00007f49364f3779
[ T3289] RDX: 0000000000000040 RSI: 00007fff3149a060 RDI: 000000000000001c
[ T3289] RBP: 00007fff3149a000 R08: 00007fff3149a060 R09: 00007fff3149a060
[ T3289] R10: 0000558d7c403f39 R11: 0000000000000206 R12: 0000000000000000
[ T3289] R13: 00007fff3149a788 R14: 00007f4936b28000 R15: 0000558d7eaf6890
[ T3289]  </TASK>
[...]
[ T6946] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T6946] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6946, name:=
 test_progs
[ T6946] preempt_count: 1, expected: 0
[ T6946] RCU nest depth: 0, expected: 0
[ T6946] CPU: 1 UID: 0 PID: 6946 Comm: test_progs Tainted: G        W  O   =
     6.15.0-rc7-next-20250523-gcc-dirty #2 PREEMPT_{RT,(full)}=20
[ T6946] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T6946] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T6946] Call Trace:
[ T6946]  <TASK>
[ T6946]  dump_stack_lvl+0x6d/0xb0
[ T6946]  __might_resched.cold+0xaf/0xbd
[ T6946]  rt_spin_lock+0x47/0xf0
[ T6946]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T6946]  ? timerqueue_add+0x71/0xc0
[ T6946]  ___slab_alloc.isra.0+0x7b/0xb00
[ T6946]  ? sched_clock_cpu+0x65/0x1f0
[ T6946]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T6946]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T6946]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T6946]  ? finish_task_switch.isra.0+0x9b/0x2f0
[ T6946]  ? bpf_map_kmalloc_node+0x72/0x130
[ T6946]  __kmalloc_node_noprof+0xd2/0x3b0
[ T6946]  bpf_map_kmalloc_node+0x72/0x130
[ T6946]  __bpf_async_init+0x104/0x290
[ T6946]  bpf_timer_init+0x33/0x40
[ T6946]  bpf_prog_03f8615b5cb1a541_start_cb+0x5d/0x91
[ T6946]  bpf_prog_e039af9d31be3357_start_timer+0x65/0x8a
[ T6946]  bpf_prog_test_run_syscall+0xdd/0x210
[ T6946]  ? fput+0x3f/0x90
[ T6946]  __sys_bpf+0xc12/0x2740
[ T6946]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T6946]  ? preempt_count_sub+0x4b/0x60
[ T6946]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T6946]  ? futex_wake+0xb2/0x1c0
[ T6946]  __x64_sys_bpf+0x21/0x30
[ T6946]  do_syscall_64+0x6f/0xfa0
[ T6946]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T6946]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T6946] RIP: 0033:0x7f49364f3779
[ T6946] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T6946] RSP: 002b:00007f4925ffa878 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0141
[ T6946] RAX: ffffffffffffffda RBX: 00007f4925ffbcdc RCX: 00007f49364f3779
[ T6946] RDX: 0000000000000050 RSI: 00007f4925ffa8b0 RDI: 000000000000000a
[ T6946] RBP: 00007f4925ffa890 R08: 0000000000000004 R09: 00007f4925ffa8b0
[ T6946] R10: 00007fff3149a440 R11: 0000000000000202 R12: 0000000000000020
[ T6946] R13: 000000000000005f R14: 00007fff3149a230 R15: 00007f49257fb000
[ T6946]  </TASK>
[...]
[ T3289] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T3289] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3289, name:=
 new_name
[ T3289] preempt_count: 1, expected: 0
[ T3289] RCU nest depth: 1, expected: 1
[ T3289] CPU: 10 UID: 0 PID: 3289 Comm: new_name Tainted: G        W  O    =
    6.15.0-rc7-next-20250523-gcc-dirty #2 PREEMPT_{RT,(full)}=20
[ T3289] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T3289] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T3289] Call Trace:
[ T3289]  <TASK>
[ T3289]  dump_stack_lvl+0x6d/0xb0
[ T3289]  __might_resched.cold+0xaf/0xbd
[ T3289]  rt_spin_lock+0x47/0xf0
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  ___slab_alloc.isra.0+0x7b/0xb00
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  ? orc_find.part.0+0x148/0x1e0
[ T3289]  ? bpf_map_kmalloc_node+0x72/0x130
[ T3289]  __kmalloc_node_noprof+0xd2/0x3b0
[ T3289]  ? kernel_text_address+0x70/0xd0
[ T3289]  bpf_map_kmalloc_node+0x72/0x130
[ T3289]  __bpf_async_init+0x104/0x290
[ T3289]  bpf_timer_init+0x33/0x40
[ T3289]  bpf_prog_208954fba389149b_test1+0x87/0x16f
[ T3289]  bpf_trampoline_6442502366+0x43/0xa7
[ T3289]  bpf_fentry_test1+0x9/0x20
[ T3289]  bpf_prog_test_run_tracing+0x132/0x290
[ T3289]  ? fput+0x3f/0x90
[ T3289]  __sys_bpf+0xc12/0x2740
[ T3289]  __x64_sys_bpf+0x21/0x30
[ T3289]  do_syscall_64+0x6f/0xfa0
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T3289] RIP: 0033:0x7f49364f3779
[ T3289] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T3289] RSP: 002b:00007fff3149a0d8 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0141
[ T3289] RAX: ffffffffffffffda RBX: 00007fff3149a778 RCX: 00007f49364f3779
[ T3289] RDX: 0000000000000050 RSI: 00007fff3149a110 RDI: 000000000000000a
[ T3289] RBP: 00007fff3149a0f0 R08: 00000000ffffffff R09: 00007fff3149a110
[ T3289] R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000000
[ T3289] R13: 00007fff3149a788 R14: 00007f4936b28000 R15: 0000558d7eaf6890
[ T3289]  </TASK>
[T10029] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[T10029] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 10029, name=
: new_name
[T10029] preempt_count: 1, expected: 0
[T10029] RCU nest depth: 0, expected: 0
[T10029] CPU: 13 UID: 0 PID: 10029 Comm: new_name Tainted: G        W  O   =
     6.15.0-rc7-next-20250523-gcc-dirty #2 PREEMPT_{RT,(full)}=20
[T10029] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[T10029] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[T10029] Call Trace:
[T10029]  <TASK>
[T10029]  dump_stack_lvl+0x6d/0xb0
[T10029]  __might_resched.cold+0xaf/0xbd
[T10029]  rt_spin_lock+0x47/0xf0
[T10029]  ___slab_alloc.isra.0+0x7b/0xb00
[T10029]  ? orc_find.part.0+0x148/0x1e0
[T10029]  ? srso_alias_return_thunk+0x5/0xfbef5
[T10029]  ? srso_alias_return_thunk+0x5/0xfbef5
[T10029]  ? is_bpf_text_address+0x22/0x30
[T10029]  ? srso_alias_return_thunk+0x5/0xfbef5
[T10029]  ? bpf_map_kmalloc_node+0x72/0x130
[T10029]  __kmalloc_node_noprof+0xd2/0x3b0
[T10029]  ? perf_callchain_kernel+0xa5/0x140
[T10029]  bpf_map_kmalloc_node+0x72/0x130
[T10029]  __bpf_async_init+0x104/0x290
[T10029]  bpf_timer_init+0x33/0x40
[T10029]  bpf_prog_6ca587954a1650c7_race+0x9c/0xe1
[T10029]  bpf_prog_test_run_syscall+0xdd/0x210
[T10029]  ? fput+0x3f/0x90
[T10029]  __sys_bpf+0xc12/0x2740
[T10029]  __x64_sys_bpf+0x21/0x30
[T10029]  do_syscall_64+0x6f/0xfa0
[T10029]  ? srso_alias_return_thunk+0x5/0xfbef5
[T10029]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[T10029] RIP: 0033:0x7f49364f3779
[T10029] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[T10029] RSP: 002b:00007f4923ff6898 EFLAGS: 00000206 ORIG_RAX: 000000000000=
0141
[T10029] RAX: ffffffffffffffda RBX: 00007f4923ff7cdc RCX: 00007f49364f3779
[T10029] RDX: 0000000000000050 RSI: 00007f4923ff68d0 RDI: 000000000000000a
[T10029] RBP: 00007f4923ff68b0 R08: 00007f4923ff76c0 R09: 00007f4923ff68d0
[T10029] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000020
[T10029] R13: 000000000000005f R14: 00007fff31499ff0 R15: 00007f49237f7000
[T10029]  </TASK>
[...]
[ T3289] BUG: sleeping function called from invalid context at kernel/locki=
ng/spinlock_rt.c:48
[ T3289] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3289, name:=
 new_name
[ T3289] preempt_count: 1, expected: 0
[ T3289] RCU nest depth: 3, expected: 3
[ T3289] CPU: 6 UID: 0 PID: 3289 Comm: new_name Tainted: G        W  O     =
   6.15.0-rc7-next-20250523-gcc-dirty #2 PREEMPT_{RT,(full)}=20
[ T3289] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ T3289] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.10F 11/11/2024
[ T3289] Call Trace:
[ T3289]  <TASK>
[ T3289]  dump_stack_lvl+0x6d/0xb0
[ T3289]  __might_resched.cold+0xaf/0xbd
[ T3289]  rt_spin_lock+0x47/0xf0
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  ___slab_alloc.isra.0+0x7b/0xb00
[ T3289]  ? ___slab_alloc.isra.0+0x289/0xb00
[ T3289]  ? ___slab_alloc.isra.0+0x289/0xb00
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  ? bpf_map_kmalloc_node+0x72/0x130
[ T3289]  __kmalloc_node_noprof+0xd2/0x3b0
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  bpf_map_kmalloc_node+0x72/0x130
[ T3289]  __bpf_async_init+0x104/0x290
[ T3289]  bpf_prog_97c348ba29efa0d1_test_call_array_sleepable+0xb3/0x10e
[ T3289]  bpf_test_run+0x200/0x390
[ T3289]  ? bpf_test_run+0x10d/0x390
[ T3289]  ? kmem_cache_alloc_noprof+0x82/0x210
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  ? migrate_enable+0x115/0x160
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  ? kmem_cache_alloc_noprof+0x82/0x210
[ T3289]  bpf_prog_test_run_skb+0x37b/0x7c0
[ T3289]  ? fput+0x3f/0x90
[ T3289]  __sys_bpf+0xc12/0x2740
[ T3289]  __x64_sys_bpf+0x21/0x30
[ T3289]  do_syscall_64+0x6f/0xfa0
[ T3289]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3289]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T3289] RIP: 0033:0x7f49364f3779
[ T3289] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 =
48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 0=
1 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T3289] RSP: 002b:00007fff31499c38 EFLAGS: 00000202 ORIG_RAX: 000000000000=
0141
[ T3289] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f49364f3779
[ T3289] RDX: 0000000000000050 RSI: 00007fff31499c70 RDI: 000000000000000a
[ T3289] RBP: 00007fff31499c50 R08: 00000000ffffffff R09: 00007fff31499c70
[ T3289] R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000000
[ T3289] R13: 00007fff3149a788 R14: 00007f4936b28000 R15: 0000558d7eaf6890
[ T3289]  </TASK>
[...]

Bert Karwatzki

