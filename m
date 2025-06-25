Return-Path: <bpf+bounces-61576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34135AE8F4F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F57B1C264B9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BFB262FED;
	Wed, 25 Jun 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgL8Laq+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA42DCBEE
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750882745; cv=none; b=RYJkTAD9zVQHaKjs0B7yKT1icy25zJ2u6xW+Szyptlc4k/QA2muAccM/PfkQ5jpjrE+32dlXBWnq7SCitQC1J5rgW33i12SQ9QzkmHcF8yfsMvhNhRGhQneKNVUaasbNnn1vC1YW6RJ9J8k7l0Cmy18KOZBN6ThCCHmPCB2eJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750882745; c=relaxed/simple;
	bh=QGjtmn8uKj3LuhCquIcj/WZxaE0JdxfjDChYnXoPBNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ujxw7XnHNNJo4SSS+c7IoQ9lujl6ium4aSpp5uqmN0KUQ9ZTDRVW/NfU8acLYxb/nUL0mt/LvJRJTuaxt7A3400pyiKjRYZtE0Aw7FUE8gRqlfhCRm5i4BA5y+o6stD3XtAnSRVo6N6U6dgkL9WcpJwxP6FhTGXTy4OoFI8RLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgL8Laq+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so471165b3a.2
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750882743; x=1751487543; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6WkbkupaKfdy05A+bt/tCcp1462qmB0e/l5MaQSJwcw=;
        b=NgL8Laq+WSGsM0oHVtOPJCgQ39r7y8DMQ6X061kuxeoWGDR+6qe+ye6ZgZfdksdXwu
         AJ72QZ7ZJH+w1Dt/72OIsT0iSJLCzB2yaP78jC/RsM/isYtYXzVzAJytNBVx5cvodpy3
         aEnPyL+DlJ8vzwDXenvNwaDi5TkDRcBPJM4Oa6EIx6ZTR2V28+BalbgbaXljkIl2bcp6
         z3UvkeNhCQ3OrT03544TW5+R6OI9PrnclNw6Q1Gb2TABEvo7fOp0NFFe0mR6PZjboePD
         bihfLLkcO6sBh41PHw7kdiNX9GXtcmdlehtLXO2TkFCz/8w+PLjz4lVTWPtaFFDGwxmE
         K7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882743; x=1751487543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WkbkupaKfdy05A+bt/tCcp1462qmB0e/l5MaQSJwcw=;
        b=re8WtBX4Eqm1H8epeq0gdEZH6H0BXd3yoYO0z6kJQzRHfbW6ZS2ERsCtjSYVnJ1eXB
         64VNr6UC8jQOFrjTqKf28byCV+ohYV298rL2J20o1pCC+1F5IfDcGbixGrJY+VN/EauG
         T7zoBLo7AZvGvsZgZvJy3rwTmA6prLmWJbwKIajrkX8Np40C4375B2Rv4sPDPx+a6o+U
         nmiW7Nn5q5Je5G8cxY7Lx8Y4cSAz3z2Vk77WQyaQT4E6mSPCzeajxWy0+A2xGE3XMq9z
         4IuPLPAdf3kxEgqPb7aFDtg0WwDaU6s2AXVj4+AX9GxY/4BJnw0E5CGtL3RvgQe3UAvF
         nmig==
X-Forwarded-Encrypted: i=1; AJvYcCXqw51zMflJ5o6DO9yO0a0Rn54cmC4cqOaaJ/1OmjSp5ZzFxjrl/kgz7ctcRgAf+weqfbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8uoorOl99DBQXmGYWoJaUCuPYjg84m5Lirn1fqM/4f746F6i
	F1hPSDn/T4FfwxaSnePFUrnGRI5OQdDxkVmTZJ97Dv1wrTbAlAHGz3pX
