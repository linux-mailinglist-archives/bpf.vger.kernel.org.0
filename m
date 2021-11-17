Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDF453FE4
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 06:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhKQFO0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 00:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhKQFO0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 00:14:26 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A1AC061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 21:11:28 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id q74so3668276ybq.11
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 21:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGE8eRpF9DMzm/+OAi0ISyojj5fR+OmUUaiVgM7m8kA=;
        b=DsAVcgfuOzH3CEYycFcEJROsgr++r8QJof/4BjpV75favBz9f15B+l7Onqdiy8KoYz
         nfVAQyoSBYHTOEawy4k8pCumAp7HjZgidRCy8Y0EmJoVA6g70OShShvYYVhbW6k0V1fM
         0xeQFQlNdUQBbmCaCSUj3ghVT2v9AqOQYbfnLx9u2eCSh/9xud7gr42UDRTqQ1Q0AZVC
         AyP8z5qav0cbo7YYFGRKyyXw6D5xAqs8G5DMa5vsY7vG+dRMJtHinjF075rl1tFuwZ6/
         AF5j7iLt8j5bXSWn8TfrDdDH4Eu0j5G7yF56Dy11FTueKe2Oz4IlOR6qcUlbS81yLu2q
         +XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGE8eRpF9DMzm/+OAi0ISyojj5fR+OmUUaiVgM7m8kA=;
        b=0oQ1SnsDbupeNZaUf3oiga/umdxW0jBVXLLM2YKci9kbSHrW103TmPnS4+SZ16uWKH
         JFiScSDpJS547xvy1hKOE1/GSPdserJM7Xes8c34BzneTt92Z9GQLL6otZ/FNaeN9pRJ
         EpPPlXpNe9BaaxnJS5tiTP8yCb2btOv8Wgh8Ojuhgt54GbCMxqy9oFNmZqG87n2Njarm
         lKupPhKy3pdfFfGACFDKUAGoOVa9nHN77pqVtqKCgRj7Y9JPkpP+A/KptiUg4FjgeQtk
         LTEP7ddgz2P2oEZMXHB1WYOfTkJYB8ougjfxCkSn6o8cat1DvrW4wsLqfa+mgCDJr3j2
         uusw==
X-Gm-Message-State: AOAM5330lxIVZEL6KTiuEl1zQZThMbQ+4i0WKRkSAuKHWYeGnv1ItLki
        AWIw57+iPa/ahywlzOPlEVzOgjbU4ST5g5UhwcA3xWKy
X-Google-Smtp-Source: ABdhPJwmk8absi3UI1jhr51cdDvLqNKcz2OE5m2ey9l3Wh8Rh/l+Z6F/V/Qlr0ttJE+EfgDdEqr7h07VR4Ng3uakAbw=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr14268117ybf.114.1637125887675;
 Tue, 16 Nov 2021 21:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20211112192535.898352-1-fallentree@fb.com>
In-Reply-To: <20211112192535.898352-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 21:11:16 -0800
Message-ID: <CAEf4BzZ+z2-LN2rvg1Fnxt3xKdU4AJfuL_fVDb0ZRrJeSqdDcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: improve test_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 12, 2021 at 11:29 AM Yucong Sun <fallentree@fb.com> wrote:
>
> various improvement to test_progs, including new '--timing' feature.
>
> Yucong Sun (4):
>   selftests/bpf: Move summary line after the error logs
>   selftests/bpf: variable naming fix
>   selftests/bpf: mark variable as static
>   selftests/bpf: Add timing to tests_progs

I've applied the first three fixes as they are completely independent
from the timing feature. Let's continue discussion on timing
separately.

>
>  tools/testing/selftests/bpf/test_progs.c | 153 +++++++++++++++++++----
>  tools/testing/selftests/bpf/test_progs.h |   2 +
>  2 files changed, 134 insertions(+), 21 deletions(-)
>
> --
> 2.30.2
>
