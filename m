Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8412220F0
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgGPKwj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 06:52:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24326 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgGPKwj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 06:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594896757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0emrD91l1z5XCWO1WKDj+Gw8G208dDDkOGJ49Qf5lQ=;
        b=eSX9IqAzTsf4aMRNFjDEw9z4bjIeb444x15LwjBB3L0AC76QAYE5b6IIfx2niem+agq4M3
        IhQS8Kh+qR8lItRYuStIV52UCdXY1In4NI6lBJvirL/xCfMGHofkws5HDct/Sf5iskVxRn
        oW+6trZFKsy77hSxiM6+buSuvC97HN4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-nWkmVVALPFW4J8ZEni20fA-1; Thu, 16 Jul 2020 06:52:35 -0400
X-MC-Unique: nWkmVVALPFW4J8ZEni20fA-1
Received: by mail-qt1-f199.google.com with SMTP id e6so3508188qtb.19
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 03:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=u0emrD91l1z5XCWO1WKDj+Gw8G208dDDkOGJ49Qf5lQ=;
        b=srZGOCBtlycclBht5QI7Lso/Fcpe+JRbINFcuoO3Bh7WFlgdVKNG+L+5dTkFFrrAD1
         if0Zxx7nMn30ZDUq6tKFpyc4clCFveJRiy5J2E3PEnsgG3bdxYF+/V16yffkwgPT6bsK
         uE6VYcPACZnYsYqhIxA4cHxyYmNyDB2YoBpv9tNRXUkTzE/TDuWUIfmRHrOTG64NSHV8
         awYQLDxT9CZH9ehZQjRJ0JLki5purf9r/2hMtFMVM5oPxnc4i6PGFCJ6uHhqcj50WRh7
         P/LxWdoloB171Kq4AAQSW6d5Qmq+v8zmlFtlVLxUv8vqCW9UgjnxILUqs11uRnyQAoDw
         vqfw==
X-Gm-Message-State: AOAM532Zddwakj9k81b/n8Q9J8+06i6BCvbdJsPM2SukLyXUrkXx+6x6
        RfOGn+QVs4vpJ2LFxkxeHl0Twpy9ttOKds9C59VWxAZNTCRWrF7x0vi/EqE0xwKEuWWpoCIB3+8
        hnp+tI2JLX/8l
X-Received: by 2002:a37:9bc9:: with SMTP id d192mr3240109qke.409.1594896754844;
        Thu, 16 Jul 2020 03:52:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpWSsFvzAOLhwSiN5YNalt/1wgOF4BWd5F3Gjz+Ywb4DPSf5HiZyVcULexRdRVCD6eV4oG2g==
X-Received: by 2002:a37:9bc9:: with SMTP id d192mr3240085qke.409.1594896754606;
        Thu, 16 Jul 2020 03:52:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u5sm6661991qke.32.2020.07.16.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:52:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 53F0C1804F0; Thu, 16 Jul 2020 12:52:32 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kicinski@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Takshak Chahande <ctakshak@fb.com>
Subject: Re: [PATCH bpf-next 2/7] bpf, xdp: add bpf_link-based XDP attachment API
In-Reply-To: <CAEf4BzbgPqN8xKX5xpHBRMJSZkhz_BBzBg7r_FPRo=j3ZmLNUQ@mail.gmail.com>
References: <20200710224924.4087399-1-andriin@fb.com> <20200710224924.4087399-3-andriin@fb.com> <877dv6gpxd.fsf@toke.dk> <CAEf4BzY7qRsdcdhzf2--Bfgo-GB=ZoKKizOb+OHO7o2PMiNubA@mail.gmail.com> <87v9ipg8jd.fsf@toke.dk> <CAEf4BzYVEqFUJybw3kjG6E6w12ocr2ncRz7j15GNNGG4BXJMTw@mail.gmail.com> <87lfjlg4fg.fsf@toke.dk> <CAEf4BzYMaKgJOA3koGkcThXriTGAOKGxjhQXYSNT9sVEFbS7ig@mail.gmail.com> <87y2nkeq4s.fsf@toke.dk> <CAEf4BzbgPqN8xKX5xpHBRMJSZkhz_BBzBg7r_FPRo=j3ZmLNUQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 16 Jul 2020 12:52:32 +0200
Message-ID: <87k0z3enpr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Jul 15, 2020 at 8:48 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> >> Yup, that was helpful, thanks! I think our difference of opinion on t=
his
>> >> stems from the same place as our disagreement about point 2.: You are
>> >> assuming that an application that uses XDP sticks around and holds on=
 to
>> >> its bpf_link, while I'm assuming it doesn't (and so has to rely on
>> >> pinning for any persistence). In the latter case you don't really gain
>> >> much from the bpf_link auto-cleanup, and whether it's a prog fd or a
>> >> link fd you go find in your bpffs doesn't make that much difference...
>> >
>> > Right. But if I had to pick just one implementation (prog fd-based vs
>> > bpf_link), I'd stick with bpf_link because it is flexible enough to
>> > "emulate" prog fd attachment (through BPF FS), but the same isn't true
>> > about prog fd attachment emulating bpf_link. That's it. I really don't
>> > enjoy harping on that point, but it feels to be silently dismissed all
>> > the time based on one particular arrangement for particular existing
>> > XDP flow.
>>
>> It can; kinda. But you introduce a dependency on bpffs that wasn't there
>> before, and you end up with resources that are kept around in the kernel
>> if the interface disappears (because they are still pinned). So I
>> consider it a poor emulation.
>
> Yes, it's not exactly 100% the same semantics.
> It is possible with slight additions to API to support essentially
> exactly the same semantics you want with prog attachment. E.g., we can
> either have a flag at LINK_CREATE time, or a separate command (e.g.,
> LINK_PIN or something), that would mark bpf_link as "sticky", bump
> it's refcnt. What happens then is that even if last FD is closed,
> there is still refcnt 1 there, and then there are two ways to detach
> that link:
>
> 1) interface/cgroup/whatever is destroyed and bpf_link is
> auto-detached. At that point auto-detach handler will see that it's a
> "sticky" bpf_link, will decrement refcnt and subsequently free
> bpf_link kernel object (unless some application still has FD open, of
> course).
>
> 2) a new LINK_DESTROY BPF command will be introduced, which will only
> work with "sticky" bpf_links. It will decrement refcnt and do the same
> stuff as the auto-detach handler does today (so bpf_link->dev =3D NULL,
> for XDP link).
>
> I don't mind this, as long as this is not a default semantics and
> require conscious opt-in from whoever creates the link.

Now *this* I would like to see! I have the issue with component progs of
the multiprog dispatcher being pinned and making everything stick
around.

[...]

> Sure, thanks, enjoy your vacation! I'll post v3 then with build fixes
> I have so far.

Thanks! :)

-Toke

