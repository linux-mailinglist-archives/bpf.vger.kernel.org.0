Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17A46CA76D
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjC0OWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjC0OVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 10:21:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F8F1FDE
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 07:19:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r11so8962802wrr.12
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avride-ai.20210112.gappssmtp.com; s=20210112; t=1679926791;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR9qlyANU+suURSeFpJZBWO7/0Ie6OD7DplKoKO5WkA=;
        b=2sqGo4bx/hXISaTDTmfmr08dwN+a9K5p1bwSwNOfoyg6rMTJDXHBZYOLfUUFjXRxJJ
         C7X6jafDaLo8ZTohb3xyrqm/FAC4LsTCNeXuF+7Yo1t5f6aHEY5ZOj+7d9e8lOxai4gx
         vjwGMbk0SbjUW3WHNtSA/1OUdj3BHioBPavnHMbCGersT+jwKDPqdwJnhGUbglyPicbI
         KoCHAPj44IsyHBArL0R/Q804WDUnEsP9WQEzCE11cDmx2454LAl6b9u6wygXvnlyJ+RU
         dTURxO+vrWxnyZ71uomvNitJlFE660idXHzXEP9Lh1wrgpEd1rQBfZwBTvk7egQ4wF6h
         veYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926791;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR9qlyANU+suURSeFpJZBWO7/0Ie6OD7DplKoKO5WkA=;
        b=Qb1zuBEYNEGUeIE6DnU5P651qCGbOer9//zYQnRVfT2+emTxsr47uOFl9PXu8Ur0OE
         RJTMUv0uYMqcWyNZBus3cCueWpRMDlk8BR+kxlNs9F09oWEwpPABK1KJKGRRzN81zeXu
         j0YJ/fsBI1J1V8aiohkkfmXQVrhfKnJhi3IxoM3tL/kIClJxwW5UUCfmr/72gA7vh6rR
         z4sb++in6F7i2LliK0D35dJwt1Y2kZW5QmfdeXA7T2B9AsjZg090a1F5i+vjXVw18IIW
         Ae6iWYv3QCqENd/0sPz0kF6R+VVgEiiCFF/hMV6I/zdfclhy2fLMynDIsObgVK+xJ4R1
         t2VA==
X-Gm-Message-State: AAQBX9eijQHAWspAN/E3so1pJNcnZfSzcyXCyQ2t5IwkDJkHZDTWsMzg
        ksmzf5GzxklwFszkyKZW5XzQIw==
X-Google-Smtp-Source: AKy350birvvGgwtqcOBrHGSbSQjsGVODn7j+zuIMOR9U8zTGbtgDFf0VHPV51rI9GCO46V5x4+fWzw==
X-Received: by 2002:a5d:58fb:0:b0:2cf:f0d9:6227 with SMTP id f27-20020a5d58fb000000b002cff0d96227mr8672723wrd.0.1679926791600;
        Mon, 27 Mar 2023 07:19:51 -0700 (PDT)
Received: from smtpclient.apple ([2001:40a8:400:600:1809:dfe4:2b3e:b115])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b002cefcac0c62sm25449432wrn.9.2023.03.27.07.19.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2023 07:19:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Network RX per process per interface statistics
From:   Kamil Zaripov <zaripov-kamil@avride.ai>
In-Reply-To: <ZB4F7l0Nh2ZYwjci@google.com>
Date:   Mon, 27 Mar 2023 17:19:50 +0300
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8C3B8DB-1CF1-4C51-91A1-6D4C6FEFD6D1@avride.ai>
References: <F75020C7-9247-4F15-96CC-C3E6F11C0429@avride.ai>
 <ZB4F7l0Nh2ZYwjci@google.com>
To:     Stanislav Fomichev <sdf@google.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> By "modifies" - do you mean the payload/headers? You can probably use
> the skb pointer address as a unique identifier to connect across =
different
> tracepoints?

No, I mean when situations when same package through its way to the =
network stack change sk_buff pointer. For example, after skb_clone() =
call. I have made some test and found out (empirically) that pointer to =
the skb->head a much better tracking ID. However, I am not sure that =
there is no other corner cases when skb->head also can change.

> Nothing pops to my mind. But I think that if you store skbaddr=3Ddev =
from
> netif_receive_skb, you should be able to look this up at a later point
> where you know skb->process association?

Yes, I have already implemented and make some test of this approach: =
I=E2=80=99m listening at netif_receive_skb tracepoint to create =
skb_head->netif map and then listening for __kfree_skb calls to create =
pid->skb_head map. However, this approach have some weaknesses:
- Part of packages of TCP protocol packages (ACK, for example) are =
handled by the kernel, so I account this packages as kernel activity. =
But almost every TCP ACK package have some  associated socket, which, in =
turn, have associated process.
- I am not sure that all package consumes call __kfree_skb at the end. =
Maybe there is some other miscounting in this place.

Maybe there is some other approaches to map packages to processes?=
