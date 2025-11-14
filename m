Return-Path: <bpf+bounces-74494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12832C5C5C5
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4D2D351B4D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A2321CC60;
	Fri, 14 Nov 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qifu6Yrl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11E307481;
	Fri, 14 Nov 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113166; cv=none; b=YpdMp8OWCy392ecrVww8HN61oOkWwnF6yoYKFFXw0ONhfXXi27M7XI3wmU0GDA/fXOt3+Hw+Ma33Nm9R6YdOYAoQRXT2/+LgGdEt10hJeGUjr6e/oB/c6aD7dGSF8CNFPFZgJsnlhCESniGpJJ+Xwlkx6rWzB89BiVcZtMG7OrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113166; c=relaxed/simple;
	bh=CmN3G295tVKXGOX+2QoIMHDwTDXiIyuU1Z0dgsv+BPI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uKjP/FW+hijEJxUVbYZgQ+Wf2PSrKvKRB2sg9tefW+pkRAtGRc2qtPgZF974wln+64VHBAluLDMfuVPxDemxipZvhfXysp9RUc/+om/N8MAUBE7mnbd3Bn63Qd6fD5125k5d0yzoWFzSBMAd5Iry+eB5V1Bek9G01KX12iqdKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qifu6Yrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B03C16AAE;
	Fri, 14 Nov 2025 09:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763113166;
	bh=CmN3G295tVKXGOX+2QoIMHDwTDXiIyuU1Z0dgsv+BPI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qifu6YrlgEr+Z/zT8GwTBisuCnJAPzAbDnYgMkYCMlVCsBfuhFCpSAuQMrXlXYRDE
	 PrMdmNp5NqHIhuoKGgUuVRqYs03l9XSILk/bThxVPz6NnskVMg+pEpfQlXwVYj2Hku
	 BoYuodunlutrmZukXwNi3pV+0UirsydJ1HGpPYOS4iRzTabhnLcterxUkCDI4zsAKV
	 OkTpuayoHQ9SdgcDXcvwOeD+1OWlpbIw2trLBPZUkrGzGcRebYsRKZsG6LJzvdg6mK
	 IRnk6Hm0vsFDoCdICvXhooSNiQaJx1qKUNInUPL0rb4vgFscsso0fvgMN12ZA9SsR6
	 wi9JByHmDaASQ==
Content-Type: multipart/mixed; boundary="===============6868097212165816017=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <39c391d944fa3db4426d0c1f9b4a22ccd1660133231a02efbcb78e0b55ac84b2@mail.kernel.org>
In-Reply-To: <20251114090231.2786984-3-dolinux.peng@gmail.com>
References: <20251114090231.2786984-3-dolinux.peng@gmail.com>
Subject: Re: [RFC PATCH 2/2] selftests/bpf: Add test cases for btf__permute functionality
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,zhangxiaoqin@xiaomi.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,pengdonglin@xiaomi.com,alan.maguire@oracle.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 09:39:25 +0000 (UTC)

--===============6868097212165816017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> new file mode 100644
> index 000000000..c1a47b846
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c

[ ... ]

> @@ -0,0 +1,626 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Xiaomi */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "btf_helpers.h"

[ ... ]

> +/* Verify btf__permute then btf__dedup work correctly */
> +static void test_permute_drop_dedup(void)
> +{
> +	struct btf *btf, *new_btf;
                              ^^^^^^^^
Can this crash if the test fails before new_btf is initialized?  Looking
at the declaration above, new_btf is uninitialized, and if ASSERT_EQ()
fails at line 570 before new_btf is assigned, the code jumps to the done
label which calls btf__free(new_btf). While btf__free() checks for NULL,
it doesn't protect against uninitialized garbage values and may
dereference an invalid pointer.

> +	const struct btf_header *hdr;
> +	const void *btf_data;
> +	char expect_strs[] = "\0int\0s1\0m\0tag1\0tag2\0tag3";
> +	char expect_strs_dedupped[] = "\0int\0s1\0m\0tag1";
> +	__u32 permute_ids[6], btf_size;
> +	int err;
> +
> +	btf = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
> +		return;
> +
> +	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);	/* [1] int */
> +	btf__add_struct(btf, "s1", 4);			/* [2] struct s1 { */
> +	btf__add_field(btf, "m", 1, 0, 0);		/*       int m; */
> +							/* } */
> +	btf__add_decl_tag(btf, "tag1", 2, -1);		/* [3] tag -> s1: tag1 */
> +	btf__add_decl_tag(btf, "tag2", 2, 1);		/* [4] tag -> s1/m: tag2 */
> +	btf__add_decl_tag(btf, "tag3", 2, 1);		/* [5] tag -> s1/m: tag3 */
> +
> +	VALIDATE_RAW_BTF(
> +		btf,
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] STRUCT 's1' size=4 vlen=1\n"
> +		"\t'm' type_id=1 bits_offset=0",
> +		"[3] DECL_TAG 'tag1' type_id=2 component_idx=-1",
> +		"[4] DECL_TAG 'tag2' type_id=2 component_idx=1",
> +		"[5] DECL_TAG 'tag3' type_id=2 component_idx=1");
> +
> +	btf_data = btf__raw_data(btf, &btf_size);
> +	hdr = btf_data;
> +	if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_strs"))
               ^^^^^^^^^^^^^^
Does this need a NULL check for btf_data?  The btf__raw_data() function
can return NULL on allocation failure (returns NULL at btf.c:1596), and
dereferencing hdr->str_len without checking would cause a segfault and
crash the test program.

> +		goto done;
> +
> +	new_btf = btf__new(btf_data, btf_size);
> +	if (!ASSERT_OK_PTR(new_btf, "btf__new"))
> +		goto done;
> +
> +	/* Drop 2 IDs result in unreferenced strings */
> +	permute_ids[0] = 0;
> +	permute_ids[1] = 3; /* [1] -> [3] */
> +	permute_ids[2] = 1; /* [2] -> [1] */
> +	permute_ids[3] = 2; /* [3] -> [2] */
> +	permute_ids[4] = 0; /* Drop result in unreferenced "tag2" */
> +	permute_ids[5] = 0; /* Drop result in unreferenced "tag3" */
> +	err = btf__permute(new_btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
> +	if (!ASSERT_OK(err, "btf__permute"))
> +		goto done;
> +
> +	VALIDATE_RAW_BTF(
> +		new_btf,
> +		"[1] STRUCT 's1' size=4 vlen=1\n"
> +		"\t'm' type_id=3 bits_offset=0",
> +		"[2] DECL_TAG 'tag1' type_id=1 component_idx=-1",
> +		"[3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
> +
> +	btf_data = btf__raw_data(new_btf, &btf_size);
> +	hdr = btf_data;
> +	if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_strs"))
               ^^^^^^^^^^^^^^
Same NULL check issue here with btf__raw_data().

> +		goto done;
> +
> +	err = btf__dedup(new_btf, NULL);
> +	if (!ASSERT_OK(err, "btf__dedup"))
> +		goto done;
> +
> +	btf_data = btf__raw_data(new_btf, &btf_size);
> +	hdr = btf_data;
> +	if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs_dedupped), "expect_strs_dedupped"))
               ^^^^^^^^^^^^^^
And again here.

> +		goto done;
> +
> +done:
> +	btf__free(btf);
> +	btf__free(new_btf);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19359945665

--===============6868097212165816017==--

