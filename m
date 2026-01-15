Return-Path: <bpf+bounces-79132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BDD27D5C
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADC14300CAC0
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275473D1CB4;
	Thu, 15 Jan 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrzmBWe9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ACD3C1996
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503340; cv=none; b=f7I9LTl9VlPqRq+lR6lD/o+Ze5yKL/Np0rbHA8pfD2iHJBeeCjfJ/2wYv26JNu+x30+lwn8KpLyv8Emb4pCOT+UkFtqH3Nb/5miqgFp6sUK+5sZeHl/t/DCA83lLWV4cL37DTjR0F/wJxsgUKojv1D7Y6i0Hdzf1wTUSASmOgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503340; c=relaxed/simple;
	bh=2wyagbCuDb2DZN7p2UQJWptODEYb/g+9c9stx3410Oc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMha3G1VmlfZ6hHRHcx3Ao/lZTEdAHsClzueWYagtLDalgkiYApX+dn57RSg1DSbk9f7UC8RtMkmMIZW1nhmTWQdayMqpii3zhW8jgPR6YBRDYzMiBJnBVtcE2gxWYSUYdcHVjfiJQnkNfoaU5JCkraLwh64dwaW+2A9JBRN+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrzmBWe9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0ac29fca1so8955965ad.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503334; x=1769108134; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2wyagbCuDb2DZN7p2UQJWptODEYb/g+9c9stx3410Oc=;
        b=ZrzmBWe9sMgw/qGgf1D61W4pPasDjOMsczDDjeMSYSyIQa7CBkTeUCHU16rcQFVDnK
         lWsILxIDtQtYztEZEQdvRzCHJUo9vBSppD7hPCrFAjndTLLwp6j2kutgJ2RM5iwzpTBv
         6POlO3asttTfg30fbIF8w6pBb7y5Aka3VOCap8gqC7IJg+oMtiiv12/w9qk06qTuYghQ
         MlzY14lWHWm43PZxXxMbF07T8fVr7YlWGkmVtsBu9ylLqLC6Iz3LoZRh9p9a5lls9off
         TuDoPQpTg1UEJOxpoMzPs/Rzwd+UHi1Sxx6JaVNoIYQcPTjygvZRH3RfmQURnsKckxHp
         hAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503334; x=1769108134;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wyagbCuDb2DZN7p2UQJWptODEYb/g+9c9stx3410Oc=;
        b=rCXszirKYiJnuHqMuERuheNHbUnt/inGU8F5L2cpkZ98DCakzchVnIu/N4u1DywNdz
         GpVUZwUmXelBqu2nLhic9LVnW5BWMrXG5zUAHUbXeB2vXCZ/kGpRb3U0+f5rZx2nnSHT
         loFNOJvf6+GKC+GoqsONhUg2IDv9bxh6C/OGojls5qdTb/gtK//4G2bPC9zzfbTClcxZ
         pL8KCs+VhXJzpdeTMmp9qHFW764ZiafyK90UJt8/G84aGtExobv1iybcO9a2CpeTuf1W
         boJGw4eYN7c+opF23tTlebPWdZJOu5Y5u71kSRXKhCvZm92vOb9EKP/SfjavgWxVGzIq
         7iQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnNBGiRQMNF1+N+IWfoWDRRebO7hsJJ+Qua/qGiL8IUc7lqirVknal4DPMwjrespNXWWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+6P1pkf/aI1f0nR0rE5aFXNqbYSa3qgnwoTF6X7/uk0rmx24
	w34K2cZR9mMn9pXCY2OdQvH+Xz5LpIhYx/42A4xYehOID0zRoRtqjlHr
X-Gm-Gg: AY/fxX7dCuiEj88D00CsCHpW7LFQxV/cxP3TTHzIEmIZ4RpA8AASGUYL/7FehCcGQv/
	Mu5dLV7lr4sUcMNzbRrPjzvs70wXQ0JZIqXdZR/a2mNDn7qfkvtUnEIznlqHtEPJwv99KNcThDT
	j2/g4ezgDd/hVZzFJfmmYQRu7xKnBsjFINL1ePOZsZDAaFqUosnCZLWKz322b0jMbKjFZMjSbnu
	JagPyacraaWRgrE+falNLEn/m5RAHFg8HtEORHLkr7TIjiHXrfz5vwTaBCWgBjc4x6v52QQlNwn
	qlfdhRqOjdWsvUYObQNvn9Tl/WKGkN7mI28ZwyZPUYVFu6Jw1eSIOtrDFM2v8jkWD+Gz8Xx28n8
	/fU4e99R/yePzwMAJk9FvrXf5kjNW7m2Wcvzttcu1yHoYalvC1uVp+xefp+Ns8JU8WasbQ0/RYs
	3o34N0pQllJE9H3RNXXyp1LQIk8AB3gpymFQ/ar82B
X-Received: by 2002:a17:903:28d:b0:2a0:89b8:4686 with SMTP id d9443c01a7336-2a7176c6d4bmr4493395ad.46.1768503333829;
        Thu, 15 Jan 2026 10:55:33 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fb239sm376865ad.70.2026.01.15.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:55:33 -0800 (PST)
Message-ID: <7ffce4afdb0e859df7f0f87d170eda31b66a5b2b.camel@gmail.com>
Subject: Re: [PATCH] bpf/verifier: compress bpf_reg_state by using bitfields
From: Eduard Zingerman <eddyz87@gmail.com>
To: wujing <realwujing@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Date: Thu, 15 Jan 2026 10:55:30 -0800
In-Reply-To: <20260115152037.449362-1-realwujing@gmail.com>
References: <20260115152037.449362-1-realwujing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-15 at 23:20 +0800, wujing wrote:
> The struct bpf_reg_state is 112 bytes long on 64-bit architectures,
> with several fields that have limited ranges. In particular, the bool
> 'precise' at the end causes 7 bytes of padding.
>=20
> This patch packs 'frameno', 'subreg_def', and 'precise' into a single
> u32/s32 bitfield block:
> - frameno: 4 bits (sufficient for MAX_CALL_FRAMES=3D8)
> - subreg_def: 27 bits (sufficient for 1M insns limit)
> - precise: 1 bit
>=20
> This reduces the size of struct bpf_reg_state from 112 to 104 bytes,
> saving 8 bytes per register. This also reduces the size of
> struct bpf_stack_state. Overall, it reduces peak memory usage of the
> verifier for complex programs with millions of states.
>=20
> The patch also updates states_maybe_looping() to use a non-bitfield
> boundary for memcmp(), as offsetof() cannot be used on bitfields.
>=20
> Signed-off-by: wujing <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---

varistat collects verifier memory usage statistics.
Does this change has an impact on programs generated for
e.g. selftests and sched_ext?

In general, you posted 4 patches claiming performance improvements,
but non of them are supported by any measurements.

P.S.
Is this LLM-generated?

