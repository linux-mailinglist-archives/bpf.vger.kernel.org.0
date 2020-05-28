Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A901A1E6951
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405744AbgE1S37 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 14:29:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25686 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405803AbgE1S36 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 14:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590690597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0Vd3Rmv/FJ0VzEZAhAOa4CEuK81Nugu5T6/vtWTnzw=;
        b=gNDFwlsXKhpl3BXE047+U2KY8pzlZEvZAc323yIVSxAfN3lXJXFTIJWQzNTugAp3KLIGhA
        J+YlyLSDO17xXM4mMvP93YeTPJe5WZGRNuOdrge+2byMhMkTMVcf8+mHYiRE7b8UtI5dp3
        sxcYG0ALJ9EnJavO4SQBK4hZgd0nX8c=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-DbLcpSezPiyk9Yj7jI0yAQ-1; Thu, 28 May 2020 14:29:53 -0400
X-MC-Unique: DbLcpSezPiyk9Yj7jI0yAQ-1
Received: by mail-ot1-f70.google.com with SMTP id v6so1766664ots.12
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 11:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0Vd3Rmv/FJ0VzEZAhAOa4CEuK81Nugu5T6/vtWTnzw=;
        b=OntYvPYRwrHXRymu4zxgn2pykw7sILJkKUcXsQqu7OQzqwNVT6whc4TtPr4ZXqOv0G
         UPjT5YXs1+p3JXQmlica0/DzslzQB/UPlui3LtG7qoWasje1+gy3uCc6puArMJbURZaU
         FSJ+dbo3+XWgD+yZ+pb8d+yhCXs9h1HAGkWSGuvHrTAcoYHhm1BmDKVOXJGyACxRpJXy
         FmSfRx2ZfkhgCma/2772L5tHuQikO2MfJdfB6Aa9J0Bv9+cp733Orjr5JrNNY5lkA3pq
         aiwQ54W30iBhIjZ1dVP7j+E0zyu7+zSJSQheASNzbopR+CB68mUWYYWb/a5uO7aNS+UY
         KAPw==
X-Gm-Message-State: AOAM532d7yakliBLfdQZxEcM1ap6g31BhS0xrdktutac0Pqn+q5OZttR
        AszaJeFvKDDjSe6ciTlYrhiZZaWr/aLfFtZqNcL+xX0EKBSg3J9U3Zf+KjOL0r4L/oGH7Zid/9h
        VCQg28IbH/Z6/idHQ+kbXW+htuLt3
X-Received: by 2002:a05:6830:2155:: with SMTP id r21mr3468291otd.187.1590690592714;
        Thu, 28 May 2020 11:29:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg4T0ToaCnYPW94GkNCgylY/4Ew6dw2U7zjptPDZEbgJaQv0LDiIcZmgltwjOWCVFVaLpICn3DsZX1DQVw7yo=
X-Received: by 2002:a05:6830:2155:: with SMTP id r21mr3468272otd.187.1590690592491;
 Thu, 28 May 2020 11:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <xuny367lq1z1.fsf@redhat.com> <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com> <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org> <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org> <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 28 May 2020 21:29:36 +0300
Message-ID: <CANoWsw=NOvkFAv_roNSJhCqK6Z=xAv79CERzDNKz0qSqzZPstQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Thu, May 28, 2020 at 9:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 28, 2020 at 11:07:09AM -0600, Shuah Khan wrote:

[...]
> >
> > Here is what CI users are requesting:
> >
> > - ability to install bpf test with other selftests using kselftest
> >   install. The common framework is in place and with minor changes
> >   to bpf test Makefile, we can make this happen. Others and myself
> >   are willing to work on this, so we can get bpf test coverage in
> >   test rings.
>
> so you're saying that bpf maintainers and all bpf developers now
> would need to incorporate new 'make install' step to their workflow
> because some unknown CI system that is not even functional decided
> to do 'make install' ?
> That's exactly my point about selfish CI developers who put their
> needs in front of bpf community of developers.

May be, it can work both ways to make everybody happy :) (I haven't
seen yet fundamental problems why not).

