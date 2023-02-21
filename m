Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9597B69E299
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjBUOrV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 09:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjBUOrU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 09:47:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66C28D06
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 06:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676990792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpISKQCjZ/nfTxKVAcbES0OdBunHJQhprLKIj7HM2OA=;
        b=BejGxHx19eVzGakhIRnjMKa4xe92qiL7u9eBfY+bxq3nxgZpZ3RYQ+n1C3bjqk5pbHp2Jb
        AlifZDYcHe/Qhq3KBjt2ZKM392NDBPzmrFywflFm97kOzaNKLc1Co2QvFOcLu55Y/eEj9T
        1g/RjVRkdFWqW0yT9tqbLV6ggAPg/4E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-a_SEJ2OiMJWWgopPVZIcxQ-1; Tue, 21 Feb 2023 09:46:31 -0500
X-MC-Unique: a_SEJ2OiMJWWgopPVZIcxQ-1
Received: by mail-wm1-f72.google.com with SMTP id k26-20020a05600c0b5a00b003dfe4bae099so1907034wmr.0
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 06:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676990790;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpISKQCjZ/nfTxKVAcbES0OdBunHJQhprLKIj7HM2OA=;
        b=T02kozw95F+FCaTIfxYl+7UI+bYyyvEW5YOcIgODKNAGtoWrudK3VXBE9+CqEkG7uh
         5KbP6GyHCa28qP6OtSSuiUZrpCI4iqYY8KHftoDrNuAcrmO2NB61Wh6aXKgVLza6rDzh
         /12w/VQPTzaBISqFPImK2Ez3U2TUX2PQG7xPI+DzUyC70LZUX5cQ/nEq4Yi6zHeMJ0Ld
         F6TpYKAq9Avg+3VGBzKOIRN48Hj8EOXfQmKTklH/VZegBybIIXcVAqYb7Qxt25HkVTKZ
         EmcyrwFmLO3I4bjfuFxWeCsKw/B3QFPXbiHhhT4Kl7xi0mIPfae/Wgz1UzuO+irhQh1b
         lL5A==
X-Gm-Message-State: AO0yUKVCcuCWohT1RcW5qkpZBGfrMWP6sDvMt4VHOfiF37+ZZS3SkXYZ
        a3Hkkx4T5axYKhB+YQ2qELEcjHrZjKF2K1lJ+rxBQwmIp1hiV2o0r2KhOtVLgoI1rvph0lxsoR1
        trjtdKt6nta9R
X-Received: by 2002:a05:600c:1c02:b0:3dd:1cd3:5d75 with SMTP id j2-20020a05600c1c0200b003dd1cd35d75mr3943344wms.0.1676990790343;
        Tue, 21 Feb 2023 06:46:30 -0800 (PST)
X-Google-Smtp-Source: AK7set/RgzKzRpe7AbFktdgMykeW6Kgj0Lv5DTVY5bfuh1xqjAel5CR6LppTKfV0QhnzzX6NgA/xHA==
X-Received: by 2002:a05:600c:1c02:b0:3dd:1cd3:5d75 with SMTP id j2-20020a05600c1c0200b003dd1cd35d75mr3943326wms.0.1676990790010;
        Tue, 21 Feb 2023 06:46:30 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d67c3000000b002c59f186739sm5811893wrw.23.2023.02.21.06.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 06:46:29 -0800 (PST)
Message-ID: <aaf3d11ea5b247ab03d117dadae682fe2180d38a.camel@redhat.com>
Subject: Re: [PATCH net] udp: fix memory schedule error
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Date:   Tue, 21 Feb 2023 15:46:27 +0100
In-Reply-To: <CAL+tcoD8PzL4khHq44z27qSHHGkcC4YUa91E3h+ki7O0u3SshQ@mail.gmail.com>
References: <20230221110344.82818-1-kerneljasonxing@gmail.com>
         <48429c16fdaee59867df5ef487e73d4b1bf099af.camel@redhat.com>
         <CAL+tcoD8PzL4khHq44z27qSHHGkcC4YUa91E3h+ki7O0u3SshQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-02-21 at 21:39 +0800, Jason Xing wrote:
> On Tue, Feb 21, 2023 at 8:27 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >=20
> > On Tue, 2023-02-21 at 19:03 +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >=20
> > > Quoting from the commit 7c80b038d23e ("net: fix sk_wmem_schedule()
> > > and sk_rmem_schedule() errors"):
> > >=20
> > > "If sk->sk_forward_alloc is 150000, and we need to schedule 150001 by=
tes,
> > > we want to allocate 1 byte more (rounded up to one page),
> > > instead of 150001"
> >=20
> > I'm wondering if this would cause measurable (even small) performance
> > regression? Specifically under high packet rate, with BH and user-space
> > processing happening on different CPUs.
> >=20
> > Could you please provide the relevant performance figures?
>=20
> Sure, I've done some basic tests on my machine as below.
>=20
> Environment: 16 cpus, 60G memory
> Server: run "iperf3 -s -p [port]" command and start 500 processes.
> Client: run "iperf3 -u -c 127.0.0.1 -p [port]" command and start 500 proc=
esses.

Just for the records, with the above command each process will send
pkts at 1mbs - not very relevant performance wise.

Instead you could do:

taskset 0x2 iperf -s &
iperf -u -c 127.0.0.1 -b 0 -l 64


> In theory, I have no clue about why it could cause some regression?
> Maybe the memory allocation is not that enough compared to the
> original code?

As Eric noted, for UDP traffic, due to the expected average packet
size, sk_forward_alloc is touched quite frequently, both with and
without this patch, so there is little chance it will have any
performance impact.

Cheers,

Paolo

