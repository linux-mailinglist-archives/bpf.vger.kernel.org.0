Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E766B59BD76
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiHVKRq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiHVKRp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 06:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E01275D7
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661163463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KtRU9aDzK4XU9Ks65egqdRwloKirfCRi6+Miz1fpKk=;
        b=O7X841avKm2MU8hIC5+gZ4rjfVmysw/+UA0T92VTIeaY/2s7cVw0lJUwqtMIjbDjTucwHL
        al6PFlCh5Ge0cEJMA18E6ZEUx1KgOYqcLFlzhWXAcV5q6QcQ9c/OxL7pnUM4NqskC1QoY6
        iK7ggM+mh0LqGvw2Xia7YrIR66wPoOg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-438-SDFkufdyO9Sixy024G7wNg-1; Mon, 22 Aug 2022 06:17:42 -0400
X-MC-Unique: SDFkufdyO9Sixy024G7wNg-1
Received: by mail-ed1-f69.google.com with SMTP id x3-20020a05640226c300b00446ad76aeb5so1901850edd.8
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 03:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/KtRU9aDzK4XU9Ks65egqdRwloKirfCRi6+Miz1fpKk=;
        b=eoFkseqqz4vAlbyrO3rfUwlNPy8bdiy7+wxity3qi2b/DFB5bIxY6JDYK2xkikggfX
         STJSusTgPSS5wV0xzna4OSB6wUaV7SXCMAPE8Ul5rxpdB/+lFBbR6w2cJhNTOEE/lbK8
         cX7CH5QnJBUkZbcRkEjARVNpZ0PyNi6YpfmEt6hN9ggzbeZWEFDjkuA8ARD82ZDcBjZ4
         CP/zTf7Yi9rDirpSatBuwUI8VdI2cSYPkycwxllQkHxaZfoJxU6AxIlC7w0sUo4hiu28
         a0hC8MSBI1ynvqveJZoAnRSORE/5ZI577NG763WNKi0SxjU8rVk/RPOKZAqs7GnBkrmP
         FX7Q==
X-Gm-Message-State: ACgBeo0C35K7X5S2W1NRSzzeB66eKTbR3Q5MaUr94574u6pnU52p2qBe
        R5ie7iGtLFxE8+KyOI18XgXqyItVdwnJPsQ0gyobAVS81KoPLcGptXAj2gdLTpAZ+nK+zjWAdJs
        WXW29Xkeibe2r
X-Received: by 2002:a05:6402:4383:b0:446:d6ac:bddd with SMTP id o3-20020a056402438300b00446d6acbdddmr2176189edc.283.1661163459840;
        Mon, 22 Aug 2022 03:17:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+l+WvEVxQS/W5H0TQ59Ekoy4qDOsUP5z/+kLkcjlvNkPB9jPMoQcOiVOt/yr2uS6SeiRsmQ==
X-Received: by 2002:a05:6402:4383:b0:446:d6ac:bddd with SMTP id o3-20020a056402438300b00446d6acbdddmr2176154edc.283.1661163459114;
        Mon, 22 Aug 2022 03:17:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j7-20020aa7c407000000b004465d1db765sm5089367edq.89.2022.08.22.03.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 03:17:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A988056014F; Mon, 22 Aug 2022 12:17:37 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] dev: Move received_rps counter next to RPS
 members in softnet data
In-Reply-To: <20220819155421.3ca7d6d6@kernel.org>
References: <20220818165906.64450-1-toke@redhat.com>
 <20220818165906.64450-2-toke@redhat.com>
 <20220818200143.7d534a41@kernel.org> <87bksgv26h.fsf@toke.dk>
 <20220819155421.3ca7d6d6@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 22 Aug 2022 12:17:37 +0200
Message-ID: <87a67wk2f2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 19 Aug 2022 14:38:14 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> > On Thu, 18 Aug 2022 18:59:03 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:=20=20
>> >> Move the received_rps counter value next to the other RPS-related mem=
bers
>> >> in softnet_data. This closes two four-byte holes in the structure, ma=
king
>> >> room for another pointer in the first two cache lines without bumping=
 the
>> >> xmit struct to its own line.=20=20
>> >
>> > What's the pointer you're making space for (which I hope will explain
>> > why this patch is part of this otherwise bpf series)?=20=20
>>=20
>> The XDP queueing series adds a pointer to keep track of which interfaces
>> were scheduled for transmission using the XDP dequeue hook (similar to
>> how the qdisc wake code works):
>>=20
>> https://lore.kernel.org/r/20220713111430.134810-12-toke@redhat.com
>
> I see, it makes more sense now :)
>
>> Note that it's still up in the air if this ends up being the way this
>> will be implemented, so I'm OK with dropping this patch for now if you'd
>> rather wait until it's really needed. OTOH it also seemed like a benign
>> change on its own, so I figured I might as well include this patch when
>> sending these out. WDYT?
>
> Whatever is easiest :)

Alright, I'm OK with either so let's leave it up to the (BPF)
maintainers if they want to drop this patch or just merge the whole
series? :)

-Toke

