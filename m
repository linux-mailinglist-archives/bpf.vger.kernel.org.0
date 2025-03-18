Return-Path: <bpf+bounces-54346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A57A67E55
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 21:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33EA42277E
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED7212FA0;
	Tue, 18 Mar 2025 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V2DFTug9"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09996185B4C
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331375; cv=none; b=Eu9N5NMzhJMzMFiIWhpv0SBi8DDYWCzD0SIruDpbTUTh1jDQfnXM7LOf5WZ1TvDPuo35JLjyVJzErH7nXxldWHwZy4lYDeG9HhyJJB22n+o/UVL9Gjqu9AMvqtxeEL12NFwXfLo1VCAVukCvesB4zNGXTkAYvt0UX+e0gQ6YsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331375; c=relaxed/simple;
	bh=yJd4jy4bjSHI/cw2uKyxQKKK1knsUJ0bGWmdp3YThMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eBK2nq+psPg5nRZfPkFcivfE89AndBCAfEYeJPxfFRclWUBfGuXNZUH6CdMQH1Y+3Q0DSk4T7triFiObAwfMoMrnVQMxiN2S4gsZu+EF386SBPVqkoFt1NldUZTzOQhN47M2CSA/9/wBgzqdG0+MMBgYfzvtF/kZgcoVJmMo5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V2DFTug9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea842369-6e90-40f9-a891-0c4a6a6e565c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742331371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qq42+DIkiDYiYs2gO4JmclmnmnLxRDVNTpzgoSDYrDo=;
	b=V2DFTug9USf4e34G1NxgCh2PNH/GLwZjBo/NrG3tYTScCPnRZK3Cid6iwuuC6kcIePdaQ3
	ZWQkw+Rs9lqD/IdzHA3yuPunzB1bq1Dto8nmngNX1Woqdqov2kU/BYuNy+9EtpVjuWlgCH
	M+TZTb1ueXdEiYDFGW7ViAJoCxTDCrg=
Date: Tue, 18 Mar 2025 13:56:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 03/14] selftests/bpf: add selftests for new
 insn_set map
Content-Language: en-GB
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-4-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250318143318.656785-4-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/18/25 7:33 AM, Anton Protopopov wrote:
> Tests are split in two parts.
>
> The `bpf_insn_set_ops` test checks that the map is managed properly:
>
>    * Incorrect instruction indexes are rejected
>    * Non-sorted and non-unique indexes are rejected
>    * Unfrozen maps are not accepted
>    * Two programs can't use the same map
>    * BPF progs can't operate the map
>
> The `bpf_insn_set_reloc` part validates, as best as it can do it from user
> space, that instructions are relocated properly:
>
>    * no relocations => map is the same
>    * expected relocations when instructions are added
>    * expected relocations when instructions are deleted
>    * expected relocations when multiple functions are present
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_insn_set.c   | 639 ++++++++++++++++++
>   1 file changed, 639 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
> new file mode 100644
> index 000000000000..796980bd4fcb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
> @@ -0,0 +1,639 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <bpf/bpf.h>
> +#include <test_progs.h>
> +
> +static inline int map_create(__u32 map_type, __u32 max_entries)
> +{
> +	const char *map_name = "insn_set";
> +	__u32 key_size = 4;
> +	__u32 value_size = 4;
> +
> +	return bpf_map_create(map_type, map_name, key_size, value_size, max_entries, NULL);
> +}
> +
> +/*
> + * Load a program, which will not be anyhow mangled by the verifier.  Add an
> + * insn_set map pointing to every instruction. Check that it hasn't changed
> + * after the program load.
> + */
> +static void check_one_to_one_mapping(void)
> +{
> +	struct bpf_insn insns[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 4),
> +		BPF_MOV64_IMM(BPF_REG_0, 3),
> +		BPF_MOV64_IMM(BPF_REG_0, 2),
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int prog_fd, map_fd;

prog_fd needs to be initialized to something like -1.

> +	union bpf_attr attr = {
> +		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
> +		.insns     = ptr_to_u64(insns),
> +		.insn_cnt  = ARRAY_SIZE(insns),
> +		.license   = ptr_to_u64("GPL"),
> +		.fd_array = ptr_to_u64(&map_fd),
> +		.fd_array_cnt = 1,
> +	};
> +	int i;
> +
> +	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(insns); i++)
> +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &i, 0), 0, "bpf_map_update_elem"))
> +			goto cleanup;

Otherwise, goto cleanup here will goto cleanup and close(prog_fd) will close
a random prog_fd. Please check the rest of prog_fd usage.

> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		return;
> +
> +	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +		goto cleanup;
> +
> +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> +		__u32 val;
> +
> +		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
> +			goto cleanup;
> +
> +		ASSERT_EQ(val, i, "val should be equal i");
> +	}
> +
> +cleanup:
> +	close(prog_fd);
> +	close(map_fd);
> +}
> +

[...]


