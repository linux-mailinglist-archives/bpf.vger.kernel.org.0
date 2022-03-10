Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBC4D3E04
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 01:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiCJATu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 19:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiCJATu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 19:19:50 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3488DBF4F;
        Wed,  9 Mar 2022 16:18:50 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id b9so1285525ila.8;
        Wed, 09 Mar 2022 16:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IW1EdT8RFVIQ1uuvdQItPGNy2Hda+mZSQKcad2yUdlM=;
        b=kPgG0VeSWf8bpnQ+Jqh0zknqWKokduRt/g17a59kj5jmTCgccEQNk8VDdMzBZDIjhZ
         CvkUY3XkfKHE73rRfVSM6uh3yOsmh+cMvTEbPPf8Ycw8fVC8EYtMK9AQztPi84Vmc6Cu
         Mt0x5s2ZusIhWmZGv/UIjhItaKC4Ms2LYn6kCjtH4rEm2N/4Asp8oejBXJQQh07GFRwC
         c+Zpq4xuW1KwHjm1upepvxfqd+4iRz0Kh+of/9fkC2810mZsUTfpuCpzNoykHZbRVCZo
         AxRPdWk0IoJ8ur4i29WlY/6szINbALhZqfr/qQYJPxnaguEg98kpXb8Fp1MLeSpBJUp7
         L+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IW1EdT8RFVIQ1uuvdQItPGNy2Hda+mZSQKcad2yUdlM=;
        b=xAWUb+muvkclw1VltqxIbxE9xw2meqfB6Xxj/HToJGGiXhmfr6agiEQzLKqQE2vh65
         8tw5gHWWr6HI2Gsvua8iVHCulWbJtsCQ0vaGfZZJ20RzJ1yA1z8CPnKSz8DuHnhnWj7N
         3qUHFjkJS4zXDa3OUZA1PjiWLQNfzMOAotGRrBUPQdKXUuScRpbeLqGVyqtqUvS9E0Ef
         VqbVhRDxMNVZft1og0o58wrQSFON6b179HbwPkF2O8uQ/STZ2PWBJ+w/oiNoeHkYsfKl
         s/IcH4vi6p+cLamUksHRrd4swQA9pxDxvp3cdJyh+KaGF/MPM4UBiJx31mQYYMhMMHyK
         F8bw==
X-Gm-Message-State: AOAM53232YsenAYDjXdHPRCrIM2cfvyU9T11xC5zW3fH98m3GQ/QYA80
        9InZXm1haDXif7MRxbZVSSrjyMSenSc15s2B0bE=
X-Google-Smtp-Source: ABdhPJw/vDxMQj4JrP2DRb56LB8U1vgz25N3oORPBW6zv9U1n3NV7mr9jjR/Va05sjfG9Jn3yiw/ezygENTBvY/TIDc=
X-Received: by 2002:a05:6e02:1a8e:b0:2c6:3b01:1ffe with SMTP id
 k14-20020a056e021a8e00b002c63b011ffemr1566181ilv.239.1646871529449; Wed, 09
 Mar 2022 16:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20220126192039.2840752-1-kuifeng@fb.com> <20220126192039.2840752-2-kuifeng@fb.com>
 <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
 <YfJudZmSS1yTkeP/@kernel.org> <CAEf4Bza8xB+yFb4qGPvM7YwvHCb1zQ8yosGbKj63vcRM7d9aLg@mail.gmail.com>
 <Yij/BSPgMl8/HEhg@kernel.org> <CAEf4BzZX8Q5MPt62+68nRoQNPe=3jnVkcEMMJwPzoU51YCBszg@mail.gmail.com>
In-Reply-To: <CAEf4BzZX8Q5MPt62+68nRoQNPe=3jnVkcEMMJwPzoU51YCBszg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Mar 2022 16:18:38 -0800
Message-ID: <CAEf4BzYxOgNjC+nFJGY_wpnOZZ-Jik=15L0aSq3Uxbiamc0h+w@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 9, 2022 at 4:14 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 9, 2022 at 11:24 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Mar 08, 2022 at 03:45:03PM -0800, Andrii Nakryiko escreveu:
> > > On Thu, Jan 27, 2022 at 11:22 AM Arnaldo Carvalho de Melo
> > > <arnaldo.melo@gmail.com> wrote:
> > > >
> > > > Em Wed, Jan 26, 2022 at 11:55:25AM -0800, Andrii Nakryiko escreveu:
> > > > > On Wed, Jan 26, 2022 at 11:20 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > > > > >
> > > > > > Add arguments to steal and thread_exit callbacks of conf_load to
> > > > > > receive per-thread data.
> > > > > >
> > > > > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > > > > ---
> > > > >
> > > > > Please carry over acks you got on previous revisions, unless you did
> > > > > some drastic changes to already acked patches.
> > > >
> > > > Yes, please do so.
> > > >
> > > > I'll collect them this time, no need to resend.
> > > >
> > >
> > > Hey, Arnaldo!
> > >
> > > Any idea when these patches will make it into master branch? I see
> > > they are in tmp.master right now.
> >
> > I did some minor fixups to the cset comment and to the code in the
> > 'pahole --compile' new feature at the head of it and pushed all up,
> > please check.
> >
>
> I did check locally with latest pahole master, and it seems like
> something is wrong with generated BTF. I get three selftests failure
> if I use latest pahole compiled from master.
>
> Kui-Feng, please take a look when you get a chance. Arnaldo, please
> hold off from releasing a new version for now.

