Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCAE62AE61
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKOWcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiKOWcU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23276EC
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668551484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJmNXPp6LKbLV1/7iK18cP0hnwLnprb5IV7cNfNC70k=;
        b=H2mE83X3H50LK1AAnmZitpF7B1/J9OngzWbrk82lxgQ/aED4QtHszdKkG7lVMtfk935GyR
        a6RD90ERWmdzlAJ0AG3J617LGkDlTpkdeHxPsscWZwCv3Ae2wNqBAfr7uVr9xVTCQUGoFV
        7DlfgOd53LUdnVKiy9Tyq716evKA/zc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-JNtotkE2NbSgChyY6n1GIA-1; Tue, 15 Nov 2022 17:31:22 -0500
X-MC-Unique: JNtotkE2NbSgChyY6n1GIA-1
Received: by mail-ej1-f72.google.com with SMTP id ne36-20020a1709077ba400b007aeaf3dcbcaso7694438ejc.6
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJmNXPp6LKbLV1/7iK18cP0hnwLnprb5IV7cNfNC70k=;
        b=EBS2456Zci5ZtWSoBtHXskg2y26RjQzlXQbDeiNxi75mka2LQ/6D+24HpAyp+KLBGV
         CZLsubSfjt0kJDI7lEkEznPmILN7DUaaeeCO3LNHFi+BGiGnx9RQgqPMWwyFriVGd0IQ
         1C+JVw39tniw3CkSVoTjJG4g43oQBMt/W5l4UrqzhfGXY6HBJ8LEW8CaIybkTgyLc+vS
         Wa3XSSPBc+GmS4shsRacOLLbext8v/Kd5FNDxeHdyXuAv78+s4gKayzz2OFwzH40mDie
         7OzoTCkKtrT3EYGAxtKFk3nsU6eVPb80p53gcCgaQGe08NzRKPnsw2VGIgl7IJHk9wtk
         j6DA==
X-Gm-Message-State: ANoB5pnKy7CXzRpjPDmfqwJ4CKwzKFfp0shBlfSjjpIdhpEabbYFfczE
        P7IBMEXjw5c02EsvdhoAswtCVarXRXVVEI93jIinnZnsV+Dbw6GpFSfkezX4nfJMDArvZHsYwrF
        w2i3VOc32v3eW
X-Received: by 2002:a17:906:8385:b0:7ad:8035:ae3d with SMTP id p5-20020a170906838500b007ad8035ae3dmr15568071ejx.46.1668551480923;
        Tue, 15 Nov 2022 14:31:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5cKn9LxWnWYRHp2/avkxz4II6DYsHD6dVz4O0FXSxYE6XoeL8CyodjK/ugPYHIHG0uyPAzUg==
X-Received: by 2002:a17:906:8385:b0:7ad:8035:ae3d with SMTP id p5-20020a170906838500b007ad8035ae3dmr15567998ejx.46.1668551479511;
        Tue, 15 Nov 2022 14:31:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906315400b0077b2b0563f4sm6123623eje.173.2022.11.15.14.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:31:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 96E997A6D4B; Tue, 15 Nov 2022 23:31:17 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next 00/11] xdp: hints via kfuncs
In-Reply-To: <CAKH8qBszV6Ni_k8JYOxtAQ2j79qe5KVryAzDqtb1Ng8+TW=+7A@mail.gmail.com>
References: <20221115030210.3159213-1-sdf@google.com>
 <87mt8si56i.fsf@toke.dk>
 <CAKH8qBszV6Ni_k8JYOxtAQ2j79qe5KVryAzDqtb1Ng8+TW=+7A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 15 Nov 2022 23:31:17 +0100
Message-ID: <875yffetoq.fsf@toke.dk>
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

> On Tue, Nov 15, 2022 at 7:54 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > - drop __randomize_layout
>> >
>> >   Not sure it's possible to sanely expose it via UAPI. Because every
>> >   .o potentially gets its own randomized layout, test_progs
>> >   refuses to link.
>>
>> So this won't work if the struct is in a kernel-supplied UAPI header
>> (which would include the __randomize_layout tag). But if it's *not* in a
>> UAPI header it should still be included in a stable form (i.e., without
>> the randomize tag) in vmlinux.h, right? Which would be the point:
>> consumers would be forced to read it from there and do CO-RE on it...
>
> So you're suggesting something like the following in the uapi header?
>
> #ifndef __KERNEL__
> #define __randomize_layout
> #endif
>
> ?

I actually just meant "don't put struct xdp_metadata in an UAPI header
file at all". However, I can see how that complicates having the
skb_metadata pointer in struct xdp_md, so if the above works, that's
fine with me as well :)

> Let me try to add some padding arguments to xdp_skb_metadata plus the
> above to see how it goes.

Cool!

-Toke

