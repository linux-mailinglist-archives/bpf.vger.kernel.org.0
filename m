Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77B844DBBE
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKSss (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhKKSsr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:48:47 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79666C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:45:58 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v64so17400482ybi.5
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yInxKNDjL90lXIkL7u3zi5/p29t776lV4em0VAu+urk=;
        b=m3/vsMOmmw3/Mz7ibQlYwJW6y6+w/CusNznc3e3LAMvB7PmMWutHPP+7WhMhQcSL1m
         FOkgUSBiMN5KcduIgGZazYGgeiPdbNm9/nYhYjUL4DdBvIw4HrpcHEaHpshHcSEXjeGE
         faRTrNNJLwinOSjQgeypHT8ylDPOmn3r3MePWwlgVwptH973YQdlcbnW/f6e1U8aqmd8
         SBQ90cQIuxABJWaxFKW422pqJgFR8Q4RGxXeBjbWZSxm9SWQvMpvZu5NLdp+MYoG8oL8
         wLSC34Rkmph31ZWUrrNWYaHrBf2HmpFMApgadkSt0l5zddgSj2YqyhSyzswFoqBoo5wF
         FMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yInxKNDjL90lXIkL7u3zi5/p29t776lV4em0VAu+urk=;
        b=ON7Mc9xtCs7n5ZdjO4c6POr/Lhq1Gu+uqHNDUn7mFhWwhd0U9InGAZI9r15txpXNZb
         cdXAEEda0rfOrBbrYwEF+WPDo9K84IN+g9njDPfLE+j4jIYHU2t5cpjeHayDDpZ14LSP
         GXQdBeEyK9xRqdQs1EQecG6YlQN6G7MJtTeZSh08eUL56gy2073eKzDNy12kVlkJq01Y
         rLAVfa3j2gFcIH5IvCBJ/JSwInH3mscDux+4q7PWvoxrYLTE2CUYxOJ4deUltm/y/qqu
         WEIYPRFxECnQZXrmRlxX/myjTP/3x7ItD0QOaSuHcJ81uLG/Zyzp/cXIjYazVEW552md
         Zn6w==
X-Gm-Message-State: AOAM532nv7xgGggNBBFfpvhQ51ZD9L+qR2Mc7x676DYDab6T9oM5tS7F
        8imfGtXVQztnbDpVXv/ziqJWNYDMyG3Zw9vdDiQ=
X-Google-Smtp-Source: ABdhPJyk6FLjz1vSRkMEuVnmAIDZgQOUIlz130QiVXeWcwtVoZhEvzZkEfMbEJCFy/zL9nX5Nn13B7QE9KxTuUiTx4U=
X-Received: by 2002:a25:d16:: with SMTP id 22mr10100103ybn.51.1636656357764;
 Thu, 11 Nov 2021 10:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052007.371167-1-yhs@fb.com>
In-Reply-To: <20211110052007.371167-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:45:46 -0800
Message-ID: <CAEf4Bza2+Qp5WBEZYniZc2bt3Y-Sce99GxkzxkNurSO6LvZfGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/10] selftests/bpf: Add BTF_KIND_TYPE_TAG unit tests
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:20 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_TYPE_TAG unit tests.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/btf.c | 18 ++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |  3 +++
>  2 files changed, 21 insertions(+)
>

[...]
