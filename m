Return-Path: <bpf+bounces-50009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B6A215F0
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A7C1889C5B
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2717E472;
	Wed, 29 Jan 2025 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SetIkXaY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099D25A641;
	Wed, 29 Jan 2025 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738112772; cv=none; b=G3Gxm2xi/TzWVvbUIzUQmGY7soEfWZJ5ahbMs6E/MQHHUfYxG0HmLslBPtblBjFsPaHAxCZBZHpPBKq9tpaX1RRx+zsbn9zgl3NToggxiCXgJN5atTp0gOG/krS8Oty6Wv4MjSe4hyyH2U7WQA97emQd5J+e14UbmkHUrMitfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738112772; c=relaxed/simple;
	bh=8KJ8Ok8kwmlYohA2Pawh83Ezhy5zVtP0dCpvat9W+UQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2d0TY+msy7wjaCa1Fu35kW1lq1m8co6KkzfXmnpjZDYRiV29qFokV23cpTHE/lpwtLRNOlNrjdtbC7F9CNK6TRXqq3YWcRgSgWNFE1IY2Lk6O9gucovyPDWX3YLSKJTMcX3+TAjcSWN/2XWWmJ8hl/cN+zKeCz7GQMSIISQjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SetIkXaY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166022c5caso100601215ad.2;
        Tue, 28 Jan 2025 17:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738112770; x=1738717570; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bvst8xPYV1MFRxmaWZ5Kg/kBERoYdR0ehlL8LHhy7H4=;
        b=SetIkXaYv5RolyqLNNaHv1I8Lt8csENupaNiJaNx38OK1o4cuwtINGH1Wcq42HfG/L
         zQS52d4DeDsYgyNnmZ3QMlNLzG2/2jYZ0Vv6zz/9FA/KqQWFP1n8QRpn1f/Pu60Zk2jM
         y/j7B8h8amdug9OOjdpb765U7pd/gKu/BnTXwZyy6WJKpXsd/iDwqVt50CuhiYKvswG6
         Zys6QSVSy+A1TdOwIlXqRbMmPRiPJfFCQKNfO+iRaa9kfIOA4x/0syiI+EPFBiRMD2aZ
         uhEs6+NqwuBDKgjYGbLdmqoLfzysVIYQCu2dkgHuRBka6wydLLloU+hLKaA4IFwGFSW0
         +Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738112770; x=1738717570;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvst8xPYV1MFRxmaWZ5Kg/kBERoYdR0ehlL8LHhy7H4=;
        b=eE68p8Sj6kdovi8GeKTKUh9Mqs4YXb7rsUfX8LM22O1K2UYPdLzh9OzwC3VlcRNenG
         ip6Wqdpw8EjoNYwBJEmzs7QsCP+TZwKPyrzzxqCwrKJbL9TafZ6Dnj4Hy+TZRNhpgEIl
         dW5x7F/F7Pzxx1v+F8vBooA6bYM7KFVYLSg6Sy0X+BxE5JEpAO+EbSfF90Oczhyh1HeQ
         rus5XbtuE8g+7VyonWp0Whvjab5PCBYMcd27E7zd5/bGu4YExiytPRd6EE6pUelkmQcv
         QxcuRhHym2Qt7wprfqP3E50ZpCT1kXIaHPiITxFnkdWsWJnPyxFzefwQuLr2p72b0a6Z
         42tA==
X-Forwarded-Encrypted: i=1; AJvYcCUlTG+RE2i6nxmMTtEJJf4RMh268jzqYZrcOyB1jdmM8x+2Ovmxp9XoXbKAeWPpPpkfYPU=@vger.kernel.org, AJvYcCVKWIZVWwRrZcT9DBOCzCzQ1c0G2PlsbbP/+gtabz6wAFKMEILC9xgeYk/el/1gMFPkV2PkZfAhAZq69Sti@vger.kernel.org
X-Gm-Message-State: AOJu0YyzK+Kh213p/CptyDhsEBCAsYL/rLMuVhfH1ZoQYhXQkGXgocLF
	bd7pq4AM/lT2vT+bF99qpPkb3s5ks0N/fWoEsp8YzTmUL7e7TT8Q
X-Gm-Gg: ASbGncud8YoTRtwoPlBHTyv3MdcBUlCTUiWGrhHmVCwSbhBWhToq8XjoyBjjlcTWp7V
	wcNV21VYk11P9rqLGF9c6drlOfiS5m3bhl1QGcxdY/JrVkT2ZoZ2Rex0Bqqt4w8gDbAC75+SFxl
	b3AIPDZN4fkeaXguhat7V+0s6FdxKi7mTDAi2bPOX4ImGpS55rw3yhmSt2UpmzH8Wzgm2Incp0t
	O0Gxpb/QEIud+/tqUGazbmgsdVk2uElv0gy13JGgei81va6xrmEGuoc1OTPLTtVZmJGFx8WoNh6
	HMh7zy5J9gWM
X-Google-Smtp-Source: AGHT+IFrfXNGqZrK5XM0SHu+NoKfGH/ZHvT/IKZCcqTIw7T082vJ6CNzDFq7W71Vut6Xp386mHPklQ==
X-Received: by 2002:a17:903:2f8c:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-21dd7c3555bmr17773795ad.5.1738112770503;
        Tue, 28 Jan 2025 17:06:10 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9b8e0sm89377575ad.40.2025.01.28.17.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 17:06:09 -0800 (PST)
