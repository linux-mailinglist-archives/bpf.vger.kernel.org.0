Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52766692261
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 16:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjBJPhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 10:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBJPhm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 10:37:42 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938273757E
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 07:37:39 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id v189so2820471vkf.6
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 07:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8hGVfsICqsIqYE96XJlOAJ0ZkmVIg/be4zwdKODYFc=;
        b=ZLEzF1dccUTFrjfXSnK63mc94+MwwXovd1AQfL2Ipzpge+POeU6AvWz2zYVOOmzwDK
         GmYbgRy61g37u2D4nGakMy4zYShAq/5KB9KnBwrmFaie2i5w7oeLNl2PAWgwYMwE9Lk3
         LgbOvX/p+19zKMuiPLIdokX7531W8g1uhe7eA4Zhtdg+Tq/B+aZ7vMfvAJXxcLEQFT0d
         igvWG5FOPKSB8Ltuc8XGn9HMW5TM4wgKOJGJu1KbrDIIQTJd/kgSo73z8ysk1KNp/irW
         KPuCT7Mrt7h/ZGZfJdV1q/5gNKlEX8wZCwH922Uy2M9+6e2XiANYzJWBRpDRLAoLO8v/
         oJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8hGVfsICqsIqYE96XJlOAJ0ZkmVIg/be4zwdKODYFc=;
        b=crJ/1y8nfS/mf+TN3iwAFb58CNqgNoP0tE0axv7UIkfW3TnZg6c6LBO8C5M+vU4wJy
         jMUaxPH4R2Kq5b1ZaAxnX3mryJ6jXogrdQ69E9t5G19l3KimdOi8U99eBj3HcWI6CYtV
         ZqH2wpBmF8hkMYeUw2Q6jPsYrPBeNOvH6I8R5x4FlpfQ4Wk/Dsx/avsi653BVFCEFFnn
         WJKnlWZyHuAl6NiCfbDXJueEVm5Ycyo9lQYlH2WrAwwBCmO/Mc3ABw+t9KyZOgyrPN5X
         h/Pz59eU/Mwxo3YWyXTlFzfED3qJTu9IOGWiqziMhzxAit+cPIqTtp4xPgFtzhMB40iJ
         USEw==
X-Gm-Message-State: AO0yUKUvpS7c/VT4o9Iv/oDDJaQUWl4koD9qXPppeSglFWstrAbQSD/A
        Jz2mnzWqBBiNqt3wwbz3cqckUHyJG5HtBDxzUBc=
X-Google-Smtp-Source: AK7set8aKK8+VJAM6CDhlDxIOAxeBGtGDE1ZSUaj9nK/GG1N4PmOsbwLVh0dW6ISqPYmfuDjrR4zS2I0W+P+jyoYg5E=
X-Received: by 2002:a1f:90d5:0:b0:401:14db:fa58 with SMTP id
 s204-20020a1f90d5000000b0040114dbfa58mr876635vkd.5.1676043458493; Fri, 10 Feb
 2023 07:37:38 -0800 (PST)
MIME-Version: 1.0
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava> <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
 <bb569967-d33a-7252-964b-a36501b3366a@gmail.com> <Y9RlpyV5JPz/hk1K@krava>
 <883a3b03-a596-8279-1278-bc622114aab5@gmail.com> <Y9kxUzyfpEQpnN7w@krava>
 <d880b3b3-d6fb-c891-bfc2-9c05c321ddac@gmail.com> <0474fbe7-14a3-71bc-02ed-73ad44b4b2a2@oracle.com>
 <949c176c-2788-3959-34b1-90e1f6fe03d1@gmail.com> <Y+ZWAesOAY5wjG6i@krava>
In-Reply-To: <Y+ZWAesOAY5wjG6i@krava>
From:   Alexandre Ferreira <alexandref75@gmail.com>
Date:   Fri, 10 Feb 2023 09:37:27 -0600
Message-ID: <CAMHq1ZuhecqT-YX8+yzUyhx8tmnQ7CDyuXV4GOuG=z44XTFsaw@mail.gmail.com>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri,

On Fri, Feb 10, 2023 at 8:34 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Feb 10, 2023 at 08:02:23AM -0600, Alexandre Peixoto Ferreira wrot=
e:
> > Alam,
> >
> > On 2/9/23 07:07, Alan Maguire wrote:
> > > On 09/02/2023 04:15, Alexandre Peixoto Ferreira wrote:
> > > > Jiri,
> > > >
> > > > On 1/31/23 09:18, Jiri Olsa wrote:
> > > > > On Sat, Jan 28, 2023 at 01:23:25PM -0600, Alexandre Peixoto Ferre=
ira wrote:
> > > > > > Jirka and Daniel,
> > > > > >
> > > > > > On 1/27/23 18:00, Jiri Olsa wrote:
> > > > > > > On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto F=
erreira wrote:
> > > > > > > > On 1/24/23 00:13, Daniel Xu wrote:
> > > > > > > > > Hi Jiri,
> > > > > > > > >
> > > > > > > > > On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
> > > > > > > > > > On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wro=
te:
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > I'm getting the following error during build:
> > > > > > > > > > >
> > > > > > > > > > >             $ ./tools/testing/selftests/bpf/vmtest.sh=
 -j30
