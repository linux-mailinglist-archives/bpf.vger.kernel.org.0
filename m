Return-Path: <bpf+bounces-72883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A32C1D099
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF2E1898D75
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C8359FB6;
	Wed, 29 Oct 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJvLlAXt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7B2F12CC;
	Wed, 29 Oct 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766881; cv=none; b=UnnCmEwgurO4GR3hxVzVXD6Uo0ML+ImcmFEP7J9c5gzg0WH2Z0GhnlPv2OseECDUBHmzcHYkn9UlKRa/fk06Gj5OpYfQ24/svQNikS3BQHg0htIwHFmOfyn7yf85+3GMmtHKxIZBmjzQSjaJMaUh/TT7O6Py3pBMDY5vZfvOXOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766881; c=relaxed/simple;
	bh=BuzMn7aouWXoh16jjFmabFNCxTkit3/w3HZninvGSdY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=omXdxdLKqSOyyvun+7cd+sZ6UbQI+EpjAXkR1Bjq51u3zPc5VpeI+aPlkEVg96Fvm1DM5efRUYG5aviQEL6qJsfZJqBBZbt3k84z4VG6/iPnAJ99YGOoGrixtZaeOl5aQvyYMd5IWwibkpZRTw7RFU3hk+8+b/3cUR93odwfNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJvLlAXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75536C4CEF7;
	Wed, 29 Oct 2025 19:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761766880;
	bh=BuzMn7aouWXoh16jjFmabFNCxTkit3/w3HZninvGSdY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PJvLlAXtavXUBhxEoO0no92VOvak+Wzz9MA8WptP1RMxUqn2gd/onRMwv778K8vr0
	 qZTQ8YDn1K3YAkduMBl+nhBdj+CXiy6j/cv39rcnr3Q1aDMNvz9lrvf6VVUbUosbuu
	 uGHrWsvV8Lzx/T4l09oim33Fl+4OQsXrQhC5xtBOC1G+5j47nZLPVaU1kHyBT3mRVa
	 DJi+wQrYr4Yjxxd6vxXKckAAOpoXjqeSU5QLwclzz3Jj2sRhtY+K7TVfLUCS/scpHl
	 RQySXstt8EN8jsV1UvthTGz+ML9MpRFqyiRHqbo8N79MOceiuWLNQMG/Op7k+5sjqO
	 ZC3CyuIJ6MxWA==
Content-Type: multipart/mixed; boundary="===============5605417871482608690=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <39bb0d21fffe3855c246dd85b2e69524c8e31bc9d84b441b063f365e5cbf220c@mail.kernel.org>
In-Reply-To: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with KF_MAGIC_ARGS
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: dwarves@vger.kernel.org,alan.maguire@oracle.com,acme@kernel.org,eddyz87@gmail.com,tj@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Oct 2025 19:41:19 +0000 (UTC)

--===============5605417871482608690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 974828216758f5fff2d9783439b8daa20188ce8c
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Support for kfuncs with KF_MAGIC_ARGS

This patch adds infrastructure for magic kfuncs, which have two BTF
representations: one for BPF programs and one for kernel implementation.
The verifier resolves these through a lookup table.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cb1b483be..fcf0872b9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3263,17 +3263,68 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>  }
>
> +/*
> + * magic_kfuncs is used as a list of (foo, foo_impl) pairs
> + */
> +BTF_ID_LIST(magic_kfuncs)
> +BTF_ID_UNUSED
> +BTF_ID_LIST_END(magic_kfuncs)
> +
> +static s32 magic_kfunc_by_impl(s32 impl_func_id)
> +{
> +	int i;
> +
> +	for (i = 1; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
> +		if (magic_kfuncs[i] == impl_func_id)
> +			return magic_kfuncs[i - 1];
> +	}
> +	return -ENOENT;
> +}
> +
> +static s32 impl_by_magic_kfunc(s32 func_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
> +		if (magic_kfuncs[i] == func_id)
> +			return magic_kfuncs[i + 1];
                                    ^^^^^^^^^^^^^^^^^

Can impl_by_magic_kfunc() overflow magic_kfuncs[]? With the current
initialization using BTF_ID_UNUSED, BTF_ID_LIST_SIZE(magic_kfuncs)
equals 1. The loop condition checks i < 1, so when i=0 it executes and
accesses magic_kfuncs[i+1], which is magic_kfuncs[1]. This is outside
the array bounds.

The same issue applies generally: the loop checks i < size but accesses
i+1, so it should check i+1 < size instead.

> +	}
> +	return -ENOENT;
> +}

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf: Support for kfuncs with KF_MAGIC_ARGS`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18919699520

--===============5605417871482608690==--

