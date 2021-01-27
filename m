Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE83305156
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 05:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhA0EpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 23:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhA0DC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 22:02:57 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC37C061351
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 18:31:46 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id h11so358458ioh.11
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 18:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ifb0D+1WqBBzNJ8/3rrdcsNeQPMZ9f86icYxJTZY2Tk=;
        b=m8njW5xDAER3TzGAaksIvhJpZmn2lOmuB8gchvUxH1GVpbz6h2XQRmr7ommg3CM4wK
         Eo5ll2kQdGUX8UUY0rikyTAbrEk6TLznXlHcScmP2vHz3C2ibwJHWJ6C5D732TwDpd7I
         M/GXf4DHXwthymIvylsvglnnTJJRsb0AoPeYuIX5Zx29XmFZvpdnvUqlSfu3jx7TuBe3
         yQ1msQhSYbeSc/XO+He/VdWIXMhKY2mtDWovwJ6ao6rf4oF9iwORyfS/VuN4G18njWhu
         QGC1NXCYRPiNUYwnXOGX4kPU5Q26SCmiXXas45Ver6C2cck5b3YWGADF3oqgcrwMQux9
         oRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ifb0D+1WqBBzNJ8/3rrdcsNeQPMZ9f86icYxJTZY2Tk=;
        b=hvIlAy9EduwQ8AxA0308FNzQzdsZGDczt0l5BtPOPtkn6BnzWscLoSk0xgtyH8Vd6r
         V3IWOfHtQ5luQFXiwHY9mIxeW7ft5m/nX8xcBuVretzlMcJzMeltL47cZcnPq+nVF4hx
         UX3KxPwlJbAoTD1R138k2SPDQZ575tb9yTPXCGu7qubNLLXNa5Ne+FH4PRST+zX5mPWE
         qNl5PkS/qcBoHIRxu5N1FiwV0Vr7ckFi5e4JhsWc/CyiGcpCpK8z9wHvvz1LI/ABUTaF
         r++fcvSWnwBsoGKbkKc62VjmeUaf8M9in1GHLkwaOQrNtzR3LM6IjlJl2n36C8PkkSOY
         wv+Q==
X-Gm-Message-State: AOAM530r839Vez1RlNHSHQr/yKTE+fIyWvBrau3zBzt5QbG46e0+aPgY
        9FypPbop0Y9ZY/oAwuBt5vaGXk2Z5YKu0AUXUnym49/o+N4=
X-Google-Smtp-Source: ABdhPJyczj+qLYBazhpHBIoxXfzQqDGoHbb3V4Bu2VJaeb78N/Z62RDtgcvN/xzk9dM31jqvD8BGQWpkhmXuQLkqY9A=
X-Received: by 2002:a02:9042:: with SMTP id y2mr7246290jaf.94.1611714705821;
 Tue, 26 Jan 2021 18:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20210124190532.428065-1-andreimatei1@gmail.com> <7d33b412-260f-f4d6-2ed0-b5076dc37179@iogearbox.net>
In-Reply-To: <7d33b412-260f-f4d6-2ed0-b5076dc37179@iogearbox.net>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Tue, 26 Jan 2021 21:31:33 -0500
Message-ID: <CABWLset0EgvNF5nCdYHNMaqYFg8MYZfqpHren41EuRP1Azax-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftest/bpf: testing for multiple logs on REJECT
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 26, 2021 at 6:21 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/24/21 8:05 PM, Andrei Matei wrote:
> > This patch adds support to verifier tests to check for a succession of
> > verifier log messages on program load failure. This makes the
> > errstr field work uniformly across REJECT and VERBOSE_ACCEPT checks.
> >
> > This patch also increases the maximum size of an accepted series of
> > messages to test from 80 chars to 200 chars. This is in order to keep
> > existing tests working, which sometimes test for messages larger than 80
> > chars (which was accepted in the REJECT case, when testing for a single
> > message, but ironically not in the VERBOSE_ACCEPT case, when testing for
> > possibly multiple messages).
> > And example of such a long, checked message is in bounds.c:
> > "R1 has unknown scalar with mixed signed bounds, pointer arithmetic with
> > it prohibited for !root"
> >
> > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > ---
> >   tools/testing/selftests/bpf/test_verifier.c | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> > index 59bfa6201d1d..69298bf8ee86 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -88,6 +88,9 @@ struct bpf_test {
> >       int fixup_map_event_output[MAX_FIXUPS];
> >       int fixup_map_reuseport_array[MAX_FIXUPS];
> >       int fixup_map_ringbuf[MAX_FIXUPS];
> > +     /* Expected verifier log output for result REJECT or VERBOSE_ACCEPT. Can be a
> > +      * tab-separated sequence of expected strings.
> > +      */
> >       const char *errstr;
> >       const char *errstr_unpriv;
> >       uint32_t insn_processed;
> > @@ -995,9 +998,11 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
> >       return 0;
> >   }
> >
> > +/* Returns true if every part of exp (tab-separated) appears in log, in order.
> > + */
> >   static bool cmp_str_seq(const char *log, const char *exp)
> >   {
> > -     char needle[80];
> > +     char needle[200];
> >       const char *p, *q;
> >       int len;
> >
> > @@ -1015,7 +1020,7 @@ static bool cmp_str_seq(const char *log, const char *exp)
> >               needle[len] = 0;
> >               q = strstr(log, needle);
> >               if (!q) {
> > -                     printf("FAIL\nUnexpected verifier log in successful load!\n"
> > +                     printf("FAIL\nUnexpected verifier log!\n"
> >                              "EXP: %s\nRES:\n", needle);
> >                       return false;
> >               }
> > @@ -1130,7 +1135,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
> >                       printf("FAIL\nUnexpected success to load!\n");
> >                       goto fail_log;
> >               }
> > -             if (!expected_err || !strstr(bpf_vlog, expected_err)) {
> > +             if (!expected_err) {
> > +                     printf("FAIL\nTestcase bug; missing expected_err\n");
> > +                     goto fail_log;
>
> Do we have an in-tree case like this?

You're asking if there are tests with expected_res == REJECT and
expected_err == NULL?
There are no such test cases, and the intention of this "testcase bug"
check was to keep it that way.
I can simply fold it into the test failure below, as you're suggesting.

> Given this would also be visible below with 'EXP:'
> being (null), I might simplify and just replace the strstr() with cmp_str_seq().
>
> Also, could you elaborate on which test cases need the cmp_str_seq() conversion?

There are VERBOSE_ACCEPT tests that you a tab-separated list of
expected messages; see precise.c.
There are no such REJECT tests yet. I was about to introduce one in
another patch that's inflight, but I ended
up not needing to. Still, I figured that unifying the capabilities of
.errstr between VERBOSE_ACCEPT and REJECT
is a good idea. If you don't think so, I'm happy to drop this patch.

>
> > +             }
> > +             if ((strlen(expected_err) > 0) && !cmp_str_seq(bpf_vlog, expected_err)) {
>
> (nit: no extra '()' needed, but either way I'd rather opt for '!expected_err ||
> !cmp_str_seq(bpf_vlog, expected_err)' anyway)
>
> >                       printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
> >                             expected_err, bpf_vlog);
> >                       goto fail_log;
> >
>
