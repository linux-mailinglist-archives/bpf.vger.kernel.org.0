Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E163D438D
	for <lists+bpf@lfdr.de>; Sat, 24 Jul 2021 02:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhGWXWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 19:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhGWXWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 19:22:23 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB2C061575
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 17:02:55 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k65so177394yba.13
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 17:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUZSIh16HVAR9CIhS3Z5hq7uRxQV1cQoR4dWam3ZP/c=;
        b=BipAAmEs0Hp/SfgohkLB5zhhVxSSP4o5w13Ex0djj7oIsZ0OsDFWXJYS1ewdDGqbq3
         VRYi/VAyE4g0iNbytP7pUDT2JB0AOqx3nAfXuWJWSM4xSvCmQtmlBysLznkHVPN1FayI
         jydmo8mTsPKt8upSv9h9RXw8rNeBj91BulplwMZ4WDGDZa7dqtHz0kJ5LfVQgxRlBRVC
         T8Qg5nc29D1Wgzj5/tg6IW+jPdJlgJ/6+g5aybV1dFhvkcyIU/gmNksy1vPXptXccU3E
         iLpAd07TXBZPpDAEkmcrD2sSGjJfuHY3y/SOyQAVBIsDkN2oUFP2aL1vajb+0E1LMloX
         ydfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUZSIh16HVAR9CIhS3Z5hq7uRxQV1cQoR4dWam3ZP/c=;
        b=AzSqCuvcj6PK5FTqxfJLa1v1JLjPQhpPAgJ0LlsSE2Puu0dgozzY2btH/uyK+Dvoaz
         0gVeDIwy2j8Wg4E+1GhtlFqtZBFS1qhYpvfrsMPl9J8jS9PThKSp40izhN8Sqt5sLi40
         iV8Y15N+wrz/nmRvqgAOaTMHpYZrIH+yf+H3eSnOXd1mDXElKM09Cve+/3S8yBNSBvuU
         HeDTxAiVCjCUcos5D6DNr3GwmvS+WH1jaD1qQUFKrX+jc/VcFBJJsU5VOL+GuwamKf70
         qPYyVYyiRe9F0OD0yop3MxZS8WQvU3aEkxna6m3uHujaHvn5aYo3x9ak5MaS8S2GiHSW
         HbHQ==
X-Gm-Message-State: AOAM530yZPFKdm1BlMm6+UUv3XegLIOs5azq4HumOr8zBhpg2c4gt3ea
        lDj1OSqbufMLwWYF63DUlDDNnu8Lu+01GxK8KU4=
X-Google-Smtp-Source: ABdhPJzCLhRXLlz2mGrnjZwDDMbPEf8DGRHwrkIizPMHOIJnOFd7YTMtMRkTcEyJm6rdFJ1/kJs2UDiPhMfwYvlsrk4=
X-Received: by 2002:a25:1455:: with SMTP id 82mr9486750ybu.403.1627084974330;
 Fri, 23 Jul 2021 17:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210723074323.55193-1-tallossos@gmail.com>
In-Reply-To: <20210723074323.55193-1-tallossos@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Jul 2021 17:02:43 -0700
Message-ID: <CAEf4BzZzXfigjYbN0JojTbJwx28+UOpdy8SEeQewYrDt9jBbQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Remove deprecated bpf_object__find_map_by_offset
To:     Tal Lossos <tallossos@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 23, 2021 at 12:43 AM Tal Lossos <tallossos@gmail.com> wrote:
>
> Removing bpf_object__find_map_by_offset as part of the effort to move
> towards a v1.0 for libbpf: https://github.com/libbpf/libbpf/issues/302.
>
> Signed-off-by: Tal Lossos <tallossos@gmail.com>
> ---

As explained before, I can't apply this just yet. We'll start removing
APIs right before 1.0 release. I'll update the issue mentioning this.

>  tools/lib/bpf/libbpf.c | 6 ------
>  tools/lib/bpf/libbpf.h | 7 -------
>  2 files changed, 13 deletions(-)
>

[...]
