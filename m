Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D740A134
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 01:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349363AbhIMXC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 19:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbhIMXCu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 19:02:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C305C061224
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 15:54:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so636703pjw.2
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJMCKfM6ky3/rtWTiE8UDQTfsaqc02RyNfdo1PKZIzA=;
        b=Wn+SpxK/ROJe838NFCMpeW2cD8imN+Oove6iOwMrpmUZhpXvA8WN+v+un9CGKXEb1w
         PbBXJK6qbHl4y0NGFjiT9zoz7YRFiCev4gXtvNbdosOoz6fC9w/igatY/UhOS12cMBgR
         XXJMYpqKQ/hOTgcxaSsN+77Pe0mF0RNf9IYCSGgrBTByxg1I+xBDq4qFewovCDjvJ8CL
         esCY+SS4rp9yb1ZqdrzDvTQoS3+ZaIhIQ7ZMwj1yrWAfJPqxtvreYLYPpJHd0f1q6gGs
         xr4gRl3FKH/MWis0bcX+4cKXwOTg2y3pUDQ9Baapd+yhD7o+/PKyEh7wOHL/OLXHfz/Y
         uWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJMCKfM6ky3/rtWTiE8UDQTfsaqc02RyNfdo1PKZIzA=;
        b=iPG4Xg/oTTL2n8l9A46kuJG9zNDprpP7gCmllwnLjrbTkM+ZmHzpN6vT2Hoar3Djuj
         xCWPpzOXA5trcraAOw98XMclJWm0Ov1zkgCo+t2rsE/YFgtiumR95O1/2liyPBpDJH3F
         Tf24iVsGg8oYH3QPDuJPYajztv1uqHmxAe/+It8bsJz95RLLqO40ujZv7JrtntVtD75b
         25P3ZGmPyhZI7VA8CE4uIeBKs4Ubl7Lnjz9EXdPYPToXRtfTmbofeTEZNlJf42zn08I6
         2dlI4Wt3qc+/JK+zV8R+slJ9X6XiD+IBXT5X4N5IbZEYrsGtyNcd0mHbdcg8rQnKyJ/G
         MINw==
X-Gm-Message-State: AOAM530cABMgWthM29KSfWKIE/1Zm3sAi8DcP8ZFeDyRvf0DFvqowfI/
        AgJlcscJxXS7dcTW+TwU5pqcmn/FIFXu8XAe4HU=
X-Google-Smtp-Source: ABdhPJwT9eZQJnVbYct3M7bd+M3P+hKBsDZ8u1WKvKLS+Jo2J6SIwp1Pr1IbwtJTQGdamSV8li2fxmxySKLibhyAaig=
X-Received: by 2002:a17:90a:450d:: with SMTP id u13mr2037087pjg.138.1631573696678;
 Mon, 13 Sep 2021 15:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210913222309.3220849-1-andrii@kernel.org>
In-Reply-To: <20210913222309.3220849-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Sep 2021 15:54:45 -0700
Message-ID: <CAADnVQJ2qd095mvj3z9u9BXQYCe2OTDn4=Gsu9nv1tjFHc2yqQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: make libbpf_version.h non-auto-generated
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 3:23 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Turn previously auto-generated libbpf_version.h header into a normal
> header file. This prevents various tricky Makefile integration issues,
> simplifies the overall build process, but also allows to further extend
> it with some more versioning-related APIs in the future.
>
> To prevent accidental out-of-sync versions as defined by libbpf.map and
> libbpf_version.h, Makefile checks their consistency at build time.
>
> Simultaneously with this change bump libbpf.map to v0.6.
>
> Also undo adding libbpf's output directory into include path for
> kernel/bpf/preload, bpftool, and resolve_btfids, which is not necessary
> because libbpf_version.h is just a normal header like any other.
>
> Fixes: 0b46b7550560 ("libbpf: Add LIBBPF_DEPRECATED_SINCE macro for scheduling API deprecations")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Applied and reverted my earlier fix with FORCE.
