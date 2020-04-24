Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCB1B77F8
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgDXOGV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 10:06:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44486 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbgDXOGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 10:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587737177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XD/8fSrDljhSMhAXxrRpIOeU+6aO8IuBMFYijn23O/I=;
        b=CtTYXHI+fXZRmptpFKOqQBn57L7HjrzwXehQZIDVL7swp3M4cHU50nJd7AJNahdDLNyv+E
        l156rpOLvJdMAZW+sU4z6188F8SYcW91BgVn6aJdfaxyn4YPb/OfX0d7oGRXTYSSUMu1Pc
        KiKSFIvwroYZeGYOQ9l3ZwqAzFuC5DM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-nxfl8DVeOEGZcORz905pdQ-1; Fri, 24 Apr 2020 10:06:15 -0400
X-MC-Unique: nxfl8DVeOEGZcORz905pdQ-1
Received: by mail-lf1-f71.google.com with SMTP id l28so3934328lfp.8
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 07:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XD/8fSrDljhSMhAXxrRpIOeU+6aO8IuBMFYijn23O/I=;
        b=qBlLQ3bEtO9nMO9SgG0rUWDmpT4H3JBftYWsfDuWz1EHW66qcLO5LU3O1NtWYMALzP
         XcXQld3oeAkwuwkw0BxuP3rKllDXATruGeNtgrxVs+FnFgVfx2fDJb7LQi/tEZXoxoIy
         OWA4IUoDGb4ZBe3Yj8Na69G0B0oi7oMoVi3dBkqrBMADr92cVrUlvpGqpT79Aa31ycUj
         cg15B6aXnMFtQKiGS1uNIAtWhoKOjQ+2FYdRXOnWrHq8rFBWYjlX71l4zvh6Lrv9cCGC
         2DSTTS5Rlh+kAkfQCe0y1Xn7qfTEc2dehQGyUsvtC+yaAkyZctobzDtfPzL6AqA/NI2/
         9gHQ==
X-Gm-Message-State: AGi0PuakhPnN3vWZ8AjDRsz0XSZiml1iA+1OGHSEmOPEBWnhWoXT5YEL
        zHB8i663jWi5Wu0di/fyVz7G/nqlr1/NPpqyRjbghTuu5xAiu9JGxsXo0qWvOSsdAS8Vt2+DNhB
        odz6US3ds+NV1
X-Received: by 2002:a2e:9207:: with SMTP id k7mr6051083ljg.124.1587737174203;
        Fri, 24 Apr 2020 07:06:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ6h7uERsLmhAPBnRhqObB3yqw69uY5U6lX8MEZMcAIqMwJ8z5fUipamaGIU7vHgPaanI6Fow==
X-Received: by 2002:a2e:9207:: with SMTP id k7mr6051063ljg.124.1587737173930;
        Fri, 24 Apr 2020 07:06:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t13sm4204213ljd.38.2020.04.24.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:06:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0F5001814FF; Fri, 24 Apr 2020 16:05:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, sameehj@amazon.com
Cc:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Mao Wenan <maowenan@huawei.com>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        Daniel Borkmann <borkmann@iogearbox.net>,
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
Subject: Re: [PATCH net-next 09/33] veth: adjust hard_start offset on redirect XDP frames
In-Reply-To: <158757168676.1370371.9335548837047528670.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul> <158757168676.1370371.9335548837047528670.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 16:05:54 +0200
Message-ID: <87368t3rnh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> When native XDP redirect into a veth device, the frame arrives in the
> xdp_frame structure. It is then processed in veth_xdp_rcv_one(),
> which can run a new XDP bpf_prog on the packet. Doing so requires
> converting xdp_frame to xdp_buff, but the tricky part is that
> xdp_frame memory area is located in the top (data_hard_start) memory
> area that xdp_buff will point into.
>
> The current code tried to protect the xdp_frame area, by assigning
> xdp_buff.data_hard_start past this memory. This results in 32 bytes
> less headroom to expand into via BPF-helper bpf_xdp_adjust_head().
>
> This protect step is actually not needed, because BPF-helper
> bpf_xdp_adjust_head() already reserve this area, and don't allow
> BPF-prog to expand into it. Thus, it is safe to point data_hard_start
> directly at xdp_frame memory area.
>
> Cc: Toshiaki Makita <toshiaki.makita1@gmail.com>
> Fixes: 9fc8d518d9d5 ("veth: Handle xdp_frames in xdp napi ring")
> Reported-by: Mao Wenan <maowenan@huawei.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Acked-by: Toshiaki Makita <toshiaki.makita1@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

