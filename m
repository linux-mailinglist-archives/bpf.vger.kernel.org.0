Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FFF486AFD
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiAFUU7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 15:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234612AbiAFUU5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 15:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641500456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVPgqD2PlyQyW5KqK6Xa09cRn07PcS57Of9dZqeQYns=;
        b=KKGOE4nvCb+Wuo7yjCjaAUYWj+QhisWy1Z5vUslc1aikjM6iSI7/V0UurnWZLkiXEKdRds
        puVoJ/YeFcY4ccOTxQ+/e86YrYMtjlzHJFiLB12H3z2NCmyuNStGvf4MGHvlTNOpOm2Hl+
        JZcYsQ6Y2rhhL9MP83EOvKOIjxPcEW8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-sZmR8qwdMkqUHkoeLxP_xQ-1; Thu, 06 Jan 2022 15:20:55 -0500
X-MC-Unique: sZmR8qwdMkqUHkoeLxP_xQ-1
Received: by mail-ed1-f70.google.com with SMTP id m16-20020a056402431000b003fb60bbe0e2so27494edc.3
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 12:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uVPgqD2PlyQyW5KqK6Xa09cRn07PcS57Of9dZqeQYns=;
        b=EMhNK5abQABx2cN3qnxDvNzQx9BeYkwQvNJpS818HoCEYXiUEmZh0g6ekuGJpRNZn4
         ft08TC7rC7exHycu17FbF0d12sOYyZkyaX5dBsdkBQaSoJMeOFQvFGNyZOzjzojwW1Es
         shzR0cJYPpzjzOCGprpTKN1YfrqySrRdcu+yf8zSYuXSWuy/rJupkUfctqyhKwYnkmzu
         0Tq/cbpQM8Q+F8dQwLKCHmMlj9iSqqryyciFHeMKXFYewyUAocoCwR+F1TJreJQlB7g+
         W9/OTOvXDWZZUJkNYYZA0tXmKtXgdcjO7n754m/eQlvPBa3Uyr8tLhXksZdR5lNvDmcu
         WlfQ==
X-Gm-Message-State: AOAM530PFmm+pdqiIzyDbAnBorUAAi3YTouhxlymCRs8sYIEbG5r/s3W
        5IGoV8dropLmmM31Uv4YVYoG11BgO/jPqLMLpR9rEwPQB5YlPy1WslnIpJQ2QCuqLvLNWnSVjA4
        IogxqD/AjWBtv
X-Received: by 2002:a05:6402:5190:: with SMTP id q16mr60144579edd.332.1641500453867;
        Thu, 06 Jan 2022 12:20:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx607J+hqfiTtq8mJkPUIsvhlCsEcMGUzayoy5UsP40GeTlwvH/LAzG7BtX60oKed4m1VMzRw==
X-Received: by 2002:a05:6402:5190:: with SMTP id q16mr60144511edd.332.1641500452572;
        Thu, 06 Jan 2022 12:20:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2sm759736ejx.123.2022.01.06.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 12:20:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 54970181F2A; Thu,  6 Jan 2022 21:20:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 7/7] selftests/bpf: Add selftest for
 XDP_REDIRECT in bpf_prog_run()
In-Reply-To: <CAADnVQ+6-Q6N1t0UsmF=Rn1yP=KPo7Xc2Fiy1rzJ+Hb0oAr4Hw@mail.gmail.com>
References: <20220103150812.87914-1-toke@redhat.com>
 <20220103150812.87914-8-toke@redhat.com>
 <20220106042027.zy6j4a72nxaqmocw@ast-mbp.dhcp.thefacebook.com>
 <87y23t9blc.fsf@toke.dk>
 <CAADnVQ+j=DO8fMCcpoHmAjrW5sTbhHp_OA4eVpcKcwwRzsvKTA@mail.gmail.com>
 <87tuegafnw.fsf@toke.dk>
 <CAADnVQ+6-Q6N1t0UsmF=Rn1yP=KPo7Xc2Fiy1rzJ+Hb0oAr4Hw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 06 Jan 2022 21:20:51 +0100
