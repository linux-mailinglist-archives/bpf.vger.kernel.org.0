Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541A636BB02
	for <lists+bpf@lfdr.de>; Mon, 26 Apr 2021 23:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhDZVJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 17:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbhDZVJq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 17:09:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1DC061756
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 14:09:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p8so4748703iol.11
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZKnL2LhXfhO22PBqGzJHWltIvmcGy2nQuksWcQWSNE=;
        b=Sg66DwQQ/VGsayTE0eTodD5DfEC9bvdXoGVRyHg95e3LTyLn6f8MpGg0OQTSUaQCmw
         rfGT4OdFzFwcfAhwYIyj0nYQgt+7qXGsvv1yrqM5qgngdqQTqjdtN1xHZk2Ji5VEeLbV
         4CAMVmJWFGisFE6VDTy1VGxY1NXMR1QLUMG48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZKnL2LhXfhO22PBqGzJHWltIvmcGy2nQuksWcQWSNE=;
        b=kAeoOC0lNyRNW5cyJCr/4wduQUGsIwzycqA4lP6sKKUI6gLsNJ8P7gDrYJLyzIVQYb
         6ewjCUY2G5xrSSyB2Lgx1YvOvzjgkPRwqH/oC16Dtdzh67rcG78WTEWaPrdAJAMCYqUs
         ipiUNATrXWm7tsvQmU7s8ZYPf1lqPursxWCBtTyZdYxPjwwEMD/FFDB+5U6TkcTDJ0RB
         5GrH3X5SosOqb7RVN8jKO5BBWdOTaFbeo5Ku91nwROCOemh6Ytxir6U8CdCrR718ZFjK
         trBMOc8pdzF7u0Igrgj/O7ScZh8HC3K4mji/y5/GB63ejmgr2KWw+O2Saue6t3w7S8er
         NO+A==
X-Gm-Message-State: AOAM533MIvvG/gkpoTnZ7Tsmlol+ODc/9ByqBM2aKISK1rqF3k2Z+vpp
        LDKCiqp3MXQ50gzrxLLdbQDBnZWTNngg2dd9xeHIWg==
X-Google-Smtp-Source: ABdhPJwgU9APzj9tdbQwuysvTzZryH9XGGjTeUj5j4UJk3bbEa5bETW9zGMZZRDdxqbbxrI59gU2uk3428KW8jNRMsI=
X-Received: by 2002:a5d:8188:: with SMTP id u8mr10398975ion.163.1619471343622;
 Mon, 26 Apr 2021 14:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-7-revest@chromium.org>
 <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
 <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com> <CAEf4BzZnkYDAm2R+5R9u4YEdZLj=C8XQmpT=iS6Qv0Ne7cRBGw@mail.gmail.com>
In-Reply-To: <CAEf4BzZnkYDAm2R+5R9u4YEdZLj=C8XQmpT=iS6Qv0Ne7cRBGw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 26 Apr 2021 23:08:52 +0200
Message-ID: <CABRcYmLn2S2g-QTezy8qECsU2QNSQ6wyjhuaHpuM9dzq97mZ7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Mon, Apr 26, 2021 at 6:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 26, 2021 at 3:10 AM Florent Revest <revest@chromium.org> wrote:
> >
> > On Sat, Apr 24, 2021 at 12:38 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Apr 19, 2021 at 8:52 AM Florent Revest <revest@chromium.org> wrote:
> > > >
> > > > The "positive" part tests all format specifiers when things go well.
> > > >
> > > > The "negative" part makes sure that incorrect format strings fail at
> > > > load time.
> > > >
> > > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++++++++++++++
> > > >  .../selftests/bpf/progs/test_snprintf.c       |  73 ++++++++++
> > > >  .../bpf/progs/test_snprintf_single.c          |  20 +++
> > > >  3 files changed, 218 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > > > new file mode 100644
> > > > index 000000000000..a958c22aec75
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > > > @@ -0,0 +1,125 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright (c) 2021 Google LLC. */
> > > > +
> > > > +#include <test_progs.h>
> > > > +#include "test_snprintf.skel.h"
> > > > +#include "test_snprintf_single.skel.h"
> > > > +
> > > > +#define EXP_NUM_OUT  "-8 9 96 -424242 1337 DABBAD00"
> > > > +#define EXP_NUM_RET  sizeof(EXP_NUM_OUT)
> > > > +
> > > > +#define EXP_IP_OUT   "127.000.000.001 0000:0000:0000:0000:0000:0000:0000:0001"
> > > > +#define EXP_IP_RET   sizeof(EXP_IP_OUT)
> > > > +
> > > > +/* The third specifier, %pB, depends on compiler inlining so don't check it */
> > > > +#define EXP_SYM_OUT  "schedule schedule+0x0/"
> > > > +#define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
> > > > +
> > > > +/* The third specifier, %p, is a hashed pointer which changes on every reboot */
> > > > +#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
> > > > +#define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
> > > > +
> > > > +#define EXP_STR_OUT  "str1 longstr"
> > > > +#define EXP_STR_RET  sizeof(EXP_STR_OUT)
> > > > +
> > > > +#define EXP_OVER_OUT "%over"
> > > > +#define EXP_OVER_RET 10
> > > > +
> > > > +#define EXP_PAD_OUT "    4 000"
> > >
> > > Roughly 50% of the time I get failure for this test case:
> > >
> > > test_snprintf_positive:FAIL:pad_out unexpected pad_out: actual '    4
> > > 0000' != expected '    4 000'
> > >
> > > Re-running this test case immediately passes. Running again most
> > > probably fails. Please take a look.
> >
> > Do you have more information on how to reproduce this ?
> > I spinned up a VM at 87bd9e602 with ./vmtest -s and then run this script:
> >
> > #!/bin/sh
> > for i in `seq 1000`
> > do
> >   ./test_progs -t snprintf
> >   if [ $? -ne 0 ];
> >   then
> >     echo FAILURE
> >     exit 1
> >   fi
> > done
> >
> > The thousand executions passed.
> >
> > This is a bit concerning because your unexpected_pad_out seems to have
> > an extra '0' so it ends up with strlen(pad_out)=11 but
> > sizeof(pad_out)=10. The actual string writing is not really done by
> > our helper code but by the snprintf implementation (str and str_size
> > are only given to snprintf()) so I'd expect the truncation to work
> > well there. I'm a bit puzzled
>
> I'm puzzled too, have no idea. I also can't repro this with vmtest.sh.
> But I can quite reliably reproduce with my local ArchLinux-based qemu
> image with different config (see [0] for config itself). So please try
> with my config and see if that helps to repro. If not, I'll have to
> debug it on my own later.
>
>   [0] https://gist.github.com/anakryiko/4b6ae21680842bdeacca8fa99d378048

I tried that config on the same commit 87bd9e602 (bpf-next/master)
with my debian-based qemu image and I still can't reproduce the issue
:| If I can be of any help let me know, I'd be happy to help
