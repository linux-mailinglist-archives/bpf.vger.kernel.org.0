Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892476457D7
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 11:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLGK2m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 05:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLGK2G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 05:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F51B7AC
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 02:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670408826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sl7ZkZKZiHSlbw4B4KJ5Z2VQTqLGIn8DjZOU7SMMFyU=;
        b=VwB7Oc44bpYcxAHUtsGBGbhidh3Tzgc2iP6XsBb0bQpDLEpYk1AnJG3gR7MLF0eA5GOVNe
        VN9s6biKwH7or1vg/SLfrB2UlHuusHkepuMIp9lwwwr3uKlxget99L8Vr0R9fG16UWLCiu
        0B2smk0YvMJrs/ix3kHn+Z94AlqZq6E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-mOmG6CSYMOaqDWjiBf4e5g-1; Wed, 07 Dec 2022 05:26:56 -0500
X-MC-Unique: mOmG6CSYMOaqDWjiBf4e5g-1
Received: by mail-wm1-f70.google.com with SMTP id r7-20020a1c4407000000b003d153a83d27so1268678wma.0
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 02:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sl7ZkZKZiHSlbw4B4KJ5Z2VQTqLGIn8DjZOU7SMMFyU=;
        b=E7TOSdyhLxopgqds5oncxNQ1fJpCTLsd4Rby9wpbPyfMqF3XZF5dOdoUA68p37xu/N
         wrUmYJ414yAcCyABDrejT68sW6vg0zOaGAJi/PkLO+vnDHtcXTd5rVXmUoMd32yTbScF
         ik30Egkrp1e2K1U46iDFqQQfW7OI5dPYKWX8D0Os4dYSAy8hULjwfklMLH+4+IdQG5IU
         vPSIK4o60Q6Ww3Zrw+6OASwZmqyvcRvSNCmu3L6SgUK8HQBjP9jfWQU0r3dMID+WGGDj
         60LRPK7lnKVLdaOJV1Q9hZDO2aLc7F5PKdoMURF/mncgxRunHvFzijV/s9JZQWq+Ifqc
         rxUg==
X-Gm-Message-State: ANoB5pm6pLb+wjSfhAl5qOxzil6IwInE9eWgSAkUdRifFA4ygTzS6CO+
        9g4B1UGPpUn6Pm/H9PDhEnRi+tdNuwPguEvQ4CsKNAQedVP/SMU0zU9CN19ThLolTx2ILmEDfsU
        tgirmd+JE233S
X-Received: by 2002:a5d:6b8a:0:b0:242:248a:a7c9 with SMTP id n10-20020a5d6b8a000000b00242248aa7c9mr22493582wrx.57.1670408815642;
        Wed, 07 Dec 2022 02:26:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Dsg4TGfhL2Cv/1eglm3fO6XYoXLJiTR62jdhwp51aRaeh+VbVjfokmXoyisqu3+FtTzNEYQ==
X-Received: by 2002:a5d:6b8a:0:b0:242:248a:a7c9 with SMTP id n10-20020a5d6b8a000000b00242248aa7c9mr22493567wrx.57.1670408815352;
        Wed, 07 Dec 2022 02:26:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it. [146.241.106.100])
        by smtp.gmail.com with ESMTPSA id r22-20020a05600c35d600b003a84375d0d1sm1281842wmq.44.2022.12.07.02.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:26:55 -0800 (PST)
Message-ID: <619913f8fc11ab502e73d526eee7ada6066843a2.camel@redhat.com>
Subject: Re: [PATCH net-next 2/6] tsnep: Add XDP TX support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com
Date:   Wed, 07 Dec 2022 11:26:53 +0100
In-Reply-To: <20221203215416.13465-3-gerhard@engleder-embedded.com>
References: <20221203215416.13465-1-gerhard@engleder-embedded.com>
         <20221203215416.13465-3-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2022-12-03 at 22:54 +0100, Gerhard Engleder wrote:
> For complete TX support tsnep_xdp_xmit_back() is already added, which is
> used later by the XDP RX path if BPF programs return XDP_TX.

Oops, I almost forgot... It's better to introduce tsnep_xdp_xmit_back()
in the patch using it: this patch introduces a build warning fixed by
the later patch, and we want to avoid it.

Cheers,

Paolo

