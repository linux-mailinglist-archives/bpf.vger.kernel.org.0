Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AAC29F66D
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 21:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgJ2UuA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgJ2Ut7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 16:49:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DAC0613D2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 13:49:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k3so5649993ejj.10
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AmYR4wyjPRvkiqjftKHBxo3W2jmK6qfcZokZj5LFZOs=;
        b=QNmP+Uj1oToOlSiK9xX0nmq2mzJsXL6abHZIFTT9AMzKLftSPUTWVc5PoltPmWrs94
         UhqBBi5hy3D2M9TNk1Gq7W39svpE+9Sikbp300iCKh5pq76A37xpWog4GdkZEGOLERxO
         zVu6H+u6uqgjbWZDlsO+LtI8c/CJksoL0+pylUCDEA0DTR2iDFRUS8hdwj368PBCukkL
         4ttBJ86nA+QujVdn62XpwxhrWWzW559RBf9/zcDrFBOjGXqQ+qKClUDyfQHcvzYsNEDd
         ijYkJ+DqTKFx0ZaoAhLnByRQtZOG+LMl+ZrPB7fexxRJpCRuSDmvRmEPYhThLq+2ErX5
         Av/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AmYR4wyjPRvkiqjftKHBxo3W2jmK6qfcZokZj5LFZOs=;
        b=Wo9jD578CEf5rT77dc0jotBnjnSyyu7k5C5SjTTbkDI3ZGtTNeq9bViSZWYux6lrlt
         7uVgXfYrE/v5KmhOAlaH5ppdD4/FB0eBSS5xwyABhjcO/PfZ2novu3xma0Lq7N8jGQji
         IYoXoTPk8srvgSF6bZYQ9BTpB8GlQtqtxMUIu1xpIJa6t4ifwWlfimtUxIopzqextO0y
         4aylmcDorYob4lgrZXoiSSLltuDLGBR0JOHC6Cg6j6Zn5MRV4iyW98mIwHjavmkuCQ0d
         0oh1Navp2uNBUyNvh3IPOAqW0aYrxFV0KdlXxZztH2UarT6YBYfZfZ8k4syzh8IAK/6z
         bfZA==
X-Gm-Message-State: AOAM5308j09mBj4z01+uE0sGc0b2+hQyHO4Cpjkp733Z8g5Th3QsOVtS
        65JZcYoc6VWqrULEUhLOl8iie6kPVXqAqRCzvZi0AQ==
X-Google-Smtp-Source: ABdhPJwOfWtdX7EKIL1ZiBAYC92OEj9ZBmxf/x5lQvJXwNDtoims4KFX+JnPyDYL1ZoRO61tpleYVbgR2cTWfbmXzoE=
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr6200582eju.44.1604004597824;
 Thu, 29 Oct 2020 13:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201029125744.GQ31092@shao2-debian> <CAEf4BzZm=PoaivFjC63di-WtCsJZzNUUY-eoDp+wz=MhsnS8_g@mail.gmail.com>
In-Reply-To: <CAEf4BzZm=PoaivFjC63di-WtCsJZzNUUY-eoDp+wz=MhsnS8_g@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 29 Oct 2020 13:49:46 -0700
Message-ID: <CA+khW7i_NSTeXA8tvfuP7uMJNQCebWtHd0xxuHoV_JXek3sx4g@mail.gmail.com>
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

Sure, let me take a look at it.

