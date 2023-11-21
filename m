Return-Path: <bpf+bounces-15476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06887F22DA
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407BBB2189C
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C641C08;
	Tue, 21 Nov 2023 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJE/AqAt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D7CA
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:06:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ff26d7c0a6so182165666b.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700528793; x=1701133593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PICi8T8v0l8gCD3fginwhG3Vtm2C+Lmd9VzJW+4MeLo=;
        b=WJE/AqAtMp8qxl51BcqGHwiw91BtgZLAL8ikUZ/tp17P5jg+7t5RMKDUSytIhZYzf1
         wP6bgXqMxUA7wNqxc1xqw6/+PWf2ofZmHl8J4WFdOvNQKTFASt74NxV11tAYc5W3Zqej
         4ZChYPfkg8pw6MhVWpJ7goRIWNPjdHBGMyuAuUnQn+3uG+4KiQo7pEi+WobwgEVv9JX2
         bmsAqGD22euBpAv4ReJfl+fuQZglp5DGd6kk7deejdBx/o5fWmJKPDEUbQZT6/Jk1KIw
         0R3VVymaAnNgrThbLFwTQnHpFXnezNd6eC48oedeEBIC1n+Uh3+sQVJCqgxf/msfRXoD
         9NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700528793; x=1701133593;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PICi8T8v0l8gCD3fginwhG3Vtm2C+Lmd9VzJW+4MeLo=;
        b=FC6CasKuNFBayvlbF1QW2tmfbfI0wWQ9HTehhs7WlS0xkDYBV/baAj60d5tsS5MFlT
         9rchDqryQH5T6qCADAqO4jRFueZbYUl86mK4HYqkiirjW8S/tcCWlGmYRYwosqGf5lrz
         HKpg9akbKC20Dpg/8Q9WQBikyRdbd5jQG2QLqwjV60a24A4zMKBS7X0OJ5qcgi+4Dhmp
         HPpX+gsdiIXW3evTFAlwtY0Ggtp4QQWWgfPeYfZsif1mFIN6TmxnPatgbztzPLbJ0jrg
         zlmjc45CLn9ax10o4Kwew2BHJnBVKtAentA0jvs7/+WnIwNxXIqoO0/qXNKJj8dQestT
         KqJg==
X-Gm-Message-State: AOJu0YwHw2rT90/v3/WlDWGXEtNe0nYiuvFKmnD6Gy3PUcD98g9h6tuA
	9Nyl8im66OBgCi6D1IgeQnk=
X-Google-Smtp-Source: AGHT+IGm4bx0TN8pPYeGtatUeY6RLkOq9vcakhVjc8NOJefJRZ1WV0VfmKtfOvc7I8B9lZnHeUagiw==
X-Received: by 2002:a17:906:257:b0:9fa:ca0c:ac42 with SMTP id 23-20020a170906025700b009faca0cac42mr6652692ejl.64.1700528793405;
        Mon, 20 Nov 2023 17:06:33 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090671d200b009fc3845adc1sm2539070ejk.154.2023.11.20.17.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:06:32 -0800 (PST)
Message-ID: <3333caf6578e73d433b0261297dfd588afb1868d.camel@gmail.com>
Subject: Re: [PATCH bpf v3 06/11] bpf: verify callbacks as if they are
 called unknown number of times
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Tue, 21 Nov 2023 03:06:32 +0200
In-Reply-To: <CAEf4BzZLU3LxG9FVAGqEmvsqpU8+X1grWj_F7Fvjvv1E8xj6Nw@mail.gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
	 <20231120225945.11741-7-eddyz87@gmail.com>
	 <CAEf4BzZLU3LxG9FVAGqEmvsqpU8+X1grWj_F7Fvjvv1E8xj6Nw@mail.gmail.com>
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

On Mon, 2023-11-20 at 17:00 -0800, Andrii Nakryiko wrote:
[...]
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 24213a99cc79..6e21d74a64e7 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -400,6 +400,7 @@ struct bpf_verifier_state {
> >         struct bpf_idx_pair *jmp_history;
> >         u32 jmp_history_cnt;
> >         u32 dfs_depth;
> > +       u32 cumulative_callback_depth;
>=20
> nit: depth and cumulative in this case doesn't make much sense to me,
> tbh. Cumulative is generally a sum of something. You don't seem to
> ever decrement this, so I guess "max_callback_depth" or
> "cur_callback_depth" would also make sense? "callback_unroll_depth" is
> another name that came to mind. But it's honestly not that important
> to me, the use of this field is very minimal in the code base.

Will use 'callback_unroll_depth' in v4, thanks.

