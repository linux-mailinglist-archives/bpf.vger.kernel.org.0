Return-Path: <bpf+bounces-76855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF684CC74F4
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED44B304EFD0
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF75382D52;
	Wed, 17 Dec 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeioTHQV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE37382D28;
	Wed, 17 Dec 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967086; cv=none; b=K565guyFpH9ATPVN/gGxWuNxG8th9MbYunw6zb3QPB13ikZbJLAf4Ig81B0uLJ/mhfTo7yJS1AGiKpBZ8DxbOMV7sHiE1eXUDA5fCauLLhUQZv90/ZXzPXhpADSH1yO7zesLa2PJGxFtAX14tq1qEmgjk/0jYzPayL3ZO7+85uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967086; c=relaxed/simple;
	bh=ShPcb8FVbUvn1b63TIaX52Z/Wh4GzHyMJJGL1Ig/FuM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kvdlHxEnmDLeQ6m7mX9BimgbGqSeti13Hfbs1tYTIv6jr9Uv0Xsm/BDzdXtoHTqmBvdO6aguLY+yNAmzSjwZcQOK17Em2P4g+SQZr+2WAnHV7H4x435yXSPDnf2i/oi5cjXvGvu+iABhUQ0ZPD8fHBxEs2TGVXYsF7uWWH4ghkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeioTHQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0465DC4CEF5;
	Wed, 17 Dec 2025 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765967086;
	bh=ShPcb8FVbUvn1b63TIaX52Z/Wh4GzHyMJJGL1Ig/FuM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YeioTHQVugbrn7CRGTzMf9EmnNWaM0WxtDIBhf9NiAZeS1G0dn7h7qEwHKxK426Ts
	 ih1H3E2i4LVV09GXN3x9XEUKtyq7DPpiRZVwBSPxQa8+ZROrbOLkVWB5xY2bVytn+m
	 zLGA9Vu9nQ7eV0xNCPp7IZskJwVAKMhPqg45r+CWuYMu7VjR/P94/cy5iNHOjiIq/b
	 1c1bLZgHvU6ulCqlsXjZN1p9OnN9iag8qyoKqKP+Fk6sWrzAglQPXfyJTcTIHuQutP
	 oyEkJduNWoI8zIxPK32w/y09LuM+1voG1sGGcsGKebLMK1xv80onz9Hr4MRnRNH5MJ
	 mxL7uAuSYySiw==
Content-Type: multipart/mixed; boundary="===============8217223416163093557=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e2567121e26195cb0dc4d9285f7269c377a4fb26c0aede0ad8ec112d7a2c98f0@mail.kernel.org>
In-Reply-To: <20251217095445.218428-9-dongml2@chinatelecom.cn>
References: <20251217095445.218428-9-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v4 8/9] selftests/bpf: add testcases for tracing session
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,andrii@kernel.org
Cc: davem@davemloft.net,dsahern@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tglx@linutronix.de,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 17 Dec 2025 10:24:46 +0000 (UTC)

--===============8217223416163093557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> new file mode 100644
> index 000000000000..f7c96ef1c7a9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 ChinaTelecom */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";

[ ... ]

> +__u64 test8_entry_result = 0;
> +__u64 test8_exit_result = 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test8, int a)
> +{
> +	__u64 addr = bpf_get_func_ip(ctx);
> +
> +	if (bpf_fsession_is_return(ctx))
> +		test8_exit_result = (const void *) addr == &bpf_fentry_test1;
> +	else
> +		test8_entry_result = (const void *) addr == &bpf_fentry_test1;
> +	return 0;
> +}

In test8, the code uses &bpf_fentry_test1 without declaring it. Looking at
similar tests like kprobe_multi.c and kprobe_multi_session.c, they include:

    extern const void bpf_fentry_test1 __ksym;

at the top of the file before taking the address of kernel symbols.
Without the __ksym declaration, does the comparison work correctly, or
would this cause the test to fail during compilation or at runtime?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20299185010

--===============8217223416163093557==--

