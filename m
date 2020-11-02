Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3052A3247
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 18:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKBRvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 12:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBRvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Nov 2020 12:51:49 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC17EC0617A6
        for <bpf@vger.kernel.org>; Mon,  2 Nov 2020 09:51:48 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id v4so15264803edi.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2020 09:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lYTztL3aVgMivkLAylzSGesmA8tITP5QP3Tu9ZrQyxg=;
        b=QRxZ1ffnwRo1IH4WhZqPMIFFWBzk2fVVyA7ClmKyxYZbNToPddEaOuyUPCE8cz+m6Z
         GJYDrwy63Q0faFS2ux34izDC2w4DwG/Lhv+kia8GruO3sO6HMxQHbIYKbkaQ4meUYYTX
         VVxC9mAOsB0zYMquaX71ddi+5FxS43429eZQGspbb26SbzhZtRQ5xLWNQl9oUd69Land
         fBGfp2NhXTqBN7dxTquphUeFoXdsw89s05FPtlt03YkUjvRQdu3yMezV0dgxJvLHiMDK
         tGjvuwu8fpSw9TaK0rG2G6Jrsyrdu1OXjz2DA8mW7s1E2GSWjssqfNJMsRIAFhxHn1qC
         Dr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lYTztL3aVgMivkLAylzSGesmA8tITP5QP3Tu9ZrQyxg=;
        b=cqOmtIZBMdLBaRveDPwd8Jbb2F1/5RZ/NfJ3vFgI9utT4OpjW3sfzV3dPhnaNzX19A
         WRHn4pgORjvG9iaYmk7oqtYS4eA34xfh9XhDHXSRqqtTwculrWpKSd/KQYke6VXBkxy7
         f/RmWwFFhSA5wDL/7kAk+qTGLoiHALeQvN77pz6c5Gt43hKnhGvJ1ssR7thzjsIMXOOZ
         cmT9PSU2Rb9fIbaHDVXydeILvczlpgeUkiY0LDPVo4GV/GfKr4neH1RLIEnQkErAKPmO
         E56hLlkxAF+TIyJ+ykQFQB1nKl9pBj1xPQ+Pr0OmV1PYzu8Jom9WjyGalJh9r6hPL2Vk
         3CQQ==
X-Gm-Message-State: AOAM532+wE6aMI69dumdbJuyeRCSr36xNujSJQKHgvgltMvf35QWRlp0
        esajvwI1OeyAa/yDbYisM0lzzshnVLs6rtfBRSj7SQ==
X-Google-Smtp-Source: ABdhPJwGcoZIxKwxhqfPaNYb3h3O1u27X6V+gs+rOmpHuRu8xPffab+4y9QnbhjAnIc7bXUV8mtiaqiWuxtxo9Glmbo=
X-Received: by 2002:aa7:d709:: with SMTP id t9mr2750342edq.305.1604339507291;
 Mon, 02 Nov 2020 09:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20201029125744.GQ31092@shao2-debian> <CAEf4BzZm=PoaivFjC63di-WtCsJZzNUUY-eoDp+wz=MhsnS8_g@mail.gmail.com>
 <CA+khW7i_NSTeXA8tvfuP7uMJNQCebWtHd0xxuHoV_JXek3sx4g@mail.gmail.com>
In-Reply-To: <CA+khW7i_NSTeXA8tvfuP7uMJNQCebWtHd0xxuHoV_JXek3sx4g@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 2 Nov 2020 09:51:35 -0800
Message-ID: <CA+khW7iO+7N=WeM21M7BMf4bbQ=en0gpZ-PNphRW0Pqe6OWHZQ@mail.gmail.com>
Subject: Re: [selftest/bpf] 472547778d: WARNING:at_kernel/bpf/verifier.c:#resolve_pseudo_ldimm64
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

May I ask what's the map that fd 0 is mapped to? IIUC, it looks like
the tests (of tracing programs) access the map of fd 0 and the
verifier complains the map is not preallocated. I think it's faster
just ask here.

Thanks,
Hao

