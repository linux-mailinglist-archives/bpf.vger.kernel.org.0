Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9591CB260
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHO6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 10:58:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726690AbgEHO6i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 10:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588949915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5cxHWT1fhpBsjHISLT+nvjAVD2NFN8LTOupRO9tndAE=;
        b=iZGw6EaepDZZyHs7kF8s+GPzn5baDqsvETPfaUj8EDcDRKObWTrIVDHLOKXz4EBRU7oRQD
        6Rv8EUH/jhkayvGP7xjKg0mJNkgepMKTQOUMN8kyouLW1XmJDXPGJsRHYPXiHC/JVyctxU
        j3nmjmVQLilmqazLQoLzfm18PzIMpYQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-aI3C5g52MKamxTr56ecKhA-1; Fri, 08 May 2020 10:58:33 -0400
X-MC-Unique: aI3C5g52MKamxTr56ecKhA-1
Received: by mail-lf1-f70.google.com with SMTP id n13so662524lfb.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 07:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5cxHWT1fhpBsjHISLT+nvjAVD2NFN8LTOupRO9tndAE=;
        b=B/aKl7ahM/hKz6XgW7ZiccdnTkuWSz2XD1mkdFN4HFvvdmIQH7Nwu3QK8WMFVPpqtG
         R1CK51o+VTMeq5jMzTIhJ0EWVrI5IBQT1ChVRpcDne7PZYLEwqoOwjz63OH3vaNnLFc6
         YVV1PC0vxo2U8ismMnAKofdQm6AuAlSxpQEqSfELkhah2/Gn+giHuNrXkLp9iHhx/ho6
         FIiArgYM4BsU5umCFmYPaTlHHlV7O6C7hSB5jTlGdHjG8RLJWGDi8GCgYVhArk2sUSf9
         aC0yFdfMUeWm6zK7rSHiMlaGnVk41V/scccJnxcm/DmvNb0HGg/2JDhu5kITnM3RJWls
         3hBw==
X-Gm-Message-State: AOAM533glRjksKXA699EnfFYLrhSKrLZe2MiV1Ta/ZWaq6kTpNSKSBP+
        DQOFKqZF+C/fAZDPrvX8m+wFeEvFc/z8ZCHmN9vk2/bCTw6W8Q4pVYrOjVWU3du4I1WqC0lbg7Z
        YykCif9nnH55g
X-Received: by 2002:a2e:9712:: with SMTP id r18mr2018698lji.225.1588949911985;
        Fri, 08 May 2020 07:58:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb7IppmyTDwD/D2z40v3OESMOGTKDkNqBfYut8xM2Nt2kauXly420+Q26OFUMj9Nt/bILVVw==
X-Received: by 2002:a2e:9712:: with SMTP id r18mr2018676lji.225.1588949911669;
        Fri, 08 May 2020 07:58:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z23sm1342258ljm.46.2020.05.08.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 07:58:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DD1EF18151A; Fri,  8 May 2020 16:58:28 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [RFC PATCHv2 bpf-next 1/2] xdp: add a new helper for dev map multicast support
In-Reply-To: <20200508085357.GC102436@dhcp-12-153.nay.redhat.com>
References: <20200415085437.23028-1-liuhangbin@gmail.com> <20200424085610.10047-1-liuhangbin@gmail.com> <20200424085610.10047-2-liuhangbin@gmail.com> <87r1wd2bqu.fsf@toke.dk> <20200506091442.GA102436@dhcp-12-153.nay.redhat.com> <874kstmlhz.fsf@toke.dk> <20200508085357.GC102436@dhcp-12-153.nay.redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 May 2020 16:58:28 +0200
Message-ID: <878si2h3sb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Wed, May 06, 2020 at 12:00:08PM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> > No, I haven't test the performance. Do you have any suggestions about =
how
>> > to test it? I'd like to try forwarding pkts to 10+ ports. But I don't =
know
>> > how to test the throughput. I don't think netperf or iperf supports
>> > this.
>>=20
>> What I usually do when benchmarking XDP_REDIRECT is to just use pktgen
>> (samples/pktgen in the kernel source tree) on another machine,
>> specifically, like this:
>>=20
>> ./pktgen_sample03_burst_single_flow.sh  -i enp1s0f1 -d 10.70.2.2 -m ec:0=
d:9a:db:11:35 -t 4  -s 64
>>=20
>> (adjust iface, IP and MAC address to your system, of course). That'll
>> flood the target machine with small UDP packets. On that machine, I then
>> run the 'xdp_redirect_map' program from samples/bpf. The bpf program
>> used by that sample will update an internal counter for every packet,
>> and the userspace prints it out, which gives you the performance (in
>> PPS). So just modifying that sample to using your new multicast helper
>> (and comparing it to regular REDIRECT to a single device) would be a
>> first approximation of a performance test.
>
> Thanks for this method. I will update the sample and do some more tests.

Great!

>> You could do something like:
>>=20
>> bool first =3D true;
>> for (;;) {
>>=20
>> [...]
>>=20
>>            if (!first) {
>>    		nxdpf =3D xdpf_clone(xdpf);
>>    		if (unlikely(!nxdpf))
>>    			return -ENOMEM;
>>    		bq_enqueue(dev, nxdpf, dev_rx);
>>            } else {
>>    		bq_enqueue(dev, xdpf, dev_rx);
>>    		first =3D false;
>>            }
>> }
>>=20
>> /* didn't find anywhere to forward to, free buf */
>> if (first)
>>    xdp_return_frame_rx_napi(xdpf);
>
> I think the first xdpf will be consumed by the driver and the later
> xdpf_clone() will failed, won't it?

No, bq_enqueue just sticks the frame on a list, it's not consumed until
after the NAPI cycle ends (and the driver calls xdp_do_flush()).

> How about just do a xdp_return_frame_rx_napi(xdpf) after all nxdpf enqueu=
e?

Yeah, that would be the semantically obvious thing to do, but it is
wasteful in that you end up performing one more clone than you strictly
have to :)

>> > @@ -3534,6 +3539,8 @@ int xdp_do_redirect(struct net_device *dev, stru=
ct
>> > xdp_buff *xdp,
>> >                   struct bpf_prog *xdp_prog)
>> >  {
>> >       struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info=
);
>> > +     bool exclude_ingress =3D !!(ri->flags & BPF_F_EXCLUDE_INGRESS);
>> > +     struct bpf_map *ex_map =3D READ_ONCE(ri->ex_map);
>>
>> I don't think you need the READ_ONCE here since there's already one
>> below?
>
> BTW, I forgot to ask, why we don't need the READ_ONCE for ex_map?
> I though the map and ex_map are two different pointers.

It isn't, but not for the reason I thought, so I can understand why my
comment might have been somewhat confusing (I have been confused by this
myself until just now...).

The READ_ONCE() is not needed because the ex_map field is only ever read
from or written to by the CPU owning the per-cpu pointer. Whereas the
'map' field is manipulated by remote CPUs in bpf_clear_redirect_map().
So you need neither READ_ONCE() nor WRITE_ONCE() on ex_map, just like
there are none on tgt_index and tgt_value.

-Toke

