Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D346264DCAF
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLOOE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 09:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOOE6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 09:04:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827BC108E
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 06:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671113050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofZsEtPN7uRhdLWCDY/UttSnpuZfov13p+90OTHUFwk=;
        b=foiiIYnNEWUL8QMSrLuzMITUcGDWp2znpCFOq+oWuYo3wWnO6GCDstGnRIgC/Ir8jUse+K
        iNgIWHBjhdwhHWQ8ZikuZBstcbK+xI4ClqAsoflw6DOgT+dN0/JEEsKyjsT1NRzWgGJ6Bb
        issvGJVppZLkLEOcvR37Ang3kvTWn8Q=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-50-_hj5tXhEOE60ihA4D7-h3w-1; Thu, 15 Dec 2022 09:04:09 -0500
X-MC-Unique: _hj5tXhEOE60ihA4D7-h3w-1
Received: by mail-lf1-f72.google.com with SMTP id f17-20020ac25091000000b004b565e69540so3935857lfm.12
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 06:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofZsEtPN7uRhdLWCDY/UttSnpuZfov13p+90OTHUFwk=;
        b=YY80h1p9+ll8nQqvKObFM/3A+tpDKRerl8an2Srpn+jSRMYAb3GJtVCzpghjDVJJe1
         YVOULHiaVyK7+ryhk0zRs6m9gdGOi8nWRq61MYz/LHB2dLH3GWxLwPELQkrQc3RbRUTK
         y4wp0lk06VmlddVyCmr01+g7VCXURg9wzVrtRVmvsfUJc3euJqlmcWmo7Z9OJn++bVl8
         5UJkj7TWNoC+L+OKoRpa9QlBuy4DPEZLS6zJWoptptvkNScah0bCSkaHJ1t/pZdaUCvG
         iMQ+0J7F5+9/yZ2oezA+ljRTxCJ0ghXXnxWGIvUS9euxN7syijlkDmx8M3+3uBHHHtCM
         sPvw==
X-Gm-Message-State: ANoB5pnAk9mfZjXCx6puyKrvCImtNABN7YdveFv65nQ8cu8SdfuCwhtR
        OwdAhpRgGPopdA4KRQDMvS3cGPq3W/6pWhLqpE6DzxuWRvHhul5HA6KCBn8flZVJA4B6pHm18AS
        TOHYpB79WDT6A
X-Received: by 2002:a05:651c:1951:b0:27b:5819:49b with SMTP id bs17-20020a05651c195100b0027b5819049bmr4804715ljb.5.1671113047100;
        Thu, 15 Dec 2022 06:04:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5yzbZM0O7TllBtP6CdWAhfDF+rriwVUSsIgk4pb+v/KKB5aSC5IRaLZr9Rq52cdszz03wRdw==
X-Received: by 2002:a05:651c:1951:b0:27b:5819:49b with SMTP id bs17-20020a05651c195100b0027b5819049bmr4804587ljb.5.1671113046019;
        Thu, 15 Dec 2022 06:04:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906311100b0073d81b0882asm7187325ejx.7.2022.12.15.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:04:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BF25D82F7DB; Thu, 15 Dec 2022 15:04:04 +0100 (CET)
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
In-Reply-To: <CAKH8qBuCwxiCPLmH9xzfG+C39GUEHFcC4h45DLZVJ9V1bsJnRA@mail.gmail.com>
References: <20221213023605.737383-1-sdf@google.com>
 <20221213023605.737383-2-sdf@google.com> <Y5iqTKnhtX2yaSAq@maniforge.lan>
 <CAKH8qBvjwMXvTg3ij=6wk2yu+=oWcRizmKf_YtW_yp5+W2F_=g@mail.gmail.com>
 <87fsdigtow.fsf@toke.dk>
 <CAKH8qBuv0pZUT-w3LVKoss6XixdNP9cbZpxe9UWghdpbWDXtgA@mail.gmail.com>
 <87r0x1eegg.fsf@toke.dk>
 <CAKH8qBuCwxiCPLmH9xzfG+C39GUEHFcC4h45DLZVJ9V1bsJnRA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Dec 2022 15:04:04 +0100
Message-ID: <87cz8kepbf.fsf@toke.dk>
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

