Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F53271B3F
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUHNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 03:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUHNO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 03:13:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA2DC061755
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 00:13:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so8217807pgm.11
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27FBm1XqiNw7AjsJuiyEsOatJq+RBJdAk0cH4QyVgm4=;
        b=Sb2PzeL87fShFqdgFltwcSK4VfBnfK8vQiMjV5iIucOhWiIpQYMUAg9Y0N1RO7g46N
         pkAZLXgSET2jjbMXvQXcxC0HFfjpM3zS7SVeZC30SO6LyxTCVyV/81qZgeHO5Gdj4tHb
         TPQTWl162Km/QVcvLA9CK+W6Mw2mAVtJlyI0tfl0z3LwHdnOInQ7cYUDrfkZXoPUp5xy
         gf+RszN2jobN8X1VobBfGU3rdQE/W2A7+HA0v6nZ8GMMrq93VLOnSh3ws8pKkh0hfs4B
         krept19O3AXLiAAaWLstp/1rIZY6rRp70LH++KgsMgtT06rwr3tcxbNdMTfxpueHkO8w
         LX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27FBm1XqiNw7AjsJuiyEsOatJq+RBJdAk0cH4QyVgm4=;
        b=FPtFVLLqrzjCETR2mexNRzc7ZhWeD7ge1JHIxBYuIQNFCOxi97JFtjh2G7f4y2ghab
         /Ahyi4WJi+Ridd0X7dfZvlbPvVrSfHJArp78xAb53jcugWDAVark2nnajtZYKSgSOmt/
         eotuxht+Bl0MrRTGrphHWMkSBOMoLKWZoTGY5c9bwpTJqXP4iUGaBKIstny6jFNUBtpo
         k4f0R0lj8COmR+NkU50yfYZyL1nukUWfCTIbH4uco/6aX2YATbGkqEF/LMw7FtdhhkND
         RU4kZ5kWxbMZ8FAizxLFFxkFl+HvqIr9mySf9V0L67fN04VBaR7dJL/L5NcL+JcZpHIx
         8CgA==
X-Gm-Message-State: AOAM532WHSxl53HuRWIdEgwk5bWR9JJWYqtl8inEfI4cUVex9viHyO8L
        R64PitO+9tLWlKMO0DAECq1+uSzl5bDCt4pms/A=
X-Google-Smtp-Source: ABdhPJx+/N9pIhfN+k7kx+mh3otgIu5Pv+X+oYls7sygR7Ne62+c6bLhwKJ5q+1k4h65hQ4roLjKDjpP6874nUbVtWM=
X-Received: by 2002:a17:902:ed4b:b029:d1:cbfc:6382 with SMTP id
 y11-20020a170902ed4bb02900d1cbfc6382mr31898674plb.24.1600672393773; Mon, 21
 Sep 2020 00:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <CAMp4zn8FPAdDubD=LGmydQvv2PJCeRB-TAeaU92ab4fJAjLnfQ@mail.gmail.com>
In-Reply-To: <CAMp4zn8FPAdDubD=LGmydQvv2PJCeRB-TAeaU92ab4fJAjLnfQ@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 21 Sep 2020 02:13:02 -0500
Message-ID: <CABqSeASeEX0huy5gudQgFA+gZzEizKXEwUT9xnbdOPTcP6-5vQ@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>, bpf@vger.kernel.org,
        Tianyin Xu <tyxu@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 12:49 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> On Sun, Sep 20, 2020 at 10:35 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> >
> Long-term, do you believe static analysis will be viable? I think that it is
> the "ideal" solution here, but I agree in that it is more complex.
>
> Is there a way to "prime" filters, by giving them a syscall #, and if it has
> a terminal condition without inspecting args, it turns into a bitmask entry
> viable?

I think in theory one could follow the execution of the filter, and if
the filter is determined to return a pass for a given syscall number
under all circumstances, we record that syscall. We can then replace
the bitmap_zero call in seccomp_cache_check with a call to bitmap_copy
from the pre-primed bitmap. However, I don't know how much benefit
this would provide.

One ugly part of the current situation is that the kernel has
absolutely no idea what arch numbers returned by syscall_get_arch may
be possible for the machine it is running on. For example, for an
x86_64 machine with IA32 emulation, the arch number can be either
AUDIT_ARCH_I386 or AUDIT_ARCH_X86_64. The seccomp filter will
typically have parts handling both cases. As a result, an uncertainty
for one syscall on one arch will affect the syscall under the same
number for the other arch. If a syscall number is not guaranteed to be
allowed under both arches, it won't be primed. Given that usually a
seccomp filter is a list of allowed syscalls, my guess is that there
won't be many syscalls numbers that will fall under this case; though,
I have not tested this.

We could add an array of possible arch numbers so that the emulator
can refine its tracing. This is probably the best in effort, though,
seccomp_cache_prepare now has to iterate through all combinations of
syscall numbers and arch numbers. Given that seccomp_cache_prepare
should be relatively cold it's probably not too much of a trouble.
Alternatively, we could employ constraint tracking, but that sounds
overly complex for what we are trying to do.

The other question would be, would pre-priming the cache be worth the
effort? The assumption is that the vast majority of cacheable syscalls
will be permitted. For them, only the first time a particular syscall
is invoked would experience the overhead of calling the filter, which
means that this part of the initial run we are going to optimize out
by pre-priming is going to be relatively cold. wdyt?

YiFei Zhu
