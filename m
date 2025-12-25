Return-Path: <bpf+bounces-77434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A6CDD92E
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 10:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD9E301356E
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE73161B1;
	Thu, 25 Dec 2025 09:17:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF55C17BEBF
	for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766654274; cv=none; b=I1Y9mMVaH+uW+feQKu85gC8vjZ9XaZlO/sxbzNy5+T01EBWTK2yCUzhcVG8qrS2FMlqYgctGYLhkUVUCp8RCXcSl2qhwKYoWqyYVdHk8LORoRg3ujzHK/DsNuRCH2qx6m/btUKMnFV5EqIDFYJxf/9EYU53ufr08sg0Yulf/6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766654274; c=relaxed/simple;
	bh=XzyAszPsEEzAGfFYYA9ANkEQadAhJos4/Kz6oJ/mG0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUOYkpK5jz/rC6ImS8gARpzE9aZNR3TF/0nlt2YJCilP72Y1srQWaTsSOu31b1FSRjxJLSYZkJ74vNxxxKfGwB+YyGSCkjKIgCo5eQMvUJAth6buRQ1hkWbIIcRmezF1rXC8RCOUJVgP5GNE1RIWWX8U+kn1KYeNG9zQKpXccQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.146.110])
	by mtasvr (Coremail) with SMTP id _____wBn9ZURAU1pKBVJAQ--.775S3;
	Thu, 25 Dec 2025 17:17:06 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.146.110])
	by mail-app2 (Coremail) with SMTP id zC_KCgCHoEQNAU1pv82sBA--.57027S2;
	Thu, 25 Dec 2025 17:17:01 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	shenghaoyuan0928@163.com,
	song@kernel.org,
	tangyazhou518@outlook.com,
	tangyazhou@zju.edu.cn,
	ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
Date: Thu, 25 Dec 2025 17:17:01 +0800
Message-ID: <20251225091701.1911903-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <db829499-1ad3-4d9f-8a89-6246938a45aa@linux.dev>
References: <db829499-1ad3-4d9f-8a89-6246938a45aa@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCHoEQNAU1pv82sBA--.57027S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhMLCmlMQgMzsgAAsx
X-CM-DELIVERINFO: =?B?5x9rvAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Dr9MYVIMdkv4rk87rhzASu3Ve6MbmPje8e4z3NFnj74RZLcPgfLhUIWcdxobQO6it2f
	/s7SWci5MPyhdGhWtGA5eE0qe+2D2/L2aOTGgXuDEn+dEztJga1jiHlT0kKvDQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7CryxWryUGFWDury8Gw48AFc_yoW8ZFy8pa
	ySg3W8urWDXF15Kw1v93yIk3Z5W395A3y7WryrCw1jk3WY9ry8ZFWFkw15WFn8G3WYgw12
	g3yYqry8Za4qyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

Hi Yonghong,

Thank you for the review.

> In my own experience, typical division (signed or unsigned) has remainder 0.
> For example, (ptr1 - ptr2)/sizeof(*ptr1).
> 
> Do you have other production examples which needs more complex div/sdiv
> handling in tnum and verifier? For example see:
>     https://lore.kernel.org/bpf/aRYSlGmmQM1kfF_b@mail.gmail.com/

You are absolutely right that pointer arithmetic is the most common use
case for division in BPF today.

To be honest, our primary motivation for this patch is not driven by a
specific real-world problem or use case. Instead, we want to improve the
completeness of the BPF verifier.

While analyzing the verifier's logic, we noticed that unlike other ALU
operations, BPF_DIV (and BPF_MOD) lacks precise value tracking. This
creates a gap where valid BPF code using standard ISA instructions might
be rejected simply because the verifier falls back to "unknown scalar"
too easily. We believe that closing this gap makes the verifier more robust
for future developers who might use division in non-pointer contexts.

That said, I fully agree with your concern regarding code complexity. To
address this, I am working on a v3 which will:

1. Simplify and refactor the logic to be cleaner and more readable.
2. Add detailed in-code comments and commit message examples to explain
   the tnum/interval derivation steps.
3. Fix the ALU32/64 mismatch issue reported by syzbot ci (which I have
   already root-caused).

I hope this helps explain the goal of the patch.

> > +/* Not well-formed Tnum, whose concrete value is empty set. */
> > +const struct tnum tnum_empty = { .value = -1, .mask = -1 };
> 
> Maybe tnum_empty renamed to tnum_poison? This will make it
> explicit that it is not well formed.

> > +static u64 __get_mask(u64 x)
> > +{
> > +	int width = 0;
> > +
> > +	if (x > 0)
> > +		width = 64 - __builtin_clzll(x);
> 
> Maybe 'width = fls64(x)'?

Agreed. I will do these 2 changes in the next version.

Thank you for the suggestions!

Best regards,

Yazhou


