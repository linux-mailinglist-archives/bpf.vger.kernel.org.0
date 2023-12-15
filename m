Return-Path: <bpf+bounces-17910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20702813EA4
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DD3B21E16
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A0652;
	Fri, 15 Dec 2023 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRDo/JUd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2D363;
	Fri, 15 Dec 2023 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-333536432e0so61916f8f.3;
        Thu, 14 Dec 2023 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702599417; x=1703204217; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S2lp22ZpE1Er+qtE5Fj0a/2zBr3ofAMY8jmSn3bat1c=;
        b=cRDo/JUd4nDPIAg6hvFrShevi+9/iXait5t+wUEy1y+fhHolTCsjpPDwOMk3/TF1Uj
         ZS0xP4vMxDQ//YQuwOeAVCjN6Wow0W+kj28WSOlQ8DsjSHVneSH7B1SxJFQJNq47RcpD
         Tzkzf7Fi2/h009ghpW95f1QkE7MS8fZmt84ZWH2C2paTKJYJoQwfPKeD0jtWnzCpyaIJ
         FE54yF/dWfQxLee7hI8vQFhFblJo0edUD9h8BjuPpoW2jFccLn0t0hS8JL64eBxk27ng
         isJ4iP1vMoNzPh+HcxX/eG4K3SHRBFkLVjyKiTfd7lPZaU00lBZG7spGntZEGpfvfHcF
         7SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702599417; x=1703204217;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2lp22ZpE1Er+qtE5Fj0a/2zBr3ofAMY8jmSn3bat1c=;
        b=BVR8pAoK7S4WJ9oSkXcCkMX4CvLqn7DhMp2+fN22pqNXmtHOFUwZ2Pyzv5zOJq2czD
         VeZ8ry30bDsdiUJaUKKtfY2iccPRpXBRWA64nKkw4AdJquWMlMh6i/4GWRtmSXLDFRdy
         FnlVgRAlJC4XA9s2rOrH/synJmn327dFcnwA0pfKj36woazEUI9ihr48oIPged/C3AN5
         7mVXLaqoNsd6LNGcts7kSgSFkwnf78IDUW7RW/3JSLK4PmTNL6Ku8H+3JNpeHpu7QVwG
         DeUV7j3vNn0LXtevOuUATBU0zUWGjNE2KCGrmUJnT1owSC35a60mx8nC5nv+X2YMW3dT
         451Q==
X-Gm-Message-State: AOJu0YxMVsE876F9d178xOu5V4NYDT0rkDRNW976gtuBlQcmJhGKfC00
	CviyelBExT7ECWQkjI8rLMk=
X-Google-Smtp-Source: AGHT+IEpulxVkS5aIZx4FhNVrqswsQgguIZVtmJrpTOFpyh6VlbpAVTZiYB9exSaseQ9tqaDHqqZsg==
X-Received: by 2002:a5d:5682:0:b0:336:4a5c:e130 with SMTP id f2-20020a5d5682000000b003364a5ce130mr721054wrv.1.1702599416874;
        Thu, 14 Dec 2023 16:16:56 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z10-20020adfe54a000000b00336491ed33asm2707329wrm.99.2023.12.14.16.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:16:56 -0800 (PST)
Message-ID: <07f0eb0f01b7e02ab5896f804359785bfa0e716f.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Date: Fri, 15 Dec 2023 02:16:55 +0200
In-Reply-To: <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
	 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
	 <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
	 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
	 <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 16:06 -0800, Andrii Nakryiko wrote:
> On Thu, Dec 14, 2023 at 8:26=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Thu, 2023-12-14 at 17:10 +0200, Eduard Zingerman wrote:
> > > [...]
> > > > The reason why retval checks fails is that the way you disable dead
> > > > code removal pass is not complete. Disable opt_remove_dead_code()
> > > > just prevent the instruction #30 from being removed, but also note
> > > > opt_hard_wire_dead_code_branches(), which convert conditional jump
> > > > into unconditional one, so #30 is still skipped.
> > > >=20
> > > > > Note that I tried this test with two functions:
> > > > > - bpf_get_current_cgroup_id, with this function I get retval 2, n=
ot 4 :)
> > > > > - bpf_get_prandom_u32, with this function I get a random retval e=
ach time.
> > > > >=20
> > > > > What is the expectation when 'bpf_get_current_cgroup_id' is used?
> > > > > That it is some known (to us) number, but verifier treats it as u=
nknown scalar?
> > > > >=20
> > > >=20
> > > > Either one would work, but to make #30 always taken, r0 should be
> > > > non-zero.
> > >=20
> > > Oh, thank you, I made opt_hard_wire_dead_code_branches() a noop,
> > > replaced r0 =3D 0x4 by r0 /=3D 0 and see "divide error: 0000 [#1] PRE=
EMPT SMP NOPTI"
> > > error in the kernel log on every second or third run of the test
> > > (when using prandom).
> > >=20
> > > Working to minimize the test case will share results a bit later.
> >=20
> > Here is the minimized version of the test:
> > https://gist.github.com/eddyz87/fb4d3c7d5aabdc2ae247ed73fefccd32
> >=20
> > If executed several times: ./test_progs -vvv -a verifier_and/pruning_te=
st
> > it eventually crashes VM with the following error:
> >=20
> > [    2.039066] divide error: 0000 [#1] PREEMPT SMP NOPTI
> >                ...
> > [    2.039987] Call Trace:
> > [    2.039987]  <TASK>
> > [    2.039987]  ? die+0x36/0x90
> > [    2.039987]  ? do_trap+0xdb/0x100
> > [    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
> > [    2.039987]  ? do_error_trap+0x7d/0x110
> > [    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
> > [    2.039987]  ? exc_divide_error+0x38/0x50
> > [    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
> > [    2.039987]  ? asm_exc_divide_error+0x1a/0x20
> > [    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
> > [    2.039987]  bpf_test_run+0x1b5/0x350
> > [    2.039987]  ? bpf_test_run+0x115/0x350
> >                ...
> >=20
> > I'll continue debugging this a bit later today.
> >=20
>=20
> Great, thanks a lot, Eduard. Let's paste the program here for discussion:
>=20
> ...
>=20

I managed to minimize it a bit more, getting rid of r5,
(not that it changes anything):

SEC("socket")
__success
__flag(BPF_F_TEST_STATE_FREQ)
__retval(42)
__naked void pruning_test(void)
{
	asm volatile (
	"   call %[bpf_get_prandom_u32];\n"
	"   r7 =3D r0;\n"
	"   r8 =3D r0;\n"
	"   call %[bpf_get_prandom_u32];\n"
	"   if r0 > 1 goto +0;\n"
	"   if r8 >=3D r0 goto 1f;\n"
	"   r8 +=3D r8;\n"
	"   if r7 =3D=3D 0 goto 1f;\n"
	"   r0 /=3D 0;\n"
	"1: r0 =3D 42;\n"
	"   exit;\n"
	:
	: __imm(bpf_get_prandom_u32)
	: __clobber_all);
}

> If you agree with the analysis, we can start discussing what's the
> best way to fix this.

Please give me some more time, I'm adding some prints do understand
why current logic does not mark r8 for state that has "if r8 >=3D r0 goto 1=
f;\n"
as it's first instruction, on a surface it should.


