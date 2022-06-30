Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3656219C
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiF3SCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 14:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiF3SCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 14:02:24 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6CF387B5
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 11:02:22 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i17so271242qvo.13
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+FEOtcsYVm/GvL3ZDcoQ3bdrjIvEyeVOUJqdpuITIc=;
        b=pJ/V6FCCmzx0kzvCsREEzipv3CIjwfr27dRd6xfTKry0nqmMz27t9Y+hMivHO5R/4k
         ep0MT4gC9oceYTf8o7dqTSS5lk3KvZBLU0U/UNm1h37rmfaiUIpxsohuEzh3S5M9DhtJ
         XEXcUE+0VvMVKQJejAWTr2d6gbXMR7JuA+bofXBZ/eVVKBGI3xAgRsX/0YOyu048vum1
         tV93LS6G31Q3iAgUKSL/BwCw+IjfS4kmNz8w763qPfOXiZk/HXgKELUeUSgN1SLrqRrC
         YR0xfbMBHcZ9RGc+H2fRY1RYoGyRlzBjT7uggCx5y+qfxDyOzLfeVC29Ebl7/Pxr7Guz
         gnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+FEOtcsYVm/GvL3ZDcoQ3bdrjIvEyeVOUJqdpuITIc=;
        b=yqgZPDrw5XMwPmCJgj8mzW+RfJUYqD1h7In9lX6aOopocY1gwh+mX6xPBfJvc+1irX
         vPTUxJsEHIC7LAC+429BhsSJ2EZL1YLuExwa9AgorTo/BmyCjJrw2IVmhy8lfWkaRweJ
         56cQ1gfLybnVdk53RSxA0I9crk8L0qWG38ciOvuhuvzIH0xC2UiwqIIOk/MRBwbyz+6c
         DeU2s0NCq0uUYRrDtSi+WX/FGKZPANOJdua15ry6A0fl0xTuu1j3pVSvqYpkRw4pagJo
         c5fBXjnQ7votYrF9Hco5VbDaIt0DrepmHfdX6YmOPPyq0yhNVA5Oj7anQ/pHYTcdx6+2
         pZwA==
X-Gm-Message-State: AJIora99ugEOLn8hoAzsktaNQYsW6YV19jCBXiNUhZHyOd/Qhk+9tTgq
        fhL3Mz1PbivFZ2cnuR5yg41HbBV2/jYH5cYNeR4vYg==
X-Google-Smtp-Source: AGRyM1tw3leiby/TQG3z7/nHnH542nBRiNfwgHIpkFGHWIX6lugMxmA4w33N95RG+GAI3iIRLEg8yy5qaQ1+pEPygI4=
X-Received: by 2002:a05:622a:1d2:b0:31d:2987:4c29 with SMTP id
 t18-20020a05622a01d200b0031d29874c29mr6741570qtw.565.1656612141422; Thu, 30
 Jun 2022 11:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220630135250.241795-1-hengqi.chen@gmail.com>
In-Reply-To: <20220630135250.241795-1-hengqi.chen@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 30 Jun 2022 11:02:10 -0700
Message-ID: <CA+khW7iP4XbZ4TPtQ7X2nWB_QXvUTJi3Y75d9Rd47E94aO4MzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow attach USDT BPF program without
 specifying binary path
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hengqi,

On Thu, Jun 30, 2022 at 7:07 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Currently, libbpf requires specifying binary path when attach USDT BPF program
> manually. This is not necessary because we can infer that from /proc/$PID/exe.
> This also avoids coredump when user do not provide binary path.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8a45a84eb9b2..4ee9b6a0944e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10686,7 +10686,19 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
>                 return libbpf_err_ptr(-EINVAL);
>         }
>
> -       if (!strchr(binary_path, '/')) {
> +       if (!binary_path) {
> +               if (pid < 0) {
> +                       pr_warn("prog '%s': missing attach target, pid or binary path required\n",
> +                               prog->name);
> +                       return libbpf_err_ptr(-EINVAL);
> +               }
> +               if (!pid)
> +                       binary_path = "/proc/self/exe";
> +               else {
> +                       snprintf(resolved_path, sizeof(resolved_path), "/proc/%d/exe", pid);
> +                       binary_path = resolved_path;
> +               }

Please add matching brackets for the 'then' clause.

Besides, do you need to call readlink() to extract the real path of
the binary? Reading /proc/$pid/exe may fail due to not being root.
Detecting such failures early and giving a warning would be great.

> +       } else if (!strchr(binary_path, '/')) {
>                 err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
>                 if (err) {
>                         pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
> --
> 2.30.2
>
