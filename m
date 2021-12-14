Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29F4749E1
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 18:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhLNRlt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 12:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhLNRlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 12:41:49 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE68C061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 09:41:49 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e136so48122451ybc.4
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 09:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aaI1HB8vdLhGUA6Yj3HhBHO4AJkDe1eAgJyiCtr3b9A=;
        b=EXqtwtZX0f6FAJ9JPz3wLkgaLjRCtDCmQehLkfUL9dzW6ibeSNEVjday6co1qpOcdj
         ZJyFOsHugZBAZOGe4lU2bfSI8kHqeRFfXQJiNwxrC8syAWhunPWlcLxRn2cIRSj6BF8c
         ptLmVOy0dwxO46v7KUKP5p8Cz+3eqE3MKDT+Ts5sZkobfzcaXLfRM9svJEcwkEJvK4hT
         y9KafwItx5RvFZR0aXJ56iH5NfsRTMkNJkU+qBzNoj9bU6+gJTwdTu5+9YX0udoMj59B
         7BGdL9XQBQP7VYwJS1J467zG5Ob9iIjir9ijMtZTSV9UKEM7gSn2KW7dFNylkkXs5zpx
         Vl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aaI1HB8vdLhGUA6Yj3HhBHO4AJkDe1eAgJyiCtr3b9A=;
        b=8An65vK50L0GDJMP8YkvdWo6dwSb0epDamz/HsO2Ox/v2EMHPfWTyUtvWzoXSJxFHK
         Ic8CKWSOmRvs4VoymNr4xJ96XUG43m62cQYtPt9/RedztekS9HZWr9jmTR7ZmUD7J8gE
         z5I2Iw6TE+44IRbYXaGgoGrF9TnQSVSbDIj3GG7xM5pMlj24uLnXtF2BJ93+ln9+I/C6
         wXc5QvaYe8j6ACouYbIgg3wpIQ13kEkKHiAXJ1lQ6IUNhVqsQhCJgKItWrmdyAEpLoj2
         QintpgjGsYRUx4cJkf+IKVVyXozCtFQhFtVjSBuKyMoyejgfpODjK+DpCNgSRiwZbv0b
         5ydw==
X-Gm-Message-State: AOAM53285TxfouNtBUFSZxW1a+SrLhbo4lru6vDztYr2otMKV7M3Y0py
        7FS2DgHJIawOGZFk0d3UTJWfxDSeweHyEugFdkVpInIFdNA=
X-Google-Smtp-Source: ABdhPJxmXjm1PFVVxibCXDUrKm1yPNCc4X3lfG5jOLEFwA/ss5vZPI+8rk4sZwt/9Yt0fqTy9Jqq04fWUcLyoS9i7AM=
X-Received: by 2002:a25:4cc5:: with SMTP id z188mr488038yba.248.1639503708310;
 Tue, 14 Dec 2021 09:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20211213182117.682461-1-christylee@fb.com> <20211213182117.682461-3-christylee@fb.com>
 <CAEf4BzZNc6RuhX278OTL4y6VDE16A-TtFXfOyo9tVJ=6hCrcsA@mail.gmail.com> <1936327A-395E-4A4B-9AD4-C22F49DF0B07@fb.com>
