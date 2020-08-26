Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C232529E4
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 11:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHZJW6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 05:22:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727793AbgHZJW6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Aug 2020 05:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598433775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcseBhu0nEPf/QOOslPZhKGmNuiktv7pnyyd3204MF8=;
        b=fpilm4aFZaqosYvJ94mCODYHeQtsezXjL2HwNEI9RrJD+ekKyl2zvIwVy3jdDXRbA19BBw
        JgXqw4RTHNsu669m/WccZY6eQtyGkDHdw4S8D4YvyupFGzs+6WFsC1bRswz6Qu6fJ8+Q7f
        K2iY0y1PF4g50ljtZmDCVtwfuB2JYos=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-pa0z5QlaMo6Jz4dk4Ruthw-1; Wed, 26 Aug 2020 05:22:53 -0400
X-MC-Unique: pa0z5QlaMo6Jz4dk4Ruthw-1
Received: by mail-wm1-f69.google.com with SMTP id r14so547262wmh.1
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 02:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IcseBhu0nEPf/QOOslPZhKGmNuiktv7pnyyd3204MF8=;
        b=EXDG1KV1NBetKR9UW2ikVHRlrVNhljiyF55/9GiJtiCvTFAfMtgVLjsYQspaAews6L
         awTz8nD6t9CSwVCXAt+uKd9fWKqsOlwYpn44DioFEXL5wFPCT+zvaBojdBgwLJFZ2lhK
         o8sv3hg76RFNIRT70cAvvgHvw8iXuRDbdV83B2r4NNnWVbZcmm5nCCcPdE4OY1vGILiE
         XOrmQBzMfmeRQwee8MeQz/mPhtygHWzmWaDEYawoTkcSEiHZEG6X1DFwpRHerqPeoQ1i
         5RLcLjKXb83dPSeVXgoMJ7RvPeWEVawXwPndh5Vc8mdthbZowXpjKJwKLgWsXAlXS1v9
         qQHw==
X-Gm-Message-State: AOAM533v4mk//Jv/Rh9FAAVyA53QBYErCa3e1xLauxrqrIDTQ5+tQBnE
        kluXg/o9PUUDta74OTzI8J9WjYhTXSA7WTJ5hmG1/ikJAbqPnuHJxFBpcV06mbBu6rcGv7uJuc2
        +jN3KXGgi5tOm
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr14950193wrt.67.1598433771672;
        Wed, 26 Aug 2020 02:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs/Ic/leIkOgBEgwyuDE69HxnrPadhLX/raoRNCMUqK6msAMsuA8wY/ai8zOIH05wGRjeZUw==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr14950172wrt.67.1598433771448;
        Wed, 26 Aug 2020 02:22:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g3sm4513833wrb.59.2020.08.26.02.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:22:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 96AE2182B6D; Wed, 26 Aug 2020 11:22:49 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: Advisory file locking behaviour of bpf_link (and others?)
In-Reply-To: <CACAyw988=DLoXJ6dC4qkTCWgQu2M19fVTAhjnF5Hg2Oe=mkmOw@mail.gmail.com>
References: <CACAyw98fJe3qanRVe5LcoP49METHhzjZKPcSGnKQ-o=_F3=Hfw@mail.gmail.com>
 <CAADnVQLji8CMCVoefHPqc457Fz1xZ+yEnogHXpghhx6=GPYTbg@mail.gmail.com>
 <CACAyw988=DLoXJ6dC4qkTCWgQu2M19fVTAhjnF5Hg2Oe=mkmOw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Aug 2020 11:22:49 +0200
Message-ID: <87zh6hwyl2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenz Bauer <lmb@cloudflare.com> writes:

> On Tue, 25 Aug 2020 at 19:06, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Aug 25, 2020 at 6:39 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>> >
>> > Hi,
>> >
>> > I was playing around a bit, and noticed that trying to acquire an
>> > exclusive POSIX record lock on a bpf_link fd fails. I've traced this
>> > to the call to anon_inode_getfile from bpf_link_prime which
>> > effectively specifies O_RDONLY on the bpf_link struct file. This makes
>> > check_fmode_for_setlk return EBADF.
>> >
>> > This means the following:
>> > * flock(link, LOCK_EX): works
>> > * fcntl(link, SETLK, F_RDLCK): works
>> > * fcntl(link, SETLK, F_WRLCK): doesn't work
>> >
>> > Especially the discrepancy between flock(EX) and fcntl(WRLCK) has me
>> > puzzled. Should fcntl(WRLCK) work on a link?
>> >
>> > program fds are always O_RDWR as far as I can tell (so all locks
>> > work), while maps depend on map_flags.
>>
>> Because for links fd/file flags are reserved for the future use.
>> progs are rdwr for historical reasons while maps can have three combinations:
>> /* Flags for accessing BPF object from syscall side. */
>>         BPF_F_RDONLY            = (1U << 3),
>>         BPF_F_WRONLY            = (1U << 4),
>> by default they are rdwr.
>> What is your use case to use flock on bpf_link fd?
>
> The idea is to prevent concurrent access / modification of pinned maps
> + pinned link from a command line tool. I could just as well lock one
> of the maps for this, but conceptually the link is the thing that
> actually controls what maps are used via the attached BPF program.
> FWIW I'm using flock(EX) on the link for now, which is fine for my use
> case. I just thought I'd raise this in case it was an oversight :)

FWIW I'm doing something similar in libxdp, except I'm using flock(EX)
on the parent directory (i.e., /sys/fs/bpf/xdp) since I need to protect
multiple modifications inside it:

https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L245

-Toke