On Thu, Oct 29, 2020 at 1:49 PM Hao Luo <haoluo@google.com> wrote:
>
> Sure, let me take a look at it.
>
> On Thu, Oct 29, 2020 at 1:43 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Hao,
> >
> > This seems to be coming from resolve_pseudo_ldimm64(), could you
> > please take a look? Thanks!
> >
> > -- Andrii
> >
> > On Thu, Oct 29, 2020 at 5:58 AM kernel test robot <lkp@intel.com> wrote=
:
> > >
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-9):
> > >
> > > commit: 472547778de24e2764ab325268dd5b77e6923939 ("selftest/bpf: Fix =
profiler test using CO-RE relocation for enums")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> > >
> > >
> > > in testcase: kernel-selftests
> > > version: kernel-selftests-x86_64-b5a583fb-1_20201015
> > > with following parameters:
> > >
> > >         group: kselftests-bpf
> > >         ucode: 0xd6
> > >
> > > test-description: The kernel contains a set of "self tests" under the=
 tools/testing/selftests/ directory. These are intended to be small unit te=
sts to exercise individual code paths in the kernel.
> > > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > >
> > >
> > > on test machine: 4 threads Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz w=
ith 32G memory
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire =
log/backtrace):
> > >
> > >
> > > +------------------------------------------+------------+------------=
+
> > > |                                          | 435ccfa894 | 472547778d =
|
> > > +------------------------------------------+------------+------------=
+
> > > | boot_successes                           | 10         | 0          =
|
> > > | boot_failures                            | 0          | 10         =
|
> > > | BUG:using__this_cpu_read()in_preemptible | 0          | 10         =
|
> > > +------------------------------------------+------------+------------=
+
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > >
> > > kern  :warn  : [  325.530080] WARNING: CPU: 3 PID: 20214 at kernel/bp=
f/verifier.c:9718 resolve_pseudo_ldimm64+0x6b8/0x8e0
> > > kern  :warn  : [  325.530812] Modules linked in: rpcsec_gss_krb5 auth=
_rpcgss nfsv4 dns_resolver netconsole snd_hda_codec_hdmi snd_hda_codec_real=
tek snd_hda_codec_generic ledtrig_audio btrfs blake2b_generic xor zstd_comp=
ress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common sd_mod t10_pi sg i=
915 btusb wmi_bmof intel_wmi_thunderbolt x86_pkg_temp_thermal intel_powercl=
amp snd_soc_skl snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core snd_soc_ac=
pi_intel_match snd_soc_acpi snd_soc_core snd_compress coretemp crct10dif_pc=
lmul snd_hda_intel crc32_pclmul btrtl crc32c_intel btbcm ghash_clmulni_inte=
l btintel snd_intel_dspcfg snd_hda_codec snd_hda_core iwlwifi aesni_intel c=
rypto_simd ahci snd_hwdep bluetooth snd_pcm libahci cryptd cfg80211 snd_tim=
er glue_helper ir_rc6_decoder pcspkr ecdh_generic libata mei_me snd ecc rc_=
rc6_mce mei soundcore i2c_i801 rfkill i2c_smbus wmi ipmi_devintf ite_cir ip=
mi_msghandler rc_core acpi_pad video intel_pmc_core ip_tables
> > > user  :notice: [  325.533201] # #3/p valid map access into an array w=
ith a constant OK
> > > kern  :warn  : [  325.537207] CPU: 3 PID: 20214 Comm: test_verifier N=
ot tainted 5.9.0-13427-g472547778de2 #1
> > >
> > > kern  :warn  : [  325.538572] Hardware name: Intel Corporation NUC7i7=
BNH/NUC7i7BNB, BIOS BNKBL357.86A.0067.2018.0814.1500 08/14/2018
> > > kern  :warn  : [  325.539414] RIP: 0010:resolve_pseudo_ldimm64+0x6b8/=
0x8e0
> > > kern  :warn  : [  325.539835] Code: ff ff c7 44 24 28 ea ff ff ff e9 =
49 fc ff ff 48 c7 c7 58 a8 5e 82 89 0c 24 48 89 54 24 08 c6 05 21 71 ff 01 =
01 e8 46 38 aa 00 <0f> 0b 8b 0c 24 48 8b 54 24 08 e9 5d fd ff ff 48 c7 c6 d=
8 a7 5e 82
> > > kern  :warn  : [  325.541298] RSP: 0018:ffffc90003b0fc50 EFLAGS: 0001=
0282
> > > kern  :warn  : [  325.541732] RAX: 0000000000000000 RBX: 000000000000=
0004 RCX: 0000000000000000
> > > kern  :warn  : [  325.542274] RDX: 0000000000000001 RSI: ffffffff811d=
234f RDI: ffffffff811d234f
> > > kern  :warn  : [  325.542847] RBP: ffffc90003b0fcb8 R08: 000000000000=
0001 R09: 0000000000000001
> > > kern  :warn  : [  325.543389] R10: 0000000000000001 R11: 000000000000=
0001 R12: ffff888100c3a000
> > > user  :notice: [  325.543850] # #4/u valid map access into an array w=
ith a register OK
> > > kern  :warn  : [  325.543996] R13: ffff8882c025dc00 R14: 000000000000=
0025 R15: ffffc9000108d058
> > >
> > > kern  :warn  : [  325.545045] FS:  00007fd26e745740(0000) GS:ffff8888=
7ed80000(0000) knlGS:0000000000000000
> > > kern  :warn  : [  325.545893] CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
> > > kern  :warn  : [  325.546334] CR2: 000055a9904a3e30 CR3: 00000002c073=
0002 CR4: 00000000003706e0
> > > kern  :warn  : [  325.546900] Call Trace:
> > > kern  :warn  : [  325.547114]  bpf_check+0x907/0x17c0
> > > kern  :warn  : [  325.547396]  ? find_held_lock+0x2b/0x80
> > > kern  :warn  : [  325.547781]  bpf_prog_load+0x48c/0x8c0
> > > kern  :warn  : [  325.548133]  ? find_held_lock+0x2b/0x80
> > > kern  :warn  : [  325.548450]  __do_sys_bpf+0x93e/0x1a60
> > > kern  :warn  : [  325.548791]  do_syscall_64+0x33/0x40
> > > kern  :warn  : [  325.549076]  entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
> > > kern  :warn  : [  325.549468] RIP: 0033:0x7fd26e83df59
> > > kern  :warn  : [  325.549771] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 =
00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c =
8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 6=
4 89 01 48
> > > kern  :warn  : [  325.551230] RSP: 002b:00007ffc55a5fc08 EFLAGS: 0000=
0246 ORIG_RAX: 0000000000000141
> > > user  :notice: [  325.551650] # #4/p valid map access into an array w=
ith a register OK
> > > kern  :warn  : [  325.551853] RAX: ffffffffffffffda RBX: 000000000000=
0000 RCX: 00007fd26e83df59
> > >
> > > kern  :warn  : [  325.552308] RDX: 0000000000000078 RSI: 00007ffc55a5=
fc30 RDI: 0000000000000005
> > > kern  :warn  : [  325.552309] RBP: 00007ffc55a5fc30 R08: 000000000000=
0004 R09: 0000000000000000
> > > kern  :warn  : [  325.552310] R10: 0000000000000025 R11: 000000000000=
0246 R12: 0000000000000005
> > > kern  :warn  : [  325.552311] R13: 0000000000000000 R14: 00007ffc55a5=
fda0 R15: 00007ffc55a5fda0
> > > kern  :warn  : [  325.552325] CPU: 3 PID: 20214 Comm: test_verifier N=
ot tainted 5.9.0-13427-g472547778de2 #1
> > > user  :notice: [  325.554366] # #5/u valid map access into an array w=
ith a variable OK
> > > kern  :warn  : [  325.554456] Hardware name: Intel Corporation NUC7i7=
BNH/NUC7i7BNB, BIOS BNKBL357.86A.0067.2018.0814.1500 08/14/2018
> > > kern  :warn  : [  325.554457] Call Trace:
> > > kern  :warn  : [  325.554461]  dump_stack+0x8d/0xb5
> > > kern  :warn  : [  325.554464]  ? resolve_pseudo_ldimm64+0x6b8/0x8e0
> > >
> > > kern  :warn  : [  325.555551]  __warn.cold+0x24/0x4b
> > > kern  :warn  : [  325.555554]  ? resolve_pseudo_ldimm64+0x6b8/0x8e0
> > > kern  :warn  : [  325.555558]  report_bug+0xd1/0x100
> > > user  :notice: [  325.557680] # #5/p valid map access into an array w=
ith a variable OK
> > > kern  :warn  : [  325.557869]  ? tick_nohz_tick_stopped+0x12/0x40
> > > kern  :warn  : [  325.557873]  handle_bug+0x3a/0xa0
> > > kern  :warn  : [  325.557876]  exc_invalid_op+0x14/0x80
> > >
> > > kern  :warn  : [  325.558465]  asm_exc_invalid_op+0x12/0x20
> > > kern  :warn  : [  325.560172] RIP: 0010:resolve_pseudo_ldimm64+0x6b8/=
0x8e0
> > > user  :notice: [  325.560516] # #6/u valid map access into an array w=
ith a signed variable OK
> > > kern  :warn  : [  325.560553] Code: ff ff c7 44 24 28 ea ff ff ff e9 =
49 fc ff ff 48 c7 c7 58 a8 5e 82 89 0c 24 48 89 54 24 08 c6 05 21 71 ff 01 =
01 e8 46 38 aa 00 <0f> 0b 8b 0c 24 48 8b 54 24 08 e9 5d fd ff ff 48 c7 c6 d=
8 a7 5e 82
> > > kern  :warn  : [  325.560554] RSP: 0018:ffffc90003b0fc50 EFLAGS: 0001=
0282
> > >
> > >
> > > kern  :warn  : [  325.562354] RAX: 0000000000000000 RBX: 000000000000=
0004 RCX: 0000000000000000
> > > kern  :warn  : [  325.562355] RDX: 0000000000000001 RSI: ffffffff811d=
234f RDI: ffffffff811d234f
> > > kern  :warn  : [  325.562356] RBP: ffffc90003b0fcb8 R08: 000000000000=
0001 R09: 0000000000000001
> > > kern  :warn  : [  325.562357] R10: 0000000000000001 R11: 000000000000=
0001 R12: ffff888100c3a000
> > > kern  :warn  : [  325.562358] R13: ffff8882c025dc00 R14: 000000000000=
0025 R15: ffffc9000108d058
> > > kern  :warn  : [  325.562369]  ? wake_up_klogd+0x4f/0x80
> > > kern  :warn  : [  325.562371]  ? wake_up_klogd+0x4f/0x80
> > > kern  :warn  : [  325.562391]  bpf_check+0x907/0x17c0
> > > user  :notice: [  325.564634] # #6/p valid map access into an array w=
ith a signed variable OK
> > > kern  :warn  : [  325.565045]  ? find_held_lock+0x2b/0x80
> > > kern  :warn  : [  325.565057]  bpf_prog_load+0x48c/0x8c0
> > >
> > > kern  :warn  : [  325.565875]  ? find_held_lock+0x2b/0x80
> > > kern  :warn  : [  325.565889]  __do_sys_bpf+0x93e/0x1a60
> > > kern  :warn  : [  325.565911]  do_syscall_64+0x33/0x40
> > > user  :notice: [  325.567592] # #7/u invalid map access into an array=
 with a constant OK
