Return-Path: <bpf+bounces-70284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB57BB6302
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5923AC8AE
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272E2475D0;
	Fri,  3 Oct 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXuFCVrk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E921487F6
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759477224; cv=none; b=s8Qb4jrLBvWXxMQgnq0GwJ4UkfKaaT5hkaFhO6+4ebH1b4JhpkFpXZfnApYYMS6QMT6msuFQ200gnmx/iXJIJSm71G0VJnM0s9nq/pZnGCnxngn6sD8GOtBrb+9aFFQHTHr55tyNxI0AYStm7ua9yM+xdJ6rmnyGQkMLIzUzyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759477224; c=relaxed/simple;
	bh=A1sscDz8aFUxCJdfH2reuSnjE0JwXHia/yq6RXNvWQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avNQbNaBbtgn9nmbuDKnvzvTXFYeeKxSTyfkp8S0BiCFilCru0ZK2dIq9R7l5VTIWIR3r/jtOAA87Thtaz1z66KYS5Iso2fLca1iKdsacwvcjcbdbVUFxWRmdUHYe3ULuO1zPx51SIfdDYQBDtT7JQab5LJXSOqw4Lp3l96a7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXuFCVrk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2e363118so17040785e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759477220; x=1760082020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky+ZbcE7SF2/jlm9O9vmjF2cJ7bIX6CcV7xx006dvWk=;
        b=XXuFCVrkhAILThHurrCBnirzP2kJUspAePEYqas+koX6jfAxgYnktETo/fhuqDdBuD
         F9igA1XkOFzbkStOnDkTg3Cs+TuHnujEazLLM6LkE9sP3vz8b7sj/TiyF+/yqoVDD3jf
         slDz1D33Qkik4GCjmYATA1louRxwnfJTE2xoRpNh+X/JDEM7Jy/Flak+LCbkqL5kcjxp
         B8eGsapKO2tUpeYtyxWVrbxuK0QV4BI+uvYuJ26+DLG76khz8qSfmaUzwupwAG/rDgOL
         B0ZIzPBGh+TQQG3vxCnCfWT3OfSsdQfVdMHJ7//4h1kcNN91rBKq4aLr4CreuXNLPHde
         EOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759477220; x=1760082020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky+ZbcE7SF2/jlm9O9vmjF2cJ7bIX6CcV7xx006dvWk=;
        b=dspKsiMLMKaSKgR2Ua0NpgaX2ySl6fMZr2vn7t2xfnvtZenDwEeNbSN3uGKmHSw+am
         XkhOUFg+CTQtChyCCYuts3kZ34bVKF7+aXVA2RuWc9Xt0ORzM4iIsfCPkK45evhXeuGS
         Syi7B8fvMjAi4SLlbBbtk0OYT3+2K5WWJZKsbogOVD+lvq0qdq9H76nYJsKUhbaFvXbP
         b+bCfoQepYbTEwUseGoIWG3TbQAAaiGjdEX2cngApHbGvzWYnmQpubvUQWmD1+W6kGbU
         HcrebMKcvVlk9NP0GKz1rB+G0XSKbNuwrwvyaoNOUMJUZkk3ZdgbmYBK9IOA6xNSXeQi
         tLOw==
X-Gm-Message-State: AOJu0YxXvPKo19fgLXMG5SX+ZGEELrAEyi28WlwiWZ/iyHoYqOa6ksvw
	VSRMrbl5miWxhizpdDlRoVikrWaYK7cDTf7ifu+36toue27VkCvOdwPGZ/3Dqg==
X-Gm-Gg: ASbGncve4uIAzWAlU/k5NP/We1TeWHwExupcbOaJsjzbh6y5Ixv+5b5j2iBgBHfjNVz
	9ifqvoRmXpSzTZJDZbfgKXkK37LfIrHQPxfE0IWEIueNJk0SIorhT2Vh2/uwCPAMuGOQLdnG/qr
	fSDohqqHgOptflSiroRv1xoucHe4cZTKBBhXMKEbCMh3FPjPyCU+gyzf8US2e0Y4JjQf3lblj7/
	B9iOEJc5vwjlhFhKihPSf72W8JZ27sMh7Uhlt+cRH0YKiC43lQFWtx/mlQ+lXXzJv57iQ2ULHNk
	WxrHBcb+62ASD+VZaQVMExr9pYVKe8f/lc/640f+UZsNk6XQTNaHbyetRaXlJyyEvasF4au7kAU
	e4p8mxVYjK4WxepzJv8B4J9Jdk3pPKqvD+XkeMJfm7imWI8ZtUrR57ONBSSGebJvGPME=
X-Google-Smtp-Source: AGHT+IEPLhlA29U8O66RS9BxuNrmj9GAGmJNR7R6d6V/HHkARfEcc++gQNS2zpcGqdSgiobazWHoTQ==
X-Received: by 2002:a05:600c:83c4:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-46e71172a04mr13860605e9.37.1759477219988;
        Fri, 03 Oct 2025 00:40:19 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234e5fdsm18527905e9.6.2025.10.03.00.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:40:19 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:46:38 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 05/15] selftests/bpf: add selftests for new
 insn_array map
