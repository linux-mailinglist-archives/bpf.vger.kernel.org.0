Return-Path: <bpf+bounces-5891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265E76279E
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 02:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0173A1C21057
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F71855;
	Wed, 26 Jul 2023 00:03:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9E15AD
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 00:03:39 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25843C0
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:03:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so9782522e87.0
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690329815; x=1690934615;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nXuy0dckcNMUpxgmOQS35xxvY9xI9raEWEpq7j9NFeA=;
        b=mkHgmPrf6TF/a3gmMIT0QQJfjcnjusNOh/NAHoVtp+BUqZG4d/c9F7VguE+UFBPWwN
         /oN7EWg0UvutZucDmLXr3o354Bv8kwNucZXbJWyr81C9vER+v7/vwRJzAYcs5BMoqTeG
         uwe41UoqpJTxlsAJCYpNT7qmkZx9T6OdiWy/O0rBgy5AkkgTG2l9RdH7x0io/cXEk/Qk
         8RXx/ugAKKcv3an5+WG7Ss4138O72BbBOv50MyNOkzqzY/6BRZZXgmPWxRuiU0lbrbrd
         AC9e6hVnjN6PvXerBabBuM4xxQaHgTOR4w6nCCJ/umL9hXcYdr5g6DJLUrHdsnwpReqx
         dUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690329815; x=1690934615;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXuy0dckcNMUpxgmOQS35xxvY9xI9raEWEpq7j9NFeA=;
        b=dH6buvQW8SD23NWzvyXM/ie8xRUMBlFCC6V1mkWn0HUU2v0MNmKdAIp7vPBaXxqcGN
         wG2hWPlSP9vLVgzs7wgtWOsyExz1aDbgLWDKF1ZQHGBtUdCsilouH80nFA3acLVc1JlQ
         yLkHRBJokpqvK6IIuWZ2DytogDqAj8vEscWb8um0lQEHCuXoNtrWZjZT++e8NrcRwawK
         i63TMGC9Xa99cyzn375+bRCi5IXhtHpllCD8wf+CoTijjfNYcSRNSXT4+EfqTMPJx/KW
         egsawIzJMaQs9itqpv92rkg8PPVTMZ6pRosVrDFowDL8dE1RnH680fH5EbhY2qk/MRxq
         Afgg==
X-Gm-Message-State: ABy/qLYBxDM4ExefOf0FY426bT+nHT8YKbSnBL52G2bW7lU9nc+g6nfQ
	bliz5Xlrpw2l+AF9d+aA6jHVLDs9KL4=
X-Google-Smtp-Source: APBJJlHCZTst7S3mKO6s1q+dgmcmUOvzU0oxDibaRFjlbTOeJPsIyIAX4tnuvuGl4ZBW5nIPGAvF5w==
X-Received: by 2002:a05:6512:54b:b0:4f6:3000:94a0 with SMTP id h11-20020a056512054b00b004f6300094a0mr236980lfl.61.1690329815003;
        Tue, 25 Jul 2023 17:03:35 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7c04a000000b0050488d1d376sm8221938edo.0.2023.07.25.17.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:03:34 -0700 (PDT)
Message-ID: <49c9170f7dd0d3e78a12570ae422bce553a1e236.camel@gmail.com>
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Timofei Pushkin
	 <pushkin.td@gmail.com>
Cc: bpf@vger.kernel.org
Date: Wed, 26 Jul 2023 03:03:33 +0300
In-Reply-To: <51d510b9-fbbd-d30a-9a01-e77c84db52a5@oracle.com>
References: 
	<CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
	 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
	 <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
	 <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
	 <51d510b9-fbbd-d30a-9a01-e77c84db52a5@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 15:04 +0100, Alan Maguire wrote:
