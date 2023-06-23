Return-Path: <bpf+bounces-3220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B29773ADBA
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 02:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5481E2817FC
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5F19F;
	Fri, 23 Jun 2023 00:18:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24717F
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 00:18:25 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC7C7
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:18:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9b4bf99c2so1580005e9.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687479503; x=1690071503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEXyHauRDmCip4ZnZJLao+9/e93O0ICbfxTVUp/lJ2o=;
        b=n513onlzVobfywuqYcoBNqPunqImuI7lBUU1yoYXxOMRxahLnsQ5ci7Ga/jL6uqzIf
         eqmg21ZEKaltwFM+R9V4kxRNfhequ6TudFqmW9adJgpbSm7Y6ectLa1NY1gKk4q8W21j
         Pu5P8QAtJalRu6ByGfwibXnN/jTRSmQM6+oXrM2AQssIdXsuqOActZBEYVdFAkslFJ2Q
         HTXREZPqF+6ZjkFewgH2+BS6JX0RTDiG1tjSiH0ByXos6bRsmrYU93ynCmgmhqzgwybb
         UMPn3RvYTQ444exN2+izfMVLZIXuz0YmNneJ4MfBHBUbiYrU+VwvKu4ilVo0RW9uVWVF
         BaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687479503; x=1690071503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEXyHauRDmCip4ZnZJLao+9/e93O0ICbfxTVUp/lJ2o=;
        b=ZXVpHf7Udm4uV+iDm1saCzqi3SYRQ6i3n3WxMutfDiVHocYcZF+clXhvr0IglrnPLV
         h26vgy53bpWw/wGvWw/yDhDGE2ORDJiuuSnQfyajK+T0DimDbqwYptCYUK2cATKNemfN
         YL9mDZFzCBOPHQewTWZAOBUMm8p4EfwVEchOnvDrd8VnxyeRVQ7wLUi7iqyssu7dv4Gp
         QO9Hp2mgBbf7x8BgZjG/3XnRDuHlYrxIGXX86ooNG9TmfLaLrXNolPkjsmUWET5ZePnI
         yixXR+En464Q5QuKbwzt0e2MfshovVG7dimnZWUrrCWBM31cxGm0RTkFzAFZkl/uBCJu
         kgKw==
X-Gm-Message-State: AC+VfDzVLwq+vwTJ8ier8mFXtvmj97BaBDVcJtE5g0JSnIV7m9h8uwAT
	XaKWO+x3LsB6BZ9z8ejjYays2RLOCIOZJfCaKkM=
X-Google-Smtp-Source: ACHHUZ42uZhSfqJq99zbhszlNDthhiEM47Z12oh1e9/RxJCHft+oQuC+HhyinwqCdM8VeSeJXRo8g8l49GNVMmKybyk=
X-Received: by 2002:a05:600c:ac9:b0:3f9:bda6:2f50 with SMTP id
 c9-20020a05600c0ac900b003f9bda62f50mr5220416wmr.22.1687479502733; Thu, 22 Jun
 2023 17:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-3-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 17:18:10 -0700
Message-ID: <CAEf4BzY9qYSmGsAOZt2W1KGuDZu+wtKFn5FNECuKkNpk7WNvwA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 02/24] bpf: Add cookies support for
 uprobe_multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to specify cookies array for uprobe_multi link.
>
> The cookies array share indexes and length with other uprobe_multi
> arrays (offsets/ref_ctr_offsets).
>
> The cookies[i] value defines cookie for i-the uprobe and will be
> returned by bpf_get_attach_cookie helper when called from ebpf
> program hooked to that specific uprobe.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/trace/bpf_trace.c       | 48 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 47 insertions(+), 5 deletions(-)
>

[...]

> @@ -3026,6 +3045,16 @@ uprobe_multi_link_ret_handler(struct uprobe_consum=
er *con, unsigned long func, s
>         return uprobe_prog_run(uprobe, func, regs);
>  }
>
> +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> +{
> +       struct bpf_uprobe_multi_run_ctx *run_ctx;
> +
> +       if (!ctx)
> +               return 0;

can't happen, let's crash if it does happen?


> +       run_ctx =3D container_of(current->bpf_ctx, struct bpf_uprobe_mult=
i_run_ctx, run_ctx);
> +       return run_ctx->uprobe->cookie;
> +}
> +

[...]

