Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DC432C1B0
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449562AbhCCWwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376656AbhCCRb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 12:31:28 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD339C061756
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 09:30:45 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p186so25387883ybg.2
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 09:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTCuCJYNVLMb10VSfKluphw42zSHU+qJgL/Nx6oGJyQ=;
        b=ZW3fqEDo4/TTHS9Xane+2Oq4fxOMGL8kGG8DIkf5FXmvBWR/ASLbSQoVs4s3QucuTJ
         VvrRZrgFPMPW/9U3L3465rPlYz0seUh80lbaC/KKAimDIiNueITmCJhmdKLC0gOZgjry
         X52rXDzGF6dNIKYWPzh47jy+l9JVzPZtv6AwtsgkrBkCIQEHkaSSUXuByL59tfK/2iHl
         yspEFreu2n6fCZXPM+PMPfZv2TTUXIMtA9TRCCZkl+vaFfnKXsIffQFP2I/C2tNRqJUy
         vbPIHalQAjmaluOxpM+LFc/f0LROPJJglv0DNkpaRXWR8Njy7XYcU586IusauwBsS0bk
         umYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTCuCJYNVLMb10VSfKluphw42zSHU+qJgL/Nx6oGJyQ=;
        b=Wjv9fgtJqy4v/I7qND3KJofskxjdbimhRAJh3DCQyXvzqEhCy8CF5/DEYPDL1AA4bf
         sLQIdYHtHWPa6UD32Gay0JMTqcG0ApKCuKf/GOhY1Mbi91psZXjNFYs/e1EiLHsyzl73
         q03yNPZK1JvgzSrjuZ3v0nKJjm9af0ttE6QcQkSdkVmCyoemA6bHomCdCsLf7cLvPGLF
         ba0VsG4yHiX3IJELgfjP+L5pkzb+q0J2hCjTd4jO/jLYzX8cicA7xxXrkoXVIG+FaRpd
         wT9bFl/Dbw1ZsAggeTWVB0dpYBIZ0HRGZstzrDH9IQGmKGY30ds6MzpGyinP8u0nc+z/
         /JKg==
X-Gm-Message-State: AOAM532EkmVI0S9QCm+BSoDsFwpEvM8+n0mf6GBc+ETfftlQdJdeA3gn
        wM0SVpUPDMMzxzWzeCnFdB3aO6W0/BUn8Gbf8WU=
X-Google-Smtp-Source: ABdhPJxKkrqI+cjLpRJt/Yae6ncLhYQMtzPuOkiyr6pLESqu4oUsPEc7SEjgNDIZ897qNqZMRwDrKupTyx36tZRoj+w=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr498588yba.510.1614792645045;
 Wed, 03 Mar 2021 09:30:45 -0800 (PST)
MIME-Version: 1.0
References: <xunyim6b5k1b.fsf@redhat.com> <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
 <CANoWswmg29OQw8472t-GYKtWXNsjFZ9AgNSPVgZvSdB566wxQw@mail.gmail.com>
In-Reply-To: <CANoWswmg29OQw8472t-GYKtWXNsjFZ9AgNSPVgZvSdB566wxQw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Mar 2021 09:30:34 -0800
Message-ID: <CAEf4Bzav5yxQW2Co+mm=Ceahyym-38n79o6_qVXX0RRzEvXwJQ@mail.gmail.com>
Subject: Re: bpf selftests and page size
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 3, 2021 at 2:40 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi!
>
> On Tue, Mar 2, 2021 at 7:08 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 1, 2021 at 1:02 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> >
> > > Bunch of bpf selftests actually depends of page size and has it
> > > hardcoded to 4K. That causes failures if page shift is configured
> > > to values other than 12. It looks as a known issue since for the
> > > userspace parts sysconf(_SC_PAGE_SIZE) is used, but what would be
> > > the correct way to export it to bpf programs?
> > >
> >
> > Given PAGE_SIZE and PAGE_SHIFT are just #defines, the only way seems
> > to be to pass it from the user-space as a read-only variable.
>
> Compile-time? Just to make sure we are on the same page, the tests may look like
> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/map_ptr_kern.c#L638
>

Oh, if it's about ringbuf, then why not just bump its size to 64KB or
something even bigger. I thought that you were referring to some BPF
code that needs to do some calculations based on PAGE_SIZE in runtime.

>
> --
> WBR, Yauheni
>
