Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3658B3FC748
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 14:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhHaMbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 08:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhHaMbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 08:31:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87429C06175F
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 05:30:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l18so31385007lji.12
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3P6y71J+N/+Nmo4dV8xQ6c1hdhqJwtQ6PsRB5PSlU0=;
        b=Z96RwoJqmJtzEE8VDumdL5JDhfIpRHINK+Yw3/3XSsCf7jDXeDC8UhuHKHEFVHMjYx
         7xwlQg0+gPyz1lvp5fLIUVm0fPM1C8xpV9DkXxOy0Hy3PfmZtG5abRoFLqDYTNNVb1l2
         /+BK71gwBQeTd+rOgRj4rnvE78i3DgvqzE5NpXDZwqws/LyiLAqZ6aFuEK6aWVCAQdPE
         jEJS4k/omCOXdd4ijHH/qrXQM8VEfiaIO78C6slD2Xzg166AW/zJMmezIF90XYnSfqZd
         DzaXV9AEuf9op0H7aEKZiwhOP89LsP6h6mkHm4tw9px8h9uSQkL73yjYxtCeU2fvhNrG
         1myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3P6y71J+N/+Nmo4dV8xQ6c1hdhqJwtQ6PsRB5PSlU0=;
        b=c3JPVKk9o++oWcSsTsR4scHqbHtbAhrz088sLOd39qWgaHehDQO7qOBgO5Oge4T25z
         eDpyp6RB/pU96zGyNe8Wi1pwKYyZnqe/wWKQo36tVvQIGnX0LuEgShIjvpk4G87ZXAcx
         hW2kNJ7RDgAhdi/wYlj8P7b2qQNCgnArO71X/6UFbpx6jUaI8M2ps9NPivNelN42wx2c
         by7JDQbFNatKIUXrEJeXjdHBrtiyFd1dRqI2Pzk0gTjCaX1feJu2IIgpsEwXOoLe06gI
         aq1w5865FPAjrCS1uQBbW4mnfBXWhnGGkcHZmgX0ikUxiEYdC+4ljXJ6a2zbTd+zQJ0+
         8Bdw==
X-Gm-Message-State: AOAM531KpFB+1m/fo+Rt+LkV38qYBdG4hWoMu+cBZ24FnLl/hlMu5T9E
        qpHNNC/4+378K3Dn86BxDPpxLfuisNO7t4atnK0nBbi5EFUBuQ==
X-Google-Smtp-Source: ABdhPJy+5GViwnWqNhudfTv9dTHacF8ugEM1mQP8FE6cO4zAMXjKyzqPiouoR/MVUKoyzaRz2Cdv2IukCPJajzybze4=
X-Received: by 2002:a2e:bf0d:: with SMTP id c13mr2911326ljr.101.1630413010725;
 Tue, 31 Aug 2021 05:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210827231307.3787723-1-fallentree@fb.com> <20210827231307.3787723-2-fallentree@fb.com>
 <CAEf4BzaSO3jfomcwTwtGJpTj730RdVuO714=tXA6pxNRzGKESQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaSO3jfomcwTwtGJpTj730RdVuO714=tXA6pxNRzGKESQ@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Tue, 31 Aug 2021 08:29:44 -0400
Message-ID: <CAJygYd0G1axj_z+_n+13goRYMsW1P4PZKv2eFttDc0Z9T+2jQg@mail.gmail.com>
Subject: Re: [RFC 1/1] selftests/bpf: Add parallelism to test_progs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 11:37 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 27, 2021 at 4:13 PM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This patch adds "-p" parameter to test_progs, which will spawn workers and
> > distribute tests evenly among all workers, speeding up execution.
>
> make and pahole use -j for parallelism, let's use the same for
> familiarity? pahole (make gives a bad example in this regard) is using
> a good convention that if no number of workers is provided with -j, it
> assumes number of CPUs. I think that's a good default, let's do that
> as well.

Ack, with the new server/worker model it would definitely make sense.

>
> >
> > "-p" mode is optional, and works with all existing test selection mechanism,
> > including "-l".
> >
> > Each worker print its own summary and exit with its own status, the main
> > process will collect all status together and exit with a overall status.
>
> Signed-off-by: is missing, don't forget about it.

Ack!

>
> > ---
> >  tools/testing/selftests/bpf/test_progs.c | 94 ++++++++++++++++++++++--
> >  tools/testing/selftests/bpf/test_progs.h |  3 +
> >  2 files changed, 91 insertions(+), 6 deletions(-)
> >
>
> I'll add high-level comments on the cover letter (which single patch
> submissions don't really need, cover letter is required only for patch
> sets with more than one patch; no big deal, but keep this in mind).

Got it!
