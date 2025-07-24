Return-Path: <bpf+bounces-64247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6CB109A3
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 13:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C501CE17DD
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BFF2BE62E;
	Thu, 24 Jul 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CRZpcCTm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91132BE038
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358025; cv=none; b=GWRHIV4IiQFeHtTMOh83HohXLeC8n9o0td3L/XLlgLVI/khbgW7wNhizwIhgy1b2RhnCgHnOrV3Wsd1hhWH0sBk5jXVIWuGzjbY7su7CAe1XUtYOypF8G6kkiHzz9Ti087Egj26UqhvCtzID71X/cHsY6j0JZ7reTF9P51ADz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358025; c=relaxed/simple;
	bh=aH6Ar9GHWtsswV8u4kFF7shHo7PRvGwiNA17hs0hWKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4URPEait7/GkfeULRUdFRX2s4rY7qk389GvSAihnw0BawAYpKnH0S2UNdhgC8s2FTfnQPxSWJ5UEKtEdVXgKfUG59rt5TsFDSpz8LxHsAs8+2jbkzV/uQBjPXeQM0xw+QvyB8K3K7VSG44NCLDrS8+FvRPDm0L9JaN4JUggkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CRZpcCTm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so1607968a12.2
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753358022; x=1753962822; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aH6Ar9GHWtsswV8u4kFF7shHo7PRvGwiNA17hs0hWKE=;
        b=CRZpcCTmWp0aHJ4+3sD34EiTBymCffdONG+c53brTzRDwoSHrdS86Fu6Y8Ri+B8CWY
         dG1h7L+7MM92w+3haILE/JzO9NE+k6UwnZ2Wmynccg23Gk1+xrACwpFccyyZvnAIuXS5
         Up32Mwb0Q4uWB7i2E/Chpi2f0tbRCsaDwL8R6COfPdZScd7/FpU4pxJn7d6ttqE/uE2b
         x1pATkZrD2PGDFN0iK07cWhPa4dn2tXuJc62Osxj2LIlCbtyQBP1qBnHOFlIj61619i+
         X7/SKbhw4hkTCW+tB7id5coBhaD0MCxUL474XP0V++TAuHvTaOUguAVbAtGRzi0Bva42
         NmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358022; x=1753962822;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH6Ar9GHWtsswV8u4kFF7shHo7PRvGwiNA17hs0hWKE=;
        b=YAnjjIWEN6wusCcKaoAKdnPMobCk5vDa6XrPheEt1weDTnCyrB9NqwnxbxPmRyUI8i
         AiR3BJwZeJW/UPtni6vEXuhdri4REs3t7AB3JiV6MYs1Gfo8wmnPgMqhCFB4egW0glp+
         GMOiVuBi8RENomQ2ME5LIwycZRrlXpL7DuyVUVwp5ybtMuXCrPizuIjU7eqISHNm13VN
         Qn2IPspV/ZRgwRgUJGuWU28/EKC+vTYnAnbe4IsvnqUZ/xc+h9ofaiNt+vA0w6fh8/wT
         sxw+YTmXc69bZRLmInDE+yfbToc5DeHgUHl/P6SmPDbAZo7tpLoAC8PC3RU5f/ZBackb
         QbNg==
X-Gm-Message-State: AOJu0Ywu3+TjLB2Q0GFdWl2PalARkBYumgDciDwZZygJ6o+uYSSRWFK+
	W6trxEvmqJNl/uXf0I6EaKJvdxchYtDbEJujNuBx2hCYmI13ZPA/dl7wl5SzgfjlAiU=
X-Gm-Gg: ASbGncvHmxa+6/os1IOx4u24JiOddgOW1JMKB5tqNs+ju2YOExM2/FTwzJmF1e6iduU
	BXoUOt94IlllF2RlsiBPhgXncfmGatrv3AOuzGlUCzGo1rK7pq9twODzhT2OqIElpye6VRl0rk6
	B6krL4+PdvU2Q8wykWKkQU43MB7XUfiCvNxiop6HO6hOq2mnTKLu99+GGjRPMTNM7TxdpAY4qBY
	EFw0iEGOwEACJs8q9xzSGrPCL6mpgQRayy8/kmd1IUaBSAyrjZUyjKcqnqU9M0JZ+qAWjiZmtuo
	jQTmc5qwEsDZd+2e4jWp76MFxT66Lf12C2GlxPiMQCD1whwM55Mt/Gj+vuWwuakQHCUFPKqf9G/
	2z8EVytOMOo3g3+M=
X-Google-Smtp-Source: AGHT+IE17Bjl2cnReWZbrPPef0EzIcx/i/mQa82oS5HBV7CB/Znkd6ax1Jo0J7MnGxskvFX2IdGWtA==
X-Received: by 2002:a05:6402:26c6:b0:60e:b01:74c1 with SMTP id 4fb4d7f45d1cf-6149b5a6b3fmr5364767a12.31.1753358021862;
        Thu, 24 Jul 2025 04:53:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:5f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd0f64besm764185a12.16.2025.07.24.04.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:53:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,
  Daniel Borkmann <daniel@iogearbox.net>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Eric Dumazet <edumazet@google.com>,  Jesper Dangaard
 Brouer <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
In-Reply-To: <20250723173038.45cbaf01@kernel.org> (Jakub Kicinski's message of
	"Wed, 23 Jul 2025 17:30:38 -0700")
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
	<20250723173038.45cbaf01@kernel.org>
Date: Thu, 24 Jul 2025 13:53:40 +0200
Message-ID: <87tt31x0sb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23, 2025 at 05:30 PM -07, Jakub Kicinski wrote:
> On Wed, 23 Jul 2025 19:36:47 +0200 Jakub Sitnicki wrote:
>> Now that we can create a dynptr to skb metadata, make reads to the metadata
>> area possible with bpf_dynptr_read() or through a bpf_dynptr_slice(), and
>> make writes to the metadata area possible with bpf_dynptr_write() or
>> through a bpf_dynptr_slice_rdwr().
>
> What are the expectations around the writes? Presumably we could have
> two programs writing into the same metadata if the SKB is a clone, no?

In this series we maintain the status quo. Access metadata dynptr is
limited to TC BPF hook only, so we provide the same guarntees as the
existing __sk_buff->data_meta.

Current situation, as I understand it, is that while packet taps are not
an issue, you could probably do naughty things with 'tc action mirred'
and end up with concurrent writes.

Taking about the next step, once skb metadata is preserved past the TC
hook - here my impression from Netdev was that the least suprising thing
to do will be to copy-on-clone or copy-on-write (if we can pull it off).

