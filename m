Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB67E36B6A2
	for <lists+bpf@lfdr.de>; Mon, 26 Apr 2021 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhDZQUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhDZQUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:30 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FC7C061761;
        Mon, 26 Apr 2021 09:19:49 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id t94so12338838ybi.3;
        Mon, 26 Apr 2021 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zB5UUN9aIWEV/M+iyVZwKW588IZlytVSoODrnO05GKQ=;
        b=j9nhxF2N7XbYLtXuUscJpuvD6NJ+HDHCcvH8g2Tde6dBxDBi+2SM3d0nvPi0SCY5BC
         Gr9WivVU7OTUylJEiRML0NwfQBF6vOOh8N+1rMv31oPpWhIcuKlGpagSakHvDgEVA0UU
         hKG4Z/sT3SmPBXHZRNrV977PRntLQQxLDw9qF4jut7L1Q2J2RXZgV6Y/YN430rWZ8dFr
         Lv9rvH85SeKXmAeUyZdYiAj3BxVvZ17UzwwpQNR46vwIfWaFaV42zQQRyZBQQkZywmmv
         mTT3ERQovVWHrtvJDlEz/dw3sQERgsdTcUF8s+Ttqhf5iGqEadDlO8XRl7iIHBRIp0ql
         G9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zB5UUN9aIWEV/M+iyVZwKW588IZlytVSoODrnO05GKQ=;
        b=fVW4ItDzYbyiqU05lSsqgvRxRlNwYzllw4geBcoMqVBO/kGX0LKWStxwu/OEYPSl1l
         TIIpQI6Pdf0cmuifYDGoXKgNrTksx7IfjB6x2vu60ozC73ITw7Hj+ChuN75dzwFz3ryw
         uVFH68Q4TvC9a8hSPDTcUu+C1krMS8r/CZpBTyRFDvZG9Q4Kjlftt1a9tArr2GoThyPd
         nnsxAf2SGWLhychvLDEnzneS49qokMkDvxjjgenwf58/xuqVk6AJpCN6zQccRDcUGwDq
         OIatIiVj+UT6siCNiaPzo8oHo+NYEi6YxwSteFfkrQKsexhK7brrQErpxt6ssq2gaGIf
         yA0A==
X-Gm-Message-State: AOAM533ylSP0fkh4qH2Ze7coHnifyf+xbJSd8F1iqxJBKENPaq8EFpT1
        4mOJnwgpA/ObwcLIkq0qmm/c4dnJH/jK2kQWg+ythN+QhTU=
X-Google-Smtp-Source: ABdhPJxBK0Xn43mxEb9uP3oocJCmZKhM1BXNFc+/ZeFYg08qsHDGnsh4lhdJ10W/f3kz5hzADv7g2iUxlfSNsM4NkYY=
X-Received: by 2002:a25:3357:: with SMTP id z84mr25805007ybz.260.1619453988319;
 Mon, 26 Apr 2021 09:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-7-revest@chromium.org>
 <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com> <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com>
In-Reply-To: <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Apr 2021 09:19:37 -0700
Message-ID: <CAEf4BzZnkYDAm2R+5R9u4YEdZLj=C8XQmpT=iS6Qv0Ne7cRBGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 26, 2021 at 3:10 AM Florent Revest <revest@chromium.org> wrote:
>
> On Sat, Apr 24, 2021 at 12:38 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Apr 19, 2021 at 8:52 AM Florent Revest <revest@chromium.org> wrote:
> > >
> > > The "positive" part tests all format specifiers when things go well.
> > >
> > > The "negative" part makes sure that incorrect format strings fail at
> > > load time.
> > >
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > ---
> > >  .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++++++++++++++
> > >  .../selftests/bpf/progs/test_snprintf.c       |  73 ++++++++++
> > >  .../bpf/progs/test_snprintf_single.c          |  20 +++
> > >  3 files changed, 218 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > > new file mode 100644
> > > index 000000000000..a958c22aec75
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > > @@ -0,0 +1,125 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2021 Google LLC. */
> > > +
> > > +#include <test_progs.h>
> > > +#include "test_snprintf.skel.h"
> > > +#include "test_snprintf_single.skel.h"
> > > +
> > > +#define EXP_NUM_OUT  "-8 9 96 -424242 1337 DABBAD00"
> > > +#define EXP_NUM_RET  sizeof(EXP_NUM_OUT)
> > > +
> > > +#define EXP_IP_OUT   "127.000.000.001 0000:0000:0000:0000:0000:0000:0000:0001"
> > > +#define EXP_IP_RET   sizeof(EXP_IP_OUT)
> > > +
> > > +/* The third specifier, %pB, depends on compiler inlining so don't check it */
> > > +#define EXP_SYM_OUT  "schedule schedule+0x0/"
> > > +#define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
> > > +
> > > +/* The third specifier, %p, is a hashed pointer which changes on every reboot */
> > > +#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
> > > +#define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
> > > +
> > > +#define EXP_STR_OUT  "str1 longstr"
> > > +#define EXP_STR_RET  sizeof(EXP_STR_OUT)
> > > +
> > > +#define EXP_OVER_OUT "%over"
> > > +#define EXP_OVER_RET 10
> > > +
> > > +#define EXP_PAD_OUT "    4 000"
> >
> > Roughly 50% of the time I get failure for this test case:
> >
> > test_snprintf_positive:FAIL:pad_out unexpected pad_out: actual '    4
> > 0000' != expected '    4 000'
> >
> > Re-running this test case immediately passes. Running again most
> > probably fails. Please take a look.
>
> Do you have more information on how to reproduce this ?
> I spinned up a VM at 87bd9e602 with ./vmtest -s and then run this script:
>
> #!/bin/sh
> for i in `seq 1000`
> do
>   ./test_progs -t snprintf
>   if [ $? -ne 0 ];
>   then
>     echo FAILURE
>     exit 1
>   fi
> done
>
> The thousand executions passed.
>
> This is a bit concerning because your unexpected_pad_out seems to have
> an extra '0' so it ends up with strlen(pad_out)=11 but
> sizeof(pad_out)=10. The actual string writing is not really done by
> our helper code but by the snprintf implementation (str and str_size
> are only given to snprintf()) so I'd expect the truncation to work
> well there. I'm a bit puzzled

I'm puzzled too, have no idea. I also can't repro this with vmtest.sh.
But I can quite reliably reproduce with my local ArchLinux-based qemu
image with different config (see [0] for config itself). So please try
with my config and see if that helps to repro. If not, I'll have to
debug it on my own later.

  [0] https://gist.github.com/anakryiko/4b6ae21680842bdeacca8fa99d378048
