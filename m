Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724663E82BC
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbhHJSRd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 14:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbhHJSPV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 14:15:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AF6C043CC2
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 10:49:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a201so37651330ybg.12
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrlILZJWFYBGa1o854A6ecPzIfey0viNq7J2h13lbHQ=;
        b=TFmdm65pOc74oaNEvS1TGjhfy79qwPL2ksVQcjcXWL6Z/pwv0mgcaUO7FX3RBlsKr1
         4uxG/Y9B/yUKW+gVyyA2HRqbgT2GrRnWceBBi9QMJaZNrE/9FGI1peRqf9vmCbD2Ecrp
         xfz62Xt75TmYcicKMBoHMw3d4LpvLLWO94dgWFeqZzrUjuYk/APe/kC+nDwA7FRYm2gS
         ZGXMkLKis1XYoR5PZO3edlvrneq4ZwUhBF9E59TEl5Hn9xOQ8D+qytx03rG0U5ugWHtM
         e4RmLoVO0eBFdNc2vGSW3vBfgxzOciK3NMr2NrF5lHzMxGczLC00ubnD2ey2VTbsfHGX
         FzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrlILZJWFYBGa1o854A6ecPzIfey0viNq7J2h13lbHQ=;
        b=BbJmP4a8pWxOpicD9zTzUJHU0/oyrShct9oPH1IzCTSeu1jFOfCEF/Sf07hXWUQByb
         QIK8xFP78vv7mnxII0E8D6iMjIiqMI5qOMcAZkbvY5PGi8xHvD1TP0uJVaep9H6ymhpt
         /O0WhGBGgDAZyGUc2L16n09mx45Gi06O7XCYe2SzDjMgB2FYIb+CviWUA7oihcfp8sN/
         Ms8jCKlgkI6uhr87UMwt/HxTslFRjFS/JHpwiRV8g94e9GHiLmHQPuhNRonBI2pDRTQ2
         ECERITw1Q4D/XpBzpUFaoB9WMerQTnyTZRCmTHZ4kABwJpyuByTQbE6O5r9uSmVFvMzp
         Hm4A==
X-Gm-Message-State: AOAM532A7R+KMfBKLr8i0mJPDGG/SrbpYt+H297ET90K4Epb6ce033l2
        dpaTCASBd2UXIHVAWmu9y98QdJ27rGK6khZ/g+A=
X-Google-Smtp-Source: ABdhPJyW7UHo7io2RqrxDICF1ko9oFEXXmUZ299A7yo+Bq2uKcrxVS8N1yAUJmCD0DQgwnTTVc5BD9d14dw8fruxe50=
X-Received: by 2002:a5b:648:: with SMTP id o8mr41088673ybq.260.1628617765499;
 Tue, 10 Aug 2021 10:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210810001625.1140255-1-fallentree@fb.com> <20210810001625.1140255-5-fallentree@fb.com>
In-Reply-To: <20210810001625.1140255-5-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Aug 2021 10:49:14 -0700
Message-ID: <CAEf4BzY-B-S+zMGQUh9UM-UQZUhtiQntUHWjoXcTtjB=9CNMUA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] Display test number when listing test names
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        sunyucong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 5:17 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch adds tests number to the output when using "test_prog -l".

Yes, but why? Commit message should contain the motivation for the
change, not just description of what's being changed.

Also, this changes the output format and there are systems that might
rely on this specific format (I remember Red Hat were using
./test_progs -l, for example). So without a good reason, we shouldn't
change the format.

>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 82d012671552..5cc808992b00 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -867,7 +867,8 @@ int main(int argc, char **argv)
>                 }
>
>                 if (env.list_test_names) {
> -                       fprintf(env.stdout, "%s\n", test->test_name);
> +                       fprintf(env.stdout, "# %d %s\n",
> +                               test->test_num, test->test_name);
>                         env.succ_cnt++;
>                         continue;
>                 }
> --
> 2.30.2
>
