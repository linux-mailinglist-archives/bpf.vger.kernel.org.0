Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A33221047B
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGAHIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 03:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGAHIF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 03:08:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B4AC061755
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 00:08:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p20so23330670ejd.13
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t1vAMxrarU9ahYOxhxdFgytVIfY9BfpJCnAxcVVFlv8=;
        b=qjmiOHG/dHRBKl863fElLepCYwBMZIqw+Kzrd4A3CvaoWMEYVxdo3+UAtZ/kJbrp+E
         Tta/DaKi17U9ges0mXkjFAOTb7dW/JSqMc06PgAkvsFOKg8AXnx33B+K1m1sKdiyrPnP
         KAFzr2yK0m2mTkJ+zggwmzR4vcZ6p5rezYtNjBiXVxSAurvDAbnebGHFxtBfWQhdr84Q
         gBMOi2URwGC4eV8viLqNEFnAUIzeJ3H6UdTRdqI8b61i9+aYeGgirOmB4illkQ8rCcXb
         IvEV8C062TlZDDq1G5gw1syPDAQw9AIFT7UNekWBm3xMTZiuAhdDETqAfv1peIzLSXKy
         mdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1vAMxrarU9ahYOxhxdFgytVIfY9BfpJCnAxcVVFlv8=;
        b=RG6CScQ61tA9meF9G/Ci2lVTsgppRncpxwZcRkZIbmizPsb9BNRe5t2GdBKf2WVZpk
         MIHdGstCQ8PfV+sQ82qPGaAEhwAtW+Xzxq5YroYKHLConOgbAhaYQNhPkXI2QtpGRcgK
         gwLXCYq7C+jmV/odujCIxGc9A2Q5StQm7a+iMNvhMtn3d9Z/jEnkLqzauD7P7mAE0Q41
         O9PoNAyFK66w2K5QjNGszoG5SCjjbOESupH1sTFUnRXTILXGAxseEoEo0u0yhYOxywBl
         tIvafx0vi2kse8Oyw5F4799vw4uv1VP2vqoZxCUlVF4TnrVPCdbKC/y51AtWojHAtkqV
         I+ZQ==
X-Gm-Message-State: AOAM532uZj38gyOWzGAmvh8ouKBf7FKH15joQ3qQgTzp0guslSsI0a7n
        4lXstq8/tho36rrimAUryGz8XDpfBg==
X-Google-Smtp-Source: ABdhPJzuu3h39XF4v5fDi8pfoz1CVznJwFmc3GaQghP99IiByy534FRe0nONqyD5a839P2lYKu1vGQ==
X-Received: by 2002:a17:906:4b59:: with SMTP id j25mr17040171ejv.301.1593587282875;
        Wed, 01 Jul 2020 00:08:02 -0700 (PDT)
Received: from [192.168.254.199] (x4d0c3c5b.dyn.telefonica.de. [77.12.60.91])
        by smtp.gmail.com with ESMTPSA id d20sm5272263edy.9.2020.07.01.00.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 00:08:02 -0700 (PDT)
Subject: Re: BUG: kernel NULL pointer dereference in
 __cgroup_bpf_run_filter_skb
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
 <b62a18d0-1f78-3bf5-38b2-08d9a779e432@iogearbox.net>