Message-ID: <aN9/XoodAYHN5Lm7@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-6-a.s.protopopov@gmail.com>
 <b7ed4bb22cd73006f761888305ed7ed2f70a5071.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ed4bb22cd73006f761888305ed7ed2f70a5071.camel@gmail.com>

On 25/10/02 06:16PM, Eduard Zingerman wrote:
> On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> 
> Overall lgtm, some code duplication worth removing, I think.
> 
> [...]
> 
> > +/*
> > + * Try to load a program with a map which points to outside of the program
> > + */
> > +static void check_out_of_bounds_index(void)
> > +{
> > +	struct bpf_insn insns[] = {
> > +		BPF_MOV64_IMM(BPF_REG_0, 4),
> > +		BPF_MOV64_IMM(BPF_REG_0, 3),
> > +		BPF_MOV64_IMM(BPF_REG_0, 2),
> > +		BPF_MOV64_IMM(BPF_REG_0, 1),
> > +		BPF_MOV64_IMM(BPF_REG_0, 0),
> > +		BPF_EXIT_INSN(),
> > +	};
> > +	int prog_fd, map_fd;
> > +	struct bpf_insn_array_value val = {};
> > +	int key;
> > +
> > +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> > +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> > +		return;
> > +
> > +	key = 0;
> > +	val.xlated_off = ARRAY_SIZE(insns); /* too big */
> > +	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
> > +		goto cleanup;
> > +
> > +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > +		goto cleanup;
> > +
> > +	errno = 0;
> 
> Nit: errno is not used in the check below, hence there is no need to reset it.
>      (here and in other tests below)

Ok, will do.

> > +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> > +	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)")) {
> > +		close(prog_fd);
> > +		goto cleanup;
> > +	}
> > +
> > +cleanup:
> > +	close(map_fd);
> > +}
> 
> [...]
> 
> > +/*
> > + * Load a program with two patches (get jiffies, for simplicity). Add an
> > + * insn_array map pointing to every instruction. Check how it was changed
> > + * after the program load.
> > + */
> > +static void check_simple(void)
> > +{
> > +	struct bpf_insn insns[] = {
> > +		BPF_MOV64_IMM(BPF_REG_0, 2),
> > +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > +		BPF_MOV64_IMM(BPF_REG_0, 1),
> > +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> > +		BPF_MOV64_IMM(BPF_REG_0, 0),
> > +		BPF_EXIT_INSN(),
> > +	};
> > +	int prog_fd = -1, map_fd;
> > +	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
> > +	__u32 map_out[] = {0, 1, 4, 5, 8, 9};
> > +	struct bpf_insn_array_value val = {};
> > +	int i;
> > +
> > +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
> > +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> > +		return;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> > +		val.xlated_off = map_in[i];
> > +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
> > +			       "bpf_map_update_elem"))
> > +			goto cleanup;
> > +	}
> > +
> > +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > +		goto cleanup;
> > +
> > +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> > +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > +		goto cleanup;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> > +		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
> > +			goto cleanup;
> > +
> > +		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]");
> 
> Nit: maybe print `i`, `xlated_off` and `map_out[i]` here?

+1

> If this test fails, debugging it with -vvv would be inconvenient,
> as there is no way to see xlated program. Maybe extend load_prog()
> to check debug level and add capability to print xlated?
> See __xlated annotation implementation in selftests.

Ok, nice, will do.

Just in case, typically, when I write selftests I add smth like

    if (getenv("HANG") && *(getenv("HANG")))
        for (;;)
            pause();

before destroying skeleton, so I can examine what was loaded, if needed.

> 
> > +	}
> > +
> > +cleanup:
> > +	close(prog_fd);
> > +	close(map_fd);
> > +}
> > +
> > +/*
> > + * Verifier can delete code in two cases: nops & dead code. From insn
> > + * array's point of view, the two cases are the same, so test using
> > + * the simplest method: by loading some nops
> > + */
> > +static void check_deletions(void)
> > +{
> > +	struct bpf_insn insns[] = {
> > +		BPF_MOV64_IMM(BPF_REG_0, 2),
> > +		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > +		BPF_MOV64_IMM(BPF_REG_0, 1),
> > +		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
> > +		BPF_MOV64_IMM(BPF_REG_0, 0),
> > +		BPF_EXIT_INSN(),
> > +	};
> 
> Success test cases follow identical pattern, ultimately having 3 input
> parameters:
> - program
> - map_in
> - map_out
> 
> Would it make sense to write a generic utility function accepting
> exactly these three params and hiding the boilerplate?

Will do.

Are you ok with the contexts of tests? Any more test cases, maybe?

> > +	int prog_fd = -1, map_fd;
> > +	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
> > +	__u32 map_out[] = {0, -1, 1, -1, 2, 3};
> > +	struct bpf_insn_array_value val = {};
> > +	int i;
> > +
> > +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
> > +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> > +		return;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> > +		val.xlated_off = map_in[i];
> > +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
> > +			       "bpf_map_update_elem"))
> > +			goto cleanup;
> > +	}
> > +
> > +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > +		goto cleanup;
> > +
> > +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> > +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > +		goto cleanup;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> > +		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
> > +			goto cleanup;
> > +
> > +		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]");
> > +	}
> > +
> > +cleanup:
> > +	close(prog_fd);
> > +	close(map_fd);
> > +}
> 
> [...]

