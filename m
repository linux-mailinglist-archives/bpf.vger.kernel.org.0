Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6327C13F0C9
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436626AbgAPSYV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 13:24:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44070 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436633AbgAPSYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 13:24:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so20039514qkb.11
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a7ONujxjG7x5qXgG+AXUy0oA1YkW/bXg+65H5zTTU8=;
        b=BXVMHJSLo0Qp+25qu7HaL6z4fovzpPATu8LN0Y2EUsx3N/2PQwV28KoUCCWeLnJyiS
         5xAJz9z2OEIB16p1B5Y6bHY5iCstw1/iwjrBXgrs+MZ9YZYF3vgRy2BzGzI85t5+lk+J
         Sq9iV9t8Q9ClWLwkh0dfm/U6tPlrp+JU7ie14Qi2Bot83CIlmtZyVi99KmI3G177bqFc
         PBDpJLsz+QJ+pwGfnMQFwKHKufwjj2TFcF1sN+jQcn4PBNUVXukOI8alN9KHTtfXDSEI
         M9Zn4OATtXh0tYpRyxwlL/iitfwlSIPvJpQNmQJQkH1s2lQu1wqy/a/tVRr6YPPZnq5O
         sz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a7ONujxjG7x5qXgG+AXUy0oA1YkW/bXg+65H5zTTU8=;
        b=KW62Es06/YmvxiTRjDU4TDFL+YsVzd5AWCRBm6OdTJfvvjmAo3AuFaKeoHBwZ7TEAt
         xFYM17XdNV5c6c5bH6OuVpyZDPF4f3KJnTp+rLIGb7Qui0HugbNC0deTESQ8x7olNC80
         NVeeq5j4Vq9JzbNgoUG67HI4TCMLJcIGwAaiPxxo6T29vruT/koGarpLaPXmguXgnkKP
         lgnT26tUl2ZGrvswrVbRMai6uOdj0FZv6xsKfQop/1QTyk6zmYTzE/pqZjDOyIxyD6pu
         xk0yyiRBhF5t7X4lgVbwrUP2LGVTpQHxe5Z+B1r7i7hbg/qgz0rzYCpfBTLshlJmx+qF
         VG9w==
X-Gm-Message-State: APjAAAWanbAKRdVenZkcxJ4N0SO+LIC1wJfMwhaY0rKtTAoMJH8MeDYZ
        6s8zrEqZp4zwLaCOhTLL2O+CiOFMsYsi+Bbo4U4=
X-Google-Smtp-Source: APXvYqwhoklB8//6zZlOT9PnquZ7kj/7UXtXtQoJBvY17dgEw8ghddOFmNa4NOvlbaG4dpAl2Sa+PQQRK67uYje34PI=
X-Received: by 2002:a37:a685:: with SMTP id p127mr30916497qke.449.1579199060271;
 Thu, 16 Jan 2020 10:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20200116174004.1522812-1-yhs@fb.com>
In-Reply-To: <20200116174004.1522812-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Jan 2020 10:24:09 -0800
Message-ID: <CAEf4Bzbi0T5P=Dnja=pz3Nj0jhO9S+q_q1U4vfBwYP8enX+Zag@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_progs send_signal
 flakiness with nmi mode
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 16, 2020 at 10:06 AM Yonghong Song <yhs@fb.com> wrote:
>
> Alexei observed that test_progs send_signal may fail if run
> with command line "./test_progs" and the tests will pass
> if just run "./test_progs -n 40".
>
> I observed similar issue with nmi subtest failure
> and added a delay 100 us in Commit ab8b7f0cb358
> ("tools/bpf: Add self tests for bpf_send_signal_thread()")
> and the problem is gone for me. But the issue still exists
> in Alexei's testing environment.
>
> The current code uses sample_freq = 50 (50 events/second), which
> may not be enough. But if the sample_freq value is larger than
> sysctl kernel/perf_event_max_sample_rate, the perf_event_open
> syscall will fail.
>
> This patch changed nmi perf testing to use sample_period = 1,
> which means trying to sampling every event. This seems fixing
> the issue.
>
> Fixes: ab8b7f0cb358 ("tools/bpf: Add self tests for bpf_send_signal_thread()")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Good not to have to rely on arbitrary timeout!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/prog_tests/send_signal.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index d4cedd86c424..504abb7bfb95 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -76,9 +76,6 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>         if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
>                 goto skel_open_load_failure;
>
> -       /* add a delay for child thread to ramp up */
> -       usleep(100);
> -
>         if (!attr) {
>                 err = test_send_signal_kern__attach(skel);
>                 if (CHECK(err, "skel_attach", "skeleton attach failed\n")) {
> @@ -155,8 +152,7 @@ static void test_send_signal_perf(bool signal_thread)
>  static void test_send_signal_nmi(bool signal_thread)
>  {
>         struct perf_event_attr attr = {
> -               .sample_freq = 50,
> -               .freq = 1,
> +               .sample_period = 1,
>                 .type = PERF_TYPE_HARDWARE,
>                 .config = PERF_COUNT_HW_CPU_CYCLES,
>         };
> --
> 2.17.1
>
