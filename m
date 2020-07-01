Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC7D21045C
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgGAG6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAG6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 02:58:21 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA66C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 23:58:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so12952321edv.6
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TQe5B1BYKCyKlCWmLDF2Hn2//wT3w3fk/1EJlVnf8JY=;
        b=MfT1VYI/vBeDHXgdoqNXo0MkRBqim/A/Nze94IuOHruUlnp7BeTOxRHDsbmTZN4F0q
         wFss9MZ0X3E+yqw9eFWnS7Q3t2iFa8Oa+NsXgEh8VTgiXTaytthJhywU2TBEeE40BEtn
         E0n/NBJXOw35C1v+afJYENOdfit5IYr3qKDmm/3U+qSM1Bg1bwaq5Hbhpwgx7OEbw1zB
         9r+wPtfAuRi/ap00geQdN4q7gapTiQ9cfHNtzSU+AYOWoaF7sv9O0qe59sqM5Hkb0B+x
         6lOoGadc0uUQNKN9tSWTUFgvEccyu5RwFvHYLxwFT1Ci6ddkNNM1NA9F60cNUfTV5KAb
         Kx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TQe5B1BYKCyKlCWmLDF2Hn2//wT3w3fk/1EJlVnf8JY=;
        b=fMiUBNHG4i8O1yHtVmnOqi7+CyjezfVDb7fngyr1gtnomFLKvuvF3RKmMb6nqmGrXe
         s3zxis/Dc7TBFqMhk1gJup/DOPEsHFFF5bWsrmc1cxlJRKDdOocju+EA+oxn//FbQABw
         Rkt6qpX2sajfRmN9ypeoxe8rNqlwSZCRRFVSTwYoNOafUlztONw7MmqAcl1vjQTzPZb0
         py14/F2cKRdK1IADrCRyhq+F5dQENCakzrj14r1bJ4AplK57IVYemitWeVzrNJniQCNV
         THHbcG4OvV7efbBPGkMW7ec/ny7GKhAj2dvk/nEHS7wonWIDx9uC6AXtvT5Ef3U/lrC5
         PKag==
X-Gm-Message-State: AOAM531orrnV/NUoublKoZOB+iAf1fg5qU/MOmT9tPAeRGPlhFYdf4jf
        NiL8SmysT6NQD0kxJ1tLwrCNmgv+1w==
X-Google-Smtp-Source: ABdhPJxnmlj/5t54p+4q51e/RQUlSAulAut7fTg3xrIIevFh5yvOuwGqXahk3uqaGMVYIcKU8CbRsg==
X-Received: by 2002:aa7:d50d:: with SMTP id y13mr27158449edq.230.1593586698779;
        Tue, 30 Jun 2020 23:58:18 -0700 (PDT)
Received: from [192.168.254.199] (x4d0c3c5b.dyn.telefonica.de. [77.12.60.91])
        by smtp.gmail.com with ESMTPSA id be2sm5265401edb.92.2020.06.30.23.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:58:18 -0700 (PDT)
Subject: Re: BUG: kernel NULL pointer dereference in
 __cgroup_bpf_run_filter_skb
From:   Thomas Reim <reimth@gmail.com>
To:     bpf@vger.kernel.org
References: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
Cc:     reimth@gmail.com
Message-ID: <6ab93d3e-aa8e-e31e-382a-43cadb04d6a7@gmail.com>
Date:   Wed, 1 Jul 2020 08:58:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> We have experienced a kernel BPF null pointer dereference issue on all
> our machines since mid of June. It might be related to an upgrade of
> libvirt/kvm/qemu at that point of time. But we’re not sure.
>
> [...]
>
> We experienced the kernel freeze on following Arch Linux kernels:
> - 5.7.0 (5.7.0-3-MANJARO x64)
> - 5.6.16 (5.6.16-1-MANJARO x64)
> - 5.4.44 (5.4.44-1-MANJARO x64)
> - 4.19.126 (4.19.126-1-MANJARO x64)
> - 4.14.183 (4.14.183-1-MANJARO x64)
> Kernel configs can be taken from https://gitlab.manjaro.org/packages/core.
>
> Subsequent e-mails will contain the relevant extracts from journal or
> netconsole logs.
>
> Help and support on this issue is welcome.

Kernel 4.19.126 (4.19.126-1-MANJARO x64)

We logged two different kind of kernel freezes:
- Gneral protection fault (1) (2)
- Unable to handle kernel paging request (3)

