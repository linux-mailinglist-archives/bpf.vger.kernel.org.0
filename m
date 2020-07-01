Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DAA210441
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 08:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGAGvj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 02:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgGAGvi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 02:51:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD36C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 23:51:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so23338604ejb.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 23:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TPXwYmR5XuohmhUKy+4gs2g1I6JlhAx7jWox8oRUISI=;
        b=K+o/4vHWVc09RNipoKQYTeFNxrfXMYbzXmxZdZUWEXt6Pj1MwRTAJdx1dQi5aBOZaf
         1LLMyxRKuaqAbGlPRtQG+JX/Jbh9ArNC6idoK/1Dq+htvheOZCsfHzJ0A0k54hLOhzR3
         91e97YnomwAQljOPvgoG1I39Y3spFCuGXNObEpbY8f1vtXVdT8e9XQQGUCA75Up9iEEy
         hY6VSyqjf2dQ3aPfgWgfvKKDCmC2HjuDgergVBdHe5Hx6hRd4+bI0YBhirFQejJW89rd
         vCa13gE8BAAhJunLoo11AQNm3GUPbUaG0htJtmp4qy+J+ny+XBlK63Kc2mpMkicH4CFQ
         pVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TPXwYmR5XuohmhUKy+4gs2g1I6JlhAx7jWox8oRUISI=;
        b=WUxK5PiU8surtHEdQKZGPl7uGnBeh3hU/nMpjFtXgBTXxOTBFW4u7cDxEuV3Afbyk2
         3XEyRLCqtwU61HF0K4u518h3loTeqimkFSDnxf+D3+Oe3MhEDO1bxV0c/jYQx3uvztHT
         WvJA0QXc2GGjFjVMsE1FS/hknh98bfA7F78B1lBlsMvwMq5gdOlbxG7rMgGZGEkCfGP1
         o4xbq4WpnKQR5UhsohxJ1aSE/MqbO3gTSE9nd8+X3nwrBKA3WpD9WQTMvYaO9s5TSuZh
         ghlRY906qfBcuD5d9ZX0tDSxLn0cKjh+iBMW7zB/CQMa87btNMNvLa++3aY9L8V7pVE1
         HwTQ==
X-Gm-Message-State: AOAM533ncBY8+tmrG9Xi/+iK45V0y8iKjl52Vr2tt0DYd7ZQxu5fS3Is
        OeElFlFmzgte2zxT2BuAfA==
X-Google-Smtp-Source: ABdhPJxGYYs2oJqXaMR6UX9E0yZdw7XX1CoIh9N9h1ELmFYJtwvFhg2HzSPS2S4IQoBeM8EqgogwdQ==
X-Received: by 2002:a17:906:add3:: with SMTP id lb19mr14121912ejb.304.1593586297382;
        Tue, 30 Jun 2020 23:51:37 -0700 (PDT)
Received: from [192.168.254.199] (x4d0c3c5b.dyn.telefonica.de. [77.12.60.91])
        by smtp.gmail.com with ESMTPSA id y62sm5473517edy.61.2020.06.30.23.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:51:36 -0700 (PDT)
Subject: Re: BUG: kernel NULL pointer dereference in
 __cgroup_bpf_run_filter_skb
From:   Thomas Reim <reimth@gmail.com>
To:     bpf@vger.kernel.org
References: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
Cc:     reimth@gmail.com
Message-ID: <e1006435-b708-0f3a-8704-c40d4cbab849@gmail.com>
Date:   Wed, 1 Jul 2020 08:51:35 +0200
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

:
> We have experienced a kernel BPF null pointer dereference issue on all
> our machines since mid of June. It might be related to an upgrade of
> libvirt/kvm/qemu at that point of time. But we’re not sure.
...
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

Kernel 5.4.44 (5.4.44-1-MANJARO x64)

