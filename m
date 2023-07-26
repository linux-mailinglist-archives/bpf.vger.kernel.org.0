Return-Path: <bpf+bounces-5998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364FC76401C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24F0281F28
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 20:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9619892;
	Wed, 26 Jul 2023 20:03:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A651988B
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 20:03:41 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15A1BF6
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:03:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991ef0b464cso310360866b.0
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690401818; x=1691006618;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQefoLbEoaNJ53qiBt3KR5BxLxUfVBMGolDxdnTEaio=;
        b=lQqD4VFLfi5SjbRxmy6ckU7Y4L3wlt7YRr86r6fNDMxRvnrACBd9mFT5rsXjpFp7z4
         cfNXjCKuDq+L4lhdRnXGNIfPzBIIxG/+EJjdzsf/S10DeoErV6MgplYutIbxauJv4rL3
         Ttz6EnVS1vXkOzYpNFUoX+h1mg3YPWLpJ3dJOxab1hxkakOotudj5slcd+81THbYXeLk
         aB4FgN4ofQ3Jsok+o71kZoTYr3WGZFp0uzJeG8ilFy8IWlKaOvXmeClYBxG5pEFmxCNG
         yP60Ca8xafBa/E72I0dIZtCWfLs1EM9lHfyGbZxTca2MFdU0L+sZARuOS4C3D2Pinnd5
         KP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690401818; x=1691006618;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQefoLbEoaNJ53qiBt3KR5BxLxUfVBMGolDxdnTEaio=;
        b=A85oCO9++Qegj233UqDBIAXDiI/LzwEl3sWdbuUF50a6dBVn53qzMIJzj/fwAtBzrb
         qCwKFVg4XO3LFhFcz0eFwsea7pCdxXitVslfvQPVFs6Ln+QJ5ZGFW6EZtVOhcNfYsbRp
         NIbUsIh71vElJG1dB8VggHo0vRU7/sXmgBjfHs/0qEonx7s/GXGtA6ClOxPEPs2BR98Z
         o2VQn8djt+3JSMAtz9Pbtvhsu1QzPDoSRdhjyHtIOQ60E47JxTdm1aM1jqjcSBsRicP2
         KWKKXmGf0sr7nJQlLXvlOFzpa5S6ON+y5vkXQz5Yz10gTJnmXCNANsvoiN+4wagYQHes
         pNkg==
X-Gm-Message-State: ABy/qLZJSSrKo8QR0dBa91KCvnrPy5qj0Drk60twdBYTn7I56qenQBhd
	yyA3d6R33ilSePeLC+7WDKY=
X-Google-Smtp-Source: APBJJlE9aYyY8vzOdwROCOQ6YuCx6Kznl2E90aiHuPiqFX42zjdu25UkIC+gXTvIWV1zfrBsjWwxXQ==
X-Received: by 2002:a17:907:2da3:b0:99b:4867:5e1c with SMTP id gt35-20020a1709072da300b0099b48675e1cmr95047ejc.28.1690401817453;
        Wed, 26 Jul 2023 13:03:37 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id kg8-20020a17090776e800b0099329b3ab67sm9959836ejc.71.2023.07.26.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 13:03:36 -0700 (PDT)
Message-ID: <8dd70c47d4f395ad5dd3b1da9e77221125eb9146.camel@gmail.com>
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Timofei Pushkin
	 <pushkin.td@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Date: Wed, 26 Jul 2023 23:03:35 +0300
In-Reply-To: <308bfec7-38d7-9dcd-3130-5602658db47f@oracle.com>
References: 
	<CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
	 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
	 <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
	 <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
	 <51d510b9-fbbd-d30a-9a01-e77c84db52a5@oracle.com>
	 <49c9170f7dd0d3e78a12570ae422bce553a1e236.camel@gmail.com>
	 <308bfec7-38d7-9dcd-3130-5602658db47f@oracle.com>
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

