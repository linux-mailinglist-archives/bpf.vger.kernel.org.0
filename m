Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5B1A24DC
	for <lists+bpf@lfdr.de>; Wed,  8 Apr 2020 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgDHPV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Apr 2020 11:21:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34181 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726663AbgDHPV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Apr 2020 11:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586359315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BwE0KT9Q2rjk3YzYy8UNLeZQzIQlzHOMHy1Y/W1+zY=;
        b=EtWdg1qHXILHVm45LbsyerroiOKrjSxYSRlgTHIQiKOB4zWQ2jfpCr+FjS9rB3N5C7hnU4
        6XCBpKj2gzTfZH0iHq3oJhRsqmn1SJOC3L+oRlTLZ1EAoybhBUG2YSUvMq7H7bE0jt/Ni9
        u9uID6vDo/LQs+hFmZwcoiQ6xC+EuF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-ABlaN5caO86TDJkTY6694A-1; Wed, 08 Apr 2020 11:21:52 -0400
X-MC-Unique: ABlaN5caO86TDJkTY6694A-1
Received: by mail-wr1-f69.google.com with SMTP id y6so4278309wrq.21
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2020 08:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2BwE0KT9Q2rjk3YzYy8UNLeZQzIQlzHOMHy1Y/W1+zY=;
        b=j/1AbccLMkkbhIdnQqkHt3XcExT2GWM0izILLpgIpO6H81Mbci44dmPYKNyWB7golH
         i1AtD/VVqp1iSJVy4TkxcM8rFSB1bv7oHaGzQV6hFFB7Rx1RvGTMISMH8AXgWeeLL1dP
         unWtJhz1pI8N8Fzg9sfxbHltb8RnMIFKLxPTjS1jS+YPXi8OHGzJDeqR5/M0+DBSVJZ3
         5NydeiQX3jJhUXcmTxVb7IZpgf0vzHz1yCaN5gn2IWzqdqchggQKt2HqmV84XdXaVUDI
         2rsXyO4oT3VWGFm9z2gpLQsN+R9vDCJEcELmaQd5VWa4Q0M6T/Tej1hroTlm3VrHmtxi
         bkfg==
X-Gm-Message-State: AGi0PubsjCDl8o+H0v83gvBkCs1Ys5X0L9k/sq1Rne2wOqWVg7vF76sT
        5jelaql7A8UmAWNidcWQ+dlB/wBjZQRynSe2JTPqvyRcoIcl+zTNXKznM4Q6Tb/DCTdwVZs28Mi
        D3WHpJbqcwZ9U
X-Received: by 2002:adf:a1c3:: with SMTP id v3mr8979183wrv.19.1586359310779;
        Wed, 08 Apr 2020 08:21:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypJJroi0n/uGtuc5zx+HA3W8TuAIaZQ1OKcxjc72XIm15CyQetrXx4jphld/jAxjiY+IP3QybA==
X-Received: by 2002:a2e:b8c1:: with SMTP id s1mr5538800ljp.0.1586358872084;
        Wed, 08 Apr 2020 08:14:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c22sm13660442lja.86.2020.04.08.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:14:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 755431804E7; Wed,  8 Apr 2020 17:14:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next 4/8] bpf: support GET_FD_BY_ID and GET_NEXT_ID for bpf_link
In-Reply-To: <CAEf4BzYrW43EW_Uneqo4B6TLY4V9fKXJxWj+-gbq-7X0j7y86g@mail.gmail.com>
References: <20200404000948.3980903-1-andriin@fb.com> <20200404000948.3980903-5-andriin@fb.com> <87pnckc0fr.fsf@toke.dk> <CAEf4BzYrW43EW_Uneqo4B6TLY4V9fKXJxWj+-gbq-7X0j7y86g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Apr 2020 17:14:27 +0200
Message-ID: <877dyq80x8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Apr 6, 2020 at 4:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Andrii Nakryiko <andriin@fb.com> writes:
>>
>> > Add support to look up bpf_link by ID and iterate over all existing bp=
f_links
>> > in the system. GET_FD_BY_ID code handles not-yet-ready bpf_link by che=
cking
>> > that its ID hasn't been set to non-zero value yet. Setting bpf_link's =
ID is
>> > done as the very last step in finalizing bpf_link, together with insta=
lling
>> > FD. This approach allows users of bpf_link in kernel code to not worry=
 about
>> > races between user-space and kernel code that hasn't finished attachin=
g and
>> > initializing bpf_link.
>> >
>> > Further, it's critical that BPF_LINK_GET_FD_BY_ID only ever allows to =
create
>> > bpf_link FD that's O_RDONLY. This is to protect processes owning bpf_l=
ink and
>> > thus allowed to perform modifications on them (like LINK_UPDATE), from=
 other
>> > processes that got bpf_link ID from GET_NEXT_ID API. In the latter cas=
e, only
>> > querying bpf_link information (implemented later in the series) will be
>> > allowed.
>>
>> I must admit I remain sceptical about this model of restricting access
>> without any of the regular override mechanisms (for instance, enforcing
>> read-only mode regardless of CAP_DAC_OVERRIDE in this series). Since you
>> keep saying there would be 'some' override mechanism, I think it would
>> be helpful if you could just include that so we can see the full
>> mechanism in context.
>
> I wasn't aware of CAP_DAC_OVERRIDE, thanks for bringing this up.
>
> One way to go about this is to allow creating writable bpf_link for
> GET_FD_BY_ID if CAP_DAC_OVERRIDE is set. Then we can allow LINK_DETACH
> operation on writable links, same as we do with LINK_UPDATE here.
> LINK_DETACH will do the same as cgroup bpf_link auto-detachment on
> cgroup dying: it will detach bpf_link, but will leave it alive until
> last FD is closed.

Yup, I think this would be a reasonable way to implement the override
mechanism - it would ensure 'full root' users (like a root shell) can
remove attachments, while still preventing applications from doing so by
limiting their capabilities.

Extending on the concept of RO/RW bpf_link attachments, maybe it should
even be possible for an application to choose which mode it wants to pin
its fd in? With the same capability being able to override it of
course...

> We need to consider, though, if CAP_DAC_OVERRIDE is something that can
> be disabled for majority of real-life applications to prevent them
> from doing this. If every realistic application has/needs
> CAP_DAC_OVERRIDE, then that's essentially just saying that anyone can
> get writable bpf_link and do anything with it.

I poked around a bit, and looking at the sandboxing configurations
shipped with various daemons in their systemd unit files, it appears
that the main case where daemons are granted CAP_DAC_OVERRIDE is if they
have to be able to read /etc/shadow (which is installed as chmod 0). If
this is really the case, that would indicate it's not a widely needed
capability; but I wouldn't exactly say that I've done a comprehensive
survey, so probably a good idea for you to check your users as well :)

-Toke

