Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B1E3EEF03
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhHQPT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbhHQPTR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 11:19:17 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03453C061764
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 08:18:44 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z18so40068006ybg.8
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jg67F8OOHQz+zTxn7kxABZfCNuvHaYBdiJ7+o96IIm0=;
        b=JndUB9MzwCaUq2fnIcUQ0vnngbvmOjYgdVEJ6XWjOtpXMHHlD8C80FSPciOtUa7pmR
         JHZZkvcpdy8vYwbrJxJEOTquCBen+IJ51XDmce8TnIZqB3MRkJFC0Hlx6eWaH9P+ndmH
         APU4ERUdioSMc7xcDrtv00oYkZng71vQLeF+iZHl0Sqxu6gCYb/nV9aPILO+TRfVHOiw
         FEePvBT+mfEa1YdxMHRaq1uIq6tSecaDiUs6wzHtUHfQSzZIuJ+Ms5Tz4lP9E2aR0Zas
         VUwWaThH/mZzQ6Hg3nJYN8FXYhzfRxKm8R8uOW6hp22qHaTkoTMvgNzwg/NS4KGM2PVU
         aMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jg67F8OOHQz+zTxn7kxABZfCNuvHaYBdiJ7+o96IIm0=;
        b=snkEKxM2jfjXHHO2SR+93bRtVd6r1BdLZ3ZalLkEYfw21P5lbsXMDEgp0jfcAnsiPB
         x1APJjSgGTJCb40nXWSncdV7iemsWDz/rQ+ll+22hWsp2rzEucyFDmfqYxPizsk7/9nn
         NJBP6D2X+psGq8S6JTGJWouH6wofPiCADBb5R091M3oqRxQgyTgRDTI7C04yjgub6/a5
         TQyZV8cpVNk22+a9lnD2ky+GJuJ9fbILTkynl9rztY0P5eDWSM6PF5iXQtUgufzOC0a6
         W0q9Cw4JiPc/tExBCEyWkaA3v0k4M1Sk9U0fKGac2R+TrtBIhiN2gacEF1HkRlzEktRz
         YJDQ==
X-Gm-Message-State: AOAM532rvmyBUkxLvri8xKm73vlY4JGAplPbST9j4dvRk5ey9rf41dlb
        p5ujtKgdeugBPVQxYX00h1KfSFLsbfZgK5C7Ay4=
X-Google-Smtp-Source: ABdhPJylCwm2a4+1hZXyDbGo1v/Q89/r/FljAPliMWY5sqbNNS7aAQG3JGMC4u2/D+OEdFlEYFu/9Q+8+/rETo05ANE=
X-Received: by 2002:a25:cc52:: with SMTP id l79mr4930715ybf.459.1629213523317;
 Tue, 17 Aug 2021 08:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210817045713.3307985-1-fallentree@fb.com>
In-Reply-To: <20210817045713.3307985-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 Aug 2021 08:18:32 -0700
Message-ID: <CAEf4Bzbf--d1tVFe_9FjqPyXPEauJ89cP-LvO7jRhFqD6TqSPA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] selftests/bpf: Add exponential backoff to
 map_delete_retriable in test_maps
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 9:57 PM Yucong Sun <fallentree@fb.com> wrote:
>
> Using a fixed delay of 1 microsecond has proven flaky in slow CPU environment,
> e.g. Github Actions CI system. This patch adds exponential backoff with a cap
> of 50ms to reduce the flakiness of the test. Initial delay is chosen at random
> in the range [0ms, 5ms).
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---

Thanks for the fast follow-up! Applied to bpf-next. Let's see what
pops up next :)

>  tools/testing/selftests/bpf/test_maps.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 2caf58b40d40..340695d5d652 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1420,11 +1420,16 @@ static int map_update_retriable(int map_fd, const void *key, const void *value,
>
>  static int map_delete_retriable(int map_fd, const void *key, int attempts)
>  {
> +       int delay = rand() % MIN_DELAY_RANGE_US;
> +
>         while (bpf_map_delete_elem(map_fd, key)) {
>                 if (!attempts || (errno != EAGAIN && errno != EBUSY))
>                         return -errno;
>
> -               usleep(1);
> +               if (delay <= MAX_DELAY_US / 2)
> +                       delay *= 2;
> +
> +               usleep(delay);
>                 attempts--;
>         }
>
> --
> 2.30.2
>
