Return-Path: <bpf+bounces-10160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC17A2483
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9221C208DB
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842B15E94;
	Fri, 15 Sep 2023 17:18:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEA1097B
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D6CC433C8;
	Fri, 15 Sep 2023 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694798296;
	bh=YO2T/6WW3bJjxN+Z8mYt9aoZJVmK6skob5Zddb0K2Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fm4mzSfILYdRHi+Q7V7D1B9m2b6jcr5JpeHoccD7vrqlE01LU9KltJ6EDE5Fegy3q
	 dg2+n8iGr5mYcARWKi6Xl3bWvQJnmgHZ5nyhorw9X9PEcuy8V8llZaO5Sns3R63EtK
	 wCnvF3tQ8V+4/+VcpOJBexc3fUH7Fmfqt6113MVJN8sb+srXjd+onx2RZ+zL3Q6B/d
	 kmaJa4Dd8pHTSVfC1A9oqSm7eHjPY3iJ1ux39KVTJqaC3SVcVM2Rn4z/7jiuBaNoEO
	 suWD+BXhFGq4MMPZl3RtSO8nyzBQ+jdcE0KD2wD2fCgF+C65H+DNLWfvpPLxx41XXn
	 5jd6BDszX+R7Q==
Date: Fri, 15 Sep 2023 10:18:14 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	stable@vger.kernel.org,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
Message-ID: <20230915171814.GA1721473@dev-arch.thelio-3990X>
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>

On Fri, Sep 15, 2023 at 09:42:20AM -0700, Nick Desaulniers wrote:
> Marcus and Satya reported an issue where BTF_ID macro generates same
> symbol in separate objects and that breaks final vmlinux link.
> 
>   ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
>   '__BTF_ID__struct__cgroup__624' is already defined
> 
> This can be triggered under specific configs when __COUNTER__ happens to
> be the same for the same symbol in two different translation units,
> which is already quite unlikely to happen.
> 
> Add __LINE__ number suffix to make BTF_ID symbol more unique, which is
> not a complete fix, but it would help for now and meanwhile we can work
> on better solution as suggested by Andrii.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
> Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
> Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  tools/include/linux/btf_ids.h | 2 +-

Shouldn't this diff be in include/linux/btf_ids.h as well? Otherwise, I
don't think it will be used by the kernel build.

>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 71e54b1e3796..30e920b96a18 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -38,7 +38,7 @@ asm(							\
>  	____BTF_ID(symbol)
>  
>  #define __ID(prefix) \
> -	__PASTE(prefix, __COUNTER__)
> +	__PASTE(prefix, __COUNTER__ __LINE__)
>  
>  /*
>   * The BTF_ID defines unique symbol for each ID pointing
> 
> ---
> base-commit: 9fdfb15a3dbf818e06be514f4abbfc071004cbe7
> change-id: 20230915-bpf_collision-36889a391d44
> 
> Best regards,
> -- 
> Nick Desaulniers <ndesaulniers@google.com>
> 

