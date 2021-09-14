Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B040A5E3
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbhINFU3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhINFU2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:20:28 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AADBC061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:19:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v10so25504921ybq.7
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtMrbL/TST7anSRA9pzrXt2GOnv68Xt9XCIHjxA6D78=;
        b=K3GFEbLta/RhWc75OBfpjRsW1xjCAoH3W9WQ3MptzenD2izM6x1jBOwjTxEGwymoVq
         ouGPAy6agPd9hC8KFxMZpxegPAoKAgWDE6eucXJgNh86gnGiEgm8eUL4E+MQj0WuEHuZ
         zSYQ6YjwVBfGyoVCnmKnOep6EXwXbmSKLNYbH0CL4y4d84YSJDOfT3SiYGAz0CwSjRP+
         fWQmldWmLQyJgLQS48ZHLQbTcJjw4NCEOkjSzfiz2zUADES94eNgBA/IWcDb3bILGKTd
         cWHOc79zBJYVPk6ChPw+lzo1pnGAFe6uYdnuqmDbxyJL5rRRuww+I4+YlDLisRBTtftn
         orSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtMrbL/TST7anSRA9pzrXt2GOnv68Xt9XCIHjxA6D78=;
        b=JS0JIrUKSBRYDwWBF4o5eiIYvGl5QaK2F+to2uCTSQaueaGp1oTF1BWD+ilunBHrJD
         Bi0aiaoJiSNlbUkFuDbYYiDQqmX/y0mWgnHPaYN2jcYCAkZ5QJEwgdfUNczLJdCYiKVs
         A9g394ujk2QyIm1dqCaIOn5IK/Z5MKdtZ+fKQJvp5ACEEUWnV/Edk3k6j6OgQ5/bEq2J
         4SQC2iwkDdj57bGLCrSpm67Grc8Z7DhLXJ7kHVfaFmFHa91l5wrjfxSkMCufiU5P1Wyr
         /Zu51X4e8l74u1zE06S7J1EWaL0ncBNwHcEoUIB3eBpf/KoZ+cAtqGfQJ7wFtNixjDd2
         W2Vg==
X-Gm-Message-State: AOAM5315KHjTGVKcXoi1eCd9AoEkxC2/5rnfpSyw8b0fvTDibsqFANgx
        yP9+FDwZO8w36XmdnpZ7xyWTjMcgW2WMB6wYqig=
X-Google-Smtp-Source: ABdhPJxP13ZptCRCCWAMRSAS3UbnmdozLaWNXCxfFYqBvUMXN66ZuPuXChGqRFp0xCJYWxThvxX/cU1jA3ISVXL0Rz8=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr19981760ybb.267.1631596750767;
 Mon, 13 Sep 2021 22:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155155.3727843-1-yhs@fb.com>
In-Reply-To: <20210913155155.3727843-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:18:59 -0700
Message-ID: <CAEf4BzZAo8u-hBmG5_FHCkSfYbPgDqL=HGFgwgFou-+kE9C+3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/11] selftests/bpf: test libbpf API function btf__add_tag()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add btf_write tests with btf__add_tag() function.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/btf_helpers.c     |  7 ++++++-
>  .../selftests/bpf/prog_tests/btf_write.c      | 21 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>

[...]
