Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B186F0E39
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 00:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbjD0WP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 18:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344058AbjD0WP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 18:15:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1551FCF
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:15:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-508418b6d59so16617868a12.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682633754; x=1685225754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyORH25dz9NxaZ0rNqbGE7C718lKWHjQGKyFg8Vl/Bg=;
        b=LkNuBkhxbCk6Di+5FSTzkK+bhpzRWZe+48kh17cHtEBJwRjDDU0Je5BDPouRdIln0H
         /q3yGky48zPcXfOuDRay6OoZsiHu+pr49XNr6El+e5oP6obG2RZEE+4GcTyLEK06eDzy
         wgt8qmgEFohLWOlSjZORM8FmR+h79hIwLdF+6Vzb/Gsq9LtsUcYhtw+sco6YGGvlGBsg
         ljgiLxaGTBjm3zPaG6XSnaoqaQhybYVwsquDIECcFjMPpB9R9Aa5Nq/l/H2d7vb9TIyl
         koRsidrvnXtfDaBKKuL+OFX2PRnDqrwlipqqzRTONW44qnXUjPXd8R6BxZDSmqFnpLPd
         gX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633754; x=1685225754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyORH25dz9NxaZ0rNqbGE7C718lKWHjQGKyFg8Vl/Bg=;
        b=e5c/R7fbqc3JIQoc6Ge1yZ7UzOb3o9KCdsREt5Ao5N0pFu3CGi7NJ869QDp1ula4S/
         nb4kuBLQR42GkPcs/IxgPOURVII5Mz9oLqRaFAlt1ZN7nXmTqJk74JOTzyaBsRaUJiKv
         hIcp2kdQg2WrWzihwdtBbVem84qB8NB3oAtYZ8T2pCqgmw3+2DqdcuupXc8fwUxRgB9R
         duhPzIA6r5nhQcrDhHL4naWIXBaKDn1l9DNnMY52Pr1qLmYmGEXiArWUJKj5Bp9iFw6G
         rZF8+wdbS4yWHpXjWW3Ym9chpeXTwLSz1nMPy7HIbNsSlM9n1QiragFkLBGUi1v5CjhQ
         Asyg==
X-Gm-Message-State: AC+VfDyJgbL5Bu2WMiKUxpym3Y9lVLqeiLD9lojG4s7L3g6OsnhWG94W
        461e2NFAjIFc+pCoF9qRT1ZyKgpdvhDH6npMtmc=
X-Google-Smtp-Source: ACHHUZ5oivBWg0IANVMsgaeyehq2qa/uQjgFabroK0gdIeeP76zV3gm7Xc+no7LqBXesUzKTSF0nSRx1HRiMj9ViD1Y=
X-Received: by 2002:a05:6402:485:b0:506:bb0e:bc4e with SMTP id
 k5-20020a056402048500b00506bb0ebc4emr2751117edv.39.1682633753709; Thu, 27 Apr
 2023 15:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230427001425.563232-1-namhyung@kernel.org> <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
 <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
 <CAEf4BzaZhjgPNaNH2yFxjZ-C+ZaSJRg9EWzOCcMOP-CV7kDHBA@mail.gmail.com> <ZEn/EOnsH2RP//24@google.com>
In-Reply-To: <ZEn/EOnsH2RP//24@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Apr 2023 15:15:41 -0700
Message-ID: <CAEf4BzZHS5NprN2ya03Re_1hvC0nNyz_qYEhbD=sGou+m=OWHw@mail.gmail.com>
Subject: Re: [HELP] failed to resolve CO-RE relocation
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 9:53=E2=80=AFPM Namhyung Kim <namhyung@gmail.com> w=
rote:
>
> On Wed, Apr 26, 2023 at 09:26:59PM -0700, Andrii Nakryiko wrote:
> > On Wed, Apr 26, 2023 at 7:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hello Andrii,
> > >
> > > On Wed, Apr 26, 2023 at 6:19=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 26, 2023 at 5:14=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > I'm having a problem of loading perf lock contention BPF program =
[1]
> > > > > on old kernels.  It has collect_lock_syms() to get the address of=
 each