On Wed, 2023-07-26 at 14:46 +0100, Alan Maguire wrote:
> On 26/07/2023 01:03, Eduard Zingerman wrote:
> > On Tue, 2023-07-25 at 15:04 +0100, Alan Maguire wrote:
> > > On 25/07/2023 00:00, Alan Maguire wrote:
> > > > On 24/07/2023 16:04, Timofei Pushkin wrote:
> > > > > On Mon, Jul 24, 2023 at 3:36=E2=80=AFPM Alan Maguire <alan.maguir=
e@oracle.com> wrote:
> > > > > >=20
> > > > > > On 24/07/2023 11:32, Timofei Pushkin wrote:
> > > > > > > Dear BPF community,
> > > > > > >=20
> > > > > > > I'm developing a perf_event BPF program which reads some regi=
ster
> > > > > > > values (frame and instruction pointers in particular) from th=
e context
> > > > > > > provided to it. I found that CO-RE-enabled PT_REGS macros giv=
e results
> > > > > > > different from the results of the usual PT_REGS  macros. I ru=
n the
> > > > > > > program on the same system I compiled it on, and so I cannot
> > > > > > > understand why the results differ and which ones should I use=
?
> > > > > > >=20
> > > > > > > From my tests, the results of the usual macros are the correc=
t ones
> > > > > > > (e.g. I can symbolize the instruction pointers I get this way=
), but
> > > > > > > since I try to follow the CO-RE principle, it seems like I sh=
ould be
> > > > > > > using the CO-RE-enabled variants instead.
> > > > > > >=20
> > > > > > > I did some experiments and found out that it is the
> > > > > > > bpf_probe_read_kernel part of the CO-RE-enabled PT_REGS macro=
s that
> > > > > > > change the results and not __builtin_preserve_access_index. B=
ut I
> > > > > > > still don't get why exactly it changes the results.
> > > > > > >=20
> > > > > >=20
> > > > > > Can you provide the exact usage of the BPF CO-RE macros that is=
n't
> > > > > > working, and the equivalent non-CO-RE version that is? Also if =
you
> > > > >=20
> > > > > As a minimal example, I wrote the following little BPF program wh=
ich
> > > > > prints instruction pointers obtained with non-CO-RE and CO-RE mac=
ros:
> > > > >=20
> > > > > volatile const pid_t target_pid;
> > > > >=20
> > > > > SEC("perf_event")
> > > > > int do_test(struct bpf_perf_event_data *ctx) {
> > > > >     pid_t pid =3D bpf_get_current_pid_tgid();
> > > > >     if (pid !=3D target_pid) return 0;
> > > > >=20
> > > > >     unsigned long p =3D PT_REGS_IP(&ctx->regs);
> > > > >     unsigned long p_core =3D PT_REGS_IP_CORE(&ctx->regs);
> > > > >     bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);
> > > > >=20
> > > > >     return 0;
> > > > > }
> > > > >=20
> > > > > From user space, I set the target PID and attach the program to C=
PU
> > > > > clock perf events (error checking and cleanup omitted for brevity=
):
> > > > >=20
> > > > > int main(int argc, char *argv[]) {
> > > > >     // Load the program also setting the target PID
> > > > >     struct test_program_bpf *skel =3D test_program_bpf__open();
> > > > >     skel->rodata->target_pid =3D (pid_t) strtol(argv[1], NULL, 10=
);
> > > > >     test_program_bpf__load(skel);
> > > > >=20
> > > > >     // Attach to perf events
> > > > >     struct perf_event_attr attr =3D {
> > > > >         .type =3D PERF_TYPE_SOFTWARE,
> > > > >         .size =3D sizeof(struct perf_event_attr),
> > > > >         .config =3D PERF_COUNT_SW_CPU_CLOCK,
> > > > >         .sample_freq =3D 1,
> > > > >         .freq =3D true
> > > > >     };
> > > > >     for (int cpu_i =3D 0; cpu_i < libbpf_num_possible_cpus(); cpu=
_i++) {
> > > > >         int perf_fd =3D syscall(SYS_perf_event_open, &attr, -1, c=
pu_i, -1, 0);
> > > > >         bpf_program__attach_perf_event(skel->progs.do_test, perf_=
fd);
> > > > >     }
> > > > >=20
> > > > >     // Wait for Ctrl-C
> > > > >     pause();
> > > > >     return 0;
> > > > > }
> > > > >=20
> > > > > As an experiment, I launched a simple C program with an endless l=
oop
> > > > > in main and started the BPF program above with its target PID set=
 to
