Return-Path: <bpf+bounces-14646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E27E7423
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F91AB20DCB
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E738F9D;
	Thu,  9 Nov 2023 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Qh5YVu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527638F92
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:06:12 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E203ABF
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 14:06:11 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so768400f8f.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 14:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699567570; x=1700172370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMP1Rpvu652gW9LuyHwR4m3CFBSeQr+oqUkWPeSe3W0=;
        b=C3Qh5YVu8oCv7G9v2KnlhJdp4zmSf2WIrdNjwMRPcc+4PTrIuVj4ZAbFczrbciSMHr
         QAasw1VAsO7cqllzPWMXI1Ki+1OAtJnPBJxRLHDyhoR1D2lvhoWeJ+S6/SLrh4nR72Bv
         sRpy01piYb+uPwxzwev2cD7hqjXnSNZOj5AEZv32uFCep+GmR+OE2K/Eq0lbQYnd5osq
         XAIunHOHbjmwuasLuVE1fHAOVbfvNEhJIGVdhJ2tnJngrthkPsKS7fZPGg5quHpkb872
         0qusB6btKAn7Sw/Uif+NCPRLk4G1vlEMXaP84s/Sd8KeSC1ZdA3oUmL9nGj0AoQbBCM1
         cn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699567570; x=1700172370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMP1Rpvu652gW9LuyHwR4m3CFBSeQr+oqUkWPeSe3W0=;
        b=qop4ycVvFFcl0HacGF9QNLWvBoBizOdV9QD7WrBxvM09rmrf9Kmd8FPSCCBwy0FCEt
         UWVy4AQRk224H5+r31saTMwb4rDqAonPaPpv/dl1HaA//D032FOlcgdSwaLw9KzRYsuv
         29fBUgFCgED3/tDsH/sQ1TPurbRz+ISKlU4xge7sGOaw0x7o0TIdyWwDW1irh+X4LMvd
         Bw8mtdmRlT78xs1POVb1Yl9JniGACYCGK9O4fdXGtEIzpycgIsE5AvomSJslqPGjESfj
         whAqKS3+DXZxpnbfPwbCIw6AlKW8qH8BjKcKweLn1jDVS11eEP6e/hk/MB21agYmjsG1
         XrFQ==
X-Gm-Message-State: AOJu0YytY0+W2sTJhcBgZwPKCTxI0Fj0eTfzWO02T4WjOldVN3a65YlZ
	z54n/pdcXxSFfA4ikXjhIpKCu4VzMOz/KvEdLXM=
X-Google-Smtp-Source: AGHT+IEu+1klw3dloVEFKDisfjVFqcP4KoSskiB5RjVDS9bAtaSBfLYWCD2AbNpXkN12yqMA3MV9l8A50JK2t5kPcIE=
X-Received: by 2002:adf:d1cf:0:b0:323:2d01:f043 with SMTP id
 b15-20020adfd1cf000000b003232d01f043mr6769086wrd.3.1699567569937; Thu, 09 Nov
 2023 14:06:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-2-andrii@kernel.org>
 <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
 <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com>
 <CAEf4BzaA12xjXm8KZNB1mkVDOTtVDQDDWF4nYQtQ2qRYoTip3A@mail.gmail.com>
 <CAADnVQLGn4vRuZLqTm_t_9ff3t=Hsugr0j47YLThhPsnpNrs_Q@mail.gmail.com>
 <CAEf4BzY72H_0fF4C1kGbX5_ymNu6NHYf55HAnU8i5dnaQ+f_vA@mail.gmail.com> <CAEf4BzYn83g6TSwWcqqdcJBPB74kRs5iX73J9Vdrt7fT6VstdA@mail.gmail.com>
In-Reply-To: <CAEf4BzYn83g6TSwWcqqdcJBPB74kRs5iX73J9Vdrt7fT6VstdA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 14:05:58 -0800
Message-ID: <CAADnVQ+wd0MVVxxLKgTQiNTSZ34ZwqM84jmgcj-f87F97PgqSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 12:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 11:49=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 11:29=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Nov 9, 2023 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > >
> > > > If we ever break DFS property, we can easily change this. Or we can
> > > > even have a hybrid: as long as traversal preserves DFS property, we
> > > > use global shared history, but we can also optionally clone and hav=
e
> > > > our own history if necessary. It's a matter of adding optional
> > > > potentially NULL pointer to "local history". All this is very nicel=
y
> > > > hidden away from "normal" code.
> > >
> > > If we can "easily change this" then let's make it last and optional p=
atch.
> > > So we can revert in the future when we need to take non-DFS path.
> >
> > Ok, sounds good. I'll reorder and put it last, you can decide whether
> > to apply it or not that way.
> >
> > >
> > > > But again, let's look at data first. I'll get back with numbers soo=
n.
> > >
> > > Sure. I think memory increase due to more tracking is ok.
> > > I suspect it won't cause 2x increase. Likely few %.
> > > The last time I checked the main memory hog is states stashed for pru=
ning.
> >
> > So I'm back with data. See verifier.c changes I did at the bottom,
> > just to double check I'm not missing something major. I count the
> > number of allocations (but that's an underestimate that doesn't take
> > into account realloc), total number of instruction history entries for
> > entire program verification, and then also peak "depth" of instruction
> > history. Note that entries should be multiplied by 8 to get the amount
> > of bytes (and that's not counting per-allocation overhead).
> >
> > Here are top 20 results, sorted by number of allocs for Meta-internal,
> > Cilium, and selftests. BEFORE is without added STACK_ACCESS tracking
> > and STACK_ZERO optimization. AFTER is with all the patches of this
> > patch set applied.
> >
> > It's a few megabytes of memory allocation, which in itself is probably
> > not a big deal. But it's just an amount of unnecessary memory
> > allocations which is basically at least 2x of the total number of
> > states that we can save. And instead have just a few reallocs to size
> > global jump history to an order of magnitudes smaller peak entries.
> >
> > And if we ever decide to track more stuff similar to
> > INSNS_F_STACK_ACCESS, we won't have to worry about more allocations or
> > more memory usage, because the absolute worst case is our global
> > history will be up to 1 million entries tops. We can track some *code
> > path dependent* per-instruction information for *each simulated
> > instruction* easily without having to think twice about this. Which I
> > think is a nice liberating thought in itself justifying this change.
> >
> >
>
> Gmail butchered tables. See Github gist ([0]) for it properly formatted.
>
>   [0] https://gist.github.com/anakryiko/04c5a3a5ae4ee672bd11d4b7b3d832f5

I think 'peak insn history' is the one to look for, since
it indicates total peak memory consumption. Right?
It seems the numbers point out a bug in number collection or
a bug in implementation.

before:
verifier_loops1.bpf.linked3.o peak=3D499999
loop3.bpf.linked3.o peak=3D111111

which makes sense, since both tests hit 1m insn.
I can see where 1/2 and 1/9 come from based on asm.

after:
verifier_loops1.bpf.linked3.o peak=3D25002
loop3.bpf.linked3.o peak=3D333335

So the 1st test got 20 times smaller memory footprint
while 2nd was 3 times higher.

Both are similar infinite loops.

The 1st one is:
l1_%=3D:  r0 +=3D 1;                                        \
        goto l1_%=3D;                                     \

My understanding is that there should be all 500k jmps in history with
or without these patches.

So now I'm more worried about the correctness of the 1st patch.