> On Wed, Dec 14, 2022 at 3:46 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > On Wed, Dec 14, 2022 at 2:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>> >>
>> >> Stanislav Fomichev <sdf@google.com> writes:
>> >>
>> >> > On Tue, Dec 13, 2022 at 8:37 AM David Vernet <void@manifault.com> w=
rote:
>> >> >>
>> >> >> On Mon, Dec 12, 2022 at 06:35:51PM -0800, Stanislav Fomichev wrote:
>> >> >> > Document all current use-cases and assumptions.
>> >> >> >
>> >> >> > Cc: John Fastabend <john.fastabend@gmail.com>
>> >> >> > Cc: David Ahern <dsahern@gmail.com>
>> >> >> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> >> >> > Cc: Jakub Kicinski <kuba@kernel.org>
>> >> >> > Cc: Willem de Bruijn <willemb@google.com>
>> >> >> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> >> >> > Cc: Anatoly Burakov <anatoly.burakov@intel.com>
>> >> >> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
>> >> >> > Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
>> >> >> > Cc: Maryam Tahhan <mtahhan@redhat.com>
>> >> >> > Cc: xdp-hints@xdp-project.net
>> >> >> > Cc: netdev@vger.kernel.org
>> >> >> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> >> >> > ---
>> >> >> >  Documentation/bpf/xdp-rx-metadata.rst | 90 ++++++++++++++++++++=
+++++++
>> >> >> >  1 file changed, 90 insertions(+)
>> >> >> >  create mode 100644 Documentation/bpf/xdp-rx-metadata.rst
>> >> >> >
>> >> >> > diff --git a/Documentation/bpf/xdp-rx-metadata.rst b/Documentati=
on/bpf/xdp-rx-metadata.rst
>> >> >> > new file mode 100644
>> >> >> > index 000000000000..498eae718275
>> >> >> > --- /dev/null
>> >> >> > +++ b/Documentation/bpf/xdp-rx-metadata.rst
>> >> >>
>> >> >> I think you need to add this to Documentation/bpf/index.rst. Or ev=
en
>> >> >> better, maybe it's time to add an xdp/ subdirectory and put all do=
cs
>> >> >> there? Don't want to block your patchset from bikeshedding on this
>> >> >> point, so for now it's fine to just put it in
>> >> >> Documentation/bpf/index.rst until we figure that out.
>> >> >
>> >> > Maybe let's put it under Documentation/networking/xdp-rx-metadata.r=
st
>> >> > and reference form Documentation/networking/index.rst? Since it's m=
ore
>> >> > relevant to networking than the core bpf?
>> >> >
>> >> >> > @@ -0,0 +1,90 @@
>> >> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >> > +XDP RX Metadata
>> >> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >> > +
>> >> >> > +XDP programs support creating and passing custom metadata via
>> >> >> > +``bpf_xdp_adjust_meta``. This metadata can be consumed by the f=
ollowing
>> >> >> > +entities:
>> >> >>
>> >> >> Can you add a couple of sentences to this intro section that expla=
ins
>> >> >> what metadata is at a high level?
>> >> >
>> >> > I'm gonna copy-paste here what I'm adding, feel free to reply back =
if
>> >> > still unclear. (so we don't have to wait another week to discuss the
>> >> > changes)
>> >> >
>> >> > XDP programs support creating and passing custom metadata via
>> >> > ``bpf_xdp_adjust_meta``. The metadata can contain some extra inform=
ation
>> >> > about the packet: timestamps, hash, vlan and tunneling information,=
 etc.
>> >> > This metadata can be consumed by the following entities:
>> >>
>> >> This is not really accurate, though? The metadata area itself can
>> >> contain whatever the XDP program wants it to, and I think you're
>> >> conflating the "old" usage for arbitrary storage with the driver-kfunc
>> >> metadata support.
>> >>
>> >> I think we should clear separate the two: the metadata area is just a
>> >> place to store data (and is not consumed by the stack, except that
>> >> TC-BPF programs can access it), and the driver kfuncs are just a gene=
ral
>> >> way to get data out of the drivers (and has nothing to do with the
>> >> metadata area, you can just get the data into stack variables).
>> >>
>> >> While it would be good to have a documentation of the general metadata
>> >> area stuff somewhere, I don't think it necessarily have to be part of
>> >> this series, so maybe just stick to documenting the kfuncs?
>> >
>> > Maybe I can reword to something like below?
>> >
>> > The metadata can be used to store some extra information about the
>> > packet timestamps, hash, vlan and tunneling information, etc.
>> >
>> > This way we are not actually defining what it is, but hinting about
>> > how it's commonly used?
>>
>> Sent another reply to the original patch with some comments that are
>> hopefully a bit more constructive :)
>
> Thanks, everything makes sense, will incorporate. I'll also try to
> share the patches privately with you sometime tomorrow maybe; not
> super comfortable sending them out with a bunch of changes on top of
> your authorship without some kind of ack from you :-)

OK, sounds good. Tomorrow (Friday) is my last day before the holidays,
but happy to look things over before I sign off :)

-Toke

