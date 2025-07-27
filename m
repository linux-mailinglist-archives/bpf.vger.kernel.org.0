Return-Path: <bpf+bounces-64462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18737B1321A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 00:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0064818906F4
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 22:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABF2472A6;
	Sun, 27 Jul 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQCrOced"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE904A11
	for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753653602; cv=none; b=a2UfGRpMilFDSLH5RBnH3uVEkd9obg0yOYs4rbrp3Xj0QmHQ3zfofA1B3d3nU1CjeahW4bcZH3/jyL5GF/6A9fmZfUmrzG9ylz/hiUaNHD4wYUNB3Za8mvA/sVdmO6WsW03cWyyGVGQfic5ffETRMEsQnXzFuTTc+ud8dIB+96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753653602; c=relaxed/simple;
	bh=OFcesHnwXQ6s/tXD3BalnBZun5reM15avV0oxWvWsrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QVljTxbJj1qh8GmvI9XI/060HcWrWCrZt32r4EQyAoP4hDINf/nkGJQy028XiTuAAuzkOVInPLDohcPME60KZGAZXZeiCRVPbqw2Mzhu/Vg8Nzw8LSmonkeVwd5JFYu36Tty9e+2UogFv1AVzlWTNvKFQI6vOz8cGFiomNIfmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQCrOced; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748e378ba4fso4740018b3a.1
        for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753653600; x=1754258400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z7y53oibyFi9f2igTiOkCWqfCKyKCqHN6TlXQC2GoGY=;
        b=jQCrOced6axOXEkK44FBtr1OAeTF2/q6rWrxTFKOtHDDm//23Yf+jOHw8JMo/ZwpWF
         uRSsP8p2x/0FUKVUZMpxTT6LcIs5212xZriUAs/SNh07YU70TODoLKqVOAm00qgQZRNU
         IHE/9hS+50fN5GwUxabP9Ua1HKPMgvHnoEBrzl/7VvdQutcsF2ncR6am6TO2/FlzhaZN
         eKbq9OVn3KrmRfF2mw68IM5q3Fhd2rp9d43Po6zCdng37LIqsJM07XgRPigLG6hpylqs
         qNZibbY23Cob15H6C/qp/U+DoDmMmi7QHExiLsI+O5p5booWh6Ximm7qYfA55AUCJsw1
         pqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753653600; x=1754258400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7y53oibyFi9f2igTiOkCWqfCKyKCqHN6TlXQC2GoGY=;
        b=j63uk5loKq4mpAeI/XRTly9Qpezb/RjZJz2ZHd0P7lJkTElafBcfFfQuN5YHAhjAoS
         Orv+woylGtclwDJtSRWuqXhPXVQQuGkyU7BoUvnVkVEABLr3f8j1I28KTIKdTOFfNqdv
         rMhp2KV8uEdEcipApN0xosnOCIax/0z0hURdc2GyxE/PLmWLdE2HTkUwcefmzK+bbPxg
         VoOuyBdSx3kD30lwAnUYmGKCUv25uWfM6+9d4PPLkOcndqDd8KMfhR1j/btwhQMsBaNz
         nuE1J+UOws3rO3KFsO1tkdbZnnn9xfHWcbhjCZEOghXByLeGfe1lsUUbGKoou1bxTF2j
         sgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk7iv5uBSt8guKhRT3BsqI/s3tyDenPFjKYet+HiWRPmK67RRRLUlrB+ttVxVIVcQ2LFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7DWlSZ01WxunHli7T+d5NmMmogAqIV1CHJrTxAicAsysbi95l
	bsoAMRzTnFJHPXQPkK8fW/w/CfsFyvLBTq6lPLX6JfnHpQAQa6Kcu5Y7
X-Gm-Gg: ASbGncuKM2Qn2t9fMc4lwhWnR6yWr204qMQZeHXg/yqqSbtn5GzWtG3q7TQv/d3GYyG
	fa+0BKh/Y4TBiXVdn2FK0/4nzoIXxsDYJ+ApS1MJY0RZa11E9nfCrl5+sqKAOUvDkxKEEgPGPRN
	4w4wDheTmOtrJxTOwg4kJK5XHi0dEQdN0ukZ0eAvJT/VHeUemx0qaEGyQLETsilOdgNvGrhXVne
	nQXL4IY39pqKX7/ujW2zkBPmy/G0B75Hg3WaWKrIkqdwCyI51HPgG3g6puq25WO5UBge/8Fm+OJ
	DUnyNwv2Km6DxTZfgfKDbr+smNFpT1Krgp/ZuRbd2JlsrH9sdomM++nuwZdFP4K7bzWMs0ElvGq
	A+ZmNA2zJW1QB2bqYnw==
