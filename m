Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597A94273B6
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbhJHW24 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhJHW2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:28:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4766C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:26:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id w10so24158179ybt.4
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xy2CinrCf9GKKKB8cXNkiqWYClyfMoj9o0JUZPMP83o=;
        b=K0uaYamqRRO9bKb9CtTo/6KXC0oAvvUstPizVf5DQjZYQqWEIXT9QZPEDNGjpAu2qp
         oVpA8nMf5cl2OvLfVCyjeZwbUTk2ij1NLf33Hzww1gcgi4/e2z+PDOlLRVWN6e9MM3PR
         8cM/Ob6nVFTGIbUYN9jkKZDULwrfYBKR2jPxViQ68ptCOcRin4dC0lmQCBEHj73KItik
         psk9wjEmPrTOl3ghAaor9jJ/KcI6kzuBQD9oaPYb28EcqNs9jxg1gupob7HfP/+wsNM4
         7x5xW/D96NtWqkV5Y8TUm/NmpA9FF3wSaIuqEAErD4HCWEmNWxPDYvqRkZYx2I7sKZq6
         5m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xy2CinrCf9GKKKB8cXNkiqWYClyfMoj9o0JUZPMP83o=;
        b=CENvcKfAmF4weaHuSPlWfMFbNwW1mKxuCev5BIFlSRoRBM+I5ugXXdObo6c1dAPzT2
         9fcostNBTLdqI8gYHNPp3J9lgP+FjJFtGrSn9XFtR2cxHr2vRrTsHbI7AOacPrE1qY0C
         TMLN5c2DpUkauXXvPmKo3sXJ0H58CU+LVaWfbwgm1wtzOgkz32PT/yZQx7E/W1Bu/ZAJ
         H6XyNtn+Mf7VPbUEbtz9UOBKwCZLWdqiQXIKrYhquSesZP9WUURrrjNCo4BbmGcjLwPw
         xUMXU6V0CIFqmNLmEWlbUvg3WtmiGGSGXzfjIVKsPtAtAVyufdw7rp/8Lc/Zi97ymuar
         q0Fw==
X-Gm-Message-State: AOAM531RtJAnP1R0GHZFe/TdnLZvrk2PdDidTs4JR4w9T9aM7JsYqbC3
        sxrCEqniRb5xdSxTijK0TiNLGHAsgqKV1uTrBRs8SpoLZpg=
X-Google-Smtp-Source: ABdhPJzpQ0LRkHjGDYOxNx3rbT9Ty4GGoLKcFA1BnOPjNiKI7yc4P66vwN8iv3XO2Pa5jB6cBhJur7tRYMl8QDqbo2E=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr6234545ybh.267.1633732018153;
 Fri, 08 Oct 2021 15:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-3-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-3-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:26:47 -0700
Message-ID: <CAEf4BzaOomCKAxLSShy1cF0xp4Xs22jKkyjdCNVJLrFwMwcNRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 02/14] selftests/bpf: Allow some tests to be
 executed in sequence
To:     Yucong Sun <fallentree@fb.com>
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
> This patch allows tests to define serial_test_name() instead of
> test_name(), and this will make test_progs execute those in sequence
> after all other tests finished executing concurrently.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 60 +++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 6 deletions(-)
>

[...]

> @@ -1129,6 +1136,40 @@ static int server_main(void)
>         free(env.worker_current_test);
>         free(data);
>
> +       /* run serial tests */
> +       save_netns();
> +
> +       for (int i = 0; i < prog_test_cnt; i++) {
> +               struct prog_test_def *test = &prog_test_defs[i];
> +               struct test_result *result = &test_results[i];
> +
> +               if (!test->should_run || !test->run_serial_test)
> +                       continue;
> +
> +               stdio_hijack();
> +
> +               run_one_test(i);
> +
> +               stdio_restore();
> +               if (env.log_buf) {
> +                       result->log_cnt = env.log_cnt;
> +                       result->log_buf = strdup(env.log_buf);
> +
> +                       free(env.log_buf);
> +                       env.log_buf = NULL;
> +                       env.log_cnt = 0;
> +               }
> +               restore_netns();
> +
> +               fprintf(stdout, "#%d %s:%s\n",
> +                       test->test_num, test->test_name,
> +                       test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> +
> +               result->error_cnt = test->error_cnt;
> +               result->skip_cnt = test->skip_cnt;
> +               result->sub_succ_cnt = test->sub_succ_cnt;
> +       }
> +

Did you try to just reuse sequential running loop logic in main() for
this? I'd like to avoid the third test running loop copy, if possible.
What were the problems of reusing the sequential logic from main(),
they do the same work, no?


>         /* generate summary */
>         fflush(stderr);
>         fflush(stdout);
> @@ -1326,6 +1367,13 @@ int main(int argc, char **argv)
>                         test->should_run = true;
>                 else
>                         test->should_run = false;
> +
> +               if ((test->run_test == NULL && test->run_serial_test == NULL) ||
> +                   (test->run_test != NULL && test->run_serial_test != NULL)) {
> +                       fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
> +                               test->test_num, test->test_name, test->test_name, test->test_name);
> +                       exit(EXIT_ERR_SETUP_INFRA);
> +               }
>         }
>
>         /* ignore workers if we are just listing */
> --
> 2.30.2
>
