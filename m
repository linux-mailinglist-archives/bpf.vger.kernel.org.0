Return-Path: <bpf+bounces-14009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8807DFAA2
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 20:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4801D1C20FD6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F92134A;
	Thu,  2 Nov 2023 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bftowuw9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA11BDF0
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 19:04:31 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAAE1FE4;
	Thu,  2 Nov 2023 12:01:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d10f94f70bso190690966b.3;
        Thu, 02 Nov 2023 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698951716; x=1699556516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifGnPdp78leEm8TF8GcQ6NdohnpOfA0bs4O5R/OYdS0=;
        b=bftowuw9fxm5FezwOluOaECx8od2BlSFkYLjj6D5Bc5BsqBJqvZ3N2+QsjcK8J3nm8
         yS/GF9r7j7MbLxymENSCtqHaxdWsPHZbFfSh+/GJtuzt7Xa9E1dhMsbvah8aL0oOFC4h
         8uC9ZVdM3ou5uFFu3jGzxOnrn5Na09QJvzw8etDceibYQEFB9bmydjRjEDF1OmSx0BoN
         +43wTMMdukkRjaKMHJ5BuoM+hxN/tNX1nFv1h/XAGiEQLbBUCfkR1LZe2Um0llay5RgS
         CUsG8BuWxp3GtN6ngCk07zQettmf4qI242m1ndqWWtt13m/pgUFtECkDR0SD0pB3zGRL
         i6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951716; x=1699556516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifGnPdp78leEm8TF8GcQ6NdohnpOfA0bs4O5R/OYdS0=;
        b=ijZID6sLIvN0bzVY4N6o7feghpwVJGROlLbHi87zQwps2HEY3tYh7Jh8hBlSPgLAm0
         kxyRuLCdJVxekguhqfEZEgTStB0/6v7ymtnhGAHOfyPCPNV+DYT1cS3VN4VIRWRf6HlV
         3AvweJ5SwBuZOffI2+Nu/cfQMlkN4jk5+C1IjAEqACuCuZZiQMSuvSYwfb/V2tnw1nW0
         sSWa7wIVIrI6TKmtgny7w5Zn2Cp2VK5nc/wZOB54IuSt7UlABzjVBcTsSXmrJ7PSVvfZ
         91QhUUh+v7AdOPzusDlFZfpRhzkYNlJ1/0A6EzifaP3Wv8au0FsLHV1czUceJg+KAsPK
         /c4w==
X-Gm-Message-State: AOJu0Yy/Q3SoHEeZ6PKUH6m2INgr9dQjhZ1HW1rPrcjbO8f9/eCi8thz
	nZC0eMDSbKj4fegL+oUYY1M52Dl1zOzXdO5kCeU=
X-Google-Smtp-Source: AGHT+IHNwR57IhzCX+H5PazBzQK6fP/65bHupUZWqtHI8AIq8RW79acIHA9KfkskZFZ1HjpDlYmLSgZ5ZF6+KYJh6KY=
X-Received: by 2002:a17:906:ee85:b0:9be:dce3:6e07 with SMTP id
 wt5-20020a170906ee8500b009bedce36e07mr5508068ejb.32.1698951716320; Thu, 02
 Nov 2023 12:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY3vMLVVO0zHd+CRcQPdykDhXv8-f2oD82+Jk5KJpq_8w@mail.gmail.com>
 <CAEf4BzbDK15myKbN4sM+cxFvfWCNjthJuFZf81k6OEBpaC124g@mail.gmail.com> <CACkBjsbpttp2L0=oi7-0+SLNC8wSxkPbG7ZYZuWOmurNxELT-Q@mail.gmail.com>