In-Reply-To: <1936327A-395E-4A4B-9AD4-C22F49DF0B07@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Dec 2021 09:41:36 -0800
Message-ID: <CAEf4BzbqZtH_EttnU3YWRMA9yAjzRTT6Df1KMxo-nEVgCtC85Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] Right align verifier states in verifier logs
To:     "Christy Lee-Eusman (PL&R)" <christylee@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 14, 2021 at 9:07 AM Christy Lee-Eusman (PL&R)
<christylee@fb.com> wrote:
>
>
>
> > On Dec 13, 2021, at 5:12 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
> >
> > On Mon, Dec 13, 2021 at 10:21 AM Christy Lee <christylee@fb.com> wrote:
> >>
> >> Make the verifier logs more readable, print the verifier states
> >> on the corresponding instruction line. If the previous line was
> >> not a bpf instruction, then print the verifier states on its own
> >> line.
> >>
> >> Before:
> >>
> >> Validating test_pkt_access_subprog3() func#3...
> >> 86: R1=3DinvP(id=3D0) R2=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
> >> ; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
> >> 86: (bf) r6 =3D r2
> >> 87: R2=3Dctx(id=3D0,off=3D0,imm=3D0) R6_w=3Dctx(id=3D0,off=3D0,imm=3D0=
)
> >> 87: (bc) w7 =3D w1
> >> 88: R1=3DinvP(id=3D0) R7_w=3DinvP(id=3D0,umax_value=3D4294967295,var_o=
ff=3D(0x0; 0xffffffff))
> >> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123=
));
> >> 88: (bf) r1 =3D r6
> >> 89: R1_w=3Dctx(id=3D0,off=3D0,imm=3D0) R6_w=3Dctx(id=3D0,off=3D0,imm=
=3D0)
> >> 89: (85) call pc+9
> >> Func#4 is global and valid. Skipping.
> >> 90: R0_w=3DinvP(id=3D0)
> >> 90: (bc) w8 =3D w0
> >> 91: R0_w=3DinvP(id=3D0) R8_w=3DinvP(id=3D0,umax_value=3D4294967295,var=
_off=3D(0x0; 0xffffffff))
> >> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123=
));
> >> 91: (b7) r1 =3D 123
> >> 92: R1_w=3DinvP123
> >> 92: (85) call pc+65
> >> Func#5 is global and valid. Skipping.
> >> 93: R0=3DinvP(id=3D0)
> >>
> >> After:
> >>
> >> Validating test_pkt_access_subprog3() func#3...
> >> 86: R1=3DinvP(id=3D0) R2=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
> >> ; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
> >> 86: (bf) r6 =3D r2               ; R2=3Dctx(id=3D0,off=3D0,imm=3D0) R6=
_w=3Dctx(id=3D0,off=3D0,imm=3D0)
> >> 87: (bc) w7 =3D w1               ; R1=3DinvP(id=3D0) R7_w=3DinvP(id=3D=
0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff))
> >> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123=
));
> >> 88: (bf) r1 =3D r6               ; R1_w=3Dctx(id=3D0,off=3D0,imm=3D0) =
R6_w=3Dctx(id=3D0,off=3D0,imm=3D0)
> >> 89: (85) call pc+9
> >> Func#4 is global and valid. Skipping.
> >> 90: R0_w=3DinvP(id=3D0)
> >> 90: (bc) w8 =3D w0               ; R0_w=3DinvP(id=3D0) R8_w=3DinvP(id=
=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff))
> >> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123=
));
> >> 91: (b7) r1 =3D 123              ; R1_w=3DinvP123
> >> 92: (85) call pc+65
> >> Func#5 is global and valid. Skipping.
> >> 93: R0=3DinvP(id=3D0)
> >
> > This is a huge improvement, makes the log so much more useful. But if
> > it's not available in log_level =3D 1 most people will never get to
> > enjoy the benefits. I think we should absolutely do this for all
> > log_levels. It might increase the size of the log for log_level in
> > terms of number of bytes emitted into the log, but the clarity of
> > what's going on is totally worth it.
> >
> > But I'm also confused why it's not available with log_level =3D 2 for
> > successfully verified programs. Do you have any idea. Running sudo
> > ./test_progs -t log_buf -v, I get this for "GOOD_PROG" case (which
> > uses log_level 2):
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > GOOD_PROG LOG:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > func#0 @0
> > arg#0 reference type('UNKNOWN ') size cannot be determined: -22
> > 0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
> > ; a[0] =3D (int)(long)ctx;
> > 0: (18) r2 =3D 0xffffc90000572000
> > 2: R2_w=3Dmap_value(id=3D0,off=3D0,ks=3D4,vs=3D16,imm=3D0)
>
> For correctness reasons, when we print verifier state, I check that the c=
urrent
> instruction index is previous instruction Index + 1. In this case, the lo=
gs skipped
> Printing out instruction index 1, so the state at 2 is not aligned to ins=
truction 0.

That sounds like some bug in verifier's logging? Can you please see if
you can fix that as part of your patch set then?

>
> > 2: (63) *(u32 *)(r2 +0) =3D r1
> > R1=3Dctx(id=3D0,off=3D0,imm=3D0) R2_w=3Dmap_value(id=3D0,off=3D0,ks=3D4=
,vs=3D16,imm=3D0)
>
> In this case the verifier state is printed =E2=80=9Cout-of-band=E2=80=9D =
from instruction index, so I
> didn't align it. Now that I think about it though, I can do an additional=
 check to
> see if the line printed before the verifier state is an instruction line =
and align it
> correspondingly.
>
> > from 2 to 3:
> > ; return a[1];
> > 3: (61) r0 =3D *(u32 *)(r2 +4)
> > R2_w=3Dmap_value(id=3D0,off=3D0,ks=3D4,vs=3D16,imm=3D0)
> >
> > from 3 to 4:
> > ; return a[1];
> > 4: (95) exit
> > processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> >
> >
> > No right alignment :( What am I missing?
> >
> >
> > Also, your changes broke lots of test_progs, please see [0] and fix
> > them. Thanks.
> >
> >  [0] https://github.com/kernel-patches/bpf/runs/4513474703?check_suite_=
focus=3Dtrue
>
> Thanks for pointing it out! Looks like the latest rebase broke this, I=E2=
=80=99ll fix this right away!

great, thanks

> >
> >>
> >> Signed-off-by: Christy Lee <christylee@fb.com>
> >> ---
> >> include/linux/bpf_verifier.h                  |   2 +
> >> kernel/bpf/verifier.c                         |  26 ++-
> >> .../testing/selftests/bpf/prog_tests/align.c  | 196 ++++++++++--------
> >> 3 files changed, 131 insertions(+), 93 deletions(-)
> >>
> >
> > [...]
>
