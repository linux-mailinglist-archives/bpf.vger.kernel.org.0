Return-Path: <bpf+bounces-74405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE4C578C9
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 14:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CC73AB1E5
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA610350D55;
	Thu, 13 Nov 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkoqBZsd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25013350D45;
	Thu, 13 Nov 2025 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038940; cv=none; b=QGC0/h0XGucUi+LmsZ4O3/rniM6qHl9yEG8bS+9zDyrxzlJfoDGmduBIdZEcNLfPtQyKG2QaQO8DA9GSJpkf7JumFQvWz3zvCUMzkgtgofWudbKo0wxDKQvjniqlmAQS62MkIwF0vhwzJYHBxJqvTYsrG6cWEehJt2Wvg9cuhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038940; c=relaxed/simple;
	bh=/L06/z32jweN40cjaZPHRLCm3sG/QFbAOWPashtYEXs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nWcBkFLLIo8IMtZQCjXvwZ+WUZHe+dAeGwJDuyUkDiAESLhWzO1XJ34Pb2ZB38uYxs1lhTuEN+jIJy50baDfji1vRHnS3Oufy+VPgiwMzl4DwelXmiNnZWUuL413FvzvF0RyfcVk5F6ykQvSD3SFS6kDWmoOQel5pRUG4aPPFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkoqBZsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1179FC116D0;
	Thu, 13 Nov 2025 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038939;
	bh=/L06/z32jweN40cjaZPHRLCm3sG/QFbAOWPashtYEXs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fkoqBZsdd8Mnery3fINEDg/aDSvV+rd6JmptlBGmtzuEZbDl/VVzkuraqdLfzMPlI
	 Ckt6gKo1kCzCVbD9YRyR4nyn1Z6YIsFCeYekXXTg579swBpSJEAMIiwdKm0WvDeS/A
	 uNEoYFWSGbecbRH6i5mVRuLi5GFTVWsWcwRDXcTUy8CohjTnh0wxfXCFb8e4jMO+mV
	 MkGaQpdbuHMPp8IZutA7VJQl5nywaDHxMxVeADYna8RbzFNW6ZZIaVMwmQNTW1HI1C
	 fxq3rTNfko9GWEz7zPTmAY3Wwohbs4n519cQE5QFEgXN7redz3gl+FhN0/WVzVu3oc
	 kBJxGdn9h4nVw==
Content-Type: multipart/mixed; boundary="===============7781627510451298251=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c341189e76b2cf9bb2fe712c074bdd652f73edd5ea2f409655b2d78a62bd332f@mail.kernel.org>
In-Reply-To: <20251113123750.2507435-4-jolsa@kernel.org>
References: <20251113123750.2507435-4-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 3/8] ftrace: Add update_ftrace_direct_add function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,rostedt@kernel.org,revest@google.com,mark.rutland@arm.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,menglong8.dong@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Nov 2025 13:02:18 +0000 (UTC)

--===============7781627510451298251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e23e6a859..ded3a306a 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h

[ ... ]

> @@ -568,6 +570,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
>  	return -ENODEV;
>  }
>
> +int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> +{
> +	return -ENODEV;
> +}
> +
>  /*
>   * This must be implemented by the architecture.
>   * It is the way the ftrace direct_ops helper, when called

Should this stub function have static inline qualifiers? All the other
stub functions in this section (ftrace_find_rec_direct,
register_ftrace_direct, unregister_ftrace_direct, modify_ftrace_direct,
and modify_ftrace_direct_nolock) use static inline. Without it, this
could cause multiple definition linker errors when the header is
included in multiple compilation units.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19332026793

--===============7781627510451298251==--

