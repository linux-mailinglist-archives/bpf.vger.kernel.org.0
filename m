Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C35E4739A4
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 01:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbhLNAgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 19:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237886AbhLNAgR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 19:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639442176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8g75T7OrGiYwikbemJZ7V+16BX6QfRNNlFlgU3rpmYs=;
        b=TvFeSzBzkj5PSl/Ku9m46jF4XnojbNTjSp0BQo1a9Eh34oJ2Nkf5r/iZ4d+kYPpk94v11X
        /BAhDS1fmfb5c85RWbFT3Z9x4JCIpf7Y4i7z0TZUVX/GH4UR1YfNVg8gTsCBzdPtpHSJxC
        1Y9W9ZBmrzbNvj5K6QpvuhOIwraz3+0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369--iw0ddFrNaK39Si9-hBkqQ-1; Mon, 13 Dec 2021 19:36:15 -0500
X-MC-Unique: -iw0ddFrNaK39Si9-hBkqQ-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso15397402eds.22
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 16:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8g75T7OrGiYwikbemJZ7V+16BX6QfRNNlFlgU3rpmYs=;
        b=qq6aZF1YzokttFm2vth+3n0efaG0Zrmw1RQfRuI8fcOmidDgfSHabon5nE5veUEtH7
         Gt8Y/6rkcEpjXaaZLYberQQNZsecIvfs8nc0grlpb/RG1figDL7npmrBONu/IEfRwnY4
         ER9LYl1A+IrzESWtNkPU2G1z/N9LnvdL4olhkioHj80WU65zjDQiKB58qZGwpbFXA4vW
         mvq6cIyhst/Jo50bObmMQbJlM3o2p30Cf9sQ6HnyNUmntAaemBMWQbMA4et3JHV1yqIW
         u5qKNm9mZygiZoYsZRL4B9zEdI1LhIMUyn/uwVvw4Y/+NsCZ2KVbzyq5p7UOHZIQeVKK
         RvuQ==
X-Gm-Message-State: AOAM530Gjv4mqusBdKa3E8l7mmac/V8sKkBs5BVBJxMSGJGAl+vMr0eD
        XvmzdRimLAdPJ3//uHTYwq0E806rwzDpqSwLgp4j0iH+h854NM+guFbifaJUC4hlIWJJ1AXM5NN
        SIRJFa69thkag
X-Received: by 2002:a17:906:4488:: with SMTP id y8mr1901817ejo.175.1639442174166;
        Mon, 13 Dec 2021 16:36:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjJwIPO7jyNoeDXjoW7bokAZ8hnH4dFJJKZ+uGdhhp+zxzgR9nZBKkWcydIs0WhwCkiuQqFA==
X-Received: by 2002:a17:906:4488:: with SMTP id y8mr1901773ejo.175.1639442173755;
        Mon, 13 Dec 2021 16:36:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 14sm616791ejj.156.2021.12.13.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 16:36:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3ED03183566; Tue, 14 Dec 2021 01:36:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 6/8] bpf: Add XDP_REDIRECT support to XDP
 for bpf_prog_run()
In-Reply-To: <CAADnVQJunh7KTKJe3F_tO0apqLHtOMFqGAB-V28ORh6o5JUTUQ@mail.gmail.com>
References: <20211211184143.142003-1-toke@redhat.com>
 <20211211184143.142003-7-toke@redhat.com>
 <CAADnVQJYfyHs41H1x-1wR5WVSX+3ju69XMUQ4id5+1DLkTVDkg@mail.gmail.com>
 <87tufceaid.fsf@toke.dk>
 <CAADnVQJunh7KTKJe3F_tO0apqLHtOMFqGAB-V28ORh6o5JUTUQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 14 Dec 2021 01:36:12 +0100
Message-ID: <87fsqwyqdf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 13, 2021 at 8:26 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Sat, Dec 11, 2021 at 10:43 AM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
>> >> +
>> >> +static void bpf_test_run_xdp_teardown(struct bpf_test_timer *t)
>> >> +{
>> >> +       struct xdp_mem_info mem =3D {
>> >> +               .id =3D t->xdp.pp->xdp_mem_id,
>> >> +               .type =3D MEM_TYPE_PAGE_POOL,
>> >> +       };
>> >
>> > pls add a new line.
>> >
>> >> +       xdp_unreg_mem_model(&mem);
>> >> +}
>> >> +
>> >> +static bool ctx_was_changed(struct xdp_page_head *head)
>> >> +{
>> >> +       return (head->orig_ctx.data !=3D head->ctx.data ||
>> >> +               head->orig_ctx.data_meta !=3D head->ctx.data_meta ||
>> >> +               head->orig_ctx.data_end !=3D head->ctx.data_end);
>> >
>> > redundant ()
>> >
>> >>         bpf_test_timer_enter(&t);
>> >>         old_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>> >>         do {
>> >>                 run_ctx.prog_item =3D &item;
>> >> -               if (xdp)
>> >> +               if (xdp && xdp_redirect) {
>> >> +                       ret =3D bpf_test_run_xdp_redirect(&t, prog, c=
tx);
>> >> +                       if (unlikely(ret < 0))
>> >> +                               break;
>> >> +                       *retval =3D ret;
>> >> +               } else if (xdp) {
>> >>                         *retval =3D bpf_prog_run_xdp(prog, ctx);
>> >
>> > Can we do this unconditionally without introducing a new uapi flag?
>> > I mean "return bpf_redirect()" was a nop under test_run.
>> > What kind of tests might break if it stops being a nop?
>>
>> Well, I view the existing mode of bpf_prog_test_run() with XDP as a way
>> to write XDP unit tests: it allows you to submit a packet, run your XDP
>> program on it, and check that it returned the right value and did the
>> right modifications. This means if you XDP program does 'return
>> bpf_redirect()', userspace will still get the XDP_REDIRECT value and so
>> it can check correctness of your XDP program.
>>
>> With this flag the behaviour changes quite drastically, in that it will
>> actually put packets on the wire instead of getting back the program
>> return. So I think it makes more sense to make it a separate opt-in
>> mode; the old behaviour can still be useful for checking XDP program
>> behaviour.
>
> Ok that all makes sense.

Great!

> How about using prog_run to feed the data into proper netdev?
> XDP prog may or may not attach to it (this detail is tbd) and
> prog_run would use prog_fd and ifindex to trigger RX (yes, receive)
> in that netdev. XDP prog will execute and will be able to perform
> all actions (not only XDP_REDIRECT).
> XDP_PASS would pass the packet to the stack, etc.

Hmm, that's certainly an interesting idea! I don't think we can actually
run the XDP hook on the netdev itself (since that is deep in the
driver), but we can emulate it: we just need to do what this version of
the patch is doing, but add handling of the other return codes.

XDP_PASS could be supported by basically copying what cpumap is doing
(turn the frames into skbs and call netif_receive_skb_list()), but
XDP_TX would have to be implemented via ndo_xdp_xmit(), so it becomes
equivalent to a REDIRECT back to the same interface. That's probably OK,
though, right?

I'll try this out for the next version, thanks for the idea!

-Toke

