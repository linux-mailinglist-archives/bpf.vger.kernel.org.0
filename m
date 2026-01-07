Return-Path: <bpf+bounces-78083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8FCFDC0B
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 13:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358DE30ACE4D
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0A3148D9;
	Wed,  7 Jan 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goCb03/1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29A30F950;
	Wed,  7 Jan 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789856; cv=none; b=kKPrJVlLO7UU+4G4geTWZrAWjBn4BMSybTzeembzWFrAOGNAsBYZYAxgx3OP3tZATVuySzik4Uuf3F9lhal1JVB1nZb89eAKbWH/b9uIpFWvU3IiMYaPadTxHfHaOqNggmWoN06iaFcsvTtNJ7XJtj/8DJDcyHeE7TG5xD+gA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789856; c=relaxed/simple;
	bh=iXJgNcThmxkm3TnRQjzZQuN8UzVODisYYjfRJTHl0yw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DU3R1Mv8QPXH6ssJemKWLvTrUrLpCHE7ABpHVZlWkRnc4+vIgcJYN8evfHC5l4lNsG9xHjsZeNsoc9puCpCfbST0CfeyWj90WIzjcMfD3hjOoIc8id0ph2H1JPdAdmtEBGyWqyjYYcBptLPVPDcc+eflOiYqBQMXfZ7dUxWe80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goCb03/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57878C4CEF7;
	Wed,  7 Jan 2026 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789856;
	bh=iXJgNcThmxkm3TnRQjzZQuN8UzVODisYYjfRJTHl0yw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=goCb03/1Z1anQzE+U+wmwe4H6zr/zAZx923KbzvF85OpQwCerss7oIwJOa4aV68Tu
	 wGabvxRnnBsb29JWa9tB1K82Rlvhd5yTjVYNxX3yG7QomgD2tNx2hGy+ZgBNTq2IgA
	 lNRbl6fKYnOj9HOPFKQefmRxyLoEDNdRZDG+V65Mujz29Koj5XX3x0tCzZwe3CoIHn
	 dhZ7bnd+Uk1QZokvoHOx+Aq7E7mMVpAJ3sYtcuFhKJGP1fBH6YfmP2OvmGG91DXVmR
	 tZrjBQ6r+DCivv6p6HRoZ/ZN85MoJ8azsL1dOitqf8JwBG2TbAWY34fESr2E7Fe9x+
	 GW+YSD9ERLKmQ==
Content-Type: multipart/mixed; boundary="===============5691045705513337693=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5be9eb70fb41e7278771d9ff1fe3493444a7c33d28f300f04fb8e3be73005ec4@mail.kernel.org>
In-Reply-To: <20260107-helper_proto-v1-2-e387e08271cc@gmail.com>
References: <20260107-helper_proto-v1-2-e387e08271cc@gmail.com>
Subject: Re: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
From: bot+bpf-ci@kernel.org
To: ftyghome@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mattbobrowski@google.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,dxu@dxuuu.xyz
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,netdev@vger.kernel.org,electronlsr@gmail.com,gplhust955@gmail.com,haoran.ni.cs@gmail.com,ftyghome@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 12:44:15 +0000 (UTC)

--===============5691045705513337693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f0ca69f888fa..c7ebddb66385 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10349,10 +10349,27 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
>  	return true;
>  }
>
> +static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> +		enum bpf_arg_type arg_type = fn->arg_type[i];
> +
> +		if (base_type(arg_type) != ARG_PTR_TO_MEM)
> +			continue;
> +		if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
> +			return false;

Does this check also apply to ARG_PTR_TO_FIXED_SIZE_MEM? Looking at the
definition in include/linux/bpf.h:

    ARG_PTR_TO_FIXED_SIZE_MEM = MEM_FIXED_SIZE | ARG_PTR_TO_MEM,

Since base_type() masks off the flags, base_type(ARG_PTR_TO_FIXED_SIZE_MEM)
returns ARG_PTR_TO_MEM. But ARG_PTR_TO_FIXED_SIZE_MEM does not include
MEM_WRITE or MEM_RDONLY in its definition.

Several helpers in net/core/filter.c use ARG_PTR_TO_FIXED_SIZE_MEM without
additional flags:

    bpf_tcp_raw_gen_syncookie_ipv4_proto:
        .arg1_type = ARG_PTR_TO_FIXED_SIZE_MEM,

    bpf_tcp_raw_gen_syncookie_ipv6_proto:
        .arg1_type = ARG_PTR_TO_FIXED_SIZE_MEM,

    bpf_tcp_raw_check_syncookie_ipv4_proto:
        .arg1_type = ARG_PTR_TO_FIXED_SIZE_MEM,
        .arg2_type = ARG_PTR_TO_FIXED_SIZE_MEM,

    bpf_tcp_raw_check_syncookie_ipv6_proto:
        .arg1_type = ARG_PTR_TO_FIXED_SIZE_MEM,
        .arg2_type = ARG_PTR_TO_FIXED_SIZE_MEM,

Would these helpers fail check_func_proto() after this change, causing
BPF programs using them to fail verification? Should these prototypes
be updated to include MEM_RDONLY (since they read from the memory), or
should the check skip ARG_PTR_TO_FIXED_SIZE_MEM?

> +	}
> +
> +	return true;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20781625347

--===============5691045705513337693==--

