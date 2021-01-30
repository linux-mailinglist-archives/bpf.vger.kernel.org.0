Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD9309890
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhA3WEm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 17:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3WEl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jan 2021 17:04:41 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC32C061573
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 14:04:01 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n2so13318102iom.7
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 14:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85aNMx0pYOopLNclulkCGoM3a5SsliJD3z+PXWwv7sY=;
        b=K63VNrOyEtPRMIOAAp1qpY4x/5HI0Jd6VkbslKyjCuFgUB9+4ytl85TjvA3bwErWEX
         vtKK3y34D5USQiW8z++CCRu1rFO3zDUobkWrzMmi34EomV2RZfXWJsqAzUSjg14rU9PX
         j0A7dcmqPygCctM0JeHORpk9ciMsDm7BWa746rTF8cWiHmiQl9Iy5YDs4RhrewX8ukEl
         9ppvl3M46VZy3WK+p/oyuJ+iClrqInbz+T2D0cDp6qGnh0dd4rDOKtBYkgA8qzwHuE4f
         PA80h7sXLykYIcIf7MvpKpFI+RZFeBuJZPt6roNl5gUnLl2RIK0Co7Q5U4Jcj8fdxZuf
         1Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85aNMx0pYOopLNclulkCGoM3a5SsliJD3z+PXWwv7sY=;
        b=bmBmygTX/ZtJW5v3norzICyfOBVmPUStO4RBoSwWeQ7I1WS+oG4WAbKgJXQRRiZr7E
         0eNxTQnYt8AWcRA9ZHYvn2WG2C1Lh+pi0ijzgiFE0jVTRbEnj1qyHbJX0QPzzKKzunZ2
         CBXQLFC2nxsDMFPtbdl68lg3317DqCS1EI8E1jn9sDWT3UeNB3XLRdsSZTy4e+Z6M7e1
         gUV2QIgKzCgtwolyXO0DGf69oGZG7rnN3BXwQ1ahKhvWAA2qIxOsvzUUgES9m7qRTqeo
         w23K3oqorTXXy1xdHS14LypEZaZbZx9XxPdZOmcmUHV6Z6NcOW9GC5XIQVJ6GA0SRk9E
         BoDQ==
X-Gm-Message-State: AOAM530GEEE+Dl285wfz50iyL/zorYBGBCdT9lODtRjsTL8OuhpmCV4K
        aj57AyNdkctRKqRl6JYRv7jxdfRRK5Q51D2fHlcjIw7fP02mLw==
X-Google-Smtp-Source: ABdhPJyXXTaH3hgfMANLndi47aRkBQnBg6Gds4CekVSvmwIjT/RRhyRk7GEP2+yHOZI6fHiq3djviW2k4c0x3oIIB4k=
X-Received: by 2002:a05:6602:2f89:: with SMTP id u9mr7737940iow.99.1612044240713;
 Sat, 30 Jan 2021 14:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20210124190532.428065-1-andreimatei1@gmail.com>
 <7d33b412-260f-f4d6-2ed0-b5076dc37179@iogearbox.net> <CABWLset0EgvNF5nCdYHNMaqYFg8MYZfqpHren41EuRP1Azax-w@mail.gmail.com>
 <82196381-fcd3-c70d-2df3-1515d2a4dd24@iogearbox.net>