> > > > > the PID of this simple C program. Then by checking the virtual me=
mory
> > > > > mapped for the C program (with "cat /proc/<PID>/maps"), I found o=
ut
> > > > > that its .text section got mapped into 55ca2577b000-55ca2577c000
> > > > > address space. When I checked the output of the BPF program, I go=
t
> > > > > "non-CO-RE: 55ca2577b131, CO-RE: ffffa58810527e48". As you can se=
e,
> > > > > the non-CO-RE result maps into the .text section of the launched =
C
> > > > > program (as it should since this is the value of the instruction
> > > > > pointer), while the CO-RE result does not.
> > > > >=20
> > > > > Alternatively, if I replace PT_REGS_IP and PT_REGS_IP_CORE with t=
he
> > > > > equivalents for the stack pointer (PT_REGS_SP and PT_REGS_SP_CORE=
), I
> > > > > get results that correspond to the stack address space from the
> > > > > non-CO-RE macro, but I always get 0 from the CO-RE macro.
> > > > >=20
> > > > > > can provide details on the platform you're running on that will
> > > > > > help narrow down the issue. Thanks!
> > > > >=20
> > > > > Sure. I'm running Ubuntu 22.04.1, kernel version 5.19.0-46-generi=
c,
> > > > > the architecture is x86_64, clang 14.0.0 is used to compile BPF
> > > > > programs with flags -g -O2 -D__TARGET_ARCH_x86.
> > > > >=20
> > > >=20
> > > > Thanks for the additional details! I've reproduced this on
> > > > bpf-next with LLVM 15; I'm seeing the same issues with the CO-RE
> > > > macros, and with BPF_CORE_READ(). However with extra libbpf debuggi=
ng
> > > > I do see that we pick up the right type id/index for the ip field i=
n
> > > > pt_regs:
> > > >=20
> > > > libbpf: prog 'do_test': relo #4: matching candidate #0 <byte_off> [=
216]
> > > > struct pt_regs.ip (0:16 @ offset 128)
> > > >=20
> > > > One thing I noticed - perhaps this will ring some bells for someone=
 -
> > > > if I use __builtin_preserve_access_index() I get the same (correct)
> > > > value for ip as is retrieved with PT_REGS_IP():
> > > >=20
> > > >     __builtin_preserve_access_index(({
> > > >         p_core =3D ctx->regs.ip;
> > > >     }));
> > > >=20
> > > > I'll check with latest LLVM to see if the issue persists there.
> > > >=20
> > >=20
> > >=20
> > > The problem occurs with latest bpf-next + latest LLVM too. Perf event
> > > programs fix up context accesses to the "struct bpf_perf_event_data *=
"
> > > context, so accessing ctx->regs in your program becomes accessing the
> > > "struct bpf_perf_event_data_kern *" regs, which is a pointer to
> > > struct pt_regs. So I _think_ that's why the
> > >=20
> > >     __builtin_preserve_access_index(({
> > >         p_core =3D ctx->regs.ip;
> > >     }));
> > >=20
> > >=20
> > > ...works; ctx->regs is fixed up to point at the right place, then
> > > CO-RE does its thing with the results. Contrast this with
> > >=20
> > > bpf_probe_read_kernel(&ip, sizeof(ip), &ctx->regs.ip);
> > >=20
> > > In the latter case, the fixups don't seem to happen and we get a
> > > bogus address which appears to be consistently 218 bytes after the ct=
x
> > > pointer. I've confirmed that a basic bpf_probe_read_kernel()
> > > exposes the issue (and gives the same wrong address as a CO-RE-wrappe=
d
> > > bpf_probe_read_kernel()).
> > >=20
> > > I tried some permutations like defining
> > >=20
> > >   struct pt_regs *regs =3D &ctx->regs;
> > >=20
> > > ...to see if that helps, but I think in that case the accesses aren't
> > > caught by the verifier because we use the & operator on the ctx->regs=
.
> > >=20
> > > Not sure how smart the verifier can be about context accesses like th=
is;
> > > can someone who understands that code better than me take a look at t=
his?
> >=20
> > Hi Alan,
> >=20
> > Your analysis is correct: verifier applies rewrites to instructions
> > that read/write from/to certain context fields, including
> > `struct bpf_perf_event_data`.
> >=20
> > This is done by function verifier.c:convert_ctx_accesses().
> > This function handles BPF_LDX, BPF_STX and BPF_ST instructions, but it
> > does not handle calls to helpers like bpf_probe_read_kernel().
> >=20
> > So, when code generated for PT_REGS_IP(&ctx->regs) is processed, the
> > correct access sequence is inserted by function
> > bpf_trace.c:pe_prog_convert_ctx_access() (see below).
> >=20
> > But code generated for `PT_REGS_IP_CORE(&ctx->regs)` is not modified.
> >=20
>=20
> Ah, makes sense. Would you consider it a bug that helper parameters
> don't get context conversions applied, or are there additional
> complexities here that mean that's not doable? (I'm wondering if
> we should fix versus document this?). I would have thought the
> only difference is the destination register, but the verifier is
> a mysterious land to me..

