Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481B73D0325
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhGTUAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbhGTTny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Jul 2021 15:43:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42CFC061574
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 13:24:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c16so229805ybl.9
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbPQtydOpOGkwFbr7R6q5nCxlKGUxfZhngP8ck+pmFQ=;
        b=rRkYfbF+c0nUllF/iR1cpNSVKAHYmy1CX1Gm8v/EiN4h2rDvOsrPwyz5+AJnsmT2l6
         K8mXCY3e4gRTGro3yjr9X7pdZMzCLsEkfSwxaytk9Cqx6cXceS4rXmYoQY0f4uQF48Bl
         l2fG/VRPCJX6+hNJWN4tat0PRrxQlEorUaMLBRsbEWm7Q1pgRnbZkyRUTUnC1xnnP2IX
         HuigCxk/EdL0LfYa14MX2I1MNPN8cpTflwMcOu29x7yLH1J8tkBiE+u0Q7zV+9Euql3P
         GjPdb5c6YW6a/rELewe75cXg9QRB2XV/iV3xW0MoNCK6f4B+vn5u0ktJVtgNlOCsPiKA
         SD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbPQtydOpOGkwFbr7R6q5nCxlKGUxfZhngP8ck+pmFQ=;
        b=lnpraV4Bz/CpceX4hsI3GUjwZcIQMkNbZxhXlIG/KAU+zEH81HhFtU/bpciGzDb433
         kzGSvCyqdKhKGIuODC1QG0vNSzNTJ/PdRRM46O6GqFUn4GfNv7vYC18mF7B2l1vl3pWG
         fBSPzZaY7S1C60O+uIVEnBIzrWbhsCOLB4bLSOwaf3srK0tZoBwVTIH1jXIbqlBaQ1cM
         58Pqs3v1X9pbGXbJMNW0bsDytw/eCBa8iGxhlU+NoNHMUx7osKZ06rKCGcNBlE4bwJTD
         re4UUNhgKz5SiZdPvxmZF+V2YCRe3BeDV/dCNN+A7a7OgsAMOQB/XdIlCGr8rmbXbwEJ
         usjQ==
X-Gm-Message-State: AOAM531ewS6fLxP9ZBnNmcICWVES0rqufhroEOaFGDTJcTlkDW6Pl40O
        qiP32Hj7YpkEuRYIPCBue0o9IBqp23Q4YD6IBsE=
X-Google-Smtp-Source: ABdhPJyRNtSBKnu95g1o+SMMOvH8LUDxta+FgdrI+kmklSq9Ax6LCoZvpUbNaoB0Mug701rQpRnO/pHo+l/1UPSHw7s=
X-Received: by 2002:a25:bd09:: with SMTP id f9mr40612823ybk.27.1626812670951;
 Tue, 20 Jul 2021 13:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210719173838.423148-1-m@lambda.lt> <20210719173838.423148-3-m@lambda.lt>
In-Reply-To: <20210719173838.423148-3-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Jul 2021 13:24:19 -0700
Message-ID: <CAEf4BzaHV6TnNr+0i6=qazDjnpY5hG2W7yNqeB-0Gh7aFT9mZw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: check inner map deletion
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 19, 2021 at 10:36 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> Add a test case to check whether an unsuccessful creation of an outer
> map of a BTF-defined map-in-map destroys the inner map.
>
> As bpf_object__create_map() is a static function, we cannot just call it
> from the test case and then check whether a map accessible via
> map->inner_map_fd has been closed. Instead, we iterate over all maps and
> check whether the map "$MAP_NAME.inner" does not exist.
>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  .../bpf/progs/test_map_in_map_invalid.c       | 26 ++++++++
>  tools/testing/selftests/bpf/test_maps.c       | 64 ++++++++++++++++++-
>  2 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
>

[...]

> +       map = bpf_object__find_map_by_name(obj, "mim");
> +       if (!map) {
> +               printf("Failed to load array of maps from test prog\n");
> +               goto out_map_in_map;
> +       }
> +
> +       err = bpf_object__load(obj);

Hi Martynas,

This now is producing this warning, when running test_maps:

libbpf: map 'mim': failed to create: Invalid argument(-22)
libbpf: failed to load object './test_map_in_map_invalid.o'

It's quite confusing, I think it's better to mute this. You can do
that by temporarily swapping libbpf's logger function to a no-op
function, ignoring all the warnings. We do this in few other places,
see libbpf_set_print().

> +       if (!err) {
> +               printf("Loading obj supposed to fail\n");
> +               goto out_map_in_map;
> +       }
> +

[...]