In-Reply-To: <CACkBjsbpttp2L0=oi7-0+SLNC8wSxkPbG7ZYZuWOmurNxELT-Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 12:01:44 -0700
Message-ID: <CAEf4BzbucupXssMKLhR5Ex4rOHupp8p19CRV6qi1dT+X_5QWJg@mail.gmail.com>
Subject: Re: bpf: incorrectly reject program with `back-edge insn from 7 to 8`
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 3:30=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote:
>
> On Wed, Nov 1, 2023 at 9:57=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Nov 1, 2023 at 6:56=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wr=
ote:
> > >
> > > Hi,
> > >
> > > The verifier incorrectly rejects the following prog in check_cfg() wh=
en
> > > loading with root with confusing log `back-edge insn from 7 to 8`:
> > >   /* 0: r9 =3D 2
> > >    * 1: r3 =3D 0x20
> > >    * 2: r4 =3D 0x35
> > >    * 3: r8 =3D r4
> > >    * 4: goto+3
> > >    * 5: r9 -=3D r3
> > >    * 6: r9 -=3D r4
> > >    * 7: r9 -=3D r8
> > >    * 8: r8 +=3D r4
> > >    * 9: if r8 < 0x64 goto-5
> > >    * 10: r0 =3D r9
> > >    * 11: exit
> > >    * */
> > >   BPF_MOV64_IMM(BPF_REG_9, 2),
> > >   BPF_MOV64_IMM(BPF_REG_3, 0x20),
> > >   BPF_MOV64_IMM(BPF_REG_4, 0x35),
> > >   BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
> > >   BPF_JMP_IMM(BPF_JA, 0, 0, 3),
> > >   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_3),
> > >   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_4),
> > >   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8),
> > >   BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_4),
> > >   BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0x68, -5),
> > >   BPF_MOV64_REG(BPF_REG_0, BPF_REG_9),
> > >   BPF_EXIT_INSN()
> > >
> > > -------- Verifier Log --------
> > > func#0 @0
> > > back-edge from insn 7 to 8
> > > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states =
0
> > > peak_states 0 mark_read 0
> > >
> > > This is not intentionally rejected, right?
> >
> > The way you wrote it, with goto +3, yes, it's intentional. Note that
> > you'll get different results in privileged and unprivileged modes.
> > Privileged mode allows "bounded loops" logic, so it doesn't
> > immediately reject this program, and then later sees that r8 is always
> > < 0x64, so program is correct.
> >
>
> I load the program with privileged mode, and goto-5 makes the program
> run from #9 to #5, so r8 is updated and the program is not infinite loop.
>
> > But in unprivileged mode the rules are different, and this conditional
> > back edge is not allowed, which is probably what you are getting.
> >
> > It's actually confusing and your "back-edge from insn 7 to 8" is out
> > of date and doesn't correspond to your program, you should see
> > "back-edge from insn 11 to 7", please double check.
> >
>
> Yes it's also confusing to me, but "back-edge from insn 7 to 8" is what
> I got. The execution path of the program is #4 to #8 (goto+3), so the
> verifier see the #8 first. Then, the program then goes #9 to #5 (goto-5),
> the verifier thus sees #7 to #8 and incorrectly concludes back-edge here.
>
> This can is the verifier log I got from latest bpf-next, this C program c=
an
> reproduce this: https://pastebin.com/raw/Yug0NVwx

Your instruction indices in your comments are wrong. Save yourself
time and confusion, use embedded assembly and llvm-objdump. You also
have a mismatch between 0x64 and actually specifying 0x68. Anyways, I
don't know how you got 7 to 8, but there does seem indeed to be a bug
in check_cfg() falsely detecting this as an infinite loop even in
privileged mode, which it should. I'll need to look deeper into how to
fix check_cfg(), it's not the easier to follow code, unfortunately.

But here's my log for your information.


$ git show
commit a343e644b8f3757a83f48b32b56ffc83943a62fa (HEAD -> temp-back-edge-tes=
t)
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Thu Nov 2 11:55:11 2023 -0700

    selftests/bpf: trickier case of "bounded loop"

    This should be accepted in privileged mode because r8 =3D 2 * r4 =3D 0x=