Specifically:

libbpf: prog 'kfunc_call_test1': BPF program load failed: Permission denied
libbpf: prog 'kfunc_call_test1': -- BEGIN PROG LOAD LOG --
Validating f1() func#1...
2: R1=ctx(off=0,imm=0) R10=fp0
; int __noinline f1(struct __sk_buff *skb)
2: (b4) w7 = -1                       ; R7_w=P4294967295
; struct bpf_sock *sk = skb->sk;
3: (79) r1 = *(u64 *)(r1 +168)        ;
R1_w=sock_common_or_null(id=1,off=0,imm=0)
; if (!sk)
4: (15) if r1 == 0x0 goto pc+26       ; R1_w=sock_common(off=0,imm=0)
; sk = bpf_sk_fullsock(sk);
5: (85) call bpf_sk_fullsock#95       ; R0_w=sock_or_null(id=2,off=0,imm=0)
6: (bf) r6 = r0                       ;
R0_w=sock_or_null(id=2,off=0,imm=0)
R6_w=sock_or_null(id=2,off=0,imm=0)
; if (!sk)
7: (15) if r6 == 0x0 goto pc+23       ; R6_w=sock(off=0,imm=0)
; bpf_get_smp_processor_id());
8: (85) call bpf_get_smp_processor_id#8       ; R0=Pscalar()
; active = (int *)bpf_per_cpu_ptr(&bpf_prog_active,
9: (18) r1 = 0x275e0                  ; R1_w=rdonly_mem(off=0,imm=0)
11: (bc) w2 = w0                      ; R0=Pscalar()
R2_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff))
12: (85) call bpf_per_cpu_ptr#153
R1 type=rdonly_mem expected=percpu_ptr_
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1
-- END PROG LOAD LOG --
libbpf: failed to load program 'kfunc_call_test1'
libbpf: failed to load object 'kfunc_call_test_subprog'
libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -13
test_subprog:FAIL:skel unexpected error: -13
#77/2 kfunc_call/subprog:FAIL
test_subprog_lskel:FAIL:skel unexpected error: -13
#77/3 kfunc_call/subprog_lskel:FAIL

test_ksyms_btf:PASS:btf_exists 0 nsec
test_basic:PASS:kallsyms_fopen 0 nsec
test_basic:PASS:ksym_find 0 nsec
test_basic:PASS:kallsyms_fopen 0 nsec
test_basic:PASS:ksym_find 0 nsec
libbpf: prog 'handler': BPF program load failed: Permission denied
libbpf: prog 'handler': -- BEGIN PROG LOAD LOG --
arg#0 reference type('UNKNOWN ') size cannot be determined: -22
0: R1=ctx(off=0,imm=0) R10=fp0
; out__bpf_prog_active_addr = (__u64)&bpf_prog_active;
0: (18) r1 = 0xffffc9000071a008       ; R1_w=map_value(off=8,ks=4,vs=36,imm=0)
2: (18) r2 = 0x275e0                  ; R2_w=rdonly_mem(off=0,imm=0)
4: (7b) *(u64 *)(r1 +0) = r2          ;
R1_w=map_value(off=8,ks=4,vs=36,imm=0) R2_w=rdonly_mem(off=0,imm=0)
; out__runqueues_addr = (__u64)&runqueues;
5: (18) r1 = 0xffffc9000071a000       ; R1_w=map_value(off=0,ks=4,vs=36,imm=0)
7: (18) r2 = 0x2b140                  ; R2_w=ptr_rq(off=0,imm=0)
9: (7b) *(u64 *)(r1 +0) = r2          ;
R1_w=map_value(off=0,ks=4,vs=36,imm=0) R2_w=ptr_rq(off=0,imm=0)
; cpu = bpf_get_smp_processor_id();
10: (85) call bpf_get_smp_processor_id#8      ; R0_w=scalar()
11: (bc) w6 = w0                      ; R0_w=scalar()
R6_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, cpu);
12: (18) r1 = 0x2b140                 ; R1_w=ptr_rq(off=0,imm=0)
14: (bc) w2 = w6                      ;
R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
R6_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
15: (85) call bpf_per_cpu_ptr#153
R1 type=ptr_ expected=percpu_ptr_
processed 11 insns (limit 1000000) max_states_per_insn 0 total_states
0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: failed to load program 'handler'
libbpf: failed to load object 'test_ksyms_btf'
libbpf: failed to load BPF skeleton 'test_ksyms_btf': -13
test_basic:FAIL:skel_open failed to open and load skeleton
#79/1 ksyms_btf/basic:FAIL

