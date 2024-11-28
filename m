Return-Path: <bpf+bounces-45792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298879DB151
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640A7B23AC0
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3B45C1C;
	Thu, 28 Nov 2024 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eftJTDrF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80B38DFC
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759282; cv=none; b=PiGK0aeWIN1GzB8q9PkhHxZXA6Y5cGv+xtVD79WhyfG9Rz8ex+syCsgXvMT7PYmeCvOYovkbiGF7rWYzyT0uJzHcCnZcmm5HxBP9TruSgK7F2hpAliLpXzDgpGNyObOdosabHfuumwSaMYX4hSN8CwvnK7TgA2wGj1PZ7ZcTkJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759282; c=relaxed/simple;
	bh=UWm0d3EE+T4OrvFIlgu1U7C5ZPlm2EmedYrNorBbJWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNen+pJwixqYDTTyUO5Y4y7UUoDK1/cT+YZjVpp6cbNJt8Qp1mFw1TLGdIHJ6aAOreaqNiCOuBFdlw9Urd1ES5MEGAGqsMxESuqUzkFfhyrgTk27B5JO3LNROhSFLFxZ7kZdr+3gxzAQuOflVoHxHlE5f5AHmLRNS0By3EfUK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eftJTDrF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21271dc4084so1996715ad.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732759280; x=1733364080; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZR7gV+PmrzLvvHYemOfaDqCJ514j2LZFjHBWefbGy48=;
        b=eftJTDrFT3/LAByZWYUuUua7kCZxRrp3hLHgZRik+J5W3MbJ2607rfPE4oaZetC7rS
         c4lyrrWhsnfRaWT5w1iGE378oJhtbtFbzVfZXLHoumv9smR29iTMHqW9fbhpHVl5/L9n
         WkkhXG0C5Z1PZLdMSskc8Qb9NzjCayH5aWsLt52gcyNIw4VEZrksX2Tthfed692IJQan
         dbeb++r0yn3F0MJXDKBrU78Zt1kfC+vxat8GDcr81hSYNGoptu0y649PkyJ2GjjDXX7P
         acPNi6K9u+QQCDA9w8lzL2hT3TR9PeAPhTacLeYcHgodhmK8cBsvkCjkTCX+kUk0OQab
         6Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732759280; x=1733364080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZR7gV+PmrzLvvHYemOfaDqCJ514j2LZFjHBWefbGy48=;
        b=sDzZEhMbvw0z7gjOhbGmPRMh8Tajw8TpYofENptySCBvrewKeBjk8JC/8odfkivvr7
         nSynSn6TQXxJq0G/Y2F+/J6cRuazNiQr001e6HfKXHpu38RYyaFK9EAMsVPPYoA3fvpJ
         uONfhDp+IxUSpgeWLg9CCIvbF//2UfGL9OAsDezvQMrGjYHFVAjJLY6FSXvsqfw9cOyC
         uyBAttcpcoDHau4/W3ZtYtIhGMgvCzeNbjn7CxsiFhmVA2vW6Y1nfKV69WF/QxLev2y6
         ITCm7WB1EUw8ZKp6QcBtpHkaLFlJcOB6Bww20XsBfdrLlVG6JEFCUYDeMZ99ukhsprJ1
         /W/g==
X-Gm-Message-State: AOJu0YzyW+gkcBDpsH0k/1i5p5SpL54M3FwVckrPAo03V/O+T1yDvWXa
	GrNszWyMp9jyIRydkm3EmJCPZPDJf4f7I06PMFwUZ1b/Etb2PMFh
X-Gm-Gg: ASbGncszWCDa+ENFgV0n7wc4oCxDw8vxPpkERUL9UCON1XoqGUIjQArr4Q80HFEKOH2
	J1Acrs8iT2ve8kRBBaI23o0DyITCFWNWDJfAJAcRwPLdT+X5IfIGaFVwYtDRY1sNqro2LRtgV6b
	Xk8M8X/j60Iq7doz3lmfPuytEm9whSd5/WHpow3MH3ICPmhWdFhVHJnXRA9vbdFk9JTR6HlYVaB
	l8DDpvwgfJg3CPzaTVFbD3E8oSkTl71QcCJJ8GaJZ8GOs8=