BUG: kernel NULL pointer dereference, address: 0000000000000010
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 3 PID: 1405 Comm: vhost-1399 Not tainted 5.4.44-1-MANJARO #1
Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
RIP: 0010:__cgroup_bpf_run_filter_skb+0xd9/0x230
Code: 00 48 01 c8 48 89 43 50 41 83 ff 01 0f 84 c2 00 00 00 e8 da a4 ed ff e8 c5 ce f2 ff 44 89 fa 48 8d 84 d5 30 06 00 00 48 8b 00 <48> 8b 78 10 4c 8d 78 10 48 85 ff 0f 84 29 01 00 00 bd 01 00 00 00
RSP: 0018:ffffbc1780b077f8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffffa32ce1bed600 RCX: 0000000000000034
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffa32cf1e22000 R08: 0000000000000000 R09: 0000000000000001
R10: 000000000000dc02 R11: ffffa32cfa1100a0 R12: 0000000000000014
R13: 0000000000000014 R14: ffffa32be074f662 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffa32d0fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 00000003cab56004 CR4: 00000000001626e0
Call Trace:
  sk_filter_trim_cap+0x12f/0x270
  ? tcp_v4_inbound_md5_hash+0x56/0x170
  tcp_v4_rcv+0x9bc/0xc10
  ? arp_process+0x221/0x7e0
  ip_protocol_deliver_rcu+0x2b/0x1e0
  ip_local_deliver_finish+0x55/0x70
  ip_local_deliver+0x115/0x130
  ? ip_protocol_deliver_rcu+0x1e0/0x1e0
  ip_rcv+0x62/0x110
  __netif_receive_skb_one_core+0x87/0xa0
  netif_receive_skb_internal+0x93/0xe0
  netif_receive_skb+0x18/0xd0
  br_pass_frame_up+0xf0/0x1d0 [bridge]
  ? br_port_flags_change+0x70/0x70 [bridge]
  br_handle_frame_finish+0x18a/0x450 [bridge]
  br_handle_frame+0x238/0x380 [bridge]
  ? br_handle_local_finish+0xa0/0xa0 [bridge]
  __netif_receive_skb_core+0x3e7/0xc20
  ? kvm_irq_delivery_to_apic_fast+0x86/0x170 [kvm]
  __netif_receive_skb_one_core+0x3d/0xa0
  netif_receive_skb_internal+0x93/0xe0
  netif_receive_skb+0x18/0xd0
  tun_sendmsg+0x3a7/0x5d0 [tun]
  vhost_tx_batch.constprop.0+0x65/0xf0 [vhost_net]
  handle_tx_copy+0x187/0x5b0 [vhost_net]
  handle_tx+0xa5/0xe0 [vhost_net]
  vhost_worker+0xb9/0x130 [vhost]
  ? vhost_new_umem_range+0x1b0/0x1b0 [vhost]
  kthread+0x117/0x130
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x35/0x40
Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter fuse netconsole bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat joydev mousedev input_leds intel_rapl_msr ofpart eeepc_wmi intel_rapl_common asus_wmi cmdlinepart x86_pkg_temp_thermal intel_powerclamp intel_spi_platform intel_spi mei_hdcp coretemp mei_wdt kvm_intel spi_nor kvm mtd iTCO_wdt iTCO_vendor_support snd_hda_codec_hdmi wmi_bmof irqbypass battery sparse_keymap rfkill crct10dif_pclmul crc32_pclmul ghash_clmulni_intel i915 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_nhlt snd_hda_codec aesni_intel snd_hda_core crypto_simd cryptd glue_helper intel_cstate i2c_algo_bit intel_uncore intel_rapl_perf pcspkr i2c_i801 snd_hwdep drm_kms_helper snd_pcm r8169 mei_me snd_timer intel_gtt syscopyarea realtek e1000e mei libphy lpc_ich snd sysfillrect sysimgblt soundcore fb_sys_fops wmi evdev mac_hid nfsd
  nfs_acl lockd auth_rpcgss grace drm sunrpc agpgart ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_logitech_dj hid_generic usbhid hid dm_mod sr_mod cdrom sd_mod ahci libahci libata crc32c_intel scsi_mod xhci_pci ehci_pci xhci_hcd ehci_hcd
CR2: 0000000000000010
---[ end trace ad97e7cc46d7ce69 ]---
RIP: 0010:__cgroup_bpf_run_filter_skb+0xd9/0x230
Code: 00 48 01 c8 48 89 43 50 41 83 ff 01 0f 84 c2 00 00 00 e8 da a4 ed ff e8 c5 ce f2 ff 44 89 fa 48 8d 84 d5 30 06 00 00 48 8b 00 <48> 8b 78 10 4c 8d 78 10 48 85 ff 0f 84 29 01 00 00 bd 01 00 00 00
RSP: 0018:ffffbc1780b077f8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffffa32ce1bed600 RCX: 0000000000000034
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffa32cf1e22000 R08: 0000000000000000 R09: 0000000000000001
R10: 000000000000dc02 R11: ffffa32cfa1100a0 R12: 0000000000000014
R13: 0000000000000014 R14: ffffa32be074f662 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffa32d0fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 00000003cab56004 CR4: 00000000001626e0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x27400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

