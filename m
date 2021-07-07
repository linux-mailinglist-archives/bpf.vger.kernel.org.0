Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4863BF222
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 00:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhGGWlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhGGWlo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 18:41:44 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7D0C06175F
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 15:39:03 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g19so5688075ybe.11
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CInolWkjka4YkrrNE0uUpeI7eDmXu/P/OnqT82g/gxA=;
        b=PZe5eNo47W2O6JWl6IvEyFZ2j8vMH6W+Yqd7xmUrWfgjwH+reiCDGVL+kO8Qp4DDvy
         FAMrGQS06HmJprdYnBe65unEeBzL4mBY/mrQDwHQRBgJtsGTeL0OpZOdhkLDytQZE6z6
         3SgofXsS/J6n7bCPM86MMj5RudY5nQXCpCaK/YcnGiDwDQ6vcXtXqJEXJU1LKAuDJeKs
         7Vr3Q8XPNNe4sXitkoDIrYTYQYieCMlNWaHY+NdeymTCsr8i42wLHiZh6dk/gFE3A0gn
         2uitjGokmLkXiTfDlTQ9WuL3uP1r5ipIxlInzb/aAU5rAIvCzu3JuWGMn2Iw89cJqQkZ
         Txww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CInolWkjka4YkrrNE0uUpeI7eDmXu/P/OnqT82g/gxA=;
        b=GQvWxGiua6YSY8S0rlr2/n7p1IbXPaApke+oTljJnC8z4HFZ6Yft+/VqcIBDU7F5Ne
         m54bH3vt+a2qu1meI2Q433ycBievAmmIY9yI7FFCkluRwins3oHra8KP0LGCL91dH0E/
         57mLp5QMQLwQii+raC61zZgDGo9/O+DWGlgYh2qiP2Va2irF7hR2jQ1d+SqYtDlRmC7n
         OEa5dW8bmFy7cRDlDUOsq5ZUfvO6abnR1ESZnuk80cV+VLO6TbH1QVa9eB8s4DEB5nH+
         zpz59Axg1ZUebZPRDfeJiMCjMD0wFzIyW/AZyvOGaRtiA4id68zNjj3KW77HjEic/hSO
         I4qw==
X-Gm-Message-State: AOAM530qRPgW42PUE9yzV7JFyYbMv96Zjs3PDlvrKwuttdMWbF1IIVr4
        iyf5wrETeISi1mJ9HPIb9PicSXQhNsp7SCi16gY=
X-Google-Smtp-Source: ABdhPJyZzr2DXM0rtwJ8mY0M1aog2DkL3T53V+Gw9B2k5a0+DFwxQwUEECybLe+HIL/10vyfwoGMH8Dkzqmj1TfH3uM=
X-Received: by 2002:a25:bd09:: with SMTP id f9mr36734272ybk.27.1625697542324;
 Wed, 07 Jul 2021 15:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210705190926.222119-1-m@lambda.lt>
In-Reply-To: <20210705190926.222119-1-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Jul 2021 15:38:51 -0700
Message-ID: <CAEf4BzaHCgNSfoEVXkBweycHtVj2MKBBH45aZy+FM-BTjSJ3kA@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix race when pinning maps in parallel
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 5, 2021 at 12:08 PM Martynas Pumputis <m@lambda.lt> wrote:
>
> When loading in parallel multiple programs which use the same to-be
> pinned map, it is possible that two instances of the loader will call
> bpf_object__create_maps() at the same time. If the map doesn't exist
> when both instances call bpf_object__reuse_map(), then one of the
> instances will fail with EEXIST when calling bpf_map__pin().
>
> Fix the race by retrying creating a map if bpf_map__pin() returns
> EEXIST. The fix is similar to the one in iproute2: e4c4685fd6e4 ("bpf:
> Fix race condition with map pinning").
>
> Cc: Joe Stringer <joe@wand.net.nz>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  tools/lib/bpf/libbpf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1e04ce724240..7a31c7c3cd21 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4616,10 +4616,12 @@ bpf_object__create_maps(struct bpf_object *obj)
>         char *cp, errmsg[STRERR_BUFSIZE];
>         unsigned int i, j;
>         int err;
> +       bool retried = false;

retried has to be reset for each map, so just move it inside the for
loop? you can also generalize it to retry_cnt (> 1 attempts) to allow
for more extreme cases of multiple loaders fighting very heavily

>
>         for (i = 0; i < obj->nr_maps; i++) {
>                 map = &obj->maps[i];
>
> +retry:
>                 if (map->pin_path) {
>                         err = bpf_object__reuse_map(map);
>                         if (err) {
> @@ -4660,9 +4662,13 @@ bpf_object__create_maps(struct bpf_object *obj)
>                 if (map->pin_path && !map->pinned) {
>                         err = bpf_map__pin(map, NULL);
>                         if (err) {
> +                               zclose(map->fd);
> +                               if (!retried && err == EEXIST) {

so I'm also wondering... should we commit at this point to trying to
pin and not attempt to re-create the map? I'm worried that
bpf_object__create_map() is not designed and tested to be called
multiple times for the same bpf_map, but it's technically possible for
it to be called multiple times in this scenario. Check the inner map
creation scenario, for example (btw, I think there is a bug in
bpf_object__create_map clean up for inner map, care to take a look at
that as well?).

So unless we want to allow map re-creation if (in a highly unlikely
scenario) someone already unpinned the other instance, I'd say we
should just bpf_map__pin() here directly, maybe in a short loop to
allow for a few attempts.

> +                                       retried = true;
> +                                       goto retry;
> +                               }
>                                 pr_warn("map '%s': failed to auto-pin at '%s': %d\n",
>                                         map->name, map->pin_path, err);
> -                               zclose(map->fd);
>                                 goto err_out;
>                         }
>                 }
> --
> 2.32.0
>
