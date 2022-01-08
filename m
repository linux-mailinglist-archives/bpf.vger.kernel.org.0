Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4242D4885E5
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 21:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiAHU3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Jan 2022 15:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229822AbiAHU3x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 8 Jan 2022 15:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641673793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dh/KH9uD8FIprLuXVq8Q8sWK983oPsbIjBghc2ryCqg=;
        b=hCyLv17oTkLyU+N/NdffysERau1YhH11UPtL3diti4jU6BZtKhnxbFZzRI1diauaZJwvFG
        LmDip2HC8u8iTvhC4CBzk6sDToLKy0QjtifXOAzS3+k0upUnbRJt617BXKFcISb9sorJi9
        dPY2JNadXzDKH7H0hnjKH552Ow9FiFc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-fS9GvxqaPO2JJnF7aL977w-1; Sat, 08 Jan 2022 15:29:51 -0500
X-MC-Unique: fS9GvxqaPO2JJnF7aL977w-1
Received: by mail-ed1-f69.google.com with SMTP id h6-20020a056402280600b003f9967993aeso7229719ede.10
        for <bpf@vger.kernel.org>; Sat, 08 Jan 2022 12:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Dh/KH9uD8FIprLuXVq8Q8sWK983oPsbIjBghc2ryCqg=;
        b=ngBty6NR30gKy307vVsk44jdAEydbxRktx2SaVvmCV8c/Vgw4QPcbDjtK6lDiV0PqI
         2wAe1RdnPH5xwt2DOTyrgekxR0JuWDNg+kulwBwNGUKzo/rzWqgIZoOD2c2S50C9Mwbl
         9Q1ukMK9EYvCofxVfFQmc1sRw29bmFkftZ0l0eePr9hDEdCUdel2xQKhGDLAsFugijxp
         kLZjHzDzAN5frkE18cSbLvB4TFbZf2MFc1gqDxtIEoKtTQ2Vm3qtCUf6axZyJ3nAh7Wx
         vfbsXkFlHh4T7fTHHaRUPne/y6AYoqOTQ0Y1rWdYE4sEiIdj4qC53dA3Im44F19XCTMM
         YYcg==
X-Gm-Message-State: AOAM5332A4yNp7t0EuRzOvDuFm/gLJoiwPKgEmWZ+p4+ufw7+3FeeP+E
        eaLtR22RL8P/vmHWUlX5bbiU/TP/4qX8m394oGeE3IFuq5GGFUHSixyUV3wI/VHDdMg3VPHx/+e
        3K8Alt4822qvR
X-Received: by 2002:a17:906:f1c1:: with SMTP id gx1mr55930398ejb.554.1641673790475;
        Sat, 08 Jan 2022 12:29:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTr5VGtDdGiudJAk1ztySeNuhP9qd+XBHQLnY8va9CaPUamGD8dX8c6oZmwI31EEz+qeH68Q==
X-Received: by 2002:a17:906:f1c1:: with SMTP id gx1mr55930389ejb.554.1641673790115;
        Sat, 08 Jan 2022 12:29:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g9sm1134615edb.53.2022.01.08.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:29:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C0956181F2A; Sat,  8 Jan 2022 21:29:48 +0100 (CET)
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
Subject: Re: [PATCH bpf-next v7 3/3] selftests/bpf: Add selftest for
 XDP_REDIRECT in bpf_prog_run()
In-Reply-To: <CAADnVQ+oqGuvm1FCnXUrfPcvNFF5iwK-FeajLO0PpnifNNZ05g@mail.gmail.com>
References: <20220107215438.321922-1-toke@redhat.com>
 <20220107215438.321922-4-toke@redhat.com>
 <CAADnVQ+oqGuvm1FCnXUrfPcvNFF5iwK-FeajLO0PpnifNNZ05g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 08 Jan 2022 21:29:48 +0100
Message-ID: <87h7ae7yyr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Jan 7, 2022 at 1:54 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>> +
>> +#define NUM_PKTS 1000000
>
> It takes 7 seconds on my kvm with kasan and lockdep
> and will take much longer in BPF CI.
> So it needs to be lower otherwise CI will struggle.

OK, I'll lower it.

>> +       /* The XDP program we run with bpf_prog_run() will cycle through=
 all
>> +        * three xmit (PASS/TX/REDIRECT) return codes starting from abov=
e, and
>> +        * ending up with PASS, so we should end up with two packets on =
the dst
>> +        * iface and NUM_PKTS-2 in the TC hook. We match the packets on =
the UDP
>> +        * payload.
>> +        */
>
> could you keep cycling through all return codes?
> That should make the test stronger.

Can do.

>> +
>> +       /* We enable forwarding in the test namespace because that will =
cause
>> +        * the packets that go through the kernel stack (with XDP_PASS) =
to be
>> +        * forwarded back out the same interface (because of the packet =
dst
>> +        * combined with the interface addresses). When this happens, the
>> +        * regular forwarding path will end up going through the same
>> +        * veth_xdp_xmit() call as the XDP_REDIRECT code, which can caus=
e a
>> +        * deadlock if it happens on the same CPU. There's a local_bh_di=
sable()
>> +        * in the test_run code to prevent this, but an earlier version =
of the
>> +        * code didn't have this, so we keep the test behaviour to make =
sure the
>> +        * bug doesn't resurface.
>> +        */
>> +       SYS("sysctl -qw net.ipv6.conf.all.forwarding=3D1");
>
> Does it mean that without forwarding=3D1 the kernel will dead lock ?!

No, the deadlock is referring to the lockdep warning you posted. Which I
fixed by moving around the local_bh_disable(); that comment is just
meant to explain why the forwarding sysctl is set (so that the code path
is still exercised even though it's no longer faulty). Reading it again
now I can see that this was not entirely clear, will try to improve the
wording :)

-Toke

