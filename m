Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A03599C20
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349008AbiHSMi3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 08:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348833AbiHSMiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 08:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C93ED58
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660912699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnnHIdU9DhmzWk8QeMkO+lqibVxsY1+S011HcqEI9i8=;
        b=H6No3tuQ+9O1SIbD1iycnOBX5Btw8wHJ1k3wKWgGkPPv2628miuPL2rxZ3iTTvVpOaPH7m
        hsoxe4PzHw5b/GfFBq6oz3kqFBFrTM5ctCAJ04pFPNRuL7rRWD9h56mCssBjGByPFAUPVF
        /7RPLH+jdQ5paueLYG0SDUANSBFo048=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-VOnL0H_bPYSpuZFX9P78IQ-1; Fri, 19 Aug 2022 08:38:18 -0400
X-MC-Unique: VOnL0H_bPYSpuZFX9P78IQ-1
Received: by mail-ed1-f70.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso2760712ede.15
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 05:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LnnHIdU9DhmzWk8QeMkO+lqibVxsY1+S011HcqEI9i8=;
        b=rQ1BHnShmczIjYKpcSqiqSCm9iIWE7Vv+5l8bObX3zvqi27aop4kEbD1rYvm2H4bSX
         yV154yAVCdjWSoLa5LypeJlcM0R8BNeeAgg/tex5OoNIi4dlTEB1xVOTV1umJRPLg8UZ
         PG4VhRanM3TqsXJfoInF331NMn11+8A0uSaeiTaNsKdRecoirAWBRKvv6EyfN6EWrc5Q
         w3YMVVyr0EIdctiUQhOAIM+2aVp2Ze1e2fyTQJfAQmz0uLukyYINDmUj76eJ52I0JVz4
         d5v5nuNtUaQxHLenNTT8zMtSYbO1hRAkdxth6SwcB2xHIHuWsMdHEo4654tKuH7GW8Wh
         f6QQ==
X-Gm-Message-State: ACgBeo1qtsh/lYBo6KS3sJ3If84nHHqJqgp6aAZ6GdJqFQTXv7Wv/rrF
        fa1nEWx8FKvwuM7sWCQHKKtpzrBDcOLMfuuxHC+hKT60Lh/IBUBvrvH5+nQmQCy1FC+vr1srXjU
        8g8kZ7GjMYbuD
X-Received: by 2002:a05:6402:2755:b0:43d:7568:c78e with SMTP id z21-20020a056402275500b0043d7568c78emr6056000edd.104.1660912696564;
        Fri, 19 Aug 2022 05:38:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5KeeNxqlZu+lhdGWImyOSstrSOYLHE6QBFFPEMo2WU91SqJCO2hfRq6xjWHfUJ3Cs7Wa9Tag==
X-Received: by 2002:a05:6402:2755:b0:43d:7568:c78e with SMTP id z21-20020a056402275500b0043d7568c78emr6055961edd.104.1660912695840;
        Fri, 19 Aug 2022 05:38:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a056402174600b0043cab10f702sm3022072edx.90.2022.08.19.05.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:38:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7F83955FC0B; Fri, 19 Aug 2022 14:38:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] dev: Move received_rps counter next to RPS
 members in softnet data
In-Reply-To: <20220818200143.7d534a41@kernel.org>
References: <20220818165906.64450-1-toke@redhat.com>
 <20220818165906.64450-2-toke@redhat.com>
 <20220818200143.7d534a41@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 19 Aug 2022 14:38:14 +0200
Message-ID: <87bksgv26h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 18 Aug 2022 18:59:03 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Move the received_rps counter value next to the other RPS-related members
>> in softnet_data. This closes two four-byte holes in the structure, making
>> room for another pointer in the first two cache lines without bumping the
>> xmit struct to its own line.
>
> What's the pointer you're making space for (which I hope will explain
> why this patch is part of this otherwise bpf series)?

The XDP queueing series adds a pointer to keep track of which interfaces
were scheduled for transmission using the XDP dequeue hook (similar to
how the qdisc wake code works):

https://lore.kernel.org/r/20220713111430.134810-12-toke@redhat.com

Note that it's still up in the air if this ends up being the way this
will be implemented, so I'm OK with dropping this patch for now if you'd
rather wait until it's really needed. OTOH it also seemed like a benign
change on its own, so I figured I might as well include this patch when
sending these out. WDYT?

-Toke

