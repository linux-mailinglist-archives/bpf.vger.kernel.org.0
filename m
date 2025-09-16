Return-Path: <bpf+bounces-68486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D11B591DE
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7FD18969AE
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186FE29898B;
	Tue, 16 Sep 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA7ew/eV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A310E9
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014093; cv=none; b=A9+DZsjbEG0aJyIlTws0BmoJEVmsDlK/NAy+3DHEFxXzr983xmyfLF3FywuH95arAuV1DrmxnlQoXUj80kezSZaccpbOvvG9WfFSvJUyEfzhxDplzm0PLi4GMQv6X+j0yS4ipXcmV50qEd40fW90ojhMOFgko8oQ/GpaT4ef7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014093; c=relaxed/simple;
	bh=t7JA6AMNc/SslXLubb+B4OGmYInEP2xAEldF8ytxiqw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJqSoIsRA/DGFyrr8RYhecwXaMHPezcKczPrZjrvTKb2BO41VTr3nvDCGT1v/BBwzqbCnmSz4vHm8Dyf3sVaobR+tIF7zGBVYr8fFTksMkcxbO0G9VL5nW6EwWHPz17S4wJrPY/npnH1ghZh5ff9Nc9rovduFcSrScAgMZZeWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA7ew/eV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77459bc5d18so3992832b3a.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014091; x=1758618891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy3gQMyU/E1i5AJcLQlonxALYGjighiI1yeoujTpolk=;
        b=SA7ew/eVWcjut7JPTDE7SYXj0SDrIWRUNsRb2S18vVI+VlAI2Kb4dZFLe8HD4qJkNm
         zB+mniJXS83kSAo8Ft+QPwkiARJZ9ZnagHAEaeeSNTudZgI1Hi6kXOt+XSDwkXmfkf56
         tHjUh3JPiku1NebIEgD+HvesJ1J2umOCak7gjb6+yndgJCcUHFK3p4BFUBBy0wXzNdm8
         X07q8J6ZJsSDfnlV7YojCvtrkK/+BEsdC/vBstZRWq2HpV/YQWPeJ6DDgqzMoh22LAIl
         m7nt33aePraYeccZ46kUO/SH6pKRRsyOxuDNNiu1nc2R7qvPXcDPiGovHK+A7ufgAAhk
         VSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014091; x=1758618891;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oy3gQMyU/E1i5AJcLQlonxALYGjighiI1yeoujTpolk=;
        b=YmHWbF127oniEUXFDNCXMs4+nCU6Us8I3rSqJRRtpmgydfEbipq7zrV0Qg5B0kpUAA
         CvwMHZ8QJUobjeIlR2f9QipEsXvcIGv4Etpj0YsLDqJIPqnWfiKHMf8i8Dp+141xx2/b
         hZiJJLG6srxom74raUfRXLPU+uFy7zmo8KCzifpbbZTr4kwAkH4QhmfFFqqMca9bZ+D1
         BGn9u0pWrnRS3o4cDgwnLBDA3XB1bznwGp1jrwU+Fd2wsux8mfB0+8k6DL5i+e/7iNu4
         eZSr3/xgtPAPWEis6o0QI7UTYL3DWlP/WDi6Nv6Gg9uDVig42CN5UL3KK3GTqAQguMkR
         V6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO7dUbZ8ZnHli8Lq3a+1RbRVGrNhrefcQk2L+cZvaT5oPi2oS+miOaWgPpo6aKg/s/Z1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXX/MMa4pgwpsmVHBondRFCMhJyFeBtvoE3zUyqXZ00yideP2N
	QUo1YvBZo/ezxtAXk+/kFCbnY5gUnA1YuDp+zPqmpTZFwcJjrlGw0JYl1nJlXtEu
X-Gm-Gg: ASbGncsgrB8AvO6mW3Y3Vg8rhpZ9XW6EI9OwxgGTG1vLQBAHe8QP13D3XlqUIrSw4yi
	EHDUo8VRidHLB8YJsD0W9NH/5QMR8YtdoKKnLimYUuTuNw1IW0O7uKy7QNa0T0d19PoMav8Ap3j
	sZZf4vCIN7h7jwOlWpJ1uLYqSSKPfsEROhoSN2zuDt9ooJR0I/Pb2vzQJfT0SjmOOvNB4jv+NPO
	bWyPmZHea8qE0a+9c0917LpTWLaF6KXDn7JlbLinf+kJXdXlHszc664F3TS9rsKODBYLiZ++hQH
	SOxTI5EGVOAfQusL3adbVwLHucGVJcmnmnG0dCNoTxsgQX71Vckuywek/yTFgzR5H3xPvBy4QS1
	qBQZAwRPccYUXj7+3yvQ=
