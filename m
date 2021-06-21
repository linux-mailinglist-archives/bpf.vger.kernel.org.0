Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE73AF767
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 23:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFUVdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 17:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFUVdU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 17:33:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D382C061756
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 14:31:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so18851380wrm.0
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THl/cfEqtiF8bpjYHQsI8F0jcqmB+ceOTFq/vSn409U=;
        b=JIArUMB/41VU5fe54U9ul6f6d/bvkUmB5dvPIC/oBkwF/qJJ7jLjsshY52MmMmV0cP
         4hQYxdfx9H5t2clz8/Rpq+p3koezpWk00PirVK7oKeWeOwjVxGwzUZAzme0CxKolMemo
         Qz9Qo9QRjMy1cCLjYn2z54HkZoHe2BuN+/RbjXCkrIXVoIEpHj/kvcTp1D0OJN/5UZgi
         NbyR+NPsy13zY/ghu94jxECNDtjP7iFI6z8f6ZY7uGqafux3cXvggShlMh2H/7Fw9eHS
         TfZynOeOxukgAfItfX6V7Guj2xRsIRRwuO/aJfQqOj0r8zQMwfDFFYHWKuM+TGGFlqOj
         fxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THl/cfEqtiF8bpjYHQsI8F0jcqmB+ceOTFq/vSn409U=;
        b=YkeOshukgLaer9HGVnJzB2UY6z0H1n0fvPhr/jtGgOio+c48Iw7fsWlEm+DbrF4/FM
         6Joa/y+adgMBWYCmWvPsws68a3+qr67JeZvwasYY8uegazbHs3MQDWDMb/gQ3bb+gKWG
         tGQWj13hoRK6HK9kgkNLFgshVreH2/Q3Jj7t+S1u+iBN2uoJEnR6wSG2p08OekK05SfP
         ahJPHYLuFGPCR7EkdKc6olFo31Hj8QztYSc0KoJ7U2hZHCp7USg3vXiqHwmVZCrBk7rn
         QyTkxI3VH4/yLpCU3vae9Wbj5GdarxQFsaJWz7vsPtwa8f1jbVU+ZnGD7SPKUj8SJr/F
         hLgA==
X-Gm-Message-State: AOAM533aIbfXqf7eWNhYF7Wq6fCY0bW8cNsb5iJK8/Dw94p2Nca8OnHJ
        ByKoetwoQuyx5JZsq0fW3q6oLUl7ytoLFOm0btkj1A==
X-Google-Smtp-Source: ABdhPJzZa6mY8h9+/DaGpxq4qInMWB2iX+FC8oHrztFc+KztQPVgXbt+vWv67DZfCPEWQTneivyVYbeiw9eU7Vi68dw=
X-Received: by 2002:adf:f30d:: with SMTP id i13mr536208wro.119.1624311064037;
 Mon, 21 Jun 2021 14:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com> <20210621075525.128b476f@canb.auug.org.au>
In-Reply-To: <20210621075525.128b476f@canb.auug.org.au>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Jun 2021 14:30:52 -0700
Message-ID: <CAP-5=fXXomqjVv4bvqhCOGPD3Q4gfCh2eya07NyBksGbkNjxMQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf test: Fix non-bash issue with stat bpf counters
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 20, 2021 at 2:55 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Ian,
>
> On Thu, 17 Jun 2021 11:42:13 -0700 Ian Rogers <irogers@google.com> wrote:
> >
> > $(( .. )) is a bash feature but the test's interpreter is !/bin/sh,
> > switch the code to use expr.
>
> The $(( .. )) syntax is specified in POSIX (see
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_04),
> so unless this caused an actual problem, this change is unnecessary.

Agreed. The issue I was seeing was:

./tests/shell/stat_bpf_counters.sh: line 14: <not + <not / 10 : syntax
error: operand expected (error token is "<not + <not / 10 ")

but that syntax error is caused by running the test within a
hypervisor. I'll resend the patch set with this one dropped.

Thanks,
Ian

> --
> Cheers,
> Stephen Rothwell
