Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9AE32C165
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446903AbhCCWlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:41:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351627AbhCCKrT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 05:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614768301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NA7daVAPhfIB0QUqSfvMss8ckTd4efh60z7i6wP4K08=;
        b=esAuNvQV8Ku9wYw28253jSo46gtzPfnulCkuOJSuIWig3ij5zDNcysvilevyg2R/vyQoAC
        aqcPsVZZEZQarnWvWDEWmlRwppPPXS5UZN1PWaJRK1sOC4V4zc64yl1TVTOGiADqstig3m
        DdIMUaHv7Hvp8ocoZyajn5s1v7BXdAM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-sQB3pYX_PPWQ0mYa8H8diw-1; Wed, 03 Mar 2021 05:39:57 -0500
X-MC-Unique: sQB3pYX_PPWQ0mYa8H8diw-1
Received: by mail-wm1-f71.google.com with SMTP id a65so1619638wmh.1
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 02:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NA7daVAPhfIB0QUqSfvMss8ckTd4efh60z7i6wP4K08=;
        b=CEnVfbfUk3C11TA6+JwvR/ho+PDtcuY5awomUx2EeDl85sqkk6CrVjpowWhTJnhvnO
         PVkXfKB4EGDR5tmhEZe5+kx964JEG2OsVpvpWiSLTrbQANxFB6g6QpcFGEVRYi5h7Gf0
         2uEXKKFuB8y3i//srywEbq79slUngLLQBZo96qNh+LTMuOwEwWqGJaCs3D+bnHYYUIER
         wnOQv4UQSzpEP5QQWKHLbdzyp4vbfB75CNdN0BoSNdhVZfdw1eK2jWDlKLhrG5fR4gCI
         Ii4PjXSnBD1O57DZRSkDHpNE/UZTiCZ+PFCez1TOgvozQbbZ+/+Bwmpg1RkxfK4ha72d
         uYqQ==
X-Gm-Message-State: AOAM530456vK1RaTW+/VZeiIVrFEJC1JJrr8NKAJ1Xgz7ehO9UjIjzGp
        AZbg2/Jd48s7z4bbarfFAFDmRrYvTsZZ7eWxAJK616rZ2jE2F713GZnkqVsDdEHssseZXYon1bS
        Rd06745/mC2V/8qdpeDuBbKdILz88
X-Received: by 2002:a5d:538d:: with SMTP id d13mr27046037wrv.92.1614767996095;
        Wed, 03 Mar 2021 02:39:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjHFp6WqyI60+a0MDNO5lIA0doGgi8Cc9Op/7/4NfY6ogSJWcHbcnupAbKsZ6MW8NNetd2swyZuCHKyyrddcQ=
X-Received: by 2002:a5d:538d:: with SMTP id d13mr27046021wrv.92.1614767995971;
 Wed, 03 Mar 2021 02:39:55 -0800 (PST)
MIME-Version: 1.0
References: <xunyim6b5k1b.fsf@redhat.com> <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 3 Mar 2021 12:39:39 +0200
Message-ID: <CANoWswmg29OQw8472t-GYKtWXNsjFZ9AgNSPVgZvSdB566wxQw@mail.gmail.com>
Subject: Re: bpf selftests and page size
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Tue, Mar 2, 2021 at 7:08 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 1, 2021 at 1:02 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
>
> > Bunch of bpf selftests actually depends of page size and has it
> > hardcoded to 4K. That causes failures if page shift is configured
> > to values other than 12. It looks as a known issue since for the
> > userspace parts sysconf(_SC_PAGE_SIZE) is used, but what would be
> > the correct way to export it to bpf programs?
> >
>
> Given PAGE_SIZE and PAGE_SHIFT are just #defines, the only way seems
> to be to pass it from the user-space as a read-only variable.

Compile-time? Just to make sure we are on the same page, the tests may look like
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/map_ptr_kern.c#L638


-- 
WBR, Yauheni

