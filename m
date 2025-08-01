Return-Path: <bpf+bounces-64915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EB9B185D0
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CAD62644F
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B2816FF44;
	Fri,  1 Aug 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dKQcL7n6"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92318D
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065872; cv=none; b=KHqjZjGy+6Ndxh30V4WhnkeinU390+XZG3jEKt5XFpQRdhW4UcSqHur4jeeKUoVkoa4KNAf/tQQSCRFVZGp2SyZjkxPgpk7LLN+VYIJGS9PneLmeNkcyAEMPwreR5/YFQPPt/z0UUELvHNHrsoRyGpS2IZYxlMQZ+SvL0f2IH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065872; c=relaxed/simple;
	bh=T4bYieFv5LfO/IRqc2qPhkIXqxlkNfCdNHoPR1nTXhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QODYZKdC9J5+L8UvMSYLaN9pLBdRopJINkgXjaCEk7bmVX68HJbm1kqKRZpK1Iop3it0v3YRMkScUi5Jsakm8j6leBG2lXTeDOYLi6QrMQcnfaZPJl/L0PCV0sVj8sr9fusm/DjRWny5MyjLKJjTZXNHldo0KTURpbX2CcGrajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dKQcL7n6; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91bb735f-088e-4346-9b2c-874caf0bc1ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754065858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XgNhwo+yL6OA0es4MKVJbLgKNyAaHpC3XsdhEhMZkc=;
	b=dKQcL7n6sN/Z+GRvJkR4hsxneyuCTSKWVV6wokYbOwUpGLoKSB1c37iXpdJLfKpyTEG5Kr
	4bSSR+FaO2hWkdmR3GSVfCehZnFc2UXGtA8pTtpgLBe3MyUW40c8MM2k/dCcsU3jBxRELM
	Xt9++LmqSdkwpRyZks+bHjdjMTVjoSs=
Date: Fri, 1 Aug 2025 09:30:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 3/4] bpf: Improve ctx access verifier error message
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, netfilter-devel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Petar Penkov <ppenkov@google.com>,
 Florian Westphal <fw@strlen.de>
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
 <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/1/25 2:49 AM, Paul Chaignon wrote:
> We've already had two "error during ctx access conversion" warnings
> triggered by syzkaller. Let's improve the error message by dumping the
> cnt variable so that we can more easily differentiate between the
> different error cases.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>   kernel/bpf/verifier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 399f03e62508..0806295945e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21445,7 +21445,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>   					 &target_size);
>   		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
>   		    (ctx_field_size && !target_size)) {
> -			verifier_bug(env, "error during ctx access conversion");
> +			verifier_bug(env, "error during ctx access conversion (%d)", cnt);

For the above, users still will not know what '(%d)' mean. So if we want to
provide better verification measure, we should do
	if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
		verifier_bug(env, "error during ctx access conversion (insn cnt %d)", cnt);
		return -EFAULT;
	} else if (ctx_field_size && !target_size) {
		verifier_bug(env, "error during ctx access conversion (ctx_field_size %d, target_size 0)", ctx_field_size);
		return -EFAULT;
	}

Another thing. The current log message is:
	verifier bug: error during ctx access conversion (0)(1)

The '(0)' corresponds to insn cnt. The same one is due to the following:

#define verifier_bug_if(cond, env, fmt, args...)                                                \
         ({                                                                                      \
                 bool __cond = (cond);                                                           \
                 if (unlikely(__cond)) {                                                         \
                         BPF_WARN_ONCE(1, "verifier bug: " fmt "(" #cond ")\n", ##args);         \
                         bpf_log(&env->log, "verifier bug: " fmt "(" #cond ")\n", ##args);       \
                 }                                                                               \
                 (__cond);                                                                       \
         })
#define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##args)

Based on the above, the error message '(1)' is always there, esp. for verifier_bug(...) case?
Does this make sense?

>   			return -EFAULT;
>   		}
>   


