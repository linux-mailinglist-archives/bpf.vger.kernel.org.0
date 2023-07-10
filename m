Return-Path: <bpf+bounces-4654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA174E24A
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F60C281305
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB24168C2;
	Mon, 10 Jul 2023 23:45:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BE14AAF;
	Mon, 10 Jul 2023 23:45:47 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367F19A;
	Mon, 10 Jul 2023 16:45:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b702319893so79876691fa.3;
        Mon, 10 Jul 2023 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689032742; x=1691624742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOzkIFoqf25CqB9hUyPl1DnkRcrfld+HOSpLgyRrDcI=;
        b=ZdWzHzRengZ9OTY5kYzIhNizMIm4bJBEhtBcpNLzYf8bkufwXdpeZzSjumeSma1n7K
         XC2HvBGNTrYT7QAMvIQIHwpwCf75tsGFftgIaUUv02L6P/cLIvW8+2iQVl2nwII1gK8D
         iWhWIQHbIK4ESR5cShCFBrJjjbRS1aNbz6et5bmomCrEOxZ+TB1KFdA3zgvMuhAexklA
         JWwyVgGFwB7hhXIbXEZqvsSgIqjBaenaPPHzDTH2OzNNc54b7pGLIPx8emn6EI5fwRmF
         4r46gtvcR0mN6dt4DmzKUP4FZ1ghVaQXJqWk6HvGMAa+AHku5sxKf6l+6v53jk3t0Oxh
         OziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689032742; x=1691624742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOzkIFoqf25CqB9hUyPl1DnkRcrfld+HOSpLgyRrDcI=;
        b=kfMvgNuFC17vOibYVtTesaowZpKmx+EFqOcfa0Asfx5bOpFPtDTod1JT9GfgbVtLZ5
         7kAZ4wo/mlwqKTN38qgOY7aWL51HEtgE0wHzTXkzqsjAn1OMrW6fy5mOIv3WkOmxyDv8
         hj5nt5x9RI9r6Cg4fJ1hNvKBefuIban0i+7y7G7VyjhON98SmeWCtXqsh7ZhEdsQ/Ykn
         8QZ2KJnoI2iUBY+wrrFGh7bMYmet7kPn3lW5KT5N4uzpPIgwnxAJloi07AUDxVjbbrSo
         OouzeeoJeU5EccZWKuEdP7++5DvUhMmFS0CqMzB8zaYK/oAR2Ob+XG615sY+3Jaml8mL
         rHgA==
X-Gm-Message-State: ABy/qLa07zOuEAZ5W5N+llRc5nSKgDfyKGTvSbNLrC1K0mtFLNDQGdYe
	AiSeXpIXcAMMrxGYLpBqFsd4QHGKOjBaS1Km+iA=
X-Google-Smtp-Source: APBJJlFULHT8iLhB9w681CsXgyMHt2EsFqaBNl+XwT2OviAPgDtyoJbasP6q7D6vPnHpAvi/reCyP4wyfRqLiqoZsqE=
X-Received: by 2002:a2e:780d:0:b0:2b6:d582:5a0 with SMTP id
 t13-20020a2e780d000000b002b6d58205a0mr11825737ljc.12.1689032742222; Mon, 10
 Jul 2023 16:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230708040750.72570-1-hffilwlqm@gmail.com> <20230708040750.72570-3-hffilwlqm@gmail.com>
In-Reply-To: <20230708040750.72570-3-hffilwlqm@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 16:45:30 -0700
Message-ID: <CAADnVQK5RLqVhc9AxaCSuQxFRDAb8wohmUDNrYEViXLf5mEMNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Introduce bpf user log
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yizhou Tang <tangyeechou@gmail.com>, kernel-patches-bot@fb.com, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 9:08=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 34fa334938ba5..8a458cfcd91bd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1549,7 +1549,6 @@ union bpf_attr {
>                 };
>                 __u32           attach_type;    /* attach type */
>                 __u32           flags;          /* extra flags */
> -               struct bpf_generic_user_log log; /* user log */
>                 union {
>                         __u32           target_btf_id;  /* btf_id of targ=
et to attach to */
>                         struct {
> @@ -1585,6 +1584,9 @@ union bpf_attr {
>                                 __s32           priority;
>                                 __u32           flags;
>                         } netfilter;
> +                       struct {
> +                               struct bpf_generic_user_log ulog; /* user=
 log */
> +                       } xdp;

1.
You cannot break api in patch 1 and fix it in patch 2.

2.
libbpf side is missing.

3.
selftest is missing.

4.
bpf_vlog_finalize() should be used and error propagated back through
link_create.
Same api must be used: log_level, log_size, log_buf, log_true_size.

But considering all that I agree with Daniel Xu that
tracepoint would be better here.

