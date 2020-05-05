Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896071C528D
	for <lists+bpf@lfdr.de>; Tue,  5 May 2020 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEEKHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 06:07:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26643 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727931AbgEEKHr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 May 2020 06:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588673265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYuWFMuynq3VbJyNimEz5R2FKeZE2sFhiA3M2NpBMuE=;
        b=eDg9o2jJP99VosQxZdGBWq9SJ7rJ31UI8obX6dEOq/20prpMseIWqN43TqwgNzs0cDjBIS
        KQg01QJ44MKml5wdZU1/VBL29NT3pOHOyy2Y4Twqf9wzCg34T4CvpnDDHa8mVevLa7DqUp
        GmSXYMLiLSplZgbzsgPq3vsq5lgagF0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-D_xbobY_McSfxsLaTclQ2A-1; Tue, 05 May 2020 06:07:44 -0400
X-MC-Unique: D_xbobY_McSfxsLaTclQ2A-1
Received: by mail-lj1-f200.google.com with SMTP id b26so352582ljp.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 03:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aYuWFMuynq3VbJyNimEz5R2FKeZE2sFhiA3M2NpBMuE=;
        b=mqAP67nOY66zwnMV/SiKaAI8YpLERsUjsDju8/9WC1wuOND1uAvDqFFMaQPnppqHsJ
         9YNrOoVMVFVGRuOAormb5QNQetJLm+qsvDDNEYi512FTLI/ezSYDhynviNS+ZXs0bLrW
         gsXdqIB4tRTb5mHMzDh5nTbZeV5ffRevoHK0h2/7+/RSTf1yLl5+ZpjWJddlLWiSYe74
         Cz5E5GOrGG8wqolaa9FHlGn0xSG/d3e8pVpbmrGdRkeDioLJMayk71amiPXlTLxvggAr
         vbj8peNvZJvpGOocry/Rc1xH4BM/uNTVuFC0XNRrqCCbwLz4laDnp+8gKV8MFeFXjWxU
         jYMw==
X-Gm-Message-State: AGi0PubgGFlCQmTOI1pJwY53ffTsNArAENr3froDAsWq6KQSvbUXkVlN
        v++fiDIiFvEGzHlKUEcsdA0fqK3ooDTr4Zc1V6E0eiQgJlee0Sw0p1x6fM5zMPceTiJ5WQ2OKhC
        E5KjZB2odZ2mx
X-Received: by 2002:a05:651c:c8:: with SMTP id 8mr1272933ljr.182.1588673262462;
        Tue, 05 May 2020 03:07:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxlFK3xQvOkXb27eoijKcaRsGbnTDR45HZ//RaU2u09Hd4m0EgGmhWdvcWj04rLF7DfHNkPA==
X-Received: by 2002:a05:651c:c8:: with SMTP id 8mr1272911ljr.182.1588673262170;
        Tue, 05 May 2020 03:07:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c19sm1582447lfh.42.2020.05.05.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:07:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8D85B1804E9; Tue,  5 May 2020 12:07:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eelco Chaudron <echaudro@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next v2] libbpf: fix probe code to return EPERM if encountered
In-Reply-To: <CAEf4BzYHBisx0dLWn-Udp6saPqAA6ew_6W1BJ=zpcQOqWxPSPQ@mail.gmail.com>
References: <158858309381.5053.12391080967642755711.stgit@ebuild> <CAEf4BzYHBisx0dLWn-Udp6saPqAA6ew_6W1BJ=zpcQOqWxPSPQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 May 2020 12:07:40 +0200
Message-ID: <87k11qoftf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, May 4, 2020 at 2:13 AM Eelco Chaudron <echaudro@redhat.com> wrote:
>>
>> When the probe code was failing for any reason ENOTSUP was returned, even
>> if this was due to no having enough lock space. This patch fixes this by
>> returning EPERM to the user application, so it can respond and increase
>> the RLIMIT_MEMLOCK size.
>>
>> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
>> ---
>> v2: Split bpf_object__probe_name() in two functions as suggested by Andrii
>
> Yeah, looks good, and this is good enough, so consider you have my
> ack. But I think we can further improve the experience by:
>
> 1. Changing existing "Couldn't load basic 'r0 = 0' BPF program."
> message to be something more meaningful and actionable for user. E.g.,
>
> "Couldn't load trivial BPF program. Make sure your kernel supports BPF
> (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough
> value."
>
> Then even complete kernel newbies can search for CONFIG_BPF_SYSCALL or
> RLIMIT_MEMLOCK and hopefully find useful discussions. We can/should
> add RLIMIT_MEMLOCK examples to some FAQ, probably as well (if it's not
> there already).

Always on board with improving documentation; and yeah I agree that
"Couldn't load basic 'r0 = 0' BPF program." could be a bit friendlier ;)

> 2. I'd do bpf_object__probe_loading() before obj->loaded is set, so
> that user can have a loop of bpf_object__load() that bump
> RLIMIT_MEMLOCK in steps. After setting obj->loaded = true, user won't
> be able to attemp loading again and will get "object should not be
> loaded twice\n".

In practice this is not going to be enough, though. The memlock error
only triggers on initial load if the limit is already exceeded (by other
BPF programs); but often what will happen is that the program being
loaded will have a map definition that's big enough to exhaust the
memlimit by itself. In which case the memlock error will trigger while
creating maps, not on initial probe.

Since you can't predict where the error will happen, you need to be
prepared to close the bpf object and start over anyway, so I'm not sure
it adds much value to move bpf_object__probe_loading() earlier?

-Toke

