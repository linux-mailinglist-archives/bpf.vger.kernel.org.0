Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9098F210424
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgGAGqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgGAGqO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 02:46:14 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A573C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 23:46:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so12311359edb.13
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mbtyM9C6tIaeDH6188xMQVtPI/2NAU5SP6lAavmLutg=;
        b=ceuQgeRxepXXjHFShtmxKo2sKjqlxOXxjz8uVScA3XOCN7dWeWuwMkvyw/WptQ8O/1
         SkuOyYcw3YJEQHB1tPrnxfx+wq60/sZKwf2msZ8OKxNiRS5zNL79Hit5VGyCluHTWHjL
         LJhObqhaHRtkVFAF4OtFHJWnqurD8oKXGaFV/S7bx6kM2SRxr4Qk/fETnY9gylTeuM0v
         Fplpz8ePm3WnM9QbMKl3jFyYWQj+aGl4aTo2e1ZNNHYXheNE5MBNCwxhAKsldc1rrGTa
         CWabIUIRAObhfKrF9ZmxUVm4gA9aYedcZc8h7Kzgk5y3GhNQqh2QQ+zXTY6Z/doOAPUs
         900Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mbtyM9C6tIaeDH6188xMQVtPI/2NAU5SP6lAavmLutg=;
        b=rYSJg+stk/ynKUA2SDbcNUlNr8VnLO3X2BHbwtq26NicYHqDbUV3ZfAW81JgpKJc8L
         b9OCqVSYOxib5oG9Z3ISqNwvxFLNwYNnTnEHss4XG0DQyBveQJkbcoINrm4+NHDgg69q
         zGTmCzR91gkAS3T+Qri/C4u7plB03eHq2RUflDxHQEevOqtDdalAZJkUN7GGUVNlu9sT
         hSdTXDzC1m9CbmKKGekY2u138t03ZuO+xnilrBdzraoISz8neALLcx0EaZS1vVqxzG3E
         rmneKZJNcKeu7EqFbIr3v+Vr/eOoDFf5Xcfh6mjd96D534WvZBAj4B2swqC+mmDqXm+V
         /+TQ==
X-Gm-Message-State: AOAM532qSRe5h6HOdnd06SXIbjQvDDhxBiz5M8f1YRHPCX3G8OwFcmsS
        umtLFSsweQdU0aWpVQY9PM0n+nlNfA==
X-Google-Smtp-Source: ABdhPJwrTQ8GhqyRRMkWXwrBtHEcHOgWMBpEKQhT9jsuAZPPwvqeU1lpPU3mIjDxDen+LAGfn4ivsA==
X-Received: by 2002:aa7:db06:: with SMTP id t6mr22859774eds.369.1593585972723;
        Tue, 30 Jun 2020 23:46:12 -0700 (PDT)
Received: from [192.168.254.199] (x4d0c3c5b.dyn.telefonica.de. [77.12.60.91])
        by smtp.gmail.com with ESMTPSA id j16sm3752825ejn.77.2020.06.30.23.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:46:12 -0700 (PDT)
Subject: Re: BUG: kernel NULL pointer dereference in
 __cgroup_bpf_run_filter_skb
From:   Thomas Reim <reimth@gmail.com>
To:     bpf@vger.kernel.org
References: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
Cc:     reimth@gmail.com
Message-ID: <14498254-3673-bda9-a163-4b6db4999cbd@gmail.com>
Date:   Wed, 1 Jul 2020 08:46:11 +0200
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
>
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
>
Linux Kernel 5.6.16 (5.6.16-1-MANJARO x64)

