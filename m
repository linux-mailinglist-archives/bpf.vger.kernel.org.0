Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC71C4273BB
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbhJHW31 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbhJHW31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7247DC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:27:31 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s4so24141318ybs.8
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2GlswS4uVXET+UpBRtdDSMuyOIWsJQMeemuhVwzdkk=;
        b=BHSLX1nOSW6A6la71adF3BpKIqcxPLTTZ8DjHgN74ng6Re4IEo1fZE5xi+s0WZHaBc
         tiPFBL3jxWIgUbcJZh1RU3G1bG3nTAjf0eAXnBKG5zN7N6mRwUWNRBECztoNVupEkowu
         qOvsgxHt8xT4DJ+cjhGzBjg8E4GOH4uZZmoLFwlj1EFMdX2uW7bshqYFTnK19hnIP+ac
         b/kTzXlKcenp6mjLtwuYdKq6rzz4wy4SBnqHbHcZ+LCKaxdnSpcfZHmzQV/U/E/i7qpF
         QMy3gKyqaZh9dBhOSPYOR65khsYNAr+4IR++wHwhpS6dvwklZ5ONkAA9IFiXpPYxy8Vl
         R+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2GlswS4uVXET+UpBRtdDSMuyOIWsJQMeemuhVwzdkk=;
        b=kShUGIEXSxjITzA0IAhm++OrXbgzlFEL7q8uD/k6Tf+1EoA75cXzltIOtSBo65lwm/
         nxV01ACkPPj/tnwXCyXLgC0rRCDnKdT365VPeiOEU8rNAcOUoyrRN6W72X37Ljzl20Yr
         gF8fIMVKdTWHomP+ibsN1pJK7GMRLIx0xG78klR0+DKJkP1VzIyvL1yv6Jh+2ZyzNAP9
         b/rRWwHMPCutfdQQZjUc5puQZ6ctUWF/9Y3mdsWXAo13KhbgUnW3dNMu0fQ+ZuWSwvnk
         Q/aSmIByIj5aFZvlHTFB2s8toqiJdX1OAC2EbL9RYOOrXN0py1AEQcbYFEuCKssPATYU
         x17Q==
X-Gm-Message-State: AOAM532YSguM1PnuMilPo8DITGiPMDXSTZUxv7DoqcYk2b29heQGXG40
        SnFxrttS5of/5cwoa/FoB8XucJO6+MR3V5KYld4=
X-Google-Smtp-Source: ABdhPJwOdD025eSdMRGVO/EAW2yfLXPTx5smZiOk7JNPErvmTbXN0NHU1w2+gKR/tc8MNNshD5dFL4XaNTuLRB/X4R0=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr5706893ybj.433.1633732050766;
 Fri, 08 Oct 2021 15:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-12-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-12-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:27:19 -0700
Message-ID: <CAEf4Bza-DrWa1Z_Q93egdUHWdcjnWn4jJtCBwZEBx3p1ynC+uA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 11/14] selftests/bpf: adding random delay for
 send_signal test
To:     Yucong Sun <fallentree@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch adds random delay on waiting for the signal to arrive,
> making the test more robust.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/send_signal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index 776916b61c40..6200256243f2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -19,6 +19,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>         int err = -1, pmu_fd = -1;
>         char buf[256];
>         pid_t pid;
> +       int attempts = 100;
>
>         if (!ASSERT_OK(pipe(pipe_c2p), "pipe_c2p"))
>                 return;
> @@ -63,7 +64,10 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>                 ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>
>                 /* wait a little for signal handler */
> -               sleep(1);
> +               while (attempts > 0 && !sigusr1_received) {

This is not reliable, sigusr1_received has to be volatile or
sig_atomic_t, please fix. I haven't applied this patch yet.

Also, previously we slept for a second, now we can, technically, sleep
only up to 100ms, would that cause any problems in practice? cc
Yonghong


> +                       attempts--;
> +                       usleep(500 + rand() % 500);
> +               }
>
>                 buf[0] = sigusr1_received ? '2' : '0';
>                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
> --
> 2.30.2
>
