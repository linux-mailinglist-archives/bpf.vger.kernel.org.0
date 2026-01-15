Return-Path: <bpf+bounces-79148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBD7D286FA
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B04523016CFE
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F5322B9E;
	Thu, 15 Jan 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIWnB0F+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4B2D9EEC
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768509367; cv=none; b=Itj/CqTr0yAICahRo5zgt+3SOGnCMvxgjqX71lHLCqgH6XS3/WwRg0Bxi9zhU2Ion4MxjtuHs86IM9V6fyN+2Gc7ug+5iiEfEwXqXbYCoqXQT+qFgqHbsDIwfT2wMyUrIDinhYYfypcFU7k2gEaRBxbN4rm5X+bpNSQ82Pd53NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768509367; c=relaxed/simple;
	bh=/zHe1NiH+CB6jspvR3U0E3fH4F1iosvN974W6nhFcvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugrvog5tOWMKozL8Ydh7MMfoHaUFSRZdFYcks3iPEJa9x/G2mTLjJ07YLkyMWMK4FBZx06qmWus8bIQP7nWDCqKjBMXHECIq2VUGNBuD8pEzTjTP9GD5ldSUg/zM4dV+NC6p0NOzH0H7NJla+pI8A6W6e4ER1LltMVBeypkslpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIWnB0F+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f5381d168so1221701b3a.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 12:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768509366; x=1769114166; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJcRRhOt4b0PRJq+/EF853UWo45Ejl2CeOM5aKFXoE4=;
        b=fIWnB0F+g3kgJ8JSUyGw1qArAmFafvoomNMM+ypyJcpBEH1Bjy8en1vyjbcfxgG7hI
         /F1R1n4U+q8WBkvcnQx2sJiwcW8mfVSNPuJ5IpoRDnHBwo1FGRvcBCwHmsF/mFo1wawx
         a8AST93kZBrWBSKj+NrRoU78515v0Nu6iMSRi38xCGcwcykD6bQCSl6/mKtx7HkDgftT
         6se4gafehGwP2FDecod7baCc8H/8zsW5tL9xo0bvq+8gb1glQpjX5+kRKjJ6wJ/nDu/y
         yq2pcODrYrWYFR4trQ9zeVGDdYC50fAHwl4qSgA5Jwv3W92OXAVjK7MF1sik44rxRNIG
         /XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768509366; x=1769114166;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJcRRhOt4b0PRJq+/EF853UWo45Ejl2CeOM5aKFXoE4=;
        b=OCH1uLDseEQJy3ioXsTlk9XV8Rh1GvltE5aAk1eCM9GEF/0EyYpYezjBjb9t3/5LRc
         3y9lmH0NzUsbPkCi5T6UMhJ9gb22XjYltPhaI9VE1xT9RZ1v/wnJjNt9sQUYLaEiWprl
         t011TP8Qfi8PekyVpiiwPqAaECM3okNd50wqzhy7xGWntZQum8ciNQQ4ji5yG5gjAe2l
         Ok1Sy1l2UtapBDiWr8HKHMoSyvwBpnFEK2S0kLNel4FGrGch+gykcz0b7V+Gn7EGFYbZ
         zijmRWgbODg9L7Q5GdUiiavJq1Tpz9xq68hcxZivQIZEHSwk6XAHQ02ZTRs+KjLzvme5
         zU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5aVyEVuowMuEHGIoUl77PnCRsAPPmLZRaNYvDsOu7v6t9TKcUeEgTy872jACYvjk2+sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOUa/dbLHyihyBKxD6rxoc9N4krGi6itRSARpEz+9WZwpdwyX
	8KoI95Gb2DlmVXyw/u4UZYgE7tFwTcIG0uRsa72WHFcTPP61SYg3kqCf
X-Gm-Gg: AY/fxX5UCesYtGmgZTRofl0PJJLUEX3BV+fFzv407EoCk9qFcf7QjaypjQvZxZoTajC
	CDZkC343fP8oNO5AcUk8HwW7hEQ8RXKRGKQG8ZUfOmC0NJzPfjsGzVuWusg5pPMhwABEej672Wl
	uhtFgr3VELFmGCTN3INzd6CN2C88c3P4eCBvaaJG12jWoS++1iDJ07MlkIMdgPlYvwRqGXo8nmJ
	AoET7w+SsDytmt58lRor3NUyJRm45rlC+5ITy3TX9dRcWuDfw7S+7+swk5YhWmpKxMSs7Jxxkn7
	aA77zCqLdEp1T+FntwHPRP3eYqiipHlm+x2TlwenBKd/j5KmUFzHTbxSsqltZTsGTYOaj//735V
	8tDJz57aW/C42KSV1oujOt4zyDRZiW0ZXd0tt1hAxPCvX/ZGXXcUOhU/364p6rCqql8hthEWPx3
	R6Fj6BPoYnE75sS17Kw/mGlO+WVH6dl/EUI1YITx3G
