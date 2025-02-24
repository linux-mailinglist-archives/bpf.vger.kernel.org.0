Return-Path: <bpf+bounces-52456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A491DA43015
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E09A3A65F7
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8720550F;
	Mon, 24 Feb 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbADqKXN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034818E377
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436131; cv=none; b=rUoA8Kvev0XSNnEXg+3eRU9BKljiI/n6baV0e8jtAtafPiuOP/7aL7DKGKS7nGE1oq2Jc5NAJhi7xC92PFIifI0w7qOPF2BbjbAsLuSA+l5lK/ciNNKUNYLIg4bX9bUpiQvZ/jqn6w9jY3lRZHumje+hdXyqEjzw+NsA3Tp86JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436131; c=relaxed/simple;
	bh=CLrJcFXuraSYg4/OcDqJXEHzvjf6VpmqxtFnoMFjIe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTm6mK93GYyKAUiKUwsSi2sN4jzgfahvTaJ+P1LnyGjLyV9P8WaB63IV+pF9cpI5ZKP19TjDAHohMAnuztKDxksR39CTMwQL8L7h7+I5/hi6bcMKM9L6CLZvkO3oYqZaPFoQ16W1CglRynWW5GNmvQ28zsYA9aasojsfM+DO+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbADqKXN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220ca204d04so80198145ad.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 14:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740436130; x=1741040930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5iw1BAt+sonC4YpMQqIU5EZsXiSTqteikRWnjB6XGNA=;
        b=dbADqKXN9oCTAH2uAsRrSjF98Im4c/FrZN+ru4v7OiSyyB3Q8jBEAaEZlXpcd6ARRp
         bYD1B1RLdjOfaB0foEUL6pcjvvezpEVMFnJYsl8zJAr6J0vTe3dJJieq0LouF8AqEVrc
         M0nBS4BdVdwX49U+71wreV8QSelifYmB1oqfzCXKZw9AOYo3tSSGFQ7hEw8ZBquIezn+
         tT5CTxDMwxFR+NQx+3JMYHIpQf0d10g2rQc44fAoorlZ5rephvGF6C6FAiW3geRi9KxO
         tAz6mBjtMicPxXEFXrViqZNFM8dC2EXf5wAAhz/mbJ6dHnvtoqr3tcIkqAmxvBb8AQzO
         zJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740436130; x=1741040930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iw1BAt+sonC4YpMQqIU5EZsXiSTqteikRWnjB6XGNA=;
        b=Gl2ZKay0UcIDO6AqHxXzRfXGm/k7fSEDqmLtbQJhiYPHkjHLM2Ewecn6U3aKbsTX9W
         j34bkfiflbGAOsX/T4xRHfeTPVDTkctPT22ECDJEz3THJ/UlNvpuRd1x9QT6cCAJStwC
         ZYMnAbr3BpnL+zYcW+NAVFVfIKC9PEtD9xdCDk1g2JsAwAEnFtAI/n9li2D1tAG0kQdh
         0KQiTfq/D/8QWJ2IHUiGH4K5cw2m/U7Fl6yXiRf3o14Ylb1LfIMHApFJCqtMEOG0S1/e
         6wUXPoqBAPIo/tnbHmIJIXZpDuuve6PjXhYqOi73mCXgGEg9KhoCJ3l8RmLJPLhPJqry
         AEzw==
X-Gm-Message-State: AOJu0Ywc7t0Dxp2A+NoCU8pYwceymorhje/hwVk14dUhxxN5WFUzVYyG
	CgWkkfZ00p7FN4P85EjhK+OIOrDJPrUyIR/c+IQJB1RUJL9a7shJ
X-Gm-Gg: ASbGncs9ocEjNRM1uY+HWTyNVg7kFE8AlYKvEzqXz2koPhEcae6EfxwlCCzPEXj1Uf3
	0jzyou4qXBAKl7195UtNRn/uBHiPSkieArVA905Ui67ykPCkzkgNGJHZHUOIoH0Lw/cDJ7RBnx6
	6EJM0ieCFwekCMcstSXVObFsn25MXnUnK60EbmkNc4bstY0KMWDJxnOg66QaS4c/VeeYM6eFijD
	IawaCbhqCtrYChn9wSTNBKrw3aqH99HCX582lyUKn9zJV5/SkR9OPL1+2F9f4qAXKo0Z5h7IrQ0
	iN9UQkecQnAU4+Wt/trq2uU=
X-Google-Smtp-Source: AGHT+IH9dHq/Zr5K72GP0lWr4YqeaFhj70yzZVs2UFlMJW1Rwu++gBtttxBBXXke3yIDCn1WqAIagw==
X-Received: by 2002:a17:902:f68e:b0:220:dfbd:55ed with SMTP id d9443c01a7336-2219ffbed96mr246158195ad.43.1740436129584;
        Mon, 24 Feb 2025 14:28:49 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00ab18sm1197585ad.78.2025.02.24.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 14:28:49 -0800 (PST)
Message-ID: <124f01c6b876a3d32909018661e9eda420945337.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/10] bpf: copy_verifier_state() should
 copy 'loop_entry' field
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, tj@kernel.org, 	patsomaru@meta.com
Date: Mon, 24 Feb 2025 14:28:45 -0800
In-Reply-To: <CAEf4Bzb3B0-aC2CQeTajhsFDYpUtXEAEM1zq81TdpHr+QZW6QA@mail.gmail.com>
References: <20250215110411.3236773-1-eddyz87@gmail.com>
	 <20250215110411.3236773-2-eddyz87@gmail.com>
	 <CAEf4Bzb3B0-aC2CQeTajhsFDYpUtXEAEM1zq81TdpHr+QZW6QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 10:56 -0800, Andrii Nakryiko wrote:

[...]

> > @@ -19243,6 +19244,8 @@ static int do_check(struct bpf_verifier_env *en=
v)
> >                                                 return err;
> >                                         break;
> >                                 } else {
> > +                                       if (WARN_ON_ONCE(env->cur_state=
->loop_entry))
> > +                                               env->cur_state->loop_en=
try =3D NULL;
>=20
> this would be a huge violation of invariant, so why wouldn't this be a
> BUG()? At the very least, we should return -EFAULT ASAP, instead of
> trying to "recover" from unknown broken state.

I'll send a follow-up.

[...]


