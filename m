Return-Path: <bpf+bounces-60632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C73AD9744
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 23:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E122416DB32
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49028D83C;
	Fri, 13 Jun 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFpp8ztW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFB28D822;
	Fri, 13 Jun 2025 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749849471; cv=none; b=TH1Z0qbF41IrTQY5jeYDx8/cOMOMXPBjDfvVwF51MosZYxKxU88cuHRNV1UYQXSWtBznuPBAF8c1/EfWS0AhMkQKA2yxHUiKNu4KzsNA5xCweG0HZn79e6IFClQBsCV9wZXPa2X6O/2PV1b/nN8w5k5a+WdB1rKC8dntIFxkNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749849471; c=relaxed/simple;
	bh=DCwPo7sO42t9J/l6c/zn2MAqLyfHwsxggzouM3HwKfs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBrVQfN6ywJ20HlnXo0oXfZmoE81NM2RXc9qfs4JKZjc9LyqB8fKX6az37t6ccOM8n1nfyHr+EpCIXBXajj9H8FH1tcDr76Z40nFYAo/A0fqxxZrmsSE3DhRfYnja2QIE/ixGCB3bZVAXVeioQn2Z3HU6rjtlrD8DbK+4C6Vv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFpp8ztW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2f603b0f0dso2447492a12.1;
        Fri, 13 Jun 2025 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749849469; x=1750454269; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsmXxUey0UIvIESNOBWD1muaRGeOJVYTb8fEmVCmw0s=;
        b=hFpp8ztWHXk+iwv6H+UsiOPZRWeLOkFRfNxzoFF4VetdQb4lRZ4Bw486OqYPDKYK4u
         GGTfwUNOg4XOeKmlLpX/KQiQR8ePIqrF18NbF3s7gkY62GLHFK9K7+Qbi6PHZCmEIWMw
         wmcG16g3BSOQ6J7XGmeY2q4jPsbL3bSdtEZPLyrRtghUb4nwgipSdWZJm+7kAvSVQl1l
         dwOWb+IUJN9/QZRlEHQBafY0eWkeX+V6+AzHHu9C1ewoHQ0HFkhbNdhqRGUdm0QJrb+W
         jH0MsBzFrq/9CYo7Un9FMTGPIdz3dmiM8zMDCOTUXYgkEGF0bQW1QPvUxvX5DhnzsYzY
         u/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749849469; x=1750454269;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wsmXxUey0UIvIESNOBWD1muaRGeOJVYTb8fEmVCmw0s=;
        b=b4oAmNl7WnqH5pSuxuOTyeEfep7gLeOPm6UOVDQSis2FIbwiH3/oLY8anvvP1m8KuL
         GvklJl3yybK3fgcA+lYvFRhu3+t++CJVJaCl+unZFd6MiAP5suPOYfxfvAxYpxqoBjFZ
         XHZgnLfv4ZRkrhRChDv1ltMr4c0rPPi6N7N4CEXV2ZgD+8vdpbU+Sh/Feq8D8Qqg4/aa
         o3UAW7pDWPADK0q/075vnt97RhBkpdEbKwyZWmNb7K/a4mloX41LVp8FiQaW4/eyB2MF
         dNAoiAs8zB+Vk8N+KVvUfSWk07RQPbLlTyk8sG8NV/7AnOkUEoAWxr8KrSETmjsm5ylA
         DYfg==
X-Forwarded-Encrypted: i=1; AJvYcCVgsYfF2WS4fMGJB+r8i0xoeEEdlMk2+dkV73aNZXzVa9qHJ0I4HfcHJrRkoEqBH0IBsJI=@vger.kernel.org, AJvYcCWWvrpkjaqarWS2r/OKxdrZu2fQO9U0nLA99Ftz5ajQAcHuA0AS/+B6xLy3SrN4d4I5yrwyr+mhN2al3Tnw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8PAu+IlaMVRUA7Yq0EtxS4lhkd8/vWelpmH9phsGSgdkICVuE
	rDIN2fa9Wv1wArlJSx41mK47WsnowznvlzSJqC429BijmeZHUH32Quzf
