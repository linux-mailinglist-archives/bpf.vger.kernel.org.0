Return-Path: <bpf+bounces-45793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA72D9DB156
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCE8B210C0
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3D45005;
	Thu, 28 Nov 2024 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNTF0wLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A14C7C
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759673; cv=none; b=kjUS8rwB2917rpd0XHpZXshBxhN9ruWCMLG+cKGFOf2mNj0IrtQGNlRTiuFqv4voGVPal+rmhCRqkpDyhzPPvV93B/DH9x3VA+F2BGTki3b28v856U5Ffh+HiDsR5W6vtUbGW93FDLwY+f2h5Pdl7u4YX96imWIQqmSyINdB7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759673; c=relaxed/simple;
	bh=t1jBoMmW3wuY1EqirlnmTu4HRURbAbrVZOrnNd7hubk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZkVNTwB1/YC/ZsxcjEundnRA5cqL6tFLzdrp9j0olJCWFfodFYpwKFuz3KTRxuAiCAXmEPraT/OoX6mmzudnmPTkaY3kLA1us4oUtX/Fa5Q3RTXeBN/f9B7iNMnXAvaSi4y54/Tzwl6d5EMBcrQ6WNzMeBZ7OtM4nCo+AVUDnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNTF0wLn; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aa545dc7105so39516066b.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732759670; x=1733364470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0m8Mj9hCCQXIZ4HCQRIiLnOe6BDcCQpNfGszX1SpXM=;
        b=ZNTF0wLntdR27QWY4HhR0P8PuR+ayPgZ0PYg3vfdd39kKDzMRq4lcaKgu4vldull3H
         FHrajQgpFrgp+6zlGQSpefoi/L8ZnbvN6xIhhByZ5UZGTZO65E/SFYpW8qY5FwFrv1Ee
         50z9tUtVvzSPep0uk3b65atc+wJHzRYnQDCxECrMioA9IUIilJKnWIfqdhzTE7p1yYZZ
         o+aSBHMMCow3fdjA6G36iOtFtfA+fFLrG/0S46NUTLez5cfpnY1vcUqMBUUlvipemQcS
         tpd0DDQ/P+Xv+IupOxlgyNJq9aEszlTL4DPhS+YZXzV76hPuDg9yr26RBbBDkl2Qfjfe
         0hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732759670; x=1733364470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0m8Mj9hCCQXIZ4HCQRIiLnOe6BDcCQpNfGszX1SpXM=;
        b=rslI4tm23s/c40U6Ng3aF9dMQwHP6Ax1MYtNOm9BAB8/qNQZS/EEpkaAbQiVGS/NXB
         p2XhnMhPD3/1+de/7gvWJl/PbW8sEkMRPSsaFwYndHIE78QYHjnVKMWypGwatbPH2Rq7
         ymsehqOsn4kKDsOGPn77D1g50FVoCmZIX77SrASUnhs9YVg7FcfjqZ+P2WrUdbc6ZIsB
         0jkHInxA0fv2nk9eCHdOa2iVuhNTb0ig0fvZuo+OgH9Tf1unSHMFWun9dyZFs0hQZUpY
         FY1PCGLifNMMd5W1cwZJ+/4N56cKkLX8ntkg14D5yuuFCIaAFBZTXoOoE/Fh4uMw/Obv
         5aCQ==
X-Gm-Message-State: AOJu0YxLrNiy4EEjngCsJbIsl7cvIRr+lCR5rF6ggjZ4H5XwW9uulWqP
	uinVT8eWB07xMzrjH820uHHR9/5obQidXiL+qRhHRYvnA+7wuF1ZfGEx4fGU303qvZuxyKaTr9d
	mtGopHLR7fCBDZ1qar5o7nqNb/cY=
X-Gm-Gg: ASbGncth85+1dBJrd+/m/QMDatNDHwly/8/T8bMOMyQRZPv0MaV1yqM+5DKtHJIHnge
	xoLTnZ2xXCoKQZq537jVrhglhA2MWNFWV
