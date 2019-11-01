Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADB1EC91F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 20:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKATgM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 1 Nov 2019 15:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfKATgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Nov 2019 15:36:11 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B5E98665A
        for <bpf@vger.kernel.org>; Fri,  1 Nov 2019 19:36:11 +0000 (UTC)
Received: by mail-lf1-f70.google.com with SMTP id o9so2202636lfd.7
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2019 12:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SsmstKUpBF7ofr68Bfnp8iZ5GYfX4M6aq588iloFPg8=;
        b=fQExmJHgOsSdNQMEqNtoPVB/Re/VeM5DAb2ZelVn70+pXcxSqZsLMNpjxX2gDqOXtz
         pIb0B1QcvLOH194/u8eewQD6K4mfYFKpehvTu8nzvVGXNj5/xtSxiRHzIM44YM30NGLj
         ijmZzY3kDdxDle4GWYjuFa4AejE1jNFqmmVgGJe1ycVl8NoQCQytBYug7MkayKLcV2I8
         XEBVeR/7NFcHGqr6j2H05gNHGvRJnDM8GE+jwErC7ynwQ8c/wdEXHa3Do2iXR91Gqrmg
         pPzYlYIUcw7oPPaH6/w/PTGkAJk9V7K4t+eaWGAqmBr/xDkCoktFVK7GeJ1F7AmUtdfL
         F8bg==
X-Gm-Message-State: APjAAAU79fP1tpmFtctqt7npIJhVsLtcxe6Pmf0hZaQwq91vHnJsN9qm
        lUh9Z2USwyFAyw8vdjiMKzBraUAKsQS8qUSduCI8Mcs11oHlM8R+q8B9BYEq5dm3Yq5YexgPOv0
        ZHx2sfuhjD8I4
X-Received: by 2002:ac2:46d7:: with SMTP id p23mr8291825lfo.104.1572636966390;
        Fri, 01 Nov 2019 12:36:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJVHQ5klNWvpRqGYN+Ta+wS+uO2/UVCP7ZzvSxgiNwulnPJddFdLrnVv+P0HgCyjem9yB5cA==
X-Received: by 2002:ac2:46d7:: with SMTP id p23mr8291797lfo.104.1572636966136;
        Fri, 01 Nov 2019 12:36:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v21sm2865146lfe.68.2019.11.01.12.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 12:36:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B327A1818B5; Fri,  1 Nov 2019 20:36:04 +0100 (CET)
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
In-Reply-To: <CAADnVQJnTuADcPizsD+hFx4Rvot0nqiX83M+ku4Nu_qLh2_vyg@mail.gmail.com>
References: <87lft1ngtn.fsf@toke.dk> <CAADnVQLrg6f_zjvNfiEVfdjcx9+DW_RFjVGetavvMNo=VXAR+g@mail.gmail.com> <87imo5ng7w.fsf@toke.dk> <CAADnVQLJ2JTsbxd2am6XY0EiocMgM29JqFVRnZ9PBcwqd7-dAQ@mail.gmail.com> <87d0ednf0t.fsf@toke.dk> <CAADnVQ+V4OMjJqSdE_OQ1Vr99kqTF=ZB3UUMKiCSg=3=c+exqg@mail.gmail.com> <20191031174208.GC2794@krava> <CAADnVQJ=cEeFdYFGnfu6hLyTABWf2==e_1LEhBup5Phe6Jg5hw@mail.gmail.com> <20191031191815.GD2794@krava> <CAADnVQJdAZS9AHx_B3SZTcWRdigZZsK1ccsYZK0qUsd1yZQqbw@mail.gmail.com> <20191101072707.GE2794@krava> <CAADnVQJnTuADcPizsD+hFx4Rvot0nqiX83M+ku4Nu_qLh2_vyg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 01 Nov 2019 20:36:04 +0100
Message-ID: <87bltvmlsr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Nov 1, 2019 at 12:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
>>
>> On Thu, Oct 31, 2019 at 01:39:12PM -0700, Alexei Starovoitov wrote:
>> > On Thu, Oct 31, 2019 at 12:18 PM Jiri Olsa <jolsa@redhat.com> wrote:
>> > > >
>> > > > yes. older vmlinux and newer installed libbpf.so
>> > > > or any version of libbpf.a that is statically linked into apps
>> > > > is something that libbpf code has to support.
>> > > > The server can be rebooted into older than libbpf kernel and
>> > > > into newer than libbpf kernel. libbpf has to recognize all these
>> > > > combinations and work appropriately.
>> > > > That's what backward and forward compatibility is.
>> > > > That's what makes libbpf so difficult to test, develop and code review.
>> > > > What that particular server has in /usr/include is irrelevant.
>> > >
>> > > sure, anyway we can't compile following:
>> > >
>> > >         tredaell@aldebaran ~ $ echo "#include <bpf/xsk.h>" | gcc -x c -
>> > >         In file included from <stdin>:1:
>> > >         /usr/include/bpf/xsk.h: In function ‘xsk_ring_prod__needs_wakeup’:
>> > >         /usr/include/bpf/xsk.h:82:21: error: ‘XDP_RING_NEED_WAKEUP’ undeclared (first use in this function)
>> > >            82 |  return *r->flags & XDP_RING_NEED_WAKEUP;
>> > >         ...
>> > >
>> > >         XDP_RING_NEED_WAKEUP is defined in kernel v5.4-rc1 (77cd0d7b3f257fd0e3096b4fdcff1a7d38e99e10).
>> > >         XSK_UNALIGNED_BUF_ADDR_MASK and XSK_UNALIGNED_BUF_OFFSET_SHIFT are defined in kernel v5.4-rc1 (c05cd3645814724bdeb32a2b4d953b12bdea5f8c).
>> > >
>> > > with:
>> > >   kernel-headers-5.3.6-300.fc31.x86_64
>> > >   libbpf-0.0.5-1.fc31.x86_64
>> > >
>> > > if you're saying this is not supported, I guess we could be postponing
>> > > libbpf rpm releases until we have the related fedora kernel released
>> >
>> > why? github/libbpf is the source of truth for building packages
>> > and afaik it builds fine.
>>
>> because we will get issues like above if there's no kernel
>> avilable that we could compile libbpf against
>
> what is the issue again?
> bpf-next builds fine. github/libbpf builds fine.
> If distro is doing something else it's distro's mistake.

With that you're saying that distros should always keep their kernel
headers and libbpf version in sync. Which is fine in itself; they can
certainly do that.

The only concern with this is that without a flow of bugfixes into the
'bpf' tree (and stable), users may end up with buggy versions of libbpf.
Which is in no one's interest. So how do we avoid that?

-Toke