On Thu, Oct 29, 2020 at 1:43 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Hao,
>
> This seems to be coming from resolve_pseudo_ldimm64(), could you
> please take a look? Thanks!
>
> -- Andrii
>
> On Thu, Oct 29, 2020 at 5:58 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 472547778de24e2764ab325268dd5b77e6923939 ("selftest/bpf: Fix pr=
ofiler test using CO-RE relocation for enums")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> >
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-b5a583fb-1_20201015
> > with following parameters:
> >
> >         group: kselftests-bpf
> >         ucode: 0xd6
> >
> > test-description: The kernel contains a set of "self tests" under the t=
ools/testing/selftests/ directory. These are intended to be small unit test=
s to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >
> >
> > on test machine: 4 threads Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz wit=
h 32G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >
> >
> > +------------------------------------------+------------+------------+
> > |                                          | 435ccfa894 | 472547778d |
> > +------------------------------------------+------------+------------+
> > | boot_successes                           | 10         | 0          |
> > | boot_failures                            | 0          | 10         |
> > | BUG:using__this_cpu_read()in_preemptible | 0          | 10         |
> > +------------------------------------------+------------+------------+
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > kern  :warn  : [  325.530080] WARNING: CPU: 3 PID: 20214 at kernel/bpf/=
verifier.c:9718 resolve_pseudo_ldimm64+0x6b8/0x8e0
> > kern  :warn  : [  325.530812] Modules linked in: rpcsec_gss_krb5 auth_r=
pcgss nfsv4 dns_resolver netconsole snd_hda_codec_hdmi snd_hda_codec_realte=
k snd_hda_codec_generic ledtrig_audio btrfs blake2b_generic xor zstd_compre=
ss raid6_pq libcrc32c intel_rapl_msr intel_rapl_common sd_mod t10_pi sg i91=
5 btusb wmi_bmof intel_wmi_thunderbolt x86_pkg_temp_thermal intel_powerclam=
p snd_soc_skl snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core snd_soc_acpi=
_intel_match snd_soc_acpi snd_soc_core snd_compress coretemp crct10dif_pclm=
ul snd_hda_intel crc32_pclmul btrtl crc32c_intel btbcm ghash_clmulni_intel =
btintel snd_intel_dspcfg snd_hda_codec snd_hda_core iwlwifi aesni_intel cry=
pto_simd ahci snd_hwdep bluetooth snd_pcm libahci cryptd cfg80211 snd_timer=
 glue_helper ir_rc6_decoder pcspkr ecdh_generic libata mei_me snd ecc rc_rc=
6_mce mei soundcore i2c_i801 rfkill i2c_smbus wmi ipmi_devintf ite_cir ipmi=
_msghandler rc_core acpi_pad video intel_pmc_core ip_tables
> > user  :notice: [  325.533201] # #3/p valid map access into an array wit=
h a constant OK
> > kern  :warn  : [  325.537207] CPU: 3 PID: 20214 Comm: test_verifier Not=
 tainted 5.9.0-13427-g472547778de2 #1
> >
> > kern  :warn  : [  325.538572] Hardware name: Intel Corporation NUC7i7BN=
H/NUC7i7BNB, BIOS BNKBL357.86A.0067.2018.0814.1500 08/14/2018
> > kern  :warn  : [  325.539414] RIP: 0010:resolve_pseudo_ldimm64+0x6b8/0x=
8e0
> > kern  :warn  : [  325.539835] Code: ff ff c7 44 24 28 ea ff ff ff e9 49=
 fc ff ff 48 c7 c7 58 a8 5e 82 89 0c 24 48 89 54 24 08 c6 05 21 71 ff 01 01=
 e8 46 38 aa 00 <0f> 0b 8b 0c 24 48 8b 54 24 08 e9 5d fd ff ff 48 c7 c6 d8 =
a7 5e 82
> > kern  :warn  : [  325.541298] RSP: 0018:ffffc90003b0fc50 EFLAGS: 000102=
82
> > kern  :warn  : [  325.541732] RAX: 0000000000000000 RBX: 00000000000000=
04 RCX: 0000000000000000
> > kern  :warn  : [  325.542274] RDX: 0000000000000001 RSI: ffffffff811d23=
4f RDI: ffffffff811d234f
> > kern  :warn  : [  325.542847] RBP: ffffc90003b0fcb8 R08: 00000000000000=
01 R09: 0000000000000001
> > kern  :warn  : [  325.543389] R10: 0000000000000001 R11: 00000000000000=
01 R12: ffff888100c3a000
> > user  :notice: [  325.543850] # #4/u valid map access into an array wit=
h a register OK
> > kern  :warn  : [  325.543996] R13: ffff8882c025dc00 R14: 00000000000000=
25 R15: ffffc9000108d058
> >
> > kern  :warn  : [  325.545045] FS:  00007fd26e745740(0000) GS:ffff88887e=
d80000(0000) knlGS:0000000000000000
> > kern  :warn  : [  325.545893] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> > kern  :warn  : [  325.546334] CR2: 000055a9904a3e30 CR3: 00000002c07300=
02 CR4: 00000000003706e0
> > kern  :warn  : [  325.546900] Call Trace:
> > kern  :warn  : [  325.547114]  bpf_check+0x907/0x17c0
> > kern  :warn  : [  325.547396]  ? find_held_lock+0x2b/0x80
> > kern  :warn  : [  325.547781]  bpf_prog_load+0x48c/0x8c0
> > kern  :warn  : [  325.548133]  ? find_held_lock+0x2b/0x80
> > kern  :warn  : [  325.548450]  __do_sys_bpf+0x93e/0x1a60
> > kern  :warn  : [  325.548791]  do_syscall_64+0x33/0x40
> > kern  :warn  : [  325.549076]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > kern  :warn  : [  325.549468] RIP: 0033:0x7fd26e83df59
> > kern  :warn  : [  325.549771] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00=
 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b=
 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 =
89 01 48
> > kern  :warn  : [  325.551230] RSP: 002b:00007ffc55a5fc08 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000141
> > user  :notice: [  325.551650] # #4/p valid map access into an array wit=
h a register OK
> > kern  :warn  : [  325.551853] RAX: ffffffffffffffda RBX: 00000000000000=
00 RCX: 00007fd26e83df59
> >
> > kern  :warn  : [  325.552308] RDX: 0000000000000078 RSI: 00007ffc55a5fc=
30 RDI: 0000000000000005
> > kern  :warn  : [  325.552309] RBP: 00007ffc55a5fc30 R08: 00000000000000=
04 R09: 0000000000000000
> > kern  :warn  : [  325.552310] R10: 0000000000000025 R11: 00000000000002=
46 R12: 0000000000000005
> > kern  :warn  : [  325.552311] R13: 0000000000000000 R14: 00007ffc55a5fd=
a0 R15: 00007ffc55a5fda0
> > kern  :warn  : [  325.552325] CPU: 3 PID: 20214 Comm: test_verifier Not=
 tainted 5.9.0-13427-g472547778de2 #1
> > user  :notice: [  325.554366] # #5/u valid map access into an array wit=
h a variable OK
> > kern  :warn  : [  325.554456] Hardware name: Intel Corporation NUC7i7BN=
H/NUC7i7BNB, BIOS BNKBL357.86A.0067.2018.0814.1500 08/14/2018
> > kern  :warn  : [  325.554457] Call Trace:
> > kern  :warn  : [  325.554461]  dump_stack+0x8d/0xb5
> > kern  :warn  : [  325.554464]  ? resolve_pseudo_ldimm64+0x6b8/0x8e0
> >
> > kern  :warn  : [  325.555551]  __warn.cold+0x24/0x4b
> > kern  :warn  : [  325.555554]  ? resolve_pseudo_ldimm64+0x6b8/0x8e0
> > kern  :warn  : [  325.555558]  report_bug+0xd1/0x100
> > user  :notice: [  325.557680] # #5/p valid map access into an array wit=
h a variable OK
> > kern  :warn  : [  325.557869]  ? tick_nohz_tick_stopped+0x12/0x40
> > kern  :warn  : [  325.557873]  handle_bug+0x3a/0xa0
> > kern  :warn  : [  325.557876]  exc_invalid_op+0x14/0x80
> >
> > kern  :warn  : [  325.558465]  asm_exc_invalid_op+0x12/0x20
> > kern  :warn  : [  325.560172] RIP: 0010:resolve_pseudo_ldimm64+0x6b8/0x=
8e0
> > user  :notice: [  325.560516] # #6/u valid map access into an array wit=
h a signed variable OK
> > kern  :warn  : [  325.560553] Code: ff ff c7 44 24 28 ea ff ff ff e9 49=
 fc ff ff 48 c7 c7 58 a8 5e 82 89 0c 24 48 89 54 24 08 c6 05 21 71 ff 01 01=
 e8 46 38 aa 00 <0f> 0b 8b 0c 24 48 8b 54 24 08 e9 5d fd ff ff 48 c7 c6 d8 =
a7 5e 82
> > kern  :warn  : [  325.560554] RSP: 0018:ffffc90003b0fc50 EFLAGS: 000102=
82
> >
> >
> > kern  :warn  : [  325.562354] RAX: 0000000000000000 RBX: 00000000000000=
04 RCX: 0000000000000000
> > kern  :warn  : [  325.562355] RDX: 0000000000000001 RSI: ffffffff811d23=
4f RDI: ffffffff811d234f
> > kern  :warn  : [  325.562356] RBP: ffffc90003b0fcb8 R08: 00000000000000=
01 R09: 0000000000000001
> > kern  :warn  : [  325.562357] R10: 0000000000000001 R11: 00000000000000=
01 R12: ffff888100c3a000
> > kern  :warn  : [  325.562358] R13: ffff8882c025dc00 R14: 00000000000000=
25 R15: ffffc9000108d058
> > kern  :warn  : [  325.562369]  ? wake_up_klogd+0x4f/0x80
> > kern  :warn  : [  325.562371]  ? wake_up_klogd+0x4f/0x80
> > kern  :warn  : [  325.562391]  bpf_check+0x907/0x17c0
> > user  :notice: [  325.564634] # #6/p valid map access into an array wit=
h a signed variable OK
> > kern  :warn  : [  325.565045]  ? find_held_lock+0x2b/0x80
> > kern  :warn  : [  325.565057]  bpf_prog_load+0x48c/0x8c0
> >
> > kern  :warn  : [  325.565875]  ? find_held_lock+0x2b/0x80
> > kern  :warn  : [  325.565889]  __do_sys_bpf+0x93e/0x1a60
> > kern  :warn  : [  325.565911]  do_syscall_64+0x33/0x40
> > user  :notice: [  325.567592] # #7/u invalid map access into an array w=
ith a constant OK
> > kern  :warn  : [  325.567640]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > kern  :warn  : [  325.568193] RIP: 0033:0x7fd26e83df59
> > kern  :warn  : [  325.569659] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00=
 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b=
 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 =
89 01 48
> > user  :notice: [  325.569825] # #7/p invalid map access into an array w=
ith a constant OK
> > kern  :warn  : [  325.570965] RSP: 002b:00007ffc55a5fc08 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000141
> > kern  :warn  : [  325.570967] RAX: ffffffffffffffda RBX: 00000000000000=
00 RCX: 00007fd26e83df59
> > kern  :warn  : [  325.570968] RDX: 0000000000000078 RSI: 00007ffc55a5fc=
30 RDI: 0000000000000005
> > kern  :warn  : [  325.570969] RBP: 00007ffc55a5fc30 R08: 00000000000000=
04 R09: 0000000000000000
> > kern  :warn  : [  325.570970] R10: 0000000000000025 R11: 00000000000002=
46 R12: 0000000000000005
> > kern  :warn  : [  325.570972] R13: 0000000000000000 R14: 00007ffc55a5fd=
a0 R15: 00007ffc55a5fda0
> >
> > kern  :warn  : [  325.573227] irq event stamp: 93003
> > kern  :warn  : [  325.575115] hardirqs last  enabled at (93103): [<ffff=
ffff811d30b3>] console_unlock+0x4d3/0x5c0
> > user  :notice: [  325.575571] # #8/u invalid map access into an array w=
ith a register OK
> >
> > kern  :warn  : [  325.575873] hardirqs last disabled at (93130): [<ffff=
ffff81ddfa21>] __schedule+0x6e1/0xaa0
> > kern  :warn  : [  325.577041] softirqs last  enabled at (93170): [<ffff=
ffff8200034e>] __do_softirq+0x34e/0x49c
> > kern  :warn  : [  325.577666] softirqs last disabled at (93187): [<ffff=
ffff81e010f2>] asm_call_irq_on_stack+0x12/0x20
> > kern  :warn  : [  325.578385] ---[ end trace 54e7a2ba0948b528 ]---
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> >
> >
> >
> > Thanks,
> > lkp
> >