X-Google-Smtp-Source: AGHT+IFRwBAv+gM3FW6NQ8wDnj8ZpAYAq5LHxgZZmC0m3Ji+oSMyylDVJKE7igYS2ZaruefyUntvig==
X-Received: by 2002:a05:6a00:22d3:b0:772:8dd7:f55f with SMTP id d2e1a72fcca58-7761218839fmr17315128b3a.25.1758014091227;
        Tue, 16 Sep 2025 02:14:51 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776075fdd83sm15555183b3a.0.2025.09.16.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:14:50 -0700 (PDT)
Message-ID: <c42dd869d9ba23f14681448581a9c8c7ec23105b.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in maybe_exit_scc
From: Eduard Zingerman <eddyz87@gmail.com>
To: syzbot <syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Tue, 16 Sep 2025 02:14:47 -0700
In-Reply-To: <b1717a5b75475b8e14afaee4825a40a3808bd0cb.camel@gmail.com>
References: <68c85acd.050a0220.2ff435.03a4.GAE@google.com>
		 <81bb1cf72e9c5f56c92ab43636a0626a1046d748.camel@gmail.com>
	 <b1717a5b75475b8e14afaee4825a40a3808bd0cb.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 16:40 -0700, Eduard Zingerman wrote:
> On Mon, 2025-09-15 at 15:34 -0700, Eduard Zingerman wrote:
>=20
> [...]
>=20
> > > verifier bug: scc exit: no visit info for call chain (1)(1)
> > > WARNING: CPU: 1 PID: 6013 at kernel/bpf/verifier.c:1949 maybe_exit_sc=
c+0x768/0x8d0 kernel/bpf/verifier.c:1949
> >=20
> > Both this and [1] are reported for very similar programs:
> >=20
> > <this>                                      <[1]>
> > -----------------------------------------------------------------------=
---------------------
> > (b7) r0 =3D -1023213567                       (b7) r0 =3D -1023213567
> > (bf) r3 =3D r10				    (bf) r3 =3D r10
> > (07) r3 +=3D -512				    (07) r3 +=3D -504
> > (72) *(u8 *)(r10 -16) =3D -8		    (72) *(u8 *)(r10 -16) =3D -8
> > (71) r4 =3D *(u8 *)(r10 -16)		    (71) r4 =3D *(u8 *)(r10 -16)
> > (65) if r4 s> 0xff000000 goto pc+2	    (65) if r4 s> 0xff000000 goto pc=
+2
> > (2d) if r0 > r4 goto pc+5		    (2d) if r0 > r4 goto pc+5
> > (20) r0 =3D *(u32 *)skb[60673]		    (20) r0 =3D *(u32 *)skb[60673]
> > (7b) *(u64 *)(r3 +0) =3D r0		    (7b) *(u64 *)(r3 +0) =3D r0
> > (1d) if r4 =3D=3D r4 goto pc+0		    (1d) if r4 =3D=3D r4 goto pc+0
> > (7a) *(u64 *)(r10 -512) =3D -256		    (7a) *(u64 *)(r10 -512) =3D -256
> > (db) lock *(u64 *)(r3 +0) |=3D r0		    (db) r0 =3D atomic64_fetch_and((=
u64 *)(r3 +0), r0)
> > (b5) if r0 <=3D 0x0 goto pc-2		    (b5) if r0 <=3D 0x0 goto pc-2
> > (95) exit				    (95) exit
> >=20
> > So, I assume it's the same issue. Looking into it.
> >=20
> > [1] https://lore.kernel.org/bpf/68c85b0d.050a0220.2ff435.03a5.GAE@googl=
e.com/T/#u
>=20
> Minimal reproducer:
>=20
>   SEC("socket")
>   __caps_unpriv(CAP_BPF)
>   __naked void syzbot_bug(void)
>   {
>         asm volatile (
>         "r0 =3D 100;"
>   "1:"
>         "*(u64 *)(r10 - 512) =3D r0;"
>         "if r0 <=3D 0x0 goto 1b;"
>         "exit;"
>         ::: __clobber_all);
>   }
>=20
> And corresponding verifier log:
>=20
>   Live regs before insn:
>         0: .......... (b7) r0 =3D 100
>     1   1: 0......... (7b) *(u64 *)(r10 -512) =3D r0
>     1   2: 0......... (b5) if r0 <=3D 0x0 goto pc-2
>         3: 0......... (95) exit
>   Global function syzbot_bug() doesn't return scalar. Only those are supp=
orted.
>   0: R1=3Dctx() R10=3Dfp0
>   ; asm volatile ( @ verifier_and.c:118
>   0: (b7) r0 =3D 100                      ; R0_w=3D100
>   1: (7b) *(u64 *)(r10 -512) =3D r0       ; R0_w=3D100 R10=3Dfp0 fp-512_w=
=3D100
>   2: (b5) if r0 <=3D 0x0 goto pc-2
>   mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1
>   mark_precise: frame0: regs=3Dr0 stack=3D before 1: (7b) *(u64 *)(r10 -5=
12) =3D r0
>   mark_precise: frame0: regs=3Dr0 stack=3D before 0: (b7) r0 =3D 100
>   2: R0_w=3D100
>   3: (95) exit
>=20
>   from 2 to 1 (speculative execution): R0_w=3Dscalar() R1=3Dctx() R10=3Df=
p0 fp-512_w=3D100
>   1: R0_w=3Dscalar() R1=3Dctx() R10=3Dfp0 fp-512_w=3D100
>   1: (7b) *(u64 *)(r10 -512) =3D r0
>   verifier bug: scc exit: no visit info for call chain (1)
>   processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>=20
> [...]

Here is what happens:
- Verification process starts and gets to instruction (2) w/o creating
  any checkpoints.
- A speculative execution of the false branch is pushed onto states
  stack; main execution process predicts the branch as false and
  continues to exit. Still no checkpoints.
- Speculative execution branch is popped from stack and proceeds from
  instruction (1).
- Speculative execution immediately terminates, because verifier
  detects an infinite loop and signals an error.
- update_branch_counts() is called for speculative execution state and
  its branches count reaches zero.
- update_branch_counts() -> maybe_exit_scc() is called for a state
  with insn_idx in SCC #1.
- maybe_exit_scc() assumes that when it is called for a state with
  insn_idx in some SCC, there should be an instance of struct
  bpf_scc_visit allocated for this SCC, which is not the case here.
 =20
Why the assumption about bpf_scc_visit existence is made by
maybe_exit_scc()?
While performing non-speculative symbolic execution there are three
ways to terminate execution path:
a. Verification error is found. In this case update_branch_counts() is
   not called and bpf_scc_visit existence does not matter.
b. Top level BPF_EXIT is reached. Exit instructions are never a part of
   an SCC, so compute_scc_callchain() in maybe_scc_exit() will return
   false and maybe_scc_exit() will return early.
c. A checkpoint is reached and matched. Checkpoints are created by
   is_state_visited(), which calls maybe_enter_scc(), which allocates
   bpf_scc_visit instances for checkpoints within SCCs.

Hence, for non-speculative symbolic execution paths there is no way to
reach a state when maybe_scc_exit() is called for a state within an
SCC, but bpf_scc_visit instance does not exist.

However, the above logic falls short for speculative symbolic
execution paths, because verification errors (option (a) above) lead
to update_branch_counts() calls. And the test case above demonstrates
exactly that scenario.

I'll send a patch disabling bpf_scc_visit existence assertion for
speculative paths in the morning. Something along the lines:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1950,6 +1950,8 @@ static int maybe_exit_scc(struct bpf_verifier_env *en=
v, struct bpf_verifier_stat
                return 0;
        visit =3D scc_visit_lookup(env, callchain);
        if (!visit) {
+               if (st->speculative)
+                       return 0;
                verifier_bug(env, "scc exit: no visit info for call chain %=
s",
                             format_callchain(env, callchain));
                return -EFAULT;


