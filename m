Return-Path: <bpf+bounces-21817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10758526E8
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1481C2557C
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926EF8825;
	Tue, 13 Feb 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFjV4fYZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F615B7
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787231; cv=none; b=q4kQ4g0UFY0VxwnddU+wDApOPBBlrHlmLvidSFyH3yutNz53PPRaK302R4n7KfNgZ8n17qY4YbD68P7Wng4OlwRHiqHckaVWeXr1hdFeg+3jl1oEc+DILUC0iadHgvBMWGn5Bufdbc11Z8b/qr6udHyYV9iuG/u4ILQjlDD7LkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787231; c=relaxed/simple;
	bh=K9CLr6JNcYww1MRscDOYfeCRcZSVBf8dR+JwJq0OUyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0/fNqONDmJPYmEE6mUHRB3O6BiUWBIifP9pHtYu17y5iQiKl/wyrrSFlCJb16nrXS6IjWZDoUwZ6TomvRzweYMkkC4hE95AQSA1kqZZjUOZya3bensb5c+FO+kKtkNAn2tcjd1KOUwATLx4IR7VYAebRHcK/Vmiks25rmqPXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFjV4fYZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fdf38873-a1e2-4a16-974b-ea2f265e08e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707787227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9VCL6dcfOIUM9I966X/Y4DCLxRn1w31b6ArmDo6KJM=;
	b=JFjV4fYZloXKt753A8/e/1em+yhpZZ+Tsy682R7PBGmpiVpAvlgkshIVXuv5oMrf+lgbSj
	qshmN71NIkwENopq7QUpLV775pqHK21u0AMTFqKHUpKLTyeXEsOmjsz5dkiSOKwWP9n/51
	B/dqphFDMPDJp/1YoNdpIbSG/FESFvc=
Date: Mon, 12 Feb 2024 17:20:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, kuniyu@amazon.com
References: <20240212143832.28838-1-eddyz87@gmail.com>
 <20240212143832.28838-3-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240212143832.28838-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/12/24 6:38 AM, Eduard Zingerman wrote:
> When comparing current and cached states verifier should consider
> bpf_func_state->callback_depth. Current state cannot be pruned against
> cached state, when current states has more iterations left compared to
> cached state. Current state has more iterations left when it's
> callback_depth is smaller.
>
> Below is an example illustrating this bug, minimized from mailing list
> discussion [0].
> The example is not a safe program: if loop_cb point (1) is followed by
> loop_cb point (2), then division by zero is possible at point (4).
>
>      struct ctx {
>      	__u64 a;
>      	__u64 b;
>      	__u64 c;
>      };
>
>      static void loop_cb(int i, struct ctx *ctx)
>      {
>      	/* assume that generated code is "fallthrough-first":
>      	 * if ... == 1 goto
>      	 * if ... == 2 goto
>      	 * <default>
>      	 */
>      	switch (bpf_get_prandom_u32()) {
>      	case 1:  /* 1 */ ctx->a = 42; return 0; break;
>      	case 2:  /* 2 */ ctx->b = 42; return 0; break;
>      	default: /* 3 */ ctx->c = 42; return 0; break;
>      	}
>      }
>
>      SEC("tc")
>      __failure
>      __flag(BPF_F_TEST_STATE_FREQ)
>      int test(struct __sk_buff *skb)
>      {
>      	struct ctx ctx = { 7, 7, 7 };
>
>      	bpf_loop(2, loop_cb, &ctx, 0);              /* 0 */
>      	/* assume generated checks are in-order: .a first */
>      	if (ctx.a == 42 && ctx.b == 42 && ctx.c == 7)
>      		asm volatile("r0 /= 0;":::"r0");    /* 4 */
>      	return 0;
>      }
>
The change LGTM. But the below description seems not very clear to me.

> Prior to this commit verifier built the following checkpoint tree for
> this example (notation: `(code point #) {<ctx->a>,<ctx->b>,<ctx->c>}`):
>
> - (0) {7P,7,7}

Why we have '7P' here?

>    - (3) {7P,7,7}

So here when (3) is hit, we have callback_depth  = 1, right?

>      - (0) {7P,7,42} (checkpoint #1):

So for below (3)/(2)/(1) we have callback_depth = 2, right?

>        - (3) {7P,7,42}
>          - (0) {7P,7,42}   -> to end
>        - (2) {7P,7,42}
>          - (0) {7P,42,42}  -> to end
>        - (1) {7P,7,42} (checkpoint #2)
>          - (0) {42P,7P,42} -> to end
>    - (2) {7P,7,7}

So now we back to callback_depth = 1.

>      - (0) {7P,42,7} safe (checkpoint #1)
>    - (1) {7,7,7} safe (checkpoint #2)
>
> Here checkpoint #2 has callback_depth of 1, meaning that it would
> never reach state {42,42,7}.

It would be good to specify which 'checkpoint #2' has callback_depth of 1.

> While the last branch of the tree has callback_depth of 0, and thus
> could yet explore the state {42,42,7} if not pruned prematurely.

which 'last branch'?

> This commit makes disallows such premature pruning.

It would be good if the commit message mentions what will change
for the above digram if this commit is applied, so people can understand
why this commit helps.

>
> [0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/
>
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   kernel/bpf/verifier.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddaf09db1175..df99fcdbaa05 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16715,6 +16715,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>   {
>   	int i;
>   
> +	if (old->callback_depth > cur->callback_depth)
> +		return false;
> +
>   	for (i = 0; i < MAX_BPF_REG; i++)
>   		if (!regsafe(env, &old->regs[i], &cur->regs[i],
>   			     &env->idmap_scratch, exact))