X-Google-Smtp-Source: AGHT+IEd9Z0atY/pRt4stSoE+WHl/BPUL1exqrwYwmwoAMBmOZrQ5fug7kA9gLVLImHkKRFwZ4mliQ==
X-Received: by 2002:a17:903:32d0:b0:212:5ba8:882b with SMTP id d9443c01a7336-21501f69bb1mr69319465ad.57.1732759279261;
        Wed, 27 Nov 2024 18:01:19 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521969c6esm2331905ad.131.2024.11.27.18.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 18:01:18 -0800 (PST)
Message-ID: <07cb2eacc4f56f9b60f9c41e9f398bb20618f3f1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add test for reading
 from STACK_INVALID slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
 Mathias Payer	 <mathias.payer@nebelwelt.net>, Meng Xu
 <meng.xu.cs@uwaterloo.ca>, Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Wed, 27 Nov 2024 18:01:14 -0800
In-Reply-To: <CAP01T76567Rf4iou=9CF+iWOVQp0VHwvEcUyaeS_2kx9hZBgWQ@mail.gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
	 <20241127212026.3580542-4-memxor@gmail.com>
	 <f0fbf1268f34b3eb7b74359dc11ec4299f5d77ad.camel@gmail.com>
	 <CAP01T76567Rf4iou=9CF+iWOVQp0VHwvEcUyaeS_2kx9hZBgWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 02:57 +0100, Kumar Kartikeya Dwivedi wrote:
> On Thu, 28 Nov 2024 at 02:50, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Wed, 2024-11-27 at 13:20 -0800, Kumar Kartikeya Dwivedi wrote:
> > > Ensure that when CAP_PERFMON is dropped, and the verifier sees
> > > allow_ptr_leaks as false, we are not permitted to read from a
> > > STACK_INVALID slot. Without the fix, the test will report unexpected
> > > success in loading.
> > >=20
> > > Since we need to control the capabilities when loading this test to o=
nly
> > > retain CAP_BPF, refactor support added to do the same for
> > > test_verifier_mtu and reuse it for this selftest to avoid copy-paste.
> > >=20
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/verifier.c       | 41 ++++++++++++++++-=
--
> > >  .../bpf/progs/verifier_stack_noperfmon.c      | 21 ++++++++++
> > >  2 files changed, 56 insertions(+), 6 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_=
noperfmon.c
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tool=
s/testing/selftests/bpf/prog_tests/verifier.c
> > > index d9f65adb456b..aaf4324e8ef0 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > @@ -63,6 +63,7 @@
> > >  #include "verifier_prevent_map_lookup.skel.h"
> > >  #include "verifier_private_stack.skel.h"
> > >  #include "verifier_raw_stack.skel.h"
> > > +#include "verifier_stack_noperfmon.skel.h"
> > >  #include "verifier_raw_tp_writable.skel.h"
> > >  #include "verifier_reg_equal.skel.h"
> > >  #include "verifier_ref_tracking.skel.h"
> > > @@ -226,22 +227,50 @@ void test_verifier_xdp_direct_packet_access(voi=
d) { RUN(verifier_xdp_direct_pack
> > >  void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
> > >  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
> > >=20
> > > -void test_verifier_mtu(void)
> > > +static int test_verifier_disable_caps(__u64 *caps)
> >=20
> > The original thread [0] discusses __caps_unpriv macro.
> > I'd prefer such macro over these changes to prog_tests/verifier.c,
> > were there any technical problems with code suggested in [0]?
> >=20
> > [0] https://lore.kernel.org/bpf/a1e48f5d9ae133e19adc6adf27e19d585e06bab=
4.camel@gmail.com/#t
> >=20
>=20
> I think that patch worked as well, but I got to look at this now after
> all these months, and concluded that
> what Daniel did in
> https://lore.kernel.org/bpf/20241021152809.33343-5-daniel@iogearbox.net
> was also
> acceptable and preferred.
>=20
> I can add your patch to this set and respin, or post a follow-up converti=
ng
> test_verifier_mtu to it as well. Whatever is preferred.

Patch #1 would need a respin because the comment for mark_stack_slot_misc()=
 needs fixing.
If you agree with adding __caps_unpriv, could you please make it a part of =
v3?

[...]


