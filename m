Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6786B31EA57
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhBRNQd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 08:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231609AbhBRLjZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 06:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613648221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36Nxu7fh3KcvHdksE5HDqIJ3wvrGYUMQwh0wbPL/3hQ=;
        b=Ntj5q//aNzk8/wEfcfaX18aPAKhw5alGvt8GLHYt1odruEcI3QtLTS+DYEEcwO1xyI9C+C
        S4w0foBzj0bVPaQNvVGrceOYyckAnqsBOJE3XIabMhcW5YX/aaeGtkhTMnN/b0h1CY5hO7
        TdDPtp34xGTaUZVlzYvH7Zq4XoMqefc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463--Sot1w2TNWCO49LIOroohA-1; Thu, 18 Feb 2021 06:33:12 -0500
X-MC-Unique: -Sot1w2TNWCO49LIOroohA-1
Received: by mail-ed1-f72.google.com with SMTP id l23so746139edt.23
        for <bpf@vger.kernel.org>; Thu, 18 Feb 2021 03:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=36Nxu7fh3KcvHdksE5HDqIJ3wvrGYUMQwh0wbPL/3hQ=;
        b=fe1gDrQck20htqRmrNqcvscdJ26PjatmAmZuSzxRdzNNfC9JdQlRQCTeN4bCBOdy7Q
         92lIIRdGcoVX2tAmE9guERHCMi+IiCds2yjQ3McSwTcRoVP8oJZSz7nB7t+n9hN/+pGC
         tshdkHZnEOONiMR60S40vKboQFPy3SSpMpP2SbOEn7TmJOnfFmWxS2zZBqG9Yd4xq/L6
         Iqa8qE+NtS2bQ7Iqtq6aL8N3ghNU1xlsjYVbM92kZOJ5Nd/skovkJoZ5qwr3Nk40KTxk
         0Zom9Gql1SiWyQIm5QZngETC6mh5nLF9eE6H5lMhJF0/SCWXuleTLko5PwO8eKzAR3gK
         rRgw==
X-Gm-Message-State: AOAM532e7vIJqy2fj/rUK/skMjXhG8bxKr2ES30q6wr3inxfw0oHSkKH
        wRcrdfpEGvBBNgV06BFZRerjxvwtnfUASD2M+EtxhcOKXUK/N5Nd6CXovq31Nn6gqWw114HZ1KW
        Ad5B6Vf3BOFUY
X-Received: by 2002:a17:906:4c90:: with SMTP id q16mr3650788eju.49.1613647991258;
        Thu, 18 Feb 2021 03:33:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwncoh1x9SnZ4fpM1Vv1Dk74fJ6NcnMvbuj6niroKBejeYqbgEzKQVsxkuh9Jeo8iBmL8Bskg==
X-Received: by 2002:a17:906:4c90:: with SMTP id q16mr3650770eju.49.1613647991115;
        Thu, 18 Feb 2021 03:33:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p20sm701475ejo.19.2021.02.18.03.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 03:33:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 619B31805FA; Thu, 18 Feb 2021 12:33:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joe Stringer <joe@cilium.io>
Cc:     bpf@vger.kernel.org, Joe Stringer <joe@cilium.io>,
        linux-man@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        mtk.manpages@gmail.com, ast@kernel.org, brianvv@google.com,
        Daniel Borkmann <daniel@iogearbox.net>, daniel@zonque.org,
        john.fastabend@gmail.com, ppenkov@google.com,
        Quentin Monnet <quentin@isovalent.com>, sean@mess.org,
        yhs@fb.com
Subject: Re: [PATCH bpf-next 00/17] Improve BPF syscall command documentation
In-Reply-To: <CADa=RywykZt_kMVcCJk8N0vm2sJHW2_mKTr9Z8m2rTsnqvinqA@mail.gmail.com>
References: <20210217010821.1810741-1-joe@wand.net.nz>
 <87r1len6hi.fsf@toke.dk>
 <CADa=RywykZt_kMVcCJk8N0vm2sJHW2_mKTr9Z8m2rTsnqvinqA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Feb 2021 12:33:09 +0100
Message-ID: <87mtw1life.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joe Stringer <joe@cilium.io> writes:

> On Wed, Feb 17, 2021 at 5:55 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Joe Stringer <joe@wand.net.nz> writes:
>> > Given the relative success of the process around bpf-helpers(7) to
>> > encourage developers to document their user-facing changes, in this
>> > patch series I explore applying this technique to bpf(2) as well.
>> > Unfortunately, even with bpf(2) being so out-of-date, there is still a
>> > lot of content to convert over. In particular, I've identified at least
>> > the following aspects of the bpf syscall which could individually be
>> > generated from separate documentation in the header:
>> > * BPF syscall commands
>> > * BPF map types
>> > * BPF program types
>> > * BPF attachment points
>>
>> Does this also include program subtypes (AKA expected_attach_type?)
>
> I seem to have left my lawyerly "including, but not limited to..."
> language at home today ;-) . Of course, I can add that to the list.

Great, thanks! :)

-Toke

