Return-Path: <bpf+bounces-75459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A6DC85298
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7EC3A2B17
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7718931C56D;
	Tue, 25 Nov 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSxeuZDc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39022EB5D4
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076936; cv=none; b=XCOpKHi6yEdRreJ0MZZ1oxtHXbAxnsKZjmq1C4mz1BzA3yxy55WxdcaQXbDwOeUtqi2vmR8/hSnbQjRtJFkseEO8t97e74M8AFsVOvZQveJw+Pku+KpjXCbNzzqTkV47QrnEFrga5D1OC1qsCVUPbw9VBg4pciL5+XS9JGehjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076936; c=relaxed/simple;
	bh=X2Sa+IyeW+ulEA8ruc8svcpEJj6JgF2Dan7xlWe1z8Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FyJjEJS3J8CWGBupV4Fo5FipwiqZcM06W3TMMR9gjRG793mTtTcPXCmYrPJYrNAS8OpCO6kuBUoYKJZJU34CTt3pFBovs0CmabNGlf7ZXO/UtaJttfh9N0IE5heybqZfyNic2LWQ7fEO/vsyc4sJI/1DnKuUpjhU8Hj6MzbjP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSxeuZDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BEBC4CEF1;
	Tue, 25 Nov 2025 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764076934;
	bh=X2Sa+IyeW+ulEA8ruc8svcpEJj6JgF2Dan7xlWe1z8Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jSxeuZDcYCBX/J6R3tZ7CFEddkyRj1zspYA6AHynbuT9khyLqG8j60lbKO3jEewGN
	 WxrqfFN0YfVCHzZSpG8AL8ogxDNzbOMYmImqXZzLz4wfBoG4hECOi0MHgTLEjzoUg/
	 iI7XaG1wBNRyHCI3VRN6zGtXEvZwOk2gnwcFgNhhpaM0+746QNyntk6K1NBycgA7cI
	 SswGLXf0bR+XiDi6814L/ro1JgoRgNFI6Idf3HdeD96DcTQzQpTNh0tP4QS0AhLxhH
	 c4QBk6vc1vUMgGfBfQtNYQP1DAGgNHKbNuHfezLalf4ReVIialzzFMHVntcEf4wlM4
	 HoKg19gADftVQ==
Content-Type: multipart/mixed; boundary="===============6436801730167258005=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b37af1dcde7b7efb4dfc0329ca3ea1c3f4ede7e9b8eb02a1eabd042d561f00fd@mail.kernel.org>
In-Reply-To: <20251125125634.2671-2-dimitar.kanaliev@siteground.com>
References: <20251125125634.2671-2-dimitar.kanaliev@siteground.com>
Subject: Re: [PATCH v1 1/3] bpf: Introduce tnum_scast as a tnum native sign extension helper
From: bot+bpf-ci@kernel.org
To: dimitar.kanaliev@siteground.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mykolal@fb.com,shung-hsi.yu@suse.com,dimitar.kanaliev@siteground.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Nov 2025 13:22:13 +0000 (UTC)

--===============6436801730167258005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index c52b862da..ed18ee114 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -63,6 +63,9 @@ struct tnum tnum_union(struct tnum t1, struct tnum t2);
>  /* Return @a with all but the lowest @size bytes cleared */
>  struct tnum tnum_cast(struct tnum a, u8 size);
>
> +/* Return @a sign-extended from @size bytes */
> +struct tnum tnum_scast(struct tnum a, u8 size);
> +
>  /* Returns true if @a is a known constant */
>  static inline bool tnum_is_const(struct tnum a)
>  {
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index f8e70e9c3..eabcec2eb 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -199,6 +199,19 @@ struct tnum tnum_cast(struct tnum a, u8 size)
>  	return a;
>  }
>
> +struct tnum tnum_scast(struct tnum a, u8 size)
> +{
> +	u8 s = 64 - size * 8;
> +	u64 value, mask;
> +
> +	if (size >= 8)
> +		return a;
> +
> +	value = ((s64)a.value << s) >> s;
> +	mask = ((s64)a.mask << s) >> s;
                                    ^^

Can this invoke undefined behavior when size is 0? When size==0,
s becomes 64, and shifting a 64-bit value by 64 bits is undefined
behavior according to the C standard. The guard only checks size >= 8,
allowing size==0 to reach the shift operations.

The similar function tnum_cast() handles size==0 by producing a zero
value (since (1ULL << 0) - 1 == 0), which is well-defined. Should
tnum_scast() also handle size==0 explicitly, perhaps by adding
"size == 0 ||" to the guard condition?

> +	return TNUM(value, mask);
> +}
> +
>  bool tnum_is_aligned(struct tnum a, u64 size)
>  {
>  	if (!size)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19670538430

--===============6436801730167258005==--