> > > > > CPU's run-queue lock.  The kernel 5.14 changed the name of the fi=
eld
> > > > > so there's bpf_core_field_exists to check the name like below.
> > > > >
> > > > >         if (bpf_core_field_exists(rq_new->__lock))
> > > > >                 lock_addr =3D (__u64)&rq_new->__lock;
> > > > >         else
> > > > >                 lock_addr =3D (__u64)&rq_old->lock;
> > > >
> > > > I suspect compiler rewrites it to something like
> > > >
> > > >    lock_addr =3D (__u64)&rq_old->lock;
> > > >    if (bpf_core_field_exists(rq_new->__lock))
> > > >         lock_addr =3D (__u64)&rq_new->__lock;
> > > >
> > > > so rq_old relocation always happens and ends up being not guarded
> > > > properly. You can try adding barrier_var(rq_new) and
> > > > barrier_var(rq_old) around if and inside branches, that should
> > > > pessimize compiler
> > > >
> > > > alternatively if you do
> > > >
> > > > if (bpf_core_field_exists(rq_new->__lock))
> > > >     lock_addr =3D (__u64)&rq_new->__lock;
> > > > else if (bpf_core_field_exists(rq_old->lock))
> > > >     lock_addr =3D (__u64)&rq_old->lock;
> > > > else
> > > >     lock_addr =3D 0; /* or signal error somehow */
> > > >
> > > > It might work as well.
> > >
> > > Thanks a lot for your comment!
> > >
> > > I've tried the below code but no luck. :(
> >
> > Can you post an output of llvm-objdump -d <your.bpf.o> of the program
> > (collect_lock_syms?) containing above code (or at least relevant
> > portions with some buffer before/after to get a sense of what's going
> > on)
>
> Sure.
>
> Here's the full source code:
>
>   SEC("raw_tp/bpf_test_finish")
>   int BPF_PROG(collect_lock_syms)
>   {
>         __u64 lock_addr;
>         __u32 lock_flag;
>
>         for (int i =3D 0; i < MAX_CPUS; i++) {
>                 struct rq *rq =3D bpf_per_cpu_ptr(&runqueues, i);
>                 struct rq___new *rq_new =3D (void *)rq;
>                 struct rq___old *rq_old =3D (void *)rq;
>
>                 if (rq =3D=3D NULL)
>                         break;
>
>                 barrier_var(rq_old);
>                 barrier_var(rq_new);
>
>                 if (bpf_core_field_exists(rq_old->lock)) {
>                         barrier_var(rq_old);
>                         lock_addr =3D (__u64)&rq_old->lock;
>                 } else if (bpf_core_field_exists(rq_new->__lock)) {
>                         barrier_var(rq_new);
>                         lock_addr =3D (__u64)&rq_new->__lock;
>                 } else
>                         continue;
>
>                 lock_flag =3D LOCK_CLASS_RQLOCK;
>                 bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, B=
PF_ANY);
>         }
>         return 0;
>   }
>
> And the disassembly is:
>
>   $ llvm-objdump -d util/bpf_skel/.tmp/lock_contention.bpf.o
>   ...
>   Disassembly of section raw_tp/bpf_test_finish:
>
>   0000000000000000 <collect_lock_syms>:
>        0:       b7 06 00 00 00 00 00 00 r6 =3D 0
>        1:       b7 07 00 00 01 00 00 00 r7 =3D 1
>        2:       b7 09 00 00 01 00 00 00 r9 =3D 1
>        3:       b7 08 00 00 00 00 00 00 r8 =3D 0
>
>   0000000000000020 <LBB3_1>:
>        4:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0 =
ll
>        6:       bf 62 00 00 00 00 00 00 r2 =3D r6
>        7:       85 00 00 00 99 00 00 00 call 153
>        8:       15 00 12 00 00 00 00 00 if r0 =3D=3D 0 goto +18 <LBB3_8>
>        9:       bf 01 00 00 00 00 00 00 r1 =3D r0
>       10:       15 07 12 00 00 00 00 00 if r7 =3D=3D 0 goto +18 <LBB3_4>
>       11:       0f 81 00 00 00 00 00 00 r1 +=3D r8
>
>   0000000000000060 <LBB3_6>:
>       12:       63 9a f4 ff 00 00 00 00 *(u32 *)(r10 - 12) =3D r9
>       13:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) =3D r1
>       14:       bf a2 00 00 00 00 00 00 r2 =3D r10
>       15:       07 02 00 00 f8 ff ff ff r2 +=3D -8
>       16:       bf a3 00 00 00 00 00 00 r3 =3D r10
>       17:       07 03 00 00 f4 ff ff ff r3 +=3D -12
>       18:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0 =
ll
>       20:       b7 04 00 00 00 00 00 00 r4 =3D 0
>       21:       85 00 00 00 02 00 00 00 call 2
>
>   00000000000000b0 <LBB3_7>:
>       22:       07 06 00 00 01 00 00 00 r6 +=3D 1
>       23:       bf 61 00 00 00 00 00 00 r1 =3D r6
>       24:       67 01 00 00 20 00 00 00 r1 <<=3D 32
>       25:       77 01 00 00 20 00 00 00 r1 >>=3D 32
>       26:       55 01 e9 ff 00 04 00 00 if r1 !=3D 1024 goto -23 <LBB3_1>
>
>   00000000000000d8 <LBB3_8>:
>       27:       b7 00 00 00 00 00 00 00 r0 =3D 0
>       28:       95 00 00 00 00 00 00 00 exit
>
>   00000000000000e8 <LBB3_4>:
>       29:       b7 01 00 00 01 00 00 00 r1 =3D 1
>       30:       15 01 f7 ff 00 00 00 00 if r1 =3D=3D 0 goto -9 <LBB3_7>
>       31:       b7 01 00 00 00 00 00 00 r1 =3D 0
>       32:       0f 10 00 00 00 00 00 00 r0 +=3D r1
>       33:       bf 01 00 00 00 00 00 00 r1 =3D r0
>       34:       05 00 e9 ff 00 00 00 00 goto -23 <LBB3_6>
>
> The error message is like this:
>
>   libbpf: prog 'collect_lock_syms': BPF program load failed: Invalid argu=
ment
>   libbpf: prog 'collect_lock_syms': -- BEGIN PROG LOAD LOG --
>   reg type unsupported for arg#0 function collect_lock_syms#380
>   0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>   ; int BPF_PROG(collect_lock_syms)
>   0: (b7) r6 =3D 0                        ; R6_w=3D0
>   1: (b7) r7 =3D 0                        ; R7_w=3D0
>   2: (b7) r9 =3D 1                        ; R9_w=3D1
>   3: <invalid CO-RE relocation>
>   failed to resolve CO-RE relocation <byte_off> [381] struct rq___old.loc=
k (0:0 @ offset 0)
>   processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
>   libbpf: prog 'collect_lock_syms': failed to load: -22
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -22
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed
>
>

