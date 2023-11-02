Return-Path: <bpf+bounces-13937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E437DEFF8
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 11:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DA01C20F29
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243513FEF;
	Thu,  2 Nov 2023 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1qiOP/+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E711427A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:30:26 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E8136;
	Thu,  2 Nov 2023 03:30:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9cbba16084so756474276.1;
        Thu, 02 Nov 2023 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698921019; x=1699525819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rctCHpSNNnudhMuzQjqFB7K6mRQjkZdSA9bEmnPeqA=;
        b=Z1qiOP/+FOR/JKzHy4msogsvl9JLMorgxzABTCBfAYTEzuxQW05flAE3Wkv1HrA/fJ
         ewmPi30q2+kgee+9kNz+Mn5k58pk7Qsuy5YuWJsQ1hWmGN84mcth+ockGLwwiWDtRIR8
         haHVhYEfz9azA3H/sEEQ8NOP0TjnKchhRMGKrR/0rIl/jShKKlSg1rud8KDc4uSN9qmT
         Q4ntuOLnXySTmki8cc9XvRt5THyxOG1ERTxzqSkbbC6WSNdGkGcbYvGImocxPmUzNk0V
         9unXzZAjftOm5KZ6oQyT4cCVqVuAxlwVFJz2GoFL/qOkfzjFR5JrGsgJig0ng9n77l73
         xGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921019; x=1699525819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rctCHpSNNnudhMuzQjqFB7K6mRQjkZdSA9bEmnPeqA=;
        b=VK0/AAGFnrztJw72j6X4YIrJzX+cj0Mh7Ax/CDCH26A15AaTLcDlj2/32hPSEKkDve
         172ll0ydvUaehgAJCO2l90F5AWdJ/FhrkxTgFIQ+6lOJzJNioQR8rW/K8zUfVxosyH8t
         GSBN/o/safOyz3wm6ZsrQEjxUMXvLBcPm5XvkMI/KFjqsbIazrOJ61hlbpR05HLPew5F
         YkXCfncFkmewsICuUeRmNPWZWBYL19DFl6lBPAMxSnf6oKFh+Op4DmJaL4WiXspQBEv0
         XnmV1sTts0KNmRsfs3Rsn50rgceVjV6WzsjdGc4yNkJ3OzLbKYOxeKPbK9FzwX5//2uE
         YC9w==
X-Gm-Message-State: AOJu0YwlX1qAp7mqFQfOCdWyOh09omWXqn9isg8EaOh93RscuC2kLtnn
	ZFlF883ovR+uAze6gFwSO+HWV+G0t+6lURIxEA==
X-Google-Smtp-Source: AGHT+IE9befvUCRRTSTK2CGqSbtQw00NeSRpf/odrYSyjMc/SGNn8v1CTqa26VeWWmBWI7wmxOXZ5rWdPQmywQvu4lc=
X-Received: by 2002:a25:d152:0:b0:da0:3bfc:b915 with SMTP id
 i79-20020a25d152000000b00da03bfcb915mr16112280ybg.11.1698921018746; Thu, 02
 Nov 2023 03:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY3vMLVVO0zHd+CRcQPdykDhXv8-f2oD82+Jk5KJpq_8w@mail.gmail.com>
 <CAEf4BzbDK15myKbN4sM+cxFvfWCNjthJuFZf81k6OEBpaC124g@mail.gmail.com>
In-Reply-To: <CAEf4BzbDK15myKbN4sM+cxFvfWCNjthJuFZf81k6OEBpaC124g@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 2 Nov 2023 11:30:07 +0100
Message-ID: <CACkBjsbpttp2L0=oi7-0+SLNC8wSxkPbG7ZYZuWOmurNxELT-Q@mail.gmail.com>
Subject: Re: bpf: incorrectly reject program with `back-edge insn from 7 to 8`
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 9:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 1, 2023 at 6:56=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrot=
e:
> >
> > Hi,
> >
> > The verifier incorrectly rejects the following prog in check_cfg() when
> > loading with root with confusing log `back-edge insn from 7 to 8`:
> >   /* 0: r9 =3D 2
> >    * 1: r3 =3D 0x20
> >    * 2: r4 =3D 0x35
> >    * 3: r8 =3D r4
> >    * 4: goto+3
> >    * 5: r9 -=3D r3
> >    * 6: r9 -=3D r4
> >    * 7: r9 -=3D r8
> >    * 8: r8 +=3D r4
> >    * 9: if r8 < 0x64 goto-5
> >    * 10: r0 =3D r9
> >    * 11: exit
> >    * */
> >   BPF_MOV64_IMM(BPF_REG_9, 2),
> >   BPF_MOV64_IMM(BPF_REG_3, 0x20),
> >   BPF_MOV64_IMM(BPF_REG_4, 0x35),
> >   BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
> >   BPF_JMP_IMM(BPF_JA, 0, 0, 3),
> >   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_3),
> >   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_4),
> >   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8),
> >   BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_4),
> >   BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0x68, -5),
> >   BPF_MOV64_REG(BPF_REG_0, BPF_REG_9),
> >   BPF_EXIT_INSN()
> >
> > -------- Verifier Log --------
> > func#0 @0
> > back-edge from insn 7 to 8
> > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> >
> > This is not intentionally rejected, right?
>
> The way you wrote it, with goto +3, yes, it's intentional. Note that
> you'll get different results in privileged and unprivileged modes.
> Privileged mode allows "bounded loops" logic, so it doesn't
> immediately reject this program, and then later sees that r8 is always
> < 0x64, so program is correct.
>

I load the program with privileged mode, and goto-5 makes the program
run from #9 to #5, so r8 is updated and the program is not infinite loop.

> But in unprivileged mode the rules are different, and this conditional
> back edge is not allowed, which is probably what you are getting.
>
> It's actually confusing and your "back-edge from insn 7 to 8" is out
> of date and doesn't correspond to your program, you should see
> "back-edge from insn 11 to 7", please double check.
>

Yes it's also confusing to me, but "back-edge from insn 7 to 8" is what
I got. The execution path of the program is #4 to #8 (goto+3), so the
verifier see the #8 first. Then, the program then goes #9 to #5 (goto-5),
the verifier thus sees #7 to #8 and incorrectly concludes back-edge here.

This can is the verifier log I got from latest bpf-next, this C program can
reproduce this: https://pastebin.com/raw/Yug0NVwx

> Anyways, while I was looking into this, I realized that ldimm64 isn't
> handled exactly correctly in check_cfg(), so I just sent a fix. It
> also adds a nicer detection of jumping into the middle of the ldimm64
> instruction, which I believe is something you were advocating for.
>
> >
> > Best
> > Hao

