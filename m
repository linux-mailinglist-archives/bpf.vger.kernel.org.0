Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C130440A749
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 09:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhINHZL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhINHZK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 03:25:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD9C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 00:23:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s11so25993622yba.11
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqwWVzwpjxr6JNBPGjXbCTiufOS/FzxIH2eYo9GMY3o=;
        b=itxR0YXXB22WSkLkSPq1ecOfiI5H2biScjqJxmcxvsvbk435dE998jkRwKZfiI68X5
         hmdJmouP31DZZKlQc7x6G9UJDQyXHRlKdwL00ISd5XFdUvvo1pCm7r3st5YsaFAMkJ0n
         ur5yXIrT2NImbHiTOB4p9G6NSB3z3gYkUHptndPPKiuAaUtGCGFJ9umOqfEvkzAkHl+D
         /vchYIojG2WaBnTz6QKC2PCVd2p61yMYnPzA3fRwweJkhwIq1i7qQIO0V6+j1gPKhzu0
         /ava1Q/TRjPIag9Wu5CdeLQ/4n+CiievqgjZcBso8bTJevdm8v2jTuVgS2JN3WrL6drI
         C1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqwWVzwpjxr6JNBPGjXbCTiufOS/FzxIH2eYo9GMY3o=;
        b=xhuTt9W4Fy+lB4KI9eFtC3UZWje/Nf7DePYMFf9p29oP/UhFRiIVSGCHeTPu0G+hK3
         YqkXKRGsxyw4B8d3vUUMZDWUzx4DV6sJOBM1rczYqiUxo8mn+wGc4PhhN64w5MGNq2PY
         1k4YqZ4CwDj4h3/nOCTVG63HSjSI2WSE6m7h8dG+EJkA+IeQYoNJjINpLpAvIzzqK6tg
         fPWRdT+pxXP1NInJDBKON3p9HlSYeowbeLav79Z1duk5mSDDrBr7XpRgJ/iC46dBvrkI
         Hx8NcLpY8OvrSp0vS0GxtHWJhalFCNqsQWl5ZhrRN81U7goEuu6trmUaGcgHOo7taASx
         eKlQ==
X-Gm-Message-State: AOAM5332KRvK1KzqnDKxa1TQ/4ARnEpqg+tkjCH+/asCt89k4smFmh2t
        GDClaO/UltTu4dptL3xk3SJ1gKnzRojy02kuz8w=
X-Google-Smtp-Source: ABdhPJzeg1carE75UvGgPdtpTtZ1L9UE8i7BmyYexlt4v6P/9lICfYzrg8O+7XPQac3UqHsBUsShcbq9VINe88XCuBY=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr19104568ybt.433.1631604229735;
 Tue, 14 Sep 2021 00:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210913193906.2813357-1-fallentree@fb.com> <20210913193906.2813357-3-fallentree@fb.com>
In-Reply-To: <20210913193906.2813357-3-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 00:23:38 -0700
Message-ID: <CAEf4BzZTv7HtiX5w-5H5hjRvaANXTPorqGNgae_FTJX9CD9Ytg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: pin some tests to worker 0
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 12:39 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch adds a simple name list to pin some tests that fail to run in
> parallel to worker 0. On encountering these tests, all other threads will wait
> on a conditional variable, which worker 0 will signal once the tests has
> finished running.
>
> Additionally, before running the test, thread 0 also check and wait until all
> other threads has finished their work, to make sure the pinned test really are
> the only test running in the system.
>
> After this change, all tests should pass in '-j' mode.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 109 ++++++++++++++++++++---
>  1 file changed, 97 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index f0eeb17c348d..dc72b3f526a6 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -18,6 +18,16 @@
>  #include <sys/socket.h>
>  #include <sys/un.h>
>
> +char *TESTS_MUST_SERIALIZE[] = {
> +       "netcnt",
> +       "select_reuseport",
> +       "sockmap_listen",
> +       "tc_redirect",
> +       "xdp_bonding",
> +       "xdp_info",
> +       NULL,
> +};
> +

I was actually thinking to encode this as part of the test function
name itself. I.e.,

void test_vmlinux(void) for parallelizable tests

and

void serial_test_vmlinux(void)


Then we can use weak symbols to "detect" which one is actually defined
for any given test.:

struct prog_test_def {
    void (*run_test)(void);
    void (*run_test_serial)(void);
    ...
};

then test_progs.c will define

#define DEFINE_TEST(name) extern void test_##name(void) __weak; extern
void serial_test_##name(void) __weak;

and that prog_test_def (though another DEFINE_TEST macro definition)
will be initialized as

{
    .test_name = #name,
    .run_test = &test_##name,
    .run_test_serial = &serial_test_##name,
}


After all that checking which of .run_test or .run_test_serial isn't
NULL (and erroring out if both or neither) will determine whether the
test is serial or parallel. Keeping this knowledge next to test itself
is nice in that it will never get out of sync, will never be
mismatched, etc (and it's very obvious when looking at the test file
itself).

Thoughts?


[...]
