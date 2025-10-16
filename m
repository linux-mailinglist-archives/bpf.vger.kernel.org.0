Return-Path: <bpf+bounces-71129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D447FBE4E84
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 19:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EC13B7C67
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7E207A38;
	Thu, 16 Oct 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLL4DEZo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FE33469A
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636611; cv=none; b=gtNUJkOe4Xsftqlq5rjknu3ZyaZzT6OW5f5cNkZFS0qqcma3hGsG8HS+D8u74zy8Arb3EXdf9wDERMtcfP18XfsOFzx8NybEkyqvMhoyQN5PtfHdevmWCTI7SbrG0/pnzMakRZZD7o1mUEgwwiJKQf3MHs+e4t7DAz2w7mbdlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636611; c=relaxed/simple;
	bh=yBBjQVRyGblUjJODwrzaNyhah7wFRahcUtCeq/hWuM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fi5xmIgr+Y2Nw4G8vm73qk+oleSLaI7oqBNokPYCJ8/bce2/tSvsFpe0jtVghFXmJQyuW8LyO1x3UTcZTdaG2qhkIY38HoIEiDyI3J4ceD9CDxtWk7jiNks6xJk3WX5Uv2g3JaN81Oh1YJMuvxomsKmUOB48O8AQXn8QwN/xQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLL4DEZo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b550a522a49so818866a12.2
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760636609; x=1761241409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omNt6d8G4KEFJy/lysclxxeLewMXvTfHJErLzzHnePM=;
        b=hLL4DEZonAIdP186lM9em9bV2Q6vnsdqFqARNZkQGoYdqLQXqRl1n7ccgAmIUDOUhH
         bNN1gzHRmHu3zHpD15Iwwv5t3J9l8jiTVbaCnGjIcl5EhsTSuL3mEix054IAQlLcFVHL
         u1hJM3C2Z8kAzNyZEl46VyV8pCuXXWA/GSovCD73oUcpR3PM75qaGowyMcRAqLNSmvNc
         KthXhqhxuzRzrOnG6OyD6EaFdD5p63a1UADSt3n3jDkOoy/kaVmalxasmhEqQHBqhURI
         Xe16lHretoKy1iso5hXe7l4IfkGO/55w8XNoDzkUE+/f/+dCoWzb98r7dDRZJ0QZ1aX1
         xGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760636609; x=1761241409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omNt6d8G4KEFJy/lysclxxeLewMXvTfHJErLzzHnePM=;
        b=lm6mJ34mkM+8ZFGz5t4qR5BTtOi4O0WJ/10qvNmlaUAvWXni11i/pJ8DyuPG0sd+2l
         a0O8633lbXLoMTLRc3uv58VNwkGVmd2J7HIwIDDYyHJZMvigtqo4oPmpgpfpOKrzYKKE
         0uo61V6mj+h0mOQpCZzX7yuuG/TjZlRujN2XJjVcxjK/8VDrCo2xGXKWAdsufNut1NIs
         vENRIIWf+zMduwGP7Atr5wsFsUfCzpswEyBfxFXyv9QI/ceUKfhRg8gSyuNk05wJZiCp
         Vx41TdNoUPc/70MaxJffHN1w14lK+gh4ASbvnqUt+XoU1M7QhLBgXKbxXrmPLwYFHqYk
         m4fg==
X-Forwarded-Encrypted: i=1; AJvYcCUatVLQurte+nS9O9WFF6LsG0d4+q43hsQeNPp5eKyp7p7PN5U5HKzyLLdjhnFxdEMcNS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOg22yUlH50D6eu/ZeqiRaCNkDGix734CWRvaYuHMg10KS6YLB
	aAvKJ8NEOsRbI4WXQcwqlqXyoQtWV4p0njsBVIp3pFd+z8RK1adDRb4/
