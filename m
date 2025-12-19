Return-Path: <bpf+bounces-77137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64734CCEDB4
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 08:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D5E130101E7
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0111DE8AE;
	Fri, 19 Dec 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeS78exI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B12D8DDF;
	Fri, 19 Dec 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130910; cv=none; b=TnsJxxe9NkuCAVk7ftwIGxkvBQp/YVacJZmhckalw3h4KG6/zwbH8Qv4guBMSkivwu9BPo+MCuTKXpnTop0HASdZ6XKvaymjJQx9ZqtQMXMrrVGUtfLdU8vRZ6jV8MRVDqiSLB87f2o9ugjYSRlMykkQv0Tzx3lwuXtVfz6ZXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130910; c=relaxed/simple;
	bh=i6jm3TrdmbiSkM3odFdOiqa8jcKmRK3jnHNaNoxvwao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA0HJXY5McT0zBmunaFhmTdmhyAF1X5UgKRy/qnLtJObvk68VKiMd0k6gOUNKAJalwV5TS8PLMf2keiWKOzAnu9K6ey6g3QQdW0gHQ40hCue6pm6brsFqpvPTVRmA8y7c5VTOKNIDTGlVvuRmoUl78hhp7Tric4nGSsID64ylYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeS78exI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E115C4CEF1;
	Fri, 19 Dec 2025 07:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766130909;
	bh=i6jm3TrdmbiSkM3odFdOiqa8jcKmRK3jnHNaNoxvwao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeS78exI7ljtsGluX4FQLpXYVyMVaIryW2kIVAAVaIkS1SWKl5nOct0TGriEmsdCl
	 PqjZfq5+9CGJsNgEDX75zFtHguzGFrzK4C3L1NpHIOSdr/6hRGFF4js3Fu+R914ua+
	 sqhAo3BNujOWcMKnVnNgOHFXqFy1WVL2UB8afzvbo6F4h6HVnm7OaiRRubXpGBaDDY
	 4MS7LuiHa5EbD+AhyFHSS2XkSyxaKvcMUmkIXaqRvyNL8O8WhDaBCeYkWtpQQT40YX
	 1moUz9pU9Ny1IBz7tXOdOtV0Ji8mqiXd73Tc7rMm8CXNGnoXDAm/kVrEOxGxBLRdM/
	 LPBVZRvJHWRoQ==
Date: Fri, 19 Dec 2025 08:54:50 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH bpf-next v6 6/8] lib/Kconfig.debug: Set the minimum
 required pahole version to v1.22
Message-ID: <aUUEyncduBLl8k4n@derry.ads.avm.de>
Mail-Followup-To: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, sched-ext@lists.linux.dev
References: <20251219020006.785065-1-ihor.solodrai@linux.dev>
 <20251219020006.785065-7-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219020006.785065-7-ihor.solodrai@linux.dev>

On Thu, Dec 18, 2025 at 06:00:04PM -0800, Ihor Solodrai wrote:
> Subsequent patches in the series change vmlinux linking scripts to
> unconditionally pass --btf_encode_detached to pahole, which was
> introduced in v1.22 [1][2].
> 
> This change allows to remove PAHOLE_HAS_SPLIT_BTF Kconfig option and
> other checks of older pahole versions.
> 
> [1] https://github.com/acmel/dwarves/releases/tag/v1.22
> [2] https://lore.kernel.org/bpf/cbafbf4e-9073-4383-8ee6-1353f9e5869c@oracle.com/
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Documentation/scheduler/sched-ext.rst |  1 -
>  lib/Kconfig.debug                     | 13 ++++---------
>  scripts/Makefile.btf                  |  9 +--------
>  tools/sched_ext/README.md             |  1 -
>  4 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 404fe6126a76..9e2882d937b4 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -43,7 +43,6 @@ options should be enabled to use sched_ext:
>      CONFIG_DEBUG_INFO_BTF=y
>      CONFIG_BPF_JIT_ALWAYS_ON=y
>      CONFIG_BPF_JIT_DEFAULT_ON=y
> -    CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>      CONFIG_PAHOLE_HAS_BTF_TAG=y
>  
>  sched_ext is used only when the BPF scheduler is loaded and running.
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ba36939fda79..60281c4f9e99 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -388,18 +388,13 @@ config DEBUG_INFO_BTF
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	depends on BPF_SYSCALL
> -	depends on PAHOLE_VERSION >= 116
> -	depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
> +	depends on PAHOLE_VERSION >= 122

As CONFIG_DEBUG_INFO_BTF was the reason for 'pahole' being listed in
Documentation/process/changes.rst, does it make sense to update the
minimum pahole version there, too?

Acked-by: Nicolas Schier <nsc@kernel.org>