Ok, I didn't manage to force compiler to behave as long as
`&rq_old->lock` pattern was used. So I went for a different approach.
This works:

$ git diff
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c
b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 8911e2a077d8..8d3cfbb3cc65 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -418,32 +418,32 @@ int contention_end(u64 *ctx)

 extern struct rq runqueues __ksym;

-struct rq__old {
+struct rq___old {
        raw_spinlock_t lock;
 } __attribute__((preserve_access_index));

-struct rq__new {
+struct rq___new {
        raw_spinlock_t __lock;
 } __attribute__((preserve_access_index));

 SEC("raw_tp/bpf_test_finish")
 int BPF_PROG(collect_lock_syms)
 {
-       __u64 lock_addr;
+       __u64 lock_addr, lock_off;
        __u32 lock_flag;

+       if (bpf_core_field_exists(struct rq___new, __lock))
+               lock_off =3D offsetof(struct rq___new, __lock);
+       else
+               lock_off =3D offsetof(struct rq___old, lock);
+
        for (int i =3D 0; i < MAX_CPUS; i++) {
                struct rq *rq =3D bpf_per_cpu_ptr(&runqueues, i);
-               struct rq__new *rq_new =3D (void *)rq;
-               struct rq__old *rq_old =3D (void *)rq;

                if (rq =3D=3D NULL)
                        break;

-               if (bpf_core_field_exists(rq_new->__lock))
-                       lock_addr =3D (__u64)&rq_new->__lock;
-               else
-                       lock_addr =3D (__u64)&rq_old->lock;
+               lock_addr =3D (__u64)(void *)rq + lock_off;
                lock_flag =3D LOCK_CLASS_RQLOCK;
                bpf_map_update_elem(&lock_syms, &lock_addr,
&lock_flag, BPF_ANY);
        }


> Thanks,
> Namhyung
>
>