1. Kernel freeze preceeded by failing ethernet interface
[10979.771448] e1000e 0000:00:19.0 ethlocal: Detected Hardware Unit Hang:#012[10979.771448]   TDH                  <b>#012[10979.771448]   TDT                  <14>#012[10979.771448]   next_to_use          <14>#012[10979.771448]   next_to_clean        <a>#012[10979.771448] buffer_info[next_to_clean]:#012[10979.771448]   time_stamp           <100104b1a>#012[10979.771448]   next_to_watch        <b>#012[10979.771448]   jiffies              <100104b80>#012[10979.771448]   next_to_watch.status <0>#012[10979.771448] MAC Status             <80083>#012[10979.771448] PHY Status             <796d>#012[10979.771448] PHY 1000BASE-T Status  <3c00>#012[10979.771448] PHY Extended Status    <3000>#012[10979.771448] PCI Status             <10>
[10979.771448] e1000e 0000:00:19.0 ethlocal: Detected Hardware Unit Hang:#012[10979.771448]   TDH                  <b>#012[10979.771448]   TDT                  <14>#012[10979.771448]   next_to_use          <14>#012[10979.771448]   next_to_clean        <a>#012[10979.771448] buffer_info[next_to_clean]:#012[10979.771448]   time_stamp           <100104b1a>#012[10979.771448]   next_to_watch        <b>#012[10979.771448]   jiffies              <100104b80>#012[10979.771448]   next_to_watch.status <0>#012[10979.771448] MAC Status             <80083>#012[10979.771448] PHY Status             <796d>#012[10979.771448] PHY 1000BASE-T Status  <3c00>#012[10979.771448] PHY Extended Status    <3000>#012[10979.771448] PCI Status             <10>
[10981.771576] e1000e 0000:00:19.0 ethlocal: Detected Hardware Unit Hang:#012[10981.771576]   TDH                  <b>#012[10981.771576]   TDT                  <14>#012[10981.771576]   next_to_use          <14>#012[10981.771576]   next_to_clean        <a>#012[10981.771576] buffer_info[next_to_clean]:#012[10981.771576]   time_stamp           <100104b1a>#012[10981.771576]   next_to_watch        <b>#012[10981.771576]   jiffies              <100104c48>#012[10981.771576]   next_to_watch.status <0>#012[10981.771576] MAC Status             <80083>#012[10981.771576] PHY Status             <796d>#012[10981.771576] PHY 1000BASE-T Status  <3c00>#012[10981.771576] PHY Extended Status    <3000>#012[10981.771576] PCI Status             <10>
[10981.771576] e1000e 0000:00:19.0 ethlocal: Detected Hardware Unit Hang:#012[10981.771576]   TDH                  <b>#012[10981.771576]   TDT                  <14>#012[10981.771576]   next_to_use          <14>#012[10981.771576]   next_to_clean        <a>#012[10981.771576] buffer_info[next_to_clean]:#012[10981.771576]   time_stamp           <100104b1a>#012[10981.771576]   next_to_watch        <b>#012[10981.771576]   jiffies              <100104c48>#012[10981.771576]   next_to_watch.status <0>#012[10981.771576] MAC Status             <80083>#012[10981.771576] PHY Status             <796d>#012[10981.771576] PHY 1000BASE-T Status  <3c00>#012[10981.771576] PHY Extended Status    <3000>#012[10981.771576] PCI Status             <10>
[10983.771682] e1000e 0000:00:19.0 ethlocal: Detected Hardware Unit Hang:#012[10983.771682]   TDH                  <b>#012[10983.771682]   TDT                  <14>#012[10983.771682]   next_to_use          <14>#012[10983.771682]   next_to_clean        <a>#012[10983.771682] buffer_info[next_to_clean]:#012[10983.771682]   time_stamp           <100104b1a>#012[10983.771682]   next_to_watch        <b>#012[10983.771682]   jiffies              <100104d10>#012[10983.771682]   next_to_watch.status <0>#012[10983.771682] MAC Status             <80083>#012[10983.771682] PHY Status             <796d>#012[10983.771682] PHY 1000BASE-T Status  <3c00>#012[10983.771682] PHY Extended Status    <3000>#012[10983.771682] PCI Status             <10>
[10983.771682] e1000e 0000:00:19.0 ethlocal: Detected Hardware Unit Hang:#012[10983.771682]   TDH                  <b>#012[10983.771682]   TDT                  <14>#012[10983.771682]   next_to_use          <14>#012[10983.771682]   next_to_clean        <a>#012[10983.771682] buffer_info[next_to_clean]:#012[10983.771682]   time_stamp           <100104b1a>#012[10983.771682]   next_to_watch        <b>#012[10983.771682]   jiffies              <100104d10>#012[10983.771682]   next_to_watch.status <0>#012[10983.771682] MAC Status             <80083>#012[10983.771682] PHY Status             <796d>#012[10983.771682] PHY 1000BASE-T Status  <3c00>#012[10983.771682] PHY Extended Status    <3000>#012[10983.771682] PCI Status             <10>
[10985.771787] e1000e 0000:00:19.0 ethlocal: Detected Hardware Unit Hang:#012[10985.771787]   TDH                  <b>#012[10985.771787]   TDT                  <14>#012[10985.771787]   next_to_use          <14>#012[10985.771787]   next_to_clean        <a>#012[10985.771787] buffer_info[next_to_clean]:#012[10985.771787]   time_stamp           <100104b1a>#012[10985.771787]   next_to_watch        <b>#012[10985.771787]   jiffies              <100104dd8>#012[10985.771787]   next_to_watch.status <0>#012[10985.771787] MAC Status             <80083>#012[10985.771787] PHY Status             <796d>#012[10985.771787] PHY 1000BASE-T Status  <3c00>#012[10985.771787] PHY Extended Status    <3000>#012[10985.771787] PCI Status             <10>
[10985.771787] e1000e 0000:00:19.0 ethlocal: Detected Hardware Unit Hang:#012[10985.771787]   TDH                  <b>#012[10985.771787]   TDT                  <14>#012[10985.771787]   next_to_use          <14>#012[10985.771787]   next_to_clean        <a>#012[10985.771787] buffer_info[next_to_clean]:#012[10985.771787]   time_stamp           <100104b1a>#012[10985.771787]   next_to_watch        <b>#012[10985.771787]   jiffies              <100104dd8>#012[10985.771787]   next_to_watch.status <0>#012[10985.771787] MAC Status             <80083>#012[10985.771787] PHY Status             <796d>#012[10985.771787] PHY 1000BASE-T Status  <3c00>#012[10985.771787] PHY Extended Status    <3000>#012[10985.771787] PCI Status             <10>
[10986.731462] ------------[ cut here ]------------
[10986.731509] NETDEV WATCHDOG: ethlocal (e1000e): transmit queue 0 timed out
[10986.731559] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:465 dev_watchdog+0x212/0x220
[10986.731574] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat joydev mousedev input_leds intel_rapl snd_hda_codec_hdmi ofpart mei_wdt cmdlinepart intel_spi_platform intel_spi spi_nor mtd x86_pkg_temp_thermal iTCO_wdt intel_powerclamp iTCO_vendor_support eeepc_wmi asus_wmi coretemp sparse_keymap rfkill wmi_bmof kvm_intel crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc i915 aesni_intel aes_x86_64 kvmgt crypto_simd cryptd vfio_mdev mdev glue_helper vfio_iommu_type1 vfio kvm intel_cstate intel_uncore snd_hda_codec_realtek irqbypass intel_rapl_perf snd_hda_codec_generic i2c_algo_bit drm_kms_helper pcspkr i2c_i801 snd_hda_intel drm snd_hda_codec
[10986.731462] ------------[ cut here ]------------
[10986.731647]  snd_hda_core snd_hwdep intel_gtt snd_pcm agpgart mei_me r8169 syscopyarea sysfillrect snd_timer sysimgblt pcc_cpufreq realtek snd lpc_ich libphy e1000e wmi soundcore mei fb_sys_fops evdev mac_hid nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci libata crc32c_intel scsi_mod xhci_pci xhci_hcd ehci_pci ehci_hcd
[10986.731712] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.126-1-MANJARO #1
[10986.731725] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[10986.731745] RIP: 0010:dev_watchdog+0x212/0x220
[10986.731763] Code: 63 74 24 e0 eb 8c 4c 89 f7 c6 05 e6 fd b8 00 01 e8 d3 b1 fc ff 44 89 e9 4c 89 f6 48 c7 c7 c8 ca d1 a9 48 89 c2 e8 5d 83 90 ff <0f> 0b eb bd 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 c7 47
[10986.731783] RSP: 0018:ffff8d258fd03e70 EFLAGS: 00010282
[10986.731802] RAX: 0000000000000000 RBX: ffff8d258bd00c00 RCX: 000000000000083f
[10986.731509] NETDEV WATCHDOG: ethlocal (e1000e): transmit queue 0 timed out
[10986.731820] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000000083f
[10986.731837] RBP: ffff8d258a06045c R08: ffff8d258fd165b8 R09: 0000000000000000
[10986.731857] R10: ffffffffa8d04510 R11: 0000000000000000 R12: ffff8d258a060480
[10986.731875] R13: 0000000000000000 R14: ffff8d258a060000 R15: ffff8d258bd00c80
[10986.731895] FS:  0000000000000000(0000) GS:ffff8d258fd00000(0000) knlGS:0000000000000000
[10986.731913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10986.731931] CR2: 00007fcf213ea770 CR3: 00000001e640a006 CR4: 00000000001626e0
[10986.731948] Call Trace:
[10986.731968]  <IRQ>
[10986.731990]  ? qdisc_reset+0xd0/0xd0
[10986.732012]  call_timer_fn+0x2b/0x130
[10986.732036]  expire_timers+0x9c/0x100
[10986.732058]  run_timer_softirq+0x8f/0x180
[10986.731559] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:465 dev_watchdog+0x212/0x220
[10986.732158]  ? __hrtimer_run_queues+0x138/0x2a0
[10986.732175]  ? sched_clock+0x5/0x10
[10986.732198]  ? sched_clock_cpu+0xc/0xb0
[10986.732218]  __do_softirq+0xee/0x2e1
[10986.732238]  irq_exit+0xa4/0xe0
[10986.732256]  smp_apic_timer_interrupt+0x78/0x140
[10986.731574] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat joydev mousedev input_leds intel_rapl snd_hda_codec_hdmi ofpart mei_wdt cmdlinepart intel_spi_platform intel_spi spi_nor mtd x86_pkg_temp_thermal iTCO_wdt intel_powerclamp iTCO_vendor_support eeepc_wmi asus_wmi coretemp sparse_keymap rfkill wmi_bmof kvm_intel crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc i915 aesni_intel aes_x86_64 kvmgt crypto_simd cryptd vfio_mdev mdev glue_helper vfio_iommu_type1 vfio kvm intel_cstate intel_uncore snd_hda_codec_realtek irqbypass intel_rapl_perf snd_hda_codec_generic i2c_algo_bit drm_kms_helper pcspkr i2c_i801 snd_hda_intel drm snd_hda_codec
[10986.732274]  apic_timer_interrupt+0xf/0x20
[10986.732289]  </IRQ>
[10986.732312] RIP: 0010:cpuidle_enter_state+0xfc/0x2c0
[10986.732328] Code: e8 e9 9f 9c ff 80 7c 24 03 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 9a 01 00 00 31 ff e8 7b ac a2 ff fb 66 0f 1f 44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 f5 ba ff ff ff 7f 48 39 c5 7f
[10986.732344] RSP: 0018:ffffae8f81933e98 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[10986.732362] RAX: ffff8d258fd21cc0 RBX: ffff8d258fd2bf00 RCX: 000000000000001f
[10986.731647]  snd_hda_core snd_hwdep intel_gtt snd_pcm agpgart mei_me r8169 syscopyarea sysfillrect snd_timer sysimgblt pcc_cpufreq realtek snd lpc_ich libphy e1000e wmi soundcore mei fb_sys_fops evdev mac_hid nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci libata crc32c_intel scsi_mod xhci_pci xhci_hcd ehci_pci ehci_hcd
[10986.732378] RDX: 0000000000000000 RSI: 000000002c235370 RDI: 0000000000000000
[10986.732394] RBP: 000009fe0c399f97 R08: 000009fe0c399f97 R09: 00000000ffffffff
[10986.732409] R10: 0000000000002645 R11: ffff8d258fd20c48 R12: 0000000000000005
[10986.732429] R13: ffffffffa9eb88d8 R14: 000009fe0aeeae21 R15: 0000000000000000
[10986.732453]  ? cpuidle_enter_state+0xd7/0x2c0
[10986.731712] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.126-1-MANJARO #1
[10986.732473]  do_idle+0x1bf/0x240
[10986.732494]  cpu_startup_entry+0x6f/0x80
[10986.732513]  start_secondary+0x1a2/0x200
[10986.732533]  secondary_startup_64+0xa4/0xb0
[10986.732551] ---[ end trace 50a63959e2687b98 ]---
[10986.731725] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[10986.731745] RIP: 0010:dev_watchdog+0x212/0x220
[10986.731763] Code: 63 74 24 e0 eb 8c 4c 89 f7 c6 05 e6 fd b8 00 01 e8 d3 b1 fc ff 44 89 e9 4c 89 f6 48 c7 c7 c8 ca d1 a9 48 89 c2 e8 5d 83 90 ff <0f> 0b eb bd 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 c7 47
[10986.731783] RSP: 0018:ffff8d258fd03e70 EFLAGS: 00010282
[10986.731802] RAX: 0000000000000000 RBX: ffff8d258bd00c00 RCX: 000000000000083f
[10986.731820] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000000083f
[10986.733084] systemd-journald[348]: Compressed data object 815 -> 682 using LZ4
[10986.731837] RBP: ffff8d258a06045c R08: ffff8d258fd165b8 R09: 0000000000000000
[10986.731857] R10: ffffffffa8d04510 R11: 0000000000000000 R12: ffff8d258a060480
[10986.731875] R13: 0000000000000000 R14: ffff8d258a060000 R15: ffff8d258bd00c80
[10986.733258] systemd-journald[348]: Compressed data object 534 -> 477 using LZ4
[10986.731895] FS:  0000000000000000(0000) GS:ffff8d258fd00000(0000) knlGS:0000000000000000
[10986.731913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10986.731931] CR2: 00007fcf213ea770 CR3: 00000001e640a006 CR4: 00000000001626e0
[10986.731948] Call Trace:
[10986.731968]  <IRQ>
[10986.731990]  ? qdisc_reset+0xd0/0xd0
[10986.732012]  call_timer_fn+0x2b/0x130
[10986.732036]  expire_timers+0x9c/0x100
[10986.732058]  run_timer_softirq+0x8f/0x180
[10986.732158]  ? __hrtimer_run_queues+0x138/0x2a0
[10986.732175]  ? sched_clock+0x5/0x10
[10986.732198]  ? sched_clock_cpu+0xc/0xb0
[10986.732218]  __do_softirq+0xee/0x2e1
[10986.732238]  irq_exit+0xa4/0xe0
[10986.732256]  smp_apic_timer_interrupt+0x78/0x140
[10986.732274]  apic_timer_interrupt+0xf/0x20
[10986.732289]  </IRQ>
[10986.732312] RIP: 0010:cpuidle_enter_state+0xfc/0x2c0
[10986.732328] Code: e8 e9 9f 9c ff 80 7c 24 03 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 9a 01 00 00 31 ff e8 7b ac a2 ff fb 66 0f 1f 44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 f5 ba ff ff ff 7f 48 39 c5 7f
[10986.732344] RSP: 0018:ffffae8f81933e98 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[10986.736147] systemd-journald[348]: Sent WATCHDOG=1 notification.
[10986.732362] RAX: ffff8d258fd21cc0 RBX: ffff8d258fd2bf00 RCX: 000000000000001f
[10986.736204] e1000e 0000:00:19.0 ethlocal: Reset adapter unexpectedly
[10986.732378] RDX: 0000000000000000 RSI: 000000002c235370 RDI: 0000000000000000
[10986.732394] RBP: 000009fe0c399f97 R08: 000009fe0c399f97 R09: 00000000ffffffff
[10986.732409] R10: 0000000000002645 R11: ffff8d258fd20c48 R12: 0000000000000005
[10986.732429] R13: ffffffffa9eb88d8 R14: 000009fe0aeeae21 R15: 0000000000000000
[10986.736616] br0: port 1(ethlocal) entered disabled state
[10986.732453]  ? cpuidle_enter_state+0xd7/0x2c0
[10986.732473]  do_idle+0x1bf/0x240
[10986.732494]  cpu_startup_entry+0x6f/0x80
[10986.732513]  start_secondary+0x1a2/0x200
[10986.732533]  secondary_startup_64+0xa4/0xb0
[10986.732551] ---[ end trace 50a63959e2687b98 ]---
[10986.733084] systemd-journald[348]: Compressed data object 815 -> 682 using LZ4
[10986.733258] systemd-journald[348]: Compressed data object 534 -> 477 using LZ4
[10986.736147] systemd-journald[348]: Sent WATCHDOG=1 notification.
[10986.736204] e1000e 0000:00:19.0 ethlocal: Reset adapter unexpectedly
[10986.736616] br0: port 1(ethlocal) entered disabled state
[10990.503856] e1000e: ethlocal NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[10990.503914] br0: port 1(ethlocal) entered blocking state
[10990.503920] br0: port 1(ethlocal) entered forwarding state
[10990.503856] e1000e: ethlocal NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[10990.503914] br0: port 1(ethlocal) entered blocking state
[10990.503920] br0: port 1(ethlocal) entered forwarding state

