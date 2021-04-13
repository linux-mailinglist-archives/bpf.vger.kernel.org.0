Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3438335E9A3
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 01:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhDMXWO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMXWN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 19:22:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AAAC061574;
        Tue, 13 Apr 2021 16:21:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g38so20017419ybi.12;
        Tue, 13 Apr 2021 16:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZ33GHUolIcGXlX+GDSqMLORxQxMH8kcsnM1VwmyJE0=;
        b=pcgTk9q5Ujx/lOsiwbIz+nnFHh7Cc2rX4wsOgsw0xzSZn4h1GJuxLL/2988hl4WHFQ
         WQkB37yZpth35nz0w17aBg/RuXqR2PQ24eCmlWh9jIM7V2JFKm8FqGoSzwzRsM3PmqSB
         joAqGnFP8IGWm4BCFegSH4aznDPRQMntMLO4fiyw6OZvMFGXwoHn5YLV36kinPnaegfh
         R2LatYCxaemEsWMdQyIlVmx+1zBsADOUh/7q5dg8MkXZKtY/RzUT2alSeRgCrNpohKNz
         5LUWF8pbP7ufV5QQ+GbDzZ5YwXGRgGFA2xHa5ijC11jTmG+cs8jinw0PIefBzodjw1i/
         STgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZ33GHUolIcGXlX+GDSqMLORxQxMH8kcsnM1VwmyJE0=;
        b=a3XZsVnfbO3pXbwHyw69rApF6Cot6feO2teHK6bEIWGFuN26SvhL+3Qzx1oX3QQicZ
         LZlLVSHBIfRG/OFG7N6/pN1KQxZT2h1z7llpCVFPI9Zh6b57QnXVSacINHwn2Dbf35cm
         jwKF1SqK2LJ7c4xbX/ATZO6BTgcSbXu6DbYOscqAk+isgzpcIXQu1uNBiXw+JHcHsf+w
         UI2Ik9VVaBiOfWMJ3Xe4Jh4HJpBbKtbZR+7uPZyn3Fdtge0ZBhuwOzGuPyeM6eNO26Bl
         0CT3pUHj0613GF+0z2YrrpHWfC2WhzqXE77FEcdT9yO/meeI689VEx3IKpeg6njgfSuv
         ei4w==
X-Gm-Message-State: AOAM531E1TQoKlt7kiNMbdYNWWqOUaHc8K14pQzw+g4W2gNztK7lPbst
        rrVPHa2ln9+N0R7oFQhi1vPCSMGpi0ha6yxGB1Q=
X-Google-Smtp-Source: ABdhPJzA1dFTwU0fVQZponRkPsdeOOcX6JUeUir0vvC2A6GeCJzGOAYUbY9rZDH+11xHldTGu+MiPH23Rgw7PKCWroM=
X-Received: by 2002:a25:dc46:: with SMTP id y67mr23254940ybe.27.1618356112955;
 Tue, 13 Apr 2021 16:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-7-revest@chromium.org>
In-Reply-To: <20210412153754.235500-7-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 16:21:42 -0700
Message-ID: <CAEf4BzZ6cLio0ZZEkc5iYp9yWg3Fc1ZORBTr85TdoqF-sRU3DQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Florent Revest <revest@chromium.org>
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

On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
>
> This exercises most of the format specifiers.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---

As I mentioned on another patch, we probably need negative tests even
more than positive ones.

I think an easy and nice way to do this is to have a separate BPF
skeleton where fmt string and arguments are provided through read-only
global variables, so that user-space can re-use the same BPF skeleton
to simulate multiple cases. BPF program itself would just call
bpf_snprintf() and store the returned result.

Whether we need to validate the verifier log is up to debate (though
it's not that hard to do by overriding libbpf_print_fn() callback),
I'd be ok at least knowing that some bad format strings are rejected
and don't crash the kernel.


>  .../selftests/bpf/prog_tests/snprintf.c       | 81 +++++++++++++++++++
>  .../selftests/bpf/progs/test_snprintf.c       | 74 +++++++++++++++++
>  2 files changed, 155 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
>

[...]
