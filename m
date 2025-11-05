Return-Path: <bpf+bounces-73608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E0BC34DDC
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D85461179
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33AA2FD688;
	Wed,  5 Nov 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p65UZzRU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490982FBE17
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334896; cv=none; b=kU3Ue8Eyb6t1MjXNy2YCQMrClKyLV6Dyfu3vAeDWnkmd9cYQRVRqrEMRKiLiufTnzkRNrLL/SGOY2wOkcFRcl1JDmER7icAcvPlm7Hv0h1axtRYQwGjnZyVY6ZnvAJqvsUGgwPCLWEugZu2a/g3tLil+dzsD/lpr9/WiNfIkYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334896; c=relaxed/simple;
	bh=fA8D4wIKMJJrzNodhSnEnjlqUFRt03NNtCSVThBMBeU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CKsdDbc8fHdm/YcAkKkypIzcRJi/ZLBocYIfYCj1N/brpCm+5WQ6834+siQK9kvCzDuDeTOQKZvJl7Yv6U0+9kmhO1HRPpqgBS8BRysaayLeNiXkmkG7JfmshoI84Nlkcmsk5UVBwRDxDGlPS2+EwLIb+hTyhtlyZ7JwhfLCOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p65UZzRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C816C4CEF8;
	Wed,  5 Nov 2025 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334895;
	bh=fA8D4wIKMJJrzNodhSnEnjlqUFRt03NNtCSVThBMBeU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=p65UZzRU/ESzwcLyn95Glx6P+BlyxaA9owHo0XQ0dvjm9k5/ChxFvzKvbvflEZCM+
	 2e2tIvAJMmuGMZb4C5wJfTzZ830enjkoeoIqgN1lCOtqkygtgirb5IDhMQMgwTbjQt
	 g34ss8fjD+uk07IphV6cZ/G0CHzKQV9xMYJC6hIhMpIe7ptaLF0Gu6GBLDM78XnWRh
	 0kDlrN52cI9gmM+OxwANrPqMyxAY75tSvoaKyggQaubM49F3iFpOYrqK8clriK7HxW
	 eXSj7pNroGDrthxG8omiG8qDYV7thM3E7GoXqQtSK7lBhNElkcCABJ+j437jnfJe1I
	 dslIRjFODo4KQ==
Content-Type: multipart/mixed; boundary="===============1877917035811909097=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0fd4c10d43f9c3ce28948a5bff8b745a1298f30154f3c1d4d095163a905429f2@mail.kernel.org>
In-Reply-To: <20251105090410.1250500-13-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-13-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v11 bpf-next 12/12] selftests/bpf: add C-level selftests for indirect jumps
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,aspsk@isovalent.com,daniel@iogearbox.net,eddyz87@gmail.com,qmo@kernel.org,yonghong.song@linux.dev
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Nov 2025 09:28:15 +0000 (UTC)

--===============1877917035811909097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> new file mode 100644
> index 000000000..ea1cd3cda
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c

[ ... ]

> @@ -0,0 +1,292 @@

[ ... ]

> +static void check_one_map_two_jumps(struct bpf_gotox *skel)
> +{
> +	struct bpf_prog_info prog_info;
> +	struct bpf_map_info map_info;
> +	__u32 len;
> +	__u32 map_ids[16];
> +	int prog_fd, map_fd;
> +	int ret;
> +	int i;
> +	bool seen = false;
> +
> +	memset(&prog_info, 0, sizeof(prog_info));
> +	prog_info.map_ids = (long)map_ids;
> +	prog_info.nr_map_ids = ARRAY_SIZE(map_ids);
> +	prog_fd = bpf_program__fd(skel->progs.one_map_two_jumps);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd(one_map_two_jumps)"))
> +		return;
> +
> +	len = sizeof(prog_info);
> +	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &len);
> +	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd(prog_fd)"))
> +		return;
> +
> +	for (i = 0; i < prog_info.nr_map_ids; i++) {
> +		map_fd  = bpf_map_get_fd_by_id(map_ids[i]);
> +		if (!ASSERT_GE(map_fd, 0, "bpf_program__fd(one_map_two_jumps)"))
                                                ^^^^

This isn't a bug, but the error message looks like it was copied from the
prog_fd check above. Should this say "bpf_map_get_fd_by_id" instead?

> +			return;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19096860051

--===============1877917035811909097==--

