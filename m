Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91046920E3
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 15:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBJOex (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 09:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjBJOew (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 09:34:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92564635A0
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:34:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ba1so5261558wrb.5
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vlt5ubaIg0OE3RbMDqOhnX6FrunjoqsyBs5mKyL60tQ=;
        b=UWb8j6ipGxxPPDTJ3m2hSmXMhEmJQL+YMx4m1oK00dxEYPRIVPx8oAcr0tDR6JtRmi
         DtnBuRRDMXgyItalTsCizKBe//hDj4l68l6x5MoqtH9ZfOkTNAKrXIcvW2XksJKwpAVd
         NHFbj3aVrUkITTUICxarGqX10OXAJyw5S7hUG/L5ZoBTS6RZGDULq8/W+BP2/Mf57WF0
         EmTncnVYrmhXfwoShno0SBkCtx2KV0ZPXtLDOaIl81RX3z95g4Jzfauya9qCqjjbsNqu
         YQ9TOSNH5bzFyLpbsmnS+ZRE80HFMJvFGrKDes5JGf9rmDA00dbr4s9u+4BGsr4YhO0o
         P/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlt5ubaIg0OE3RbMDqOhnX6FrunjoqsyBs5mKyL60tQ=;
        b=OBVhiKkI4Th4WRJcAokNzRvzZcoo3HZ2hRxf81bluBF9tI6pzv0eQRECdrHH18yF7e
         Fk5X1MnrQhaUMQLbC1WgaD7i+gBSAk369nD6fno+H8yhdNuEiTQCJMsWUsIoNLC9ycwH
         M7JodT6IlyE/ZjVY4bfh/754MiZYfQxqFnUgJHLcqJCi9RmeDAJQZtX2f4frTfb3C+Mk
         KjwO87VcZVXDeLZvXm/8jTT0Ylf2wDa8kCpjgLH4Iovtvv1/Bjnq0yeXoHKu5HkVCDdG
         XSKUR8p+FWnJ0S37oClR/J/vpdNRrvY6qu9+7lE7a0vcwu3W1XRVbCkip5c5qG/QnA/b
         vrmQ==
X-Gm-Message-State: AO0yUKWRqI2Rmz4GmOHYasK0nwdiAELL0ghFahM5knnFbHFGsUxt0zjr
        I1khf7i90Q8EzFN9QgArNBM=
X-Google-Smtp-Source: AK7set9fDgKLRD/gE2ZEf6oy5ix2b4htY5QlFgaK6yE0FvauF9wTiKGNfJK5VCk8v4wiO+uWrGttlA==
X-Received: by 2002:adf:ee92:0:b0:2c5:4c0e:3736 with SMTP id b18-20020adfee92000000b002c54c0e3736mr1743843wro.24.1676039688932;
        Fri, 10 Feb 2023 06:34:48 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q14-20020a5d574e000000b002bfb02153d1sm3813387wrw.45.2023.02.10.06.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:34:48 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 10 Feb 2023 15:34:41 +0100
To:     Alexandre Peixoto Ferreira <alexandref75@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Message-ID: <Y+ZWAesOAY5wjG6i@krava>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
 <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
 <bb569967-d33a-7252-964b-a36501b3366a@gmail.com>
 <Y9RlpyV5JPz/hk1K@krava>
 <883a3b03-a596-8279-1278-bc622114aab5@gmail.com>
 <Y9kxUzyfpEQpnN7w@krava>
 <d880b3b3-d6fb-c891-bfc2-9c05c321ddac@gmail.com>
 <0474fbe7-14a3-71bc-02ed-73ad44b4b2a2@oracle.com>
 <949c176c-2788-3959-34b1-90e1f6fe03d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <949c176c-2788-3959-34b1-90e1f6fe03d1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 08:02:23AM -0600, Alexandre Peixoto Ferreira wrote:
> Alam,
> 
> On 2/9/23 07:07, Alan Maguire wrote:
> > On 09/02/2023 04:15, Alexandre Peixoto Ferreira wrote:
> > > Jiri,
> > > 
> > > On 1/31/23 09:18, Jiri Olsa wrote:
> > > > On Sat, Jan 28, 2023 at 01:23:25PM -0600, Alexandre Peixoto Ferreira wrote:
> > > > > Jirka and Daniel,
> > > > > 
> > > > > On 1/27/23 18:00, Jiri Olsa wrote:
> > > > > > On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
> > > > > > > On 1/24/23 00:13, Daniel Xu wrote:
> > > > > > > > Hi Jiri,
> > > > > > > > 
> > > > > > > > On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
> > > > > > > > > On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > 
> > > > > > > > > > I'm getting the following error during build:
> > > > > > > > > > 
> > > > > > > > > >             $ ./tools/testing/selftests/bpf/vmtest.sh -j30
> > > > > > > > > >             [...]
> > > > > > > > > >               BTF     .btf.vmlinux.bin.o
> > > > > > > > > >             btf_encoder__encode: btf__dedup failed!
> > > > > > > > > >             Failed to encode BTF
> > > > > > > > > >               LD      .tmp_vmlinux.kallsyms1
> > > > > > > > > >               NM      .tmp_vmlinux.kallsyms1.syms
> > > > > > > > > >               KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > > > > > > >               AS      .tmp_vmlinux.kallsyms1.S
> > > > > > > > > >               LD      .tmp_vmlinux.kallsyms2
> > > > > > > > > >               NM      .tmp_vmlinux.kallsyms2.syms
> > > > > > > > > >               KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > > > > > > >               AS      .tmp_vmlinux.kallsyms2.S
> > > > > > > > > >               LD      .tmp_vmlinux.kallsyms3
> > > > > > > > > >               NM      .tmp_vmlinux.kallsyms3.syms
> > > > > > > > > >               KSYMS   .tmp_vmlinux.kallsyms3.S
> > > > > > > > > >               AS      .tmp_vmlinux.kallsyms3.S
> > > > > > > > > >               LD      vmlinux
> > > > > > > > > >               BTFIDS  vmlinux
> > > > > > > > > >             FAILED: load BTF from vmlinux: No such file or directory
> > > > > > > > > >             make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
> > > > > > > > > >             make[1]: *** Deleting file 'vmlinux'
> > > > > > > > > >             make: *** [Makefile:1264: vmlinux] Error 2
> > > > > > > > > > 
> > > > > > > > > > This happens on both bpf-next/master (84150795a49) and 6.2-rc5
> > > > > > > > > > (2241ab53cb).
> > > > > > > > > > 
> > > > > > > > > > I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
> > > > > > > > > > upstream pahole on master (02d67c5176) and upstream pahole on
> > > > > > > > > > next (2ca56f4c6f659).
> > > > > > > > > > 
> > > > > > > > > > Of the above 6 combinations, I think I've tried all of them (maybe
> > > > > > > > > > missing 1 or 2).
> > > > > > > > > > 
> > > > > > > > > > Looks like GCC got updated recently on my machine, so perhaps
> > > > > > > > > > it's related?
> > > > > > > > > > 
> > > > > > > > > >             CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
> > > > > > > > > > 
> > > > > > > > > > I'll try some debugging, but just wanted to report it first.
> > > > > > > > > hi,
> > > > > > > > > I can't reproduce that.. can you reproduce it outside vmtest.sh?
> > > > > > > > > 
> > > > > > > > > there will be lot of output with patch below, but could contain
> > > > > > > > > some more error output
> > > > > > > > Thanks for the hints. Doing a regular build outside of vmtest.sh
> > > > > > > > seems to work ok. So maybe it's a difference in the build config.
> > > > > > > > 
> > > > > > > > I'll put a little more time into debugging to see if it goes anywhere.
> > > > > > > > But I'll have to get back to the regularly scheduled programming
> > > > > > > > soon.
> > > > > > > 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
> > > > > > > in pahole when CONFIG_X86_KERNEL_IBT is set.
> > > > > > could you plese attach your config and the build error?
> > > > > > I can't reproduce that
> > > > > > 
> > > > > > thanks,
> > > > > > jirka
> > > > > My working .config is available at https://pastebin.pl/view/bef3765c
> > > > > change CONFIG_X86_KERNEL_IBT to y to get the error.
> > > > > 
> > > > > The error is similar to Daniel's and is shown below:
> > > > > 
> > > > >     LD      .tmp_vmlinux.btf
> > > > >     BTF     .btf.vmlinux.bin.o
> > > > > btf_encoder__encode: btf__dedup failed!
> > > > > Failed to encode BTF
> > > > >     LD      .tmp_vmlinux.kallsyms1
> > > > >     NM      .tmp_vmlinux.kallsyms1.syms
> > > > >     KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > >     AS      .tmp_vmlinux.kallsyms1.S
> > > > >     LD      .tmp_vmlinux.kallsyms2
> > > > >     NM      .tmp_vmlinux.kallsyms2.syms
> > > > >     KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > >     AS      .tmp_vmlinux.kallsyms2.S
> > > > >     LD      .tmp_vmlinux.kallsyms3
> > > > >     NM      .tmp_vmlinux.kallsyms3.syms
> > > > >     KSYMS   .tmp_vmlinux.kallsyms3.S
> > > > >     AS      .tmp_vmlinux.kallsyms3.S
> > > > >     LD      vmlinux
> > > > >     BTFIDS  vmlinux
> > > > > FAILED: load BTF from vmlinux: No such file or directory
> > > > > make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
> > > > > make[1]: *** Deleting file 'vmlinux'
> > > > > make: *** [Makefile:1264: vmlinux] Error 2
> > > > I can't reproduce that.. I tried with gcc versions:
> > > > 
> > > >     gcc (GCC) 13.0.1 20230117 (Red Hat 13.0.1-0)
> > > >     gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
> > > > 
> > > > I haven't found fedora setup with 12.2.1 20230111 yet
> > > > 
> > > > I tried alsa with latest pahole master branch
> > > > 
> > > > were you guys able to get any more verbose output
> > > > that I suggested earlier?
> > > > 
> > > > jirka
> > > I compiled with and without IBT using the -V on pahole (LLVM_OBJCOPY=objcopy pahole -V -J --btf_gen_floats -j .tmp_vmlinux.btf) and the outfiles are a little too big (540MB). The error happens with this CONST type pointing to itself. That does not happen with the IBT option removed.
> > > 
> > > $ grep  -n "CONST (anon) type_id" /tmp/with_IBT  | more
> > > 346:[2] CONST (anon) type_id=2
> > > 349:[5] CONST (anon) type_id=5
> > > 351:[7] CONST (anon) type_id=7
> > > 356:[12] CONST (anon) type_id=12
> > > 363:[19] CONST (anon) type_id=19
> > > 373:[29] CONST (anon) type_id=29
> > > 375:[31] CONST (anon) type_id=31
> > > 409:[63] CONST (anon) type_id=63
> > > 444:[89] CONST (anon) type_id=0
> > > 472:[97] CONST (anon) type_id=97
> > > 616:[129] CONST (anon) type_id=129
> > > 652:[131] CONST (anon) type_id=131
> > > 1319:[234] CONST (anon) type_id=234
> > > 1372:[246] CONST (anon) type_id=246
> > > ....
> > > 
> > > $diff -ru with_IBT without_IBT
> > > --- with_IBT 2023-01-31 09:39:24.915912735 -0600
> > > +++ without_IBT 2023-01-31 09:46:23.456005278 -0600
> > > @@ -340,346 +340,14800 @@
> > >   Found per-CPU symbol 'cpu_tlbstate_shared' at address 0x2c040
> > >   Found per-CPU symbol 'mce_poll_banks' at address 0x1ad20
> > >   Found 341 per-CPU variables!
> > > -Found 61470 functions!
> > > +Found 61462 functions!
> > > +File .tmp_vmlinux.btf:
> > > +[1] FUNC_PROTO (anon) return=0 args=(void)
> > > +[2] FUNC verify_cpu type_id=1
> > > +[3] FUNC_PROTO (anon) return=0 args=(void)
> > > +[4] FUNC sev_verify_cbit type_id=3
> > > +search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
> > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > +Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
> > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > > +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> > > +Found per-CPU symbol 'last_nmi_rip' at address 0x1a018
> > > +Found per-CPU symbol 'nmi_stats' at address 0x1a030
> > > +Found per-CPU symbol 'swallow_nmi' at address 0x1a020
> > > +Found per-CPU symbol 'nmi_state' at address 0x1a010
> > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > +Found per-CPU symbol 'nmi_cr2' at address 0x1a008
> > > +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > > +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > > ...
> > > 
> > > And the lines 342-365 of the with_IBT result:
> > >       342 Found 341 per-CPU variables!
> > >       343 Found 61470 functions!
> > >       344 File .tmp_vmlinux.btf:
> > >       345 [1] INT long unsigned int size=8 nr_bits=64 encoding=(none)
> > >       346 [2] CONST (anon) type_id=2
> > >       347 [3] PTR (anon) type_id=6
> > >       348 [4] INT char size=1 nr_bits=8 encoding=(none)
> > >       349 [5] CONST (anon) type_id=5
> > >       350 [6] INT unsigned int size=4 nr_bits=32 encoding=(none)
> > >       351 [7] CONST (anon) type_id=7
> > >       352 [8] TYPEDEF __s8 type_id=10
> > >       353 [9] INT signed char size=1 nr_bits=8 encoding=SIGNED
> > >       354 [10] TYPEDEF __u8 type_id=12
> > >       355 [11] INT unsigned char size=1 nr_bits=8 encoding=(none)
> > >       356 [12] CONST (anon) type_id=12
> > >       357 [13] TYPEDEF __s16 type_id=15
> > >       358 [14] INT short int size=2 nr_bits=16 encoding=SIGNED
> > >       359 [15] TYPEDEF __u16 type_id=17
> > >       360 [16] INT short unsigned int size=2 nr_bits=16 encoding=(none)
> > >       361 [17] TYPEDEF __s32 type_id=19
> > >       362 [18] INT int size=4 nr_bits=32 encoding=SIGNED
> > >       363 [19] CONST (anon) type_id=19
> > >       364 [20] TYPEDEF __u32 type_id=7
> > >       365 [21] TYPEDEF __s64 type_id=23
> > > 
> > > lines 342-362 of without_IBT
> > > 
> > >       342 Found 341 per-CPU variables!
> > >       343 Found 61462 functions!
> > >       344 File .tmp_vmlinux.btf:
> > >       345 [1] FUNC_PROTO (anon) return=0 args=(void)
> > >       346 [2] FUNC verify_cpu type_id=1
> > >       347 [3] FUNC_PROTO (anon) return=0 args=(void)
> > >       348 [4] FUNC sev_verify_cbit type_id=3
> > >       349 search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
> > >       350 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > >       351 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > >       352 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > >       353 Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> > >       354 Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> > >       355 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > >       356 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > >       357 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > >       358 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> > >       359 Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
> > >       360 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > >       361 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> > >       362 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> > > 
> > > If the full debug files are useful or a target grep or diff is better let me know.
> > > 
> > I managed to reproduce this too with IBT enabled; one thing I
> > noticed is with pahole built with an up-to-date libbpf and the
> > changes in https://github.com/acmel/dwarves/tree/next, the problem
> > went away. I didn't have time to root-cause it yet however.
> > 
> > Not sure if you're in a position to do this, but if you can,
> > would you mind building pahole from
> > 
> > https://github.com/acmel/dwarves/tree/next
> > 
> > ...and re-testing to see if that helps? Thanks!
> > 
> > Alan
> > > Thanks,
> > > 
> I tried with libbpf compiled from master
> https://github.com/libbpf/libbpf.git and pahole compiled from next branch on
> https://github.com/acmel/dwarve with the same result.
> With IBT enabled pahole fails and removing it results in a successful
> kernel.

hi,
in case it slipped, you also need to add new options for pahole:
  https://lore.kernel.org/bpf/1675949331-27935-1-git-send-email-alan.maguire@oracle.com/

should be added for version 124 for now

jirka
