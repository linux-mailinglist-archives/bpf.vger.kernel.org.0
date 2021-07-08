Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EF3C1A8C
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGHUf7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Jul 2021 16:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGHUf7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Jul 2021 16:35:59 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1AAC061574
        for <bpf@vger.kernel.org>; Thu,  8 Jul 2021 13:33:15 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i18so10996504yba.13
        for <bpf@vger.kernel.org>; Thu, 08 Jul 2021 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ie6tHJnyaj5wCXmWHpx3zuiEq63TIri4SDpLXKzH73A=;
        b=vWBEeJ2sDLf7H38+RrEdNdaQmiEyFPqcR14gTc04oGcr9Ot69m1508agp7sOd6WcHN
         kThrnr1GYB9RZqtjN9jZBxLtTUb+uuov3NlYlnxFJLAUBZBh3sYN3LTP/WOAfjhDeDKC
         tLazJL89QIcjSCO+l6IFCwew8B2W8M8YBjQYEgkORso/5tVdYmLn7NcDF4eb8P5B7X+U
         ibXqLNZbpU6BT+WxxdL7BHwhH1yDTSVlWoHkOl6UyFzeNMR3fx+5Ow01ngD1gjynzp7T
         B8Bzhuli7ydwYd5f4anOYOZoJf+zM5PrgJak4VUcol6O+B+fBgvtYzQnpI4vQttFjomr
         GO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ie6tHJnyaj5wCXmWHpx3zuiEq63TIri4SDpLXKzH73A=;
        b=MID8LTtWXgsrO80I+Ix0zx/PXAFaF0D8OuOONRkeu8nsnRNsOvVxSLe681MQjkmcxS
         gtODl3gM0EQf/+hV/bnUX+2OnGMNLIvPY8fyYMd3UyDS+L7f0A4oZvFGw4DHOddRahnZ
         wuCvxa6+3ft9GK95cYRHszTI5A2sJZ4cBJVxKfOOeznB+LU/4V8UqOaxTbFCj5HECBHP
         uAnObrsIhirfGuSudHFVURHIc2yQyR+9W6pydIvJX2T1RoAi/KTXbAUS1SxdZwTr7XJ9
         aTfz6VCdIhjcKouJjcokyLi5RrhjshYlH7IUUksQvr6+DWpCDwdm+eTx5vzxXJqkgD1H
         R32Q==
X-Gm-Message-State: AOAM530eGCgbs0Y7ChJui4rtVhYjXxtPsua9/9YKsaa6/zdwIGAAQREM
        ySGN9HgDnWHfGy4P2Qshfb9W9ZFHrl1+O8ZdpGU=
X-Google-Smtp-Source: ABdhPJzZbQo3XYT7RZ6Z2YvfUwaVB/tLWRVzjBxu08c4oUS4kKEETDiAzXHucn+OLRIoZ37/ZeW5x8A5FnbO+jInkPM=
X-Received: by 2002:a25:1ec4:: with SMTP id e187mr41263583ybe.425.1625776395013;
 Thu, 08 Jul 2021 13:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210705190926.222119-1-m@lambda.lt> <CAEf4BzaHCgNSfoEVXkBweycHtVj2MKBBH45aZy+FM-BTjSJ3kA@mail.gmail.com>
 <4f2a546f-8d78-df2e-69eb-75055ff4137d@lambda.lt>
In-Reply-To: <4f2a546f-8d78-df2e-69eb-75055ff4137d@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Jul 2021 13:33:03 -0700
Message-ID: <CAEf4BzYaQsD6NaEUij6ttDeKYP7oEB0=c0D9_xdAKw6FYb7h1g@mail.gmail.com>
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

