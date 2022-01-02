Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C03482CE1
	for <lists+bpf@lfdr.de>; Sun,  2 Jan 2022 23:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiABWHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Jan 2022 17:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbiABWHp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 2 Jan 2022 17:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641161265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=r2CY+YsVpNMyicIxzPkOClAGDZGxtgErjOQ1KAWeYsU=;
        b=VkhwrE/+Uynxr7snFXAMX9kTPtHa3fwIaj4M4qgfbWDzpabbKHTAYkO+Hgjk9ud7ocgrOq
        ZBGb1m/1dog2irRSBgSJnULvzn1ZSeJuP1yYBHGN3yu0v/77VVQ3ZMJxVaJR8bCDm6HGjv
        hp0GKNdspSgMKsOi2zW2SwoRcRUrePQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-fdu5g8oyM9Wp2AHtvlaSJw-1; Sun, 02 Jan 2022 17:07:44 -0500
X-MC-Unique: fdu5g8oyM9Wp2AHtvlaSJw-1
Received: by mail-ed1-f70.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so21683982edd.15
        for <bpf@vger.kernel.org>; Sun, 02 Jan 2022 14:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r2CY+YsVpNMyicIxzPkOClAGDZGxtgErjOQ1KAWeYsU=;
        b=Rjv5zHpEA6V+01ZckDLdkP0PoxL0Vc7bgP96ox9dIx1vQVrLJDWPA1UTdI9h8gqv/c
         cF2R41ZS+R0AujlnZnSQkqLRdZn5saVAwluvgJTBeZSFPfZGwEMPxFK7dfNjwP6mTLv9
         k68CNcKtM65imjeql8kK1t+/JX3DmGLkdURgBc8OIwv0+JlsJ/dr2htkHkLnclv3RcTk
         6BaWPwVYYVzotaAD0t0dW+iWS0gGUviimpDwdAf7KtWaOtIoLKc6pPp2aKSHPyCQ3hom
         5HlL3psEMbuXI125lNd2lV4y5jEnLlfTcMw9Ly4+zUUI0s4vkA1Yj7EITgHFsoqA2o6S
         /tcg==
X-Gm-Message-State: AOAM532HQuR2UJvU928/RIgMJr4GT6H1UDv3+KNEXVmcgSowhEx/RygR
        Z1xSAZbNGi/Vslz/D6JevAL/wuSJCc9h5xRWda5rch/uywueT4Bbv/v1nshJihgJQSJUli6JOxJ
        FNs2I0hzt89wO
X-Received: by 2002:aa7:cf95:: with SMTP id z21mr43594024edx.173.1641161262083;
        Sun, 02 Jan 2022 14:07:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJT3qh+TX11esF3XLOFs56iaE178/hl/psHWJ2W9JE8eRhGnyOycbfo1/hF5+s2ym/kXn7zQ==
X-Received: by 2002:aa7:cf95:: with SMTP id z21mr43594016edx.173.1641161261865;
        Sun, 02 Jan 2022 14:07:41 -0800 (PST)
Received: from krava ([83.240.62.97])
        by smtp.gmail.com with ESMTPSA id o12sm13060832edz.71.2022.01.02.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 14:07:41 -0800 (PST)
Date:   Sun, 2 Jan 2022 23:07:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Yauheni Kaliuta <ykaliuta@redhat.com>, haliu@redhat.com
Subject: [BUG] powerpc: test_progs -t for_each faults kernel
Message-ID: <YdIiK8/krc5x5BmM@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
when running 'test_progs -t for_each' on powerpc we are getting
the fault below

it seems that for some reason the function callback address passed
to bpf_for_each_array_elem is wrong.. I wonder it's the powerpc
function pointers magic ;-)

it's the latest bpf-next/master, I can send .config if needed

thanks,
jirka


