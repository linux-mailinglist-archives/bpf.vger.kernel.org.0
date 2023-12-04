Return-Path: <bpf+bounces-16594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C480390A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 16:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EE21F2119B
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE42C878;
	Mon,  4 Dec 2023 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrULfQ+p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D762B0
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 07:41:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e1021dbd28so633186466b.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 07:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704516; x=1702309316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oRk1nRknIdEHvn/XYYtF0TPUMF8qHXNIu+UY7UEjxto=;
        b=ZrULfQ+pKFmdZQdPs9neCOUyrJNKUZodmt223GoyfwRFdl5D8OyrnSOXEQUAdANvGF
         JwukzoB54a4xqzWhly4Py2N0TO6r+/u3gB2/t+e/bPO+dlbKKV33NvU75vJVLou3aBa7
         woNYvUDySGrrs0kID5x2t/kdqDU/SdMy/uCS8Dv1+RjpFAynIR2Y+TXMJoGgaRwAdgKE
         3jw4jHPEN6pnTfhxgTbSd8TQWHWJwv9ueBZR2U63wF26q+lRD9UFoDl10b/0wdo0ZJSV
         f2FWecoEKjd+4CQMLTWoHGsvttnCkDZOSTcQphJEF/BJdJ8R2fAw1ca1EO8AxpvfWP5G
         VDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704516; x=1702309316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRk1nRknIdEHvn/XYYtF0TPUMF8qHXNIu+UY7UEjxto=;
        b=MLNXdswcUtqrEy68IDfS1oOXjN6MYsH+BaMt29ZXW/TGARTZFWWBsVn7NJf2cECwZs
         SqyQQILQqOVf03fRkXxeXUwRLdKbZD0NKZcLMd6IDKWprkjUndVKuYYtT4cwQUgpA2nu
         VX72PBm8d7l7t5yfJqblicKsc/9ji3Pza+zBG8rmC3OrdfBboC7n9RsTe4qCpk8DtdvJ
         TzCTdQi/L1RqBiWXn3pTqI87LJcptM0UX72pjWHUP4Gw8ZYbISVh+rOdvqMsxry11Y3r
         LrCQ8kUl7Ylo/wXrc356Ok++4Tj8ka6eRSRLWztYT/cArkuIXEEnu5FOv0JV3nBCYWCA
         xAIA==
X-Gm-Message-State: AOJu0Yy3YJudx0cu84X38BtoQsjqZ2IAqHWfxksW13TbjXnmBme7biss
	HLkrg6CXAum38dC+i4K8fsP7xfJxnMC93r9/8Mg=
X-Google-Smtp-Source: AGHT+IGnBwu08KCGBQDAxgmTnTCtWvVF/3kgGDDHnsZH6tCoG3dyY6a7VA4MBVOgyJtxOshe7wcRNbWTl+nGmZwZhdQ=
X-Received: by 2002:a17:906:205:b0:a19:1c2a:9761 with SMTP id
 5-20020a170906020500b00a191c2a9761mr3875417ejd.36.1701704516100; Mon, 04 Dec
 2023 07:41:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204010139.2038464-1-andreimatei1@gmail.com> <AB2EA8CD-8B4C-49E8-B017-1B93954C85C9@gmail.com>
In-Reply-To: <AB2EA8CD-8B4C-49E8-B017-1B93954C85C9@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 4 Dec 2023 10:41:44 -0500
Message-ID: <CABWLsespouAOUL4VZ6vboWDsNV0ocT0-F_Ezm2rCbO_+wVodiA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix verification of indirect var-off stack access
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"

[...]

>
> Andrei, thanks for the quick fix! But with this fix, I suspect the
> max_off would be incorrect when access_size is zero. We probably
> should do something like this:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2a9d521b64f4..70d5201f7d08 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6556,10 +6556,9 @@ static int check_stack_access_within_bounds(
>                         return -EACCES;
>                 }
>                 min_off = reg->smin_value + off;
> +               max_off = reg->smax_value + off;
>                 if (access_size > 0)
> -                       max_off = reg->smax_value + off + access_size - 1;
> -               else
> -                       max_off = min_off;
> +                       max_off += access_size - 1;
>         }
>
>         err = check_stack_slot_within_bounds(env, min_off, state, type);
>

Indeed, thanks. Resent.

I would love to add a few words about what the intention and exact
semantics of checking a zero-sized access are, if anyone can explain
it. I'm wondering if it'd be better to massage the code such that the
smallest access to verify has size 1.

