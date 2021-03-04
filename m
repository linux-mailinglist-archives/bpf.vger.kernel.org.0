Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6532DB40
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 21:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhCDUhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 15:37:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232156AbhCDUhX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Mar 2021 15:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614890157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cntCsCUt69Nn2PmpOfjAwScBt7Ru7XwmNh3OZbyVln0=;
        b=dulwVW/phl3IVlcN2Q++PwasgRVx3AxrxDPCdYNQw5+g8vUxK5ykiiHB8AqofRb1b3qK1f
        zLtV7eHrLbKwo2jGyM+DGEZtFdobKnf4yOpv7qVF6JwVbyyCBe+Ki+Y6BJS4RxXfFP/4gL
        AHA50Mol3qq+QlgjWSRTzavpeOWRFOg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-Jkj2jL6HPP-WzT4lXkXgrQ-1; Thu, 04 Mar 2021 15:35:54 -0500
X-MC-Unique: Jkj2jL6HPP-WzT4lXkXgrQ-1
Received: by mail-wr1-f72.google.com with SMTP id y5so8820wrp.2
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 12:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cntCsCUt69Nn2PmpOfjAwScBt7Ru7XwmNh3OZbyVln0=;
        b=fMtHcuKeL8L+WT1aP0GUt6eDa+wWLc4ZO8bTzDymdKvyPGXR9J74mPSPkFIRivNkyo
         foXHL6LbW7BM1OffeWf6Oz4MeEo0eZXfK61tPBEh2OFbMM/oIjF0NJoHyTxEWUxS4Mdj
         36AYlXDe/XZRii9cqtIS8sRzZFKZZtJre0Dp1XRNDtpuRlDKpyQvjMthMYWrcY5oEKXQ
         KMP5XUBhlKtsrt/heQNlaoUppgoeDVpvwJVDxp8Vz+BdjMbZG3pflKEgi++ZTv3Xjzz/
         Y4sQNgpWkwUL9ZIyxD7X/vexy1TaUHSLqB4ezz3nKP1pL0vD9ZsZds48n1t5m3clwLXs
         7hug==
X-Gm-Message-State: AOAM531d8YEy/XYFcKqndllkfuWtqQ+aQdZLQf4HCUeKBactp+dKh4Vu
        MoakVGYaNVWxu6ORGD1yr5nUpexxlmmwA1S797OCPknWqFydfebYvIIgcmTWzilLk4LYOim10D/
        4S/obhOKR3WPk/VnWj3SaE42bdOen
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr5888812wrw.53.1614890153362;
        Thu, 04 Mar 2021 12:35:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzI7qWlISGOIGp6TTGXq6+zGWjX42UcrobDyclT8wHarlCCb/WpkgrZq2BLGNsC8t8RzLXLkc7O3K6LpHfcrs=
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr5888805wrw.53.1614890153230;
 Thu, 04 Mar 2021 12:35:53 -0800 (PST)
MIME-Version: 1.0
References: <xunyim6b5k1b.fsf@redhat.com> <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
 <CANoWswmg29OQw8472t-GYKtWXNsjFZ9AgNSPVgZvSdB566wxQw@mail.gmail.com> <CAEf4Bzav5yxQW2Co+mm=Ceahyym-38n79o6_qVXX0RRzEvXwJQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzav5yxQW2Co+mm=Ceahyym-38n79o6_qVXX0RRzEvXwJQ@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 4 Mar 2021 22:35:37 +0200
Message-ID: <CANoWswmj4HLRj9rG3cyqPQVrjUi7K8S7vvVXkRma2kUf376Ccw@mail.gmail.com>
Subject: Re: bpf selftests and page size
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Wed, Mar 3, 2021 at 7:30 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 3, 2021 at 2:40 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > Hi!
> >
> > On Tue, Mar 2, 2021 at 7:08 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Mar 1, 2021 at 1:02 AM Yauheni Kaliuta
> > > <yauheni.kaliuta@redhat.com> wrote:
> > >
> > > > Bunch of bpf selftests actually depends of page size and has it
> > > > hardcoded to 4K. That causes failures if page shift is configured
> > > > to values other than 12. It looks as a known issue since for the
> > > > userspace parts sysconf(_SC_PAGE_SIZE) is used, but what would be
> > > > the correct way to export it to bpf programs?
> > > >
> > >
> > > Given PAGE_SIZE and PAGE_SHIFT are just #defines, the only way seems
> > > to be to pass it from the user-space as a read-only variable.
> >
> > Compile-time? Just to make sure we are on the same page, the tests may look like
> > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/map_ptr_kern.c#L638
> >
>
> Oh, if it's about ringbuf, then why not just bump its size to 64KB or
> something even bigger.

It will work for me in this, but sounds as workaround since the value
depends of actual page size.

>
> I thought that you were referring to some BPF code that needs to do some calculations based on PAGE_SIZE in runtime.

Do you mean, like that
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/sockopt_sk.c#L12
?

There are such tests as well  :)

