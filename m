Return-Path: <bpf+bounces-15259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6C7EF795
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 19:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE171C20939
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585544315C;
	Fri, 17 Nov 2023 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTybAdvZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF3510D0
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:09 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so3337005a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700247187; x=1700851987; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+F57NAXBxIUjpyKUeauHAbmtcRg88qsJW+j+SRa+wos=;
        b=PTybAdvZxiBEHsecZkmJus3sGgsXCOWPp14F/5MrlkYYJJgd1dwbF7yw8KzTBA8ug8
         qRIISuNPFrBWczhiXsKq4sdbrjXpSspjG3M2ITlcdaBSqQApqDiJxgpMWUSRWPqgwTx2
         QJM+OB3C7u/BG9uHGXf/uhWJGX8sVzMf1ynO0WoEze0hy/yUSla85+g9BpPxX2v6U66O
         sGfr/iodvKZyBqfX9F7wy01WssGwspOUp8CxuSJtHNE4XAV8APBwvOuz0AFfByiVaNrM
         8Jr2cFQxzRGMlXu26AATo0Vcidb8XdwD97u1nCGymSC1SEJOXZaimThX/4euc6Y46N/B
         eCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247187; x=1700851987;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+F57NAXBxIUjpyKUeauHAbmtcRg88qsJW+j+SRa+wos=;
        b=Nu+d3QxNpTkit4JVmBqSkJAxsmflQBMXbGTvYbrhVB187zN0J6nDjIUvuzybDVXduI
         ZzUKaKoZpcz427UaNQn0St53dO/0S8jy/tpnxPfHwS98vWhCuoMoAYNyQndBEje2wpe9
         6BrdkxmQaet1h8H0o9jesJccSWUSu+qi3z8qnrUJpKMlfsaM7VwWr5b7JAhFVDoyLq3z
         ruNO1xkiiSzj7uv2DNZMh5Jgdn/oJokTm2+RDGH0N384QRKteESU45sL66Xp3v7VVQR9
         yDtOkNOZ67OkfbucvnMqdUaY0W/SK+FS0rJAgTrOiVu7c0Tc6KscWhOSFG/kcHl3uHnO
         gAvA==
X-Gm-Message-State: AOJu0YyjLRq+DOtUlzBhU8/M/+h5Z8nmOTcxQZFFTzF389yjwhENPPX1
	6A607h+YJ82dg1x+92m4vYo+oHWG+uo=
X-Google-Smtp-Source: AGHT+IHmZuoZAMYccpOnuD3hvr2WTqnoVT8tsGxX/8LPMkI+mE5Vo2FxRutBNf0UlYMbIYLsbEXZlA==
X-Received: by 2002:a05:6402:524a:b0:548:4dd2:aa58 with SMTP id t10-20020a056402524a00b005484dd2aa58mr1936189edd.28.1700247187442;
        Fri, 17 Nov 2023 10:53:07 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402079200b005438ce5bf80sm960142edy.20.2023.11.17.10.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:53:07 -0800 (PST)
Message-ID: <8debf74caf92472d40e34fef20658727e541f3b1.camel@gmail.com>
Subject: Re: [PATCH bpf 09/12] selftests/bpf: test widening for iterating
 callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 20:53:05 +0200
In-Reply-To: <CAEf4BzZ+rMakBnBKnqOCsxM4XqSfraaqaEE1wdfrhAwLOP1x6A@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-10-eddyz87@gmail.com>
	 <CAEf4BzZ+rMakBnBKnqOCsxM4XqSfraaqaEE1wdfrhAwLOP1x6A@mail.gmail.com>
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

On Fri, 2023-11-17 at 11:47 -0500, Andrii Nakryiko wrote:
> On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > A test case to verify that imprecise scalars widening is applied to
> > callback bodies on repetative iteration.
>=20
> typo: repetitive? repeating? successive? subsequent?

I'll configure spell-checking, I promise.

[...]
> > +static int widening_cb(__u32 idx, struct num_context *ctx)
> > +{
> > +       ++ctx->i;
> > +       return 0;
> > +}
> > +
> > +SEC("?raw_tp")
> > +__success
> > +int widening(void *unused)
> > +{
> > +       struct num_context loop_ctx =3D { .i =3D 0, .j =3D 1 };
> > +
> > +       bpf_loop(100, widening_cb, &loop_ctx, 0);
> > +       /* loop_ctx.j is not changed during callback iteration,
> > +        * verifier should not apply widening to it.
> > +        */
> > +       return choice_arr[loop_ctx.j];
>=20
> would the test be a bit more interesting if you use loop_ctx.i here?
> `return choice_arr[loop_ctx.i & 1];` ?=20

It would force precision for 'loop_ctx.i', precise values are not widened.

>=20
> > +}
> > +



