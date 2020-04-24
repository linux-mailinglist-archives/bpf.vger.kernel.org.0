Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683A31B77F1
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgDXOEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 10:04:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55620 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727064AbgDXOEv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 10:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587737090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VuZCm8HvCNkNO0M8vLGp4C0YFmiV3243zClgfZKZD0=;
        b=GiobOISlOtNjP9oa3FO62kNZSPcsb5f8arHiJXTpfAEoQ1Un62Y3uZtCsTXvPjmunQeTOy
        hyhZR64eZ+JWhhIlKmsqe+Xvacg/+B2G52XzHNX4aW7EcCpcso4nKLDIPKqLuMh4vTy3o4
        x9JKIuJls/0XGoKFDyj/FIC8kW+T988=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-5iqNImgZPgWdDjl7tKYGkw-1; Fri, 24 Apr 2020 10:04:47 -0400
X-MC-Unique: 5iqNImgZPgWdDjl7tKYGkw-1
Received: by mail-lj1-f197.google.com with SMTP id p7so1820843ljg.15
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 07:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0VuZCm8HvCNkNO0M8vLGp4C0YFmiV3243zClgfZKZD0=;
        b=pdPJXh4Q3Sv1MDzR3qTeXFnDkyQBTG7lgpDksGAo1VmhD3+oPEg9RAj4f7N6ETsxhW
         Mxz293uuU2nQcZ3MnPty0SWg33zXWSiEjcH3r5l7ppxDG4/B/pxzEW0rOZOG1M2FvKbz
         ZiYMFsOCORsC6nwAOd62ZYeG65Zyi424YmxarLZcj4Vr6Urce125+9JsFriwYyveJ/UW
         TRNIq+R9GzzewCvBtEqWMFoaf9wKfWXDyEzTFvXhUtwuWFzD4EpUzHIH4Gd/kaKLCMfJ
         b54q32SX/cHY67+vksUIciA60KAnU3XGZxmi3s0mV1BUPHM4LXAzuRtvwUk6Xx1r1hRg
         AsCg==
X-Gm-Message-State: AGi0PuZUxvY+zC98QGXPkkZOLISdlx9e4zKP92ZUAQHb2RtZhIFe6hIV
        ePiyxnHPdj0Y8/0Ll/b7F14jD2PyWXEKc50BNDIGJcgrMIt3AnVzBJqaA84AvLucKg47Ys1iBAF
        FFknnAtEfCIQp
X-Received: by 2002:a2e:9990:: with SMTP id w16mr6015968lji.194.1587737086238;
        Fri, 24 Apr 2020 07:04:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypIcYuzHqe2Le/bdEmwoFanwD5jjtMRUpUe/Z7es4/wA8F/fojolHJVuYI3fbdh5xL/dy9YHFg==
X-Received: by 2002:a2e:9990:: with SMTP id w16mr6015940lji.194.1587737085934;
        Fri, 24 Apr 2020 07:04:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z13sm4316533ljn.77.2020.04.24.07.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:04:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 889121814FF; Fri, 24 Apr 2020 16:04:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, zorik@amazon.com, akiyano@amazon.com,
        gtzalik@amazon.com, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Subject: Re: [PATCH net-next 08/33] xdp: cpumap redirect use frame_sz and increase skb_tailroom
In-Reply-To: <158757168168.1370371.11510167625755235041.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul> <158757168168.1370371.11510167625755235041.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 16:04:19 +0200
Message-ID: <875zdp3rq4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> Knowing the memory size backing the packet/xdp_frame data area, and
> knowing it already have reserved room for skb_shared_info, simplifies
> using build_skb significantly.
>
> With this change we no-longer lie about the SKB truesize, but more
> importantly a significant larger skb_tailroom is now provided, e.g. when
> drivers uses a full PAGE_SIZE. This extra tailroom (in linear area) can be
> used by the network stack when coalescing SKBs (e.g. in skb_try_coalesce,
> see TCP cases where tcp_queue_rcv() can 'eat' skb).
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