BUG: kernel NULL pointer dereference, address: 0000000000000010
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 2 PID: 988 Comm: nfsd Not tainted 5.6.16-1-MANJARO #1
Hardware name: ASUS All Series/CS-B, BIOS 3602 03/26/2018
RIP: 0010:__cgroup_bpf_run_filter_skb+0x196/0x230
Code: 48 89 73 18 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 31 c0 c3 c3 e8 38 ef ec ff e8 f3 2d f2 ff 48 8b 85 38 06 00 00 31 ed <48> 8b 78 10 4c 8d 70 10 48 85 ff 74 34 49 8b 46 08 65 48 89 05 d1
RSP: 0018:ffffa3e54097f9f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff962908bb82e0 RCX: 0000000000000034
RDX: 0000000000000000 RSI: ffff962907408900 RDI: ffffffffa2df2178
RBP: 0000000000000000 R08: ffff96290981ed20 R09: 000000000000fa4c
R10: 0000000000007d26 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff96290ff00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 00000003e185e005 CR4: 00000000001626e0
Call Trace:
  ? __local_bh_enable_ip+0x33/0x70
  ip_finish_output+0x68/0xa0
  ip_output+0x76/0x130
  ? __ip_local_out+0x4b/0x170
  __ip_queue_xmit+0x186/0x440
  ? __switch_to_asm+0x34/0x70
  ? __switch_to_asm+0x40/0x70
  __tcp_transmit_skb+0x53e/0xbf0
  ? __switch_to_asm+0x34/0x70
  tcp_write_xmit+0x391/0x11b0
  __tcp_push_pending_frames+0x32/0xf0
  do_tcp_sendpages+0x5f8/0x630
  tcp_sendpage+0x48/0x80
  inet_sendpage+0x52/0x90
  kernel_sendpage+0x1a/0x30
  svc_send_common+0x62/0x150 [sunrpc]
  svc_sendto+0xd7/0x240 [sunrpc]
  svc_tcp_sendto+0x36/0x50 [sunrpc]
  svc_send+0x7b/0x190 [sunrpc]
  nfsd+0xed/0x150 [nfsd]
  ? nfsd_destroy+0x60/0x60 [nfsd]
  kthread+0x117/0x130
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x35/0x40
Modules linked in: rpcsec_gss_krb5 vhost_net vhost tap tun fuse bridge stp llc nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat joydev mousedev input_leds intel_rapl_msr ofpart cmdlinepart intel_spi_platform intel_spi mei_wdt mei_hdcp spi_nor mtd iTCO_wdt iTCO_vendor_support eeepc_wmi asus_wmi battery sparse_keymap rfkill wmi_bmof intel_rapl_common snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm i915 irqbypass crct10dif_pclmul snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio crc32_pclmul snd_hda_intel i2c_algo_bit ghash_clmulni_intel snd_intel_dspcfg aesni_intel crypto_simd snd_hda_codec drm_kms_helper cryptd glue_helper intel_cstate pcspkr i2c_i801 intel_uncore snd_hda_core intel_rapl_perf snd_hwdep cec snd_pcm r8169 rc_core realtek intel_gtt snd_timer syscopyarea mei_me libphy lpc_ich snd mei e1000e sysfillrect soundcore sysimgblt fb_sys_fops wmi evdev mac_hid nfsd nfsv4 dns_resolver nfs_acl nfs lockd auth_rpcgss grace drm sunrpc
  fscache agpgart ip_tables x_tables ext4 crc16 mbcache jbd2 hid_logitech_hidpp hid_logitech_dj dm_thin_pool dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio hid_generic usbhid hid dm_mod crc32c_intel sr_mod xhci_pci cdrom xhci_hcd ehci_pci ehci_hcd
CR2: 0000000000000010
---[ end trace 50bcc1a93a161137 ]---
RIP: 0010:__cgroup_bpf_run_filter_skb+0x196/0x230
Code: 48 89 73 18 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 31 c0 c3 c3 e8 38 ef ec ff e8 f3 2d f2 ff 48 8b 85 38 06 00 00 31 ed <48> 8b 78 10 4c 8d 70 10 48 85 ff 74 34 49 8b 46 08 65 48 89 05 d1
RSP: 0018:ffffa3e54097f9f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff962908bb82e0 RCX: 0000000000000034
RDX: 0000000000000000 RSI: ffff962907408900 RDI: ffffffffa2df2178
RBP: 0000000000000000 R08: ffff96290981ed20 R09: 000000000000fa4c
R10: 0000000000007d26 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff96290ff00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 00000003e185e005 CR4: 00000000001626e0
note: nfsd[988] exited with preempt_count 1
-- Reboot --

