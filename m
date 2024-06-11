Return-Path: <bpf+bounces-31868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAE99043D0
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD911F25DC7
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2A7581F;
	Tue, 11 Jun 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCDEat96"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863A59167
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131175; cv=none; b=mfFDd+ltZIIOvaj1c90MZrxqjj5ZJ08gflPCv0ToqjNLCD0wPB8VDv1YXNnqVeM7QP3JyQwaJE/fFFfX1fNR3iBfoYLNZVNJ+RZfOsCWdRuxeXbcMRQjZN3M4aVhxPpNToAvEkYNsaYphHCkGH8nLPHCBmGR6q9KbMne9ioJjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131175; c=relaxed/simple;
	bh=ycit/Diz+dHL75YWV0F0x93Y3WYPZNf+D6KST+cL8yQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heQJ3RZpsgbeOhmHpPRGcSCRpgLuPPsgcjiIcGFKlr5QU9AfYb/xolt0Yj+6CO1Y/4cyriK7PVYZxlnYZ8Zq+9iWKUvaK4CeUTayE8Nb6YuXcCPCofb6y7/OYckPMIMKNVzYYRDRLccgMvzVxl+DF4KtR/5jdelWJ6gRjVPDEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCDEat96; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1048024a12.0
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718131174; x=1718735974; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+oqFcPvMYuMqnpG0dps0lCuqrV4MjZGIE6oq0Nio8QI=;
        b=aCDEat96aYA3mzuXgXl6CgEe9VvUgK8BqPGs7M9N/n+FnhArsYf2l4WWqPCg4hVGH6
         0i3KfxHsqPtqwP6bKFUZMCI5IC+SVYu7p++Y6jxVgfppU9h4D1lfp2NPDU83g1fpVvQP
         cBNr5YtLj2UejeSwbkg69vDrJzZipbC8FfXUflACBZqmQxph0OSK2aBQUc1ZkJeEnRGG
         asqYyX9yMDItW3GcWxLMBoePqtm/dV7cGt68FEbn+zFVPxD6jrRcbU22Ix2NRY4PUcOJ
         qJ3P2WYL9CxkAxggUmP8MsTB9/6ZpnOzfwMzlvNvcVxgeE7LmC2uQ+kCq4K/RZWjdGl/
         5NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131174; x=1718735974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+oqFcPvMYuMqnpG0dps0lCuqrV4MjZGIE6oq0Nio8QI=;
        b=psKJShjswT5rzH8M8ZMNw6oBMvIscIEJhZBPVskdec5pRD2UluR4hDV/uUrCOkUbMx
         0ahC3w6KbeZwLzarhFWRDRSGfmcgR7JjVCsq/qZXO0S78CT0+rajQjY/akZ3NPbWO7HM
         WUvm5uJh8XkgaFs61yxc03jcNY2OLdF3ENGuLbNSj1IzUQpDt/9qyrzqPtXf68XFTsPx
         ShOkAp8cB7e02rvtv2B9R4tFIz59AaQ0rEOqGz5JtemrtGlEhrMVjOFXb8gkldXJB5m7
         ktnnrJYh82TkOkF7TxPRrIbj4JW/PHfWn8ppzUtHVwK0GkM+iGovvwpJMDOeuVKS4VbN
         Cv2g==
X-Forwarded-Encrypted: i=1; AJvYcCUVwY6gQKWy+X4eVUeT3Mulq+uZLqX4fGZWkcb5Dri42DWmZu5I7+8ZHnWTUcjKDbU1eeqA/kYFoPQXrA2rU6PRk4OT
X-Gm-Message-State: AOJu0YxVpH662Jf0z1YEtPbePQqUELclpBS5k3b0V2BgzOrJG8w3aY3u
	f/mLb54AjbFhtXhZ2nQ7XbrpmNEUfXoLPTL2x4xQua9i/+OGfPxjhRWGNw==
X-Google-Smtp-Source: AGHT+IFJ6S+9MRkPI3l6u3iV+dfbnkoK8id2v+Rntbt1ksvY3y+SIAEssXMisnNihL7wBu4K7KVRGw==
X-Received: by 2002:a05:6a00:844:b0:705:9aac:ffb8 with SMTP id d2e1a72fcca58-7059aad0ad0mr5968208b3a.9.1718131173546;
        Tue, 11 Jun 2024 11:39:33 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm35666065ad.99.2024.06.11.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:39:33 -0700 (PDT)
Message-ID: <b22c50a1f73bdb88b728a1e5c1e3af143e8c92d5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Match tests against
 regular expres
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, Yonghong Song
	 <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jun 2024 11:39:28 -0700
In-Reply-To: <20240611174056.349620-3-cupertino.miranda@oracle.com>
References: <20240611174056.349620-1-cupertino.miranda@oracle.com>
	 <20240611174056.349620-3-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-11 at 18:40 +0100, Cupertino Miranda wrote:
> This patch changes a few tests to make use of reg
> would otherwise fail when compiled with GCC.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: jose.marchesi@oracle.com
> Cc: david.faust@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---

Looks good, but I think that changes for 'off' for three cases below
are not necessary.

[...]

> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/test=
ing/selftests/bpf/progs/rbtree_fail.c
> index 3fecf1c6dfe5..8399304eca72 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> @@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct bp=
f_rb_node *b)
>  }
> =20
>  SEC("?tc")
> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_rb=
_root")

This error message is reported in a single place in
verifier.c:__process_kf_arg_ptr_to_graph_root():

	if (check_reg_allocation_locked(env, reg)) {
		verbose(env, "bpf_spin_lock at off=3D%d must be held for %s\n",
			rec->spin_lock_off, head_type_name);
		return -EINVAL;
	}

Where `rec` is a description of the BTF type, `off` is an offset
inside the structure, why do you need to change it to regex?

>  long rbtree_api_nolock_add(void *ctx)
>  {
>  	struct node_data *n;
> @@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
>  }
> =20
>  SEC("?tc")
> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_rb=
_root")
>  long rbtree_api_nolock_remove(void *ctx)
>  {
>  	struct node_data *n;
> @@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
>  }
> =20
>  SEC("?tc")
> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_rb=
_root")
>  long rbtree_api_nolock_first(void *ctx)
>  {
>  	bpf_rbtree_first(&groot);

[...]

