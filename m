Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFBB2CF50C
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 20:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgLDTuP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 14:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLDTuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 14:50:14 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B89C0613D1;
        Fri,  4 Dec 2020 11:49:34 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id r127so6474391yba.10;
        Fri, 04 Dec 2020 11:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pssQqJTEr/Ao53PSUwAZTtCUTIw/MtZs2poGnWWmEvQ=;
        b=rKVYiulm4ye94NeDnB1chEK1nEJW6PXd0XU8tAYC/JM0caYjEgStpWAWRvNNmCYpje
         EJZlTVqjqy/9IWYXAK9C1m0vyO7lFZDd2tYHWYdSER/3xQ52OTctWc76zbUhiEdnW9+u
         xJsbnVUKQyUZo3IrnSZvg3rx/xRrJc1TE1KffcuFFMeBB8w2mtpSo94Oh+nGEI6kY/Uc
         r7JIraPTkOMg6G680hE6vOJ411uoEDOqm8vUWzBcgPbUFyYgJyE296gZWpzyOPOsPvFZ
         /laFhfS/NO8zak52PYTFgOqr0azinXlRq34gihke+9OlrCqEQSRpPBToPwm0vD64QP/w
         y5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pssQqJTEr/Ao53PSUwAZTtCUTIw/MtZs2poGnWWmEvQ=;
        b=NkBN4Fo1dttUm2d8nHaTi1vtw+xChV9W0TmhXY/bsD8eEqNq9DqN3WFzPYKDFHiDVY
         mVj5D0BQk2MFK3pSkQzFSHb7khQBkX6hS1rI4Jl0v937Pb+n2+aHRq5HOISD1Fxq+qRH
         HVHnUAMQl+TYxatgQL20NDp0o+hZVmGEOXfAcge8fllCVUkBFII2HCxg7gZl6VFij1KY
         APLwB5SIBmKeFLpKzFIM30IeQ+7hMt4wJjLdeqAWcg0zYi0WKBIxG5Jgn8iaNH+kzzkx
         ENLeilPX9USV9zzCwAdv3s/E4nw0Ic09Phz+a7600MKVeNaaq/LLSfnPw3yIo9jJo7MK
         H6MQ==
X-Gm-Message-State: AOAM532hhTNuaiUnO5IZ/VhsNTELAqwT4n5rLu2tVlz/tDIHTv+LR5Ha
        4tPFToxXgXbTjWmwvO3p89UGxsBhnsIS6gjRzXQ=
X-Google-Smtp-Source: ABdhPJyU0t4h3vajObpDIpV+KjlGvJ63K/IVH2FGE7oTHeNKDbbBdODQlH8VjyvkFDb/+IarElbRbQNdqKWUEcTOgA4=
X-Received: by 2002:a25:6a05:: with SMTP id f5mr4586890ybc.459.1607111373812;
 Fri, 04 Dec 2020 11:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com> <20201203160245.1014867-14-jackmanb@google.com>
 <b629793c-fb9c-6ef5-e2d6-7acaf1d2fc7f@fb.com> <X8oFJW/mMFHVxngY@google.com> <6f008322-0b8f-223a-9148-ce9fee0810dc@fb.com>
In-Reply-To: <6f008322-0b8f-223a-9148-ce9fee0810dc@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 11:49:22 -0800
Message-ID: <CAEf4BzZHty17jLH7T-vDLGZftr077BUb9mSciX2Lt3Ofs4r7CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 13/14] bpf: Add tests for new BPF atomic operations
To:     Yonghong Song <yhs@fb.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 4, 2020 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 12/4/20 1:45 AM, Brendan Jackman wrote:
> > On Thu, Dec 03, 2020 at 11:06:31PM -0800, Yonghong Song wrote:
> >> On 12/3/20 8:02 AM, Brendan Jackman wrote:
> > [...]
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> >>> new file mode 100644
> >>> index 000000000000..66f0ccf4f4ec
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> >>> @@ -0,0 +1,262 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +
> >>> +#include <test_progs.h>
> >>> +
> >>> +
> >>> +#include "atomics_test.skel.h"
> >>> +
> >>> +static struct atomics_test *setup(void)
> >>> +{
> >>> +   struct atomics_test *atomics_skel;
> >>> +   __u32 duration = 0, err;
> >>> +
> >>> +   atomics_skel = atomics_test__open_and_load();
> >>> +   if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
> >>> +           return NULL;
> >>> +
> >>> +   if (atomics_skel->data->skip_tests) {
> >>> +           printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
> >>> +                  __func__);
> >>> +           test__skip();
> >>> +           goto err;
> >>> +   }
> >>> +
> >>> +   err = atomics_test__attach(atomics_skel);
> >>> +   if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
> >>> +           goto err;
> >>> +
> >>> +   return atomics_skel;
> >>> +
> >>> +err:
> >>> +   atomics_test__destroy(atomics_skel);
> >>> +   return NULL;
> >>> +}
> >>> +
> >>> +static void test_add(void)
> >>> +{
> >>> +   struct atomics_test *atomics_skel;
> >>> +   int err, prog_fd;
> >>> +   __u32 duration = 0, retval;
> >>> +
> >>> +   atomics_skel = setup();
> >>
> >> When running the test, I observed a noticeable delay between skel load and
> >> skel attach. The reason is the bpf program object file contains
> >> multiple programs and the above setup() tries to do attachment
> >> for ALL programs but actually below only "add" program is tested.
> >> This will unnecessarily increase test_progs running time.
> >>
> >> The best is for setup() here only load and attach program "add".
> >> The libbpf API bpf_program__set_autoload() can set a particular
> >> program not autoload. You can call attach function explicitly
> >> for one specific program. This should be able to reduce test
> >> running time.
> >
> > Interesting, thanks a lot - I'll try this out next week. Maybe we can
> > actually load all the progs once at the beginning (i.e. in
>
> If you have subtest, people expects subtest can be individual runable.
> This will complicate your logic.
>
> > test_atomics_test) then attach/detch each prog individually as needed...
> > Sorry, I haven't got much of a grip on libbpf yet.
>
> One alternative is not to do subtests. There is nothing run to have
> just one bpf program instead of many. This way, you load all and attach
> once, then do all the test verification.

I think subtests are good for debuggability, at least. But in this
case it's very easy to achieve everything you've discussed:

1. do open() right there in test_atomics_test()  (btw, consider naming
the test just "atomics" or "atomic_insns" or something, no need for
test-test tautology)
2. check if needs skipping, skip entire test
3. if not skipping, load
4. then pass the same instance of the skeleton to each subtest
5. each subtest will
  5a. bpf_prog__attach(skel->prog.my_specific_subtest_prog);
  5b. trigger and do checks
  5c. bpf_link__destroy(<link from 5a step>);
