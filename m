Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44F53B5B29
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 11:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhF1JYU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1JYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 05:24:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09BC061574
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 02:21:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h2so21372232iob.11
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g5qZKYCziA7AuQxCTs0bsrOVVtxbtzYl4YkIRBhbMdY=;
        b=oPilTdUORmoFChQtQHAur9BRTUyAt+bx8m4zEjslRSu+4957dYnJyUMZrn/7u/6NM/
         1iAeqmch1rYLex/V0cL+iNFYcXpBm37QWML4SHi6AxkNe3lyYnL8+ynmaEXmkY3re3lP
         BSuwJe7zqxVRPLjfDWbdv/JUxG+QWOy5degvBQbXfb+N41yknz4BJRyrwiNYnz7noyRP
         pRMrgvZm/dT4q4hGoD4TZTFHUaoX1DzZsk1y5bVyS0UQEF7oeG23/9M4wHA++vuxoYM/
         soWSiv5mI7EfT57r9kgS6kKI7PgCXu9b5ZNqiS3+2qxk6BvOigjz9ypacdg8sLFiK0VK
         /8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g5qZKYCziA7AuQxCTs0bsrOVVtxbtzYl4YkIRBhbMdY=;
        b=uIb9BKaRgdDdWBDueTKPkjuAGLrd3UGm+WTIL2U9paOWMlYGNxk1KIrgaeOyNsTQBk
         N67boyTnOE3iGo1H3SYyPM29C+C6ZHtEbcMbkXfzEAipYayeAN9XTXeCGVtgHPKXpzY5
         dyR0b0w+UnanuwDo8xRtn42VQlMy72fJ0jf8E3dOIV/35+9qjUduVoW9YF6yu0Q+rEAt
         aahkPNlxny6rhENU7ZoTLms5M68ZvxQrx9bLZAaVQHqPMY+NOqWUpqEHGi+J3amlbPtJ
         nrPEhfU1hE3LNm4sxzzSddcyIxwiGSu/ePPWsC8mCGJ9nX8xdEjBPssWQpoB9r+lQb7k
         RMOA==
X-Gm-Message-State: AOAM5324HC+u7t2jPDqgZICqrzbC54U5Tr9xumIWqd0wO/472h1POlFV
        UTfszeHPc8IHuXxzslFNR051UnduEPb7askvR5a3Dg==
X-Google-Smtp-Source: ABdhPJxUbfn1wSSECM+UbA4gdXecnfYeVXyNH+ktzq7tT06Xqil8KMgKV1wL53rBDZufvAcDvC/PT3WfER1bmCjOTnc=
X-Received: by 2002:a05:6602:25da:: with SMTP id d26mr20362529iop.106.1624872113955;
 Mon, 28 Jun 2021 02:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210202135002.4024825-1-jackmanb@google.com> <YNiadhIbJBBPeOr6@krava>
