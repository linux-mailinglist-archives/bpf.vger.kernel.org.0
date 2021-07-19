Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F403CF099
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 02:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbhGSXcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 19:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391379AbhGSW0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 18:26:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE70C0610CF
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 15:58:42 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p22so30232774yba.7
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 15:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=In4vAXf0YMUsYCOzHvW3y8PXvW5JTmoItXJtcPBdR28=;
        b=tOWsvcSG5uTxa1fwD45waDZqGcTDqsOBtzdF2QwHl0rKWaP4HpL6UuzxipJ00Zk2mw
         oUufLZwGw7M6yRnTeQKq3vf7cMTvlnzPjSS6UpbmnKaVxVmDLjHhinIJ0JIpSQ3IF52I
         s/aLFy2S3FnI2nrdH4aS93oUsCUSghgGD3yP7q8FSgdHQqfhKf1PvTtajqFsd32LMYEh
         IlSDhrRE4+oxCC1igZNvDC+u9NYcZ8Yi5C8lepp4x+M0lHZcWbvUYiFTaf/Li6eAXJlO
         MXJYr5JPzOkwl9Dd9hRsD7zKfgdPXCM4oWWWtI1z4CfYWoW+IbZQ/m5stiaXyZhiXpyF
         NkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=In4vAXf0YMUsYCOzHvW3y8PXvW5JTmoItXJtcPBdR28=;
        b=a+YslSnLHwQa2/4pXmu4K5qiLx9IshCvYtvyASocf0gHGH+RxgTmk46jNqNO0fkYpr
         0nQnO89OYxhCpV4EGVtbVqEX/x3Yrn+4heU/rh6gkheHK90zGD35wgAbY5V5LTfBJb24
         2heZ/a18JRNPds7D/PbBepsuW7wufzJSM/f+YGNtpzwqRySDkjeLqYQrC6OFYraZT7+a
         C7Dl3KKPF08f10dv0TuxXxS7OO4HuuezPO3L43hAWiXelpNSgpGqN7Nes59/dkPYI2v2
         TIA1vERNeZOu9Bt94UWKmURLj866yY7YkMpt26LyR9ihQvOTOZG524QTwCKBUokM8D3K
         mY3A==
X-Gm-Message-State: AOAM5316It8Bkg8XyNqi8vHJKMCqQxlMf6oY5vA8Sx7QOQISDEfQBq+u
        e9fm56beBF+peqqJnGJ49YY7YMAM9goTRuA9roWATyA6SKQ=
X-Google-Smtp-Source: ABdhPJwCx4kQjzD7+fPgNzpap41XXzHL2jSwj2D3xoucWNXRczCZTfmuvPjfKODW9IbXmCvMOUpR94NlPOp8OEVlF58=
X-Received: by 2002:a25:9942:: with SMTP id n2mr35321568ybo.230.1626735521982;
 Mon, 19 Jul 2021 15:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210719173838.423148-1-m@lambda.lt> <20210719173838.423148-2-m@lambda.lt>
In-Reply-To: <20210719173838.423148-2-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Jul 2021 15:58:30 -0700
Message-ID: <CAEf4BzbjVdG57QuhvpxAuq8qz+T3+DbP28_CpF2Y4v1AmwkDKw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] libbpf: fix removal of inner map in bpf_object__create_map
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 19, 2021 at 10:36 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> If creating an outer map of a BTF-defined map-in-map fails (via
> bpf_object__create_map()), then the previously created its inner map
> won't be destroyed.
>
> Fix this by ensuring that the destroy routines are not bypassed in the
> case of a failure.
>
> Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>

Please preserve received acks between versions (unless some
significant changes happen between versions invalidating the original
ack):

Acked-by: John Fastabend <john.fastabend@gmail.com>

Thanks, applied (with few adjustments) to bpf-next, given we lived
with this bug for a long while and no one ever noticed/reported it
(and BPF map will be cleaned up when the process exits anyway).
Keeping it in bpf-next will make it easier for follow-up patches
changing/enhancing bpf_map__create_map() and will avoid merge
conflicts down the line.

> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  tools/lib/bpf/libbpf.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6f5e2757bb3c..dde521366579 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4479,6 +4479,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>  {
>         struct bpf_create_map_attr create_attr;
>         struct bpf_map_def *def = &map->def;
> +       int err = 0;
>
>         memset(&create_attr, 0, sizeof(create_attr));
>
> @@ -4521,8 +4522,6 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>
>         if (bpf_map_type__is_map_in_map(def->type)) {
>                 if (map->inner_map) {
> -                       int err;
> -
>                         err = bpf_object__create_map(obj, map->inner_map, true);
>                         if (err) {
>                                 pr_warn("map '%s': failed to create inner map: %d\n",
> @@ -4547,7 +4546,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>         if (map->fd < 0 && (create_attr.btf_key_type_id ||
>                             create_attr.btf_value_type_id)) {
>                 char *cp, errmsg[STRERR_BUFSIZE];
> -               int err = -errno;

needed empty line here


> +               err = -errno;
>
>                 cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
>                 pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
> @@ -4560,8 +4559,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>                 map->fd = bpf_create_map_xattr(&create_attr);
>         }
>
> -       if (map->fd < 0)
> -               return -errno;
> +       err = map->fd < 0 ? -errno : 0;
>
>         if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
>                 if (obj->gen_loader)
> @@ -4570,7 +4568,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>                 zfree(&map->inner_map);
>         }
>
> -       return 0;
> +       return err;
>  }
>
>  static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
> --
> 2.32.0
>
