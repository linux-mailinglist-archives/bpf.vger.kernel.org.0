Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206D4EC061
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 10:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfKAJQ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 1 Nov 2019 05:16:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbfKAJQ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Nov 2019 05:16:57 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A703F59449
        for <bpf@vger.kernel.org>; Fri,  1 Nov 2019 09:16:56 +0000 (UTC)
Received: by mail-lf1-f72.google.com with SMTP id o140so1905949lff.18
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2019 02:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Dkl3aHb5bKrEXW75qkROq0EGnFR82jvIZST+34q38vQ=;
        b=qR/NGezbLHYj8N9Vrxz4p/GnBENmoDscFj4UmZ68w29sHwaWgaYGHnmH7EPcmnqp/w
         6QQ8CZ7v13JjU5yijKA1d27Q6CrArKz2E2BOvYgA0Np92PQeSfWYWapxBzSc3s7Z9vME
         p9b5yxPIpd+N9IRlSHGZ3OSe2lZjibA7/76Ut1BBjNrW0ku6HA/D2VaDxJ0LKltgPsul
         fNko5CeCDaE/fNruLc9Dx52GURhqsIgKjD6THesVBhrtipM2cqWURI4WrT0kWl5qFzTy
         SQJObKlqfQpRfLInVL1ygXAPjHdU8gJ4nqRKe7UZ1fWp/ASLnLGq7zOB8sgZG6B30IPk
         /xwA==
X-Gm-Message-State: APjAAAXoLLV7dHnIpXy59UYBafh6fYxH5jPawJxeN+AvQyStai8FLa2s
        NaMaUgCxE74df1QSByiyDB8yl3USWaqvq6CVCdrdu7MJ+D9faWeJknusYD7Wu5xNb5PYgtalWw9
        3iHXnfelTZwzj
X-Received: by 2002:a2e:3807:: with SMTP id f7mr7518768lja.241.1572599813286;
        Fri, 01 Nov 2019 02:16:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFk5cohwcAac9ROKmVcbyZ06Unn9LDLz/uVc6cFTwxopCUrWZXfy4+5auWRTX485e2Ep6o2Q==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr7518742lja.241.1572599813038;
        Fri, 01 Nov 2019 02:16:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id u10sm641296lfn.48.2019.11.01.02.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 02:16:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E28961818B5; Fri,  1 Nov 2019 10:16:50 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        bpf <bpf@vger.kernel.org>, degeneloy@gmail.com,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: fix compatibility for kernels without need_wakeup
In-Reply-To: <CAADnVQJdAZS9AHx_B3SZTcWRdigZZsK1ccsYZK0qUsd1yZQqbw@mail.gmail.com>
References: <CAJ+HfNimRqftmKASOdceXFJmgbLvXnNBZATTnfA9LMF2amGzzA@mail.gmail.com> <CAADnVQJRe4Pm-Rxx9zobn8YRHh9i+xQp7HX4gidqq9Mse7PJ5g@mail.gmail.com> <87lft1ngtn.fsf@toke.dk> <CAADnVQLrg6f_zjvNfiEVfdjcx9+DW_RFjVGetavvMNo=VXAR+g@mail.gmail.com> <87imo5ng7w.fsf@toke.dk> <CAADnVQLJ2JTsbxd2am6XY0EiocMgM29JqFVRnZ9PBcwqd7-dAQ@mail.gmail.com> <87d0ednf0t.fsf@toke.dk> <CAADnVQ+V4OMjJqSdE_OQ1Vr99kqTF=ZB3UUMKiCSg=3=c+exqg@mail.gmail.com> <20191031174208.GC2794@krava> <CAADnVQJ=cEeFdYFGnfu6hLyTABWf2==e_1LEhBup5Phe6Jg5hw@mail.gmail.com> <20191031191815.GD2794@krava> <CAADnVQJdAZS9AHx_B3SZTcWRdigZZsK1ccsYZK0qUsd1yZQqbw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 01 Nov 2019 10:16:50 +0100
Message-ID: <87tv7olzwd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Oct 31, 2019 at 12:18 PM Jiri Olsa <jolsa@redhat.com> wrote:
>> >
>> > yes. older vmlinux and newer installed libbpf.so
>> > or any version of libbpf.a that is statically linked into apps
>> > is something that libbpf code has to support.
>> > The server can be rebooted into older than libbpf kernel and
>> > into newer than libbpf kernel. libbpf has to recognize all these
>> > combinations and work appropriately.
>> > That's what backward and forward compatibility is.
>> > That's what makes libbpf so difficult to test, develop and code review.
>> > What that particular server has in /usr/include is irrelevant.
>>
>> sure, anyway we can't compile following:
>>
>>         tredaell@aldebaran ~ $ echo "#include <bpf/xsk.h>" | gcc -x c -
>>         In file included from <stdin>:1:
>>         /usr/include/bpf/xsk.h: In function ‘xsk_ring_prod__needs_wakeup’:
>>         /usr/include/bpf/xsk.h:82:21: error: ‘XDP_RING_NEED_WAKEUP’ undeclared (first use in this function)
>>            82 |  return *r->flags & XDP_RING_NEED_WAKEUP;
>>         ...
>>
>>         XDP_RING_NEED_WAKEUP is defined in kernel v5.4-rc1 (77cd0d7b3f257fd0e3096b4fdcff1a7d38e99e10).
>>         XSK_UNALIGNED_BUF_ADDR_MASK and XSK_UNALIGNED_BUF_OFFSET_SHIFT are defined in kernel v5.4-rc1 (c05cd3645814724bdeb32a2b4d953b12bdea5f8c).
>>
>> with:
>>   kernel-headers-5.3.6-300.fc31.x86_64
>>   libbpf-0.0.5-1.fc31.x86_64
>>
>> if you're saying this is not supported, I guess we could be postponing
>> libbpf rpm releases until we have the related fedora kernel released
>
> why? github/libbpf is the source of truth for building packages
> and afaik it builds fine.
>
>> or how about inluding uapi headers in libbpf-devel.. but that might
>> actualy cause more confusion
>
> Libraries (libbpf or any other) should not install headers that
> typically go into /usr/include/
> if_xdp.h case is not unique.
> We'll surely add another #define, enum, etc to uapi/linux/bpf.h tomorrow.
> And we will not copy paste these constants and types into tools/lib/bpf/.
> In kernel tree libbpf development is using kernel tree headers.
> No problem there for libbpf developers.
> Packages are built out of github/libbpf that has a copy of uapi headers
> necessary to create packages.
> No problem there for package builders either.
> But libbpf package is not going to install those uapi headers.
> libbpf package installs only libbpf own headers (like libbpf.h)
> The users that want to build against the latest libbpf package need
> to install corresponding uapi headers package.
> I don't think such dependency is specified in rpm scripts.
> May be it is something to fix? Or may be not.
> Some folks might not want to update all of /usr/include to bring libbpf-devel.
> Then it would be their responsibility to get fresh /usr/include headers.

We can certainly tie libbpf to the kernel version. The obvious way to do
that is to just ship the version of libbpf that's in the kernel tree of
whatever kernel version the distro ships. But how will we handle
bugfixes, then? You've explicitly stated that libbpf gets no bugfixes
outside of bpf-next...

-Toke
