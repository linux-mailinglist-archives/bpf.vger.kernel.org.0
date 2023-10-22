Return-Path: <bpf+bounces-12919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C687D20FF
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 06:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E4B1C209B4
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 04:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BF4EDA;
	Sun, 22 Oct 2023 04:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUUsycKV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E79A57
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 04:28:50 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1CD6
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:28:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c3aec5f326so689605866b.1
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697948927; x=1698553727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A76lH12I7HvI/jfJZW8evRNi8CAk0+2ajkYy2hOarfY=;
        b=NUUsycKVF4QbU+iDXm8Y8rOY/MYsoPD+uZUKxqvv0ZXuzxkOEdI+HAcDvkPFDQ0QoZ
         6QPT+l2+cBLH9whNmyq/aP6mw8pJ5/ixxmsFyaTvHbp+rxkxx+DxN6FrDcQvHcC0fGY2
         PSS8LCbtqFeuSuKmplpcxLWdOJby/id+SwswXZk8D8+eJGg3G5Edgcc/ef0Eu1nXajDr
         roVKqO4h4kc9jrexkeQHMKuxh9e6XY3Eqwc0jK43s+wMqoTVWaA0wSS3YW3AAndSvZTw
         RanBxo4cMAwyqQgLVD9KoM9LjFhcZeFCdLRjt1XPs/fXnbvTmyMY/kCWF6DDjU29Ri3Q
         Lf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697948927; x=1698553727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A76lH12I7HvI/jfJZW8evRNi8CAk0+2ajkYy2hOarfY=;
        b=VbwSHDDOZ5U00OAhJxvKEq8k22UybjtpQgrvyHfOxTlKybxIwnHZIwoQlWV4hspZo7
         6IspkgeN+hS1UjsZtWFrG1jzWglDNB5u8ZqlAAV8csptRnEicVmJkXBmjE1QnZKiFasO
         CxmTKXALJWx0+QT2rS3ou1F1n907P7x6Og4lzQmlIAAP5pemVApLMVs2/gmEIm81ueMC
         YFI1RdLIUYnlXPJ+i2eWtQP2MpGa9zUUmpyVzBGKGVPDLOyv3wsVESlnGoJ1URuiBBWD
         bM06kN9y9asAqkXgFNPLBVDGqT2QacL7BJCfceIBGl6GopT+kLzH0EaBxOUp50SdKxwh
         zl8Q==
X-Gm-Message-State: AOJu0Yxpx8nVfo0Mauj/LI02kgRyZSGGbtxWXA6lBtlqfRFOU+lxDWWA
	gkQxHercEWO/OL/dneEo2uumoq9YBkYu/Ll5Q0o=
X-Google-Smtp-Source: AGHT+IGjx6yA6iTYVy9u3MRkwqd6YO9OeaFU2DY9m6FU7VyUdlSV3YHnnvYKQ+Z2elUC6krlmE0+66PZv0rAPV8zShA=
X-Received: by 2002:a17:907:7290:b0:9ba:b5:cba6 with SMTP id
 dt16-20020a170907729000b009ba00b5cba6mr5550414ejc.14.1697948927306; Sat, 21
 Oct 2023 21:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022010812.9201-1-eddyz87@gmail.com> <20231022010812.9201-8-eddyz87@gmail.com>
In-Reply-To: <20231022010812.9201-8-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 21 Oct 2023 21:28:36 -0700
Message-ID: <CAEf4BzY0jxrVKW=zqNAYg8xR5chDJpPhOSWBs6CFksEs7U9+Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/7] bpf: print full verifier states on
 infinite loop detection
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 6:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Additional logging in is_state_visited(): if infinite loop is detected
> print full verifier state for both current and equivalent states.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Great, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index baf31b61b3ff..a91aa8638dba 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16927,6 +16927,10 @@ static int is_state_visited(struct bpf_verifier_=
env *env, int insn_idx)
>                             !iter_active_depths_differ(&sl->state, cur)) =
{
>                                 verbose_linfo(env, insn_idx, "; ");
>                                 verbose(env, "infinite loop detected at i=
nsn %d\n", insn_idx);
> +                               verbose(env, "cur state:");
> +                               print_verifier_state(env, cur->frame[cur-=
>curframe], true);
> +                               verbose(env, "old state:");
> +                               print_verifier_state(env, sl->state.frame=
[cur->curframe], true);
>                                 return -EINVAL;
>                         }
>                         /* if the verifier is processing a loop, avoid ad=
ding new state
> --
> 2.42.0
>

