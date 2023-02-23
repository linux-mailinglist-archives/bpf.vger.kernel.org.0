Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B666A0402
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 09:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjBWIkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 03:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjBWIkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 03:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338BC13DC2
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 00:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677141562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sPuPMmKl8Fh55oJyqKfdWjSTl4UX6ztUqAWilF1Ap8=;
        b=WoxGTWYjPziAI076K06HglUX3Ov4DLC5GDT9UeMgHiRsyU7nGtvfO/f0o7tEmWCc6jyGFw
        Bsi18+a8Cq5VCSbYGSqImBAlwL2K43QDSP+AQOdnmklI/c3ipLkfUJWZLlWX6bgMDIMwzo
        ZNxVFVXecmISy0TFQJb5D+svpMN3ZGQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-AHsdILhqOiiXMZr9zXhAPQ-1; Thu, 23 Feb 2023 03:39:21 -0500
X-MC-Unique: AHsdILhqOiiXMZr9zXhAPQ-1
Received: by mail-wr1-f72.google.com with SMTP id 4-20020a5d47a4000000b002c5699ff08aso2035677wrb.9
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 00:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677141560;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sPuPMmKl8Fh55oJyqKfdWjSTl4UX6ztUqAWilF1Ap8=;
        b=iWfWoF/GU5ho3Ltyzn69oBaOLgUhQHGfPuzMkYMal7RiFV+wK2YVLCymwiswyrNE6E
         3X4m0nkkolEyeogWVemUJP7AL3y87Pb9cx/RtANMvC+rtPaEsYfqm/Wsr95ecEQB2HH7
         A8ho2g5ulDN9m3+kqY9/IIOAHZKAHnqIbZN7iyHfbuXjZojS0V3iaLFwN6kr74x2j6eq
         aNAPCMUQ1snakwejX7ZRbmo28BqEZbFWgp5WDSbjZlJtQusq/8H0F1Bood1prGpE8au3
         H+4DGHyrZkMCeKwFyQXkv+mFuxbCL/l6J3zsfMigyUPPCRhwih2l1YVCNdEndl9wmI0t
         lWfA==
X-Gm-Message-State: AO0yUKW7rGZ9Ue4Qfits2ii4p2yS+prmWM70VrTD20Zbxz9zygRMLP/O
        KnGnlnl+1ECcTH8UUfUxBGjKGa1o8OcUWFSe5c7vuWMty956mb6p3cH8DpxTSR3r/9icKZsIyEL
        /GBauh93gjkyO
X-Received: by 2002:a1c:741a:0:b0:3e2:415:f09f with SMTP id p26-20020a1c741a000000b003e20415f09fmr10130671wmc.3.1677141559961;
        Thu, 23 Feb 2023 00:39:19 -0800 (PST)
X-Google-Smtp-Source: AK7set98+o6jJ1qOgbToOoRq/imOK3FoKhZ+VL6UYssekxL/stE0Ck+L7wA5jcx60YYmNlFc6d2hsA==
X-Received: by 2002:a1c:741a:0:b0:3e2:415:f09f with SMTP id p26-20020a1c741a000000b003e20415f09fmr10130657wmc.3.1677141559590;
        Thu, 23 Feb 2023 00:39:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003e21f20b646sm12230241wmq.21.2023.02.23.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:39:18 -0800 (PST)
Message-ID: <795aed3f0e433a89fb72a8af3fc736f58dea1bf1.camel@redhat.com>
Subject: Re: [PATCH net] udp: fix memory schedule error
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Date:   Thu, 23 Feb 2023 09:39:17 +0100
In-Reply-To: <CAL+tcoBGFkXea-GyzbO41Ve8_wUF3PT=YF43TxuzgM+adVa8gw@mail.gmail.com>
References: <20230221110344.82818-1-kerneljasonxing@gmail.com>
         <48429c16fdaee59867df5ef487e73d4b1bf099af.camel@redhat.com>
         <CAL+tcoD8PzL4khHq44z27qSHHGkcC4YUa91E3h+ki7O0u3SshQ@mail.gmail.com>
         <aaf3d11ea5b247ab03d117dadae682fe2180d38a.camel@redhat.com>
         <CAL+tcoBZFFwOnUqzcDtSsNyfPgHENAOv0bPcvncxuMPwCn40+Q@mail.gmail.com>
         <CAL+tcoBGFkXea-GyzbO41Ve8_wUF3PT=YF43TxuzgM+adVa8gw@mail.gmail.com>
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

On Wed, 2023-02-22 at 11:47 +0800, Jason Xing wrote:
> On Tue, Feb 21, 2023 at 11:46 PM Jason Xing <kerneljasonxing@gmail.com> w=
rote:
> >=20
> > On Tue, Feb 21, 2023 at 10:46 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > >=20
> > > On Tue, 2023-02-21 at 21:39 +0800, Jason Xing wrote:
> > > > On Tue, Feb 21, 2023 at 8:27 PM Paolo Abeni <pabeni@redhat.com> wro=
te:
> > > > >=20
> > > > > On Tue, 2023-02-21 at 19:03 +0800, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >=20
> > > > > > Quoting from the commit 7c80b038d23e ("net: fix sk_wmem_schedul=
e()
> > > > > > and sk_rmem_schedule() errors"):
> > > > > >=20
> > > > > > "If sk->sk_forward_alloc is 150000, and we need to schedule 150=
001 bytes,
> > > > > > we want to allocate 1 byte more (rounded up to one page),
> > > > > > instead of 150001"
> > > > >=20
> > > > > I'm wondering if this would cause measurable (even small) perform=
ance
> > > > > regression? Specifically under high packet rate, with BH and user=
-space
> > > > > processing happening on different CPUs.
> > > > >=20
> > > > > Could you please provide the relevant performance figures?
> > > >=20
> > > > Sure, I've done some basic tests on my machine as below.
> > > >=20
> > > > Environment: 16 cpus, 60G memory
> > > > Server: run "iperf3 -s -p [port]" command and start 500 processes.
> > > > Client: run "iperf3 -u -c 127.0.0.1 -p [port]" command and start 50=
0 processes.
> > >=20
> > > Just for the records, with the above command each process will send
> > > pkts at 1mbs - not very relevant performance wise.
> > >=20
> > > Instead you could do:
> > >=20
> >=20
> > > taskset 0x2 iperf -s &
> > > iperf -u -c 127.0.0.1 -b 0 -l 64
> > >=20
> >=20
> > Thanks for your guidance.
> >=20
> > Here're some numbers according to what you suggested, which I tested
> > several times.
> > ----------|IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > Before: lo 411073.41 411073.41  36932.38  36932.38
> > After:   lo 410308.73 410308.73  36863.81  36863.81
> >=20
> > Above is one of many results which does not mean that the original
> > code absolutely outperforms.
> > The output is not that constant and stable, I think.
>=20
> Today, I ran the same test on other servers, it looks the same as
> above. Those results fluctuate within ~2%.
>=20
> Oh, one more thing I forgot to say is the output of iperf itself which
> doesn't show any difference.
> Before: Bitrate is 211 - 212 Mbits/sec
> After: Bitrate is 211 - 212 Mbits/sec
> So this result is relatively constant especially if we keep running
> the test over 2 minutes.

Thanks for the testing. My personal take on this one is that is more a
refactor than a bug fix - as the amount forward allocated memory should
always be negligible for UDP.=20

Still it could make sense keep the accounting schema consistent across
different protocols. I suggest to repost for net-next, when it will re-
open, additionally introducing __sk_mem_schedule() usage to avoid code
duplication.

Thanks,

Paolo

