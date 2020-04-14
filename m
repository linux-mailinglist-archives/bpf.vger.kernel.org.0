Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6B1A7870
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 12:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438379AbgDNKcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 06:32:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22380 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438363AbgDNKcM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 06:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586860330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puRZHsouOsa+kXRm9Yn+iQV/J7KVw+zCVFM/OzxJ0Iw=;
        b=aMfL/9yUdVPSVYkVm1JzAyo+UiAj8i7qq+MJRgL02mW1TLuXZdwChGHT1AQAxM9Hn5eu/B
        hOm8jZIWLQc8Df9L3LypWadzslhV5a4QlWhquvky328JwFkBMCGo2Z+9sV05QDi4/96src
        yV9eWh+J4j0xNUtASy0oEx3+N0b1v5Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-x6gjLV8DNtGu6CNHh2f6gw-1; Tue, 14 Apr 2020 06:32:09 -0400
X-MC-Unique: x6gjLV8DNtGu6CNHh2f6gw-1
Received: by mail-lj1-f198.google.com with SMTP id j15so1228461lji.4
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 03:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=puRZHsouOsa+kXRm9Yn+iQV/J7KVw+zCVFM/OzxJ0Iw=;
        b=RZNfQLpAhkuTA7kK6jehF8JYHGFQKprQFjMECo5HZeIsPwwQnLjiz5JpIkyhpSfq8y
         TyoFxjCufQrMKCiE4Ix8JkRJjVJryGGAvlCnnq0VF0gDvuDZI04u+wIOIKjIJv1F4pyO
         M6WAWy5HE4CoWPHyT8lfOjghfPbMv0/eFdmsG6+OfvwYhItkNRD+fiXF16Ie8dfMDQ7o
         gwbQDS1XNIwdHBMF/M5v2WtFmkP1AUpEJSH/bWuQaxxHAYnlc3NJDnGD9LElpPcsc5ZB
         jAVHuMSPYg2/cEL9gmLEtBzKFsuOIHinNqO/f2sr2gsGI23EkhDVEZqSAps3hOBPmsc+
         NLhg==
X-Gm-Message-State: AGi0PuabPyvrDxpRpOnChbVxwJAabXXIuoQHHbtkHKeVf5YMqbOtRdN2
        /S8l9y1McG2EDkHoa+gHw6IbbL6r8OEJZghsOmU0McNjrzFK5vEOVlQMS48xQkswXZz+P40V48y
        FH0/0bAz3fT6d
X-Received: by 2002:a2e:884d:: with SMTP id z13mr13832030ljj.158.1586860327528;
        Tue, 14 Apr 2020 03:32:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypLQHW4saFb1NraTKoPsxOqixD5mRrBsjSvfBmThywmMh1KVqoHU+D5sm9B8VhTNk/SIgfK2Kw==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr13832014ljj.158.1586860327243;
        Tue, 14 Apr 2020 03:32:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b21sm8930304ljj.46.2020.04.14.03.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 03:32:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B9016181586; Tue, 14 Apr 2020 12:32:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next 4/8] bpf: support GET_FD_BY_ID and GET_NEXT_ID for bpf_link
In-Reply-To: <CAEf4BzbXCsHCJ6Tet0i5g=pKB_uYqvgiaBNuY-NMdZm8rdZN5g@mail.gmail.com>
References: <20200404000948.3980903-1-andriin@fb.com> <20200404000948.3980903-5-andriin@fb.com> <87pnckc0fr.fsf@toke.dk> <CAEf4BzYrW43EW_Uneqo4B6TLY4V9fKXJxWj+-gbq-7X0j7y86g@mail.gmail.com> <877dyq80x8.fsf@toke.dk> <CAEf4BzaiRYMc4QMjz8bEn1bgiSXZvW_e2N48-kTR4Fqgog2fBg@mail.gmail.com> <87tv1t65cr.fsf@toke.dk> <CAEf4BzbXCsHCJ6Tet0i5g=pKB_uYqvgiaBNuY-NMdZm8rdZN5g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 14 Apr 2020 12:32:04 +0200
Message-ID: <87mu7enysb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> > After that, one can pin bpf_link temporarily and re-open it as
>> > writable one, provided CAP_DAC_OVERRIDE capability is present. All
>> > that works already, because pinned bpf_link is just a file, so one can
>> > do fchmod on it and all that will go through normal file access
>> > permission check code path.
>>
>> Ah, I did not know that was possible - I was assuming that bpffs was
>> doing something special to prevent that. But if not, great!
>>
>> > Unfortunately, just re-opening same FD as writable (which would
>> > be possible if fcntl(fd, F_SETFL, S_IRUSR
>> >  S_IWUSR) was supported on Linux) without pinning is not possible.
>> > Opening link from /proc/<pid>/fd/<link-fd> doesn't seem to work
>> > either, because backing inode is not BPF FS inode. I'm not sure, but
>> > maybe we can support the latter eventually. But either way, I think
>> > given this is to be used for manual troubleshooting, going through few
>> > extra hoops to force-detach bpf_link is actually a good thing.
>>
>> Hmm, I disagree that deliberately making users jump through hoops is a
>> good thing. Smells an awful lot like security through obscurity to me;
>> and we all know how well that works anyway...
>
> Depends on who users are? bpftool can implement this as one of
> `bpftool link` sub-commands and allow human operators to force-detach
> bpf_link, if necessary.

Yeah, I would expect this to be the common way this would be used: built
into tools.

> I think applications shouldn't do this (programmatically) at all,
> which is why I think it's actually good that it's harder and not
> obvious, this will make developer think again before implementing
> this, hopefully. For me it's about discouraging bad practice.

I guess I just don't share your optimism that making people jump through
hoops will actually discourage them :)

If people know what they are doing it should be enough to document it as
discouraged. And if they don't, they are perfectly capable of finding
and copy-pasting the sequence of hoop-jumps required to achieve what
they want, probably with more bugs added along the way.

So in the end I think that all you're really achieving is annoying
people who do have a legitimate reason to override the behaviour (which
includes yourself as a bpftool developer :)). That's what I meant by the
'security through obscurity' comment.

-Toke