> > > > > > > > > > >             [...]
> > > > > > > > > > >               BTF     .btf.vmlinux.bin.o
> > > > > > > > > > >             btf_encoder__encode: btf__dedup failed!
> > > > > > > > > > >             Failed to encode BTF
> > > > > > > > > > >               LD      .tmp_vmlinux.kallsyms1
> > > > > > > > > > >               NM      .tmp_vmlinux.kallsyms1.syms
> > > > > > > > > > >               KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > > > > > > > >               AS      .tmp_vmlinux.kallsyms1.S
> > > > > > > > > > >               LD      .tmp_vmlinux.kallsyms2
> > > > > > > > > > >               NM      .tmp_vmlinux.kallsyms2.syms
> > > > > > > > > > >               KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > > > > > > > >               AS      .tmp_vmlinux.kallsyms2.S
> > > > > > > > > > >               LD      .tmp_vmlinux.kallsyms3
> > > > > > > > > > >               NM      .tmp_vmlinux.kallsyms3.syms
> > > > > > > > > > >               KSYMS   .tmp_vmlinux.kallsyms3.S
> > > > > > > > > > >               AS      .tmp_vmlinux.kallsyms3.S
> > > > > > > > > > >               LD      vmlinux
> > > > > > > > > > >               BTFIDS  vmlinux
> > > > > > > > > > >             FAILED: load BTF from vmlinux: No such fi=
le or directory
> > > > > > > > > > >             make[1]: *** [scripts/Makefile.vmlinux:35=
: vmlinux] Error 255
> > > > > > > > > > >             make[1]: *** Deleting file 'vmlinux'
> > > > > > > > > > >             make: *** [Makefile:1264: vmlinux] Error =
2
> > > > > > > > > > >
> > > > > > > > > > > This happens on both bpf-next/master (84150795a49) an=
d 6.2-rc5
> > > > > > > > > > > (2241ab53cb).
> > > > > > > > > > >
> > > > > > > > > > > I've also tried arch linux pahole 1:1.24+r29+g02d67c5=
-1 as well as
> > > > > > > > > > > upstream pahole on master (02d67c5176) and upstream p=
ahole on
> > > > > > > > > > > next (2ca56f4c6f659).
> > > > > > > > > > >
> > > > > > > > > > > Of the above 6 combinations, I think I've tried all o=
f them (maybe
> > > > > > > > > > > missing 1 or 2).
> > > > > > > > > > >
> > > > > > > > > > > Looks like GCC got updated recently on my machine, so=
 perhaps
> > > > > > > > > > > it's related?
> > > > > > > > > > >
> > > > > > > > > > >             CONFIG_CC_VERSION_TEXT=3D"gcc (GCC) 12.2.=
1 20230111"
> > > > > > > > > > >
> > > > > > > > > > > I'll try some debugging, but just wanted to report it=
 first.
> > > > > > > > > > hi,
> > > > > > > > > > I can't reproduce that.. can you reproduce it outside v=
mtest.sh?
> > > > > > > > > >
> > > > > > > > > > there will be lot of output with patch below, but could=
 contain
> > > > > > > > > > some more error output
> > > > > > > > > Thanks for the hints. Doing a regular build outside of vm=
test.sh
> > > > > > > > > seems to work ok. So maybe it's a difference in the build=
 config.
