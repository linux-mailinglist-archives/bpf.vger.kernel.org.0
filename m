Return-Path: <bpf+bounces-63672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FEB0960B
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 22:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B731188AF08
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250C22A4D6;
	Thu, 17 Jul 2025 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWA/cVgw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E885EEBB;
	Thu, 17 Jul 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785810; cv=none; b=V1K0nhOSrIG2WKFOrR0Xe9KS719kwwfoyhwiIP7PF5YDy25WSSOH/2/tJNdNBeZs9sQHsFBx2B2cYYQv6KBmPPpYPaHIKNuIweMfaGsuWJI6x+W8Zv9peGVKaf9ZdCpe+tWMwbhPmHF8BWbwipOhQC4Y1Npygg/DKbVnTCBpBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785810; c=relaxed/simple;
	bh=Ys203Svg62wgyIV0TPHIA8gLtygtPUojKJwCWhI3mMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bv0iWPGPx2yAdd6Yn3tusdTzfbwXW4uI58BNQJ827a2vM7bp9JODKPBeFY3lKC+UvWhorsJi1jYN2n/JVyGPebT2N2Yshyo5gi1cH7HlFc6HfdogdniPbcOJNpxHCLgKL08G0wWzD1q5NLHVaRHV+G+eKNYhU/TxKPQbp8BrcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWA/cVgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48843C4CEE3;
	Thu, 17 Jul 2025 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752785809;
	bh=Ys203Svg62wgyIV0TPHIA8gLtygtPUojKJwCWhI3mMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rWA/cVgwaGrm6pq4B7i4gDgcU3D87a0eBpWBu6FZZv6GNu/oXL0sn2F7la8RX9keL
	 ZIaOeZynH3rSAnQr7/ivnd9PGS8+RxmcNv7IqrApDqvJqViLlUEF/a+vIRWMtN3L0v
	 VM/T8+IiOeS6/oba0yONX3gEq6E5ZJHPQQf5/3VXBcXoCm4SG56nnjD0x3ygYC9uU4
	 VqWtTn4aaJQ6x53maV01dTbDeTI94kdV875y9BOY6yvUEg6Ip8QOfCumfCnINkJwHI
	 aJweomH1oTn2dEaoxKbr+ft7C1RdnxvFMD3+5tgWKhHpIbXdFsiO7fir+0B6ws+nS1
	 C4NK478mZE6wA==
From: <puranjay@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Hari Bathini
 <hbathini@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 lkmm@lists.linux.dev
Subject: Re: [PATCH RESEND bpf-next 1/1] powerpc64/bpf: Add jit support for
 load_acquire and store_release
In-Reply-To: <20250717202935.29018-2-puranjay@kernel.org>
References: <20250717202935.29018-1-puranjay@kernel.org>
 <20250717202935.29018-2-puranjay@kernel.org>
Date: Thu, 17 Jul 2025 20:56:45 +0000
Message-ID: <mb61pfreuy1rm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

Somehow the cover letter for this patch was missed, adding it here:

To test the functionality of these special instructions, a tool called
blitmus[0] was used to convert the following baseline litmus test[1] to bpf
programs:

 C MP+poonceonces

 (*
  * Result: Sometimes
  *
  * Can the counter-intuitive message-passing outcome be prevented with
  * no ordering at all?
  *)

 {}

 P0(int *buf, int *flag)
 {
         WRITE_ONCE(*buf, 1);
         WRITE_ONCE(*flag, 1);
 }

 P1(int *buf, int *flag)
 {
         int r0;
         int r1;

         r0 = READ_ONCE(*flag);
         r1 = READ_ONCE(*buf);
 }

 exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)

Running the generated bpf program shows that the bad outcome is possible on
powerpc:

 [fedora@linux-kernel blitmus]$ sudo ./mp_poonceonces
 Starting litmus test with configuration:
   Test: MP+poonceonces
   Iterations: 4100

 Test MP+poonceonces Allowed
 Histogram (4 states)
 21548375 :>1:r0=0; 1:r1=0;
 301187   :>1:r0=0; 1:r1=1;
 337147   *>1:r0=1; 1:r1=0;
 18813291 :>1:r0=1; 1:r1=1;
 Ok

 Witnesses
 Positive: 337147, Negative: 40662853
 Condition exists (1:r0=1 /\ 1:r1=0) is validated
 Observation MP+poonceonces Sometimes 337147 40662853
 Time MP+poonceonces 13.48

 Thu Jul 17 18:12:51 UTC

Now the second write and the first read is converted to store_release and
load_acquire and it gives us the following litmus test[2]

 C MP+pooncerelease+poacquireonce

 (*
  * Result: Never
  *
  * This litmus test demonstrates that smp_store_release() and
  * smp_load_acquire() provide sufficient ordering for the message-passing
  * pattern.
  *)

 {}

 P0(int *buf, int *flag)
 {
         WRITE_ONCE(*buf, 1);
         smp_store_release(flag, 1);
 }

 P1(int *buf, int *flag)
 {
         int r0;
         int r1;

         r0 = smp_load_acquire(flag);
         r1 = READ_ONCE(*buf);
 }

 exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)


Running the generated bpf program shows that the bad outcome is *not* possible
on powerpc with the implementation in this patch:

 [fedora@linux-kernel blitmus]$ sudo ./mp_pooncerelease_poacquireonce
 Starting litmus test with configuration:
   Test: MP+pooncerelease+poacquireonce
   Iterations: 4100

 Test MP+pooncerelease+poacquireonce Allowed
 Histogram (3 states)
 21036021 :>1:r0=0; 1:r1=0;
 14488694 :>1:r0=0; 1:r1=1;
 5475285  :>1:r0=1; 1:r1=1;
 No

 Witnesses
 Positive: 0, Negative: 41000000
 Condition exists (1:r0=1 /\ 1:r1=0) is NOT validated
 Observation MP+pooncerelease+poacquireonce Never 0 41000000
 Time MP+pooncerelease+poacquireonce 13.74

 Thu Jul 17 18:13:40 UTC

[0] https://github.com/puranjaymohan/blitmus
[1] https://github.com/puranjaymohan/blitmus/blob/main/litmus_tests/MP%2Bpoonceonces.litmus
[2] https://github.com/puranjaymohan/blitmus/blob/main/litmus_tests/MP%2Bpooncerelease%2Bpoacquireonce.litmus