X-Gm-Gg: ASbGncvGDQNi8kMcfanRaksXCPllk2Safe2I/uqEeNAKuTJQRnzZvek7Ubxpwb/9Jlg
	6JtHIq3NmTM5+APP8cTdGBafa7vxQ3nxK0j7PiH8ChCcZTJxuhLcqX91pBTY2PDSEZPOtJWGEEj
	ajk3A/Ba9pdju0LCjh2/WKUs6cos+ZhehUMapXDwBVvKCN3UgBydx5fDFrYWrzXKzvek9oGI7cc
	m7ir4tl5WoIbXVSLGoEsbg+Y3BmGns87hJEk9Wq6bi3fWEuavYN3WKVjV8Vot4c7oCdqiZZvasw
	V2Q5QvZgVR2inLOWAyjG+ydrxd69YuHI/ZGVyEIc5Y4Z7eQz6jewdR+DXm4xdnWSMBOmMfPkHbA
	L185s4as04p0Iq2pQwk/VD0wETgnRV+vwthjdfaU58CgvamCs16wBeabN0/ENx4vGhIfYJ9lHAq
	qMk2MlKjwdOlPmkxgXjEnFHs4GRbGfhOi4RiA=
X-Google-Smtp-Source: AGHT+IGE8LmA05+md2R/UN6tUvS8+B6jdz7Y5VdgdosEbxeqfOb/EMnNS2Gq5uXQSuTA+IxzhVS86g==
X-Received: by 2002:a05:6a20:914b:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-334a8534446mr1041614637.2.1760636609463;
        Thu, 16 Oct 2025 10:43:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe4f:64d:d8b0:33de? ([2620:10d:c090:500::5:b51f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09d6easm23099242b3a.51.2025.10.16.10.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:43:29 -0700 (PDT)
Message-ID: <69d2c22ed0cac19a2fc13d422597d781281e4625.camel@gmail.com>
Subject: Re: [PATCH bpf 1/1] bpf: liveness: Handle ERR_PTR from
 get_outer_instance() in propagate_to_outer_instance()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list	
 <linux-kernel@vger.kernel.org>
Date: Thu, 16 Oct 2025 10:43:27 -0700
In-Reply-To: <20251016101343.325924-2-shardulsb08@gmail.com>
References: <20251016101343.325924-1-shardulsb08@gmail.com>
	 <20251016101343.325924-2-shardulsb08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 15:43 +0530, Shardul Bankar wrote:
> propagate_to_outer_instance() calls get_outer_instance() and then uses th=
e
> returned pointer to reset/commit stack write marks. When get_outer_instan=
ce()
> fails (e.g., __lookup_instance() returns -ENOMEM), it may return an ERR_P=
TR.
> Without a check, the code dereferences this error pointer.
>=20
> Protect the call with IS_ERR() and propagate the error.
>=20
> Fixes: b3698c356ad9 ("bpf: callchain sensitive stack liveness tracking
> using CFG")
> Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches=
/bpf/pull/10006#issuecomment-3409419240)
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> ---

This was brought up already in [1].  This is not a bug as check before
propagate_to_outer_instance() call in update_instance() guarantees
that outer instance exists.

We can land this change to avoid confusion, but the fixes tag is
unnecessary.

[1] https://lore.kernel.org/bpf/8430f47f73d8d55a698e85341ece81955355c1fd.ca=
mel@gmail.com/


>  kernel/bpf/liveness.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 3c611aba7f52..ae31f9ee4994 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -522,6 +522,8 @@ static int propagate_to_outer_instance(struct bpf_ver=
ifier_env *env,
> =20
>  	this_subprog_start =3D callchain_subprog_start(callchain);
>  	outer_instance =3D get_outer_instance(env, instance);
> +	if (IS_ERR(outer_instance))
> +		return PTR_ERR(outer_instance);
>  	callsite =3D callchain->callsites[callchain->curframe - 1];
> =20
>  	reset_stack_write_marks(env, outer_instance, callsite);

