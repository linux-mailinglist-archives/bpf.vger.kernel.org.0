Return-Path: <bpf+bounces-54344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB80A67E51
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF47517493A
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6928A212FA0;
	Tue, 18 Mar 2025 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JsEScJfe"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12FE1DE89D
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331200; cv=none; b=kyf8JTvSMlzWRC55FXOxDHnHqRfYWXsDUfuRmgg+SI+sNAntxi3QEfRz7GHd63LsQJPTa7xj6FT5lD1FeBIMZr6wELRivA4hSdAFKcRjH1DF+KUJ7E3oEl9BkPxdXJQ700mDY4Hxt1g3cnKNwuW2zE4rag80KyOJBG8wGRYTQfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331200; c=relaxed/simple;
	bh=JKDxme6hT6aPSaYHbuz8dGPiFRUSb6TydRzy6KiaaQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aSiBDsvWUl5YbdK2zICe+u3ioAfaRHNhojD7++tTONg2/IZY7W56EcdVvEjbE9eCDVLO/z2+MGNBuAGsjiRgFLIxDeyU2+pwKbhFQCxqDgM/xfG1ubBIxGz3Ye0K5wVpqLNoYjzi11L2oITImKu/X+pV5hO4z+NJH/1bLLd3Rao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JsEScJfe; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <543f9e82-b941-4a90-90c8-f559c2e3d908@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742331195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFXlKyr14/au1orvwy5P9s5jkZitZindIzU+ZoQ90Hs=;
	b=JsEScJfeCqlDIkzPAYSff5nkiqm94Xx4JyIp6zEOIdtTHwg/sIhO8PoUjtY9ruwjqlja7e
	Qq4VT/cbG5Eu/fyHPsJyznFQCAjZ0skQqPVgx97xJqDxaQBtxPXFy2tstO0+0Vcw3159zP
	ZPhZ0Ev9ZAdFVTmRzEWgKkXgLvD0/bw=
Date: Tue, 18 Mar 2025 13:53:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 14/14] selftests/bpf: Add tests for BPF
 static calls
Content-Language: en-GB
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-15-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250318143318.656785-15-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/18/25 7:33 AM, Anton Protopopov wrote:
> Add self-tests to test new BPF_STATIC_BRANCH_JA jump instructions
> and the BPF_STATIC_KEY_UPDATE syscall.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>   .../bpf/prog_tests/bpf_static_keys.c          | 359 ++++++++++++++++++
>   .../selftests/bpf/progs/bpf_static_keys.c     | 131 +++++++
>   2 files changed, 490 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_static_keys.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c b/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
> new file mode 100644
> index 000000000000..3f105d36743b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#include <sys/syscall.h>
> +#include <bpf/bpf.h>
> +
> +#include "bpf_static_keys.skel.h"
> +
> +#define VAL_ON	7
> +#define VAL_OFF	3
> +
> +enum {
> +	OFF,
> +	ON
> +};
> +
> +static int _bpf_prog_load(struct bpf_insn *insns, __u32 insn_cnt)
> +{
> +	return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, NULL);
> +}
> +
> +static int _bpf_static_key_update(int map_fd, __u32 on)
> +{
> +	LIBBPF_OPTS(bpf_static_key_update_opts, opts);
> +
> +	opts.on = on;
> +
> +	return bpf_static_key_update(map_fd, &opts);
> +}
> +
> +#define BPF_JMP32_OR_NOP(IMM, OFF)				\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_JMP32 | BPF_JA | BPF_K,		\
> +		.dst_reg = 0,					\
> +		.src_reg = BPF_STATIC_BRANCH_JA,		\
> +		.off   = OFF,					\
> +		.imm   = IMM })
> +
> +#define BPF_JMP_OR_NOP(IMM, OFF)				\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_JMP | BPF_JA | BPF_K,		\
> +		.dst_reg = 0,					\
> +		.src_reg = BPF_STATIC_BRANCH_JA,		\
> +		.off   = OFF,					\
> +		.imm   = IMM })
> +
> +#define BPF_NOP_OR_JMP32(IMM, OFF)				\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_JMP32 | BPF_JA | BPF_K,		\
> +		.dst_reg = 0,					\
> +		.src_reg = BPF_STATIC_BRANCH_JA |		\
> +			   BPF_STATIC_BRANCH_NOP,		\
> +		.off   = OFF,					\
> +		.imm   = IMM })
> +
> +#define BPF_NOP_OR_JMP(IMM, OFF)				\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_JMP | BPF_JA | BPF_K,		\
> +		.dst_reg = 0,					\
> +		.src_reg = BPF_STATIC_BRANCH_JA |		\
> +			   BPF_STATIC_BRANCH_NOP,		\
> +		.off   = OFF,					\
> +		.imm   = IMM })
> +
> +static const struct bpf_insn insns0[] = {
> +	BPF_JMP_OR_NOP(0, 1),
> +	BPF_NOP_OR_JMP(0, 1),
> +	BPF_JMP32_OR_NOP(1, 0),
> +	BPF_NOP_OR_JMP32(1, 0),
> +};
> +

[...]

> +
> +static void check_bpf_to_bpf_call(struct bpf_static_keys *skel,
> +				  struct bpf_map *key1,
> +				  struct bpf_map *key2)
> +{
> +	struct bpf_link *link;
> +
> +	link = bpf_program__attach(skel->progs.check_bpf_to_bpf_call);

there is no progcheck_bpf_to_bpf_call. Compilation will fail.

> +	if (!ASSERT_OK_PTR(link, "link"))
> +		return;
> +
> +	__check_multiple_keys(skel, key1, key2, 0, 303, 3030, 3333);
> +
> +	bpf_link__destroy(link);
> +}
> +
[...]

