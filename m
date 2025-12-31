Return-Path: <bpf+bounces-77582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF83CEBB70
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 10:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7613025FBB
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC35314D0B;
	Wed, 31 Dec 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pU3mkzr7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2822301;
	Wed, 31 Dec 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767174501; cv=none; b=eSNAsZCK0XqNmT+GeOuZeXcPymJnoqMr/4UQHvcY3qUaIygenHIAXpEio4jgSb/iBOCtwncQMf04EvqFi8GXnK6cj3lm77FCpZT/T8dox9s8dVkAupirqzEIW89QW8O2YBOQjmmtjAsWgBQ9aIKJe/12lMX5c4QgIO6thA5h/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767174501; c=relaxed/simple;
	bh=K1E8g82sSzogoZCwD9FdLSZz5brvHfQEWBXc8AQUlFo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JYk0nglN6R42ZUMb2IT68YOmMCWummvq2Y8xk6Ys9S1zznIHd0sbb/PISvzzcH5vy2/Sw4HeCB5K4LcnxN91NNweanvhLxvODmxjYw/jbNCBVuy1VPJ84X0f2znq5jd1maChxdTUT1/xpERz7OX1qjf6UiIniStQ5Q22LP60tMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pU3mkzr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2BBC113D0;
	Wed, 31 Dec 2025 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767174501;
	bh=K1E8g82sSzogoZCwD9FdLSZz5brvHfQEWBXc8AQUlFo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pU3mkzr7B6S+erqJZrbs0cHtgUzViWuII+cgNOVlRC+7G/KAFTdx2kBPpeGxcTPpz
	 X02UaMZKKB4JHIn0dKUQaf5HIb26k/aNsH7NAUnsir69yflvzHwl63ualTVIxOPemj
	 pxMlbe1b1OfLkoAqe1uJxwOemdtyWcnKOKKVAwK5phUsrobQHydjFFz0RQZfCB0Fil
	 yrjFfOnPfGQjMkK3qqPeX5DubFWDD1IK8GgydBRplrNiSGRfNUpIS5Dhw+fCq3BENL
	 d4+TPoNv8LUChirENxIeZpXB+YQ6xWA40HozGsBoT97dNfah3deKrBwWqh/Fk+2kMh
	 eGsUDQiQzroJA==
Content-Type: multipart/mixed; boundary="===============6587404859822489521=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <068479a445bbedc0c50f50f817f6236444dc4809e9a8a0fdefc9216a3832c864@mail.kernel.org>
In-Reply-To: <20251231092541.3352-1-kiraskyler@163.com>
References: <20251231092541.3352-1-kiraskyler@163.com>
Subject: Re: [PATCH bpf-next] bpftool: Make skeleton C++ compatible with explicit casts
From: bot+bpf-ci@kernel.org
To: kiraskyler@163.com,qmo@kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,kiraskyler@163.com,menglong8.dong@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,niuwl1@chinatelecom.cn,dongml2@chinatelecom.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 31 Dec 2025 09:48:20 +0000 (UTC)

--===============6587404859822489521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 993c7d9484a4..71446a776130 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -731,10 +731,10 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  		{							    \n\
>  			struct %1$s *skel;				    \n\
>  									    \n\
> -			skel = skel_alloc(sizeof(*skel));		    \n\
> +			skel = (struct trace_bpf *)skel_alloc(sizeof(*skel));\n\
                                   ^^^^^^^^^

Should this cast use (struct %1$s *) instead of (struct trace_bpf *)?

The variable skel is declared as "struct %1$s *skel" where %1$s is replaced
with obj_name, but the cast hardcodes "trace_bpf" regardless of what skeleton
is being generated. This would cause C++ compilation errors for any BPF
object with a name other than trace_bpf.

For comparison, the non-loader skeleton at do_skeleton() correctly uses
"(struct %1$s *)calloc()" to match the skeleton name.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20616299845

--===============6587404859822489521==--

