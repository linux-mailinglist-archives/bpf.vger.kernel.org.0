Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE8614B2B
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 13:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKAMyE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 08:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKAMyC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 08:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657B1B7B1
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667307181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAuqpjNSQDmHK4eVVdNvYAUpPeJmn3ZvCnWYn2SThKI=;
        b=Pqo/z48TiwyIhkuEQD6Sdj6bmjEYpvG64dZs/NIkwqI67wVyR0UeCrp5JFZh2aTesXYXGM
        fsOmXOWbTSayjRCWSkVgbqaT5Ayx/P5YF1SrPYu2EIS22r43XmRVdwrpJAjOEbIyeB2Y7j
        CEuFJLf3Oi6o2SUvotKnL7Kbu5/ONcQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-QkXfZjqTOo-O4GwcOC-c7Q-1; Tue, 01 Nov 2022 08:53:00 -0400
X-MC-Unique: QkXfZjqTOo-O4GwcOC-c7Q-1
Received: by mail-ej1-f71.google.com with SMTP id oz34-20020a1709077da200b007adc8d68e90so3559758ejc.11
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 05:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAuqpjNSQDmHK4eVVdNvYAUpPeJmn3ZvCnWYn2SThKI=;
        b=csoizQSqmzoqVmMciYx86p9NJ/TeSGQsYXM8PPKMKWIePBzV+apBP81EzLeUyWca//
         2tOvoPT1IkpqMWwqIWgd/iQ9XnZP0GDaHmJaQCo0G7qE486aiSIC7DNAtsHbo+3J9zKM
         qfHu+7XJ9hdUyTcwi5YoWhj3y87uZbtzc1LXetq4Wmt+Esm7B19PTXKlKAbywb3ockNW
         zSFN+kO+tXJjTt4+tmnSkRY+WdBIQ8MryTvubo09WSHXk0AOjoFkObYn9KfT4W842y6F
         2V5sMB+e433C9PUkRMtqQeGwE9bs9gBvXRFfeF2y5JjB0qN6pSZw3Nw7cEuTPa9sBT5/
         yzzg==
X-Gm-Message-State: ACrzQf20X8tKOMy3eNs+AT5YHzCV/aIEEHX0GdYHKOrIJwCdnJpZpVYu
        01Zs3jNlxHzxNKB1jorQdYoGWQ/q6JfKurNsNYMjgYLKuP7AEJ2tNzTDXm2sygnMR1gLmkukV0h
        7zudmWlcNEUPY
X-Received: by 2002:aa7:da9a:0:b0:461:eea0:514c with SMTP id q26-20020aa7da9a000000b00461eea0514cmr117468eds.296.1667307178203;
        Tue, 01 Nov 2022 05:52:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4kxppzdaXroY6AxpsBc+e2cRbM2r7liAB8w9BfrQkNb5NS0h4fF4vLsR1YZY54iS1hSxYWnA==
X-Received: by 2002:aa7:da9a:0:b0:461:eea0:514c with SMTP id q26-20020aa7da9a000000b00461eea0514cmr117458eds.296.1667307176361;
        Tue, 01 Nov 2022 05:52:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b007a1d4944d45sm4208809ejh.142.2022.11.01.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:52:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 53F3C723703; Tue,  1 Nov 2022 13:52:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "alexandr.lobakin@intel.com" <alexandr.lobakin@intel.com>,
        "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
        "song@kernel.org" <song@kernel.org>,
        "Deric, Nemanja" <nemanja.deric@siemens.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "magnus.karlsson@gmail.com" <magnus.karlsson@gmail.com>,
        "willemb@google.com" <willemb@google.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "brouer@redhat.com" <brouer@redhat.com>, "yhs@fb.com" <yhs@fb.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "mtahhan@redhat.com" <mtahhan@redhat.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>
Subject: Re: [xdp-hints] Re: [RFC bpf-next 0/5] xdp: hints via kfuncs
In-Reply-To: <CAKH8qBsGB1G60cu91Au816gsB2zF8T0P-yDwxbTEOxX0TN3WgA@mail.gmail.com>
References: <20221027200019.4106375-1-sdf@google.com>
 <635bfc1a7c351_256e2082f@john.notmuch>
 <20221028110457.0ba53d8b@kernel.org>
 <CAKH8qBshi5dkhqySXA-Rg66sfX0-eTtVYz1ymHfBxSE=Mt2duA@mail.gmail.com>
 <635c62c12652d_b1ba208d0@john.notmuch>
 <20221028181431.05173968@kernel.org>
 <5aeda7f6bb26b20cb74ef21ae9c28ac91d57fae6.camel@siemens.com>
 <875yg057x1.fsf@toke.dk>
 <CAKH8qBvQbgE=oSZoH4xiLJmqMSXApH-ufd-qEKGKD8=POfhrWQ@mail.gmail.com>
 <77b115a0-bbba-48eb-89bd-3078b5fb7eeb@linux.dev>
 <CAKH8qBsGB1G60cu91Au816gsB2zF8T0P-yDwxbTEOxX0TN3WgA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Nov 2022 13:52:55 +0100