---
[  114.362271] kernel tried to execute user page (100000000) - exploit attempt? (uid: 0)
[  114.362284] BUG: Unable to handle kernel instruction fetch
[  114.362288] Faulting instruction address: 0x100000000
[  114.362294] Oops: Kernel access of bad area, sig: 11 [#1]
[  114.362299] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
[  114.362309] Modules linked in: bpf_testmod(OE) bonding tls rfkill pseries_rng ibmveth crct10dif_vpmsum drm fuse i2c_core drm_panel_orientation_quirks zram ip_tables ibmvscsi scsi_transport_srp vmx_crypto crc32c_vpmsum
[  114.362339] CPU: 5 PID: 935 Comm: test_progs Tainted: G           OE     5.16.0-rc7+ #3
[  114.362345] NIP:  0000000100000000 LR: c000000000378a24 CTR: 0000000100000001
[  114.362350] REGS: c000000015ef36e0 TRAP: 0400   Tainted: G           OE      (5.16.0-rc7+)
[  114.362355] MSR:  800000004280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 88008248  XER: 20040000
[  114.362371] CFAR: c000000000378a20 IRQMASK: 0 
               GPR00: c0000000003789bc c000000015ef3980 c000000002890900 c00000000cbb0200 
               GPR04: c000000015ef39ec c00000000cbb0310 c000000015ef3a48 0000000000000000 
               GPR08: 00000001fd9a0000 0000000000000003 0000000000000000 0000000000002000 
               GPR12: 0000000100000001 c00000001ecab080 0000000000000000 0000000000000000 
               GPR16: 0000000000000000 0000000000000000 0000000000000000 c000000017a48400 
               GPR20: 0000000000000001 0000000000000000 c000000015ef3ac0 c000000015ef3b7c 
               GPR24: c000000015ef3b78 c008000002e40000 c008000002e40048 c000000015ef3a48 
               GPR28: c00000000cbb0310 0000000100000001 c00000000cbb0200 0000000000000001 
[  114.362431] NIP [0000000100000000] 0x100000000
[  114.362436] LR [c000000000378a24] bpf_for_each_array_elem+0xc4/0x1c0
[  114.362443] Call Trace:
[  114.362445] [c000000015ef3980] [c0000000003789bc] bpf_for_each_array_elem+0x5c/0x1c0 (unreliable)
[  114.362454] [c000000015ef3a20] [c0080000032267dc] bpf_prog_21bfb2cd0ec79d94_F+0xac/0x98d0
[  114.362461] [c000000015ef3a90] [c000000000f54308] bpf_test_run+0x208/0x420
[  114.362469] [c000000015ef3b50] [c000000000f551b8] bpf_prog_test_run_skb+0x368/0x7a0
[  114.362478] [c000000015ef3bf0] [c00000000034bf40] __sys_bpf+0xc20/0x2e20
[  114.362486] [c000000015ef3d90] [c00000000034e1dc] sys_bpf+0x2c/0x40
[  114.362495] [c000000015ef3db0] [c00000000002d478] system_call_exception+0x188/0x360
[  114.362505] [c000000015ef3e10] [c00000000000bfe8] system_call_vectored_common+0xe8/0x278
[  114.362514] --- interrupt: 3000 at 0x7fff813dc9fc
[  114.362520] NIP:  00007fff813dc9fc LR: 0000000000000000 CTR: 0000000000000000
[  114.362526] REGS: c000000015ef3e80 TRAP: 3000   Tainted: G           OE      (5.16.0-rc7+)
[  114.362532] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002848  XER: 00000000
[  114.362552] IRQMASK: 0 
               GPR00: 0000000000000169 00007fffe3429c10 00007fff814e6f00 000000000000000a 
               GPR04: 00007fffe3429cb8 0000000000000090 0000000000000000 0000000000000008 
               GPR08: 000000000000000a 0000000000000000 0000000000000000 0000000000000000 
               GPR12: 0000000000000000 00007fff8164b7d0 0000000000000000 0000000000000000 
               GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
               GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
               GPR24: 00000000101baa4c 00007fffe342a520 000000001056f5d8 00007fff8163eb68 
               GPR28: 00007fffe342a6a8 00007fffe342a4f8 0000000000000004 00007fffe3429c10 
[  114.362626] NIP [00007fff813dc9fc] 0x7fff813dc9fc
[  114.362631] LR [0000000000000000] 0x0
[  114.362636] --- interrupt: 3000
[  114.362640] Instruction dump:
[  114.362646] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
[  114.362661] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
[  114.362675] ---[ end trace c044e1b381f36402 ]---

