Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFBF485D04
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 01:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiAFAUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 19:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbiAFAUY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 19:20:24 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9D4C061245;
        Wed,  5 Jan 2022 16:20:24 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 19so1155757ioz.4;
        Wed, 05 Jan 2022 16:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afHwasYWtel71T52UF7stDnTAfOaNsd9+7/dlmmkp60=;
        b=j9+paRHLfU86rGo/8JxWy0jxYPGO7vx04QCljY1ltgDQioRJMOXp7KUEsCm+S5PCOA
         /d2RoIfCdYwlqY5pbU6jVYMBYZErWVkXcM2dRAR2tRgy+zs+LNWFwi+Q7rcXPQJvxVFY
         g/StW1He75P4ddLV7MsJBPQhAQFXfA6IOzT73pL2QqbFJgYUFdPX6ULaxmAp/6A4PAmK
         xscGgjarrP3o1MIc5GQjUaWvP2LdFWt7EOUERGL+7RLYT695+9lv0z5LfGg14BZFg6Cd
         /fAILBbkmKoDEdoiS+cErjWz2I6TJ2z9SRosqWI3FSXx6BcLzuUzx6ifX5jkbWS//DX/
         XpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afHwasYWtel71T52UF7stDnTAfOaNsd9+7/dlmmkp60=;
        b=aiOfIiDKMqH3H65mqc4D143ltHWOKoVTv5sHWcUkzOQQPdNvQ862t/LO8AgYzK2NIw
         t0YFCrNzc1oQja2hjqpDm1/j2j+9GAqtSI+0nGP7aewglwRXk6NSb/pwu8gVgcJcF4Q3
         OB5vogqTYM+rv0LO3Vvqk/beZRs3vKuaZ/BrCOBE3dbAesqDe4Wrjp+KYmnsjAO7OljC
         rNj1vd8kueKdf/U/somdxPPxnTPZKWzKf0ydy9bRcx4DgidX9juxMsG9+X4NnNQ6b6jn
         CEieRF1958uwv80wgfjUIqsyd45h34MeAoNagLMtCg/BClCM785RBafi1ABCgBNhNOwe
         IAGA==
X-Gm-Message-State: AOAM531HWUbGeGsgj4kCdDvMmvTOQ+xoTP7kCepkHmK/OIoDCle/Gw7w
        wfPUkNFN8WMJScuJAYTZpCYToznUSDPzE086IZwQlUD8
X-Google-Smtp-Source: ABdhPJxyHijY8s6F5fJC8AKhMnRGVck93Q/Qv8hknLhHhPztfuEk7qbgtStelyrYbiG6F+nRmd5EDtdwIVRkFexTp8w=
X-Received: by 2002:a05:6602:1495:: with SMTP id a21mr26989851iow.79.1641428423481;
 Wed, 05 Jan 2022 16:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20220105230057.853163-1-christylee@fb.com> <20220105230057.853163-4-christylee@fb.com>
In-Reply-To: <20220105230057.853163-4-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 16:20:12 -0800
Message-ID: <CAEf4BzY--+cSM0rWP3yWUyaqfxSr-CrvAV+s9muGoKrxv7Avww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] perf: stop using bpf_map__def() API
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 5, 2022 at 3:01 PM Christy Lee <christylee@fb.com> wrote:
>
> libbpf bpf_map__def() API is being deprecated, replace bpftool's
> usage with the appropriate getters and setters.
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  tools/perf/util/bpf-loader.c | 58 ++++++++++++++++--------------------
>  tools/perf/util/bpf_map.c    | 28 ++++++++---------
>  2 files changed, 39 insertions(+), 47 deletions(-)
>

[...]

> @@ -1304,7 +1296,7 @@ bpf_map_config_foreach_key(struct bpf_map *map,
>                            map_config_func_t func,
>                            void *arg)
>  {
> -       int err, map_fd;
> +       int err, map_fd, type;
>         struct bpf_map_op *op;
>         const struct bpf_map_def *def;

missed this one and another bpf_map__def()? A small pro tip is after
marking some API as deprecated since v0.8 (for example), locally mark
it as deprecated since 0.6 or 0.7 (current or older version) and build
all the typical suspects (perf, bpftool, selftests, etc) to let
compiler complain about any missed references.

>         const char *name = bpf_map__name(map);
> @@ -1330,19 +1322,19 @@ bpf_map_config_foreach_key(struct bpf_map *map,
>                 return map_fd;
>         }
>
> +       type = bpf_map__type(map);
>         list_for_each_entry(op, &priv->ops_list, list) {
> -               switch (def->type) {
> +               switch (type) {
>                 case BPF_MAP_TYPE_ARRAY:
>                 case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
>                         switch (op->key_type) {
>                         case BPF_MAP_KEY_ALL:
>                                 err = foreach_key_array_all(func, arg, name,
> -                                                           map_fd, def, op);
> +                                               map_fd, map, op);

double check argument indentation

>                                 break;
>                         case BPF_MAP_KEY_RANGES:
>                                 err = foreach_key_array_ranges(func, arg, name,
> -                                                              map_fd, def,
> -                                                              op);
> +                                               map_fd, map, op);

and here


>                                 break;
>                         default:
>                                 pr_debug("ERROR: keytype for map '%s' invalid\n",

[...]