> On 25/07/2023 00:00, Alan Maguire wrote:
> > On 24/07/2023 16:04, Timofei Pushkin wrote:
> > > On Mon, Jul 24, 2023 at 3:36=E2=80=AFPM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> > > >=20
> > > > On 24/07/2023 11:32, Timofei Pushkin wrote:
> > > > > Dear BPF community,
> > > > >=20
> > > > > I'm developing a perf_event BPF program which reads some register
> > > > > values (frame and instruction pointers in particular) from the co=
ntext
> > > > > provided to it. I found that CO-RE-enabled PT_REGS macros give re=
sults
> > > > > different from the results of the usual PT_REGS  macros. I run th=
e
> > > > > program on the same system I compiled it on, and so I cannot
> > > > > understand why the results differ and which ones should I use?
> > > > >=20
> > > > > From my tests, the results of the usual macros are the correct on=
es
> > > > > (e.g. I can symbolize the instruction pointers I get this way), b=
ut
> > > > > since I try to follow the CO-RE principle, it seems like I should=
 be
> > > > > using the CO-RE-enabled variants instead.
> > > > >=20
> > > > > I did some experiments and found out that it is the
> > > > > bpf_probe_read_kernel part of the CO-RE-enabled PT_REGS macros th=
at
> > > > > change the results and not __builtin_preserve_access_index. But I
> > > > > still don't get why exactly it changes the results.
> > > > >=20
> > > >=20
> > > > Can you provide the exact usage of the BPF CO-RE macros that isn't
> > > > working, and the equivalent non-CO-RE version that is? Also if you
> > >=20
> > > As a minimal example, I wrote the following little BPF program which
> > > prints instruction pointers obtained with non-CO-RE and CO-RE macros:
> > >=20
> > > volatile const pid_t target_pid;
> > >=20
> > > SEC("perf_event")
> > > int do_test(struct bpf_perf_event_data *ctx) {
> > >     pid_t pid =3D bpf_get_current_pid_tgid();
> > >     if (pid !=3D target_pid) return 0;
> > >=20
> > >     unsigned long p =3D PT_REGS_IP(&ctx->regs);
> > >     unsigned long p_core =3D PT_REGS_IP_CORE(&ctx->regs);
> > >     bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);
> > >=20
> > >     return 0;
> > > }
> > >=20
> > > From user space, I set the target PID and attach the program to CPU
> > > clock perf events (error checking and cleanup omitted for brevity):
> > >=20
> > > int main(int argc, char *argv[]) {
> > >     // Load the program also setting the target PID
> > >     struct test_program_bpf *skel =3D test_program_bpf__open();
> > >     skel->rodata->target_pid =3D (pid_t) strtol(argv[1], NULL, 10);
> > >     test_program_bpf__load(skel);
> > >=20
> > >     // Attach to perf events
> > >     struct perf_event_attr attr =3D {
> > >         .type =3D PERF_TYPE_SOFTWARE,
> > >         .size =3D sizeof(struct perf_event_attr),
> > >         .config =3D PERF_COUNT_SW_CPU_CLOCK,
> > >         .sample_freq =3D 1,
> > >         .freq =3D true
> > >     };
> > >     for (int cpu_i =3D 0; cpu_i < libbpf_num_possible_cpus(); cpu_i++=
) {
> > >         int perf_fd =3D syscall(SYS_perf_event_open, &attr, -1, cpu_i=
, -1, 0);
> > >         bpf_program__attach_perf_event(skel->progs.do_test, perf_fd);
> > >     }
> > >=20
> > >     // Wait for Ctrl-C
> > >     pause();
> > >     return 0;
> > > }
> > >=20
> > > As an experiment, I launched a simple C program with an endless loop
> > > in main and started the BPF program above with its target PID set to
> > > the PID of this simple C program. Then by checking the virtual memory
> > > mapped for the C program (with "cat /proc/<PID>/maps"), I found out
> > > that its .text section got mapped into 55ca2577b000-55ca2577c000
> > > address space. When I checked the output of the BPF program, I got
> > > "non-CO-RE: 55ca2577b131, CO-RE: ffffa58810527e48". As you can see,
> > > the non-CO-RE result maps into the .text section of the launched C
> > > program (as it should since this is the value of the instruction
> > > pointer), while the CO-RE result does not.
> > >=20
> > > Alternatively, if I replace PT_REGS_IP and PT_REGS_IP_CORE with the
> > > equivalents for the stack pointer (PT_REGS_SP and PT_REGS_SP_CORE), I
> > > get results that correspond to the stack address space from the
> > > non-CO-RE macro, but I always get 0 from the CO-RE macro.
> > >=20
> > > > can provide details on the platform you're running on that will
> > > > help narrow down the issue. Thanks!
> > >=20
> > > Sure. I'm running Ubuntu 22.04.1, kernel version 5.19.0-46-generic,
> > > the architecture is x86_64, clang 14.0.0 is used to compile BPF
> > > programs with flags -g -O2 -D__TARGET_ARCH_x86.
> > >=20
> >=20
> > Thanks for the additional details! I've reproduced this on
> > bpf-next with LLVM 15; I'm seeing the same issues with the CO-RE
> > macros, and with BPF_CORE_READ(). However with extra libbpf debugging
> > I do see that we pick up the right type id/index for the ip field in
> > pt_regs:
> >=20
> > libbpf: prog 'do_test': relo #4: matching candidate #0 <byte_off> [216]
> > struct pt_regs.ip (0:16 @ offset 128)
> >=20
> > One thing I noticed - perhaps this will ring some bells for someone -
> > if I use __builtin_preserve_access_index() I get the same (correct)
> > value for ip as is retrieved with PT_REGS_IP():
> >=20
> >     __builtin_preserve_access_index(({
> >         p_core =3D ctx->regs.ip;
> >     }));
> >=20
> > I'll check with latest LLVM to see if the issue persists there.
> >=20
>=20
>=20
> The problem occurs with latest bpf-next + latest LLVM too. Perf event
> programs fix up context accesses to the "struct bpf_perf_event_data *"
> context, so accessing ctx->regs in your program becomes accessing the
> "struct bpf_perf_event_data_kern *" regs, which is a pointer to
> struct pt_regs. So I _think_ that's why the
>=20
>     __builtin_preserve_access_index(({
>         p_core =3D ctx->regs.ip;
>     }));
>=20
>=20
> ...works; ctx->regs is fixed up to point at the right place, then
> CO-RE does its thing with the results. Contrast this with
>=20
> bpf_probe_read_kernel(&ip, sizeof(ip), &ctx->regs.ip);
>=20
> In the latter case, the fixups don't seem to happen and we get a
> bogus address which appears to be consistently 218 bytes after the ctx
> pointer. I've confirmed that a basic bpf_probe_read_kernel()
> exposes the issue (and gives the same wrong address as a CO-RE-wrapped
> bpf_probe_read_kernel()).
>=20
> I tried some permutations like defining
>=20
> 	struct pt_regs *regs =3D &ctx->regs;
>=20
> ...to see if that helps, but I think in that case the accesses aren't
> caught by the verifier because we use the & operator on the ctx->regs.
>=20
> Not sure how smart the verifier can be about context accesses like this;
> can someone who understands that code better than me take a look at this?

