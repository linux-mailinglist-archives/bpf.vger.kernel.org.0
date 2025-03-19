Return-Path: <bpf+bounces-54395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5CA6964D
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 18:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B3F3BE941
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6AA1FDA69;
	Wed, 19 Mar 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="JTJQFPdi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1E1F4C97
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404988; cv=none; b=oJTz890mLoLZPXS66FtU8fa3py31jU/DlhQrGGsOYTSOmRrF8Emj7oe8AlaYP5pO7PtKxttyAeDWvQF1R4lyRQlbjYT1eWC0cbbdQ34a4ngKugdhw71LFo8HSySR0a3d+j3JY9VSuzjlglb7Ij6SrhggKY7rhzz7xyqBW2MaiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404988; c=relaxed/simple;
	bh=PxZxtpo4Vh2oLUQvasN1ei6FQjByNlGgqLKwLa/InHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktCT59nzZ5lmU0pleKJgPJPw5uIWK3RI3IqACHRs9pKwiZqBRP/OXjFkX7i33E1XesmcOICCXtTR6VITd56YU1xPIYC8olsjG6idpj8yl5QN49OtfQ3nhNCvvsR9TaTKHerIoWYBH9kWPOjr0+BWKbrbxwHD2nkmsFm7AhA5NV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=JTJQFPdi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39149bccb69so6959126f8f.2
        for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742404985; x=1743009785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dXweI32pDPuG7PsLPmkGCmlm/kvZ1BL8PlULxwnDhM=;
        b=JTJQFPdibFwvRPcOnzXnLqN4RTLjjfq2EIeOlOzL9YcEI4C5pibydReHb1TtLDZayV
         k8/hJKgK54Gpm4shq8Lx3m/Kug3bQvuBHg1oRfUpodJr+6vV03TAFbJ4pWc6m8IUzViB
         yc+QiD7lw+7wb0Hrs3G1mnJP1XYq3IK5dM/hV3nAAvw8Frmzpi1hrbG40+2mpLkra1Wg
         Mimo2HY394mCF3KEdNmyLDjv9P2YQRiN+7gfMRpt7VZgSA3C6hmrNLQy5DHbh613uUrp
         6IU/O1ZcT3nQsA1XKG/zzHeEcNXBfpsLfEIWZQSIqZ7BEg7gBs4VuszFyO8f7L1lidjq
         qZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404985; x=1743009785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dXweI32pDPuG7PsLPmkGCmlm/kvZ1BL8PlULxwnDhM=;
        b=LzrHs2vVb6DRxVX9CMQxl6P1JTx2ztBYCQP3fHfN45IyKdu4ls2AlZHKTaS6Zp2HLZ
         TG4DkMvb/AkfacrqI1hPD8Dtjn44eBZ0ATeVj2l6Ajz0B6yl7Fv5meEhfWauI90dgDM7
         eUScHYdQ8ATCDFSbsmLAh2Xoq9RABN2H0DLnxnItHV8ADEzKF7H3uAbdseZPd0pB4mv6
         bPbZ0Qm1TevKqiUslfhLRkk9qA5mgCAfX/zf80D3Ew5C9Jrkdp2RbCDUlAC/ddSuWfTx
         DNntSEH5sJ54KZCbYzFNqoIhQGL3qaVnU3bsOhj/MO3tL/7hp0eSPXx6xNJ/frcgdfbS
         l9Xg==
X-Gm-Message-State: AOJu0YxniHk2FqECmj1OZt4FLxsZ7M2PBNFW58dfYGJqTAybYV9mRu3q
	AguWjV/eztUC9Yw1vI3jB6xMxDxmU1McTeivAvPVMI1kzfHG1MstYfPQIET9bsM=
X-Gm-Gg: ASbGncsdn1en1dNZiFlychZE8J9lUBK1K2mUBPX35t9xul1jl9AQwn8rX6EWIIx8p5W
	wPSkDDcG70VSwYAyT8mD231bkHUOsXKtcdfOy6gFg9TwLWSrkFMl9CdqhuWAYOTgazo8A9Tio6g
	bPR/3rf9lPwns1yxNxe1+vcOdYRmPqDQfDUIcNjP8X/+px6rankZ5C/z/lN+BmEdsiZ0GihrYIK
	D1dMzzdNEU4f3pBQs0SpjI/zNva6hfuSuv4rmNzEvdr4A593ZBL5dvVFa5w46BJmSJwYW2l6JWJ
	ELzWtXfCp2zp6rnqESvF6t/CR2djPFooNeZ6TgzRulSMt13s