Message-ID: <131a817f7f2749e78e527a251ca7971588cf62f8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet	
 <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon	 <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>,  Barret Rhoden <brho@google.com>, Neel Natu
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	linux-kernel@vger.kernel.org
Date: Tue, 28 Jan 2025 17:06:03 -0800
In-Reply-To: <3f2de7c6e5d2def7bdfb091347c1dacea0915974.1737763916.git.yepeilin@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
	 <3f2de7c6e5d2def7bdfb091347c1dacea0915974.1737763916.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-01-25 at 02:19 +0000, Peilin Ye wrote:
> Add several ./test_progs tests:
>=20
>   - atomics/load_acquire
>   - atomics/store_release
>   - arena_atomics/load_acquire
>   - arena_atomics/store_release
>   - verifier_load_acquire/*
>   - verifier_store_release/*
>   - verifier_precision/bpf_load_acquire
>   - verifier_precision/bpf_store_release
>=20
> The last two tests are added to check if backtrack_insn() handles the
> new instructions correctly.
>=20
> Additionally, the last test also makes sure that the verifier
> "remembers" the value (in src_reg) we store-release into e.g. a stack
> slot.  For example, if we take a look at the test program:
>=20
>     #0:  "r1 =3D 8;"
>     #1:  "store_release((u64 *)(r10 - 8), r1);"
>     #2:  "r1 =3D *(u64 *)(r10 - 8);"
>     #3:  "r2 =3D r10;"
>     #4:  "r2 +=3D r1;"	/* mark_precise */
>     #5:  "r0 =3D 0;"
>     #6:  "exit;"
>=20
> At #1, if the verifier doesn't remember that we wrote 8 to the stack,
> then later at #4 we would be adding an unbounded scalar value to the
> stack pointer, which would cause the program to be rejected:
>=20
>   VERIFIER LOG:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ...
>   math between fp pointer and register with unbounded min value is not al=
lowed
>=20
> All new tests depend on the pre-defined __BPF_FEATURE_LOAD_ACQ_STORE_REL
> feature macro, which implies -mcpu>=3Dv4.

This restriction would mean that tests are skipped on BPF CI, as it
currently runs using llvm 17 and 18. Instead, I suggest using some
macro hiding an inline assembly as below:

	asm volatile (".8byte %[insn];"
	              :
	              : [insn]"i"(*(long *)&(BPF_RAW_INSN(...)))
	              : /* correct clobbers here */);

See the usage of the __imm_insn() macro in the test suite.

Also, "BPF_ATOMIC loads from R%d %s is not allowed\n" and
      "BPF_ATOMIC stores into R%d %s is not allowed\n"
situations are not tested.

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/tes=
ting/selftests/bpf/prog_tests/atomics.c
> index 13e101f370a1..5d7cff3eed2b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/atomics.c
> +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
> @@ -162,6 +162,56 @@ static void test_xchg(struct atomics_lskel *skel)
>  	ASSERT_EQ(skel->bss->xchg32_result, 1, "xchg32_result");
>  }

Nit: Given the tests in verifier_load_acquire.c and verifier_store_release.=
c
     that use __retval annotation, are these tests really necessary?
     (assuming that verifier_store_release.c tests are modified to read
      stored location into r0 before exit).

> +static void test_load_acquire(struct atomics_lskel *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	int err, prog_fd;
> +
> +	if (skel->data->skip_lacq_srel_tests) {
> +		printf("%s:SKIP:Clang does not support BPF load-acquire\n", __func__);
> +		test__skip();
> +		return;
> +	}
> +
> +	/* No need to attach it, just run it directly */
> +	prog_fd =3D skel->progs.load_acquire.prog_fd;
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +	if (!ASSERT_OK(err, "test_run_opts err"))
> +		return;
> +	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +		return;
> +
> +	ASSERT_EQ(skel->bss->load_acquire8_result, 0x12, "load_acquire8_result"=
);
> +	ASSERT_EQ(skel->bss->load_acquire16_result, 0x1234, "load_acquire16_res=
ult");
> +	ASSERT_EQ(skel->bss->load_acquire32_result, 0x12345678, "load_acquire32=
_result");
> +	ASSERT_EQ(skel->bss->load_acquire64_result, 0x1234567890abcdef, "load_a=
cquire64_result");
> +}

[...]

> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
[...]

> +SEC("raw_tp/sys_enter")
> +int load_acquire(const void *ctx)
> +{
> +	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +		return 0;

Nit: This check is not needed, since bpf_prog_test_run_opts() is used
     to run the tests.

> +
> +#ifdef __BPF_FEATURE_LOAD_ACQ_STORE_REL
> +	load_acquire8_result =3D __atomic_load_n(&load_acquire8_value, __ATOMIC=
_ACQUIRE);
> +	load_acquire16_result =3D __atomic_load_n(&load_acquire16_value, __ATOM=
IC_ACQUIRE);
> +	load_acquire32_result =3D __atomic_load_n(&load_acquire32_value, __ATOM=
IC_ACQUIRE);
> +	load_acquire64_result =3D __atomic_load_n(&load_acquire64_value, __ATOM=
IC_ACQUIRE);
> +#endif
> +
> +	return 0;
> +}

[...]