From:   Thomas Reim <reimth@gmail.com>
Message-ID: <92acbf2d-9d21-5074-cb07-0a3f206bd090@gmail.com>
Date:   Wed, 1 Jul 2020 09:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b62a18d0-1f78-3bf5-38b2-08d9a779e432@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> We have experienced a kernel BPF null pointer dereference issue on all
>> our machines since mid of June. It might be related to an upgrade of
>> libvirt/kvm/qemu at that point of time. But we’re not sure.
>>
>> None of the servers can be used with this bug, as they crash latest
>> one hour after reboot. The time period until kernel panic can be
>> easily reduced down to 2 minutes, when starting one or more
>> applications of the following list:
>> - LXD daemon (4.2.1)
>> - libvirtd daemon (6.4.0) with qemu/kvm guests
>> - NFS server 2.5.1
>> - Mozilla Firefox
>> - Mozilla Thunderbird
>>
>> If none of the applications run, the systems seem to be stable.
>>
>> Intermediate solution:
>> Downgrade Linux kernel to 4.9.226 LTS or 4.4.226  LTS on all the machines
>>
>> Why this solution works is not clear, yet. One of the major
>> differences we saw is, that both kernel packages have been configured
>> with user namespaces disabled.
>>
>> We experienced the kernel freeze on following Arch Linux kernels:
>> - 5.7.0 (5.7.0-3-MANJARO x64)
>> - 5.6.16 (5.6.16-1-MANJARO x64)
>> - 5.4.44 (5.4.44-1-MANJARO x64)
>> - 4.19.126 (4.19.126-1-MANJARO x64)
>> - 4.14.183 (4.14.183-1-MANJARO x64)
>> Kernel configs can be taken from 
>> https://gitlab.manjaro.org/packages/core.
>>
>> Subsequent e-mails will contain the relevant extracts from journal or
>> netconsole logs.
>>
>> Help and support on this issue is welcome.
> 
> Fix is under discussion here:
> 
>    
> https://lore.kernel.org/netdev/20200616180352.18602-1-xiyou.wangcong@gmail.com/ 
> 
> 
> Thanks,
> Daniel

Dear Daniel,

thank you for the hint. I will try to follow-up the discussion. For your 
convenience I have added some of our many and various logs to this 
thread. Maybe it will be of some help for the team.

Below you will find one log from kernel 4.14, which maybe outlines a 
different issue. Do we need another thread or do you judge it to have 
the same root cause?

Kernel 4.14.183 (4.14.183-1-MANJARO x64)

BUG: unable to handle kernel paging request at 0000200000000002
IP: __cgroup_bpf_run_filter_skb+0xca/0x1b0
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun 
ebtable_filter ebtables devlink ip6table_filter ip6_tables 
iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid 
nls_iso8859_1 nls_cp437 vfat fat input_leds joydev mousedev 
snd_hda_codec_hdmi eeepc_wmi iTCO_wdt asus_wmi mei_wdt sparse_keymap 
rfkill intel_rapl iTCO_vendor_support led_class wmi_bmof 
x86_pkg_temp_thermal intel_powerclamp coretemp evdev mac_hid kvm_intel 
i915 snd_hda_codec_realtek snd_hda_codec_generic kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc snd_hda_intel 
aesni_intel aes_x86_64 crypto_simd glue_helper cryptd i2c_algo_bit 
snd_hda_codec intel_cstate drm_kms_helper pcspkr snd_hda_core 
intel_rapl_perf snd_hwdep e1000e snd_pcm r8169 i2c_i801 intel_gtt mii 
syscopyarea snd_timer sysfillrect
  sysimgblt snd ptp lpc_ich mei_me fb_sys_fops soundcore shpchp pps_core 
mei wmi thermal fan pcc_cpufreq video button sch_fq_codel nfsd 
auth_rpcgss oid_registry drm nfs_acl lockd grace agpgart sunrpc 
ip_tables x_tables ext4 crc16 mbcache jbd2 fscrypto dm_thin_pool 
dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio 
hid_generic hid_logitech_hidpp dm_mod hid_logitech_dj usbhid hid sr_mod 
sd_mod cdrom ahci libahci ehci_pci xhci_pci ehci_hcd libata xhci_hcd 
crc32c_intel scsi_mod usbcore usb_common
CPU: 0 PID: 1313 Comm: vhost-1306 Not tainted 4.14.183-1-MANJARO #1
Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
task: ffff90a042548000 task.stack: ffff9c4e82b4c000
RIP: 0010:__cgroup_bpf_run_filter_skb+0xca/0x1b0
RSP: 0018:ffff9c4e82b4f9a8 EFLAGS: 00010296
RAX: ffff909fa973804e RBX: ffff909efbb6d800 RCX: 0000000000000001
RDX: ffff909fa973804e RSI: ffff909efbb6d800 RDI: ffff90a06c0a2000
RBP: 0000000000000014 R08: 0000000000000001 R09: ffff90a06c0a2000
R10: 000000000000af02 R11: 000000000300a8c0 R12: 0000200000000000
R13: 0000000000000000 R14: 0000000000000014 R15: ffff909fa973804e
FS:  0000000000000000(0000) GS:ffff90a09fa00000(0000) knlGS:0000000000000000
BUG: unable to handle kernel paging request at 0000200000000002
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000002 CR3: 00000003c2438001 CR4: 00000000001626f0
Call Trace:
  sk_filter_trim_cap+0xd1/0x1a0
  tcp_v4_rcv+0x921/0xbc0
  ? ip_local_deliver+0xbf/0x120