Hi Alan,

Your analysis is correct: verifier applies rewrites to instructions
that read/write from/to certain context fields, including
`struct bpf_perf_event_data`.

This is done by function verifier.c:convert_ctx_accesses().
This function handles BPF_LDX, BPF_STX and BPF_ST instructions, but it
does not handle calls to helpers like bpf_probe_read_kernel().

So, when code generated for PT_REGS_IP(&ctx->regs) is processed, the
correct access sequence is inserted by function
bpf_trace.c:pe_prog_convert_ctx_access() (see below).

But code generated for `PT_REGS_IP_CORE(&ctx->regs)` is not modified.

It looks like `PT_REGS_IP_CORE` macro should not be defined through
bpf_probe_read_kernel(). I'll dig through commit history tomorrow to
understand why is it defined like that now.

Thanks,
Eduard

---
Below is annotated example, inpatient reader might skip it

For the following test program:

    #include "vmlinux.h"
    ...
    SEC("perf_event")
    int do_test(struct bpf_perf_event_data *ctx) {
      unsigned long p =3D PT_REGS_IP(&ctx->regs);
      unsigned long p_core =3D PT_REGS_IP_CORE(&ctx->regs);
      bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);
      return 0;
    }

Generated BPF code looks as follows:

    $ llvm-objdump --no-show-raw-insn -rd bpf.linked.o=20
    ...
    0000000000000000 <do_test>:
    # Third argument for bpf_probe_read_kernel: offset of bpf_perf_event_da=