#80 ksyms_module:FAIL
test_ksyms_module_lskel:FAIL:test_ksyms_module_lskel__open_and_load
unexpected error: -13
#80/1 ksyms_module/lskel:FAIL
libbpf: prog 'load': BPF program load failed: Permission denied
libbpf: prog 'load': -- BEGIN PROG LOAD LOG --
0: R1=ctx(off=0,imm=0) R10=fp0
; if (x)
0: (18) r1 = 0xffffc9000109e000       ; R1_w=map_value(off=0,ks=4,vs=4,imm=0)
2: (61) r1 = *(u32 *)(r1 +0)          ; R1_w=0
; if (x)
3: (16) if w1 == 0x0 goto pc+1        ; R1_w=P0
; bpf_testmod_test_mod_kfunc(42);
5: (b4) w1 = 42                       ; R1_w=42
6: (85) call bpf_testmod_test_mod_kfunc#123710
; out_bpf_testmod_ksym = *(int *)bpf_this_cpu_ptr(&bpf_testmod_ksym_percpu);
7: (18) r1 = 0x2c3e8                  ; R1_w=rdonly_mem(off=0,imm=0)
9: (85) call bpf_this_cpu_ptr#154
R1 type=rdonly_mem expected=percpu_ptr_
processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: failed to load program 'load'
libbpf: failed to load object 'test_ksyms_module'
libbpf: failed to load BPF skeleton 'test_ksyms_module': -13
test_ksyms_module_libbpf:FAIL:test_ksyms_module__open unexpected error: -13
#80/2 ksyms_module/libbpf:FAIL


So it seems like something broke around per-CPU variable info generation.