X-Gm-Gg: ASbGncuXtw+0OXBSH2nEsLNtzLsh1wzy4FWpIQ6v2COG/SeQ/ydCs8KQ+RGW8W35BZN
	qP+nBGR8H3hUSX+arCTw+Xgg6K1+keBGwCv8RZOm5FBQFao9UABWMFptvjcSJVhfGYaLqtIqjZv
	KXbm1T8879c/1ftEd2iToqAvFgdojCqGm3JVRNq2Mw2uCrEwmwRrC9R76xOQRc9UvrfEu7jpHLp
	fqeU7jlhPVxwzLpIncThQ1sHKFchLCKYYQe+hHWaCMJ7/3jHUR+YzaVM9KAGGmK5aCN8vrGHEek
	tvSOSALgWpgNCCEdEFzcz0XlstBi6Mi+CXFLlqxoI1YL6pVSAI94R0f7eRs=
X-Google-Smtp-Source: AGHT+IHTHbvCObYgkN/Yplj/d78ceR1ET3UUZfE+bp9ULGsJLHOVCdFDbei2f0z180uu1WfLAlrhcQ==
X-Received: by 2002:a05:6a21:4612:b0:1fd:f55f:881e with SMTP id adf61e73a8af0-21fbd68e2e7mr1282934637.36.1749849468775;
        Fri, 13 Jun 2025 14:17:48 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecce6sm2200632b3a.10.2025.06.13.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:17:48 -0700 (PDT)
Message-ID: <a4fbe41d6f4c25c3d1edd42905eb556541857327.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Remove redundant
 free_verifier_state()/pop_stack()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 13 Jun 2025 14:17:46 -0700
In-Reply-To: <20250613090157.568349-2-luis.gerhorst@fau.de>
References: <19f50af28e3a90cbd24b2325da8025e47f221739.camel@gmail.com>
	 <20250613090157.568349-2-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 11:01 +0200, Luis Gerhorst wrote:
> This patch removes duplicated code.
>=20
> Eduard points out [1]:
>=20
>     Same cleanup cycles are done in push_stack() and push_async_cb(),
>     both functions are only reachable from do_check_common() via
>     do_check() -> do_check_insn().
>=20
>     Hence, I think that cur state should not be freed in push_*()
>     functions and pop_stack() loop there is not needed.
>=20
> This would also fix the 'symptom' for [2], but the issue also has a
> simpler fix which was sent separately. This fix also makes sure the
> push_*() callers always return an error for which
> error_recoverable_with_nospec(err) is false. This is required because
> otherwise we try to recover and access the stale `state`.
>=20
> Moving free_verifier_state() and pop_stack(..., pop_log=3Dfalse) to happe=
n
> after the bpf_vlog_reset() call in do_check_common() is fine because the
> pop_stack() call that is moved does not call bpf_vlog_reset() with the
> pop_log=3Dfalse parameter.
>=20
> [1] https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69a.=
camel@gmail.com/
> [2] https://lore.kernel.org/all/68497853.050a0220.33aa0e.036a.GAE@google.=
com/
>=20
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Link: https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69=
a.camel@gmail.com/
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> ---

Tried v2, all looks good.

[...]

> @@ -22934,6 +22922,11 @@ static void free_states(struct bpf_verifier_env =
*env)
>  	struct bpf_scc_info *info;
>  	int i, j;
> =20
> +	WARN_ON_ONCE(!env->cur_state);

Tbh I woudn't do this a warning, just an 'if (env->cur_state) ...',
but that's immaterial. Given current way do_check_common() is written
env->cur_state !=3D NULL at this point, so the patch is safe to land.

> +	free_verifier_state(env->cur_state, true);
> +	env->cur_state =3D NULL;
> +	while (!pop_stack(env, NULL, NULL, false));
> +
>  	list_for_each_safe(pos, tmp, &env->free_list) {
>  		sl =3D container_of(pos, struct bpf_verifier_state_list, node);
>  		free_verifier_state(&sl->state, false);

