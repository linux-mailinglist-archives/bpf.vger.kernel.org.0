Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72884731B9
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 17:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhLMQ07 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 11:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240756AbhLMQ0z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 11:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639412814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xStP3+7Ro9V0luE32DgT7Hp9RicdgEwCYJfQCO89zJk=;
        b=Do+5MZ0zEmpcyjanH56o2r86hOmbsteueT64iRzxbXA06Ev32CKyE982XFCSeWZYV2gONA
        0lP9PRhg/oH91ONcUx55PwALEqViZyoSHxkQhiGqxZ5ZpROiRtxdzHdUJLxOVBdgFtzS73
        q+dxd4lCQSwP8k2M/Ig99q+5Z2o8FbI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-_zO5NAJNOlCrWE4gn_yfHQ-1; Mon, 13 Dec 2021 11:26:53 -0500
X-MC-Unique: _zO5NAJNOlCrWE4gn_yfHQ-1
Received: by mail-ed1-f69.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so14363008eds.23
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 08:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xStP3+7Ro9V0luE32DgT7Hp9RicdgEwCYJfQCO89zJk=;
        b=FW45SGaVofK2Jo/anfJJfQEfJVbhBGhKmrKXLvPW0BIOZkYSIxfyQpXFyfB3e6xpL7
         SWgf1j4P28eDwLHokn5HOYqWNjk9Q0OZhG83YGLAiQssyGhIX/4ofFeQZI/BWzwR7U1s
         //YEJjOC7c2YGxHMAEsALDt2Re1gQYYKuTSh6WmEGXFs9cs5JxigD6+VLGhl0aAFLQ9o
         1H7/bLkIEhRDQfiLQhP94yxmtTOxXU9IYTTVX9/4OFaL3lD4ZJ9V0B1TFV4XHumzBBz8
         nNJdNAyvkvmZrLCkL7VbDTPxo7bsl9FZB9ev+eUTSov1Qoz2ce+YA9z/Fiokw5DARPt9
         A3hg==
X-Gm-Message-State: AOAM5321J5J/MIV3QkTKZ4uLOEg4y9vZ/wGoFwk7CM/BrINUNJsR1boi
        1MqpbjS/dAJ7aQZ6Mp75ke50L6B0YAl3Nn6VvBRcH08qQwoa900VEe0ryvolMeIRe4Xdtke/tAX
        RX5rmYBChjh/w
X-Received: by 2002:a17:907:160c:: with SMTP id hb12mr44802246ejc.460.1639412811995;
        Mon, 13 Dec 2021 08:26:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqepGzhbcfvTvErYJ74zZ/4uLaabIGMemsbkGr36u0LTcJroOlW5D/IdsKyygsqQTSDTYOTw==
X-Received: by 2002:a17:907:160c:: with SMTP id hb12mr44802199ejc.460.1639412811649;
        Mon, 13 Dec 2021 08:26:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t5sm6662646edd.68.2021.12.13.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:26:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 716CF183553; Mon, 13 Dec 2021 17:26:50 +0100 (CET)
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
In-Reply-To: <CAADnVQJYfyHs41H1x-1wR5WVSX+3ju69XMUQ4id5+1DLkTVDkg@mail.gmail.com>
References: <20211211184143.142003-1-toke@redhat.com>
 <20211211184143.142003-7-toke@redhat.com>
 <CAADnVQJYfyHs41H1x-1wR5WVSX+3ju69XMUQ4id5+1DLkTVDkg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 13 Dec 2021 17:26:50 +0100
Message-ID: <87tufceaid.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Dec 11, 2021 at 10:43 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> +
>> +static void bpf_test_run_xdp_teardown(struct bpf_test_timer *t)
>> +{
>> +       struct xdp_mem_info mem =3D {
>> +               .id =3D t->xdp.pp->xdp_mem_id,
>> +               .type =3D MEM_TYPE_PAGE_POOL,
>> +       };
>
> pls add a new line.
>
>> +       xdp_unreg_mem_model(&mem);
>> +}
>> +
>> +static bool ctx_was_changed(struct xdp_page_head *head)
>> +{
>> +       return (head->orig_ctx.data !=3D head->ctx.data ||
>> +               head->orig_ctx.data_meta !=3D head->ctx.data_meta ||
>> +               head->orig_ctx.data_end !=3D head->ctx.data_end);
>
> redundant ()
>
>>         bpf_test_timer_enter(&t);
>>         old_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>>         do {
>>                 run_ctx.prog_item =3D &item;
>> -               if (xdp)
>> +               if (xdp && xdp_redirect) {
>> +                       ret =3D bpf_test_run_xdp_redirect(&t, prog, ctx);
>> +                       if (unlikely(ret < 0))
>> +                               break;
>> +                       *retval =3D ret;
>> +               } else if (xdp) {
>>                         *retval =3D bpf_prog_run_xdp(prog, ctx);
>
> Can we do this unconditionally without introducing a new uapi flag?
> I mean "return bpf_redirect()" was a nop under test_run.
> What kind of tests might break if it stops being a nop?

Well, I view the existing mode of bpf_prog_test_run() with XDP as a way
to write XDP unit tests: it allows you to submit a packet, run your XDP
program on it, and check that it returned the right value and did the
right modifications. This means if you XDP program does 'return
bpf_redirect()', userspace will still get the XDP_REDIRECT value and so
it can check correctness of your XDP program.

With this flag the behaviour changes quite drastically, in that it will
actually put packets on the wire instead of getting back the program
return. So I think it makes more sense to make it a separate opt-in
mode; the old behaviour can still be useful for checking XDP program
behaviour.

-Toke

