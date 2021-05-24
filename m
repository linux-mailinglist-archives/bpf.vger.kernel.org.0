Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5879138F321
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhEXSlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 14:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232814AbhEXSlU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 May 2021 14:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621881591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMfHoa6IpM5dqXHEXR66ytrwQnf7YpLgYSvDY3BxGTE=;
        b=BIHJ1sYnNhwauRX84Kpy2M3bO3PVHGn4CuQvt57bjbQDDjycO2SpUolFTU5uxtWYZ4pZQW
        LIDhaHZMgEiH26n/0oz1wim64dvHjCqvQJJg6n9lBU9A14E4qCAATzJmEfxqP71ddzO6s6
        xvhR359gEwMFS6J6KYVJ9gD/T2D4oMY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-4r_U5X60MjeBhsManC0-rA-1; Mon, 24 May 2021 14:39:50 -0400
X-MC-Unique: 4r_U5X60MjeBhsManC0-rA-1
Received: by mail-ej1-f70.google.com with SMTP id k9-20020a17090646c9b029039d323bd239so7876766ejs.16
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 11:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CMfHoa6IpM5dqXHEXR66ytrwQnf7YpLgYSvDY3BxGTE=;
        b=f+1BV3z7PvL0Ql1JJybUmHWVDXjlq+Xp4T8n5miCjH2hfFgMMEO/a8W+O5b5GUWFBi
         Vf5sq+DYYJc/xo1PFv8MDX5f7OB77Yw2V3J24cZ3dbg9B0CLuxcU1SSZtzZEGc8ufLOM
         6utFYc95xFr3shpGZeieG4GrzZh6WhGT5loKAXJP2qLFJcUIUvlyyaiQ5C6BmvpGLkVU
         RLRUx7B5sokkmJlU3f6KY0GJhRkapTyOVD5QDGlY/f2QfArxUMnbBRtmcbiutrI1ZIDc
         6ZjG9kMCZXMo81+zLWYp5kAp75+GyCC5vp0bwSm9ogKrCKHfFpQd70rndOlohoGrqJf9
         +K7A==
X-Gm-Message-State: AOAM530kKJaHVa5VQ+HDqyjReR8FSCCT039wIkezh9BOZmASbO9427fv
        NUAcdH7G7tuSinBM+DxHA484p/HDd6L0d3NXzX5eEkDUaDnRjXt/2taw8RATVdAFeIpBJgKF5B+
        K5YbX74Ws+Fgt
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr24263315ejc.384.1621881588388;
        Mon, 24 May 2021 11:39:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0s9NTWgKCVyxamPFjeE/UY3/9N5lA2xB4zFvP0Y+X949wQSjY0Rv0+v1HZt7vBNADT66Ctg==
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr24263289ejc.384.1621881588036;
        Mon, 24 May 2021 11:39:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h9sm9695640edt.18.2021.05.24.11.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:39:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 43C8F180275; Mon, 24 May 2021 20:39:46 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
In-Reply-To: <CAADnVQL8qw4OYQp+ozJpgPnimNYV7PtShZ-4tqdY7fTBhHf2ww@mail.gmail.com>
References: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
 <87o8d1zn59.fsf@toke.dk>
 <CAADnVQL9xKcdCyR+-8irH07Ws7iKHjrE4XNb4OA7BkpBrkkEuA@mail.gmail.com>
 <CAADnVQL8qw4OYQp+ozJpgPnimNYV7PtShZ-4tqdY7fTBhHf2ww@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 24 May 2021 20:39:46 +0200
Message-ID: <87cztgyo0d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, May 23, 2021 at 8:58 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Sun, May 23, 2021 at 4:48 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> >
>> > Still wrapping my head around this, but one thing immediately sprang to
>> > mind:
>> >
>> > > + * long bpf_timer_mod(struct bpf_timer *timer, u64 msecs)
>> > > + *   Description
>> > > + *           Set the timer expiration N msecs from the current time.
>> > > + *   Return
>> > > + *           zero
>> >
>> > Could we make this use nanoseconds (and wire it up to hrtimers) instea=
d?
>> > I would like to eventually be able to use this for pacing out network
>> > packets, and msec precision is way too coarse for that...
>>
>> msecs are used to avoid exposing jiffies to bpf prog, since msec_to_jiff=
ies
>> isn't trivial to do in the bpf prog unlike the kernel.
>> hrtimer would be great to support as well.
>> It could be implemented via flags (which are currently zero only)
>> but probably not as a full replacement for jiffies based timers.
>> Like array vs hash. bpf_timer can support both.
>
> After reading the hrtimer code I might take the above statement back...
> hrtimer looks strictly better than timerwheel and jiffies.
> It scales well and there are no concerns with overload,
> since sys_nanonsleep and tcp are heavy users.
> So I'm thinking to drop jiffies approach and do hrtimer only.
> wdyt?

Oops, sorry, crossed streams, didn't see this before sending my other
reply. Yeah, hrtimers only SGTM :)

-Toke

