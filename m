Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED6647AA3
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 01:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLIAPy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 19:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLIAPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 19:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBC582F9A
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 16:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670544859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4T5sBCl/3CDxr25zUnGc9p87c5wEBV2/DlcV/PFZ2Ac=;
        b=fUQIHnEcx3UZOSATLKBQ6LL17MMhV7wZ7TR9w5h4RheIjKYMkaInRSRdlXuLLwLNCsjkyx
        ulLlHDAxwrMdal5rOhDSRVHv5Y49/voKbVVZz8EJ8NwLRuaIuk+eZLG15lBPboCzfH/efG
        b4aLux+otqbqd5C2YKrlGhnK/EAYCH4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-356-GFArlXYLOV2lYTwJm3eU4Q-1; Thu, 08 Dec 2022 19:14:18 -0500
X-MC-Unique: GFArlXYLOV2lYTwJm3eU4Q-1
Received: by mail-ed1-f70.google.com with SMTP id z16-20020a05640235d000b0046d0912ae25so414084edc.5
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 16:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T5sBCl/3CDxr25zUnGc9p87c5wEBV2/DlcV/PFZ2Ac=;
        b=b/75bFAscNt1fdkULSUiBryxZmBlvdWpwsN+Fu6vjePn4P+K0RKFaBUJoIlljOWZ2V
         DtaR0k0UeB+Z103GqJyoMBI5TB7Ryg9liHD0KOnsB8RbmxueUbF6StSiccYQ3IF/+mpN
         PM6lWgg4VTl8WUb/W8IYkFuF+beR6p7GBmS05dX8CYJ+arQMv/ybcgpKuP5di+x3znYc
         WcoHUwhvb1BI/SM9PCot5pvGZSMdnRGS/uziYFT7ZFDPgE2zPZvK55SVCpfxPfAk6vHG
         1ZmPXQxMmpzDDEu2yJT5ZR28nRf90GApIozmFZuuH0EIqexqUmKrgn+rixUxYFpQs0Gv
         sc8A==
X-Gm-Message-State: ANoB5pnxDole0Ds0aNHFvRuQl5Qu8tBZuYkCXKV83MzdyiD2+cAfwpSs
        +WBWuD/SVkrvOv1FOo2ja3BR9VvcjLIW9RkCftksq0BNQ2OJ9aAb6HSUAIwmEcd+oj0r5xkNJ6W
        bWf8pvg0zspRT
X-Received: by 2002:a05:6402:3985:b0:461:3ae6:8bfc with SMTP id fk5-20020a056402398500b004613ae68bfcmr3791861edb.34.1670544856450;
        Thu, 08 Dec 2022 16:14:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4pGscj4T39ekLdKdM3k2JNhFGEY2EQzfwP35Z/evcQY53JRadCWkl1oFCQPRUO4A24tOytvg==
X-Received: by 2002:a05:6402:3985:b0:461:3ae6:8bfc with SMTP id fk5-20020a056402398500b004613ae68bfcmr3791804edb.34.1670544854791;
        Thu, 08 Dec 2022 16:14:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u26-20020a05640207da00b0046bc2f432dasm20515edy.22.2022.12.08.16.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:14:14 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B62382E9C9; Fri,  9 Dec 2022 01:14:13 +0100 (CET)
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
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 00/12] xdp: hints via kfuncs
In-Reply-To: <CAKH8qBuzpiXrL5SOxd1u0-zim+Kf166DRUDT0PuR081f-ad2-Q@mail.gmail.com>
References: <20221206024554.3826186-1-sdf@google.com>
 <87bkodleca.fsf@toke.dk>
 <CAKH8qBuzpiXrL5SOxd1u0-zim+Kf166DRUDT0PuR081f-ad2-Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 09 Dec 2022 01:14:13 +0100
Message-ID: <87wn71juwa.fsf@toke.dk>
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

> On Thu, Dec 8, 2022 at 2:29 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > Please see the first patch in the series for the overall
>> > design and use-cases.
>> >
>> > Changes since v3:
>> >
>> > - Rework prog->bound_netdev refcounting (Jakub/Marin)
>> >
>> >   Now it's based on the offload.c framework. It mostly fits, except
>> >   I had to automatically insert a HT entry for the netdev. In the
>> >   offloaded case, the netdev is added via a call to
>> >   bpf_offload_dev_netdev_register from the driver init path; with
>> >   a dev-bound programs, we have to manually add (and remove) the entry.
>> >
>> >   As suggested by Toke, I'm also prohibiting putting dev-bound programs
>> >   into prog-array map; essentially prohibiting tail calling into it.
>> >   I'm also disabling freplace of the dev-bound programs. Both of those
>> >   restrictions can be loosened up eventually.
>>
>> I thought it would be a shame that we don't support at least freplace
>> programs from the get-go (as that would exclude libxdp from taking
>> advantage of this). So see below for a patch implementing this :)
>>
>> -Toke
>
> Damn, now I need to write a selftest :-)
> But seriously, thank you for taking care of this, will try to include
> preserving SoB!

Cool, thanks! I just realised I made on mistake in the attach check,
though:

[...]

>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index b345a273f7d0..606e6de5f716 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3021,6 +3021,14 @@ static int bpf_tracing_prog_attach(struct bpf_pro=
g *prog,
>>                         goto out_put_prog;
>>                 }
>>
>> +               if (bpf_prog_is_dev_bound(tgt_prog->aux) &&
>> +                   (bpf_prog_is_offloaded(tgt_prog->aux) ||
>> +                    !bpf_prog_is_dev_bound(prog->aux) ||
>> +                    !bpf_offload_dev_match(prog, tgt_prog->aux->offload=
->netdev))) {

This should switch the order of the is_dev_bound() checks, like:

+               if (bpf_prog_is_dev_bound(prog->aux) &&
+                   (bpf_prog_is_offloaded(tgt_prog->aux) ||
+                    !bpf_prog_is_dev_bound(tgt_prog->aux) ||
+                    !bpf_offload_dev_match(prog, tgt_prog->aux->offload->n=
etdev))) {

I.e., first check bpf_prog_is_dev_bound(prog->aux) (the program being
attached), and only perform the other checks if we're attaching
something that has been verified as being dev-bound. It should be fine
to attach a non-devbound function to a devbound parent program (since
that non-devbound function can't call any of the kfuncs).

-Toke

