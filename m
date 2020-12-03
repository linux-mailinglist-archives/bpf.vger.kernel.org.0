Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0F12CCECC
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 06:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgLCFrZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 00:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgLCFrY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 00:47:24 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B0C061A4D
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 21:46:43 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id e81so995387ybc.1
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 21:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SdJd2yd8ucpYWtM5PgRFUu03l2zl+1sLmXqe3rGHyqY=;
        b=MUkgR0H98x0IJ4tO/LczsnUiuQ1Y9bQVgmeU12FK6ziWSyLq7j8w84zW4/37qHVx1K
         NkNf1ZXkM0A9YjNoyb/eMkQqpK6uM1g6CrDzCYH8g/EJdBa5rgW5sYYv4uoVQyv2oRY2
         yJbl/7RYGpJkDFJXuMAxrh7BxEbPsuB7/5nYBfLApmNfCXfzHbWSJkv6FnM5p9ftAamS
         Ari6FzG1HsXnkVgXClnk1UW4rICyme3Z1pRInRmvO/lm2tID9x8WOEC00ctaVnuW/00P
         FU2gI3sas0fOzoHB+8TPHMTkBNa2djarj0c5/7pY9Ucb4WT66gROlrR+0srotzDkTdY6
         38Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SdJd2yd8ucpYWtM5PgRFUu03l2zl+1sLmXqe3rGHyqY=;
        b=AtAQ72qH6edHY61lHX17TxTo86jcchLxm7V7zwNNUaGo2Xp2L1YjdV6dnf+VMXQRyg
         MacGkgMaI7T21LwiIkwRV8mRP2ReMm4/Cqg59p9rMx2jBLDnmMHec+OhRjBdyBbyPA9O
         qjlYUF1kAaN8uHUROnVVlb4917FRMbKKv3YoCj4cyUAPzdpDloe9Hm5GKv9eblRqdpdU
         c+aKdI5SefZQYxZRkD0raqyRGKBthduqvkQ9bNKudKnf0HP7u59othZyfmQTGiHFhXyy
         N8DLQygTp1RJ1BYZqVJ5sPz5avxBPppDb4UZjYqoeR/C2fNOzn2JC5lyWR/QdyXIEksZ
         vQaA==
X-Gm-Message-State: AOAM530teITDpGjyUh9UWJkyffh44M36i/EfewWiYSdEDBWhhBwRcBP8
        Ru4TRinyUdGB/mE6zx1Sl64onERkmacFFQmfnak=
X-Google-Smtp-Source: ABdhPJzt+ZvynB5atccFnysmnWr+5cJ+FTwRYvjh7mfTnaxPAgUpSFE4VX39QofGgZu3GTzzpcFnCvT/ZnkWrB6R1do=
X-Received: by 2002:a25:2845:: with SMTP id o66mr2332013ybo.260.1606974403138;
 Wed, 02 Dec 2020 21:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-5-kpsingh@chromium.org>
In-Reply-To: <20201203005807.486320-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Dec 2020 21:46:32 -0800
Message-ID: <CAEf4BzZSw-338WCzhbWyJGOVnkBvOsLqoqa1yTA88aNe8JdJtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Indent ima_setup.sh with tabs.
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>

Commit message is missing completely.

> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/testing/selftests/bpf/ima_setup.sh | 108 +++++++++++------------
>  1 file changed, 54 insertions(+), 54 deletions(-)
>

[...]