In-Reply-To: <YNiadhIbJBBPeOr6@krava>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 28 Jun 2021 11:21:42 +0200
Message-ID: <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 27 Jun 2021 at 17:34, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Feb 02, 2021 at 01:50:02PM +0000, Brendan Jackman wrote:
>
> SNIP
>
> > diff --git a/tools/testing/selftests/bpf/verifier/atomic_bounds.c b/too=
ls/testing/selftests/bpf/verifier/atomic_bounds.c
> > new file mode 100644
> > index 000000000000..e82183e4914f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> > @@ -0,0 +1,27 @@
> > +{
> > +     "BPF_ATOMIC bounds propagation, mem->reg",
> > +     .insns =3D {
> > +             /* a =3D 0; */
> > +             /*
> > +              * Note this is implemented with two separate instruction=
s,
> > +              * where you might think one would suffice:
> > +              *
> > +              * BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > +              *
> > +              * This is because BPF_ST_MEM doesn't seem to set the sta=
ck slot
> > +              * type to 0 when storing an immediate.
> > +              */
> > +             BPF_MOV64_IMM(BPF_REG_0, 0),
> > +             BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> > +             /* b =3D atomic_fetch_add(&a, 1); */
> > +             BPF_MOV64_IMM(BPF_REG_1, 1),
> > +             BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BP=
F_REG_1, -8),
> > +             /* Verifier should be able to tell that this infinite loo=
p isn't reachable. */
> > +             /* if (b) while (true) continue; */
> > +             BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -1),
> > +             BPF_EXIT_INSN(),
> > +     },
> > +     .result =3D ACCEPT,
> > +     .result_unpriv =3D REJECT,
> > +     .errstr_unpriv =3D "back-edge",
> > +},
> >
> > base-commit: 61ca36c8c4eb3bae35a285b1ae18c514cde65439
> > --
> > 2.30.0.365.g02bc693789-goog
> >
>
> hi,
> I tracked soft lock up on powerpc to this test:
>
>         [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 25
>         #25/u BPF_ATOMIC bounds propagation, mem->reg SKIP
>         #25/p BPF_ATOMIC bounds propagation, mem->reg
>
>         Message from syslogd@ibm-p9z-07-lp1 at Jun 27 11:24:34 ...
>          kernel:watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_v=
erifier:1055]
>
>         Message from syslogd@ibm-p9z-07-lp1 at Jun 27 11:25:04 ...
>          kernel:watchdog: BUG: soft lockup - CPU#2 stuck for 48s! [test_v=
erifier:1055]
>
> please check the console output below.. it looks like the verifier
> allowed the loop to happen for some reason on powerpc.. any idea?
>
> I'm on latest bpf-next/master, I can send the config if needed
>
> thanks,
> jirka
>
>
> ---
> ibm-p9z-07-lp1 login: [  184.108655] watchdog: BUG: soft lockup - CPU#2 s=
tuck for 26s! [test_verifier:1055]
> [  184.108679] Modules linked in: snd_seq_dummy(E) snd_hrtimer(E) snd_seq=
(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) bonding(E) tls(E) rf=
kill(E) pseries_rng(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) xfs(E=
) libcrc32c(E) sd_mod(E) t10_pi(E) ibmvscsi(E) ibmveth(E) scsi_transport_sr=
p(E) vmx_crypto(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> [  184.108722] CPU: 2 PID: 1055 Comm: test_verifier Tainted: G           =
 E     5.13.0-rc3+ #3
> [  184.108728] NIP:  c00800000131314c LR: c000000000c56918 CTR: c00800000=
1313118
> [  184.108733] REGS: c0000000119ef820 TRAP: 0900   Tainted: G            =
E      (5.13.0-rc3+)
> [  184.108739] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 4422284=
0  XER: 20040003
> [  184.108752] CFAR: c008000001313150 IRQMASK: 0
> [  184.108752] GPR00: c000000000c5671c c0000000119efac0 c000000002a08400 =
0000000000000001
> [  184.108752] GPR04: c0080000010c0048 ffffffffffffffff 0000000001f3f8ec =
0000000000000008
> [  184.108752] GPR08: 0000000000000000 c0000000119efae8 0000000000000001 =
49adb8fcb8417937
> [  184.108752] GPR12: c008000001313118 c00000001ecae400 0000000000000000 =
0000000000000000
> [  184.108752] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
c0000000021cf6f8
> [  184.108752] GPR20: 0000000000000000 c0000000119efc34 c0000000119efc30 =
c0080000010c0048
> [  184.108752] GPR24: c00000000a1dc100 0000000000000001 c000000011fadc80 =
c0000000021cf638
> [  184.108752] GPR28: c0080000010c0000 0000000000000001 c0000000021cf638 =
c0000000119efaf0
> [  184.108812] NIP [c00800000131314c] bpf_prog_a2eb9104e5e8a5bf+0x34/0xce=
e8
> [  184.108819] LR [c000000000c56918] bpf_test_run+0x2f8/0x470
> [  184.108826] Call Trace:
> [  184.108828] [c0000000119efac0] [c0000000119efb30] 0xc0000000119efb30 (=
unreliable)
> [  184.108835] [c0000000119efb30] [c000000000c5671c] bpf_test_run+0xfc/0x=
470
> [  184.108841] [c0000000119efc10] [c000000000c57b6c] bpf_prog_test_run_sk=
b+0x38c/0x660
> [  184.108848] [c0000000119efcb0] [c00000000035de6c] __sys_bpf+0x46c/0xd6=
0
> [  184.108854] [c0000000119efd90] [c00000000035e810] sys_bpf+0x30/0x40
> [  184.108859] [c0000000119efdb0] [c00000000002ea34] system_call_exceptio=
n+0x144/0x280
> [  184.108866] [c0000000119efe10] [c00000000000c570] system_call_vectored=
_common+0xf0/0x268
> [  184.108874] --- interrupt: 3000 at 0x7fff8bb3ef24
> [  184.108878] NIP:  00007fff8bb3ef24 LR: 0000000000000000 CTR: 000000000=
0000000
> [  184.108883] REGS: c0000000119efe80 TRAP: 3000   Tainted: G            =
E      (5.13.0-rc3+)
> [  184.108887] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE=
>  CR: 28000848  XER: 00000000
> [  184.108903] IRQMASK: 0
> [  184.108903] GPR00: 0000000000000169 00007fffe4577710 00007fff8bc27200 =
000000000000000a
> [  184.108903] GPR04: 00007fffe45777b8 0000000000000080 0000000000000001 =
0000000000000008
> [  184.108903] GPR08: 000000000000000a 0000000000000000 0000000000000000 =
0000000000000000
> [  184.108903] GPR12: 0000000000000000 00007fff8be1c400 0000000000000000 =
0000000000000000
> [  184.108903] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
> [  184.108903] GPR20: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
> [  184.108903] GPR24: 0000000000000000 0000000000000000 0000000000000000 =
000000001000d1d0
> [  184.108903] GPR28: 0000000000000002 00007fffe4578128 00007fffe45782c0 =
00007fffe4577710
> [  184.108960] NIP [00007fff8bb3ef24] 0x7fff8bb3ef24
> [  184.108964] LR [0000000000000000] 0x0
> [  184.108967] --- interrupt: 3000
> [  184.108970] Instruction dump:
> [  184.108974] 60000000 f821ff91 fbe10068 3be10030 39000000 f91ffff8 3860=
0001 393ffff8
> [  184.108985] 7d4048a8 7d4a1a14 7d4049ad 4082fff4 <28230000> 4082fffc 60=
000000 ebe10068

Hmm, is the test prog from atomic_bounds.c getting JITed there (my
dumb guess at what '0xc0000000119efb30 (unreliable)' means)? That
shouldn't happen - should get 'eBPF filter atomic op code %02x (@%d)
unsupported\n' in dmesg instead. I wonder if I missed something in
commit 91c960b0056 (bpf: Rename BPF_XADD and prepare to encode other
atomics in .imm). Any idea if this test was ever passing on PowerPC?
