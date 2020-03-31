Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5BF199339
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgCaKN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 06:13:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730224AbgCaKN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 06:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585649605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiuEMwk5QuitIfDRpxWsjJRKhCskplSxPEEHaL3KHzA=;
        b=Sgp/D+CyDOvF8nAj+cfyLajB60zByKDDtdyuvRbhgYMhFOG3nR2/OFUb3SHStrPwJ3w/ux
        rfcJ2LzZX2ttfHIfWpTIQgv93XLUljjZjyZhiKjTCChcqOXYgNC0ASt7w7iI3bu2CBF0HY
        y41IbPj02pYookn/cqmrzdyl3gtR7V4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-9FTbXSNnP5KtVZG-Wl1uBw-1; Tue, 31 Mar 2020 06:13:24 -0400
X-MC-Unique: 9FTbXSNnP5KtVZG-Wl1uBw-1
Received: by mail-lf1-f71.google.com with SMTP id q4so8656615lff.4
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2020 03:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CiuEMwk5QuitIfDRpxWsjJRKhCskplSxPEEHaL3KHzA=;
        b=XHJ33wpG1ReTcMqP9eY5jsyKFjOAP7chmxzvrEM6ohpgVFCeIlicDDQ+I3lHwGLJT2
         sLMxONMm00yLNS5TgKOQI0WERg0/+dW0srJPGcE1ZPZQ1IheI5hNg8krboM4Hz1VaDnB
         2RdcNourAmhXExsMuJzUzpWDUsslHY1mYDhNH0uA4TIbHSurSzlACbwnYT0I3m+Wxtzl
         7m8V1JPqBM6uEUGa1cmMS9S38fQp2iSjJiq+u0+S5CPP+f1o1JiBDeIYiOu9Uuqn5vJY
         ACCaZfXn6+fDykHG1GuUKlG4sfwLzcFCrTeXDD1ldX7V9Hpdnwry+NyhbOpjzBq5H5M7
         DCeQ==
X-Gm-Message-State: AGi0PuZa12lLki/B9EHChCS8Cojw0ZnwUBt9PPwRjgONztmhBlijeaW8
        G7kTaA7esxiSDHl73TEcavKEpNsX7kZz9SsB9h1dxAFbUI87qsp09uCEgmZWsGQeYmaIE3ztX0Y
        wAU9WpoKuV2qz
X-Received: by 2002:ac2:4462:: with SMTP id y2mr6867603lfl.183.1585649602707;
        Tue, 31 Mar 2020 03:13:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypLBBxVYR14X16mmpnBA+hqpOuXZoB5tEwmNqRbKEhj23n6swe1DbyDYzlPViP7KgLE3IhgH0A==
X-Received: by 2002:ac2:4462:: with SMTP id y2mr6867581lfl.183.1585649602472;
        Tue, 31 Mar 2020 03:13:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n17sm8375658ljc.76.2020.03.31.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 03:13:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4DDA918158D; Tue, 31 Mar 2020 12:13:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <CAEf4Bza4vKbjkj8kBkrVmayFr2j_nvrORF_YkCoVKibB=SmSYQ@mail.gmail.com>
References: <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com> <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com> <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <87pncznvjy.fsf@toke.dk> <20200326195859.u6inotgrm3ubw5bx@ast-mbp> <87imiqm27d.fsf@toke.dk> <20200327230047.ois5esl35s63qorj@ast-mbp> <87lfnll0eh.fsf@toke.dk> <20200328022609.zfupojim7see5cqx@ast-mbp> <87eetcl1e3.fsf@toke.dk> <CAEf4Bzb+GSf8cE_rutiaeZOtAuUick1+RnkCBU=Z+oY_36ArSA@mail.gmail.com> <87y2rihruq.fsf@toke.dk> <CAEf4Bza4vKbjkj8kBkrVmayFr2j_nvrORF_YkCoVKibB=SmSYQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 31 Mar 2020 12:13:16 +0200
Message-ID: <87pncsj0hv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> > So you install your libxdp-based firewalls and are happy. Then you
>> > decide to install this awesome packet analyzer, which doesn't know
>> > about libxdp yet. Suddenly, you get all packets analyzer, but no more
>> > firewall, until users somehow notices that it's gone. Or firewall
>> > periodically checks that it's still runinng. Both not great, IMO, but
>> > might be acceptable for some users, I guess. But imagine all the
>> > confusion for user, especially if he doesn't give a damn about XDP and
>> > other buzzwords, but only needs a reliable firewall :)
>>
>> Yes, whereas if the firewall is using bpf_link, then the packet analyser
>> will be locked out and can't do its thing. Either way you end up with a
>> broken application; it's just moving the breakage. In the case of
>
> Hm... In one case firewall installation reported success and stopped
> working afterwards with no notification and user having no clue. In
> another, packet analyzer refused to start and reported error to user.
> Let's agree to disagree that those are not at all equivalent. To me
> silent failure is so much worse, than application failing to start in
> the first place.

Oh, sure, obvious failures are preferable to silent ones, do doubt about
that. But for things to actually *work*, both applications need to agree
on how to do things, which in practice means they'll need to use the
same library. At which point you can solve this problem in the
library.

So again, I'm not saying the two are equivalent, I am just disagreeing
with you about how big the benefit is. And sure, we can agree to
disagree on that :)

-Toke

