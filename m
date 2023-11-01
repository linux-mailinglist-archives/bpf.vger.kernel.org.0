Return-Path: <bpf+bounces-13835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4B97DE6F8
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2171C20D5F
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016218032;
	Wed,  1 Nov 2023 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwoK++cf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE533E7
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:57:48 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4489E10C;
	Wed,  1 Nov 2023 13:57:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so2636361a12.0;
        Wed, 01 Nov 2023 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698872266; x=1699477066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E71E5dF0f7RF1z/b8IaouihYDBRTmJBE+XZef23gOzE=;
        b=TwoK++cf7p5dhIUPAn9VzTXbcJS3oEaOFlXv+A+gsvb2geNV/gxMjOvLKrg46M/gus
         wgp98W9xFDCoJDxYazbk0LWvp5XxitHlVehCfZwy2DNZ5Y75WLWiDG1SIXQIJxM6y02f
         2sIskL02zMa0ZQw2chJEULrHCi72iOPpiElO/I0789gYWESwnXoFIx0hXe1jPENWQR69
         i9OrfAL3BnjJ8NQurB5pFb6LreCSbSvH/w44EFQtLecX2dNh75Nwb2G1hkeWq/nRkqt9
         xMRy+6dkW6fjH9eL2uzKG2il00E3T4836Dh9FqLjPQF/yZLhx7gLrzX5s4yOKaibDLVR
         u3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698872266; x=1699477066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E71E5dF0f7RF1z/b8IaouihYDBRTmJBE+XZef23gOzE=;
        b=SWeoZn7efeTuXkGaGMuKwHScQfzqOEY+WPprCSRDR876gCKDUTUvOqBCmzSXqypuHm
         vYkKQvd2DI4xN70TtxIfCi6Q6agWKeosfnTDrV7SH8JaLh8j3j0oDXcxnltwoAjYxHOB
         JcE46y5fwGuWDOlts+YfT7mTGz8MLrpt7tVfJ8ePf3RaGnc4q7vqJLPTjtK0LpKqVKVD
         FD6I7K3PUJV0fCqz6za+GRQ45raZ1TO1t8jiimIo9ing6tSJmFp38vVJL3elhiLhMz6V
         z6Wz/vyYz9buL98REHzCBAMCTIJ8F30b0J4YKHAFh4QY166rRVVRU9QwzySwlNmnYJzJ
         2h+Q==
X-Gm-Message-State: AOJu0YziURqTitCx6N6FLISx6Yh4/VLV+FwkXQBMSKgm0L5BwFMBTSxb
	Hvi9EkXMLMI2cwQ4BpAek/x0tYqRMjaAVqOd/NE=
X-Google-Smtp-Source: AGHT+IFOd/fuK7bC4p8fNBpVhvNyYnepW6Z+IiiMZtKVlWbVFzDiXq8oV1R6oyMyWXwxEy0zRROdyfjx5YvPgE1aY2E=
X-Received: by 2002:a17:906:c104:b0:9b2:bdbb:f145 with SMTP id
 do4-20020a170906c10400b009b2bdbbf145mr2900162ejc.34.1698872265479; Wed, 01
 Nov 2023 13:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY3vMLVVO0zHd+CRcQPdykDhXv8-f2oD82+Jk5KJpq_8w@mail.gmail.com>
In-Reply-To: <CACkBjsY3vMLVVO0zHd+CRcQPdykDhXv8-f2oD82+Jk5KJpq_8w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 13:57:33 -0700
Message-ID: <CAEf4BzbDK15myKbN4sM+cxFvfWCNjthJuFZf81k6OEBpaC124g@mail.gmail.com>
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

On Wed, Nov 1, 2023 at 6:56=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote:
>
> Hi,
>
> The verifier incorrectly rejects the following prog in check_cfg() when
> loading with root with confusing log `back-edge insn from 7 to 8`:
>   /* 0: r9 =3D 2
>    * 1: r3 =3D 0x20
>    * 2: r4 =3D 0x35
>    * 3: r8 =3D r4
>    * 4: goto+3
>    * 5: r9 -=3D r3
>    * 6: r9 -=3D r4
>    * 7: r9 -=3D r8
>    * 8: r8 +=3D r4
>    * 9: if r8 < 0x64 goto-5
>    * 10: r0 =3D r9
>    * 11: exit
>    * */
>   BPF_MOV64_IMM(BPF_REG_9, 2),
>   BPF_MOV64_IMM(BPF_REG_3, 0x20),
>   BPF_MOV64_IMM(BPF_REG_4, 0x35),
>   BPF_MOV64_REG(BPF_REG_8, BPF_REG_4),
>   BPF_JMP_IMM(BPF_JA, 0, 0, 3),
>   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_3),
>   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_4),
>   BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8),
>   BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_4),
>   BPF_JMP32_IMM(BPF_JLT, BPF_REG_8, 0x68, -5),
>   BPF_MOV64_REG(BPF_REG_0, BPF_REG_9),
>   BPF_EXIT_INSN()
>
> -------- Verifier Log --------
> func#0 @0
> back-edge from insn 7 to 8
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
>
> This is not intentionally rejected, right?

The way you wrote it, with goto +3, yes, it's intentional. Note that
you'll get different results in privileged and unprivileged modes.
Privileged mode allows "bounded loops" logic, so it doesn't
immediately reject this program, and then later sees that r8 is always
< 0x64, so program is correct.

But in unprivileged mode the rules are different, and this conditional
back edge is not allowed, which is probably what you are getting.

It's actually confusing and your "back-edge from insn 7 to 8" is out
of date and doesn't correspond to your program, you should see
"back-edge from insn 11 to 7", please double check.

Anyways, while I was looking into this, I realized that ldimm64 isn't
handled exactly correctly in check_cfg(), so I just sent a fix. It
also adds a nicer detection of jumping into the middle of the ldimm64
instruction, which I believe is something you were advocating for.

>
> Best
> Hao

