Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43E64D3A7
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 00:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLNXrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 18:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLNXrR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 18:47:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B41D30F70
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671061590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCzldWN/5cZ2JoAWZJugna0y9Vh9nWLOhmVhul+oqOk=;
        b=X4Ts1n/kyW2Mda5MfCQcN0UKo8zJYPv0Ex2KjFso3usbOJ5ERyx5Ggd0Z7ZmqdF5Yv+o3W
        pNFR5mbF8nHWaXEmC6w+hyptlwYE631L4ksnwfZZADxj7RHhIlf6Hndrx7ZEMsMowEYxGp
        p8dc8NyOYAd1DITTJ4zsttxV5LUA310=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-m4oUzhASOJaOTpqWjRyu-Q-1; Wed, 14 Dec 2022 18:46:29 -0500
X-MC-Unique: m4oUzhASOJaOTpqWjRyu-Q-1
Received: by mail-ed1-f72.google.com with SMTP id b16-20020a056402279000b0046fb99731e6so7350204ede.1
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCzldWN/5cZ2JoAWZJugna0y9Vh9nWLOhmVhul+oqOk=;
        b=ufDr8pXyBsJSS/7Tswh+/h1yE5LeQ4rQ6AXbdwl6WudLE/s1x2SI8AjCtLWDPpEAc1
         w2f1KEDB9lRh+Nsfwa8IEwjJbxoIQz8M7+xAFRwnjuiB9I1NVyQVgxJsWWpxJqnlFQ8F
         5ESy2aIx8/8+bwsaSdAC874QkVQoL+pf6/KfoGgitnLrMVbuLn1drxtQ5vQmUtYfyXxX
         E3SPpTYfh+F/4oZOFWauNrgk/Ee0trUfBy4tk9gahEe+c3pRX+KrWH6xB0qIZr1nIZ29
         5LZnUD9VfZ07mlHugzsRblfm4Q+zOhlM5wxcLedGIJ99WaLYqCkwa7mUN95eXZI+4rjb
         eKqw==
X-Gm-Message-State: ANoB5pmQb9zpiiwztYQ+5dD2r+c+wRz2edKCZnh9tZqKxvvMZfQitiEu
        mQzFhqY/fkvF+lEwbbjX31i5iWvHx64NSIzRw+FR7lX4rp95+5ln/O7Etmt12nWBhDsaxJQXKf/
        QUHilauD2G7ki
X-Received: by 2002:aa7:db91:0:b0:461:9075:4161 with SMTP id u17-20020aa7db91000000b0046190754161mr21220480edt.15.1671061585938;
        Wed, 14 Dec 2022 15:46:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7pBlQ2i0qP1De1qzz2UYRP1C/T5yT57y4dH7rQWDDbGIxTpFhIM14u64IWVSzOvPMkZlsnFA==
X-Received: by 2002:aa7:db91:0:b0:461:9075:4161 with SMTP id u17-20020aa7db91000000b0046190754161mr21220454edt.15.1671061585065;
        Wed, 14 Dec 2022 15:46:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dc20-20020a170906c7d400b007c0f90a9cc5sm6407157ejb.105.2022.12.14.15.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:46:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3DD2B82F671; Thu, 15 Dec 2022 00:46:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v4 01/15] bpf: Document XDP RX
 metadata
In-Reply-To: <CAKH8qBuv0pZUT-w3LVKoss6XixdNP9cbZpxe9UWghdpbWDXtgA@mail.gmail.com>
References: <20221213023605.737383-1-sdf@google.com>
 <20221213023605.737383-2-sdf@google.com> <Y5iqTKnhtX2yaSAq@maniforge.lan>
 <CAKH8qBvjwMXvTg3ij=6wk2yu+=oWcRizmKf_YtW_yp5+W2F_=g@mail.gmail.com>
 <87fsdigtow.fsf@toke.dk>
 <CAKH8qBuv0pZUT-w3LVKoss6XixdNP9cbZpxe9UWghdpbWDXtgA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Dec 2022 00:46:23 +0100
