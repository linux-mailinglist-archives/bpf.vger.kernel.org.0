Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E4B5E6CED
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiIVUTW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiIVUTO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 16:19:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215A7110B2F;
        Thu, 22 Sep 2022 13:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A96ACB80D3A;
        Thu, 22 Sep 2022 20:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DA0C433D6;
        Thu, 22 Sep 2022 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663877950;
        bh=S1K7C25yLEOnIGEyi9bQtPFbKSPJ0EOaQQwxblra/SI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rUI+qlHiB6DubkBJaFFHPlgm/El22Ud+jzBdwQDamBuyLsQuSeBAzCNfSttOZzNIX
         /eakO0FaiJDN+ND3jATB5jwpLTRw9xjewanXadFLUJX9tC7MExa2p9fK4aaXAMv/Vo
         RagAJP4fhdp930+VsaypRG7wH+8FHAejm32MG8DSyW0PJ9y0p87txyw8C3gvhr1bu6
         pJ4NVzt53kSa/HS5N3GvGnYED5O5dzhu9edchcg9MAcGUtMPCXxF4M1hKh66ILw5RQ
         d9/Gdt2tfy2IFdBzPs5euWu8qxK0l1QhB9o08Sy+7XNIsRv/Z3Rtv7I0HaDxbAjR+x
         Qlc9dUNGJ9P+g==
Received: by mail-ej1-f54.google.com with SMTP id sb3so23531159ejb.9;
        Thu, 22 Sep 2022 13:19:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf0R0z0qsnaVNhkP70NppI2ctQxpOUoOQVfGzLAtwf8IXNN+VJJF
        DFf2OGAhdRyIK40qw55wHz9lkOX87Nap+X53kZg=
X-Google-Smtp-Source: AMsMyM4WpEGQuFtwK7W9Js2rxz7XA9W2dHzy+IOaT8Z2/M5EeuJVwM1EV8IDt1FmQB6YIVTfv2OCJ/YobBIryubQkDk=
X-Received: by 2002:a17:906:974d:b0:780:2c07:7617 with SMTP id
 o13-20020a170906974d00b007802c077617mr4263119ejy.707.1663877948486; Thu, 22
 Sep 2022 13:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org>
In-Reply-To: <c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 22 Sep 2022 13:18:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7+CQV69KhmqfSyB5Gme7wRJSHBozDxhtBM=ggPM=5o2A@mail.gmail.com>
Message-ID: <CAPhsuW7+CQV69KhmqfSyB5Gme7wRJSHBozDxhtBM=ggPM=5o2A@mail.gmail.com>
Subject: Re: CPA refuse W^X violation in linux-next kernel
To:     Jeff Layton <jlayton@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jeff,

On Thu, Sep 22, 2022 at 5:19 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> (sorry for the resend, but I missed the subject line and I wanted to
> make sure this was seen)
>
> Got a reproducible panic at boot today with a linux-next kernel. I have
> some patches on top linux-next, but nothing that should affect things at this
> level. The host is a QEMU/KVM VM running Fedora 36. Kconfig is attached:

Thanks for the report! I am able to reproduce the issue.

I am working on a fix. I will try to send v1 of the fix by EOD tomorrow.

Song

