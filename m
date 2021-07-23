Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032BC3D3226
	for <lists+bpf@lfdr.de>; Fri, 23 Jul 2021 05:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhGWCcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Jul 2021 22:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhGWCcG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Jul 2021 22:32:06 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990ADC061575
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 20:12:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v46so275307ybi.3
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/5Vs+a5tgpuXaytQELaR1MJ5pesNUM19bsSeStgrEM=;
        b=K5enKrQE5OXTlMnmKtmNamTBSLzkW0D4E94CMDDNTMNkMvds+cFKIrOw4VutQyw1y9
         ii83LzeUQ3XO+N1kwW+9JV3H1f3r/vrr8V/WQss5JoXIbMdQL5vxDgdZ3DD20+FQsG8X
         WGSwp9WL4zDIllbTrhfoR3g708Drbz+kmhNeByL+m7UV45QejH8gYC2nFAqxWx6GUMtm
         J4HbC4zGjsT3XYqSfhsy0ZBtZJ+PBIj9gPHCnKrmZw/1/8GTaj9GFv8Kn+b6Vnw1xnWE
         UxuB8vzIqby/sUUS4kk0oV3t7ijJP+UIy/ooObic00BZn1aXBHVzHECx6dh3PG3mESzJ
         8Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/5Vs+a5tgpuXaytQELaR1MJ5pesNUM19bsSeStgrEM=;
        b=EEAz7xBFERNaCpZAVRZlacNFqKFgai6LahTEWCYaBd42uESSamxQK26aWy8O5fkqzm
         Zh05yknWPxR9aTjLds9CyBIOT8SQJDkl+5KFiOHz0HtTdh9qn09wI75YuS/7ja4V6wOv
         q70Kp0kHHVFnbvpHdWOPW6isYn3wxbwI0z5dbnmeP/MEY990GNMb51sqmjaw7O+z+o9m
         /+tOfUzdHMeida4oMkGGA4xYb3JDj6k7im7ru1CP8OcEYCRYlH91QkGo4QSyNrSzKZDQ
         J3jhcZ2dXbSZj67uxEy7WhAkfkQl7dDAF/K4BL+t4jNCPudB1JeLpGmO74v7Iuj0SPgr
         K4fg==
X-Gm-Message-State: AOAM533ZjWAjBGBYq/gNL9K7U4RoR8Pu5UBGwjzxGr5W9L5blEQFvkGG
        lOomp7HbLGkdMPuhtqTkUOz3PEtmWueIGze32Fw=
X-Google-Smtp-Source: ABdhPJzbGvWIhCB2B7YKn76JfdP9YAxFPyEMcUhuHhIVJQg0uwjyOMkyf2jcpKbzikjVYBye7dXfAuSgJHyLyECILME=
X-Received: by 2002:a25:b741:: with SMTP id e1mr3645106ybm.347.1627009958960;
 Thu, 22 Jul 2021 20:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210722162526.32444-1-tallossos@gmail.com>
In-Reply-To: <20210722162526.32444-1-tallossos@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 22 Jul 2021 20:12:28 -0700
Message-ID: <CAEf4BzaJwBQvDhAYie-xSjQzUggr7FZVyVoa0X25TcfYxnWT=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Remove deprecated bpf_object__find_map_by_offset
To:     Tal Lossos <tallossos@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 22, 2021 at 9:26 AM Tal Lossos <tallossos@gmail.com> wrote:
>
> Removing bpf_object__find_map_by_offset as part of the effort to move
> towards a v1.0 for libbpf: https://github.com/libbpf/libbpf/issues/302.
>
> Signed-off-by: Tal Lossos <tallossos@gmail.com>
> ---

Thanks for helping with the libbpf 1.0 effort! But we shouldn't be
removing APIs until right before 1.0 release, otherwise we are
breaking backwards compatibility guarantees. So this will have to wait
until then (even though I don't believe anyone is using
bpf_object__find_map_by_offset() in the wild).

>  tools/lib/bpf/libbpf.c   | 6 ------
>  tools/lib/bpf/libbpf.h   | 7 -------
>  tools/lib/bpf/libbpf.map | 1 -
>  3 files changed, 14 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4c153c379989..6b021b893579 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9956,12 +9956,6 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name)
>         return bpf_map__fd(bpf_object__find_map_by_name(obj, name));
>  }
>
> -struct bpf_map *
> -bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset)
> -{
> -       return libbpf_err_ptr(-ENOTSUP);
> -}
> -
>  long libbpf_get_error(const void *ptr)
>  {
>         if (!IS_ERR_OR_NULL(ptr))
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6b08c1023609..1de34b315277 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -422,13 +422,6 @@ bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name);
>  LIBBPF_API int
>  bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name);
>
> -/*
> - * Get bpf_map through the offset of corresponding struct bpf_map_def
> - * in the BPF object file.
> - */
> -LIBBPF_API struct bpf_map *
> -bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
> -
>  LIBBPF_API struct bpf_map *
>  bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
>  #define bpf_object__for_each_map(pos, obj)             \
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 5bfc10722647..220d22b73b9c 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -38,7 +38,6 @@ LIBBPF_0.0.1 {
>                 bpf_object__btf_fd;
>                 bpf_object__close;
>                 bpf_object__find_map_by_name;
> -               bpf_object__find_map_by_offset;

we can't retroactively modify libbpf.map for already released
versions. I think once we are ready for libbpf 1.0 we'll just dump all
the non-deleted APIs into a LIBBPF_1.0.0 section without inheriting
from the last 0.x version.

>                 bpf_object__find_program_by_title;
>                 bpf_object__kversion;
>                 bpf_object__load;
> --
> 2.27.0
>