Message-ID: <87r0x1eegg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Wed, Dec 14, 2022 at 2:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > On Tue, Dec 13, 2022 at 8:37 AM David Vernet <void@manifault.com> wrot=
e:
>> >>
>> >> On Mon, Dec 12, 2022 at 06:35:51PM -0800, Stanislav Fomichev wrote:
>> >> > Document all current use-cases and assumptions.
>> >> >
>> >> > Cc: John Fastabend <john.fastabend@gmail.com>
>> >> > Cc: David Ahern <dsahern@gmail.com>
>> >> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> >> > Cc: Jakub Kicinski <kuba@kernel.org>
>> >> > Cc: Willem de Bruijn <willemb@google.com>
>> >> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> >> > Cc: Anatoly Burakov <anatoly.burakov@intel.com>
>> >> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
>> >> > Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
>> >> > Cc: Maryam Tahhan <mtahhan@redhat.com>
>> >> > Cc: xdp-hints@xdp-project.net
>> >> > Cc: netdev@vger.kernel.org
>> >> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> >> > ---
>> >> >  Documentation/bpf/xdp-rx-metadata.rst | 90 +++++++++++++++++++++++=
++++
>> >> >  1 file changed, 90 insertions(+)
>> >> >  create mode 100644 Documentation/bpf/xdp-rx-metadata.rst
>> >> >
>> >> > diff --git a/Documentation/bpf/xdp-rx-metadata.rst b/Documentation/=
bpf/xdp-rx-metadata.rst
>> >> > new file mode 100644
>> >> > index 000000000000..498eae718275
>> >> > --- /dev/null
>> >> > +++ b/Documentation/bpf/xdp-rx-metadata.rst
>> >>
>> >> I think you need to add this to Documentation/bpf/index.rst. Or even
>> >> better, maybe it's time to add an xdp/ subdirectory and put all docs
>> >> there? Don't want to block your patchset from bikeshedding on this
>> >> point, so for now it's fine to just put it in
>> >> Documentation/bpf/index.rst until we figure that out.
>> >
>> > Maybe let's put it under Documentation/networking/xdp-rx-metadata.rst
>> > and reference form Documentation/networking/index.rst? Since it's more
>> > relevant to networking than the core bpf?
>> >
>> >> > @@ -0,0 +1,90 @@
>> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > +XDP RX Metadata
>> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > +
>> >> > +XDP programs support creating and passing custom metadata via
>> >> > +``bpf_xdp_adjust_meta``. This metadata can be consumed by the foll=
owing
>> >> > +entities:
>> >>
>> >> Can you add a couple of sentences to this intro section that explains
>> >> what metadata is at a high level?
>> >
>> > I'm gonna copy-paste here what I'm adding, feel free to reply back if
>> > still unclear. (so we don't have to wait another week to discuss the
>> > changes)
>> >
>> > XDP programs support creating and passing custom metadata via
>> > ``bpf_xdp_adjust_meta``. The metadata can contain some extra informati=
on
>> > about the packet: timestamps, hash, vlan and tunneling information, et=
c.
>> > This metadata can be consumed by the following entities:
>>
>> This is not really accurate, though? The metadata area itself can
>> contain whatever the XDP program wants it to, and I think you're
>> conflating the "old" usage for arbitrary storage with the driver-kfunc
>> metadata support.
>>
>> I think we should clear separate the two: the metadata area is just a
>> place to store data (and is not consumed by the stack, except that
>> TC-BPF programs can access it), and the driver kfuncs are just a general
>> way to get data out of the drivers (and has nothing to do with the
>> metadata area, you can just get the data into stack variables).
>>
>> While it would be good to have a documentation of the general metadata
>> area stuff somewhere, I don't think it necessarily have to be part of
>> this series, so maybe just stick to documenting the kfuncs?
>
> Maybe I can reword to something like below?
>
> The metadata can be used to store some extra information about the
> packet timestamps, hash, vlan and tunneling information, etc.
>
> This way we are not actually defining what it is, but hinting about
> how it's commonly used?

Sent another reply to the original patch with some comments that are
hopefully a bit more constructive :)

-Toke

