Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DA2C9153
	for <lists+bpf@lfdr.de>; Mon, 30 Nov 2020 23:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgK3Wm2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 17:42:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgK3Wm1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 17:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606776060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awnP1wNfpho4sGMKxjTXmUDsOu+jXjRCz1aWKT/8GIo=;
        b=FRFw86LyZOijon+hz1Tm8chsOuRX2o78szoAIoO66FH9FixJnuF3wTYwP155D7eHERC7yw
        U+s15Yy110McmEu0YSGJU12T/q4anZhx4m8gszzG3XceAdKeTnffuYFl2aqJ5KS0jZHRqU
        XD1mRy3cvUtvj2ALlu4LRcYa9yLSVio=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-5iXa410-NUqMp2HFdJiApQ-1; Mon, 30 Nov 2020 17:40:57 -0500
X-MC-Unique: 5iXa410-NUqMp2HFdJiApQ-1
Received: by mail-ed1-f71.google.com with SMTP id x71so4333055ede.9
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 14:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=awnP1wNfpho4sGMKxjTXmUDsOu+jXjRCz1aWKT/8GIo=;
        b=eIcYYeWFJxB3YukH5lnO8AZYiUgRwe3mCUszpkdkhd9Q28QqL4L92/Kr8TDivjyI90
         c3u7IPDr6Tb4QCPDKWOz9VJwVYMlusjEf/iTNJM0N12Xh+7cKMA47zGCfPW65Tw/F4mn
         uJIwXK7zh3sxdMdgZ9EP0qlwVCvuNHhscw5nNHxlUpIVP6AyrQDSqLGOSdG2/ZUDhQIs
         XxTH/wZFn3X1LKI0aqrYRcsL7T3xGmhKSJchLPdbiWZW8vjYUK8GNSnt6+TxxZ4xbPHe
         BAqghy+KTVBhJWOHi+bieslN54CUC0V4dJ6frO3lU96/P0bzSE7+aWdpN+TckPSutSQE
         2GEg==
X-Gm-Message-State: AOAM530YInw7mvG3WGSaKQaJrt2hhaQjp2E+P4qHemMNcWQJ3GHCItTy
        DPQGogah+lbcSwuho8aPa0A92SszCqAiv9du7GwxdL+TzSKOZgeZJ6UhcHLftIyRgyFHv5Ujnjr
        bmhHbwyF8m6KA
X-Received: by 2002:a17:906:b79a:: with SMTP id dt26mr6619148ejb.337.1606776056313;
        Mon, 30 Nov 2020 14:40:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbuLqZuOzrQHnQRdY/Gzm+Aqmv7kyYntl0031e0a43VHF2DFSM2wlAef9cdyrygcB020afTQ==
X-Received: by 2002:a17:906:b79a:: with SMTP id dt26mr6619129ejb.337.1606776055919;
        Mon, 30 Nov 2020 14:40:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k15sm1674711ejc.79.2020.11.30.14.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:40:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B6E05181AD4; Mon, 30 Nov 2020 23:40:54 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: reset errno after probing kernel features
In-Reply-To: <CAEf4BzZy0Y1hAwOpY=Azod3bSqUKfGNwycGS7s=-DQvTWd8ThA@mail.gmail.com>
References: <20201130154143.292882-1-toke@redhat.com>
 <CAEf4BzZy0Y1hAwOpY=Azod3bSqUKfGNwycGS7s=-DQvTWd8ThA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 30 Nov 2020 23:40:54 +0100
Message-ID: <87pn3uwjrd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Nov 30, 2020 at 7:42 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> The kernel feature probing results in 'errno' being set if the probing
>> fails (as is often the case). This can stick around and leak to the call=
er,
>> which can lead to confusion later. So let's make sure we always reset er=
rno
>> after calling a probe function.
>
> What specifically is the problem and what sort of confusion we are
> talking about here? You are not supposed to check errno, unless the
> function returned -1 or other error result.
>
> In some cases, you have to reset errno manually just to avoid
> confusion (see how strtol() is used, as an example).
>
> I.e., I don't see the problem here, any printf() technically can set
> errno to <0, we don't reset errno after each printf call though,
> right?

Well yeah, technically things work fine in the common case. But this
errno thing sent me on quite the wild goose chase when trying to find
the root cause of the pinning issue I also sent a patch for...

So since reseting errno doesn't hurt either I figured I'd save others
ending up in similar trouble. If it's not to your taste feel free to
just drop the patch :)

-Toke