X-Google-Smtp-Source: AGHT+IFwpfYNiYmrF9OaVaKU4jnBy2GnbUu8mr2zOPQEu2ox7LJHeOoFVaXf70uuh4fZlfgHQNr6Gw==
X-Received: by 2002:a05:6a00:1410:b0:748:34a4:ab13 with SMTP id d2e1a72fcca58-76332c46a56mr13961372b3a.6.1753653599748;
        Sun, 27 Jul 2025 14:59:59 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02727sm4074874b3a.48.2025.07.27.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 14:59:59 -0700 (PDT)
Message-ID: <f1e5b0cad2f34f3670603be11be52ccb28c42a08.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] selftests/bpf: Test cross-sign 64bits
 range refinement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Sun, 27 Jul 2025 14:59:55 -0700
In-Reply-To: <efbb1967c5595dcf4a0b334f934b6d59c6c20d30.1753468667.git.paul.chaignon@gmail.com>
References: <cover.1753468667.git.paul.chaignon@gmail.com>
	 <efbb1967c5595dcf4a0b334f934b6d59c6c20d30.1753468667.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-25 at 21:08 +0200, Paul Chaignon wrote:
> This patch adds coverage for the new cross-sign 64bits range refinement
> logic. The three tests cover the cases when the u64 and s64 ranges
> overlap (1) in the negative portion of s64, (2) in the positive portion
> of s64, and (3) in both portions.
>=20
> The first test is a simplified version of a BPF program generated by
> syzkaller that caused an invariant violation [1]. It looks like
> syzkaller could not extract the reproducer itself (and therefore didn't
> report it to the mailing list), but I was able to extract it from the
> console logs of a crash.
>=20
> The principle is similar to the invariant violation described in
> commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
> JSET"): the verifier walks a dead branch, uses the condition to refine
> ranges, and ends up with inconsistent ranges. In this case, the dead
> branch is when we fallthrough on both jumps. The new refinement logic
> improves the bounds such that the second jump is properly detected as
> always-taken and the verifier doesn't end up walking a dead branch.
>=20
> The second and third tests are inspired by the first, but rely on
> condition jumps to prepare the bounds instead of ALU instructions. An
> R10 write is used to trigger a verifier error when the bounds can't be
> refined.
>=20
> Link: https://syzkaller.appspot.com/bug?extid=3Dc711ce17dd78e5d4fdcf [1]
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +/* This test covers the bounds deduction on 64bits when the s64 and u64 =
ranges
> + * overlap on the positive side. At instruction 3, the ranges look as fo=
llows:
> + *
> + * 0 umin=3D0                      umax=3D0xfffffffffffffeff       U64_M=
AX

Nit: when I insert prints on master the umax is 0xffffffffffffff00,
     which makes sense, as for the false branch the bound for r0
     would be deduced from r0 <=3D r1 with r1 =3D=3D 0xffffffffffffff00.

> + * [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]            |
> + * |----------------------------|------------------------------|
> + * |xxxxxxxx]                                         [xxxxxxxx|
> + * 0      smax=3D127                                smin=3D-128    -1
> + *
> + * We should therefore deduce the following new bounds:
> + *
> + * 0  u64=3D[0;127]                                              U64_MAX
> + * [xxxxxxxx]                                                  |
> + * |----------------------------|------------------------------|
> + * [xxxxxxxx]                                                  |
> + * 0  s64=3D[0;127]                                              -1
> + *
> + * Without the deduction cross sign boundary, the program is rejected du=
e to
> + * the frame pointer write.
> + */
> +SEC("socket")
> +__description("bounds deduction cross sign boundary, positive overlap")
> +__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__msg("3: (2d) if r0 > r1 {{.*}} R0_w=3Dscalar(smin=3Dsmin32=3D0,smax=3D=
umax=3Dsmax32=3Dumax32=3D127,var_off=3D(0x0; 0x7f))")
> +__retval(0)
> +__naked void bounds_deduct_positive_overlap(void)
> +{
> +	asm volatile("			\
> +	call %[bpf_get_prandom_u32];	\
> +	r0 =3D (s8)r0;			\
> +	r1 =3D 0xffffffffffffff00;	\
> +	if r0 > r1 goto l0_%=3D;		\
> +	if r0 < 128 goto l0_%=3D;		\
> +	r10 =3D 0;			\
> +l0_%=3D:	r0 =3D 0;				\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[...]