Message-ID: <87mtk8aa58.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Jan 6, 2022 at 10:21 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Thu, Jan 6, 2022 at 6:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> >>
>> >> > On Mon, Jan 03, 2022 at 04:08:12PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>> >> >> +
>> >> >> +#define NUM_PKTS 3
>> >> >
>> >> > May be send a bit more than 3 packets?
>> >> > Just to test skb_list logic for XDP_PASS.
>> >>
>> >> OK, can do.
>> >>
>> >> >> +
>> >> >> +    /* We setup a veth pair that we can not only XDP_REDIRECT pac=
kets
>> >> >> +     * between, but also route them. The test packet (defined abo=
ve) has
>> >> >> +     * address information so it will be routed back out the same=
 interface
>> >> >> +     * after it has been received, which will allow it to be pick=
ed up by
>> >> >> +     * the XDP program on the destination interface.
>> >> >> +     *
>> >> >> +     * The XDP program we run with bpf_prog_run() will cycle thro=
ugh all
>> >> >> +     * four return codes (DROP/PASS/TX/REDIRECT), so we should en=
d up with
>> >> >> +     * NUM_PKTS - 1 packets seen on the dst iface. We match the p=
ackets on
>> >> >> +     * the UDP payload.
>> >> >> +     */
>> >> >> +    SYS("ip link add veth_src type veth peer name veth_dst");
>> >> >> +    SYS("ip link set dev veth_src address 00:11:22:33:44:55");
>> >> >> +    SYS("ip link set dev veth_dst address 66:77:88:99:aa:bb");
>> >> >> +    SYS("ip link set dev veth_src up");
>> >> >> +    SYS("ip link set dev veth_dst up");
>> >> >> +    SYS("ip addr add dev veth_src fc00::1/64");
>> >> >> +    SYS("ip addr add dev veth_dst fc00::2/64");
>> >> >> +    SYS("ip neigh add fc00::2 dev veth_src lladdr 66:77:88:99:aa:=
bb");
>> >> >> +    SYS("sysctl -w net.ipv6.conf.all.forwarding=3D1");
>> >> >
>> >> > These commands pollute current netns. The test has to create its ow=
n netns
>> >> > like other tests do.
>> >>
>> >> Right, will fix.
>> >>
>> >> > The forwarding=3D1 is odd. Nothing in the comments or commit logs
>> >> > talks about it.
>> >>
>> >> Hmm, yeah, should probably have added an explanation, sorry about tha=
t :)
>> >>
>> >> > I'm guessing it's due to patch 6 limitation of picking loopback
>> >> > for XDP_PASS and XDP_TX, right?
>> >> > There is ingress_ifindex field in struct xdp_md.
>> >> > May be use that to setup dev and rxq in test_run in patch 6?
>> >> > Then there will be no need to hack through forwarding=3D1 ?
>> >>
>> >> No, as you note there's already ingress_ifindex to set the device, and
>> >> the test does use that:
>> >>
>> >> +       memcpy(skel->rodata->expect_dst, &pkt_udp.eth.h_dest, ETH_ALE=
N);
>> >> +       skel->rodata->ifindex_out =3D ifindex_src;
>> >> +       ctx_in.ingress_ifindex =3D ifindex_src;
>> >
>> > My point is that this ingress_ifindex should be used instead of loopba=
ck.
>> > Otherwise the test_run infra is lying to the xdp program.
>>
>> But it is already using that! There is just no explicit code in patch 6
>> to do that because that was already part of the XDP prog_run
>> functionality.
>>
>> Specifically, the existing bpf_prog_test_run_xdp() will pass the context
>> through xdp_convert_md_to_buff() which will resolve the ifindex and get
>> a dev reference. So the xdp_buff object being passed to the new
>> bpf_test_run_xdp_live() function already has the right device in
>> ctx->rxq.
>
> Got it. Please make it clear in the commit log.

Ah, sorry, already hit send on v6 before I saw this. If you want to fix
up the commit message while applying, how about a paragraph at the end
like:


The new mode reuses the setup code from the existing bpf_prog_run() for
XDP. This means that userspace can set the ingress ifindex and RXQ
number as part of the context object being passed to the kernel, in
which case packets will look like they arrived on that interface when
the test program returns XDP_PASS and the packets go up the stack.

>> No the problem of XDP_PASS going in the opposite direction of XDP_TX and
>> XDP_REDIRECT remains. This is just like on a physical interface: if you
>> XDP_TX a packet it goes back out, if you XDP_PASS it, it goes up the
>> stack. To intercept both after the fact, you need to look in two
>> different places.
>>
>> Anyhow, just using a TC hook for XDP_PASS works fine and gets rid of the
>> forwarding hack; I'll send a v6 with that just as soon as I verify that
>> I didn't break anything when running the traffic generator on bare metal=
 :)
>
> Got it. You mean a tc ingress prog attached to veth_src ? That should wor=
k.

Yup, exactly!

-Toke