[11011.263415] general protection fault: 0000 [#1] SMP PTI
[11011.263458] CPU: 0 PID: 1183 Comm: vhost-1178 Tainted: G        W         4.19.126-1-MANJARO #1
[11011.263468] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[11011.263492] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[11011.263502] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[11011.263512] RSP: 0018:ffffae8f837b3840 EFLAGS: 00010296
[11011.263522] RAX: 46e6c3fabfad8c89 RBX: ffff8d2589a47700 RCX: 0000000000000014
[11011.263531] RDX: 0000000000000000 RSI: ffff8d25725c8800 RDI: 0000000000000000
[11011.263571] RBP: ffff8d23f9639000 R08: ffff8d2589a47700 R09: 0000000000000001
[11011.263596] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000014
[11011.263610] R13: 0000000000000020 R14: ffffffffa9ef1d80 R15: ffff8d23f9639000
[11011.263627] FS:  0000000000000000(0000) GS:ffff8d258fc00000(0000) knlGS:0000000000000000
[11011.263642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11011.263654] CR2: 00007f6b95687fd8 CR3: 00000003df862004 CR4: 00000000001626f0
[11011.263666] Call Trace:
[11011.263694]  ? rt_cache_route+0xbe/0xd0
[11011.263415] general protection fault: 0000 [#1] SMP PTI
[11011.263720]  ? ipt_do_table+0x379/0x640 [ip_tables]
[11011.263747]  sk_filter_trim_cap+0xfe/0x1b0
[11011.263771]  tcp_v4_rcv+0xaf7/0xdf0
[11011.263791]  ip_local_deliver_finish+0x9c/0x1e0
[11011.263813]  ip_local_deliver+0x78/0x120
[11011.263458] CPU: 0 PID: 1183 Comm: vhost-1178 Tainted: G        W         4.19.126-1-MANJARO #1
[11011.263830]  ? ip_sublist_rcv_finish+0x60/0x60
[11011.263850]  ip_rcv+0x76/0x100
[11011.263873]  __netif_receive_skb_one_core+0x5b/0x80
[11011.263895]  netif_receive_skb_internal+0x4a/0xc0
[11011.263936]  br_pass_frame_up+0x108/0x1b0 [bridge]
[11011.263468] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[11011.263973]  ? br_port_flags_change+0x70/0x70 [bridge]
[11011.264007]  br_handle_frame_finish+0x181/0x450 [bridge]
[11011.264041]  br_handle_frame+0x175/0x360 [bridge]
[11011.263492] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[11011.264074]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[11011.264095]  __netif_receive_skb_core+0x4be/0xc60
[11011.264123]  ? tun_build_skb+0x2b1/0x520 [tun]
[11011.264148]  __netif_receive_skb_one_core+0x3d/0x80
[11011.263502] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[11011.264168]  netif_receive_skb_internal+0x4a/0xc0
[11011.264193]  tun_get_user+0x1021/0x12b0 [tun]
[11011.264221]  tun_sendmsg+0x55/0x70 [tun]
[11011.263512] RSP: 0018:ffffae8f837b3840 EFLAGS: 00010296
[11011.264247]  handle_tx_copy+0x142/0x280 [vhost_net]
[11011.264267]  handle_tx+0xa5/0xe0 [vhost_net]
[11011.264291]  vhost_worker+0xaa/0x100 [vhost]
[11011.264318]  kthread+0xfb/0x130
[11011.263522] RAX: 46e6c3fabfad8c89 RBX: ffff8d2589a47700 RCX: 0000000000000014
[11011.264342]  ? vhost_flush_work+0x10/0x10 [vhost]
[11011.264361]  ? kthread_park+0x80/0x80
[11011.264381]  ret_from_fork+0x35/0x40
[11011.263531] RDX: 0000000000000000 RSI: ffff8d25725c8800 RDI: 0000000000000000
[11011.264401] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat joydev mousedev input_leds intel_rapl snd_hda_codec_hdmi ofpart mei_wdt cmdlinepart intel_spi_platform intel_spi spi_nor mtd x86_pkg_temp_thermal iTCO_wdt intel_powerclamp iTCO_vendor_support eeepc_wmi asus_wmi coretemp sparse_keymap rfkill wmi_bmof kvm_intel crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc i915 aesni_intel aes_x86_64 kvmgt crypto_simd cryptd vfio_mdev mdev glue_helper vfio_iommu_type1 vfio kvm intel_cstate intel_uncore snd_hda_codec_realtek irqbypass intel_rapl_perf snd_hda_codec_generic i2c_algo_bit drm_kms_helper pcspkr i2c_i801 snd_hda_intel drm snd_hda_codec
[11011.264502]  snd_hda_core snd_hwdep intel_gtt snd_pcm agpgart mei_me r8169 syscopyarea sysfillrect snd_timer sysimgblt pcc_cpufreq realtek snd lpc_ich libphy e1000e wmi soundcore mei fb_sys_fops evdev mac_hid nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci libata crc32c_intel scsi_mod xhci_pci xhci_hcd ehci_pci ehci_hcd
[11011.264593] ---[ end trace 50a63959e2687b99 ]---
[11011.264617] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[11011.264639] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[11011.264658] RSP: 0018:ffffae8f837b3840 EFLAGS: 00010296
[11011.264677] RAX: 46e6c3fabfad8c89 RBX: ffff8d2589a47700 RCX: 0000000000000014
[11011.264697] RDX: 0000000000000000 RSI: ffff8d25725c8800 RDI: 0000000000000000
[11011.264715] RBP: ffff8d23f9639000 R08: ffff8d2589a47700 R09: 0000000000000001
[11011.264734] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000014
[11011.264751] R13: 0000000000000020 R14: ffffffffa9ef1d80 R15: ffff8d23f9639000
[11011.264770] FS:  0000000000000000(0000) GS:ffff8d258fc00000(0000) knlGS:0000000000000000
[11011.264788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11011.264807] CR2: 00007f6b95687fd8 CR3: 00000003df862004 CR4: 00000000001626f0
[11011.264831] Kernel panic - not syncing: Fatal exception in interrupt
[11011.264866] Kernel Offset: 0x27c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[11011.264879] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
[11011.263571] RBP: ffff8d23f9639000 R08: ffff8d2589a47700 R09: 0000000000000001
[11011.263596] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000014
[11011.263610] R13: 0000000000000020 R14: ffffffffa9ef1d80 R15: ffff8d23f9639000
[11011.263627] FS:  0000000000000000(0000) GS:ffff8d258fc00000(0000) knlGS:0000000000000000
[11011.263642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11011.263654] CR2: 00007f6b95687fd8 CR3: 00000003df862004 CR4: 00000000001626f0
[11011.263666] Call Trace:
[11011.263694]  ? rt_cache_route+0xbe/0xd0
[11011.263720]  ? ipt_do_table+0x379/0x640 [ip_tables]
[11011.263747]  sk_filter_trim_cap+0xfe/0x1b0
[11011.263771]  tcp_v4_rcv+0xaf7/0xdf0
[11011.263791]  ip_local_deliver_finish+0x9c/0x1e0
[11011.263813]  ip_local_deliver+0x78/0x120
[11011.263830]  ? ip_sublist_rcv_finish+0x60/0x60
[11011.263850]  ip_rcv+0x76/0x100
[11011.263873]  __netif_receive_skb_one_core+0x5b/0x80
[11011.263895]  netif_receive_skb_internal+0x4a/0xc0
[11011.263936]  br_pass_frame_up+0x108/0x1b0 [bridge]
[11011.263973]  ? br_port_flags_change+0x70/0x70 [bridge]
[11011.264007]  br_handle_frame_finish+0x181/0x450 [bridge]
[11011.264041]  br_handle_frame+0x175/0x360 [bridge]
[11011.264074]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[11011.264095]  __netif_receive_skb_core+0x4be/0xc60
[11011.264123]  ? tun_build_skb+0x2b1/0x520 [tun]
[11011.264148]  __netif_receive_skb_one_core+0x3d/0x80
[11011.264168]  netif_receive_skb_internal+0x4a/0xc0
[11011.264193]  tun_get_user+0x1021/0x12b0 [tun]
[11011.264221]  tun_sendmsg+0x55/0x70 [tun]
[11011.264247]  handle_tx_copy+0x142/0x280 [vhost_net]
[11011.264267]  handle_tx+0xa5/0xe0 [vhost_net]
[11011.264291]  vhost_worker+0xaa/0x100 [vhost]
[11011.264318]  kthread+0xfb/0x130
[11011.264342]  ? vhost_flush_work+0x10/0x10 [vhost]
[11011.264361]  ? kthread_park+0x80/0x80
[11011.264381]  ret_from_fork+0x35/0x40
[11011.264401] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat joydev mousedev input_leds intel_rapl snd_hda_codec_hdmi ofpart mei_wdt cmdlinepart intel_spi_platform intel_spi spi_nor mtd x86_pkg_temp_thermal iTCO_wdt intel_powerclamp iTCO_vendor_support eeepc_wmi asus_wmi coretemp sparse_keymap rfkill wmi_bmof kvm_intel crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc i915 aesni_intel aes_x86_64 kvmgt crypto_simd cryptd vfio_mdev mdev glue_helper vfio_iommu_type1 vfio kvm intel_cstate intel_uncore snd_hda_codec_realtek irqbypass intel_rapl_perf snd_hda_codec_generic i2c_algo_bit drm_kms_helper pcspkr i2c_i801 snd_hda_intel drm snd_hda_codec
[11011.264502]  snd_hda_core snd_hwdep intel_gtt snd_pcm agpgart mei_me r8169 syscopyarea sysfillrect snd_timer sysimgblt pcc_cpufreq realtek snd lpc_ich libphy e1000e wmi soundcore mei fb_sys_fops evdev mac_hid nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci libata crc32c_intel scsi_mod xhci_pci xhci_hcd ehci_pci ehci_hcd
[11011.264593] ---[ end trace 50a63959e2687b99 ]---
[11011.264617] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[11011.264639] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[11011.264658] RSP: 0018:ffffae8f837b3840 EFLAGS: 00010296
[11011.264677] RAX: 46e6c3fabfad8c89 RBX: ffff8d2589a47700 RCX: 0000000000000014
[11011.264697] RDX: 0000000000000000 RSI: ffff8d25725c8800 RDI: 0000000000000000
[11011.264715] RBP: ffff8d23f9639000 R08: ffff8d2589a47700 R09: 0000000000000001
[11011.264734] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000014
[11011.264751] R13: 0000000000000020 R14: ffffffffa9ef1d80 R15: ffff8d23f9639000
[11011.264770] FS:  0000000000000000(0000) GS:ffff8d258fc00000(0000) knlGS:0000000000000000
[11011.264788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11011.264807] CR2: 00007f6b95687fd8 CR3: 00000003df862004 CR4: 00000000001626f0
[11011.264831] Kernel panic - not syncing: Fatal exception in interrupt
[11011.264866] Kernel Offset: 0x27c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[11011.264879] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

2. Kernel freeze (general protection fault)
[10185.416945] general protection fault: 0000 [#1] SMP PTI
[10185.416972] CPU: 0 PID: 38176 Comm: vhost-38171 Not tainted 4.19.126-1-MANJARO #1
[10185.416977] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[10185.416988] RIP: 0010:__cgroup_bpf_run_filter_skb+0xe3/0x1e0
[10185.416994] Code: c8 03 00 00 48 8b 00 48 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd 01 00 00 00 49 8b 46 08 48 85 c0 74 0f <48> 8b 00 48 83 c0 10 65 48 89 05 86 1c 06 45 f6 43 02 10 0f 85 9c
[10185.417000] RSP: 0018:ffffab4103fe7680 EFLAGS: 00010286
[10185.417006] RAX: f083ff937272e800 RBX: 00000cbe407f8b48 RCX: 0000000000000014
[10185.417010] RDX: 0000000000000000 RSI: ffff9583755c3800 RDI: 0000000000000000
[10185.417014] RBP: 0000000000000001 R08: ffff958386cf8880 R09: 0000000000000000
[10185.417019] R10: ffff95838f803800 R11: 0000000000000801 R12: 0000000000000014
[10185.417024] R13: ffff95832ec93530 R14: ffffffffbb5598e0 R15: ffff95832ec93500
[10185.417028] FS:  0000000000000000(0000) GS:ffff95838fc00000(0000) knlGS:0000000000000000
[10185.417033] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10185.417037] CR2: 00007f6a6000d2c0 CR3: 0000000354366004 CR4: 00000000001626f0
[10185.417041] Call Trace:
[10185.417054]  sk_filter_trim_cap+0xfe/0x1b0
[10185.417062]  tcp_v4_rcv+0xaf7/0xdf0
[10185.417068]  ip_local_deliver_finish+0x9c/0x1e0
[10185.417074]  ip_local_deliver+0x78/0x120
[10185.417078]  ? ip_sublist_rcv_finish+0x60/0x60
[10185.417085]  ip_sabotage_in+0x42/0x50 [br_netfilter]
[10185.417091]  nf_hook_slow+0x3f/0xb0
[10185.417096]  ip_rcv+0xdd/0x100
[10185.417100]  ? ip_sublist_rcv+0x2a0/0x2a0
[10185.417176]  __netif_receive_skb_one_core+0x5b/0x80
[10185.417182]  netif_receive_skb_internal+0x4a/0xc0
[10185.417193]  br_pass_frame_up+0x108/0x1b0 [bridge]
[10185.417203]  ? br_port_flags_change+0x70/0x70 [bridge]
[10185.417211]  br_handle_frame_finish+0x181/0x450 [bridge]
[10185.417219]  ? br_pass_frame_up+0x1b0/0x1b0 [bridge]
[10185.417225]  br_nf_hook_thresh+0xdf/0xf0 [br_netfilter]
[10185.417232]  ? br_pass_frame_up+0x1b0/0x1b0 [bridge]
[10185.417237]  br_nf_pre_routing_finish+0x148/0x380 [br_netfilter]
[10185.417245]  ? br_pass_frame_up+0x1b0/0x1b0 [bridge]
[10185.417250]  br_nf_pre_routing+0x383/0x470 [br_netfilter]
[10185.417254]  ? br_nf_forward_ip+0x490/0x490 [br_netfilter]
[10185.417260]  nf_hook_slow+0x3f/0xb0
[10185.417268]  br_handle_frame+0x217/0x360 [bridge]
[10185.417275]  ? br_pass_frame_up+0x1b0/0x1b0 [bridge]
[10185.417282]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[10185.417286]  __netif_receive_skb_core+0x4be/0xc60
[10185.417293]  ? tun_build_skb+0x2b1/0x520 [tun]
[10185.417299]  __netif_receive_skb_one_core+0x3d/0x80
[10185.417303]  netif_receive_skb_internal+0x4a/0xc0
[10185.417308]  tun_get_user+0x1021/0x12b0 [tun]
[10185.417315]  tun_sendmsg+0x55/0x70 [tun]
[10185.417320]  handle_tx_copy+0x142/0x280 [vhost_net]
[10185.417326]  handle_tx+0xa5/0xe0 [vhost_net]
[10185.417387]  vhost_worker+0xaa/0x100 [vhost]
[10185.417395]  kthread+0xfb/0x130
[10185.417406]  ? vhost_flush_work+0x10/0x10 [vhost]
[10185.417411]  ? kthread_park+0x80/0x80
[10185.417416]  ret_from_fork+0x35/0x40
[10185.417420] Modules linked in: ipt_MASQUERADE xt_recent xt_comment ipt_REJECT nf_reject_ipv4 xt_addrtype br_netfilter xt_physdev iptable_nat nf_nat_ipv4 xt_mark iptable_mangle xt_TCPMSS xt_hashlimit xt_tcpudp xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_proto_gre nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp nf_conntrack_proto_gre nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter
[10185.416945] general protection fault: 0000 [#1] SMP PTI
[10185.417447]  ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat mousedev input_leds joydev snd_hda_codec_hdmi ofpart cmdlinepart intel_spi_platform intel_spi spi_nor intel_rapl iTCO_wdt mtd iTCO_vendor_support mei_wdt wmi_bmof eeepc_wmi asus_wmi sparse_keymap rfkill i915 x86_pkg_temp_thermal intel_powerclamp coretemp kvmgt kvm_intel vfio_mdev mdev vfio_iommu_type1 crct10dif_pclmul vfio crc32_pclmul ghash_clmulni_intel pcbc kvm aesni_intel aes_x86_64 crypto_simd cryptd glue_helper intel_cstate irqbypass snd_hda_codec_realtek i2c_algo_bit intel_uncore drm_kms_helper intel_rapl_perf snd_hda_codec_generic pcspkr drm snd_hda_intel snd_hda_codec intel_gtt r8169 snd_hda_core agpgart syscopyarea snd_hwdep snd_pcm lpc_ich realtek
[10185.417480]  sysfillrect sysimgblt snd_timer snd i2c_i801 mei_me libphy e1000e pcc_cpufreq fb_sys_fops mei soundcore wmi evdev mac_hid nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci libata crc32c_intel scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd
[10185.417517] ---[ end trace 7f69e8167d4880de ]---
[10185.417526] RIP: 0010:__cgroup_bpf_run_filter_skb+0xe3/0x1e0
[10185.417532] Code: c8 03 00 00 48 8b 00 48 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd 01 00 00 00 49 8b 46 08 48 85 c0 74 0f <48> 8b 00 48 83 c0 10 65 48 89 05 86 1c 06 45 f6 43 02 10 0f 85 9c
[10185.417537] RSP: 0018:ffffab4103fe7680 EFLAGS: 00010286
[10185.417541] RAX: f083ff937272e800 RBX: 00000cbe407f8b48 RCX: 0000000000000014
[10185.417544] RDX: 0000000000000000 RSI: ffff9583755c3800 RDI: 0000000000000000
[10185.417548] RBP: 0000000000000001 R08: ffff958386cf8880 R09: 0000000000000000
[10185.417551] R10: ffff95838f803800 R11: 0000000000000801 R12: 0000000000000014
[10185.417555] R13: ffff95832ec93530 R14: ffffffffbb5598e0 R15: ffff95832ec93500
[10185.417558] FS:  0000000000000000(0000) GS:ffff95838fc00000(0000) knlGS:0000000000000000
[10185.417562] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10185.417565] CR2: 00007f6a6000d2c0 CR3: 0000000354366004 CR4: 00000000001626f0
[10185.417569] Kernel panic - not syncing: Fatal exception in interrupt
[10185.417580] Kernel Offset: 0x39e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[10185.417585] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
[10185.416972] CPU: 0 PID: 38176 Comm: vhost-38171 Not tainted 4.19.126-1-MANJARO #1
[10185.416977] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[10185.416988] RIP: 0010:__cgroup_bpf_run_filter_skb+0xe3/0x1e0
[10185.416994] Code: c8 03 00 00 48 8b 00 48 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd 01 00 00 00 49 8b 46 08 48 85 c0 74 0f <48> 8b 00 48 83 c0 10 65 48 89 05 86 1c 06 45 f6 43 02 10 0f 85 9c
[10185.417000] RSP: 0018:ffffab4103fe7680 EFLAGS: 00010286
[10185.417006] RAX: f083ff937272e800 RBX: 00000cbe407f8b48 RCX: 0000000000000014
[10185.417010] RDX: 0000000000000000 RSI: ffff9583755c3800 RDI: 0000000000000000
[10185.417014] RBP: 0000000000000001 R08: ffff958386cf8880 R09: 0000000000000000
[10185.417019] R10: ffff95838f803800 R11: 0000000000000801 R12: 0000000000000014
[10185.417024] R13: ffff95832ec93530 R14: ffffffffbb5598e0 R15: ffff95832ec93500
[10185.417028] FS:  0000000000000000(0000) GS:ffff95838fc00000(0000) knlGS:0000000000000000
[10185.417033] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10185.417037] CR2: 00007f6a6000d2c0 CR3: 0000000354366004 CR4: 00000000001626f0
[10185.417041] Call Trace:
[10185.417054]  sk_filter_trim_cap+0xfe/0x1b0
[10185.417062]  tcp_v4_rcv+0xaf7/0xdf0
[10185.417068]  ip_local_deliver_finish+0x9c/0x1e0
[10185.417074]  ip_local_deliver+0x78/0x120
[10185.417078]  ? ip_sublist_rcv_finish+0x60/0x60
[10185.417085]  ip_sabotage_in+0x42/0x50 [br_netfilter]
[10185.417091]  nf_hook_slow+0x3f/0xb0
[10185.417096]  ip_rcv+0xdd/0x100
[10185.417100]  ? ip_sublist_rcv+0x2a0/0x2a0
[10185.417176]  __netif_receive_skb_one_core+0x5b/0x80
[10185.417182]  netif_receive_skb_internal+0x4a/0xc0
[10185.417193]  br_pass_frame_up+0x108/0x1b0 [bridge]
[10185.417203]  ? br_port_flags_change+0x70/0x70 [bridge]
[10185.417211]  br_handle_frame_finish+0x181/0x450 [bridge]
[10185.417219]  ? br_pass_frame_up+0x1b0/0x1b0 [bridge]
[10185.417225]  br_nf_hook_thresh+0xdf/0xf0 [br_netfilter]
[10185.417232]  ? br_pass_frame_up+0x1b0/0x1b0 [bridge]
[10185.417237]  br_nf_pre_routing_finish+0x148/0x380 [br_netfilter]
[10185.417245]  ? br_pass_frame_up+0x1b0/0x1b0 [bridge]
[10185.417250]  br_nf_pre_routing+0x383/0x470 [br_netfilter]
[10185.417254]  ? br_nf_forward_ip+0x490/0x490 [br_netfilter]
[10185.417260]  nf_hook_slow+0x3f/0xb0
[10185.417268]  br_handle_frame+0x217/0x360 [bridge]
[10185.417275]  ? br_pass_frame_up+0x1b0/0x1b0 [bridge]
[10185.417282]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[10185.417286]  __netif_receive_skb_core+0x4be/0xc60
[10185.417293]  ? tun_build_skb+0x2b1/0x520 [tun]
[10185.417299]  __netif_receive_skb_one_core+0x3d/0x80
[10185.417303]  netif_receive_skb_internal+0x4a/0xc0
[10185.417308]  tun_get_user+0x1021/0x12b0 [tun]
[10185.417315]  tun_sendmsg+0x55/0x70 [tun]
[10185.417320]  handle_tx_copy+0x142/0x280 [vhost_net]
[10185.417326]  handle_tx+0xa5/0xe0 [vhost_net]
[10185.417387]  vhost_worker+0xaa/0x100 [vhost]
[10185.417395]  kthread+0xfb/0x130
[10185.417406]  ? vhost_flush_work+0x10/0x10 [vhost]
[10185.417411]  ? kthread_park+0x80/0x80
[10185.417416]  ret_from_fork+0x35/0x40
[10185.417420] Modules linked in: ipt_MASQUERADE xt_recent xt_comment ipt_REJECT nf_reject_ipv4 xt_addrtype br_netfilter xt_physdev iptable_nat nf_nat_ipv4 xt_mark iptable_mangle xt_TCPMSS xt_hashlimit xt_tcpudp xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_proto_gre nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp nf_conntrack_proto_gre nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter
[10185.417447]  ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat mousedev input_leds joydev snd_hda_codec_hdmi ofpart cmdlinepart intel_spi_platform intel_spi spi_nor intel_rapl iTCO_wdt mtd iTCO_vendor_support mei_wdt wmi_bmof eeepc_wmi asus_wmi sparse_keymap rfkill i915 x86_pkg_temp_thermal intel_powerclamp coretemp kvmgt kvm_intel vfio_mdev mdev vfio_iommu_type1 crct10dif_pclmul vfio crc32_pclmul ghash_clmulni_intel pcbc kvm aesni_intel aes_x86_64 crypto_simd cryptd glue_helper intel_cstate irqbypass snd_hda_codec_realtek i2c_algo_bit intel_uncore drm_kms_helper intel_rapl_perf snd_hda_codec_generic pcspkr drm snd_hda_intel snd_hda_codec intel_gtt r8169 snd_hda_core agpgart syscopyarea snd_hwdep snd_pcm lpc_ich realtek
[10185.417480]  sysfillrect sysimgblt snd_timer snd i2c_i801 mei_me libphy e1000e pcc_cpufreq fb_sys_fops mei soundcore wmi evdev mac_hid nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci libata crc32c_intel scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd
[10185.417517] ---[ end trace 7f69e8167d4880de ]---
[10185.417526] RIP: 0010:__cgroup_bpf_run_filter_skb+0xe3/0x1e0
[10185.417532] Code: c8 03 00 00 48 8b 00 48 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd 01 00 00 00 49 8b 46 08 48 85 c0 74 0f <48> 8b 00 48 83 c0 10 65 48 89 05 86 1c 06 45 f6 43 02 10 0f 85 9c
[10185.417537] RSP: 0018:ffffab4103fe7680 EFLAGS: 00010286
[10185.417541] RAX: f083ff937272e800 RBX: 00000cbe407f8b48 RCX: 0000000000000014
[10185.417544] RDX: 0000000000000000 RSI: ffff9583755c3800 RDI: 0000000000000000
[10185.417548] RBP: 0000000000000001 R08: ffff958386cf8880 R09: 0000000000000000
[10185.417551] R10: ffff95838f803800 R11: 0000000000000801 R12: 0000000000000014
[10185.417555] R13: ffff95832ec93530 R14: ffffffffbb5598e0 R15: ffff95832ec93500
[10185.417558] FS:  0000000000000000(0000) GS:ffff95838fc00000(0000) knlGS:0000000000000000
[10185.417562] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10185.417565] CR2: 00007f6a6000d2c0 CR3: 0000000354366004 CR4: 00000000001626f0
[10185.417569] Kernel panic - not syncing: Fatal exception in interrupt
[10185.417580] Kernel Offset: 0x39e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[10185.417585] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

