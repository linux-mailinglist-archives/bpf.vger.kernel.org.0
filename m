Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C2626B949
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 03:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIPBT0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 21:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgIPBTY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 21:19:24 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9515EC06174A
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 18:19:24 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a2so4152754ybj.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 18:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sV2ca27Aey3n3PyPaTrNzIh8uNIQc8LgfEcANvY9XFM=;
        b=awe1lfxvoiQcSy7JoupC1W+TFM1g3Dttw7j9saC7XtAqE7zxaeR03JBjBQsh/PBhmJ
         LqGwRsjMgvqhyE+83odrAFtXq1xcIQNzc65n1PAt3z5LZd/U8SvdCkCtFrHUnKmhIBic
         meVrU06iGZd8o4AqjiAGn0aBrjfu4ky4214j9cNwtQPQkhw1xnzyuGO4lcdTfkDYkgb0
         a9m4ymCMv/SaPBOJBY+NekiGzyLjG6gHBPHfoRa36uMsWO3rpvaDK9dtyvIx+OreeK+g
         aksWKozDixqEezutruliJTqmcHCj7FtHx4NTfBF5kq7uHhUEgLKAG1MJaQKxRlNUnOjl
         PT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sV2ca27Aey3n3PyPaTrNzIh8uNIQc8LgfEcANvY9XFM=;
        b=PhItzzaj1i+2vsIlQ+HdWpBb7czn2P6XXYiVVui/zzM1GKja4CD4kLkVoz/Rkop77J
         QrH41tj02YuEdLCFduZUQDU9yuMlOP/9DA7YM+WTjw6s1Jz90fQ7/R9/Mro0uTZgk8ed
         FdbW0GUAJG66L2SFpUPxTjwxZUe9z/vMZUyw7BZlQ71jvXw/ft+vX0bcK6sqBBvt9Mo6
         SrTEzES49A71MFSdT08I2MijdXTuVAxdKmXuGPHg5+lwE5GbQt4+JfYx8arKJqMmPbLn
         p7NlHlZANsafimFyk8f9H2EQB/fmxLAoW/ez9xDoPBNNeuJE7yR/m+xZ01yd3miAew6Q
         mtTA==
X-Gm-Message-State: AOAM532Ja7r3p24K23a+TI0mA8u/mRNjEbpY2hCXag3ACbDPb8i31wza
        5Zxwx7uvX+TuOskTKeRBY8Cgoz68lNPKvvjZPus=
X-Google-Smtp-Source: ABdhPJypDjAMgMEcswY9+jHM6BiaEPwMXwV+DLoAU1/tJjfozTA7wkX6jJHf3cJSW/YVkqRHVDoFyjzmJd7i4UMSdlk=
X-Received: by 2002:a25:da90:: with SMTP id n138mr12169429ybf.260.1600219163676;
 Tue, 15 Sep 2020 18:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200915113928.3768496-1-iii@linux.ibm.com>
In-Reply-To: <20200915113928.3768496-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Sep 2020 18:19:12 -0700
Message-ID: <CAEf4BzaE_gAF7fHyD2HTQRgH0KLgD39yxh7WsJ8SxMrtXj6GKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix endianness issue in test_sockopt_sk
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 4:39 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> getsetsockopt() calls getsockopt() with optlen == 1, but then checks
> the resulting int. It is ok on little endian, but not on big endian.
>
> Fix by checking char instead.
>
> Fixes: 8a027dc0 ("selftests/bpf: add sockopt test that exercises sk helpers")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>
> v1->v2: Also pass a single byte to log_err.
>

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 5f54c6aec7f0..b25c9c45c148 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -45,9 +45,9 @@ static int getsetsockopt(void)
>                 goto err;
>         }
>
> -       if (*(int *)big_buf != 0x08) {
> +       if (*big_buf != 0x08) {
>                 log_err("Unexpected getsockopt(IP_TOS) optval 0x%x != 0x08",
> -                       *(int *)big_buf);
> +                       (int)*big_buf);
>                 goto err;
>         }
>
> --
> 2.25.4
>