6a,
    and so `if r8 < 0x64 goto -5;` is always false. Currently BPF verifier'=
s
    check_cfg() doesn't detect this properly.

    Reported-by: Hao Sun <sunhao.th@gmail.com>
    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c
b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index df7697b94007..f89dce7850f6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -97,4 +97,26 @@ l0_%=3D:       r2 =3D r0;
         \
 "      ::: __clobber_all);
 }

+SEC("socket")
+__description("conditional loop (2)")
+__success
+__failure_unpriv __msg_unpriv("back-edge from insn 10 to 11")
+__naked void conditional_loop2(void)
+{
+       asm volatile ("                                 \
+       r9 =3D 2 ll;                                      \
+       r3 =3D 0x20 ll;                                   \
+       r4 =3D 0x35 ll;                                   \
+       r8 =3D r4;                                        \
+       goto l1_%=3D;                                     \
+l0_%=3D: r9 -=3D r3;                                       \
+       r9 -=3D r4;                                       \
+       r9 -=3D r8;                                       \
+l1_%=3D: r8 +=3D r4;                                       \
+       if r8 < 0x64 goto l0_%=3D;                        \
+       r0 =3D r9;                                        \
+       exit;                                           \
+"      ::: __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";

Here's disassembly (though I moved it to separate .bpf.c file to have
0-based instruction indices, my patch above adds test to other
existing tests):

$ llvm-objdump -d verifier_cfg1.bpf.o

verifier_cfg1.bpf.o:    file format elf64-bpf

Disassembly of section socket:

0000000000000000 <conditional_loop2>:
       0:       18 09 00 00 02 00 00 00 00 00 00 00 00 00 00 00 r9 =3D 0x2 =
ll
       2:       18 03 00 00 20 00 00 00 00 00 00 00 00 00 00 00 r3 =3D 0x20=
 ll
       4:       18 04 00 00 35 00 00 00 00 00 00 00 00 00 00 00 r4 =3D 0x35=
 ll
       6:       bf 48 00 00 00 00 00 00 r8 =3D r4
       7:       05 00 03 00 00 00 00 00 goto +0x3 <l1_0>

0000000000000040 <l0_0>:
       8:       1f 39 00 00 00 00 00 00 r9 -=3D r3
       9:       1f 49 00 00 00 00 00 00 r9 -=3D r4
      10:       1f 89 00 00 00 00 00 00 r9 -=3D r8

0000000000000058 <l1_0>:
      11:       0f 48 00 00 00 00 00 00 r8 +=3D r4
      12:       a5 08 fb ff 64 00 00 00 if r8 < 0x64 goto -0x5 <l0_0>
      13:       bf 90 00 00 00 00 00 00 r0 =3D r9
      14:       95 00 00 00 00 00 00 00 exit

Then running test on latest bpf-next:

$ sudo ./test_progs -t verifier_cfg
...
run_subtest:PASS:obj_open_mem 0 nsec
libbpf: prog 'conditional_loop2': BPF program load failed: Invalid argument
libbpf: prog 'conditional_loop2': failed to load: -22
libbpf: failed to load object 'verifier_cfg'
run_subtest:FAIL:unexpected_load_failure unexpected error: -22 (errno 22)
VERIFIER LOG:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
10: asm volatile ("                                     \
back-edge from insn 10 to 11
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#329/15  verifier_cfg/conditional loop (2):FAIL
#329/16  verifier_cfg/conditional loop (2) @unpriv:OK
#329     verifier_cfg:FAIL


I'll keep looking into this after taking care of other stuff I have on
TODO list, thanks.



>
> > Anyways, while I was looking into this, I realized that ldimm64 isn't
> > handled exactly correctly in check_cfg(), so I just sent a fix. It
> > also adds a nicer detection of jumping into the middle of the ldimm64
> > instruction, which I believe is something you were advocating for.
> >
> > >
> > > Best
> > > Hao