> > > > > > > > >
> > > > > > > > > I'll put a little more time into debugging to see if it g=
oes anywhere.
> > > > > > > > > But I'll have to get back to the regularly scheduled prog=
ramming
> > > > > > > > > soon.
> > > > > > > > 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is co=
mmented but fails
> > > > > > > > in pahole when CONFIG_X86_KERNEL_IBT is set.
> > > > > > > could you plese attach your config and the build error?
> > > > > > > I can't reproduce that
> > > > > > >
> > > > > > > thanks,
> > > > > > > jirka
> > > > > > My working .config is available at https://pastebin.pl/view/bef=
3765c
> > > > > > change CONFIG_X86_KERNEL_IBT to y to get the error.
> > > > > >
> > > > > > The error is similar to Daniel's and is shown below:
> > > > > >
> > > > > >     LD      .tmp_vmlinux.btf
> > > > > >     BTF     .btf.vmlinux.bin.o
> > > > > > btf_encoder__encode: btf__dedup failed!
> > > > > > Failed to encode BTF
> > > > > >     LD      .tmp_vmlinux.kallsyms1
> > > > > >     NM      .tmp_vmlinux.kallsyms1.syms
> > > > > >     KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > > >     AS      .tmp_vmlinux.kallsyms1.S
> > > > > >     LD      .tmp_vmlinux.kallsyms2
> > > > > >     NM      .tmp_vmlinux.kallsyms2.syms
> > > > > >     KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > > >     AS      .tmp_vmlinux.kallsyms2.S
> > > > > >     LD      .tmp_vmlinux.kallsyms3
> > > > > >     NM      .tmp_vmlinux.kallsyms3.syms
> > > > > >     KSYMS   .tmp_vmlinux.kallsyms3.S
> > > > > >     AS      .tmp_vmlinux.kallsyms3.S
> > > > > >     LD      vmlinux
> > > > > >     BTFIDS  vmlinux
> > > > > > FAILED: load BTF from vmlinux: No such file or directory
> > > > > > make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
> > > > > > make[1]: *** Deleting file 'vmlinux'
> > > > > > make: *** [Makefile:1264: vmlinux] Error 2
> > > > > I can't reproduce that.. I tried with gcc versions:
> > > > >
> > > > >     gcc (GCC) 13.0.1 20230117 (Red Hat 13.0.1-0)
> > > > >     gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
> > > > >
> > > > > I haven't found fedora setup with 12.2.1 20230111 yet
> > > > >
> > > > > I tried alsa with latest pahole master branch
> > > > >
> > > > > were you guys able to get any more verbose output
> > > > > that I suggested earlier?
> > > > >
> > > > > jirka
> > > > I compiled with and without IBT using the -V on pahole (LLVM_OBJCOP=
Y=3Dobjcopy pahole -V -J --btf_gen_floats -j .tmp_vmlinux.btf) and the outf=
iles are a little too big (540MB). The error happens with this CONST type p=
ointing to itself. That does not happen with the IBT option removed.
> > > >
> > > > $ grep  -n "CONST (anon) type_id" /tmp/with_IBT  | more
> > > > 346:[2] CONST (anon) type_id=3D2
> > > > 349:[5] CONST (anon) type_id=3D5
> > > > 351:[7] CONST (anon) type_id=3D7
> > > > 356:[12] CONST (anon) type_id=3D12
> > > > 363:[19] CONST (anon) type_id=3D19
> > > > 373:[29] CONST (anon) type_id=3D29
> > > > 375:[31] CONST (anon) type_id=3D31
> > > > 409:[63] CONST (anon) type_id=3D63
> > > > 444:[89] CONST (anon) type_id=3D0
> > > > 472:[97] CONST (anon) type_id=3D97
> > > > 616:[129] CONST (anon) type_id=3D129
> > > > 652:[131] CONST (anon) type_id=3D131
> > > > 1319:[234] CONST (anon) type_id=3D234
> > > > 1372:[246] CONST (anon) type_id=3D246
> > > > ....
> > > >
> > > > $diff -ru with_IBT without_IBT
> > > > --- with_IBT 2023-01-31 09:39:24.915912735 -0600
> > > > +++ without_IBT 2023-01-31 09:46:23.456005278 -0600
> > > > @@ -340,346 +340,14800 @@
> > > >   Found per-CPU symbol 'cpu_tlbstate_shared' at address 0x2c040
> > > >   Found per-CPU symbol 'mce_poll_banks' at address 0x1ad20
> > > >   Found 341 per-CPU variables!
> > > > -Found 61470 functions!
> > > > +Found 61462 functions!
> > > > +File .tmp_vmlinux.btf:
> > > > +[1] FUNC_PROTO (anon) return=3D0 args=3D(void)
> > > > +[2] FUNC verify_cpu type_id=3D1
> > > > +[3] FUNC_PROTO (anon) return=3D0 args=3D(void)
> > > > +[4] FUNC sev_verify_cbit type_id=3D3
> > > > +search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
> > > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > > +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> > > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > > +Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
> > > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > > +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> > > > +Found per-CPU symbol 'last_nmi_rip' at address 0x1a018
> > > > +Found per-CPU symbol 'nmi_stats' at address 0x1a030
> > > > +Found per-CPU symbol 'swallow_nmi' at address 0x1a020
> > > > +Found per-CPU symbol 'nmi_state' at address 0x1a010
> > > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > > +Found per-CPU symbol 'nmi_cr2' at address 0x1a008
> > > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > > +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> > > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > > ...
> > > >
> > > > And the lines 342-365 of the with_IBT result:
> > > >       342 Found 341 per-CPU variables!
> > > >       343 Found 61470 functions!
> > > >       344 File .tmp_vmlinux.btf:
> > > >       345 [1] INT long unsigned int size=3D8 nr_bits=3D64 encoding=
=3D(none)
> > > >       346 [2] CONST (anon) type_id=3D2
> > > >       347 [3] PTR (anon) type_id=3D6
> > > >       348 [4] INT char size=3D1 nr_bits=3D8 encoding=3D(none)
> > > >       349 [5] CONST (anon) type_id=3D5
> > > >       350 [6] INT unsigned int size=3D4 nr_bits=3D32 encoding=3D(no=
ne)
> > > >       351 [7] CONST (anon) type_id=3D7
> > > >       352 [8] TYPEDEF __s8 type_id=3D10
> > > >       353 [9] INT signed char size=3D1 nr_bits=3D8 encoding=3DSIGNE=
D
> > > >       354 [10] TYPEDEF __u8 type_id=3D12
> > > >       355 [11] INT unsigned char size=3D1 nr_bits=3D8 encoding=3D(n=
one)
> > > >       356 [12] CONST (anon) type_id=3D12
> > > >       357 [13] TYPEDEF __s16 type_id=3D15
> > > >       358 [14] INT short int size=3D2 nr_bits=3D16 encoding=3DSIGNE=
D
> > > >       359 [15] TYPEDEF __u16 type_id=3D17
> > > >       360 [16] INT short unsigned int size=3D2 nr_bits=3D16 encodin=
g=3D(none)
> > > >       361 [17] TYPEDEF __s32 type_id=3D19
> > > >       362 [18] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
> > > >       363 [19] CONST (anon) type_id=3D19
> > > >       364 [20] TYPEDEF __u32 type_id=3D7
> > > >       365 [21] TYPEDEF __s64 type_id=3D23
> > > >
> > > > lines 342-362 of without_IBT
> > > >
> > > >       342 Found 341 per-CPU variables!
> > > >       343 Found 61462 functions!
> > > >       344 File .tmp_vmlinux.btf:
> > > >       345 [1] FUNC_PROTO (anon) return=3D0 args=3D(void)
> > > >       346 [2] FUNC verify_cpu type_id=3D1
> > > >       347 [3] FUNC_PROTO (anon) return=3D0 args=3D(void)
> > > >       348 [4] FUNC sev_verify_cbit type_id=3D3
> > > >       349 search cu 'arch/x86/kernel/head_64.S' for percpu global v=
ariables.
> > > >       350 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x1=
8a08
> > > >       351 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > >       352 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f8=
0
> > > >       353 Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > >       354 Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> > > >       355 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x1=
8a08
> > > >       356 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x1=
8a08
> > > >       357 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > >       358 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > >       359 Found per-CPU symbol 'current_tsc_ratio' at address 0x19f=
a0
> > > >       360 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x1=
8a08
> > > >       361 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x1=
8a08
> > > >       362 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f8=
0
> > > >
> > > > If the full debug files are useful or a target grep or diff is bett=
er let me know.
> > > >
> > > I managed to reproduce this too with IBT enabled; one thing I
> > > noticed is with pahole built with an up-to-date libbpf and the
> > > changes in https://github.com/acmel/dwarves/tree/next, the problem
> > > went away. I didn't have time to root-cause it yet however.
> > >
> > > Not sure if you're in a position to do this, but if you can,
> > > would you mind building pahole from
> > >
> > > https://github.com/acmel/dwarves/tree/next
> > >
> > > ...and re-testing to see if that helps? Thanks!
> > >
> > > Alan
> > > > Thanks,
> > > >
> > I tried with libbpf compiled from master
> > https://github.com/libbpf/libbpf.git and pahole compiled from next bran=
ch on
> > https://github.com/acmel/dwarve with the same result.
> > With IBT enabled pahole fails and removing it results in a successful
> > kernel.
>
> hi,
> in case it slipped, you also need to add new options for pahole:
>   https://lore.kernel.org/bpf/1675949331-27935-1-git-send-email-alan.magu=
ire@oracle.com/
>
> should be added for version 124 for now
>
> jirka


Added the patch to include options on pahole but same problem.
$ pahole --version
v1.25
$ ls -l /usr/lib64/libbpf.so.1.2.0
-rwxr-xr-x 1 root root 422088 Feb  9 13:23 /usr/lib64/libbpf.so.1.2.0

  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_gen_floats -j
--skip_encoding_btf_inconsistent_proto --btf_gen_optimized
.tmp_vmlinux.btf
btf_encoder__encode: btf__dedup failed!
Failed to encode BTF

Thanks,
