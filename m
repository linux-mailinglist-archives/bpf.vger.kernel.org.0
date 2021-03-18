Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00A73407B5
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 15:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCROUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 10:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230159AbhCROTw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 10:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616077191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyS/wOCby9V1eK7ITvUfmwzDLjAaah1lpf8TDwH3Upg=;
        b=U5DgmCCWbL0MDBlwt/Ac6ZXCEvQ/BsHted/CyD7NJ9Wc5HYY/cQYiWIz/GlEB/njLnXNfn
        Fxjb7c6kc7/jAeDulkQvFIGdtaSuld1ROYk2qcbgugbzCCiF9NVkOO4vuhmwPyJLfgbIyr
        mAj2AZ+wrEXIcIbndXhxYYtjfotLFpQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-Toq6uHw0O6Oti5Gqmvv2gw-1; Thu, 18 Mar 2021 10:19:50 -0400
X-MC-Unique: Toq6uHw0O6Oti5Gqmvv2gw-1
Received: by mail-ed1-f70.google.com with SMTP id cq11so21216368edb.14
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 07:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HyS/wOCby9V1eK7ITvUfmwzDLjAaah1lpf8TDwH3Upg=;
        b=rdA32kDh2YrykjNAQhqiXmnqdU9Fs6sPVTaOIxGRLbt07LNSY/O6qRSf+dae2JGxgA
         ct8ohnzBSkd57kieZgUguyOimGgkPpWJOucLVI3AZdQOll2WQex+4Xn5wSuBras2Kjlr
         43iAC2cuIP2nDqPtoE727zF7V52ZfjJhqNxfoZzKS0p+4cDawfzan6pm15uIsgv0gxVe
         EUWjqcRjnkCadbS38+ULq28erxbIP9J2PXDVyoe53T3HnYjw8FO7AZfJYg2YHz5QeGDH
         8DsUXkeSqqhmx/Or3Ab+peFdsvgmaRPRx2RaObooE2z/7Z+B8beWLqWWOhP/Q8HBKBtv
         j3IQ==
X-Gm-Message-State: AOAM532MFp8mQ7TQG2sVrCZ6C/+2eSaFBZ2QARhGzfKRLfcnVHq2h0mP
        bxVtz1o5KSBPvYnzdoPCuXeSre2L1YS78FA7eSDOlXEpczKb+Cd07ThknwhVsnD8CSlGkswrzC0
        zQGEycSGGZatg
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr4013141edb.306.1616077189001;
        Thu, 18 Mar 2021 07:19:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRI1rPWv8fl0rrhCiL99uDZU48QX8KglnOrp57iNLJlU7tgzOUkE6p1LdfAuqTLs578mJRfQ==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr4013125edb.306.1616077188868;
        Thu, 18 Mar 2021 07:19:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p9sm2218245eds.66.2021.03.18.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 07:19:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7B020181F54; Thu, 18 Mar 2021 15:19:47 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bjorn@kernel.org
Subject: Re: [PATCHv2 bpf-next 2/4] xdp: extend xdp_redirect_map with
 broadcast support
In-Reply-To: <20210318035200.GB2900@Leo-laptop-t470s>
References: <20210309101321.2138655-1-liuhangbin@gmail.com>
 <20210309101321.2138655-3-liuhangbin@gmail.com> <87r1kec7ih.fsf@toke.dk>
 <20210318035200.GB2900@Leo-laptop-t470s>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Mar 2021 15:19:47 +0100
Message-ID: <875z1oczng.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Wed, Mar 17, 2021 at 01:03:02PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> FYI, this no longer applies to bpf-next due to Bj=C3=B6rn's refactor in
>> commit: ee75aef23afe ("bpf, xdp: Restructure redirect actions")
>
> Thanks Toke, I need to see how to get the map via map_id, does
> bpf_map_get_curr_or_next() works? Should I call bpf_map_put() after
> using?

I would expect that to be terrible for performance; I think it would be
better to just add back the map pointer into struct bpf_redirect_info.
If you only set the map pointer when the multicast flag is set, you can
just check that pointer to disambiguate between when you need to call
dev_map_enqueue() and dev_map_enqueue_multi(), in which case you don't
need to add back the flags member...

-Toke

