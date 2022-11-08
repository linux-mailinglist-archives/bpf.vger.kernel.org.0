Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9362071C
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 04:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiKHDBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 22:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiKHDBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 22:01:49 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F642FFC5;
        Mon,  7 Nov 2022 19:01:48 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-370547b8ca0so122875757b3.0;
        Mon, 07 Nov 2022 19:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AHh9sau1gEMT5UjcED2pS6jwgKENXfptObNT/GNvsk=;
        b=T8TdWMiKO2p/hQOh3TlatOHlMQWnQ42yQeiyfDa3CaNQhqfKGaA6PDjAwtscCh5qHu
         n8l6WDGQ5PvEF7H5kobLyK20iQsbIMMsCyafsVZ/G0Tyvt09p4QLuo98zyk8Uav+cz8a
         7qsRS/IbANuYv2q6WkH/l8JSkQqu//qrBrCjepCDEhJDh5FCyoRGKA2LN5ZeNQHx3Y58
         y5Z2fFR48j6EwrPUGiWzNR5H5lgMwxpREqgRmQ43tRg+KcWuRSdvjW5gW+8b7w8I9U7y
         IqsYDcYcjClEjUbRXdU2FDwGeyoEq4sSccVBNaLky7hKzGCGdwxvmK+IfAGEN/iPDHVt
         bniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AHh9sau1gEMT5UjcED2pS6jwgKENXfptObNT/GNvsk=;
        b=6tLtkCHKsZUQEnMEzSoupHubRXi/f8pw7AM9W9jhp9iMpC9HuVl72UEY5K9Wg81rNz
         QFy+3/duPtdxqz+yNAywu5spqZUUz9S8YGzS2TLodr/cL3sAIHflwquXG8QScfyfcEdq
         gU0BfG5T13mY4/RpWi68MbvC5Uqjf0Spf/3PQZVF76ixrmfe/3ofsyzaR/3oEnkhYlEx
         aFPdS0SDIXtqVObDZ1v1Xo2nKA6dZOYVrznoE2yfboH4Z0TUqsUdJ49BGwBxL4DmSaXO
         QZN1uAbr4sDG2BKSrMb9mFaV58m0WjYnYjbHx/KKH8HSgxn/hCG8w02RER3FbhhGugPC
         U2rg==
X-Gm-Message-State: ACrzQf1ikYuIoP3lEyNdQQY6ZtSaU+4O+eXfJkKEfCKEb/On2XyvNYH6
        46bZvM7b+YTzIiB5/k9duVmKUWZ7gDLhRM9e8g==
X-Google-Smtp-Source: AMsMyM6hxr0AlGxfCMLSDkBzrF+n9phWyDOdB2NH9GAdrrkINBW/Y1144VzzZb2YDSxMr8KneTEUC/UvrEQr1kUU1x4=
X-Received: by 2002:a81:1b53:0:b0:373:6185:b72 with SMTP id
 b80-20020a811b53000000b0037361850b72mr29694003ywb.104.1667876507271; Mon, 07
 Nov 2022 19:01:47 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsaRPHUpfST=3-FTWbQycHsNgvWyVFpCLkJEwcrLhSZfnQ@mail.gmail.com>
 <CAADnVQLev0xX3wHm-dgD-eJcV0vkuvZ0Tm=X_P68qcUabKw8eA@mail.gmail.com>
In-Reply-To: <CAADnVQLev0xX3wHm-dgD-eJcV0vkuvZ0Tm=X_P68qcUabKw8eA@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 8 Nov 2022 11:01:36 +0800
Message-ID: <CACkBjsZFLrWXOFJTEP=w+cCFB=vL0tLQuec_QD20Fyt-9BLi6w@mail.gmail.com>
Subject: Re: BUG in BPF verifier, 10 insns costs 2 mins+ to load
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B411=
=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 04:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 6, 2022 at 8:26 PM Hao Sun <sunhao.th@gmail.com> wrote:
> >
> > Hi,
> >
> > I've just written a BPF verifier fuzzer, targeting logic bugs in the
> > BPF verifier.
> > The following is an abnormal case it generated. The case only contains =
10
> > BPF instructions but costs more than 2 mins to load on :
>
> with full verbose verifier logging, right?
> That is expected for any prog that is going to hit the 1M insn limit.
>

Hi,

Thanks for looking this.

No, `log_level` was set to 0 in this test. It takes more time if
enable verbose logging.
In this particular case, verifier should be able to exit at the first
time it meets BPF_JGT,
since R2=3D42 after insn 2, the test case essentially is like this:

0: r1 =3D 42
1: r2 =3D 0
2: r2 +=3D r1
3: r2 /=3D 1 (alu32)
4: r1 -=3D 108
5: if r1 > r2 goto -3

But R2=3D42 was lost, after the following check for insn 3:

check_alu_op
  -> adjust_scalar_min_max_vals
         -> switch (op_code) {
             default:
               mark_reg_unknown(env, regs, insn->dst_reg);
               break;
             }

So, `dst_reg` range information is lost for both `BPF_DIV` and `BPF_MOD` in=
sn.
I guess it's not easy to perform tracking over these ops in general
case, but should
we consider special cases like, devide by 1 and mod by 1, etc.

