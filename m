Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C282F7124
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 04:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbhAODsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 22:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbhAODsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 22:48:14 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57D6C061575;
        Thu, 14 Jan 2021 19:47:32 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a12so11234878lfl.6;
        Thu, 14 Jan 2021 19:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUoYG1aQlB7dSe08I8qA9iZwXLLkDAhxs+3M3UA36LE=;
        b=p8vwErNxhg9GD+Y1AJId3BabuPOkSjgH7fI8yIj9gFI3+0Clgm49cO3/TLYcD3tUt8
         JUehVjlXRdr1OvEg4cLQa3Fv/5r7wHdlhzubI0aMZE4qV9NmX7WPibnJM7dDfyd3GR5J
         eJCAS92nKTx8LLWsiHRa4+cAJWJzfZQ4BIOdT90H6o4wOAvnjGrVaJ6NpiAefsuxXNNV
         CcgtDsK+QrGma6aYsCtXOA3yvb4ccGd/psy7cy/YyAY3JYvQ622ppJEBJHOJNBN10U7t
         xscya8aWEnI4xDxwoE2LRuwvrXWURhbaG9rAFc4xJPxX6LlwiwfTBq1y0m18v4kKDx+z
         byaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUoYG1aQlB7dSe08I8qA9iZwXLLkDAhxs+3M3UA36LE=;
        b=aevP+FBZcOzjoAiW9WhksGRjXmeyAFAvu0fEb3bDH3krO+/66iyxgpTVoM8EY+pros
         R8lmSdYCwnN30S4wBf9CjVMPYZigZr+J1cocB6EgXw5jY4jUz1nWQHgprLgEAAUsowPp
         jVthxi1p7WBuOJ3OyjJYRezka633Z7sA4ATOlQwQhCt6KxqRF5v2wTsAA0Sashm2x3CN
         rQ68G4oGDzv+iN0mJS9g64sL6cuW5FLZEmMLqZ9uBY5kSsihSL4raEVDQ8kpASHD8Mpb
         mg/xmEvRX9egj+jkpgYj5SjqaAHWI23eomUyqEfcbGuoP67gUipL2Mb5cR+anSMfYBF8
         rbCQ==
X-Gm-Message-State: AOAM5332XUb1srrliZlfpaWB7ojCeDbaOuLkOykM/J3ki/2kpRZY/i1z
        o0D454P67Gqnx/KsNkq4n5+3RZ/R00BWVr5mggI=
X-Google-Smtp-Source: ABdhPJxaCksTyq4bOT5eEDGSKAlBAo3nsrB6PORL+WNb1G1ykzz7e+2pr07NswDKLFqTuUmfTHjbssII6IV5tq1edMI=
X-Received: by 2002:ac2:5b1e:: with SMTP id v30mr5129391lfn.540.1610682451359;
 Thu, 14 Jan 2021 19:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20210114134044.1418404-1-jolsa@kernel.org> <20210114134044.1418404-3-jolsa@kernel.org>
 <19f16729-96d6-cc8e-5bd5-c3f5940365d4@fb.com> <20210114200120.GF1416940@krava>
 <d90fd73f-b9a6-c436-f8ae-0833ce3926ef@fb.com> <20210114220234.GA1456269@krava>
 <5043cef5-eda7-4373-dcb5-546f6192e1a9@fb.com>
In-Reply-To: <5043cef5-eda7-4373-dcb5-546f6192e1a9@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Jan 2021 19:47:20 -0800
Message-ID: <CAADnVQLkM7+1+wzg=s8+zdKwYnmBRgvVK7K-qivu_a9mvaK7Yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add size arg to build_id_parse function
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 3:44 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/14/21 2:02 PM, Jiri Olsa wrote:
> > On Thu, Jan 14, 2021 at 01:05:33PM -0800, Yonghong Song wrote:
> >>
> >>
> >> On 1/14/21 12:01 PM, Jiri Olsa wrote:
> >>> On Thu, Jan 14, 2021 at 10:56:33AM -0800, Yonghong Song wrote:
> >>>>
> >>>>
> >>>> On 1/14/21 5:40 AM, Jiri Olsa wrote:
> >>>>> It's possible to have other build id types (other than default SHA1).
> >>>>> Currently there's also ld support for MD5 build id.
> >>>>
> >>>> Currently, bpf build_id based stackmap does not returns the size of
> >>>> the build_id. Did you see an issue here? I guess user space can check
> >>>> the length of non-zero bits of the build id to decide what kind of
> >>>> type it is, right?
> >>>
> >>> you can have zero bytes in the build id hash, so you need to get the size
> >>>
> >>> I never saw MD5 being used in practise just SHA1, but we added the
> >>> size to be complete and make sure we'll fit with build id, because
> >>> there's only limited space in mmap2 event
> >>
> >> I am asking to check whether we should extend uapi struct
> >> bpf_stack_build_id to include build_id_size as well. I guess
> >> we can delay this until a real use case.
> >
> > right, we can try make some MD5 build id binaries and check if it
> > explodes with some bcc tools, but I don't expect that.. I'll try
> > to find some time for that
>
> Thanks. We may have issues on bcc side. For build_id collected in
> kernel, bcc always generates a length-20 string. But for user
> binaries, the build_id string length is equal to actual size of
> the build_id. They may not match (MD5 length is 16).
> The fix is probably to append '0's (up to length 20) for user
> binary build_id's.
>
> I guess MD5 is very seldom used. I will wait if you can reproduce
> the issue and then we might fix it.

Indeed.
Jiri, please check whether md5 is really an issue.
Sounds like we have to do something on the kernel side.
Hopefully zero padding will be enough.
I would prefer to avoid extending uapi struct to cover rare case.

I've applied the series, since this issue sounds orthogonal.
