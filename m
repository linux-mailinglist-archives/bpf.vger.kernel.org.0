Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2E2AE7B8
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 06:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKKFGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 00:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKFGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 00:06:30 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B68DC0613D1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:06:30 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id s8so748825yba.13
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQOQXmVOjtFvjo2NMKMUWQnQ7P/3eXWd6E4bLesOoJY=;
        b=T5MpZ/xgPBnE/vFamoHZonQaQAz+s4LRnuBVhSW0T0EpFBIT8c//FDk0V5BCgrwOR6
         kujLI7D7TPcYNQi+/id5SxNREZAz1ExLJ7qJFhmgsedcnUlJs5lhqC3BYv6YUiwXHQUo
         k9NGEmE/IIG5JtiJji8p89JkBSwkb0cFDBRIa5u8dPFBctrWy9tGrAIpzAo6yl8kt+5y
         MPzwuJ0/yo0vxoy4BhjhFsrb/Ux0LIwX8tOdEOKX0DtGWF3LRSBNFiSpn0oqZaJrMIhX
         t4rX1GiRpJfY4qEoMO2BXJs7ljPdeg2FLNqWLXBzBWzT6mYUjQSoHK3RoyZXYgg+2p5Q
         7RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQOQXmVOjtFvjo2NMKMUWQnQ7P/3eXWd6E4bLesOoJY=;
        b=b4XrH8lKSk+7Y6Rlb4yIvY8n1B3OtdJkZf+Ze7yioeotkZdAg5PXPof6id6LTClN43
         oBex3pmgRouhCiPv1ME3txYomBWfzeglDV7Ei0mImakKO0mjFkwJhFfeWNlXaSaE+vzQ
         wzoBwCIneU8k6eDCvJ3l4baKbVsks/9l0YoVmk9yvXWxQQYnebN6hGCo82YrdDW9Scaz
         J5eweLic73Zw98GrjlP0UoNlIV+q6NkjqVb6TT8Hc7TDgcMPqbI3Kq9YlE/R7ZG9a2YM
         sGtfoPHihpPNM4Lb6cCGZ6/n1kkQrRC2i/YlBOgWoKfhC0m985AsBOCP3RTdYegcB4h6
         k7PA==
X-Gm-Message-State: AOAM532lGmtrf1/ohCU4v+izbFvbGh4R6MBrO+ZrY/2M1ktP83rS5N5F
        bUGn5+L4y7ci1ETQQ80auKT4Q26968r/ppWnNPk=
X-Google-Smtp-Source: ABdhPJwfRs/CskDKlx95v53DxzMwRg7Hw6gvJECRFKWn5sPH7/5wOQJiw720bRUFUv/kBKBFd5JcP/K2kb26KeKijHQ=
X-Received: by 2002:a25:df82:: with SMTP id w124mr3337631ybg.347.1605071189754;
 Tue, 10 Nov 2020 21:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org> <20201110164310.2600671-5-jean-philippe@linaro.org>
In-Reply-To: <20201110164310.2600671-5-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 21:06:19 -0800
Message-ID: <CAEf4BzaOXH_Tq_c7mjnZW8kRy7Kff4vy7_7DgGuOe6oRbWhu=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] tools/runqslower: Use Makefile.include
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 8:44 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Makefile.include defines variables such as OUTPUT and CC for out-of-tree
> build and cross-build. Include it into the runqslower Makefile and use
> its $(QUIET*) helpers.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/bpf/runqslower/Makefile | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>

[...]
