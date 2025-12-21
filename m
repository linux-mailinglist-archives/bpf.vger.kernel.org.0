Return-Path: <bpf+bounces-77268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E244CD3E60
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 11:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8CBA30010F3
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3892868A7;
	Sun, 21 Dec 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt7c31X0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA027FD54
	for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766311678; cv=none; b=Qu7duczq6vV2hRvu+RQrYPsLccSq8t+Te1zCc6UCc1IiatVRN3lAIGlqSdDIGRAcryOgPeBYP/v4HNpz1B0Ke4ZCwQBewpARVW8h3yTJIaekGOYZYipBCFWKcJ4LAugL3StojBwQBM2h4I0a4Lm8ymXEFYwH6vV/p2Gfcnwiuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766311678; c=relaxed/simple;
	bh=2pXdYG6w5DgZ6NbJ/cvkCCnmAx3yqRkhFtkUSXP0PQg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TA25VWPNyNq0U6Na2DDDGaK1OxuAivuOOxQ9GMqR1cZxWabha/x8Q0pmnb58FjhATFMUX5yKQGQCi5hfChc38HTfHDA+Q7s0olM/YFVC8nXaeqjijOhFeiHNpI1qrcUbBGNOxk9FPrNwjwnVHNYJUz+Nauw01TezfwWrM5jINgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt7c31X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D6CC4CEFB;
	Sun, 21 Dec 2025 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766311677;
	bh=2pXdYG6w5DgZ6NbJ/cvkCCnmAx3yqRkhFtkUSXP0PQg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Yt7c31X0wZX27mUS12pEQVMcXYuM8pPuVAmIhrWCDuto4AZrH5mkf1kfdxBBIyWiK
	 6Jon5ilFdjJRvSx8hHwB6QjAw1fD2nGnPHl/0aNa5lSf5wEQhKyIeFm/BJfPsvGgZ+
	 394z5lpCsUtQsCemZFrSXGCqoi2Fxodk7rycZHuDK6Zgh/YAOJtOJtzGCGPQMAsmi/
	 HbJxq5R8ftWu/BH8L4JUtHBqB1nwAwvYeyzc4/7afyU8WENeSIxTADKDe6ySWZisE8
	 ruUCHseKopGJqzHjBHlQou6hQewS0nvPB1jxVrXuhKc7PPmkjN0NZHTrGSr3ebLMB/
	 Sp/+53jbWA0hg==
Content-Type: multipart/mixed; boundary="===============1392216173478546896=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <46a0e941f1c3ebdbe2430df45568baad54eec29e6a9141d47c4881fdf674378e@mail.kernel.org>
In-Reply-To: <tencent_7C98FAECA40C98489ACF4515CE346F031509@qq.com>
References: <tencent_7C98FAECA40C98489ACF4515CE346F031509@qq.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
From: bot+bpf-ci@kernel.org
To: yazhoutang@foxmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 21 Dec 2025 10:07:57 +0000 (UTC)

--===============1392216173478546896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index f8e70e9c3998..d115528da6a6 100644

[ ... ]

> +/* __tnum_neg_width: tnum negation with given bit width.
> + * @a: the tnum to be negated.
> + * @width: the bit width to perform negation, 32 or 64.
> + */
> +static struct tnum __tnum_neg_width(struct tnum a, int width)
> +{
> +	if (width == 32)
> +		return tnum_sub(TNUM(U32_MAX, 0), a);
                                ^^^^^^^

For 32-bit negation, is subtracting from U32_MAX correct? This computes
the bitwise NOT (~a) rather than arithmetic negation (-a).

For example, for a = -10 (0xFFFFFFF6 in 32-bit):
  U32_MAX - 0xFFFFFFF6 = 9, but |-10| = 10

The 64-bit case correctly uses tnum_sub(TNUM(0, 0), a) for negation.
Should the 32-bit case also subtract from zero (with appropriate 32-bit
masking)?

This function is called by __tnum_abs() which is used by tnum_sdiv() for
32-bit signed division, so incorrect absolute values would lead to
incorrect tnum results.

> +	else if (width == 64)
> +		return tnum_sub(TNUM(0, 0), a);
> +	else
> +		return tnum_unknown;
> +}

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d6b8a77fbe3b..df04a35153ef 100644

[ ... ]

> +static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
> +				struct bpf_reg_state *src_reg)
> +{
> +	u32 *dst_smin = &dst_reg->s32_min_value;
> +	u32 *dst_smax = &dst_reg->s32_max_value;
> +	u32 smin_val = src_reg->s32_min_value;
> +	u32 smax_val = src_reg->s32_max_value;
        ^^^

Should these be s32 rather than u32? The fields s32_min_value and
s32_max_value are declared as s32 in struct bpf_reg_state.

Using u32 causes the signed comparisons below to behave incorrectly:

> +	if (smin_val <= 0 && smax_val >= 0) {
            ^^^^^^^^^^^^

When s32_min_value contains a negative value like -10 (stored as
0xFFFFFFF6), reading it as u32 gives 4294967286, and the comparison
"smin_val <= 0" becomes "4294967286 <= 0" which is always false.

Similarly:

> +		if (smin_val < 0) {
                    ^^^^^^^^^^^^

This condition can never be true when smin_val is u32.

The 64-bit version scalar_min_max_sdiv() correctly uses s64 types.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20408116978

--===============1392216173478546896==--