In-Reply-To: <82196381-fcd3-c70d-2df3-1515d2a4dd24@iogearbox.net>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Sat, 30 Jan 2021 17:03:49 -0500
Message-ID: <CABWLsesJPs8FFSgxVmOO0VcnYRpgC4te62wMRd5XJHeB2aOE1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftest/bpf: testing for multiple logs on REJECT
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 27, 2021 at 6:24 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/27/21 3:31 AM, Andrei Matei wrote:
> > On Tue, Jan 26, 2021 at 6:21 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 1/24/21 8:05 PM, Andrei Matei wrote:
> >>> This patch adds support to verifier tests to check for a succession of
> >>> verifier log messages on program load failure. This makes the
> >>> errstr field work uniformly across REJECT and VERBOSE_ACCEPT checks.
> >>>
> >>> This patch also increases the maximum size of an accepted series of
> >>> messages to test from 80 chars to 200 chars. This is in order to keep
> >>> existing tests working, which sometimes test for messages larger than 80
> >>> chars (which was accepted in the REJECT case, when testing for a single
> >>> message, but ironically not in the VERBOSE_ACCEPT case, when testing for
> >>> possibly multiple messages).
> >>> And example of such a long, checked message is in bounds.c:
> >>> "R1 has unknown scalar with mixed signed bounds, pointer arithmetic with
> >>> it prohibited for !root"
> >>>
> >>> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> >>> ---
> >>>    tools/testing/selftests/bpf/test_verifier.c | 15 ++++++++++++---
> >>>    1 file changed, 12 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> >>> index 59bfa6201d1d..69298bf8ee86 100644
> >>> --- a/tools/testing/selftests/bpf/test_verifier.c
> >>> +++ b/tools/testing/selftests/bpf/test_verifier.c
> >>> @@ -88,6 +88,9 @@ struct bpf_test {
> >>>        int fixup_map_event_output[MAX_FIXUPS];
> >>>        int fixup_map_reuseport_array[MAX_FIXUPS];
> >>>        int fixup_map_ringbuf[MAX_FIXUPS];
> >>> +     /* Expected verifier log output for result REJECT or VERBOSE_ACCEPT. Can be a
> >>> +      * tab-separated sequence of expected strings.
> >>> +      */
> >>>        const char *errstr;
> >>>        const char *errstr_unpriv;
> >>>        uint32_t insn_processed;
> >>> @@ -995,9 +998,11 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
> >>>        return 0;
> >>>    }
> >>>
> >>> +/* Returns true if every part of exp (tab-separated) appears in log, in order.
> >>> + */
> >>>    static bool cmp_str_seq(const char *log, const char *exp)
> >>>    {
> >>> -     char needle[80];
> >>> +     char needle[200];
> >>>        const char *p, *q;
> >>>        int len;
> >>>
> >>> @@ -1015,7 +1020,7 @@ static bool cmp_str_seq(const char *log, const char *exp)
> >>>                needle[len] = 0;
> >>>                q = strstr(log, needle);
> >>>                if (!q) {
> >>> -                     printf("FAIL\nUnexpected verifier log in successful load!\n"
> >>> +                     printf("FAIL\nUnexpected verifier log!\n"
> >>>                               "EXP: %s\nRES:\n", needle);
> >>>                        return false;
> >>>                }
> >>> @@ -1130,7 +1135,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
> >>>                        printf("FAIL\nUnexpected success to load!\n");
> >>>                        goto fail_log;
> >>>                }
> >>> -             if (!expected_err || !strstr(bpf_vlog, expected_err)) {
> >>> +             if (!expected_err) {
> >>> +                     printf("FAIL\nTestcase bug; missing expected_err\n");
> >>> +                     goto fail_log;
> >>
> >> Do we have an in-tree case like this?
> >
> > You're asking if there are tests with expected_res == REJECT and
> > expected_err == NULL?
> > There are no such test cases, and the intention of this "testcase bug"
> > check was to keep it that way.
> > I can simply fold it into the test failure below, as you're suggesting.
>
> Yeah, I would just fold it given such issue would be visible there as well.
>
> >> Given this would also be visible below with 'EXP:'
> >> being (null), I might simplify and just replace the strstr() with cmp_str_seq().
> >>
> >> Also, could you elaborate on which test cases need the cmp_str_seq() conversion?
> >
> > There are VERBOSE_ACCEPT tests that you a tab-separated list of
> > expected messages; see precise.c.
> > There are no such REJECT tests yet. I was about to introduce one in
> > another patch that's inflight, but I ended
> > up not needing to. Still, I figured that unifying the capabilities of
> > .errstr between VERBOSE_ACCEPT and REJECT
> > is a good idea.
> I think unifying seems reasonable, lets do then.

Please see v2. I've had to do a small change to cmp_str_seq to have it
declare success when looking for "". This is to keep a couple of
existing tests happy which expected REJECT but didn't want to check
any log message.

>
> Thanks,
> Daniel
