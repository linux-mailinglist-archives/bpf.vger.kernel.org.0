Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4136B14B
	for <lists+bpf@lfdr.de>; Mon, 26 Apr 2021 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhDZKK7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbhDZKK7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 06:10:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6DEC061756
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 03:10:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l21so12170569iob.1
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fN1CnJTyw4SnuzW6DBA9Vu0o0I1yNjEi0kq9D/Z/LQ=;
        b=VC5Jbt1mUZhRJa1ZD/9L/LbwQ5aW97mMI1TZ/3Td6ktOlGoYQVNPE7WaGDo/cTgrhG
         rHXRlzfr2sRQoAkwwC78WuaYeYATWmQLvI/7Yk6UnCohEEtwLG429skjYJI7Fm3yqlO6
         AK38rjEuSzLGwA50eHF516Yiu234Il1D7XIys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fN1CnJTyw4SnuzW6DBA9Vu0o0I1yNjEi0kq9D/Z/LQ=;
        b=I3sVx6bMXhY06MPGB3QOR1qhmkGQngP5muU2BFwFGVHaCFQB55kzSD29tPXwzb5Swv
         Ueoggnwt6CdzfX+I8ugh4quCkOIpCNYNkLxwcBVjjcgZkJtqog6Eciu2K6im6LWm3Ljy
         FB+T+WjPLm+2MSGJTWiGaRTN/y+5XBgqdYS/2/SnPUXbREryZoEGp1N2wjF65mdPqLKU
         c9cl2G58iCbjD/flWYPwzKv8WwdG24s8gO61Bg1O/84WGCcD5/0Ra9EEq+0w75ZnkWfF
         x2FOSouiMAWEI76oAqyoJM7vl6BETcLkiazO57GLpNLCJszfIym1z5Rp2iKwWs14K634
         e2pQ==
X-Gm-Message-State: AOAM532RlZ9FVhNAlkRXYSOz5gLLb4v5DvhY1lpNjSziElGa0PnE6GZD
        cGkyZs3HprV6es2WbWecWXbILQksMhDGYFCEknr1YQ==
X-Google-Smtp-Source: ABdhPJwgriBQCSHOjdrO17+KXCZW2qXNmeiV/x6yOVr2f5eCl0JJpBSIeqFLUiV7xldi2fX/95tSgAQ+2QJx3f1w2Y0=
X-Received: by 2002:a05:6602:218a:: with SMTP id b10mr13945010iob.122.1619431815692;
 Mon, 26 Apr 2021 03:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-7-revest@chromium.org>
 <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
In-Reply-To: <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 26 Apr 2021 12:10:04 +0200
Message-ID: <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com>
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

On Sat, Apr 24, 2021 at 12:38 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 19, 2021 at 8:52 AM Florent Revest <revest@chromium.org> wrote:
> >
> > The "positive" part tests all format specifiers when things go well.
> >
> > The "negative" part makes sure that incorrect format strings fail at
> > load time.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_snprintf.c       |  73 ++++++++++
> >  .../bpf/progs/test_snprintf_single.c          |  20 +++
> >  3 files changed, 218 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > new file mode 100644
> > index 000000000000..a958c22aec75
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> > @@ -0,0 +1,125 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2021 Google LLC. */
> > +
> > +#include <test_progs.h>
> > +#include "test_snprintf.skel.h"
> > +#include "test_snprintf_single.skel.h"
> > +
> > +#define EXP_NUM_OUT  "-8 9 96 -424242 1337 DABBAD00"
> > +#define EXP_NUM_RET  sizeof(EXP_NUM_OUT)
> > +
> > +#define EXP_IP_OUT   "127.000.000.001 0000:0000:0000:0000:0000:0000:0000:0001"
> > +#define EXP_IP_RET   sizeof(EXP_IP_OUT)
> > +
> > +/* The third specifier, %pB, depends on compiler inlining so don't check it */
> > +#define EXP_SYM_OUT  "schedule schedule+0x0/"
> > +#define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
> > +
> > +/* The third specifier, %p, is a hashed pointer which changes on every reboot */
> > +#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
> > +#define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
> > +
> > +#define EXP_STR_OUT  "str1 longstr"
> > +#define EXP_STR_RET  sizeof(EXP_STR_OUT)
> > +
> > +#define EXP_OVER_OUT "%over"
> > +#define EXP_OVER_RET 10
> > +
> > +#define EXP_PAD_OUT "    4 000"
>
> Roughly 50% of the time I get failure for this test case:
>
> test_snprintf_positive:FAIL:pad_out unexpected pad_out: actual '    4
> 0000' != expected '    4 000'
>
> Re-running this test case immediately passes. Running again most
> probably fails. Please take a look.

Do you have more information on how to reproduce this ?
I spinned up a VM at 87bd9e602 with ./vmtest -s and then run this script:

#!/bin/sh
for i in `seq 1000`
do
  ./test_progs -t snprintf
  if [ $? -ne 0 ];
  then
    echo FAILURE
    exit 1
  fi
done

The thousand executions passed.

This is a bit concerning because your unexpected_pad_out seems to have
an extra '0' so it ends up with strlen(pad_out)=11 but
sizeof(pad_out)=10. The actual string writing is not really done by
our helper code but by the snprintf implementation (str and str_size
are only given to snprintf()) so I'd expect the truncation to work
well there. I'm a bit puzzled
