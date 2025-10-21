Return-Path: <bpf+bounces-71644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D21BF91B1
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 00:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E35194FA97A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636ED2E7BDD;
	Tue, 21 Oct 2025 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo2AUayj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C852C326C
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086582; cv=none; b=qyqAPBs2+94dyxBMlbOPILXcx+02XnQQNGxTd47KJJZ0TbhvzmnLlRHF3mhm4LQOHi9a//7Ud23tGxJ+UfTqVjnDDDLybroJcGCDtv7ShdpAoAk/SQ5VhU/JIfPCv3HgrEmQUSgIS2cB+IgrBsIr5t+v8ppR2FrFj14prpprkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086582; c=relaxed/simple;
	bh=MzqSwiwer1zW9tfL+O4jCtylLrj6/cVtYWjZZN1u9is=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKbc6jx6UPCp4AZbYb5JB4AQMThxm5nt8quuZEEVZ9PkTdskI5AgVLW+ZvOtbxUreyz8KkXUSs5Ap24i5yJXtgdRtVfgEXYTcAXhpV3LR0OqLAc1Td5XMEdgfuyOvUd+px9C63xgw5ryFHpnMeb9x6loDY/e3mEx3It1sdYFxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo2AUayj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781010ff051so4593446b3a.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761086580; x=1761691380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNtjmbThiH7BdTtfw2oLKsTbwFsjoxfH7/HpFDUzcP0=;
        b=Xo2AUayjLx70GBDxBmBJDJtzJn/hllJx0WVMBiDe1CXHEzCA+eWZzKlBAY6yu8uczs
         RL4qcIFSAbJ3XGRtkilAq7cISG0SeDFAJxIiJA/RT4zncbmP5thpU96pTEMOObq5oIc0
         PggHmfK+fcooJ8VRTqt7ttkv1QioZFc1hrrgWeUdylMUkS0YnB+F4W5dahb6Yc7Tiu8l
         mBUIyO3TEEqeQFSK6X+TERNImx6T2hGtvHPwjgfW+N9IGdz2J3ODmmBK/D/QL9/Dnl6J
         pfArH1CzJkMtqvWZpYhneyk6tp55PBYyw+8Me2E55N8pDxHgOWXsXUBZIG41iN+xcuwa
         4eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086580; x=1761691380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HNtjmbThiH7BdTtfw2oLKsTbwFsjoxfH7/HpFDUzcP0=;
        b=cxLOuXZjRGg4zEQfLbTi9/VjcesnVGnDkHtPrOpk6blTQQFgIBqnk7lRVR9TRgyfaY
         lDt8LQsCSPGI3WpLyOtkRYBzzLD0USfcaN/uqQWXcz1nG88L05LqffifO834TrfFDARN
         EjtPd8gKWvW0jY3tMKgML8MAp83DuMfhZxn0fIvAlA96CILswXeqvG+gtoUZdQTEp4Qe
         5OTunYM78jOH6iisgQdWW2ux+qVEQs4uQnkQU2nsdY4uy/n5xPV5OnkiCZuiYpLx6QL6
         VOfL31ymJMnNq+wXDYgkrVSfzGvndXLE3Ka2XYsGeoROZNWJP+t67nbASzCtyl6yyfXU
         pKEw==
X-Forwarded-Encrypted: i=1; AJvYcCUHBlVj+9WGcMKDFt4RRI4Z9VZDkxkvKSlhmoE+vR2317NFmdvVbY3vml7uLd3OyfJ5Y70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFiwRGI/60Z1DqLr8RtGjhyNKP21ztlLAOtCXS3Xj5PqvK4Zk
	Kt/GdWIgwh1K/uirPSCqu3LSRjgrNLr5g+28T9/OweA8j/fzl8dwTWsF
X-Gm-Gg: ASbGncukk/72H1GpdzIffvgGSjAjJ2/W4hDTO14KhcybugflBJ72mzoKenkY1V9Nz/p
	4R4uDSItBpf/sjpapX1CBSR7qdAgYLx17qH9PISkWKWoK+Kuxq20+4pdZ3erXp219SKRbFLYFoj
	3Q2HOqfhTKMXKmEZyQ8A2qC4xnwVkvsIgcwZ1cQ8ombAHgp5i/Um3BJI6IE3fQbCmnhdBPA1oGb
	CACW+WN+7vm6zs+BvK7JNeMNa7DOxizRzhW/EwQZGVe2UUyo6fuB3T2wJ/4A44c3L6x9StL3dgW
	McnkMMr+x5i5+2o1YoPQI3+r+wkcsH1p2cCD7/7HGR9EKeJEmDTknhH4Ul0ais2hqMuBg5OXMFr
	iAYyjJBCKm+dRRiBu38DkMgPlo9pEAg/AKI8T8RQ0BQvK1GEDMarRKWP2nBKlsFphXqUr+0tmsz
	8hTVBvYEhoUJc9LvDv0u+upskkytwU6jjU68g=
