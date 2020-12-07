Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B4D2D1513
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 16:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgLGPtd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 10:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLGPtd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 10:49:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EFDC061793
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 07:48:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a12so6420485wrv.8
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UP632KzV8q/pnPeSOlqUSkndcfY2+BT3fJ9Prk+u7ew=;
        b=Ipdlcls9kyqNyX6Qhc86PRPdrdbMtj53DwOhc2UwWErC83fNYkK3wqSwToYUcLqURz
         FrxkyAJirl59tcHgt1ynxog5yRZwt3lmvNg+ZRncezSDmxQXyAnHHMm9Ck4AmaNrlmIV
         LGv54RwDzC7JtvDLU5h1XI9YmbxvPwG6fVbCKrSBL+Vf/sfODCaH45VFjwbWIFuH0xYc
         dFpsWt8pCiRqjAoLy7/dwyNw+wYr2JgLzaHbGI7a0Zx6uWmpgkk1sXrAphFc23LlVroi
         mVvCbFy1ASeeI5XM/Gikxy/SqxccYyPwBmvOSffpnSJw7MQpL5nl8g779EomKKGmQ/PU
         AD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UP632KzV8q/pnPeSOlqUSkndcfY2+BT3fJ9Prk+u7ew=;
        b=OLXarhhqPEGfUvywaog+J+ZACoPIbOT7e2qMYmF8mgQngEz+XpmXxXrs7ziL/MJ9OY
         ov47vPNRBuEyJx9JjyWJ83UQ/8ryHb13kRhZN9WcqcBKpZkFls57/Tfmouqpe4gZi4Cx
         UM1GuqBpcamAM6TygHKEBEDbdvgRxVEz24gqmwDDWwLaOcZ/2CdBZDfSfkgPbWkLT/Ig
         4MXqg2ErhgwE+9FzNeUcfDfyPZ3zeJyOa5DKb3bAyVvzNtf/0wOuAZE9feOe4HuIrA2A
         coszf7Khvx28EtHnNirv1SVZ5/aflJtb9TUBBdLlrZY2WLJbIOlUQVARqN1j8hz8AOyO
         6ysw==
X-Gm-Message-State: AOAM5324XAWsKcx2a0XrVYcYifv1lKlOL7rQDOTpMn5mTZUEG/Jp309m
        QAkNK9zHm56K6qLyBTu8YyLA5Afo5+AEEA==
X-Google-Smtp-Source: ABdhPJzGA+pA+rM8Nk2dRevaDPo47pLvG38H7lX7zYyZOSidu+JR1gr2BHx9m68iLWRahh+qgLJ1AA==
X-Received: by 2002:adf:8285:: with SMTP id 5mr6622195wrc.289.1607356131397;
        Mon, 07 Dec 2020 07:48:51 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id a13sm14937428wrm.39.2020.12.07.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 07:48:50 -0800 (PST)
Date:   Mon, 7 Dec 2020 15:48:46 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 13/14] bpf: Add tests for new BPF atomic
 operations
Message-ID: <X85O3ihW1s7Afqoz@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-14-jackmanb@google.com>
 <b629793c-fb9c-6ef5-e2d6-7acaf1d2fc7f@fb.com>
 <X8oFJW/mMFHVxngY@google.com>
 <6f008322-0b8f-223a-9148-ce9fee0810dc@fb.com>
 <CAEf4BzZHty17jLH7T-vDLGZftr077BUb9mSciX2Lt3Ofs4r7CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZHty17jLH7T-vDLGZftr077BUb9mSciX2Lt3Ofs4r7CQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 04, 2020 at 11:49:22AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 4, 2020 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 12/4/20 1:45 AM, Brendan Jackman wrote:
> > > On Thu, Dec 03, 2020 at 11:06:31PM -0800, Yonghong Song wrote:
> > >> On 12/3/20 8:02 AM, Brendan Jackman wrote:
> > > [...]
> > >>> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> > >>> new file mode 100644
> > >>> index 000000000000..66f0ccf4f4ec
> > >>> --- /dev/null
> > >>> +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> > >>> @@ -0,0 +1,262 @@
> > >>> +// SPDX-License-Identifier: GPL-2.0
> > >>> +
> > >>> +#include <test_progs.h>
> > >>> +
> > >>> +
> > >>> +#include "atomics_test.skel.h"
> > >>> +
> > >>> +static struct atomics_test *setup(void)
> > >>> +{
> > >>> +   struct atomics_test *atomics_skel;
> > >>> +   __u32 duration = 0, err;
> > >>> +
> > >>> +   atomics_skel = atomics_test__open_and_load();
> > >>> +   if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
> > >>> +           return NULL;
> > >>> +
> > >>> +   if (atomics_skel->data->skip_tests) {
> > >>> +           printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
> > >>> +                  __func__);
> > >>> +           test__skip();
> > >>> +           goto err;
> > >>> +   }
> > >>> +
> > >>> +   err = atomics_test__attach(atomics_skel);
> > >>> +   if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
> > >>> +           goto err;
> > >>> +
> > >>> +   return atomics_skel;
> > >>> +
> > >>> +err:
> > >>> +   atomics_test__destroy(atomics_skel);
> > >>> +   return NULL;
> > >>> +}
> > >>> +
> > >>> +static void test_add(void)
> > >>> +{
> > >>> +   struct atomics_test *atomics_skel;
> > >>> +   int err, prog_fd;
> > >>> +   __u32 duration = 0, retval;
> > >>> +
> > >>> +   atomics_skel = setup();
> > >>
> > >> When running the test, I observed a noticeable delay between skel load and
> > >> skel attach. The reason is the bpf program object file contains
> > >> multiple programs and the above setup() tries to do attachment
> > >> for ALL programs but actually below only "add" program is tested.
> > >> This will unnecessarily increase test_progs running time.
> > >>
> > >> The best is for setup() here only load and attach program "add".
> > >> The libbpf API bpf_program__set_autoload() can set a particular
> > >> program not autoload. You can call attach function explicitly
> > >> for one specific program. This should be able to reduce test
> > >> running time.
> > >
> > > Interesting, thanks a lot - I'll try this out next week. Maybe we can
> > > actually load all the progs once at the beginning (i.e. in
> >
> > If you have subtest, people expects subtest can be individual runable.
> > This will complicate your logic.
> >
> > > test_atomics_test) then attach/detch each prog individually as needed...
> > > Sorry, I haven't got much of a grip on libbpf yet.
> >
> > One alternative is not to do subtests. There is nothing run to have
> > just one bpf program instead of many. This way, you load all and attach
> > once, then do all the test verification.
> 
> I think subtests are good for debuggability, at least. But in this
> case it's very easy to achieve everything you've discussed:
> 
> 1. do open() right there in test_atomics_test()  (btw, consider naming
> the test just "atomics" or "atomic_insns" or something, no need for
> test-test tautology)
> 2. check if needs skipping, skip entire test
> 3. if not skipping, load
> 4. then pass the same instance of the skeleton to each subtest
> 5. each subtest will
>   5a. bpf_prog__attach(skel->prog.my_specific_subtest_prog);
>   5b. trigger and do checks
>   5c. bpf_link__destroy(<link from 5a step>);

Thanks, this seems like the way forward to me.