> > > kern  :warn  : [  325.567640]  entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
> > >
> > > kern  :warn  : [  325.568193] RIP: 0033:0x7fd26e83df59
> > > kern  :warn  : [  325.569659] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 =
00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c =
8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 6=
4 89 01 48
> > > user  :notice: [  325.569825] # #7/p invalid map access into an array=
 with a constant OK
> > > kern  :warn  : [  325.570965] RSP: 002b:00007ffc55a5fc08 EFLAGS: 0000=
0246 ORIG_RAX: 0000000000000141
> > > kern  :warn  : [  325.570967] RAX: ffffffffffffffda RBX: 000000000000=
0000 RCX: 00007fd26e83df59
> > > kern  :warn  : [  325.570968] RDX: 0000000000000078 RSI: 00007ffc55a5=
fc30 RDI: 0000000000000005
> > > kern  :warn  : [  325.570969] RBP: 00007ffc55a5fc30 R08: 000000000000=
0004 R09: 0000000000000000
> > > kern  :warn  : [  325.570970] R10: 0000000000000025 R11: 000000000000=
0246 R12: 0000000000000005
> > > kern  :warn  : [  325.570972] R13: 0000000000000000 R14: 00007ffc55a5=
fda0 R15: 00007ffc55a5fda0
> > >
> > > kern  :warn  : [  325.573227] irq event stamp: 93003
> > > kern  :warn  : [  325.575115] hardirqs last  enabled at (93103): [<ff=
ffffff811d30b3>] console_unlock+0x4d3/0x5c0
> > > user  :notice: [  325.575571] # #8/u invalid map access into an array=
 with a register OK
> > >
> > > kern  :warn  : [  325.575873] hardirqs last disabled at (93130): [<ff=
ffffff81ddfa21>] __schedule+0x6e1/0xaa0
> > > kern  :warn  : [  325.577041] softirqs last  enabled at (93170): [<ff=
ffffff8200034e>] __do_softirq+0x34e/0x49c
> > > kern  :warn  : [  325.577666] softirqs last disabled at (93187): [<ff=
ffffff81e010f2>] asm_call_irq_on_stack+0x12/0x20
> > > kern  :warn  : [  325.578385] ---[ end trace 54e7a2ba0948b528 ]---
> > >
> > >
> > > To reproduce:
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp install job.yaml  # job file is attached in this emai=
l
> > >         bin/lkp run     job.yaml
> > >
> > >
> > >
> > > Thanks,
> > > lkp
> > >
