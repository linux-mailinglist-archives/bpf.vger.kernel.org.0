Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C546ED9F
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 17:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbhLIQze (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 11:55:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234550AbhLIQze (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 11:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639068720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QG01/RJqDDEw9ymjpQGPzqtzIKmpfXP+DB/cbpZfIiQ=;
        b=IL8KDpoJW9tdSLVpGTF6tmrCGOrji9fclHBum83gtX/9SJ2HIXHsWblZvzykzwVVEQnDD+
        B1OLvbahDZoo3Zvi2Q6js1hBe9g6KTlq9WrHtf7jWOhPDLYjreQjyUHLfns7sQxe4Rki+L
        HhfR+sgWCJXymTLgsn7SOSHJSt7ZrEk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-uk5-1wsiP4yar18v3IKt0w-1; Thu, 09 Dec 2021 11:51:59 -0500
X-MC-Unique: uk5-1wsiP4yar18v3IKt0w-1
Received: by mail-ed1-f70.google.com with SMTP id c1-20020aa7c741000000b003e7bf1da4bcso5722788eds.21
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 08:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QG01/RJqDDEw9ymjpQGPzqtzIKmpfXP+DB/cbpZfIiQ=;
        b=66tYDLrTF31qwtT0XAAPSdz2r6IC1WL5kXG6FgUbwJfxDqpYUFksmA2p7KXf+bk6xx
         zDbxPVPnTPqiCzyMpUkzSrBjocSjc7VC7rFqJQmCp2iIxkO0B8p2gnV4nTvDJJpqXHKv
         dQk8NKBEslN4dwiX0pUPAtF77a5Rcp5PGBwYKD94a9A/CC1EpDXuuEMddsENaGIjlHZZ
         vebaI6eMTcNvchlRgtoN5Y4E+O9vzUfVzJCi+7AfI8Hmtcs0EN0/IwqXlqiXF69wCzvq
         DGmvIhlAiuQh17YQFnQ+P+QdYZIWUiGP32S1Ofq5ESw2qOL+CHsEWzTNjPay74jdIZjX
         UCYg==
X-Gm-Message-State: AOAM533XfYjcfsjx/GmD3rHhlLYu9KW5b7KgqCF2wv6NL44TRW4YNr0E
        HyinQ5Nu/sB+4zaxGeg+pDMit6v6XvgEEpPhS5N47QOuSfi0RJlFyTXyrW4FobFVEK0fkqUZAv/
        m2um0C0FbQDCX
X-Received: by 2002:a17:907:d9f:: with SMTP id go31mr17437666ejc.412.1639068717594;
        Thu, 09 Dec 2021 08:51:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyh4kBjnbjbSprM3EBc3G6vs8Ux0b8jcgJz8EAUmI0eekyzp2C4MncuX++F6fLeLqG/dU9EWg==
X-Received: by 2002:a17:907:d9f:: with SMTP id go31mr17437626ejc.412.1639068717204;
        Thu, 09 Dec 2021 08:51:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e4sm212730ejs.13.2021.12.09.08.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:51:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CEB08180471; Thu,  9 Dec 2021 17:51:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: RE: [PATCH bpf-next 6/8] bpf: Add XDP_REDIRECT support to XDP for
 bpf_prog_run()
In-Reply-To: <87tufhwygr.fsf@toke.dk>
References: <20211202000232.380824-1-toke@redhat.com>
 <20211202000232.380824-7-toke@redhat.com>
 <61b1537634e07_979572086f@john.notmuch> <87tufhwygr.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 09 Dec 2021 17:51:55 +0100
Message-ID: <87r1alwwk4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> John Fastabend <john.fastabend@gmail.com> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> This adds support for doing real redirects when an XDP program returns
>>> XDP_REDIRECT in bpf_prog_run(). To achieve this, we create a page pool
>>> instance while setting up the test run, and feed pages from that into t=
he
>>> XDP program. The setup cost of this is amortised over the number of
>>> repetitions specified by userspace.
>>>=20
>>> To support performance testing use case, we further optimise the setup =
step
>>> so that all pages in the pool are pre-initialised with the packet data,=
 and
>>> pre-computed context and xdp_frame objects stored at the start of each
>>> page. This makes it possible to entirely avoid touching the page conten=
t on
>>> each XDP program invocation, and enables sending up to 11.5 Mpps/core o=
n my
>>> test box.
>>>=20
>>> Because the data pages are recycled by the page pool, and the test runn=
er
>>> doesn't re-initialise them for each run, subsequent invocations of the =
XDP
>>> program will see the packet data in the state it was after the last tim=
e it
>>> ran on that particular page. This means that an XDP program that modifi=
es
>>> the packet before redirecting it has to be careful about which assumpti=
ons
>>> it makes about the packet content, but that is only an issue for the mo=
st
>>> naively written programs.
>>>=20
>>> Previous uses of bpf_prog_run() for XDP returned the modified packet da=
ta
>>> and return code to userspace, which is a different semantic then this n=
ew
>>> redirect mode. For this reason, the caller has to set the new
>>> BPF_F_TEST_XDP_DO_REDIRECT flag when calling bpf_prog_run() to opt in to
>>> the different semantics. Enabling this flag is only allowed if not sett=
ing
>>> ctx_out and data_out in the test specification, since it means frames w=
ill
>>> be redirected somewhere else, so they can't be returned.
>>>=20
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> ---
>>
>> [...]
>>
>>> +static int bpf_test_run_xdp_redirect(struct bpf_test_timer *t,
>>> +				     struct bpf_prog *prog, struct xdp_buff *orig_ctx)
>>> +{
>>> +	void *data, *data_end, *data_meta;
>>> +	struct xdp_frame *frm;
>>> +	struct xdp_buff *ctx;
>>> +	struct page *page;
>>> +	int ret, err =3D 0;
>>> +
>>> +	page =3D page_pool_dev_alloc_pages(t->xdp.pp);
>>> +	if (!page)
>>> +		return -ENOMEM;
>>> +
>>> +	ctx =3D ctx_from_page(page);
>>> +	data =3D ctx->data;
>>> +	data_meta =3D ctx->data_meta;
>>> +	data_end =3D ctx->data_end;
>>> +
>>> +	ret =3D bpf_prog_run_xdp(prog, ctx);
>>> +	if (ret =3D=3D XDP_REDIRECT) {
>>> +		frm =3D (struct xdp_frame *)(ctx + 1);
>>> +		/* if program changed pkt bounds we need to update the xdp_frame */
>>
>> Because this reuses the frame repeatedly is there any issue with also
>> updating the ctx each time? Perhaps if the prog keeps shrinking
>> the pkt it might wind up with 0 len pkt? Just wanted to ask.
>
> Sure, it could. But the data buffer comes from userspace anyway, and
> there's nothing preventing userspace from passing a 0-length packet
> anyway, so I just mentally put this in the "don't do that, then" bucket :)
>
> At least I don't *think* there's actually any problem with this that we
> don't have already? A regular XDP program can also shrink an incoming
> packet to zero, then redirect it, no?

Another thought is that we could of course do the opposite here: instead
of updating the xdp_frame when the program resizes the packet, just
reset the pointers so that the next invocation will get the original
size again? The data would still be changed, but maybe that behaviour is
less surprising? WDYT?

-Toke