Message-ID: <87wn8e4z14.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Mon, Oct 31, 2022 at 3:57 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/31/22 10:00 AM, Stanislav Fomichev wrote:
>> >> 2. AF_XDP programs won't be able to access the metadata without using a
>> >> custom XDP program that calls the kfuncs and puts the data into the
>> >> metadata area. We could solve this with some code in libxdp, though; if
>> >> this code can be made generic enough (so it just dumps the available
>> >> metadata functions from the running kernel at load time), it may be
>> >> possible to make it generic enough that it will be forward-compatible
>> >> with new versions of the kernel that add new fields, which should
>> >> alleviate Florian's concern about keeping things in sync.
>> >
>> > Good point. I had to convert to a custom program to use the kfuncs :-(
>> > But your suggestion sounds good; maybe libxdp can accept some extra
>> > info about at which offset the user would like to place the metadata
>> > and the library can generate the required bytecode?
>> >
>> >> 3. It will make it harder to consume the metadata when building SKBs. I
>> >> think the CPUMAP and veth use cases are also quite important, and that
>> >> we want metadata to be available for building SKBs in this path. Maybe
>> >> this can be resolved by having a convenient kfunc for this that can be
>> >> used for programs doing such redirects. E.g., you could just call
>> >> xdp_copy_metadata_for_skb() before doing the bpf_redirect, and that
>> >> would recursively expand into all the kfunc calls needed to extract the
>> >> metadata supported by the SKB path?
>> >
>> > So this xdp_copy_metadata_for_skb will create a metadata layout that
>>
>> Can the xdp_copy_metadata_for_skb be written as a bpf prog itself?
>> Not sure where is the best point to specify this prog though.  Somehow during
>> bpf_xdp_redirect_map?
>> or this prog belongs to the target cpumap and the xdp prog redirecting to this
>> cpumap has to write the meta layout in a way that the cpumap is expecting?
>
> We're probably interested in triggering it from the places where xdp
> frames can eventually be converted into skbs?
> So for plain 'return XDP_PASS' and things like bpf_redirect/etc? (IOW,
> anything that's not XDP_DROP / AF_XDP redirect).
> We can probably make it magically work, and can generate
> kernel-digestible metadata whenever data == data_meta, but the
> question - should we?
> (need to make sure we won't regress any existing cases that are not
> relying on the metadata)

So I was thinking about whether we could have the kernel do this
automatically, and concluded that this was probably not feasible in
general, which is why I suggested the explicit helper. My reasoning was
as follows:

For straight XDP_PASS in the driver we don't actually need to do
anything today, as the driver itself will build the SKB and read any
metadata it needs from the HW descriptor[0].

This leaves packets that are redirected (either to a veth or a cpumap so
we build SKBs from them later); here the problem is that we buffer the
packets (for performance reasons) so that the redirect doesn't actually
happen until after the driver exits the NAPI loop. At which point we
don't have access to the HW descriptors anymore, so we can't actually
read the metadata.

This means that if we want to execute the metadata gathering
automatically, we'd have to do it in xdp_do_redirect(). Which means that
we'll have to figure out, at that point, whether the XDP frame is likely
to be converted to an SKB. This will add at least one branch (and
probably more) that will be in-path for every redirected frame.

Hence, making it up to the XDP program itself to decide whether it will
need the metadata for SKB conversion seems like a better choice, as long
as we make it easy for the XDP program to do this. Instead of a helper,
this could also simply be a new flag to the bpf_redirect{,_map}()
helpers (either opt-in or opt-out depending on the overhead), which
would be even simpler?

I.e.,

return bpf_redirect_map(&cpumap, 0, BPF_F_PREPARE_SKB_METADATA);

-Toke


[0] As an aside, in the future drivers may want to take advantage of the
XDP-specific metadata reading also when building SKBs (so it doesn't
have to implement it in both BPF and C code). For this, we could expose
a new internal helper function that the drivers could call to simply
execute the XDP-to-skb metadata helpers the same way the stack/helper
does.