Sorry for delay, had to read through implementation.

Verifier already reports an error when pointer to a context is passed
to helper function if context is subject to convert_ctx_accesses().
This is done in function verifier.c:check_helper_mem_access()
(see `case PTR_TO_CTX` at the end of the function).

For example, the following program is rejected:

  struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __uint(max_entries, 1);
    __type(key, void *);
    __type(value, int);
  } map SEC(".maps");
 =20
  SEC("perf_event")
  int do_test(struct bpf_perf_event_data *ctx) {
    void *p =3D bpf_map_lookup_elem(&map, &ctx->regs);
    return p ? 0 : 1;
  }

Here is the log:

  ...
  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
  ; int do_test(struct bpf_perf_event_data *ctx) {
  0: (bf) r2 =3D r1                       ; R1=3Dctx(off=3D0,imm=3D0) R2_w=
=3Dctx(off=3D0,imm=3D0)
  1: (b7) r1 =3D 0                        ; R1_w=3D0
  2: (0f) r2 +=3D r1
  mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1=20
  mark_precise: frame0: regs=3Dr1 stack=3D before 1: (b7) r1 =3D 0
  3: R1_w=3D0 R2_w=3Dctx(off=3D0,imm=3D0)
  ; void *p =3D bpf_map_lookup_elem(&map, &ctx->regs);
  3: (18) r1 =3D 0xffff888102c22000       ; R1_w=3Dmap_ptr(off=3D0,ks=3D8,v=
s=3D4,imm=3D0)
  5: (85) call bpf_map_lookup_elem#1
  R2 type=3Dctx expected=3Dfp, pkt, pkt_meta, map_key, map_value, mem, ring=
buf_mem, buf, trusted_ptr_
  ^^^^^^
     error message (a bit cryptic)
  ...

However, this error is checked conditionally depending on the
proto defined for the helper function. For example, here is the
proto for bpf_map_lookup_elem():

  const struct bpf_func_proto bpf_map_lookup_elem_proto =3D {
    .func       =3D bpf_map_lookup_elem,
    .gpl_only   =3D false,
    .pkt_access =3D true,
    .ret_type   =3D RET_PTR_TO_MAP_VALUE_OR_NULL,
    .arg1_type  =3D ARG_CONST_MAP_PTR,    // <-- check_helper_mem_access() =
is done
    .arg2_type  =3D ARG_PTR_TO_MAP_KEY,   // <-- check_helper_mem_access() =
is done
  };

And here is prototype for bpf_probe_read_kernel():

  const struct bpf_func_proto bpf_probe_read_kernel_proto =3D {
    .func       =3D bpf_probe_read_kernel,
    .gpl_only   =3D true,
    .ret_type   =3D RET_INTEGER,
    .arg1_type  =3D ARG_PTR_TO_UNINIT_MEM,   // <-- check_helper_mem_access=
() is done
    .arg2_type  =3D ARG_CONST_SIZE_OR_ZERO,  // <-- check_helper_mem_access=
() is done for
                                           //     the previous argument (a =
bit complicated)
    .arg3_type  =3D ARG_ANYTHING,            // <-- check_helper_mem_access=
() is *NOT* done
  };
 =20
So, the way bpf_probe_read_kernel() is defined for verifier it does
not check that last argument might point to "fake" location.

I think this should be fixed, but would be interesting to hear what
people on the mailing list think.

> > It looks like `PT_REGS_IP_CORE` macro should not be defined through
> > bpf_probe_read_kernel(). I'll dig through commit history tomorrow to
> > understand why is it defined like that now.
> >  help
>=20
> If I recall the rationale was to allow the macros to work for both
> BPF programs that can do direct dereference (fentry, fexit, tp_btf etc)
> and for kprobe-style that need to use bpf_probe_read_kernel().
> Not sure if it would be worth having variants that are purely
> dereference-based, since we can just use PT_REGS_IP() due to
> the __builtin_preserve_access_index attributes applied in vmlinux.h.

Sorry, need a bit more time, thanks for the context.