ta::regs.ip
           0:	r2 =3D 0x80
    		0000000000000000:  CO-RE <byte_off> [2] struct bpf_perf_event_data::r=
egs.ip (0:0:16)
           1:	r3 =3D r1
           2:	r3 +=3D r2
    # The "non CO-RE" version of PT_REGS_IP is, in fact, CO-RE
    # because `struct bpf_perf_event_data` has preserve_access_index
    # tag in the vmlinux.h.
    # Here the regs.ip is stored in r6 to be used after the call
    # to bpf_probe_read_kernel() (from PT_REGS_IP_CORE).
           3:	r6 =3D *(u64 *)(r1 + 0x80)
    		0000000000000018:  CO-RE <byte_off> [2] struct bpf_perf_event_data::r=
egs.ip (0:0:16)
    # First argument for bpf_probe_read_kernel: a place on stack to put rea=
d result to.
           4:	r1 =3D r10
           5:	r1 +=3D -0x8
    # Second argument for bpf_probe_read_kernel: the size of the field to r=
ead.
           6:	w2 =3D 0x8
    # Call to bpf_probe_read_kernel()
           7:	call 0x71
    # Fourth parameter of bpf_printk: p_core read from stack
    # (was written by call to bpf_probe_read_kernel)
           8:	r4 =3D *(u64 *)(r10 - 0x8)
    # First parameter of bpf_printk: control string
           9:	r1 =3D 0x0 ll
    		0000000000000048:  R_BPF_64_64	.rodata
    # Second parameter of bpf_printk: size of the control string
          11:	w2 =3D 0x1b
    # Third parameter of bpf_printk: p (see addr 3)
          12:	r3 =3D r6
    # Call to bpf_printk
          13:	call 0x6
    ;   return 0;
          14:	w0 =3D 0x0
          15:	exit
   =20
I get the following BPF after all verifier rewrites are applied
(including verifier.c:convert_ctx_accesses()):

    # ./tools/bpf/bpftool/bpftool prog dump xlated id 114
    int do_test(struct bpf_perf_event_data * ctx):
    ; int do_test(struct bpf_perf_event_data *ctx) {
       0: (b7) r2 =3D 128                  | CO-RE replacement, 128 is a va=
lid offset for
                                         | bpf_perf_event_data::regs.ip in =
my kernel
       1: (bf) r3 =3D r1
       2: (0f) r3 +=3D r2

       3: (79) r6 =3D *(u64 *)(r1 +0)      | This is an expantion of the=
=20
       4: (79) r6 =3D *(u64 *)(r6 +128)    |   r6 =3D *(u64 *)(r1 + 0x80)
       5: (bf) r1 =3D r10                  | Created by bpf_trace.c:pe_prog=
_convert_ctx_access()

       6: (07) r1 +=3D -8
       7: (b4) w2 =3D 8
       8: (85) call bpf_probe_read_kernel#-91984
       9: (79) r4 =3D *(u64 *)(r10 -8)
      10: (18) r1 =3D map[id:59][0]+0
      12: (b4) w2 =3D 27
      13: (bf) r3 =3D r6
      14: (85) call bpf_trace_printk#-85520
      15: (b4) w0 =3D 0
      16: (95) exit
   =20


