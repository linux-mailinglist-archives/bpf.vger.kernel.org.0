Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F192F6EFAC9
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDZTOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjDZTOD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:14:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F5185
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:13:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-95316faa3a8so1425755566b.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682536412; x=1685128412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7qLe9xoGQAtvSX/k61PvNxTN1RH0wiXnhCUKQsGbPA=;
        b=ZdKXHwE5Kytb2wZE6E8NEH5fUAPCDuTdHP+UW72cG/SxvQdm7EsuUUEN2HbJDp1Mjg
         YhWT8Fk+jrqD49XNHO4oRTjpc310YoHj3LfcYYQXNIxszrfb3+HNEWtS6SWNU2zIQRnC
         FBKFDmkCx+Bs6hIOqr7LGKd2wIRWiU+ikddBbO17fzB+rNSKCewmefHrSeufKW0ySa+d
         U6l1iGpDLAmx3NMez+/f/lrM2N3UUV1h/YyeQRe/Q6/pIfRZicQaCeydwm0IeHzEFSz6
         v2pbwwOlId8BnFmO3uIehiRZqB1YbNo/RAgi0dfsH3iA8omcNUvuzkfTFR9Xdtk/Yd33
         Ux7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536412; x=1685128412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7qLe9xoGQAtvSX/k61PvNxTN1RH0wiXnhCUKQsGbPA=;
        b=GTR487jogn33C4IM5dZ88Zf4wk2s3EwuR392SX3/CaVCxw+3/cZJ5CG/N2oil+ltP5
         rdAdOd+d/rbFZsosfBibtk20dC6zQ+RMe+RszhXlHVlSrxp8yrKgBK46U2F62Ms+GD5U
         5iflIZPfP1aQB2irXzkLZg7bAfN6VTDEGe6MCOJIbUZBN/dDPs2mUlLjdQlBvjoAjnFh
         Ml1vdMY9dgRiVvwbYjO+E7geWHIquAAhi/Pzh1hpx+LWiY23dSQN+6ETNF5wtl6Ggi4S
         k890SQQlXkHDP0BtHvzT3IQWE0RP8kc/3oLAQnN2EMpcPX34S3ZDfO9PT6lUpB/5Zlwi
         841w==
X-Gm-Message-State: AAQBX9cDChD7Z7QzrbndgYCKWJSV7n5VLmO6c1A8gDXnERWLch9Kxgrb
        iv42eE+vFWxQqYkuLiO5ZZYrlZDLndN1ojeGcGo=
X-Google-Smtp-Source: AKy350Y7TNPHsQ26xhDcNJeUK9ld3MzEJRsscyrtnMnk8Intwod7pcScvwUv3glr4Kgi32c9QK7YUeK2qi3pPfmJusM=
X-Received: by 2002:a17:906:8a62:b0:94f:969e:c52b with SMTP id
 hy2-20020a1709068a6200b0094f969ec52bmr14977106ejc.74.1682536412045; Wed, 26
 Apr 2023 12:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-3-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:13:20 -0700
Message-ID: <CAEf4Bzb5H6caJ24HWhRnOmqOU9nbqruDp1MP0pcStqd8OyvhJQ@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 02/20] bpf: Add cookies support for
 uprobe_multi link
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 9:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to specify cookies array for uprobe_multi link.
>
> The cookies array share indexes and length with other uprobe_multi
> arrays (paths/offsets/ref_ctr_offsets).
>
> The cookies[i] value defines cookie for i-the uprobe and will be
> returned by bpf_get_attach_cookie helper when called from ebpf
> program hooked to that specific uprobe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h |  1 +
>  kernel/bpf/syscall.c     |  2 +-
>  kernel/trace/bpf_trace.c | 46 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 45 insertions(+), 4 deletions(-)
>

LGTM, one nit below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

>  static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
> @@ -2964,6 +2982,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprob=
e,
>         struct bpf_uprobe_multi_link *link =3D uprobe->link;
>         struct bpf_uprobe_multi_run_ctx run_ctx =3D {
>                 .entry_ip =3D entry_ip,
> +               .uprobe =3D uprobe,
>         };
>         struct bpf_run_ctx *old_run_ctx;
>         int err;
> @@ -3005,6 +3024,16 @@ uprobe_multi_link_ret_handler(struct uprobe_consum=
er *con, unsigned long func, s
>         return uprobe_prog_run(uprobe, func, regs);
>  }
>
> +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> +{
> +       struct bpf_uprobe_multi_run_ctx *run_ctx;
> +
> +       if (WARN_ON_ONCE(!ctx))
> +               return 0;

do we need this check?... seems redundant, tbh

> +       run_ctx =3D container_of(current->bpf_ctx, struct bpf_uprobe_mult=
i_run_ctx, run_ctx);
> +       return run_ctx->uprobe->cookie;
> +}
> +

[...]
