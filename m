Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8273E1CA942
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEHLLa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 07:11:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24092 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726638AbgEHLL3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 May 2020 07:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588936288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgmQQ3BdP3fG2j1xwjXam7QeuzlwY8kv6oC0rf1kJv0=;
        b=EbOd+xk7cay3OJWXcshpnh4m/fP5XrZeeZjYF/8ToQirjVLdZ3dlxWyVzKhFIWvgS9eo/n
        8Vjq1NpQ9RBbvafSalMaceIOCLnQPEqxRJrpj4ic75GvgEcGalrJ3YozdLx3OUVY7a+G7a
        Xi00wDZXSQRUXPFCKENuIQZRl/AcfLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-OlEnG33SOwGPiM3h-gERyQ-1; Fri, 08 May 2020 07:11:27 -0400
X-MC-Unique: OlEnG33SOwGPiM3h-gERyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F94580058A;
        Fri,  8 May 2020 11:11:25 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD413649D5;
        Fri,  8 May 2020 11:11:19 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 8F839300020FB;
        Fri,  8 May 2020 13:11:18 +0200 (CEST)
Subject: [PATCH net-next v3 30/33] xdp: clear grow memory in
 bpf_xdp_adjust_tail()
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
Date:   Fri, 08 May 2020 13:11:18 +0200
Message-ID: <158893627850.2321140.10204400330949821907.stgit@firesoul>
In-Reply-To: <158893607924.2321140.16117992313983615627.stgit@firesoul>
References: <158893607924.2321140.16117992313983615627.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clearing memory of tail when grow happens, because it is too easy
to write a XDP_PASS program that extend the tail, which expose
this memory to users that can run tcpdump.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/filter.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ec3ab2e2d800..691235208e0b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3427,6 +3427,10 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 	if (unlikely(data_end < xdp->data + ETH_HLEN))
 		return -EINVAL;
 
+	/* Clear memory area on grow, can contain uninit kernel memory */
+	if (offset > 0)
+		memset(xdp->data_end, 0, offset);
+
 	xdp->data_end = data_end;
 
 	return 0;


