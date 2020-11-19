Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD92B9949
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 18:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgKSR0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 12:26:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729293AbgKSR0x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Nov 2020 12:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605806812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A9gyGsjXsxFxygwzA3IzjqNNYV6lCQYqmAHBNaZPFrA=;
        b=i7+IKGdeHsPCVKf7d2jL2g4DvPTDSg0CLGlbaCoUO+jAtQKnQUsRlN9eeCsLL7BASK89e4
        hxxie+yfCRCibRiO6SV3tmmdwjMQdGe2ZnMmB8fkqa3pRxG4Ln6EwrrJ1w40p+gDJX+gEv
        vpKoOrCuQNxRHmeTmTpDTIKqd4Hwir8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-SsvYuXONNUyT9mp4G0WOog-1; Thu, 19 Nov 2020 12:26:46 -0500
X-MC-Unique: SsvYuXONNUyT9mp4G0WOog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5765310766BB;
        Thu, 19 Nov 2020 17:26:45 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D010610016F6;
        Thu, 19 Nov 2020 17:26:41 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 81CA932138455;
        Thu, 19 Nov 2020 18:26:40 +0100 (CET)
Subject: [PATCH net-next] MAINTAINERS: Update XDP and AF_XDP entries
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Date:   Thu, 19 Nov 2020 18:26:40 +0100
Message-ID: <160580680009.2806072.11680148233715741983.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Getting too many false positive matches with current use
of the content regex K: and file regex N: patterns.

This patch drops file match N: and makes K: more restricted.
Some more normal F: file wildcards are added.

Notice that AF_XDP forgot to some F: files that is also
updated in this patch.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 MAINTAINERS |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af9f6a3ab100..230917ee687f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19105,12 +19105,17 @@ L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	include/net/xdp.h
+F:	include/net/xdp_priv.h
 F:	include/trace/events/xdp.h
 F:	kernel/bpf/cpumap.c
 F:	kernel/bpf/devmap.c
 F:	net/core/xdp.c
-N:	xdp
-K:	xdp
+F:	samples/bpf/xdp*
+F:	tools/testing/selftests/bpf/*xdp*
+F:	tools/testing/selftests/bpf/*/*xdp*
+F:	drivers/net/ethernet/*/*/*/*/*xdp*
+F:	drivers/net/ethernet/*/*/*xdp*
+K:	[^a-z0-9]xdp[^a-z0-9]
 
 XDP SOCKETS (AF_XDP)
 M:	Björn Töpel <bjorn.topel@intel.com>
@@ -19119,9 +19124,12 @@ R:	Jonathan Lemon <jonathan.lemon@gmail.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
+F:	Documentation/networking/af_xdp.rst
 F:	include/net/xdp_sock*
 F:	include/net/xsk_buff_pool.h
 F:	include/uapi/linux/if_xdp.h
+F:	include/uapi/linux/xdp_diag.h
+F:	include/net/netns/xdp.h
 F:	net/xdp/
 F:	samples/bpf/xdpsock*
 F:	tools/lib/bpf/xsk*