>
>
> > - Arnaldo
> >
> > > > - Arnaldo
> > > >
> > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > >
> > > > > >  btf_loader.c   | 2 +-
> > > > > >  ctf_loader.c   | 2 +-
> > > > > >  dwarf_loader.c | 4 ++--
> > > > > >  dwarves.h      | 5 +++--
> > > > > >  pahole.c       | 3 ++-
> > > > > >  pdwtags.c      | 3 ++-
> > > > > >  pfunct.c       | 4 +++-
> > > > > >  7 files changed, 14 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/btf_loader.c b/btf_loader.c
> > > > > > index 7a5b16ff393e..b61cadd55127 100644
> > > > > > --- a/btf_loader.c
> > > > > > +++ b/btf_loader.c
> > > > > > @@ -624,7 +624,7 @@ static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *fi
> > > > > >          * The app stole this cu, possibly deleting it,
> > > > > >          * so forget about it
> > > > > >          */
> > > > > > -       if (conf && conf->steal && conf->steal(cu, conf))
> > > > > > +       if (conf && conf->steal && conf->steal(cu, conf, NULL))
> > > > > >                 return 0;
> > > > > >
> > > > > >         cus__add(cus, cu);
> > > > > > diff --git a/ctf_loader.c b/ctf_loader.c
> > > > > > index 7c34739afdce..de6d4dbfce97 100644
> > > > > > --- a/ctf_loader.c
> > > > > > +++ b/ctf_loader.c
> > > > > > @@ -722,7 +722,7 @@ int ctf__load_file(struct cus *cus, struct conf_load *conf,
> > > > > >          * The app stole this cu, possibly deleting it,
> > > > > >          * so forget about it
> > > > > >          */
> > > > > > -       if (conf && conf->steal && conf->steal(cu, conf))
> > > > > > +       if (conf && conf->steal && conf->steal(cu, conf, NULL))
> > > > > >                 return 0;
> > > > > >
> > > > > >         cus__add(cus, cu);
> > > > > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > > > > index e30b03c1c541..bf9ea3765419 100644
> > > > > > --- a/dwarf_loader.c
> > > > > > +++ b/dwarf_loader.c
> > > > > > @@ -2686,7 +2686,7 @@ static int cu__finalize(struct cu *cu, struct conf_load *conf)
> > > > > >  {
> > > > > >         cu__for_all_tags(cu, class_member__cache_byte_size, conf);
> > > > > >         if (conf && conf->steal) {
> > > > > > -               return conf->steal(cu, conf);
> > > > > > +               return conf->steal(cu, conf, NULL);
> > > > > >         }
> > > > > >         return LSK__KEEPIT;
> > > > > >  }
> > > > > > @@ -2930,7 +2930,7 @@ static void *dwarf_cus__process_cu_thread(void *arg)
> > > > > >                         goto out_abort;
> > > > > >         }
> > > > > >
> > > > > > -       if (dcus->conf->thread_exit && dcus->conf->thread_exit() != 0)
> > > > > > +       if (dcus->conf->thread_exit && dcus->conf->thread_exit(dcus->conf, NULL) != 0)
> > > > > >                 goto out_abort;
> > > > > >
> > > > > >         return (void *)DWARF_CB_OK;
> > > > > > diff --git a/dwarves.h b/dwarves.h
> > > > > > index 52d162d67456..9a8e4de8843a 100644
> > > > > > --- a/dwarves.h
> > > > > > +++ b/dwarves.h
> > > > > > @@ -48,8 +48,9 @@ struct conf_fprintf;
> > > > > >   */
> > > > > >  struct conf_load {
> > > > > >         enum load_steal_kind    (*steal)(struct cu *cu,
> > > > > > -                                        struct conf_load *conf);
> > > > > > -       int                     (*thread_exit)(void);
> > > > > > +                                        struct conf_load *conf,
> > > > > > +                                        void *thr_data);
> > > > > > +       int                     (*thread_exit)(struct conf_load *conf, void *thr_data);
> > > > > >         void                    *cookie;
> > > > > >         char                    *format_path;
> > > > > >         int                     nr_jobs;
> > > > > > diff --git a/pahole.c b/pahole.c
> > > > > > index f3a51cb2fe74..f3eeaaca4cdf 100644
> > > > > > --- a/pahole.c
> > > > > > +++ b/pahole.c
> > > > > > @@ -2799,7 +2799,8 @@ out:
> > > > > >  static struct type_instance *header;
> > > > > >
> > > > > >  static enum load_steal_kind pahole_stealer(struct cu *cu,
> > > > > > -                                          struct conf_load *conf_load)
> > > > > > +                                          struct conf_load *conf_load,
> > > > > > +                                          void *thr_data)
> > > > > >  {
> > > > > >         int ret = LSK__DELETE;
> > > > > >
> > > > > > diff --git a/pdwtags.c b/pdwtags.c
> > > > > > index 2b5ba1bf6745..8b1d6f1c96cb 100644
> > > > > > --- a/pdwtags.c
> > > > > > +++ b/pdwtags.c
> > > > > > @@ -72,7 +72,8 @@ static int cu__emit_tags(struct cu *cu)
> > > > > >  }
> > > > > >
> > > > > >  static enum load_steal_kind pdwtags_stealer(struct cu *cu,
> > > > > > -                                           struct conf_load *conf_load __maybe_unused)
> > > > > > +                                           struct conf_load *conf_load __maybe_unused,
> > > > > > +                                           void *thr_data __maybe_unused)
> > > > > >  {
> > > > > >         cu__emit_tags(cu);
> > > > > >         return LSK__DELETE;
> > > > > > diff --git a/pfunct.c b/pfunct.c
> > > > > > index 5485622e639b..314915b774f4 100644
> > > > > > --- a/pfunct.c
> > > > > > +++ b/pfunct.c
> > > > > > @@ -489,7 +489,9 @@ int elf_symtabs__show(char *filenames[])
> > > > > >         return EXIT_SUCCESS;
> > > > > >  }
> > > > > >
> > > > > > -static enum load_steal_kind pfunct_stealer(struct cu *cu, struct conf_load *conf_load __maybe_unused)
> > > > > > +static enum load_steal_kind pfunct_stealer(struct cu *cu,
> > > > > > +                                          struct conf_load *conf_load __maybe_unused,
> > > > > > +                                          void *thr_data __maybe_unused)
> > > > > >  {
> > > > > >
> > > > > >         if (function_name) {
> > > > > > --
> > > > > > 2.30.2
> > > > > >
> > > >
> > > > --
> > > >
> > > > - Arnaldo
> >
> > --
> >
> > - Arnaldo
