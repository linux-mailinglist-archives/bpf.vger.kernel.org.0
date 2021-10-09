Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC54427D78
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 23:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhJIVFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Oct 2021 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhJIVFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Oct 2021 17:05:38 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8671DC061762
        for <bpf@vger.kernel.org>; Sat,  9 Oct 2021 14:03:40 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 66so14414292vsd.11
        for <bpf@vger.kernel.org>; Sat, 09 Oct 2021 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7jGqfOw9qo5hC9+eNinvPdCxHHutP8FggIwyWUbnbs=;
        b=cSewnXxVU19bw9LMJ5Om/uRnP044VSKaudv3l4sRqAZawjGzRr3F+NsHj9I2ipGFB5
         utNCUyZVdais78Iky/Cd+Plu8L6hHKbx43Jha5GpI7iclMHosB+qfPCV6Zqtbkr22OZk
         yfPtupWdvC02qfMSAyRbZYI1vSWd0UiMu8dO774/g/3ItNqUeWmWCwAoYxf1LFztmSpi
         ilahAxWNAEP18U7K65BbL9NbjCUP6OWkWgqQchT4ZBosH5LwpOBTELzwxbMTI/USuUwK
         0tu5dHpmCnLsg0XS0H1TD8T4CdTkVmevB86VLDk87C2WJT9cclobORznuAGLE/8h2t50
         dC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7jGqfOw9qo5hC9+eNinvPdCxHHutP8FggIwyWUbnbs=;
        b=Ufxh9ZancdAbe76n54TXjHGGFCZO2B5yC9z041dTFwTDSlyQMJyi91Bp20pd9Yztwj
         P3qDNooH60KyvuSRSC7yzbcv3n2Q1/QkTduB7CAwKd+cB5sf0+FIkY9+vdZAWhPZhrlK
         9d0OxQERg6HRQwZpktT/Rxijtu0cE7gefCnPTy+Tt4tP+K/iIDDxmKIxULYOx1bkZzM8
         pPO1cKPZDtUftyFPetzKnhmb+Rs8N0o5u/m1FVE4HqlWef2dEodYCzKLmGYvmf7yJAJ1
         zC5WyIzNxKbcx5krduICydupXGjjCjypKJtbw3FE4kpuO/OUl8qldlwlq80Suj4gLlYd
         4vrg==
X-Gm-Message-State: AOAM532cHIJEYXYDn9ZdIP3zZsv4VrEcQuQXjLE0ONKH/HKfjtwje0ku
        YhkYwz/7LvkIdZQ8eyyDZg2se6iO+5BuNhY8ZOvCrw==
X-Google-Smtp-Source: ABdhPJzLxzku9b6SlI+6iti9iD5Vq4vYERfK9b1moadJwfIXkszHczDzNlAY0LontEuq6SCS8npWa00m7xqCyD9XmHM=
X-Received: by 2002:a67:4307:: with SMTP id q7mr2345785vsa.54.1633813418641;
 Sat, 09 Oct 2021 14:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211007194438.34443-1-quentin@isovalent.com> <CAEf4BzZd0FA6yX4WzK6GZFW2VbBgEJ=oJ=f4GzkapCkbAGUNrA@mail.gmail.com>
In-Reply-To: <CAEf4BzZd0FA6yX4WzK6GZFW2VbBgEJ=oJ=f4GzkapCkbAGUNrA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Sat, 9 Oct 2021 22:03:27 +0100
Message-ID: <CACdoK4KaaV_OZJdUz30VyQYyJNeseV=7LX+akeeXpFhQe6Zh6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/12] install libbpf headers when using the library
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 8 Oct 2021 at 20:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Tons of ungrateful work, thank you! Applied to bpf-next.
>
> I did a few clean ups (from my POV), see comments on relevant patches.

Thanks for that. I don't mind the clean ups. There are several of them
I considered before sending but wasn't sure about, so it's a good
thing that you did it :).

> Also in a bunch of Makefiles I've moved `| $(LIBBPF_OUTPUT)` to the
> same line if the line wasn't overly long. 80 characters is not a law,
> and I preferred single-line Makefile target definitions, if possible.

No particular preference on my side, so OK.

>
> There is one problem in bpftool's Makefile, but it works with a
> limited case of single file today. Please follow up with a proper fix.

Right, good catch. I'm sending the fix.

>
> Btw, running make in bpftool's directory, I'm getting:
>
> make[1]: Entering directory '/data/users/andriin/linux/tools/lib/bpf'
> make[1]: Entering directory '/data/users/andriin/linux/tools/lib/bpf'
> make[1]: Nothing to be done for 'install_headers'.
> make[1]: Leaving directory '/data/users/andriin/linux/tools/lib/bpf'
> make[1]: Leaving directory '/data/users/andriin/linux/tools/lib/bpf'
>
> Not sure how useful those are, might be better to disable that.

I had a look for bpftool, this is because we always descend into
libbpf's directory (FORCE target). Removing this FORCE target as I did
in samples/bpf/ avoids the descent and clears the output. I'll send a
patch.

>
> When running libbpf's make, we constantly getting this annoying warning:
>
> Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h'
> differs from latest version at 'include/uapi/linux/netlink.h'
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h'
> differs from latest version at 'include/uapi/linux/if_link.h'
>
> If you will get a chance, maybe you can get rid of that as well? I
> don't think we need to stay up to date with netlink.h and if_link.h,
> so this seems like just a noise.

I can look into that. Are you sure you want the warnings removed? Or
would it be cleaner to simply update the headers?

>
> There was also
>
> make[4]: Nothing to be done for 'install_headers'.
>
> when building the kernel. It probably is coming from either
> bpf_preload or iterators, but maybe also resolve_btfids, I didn't try
> to narrow this down. Also seems like a noise, tbh. There are similar
> useless notifications when building selftests/bpf. If it doesn't take
> too much time to clean all that up, I'd greatly appreciate that!

I haven't looked into it yet, but I can do as a follow-up. I'll post
the patches for bpftool first because I prefer to submit the fix for
bpftool's Makefile as soon as possible, and will look at this next.

Thanks,
Quentin
