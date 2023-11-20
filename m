Return-Path: <bpf+bounces-15339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E377F0A6A
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 03:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EE2280BEE
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1C61878;
	Mon, 20 Nov 2023 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHXjcM6U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E408136
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:00:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083f61312eso14044875e9.3
        for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700445626; x=1701050426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E7em82XObCZZzus55Rmpj7k6/gIzHcADd8RwWOZnHU=;
        b=gHXjcM6UQ+Uw00qUGvLcIXPbErtDGd/N6F7CReNZQGHanB72q4rSJtKTEzoivo2sSp
         W5KyLXd9PFW0Pzsicxg4EMlAEp6Vhnf1NanSOSLW65osI7uLpzj1GLuXMcKYjuMwoFnl
         GKh7aXJtdNbTXGdXyXLqihb4b2pvp0VTV2cXBib7Rh4Cjlj9iIbz7AKQBV5LOC8dw0iN
         xenc7KwTk1j8aIWbOC4DVJph0IlS3z7YNql55YbFoGjAVJM4sRV2ffNIUrmltt9sNzNB
         4cHw22IyFTPigoimp+8ltEIGEl+nNuQ+WDAPj2z+GwO/wKxvxWHCC2ADNNFRYzUfrH8Q
         qX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700445626; x=1701050426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9E7em82XObCZZzus55Rmpj7k6/gIzHcADd8RwWOZnHU=;
        b=ZzJomNi9Dmeji44nS3GpNaf+ybUU4CxAaN1kT4twR9n9uaPaa8b77tHyHEqBUrgOA+
         02t2zIPhtNIgYIlrDZI464IEtI9nCvvJtpPW/RTqWLLHRkpZy3FZUJ0QvLfsZkfNr2Nv
         cTwrh7I6i4/PIRguBA3pva4WHo/O0DpqD+65MNsZXc2hmgOfnmr8pLDXLxQdJ2uArmRH
         QuTbTByBw/j8L+vpZzcMO/G0sdJxDfWNpcH31CtH6JEu23F4rA8jcD5C2YGJg/EMXIUS
         d0uInoy+m/eKsT9DS166p1JsKqlz61SxfaDj3+HH0TR86+JqhXlF3e5xb/fhwbdZ+WqE
         95Rw==
X-Gm-Message-State: AOJu0YyITyDilC8wSS5IsNPAYTYpnJb6EQQkF0VfCwHBtylvk/1K6ve9
	YsLp/Dcutm8WtkoE+SZ28Utwgoyj0vUhQfM9d2o=
X-Google-Smtp-Source: AGHT+IHHjHZ8sBGiC/1+6fD8Zk56rpkPhlb3VVTwAuRcC6vGjueqDxQl8VdZj1fSjUfcMRFQdeEVfKiqKUXrq7SS+Fc=
X-Received: by 2002:a5d:6d0a:0:b0:32d:9fc9:d14c with SMTP id
 e10-20020a5d6d0a000000b0032d9fc9d14cmr4547580wrq.47.1700445625704; Sun, 19
 Nov 2023 18:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118013355.7943-1-eddyz87@gmail.com> <20231118013355.7943-11-eddyz87@gmail.com>
In-Reply-To: <20231118013355.7943-11-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Nov 2023 18:00:14 -0800
Message-ID: <CAADnVQ+Zit-KLSnoo0x-dh7Ek-VGm1K0-oBWZ085dke-ztYLMg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 10/11] bpf: keep track of max number of bpf_loop
 callback iterations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 5:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7def320aceef..71b7c7c39cea 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -301,6 +301,15 @@ struct bpf_func_state {
>         struct tnum callback_ret_range;
>         bool in_async_callback_fn;
>         bool in_exception_callback_fn;
> +       /* For callback calling functions that limit number of possible
> +        * callback executions (e.g. bpf_loop) keeps track of current
> +        * simulated iteration number. When non-zero either:
> +        * - current frame has a child frame, in such case it's callsite =
points
> +        *   to callback calling function;
> +        * - current frame is a topmost frame, in such case callback has =
just
> +        *   returned and env->insn_idx points to callback calling functi=
on.
> +        */
> +       u32 callback_depth;

The first part of the comment makes sense, but the second...
What are you trying to explain with the second part ?
How does the knowledge of insn_idx help here ? or helps to
understand the rest of the patch?

