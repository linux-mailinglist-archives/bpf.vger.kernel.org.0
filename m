Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6B1B7814
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgDXOKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 10:10:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39731 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726993AbgDXOKG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Apr 2020 10:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587737404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Q24/Cv4pcX9vIZJCefwPpasOYfyPgu54YOF/qyScso=;
        b=iX+x0hfyvhIbSQoWiBVC5ktqrExGw3T3KC/gBqeEgJPo/mkc8iA6kllqGQaVIzycPqTqZl
        L6b/rw+tK3r+jX3IR5m80RX6w2LxsGbHEbLIxRsqqzlg5xgAcNgwa/moV7KiIy/FPA5xCp
        Oi8LEL6qCbk71LwJBFLujo4liJ2T9sY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-apQYQGsDOd6JW9-wxIt-3g-1; Fri, 24 Apr 2020 10:10:03 -0400
X-MC-Unique: apQYQGsDOd6JW9-wxIt-3g-1
Received: by mail-lf1-f70.google.com with SMTP id v6so3956065lfi.6
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 07:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9Q24/Cv4pcX9vIZJCefwPpasOYfyPgu54YOF/qyScso=;
        b=Nl8jsVi+6eWrNoBHbiYZi5zqD+DAmY4t67d0Va+cpThoBOu68Ip97kn2arik5+mRiO
         QsElawOmeLGFRbQvPbmxNP9qTcHnigCdiGDV4qKNQa4nH6FfJFT0yJ3Ou+2XBLryuIBN
         09fww0yAGJHuVwjdb3hdquniyJin2r/xiriKaYz3GlYoZIxd7Uy4JiQ6ZEar+jSk7/mC
         Oy/9SYqA/hzI6CIMiq+ZZJNAtKL+bmbjyft5BmYDn2VHBVjAEgYY+0xDMBwXsnER1yPW
         3npQRWDfijvspFS8J8qjPHGJjvWZrRLpesCx2rnzArveRoAS0OnDdjAjPfO4eUnAyJ9L
         i5dw==
X-Gm-Message-State: AGi0PuY5TWgX77UhvpEcP6vLp+/IferRGoPMgG1rbZm4DNEdxIJ7LWv2
        4MnnTJwzvIT8V+RBP1ZUIAc08l7bJSs9rA0ITEiCKgMabu52Kgi1DEQ9gUnOrVL7Kn9jApHI+F+
        pBHs5OH3ckgI+
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr5702468lji.77.1587737401826;
        Fri, 24 Apr 2020 07:10:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypIFrCM8GUhbtFpBrUIy12fsocbDRJMdhvHelGZHzZK4+D07R3UTsAvB5y+4JQ6eoZ+GonblgA==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr5702448lji.77.1587737401609;
        Fri, 24 Apr 2020 07:10:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f4sm4606019lfa.24.2020.04.24.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:10:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 48A4F1814FF; Fri, 24 Apr 2020 16:09:59 +0200 (CEST)
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
Subject: Re: [PATCH net-next 30/33] xdp: clear grow memory in bpf_xdp_adjust_tail()
In-Reply-To: <158757179349.1370371.14581472372520364962.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul> <158757179349.1370371.14581472372520364962.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 16:09:59 +0200
Message-ID: <87tv192cw8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> Clearing memory of tail when grow happens, because it is too easy
> to write a XDP_PASS program that extend the tail, which expose
> this memory to users that can run tcpdump.
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Probably a good precaution :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