>=20
> Thanks!
>=20
> Alan
>=20
> > Thanks,
> > Eduard
> >=20
> > ---
> > Below is annotated example, inpatient reader might skip it
> >=20
> > For the following test program:
> >=20
> >     #include "vmlinux.h"
> >     ...
> >     SEC("perf_event")
> >     int do_test(struct bpf_perf_event_data *ctx) {
> >       unsigned long p =3D PT_REGS_IP(&ctx->regs);
> >       unsigned long p_core =3D PT_REGS_IP_CORE(&ctx->regs);
> >       bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);
> >       return 0;
> >     }
> >=20
> > Generated BPF code looks as follows:
> >=20
> >     $ llvm-objdump --no-show-raw-insn -rd bpf.linked.o=20
> >     ...
> >     0000000000000000 <do_test>:
> >     # Third argument for bpf_probe_read_kernel: offset of bpf_perf_even=
t_data::regs.ip
> >            0:   r2 =3D 0x80
> >             0000000000000000:  CO-RE <byte_off> [2] struct bpf_perf_eve=
nt_data::regs.ip (0:0:16)
> >            1:   r3 =3D r1
> >            2:   r3 +=3D r2
> >     # The "non CO-RE" version of PT_REGS_IP is, in fact, CO-RE
> >     # because `struct bpf_perf_event_data` has preserve_access_index
> >     # tag in the vmlinux.h.
> >     # Here the regs.ip is stored in r6 to be used after the call
> >     # to bpf_probe_read_kernel() (from PT_REGS_IP_CORE).
> >            3:   r6 =3D *(u64 *)(r1 + 0x80)
> >             0000000000000018:  CO-RE <byte_off> [2] struct bpf_perf_eve=
nt_data::regs.ip (0:0:16)
> >     # First argument for bpf_probe_read_kernel: a place on stack to put=
 read result to.
> >            4:   r1 =3D r10
> >            5:   r1 +=3D -0x8
> >     # Second argument for bpf_probe_read_kernel: the size of the field =
to read.
> >            6:   w2 =3D 0x8
> >     # Call to bpf_probe_read_kernel()
> >            7:   call 0x71
> >     # Fourth parameter of bpf_printk: p_core read from stack
> >     # (was written by call to bpf_probe_read_kernel)
> >            8:   r4 =3D *(u64 *)(r10 - 0x8)
> >     # First parameter of bpf_printk: control string
> >            9:   r1 =3D 0x0 ll
> >             0000000000000048:  R_BPF_64_64  .rodata
> >     # Second parameter of bpf_printk: size of the control string
> >           11:   w2 =3D 0x1b
> >     # Third parameter of bpf_printk: p (see addr 3)
> >           12:   r3 =3D r6
> >     # Call to bpf_printk
> >           13:   call 0x6
> >     ;   return 0;
> >           14:   w0 =3D 0x0
> >           15:   exit
> >    =20
> > I get the following BPF after all verifier rewrites are applied
> > (including verifier.c:convert_ctx_accesses()):
> >=20
> >     # ./tools/bpf/bpftool/bpftool prog dump xlated id 114
> >     int do_test(struct bpf_perf_event_data * ctx):
> >     ; int do_test(struct bpf_perf_event_data *ctx) {
> >        0: (b7) r2 =3D 128                  | CO-RE replacement, 128 is =
a valid offset for
> >                                          | bpf_perf_event_data::regs.ip=
 in my kernel
> >        1: (bf) r3 =3D r1
> >        2: (0f) r3 +=3D r2
> >=20
> >        3: (79) r6 =3D *(u64 *)(r1 +0)      | This is an expantion of th=
e=20
> >        4: (79) r6 =3D *(u64 *)(r6 +128)    |   r6 =3D *(u64 *)(r1 + 0x8=
0)
> >        5: (bf) r1 =3D r10                  | Created by bpf_trace.c:pe_=
prog_convert_ctx_access()
> >=20
> >        6: (07) r1 +=3D -8
> >        7: (b4) w2 =3D 8
> >        8: (85) call bpf_probe_read_kernel#-91984
> >        9: (79) r4 =3D *(u64 *)(r10 -8)
> >       10: (18) r1 =3D map[id:59][0]+0
> >       12: (b4) w2 =3D 27
> >       13: (bf) r3 =3D r6
> >       14: (85) call bpf_trace_printk#-85520
> >       15: (b4) w0 =3D 0
> >       16: (95) exit
> >    =20
> >=20


