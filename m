Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71714883B9
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiAHNTX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Jan 2022 08:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231812AbiAHNTV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 8 Jan 2022 08:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641647960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GOVNA9SuwYQsFtw+yXScNi6YMB3yWtPDjX6RhO9knY=;
        b=ePLwDMUjUAIyGOAySnSi4qVA81gUKWXB0RTBJMFkn3lVLa+GIsgsLe9EmGUJvPAvM/bYtr
        Ohyad90J3oyYNSvM+fVa0gmpg/IqfWQfx0dihdhAHSI+mglOinYJd4spURL3LVSN/ZnlEg
        EOSCpzd+jHKJb5HHV+EISqvto17OtBk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-h70PtUdlMzS73TdhjzxmHw-1; Sat, 08 Jan 2022 08:19:19 -0500
X-MC-Unique: h70PtUdlMzS73TdhjzxmHw-1
Received: by mail-ed1-f72.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so6807164edc.2
        for <bpf@vger.kernel.org>; Sat, 08 Jan 2022 05:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1GOVNA9SuwYQsFtw+yXScNi6YMB3yWtPDjX6RhO9knY=;
        b=KNwsxbOfNf1VpK1N9rkmERIvugFBaAdSYA2iv+dqgtzc0AkCwThiI6tjrVwdu+6V+d
         fm1nXzDxkNSDrnVppZpzUuoUQQBRfqdE5+nk7xDWFb2pJIomV/LTB6dV4E9Y44An//CK
         +683CsoFtOU4mtGPs7YFJvMSt4P1NoHav8eW73nag4Bc8uwyvRweTJZ7XODOy/Velv2E
         q6eZibjxHTGV3bIt0+NJy3bC6lFeHezteWdYLxhkJd8pzHcfETQJzIEW0MBRCzPsFoW9
         w0HQChxGcRVTRojkjzdrDBHe7HzsdIZT042qRoIm02a+bxZHnM5sMIw/WXNS0Mh7VPIe
         PR+w==
X-Gm-Message-State: AOAM530a4O7+nkRV0k9khvWVMCEyMRYNYQ7FJBVCvG689iCLrtcdT1C9
        5BwIKmXTSAMhPKZ0lyK4UJreJyt4Fn2APwyNzYi4R9tbwcuGMN9PuwA8n2+UF/vT0ul6V8aoUM6
        1GinXlrmdTbb2
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr9271189eju.173.1641647956911;
        Sat, 08 Jan 2022 05:19:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl8frPs5iWMSCXg8M9iFS0R5FB7NHA5s0p2gjFK1kPqlohOkpklN3IvLKGdSHqYphYYzObrw==
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr9271106eju.173.1641647955243;
        Sat, 08 Jan 2022 05:19:15 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i23sm694664edt.93.2022.01.08.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 05:19:14 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CAC4A181F2A; Sat,  8 Jan 2022 14:19:13 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Add "live packet" mode for XDP in
 bpf_prog_run()
In-Reply-To: <CAADnVQ+uftgnRQa5nvG4FTJga_=_FMAGxuiPB3O=AFKfEdOg=A@mail.gmail.com>
References: <20220107215438.321922-1-toke@redhat.com>
 <20220107215438.321922-2-toke@redhat.com>
 <CAADnVQ+uftgnRQa5nvG4FTJga_=_FMAGxuiPB3O=AFKfEdOg=A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 08 Jan 2022 14:19:13 +0100
Message-ID: <87pmp28iwe.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Jan 7, 2022 at 1:54 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Because the data pages are recycled by the page pool, and the test runner
>> doesn't re-initialise them for each run, subsequent invocations of the X=
DP
>> program will see the packet data in the state it was after the last time=
 it
>> ran on that particular page. This means that an XDP program that modifies
>> the packet before redirecting it has to be careful about which assumptio=
ns
>> it makes about the packet content, but that is only an issue for the most
>> naively written programs.
>
> This is too vague and partially incorrect.
> The bpf program can do bpf_xdp_adjust_meta() and otherwise change
> packet boundaries. These effects will be seen by subsequent
> XDP_PASS/TX/REDIRECT, but on the next iteration the boundaries
> will get reset to the original values.
> So the test runner actually re-initializes some parts of the data,
> but not the contents of the packet.
> At least that's my understanding of the patch.

Yes, that's correct. Boundaries will be reset, data won't. The boundary
reset was added later, though, so guess I neglected to update the commit
message. Will fix.

> The users shouldn't need to dig into implementation to discover this.
> Please document it.
> The more I think about it the more I believe that it warrants
> a little blurb in Documentation/bpf/ that describes what one can
> do with this "xdp live mode".

Sure, can do. Doesn't look like BPF_PROG_RUN is documented in there at
all, so guess I can start such a document :)

> Another question comes to mind:
> What happens when a program modifies the packet?
> Does it mean that the 2nd frame will see the modified data?
> It will not, right?
> It's the page pool size of packets that will be inited the same way
> at the beginning. Which is NAPI_POLL_WEIGHT * 2 =3D=3D 128 packets.
> Why this number?

Yes, you're right: the next run won't see the modified packet data. The
128 pages is because we run the program loop in batches of 64 (like NAPI
does, the fact that TEST_XDP_BATCH and NAPI_POLL_WEIGHT are the same is
not a coincidence).

We need 2x because we want enough pages so we can keep running without
allocating more, and the first batch can still be in flight on a
different CPU while we're processing batch 2.

I experimented with different values, and 128 was the minimum size that
didn't have a significant negative impact on performance, and above that
saw diminishing returns.

> Should it be configurable?
> Then the user can say: init N packets with this one pattern
> and the program will know that exactly N invocation will be
> with the same data, but N+1 it will see the 1st packet again
> that potentially was modified by the program.
> Is it accurate?

I thought about making it configurable, but the trouble is that it's not
quite as straight-forward as the first N packets being "pristine": it
depends on what happens to the packet afterwards:

On XDP_DROP, the page will be recycled immediately, whereas on
XDP_{TX,REDIRECT} it will go through the egress driver after sitting in
the bulk queue for a little while, so you can get reordering compared to
the original execution order.

On XDP_PASS the kernel will release the page entirely from the pool when
building an skb, so you'll never see that particular page again (and
eventually page_pool will allocate a new batch that will be
re-initialised to the original value).

If we do want to support a "pristine data" mode, I think the least
cumbersome way would be to add a flag that would make the kernel
re-initialise the packet data before every program invocation. The
reason I didn't do this was because I didn't have a use case for it. The
traffic generator use case only rewrites a tiny bit of the packet
header, and it's just as easy to just keep rewriting it without assuming
a particular previous value. And there's also the possibility of just
calling bpf_prog_run() multiple times from userspace with a lower number
of repetitions...

I'm not opposed to adding such a flag if you think it would be useful,
though. WDYT?

-Toke

