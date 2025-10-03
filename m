Return-Path: <bpf+bounces-70266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C9BB5BA1
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 03:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D1D1AE47CF
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB2025B1CE;
	Fri,  3 Oct 2025 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3VejEx0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFC1DFCE
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454225; cv=none; b=a2damXuTzFnu0K39yFQOmNE92spFhdAgbAWomBjDoBir4JFqLApxGE0NxJA+1DvhQ3CeTVRNbHTF9SBqt7FSXUTGpRkZyeCeaaBwM1bbsm4DL1ATHT4l9IYjX33yabXsKCuKLo9DZ933/afcO7TCTF43dihQ+Ekvrv836EEo/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454225; c=relaxed/simple;
	bh=AIOuZvLEOgNtc3kbuNLu3b6Jnrb+jd3YUcXD3xAQnAg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMFzZ4smnALgNmYkDcZ+Qur8F+uCTIAxvjK5j/qUxXcfwaHHNB3oJJCwuMMejSjfm/SrSE/RMMA52f77ln9tZltf/VgN7izPphDlANKrd/0Fw0SWRtwB0X5ayG5M/+Uj8Jjjpx/Z2jknL6egk61woNfUtDjx99LIgl9OL9WPS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3VejEx0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so2072059a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 18:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759454219; x=1760059019; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdF4SsskQjFPB4yFp9I2dDOo5PCO+8XAzx3sFNrXNOE=;
        b=b3VejEx0EARSO6z5vYpUJgq+O2iUSFw6oW77zxumjLCIpk9znXjHNTI4g/ODECBPQv
         mMvTo+nIgHoxoqNNI9xZrI5fSt/tfxv3b3saJluZGPkv9+NJNJFz8RkELxVHtRXtTKXc
         5lRu1AbbNPlfnxefczOGO20dIy4Kv2H5KbCVXcvE53IT09KCpNC52OGHx7esyO8JEmv8
         ILMQ2xik+fvZ7xXcGckpEtKyTpkdE4Ebci2AEJqLIeQ5MpIZTB4ebq31LSlIrWEkGSyP
         6oValCbNbY7YJ24ddujfTESkb6ExIqbYPyYsAZBjgEHtKthr47VUvQj1AY2GPx2eF/ix
         nEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454219; x=1760059019;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdF4SsskQjFPB4yFp9I2dDOo5PCO+8XAzx3sFNrXNOE=;
        b=hHc49iJS0VY/zZGgTpLhLAU7aC+ysdzUnEjvYtQkn9Pb5fHUD9LmF7oQMPiFKxDVGe
         WV9PGZZYzyCPlM/x4ivo6DS7xLv4xTRsM6/vRtD6KjYtDTASSV0mcT1gpJDC+bc+jGG2
         mRK8YH/ZwWGgnLgS9ocQxUmXQWQRzEIPYWzzexlAnSyqjC78jBjJQVfF2VEeEwtnJ8v3
         kl002bMV3JHKu/zIVu+SK0KP9KA3VHSqyMnNtfX4+SzAa8k2uFmqLKf1xYHV9h+0bPGh
         WOQ9cisPRefs3rrHYadyIk6wGCC8zmqFSrtQiSNxF/3fsf5IIP9PdXNtNZX8GEswdENb
         CfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzAQoY5MyPZnJw3GkkXchDzYSa2v8EC1SJUjWya4AK+vsbdS+gGw9TQV9RL6dymYTuiP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx994hWibXGs1rCHVMOHOTx+0cz0RuTakL+xLvdL+emlssTEl2l
	LJb6fAS23G8a85fTF9KcqFiA7HLwH0hbmnMrqpdRVK0QpIhSFByPYlZ9WMZufA==
X-Gm-Gg: ASbGncsaBaQ83hQ4lyuuzJDFDbyLZpSDyp5jyBtQ1YiPdEuCnlja7f58KovdaiOPRBy
	CWl5YZGlnzv2lJKrezsDWBLS4gz9ko4XMSya8kuJmZ/WE8bGXEQW15sSeJ23OVpfWo9SXGx8tR5
	2sVnbv7JeqVb+cz0n/B8IMgg9nWcUoGXyiwG6NLQ19vlFLLmkPIKnUBfwtBTJkinDqHPMMV4tNT
	QhqU4wqDAbFqOn/zWhcf328wWBrNe0FrsLtNRy77mzjts8lK6iqBYwrhcru4pagZmiBVkjId0vt
	gxjnIaGjz2rNab2FVYYGhHLSj8QKuLVPvCEwOnKDszf1P8GeTj19hiuWFFBtNRaBj9RgRxseDk+
	MgjgEVX1B9+VD0jIdsC4Wos75U9Y4zo5mNrw6vJTjjgnS
