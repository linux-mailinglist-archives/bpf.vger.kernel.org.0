Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E556B3B1846
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFWK6U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 06:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhFWK6U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 06:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624445762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0rnZYZLTgGGB4O4LME1I6ADl2UwNN76Ezwf4qF0mCI=;
        b=Wz1kzovPN7LJM6AMRxxXmZptMKuPc25/mr6sxwlJggxwTtcshmRcw3pPHd5vF+eyfIfqfC
        d5G1oF1oeVTkmeq3cfHrG2DxoDPAQyEqdGPetk+4EWlOHYlUGYlpeUzOs21CYcDKt3nljh
        Qn0391K0uZksdjRQ371l4vVWDkrAlu8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-O3n0wrVONmKQqgxh1e5raQ-1; Wed, 23 Jun 2021 06:55:59 -0400
X-MC-Unique: O3n0wrVONmKQqgxh1e5raQ-1
Received: by mail-ed1-f69.google.com with SMTP id x10-20020aa7cd8a0000b0290394bdda92a8so1097058edv.8
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 03:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=l0rnZYZLTgGGB4O4LME1I6ADl2UwNN76Ezwf4qF0mCI=;
        b=HO9Pk49CbqZxBMdB0hejxW1emZGfg6Mkz4W0187X665vl7FIrSMewx1u7sfR/7+TNG
         NhkSqiiHznaAsq0BnIOcoTeMLnWmKy4XnuLexoHs1rfhJd4QvhcQi5DGjC/rCg399OV8
         W8cBvOFkJC8clwC1lexdFmvz1e/yOGavMwBKRLLxc1q/xAlbpnTAndQsBqkMLqpTMG8Y
         BiM2i5zMb8tFpEg5tY89s44gvfNSPtNHa0eh00gL7+OFM4ocLnxj3nvPqC3NbjmsS1XP
         Ew2tyUxji7Ou63JDgNIHyb+NKThk6BHom8vnLFp083QyTIvDyXdsY+2Y0ZSZegaFyCSj
         2HHQ==
X-Gm-Message-State: AOAM532VRR0M4mMzg57LOJlS1Wg3pQ1lbJdcTs6q6n7Y3fynALfebEZS
        5is0df7KkLmCsyXWVYCnWMbEIa0ANDmYin2eW/zBZ+AKRf84QVQaQig9S+4e/A3QacO8XmCTaJM
        BlFeib9Pi2F5v
X-Received: by 2002:a05:6402:1d55:: with SMTP id dz21mr4598482edb.338.1624445758487;
        Wed, 23 Jun 2021 03:55:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl/daCOipGRoHNcu5HqM7PZSYLBKhJx+6m3jGMZC6YVrEBrzMUhI1Tf/lrymqJ58SdU1r77w==
X-Received: by 2002:a05:6402:1d55:: with SMTP id dz21mr4598464edb.338.1624445758192;
        Wed, 23 Jun 2021 03:55:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u22sm13518224edr.11.2021.06.23.03.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 03:55:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A4162180730; Wed, 23 Jun 2021 12:55:55 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 03/16] xdp: add proper __rcu annotations to
 redirect map entries
In-Reply-To: <20210622231950.GK4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210617212748.32456-1-toke@redhat.com>
 <20210617212748.32456-4-toke@redhat.com>
 <1881ecbe-06ec-6b0a-836c-033c31fabef4@iogearbox.net>
 <87zgvirj6g.fsf@toke.dk> <87r1guovg2.fsf@toke.dk>
 <20210622202604.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <874kdppo45.fsf@toke.dk>
 <20210622231950.GK4397@paulmck-ThinkPad-P17-Gen-1>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Jun 2021 12:55:55 +0200
Message-ID: <87eecsonno.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Jun 22, 2021 at 11:48:26PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>>=20
>> > On Tue, Jun 22, 2021 at 03:55:25PM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>> >>=20
>> >> >> It would also be great if this scenario in general could be placed
>> >> >> under the Documentation/RCU/whatisRCU.rst as an example, so we cou=
ld
>> >> >> refer to the official doc on this, too, if Paul is good with this.
>> >> >
>> >> > I'll take a look and see if I can find a way to fit it in there...
>> >>=20
>> >> OK, I poked around in Documentation/RCU and decided that the most
>> >> natural place to put this was in checklist.rst which already talks ab=
out
>> >> local_bh_disable(), but a bit differently. Fixing that up to correspo=
nd
>> >> to what we've been discussing in this thread, and adding a mention of
>> >> XDP as a usage example, results in the patch below.
>> >>=20
>> >> Paul, WDYT?
>> >
>> > I think that my original paragraph needed to have been updated back
>> > when v4.20 came out.  And again when RCU Tasks Trace came out.  ;-)
>> >
>> > So I did that updating, then approximated your patch on top of it,
>> > as shown below.  Does this work for you?
>>=20
>> Yup, LGTM, thanks! Shall I just fold that version into the next version
>> of my series, or do you want to take it through your tree (I suppose
>> it's independent of the rest, so either way is fine by me)?
>
> I currently have the two here in -rcu, most likely for v5.15 (as in
> the merge window after the upcoming one):
>
> 2b7cb9d95ba4 ("doc: Clarify and expand RCU updaters and corresponding rea=
ders")
> c6ef58907d22 ("doc: Give XDP as example of non-obvious RCU reader/updater=
 pairing")
>
> I am happy taking it, but if you really would like to add it to your
> series, please do take both.  ;-)

Alright, I'll fold both in to v4 :)

-Toke

