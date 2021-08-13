Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1C3EBE68
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 00:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhHMW41 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 18:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhHMW4Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 18:56:25 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC31C061756
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 15:55:57 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b132so5788411ybg.4
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 15:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zE5T6vQMUaaAi0jFP80DEizpk6vLnduNg2lmlZQZ0D4=;
        b=Mtuo8kCA6sAUV1BqHJMtMliD6mwS++GhqtbLK1kp9MOCHdbJPNh7vUZe7Mhc1txScP
         tDRGbEqYKrTBv9tkQpwqCMnfqY4lSWRxbRr9a3pKKv6HjPa/5BuVJ2ODJYnajdw8dRqG
         L5rDH1RRv/a1ibRaKJvnEvMW+HmLgCSJHbdwrQp0YWNutm9OmYIohi/Lz0qWns63+E1F
         hZB69c9rkrs3J8V/JxXgF/PqaNIidjQER0G0NdrX636o54d1nYHYYDOlEIO14FVlak0X
         4BrCqwylC7JNcvRz7rhcRxpdYhGjGJbJUveGMMhNDMYyxZKhJyvuDj3VsRX5yh04ovww
         CpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zE5T6vQMUaaAi0jFP80DEizpk6vLnduNg2lmlZQZ0D4=;
        b=GIOiFK63l4BuRfNJ37oQLlVzmk8R6odhVU0nLICd3RO0SLPDYxoo/mzf2BTZ3x64on
         hj5rmPHlEYE8rwDzFK4dNixl5+kVGHGbw6nT4iwX5WqBgXy9tmEnG/N2X6uu/538rCtv
         tqJmRtihrFY1DoTlw5iCw46v6ekdVagmJExmEpmMlN15ynscYo4ocdnmpinR3sFRRA/m
         BKxA7aT0DRX/PfCKJMIm2BZCaVEG5O2BTjTy3JwgHvsppJni2eFVtKyr4W9R+GR7ACDE
         JM9bwBE8wIfL21z5t3T+gmta0MFqmoPuLKRDJz5CQUXWDkUflk4dWNIsHtoOqJYWy0Cc
         9zlA==
X-Gm-Message-State: AOAM533aBG8h340ACfrYgwAncoMPfkCAUSP+PQgJlybgOv3wV2zi81bf
        6UMZJj3zOzeTSC4zRt7TKmAVbPYXGJvQlD7BIjU=
X-Google-Smtp-Source: ABdhPJyRieIvK1xL3VugugVwI0QtZ1DcLqwyFb8y2ykG/okdwmBnVXcdX4aOAH6qMWKuIXQDj9drWpZDVedJWRpeyZA=
X-Received: by 2002:a25:4091:: with SMTP id n139mr5896109yba.425.1628895356995;
 Fri, 13 Aug 2021 15:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210808215914.weaqxmsqgvmtbvep@bigdesk>
In-Reply-To: <20210808215914.weaqxmsqgvmtbvep@bigdesk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Aug 2021 15:55:45 -0700
Message-ID: <CAEf4BzaQ05XwCCRSRRN7McdUU=fAj3N+QGWTJaJJMQJ041yPUw@mail.gmail.com>
Subject: Re: Update percpu array from userspace?
To:     Yadunandan Pillai <ytpillai@thesw4rm.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 8, 2021 at 3:12 PM Yadunandan Pillai <ytpillai@thesw4rm.com> wrote:
>
> Hello,
>
> Conceptually, what would be the process behind updating a percpu map
> from userspace? Looking up elements is fairly simple to digest. (For
> example).

It's symmetrical to lookup. You have to prepare an array of values,
one for each possible CPU, and just pass that to bpf_map_update_elem()
call. You cannot update individual CPU value, it's all of CPU values
(for a given key, of course).

>
> -------
>
> int map_fd = bpf_create_map_name(
>         BPF_MAP_TYPE_PERCPU_ARRAY,
>         "map_name",
>         sizeof(__u32),
>         sizeof(__u32),
>         10,
>         0
> );
>
> int key = 4;
> int values[nr_cpus];
>
> bpf_map_lookup_elem(map_fd, &key, values);
>
> -------
>
> This gets the fifth element for each percpu array.
>
> But how do you update the values in each percpu array from the
> "values" array? If you can directly run bpf_map_update_elem() on the
> file descriptor, does that mean that the updated value is automatically
> replicated across all percpu arrays? What if you wanted to update a
> specific percpu array?
>

Why don't you just try and see how it works? In this case, if you
specify the same key (4), you'll update values (across all CPUs)
corresponding to key=4.
