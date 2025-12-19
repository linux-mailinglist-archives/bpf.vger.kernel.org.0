Return-Path: <bpf+bounces-77083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F835CCE17B
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AD4A304F137
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90D321257B;
	Fri, 19 Dec 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euHPzwOP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251803A1E8B;
	Fri, 19 Dec 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105595; cv=none; b=n/rZwRq8ZNuXVclhYB87aWQboCOa+ZgNkHeUpxISN5YEY4kyoJF8N01+FQCf2brmbr0YTZ7Ck8Cn2mpvUSBs5mi4NF8pAUszNcDacrZSr0a18YaVYd17MfDywguHWU9JdKmrUp736mr4pQwTa5lSFdE/aYtBC7vRdWH71E54J2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105595; c=relaxed/simple;
	bh=8t0rKlOdL3F3z4Kd5lCJN2OPzaRO3sB1fLvURDHw0LI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qqGyu04CfqE1+52gpSo7t0Oj5vzMpEG4iLWnbwRut4ASilS4d7aOyXURKWyiKe4nFcy0Z1miw9AFHAbYaIu/vTybELDNNkk8V/0yHx7YW24kiSlm3ssNNLRpRFsML8+WirQ6rILQFHxZ1mIKxHsRJfLRwNZgpjQSua22POsoylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euHPzwOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C1DC4CEFB;
	Fri, 19 Dec 2025 00:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766105593;
	bh=8t0rKlOdL3F3z4Kd5lCJN2OPzaRO3sB1fLvURDHw0LI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=euHPzwOPilfmzUEUSs4N66QQyTJW8fbLL9q/iCCmB7QV/xFrZPEMoHCBy2J3Qn74q
	 fddBstzs+Q4wtHoMSFpK4MVJctm4RV41I+2SPWZHOXaOQYa3PlTkFgXblac1Orja6h
	 mlS7Th/CzyyGmzIEprZYn0govPGwpVhSsN8LZi8q1ruXv7WPwwQqWIftRhsbicsvCi
	 h7UV9PUPvgTBUX0UxAJrxdpnSs7eZjKDtMVI6WV6yi88BOJV7w6bJ9YYfxbHVXNlAA
	 ZxI0ZpH0ZqI6G01hMvp8gU06iH7NE8KHe582kUsHt5zP1Xnh6nwh/inTNbdGYS2xFQ
	 DOJyOxpR0WMig==
Content-Type: multipart/mixed; boundary="===============3171614020991680172=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e269870b8db409800045ee0061fc02d21721e0efadd99ca83960b48f8db7b3f3@mail.kernel.org>
In-Reply-To: <20251219003147.587098-9-ihor.solodrai@linux.dev>
References: <20251219003147.587098-9-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v5 8/8] resolve_btfids: Change in-place update with raw binary output
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,akpm@linux-foundation.org,nathan@kernel.org,nsc@kernel.org,corbet@lwn.net,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,shuah@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,alan.maguire@oracle.com,dolinux.peng@gmail.com
Cc: bpf@vger.kernel.org,dwarves@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Dec 2025 00:53:13 +0000 (UTC)

--===============3171614020991680172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index e721e20a2bbd..7127396c5f50 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -587,6 +563,19 @@ static int load_btf(struct object *obj)
>  	obj->base_btf = base_btf;
>  	obj->btf = btf;
>
> +	if (obj->base_btf && obj->distill_base) {
> +		err = btf__distill_base(obj->btf, &base_btf, &btf);
> +		if (err) {
> +			pr_err("FAILED to distill base BTF: %s\n", strerror(errno));
> +			goto out_err;
> +		}
> +
> +		btf__free(obj->btf);
> +		btf__free(obj->base_btf);
> +		obj->btf = btf;
> +		obj->base_btf = base_btf;
> +	}
> +
>  	return 0;
>
>  out_err:
> +	btf__free(base_btf);
> +	btf__free(btf);
>  	return err;
>  }

Can this lead to a double free if btf__distill_base() fails?

At the point of calling btf__distill_base(), the local variables base_btf
and btf have already been assigned to obj->base_btf and obj->btf. If
btf__distill_base() fails, it does not modify its output parameters, so
base_btf and btf still point to the same memory as obj->base_btf and
obj->btf.

The out_err path then frees base_btf and btf (the original BTF objects).
But obj->base_btf and obj->btf still point to this freed memory. When
load_btf() returns an error to main(), the cleanup at the out: label
calls btf__free(obj.base_btf) and btf__free(obj.btf), which would free
the same memory a second time.

The execution path would be:
  main() -> load_btf() -> btf__distill_base() fails
  -> out_err frees base_btf and btf
  -> return err to main()
  -> main() goto out
  -> btf__free(obj.base_btf) and btf__free(obj.btf) -> double free

Perhaps the out_err path should set obj->base_btf = NULL and obj->btf =
NULL after freeing, or load_btf() should clear obj->base_btf/obj->btf
before going to out_err?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20355860150

--===============3171614020991680172==--