>
> [    2.353769] systemd[1]: Hostname set to <iversion>.
> [    2.413012] ------------[ cut here ]------------
> [    2.413761] CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: 0xffffffffc04ff000 - 0xffffffffc04fffff PFN 108686
> [    2.415382] WARNING: CPU: 2 PID: 1 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0x100b/0x1050
> [    2.416838] Modules linked in:
> [    2.417349] CPU: 2 PID: 1 Comm: systemd Not tainted 6.0.0-rc6-next-20220921+ #26
> [    2.418430] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
> [    2.419671] RIP: 0010:__change_page_attr_set_clr+0x100b/0x1050
> [    2.420503] Code: 8b 44 24 20 48 89 f2 4d 89 f1 48 89 ee 48 c7 c7 f8 14 3a b1 c6 05 ed 22 c1 01 01 4c 8d 80 ff 0f 00 00 48 89 c1 e8 65 1f a8 00 <0f> 0b e9 f6 fc ff ff 80 3d d1 22 c1 01 00 0f 85 6e f8 ff ff 48 89
> [    2.422998] RSP: 0018:ffffb94ec0013b20 EFLAGS: 00010282
> [    2.423762] RAX: 0000000000000078 RBX: 0000000108686163 RCX: 0000000000000000
> [    2.424745] RDX: 0000000000000002 RSI: 00000000ffffdfff RDI: 00000000ffffffff
> [    2.425729] RBP: 8000000000000163 R08: 0000000000000000 R09: ffffb94ec00139d8
> [    2.426731] R10: 0000000000000003 R11: ffffffffb1b45448 R12: 8000000108686163
> [    2.427731] R13: 0000000000000000 R14: 0000000000108686 R15: 8000000000000000
> [    2.428730] FS:  00007f85928f0b40(0000) GS:ffff968f37c80000(0000) knlGS:0000000000000000
> [    2.431729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.432555] CR2: 00007f85923ed000 CR3: 000000010095e000 CR4: 00000000003506e0
> [    2.433572] Call Trace:
> [    2.434060]  <TASK>
> [    2.434461]  ? __purge_vmap_area_lazy+0x34e/0x700
> [    2.435177]  ? _vm_unmap_aliases.part.0+0xff/0x130
> [    2.435907]  change_page_attr_set_clr+0x10f/0x190
> [    2.436625]  set_memory_x+0x37/0x50
> [    2.437190]  bpf_trampoline_update+0x23c/0x5b0
> [    2.437866]  __bpf_trampoline_link_prog+0xd0/0x1b0
> [    2.438594]  bpf_trampoline_link_prog+0x26/0x40
> [    2.439312]  bpf_tracing_prog_attach+0x31e/0x4b0
> [    2.440017]  __sys_bpf+0x171/0x2c20
> [    2.440577]  ? ttwu_queue_wakelist+0xbf/0x110
> [    2.441246]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [    2.441990]  ? try_to_wake_up+0x83/0x570
> [    2.442677]  ? insert_work+0x46/0xc0
> [    2.443579]  ? _raw_spin_unlock+0x15/0x30
> [    2.444455]  __x64_sys_bpf+0x1a/0x30
> [    2.445041]  do_syscall_64+0x3a/0x90
> [    2.447104]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [    2.447842] RIP: 0033:0x7f859340ef3d
> [    2.448411] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 ce 0e 00 f7 d8 64 89 01 48
> [    2.451106] RSP: 002b:00007ffe34d26688 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> [    2.452405] RAX: ffffffffffffffda RBX: 0000556f6d038600 RCX: 00007f859340ef3d
> [    2.453567] RDX: 0000000000000090 RSI: 00007ffe34d26690 RDI: 0000000000000011
> [    2.454560] RBP: 000000000000000e R08: 00007ffe34d2659c R09: 0000000000000000
> [    2.455549] R10: 0000000000000000 R11: 0000000000000246 R12: 0000556f6d03c4b0
> [    2.456539] R13: 00007ffe34d26840 R14: 0000556f6c5f2e8f R15: 0000556f6c5d407b
> [    2.457528]  </TASK>
> [    2.457935] ---[ end trace 0000000000000000 ]---
> [    2.718704] systemd[1]: LSM BPF program attached
> [    2.719654] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [    2.722000] BUG: unable to handle page fault for address: ffffffffc0501000
> [    2.724425] #PF: supervisor instruction fetch in kernel mode
> [    2.726420] #PF: error_code(0x0011) - permissions violation
> [    2.728392] PGD 7a15067 P4D 7a15067 PUD 7a17067 PMD 100c40067 PTE 80000001086ae163
> [    2.731936] Oops: 0011 [#1] PREEMPT SMP NOPTI
> [    2.733243] CPU: 2 PID: 1 Comm: systemd Tainted: G        W          6.0.0-rc6-next-20220921+ #26
> [    2.736361] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
> [    2.739401] RIP: 0010:bpf_trampoline_6442483261_0+0x0/0x1000
> [    2.741421] Code: Unable to access opcode bytes at RIP 0xffffffffc0500fd6.
> [    2.743635] RSP: 0018:ffffb94ec0013cd8 EFLAGS: 00010282
> [    2.745434] RAX: ffffffffb0291390 RBX: ffffffffb14ba010 RCX: ffff968dc0218f78
> [    2.747998] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff968dc0960f00
> [    2.750765] RBP: ffff968dc0960f00 R08: ffffffffb26670c0 R09: 0000000000000000
> [    2.753079] R10: 0000000000000007 R11: 0000000000000000 R12: ffffb94ec0013eec
> [    2.755455] R13: 0000000000000000 R14: ffff968dc0960f10 R15: ffff968dc0960f00
> [    2.758095] FS:  00007f85928f0b40(0000) GS:ffff968f37c80000(0000) knlGS:0000000000000000
> [    2.761972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.763221] CR2: ffffffffc0500fd6 CR3: 000000010095e000 CR4: 00000000003506e0
> [    2.764564] Call Trace:
> [    2.765146]  <TASK>
> [    2.765664]  ? bpf_lsm_file_open+0x5/0x10
> [    2.766513]  ? security_file_open+0x2c/0x50
> [    2.767451]  ? do_dentry_open+0xf8/0x410
> [    2.768183]  ? path_openat+0xc43/0x1360
> [    2.768889]  ? __cgroup_account_cputime+0x4c/0x70
> [    2.769723]  ? do_filp_open+0xa1/0x130
> [    2.770452]  ? __check_object_size+0x1e6/0x200
> [    2.771287]  ? _raw_spin_unlock+0x15/0x30
> [    2.772064]  ? do_sys_openat2+0x7c/0x130
> [    2.772782]  ? __x64_sys_openat+0x5c/0x80
> [    2.773537]  ? do_syscall_64+0x3a/0x90
> [    2.774251]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [    2.775193]  </TASK>
> [    2.775668] Modules linked in:
> [    2.776288] CR2: ffffffffc0501000
> [    2.776924] ---[ end trace 0000000000000000 ]---
> [    2.777750] RIP: 0010:bpf_trampoline_6442483261_0+0x0/0x1000
> [    2.778748] Code: Unable to access opcode bytes at RIP 0xffffffffc0500fd6.
> [    2.779889] RSP: 0018:ffffb94ec0013cd8 EFLAGS: 00010282
> [    2.780807] RAX: ffffffffb0291390 RBX: ffffffffb14ba010 RCX: ffff968dc0218f78
> [    2.782093] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff968dc0960f00
> [    2.783321] RBP: ffff968dc0960f00 R08: ffffffffb26670c0 R09: 0000000000000000
> [    2.784537] R10: 0000000000000007 R11: 0000000000000000 R12: ffffb94ec0013eec
> [    2.785731] R13: 0000000000000000 R14: ffff968dc0960f10 R15: ffff968dc0960f00
> [    2.786762] FS:  00007f85928f0b40(0000) GS:ffff968f37c80000(0000) knlGS:0000000000000000
> [    2.787918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.788744] CR2: ffffffffc0500fd6 CR3: 000000010095e000 CR4: 00000000003506e0
> [    2.789843] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> [    2.792032] Kernel Offset: 0x2f000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    2.793568] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
>
>
> --
> Jeff Layton <jlayton@kernel.org>