X-Google-Smtp-Source: AGHT+IE2u3Lje9g94KQKMaR6XcC9JdDqYk4juL+ChvNep5s/P/vfsD2uGkmnVXT6jhVJe0MBIQVycw==
X-Received: by 2002:a5d:64e5:0:b0:391:13ef:1af8 with SMTP id ffacd0b85a97d-39973b08f0emr2859658f8f.54.1742404984508;
        Wed, 19 Mar 2025 10:23:04 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b09sm21869164f8f.57.2025.03.19.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:23:03 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:26:44 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH bpf-next 03/14] selftests/bpf: add selftests for new
 insn_set map
Message-ID: <Z9r+VKRvY+pHesPa@mail.gmail.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-4-aspsk@isovalent.com>
 <ea842369-6e90-40f9-a891-0c4a6a6e565c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea842369-6e90-40f9-a891-0c4a6a6e565c@linux.dev>

On 25/03/18 01:56PM, Yonghong Song wrote:
> 
> 
> On 3/18/25 7:33 AM, Anton Protopopov wrote:
> > Tests are split in two parts.
> > 
> > The `bpf_insn_set_ops` test checks that the map is managed properly:
> > 
> >    * Incorrect instruction indexes are rejected
> >    * Non-sorted and non-unique indexes are rejected
> >    * Unfrozen maps are not accepted
> >    * Two programs can't use the same map
> >    * BPF progs can't operate the map
> > 
> > The `bpf_insn_set_reloc` part validates, as best as it can do it from user
> > space, that instructions are relocated properly:
> > 
> >    * no relocations => map is the same
> >    * expected relocations when instructions are added
> >    * expected relocations when instructions are deleted
> >    * expected relocations when multiple functions are present
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >   .../selftests/bpf/prog_tests/bpf_insn_set.c   | 639 ++++++++++++++++++
> >   1 file changed, 639 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
> > new file mode 100644
> > index 000000000000..796980bd4fcb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
> > @@ -0,0 +1,639 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <bpf/bpf.h>
> > +#include <test_progs.h>
> > +
> > +static inline int map_create(__u32 map_type, __u32 max_entries)
> > +{
> > +	const char *map_name = "insn_set";
> > +	__u32 key_size = 4;
> > +	__u32 value_size = 4;
> > +
> > +	return bpf_map_create(map_type, map_name, key_size, value_size, max_entries, NULL);
> > +}
> > +
> > +/*
> > + * Load a program, which will not be anyhow mangled by the verifier.  Add an
> > + * insn_set map pointing to every instruction. Check that it hasn't changed
> > + * after the program load.
> > + */
> > +static void check_one_to_one_mapping(void)
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
> 
> prog_fd needs to be initialized to something like -1.

Thanks! I've fixed this and similar occurrences.

Also replaced syscall(BPF_PROG_LOAD) with libbpf wrappers, so the code
is a bit shorter now.  Will resend the patch to this thread shortly.

> > +	union bpf_attr attr = {
> > +		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
> > +		.insns     = ptr_to_u64(insns),
> > +		.insn_cnt  = ARRAY_SIZE(insns),
> > +		.license   = ptr_to_u64("GPL"),
> > +		.fd_array = ptr_to_u64(&map_fd),
> > +		.fd_array_cnt = 1,
> > +	};
> > +	int i;
> > +
> > +	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
> > +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> > +		return;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(insns); i++)
> > +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &i, 0), 0, "bpf_map_update_elem"))
> > +			goto cleanup;
> 
> Otherwise, goto cleanup here will goto cleanup and close(prog_fd) will close
> a random prog_fd. Please check the rest of prog_fd usage.
> 
> > +
> > +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > +		return;
> > +
> > +	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> > +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > +		goto cleanup;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> > +		__u32 val;
> > +
> > +		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
> > +			goto cleanup;
> > +
> > +		ASSERT_EQ(val, i, "val should be equal i");
> > +	}
> > +
> > +cleanup:
> > +	close(prog_fd);
> > +	close(map_fd);
> > +}
> > +
> 
> [...]
> 

