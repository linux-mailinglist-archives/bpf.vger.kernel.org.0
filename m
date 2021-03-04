Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998C432DB74
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 21:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhCDUwj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 15:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhCDUwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 15:52:22 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C041C061756
        for <bpf@vger.kernel.org>; Thu,  4 Mar 2021 12:51:42 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id n195so29965514ybg.9
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiuzCk3sHiMaN6YQigLJUE/kJXbqtpGJ+86yA19dymg=;
        b=T6GpOSUdPsaP00hNu2UsQXSFaIMZ6AfY2YLQb/kwXdI48P5sTLRqhyw29phFj0ne9o
         2bdSM8Xv31jGxz2DLWUX35PLyNJImI0nR7Ro1kqCvGF5NjaGjhcrgrVu1gir+7x6Y9cH
         2iuiGNW2oSJRmV524ks1+cXkEn6uWVewvoqI/Ojpfkvty84WBfyG49L1zO6UpZx54qh2
         koJLW5puyg76E3SBQkXrsWcPf6Q9Ture8JiuPuhhMkCDo7XdAFUCgVtwaGCY4rLRo3z/
         XV85eF644WOGA0Roi58OwuxoATRKmyWceU/BRD8kWg/As9arbI/6I7URO0w54NxzeN56
         M0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiuzCk3sHiMaN6YQigLJUE/kJXbqtpGJ+86yA19dymg=;
        b=TjWevUpSVQv6MUojB1LVa+UU5BLfKuL8s47Rr+s0VBWC9uf/EAr3JDNF1rsXugaXrW
         qmFlsL4aV19Zm3VGGG0A0ll/2YXyoeIVO5Y0mAAx8Mq5ION4phmAUviMmSDg9EAdvJjs
         pHoZyt4GPNgo0xQFk8v4aqEIGWAhyii4+04Jd2R5380UE/nsk2XQt9ORZDBG+q8H1/VB
         9wQ7GEDmtB+xy2FTOcHc4ejiQX4OW7bVrxjgZ6h8orUZSNkFW8u5kqdTZhTGDwfbuUNH
         gkuaf4gPj+OSHb6SzpWdng15YV+3t5d5uUYZQ+6nkdoVgGv9RFk0cZEHCO5GOVpzrWwI
         /4Dg==
X-Gm-Message-State: AOAM530PrTf0+QJXoslsmOxUop5uaHUYClPnxrEzO1J/RXBAm0l71CGZ
        HyyqdGoJ2qwdk11cbvUoxQjZ03irLF3qIqr0u1U=
X-Google-Smtp-Source: ABdhPJziDR8jfVPDGA0k7ODFSK7KDolFdUgd2LYaKd9htTv+bvBYxymq907DvIat7Hi/JOyjsAvq59nTd7O7wrVInCQ=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr8850002yba.510.1614891101550;
 Thu, 04 Mar 2021 12:51:41 -0800 (PST)
MIME-Version: 1.0
References: <xunyim6b5k1b.fsf@redhat.com> <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
 <CANoWswmg29OQw8472t-GYKtWXNsjFZ9AgNSPVgZvSdB566wxQw@mail.gmail.com>
 <CAEf4Bzav5yxQW2Co+mm=Ceahyym-38n79o6_qVXX0RRzEvXwJQ@mail.gmail.com> <CANoWswmj4HLRj9rG3cyqPQVrjUi7K8S7vvVXkRma2kUf376Ccw@mail.gmail.com>
In-Reply-To: <CANoWswmj4HLRj9rG3cyqPQVrjUi7K8S7vvVXkRma2kUf376Ccw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Mar 2021 12:51:30 -0800
Message-ID: <CAEf4BzZdBtNLG1kb4v6XJCPHCiUoxeFX7WB+auZHEifWT-GLdQ@mail.gmail.com>
Subject: Re: bpf selftests and page size
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 4, 2021 at 12:35 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi!
>
> On Wed, Mar 3, 2021 at 7:30 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 3, 2021 at 2:40 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> > >
> > > Hi!
> > >
> > > On Tue, Mar 2, 2021 at 7:08 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 1, 2021 at 1:02 AM Yauheni Kaliuta
> > > > <yauheni.kaliuta@redhat.com> wrote:
> > > >
> > > > > Bunch of bpf selftests actually depends of page size and has it
> > > > > hardcoded to 4K. That causes failures if page shift is configured
> > > > > to values other than 12. It looks as a known issue since for the
> > > > > userspace parts sysconf(_SC_PAGE_SIZE) is used, but what would be
> > > > > the correct way to export it to bpf programs?
> > > > >
> > > >
> > > > Given PAGE_SIZE and PAGE_SHIFT are just #defines, the only way seems
> > > > to be to pass it from the user-space as a read-only variable.
> > >
> > > Compile-time? Just to make sure we are on the same page, the tests may look like
> > > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/map_ptr_kern.c#L638
> > >
> >
> > Oh, if it's about ringbuf, then why not just bump its size to 64KB or
> > something even bigger.
>
> It will work for me in this, but sounds as workaround since the value
> depends of actual page size.

Not at all a work around. ringbuf needs to have the size which is a
multiple of PAGE_SIZE.

>
> >
> > I thought that you were referring to some BPF code that needs to do some calculations based on PAGE_SIZE in runtime.
>
> Do you mean, like that
> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/sockopt_sk.c#L12
> ?

yeah, here we'll need to pass actual page_size from the user-space
using global variable

>
> There are such tests as well  :)
>
