Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC75F6ADB1E
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 10:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCGJzI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 04:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCGJyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 04:54:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813A33D904
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678182828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggd3+ao+WeqD8liBzoZLjCqGeA5JT3k3Ek928KuXPYA=;
        b=RzP6qKsPUHGTAI4LHFDZ9vq85WStAi6SFTqna5PqZDqVtBHNuZQtiZGIqZePJWlqwMGm+h
        WeEoZdS41lfdfbKn+EOhkRs9IgN4/brqkFZi8E7Y1SbQ4w8hRV4bs8YJW4oGaLE2JNB8rh
        MxhCB0RFu5wtnPoDDtUEAWXyX8sz//U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-uR9g50zrOUWZhdM6AZkO1Q-1; Tue, 07 Mar 2023 04:53:47 -0500
X-MC-Unique: uR9g50zrOUWZhdM6AZkO1Q-1
Received: by mail-qt1-f198.google.com with SMTP id i24-20020ac84f58000000b003bfe3358691so6767040qtw.21
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 01:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182827;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggd3+ao+WeqD8liBzoZLjCqGeA5JT3k3Ek928KuXPYA=;
        b=HLxzXnTPJeFCqioaZ3pKfwLjCbnG+xwXIveEEDjj9Ool+8w1yYFOCjRtbnskNiYSr3
         NaszppyCokwhDKL9oHDiMom2hTmZb5e+6wcbbYjVmVrHIotSB/NpgbwKUnbe2WPit4yk
         I23gLzxsFOVnZOHdctnmgMvubJ04TZjabkE35yM8a4zCoxM/9lWBMOAeDbL724XfupUw
         +MjRZeIWROTF1+0Gp2+MdXHbtTnk/+AOQUOCBjuZDxrRbEnzDzxk4kghKQJcW26N0aH1
         8QzDsx/G8TmEt2XGznf/SKdx7SiCiFzU2TcSoSZj0Z63BOAO1/qcah8wkjHEDJEVodKO
         q4+A==
X-Gm-Message-State: AO0yUKWAT2lJQJEKvD01/FzBZtFgSQ6jkid0QI6egl+doUNwcP3eCzNm
        6QbxFEDN8fO78XstJmRCprVLbm8U/i0u15UeVOYFB0Q7R80TYoMIsi7UWKfe2wikyRd5eBayTpt
        8YKjE6tN1CENE
X-Received: by 2002:a05:622a:1443:b0:3bf:cf77:a861 with SMTP id v3-20020a05622a144300b003bfcf77a861mr26042698qtx.4.1678182826888;
        Tue, 07 Mar 2023 01:53:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/Ht7SnNixqcSsXD0GLyGOfUcXl++SZRRVs2S7WoQNC08oY0HQ25bhDHtpsc4xRCT0+4cdvAg==
X-Received: by 2002:a05:622a:1443:b0:3bf:cf77:a861 with SMTP id v3-20020a05622a144300b003bfcf77a861mr26042676qtx.4.1678182826522;
        Tue, 07 Mar 2023 01:53:46 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-28.dyn.eolo.it. [146.241.121.28])
        by smtp.gmail.com with ESMTPSA id 127-20020a370b85000000b007425ef4cbc2sm9256355qkl.100.2023.03.07.01.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 01:53:46 -0800 (PST)
Message-ID: <27a06a7d79fef3446ae1167612808a2af09922be.camel@redhat.com>
Subject: Re: [PATCH net 0/2] add checking sq is full inside xdp xmit
From:   Paolo Abeni <pabeni@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Date:   Tue, 07 Mar 2023 10:53:41 +0100
In-Reply-To: <1678153770.8281553-2-xuanzhuo@linux.alibaba.com>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
         <20230306125742-mutt-send-email-mst@kernel.org>
         <1678153770.8281553-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
On Tue, 2023-03-07 at 09:49 +0800, Xuan Zhuo wrote:
> On Mon, 6 Mar 2023 12:58:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> =
wrote:
> > On Mon, Mar 06, 2023 at 12:15:33PM +0800, Xuan Zhuo wrote:
> > > If the queue of xdp xmit is not an independent queue, then when the x=
dp
> > > xmit used all the desc, the xmit from the __dev_queue_xmit() may enco=
unter
> > > the following error.
> > >=20
> > > net ens4: Unexpected TXQ (0) queue failure: -28
> > >=20
> > > This patch adds a check whether sq is full in XDP Xmit.
> > >=20
> > > Thanks.
> >=20
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > needed for stable?
>=20
> Yes i think.

Could you please re-post including a suitable 'Fixes' tag? That would
address stable, too. Additionally you could rename check_sq_full() in
patch 1, perhaps 'check_disable_sq_full()' would do.

You can retain the already collected tags.

Thanks!

Paolo