X-Received: by 2002:a05:6a21:6da6:b0:361:1cef:c39b with SMTP id adf61e73a8af0-38dfe76e2ffmr893133637.45.1768509365581;
        Thu, 15 Jan 2026 12:36:05 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf24dd20sm272655a12.14.2026.01.15.12.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 12:36:05 -0800 (PST)
Message-ID: <fe21bddcc1c46ecd18a28cf76db4de78c5ef314e.camel@gmail.com>
Subject: Re: [PATCH] bpf/verifier: optimize ID mapping reset in states_equal
From: Eduard Zingerman <eddyz87@gmail.com>
To: wujing <realwujing@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Date: Thu, 15 Jan 2026 12:36:02 -0800
In-Reply-To: <20260115144946.439069-1-realwujing@gmail.com>
References: <20260115144946.439069-1-realwujing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-15 at 22:49 +0800, wujing wrote:
> The verifier uses an ID mapping table (struct bpf_idmap) during state
> equivalence checks. Currently, reset_idmap_scratch performs a full memset
> on the entire map in every call.
>=20
> The table size is exactly 4800 bytes (approx. 4.7KB), calculated as:
> - MAX_BPF_REG =3D 11
> - MAX_BPF_STACK =3D 512
> - BPF_REG_SIZE =3D 8
> - MAX_CALL_FRAMES =3D 8
> - BPF_ID_MAP_SIZE =3D (11 + 512 / 8) * 8 =3D 600 entries
> - Each entry (struct bpf_id_pair) is 8 bytes (two u32 fields)
> - Total size =3D 600 * 8 =3D 4800 bytes
>=20
> For complex programs with many pruning points, this constant large memset
> introduces significant CPU overhead and cache pressure, especially when
> only a few IDs are actually used.
>=20
> This patch optimizes the reset logic by:
> 1. Adding 'map_cnt' to bpf_idmap to track used slots.
> 2. Updating 'map_cnt' in check_ids to record the high-water mark.
> 3. Making reset_idmap_scratch perform a partial memset based on 'map_cnt'=
.
>=20
> This improves pruning performance and reduces redundant memory writes.
>=20
> Signed-off-by: wujing <realwujing@gmail.com>
                 ^^^^^^
		 Please use your full name.
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---

I think this is an ok change.
Could you please collect some stats using 'perf stat' for some big selftest=
?

>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/verifier.c        | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 130bcbd66f60..562f7e63be29 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -692,6 +692,7 @@ struct bpf_id_pair {
> =20
>  struct bpf_idmap {
>  	u32 tmp_id_gen;
> +	u32 map_cnt;
>  	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
>  };
> =20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 37ce3990c9ad..6220dde41107 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18954,6 +18954,7 @@ static bool check_ids(u32 old_id, u32 cur_id, str=
uct bpf_idmap *idmap)
>  			/* Reached an empty slot; haven't seen this id before */
>  			map[i].old =3D old_id;
>  			map[i].cur =3D cur_id;
> +			idmap->map_cnt =3D i + 1;
>  			return true;
>  		}
>  		if (map[i].old =3D=3D old_id)
> @@ -19471,8 +19472,13 @@ static bool func_states_equal(struct bpf_verifie=
r_env *env, struct bpf_func_stat
> =20
>  static void reset_idmap_scratch(struct bpf_verifier_env *env)
>  {
> -	env->idmap_scratch.tmp_id_gen =3D env->id_gen;
> -	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
> +	struct bpf_idmap *idmap =3D &env->idmap_scratch;
> +
> +	idmap->tmp_id_gen =3D env->id_gen;
> +	if (idmap->map_cnt) {

Nit: this condition is not really necessary.

> +		memset(idmap->map, 0, idmap->map_cnt * sizeof(struct bpf_id_pair));
> +		idmap->map_cnt =3D 0;
> +	}
>  }
> =20
>  static bool states_equal(struct bpf_verifier_env *env,

