Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6A1CA92D
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEHLKn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 07:10:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36207 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727924AbgEHLKl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 07:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588936240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wnGtQ8BrPvREsgrPw3LT2UIoKWkjXjqbLQOtszSlK+k=;
        b=HWVAnrNmE35NNpKlCijf4YFsufYjVB5ibH9AD8CRKEvdukoJGUkGMWA6wBdmxM+hWv4Ske
        nLLRhP/tgsikSt9oNzT5mE99RkKuZl/cNrfHuCOF5c01xrgh/WWldnXjrfDrwDtdULu3FZ
        YduXlVTVaulw5qz0/5J7zuRLqIrUzIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-oE7G7v2SMZmk6e1RzcTDWA-1; Fri, 08 May 2020 07:10:36 -0400
X-MC-Unique: oE7G7v2SMZmk6e1RzcTDWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954EB107ACCD;
        Fri,  8 May 2020 11:10:34 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFF6A2E045;
        Fri,  8 May 2020 11:10:28 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 9E835300020FB;
        Fri,  8 May 2020 13:10:27 +0200 (CEST)
Subject: [PATCH net-next v3 20/33] vhost_net: also populate XDP frame size
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Date:   Fri, 08 May 2020 13:10:27 +0200
Message-ID: <158893622757.2321140.18299712455321031398.stgit@firesoul>
In-Reply-To: <158893607924.2321140.16117992313983615627.stgit@firesoul>
References: <158893607924.2321140.16117992313983615627.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In vhost_net_build_xdp() the 'buf' that gets queued via an xdp_buff
have embedded a struct tun_xdp_hdr (located at xdp->data_hard_start)
which contains the buffer length 'buflen' (with tailroom for
skb_shared_info). Also storing this buflen in xdp->frame_sz, does not
obsolete struct tun_xdp_hdr, as it also contains a struct
virtio_net_hdr with other information.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 2927f02cc7e1..516519dcc8ff 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -747,6 +747,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	xdp->data = buf + pad;
 	xdp->data_end = xdp->data + len;
 	hdr->buflen = buflen;
+	xdp->frame_sz = buflen;
 
 	--net->refcnt_bias;
 	alloc_frag->offset += buflen;


