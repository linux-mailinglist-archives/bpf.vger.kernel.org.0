Return-Path: <bpf+bounces-22807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231D886A1EE
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A435B25C75
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D7914F995;
	Tue, 27 Feb 2024 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLYI55Wj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2F2D60B
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070569; cv=none; b=o89ZDE2+c6g+X8OVZmCJ6KKQ43cuJTNjErwA9C/7/CIFGiGEZAOyEmJ7HRtwBl3X+A9x/icEYzynQf0vscR20icoCuxLxEdLJcZgjeOJ3anxCo6JN+5PZ4DeTMT+pirij9xUrezUq1zkgLPuwi2RTXGM1E52OesUz5rzSdz7bGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070569; c=relaxed/simple;
	bh=E1ro+e7zRUR0vOnXSDhkZ7oq5QOHYndUZlyfCBZ31XM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqHFnIWxQuRNrjeVlFzXa5NTH9MvqNYbGrFswxmI9gCMvI16vnoC2xqosrjkTvbsnZ5/4APOGOtxpTaJrnta+Vtncnmdi6xinsrWbFdjiuDJmIzRg0wqwIEZ7dGwz4dTo4ABAKmty4NZ6e9UYUXGILy5wXxViEbWtw84Sk/LMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLYI55Wj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so5187399a12.0
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 13:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709070566; x=1709675366; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gG/c4Dh76shYbich5hnZPYZHToY14uQNBdPOZQCxgSg=;
        b=eLYI55WjeHo+KKRobWSgQjiwNUrKyZJguG5vwsnj8yQ2upYJ/3xZTX3TPSMFOQcane
         QabF95ttbC9O1j1/SYBcoEg2aRjO3Hvi2wI8Ii9qhXUfBr/ZYgniIz3eiMtJTBLXJ+l+
         083GV23hGobpAW1RFJaTf60TVKJWThtlP/VLEX+t69WYiPOj7L5MvKK6dqDIWn96x7rm
         NHjgFWxRSDIJpXHMZa1J8CKD+OglONHYQdnJiXlrcshJ8Nukm6CTWiX2K1zqaBj2doIx
         Pht4AE9HDySPxJhkEoL64dzMNeIzIKrWK4aGywYEjwD5OOaNb5Ck59hdRbqClfYcf+gp
         jMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709070566; x=1709675366;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gG/c4Dh76shYbich5hnZPYZHToY14uQNBdPOZQCxgSg=;
        b=kzhyKJxpUVvT/pOlQEgvTOvX0pH/oItHskcUouK4HTgqyyvTIdTwGoXDAJt/1B4MuA
         JJXkVpC0nmE68iCQWNBWiqcYzF+30kBsmkZUAIYn5TYxFdI1S2HMxk9xsGPZcbhkgyiP
         dtZap4v1lx4/idEHgYZxjINfHqi7/4b6ibro2rpcafhI+fj/OdQXMBi/BzaC/0vfM9Mc
         wORqal6Cayr8giLQQPi4GgMi3Isu/c6v5LCfL+n1tEhGgjm1IZL0AznhqFaoAet0iALH
         7zytiqd86ttnzGCzoXg2V9nOCUjj3J0YB6uf4NT0ZrYo0RTQLW0MoenKtoetwhe0+F2f
         r3lA==
X-Forwarded-Encrypted: i=1; AJvYcCXNcGaKM4wL+YLxl3/IqYG1AovL4jVxbJvPCF40aR5ezyzg+TxbtZ4EH1+eXrw9faE06n7KaxnHA4sSXf5jk5DG/acW
X-Gm-Message-State: AOJu0YwN4xMxnGLhK056UWsP150XU++MEqCsX3G8VcR8eDYuggfYXtl4
	q1Vb5E5kDuQNV9A0aIxA4bfu9fHSjH7DrWIcMLHGqoMpDwKkLeDz
X-Google-Smtp-Source: AGHT+IELwZNhdCvL8Y7GXTKLETnqAKGlZLxCKHli/qhB3tzKKVxE3Fj4kdGKDbP9zeWkvyooX4L0sQ==
X-Received: by 2002:aa7:d417:0:b0:566:5eb1:868d with SMTP id z23-20020aa7d417000000b005665eb1868dmr425920edq.21.1709070565461;
        Tue, 27 Feb 2024 13:49:25 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m23-20020aa7c497000000b00564e489ce9asm1131264edq.12.2024.02.27.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:49:24 -0800 (PST)
Message-ID: <9c7c56c9bb0da7878339a2eb4ea3d17b008ac003.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] libbpf: allow version suffixes
 (___smth) for struct_ops types
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
Date: Tue, 27 Feb 2024 23:49:18 +0200
In-Reply-To: <fdac1d86-9e30-46b3-a1b7-5878dd49b1b8@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-2-eddyz87@gmail.com>
	 <fdac1d86-9e30-46b3-a1b7-5878dd49b1b8@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 13:47 -0800, Kui-Feng Lee wrote:
[...]

> > @@ -997,7 +1004,8 @@ find_struct_ops_kern_types(struct bpf_object *obj,=
 const char *tname,
> >   	if (i =3D=3D btf_vlen(kern_vtype)) {
> >   		pr_warn("struct_ops init_kern: struct %s data is not found in struc=
t %s%s\n",
> >   			tname, STRUCT_OPS_VALUE_PREFIX, tname);
> > -		return -EINVAL;
> > +		err =3D -EINVAL;
> > +		goto err_out;
> >   	}
> >  =20
> >   	*type =3D kern_type;
> > @@ -1007,6 +1015,10 @@ find_struct_ops_kern_types(struct bpf_object *ob=
j, const char *tname,
> >   	*data_member =3D kern_data_member;
>=20
> Where is going to free tname when it successes?

My bad, thank you for spotting this.

> >  =20
> >   	return 0;
> > +
> > +err_out:
> > +	free(tname);
> > +	return err;
> >   }
> >  =20
> >   static bool bpf_map__is_struct_ops(const struct bpf_map *map)


