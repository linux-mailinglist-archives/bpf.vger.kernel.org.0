Return-Path: <bpf+bounces-17720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F6B81201A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 21:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B61C20CB1
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3415D4AA;
	Wed, 13 Dec 2023 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4Bp7/vR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A381E9C
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 12:39:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c580ba223so18432445e9.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702499943; x=1703104743; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ikKwWPzVliFIlEl0tkcF5e3oCHTfD+1AWpzSBon1MRs=;
        b=B4Bp7/vRmqcrULtZHvxOam0KsYF4WLX4nUgcrO5tCkP2Mawbm1NMpZuA/6HMgnjZdP
         MzHHzet8Lt//rK+PcVBfqgrDNwia1N58AUXIMdD+6r2ZTGRJS98p0/bwuw+rLrvN0p3L
         i6zM5IUdckchOy4Bn1Qnv1G8D6WcCBvZiZ2BUUuaV9ugUJpGF+df5NkWTHLPymbPBAVT
         fP+tvVMpxgbn7TQg3nsODp9MPll1qwtvfJImmTbfRV6H7rU+5Ad2NCF10UUgKRn+Ng9K
         wIOvWTG7RB+/P2REx76SZ1vxCeo3HL8zA18V6VQW0XYWI9Ae3F/H/UPFqRlMHgM9JxE2
         C7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499943; x=1703104743;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikKwWPzVliFIlEl0tkcF5e3oCHTfD+1AWpzSBon1MRs=;
        b=uijpDTtBHBnvZYYUcVC20ZmZuDKYEXleIdC16u5OaX7MtZ3Zhl2sd/qtibNiRg4sPb
         7lX+rqpNMamSFHwOKyk1U7XHUxYV79dBz4Lt9wqcTjH1i1WwO9r/PrAMuOMhM7WfAwY+
         Nu7MPh0W0IABUWdPSXvrhcPVeiwk5OSSR1LLfrrC9Z41ttB1meLI/gA5Od7WdawXm3BU
         Nd/EkI3qT2SLQ4ULx6NXOD3bSJtf8gBeICfJN/Jx6tEb55BJh/GC3W2A0c9ASgyPKg5y
         6hIfQEclFLD/jRlPAcvwe31x/Yrp1a4oLZogr+1nyt+so4fKEcBvHjHt2YpUu2H+qIip
         xQOg==
X-Gm-Message-State: AOJu0YwNlJZ8ok+uZdXkCulh2lViyBh4eLSKEoSN9JJh0QH/nOBASnPl
	3Yy3Um8siwduRAZszz77zJw=
X-Google-Smtp-Source: AGHT+IHpdEsaB2LLCWBa+f/wVtHnEWYPzTouyJYfiz6vX766I+cxYPS/ixHnWjhyDZa9NP2InoMGRg==
X-Received: by 2002:a7b:cb89:0:b0:409:19a0:d247 with SMTP id m9-20020a7bcb89000000b0040919a0d247mr4466571wmi.18.1702499942867;
        Wed, 13 Dec 2023 12:39:02 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm23905007wmo.16.2023.12.13.12.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:39:02 -0800 (PST)
Message-ID: <795bfa3fef7bb0252d5e1d7fd721880ddfae0ecc.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add freplace of
 BTF-unreliable main prog test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Wed, 13 Dec 2023 22:39:00 +0200
In-Reply-To: <CAEf4BzaeEhfFB=ZSQO=i8hT6OP1bkT4b2pzHoViFA4Q_Vju1tA@mail.gmail.com>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-11-andrii@kernel.org>
	 <f94dd0e3404253936b7489ea9aee3a530749c633.camel@gmail.com>
	 <CAEf4BzaeEhfFB=ZSQO=i8hT6OP1bkT4b2pzHoViFA4Q_Vju1tA@mail.gmail.com>
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

On Wed, 2023-12-13 at 11:25 -0800, Andrii Nakryiko wrote:
[...]
> Yes, if we add a bunch of extra log grabbing and matching logic to
> fexit_bpf2bpf test. Which, honestly, I just didn't want to touch more
> than I absolutely needed to. So I'll use your permission to ignore
> this.

Still think it's useful and diff is not that big:
https://gist.github.com/eddyz87/5f518b96eb4188dd1afd436e811bbef9

> > Also, maybe kernel should be tweaked to be a bit more informative,
> > as message about static function is confusing, wdyt?
> >=20
>=20
> Currently the verifier doesn't distinguish between reasons for
> "unreliable". Not sure if it's worth tracking more information just
> for this. Certainly that feels like an orthogonal to this series
> improvement.

Fair enough.