X-Gm-Gg: ASbGncsym2A+aFZMafU/8J2lbodSVkyTynAC4Om1jvXqA9McRyUjeP71mikvZBeSiaD
	SC2qsl6xfMJIHtsAJjYg4EuOUNVna0/sKoEgnU3lqpytjzvpaxvIGWSzBBylKDbl7smx6Bni2Z9
	jarmdAo4jcuWnM/CGOVO5JTpdqLuwkDOBMoe0qvhQ2Y8nI17OA2/mPIfq4KzPNpljbasQ8lH/rc
	jMnYmDJwjiWa2ABpESKaEZQVSK76l/4NwKZBzaouLANXith6b0mOFlj3YHYh5gwyIvmO2uDqJOx
	7hxphS+zN/fHtoDlzoLnKtTPWxQ8/ttUQlgwysv/vmv15e93R1VR4/Xn+gGSy4LDFy2dZ3jpa9S
	5+blfp1h2VGk=
X-Google-Smtp-Source: AGHT+IH9HFXxPp9QkEJl4hZz7U0+eVmtPEGwKb57rafkIa3trKEmwMwIKOjKcVvvTvsS3DHDf/YsNQ==
X-Received: by 2002:a05:6a20:2d11:b0:21e:f2b5:30de with SMTP id adf61e73a8af0-2207f1d7e7bmr7427079637.12.1750882743347;
        Wed, 25 Jun 2025 13:19:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f11ac8eesm13548704a12.34.2025.06.25.13.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:19:02 -0700 (PDT)
Message-ID: <402ecbeabdd090b81ae35d2187c344779ff926c7.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix unwarranted warning on speculative
 path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Luis Gerhorst
 <luis.gerhorst@fau.de>
Date: Wed, 25 Jun 2025 13:19:01 -0700
In-Reply-To: <aFw5ha9TAf84MUdR@mail.gmail.com>
References: <aFw5ha9TAf84MUdR@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 20:01 +0200, Paul Chaignon wrote:
> Commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1") added a
> WARN_ON_ONCE to check that we're not skipping a nospec due to a jump.
> It however failed to take into account LDIMM64 instructions as below:
>
>     15: (18) r1 =3D 0x2020200005642020
>     17: (7b) *(u64 *)(r10 -264) =3D r1
>
> This bytecode snippet generates a warning because the move from the
> LDIMM64 instruction to the next instruction is seen as a jump. This
> patch fixes it.
>
> Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  kernel/bpf/verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 279a64933262..66841ed6dfc0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19819,6 +19819,7 @@ static int do_check(struct bpf_verifier_env *env)
>  	int insn_cnt =3D env->prog->len;
>  	bool do_print_state =3D false;
>  	int prev_insn_idx =3D -1;
> +	int insn_sz;
>
>  	for (;;) {
>  		struct bpf_insn *insn;
> @@ -19942,7 +19943,8 @@ static int do_check(struct bpf_verifier_env *env)
>  			 * to document this in case nospec_result is used
>  			 * elsewhere in the future.
>  			 */
> -			WARN_ON_ONCE(env->insn_idx !=3D prev_insn_idx + 1);
> +			insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
> +			WARN_ON_ONCE(env->insn_idx !=3D prev_insn_idx + insn_sz);

Could you please elaborate a bit?
The code looks as follows:

                 prev_insn_idx =3D env->insn_idx;
                 ...
                 err =3D do_check_insn(env, do_print_state: &do_print_state=
);
                 ...
                 if (state->speculative && cur_aux(env)->nospec_result) {
                         ...
                         insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
                         WARN_ON_ONCE(env->insn_idx !=3D prev_insn_idx + in=
sn_sz);
                         ...
                 }

The `cur_aux(env)->nospec_result` is set to true only for ST/STX
instructions which are 8-bytes wide. `do_check_insn` moves
env->isns_idx by 1 for these instructions.

So, suppose there is a program:

     15: (18) r1 =3D 0x2020200005642020
     17: (7b) *(u64 *)(r10 -264) =3D r1

Insn processing sequence would look like (starting from 15):
- prev_insn_idx <- 15
- do_check_insn()
  - env->insn_idx <- 17
- prev_insn_idx <- 17
- do_check_insn():
  - nospec_result <- true
  - env->insn_idx <- 18
- state->speculative && cur_aux(env)->nospec_result =3D=3D true:
  - WARN_ON_ONCE(18 !=3D 17 + 1) // no warning

What do I miss?
Could you please add a test case?

>  process_bpf_exit:
>  			mark_verifier_state_scratched(env);
>  			err =3D update_branch_counts(env, env->cur_state);