IP: __cgroup_bpf_run_filter_skb+0xca/0x1b0
  ip_local_deliver_finish+0x66/0x200
PGD 0 P4D 0
  __netif_receive_skb_core+0x35e/0xb40
  ? nf_hook_slow+0x3f/0xb0
  netif_receive_skb_internal+0x4b/0x130
Oops: 0000 [#1] PREEMPT SMP PTI
  br_handle_frame_finish+0x148/0x510 [bridge]
  ? try_to_wake_up+0x54/0x4a0
  ? br_handle_frame_finish+0x510/0x510 [bridge]
  br_handle_frame+0x146/0x330 [bridge]
  __netif_receive_skb_core+0x3e9/0xb40
  ? __skb_get_hash_symmetric+0x74/0xc0
  netif_receive_skb_internal+0x4b/0x130
  tun_get_user+0x956/0xf00 [tun]
  ? __switch_to_asm+0x35/0x70
  ? __switch_to_asm+0x41/0x70
  ? __switch_to_asm+0x35/0x70
  ? __switch_to_asm+0x41/0x70
  tun_sendmsg+0x60/0x90 [tun]
  handle_tx+0x360/0x5f0 [vhost_net]
  vhost_worker+0xa7/0x100 [vhost]
  kthread+0x102/0x140
  ? vhost_dev_reset_owner+0x50/0x50 [vhost]
  ? kthread_create_on_node+0x60/0x60
  ret_from_fork+0x35/0x40
Code: 00 00 48 03 93 d0 00 00 00 4c 8b 6b 18 48 89 6b 18 49 89 c6 49 29 
d6 44 01 b3 80 00 00 00 44 89 f5 48 29 e8 48 89 83 d8 00 00 00 <41> f6 
44 24 02 08 75 7c 49 8b 44 24 28 49 8d 74 24 30 48 89 df
Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun 
ebtable_filter ebtables devlink ip6table_filter ip6_tables 
iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid 
nls_iso8859_1 nls_cp437 vfat fat input_leds joydev mousedev 
snd_hda_codec_hdmi eeepc_wmi iTCO_wdt asus_wmi mei_wdt sparse_keymap 
rfkill intel_rapl iTCO_vendor_support led_class wmi_bmof 
x86_pkg_temp_thermal intel_powerclamp coretemp evdev mac_hid kvm_intel 
i915 snd_hda_codec_realtek snd_hda_codec_generic kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc snd_hda_intel 
aesni_intel aes_x86_64 crypto_simd glue_helper cryptd i2c_algo_bit 
snd_hda_codec intel_cstate drm_kms_helper pcspkr snd_hda_core 
intel_rapl_perf snd_hwdep e1000e snd_pcm r8169 i2c_i801 intel_gtt mii 
syscopyarea snd_timer sysfillrect
  sysimgblt snd ptp lpc_ich mei_me fb_sys_fops soundcore shpchp pps_core 
mei wmi thermal fan pcc_cpufreq video button sch_fq_codel nfsd 
auth_rpcgss oid_registry drm nfs_acl lockd grace agpgart sunrpc 
ip_tables x_tables ext4 crc16 mbcache jbd2 fscrypto dm_thin_pool 
dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio 
hid_generic hid_logitech_hidpp dm_mod hid_logitech_dj usbhid hid sr_mod 
sd_mod cdrom ahci libahci ehci_pci xhci_pci ehci_hcd libata xhci_hcd 
crc32c_intel scsi_mod usbcore usb_common
RIP: __cgroup_bpf_run_filter_skb+0xca/0x1b0 RSP: ffff9c4e82b4f9a8
CR2: 0000200000000002
---[ end trace cb04f0196a7eba73 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x3a000000 from 0xffffffff81000000 (relocation range: 
0xffffffff80000000-0xffffffffbfffffff)
CPU: 0 PID: 1313 Comm: vhost-1306 Not tainted 4.14.183-1-MANJARO #1
---[ end Kernel panic - not syncing: Fatal exception in interrupt
Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
task: ffff90a042548000 task.stack: ffff9c4e82b4c000
RIP: 0010:__cgroup_bpf_run_filter_skb+0xca/0x1b0
RSP: 0018:ffff9c4e82b4f9a8 EFLAGS: 00010296
RAX: ffff909fa973804e RBX: ffff909efbb6d800 RCX: 0000000000000001
RDX: ffff909fa973804e RSI: ffff909efbb6d800 RDI: ffff90a06c0a2000
RBP: 0000000000000014 R08: 0000000000000001 R09: ffff90a06c0a2000
R10: 000000000000af02 R11: 000000000300a8c0 R12: 0000200000000000
R13: 0000000000000000 R14: 0000000000000014 R15: ffff909fa973804e
FS:  0000000000000000(0000) GS:ffff90a09fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000002 CR3: 00000003c2438001 CR4: 00000000001626f0
Call Trace:
  sk_filter_trim_cap+0xd1/0x1a0
  tcp_v4_rcv+0x921/0xbc0
  ? ip_local_deliver+0xbf/0x120
  ip_local_deliver_finish+0x66/0x200
  __netif_receive_skb_core+0x35e/0xb40
  ? nf_hook_slow+0x3f/0xb0
  netif_receive_skb_internal+0x4b/0x130
  br_handle_frame_finish+0x148/0x510 [bridge]
  ? try_to_wake_up+0x54/0x4a0
  ? br_handle_frame_finish+0x510/0x510 [bridge]
  br_handle_frame+0x146/0x330 [bridge]
  __netif_receive_skb_core+0x3e9/0xb40
  ? __skb_get_hash_symmetric+0x74/0xc0
  netif_receive_skb_internal+0x4b/0x130
  tun_get_user+0x956/0xf00 [tun]
  ? __switch_to_asm+0x35/0x70
  ? __switch_to_asm+0x41/0x70
  ? __switch_to_asm+0x35/0x70
  ? __switch_to_asm+0x41/0x70
  tun_sendmsg+0x60/0x90 [tun]
  handle_tx+0x360/0x5f0 [vhost_net]
  vhost_worker+0xa7/0x100 [vhost]
  kthread+0x102/0x140
  ? vhost_dev_reset_owner+0x50/0x50 [vhost]
  ? kthread_create_on_node+0x60/0x60
  ret_from_fork+0x35/0x40
Code: 00 00 48 03 93 d0 00 00 00 4c 8b 6b 18 48 89 6b 18 49 89 c6 49 29 
d6 44 01 b3 80 00 00 00 44 89 f5 48 29 e8 48 89 83 d8 00 00 00 <41> f6 
44 24 02 08 75 7c 49 8b 44 24 28 49 8d 74 24 30 48 89 df
RIP: __cgroup_bpf_run_filter_skb+0xca/0x1b0 RSP: ffff9c4e82b4f9a8
CR2: 0000200000000002
---[ end trace cb04f0196a7eba73 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x3a000000 from 0xffffffff81000000 (relocation range: 
0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt


