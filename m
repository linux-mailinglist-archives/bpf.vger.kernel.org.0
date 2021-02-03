Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759A030D800
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhBCK6o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 05:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233405AbhBCK6n (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Feb 2021 05:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612349837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfbgbJhHtgoEa3TTKwz0zjRQm8LFCukH9HmIdgu7JqU=;
        b=PX6uujiBQPpqFNE+IX+6O55rsalb3LpgODCXkc16HUxr9Pd/xwe7bkKlZVs75Y85eXJbGT
        K15kq8LJiT4QSOnYov0cQqIeyi23batrpNzZu/mX/pxpc0rp90gkEVH3XKZ5qdCORIFnZs
        m/pgSIVcCiLBmlBXQfQKmDVscSx0+zU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-r-8VUPvKPGCkdNIbXC-Tsg-1; Wed, 03 Feb 2021 05:57:15 -0500
X-MC-Unique: r-8VUPvKPGCkdNIbXC-Tsg-1
Received: by mail-ed1-f71.google.com with SMTP id y6so11234061edc.17
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 02:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UfbgbJhHtgoEa3TTKwz0zjRQm8LFCukH9HmIdgu7JqU=;
        b=UPe/8NdgXha4QSBb/LqxCa+zkUYRJHRGAlnSfs+hAegOdOOtm80qTbkMqalbWre2/Z
         zaN/+Ve2mzH4qv65L/EdTZ+g6TNCFpSFQzIZ2b5Sds4Qdg1TwyKd6IvZG1aZgsqSsdEt
         nLUEO4v4U8u1hKuPORDIP7Gzh6wWvPCwiiOb3HEmW7Psh5xbv8qx6dxUqr40RmK2NDLf
         zBvOYXPRtiNfq/jywGUD0P6YdmqC5+EnsDUfVM68DhyqNHgH1itn4bI0pRWqRJ3loIaX
         l0bLcG6tqo4AEDGdKcpGAuO1Z/0qmSRWq1pWjy4Xi5cpOA2RtwmiWJDcGmQBO86I1PWa
         x9Gg==
X-Gm-Message-State: AOAM533PHR5wPPFfbJPqwqEHwo6S6cijo4KoO80jUHS1OVa+iZpYA4P9
        O+miX6rq06cTnaTtEurbnm1c8Z7yNjiFc/65BW9RnIHZlGOjQKQ/YjqYZC08/wI1DlI320KJ7Iu
        mr7aZx57gUJxo
X-Received: by 2002:aa7:cc18:: with SMTP id q24mr2275342edt.82.1612349834064;
        Wed, 03 Feb 2021 02:57:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTy7nKVt6xXY5DJ8qer2L+ohN1Pscvrulx2Yr3wt3RzM8W2V7MIZytGPa13kKgbPoJpNPjPw==
X-Received: by 2002:aa7:cc18:: with SMTP id q24mr2275327edt.82.1612349833686;
        Wed, 03 Feb 2021 02:57:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bo12sm817091ejb.93.2021.02.03.02.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 02:57:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CCF6A18034E; Wed,  3 Feb 2021 11:57:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>
Subject: Re: finding libelf
In-Reply-To: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
References: <8a6894e9-71ef-09e3-64fa-bf6794fc6660@infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 03 Feb 2021 11:57:12 +0100
Message-ID: <87eehxa06v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
>
> I see this sometimes when building a kernel: (on x86_64,
> with today's linux-next 20210202):
>
>
> CONFIG_CGROUP_BPF=y
> CONFIG_BPF=y
> CONFIG_BPF_SYSCALL=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> CONFIG_BPF_PRELOAD=y
> CONFIG_BPF_PRELOAD_UMD=m
> CONFIG_HAVE_EBPF_JIT=y
>
>
> Auto-detecting system features:
> ...                        libelf: [ [31mOFF[m ]
> ...                          zlib: [ [31mOFF[m ]
> ...                           bpf: [ [31mOFF[m ]
>
> No libelf found
> make[5]: [Makefile:287: elfdep] Error 1 (ignored)
> No zlib found
> make[5]: [Makefile:290: zdep] Error 1 (ignored)
> BPF API too old
> make[5]: [Makefile:293: bpfdep] Error 1 (ignored)
>
>
> but pkg-config tells me:
>
> $ pkg-config --modversion  libelf
> 0.168
> $ pkg-config --libs  libelf
> -lelf
>
>
> Any ideas?

This usually happens because there's a stale cache of the feature
detection tests lying around somewhere. Look for a 'feature' directory
in whatever subdir you got that error. Just removing the feature
directory usually fixes this; I've fixed a couple of places where this
is not picked up by 'make clean' (see, e.g., 9d9aae53b96d ("bpf/preload:
Make sure Makefile cleans up after itself, and add .gitignore")) but I
wouldn't be surprised if there are still some that are broken.

-Toke