3. Kernel Freeze (Paging Request)
[ 3719.735568] BUG: unable to handle kernel paging request at 0000740100706d71
[ 3719.735605] PGD 0 P4D 0
[ 3719.735621] Oops: 0000 [#1] SMP PTI
[ 3719.735635] CPU: 1 PID: 1203 Comm: vhost-1198 Not tainted 4.19.126-1-MANJARO #1
[ 3719.735643] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[ 3719.735663] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[ 3719.735679] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[ 3719.735690] RSP: 0018:ffffb49f03bc7840 EFLAGS: 00010296
[ 3719.735705] RAX: 0000740100706d61 RBX: ffff9d103572d500 RCX: 0000000000000014
[ 3719.735715] RDX: 0000000000000000 RSI: ffff9d103ccdb000 RDI: 0000000000000000
[ 3719.735728] RBP: ffff9d10398d0300 R08: ffff9d103572d500 R09: 0000000000000001
[ 3719.735738] R10: 000000000000f203 R11: 0000000000000000 R12: 0000000000000014
[ 3719.735747] R13: 0000000000000020 R14: ffffffff942f1d80 R15: ffff9d10398d0300
[ 3719.735758] FS:  0000000000000000(0000) GS:ffff9d104fc80000(0000) knlGS:0000000000000000
[ 3719.735767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3719.735775] CR2: 0000740100706d71 CR3: 00000003dc4a0002 CR4: 00000000001626e0
[ 3719.735785] Call Trace:
[ 3719.735808]  ? ipt_do_table+0x379/0x640 [ip_tables]
[ 3719.735568] BUG: unable to handle kernel paging request at 0000740100706d71
[ 3719.735830]  sk_filter_trim_cap+0xfe/0x1b0
[ 3719.735854]  tcp_v4_rcv+0xaf7/0xdf0
[ 3719.735872]  ip_local_deliver_finish+0x9c/0x1e0
[ 3719.735890]  ip_local_deliver+0x78/0x120
[ 3719.735903]  ? ip_sublist_rcv_finish+0x60/0x60
[ 3719.735914]  ip_rcv+0x76/0x100
[ 3719.735928]  __netif_receive_skb_one_core+0x5b/0x80
[ 3719.735605] PGD 0 P4D 0
[ 3719.735943]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.735970]  br_pass_frame_up+0x108/0x1b0 [bridge]
[ 3719.735996]  ? br_port_flags_change+0x70/0x70 [bridge]
[ 3719.736019]  br_handle_frame_finish+0x181/0x450 [bridge]
[ 3719.735621] Oops: 0000 [#1] SMP PTI
[ 3719.736045]  br_handle_frame+0x175/0x360 [bridge]
[ 3719.736072]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[ 3719.736086]  __netif_receive_skb_core+0x4be/0xc60
[ 3719.736101]  ? tun_build_skb+0x2b1/0x520 [tun]
[ 3719.736116]  __netif_receive_skb_one_core+0x3d/0x80
[ 3719.736134]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.735635] CPU: 1 PID: 1203 Comm: vhost-1198 Not tainted 4.19.126-1-MANJARO #1
[ 3719.736148]  tun_get_user+0x1021/0x12b0 [tun]
[ 3719.736167]  tun_sendmsg+0x55/0x70 [tun]
[ 3719.736188]  handle_tx_copy+0x142/0x280 [vhost_net]
[ 3719.736208]  handle_tx+0xa5/0xe0 [vhost_net]
[ 3719.736229]  vhost_worker+0xaa/0x100 [vhost]
[ 3719.735643] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[ 3719.736245]  kthread+0xfb/0x130
[ 3719.736260]  ? vhost_flush_work+0x10/0x10 [vhost]
[ 3719.736274]  ? kthread_park+0x80/0x80
[ 3719.736294]  ret_from_fork+0x35/0x40
[ 3719.735663] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[ 3719.736313] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat mousedev joydev input_leds intel_rapl ofpart cmdlinepart intel_spi_platform snd_hda_codec_hdmi intel_spi iTCO_wdt spi_nor mtd iTCO_vendor_support mei_wdt x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel crct10dif_pclmul eeepc_wmi crc32_pclmul asus_wmi ghash_clmulni_intel wmi_bmof sparse_keymap rfkill pcbc aesni_intel i915 aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_uncore kvmgt vfio_mdev mdev vfio_iommu_type1 vfio snd_hda_codec_realtek intel_rapl_perf kvm pcspkr snd_hda_codec_generic irqbypass i2c_algo_bit r8169 snd_hda_intel snd_hda_codec realtek snd_hda_core
[ 3719.736376]  drm_kms_helper libphy i2c_i801 e1000e intel_gtt lpc_ich snd_hwdep snd_pcm syscopyarea mei_me sysfillrect pcc_cpufreq snd_timer evdev sysimgblt mei fb_sys_fops mac_hid wmi snd soundcore nfsd nfs_acl lockd drm auth_rpcgss grace sunrpc agpgart ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci crc32c_intel xhci_pci libata ehci_pci scsi_mod xhci_hcd ehci_hcd
[ 3719.736432] CR2: 0000740100706d71
[ 3719.736453] ---[ end trace e5ae8b80d90db0da ]---
[ 3719.736471] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[ 3719.736485] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[ 3719.736500] RSP: 0018:ffffb49f03bc7840 EFLAGS: 00010296
[ 3719.736518] RAX: 0000740100706d61 RBX: ffff9d103572d500 RCX: 0000000000000014
[ 3719.736528] RDX: 0000000000000000 RSI: ffff9d103ccdb000 RDI: 0000000000000000
[ 3719.736540] RBP: ffff9d10398d0300 R08: ffff9d103572d500 R09: 0000000000000001
[ 3719.736556] R10: 000000000000f203 R11: 0000000000000000 R12: 0000000000000014
[ 3719.736571] R13: 0000000000000020 R14: ffffffff942f1d80 R15: ffff9d10398d0300
[ 3719.736582] FS:  0000000000000000(0000) GS:ffff9d104fc80000(0000) knlGS:0000000000000000
[ 3719.736592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3719.736600] CR2: 0000740100706d71 CR3: 00000003dc4a0002 CR4: 00000000001626e0
[ 3719.736611] Kernel panic - not syncing: Fatal exception in interrupt
[ 3719.736644] Kernel Offset: 0x12000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 3719.736657] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
[ 3719.736686] WARNING: CPU: 1 PID: 1203 at kernel/sched/core.c:1164 set_task_cpu+0x173/0x180
[ 3719.736695] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat mousedev joydev input_leds intel_rapl ofpart cmdlinepart intel_spi_platform snd_hda_codec_hdmi intel_spi iTCO_wdt spi_nor mtd iTCO_vendor_support mei_wdt x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel crct10dif_pclmul eeepc_wmi crc32_pclmul asus_wmi ghash_clmulni_intel wmi_bmof sparse_keymap rfkill pcbc aesni_intel i915 aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_uncore kvmgt vfio_mdev mdev vfio_iommu_type1 vfio snd_hda_codec_realtek intel_rapl_perf kvm pcspkr snd_hda_codec_generic irqbypass i2c_algo_bit r8169 snd_hda_intel snd_hda_codec realtek snd_hda_core
[ 3719.736743]  drm_kms_helper libphy i2c_i801 e1000e intel_gtt lpc_ich snd_hwdep snd_pcm syscopyarea mei_me sysfillrect pcc_cpufreq snd_timer evdev sysimgblt mei fb_sys_fops mac_hid wmi snd soundcore nfsd nfs_acl lockd drm auth_rpcgss grace sunrpc agpgart ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci crc32c_intel xhci_pci libata ehci_pci scsi_mod xhci_hcd ehci_hcd
[ 3719.736784] CPU: 1 PID: 1203 Comm: vhost-1198 Tainted: G      D           4.19.126-1-MANJARO #1
[ 3719.736791] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[ 3719.736803] RIP: 0010:set_task_cpu+0x173/0x180
[ 3719.736813] Code: e9 54 ff ff ff 0f 0b e9 dc fe ff ff 8b 43 60 85 c0 0f 84 e8 fe ff ff 8b 43 60 83 f8 02 0f 84 dc fe ff ff 0f 0b e9 d5 fe ff ff <0f> 0b e9 df fe ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 41 55 49 89
[ 3719.736823] RSP: 0018:ffff9d104fc83cb8 EFLAGS: 00010006
[ 3719.736832] RAX: 0000000000000200 RBX: ffff9d10486bd940 RCX: ffff9d104fd80000
[ 3719.736840] RDX: ffff9d10486bd940 RSI: 0000000000000003 RDI: ffff9d10486bd940
[ 3719.736848] RBP: ffff9d10486bd940 R08: 0000000000000003 R09: 0000000000000001
[ 3719.736857] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000003
[ 3719.735679] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[ 3719.736865] R13: 0000000000000003 R14: 0000000000000046 R15: ffff9d10486be084
[ 3719.736875] FS:  0000000000000000(0000) GS:ffff9d104fc80000(0000) knlGS:0000000000000000
[ 3719.736885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3719.736893] CR2: 0000740100706d71 CR3: 00000003dc4a0002 CR4: 00000000001626e0
[ 3719.736900] Call Trace:
[ 3719.736915]  <IRQ>
[ 3719.737005]  try_to_wake_up+0x185/0x4c0
[ 3719.737019]  __wake_up_common+0x7a/0x140
[ 3719.737033]  ep_poll_callback+0x152/0x270
[ 3719.737046]  __wake_up_common+0x7a/0x140
[ 3719.737058]  __wake_up_common_lock+0x7f/0xc0
[ 3719.737072]  irq_work_run_list+0x4f/0x70
[ 3719.737086]  update_process_times+0x84/0x90
[ 3719.737097]  tick_sched_handle+0x22/0x60
[ 3719.737108]  tick_sched_timer+0x51/0xb0
[ 3719.735690] RSP: 0018:ffffb49f03bc7840 EFLAGS: 00010296
[ 3719.737119]  ? tick_do_update_jiffies64.part.0+0xd0/0xd0
[ 3719.737132]  __hrtimer_run_queues+0x128/0x2a0
[ 3719.737145]  hrtimer_interrupt+0x10e/0x280
[ 3719.737158]  smp_apic_timer_interrupt+0x6e/0x140
[ 3719.737169]  apic_timer_interrupt+0xf/0x20
[ 3719.737179]  </IRQ>
[ 3719.737190] RIP: 0010:panic+0x204/0x24a
[ 3719.737199] Code: eb a6 83 3d 15 4f 80 01 00 74 05 e8 0e 54 02 00 48 c7 c6 00 b1 88 94 48 c7 c7 18 f4 07 94 e8 89 77 06 00 fb 66 0f 1f 44 00 00 <31> db e8 1d b2 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 bd 4e 80
[ 3719.737208] RSP: 0018:ffffb49f03bc76f8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[ 3719.737217] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000006
[ 3719.737228] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff9d104fc965b0
[ 3719.737237] RBP: ffffb49f03bc7768 R08: 0000000000000610 R09: 0000000000000000
[ 3719.737245] R10: ffffffff93104510 R11: ffffe42f4c8dd600 R12: 0000000000000000
[ 3719.737253] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 3719.735705] RAX: 0000740100706d61 RBX: ffff9d103572d500 RCX: 0000000000000014
[ 3719.737264]  ? swiotlb_tbl_unmap_single+0x110/0x110
[ 3719.737349]  ? panic+0x1fd/0x24a
[ 3719.737363]  oops_end.cold+0xc/0x18
[ 3719.737373]  page_fault+0x1e/0x30
[ 3719.737386] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[ 3719.737394] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[ 3719.737402] RSP: 0018:ffffb49f03bc7840 EFLAGS: 00010296
[ 3719.737411] RAX: 0000740100706d61 RBX: ffff9d103572d500 RCX: 0000000000000014
[ 3719.737418] RDX: 0000000000000000 RSI: ffff9d103ccdb000 RDI: 0000000000000000
[ 3719.737426] RBP: ffff9d10398d0300 R08: ffff9d103572d500 R09: 0000000000000001
[ 3719.735715] RDX: 0000000000000000 RSI: ffff9d103ccdb000 RDI: 0000000000000000
[ 3719.737434] R10: 000000000000f203 R11: 0000000000000000 R12: 0000000000000014
[ 3719.737442] R13: 0000000000000020 R14: ffffffff942f1d80 R15: ffff9d10398d0300
[ 3719.737458]  ? ipt_do_table+0x379/0x640 [ip_tables]
[ 3719.737473]  sk_filter_trim_cap+0xfe/0x1b0
[ 3719.737487]  tcp_v4_rcv+0xaf7/0xdf0
[ 3719.737499]  ip_local_deliver_finish+0x9c/0x1e0
[ 3719.737512]  ip_local_deliver+0x78/0x120
[ 3719.735728] RBP: ffff9d10398d0300 R08: ffff9d103572d500 R09: 0000000000000001
[ 3719.737522]  ? ip_sublist_rcv_finish+0x60/0x60
[ 3719.737532]  ip_rcv+0x76/0x100
[ 3719.737543]  __netif_receive_skb_one_core+0x5b/0x80
[ 3719.737553]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.737574]  br_pass_frame_up+0x108/0x1b0 [bridge]
[ 3719.737592]  ? br_port_flags_change+0x70/0x70 [bridge]
[ 3719.737610]  br_handle_frame_finish+0x181/0x450 [bridge]
[ 3719.735738] R10: 000000000000f203 R11: 0000000000000000 R12: 0000000000000014
[ 3719.737703]  br_handle_frame+0x175/0x360 [bridge]
[ 3719.735747] R13: 0000000000000020 R14: ffffffff942f1d80 R15: ffff9d10398d0300
[ 3719.737721]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[ 3719.737732]  __netif_receive_skb_core+0x4be/0xc60
[ 3719.737745]  ? tun_build_skb+0x2b1/0x520 [tun]
[ 3719.737755]  __netif_receive_skb_one_core+0x3d/0x80
[ 3719.737765]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.737777]  tun_get_user+0x1021/0x12b0 [tun]
[ 3719.737791]  tun_sendmsg+0x55/0x70 [tun]
[ 3719.735758] FS:  0000000000000000(0000) GS:ffff9d104fc80000(0000) knlGS:0000000000000000
[ 3719.737802]  handle_tx_copy+0x142/0x280 [vhost_net]
[ 3719.737815]  handle_tx+0xa5/0xe0 [vhost_net]
[ 3719.737828]  vhost_worker+0xaa/0x100 [vhost]
[ 3719.737841]  kthread+0xfb/0x130
[ 3719.737853]  ? vhost_flush_work+0x10/0x10 [vhost]
[ 3719.737864]  ? kthread_park+0x80/0x80
[ 3719.737874]  ret_from_fork+0x35/0x40
[ 3719.737884] ---[ end trace e5ae8b80d90db0db ]---
[ 3719.737897] ------------[ cut here ]------------
[ 3719.737905] sched: Unexpected reschedule of offline CPU#3!
[ 3719.735767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3719.737919] WARNING: CPU: 1 PID: 1203 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x34/0x40
[ 3719.737929] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat mousedev joydev input_leds intel_rapl ofpart cmdlinepart intel_spi_platform snd_hda_codec_hdmi intel_spi iTCO_wdt spi_nor mtd iTCO_vendor_support mei_wdt x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel crct10dif_pclmul eeepc_wmi crc32_pclmul asus_wmi ghash_clmulni_intel wmi_bmof sparse_keymap rfkill pcbc aesni_intel i915 aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_uncore kvmgt vfio_mdev mdev vfio_iommu_type1 vfio snd_hda_codec_realtek intel_rapl_perf kvm pcspkr snd_hda_codec_generic irqbypass i2c_algo_bit r8169 snd_hda_intel snd_hda_codec realtek snd_hda_core
[ 3719.735775] CR2: 0000740100706d71 CR3: 00000003dc4a0002 CR4: 00000000001626e0
[ 3719.737974]  drm_kms_helper libphy i2c_i801 e1000e intel_gtt lpc_ich snd_hwdep snd_pcm syscopyarea mei_me sysfillrect pcc_cpufreq snd_timer evdev sysimgblt mei fb_sys_fops mac_hid wmi snd soundcore nfsd nfs_acl lockd drm auth_rpcgss grace sunrpc agpgart ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci crc32c_intel xhci_pci libata ehci_pci scsi_mod xhci_hcd ehci_hcd
[ 3719.738014] CPU: 1 PID: 1203 Comm: vhost-1198 Tainted: G      D W         4.19.126-1-MANJARO #1
[ 3719.738024] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[ 3719.735785] Call Trace:
[ 3719.738034] RIP: 0010:native_smp_send_reschedule+0x34/0x40
[ 3719.738115] Code: 05 c1 89 2f 01 73 15 48 8b 05 78 71 0d 01 be fd 00 00 00 48 8b 40 30 e9 ca eb ba 00 89 fe 48 c7 c7 30 58 07 94 e8 fb 1a 03 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 6d 7a 83
[ 3719.738124] RSP: 0018:ffff9d104fc83ca0 EFLAGS: 00010086
[ 3719.738132] RAX: 0000000000000000 RBX: ffff9d104fda1cc0 RCX: 0000000000000006
[ 3719.738140] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff9d104fc965b0
[ 3719.738147] RBP: ffff9d10486bd940 R08: 0000000000000663 R09: 0000000000000000
[ 3719.738156] R10: ffffffff93104510 R11: 0000000000000000 R12: ffff9d10486bd940
[ 3719.738163] R13: ffff9d104fc83cf0 R14: 0000000000000046 R15: ffff9d10486be084
[ 3719.738172] FS:  0000000000000000(0000) GS:ffff9d104fc80000(0000) knlGS:0000000000000000
[ 3719.738180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3719.738188] CR2: 0000740100706d71 CR3: 00000003dc4a0002 CR4: 00000000001626e0
[ 3719.738195] Call Trace:
[ 3719.738203]  <IRQ>
[ 3719.735808]  ? ipt_do_table+0x379/0x640 [ip_tables]
[ 3719.738214]  check_preempt_curr+0x4d/0x90
[ 3719.738225]  ttwu_do_wakeup+0x19/0x150
[ 3719.738236]  try_to_wake_up+0x210/0x4c0
[ 3719.738250]  __wake_up_common+0x7a/0x140
[ 3719.738265]  ep_poll_callback+0x152/0x270
[ 3719.738280]  __wake_up_common+0x7a/0x140
[ 3719.738292]  __wake_up_common_lock+0x7f/0xc0
[ 3719.735830]  sk_filter_trim_cap+0xfe/0x1b0
[ 3719.738304]  irq_work_run_list+0x4f/0x70
[ 3719.738316]  update_process_times+0x84/0x90
[ 3719.738329]  tick_sched_handle+0x22/0x60
[ 3719.738340]  tick_sched_timer+0x51/0xb0
[ 3719.735854]  tcp_v4_rcv+0xaf7/0xdf0
[ 3719.738424]  ? tick_do_update_jiffies64.part.0+0xd0/0xd0
[ 3719.738435]  __hrtimer_run_queues+0x128/0x2a0
[ 3719.738448]  hrtimer_interrupt+0x10e/0x280
[ 3719.738460]  smp_apic_timer_interrupt+0x6e/0x140
[ 3719.738470]  apic_timer_interrupt+0xf/0x20
[ 3719.738478]  </IRQ>
[ 3719.738488] RIP: 0010:panic+0x204/0x24a
[ 3719.738496] Code: eb a6 83 3d 15 4f 80 01 00 74 05 e8 0e 54 02 00 48 c7 c6 00 b1 88 94 48 c7 c7 18 f4 07 94 e8 89 77 06 00 fb 66 0f 1f 44 00 00 <31> db e8 1d b2 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 bd 4e 80
[ 3719.735872]  ip_local_deliver_finish+0x9c/0x1e0
[ 3719.738505] RSP: 0018:ffffb49f03bc76f8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[ 3719.738514] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000006
[ 3719.738522] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff9d104fc965b0
[ 3719.738531] RBP: ffffb49f03bc7768 R08: 0000000000000610 R09: 0000000000000000
[ 3719.738539] R10: ffffffff93104510 R11: ffffe42f4c8dd600 R12: 0000000000000000
[ 3719.738547] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 3719.738558]  ? swiotlb_tbl_unmap_single+0x110/0x110
[ 3719.738571]  ? panic+0x1fd/0x24a
[ 3719.738584]  oops_end.cold+0xc/0x18
[ 3719.738593]  page_fault+0x1e/0x30
[ 3719.735890]  ip_local_deliver+0x78/0x120
[ 3719.738605] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[ 3719.738616] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[ 3719.738625] RSP: 0018:ffffb49f03bc7840 EFLAGS: 00010296
[ 3719.738633] RAX: 0000740100706d61 RBX: ffff9d103572d500 RCX: 0000000000000014
[ 3719.738640] RDX: 0000000000000000 RSI: ffff9d103ccdb000 RDI: 0000000000000000
[ 3719.735903]  ? ip_sublist_rcv_finish+0x60/0x60
[ 3719.738648] RBP: ffff9d10398d0300 R08: ffff9d103572d500 R09: 0000000000000001
[ 3719.738730] R10: 000000000000f203 R11: 0000000000000000 R12: 0000000000000014
[ 3719.738738] R13: 0000000000000020 R14: ffffffff942f1d80 R15: ffff9d10398d0300
[ 3719.738751]  ? ipt_do_table+0x379/0x640 [ip_tables]
[ 3719.738765]  sk_filter_trim_cap+0xfe/0x1b0
[ 3719.738778]  tcp_v4_rcv+0xaf7/0xdf0
[ 3719.738789]  ip_local_deliver_finish+0x9c/0x1e0
[ 3719.738799]  ip_local_deliver+0x78/0x120
[ 3719.735914]  ip_rcv+0x76/0x100
[ 3719.738809]  ? ip_sublist_rcv_finish+0x60/0x60
[ 3719.738819]  ip_rcv+0x76/0x100
[ 3719.738830]  __netif_receive_skb_one_core+0x5b/0x80
[ 3719.738841]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.738861]  br_pass_frame_up+0x108/0x1b0 [bridge]
[ 3719.738880]  ? br_port_flags_change+0x70/0x70 [bridge]
[ 3719.738898]  br_handle_frame_finish+0x181/0x450 [bridge]
[ 3719.735928]  __netif_receive_skb_one_core+0x5b/0x80
[ 3719.738916]  br_handle_frame+0x175/0x360 [bridge]
[ 3719.738934]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[ 3719.738946]  __netif_receive_skb_core+0x4be/0xc60
[ 3719.738959]  ? tun_build_skb+0x2b1/0x520 [tun]
[ 3719.738972]  __netif_receive_skb_one_core+0x3d/0x80
[ 3719.738981]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.738993]  tun_get_user+0x1021/0x12b0 [tun]
[ 3719.739006]  tun_sendmsg+0x55/0x70 [tun]
[ 3719.735943]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.739020]  handle_tx_copy+0x142/0x280 [vhost_net]
[ 3719.739104]  handle_tx+0xa5/0xe0 [vhost_net]
[ 3719.739116]  vhost_worker+0xaa/0x100 [vhost]
[ 3719.735970]  br_pass_frame_up+0x108/0x1b0 [bridge]
[ 3719.739128]  kthread+0xfb/0x130
[ 3719.739140]  ? vhost_flush_work+0x10/0x10 [vhost]
[ 3719.739149]  ? kthread_park+0x80/0x80
[ 3719.739158]  ret_from_fork+0x35/0x40
[ 3719.739168] ---[ end trace e5ae8b80d90db0dc ]---
[ 3719.735996]  ? br_port_flags_change+0x70/0x70 [bridge]
[ 3719.736019]  br_handle_frame_finish+0x181/0x450 [bridge]
[ 3719.736045]  br_handle_frame+0x175/0x360 [bridge]
[ 3719.736072]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[ 3719.736086]  __netif_receive_skb_core+0x4be/0xc60
[ 3719.736101]  ? tun_build_skb+0x2b1/0x520 [tun]
[ 3719.736116]  __netif_receive_skb_one_core+0x3d/0x80
[ 3719.736134]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.736148]  tun_get_user+0x1021/0x12b0 [tun]
[ 3719.736167]  tun_sendmsg+0x55/0x70 [tun]
[ 3719.736188]  handle_tx_copy+0x142/0x280 [vhost_net]
[ 3719.736208]  handle_tx+0xa5/0xe0 [vhost_net]
[ 3719.736229]  vhost_worker+0xaa/0x100 [vhost]
[ 3719.736245]  kthread+0xfb/0x130
[ 3719.736260]  ? vhost_flush_work+0x10/0x10 [vhost]
[ 3719.736274]  ? kthread_park+0x80/0x80
[ 3719.736294]  ret_from_fork+0x35/0x40
[ 3719.736313] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat mousedev joydev input_leds intel_rapl ofpart cmdlinepart intel_spi_platform snd_hda_codec_hdmi intel_spi iTCO_wdt spi_nor mtd iTCO_vendor_support mei_wdt x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel crct10dif_pclmul eeepc_wmi crc32_pclmul asus_wmi ghash_clmulni_intel wmi_bmof sparse_keymap rfkill pcbc aesni_intel i915 aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_uncore kvmgt vfio_mdev mdev vfio_iommu_type1 vfio snd_hda_codec_realtek intel_rapl_perf kvm pcspkr snd_hda_codec_generic irqbypass i2c_algo_bit r8169 snd_hda_intel snd_hda_codec realtek snd_hda_core
[ 3719.736376]  drm_kms_helper libphy i2c_i801 e1000e intel_gtt lpc_ich snd_hwdep snd_pcm syscopyarea mei_me sysfillrect pcc_cpufreq snd_timer evdev sysimgblt mei fb_sys_fops mac_hid wmi snd soundcore nfsd nfs_acl lockd drm auth_rpcgss grace sunrpc agpgart ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci crc32c_intel xhci_pci libata ehci_pci scsi_mod xhci_hcd ehci_hcd
[ 3719.736432] CR2: 0000740100706d71
[ 3719.736453] ---[ end trace e5ae8b80d90db0da ]---
[ 3719.736471] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[ 3719.736485] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[ 3719.736500] RSP: 0018:ffffb49f03bc7840 EFLAGS: 00010296
[ 3719.736518] RAX: 0000740100706d61 RBX: ffff9d103572d500 RCX: 0000000000000014
[ 3719.736528] RDX: 0000000000000000 RSI: ffff9d103ccdb000 RDI: 0000000000000000
[ 3719.736540] RBP: ffff9d10398d0300 R08: ffff9d103572d500 R09: 0000000000000001
[ 3719.736556] R10: 000000000000f203 R11: 0000000000000000 R12: 0000000000000014
[ 3719.736571] R13: 0000000000000020 R14: ffffffff942f1d80 R15: ffff9d10398d0300
[ 3719.736582] FS:  0000000000000000(0000) GS:ffff9d104fc80000(0000) knlGS:0000000000000000
[ 3719.736592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3719.736600] CR2: 0000740100706d71 CR3: 00000003dc4a0002 CR4: 00000000001626e0
[ 3719.736611] Kernel panic - not syncing: Fatal exception in interrupt
[ 3719.736644] Kernel Offset: 0x12000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 3719.736657] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
[ 3719.736686] WARNING: CPU: 1 PID: 1203 at kernel/sched/core.c:1164 set_task_cpu+0x173/0x180
[ 3719.736695] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat mousedev joydev input_leds intel_rapl ofpart cmdlinepart intel_spi_platform snd_hda_codec_hdmi intel_spi iTCO_wdt spi_nor mtd iTCO_vendor_support mei_wdt x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel crct10dif_pclmul eeepc_wmi crc32_pclmul asus_wmi ghash_clmulni_intel wmi_bmof sparse_keymap rfkill pcbc aesni_intel i915 aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_uncore kvmgt vfio_mdev mdev vfio_iommu_type1 vfio snd_hda_codec_realtek intel_rapl_perf kvm pcspkr snd_hda_codec_generic irqbypass i2c_algo_bit r8169 snd_hda_intel snd_hda_codec realtek snd_hda_core
[ 3719.736743]  drm_kms_helper libphy i2c_i801 e1000e intel_gtt lpc_ich snd_hwdep snd_pcm syscopyarea mei_me sysfillrect pcc_cpufreq snd_timer evdev sysimgblt mei fb_sys_fops mac_hid wmi snd soundcore nfsd nfs_acl lockd drm auth_rpcgss grace sunrpc agpgart ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci crc32c_intel xhci_pci libata ehci_pci scsi_mod xhci_hcd ehci_hcd
[ 3719.736784] CPU: 1 PID: 1203 Comm: vhost-1198 Tainted: G      D           4.19.126-1-MANJARO #1
[ 3719.736791] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[ 3719.736803] RIP: 0010:set_task_cpu+0x173/0x180
[ 3719.736813] Code: e9 54 ff ff ff 0f 0b e9 dc fe ff ff 8b 43 60 85 c0 0f 84 e8 fe ff ff 8b 43 60 83 f8 02 0f 84 dc fe ff ff 0f 0b e9 d5 fe ff ff <0f> 0b e9 df fe ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 41 55 49 89
[ 3719.736823] RSP: 0018:ffff9d104fc83cb8 EFLAGS: 00010006
[ 3719.736832] RAX: 0000000000000200 RBX: ffff9d10486bd940 RCX: ffff9d104fd80000
[ 3719.736840] RDX: ffff9d10486bd940 RSI: 0000000000000003 RDI: ffff9d10486bd940
[ 3719.736848] RBP: ffff9d10486bd940 R08: 0000000000000003 R09: 0000000000000001
[ 3719.736857] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000003
[ 3719.736865] R13: 0000000000000003 R14: 0000000000000046 R15: ffff9d10486be084
[ 3719.736875] FS:  0000000000000000(0000) GS:ffff9d104fc80000(0000) knlGS:0000000000000000
[ 3719.736885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3719.736893] CR2: 0000740100706d71 CR3: 00000003dc4a0002 CR4: 00000000001626e0
[ 3719.736900] Call Trace:
[ 3719.736915]  <IRQ>
[ 3719.737005]  try_to_wake_up+0x185/0x4c0
[ 3719.737019]  __wake_up_common+0x7a/0x140
[ 3719.737033]  ep_poll_callback+0x152/0x270
[ 3719.737046]  __wake_up_common+0x7a/0x140
[ 3719.737058]  __wake_up_common_lock+0x7f/0xc0
[ 3719.737072]  irq_work_run_list+0x4f/0x70
[ 3719.737086]  update_process_times+0x84/0x90
[ 3719.737097]  tick_sched_handle+0x22/0x60
[ 3719.737108]  tick_sched_timer+0x51/0xb0
[ 3719.737119]  ? tick_do_update_jiffies64.part.0+0xd0/0xd0
[ 3719.737132]  __hrtimer_run_queues+0x128/0x2a0
[ 3719.737145]  hrtimer_interrupt+0x10e/0x280
[ 3719.737158]  smp_apic_timer_interrupt+0x6e/0x140
[ 3719.737169]  apic_timer_interrupt+0xf/0x20
[ 3719.737179]  </IRQ>
[ 3719.737190] RIP: 0010:panic+0x204/0x24a
[ 3719.737199] Code: eb a6 83 3d 15 4f 80 01 00 74 05 e8 0e 54 02 00 48 c7 c6 00 b1 88 94 48 c7 c7 18 f4 07 94 e8 89 77 06 00 fb 66 0f 1f 44 00 00 <31> db e8 1d b2 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 bd 4e 80
[ 3719.737208] RSP: 0018:ffffb49f03bc76f8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[ 3719.737217] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000006
[ 3719.737228] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff9d104fc965b0
[ 3719.737237] RBP: ffffb49f03bc7768 R08: 0000000000000610 R09: 0000000000000000
[ 3719.737245] R10: ffffffff93104510 R11: ffffe42f4c8dd600 R12: 0000000000000000
[ 3719.737253] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 3719.737264]  ? swiotlb_tbl_unmap_single+0x110/0x110
[ 3719.737349]  ? panic+0x1fd/0x24a
[ 3719.737363]  oops_end.cold+0xc/0x18
[ 3719.737373]  page_fault+0x1e/0x30
[ 3719.737386] RIP: 0010:__cgroup_bpf_run_filter_skb+0xc0/0x1e0
[ 3719.737394] Code: 48 89 3c 24 44 89 e1 45 01 a7 80 00 00 00 48 29 c8 48 89 4c 24 08 49 89 87 d8 00 00 00 89 d2 48 8d 84 d6 c8 03 00 00 48 8b 00 <48> 8b 58 10 4c 8d 70 10 48 85 db 0f 84 fe 00 00 00 4d 8d 6f 30 bd
[ 3719.737402] RSP: 0018:ffffb49f03bc7840 EFLAGS: 00010296
[ 3719.737411] RAX: 0000740100706d61 RBX: ffff9d103572d500 RCX: 0000000000000014
[ 3719.737418] RDX: 0000000000000000 RSI: ffff9d103ccdb000 RDI: 0000000000000000
[ 3719.737426] RBP: ffff9d10398d0300 R08: ffff9d103572d500 R09: 0000000000000001
[ 3719.737434] R10: 000000000000f203 R11: 0000000000000000 R12: 0000000000000014
[ 3719.737442] R13: 0000000000000020 R14: ffffffff942f1d80 R15: ffff9d10398d0300
[ 3719.737458]  ? ipt_do_table+0x379/0x640 [ip_tables]
[ 3719.737473]  sk_filter_trim_cap+0xfe/0x1b0
[ 3719.737487]  tcp_v4_rcv+0xaf7/0xdf0
[ 3719.737499]  ip_local_deliver_finish+0x9c/0x1e0
[ 3719.737512]  ip_local_deliver+0x78/0x120
[ 3719.737522]  ? ip_sublist_rcv_finish+0x60/0x60
[ 3719.737532]  ip_rcv+0x76/0x100
[ 3719.737543]  __netif_receive_skb_one_core+0x5b/0x80
[ 3719.737553]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.737574]  br_pass_frame_up+0x108/0x1b0 [bridge]
[ 3719.737592]  ? br_port_flags_change+0x70/0x70 [bridge]
[ 3719.737610]  br_handle_frame_finish+0x181/0x450 [bridge]
[ 3719.737703]  br_handle_frame+0x175/0x360 [bridge]
[ 3719.737721]  ? br_handle_local_finish+0xa0/0xa0 [bridge]
[ 3719.737732]  __netif_receive_skb_core+0x4be/0xc60
[ 3719.737745]  ? tun_build_skb+0x2b1/0x520 [tun]
[ 3719.737755]  __netif_receive_skb_one_core+0x3d/0x80
[ 3719.737765]  netif_receive_skb_internal+0x4a/0xc0
[ 3719.737777]  tun_get_user+0x1021/0x12b0 [tun]
[ 3719.737791]  tun_sendmsg+0x55/0x70 [tun]
[ 3719.737802]  handle_tx_copy+0x142/0x280 [vhost_net]
[ 3719.737815]  handle_tx+0xa5/0xe0 [vhost_net]
[ 3719.737828]  vhost_worker+0xaa/0x100 [vhost]
[ 3719.737841]  kthread+0xfb/0x130
[ 3719.737853]  ? vhost_flush_work+0x10/0x10 [vhost]
[ 3719.737864]  ? kthread_park+0x80/0x80
[ 3719.737874]  ret_from_fork+0x35/0x40
[ 3719.737884] ---[ end trace e5ae8b80d90db0db ]---
[ 3719.737897] ------------[ cut here ]------------
[ 3719.737905] sched: Unexpected reschedule of offline CPU#3!
[ 3719.737919] WARNING: CPU: 1 PID: 1203 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x34/0x40
[ 3719.737929] Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat mousedev joydev input_leds intel_rapl ofpart cmdlinepart intel_spi_platform snd_hda_codec_hdmi intel_spi iTCO_wdt spi_nor mtd iTCO_vendor_support mei_wdt x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel crct10dif_pclmul eeepc_wmi crc32_pclmul asus_wmi ghash_clmulni_intel wmi_bmof sparse_keymap rfkill pcbc aesni_intel i915 aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_uncore kvmgt vfio_mdev mdev vfio_iommu_type1 vfio snd_hda_codec_realtek intel_rapl_perf kvm pcspkr snd_hda_codec_generic irqbypass i2c_algo_bit r8169 snd_hda_intel snd_hda_codec realtek snd_hda_core
[ 3719.737974]  drm_kms_helper libphy i2c_i801 e1000e intel_gtt lpc_ich snd_hwdep snd_pcm syscopyarea mei_me sysfillrect pcc_cpufreq snd_timer evdev sysimgblt mei fb_sys_fops mac_hid wmi snd soundcore nfsd nfs_acl lockd drm auth_rpcgss grace sunrpc agpgart ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci crc32c_intel xhci_pci libata ehci_pci scsi_mod xhci_hcd ehci_hcd
[ 3719.738014] CPU: 1 PID: 1203 Comm: vhost-1198 Tainted: G      D W         4.19.126-1-MANJARO #1
[ 3719.738024] Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
[ 3719.738034] RIP: 0010:native_smp_send_reschedule+0x34/0x40
[ 3719.738115] Code: 05 c1 89 2f 01 73 15 48 8b 05 78 71 0d 01 be fd 00 00 00 48 8b 40 30 e9 ca eb ba 00 89 fe 48 c7 c7 30 58 07 94 e8 fb 1a 03 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 6d 7a 83
[ 3719.738124] RSP: 0018:ffff9d104fc83ca0 EFLAGS: 00010086
[ 3719.738132] RAX: 0000000000000000 RBX: ffff9d104fda1cc0 RCX: 0000000000000006
[ 3719.738140] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff9d104fc965b0
[ 3719.738147] RBP: ffff9d10486bd940 R08: 0000000000000663 R09: 0000000000000000
[ 3719.738156] R10: ffffffff93104510 R11: 0000000000000000 R12: ffff9d10486bd940
[ 3719.738163] R13: ffff9d104fc83cf0 R14: 0000000000000046 R15: ffff9d10486be084
[ 3719.738172] FS:  0000000000000000(0000) GS:ffff9d104fc80000(0000) knlGS:0000000000000000
[ 3719.738180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3719.738188] CR2: 0000740100706d71 CR3: 00000003dc4a0002 CR4: 00000000001626e0
[ 3719.738195] Call Trace:
[ 3719.738203]  <IRQ>
[ 3719.738214]  check_preempt_curr+0x4d/0x90
[ 3719.738225]  ttwu_do_wakeup+0x19/0x150
[ 3719.738236]  try_to_wake_up+0x210/0x4c0
[ 3719.738250]  __wake_up_common+0x7a/0x140
[ 3719.738265]  ep_poll_callback+0x152/0x270
[ 3719.738280]  __wake_up_common+0x7a/0x140
[ 3719.738292]  __wake_up_common_lock+0x7f/0xc0
[ 3719.738304]  irq_work_run_list+0x4f/0x70
[ 3719.738316]  update_process_times+0x84/0x90
[ 3719.738329]  tick_sched_handle+0x22/0x60
[ 3719.738340]  tick_sched_timer+0x51/0xb0
[ 3719.738424]  ? tick_do_update_jiffies64.part.0+0xd0/0xd0
[ 3719.738435]  __hrtimer_run_queues+0x128/0x2a0

