Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6951B77EB
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 16:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgDXODz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 10:03:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47365 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727921AbgDXODz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 10:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587737033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86M4xLQmCX1+Kj9jFqVw76Vk3b/HPyVBNV1KeyvfXH8=;
        b=R55GRcqEX4TM0eJoTC/rW/2Ou8pu8DZX0bXaX+TdZ7mBdOyyPahVFtMqMpV7J+/X8INaML
        MkzspGFzY/jPwDB/fTkLPuzx4hBUOhFTF7RWKlJjYGPmEB7VghKJTcnsu/JmBoxUpXn1ht
        nLGcsbq+u5975pZo+rrceOJR6eXU7X0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-GeTXm1eHMDyWtub1VxeKGQ-1; Fri, 24 Apr 2020 10:03:52 -0400
X-MC-Unique: GeTXm1eHMDyWtub1VxeKGQ-1
Received: by mail-lf1-f70.google.com with SMTP id d5so3948704lfb.5
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 07:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=86M4xLQmCX1+Kj9jFqVw76Vk3b/HPyVBNV1KeyvfXH8=;
        b=m6A4f9lJU0+XB2FWyYiV1O5un9rYZZIAcIH+Ex5OWSiysUouKGlhj+OiQw6z6Jd6dz
         35261J0BZh2InJbAKNNLexfxBeBOMJ45VlWnmLLn1KtOVt7khj3EhRpbBQiFs0+mtQTx
         7TMt4OnsXhPa0Makf6rb/M21vIiy1mqylk67rJUdXmtV827OGg3QnR5gS4LFIEmfIF0v
         IVR3rD40v2V8V3PqleHhH2/Z1cq9aL020JxyqB52Rtac50Hj28rGmsZ5Ey8m+MGk8iio
         SfbXL1Koc4zGxK2CjwvFk89LMUuAShtEN9+4RaqUzU3v3sDWc5zeXbfDowT6BSEclEd2
         Cydw==
X-Gm-Message-State: AGi0PuazfnqOP/1Gco4GQmtqiuWO6SYOPWxpR/VqXFUFb+NKO99/PMc3
        ZNURo5DyOKlQf8dcuzfBMTFpbT0LDoIMKOBFPTeyydWSojAAqQ2DZEGCyGj3M+mzKG2UZHxy/L2
        Q+4mndnEog5f5
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr5838020ljj.136.1587737029538;
        Fri, 24 Apr 2020 07:03:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypJMYfs1sZxGBXbruY1FnOCks0xsAgGNnkQ+l8pOrzapO4B0sM0RXjSKiML1hjyB3FQOYpf72Q==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr5837996ljj.136.1587737029225;
        Fri, 24 Apr 2020 07:03:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l7sm4944371lfg.79.2020.04.24.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:03:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B91671814FF; Fri, 24 Apr 2020 16:03:23 +0200 (CEST)
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
Subject: Re: [PATCH net-next 06/33] net: XDP-generic determining XDP frame size
In-Reply-To: <158757167152.1370371.9610663437543094071.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul> <158757167152.1370371.9610663437543094071.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 16:03:23 +0200
Message-ID: <87blnh3rro.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> The SKB "head" pointer points to the data area that contains
> skb_shared_info, that can be found via skb_end_pointer(). Given
> xdp->data_hard_start have been established (basically pointing to
> skb->head), frame size is between skb_end_pointer() and data_hard_start,
> plus the size reserved to skb_shared_info.
>
> Change the bpf_xdp_adjust_tail offset adjust of skb->len, to be a positive
> offset number on grow, and negative number on shrink.  As this seems more
> natural when reading the code.
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

