Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362B71F1C27
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgFHPdG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 11:33:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28272 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729754AbgFHPdG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 11:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ejRzmIfo/YStbmem6OtL2DwKFhnwBSwtvJjwxXmGTAs=;
        b=ZmbN4MZ6etr92F1M7dyKE+zY3e00aHzs06BIXI3nMhmw2FuC1I35rRhRIMydMuWEQjEGss
        6FUZ9jMNplCAyUywyZC9+8I8Q3nsx5ijzxvlmfoeq6OLuxZ8TGsEb+GabRcmXJi97C7exY
        J7R7y6sdoiHbiRXxj+Etssu75I+CiQ4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-z59hrjdaM0yVyiGoKu_p1A-1; Mon, 08 Jun 2020 11:33:03 -0400
X-MC-Unique: z59hrjdaM0yVyiGoKu_p1A-1
Received: by mail-ed1-f71.google.com with SMTP id w23so7037597edt.18
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2020 08:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ejRzmIfo/YStbmem6OtL2DwKFhnwBSwtvJjwxXmGTAs=;
        b=fqD6e9IiL/Jh08nI6rxextBzCgl6KjBXRbPeTDTnJlKNLt65ayw9LukJQ0KbFh6ypE
         EWnv2Z+LdYCKVHtckJq4WcsLi6pX2+uuNHyacCirvuySqx71PiHGNcj9JtqBQe2campI
         vsGAH7iQEIxMT39OtW4msDsp5qxA6SyBi9hL7DnCHIrk4AftzgddfeV2AWLoHkKqvPvC
         BX8AGIDgvOXoVkUIvPdSrXNMPq129Krd/2W1johX/txb085joh/Imm5q5KWKT8f3rWlg
         1OlhBbwHbAqR+F+W/1TAFZmlyEwRRN11P6XisHSIS/zbsSApwX7KNpuES5CKpB44hJmS
         1p6w==
X-Gm-Message-State: AOAM530yyxZhALvLZnC66AcAU12JQ1tzV/L9/0KrR0LPXGMWe2zSQLqa
        LEsmSUaQI4H1KZoSts6vKXwzskBdVK4vdkGF0POpZS4HXYgLKhrcJTva2MQFyVMBe3f5W24Eke5
        hGtcUrNe3Rtbp
X-Received: by 2002:a17:906:b7cd:: with SMTP id fy13mr20807850ejb.443.1591630379391;
        Mon, 08 Jun 2020 08:32:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6+Rh+weLJ3CfNdx8kMK8oyTWU8xcp2vBI8ombCs1CQg+t4iJHtD4AMWJQ7Wb0figtNT0EXQ==
X-Received: by 2002:a17:906:b7cd:: with SMTP id fy13mr20807831ejb.443.1591630379191;
        Mon, 08 Jun 2020 08:32:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id sa19sm11467045ejb.15.2020.06.08.08.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:32:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 916E818200D; Mon,  8 Jun 2020 17:32:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCHv4 bpf-next 0/2] xdp: add dev map multicast support
In-Reply-To: <20200605062606.GO102436@dhcp-12-153.nay.redhat.com>
References: <20200526140539.4103528-1-liuhangbin@gmail.com> <87zh9t1xvh.fsf@toke.dk> <20200603024054.GK102436@dhcp-12-153.nay.redhat.com> <87img8l893.fsf@toke.dk> <20200604040940.GL102436@dhcp-12-153.nay.redhat.com> <871rmvkvwn.fsf@toke.dk> <20200604121212.GM102436@dhcp-12-153.nay.redhat.com> <87bllzj9bw.fsf@toke.dk> <20200604144145.GN102436@dhcp-12-153.nay.redhat.com> <87d06ees41.fsf@toke.dk> <20200605062606.GO102436@dhcp-12-153.nay.redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Jun 2020 17:32:54 +0200
Message-ID: <878sgxd13t.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Thu, Jun 04, 2020 at 06:02:54PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Hangbin Liu <liuhangbin@gmail.com> writes:
>>=20
>> > On Thu, Jun 04, 2020 at 02:37:23PM +0200, Toke H=C3=83=C6=92=C3=82=C2=
=B8iland-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> >> > Now I use the ethtool_stats.pl to count forwarding speed and here i=
s the result:
>> >> >
>> >> > With kernel 5.7(ingress i40e, egress i40e)
>> >> > XDP:
>> >> > bridge: 1.8M PPS
>> >> > xdp_redirect_map:
>> >> >   generic mode: 1.9M PPS
>> >> >   driver mode: 10.4M PPS
>> >>=20
>> >> Ah, now we're getting somewhere! :)
>> >>=20
>> >> > Kernel 5.7 + my patch(ingress i40e, egress i40e)
>> >> > bridge: 1.8M
>> >> > xdp_redirect_map:
>> >> >   generic mode: 1.86M PPS
>> >> >   driver mode: 10.17M PPS
>> >>=20
>> >> Right, so this corresponds to a ~2ns overhead (10**9/10400000 -
>> >> 10**9/10170000). This is not too far from being in the noise, I suppo=
se;
>> >> is the difference consistent?
>> >
>> > Sorry, I didn't get, what different consistent do you mean?
>>=20
>> I meant, how much do the numbers vary between each test run?
>
> Oh, when run it at the same period, the number is stable, the range is ab=
out
> ~0.05M PPS. But after a long time or reboot, the speed may changed a litt=
le.
> Here is the new test result after I reboot the system:
>
> Kernel 5.7 + my patch(ingress i40e, egress i40e)
> xdp_redirect_map:
>   generic mode: 1.9M PPS
>   driver mode: 10.2M PPS
>
> xdp_redirect_map_multi:
>   generic mode: 1.58M PPS
>   driver mode: 7.16M PPS
>
> Kernel 5.7 + my patch(ingress i40e, egress i40e + veth(No XDP on peer))
> xdp_redirect_map:
>   generic mode: 2.2M PPS
>   driver mode: 14.2M PPS

This looks wrong - why is performance increasing when adding another
target? How are you even adding another target to regular
xdp_redirect_map?

-Toke

