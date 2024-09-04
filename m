Return-Path: <bpf+bounces-38919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2153F96C78F
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8FE1F23976
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBF1E633C;
	Wed,  4 Sep 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="namnZD8I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55571E4923;
	Wed,  4 Sep 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478181; cv=none; b=ZNEDD1DO6OwD9vKa5vZl/5Ge4nCj3juPdOKO5c2JBPksd4tufbjcHUvIn2wbNrNXTrtgYS05QlRaktchHYnBLs4gUkf1oz6v8PhRhpNJM2yas0Tb6iQ7TNF1ioC5zetux8qNa7Ou2NjSpSk8Tyfb0sHMwBalycaSXUIyRan9mfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478181; c=relaxed/simple;
	bh=umdFtTlAWj8D6491w1Cn+lrTO8LaHN5Nsaig1rhVMFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLwWhcONl4csdhsDFf4MM8ncd04dclKNi6N/NUxOwarHx0jTevCWpcqKLg2shx8NzJv/dAPebQyktrQqvGdLurQAA2vCey6WudJb/XaE43YMArzak/XqkQcLiJZ7C5BhPn2XXmbyfxck+IfzES6sJc8eQus670tdqC4PThHvQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=namnZD8I; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso11509a12.1;
        Wed, 04 Sep 2024 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725478179; x=1726082979; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=umdFtTlAWj8D6491w1Cn+lrTO8LaHN5Nsaig1rhVMFY=;
        b=namnZD8IVWSzEIcld85LeBm9ssj2d4Jkh6ZuL7pzcGQiKix8BEhP+ZsmPxIb8X2yFo
         E0YdtUWcK66oD3IEMd24jOQxA99DmkpUn/82tfgCfu876EU+q4PETn7RKft9nlAmnrGf
         PpEHdtWBNWADOnNZp1AsPzXvBaiDm6Y53r6t37sT2YvqLwi2eD00J5G1e7oikcEEyuAL
         Fy/If1ZjuVZQ49gkduwiSUjM08dNY1ow5+N9BTwSm6+LbtalFOpxan/Kl4Es8GThiWq7
         9rNOTOjPxLQCKL+ZE27vYLmt6HsJMZ4xEv0tscMd7AoRnBYiKOFiJiooQULAyUY49hCC
         mgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478179; x=1726082979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umdFtTlAWj8D6491w1Cn+lrTO8LaHN5Nsaig1rhVMFY=;
        b=lRD5vO3PJ6P3215GsXAOTP1iq8wnjqFxhN9R1agf2S6wMUigGpbxrsMURBzUTTQCUc
         S9VJPEzZy5NUVlEOZuG9gzDF0CkOu7CP7jP+8E9+3vXP/STw89mSL4LDk88YKI/2gw8w
         Sny9sc6ySuD3BU8U/mE+gGk8u0D4gKZYPPhrzaFMPS2LfRMSDb3wE0lBvVf6OwYeqs+t
         WZgxZsQZoJ8JMDqepIMYpAFrdQUfXqQgELYTrFLZS0Qwq81EF8HXPpNJc1NoNJsuAWtv
         0OaRSNCSObnmmvuYIxX2v1ROm/fDuLR/B0SZdRfdlTZ0aoPL8fZJTKi0ogvyLmavxWiU
         A23A==
X-Forwarded-Encrypted: i=1; AJvYcCWqDTwk8VGXv5zF7y5sVCNIurD73UqWrTN7G9ubhOfeTu/cAg2LfCu5Q5y2Sg9uvPk1d7e+cwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLcH6s4eLqUCN/nS8OzQ755B01d9kCwtC+AMhBeBVb01BQq+l
	8k95WcaLvH4I7efCz4kJi8H4qWtNBblcBbV3h4hWvHFFabO1otSj
X-Google-Smtp-Source: AGHT+IGA+X6axjpJX2VU9G8Ebr6TmrtuSAEq2O+0Rssv2+hY/YGT0Q2PHCZbsrYcd7742d+TlLIYOA==
X-Received: by 2002:a05:6a20:2d2c:b0:1cf:126c:3f6a with SMTP id adf61e73a8af0-1cf126c43b8mr636264637.27.1725478178880;
        Wed, 04 Sep 2024 12:29:38 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778520e66sm1980240b3a.21.2024.09.04.12.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:29:38 -0700 (PDT)
Message-ID: <19101f0b4dbbc933e59ce545bb9f5d719c4e5024.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/10] selftests/bpf: Adapt OUTPUT appending
 logic to lower versions of Make
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Pu Lehui
	 <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, 
 Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Palmer Dabbelt
 <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Date: Wed, 04 Sep 2024 12:29:33 -0700
In-Reply-To: <CAEf4BzaW6UfJGFK5hy5JQYsf3qwiqQ81h4Awtkj3XtKv-HKRrA@mail.gmail.com>
References: <20240904141951.1139090-1-pulehui@huaweicloud.com>
	 <20240904141951.1139090-2-pulehui@huaweicloud.com>
	 <CAEf4BzaW6UfJGFK5hy5JQYsf3qwiqQ81h4Awtkj3XtKv-HKRrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 11:49 -0700, Andrii Nakryiko wrote:
> On Wed, Sep 4, 2024 at 7:17=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com>=
 wrote:
> >=20
> > From: Pu Lehui <pulehui@huawei.com>
> >=20
> > The $(let ...) function is only supported by GNU Make version 4.4 [0]
>=20
> Eduard, seems like the mystery is finally solved.

That this thing was silently ignored is most perplexing.

> We were actually considering removing the FEATURE-DUMP functionality
> from BPF selftests, but it's good to have a fix nevertheless, thanks!

Pu, thank you for figuring this out...

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


