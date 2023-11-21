Return-Path: <bpf+bounces-15471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE87F226F
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80199B217A7
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE715B6;
	Tue, 21 Nov 2023 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYvO1VGc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE9CD
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:42:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548f6f3cdc9so426152a12.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527377; x=1701132177; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+m785zn0Z1WV+YazKTrjT5PG7s/tHYuIN2lTfuI8a8=;
        b=hYvO1VGcW6QucibBIaNwd/eXWN9RtDp+A6z7T/7gpUbxfNE+xN4nbXTtnqHuyznp9e
         VlsYWDTzZTf0BtnadIsxFLymXiHHf9B3h+ihDht1l0VgZahuoSrH+DqqsMC+IQMUphds
         JlXSsjfwXkksV/K43u56ElB5OAN5vNIhT553Ia5fEv+uiolFs/NRiIr9UUnzg1e4Wn8J
         isbTzUFwbw9QNVPJwAshchkLLJIB6BqP9SXizKd9NDefpm8bmZxI8H2dxK2OyXjYpaoK
         Ozz/kooIGlrirOMuWMkiasBD1z+8Gtd7PI/SzjvnaxD5XcfDAmk3gLV0iqfdNn/b9dZk
         ewNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527377; x=1701132177;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+m785zn0Z1WV+YazKTrjT5PG7s/tHYuIN2lTfuI8a8=;
        b=MiR8vO+LtVVB9knFjVoSlcLeVknQ97biR8qv6D44BZ8IZXKELWlA2Nd6AWes4Z5bpp
         kOi1W3Z6yUhlN230ZRqcvK1UftNrYJdf2g/KtYp6NzWviyKFpYfI54ZLO22l7+bXjsO7
         9aTZ3kdF001QKP5u9zTdgl/2Bm2me5Z71468fS/j5I6nAFYvLS/PLh8167vnnV0qePlq
         Nbs5zM7O1aYFEYzcrnM/CIG7dTKM6jNnDxSf8VmlfOvwhKrkaPkSABEinD7K41zcd7JK
         keWfqyJFDs6pase3jlvJmukUd0a6yqHwQpMB8pIDSUjPqLmFeep43YZluMinLgZrt261
         fXdA==
X-Gm-Message-State: AOJu0YyYfHJPsVf3TuLYTmJW1EO5cvttQyDszedkdZ3uVy96B4YxSo7C
	sMKFagNwIgbOYltlN9CC8Fw=
X-Google-Smtp-Source: AGHT+IHWeOBTMcPmLXsOYePvTofOOK4dzrwiQoVyrsNWu+yqE1Yf1ARX1D39bWasYo/2Le9l+Hzcpw==
X-Received: by 2002:a17:906:256:b0:a00:3bc8:d481 with SMTP id 22-20020a170906025600b00a003bc8d481mr2256689ejl.16.1700527376954;
        Mon, 20 Nov 2023 16:42:56 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906c19800b009a1b857e3a5sm4510809ejz.54.2023.11.20.16.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:42:56 -0800 (PST)
Message-ID: <2ace40c9c5b8133956bcdefc1d8592dad640455c.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/10] selftests/bpf: add stack access
 precision test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 21 Nov 2023 02:42:55 +0200
In-Reply-To: <20231121002221.3687787-3-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
	 <20231121002221.3687787-3-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-20 at 16:22 -0800, Andrii Nakryiko wrote:
> Add a new selftests that validates precision tracking for stack access
> instruction, using both r10-based and non-r10-based accesses. For
> non-r10 ones we also make sure to have non-zero var_off to validate that
> final stack offset is tracked properly in instruction history
> information inside verifier.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