On Thu, Jul 8, 2021 at 8:50 AM Martynas Pumputis <m@lambda.lt> wrote:
>
>
>
> On 7/8/21 12:38 AM, Andrii Nakryiko wrote:
> > On Mon, Jul 5, 2021 at 12:08 PM Martynas Pumputis <m@lambda.lt> wrote:
> >>
> >> When loading in parallel multiple programs which use the same to-be
> >> pinned map, it is possible that two instances of the loader will call
> >> bpf_object__create_maps() at the same time. If the map doesn't exist
> >> when both instances call bpf_object__reuse_map(), then one of the
> >> instances will fail with EEXIST when calling bpf_map__pin().
> >>
> >> Fix the race by retrying creating a map if bpf_map__pin() returns
> >> EEXIST. The fix is similar to the one in iproute2: e4c4685fd6e4 ("bpf:
> >> Fix race condition with map pinning").
> >>
> >> Cc: Joe Stringer <joe@wand.net.nz>
> >> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 1e04ce724240..7a31c7c3cd21 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -4616,10 +4616,12 @@ bpf_object__create_maps(struct bpf_object *obj)
> >>          char *cp, errmsg[STRERR_BUFSIZE];
> >>          unsigned int i, j;
> >>          int err;
> >> +       bool retried = false;
> >
> > retried has to be reset for each map, so just move it inside the for
> > loop? you can also generalize it to retry_cnt (> 1 attempts) to allow
> > for more extreme cases of multiple loaders fighting very heavily
>
> If we move "retried = false" to inside the loop, then there is no need
> for retry_cnt. Single retry for each map should be enough to resolve the
> race. In any case, I'm going to move "retried = false", as you suggested.

Right, I was originally thinking about the case where already pinned
map might get unpinned. But then subsequently rejected the idea of
re-creating the map :) So single retry should do.

>
> >
> >>
> >>          for (i = 0; i < obj->nr_maps; i++) {
> >>                  map = &obj->maps[i];
> >>
> >> +retry:
> >>                  if (map->pin_path) {
> >>                          err = bpf_object__reuse_map(map);
> >>                          if (err) {
> >> @@ -4660,9 +4662,13 @@ bpf_object__create_maps(struct bpf_object *obj)
> >>                  if (map->pin_path && !map->pinned) {
> >>                          err = bpf_map__pin(map, NULL);
> >>                          if (err) {
> >> +                               zclose(map->fd);
> >> +                               if (!retried && err == EEXIST) {
> >
> > so I'm also wondering... should we commit at this point to trying to
> > pin and not attempt to re-create the map? I'm worried that
> > bpf_object__create_map() is not designed and tested to be called
> > multiple times for the same bpf_map, but it's technically possible for
> > it to be called multiple times in this scenario. Check the inner map
>
> Good call. I'm going to add "if (retried && map->fd < 0) { return
> -ENOENT; }" after the "if (map->pinned) { err = bpf_object__reuse_map()
> ... }" statement. This should prevent from invoking
> bpf_object__create_map() multiple times.
>
> > creation scenario, for example (btw, I think there is a bug in
> > bpf_object__create_map clean up for inner map, care to take a look at
> > that as well?).
>
> In the case of the inner map, it should be destroyed inside
> bpf_object__create_map() after a successful BPF_MAP_CREATE. So AFAIU,
> there should be no need for the cleanup. Or do I miss something?

But if outer map creation fails, we won't do
bpf_map__destroy(map->inner_map);, which is one bug. And then with
your retry logic we also don't clean up the internal state of the
bpf_map, which is another one. It would be good to add a self-test
simulating such situations (e.g., by specifying wrong key_size for
outer_map, but correct inner_map definition). Not sure how to reliably
simulate this pinning race, though.

Can you please add at least the first test case?

>
> >
> > So unless we want to allow map re-creation if (in a highly unlikely
> > scenario) someone already unpinned the other instance, I'd say we
> > should just bpf_map__pin() here directly, maybe in a short loop to
> > allow for a few attempts.
> >
> >> +                                       retried = true;
> >> +                                       goto retry;
> >> +                               }
> >>                                  pr_warn("map '%s': failed to auto-pin at '%s': %d\n",
> >>                                          map->name, map->pin_path, err);
> >> -                               zclose(map->fd);
> >>                                  goto err_out;
> >>                          }
> >>                  }
> >> --
> >> 2.32.0
> >>