X-Google-Smtp-Source: AGHT+IGeXlV7b2x8pnPY5Vz79atewuCDLeZE1wJx/bWvbgvlhb5FyiByJkDMqw56Pit9zbA22/yyIgqJnh9qmIFmEVY=
X-Received: by 2002:a17:907:7781:b0:aa5:451c:ce22 with SMTP id
 a640c23a62f3a-aa580f4c958mr393807266b.31.1732759669983; Wed, 27 Nov 2024
 18:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212026.3580542-1-memxor@gmail.com> <20241127212026.3580542-4-memxor@gmail.com>
 <f0fbf1268f34b3eb7b74359dc11ec4299f5d77ad.camel@gmail.com>
 <CAP01T76567Rf4iou=9CF+iWOVQp0VHwvEcUyaeS_2kx9hZBgWQ@mail.gmail.com> <07cb2eacc4f56f9b60f9c41e9f398bb20618f3f1.camel@gmail.com>
In-Reply-To: <07cb2eacc4f56f9b60f9c41e9f398bb20618f3f1.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 03:07:13 +0100
Message-ID: <CAP01T76+q10MDqypwng-Rk4-2yvjp+rAqycG7cB_82oNfX3gYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add test for reading from
 STACK_INVALID slots
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 03:01, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-11-28 at 02:57 +0100, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 28 Nov 2024 at 02:50, Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Wed, 2024-11-27 at 13:20 -0800, Kumar Kartikeya Dwivedi wrote:
> > > > Ensure that when CAP_PERFMON is dropped, and the verifier sees
> > > > allow_ptr_leaks as false, we are not permitted to read from a
> > > > STACK_INVALID slot. Without the fix, the test will report unexpected
> > > > success in loading.
> > > >
> > > > Since we need to control the capabilities when loading this test to only
> > > > retain CAP_BPF, refactor support added to do the same for
> > > > test_verifier_mtu and reuse it for this selftest to avoid copy-paste.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/verifier.c       | 41 ++++++++++++++++---
> > > >  .../bpf/progs/verifier_stack_noperfmon.c      | 21 ++++++++++
> > > >  2 files changed, 56 insertions(+), 6 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > > index d9f65adb456b..aaf4324e8ef0 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > > > @@ -63,6 +63,7 @@
> > > >  #include "verifier_prevent_map_lookup.skel.h"
> > > >  #include "verifier_private_stack.skel.h"
> > > >  #include "verifier_raw_stack.skel.h"
> > > > +#include "verifier_stack_noperfmon.skel.h"
> > > >  #include "verifier_raw_tp_writable.skel.h"
> > > >  #include "verifier_reg_equal.skel.h"
> > > >  #include "verifier_ref_tracking.skel.h"
> > > > @@ -226,22 +227,50 @@ void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_pack
> > > >  void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
> > > >  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
> > > >
> > > > -void test_verifier_mtu(void)
> > > > +static int test_verifier_disable_caps(__u64 *caps)
> > >
> > > The original thread [0] discusses __caps_unpriv macro.
> > > I'd prefer such macro over these changes to prog_tests/verifier.c,
> > > were there any technical problems with code suggested in [0]?
> > >
> > > [0] https://lore.kernel.org/bpf/a1e48f5d9ae133e19adc6adf27e19d585e06bab4.camel@gmail.com/#t
> > >
> >
> > I think that patch worked as well, but I got to look at this now after
> > all these months, and concluded that
> > what Daniel did in
> > https://lore.kernel.org/bpf/20241021152809.33343-5-daniel@iogearbox.net
> > was also
> > acceptable and preferred.
> >
> > I can add your patch to this set and respin, or post a follow-up converting
> > test_verifier_mtu to it as well. Whatever is preferred.
>
> Patch #1 would need a respin because the comment for mark_stack_slot_misc() needs fixing.
> If you agree with adding __caps_unpriv, could you please make it a part of v3?

Should I leave STACK_INVALID as-is regardless of privilege, which
would basically remove the need to check allow_ptr_leaks in this
function? As you said, pruning considers them equivalent if
allow_uninit_stack and stack_read logic allows loading from invalid
slots, so upgrading to STACK_MISC isn't necessary.

>
> [...]
>

