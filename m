Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35991453FEE
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 06:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhKQFXx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 00:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhKQFXx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 00:23:53 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBFBC061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 21:20:55 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i194so3803959yba.6
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 21:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSnOhBdo7nIssGtC/kMfshOI6+QT3XFzLh+A325DbvM=;
        b=PLRMXbODa4Vv8LIeX00GdxQQEs8+wIkx99MTZ9HJyAVCmCH655J8UrSuZ4uPSd+G08
         GcVszW9/9F7TOLNXK69idxjyzl3OhBaWt4VWwjpUz9keYs8VfPNJhdU1cfAb6OgnG36g
         sKA05rY22Xsj1j+w/zmKLk2R60ZCBRS3mbJX2f4SE4fmdSXzX9QRjap36ocehHWxpt8+
         mguVE7TG16HJyqAfOxH8kVlDyvCCZqqroZOH/6GcRFib0SztNba2HsPjY9UbS60Zk4Uq
         C5rUsfFPpNdO0eSwpd0E4R7gOJ+qxjZ3o7Cu7/m/nsmB+2+miC8knnP50Ld6hJhVyPtz
         3tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSnOhBdo7nIssGtC/kMfshOI6+QT3XFzLh+A325DbvM=;
        b=B9gY8+6qkKzpDN4MXG0vTVdnJUkAh1Io38UgIBychJAoaI1xoc2iXNQ9Ae05waSRW7
         Vb9wuerveawxyimND0L9DN9J4w5g8n1Y5zBuBRaU7Oihd0BJwhAjWyeWZYOuUPF6sgWw
         uH3l/afLXLqkwles1SbbrGToLOuNBwGXijnko/f8eK4V3Mz8tmmqXxWhKbU3vhEyF0ni
         RY0efaHYLPxdTzFfq51O/mmpoL2GmCjVef1z9mJY0aeO8+StZCvgFbFxitVz7M88AEQe
         LGSQYaM3U8GO6Jv+LiMFM7bMaHUG1SXMRN57lXlMh+pI2Uw/BvYS37tw+7jfvgDFw3/h
         2UMA==
X-Gm-Message-State: AOAM530DEvj6dimP8oEC+TLOecdAYWjPbbtzjWCHd4rGr86md4konIWL
        v1jzY0eTKyOe+53w/xXEz1tsDYHvHjX4UYsTsic=
X-Google-Smtp-Source: ABdhPJx5gPZMVg90LYJaDxq8N5br2QKplFm7R6JojgQG4JtQB+dvGWqHorCjy2xj1RDROspv/2UCSCyBB94nrTk9qoE=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr14956232ybj.504.1637126454486;
 Tue, 16 Nov 2021 21:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20211115191840.496263-1-memxor@gmail.com> <20211115191840.496263-4-memxor@gmail.com>
In-Reply-To: <20211115191840.496263-4-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 21:20:43 -0800
Message-ID: <CAEf4BzaNrXU1rDwHw14aoQYrwY5nWWyFmzgTrpRxVT2yNWHUCQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 3/3] tools/resolve_btfids: Demote unresolved symbol
 message to debug
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Pavel Skripkin <paskripkin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 15, 2021 at 11:18 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> resolve_btfids prints a warning when it finds an unresolved symbol,
> (id == 0) in id_patch. This can be the case for BTF sets that are empty
> (due to disabled config options), hence printing warnings for certain
> builds, most recently seen in [0]. Hence, demote the warning to debug
> log level to avoid build time noise.
>
>   [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com
>
> Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
> Reported-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index a59cb0ee609c..833bfcc9ccf6 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -569,7 +569,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
>         int i;
>
>         if (!id->id) {
> -               pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> +               pr_debug("WARN: resolve_btfids: unresolved symbol %s\n", id->name);

This is an important warning that helps detect some misconfiguration,
we cannot just hide it. If it really is happening for empty lists
(why?), we should handle empty lists better, but not hide the warning.

>         }
>
>         for (i = 0; i < id->addr_cnt; i++) {
> --
> 2.33.1
>