X-Google-Smtp-Source: AGHT+IGVeB9pZsRRluUhaCG+FLAWMza21q77wgJgK0dUdiybSzmzUMI2pxF8LCUZXhLB3ZwFISf+zQ==
X-Received: by 2002:a05:6a20:3805:b0:334:a942:89f5 with SMTP id adf61e73a8af0-334a9428a30mr15578740637.9.1761086580102;
        Tue, 21 Oct 2025 15:43:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15c89sm12795759b3a.1.2025.10.21.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 15:42:59 -0700 (PDT)
Message-ID: <b0e59e59fbe35090809ccbe0b01d923212c789ab.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 16/17] selftests/bpf: add new verifier_gotox
 test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 15:42:58 -0700
In-Reply-To: <20251019202145.3944697-17-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-17-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> Add a set of tests to validate core gotox functionality
> without need to rely on compilers.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Thank you for adding these.
Could you please also add a test cases that checks the following errors:
- "jump table for insn %d points outside of the subprog [%u,%u]"
- "the sum of R%u umin_value %llu and off %u is too big\n"
- "register R%d doesn't point to any offset in map id=3D%d\n"
?

Might be the case that some of these can't be triggered because of the
check_mem_access() call.

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/t=
esting/selftests/bpf/progs/verifier_gotox.c
> new file mode 100644
> index 000000000000..1a92e4d321e8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c

[...]

> +/*
> + * Gotox is forbidden when there is no jump table loaded
> + * which points to the sub-function where the gotox is used
> + */
> +SEC("socket")
> +__failure __msg("no jump tables found for subprog starting at 0")
                                                              ^^^^
				Nit: one day we need to figure out a way to
				     report subprogram names, when reporting
				     check_cfg() errors.

> +__naked void jump_table_no_jump_table(void)
> +{
> +	asm volatile ("						\
> +	.8byte %[gotox_r0];					\
> +	r0 =3D 1;							\
> +	exit;							\
> +"	:							\
> +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0=
, 0, 0 , 0))
> +	: __clobber_all);
> +}
> +
> +/*
> + * Incorrect type of the target register, only PTR_TO_INSN allowed
> + */
> +SEC("socket")
> +__failure __msg("R1 has type 1, expected PTR_TO_INSN")
                           ^^^^^^
	      log.c:reg_type_str() should help here.

> +__naked void jump_table_incorrect_dst_reg_type(void)
> +{
> +	asm volatile ("						\
> +	.pushsection .jumptables,\"\",@progbits;		\
> +jt0_%=3D:								\
> +	.quad ret0_%=3D;						\
> +	.quad ret1_%=3D;						\
> +	.size jt0_%=3D, 16;					\
> +	.global jt0_%=3D;						\
> +	.popsection;						\
> +								\
> +	r0 =3D jt0_%=3D ll;						\
> +	r0 +=3D 8;						\
> +	r0 =3D *(u64 *)(r0 + 0);					\
> +	r1 =3D 42;						\
> +	.8byte %[gotox_r1];					\
> +	ret0_%=3D:						\
> +	r0 =3D 0;							\
> +	exit;							\
> +	ret1_%=3D:						\
> +	r0 =3D 1;							\
> +	exit;							\
> +"	:							\
> +	: __imm_insn(gotox_r1, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1=
, 0, 0 , 0))
> +	: __clobber_all);
> +}
> +
> +#define DEFINE_INVALID_SIZE_PROG(READ_SIZE, OUTCOME)			\

Nit: this can be merged with DEFINE_SIMPLE_JUMP_TABLE_PROG.

> +									\
> +	SEC("socket")							\
> +	OUTCOME								\
> +	__naked void jump_table_invalid_read_size_ ## READ_SIZE(void)	\
> +	{								\
> +		asm volatile ("						\
> +		.pushsection .jumptables,\"\",@progbits;		\
> +	jt0_%=3D:								\
> +		.quad ret0_%=3D;						\
> +		.quad ret1_%=3D;						\
> +		.size jt0_%=3D, 16;					\
> +		.global jt0_%=3D;						\
> +		.popsection;						\
> +									\
> +		r0 =3D jt0_%=3D ll;						\
> +		r0 +=3D 8;						\
> +		r0 =3D *(" #READ_SIZE " *)(r0 + 0);			\
> +		.8byte %[gotox_r0];					\
> +		ret0_%=3D:						\
> +		r0 =3D 0;							\
> +		exit;							\
> +		ret1_%=3D:						\
> +		r0 =3D 1;							\
> +		exit;							\
> +	"	:							\
> +		: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_=
0, 0, 0 , 0)) \
> +		: __clobber_all);					\
> +	}
> +
> +DEFINE_INVALID_SIZE_PROG(u32, __failure __msg("Invalid read of 4 bytes f=
rom insn_array"))
> +DEFINE_INVALID_SIZE_PROG(u16, __failure __msg("Invalid read of 2 bytes f=
rom insn_array"))
> +DEFINE_INVALID_SIZE_PROG(u8,  __failure __msg("Invalid read of 1 bytes f=
rom insn_array"))

[...]

