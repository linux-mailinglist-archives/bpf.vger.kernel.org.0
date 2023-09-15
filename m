Return-Path: <bpf+bounces-10176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED27A25BA
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792B31C20A77
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912C18E27;
	Fri, 15 Sep 2023 18:30:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D718E11
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 18:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76465C433C8;
	Fri, 15 Sep 2023 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694802611;
	bh=wbnJo8rFizU3HAyVmJkb5mTxsQnJcT5sgSZwMnt/Su8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/72teB7kMJ3Y5PTQUPYA1iDWaFjQn4n7PQkMSnEaeNmM2HvymvFNd7VWLnGwpqhS
	 WWFLON3vKsiU6RBXxBtrB5BX57qhAFgWwzRj2Op/p6zl4VIf/1xbLvcBaKgTchc21R
	 phqhYJ4IbejtsSu9yvB76uBvPpnoYaAfKp2NdIZpbsBjDJPcJ12w2IVcJje3kRRtR/
	 ILQ2S27EB9WVv3QbBIUUqHmn+xwEjgZpZD4hfKTvpXz45r4/uZGr1yqyE3leBGt+6f
	 6Usxkzu2JDe3//pzWURqJph/X5gHxkpgcv41uu6e3yQAXJfHO+z79+9xOxK8SgmL17
	 yfvlEBniTNh9Q==
Date: Fri, 15 Sep 2023 11:30:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	stable@vger.kernel.org,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>
Subject: Re: [PATCH  bpf  v3 1/2] bpf: Fix BTF_ID symbol generation collision
Message-ID: <20230915183008.GA17653@dev-arch.thelio-3990X>
References: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
 <20230915-bpf_collision-v3-1-263fc519c21f@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-bpf_collision-v3-1-263fc519c21f@google.com>

On Fri, Sep 15, 2023 at 10:34:27AM -0700, Nick Desaulniers wrote:
> From: Jiri Olsa <jolsa@kernel.org>
> 
> Marcus and Satya reported an issue where BTF_ID macro generates same
> symbol in separate objects and that breaks final vmlinux link.
> 
> ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> '__BTF_ID__struct__cgroup__624' is already defined
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
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/btf_ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index a3462a9b8e18..a9cb10b0e2e9 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -49,7 +49,7 @@ word							\
>  	____BTF_ID(symbol, word)
>  
>  #define __ID(prefix) \
> -	__PASTE(prefix, __COUNTER__)
> +	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
>  
>  /*
>   * The BTF_ID defines unique symbol for each ID pointing
> 
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 

