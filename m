Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72C342790
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 22:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSVTr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhCSVTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 17:19:31 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E91C06175F
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 14:19:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e193so2872277ybc.6
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VzDNEsJZ9vi5ZA+3LPPt2bkm+WmI5zkVuzvnJyktsTw=;
        b=ZblVrey5cmJXAHHaIYCfI1YyXlxtRua9UdyQzA6/0OWwlqVfACC8SvayrUd+8FPt0Y
         4bCoX3VNRvAPrJd19/xEZvyBLDX+5MTIEuDJN11vJjxtSuKINXM/fG30kH9oUYiwUrty
         g9vHqBhFXTqSQOq09HQdE6yxLP8TypwaddX00F+nhQAEIfK9OAzxr2q+tI4YSEp6gksY
         eEJhjJpjojO12oWL9Za/GpKL7z4TBdzJvz64x6+Q/io4IQLSQR+Xy8gYu2ebcM3jdYYI
         HN7BKPNdec2f1HsCa7xuCqFBxk4RDNV60h+kfl1kLWDVoDSOBmi+IAADZXiUQ+aH08GE
         xsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VzDNEsJZ9vi5ZA+3LPPt2bkm+WmI5zkVuzvnJyktsTw=;
        b=KJa0tnz1qHcCr5Jy5YLHUOnSnkdwm5Cc6AYIOsrXzjfKReQOWBQiqjWuHVp8Nm3dNo
         p8BLSARZfuP/ubSxBM37+2lW1mWDn8C0fy5UujGXdrcqeouNpeh5ki0BhP0JLMkHIV+A
         jQ5IPdDMR35B10sOt/JWXkunBrREKxXsqF711GG2BR8IJGyF4msUTnRri2u6Y9wT3E2h
         oTz64Fqh7tQeV0N4S1O9w29itg8+RYWC4YTuUByfpHLbmSmTpC9H6vdvcXvCu4igWgAJ
         Il9LyIa4D1gKrkuU8sKSzgsjr0VAAN4sOGFQW7BHAFFDqmitT6o/ObQSMXgNx5C6jW20
         DB9Q==
X-Gm-Message-State: AOAM530zKQF54bsq5iW0PZZsh9zXmxD0JilWIDKRXmXes6+lwv8HtxFV
        c1O8MhV+cyAKrmNJG5UuQX/cefRO7t+MSw9n0x8=
X-Google-Smtp-Source: ABdhPJxV/5p9AS5/u8RPEh0M7SxfLUVIt9y9BJWChSNed3naY9SR8oOF2qDrnKvm0wO90vQOW+EPxrnZSWlJDUFrMmo=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr8909831yba.459.1616188770385;
 Fri, 19 Mar 2021 14:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210318122700.396574-1-jean-philippe@linaro.org>
 <CAEf4BzZzXxYxjzH86VYh0TvpW8u2+4qgAD1wMkRncYiiJ+2-0g@mail.gmail.com> <YFR7cOIV+kyHYzgJ@myrica>
In-Reply-To: <YFR7cOIV+kyHYzgJ@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Mar 2021 14:19:19 -0700
Message-ID: <CAEf4BzafQRMVGFkLtHzbbDvwZYjymzAkR0urzNk8y-RRon++Mw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix BTF dump of pointer-to-array-of-struct
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 19, 2021 at 3:22 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, Mar 18, 2021 at 10:08:36AM -0700, Andrii Nakryiko wrote:
> > Yeah, makes total sense. I missed that array forces a strong link
> > between types. The fix looks good, but can you please add those two
> > cases to selftests? There is progs/btf_dump_test_case_syntax.c that
> > probably can be extended. Please think about a way to specify types
> > such that the order of BTF types doesn't matter and the issue has to
> > be handled always.
>
> Sure, I'll add those selftests. I didn't figure out a way to trigger the
> error unconditionally, but given that the selftest is always built with
> clang it's still a good regression test.

Yes, that's fine. Thanks for the fix and tests, applied to the bpf tree.

>
> Thanks,
> Jean
>
