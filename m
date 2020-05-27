Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63D21E4ADF
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgE0QsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 12:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgE0QsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 12:48:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BADAC05BD1E
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 09:48:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b6so29798009ljj.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvL8gEb0gFmJWGQrz/s4t2qDmoxG5kgXEI9K+wXq4hM=;
        b=sDLHfJl4G+YuIzGB2dICZWDTw+bPHcFw1y8jkcKeK/YgKkgPsTmY8vTzuHSz+E5l+d
         6Ti6cLwY7XSRkEIoZBzxJmr3l6Rw3WvZQspp7gEptriM6Xu4hFuh9QHZEfuxpO3+0ZDq
         glmemKLD2v8PgHe6I3B2mEOQEaSzKL7nFyttl1HL/Qw2VyRhzQu5otawFeZr52/VJfV5
         QTb8nuD6uWI+F7/Xnyf3/4TmAytxCi0tf0TiC7rwwr0Si1gsn1ChrJ9U4O8kkrKmNwDm
         rj4A9FReOUwz03E1aFvpUj/t2EI50R3PWiemQr34LNWmw0WPpcmoqz98giuFnteZoqtw
         4Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvL8gEb0gFmJWGQrz/s4t2qDmoxG5kgXEI9K+wXq4hM=;
        b=nl2Ylk5HlXgYKht9FdDh0CYdJqpvEEiWN4wCULAGEnuTWhzInaljcFr620d/75lL8A
         vipbl+5itb9CiUGqZBiPvDrivcxutiKpgnoJgTNRkOckD3Cu/JtqoE26eOOdfF82yMjG
         SkF78WvEdnMAvk2nafOELxINDJUAyH6ORYLHlz2bcvPPzmV69kZ5PFLtg9Nt9e5YAByh
         ngH346lFdDb/5U3gWt+H6/GiAFgzq+DOCNlCYZbN6I7aIAyEegMmwr1KqZNDIQgUgfhU
         8XxetFFlwKN3nBBBjYdtVxNobdhFgNVMtlfXntVzGxuwjTp5mCMWFFqN2aYBXK8TDQl5
         zbFg==
X-Gm-Message-State: AOAM531FEiZEfQcp5/7+6xBM6g1WpXHHjPmbrDf9fAn20OLsmNvREoMj
        mI1Vp1bRO+2fYCPuTPE8B62r3R/GEBPv6hGKxBk=
X-Google-Smtp-Source: ABdhPJya0RVrmmiWOIe6qwEl+l8k8sYWIA3E8475EFjErlYOGF0HtyVpc79q8WyaGG68SnCyXBmIUYkjXQ4VApCqnxk=
X-Received: by 2002:a2e:81d1:: with SMTP id s17mr3608162ljg.91.1590598095761;
 Wed, 27 May 2020 09:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <xuny367so4k3.fsf@redhat.com> <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
 <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
 <xunya71uosvv.fsf@redhat.com> <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com>
In-Reply-To: <xuny367lq1z1.fsf@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 May 2020 09:48:04 -0700
Message-ID: <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 27, 2020 at 12:19 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Alexei!
>
> >>>>> On Tue, 26 May 2020 22:37:39 -0700, Alexei Starovoitov  wrote:
>
>  > On Tue, May 26, 2020 at 10:31 PM Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>  >>
>  >> Hi, Andrii!
>  >>
>  >> >>>>> On Tue, 26 May 2020 17:19:18 -0700, Andrii Nakryiko  wrote:
>  >>
>  >> > On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
>  >> > <yauheni.kaliuta@redhat.com> wrote:
>  >> >>
>  >> >> There is difference in depoying static and generated extra resource
>  >> >> files between in/out of tree build and flavors:
>  >> >>
>  >> >> - in case of unflavored out-of-tree build static files are not
>  >> >> available and must be copied as well as both static and generated
>  >> >> files for flavored build.
>  >> >>
>  >> >> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
>  >> >> is chosen in analogy to TEST_GEN_* variants.
>  >> >>
>  >>
>  >> > Can we keep them together but be smarter about what needs to
>  >> > be copied based on source/target directories? I would really
>  >> > like to not blow up all these rules.
>  >>
>  >> I can try, ok, I just find it a bit more clear. But it's good to
>  >> get some input from kselftest about OOT build in general.
>
>  > I see no value in 'make install' of selftests/bpf
>  > and since it's broken just remove that makefile target.
>
> Some CI systems perform testing next stage after building were
> build tree is not available anymore. So it's in use at the
> moment.

such CI systems can do 'cp -r' then
