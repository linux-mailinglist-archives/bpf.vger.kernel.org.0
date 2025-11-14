Return-Path: <bpf+bounces-74498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55378C5C8E2
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4138344086
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C030FC1B;
	Fri, 14 Nov 2025 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ces3QwLP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256C2DC78C;
	Fri, 14 Nov 2025 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115625; cv=none; b=URewSm/bfVGvk8BIrKf4mzKZuSeaF7Uuu6XaiX6CrIKAB6ez6kGa53h0s6RtQQnk30GNmQqc+ggHeUqjHf5ETC9d5cp50seAvu/noSIz2pufgYUeBXxB2NmnrAAK8hJM6FhR8x1HgNRHCg1cE5EGweg/zTsZfvCT9pfNN25X+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115625; c=relaxed/simple;
	bh=fSO6pWTAU9fX5LrPb4jxanlzKRjhj3oVdw0B+ORFeA4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V3g6e9zfHW46EH6kemv19JVbnV2LJQIBK/8GwgKWmlE43sPNTpUr+XeJtfwErOgYXzYXeWs79oTFt5dJ6WGuW4h6jiCY/hnHjn6oqwAwOMYjugDDd1hyBjYrcXWJmyGkzGOewHw8HmgN5gJKqD5wNiXEUAfyr/KaqEQSWL/Gg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ces3QwLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62477C4CEF8;
	Fri, 14 Nov 2025 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115624;
	bh=fSO6pWTAU9fX5LrPb4jxanlzKRjhj3oVdw0B+ORFeA4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ces3QwLP8RPLWdkIOjd8Iq2quinCayJyyGK3Nt0JbLctMdoBbAEsyu1dlG52IC/Je
	 LCfEBrrxm1uKNvzxgpeR3hFM9EEfQW7FSCOCxVcL97ONTMK1Y7XtJ0hkvJ6++QFp4i
	 7XXgq43HC4lpn74fDYdxCedQwvhAw/ufEPHwa0Yxwm6UXewZ6LrpwmG22tqEpyfHgX
	 CT3vlOd7rriC4ErJ1xbr4oKPTPmTjlLbBU49L15quhqJpBZZLhMfHTm7y/dxiE+uFZ
	 1b/IYqLybiNHl/WKsD0zIkI1IsGSPTRCws4MV1CxOJ1clIf6rq9FZTkICdsMvKdBUl
	 zr8EVX6Cz62xA==
Content-Type: multipart/mixed; boundary="===============7891569904405583792=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cf34d9e768db2261565112341daaf39d6b3cb5f75b405b04e07186ed27e76520@mail.kernel.org>
In-Reply-To: <20251114092450.172024-6-dongml2@chinatelecom.cn>
References: <20251114092450.172024-6-dongml2@chinatelecom.cn>
Subject: Re: [PATCH RFC bpf-next 5/7] bpf: introduce bpf_arch_text_poke_type
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,rostedt@goodmis.org
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mhiramat@kernel.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 10:20:24 +0000 (UTC)

--===============7891569904405583792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8fb8c9bbd..975930e10 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3712,6 +3712,10 @@ enum bpf_text_poke_type {
>  	BPF_MOD_JUMP,
>  };
>
> +int bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
> +			    enum bpf_text_poke_type new_t, void *addr1,
> +			    void *addr2);
                                                          ^^^^^^^^^^^^

The header declaration uses parameter names addr1 and addr2, but the
implementation in kernel/bpf/core.c uses old_addr and new_addr. Should
these match? When developers implement arch-specific versions, they'll
see addr1/addr2 in the header but old_addr/new_addr in the weak default
implementation. The existing bpf_arch_text_poke() uses addr1/addr2, but
the x86 implementation of that function semantically treats them as
old_addr and new_addr. Would it be clearer to use old_addr/new_addr
consistently, or addr1/addr2 to match the existing function?

> +
>  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>  		       void *addr1, void *addr2);
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ef4448f18..400eb70fd 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3156,6 +3156,16 @@ int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>  	return -ENOTSUPP;
>  }
>
> +int __weak bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
> +				   enum bpf_text_poke_type new_t, void *old_addr,
> +				   void *new_addr)
                                       ^^^^^^^^^^^^^^^^^^^^^^
> +{
> +	if (old_t == new_t)
> +		return bpf_arch_text_poke(ip, old_t, old_addr, new_addr);
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  void * __weak bpf_arch_text_copy(void *dst, void *src, size_t len)
>  {
>  	return ERR_PTR(-ENOTSUPP);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19360353328

--===============7891569904405583792==--

