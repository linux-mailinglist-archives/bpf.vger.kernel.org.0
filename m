Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8674535F0B0
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 11:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347647AbhDNJV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347622AbhDNJVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 05:21:55 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB7AC061756
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 02:21:34 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e14so5208214ils.12
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHpie5HpZgHlzw3ULYYgfK8HzQppRmaDIQ+JyFmm3tc=;
        b=QlOQDTDC6+TFMXbxL4bxceCqvjswx//Lmdk4CAO1oE//dHahhT8jOfftD/CV4t5y47
         HmNr0TY1RLAy9fNL1hzmQsvrCqMB8p0xE7GaT8rIJJPQrxyV33A0L+bPI51NcJE/OuvE
         uOZNBxO2u/9URtGWy3edZaWD8cqW7AXUapOLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHpie5HpZgHlzw3ULYYgfK8HzQppRmaDIQ+JyFmm3tc=;
        b=Zh0uf3+uWw0GUlCmKCa3KGnsHdVXvnQ8ovpOcbNjm3tqssBQ0LxlG/rDk0sSh1UBOw
         MwSsZgAEOfSx4B3KJVUpDsWNxgDtWYy/OVqZx5ixdmnavnR8KtugKwAW6dKvqtj4D9Qy
         pl7Gv95vhNleAlKYzF9dcBwUaAEokKoMCRe+DD/rNmpG9OlxnX4ymf4/esdZ1zmqKDNT
         B23UcBw2Rb6A2LSH1WvVhriGFuW5rp8HgszaMmarNPJPLH+246aNnDoN5CujodmSrMUF
         UzmwjQ9coy9asGbYM+guIi6FeQhKjC1S8T4c0Tdzq3Hrjd6ATpwatCWP7btPTCIXnUbD
         qmmA==
X-Gm-Message-State: AOAM531R+tAUImlWEf/OkR1QHdXDL3EH8R2/q6RAatzzVKb7pTVifG7D
        0CtDKZF7H7YExNP4VfKXh60B+4vzNFTasoCCf9dQmg==
X-Google-Smtp-Source: ABdhPJzR/Eyk4vNV+pEmINVYnRnn1ZEdPsz4uQSiSwKX1m0Oq6toGUbWmCeUF3zhJ1HwBombj9oKmGbZNmHGLtoLt1g=
X-Received: by 2002:a05:6e02:2182:: with SMTP id j2mr32034994ila.89.1618392093374;
 Wed, 14 Apr 2021 02:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-7-revest@chromium.org>
 <CAEf4BzZ6cLio0ZZEkc5iYp9yWg3Fc1ZORBTr85TdoqF-sRU3DQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6cLio0ZZEkc5iYp9yWg3Fc1ZORBTr85TdoqF-sRU3DQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 14 Apr 2021 11:21:22 +0200
Message-ID: <CABRcYm+v7xC8WsxYu6BoiEX1vhQSVSX5U-LyUnevGt1tFud5tA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 1:21 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> >
> > This exercises most of the format specifiers.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> As I mentioned on another patch, we probably need negative tests even
> more than positive ones.

Agreed.

> I think an easy and nice way to do this is to have a separate BPF
> skeleton where fmt string and arguments are provided through read-only
> global variables, so that user-space can re-use the same BPF skeleton
> to simulate multiple cases. BPF program itself would just call
> bpf_snprintf() and store the returned result.

Ah, great idea! I was thinking of having one skeleton for each but it
would be a bit much indeed.

Because the format string needs to be in a read only map though, I
hope it can be modified from userspace before loading. I'll try it out
and see :) if it doesn't work I'll just use more skeletons

> Whether we need to validate the verifier log is up to debate (though
> it's not that hard to do by overriding libbpf_print_fn() callback),
> I'd be ok at least knowing that some bad format strings are rejected
> and don't crash the kernel.

Alright :)

>
> >  .../selftests/bpf/prog_tests/snprintf.c       | 81 +++++++++++++++++++
> >  .../selftests/bpf/progs/test_snprintf.c       | 74 +++++++++++++++++
> >  2 files changed, 155 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> >
>
> [...]