Also, I'm wondering if this behavior can be exploited, e.g., hind
actual value of particular
regs by deviding it by 1, then, trick verifier by adding a if
statement, finally, we get regs
with the value we want, something like this:

r0 =3D evil_val
r0 /=3D 1
if r0 > some_val goto X
at X:
verifier thinks r0 > some_val
but we know r0 equals evil_val

Just a random thought, no actual POC for this, any idea?

Regards
Hao

> >     HEAD commit: f0c4d9fc9cc9 Linux 6.1-rc4
> >     git tree: upstream
> >     kernel config: https://pastebin.com/raw/SBxaikiG
> >     C reproducer: https://pastebin.com/raw/HsDXdraZ
> >     verifier log: https://pastebin.com/raw/sNmSsVxs
> >
> > Ideally, the verifier should exit quickly in this case, since R2=3D42
> > always holds.
> > The behaviour of the verifier does not make sense to me, seems it lost
> > the range information of R2.
> >
> > Please point out if I missed anything, the C reproducer in the link
> > (https://pastebin.com/raw/HsDXdraZ)
> > essentially loads the following case into `test_verifier.c`:
> > {
> > "BVF verifier test",
> > .insns =3D {
> > BPF_MOV64_IMM(BPF_REG_1, 42),
> > BPF_MOV64_IMM(BPF_REG_2, 0),
> > BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
> > BPF_EXIT_INSN(),
> > BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
> > BPF_ALU32_IMM(BPF_DIV, BPF_REG_2, 1),
> > BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 108),
> > BPF_JMP32_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
> > BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
> > BPF_EXIT_INSN(),
> > },
> > .prog_type =3D BPF_PROG_TYPE_XDP,
> > },
> >
> > The verifier's log is more then 4M, but essentially is:
> >     0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >     0: (b7) r1 =3D 42                       ; R1_w=3DP42
> >     1: (b7) r2 =3D 0                        ; R2_w=3DP0
> >     2: (85) call pc+1
> >     caller:
> >      R10=3Dfp0
> >     callee:
> >      frame1: R1_w=3DP42 R2_w=3DP0 R10=3Dfp0
> >     4: (57) r2 &=3D -52                     ; frame1: R2_w=3DP0
> >     5: (0f) r2 +=3D r1                      ; frame1: R1_w=3DP42 R2_w=
=3DP42
> >     6: (34) w2 /=3D 1                       ; frame1:
> > R2_w=3DPscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff))
> >     7: (17) r1 -=3D 108                     ; frame1: R1_w=3DP-66
> >     8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=3DP-66
> > R2_w=3DPscalar(umax=3D4294967229,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
> >     6: (34) w2 /=3D 1                       ; frame1:
> > R2_w=3DPscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff))
> >     7: (17) r1 -=3D 108                     ; frame1: R1_w=3DP-174
> >     8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=3DP-174
> > R2_w=3DPscalar(umax=3D4294967121,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
> >     6: (34) w2 /=3D 1                       ; frame1:
> > R2_w=3DPscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff))
> >     7: (17) r1 -=3D 108                     ; frame1: R1=3DP-282
> >     8: (2e) if w1 > w2 goto pc-3 6: frame1: R1=3DP-282
> > R2=3DPscalar(umax=3D4294967013,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
> >     ...
> >     6: (34) w2 /=3D 1                       ; frame1:
> > R2_w=3DPscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff))
> >     7: (17) r1 -=3D 108                     ; frame1: R1_w=3DP-6342690
> >     8: (2e) if w1 > w2 goto pc-3 6: frame1: R1_w=3DP-6342690
> > R2_w=3DPscalar(umax=3D4288624605,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
> >     6: (34) w2 /=3D 1                       ; frame1:
> > R2_w=3DPscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff))
> >     7: (17) r1 -=3D 108                     ; frame1: R1_w=3DP-6342798
> >     8: (2e) if w1 > w2 goto pc-3          ; frame1: R1_w=3DP-6342798
> > R2_w=3DPscalar(umin=3D4288624498,umax=3D4294967295,var_off=3D(0xff80000=
0;
> > 0x7fffff),s32_min=3D-6342798,s32_max=3D-1)
> >     9: (bf) r0 =3D r2                       ; frame1:
> > R0_w=3DPscalar(id=3D58730,umin=3D4288624498,umax=3D4294967295,var_off=
=3D(0xff800000;
> > 0x7fffff),s32_min=3D-6342798,s32_max=3D-1)
> > R2_w=3DPscalar(id=3D58730,umin=3D4288624498,umax=3D4294967295,var_off=
=3D(0xff800000;
> > 0x7fffff),s32_min=3D-6342798,s32_max=3D-1)
> >     10: (95) exit
> >     returning from callee:
> >      frame1: R0_w=3DPscalar(id=3D58730,umin=3D4288624498,umax=3D4294967=
295,var_off=3D(0xff800000;
> > 0x7fffff),s32_min=3D-6342798,s32_max=3D-1) R1_w=3DP-6342798
> > R2_w=3DPscalar(id=3D58730,umin=3D4288624498,umax=3D4294967295,var_off=
=3D(0xff800000;
> > 0x7fffff),s32_min=3D-6342798,s32_max=3D-1) R10=3Dfp0
> >     to caller at 3:
> >      R0_w=3DPscalar(id=3D58730,umin=3D4288624498,umax=3D429496
