Return-Path: <bpf+bounces-76440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE39CB403A
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DDCF30E5DDA
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7533D273F9;
	Wed, 10 Dec 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3CU03fU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577C32ABF7;
	Wed, 10 Dec 2025 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400157; cv=none; b=sWoWGLf2x0cngb8khaL+rc/iG3EP2+wWcneP83TtCFMTLsWQtwq8GM03d4MG1PROnZHhphhputnpkbPDHX1H5AWSqYwXcc29o8JQRA1/yQcxaXaYmoLca7emwqTowhL1RCvPbMxBArL+AcSHsNg0rjkP1p6vcTpQbbNl8+htSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400157; c=relaxed/simple;
	bh=vcijIVXYyAub5EchaCxi+3aTkjKd9dSQhZ8k4SvNr2A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CL8EwwUcyZQk+04q/lXR3BNc62MozZlm2tFFRkW8362jfe+m58MonCK6w2zG9gozhYBNi9y0vGjvqL4grkFrJQOEKgV8pUUyolG6KyXyxWNdNIxtnLqZ5zNM76//dExKooYfafpuZIt9U+tb6z5Vlkx+67yV3dMwgTbgLwlDwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3CU03fU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A833C4CEF1;
	Wed, 10 Dec 2025 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765400157;
	bh=vcijIVXYyAub5EchaCxi+3aTkjKd9dSQhZ8k4SvNr2A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Z3CU03fUQ3pPoWxIbotjVOGFSonpnSvgOk8EHJYZcEj5yoDtlsnm9LaP4rAf+YdRo
	 fB81x/sz5CB99GO6Z5QRrWBu6KxdvaXJGABrwuACz+Ef3hCKHXNSkWLveA0vtT2FGx
	 X82qW5wpHsvsh+/v98SArO7eO2DyF7XSCl7UFbGNZ2vusjxIKfaRq8pgMds2AYUF9X
	 EXuj+kw5GSB50Eh7aP2RxA9euSzok+VoDw2LMRj94Vzk5cnHAhBbte1f9Q+dJfItRk
	 6S45EBEylsJk3Z6PsCRioHeSZ2dXro6krJNF/5r4DO7kPvs5hWx8nsvrQXoaOPtd/o
	 TVPX2Ne4u2ijg==
Content-Type: multipart/mixed; boundary="===============0457991203563875826=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9730b9defcd840698e12f3f5422e469604d3dfc474d156dab7a953a9a96bfda1@mail.kernel.org>
In-Reply-To: <20251210203243.814529-8-alan.maguire@oracle.com>
References: <20251210203243.814529-8-alan.maguire@oracle.com>
Subject: Re: [PATCH v6 bpf-next 07/10] selftests/bpf: test kind encoding/decoding
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Dec 2025 20:55:55 +0000 (UTC)

--===============0457991203563875826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
> new file mode 100644
> index 000000000000..735ea0b588a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
> @@ -0,0 +1,176 @@

[ ... ]

> +static void write_raw_btf(const char *btf_path, void *raw_btf, size_t raw_size)
> +{
> +	int fd = open(btf_path, O_WRONLY | O_CREAT);
                                                  ^^

Should open() include a mode parameter here? POSIX requires a mode
argument when O_CREAT is specified. Other tests in this directory use
0644, for example d_path.c and fs_kfuncs.c both use:

    open(path, O_CREAT | O_RDONLY, 0644)

> +
> +	write(fd, raw_btf, raw_size);
> +	close(fd);
> +}
> +

[ ... ]

> +void test_btf_kind_decoding(void)
> +{
> +	__s32 int_id, unrec_id, id, id2;
> +	LIBBPF_OPTS(btf_new_opts, opts);
> +	struct btf *btf, *new_btf;
> +	struct btf_kind_layout *k;
> +	struct btf_header *hdr;
> +	const void *raw_btf;
> +	struct btf_type *t;
> +	char btf_path[64];
> +	void *new_raw_btf;
> +	__u32 raw_size;

[ ... ]

> +	raw_btf = (void *)btf__raw_data(btf, &raw_size);
> +	if (!ASSERT_OK_PTR(raw_btf, "btf__raw_data"))
> +		return;
> +
> +	new_raw_btf = calloc(1, raw_size + sizeof(*k));
> +	memcpy(new_raw_btf, raw_btf, raw_size);
         ^^^^^^^

Can memcpy() dereference NULL here if calloc() fails? Other BPF tests
check calloc() before use. For example, btf.c uses:

    mapv = calloc(num_cpus, rounded_value_size);
    if (CHECK(!mapv, "mapv allocation failure")) {

And htab_update.c uses:

    value = calloc(1, value_size);
    if (!ASSERT_OK_PTR(value, "calloc value"))

> +
> +	/* add new layout description */
> +	hdr = new_raw_btf;
> +	hdr->kind_layout_len += sizeof(*k);
> +	k = new_raw_btf + hdr->hdr_len + hdr->kind_layout_off;
> +	k[NR_BTF_KINDS].info_sz = 0;
> +	k[NR_BTF_KINDS].elem_sz = 0;
> +
> +	/* now modify our typedef added above to be an unrecognized kind. */
> +	t = (void *)hdr + hdr->hdr_len + hdr->type_off + sizeof(struct btf_type) +
> +		sizeof(__u32);
> +	t->info = (NR_BTF_KINDS << 24);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486

--===============0457991203563875826==--

