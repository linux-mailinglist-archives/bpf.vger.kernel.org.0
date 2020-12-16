Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E332DB927
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 03:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPCaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 21:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPCaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 21:30:10 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7286C0613D6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 18:29:29 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o13so21374188lfr.3
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 18:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8A2U51jQN3ISbj4nHhpGo6Abg1U+fv3evJLjsDH6Vs=;
        b=GQzx1SXM2J6s/MIfluXNDwRnE4OPcEf2UkZBq7s6k11VCKSSNTqM8EbqkTfbarh33b
         fssxfR8x26LQEvAp9g4acxSv1uoBwqpSK39PoW8p6XO1a/UnS636oNX/gyh3EoLmy6im
         O0m8OIrHhyEEpNkrxo4ODXtutDhiRcgiZBBut5wwMnZLNE6VZOZa92JE1ap2iAeUCZ3u
         JgP2u1/UG0cNT8a1wv9yCz1MyIx1Y7PxL8JA7u5BbpqhnkxwJUAHVmZEZqkSr1BqmTMw
         dgcSkUPm/Ewzt8LA996qneFfGAjFIZpINpJsTRHYAOHyT7K4nV+c0fsFJmizcluQogZ6
         vTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8A2U51jQN3ISbj4nHhpGo6Abg1U+fv3evJLjsDH6Vs=;
        b=SEBPeuwY+hpplGGf7Uze9xaRAifjkJMdOstrNtCgcE5XZ6K1olpWB1WEwgl7YAGTnW
         xL7Um91RQ3pr4083cm1uVsXpp8mkYJm7SjreiYjg76kVjSNfj2CBUMmA0LIF4k2qDVRa
         uHahSZfUCrNwugiLInHGVT7FBeHeOtDTO+tZWRmh5G+pnJ7TgNvRD/dScz0hDmVpArQi
         aQfe+D+ZGRJyQio94ZbKjqbbATvqGZCQTZR0tE8wSN7AgCphjBsPf8/aYiV6v0wAxomI
         iqFWa4x5pOyW8TmagzWEaThPOTF966gqSBKNSh81j9IChsAAtVM/xRtbDsavQN8p2ay4
         827g==
X-Gm-Message-State: AOAM532epQ4x3sM3PIrjiLnpASN2R2IDce9WLZO8oZ+0m2s/76389VBP
        GuL4Cv3lvvmj/dJYiZiCtUjrgDDovTkiibNb1ag=
X-Google-Smtp-Source: ABdhPJyTl/t0gMn4701+M4KmFHSiExZPZZWaFBPlT4zG4/2bid/KR20MX+E5vDu7oYnssi0cu5UkC6UyWqA7sp6Uvg8=
X-Received: by 2002:a19:f243:: with SMTP id d3mr11988424lfk.534.1608085768379;
 Tue, 15 Dec 2020 18:29:28 -0800 (PST)
MIME-Version: 1.0
References: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
 <CAADnVQJOCGQanyw2qfG4gxEw3FHQ0oSUbSeAk2WTuZ+mnwVk5Q@mail.gmail.com> <CAM_iQpX8HU1RPHb+vXRH2qqFLETOJHR91dNxjN-y88v-bcNh+Q@mail.gmail.com>
In-Reply-To: <CAM_iQpX8HU1RPHb+vXRH2qqFLETOJHR91dNxjN-y88v-bcNh+Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Dec 2020 18:29:17 -0800
Message-ID: <CAADnVQ+RHnrhTAb84aEoqpjy-ez5Hdr5BwroNskj7AfVS7v6Kg@mail.gmail.com>
Subject: Re: Why n_buckets is at least max_entries?
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 5:55 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 5:45 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 15, 2020 at 1:44 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > Any reason why we allocate at least max_entries of buckets of a hash map?
> > >
> > >  466
> > >  467         /* hash table size must be power of 2 */
> > >  468         htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
> >
> > because hashmap performance matters a lot.
>
> Unless you believe hash is perfect, there is always conflict no matter
> how many buckets we have.
>
> Other hashmap implementations also care about performance, but none
> of them allocates the number of buckets in this aggressive way. In some
> particular cases, for instance max_entries=1025, we end up having almost
> buckets twice of max_entries.

Do you have any numbers to prove that max_entries > 1024 with n_buckets == 1024
would still provide the same level of performance?
