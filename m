Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57C30B3B1
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 00:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBAXuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 18:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBAXuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 18:50:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEA2B64ECE
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612223370;
        bh=r9PzWXGDssn9ajMQyOaKD9CX7t0z43ItQhkrbbcrmP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QD8fOLv9v5sjqnJ9TFy9nPHibokzPSuX+B/rME4hiDcfLJf/NqEE31YKk1kbPNYum
         T7Cr2HcT20m04S+mDqvuRJ+D5ynnqWNO4sHKU1BK+xGHfb4WRv23Qy56KSsRcPrXga
         KvDx9pCwc1jOqr+na69g0iq7odNrG414R+oCLkYvB8miH2UZGG9YWtnlfX0QozNJ+H
         ojVjUGMYt1j3RISrpMCpjeWw3RpklBsY7DClVCjUsy1yS3T2qUTysi5s5NwIkvTrb7
         rnkovAgQbK4wn5K9H422a/JjUeshHA07xbnDUUGYhz1K1Ztzp76rk5yRbjGLsBjXKL
         55/OpndbRCEfg==
Received: by mail-lf1-f48.google.com with SMTP id m22so25321615lfg.5
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 15:49:29 -0800 (PST)
X-Gm-Message-State: AOAM533sJBpr2tKZONfxddzp2CpeaTjZBejXki3D9zar0luKqdTlK9zs
        vdDvQvcwnsL49TqwDbcICu1/g7YWt7j+pPcIXng=
X-Google-Smtp-Source: ABdhPJyTdpMIYRY7k67uHd2xykTAIMSll0aORzm8NILrAtQlCFHs0QGoOSX3QFigsU+uwiZqHJOauvV8By+shLwQ2qE=
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr9705334lfu.10.1612223368255;
 Mon, 01 Feb 2021 15:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20210130220150.59305-1-andreimatei1@gmail.com>
In-Reply-To: <20210130220150.59305-1-andreimatei1@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 1 Feb 2021 15:49:17 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6VFdX8cSYoC1z7bVLRhM1pH1NiRFdj73S+4d=qV80tPg@mail.gmail.com>
Message-ID: <CAPhsuW6VFdX8cSYoC1z7bVLRhM1pH1NiRFdj73S+4d=qV80tPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftest/bpf: testing for multiple logs on REJECT
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 30, 2021 at 2:10 PM Andrei Matei <andreimatei1@gmail.com> wrote:
>
> This patch adds support to verifier tests to check for a succession of
> verifier log messages on program load failure. This makes the
> errstr field work uniformly across REJECT and VERBOSE_ACCEPT checks.
>
> This patch also increases the maximum size of a message in the series of
> messages to test from 80 chars to 200 chars. This is in order to keep
> existing tests working, which sometimes test for messages larger than 80
> chars (which was accepted in the REJECT case, when testing for a single
> message, but not in the VERBOSE_ACCEPT case, when testing for possibly
> multiple messages).
> And example of such a long, checked message is in bounds.c:
> "R1 has unknown scalar with mixed signed bounds, pointer arithmetic with
> it prohibited for !root"
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/test_verifier.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 59bfa6201d1d..58b5a349d3ba 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -88,6 +88,10 @@ struct bpf_test {
>         int fixup_map_event_output[MAX_FIXUPS];
>         int fixup_map_reuseport_array[MAX_FIXUPS];
>         int fixup_map_ringbuf[MAX_FIXUPS];
> +       /* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
> +        * Can be a tab-separated sequence of expected strings. An empty string
> +        * means no log verification.
> +        */
>         const char *errstr;
>         const char *errstr_unpriv;
>         uint32_t insn_processed;
> @@ -995,13 +999,19 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
>         return 0;
>  }
>
> +/* Returns true if every part of exp (tab-separated) appears in log, in order.
> + *
> + * If exp is an empty string, returns true.
> + */
>  static bool cmp_str_seq(const char *log, const char *exp)
>  {
> -       char needle[80];
> +       char needle[200];
>         const char *p, *q;
>         int len;
>
>         do {
> +               if (!strlen(exp))
> +                       break;
>                 p = strchr(exp, '\t');
>                 if (!p)
>                         p = exp + strlen(exp);
> @@ -1015,7 +1025,7 @@ static bool cmp_str_seq(const char *log, const char *exp)
>                 needle[len] = 0;
>                 q = strstr(log, needle);
>                 if (!q) {
> -                       printf("FAIL\nUnexpected verifier log in successful load!\n"
> +                       printf("FAIL\nUnexpected verifier log!\n"
>                                "EXP: %s\nRES:\n", needle);
>                         return false;
>                 }
> @@ -1130,7 +1140,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>                         printf("FAIL\nUnexpected success to load!\n");
>                         goto fail_log;
>                 }
> -               if (!expected_err || !strstr(bpf_vlog, expected_err)) {
> +               if (!expected_err || !cmp_str_seq(bpf_vlog, expected_err)) {
>                         printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
>                               expected_err, bpf_vlog);
>                         goto fail_log;
> --
> 2.27.0
>