X-Google-Smtp-Source: AGHT+IG2VZ8n4GnkskFFabRkaOldTfl0trH1vDtypGwtl5xXg3NrTIOQ/ghewbfgJ5uvs0aDPJ1RIw==
X-Received: by 2002:a17:90b:314e:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-339c279740amr1575104a91.23.1759454219295;
        Thu, 02 Oct 2025 18:16:59 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099b1cf08sm3045222a12.22.2025.10.02.18.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:16:58 -0700 (PDT)
Message-ID: <b7ed4bb22cd73006f761888305ed7ed2f70a5071.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 05/15] selftests/bpf: add selftests for new
 insn_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 02 Oct 2025 18:16:56 -0700
In-Reply-To: <20250930125111.1269861-6-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-6-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:

Overall lgtm, some code duplication worth removing, I think.

[...]

> +/*
> + * Try to load a program with a map which points to outside of the progr=
am
> + */
> +static void check_out_of_bounds_index(void)
> +{
> +	struct bpf_insn insns[] =3D {
> +		BPF_MOV64_IMM(BPF_REG_0, 4),
> +		BPF_MOV64_IMM(BPF_REG_0, 3),
> +		BPF_MOV64_IMM(BPF_REG_0, 2),
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int prog_fd, map_fd;
> +	struct bpf_insn_array_value val =3D {};
> +	int key;
> +
> +	map_fd =3D map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return;
> +
> +	key =3D 0;
> +	val.xlated_off =3D ARRAY_SIZE(insns); /* too big */
> +	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_=
update_elem"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto cleanup;
> +
> +	errno =3D 0;

Nit: errno is not used in the check below, hence there is no need to reset =
it.
     (here and in other tests below)

> +	prog_fd =3D prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> +	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (pr=
og_fd !=3D -EINVAL)")) {
> +		close(prog_fd);
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	close(map_fd);
> +}

[...]

> +/*
> + * Load a program with two patches (get jiffies, for simplicity). Add an
> + * insn_array map pointing to every instruction. Check how it was change=
d
> + * after the program load.
> + */
> +static void check_simple(void)
> +{
> +	struct bpf_insn insns[] =3D {
> +		BPF_MOV64_IMM(BPF_REG_0, 2),
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int prog_fd =3D -1, map_fd;
> +	__u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> +	__u32 map_out[] =3D {0, 1, 4, 5, 8, 9};
> +	struct bpf_insn_array_value val =3D {};
> +	int i;
> +
> +	map_fd =3D map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(insns); i++) {
> +		val.xlated_off =3D map_in[i];
> +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
> +			       "bpf_map_update_elem"))
> +			goto cleanup;
> +	}
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto cleanup;
> +
> +	prog_fd =3D prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +		goto cleanup;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(insns); i++) {
> +		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_look=
up_elem"))
> +			goto cleanup;
> +
> +		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]"=
);

Nit: maybe print `i`, `xlated_off` and `map_out[i]` here?

If this test fails, debugging it with -vvv would be inconvenient,
as there is no way to see xlated program. Maybe extend load_prog()
to check debug level and add capability to print xlated?
See __xlated annotation implementation in selftests.

> +	}
> +
> +cleanup:
> +	close(prog_fd);
> +	close(map_fd);
> +}
> +
> +/*
> + * Verifier can delete code in two cases: nops & dead code. From insn
> + * array's point of view, the two cases are the same, so test using
> + * the simplest method: by loading some nops
> + */
> +static void check_deletions(void)
> +{
> +	struct bpf_insn insns[] =3D {
> +		BPF_MOV64_IMM(BPF_REG_0, 2),
> +		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};

Success test cases follow identical pattern, ultimately having 3 input
parameters:
- program
- map_in
- map_out

Would it make sense to write a generic utility function accepting
exactly these three params and hiding the boilerplate?

> +	int prog_fd =3D -1, map_fd;
> +	__u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> +	__u32 map_out[] =3D {0, -1, 1, -1, 2, 3};
> +	struct bpf_insn_array_value val =3D {};
> +	int i;
> +
> +	map_fd =3D map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(insns); i++) {
> +		val.xlated_off =3D map_in[i];
> +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
> +			       "bpf_map_update_elem"))
> +			goto cleanup;
> +	}
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto cleanup;
> +
> +	prog_fd =3D prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +		goto cleanup;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(insns); i++) {
> +		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_look=
up_elem"))
> +			goto cleanup;
> +
> +		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]"=
);
> +	}
> +
> +cleanup:
> +	close(prog_fd);
> +	close(map_fd);
> +}

[...]

