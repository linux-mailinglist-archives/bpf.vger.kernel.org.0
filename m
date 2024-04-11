Return-Path: <bpf+bounces-26588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F018A21AC
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 00:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C431C209DA
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 22:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA56405EB;
	Thu, 11 Apr 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwPprsiw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A99383AA
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873674; cv=none; b=sGmPkLlgX7m+3GDpvaq9pMHYlfpkLE3CwfdBVKj5WuRpEictV0a4IadzukyLwOzyoTDNw34x8nuoNELeRUFuvTfp934GM9QzA2hvwD0J/y0Y+g2VLGNy6AzjuwEuvyiMGWSOsXuD2IaPmnufghkf7xWqDILieSC076NlKKymbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873674; c=relaxed/simple;
	bh=qZCHruiH4UEQJ9dPkFgcwPdRgGNeGc+3wuxBfM7MRoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g2RrfShubA0YSVJsl6CFL7zoFBkQTy7U3lLAAirQRrv6VUUizvKUu3IMii1gfVcRtRID66S57U5aeaUqVx2d7ShrM1FZO+QXICHz8/Z+Tc+sQ674+bIDnDkRBawWv3JVAGTrOH0ClNI01pWJtufYSVFMgKHCgJQZYh2mcE3BLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwPprsiw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso268178a12.0
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712873671; x=1713478471; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zJVJgvg58Q7Ht0TRQtgs7+sWP1xuNLLgLeEr1TjeO8=;
        b=gwPprsiw/skUPzk2YX8Q9RTcWx3tCcUrM002dBy1WcWI3+8iPmBqV36BxuMA4HN9iQ
         n3LombCtasf49/mrkNABTr5QYf9FEE46k5phZ1D+Sn5zdeHiA176QtiG2RFsu4LqNPT4
         zrcTJwJXUKUfXSe0sqnMaQtbGlt6hWct0ygjH8OvJ1W6Eu4URZSl0mfaBgRQqEnzR4nr
         6qwFP4Gk87gwca3d/4SVkchkfHhYihuSG/57Ie+hZUteFCA2BeRvpoJsc/emQgX8UW00
         4YJK3wWnLmnenciMyZnWj49IdT52GiLl20ZBvtReD6h296nXHkNg+23k+pEnGAUbGQeE
         8yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873671; x=1713478471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zJVJgvg58Q7Ht0TRQtgs7+sWP1xuNLLgLeEr1TjeO8=;
        b=A9ijttkwVgxmKFWJ+68V6OuaVZWDXOt392DYDLGSi55L8j3zloH8FQEngd+langcdC
         DiTLc/U43EpdAB62HSaqy76c5qwSD/mzH12aCuozJWQP/IrJrEq8pfjGA1HZfUFWtcNL
         fKaZG0/6096pZjNBb5SOlu8l7N+5OJO6BbqStBbJqwvm82tqtsxkh35IyDLolk56zIIO
         uJuBHgrtNEzAjYgCeaIeoUbGSl8Jj1qIzoP+QI/fYgRsOGn3C6K2fNMQ0QGJJhxRLveH
         R+br93FGuJz6Z5t1HRYT3wd3+6U/RAaMaf88ktF/dhtU+ndvCTBEI78enp+sxGjIXygq
         RXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0chnqAj0N88wB71hzqLsXS4Sws4w+8QSI+saCTgEi6+JGNJ6vGuKlTQ55r+qZta4F7tPQekfLBV1lcnSRHILe+Sxi
X-Gm-Message-State: AOJu0Yx2HXE3hVEPtt8O3rgnhkd9YeAt/YRubzzkCso5eWOIs3o7ORR6
	Rl2Gae6xZ3gAaD212u+K1CGt5hwG4lz1zF02C7hrtl5CgQMNpVwU
X-Google-Smtp-Source: AGHT+IHJ5pdrWKm03q9g7nQMUE2SvBHZCvhfO6CEobDhzeUiUj+4hcNxnEnJux+k/4Mx/0fyOzDsHA==
X-Received: by 2002:a17:906:a87:b0:a51:9d99:78ae with SMTP id y7-20020a1709060a8700b00a519d9978aemr478628ejf.67.1712873671496;
        Thu, 11 Apr 2024 15:14:31 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906338900b00a51d45b289dsm1135489eja.81.2024.04.11.15.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 15:14:31 -0700 (PDT)
Message-ID: <c89a020a219dd2d6e781dce9986d46cbafd6499c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 07/11] bpf: check_map_access() with the
 knowledge of arrays.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Fri, 12 Apr 2024 01:14:29 +0300
In-Reply-To: <20240410004150.2917641-8-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-8-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
[...]

> Any access to elements other than the first one would be rejected.

I'm not sure this is true, could you please point me to a specific
check in the code that enforces access to go to the first element?
The check added in this patch only enforces correct alignment with
array element start.

Other than this, the patch looks good to me.

[...]

> @@ -5448,7 +5448,10 @@ static int check_map_access(struct bpf_verifier_en=
v *env, u32 regno,
>  					verbose(env, "kptr access cannot have variable offset\n");
>  					return -EACCES;
>  				}
> -				if (p !=3D off + reg->var_off.value) {
> +				var_p =3D off + reg->var_off.value;
> +				elem_size =3D field->size / field->nelems;
> +				if (var_p < p || var_p >=3D p + field->size ||
> +				    (var_p - p) % elem_size) {
>  					verbose(env, "kptr access misaligned expected=3D%u off=3D%llu\n",
>  						p, off + reg->var_off.value);
>  					return -EACCES;



