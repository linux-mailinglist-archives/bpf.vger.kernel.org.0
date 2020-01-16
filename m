Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5C13DE64
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 16:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAPPOy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 10:14:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34175 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgAPPOy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Jan 2020 10:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579187693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pv4ffWDUPmdrqZm8YTbA/y+nX83CqQmxRiNOQLChJNw=;
        b=G+hdGvsKXR0xN3sTHWVdzWIPGD8YA6q/bO1pULLhv9hlOJj/K1M/oc92dXvXfyltbd839e
        wLM3GtYZe9014rJ/XKmqb9NpI0DmuBslP4V1y4MUFAUnpA+qF2Gs0W7z4Nbz5wx4zAelaR
        WmpzHnGkmyMA60md1wDKlx3U/r21Djo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-u4TDFevfMAK1nO66jBlV2Q-1; Thu, 16 Jan 2020 10:14:51 -0500
X-MC-Unique: u4TDFevfMAK1nO66jBlV2Q-1
Received: by mail-lj1-f198.google.com with SMTP id g5so5269416ljj.22
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 07:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pv4ffWDUPmdrqZm8YTbA/y+nX83CqQmxRiNOQLChJNw=;
        b=tb+zShYEQRgB04EA3X6sSH6FTcaABspr1PIqwtUOKyurUDFIpItcnjOlPF/ZTSZHX7
         1z/wRwfXAX1mF0jm4CnaQRdj/AMtkNq57TLSJgsHYWDQrHolaOsmq+YDatSWrSjLsY9n
         y4g0qH0Q0vLNToE6Dot399rcAdBrMy487FSiiMx3k3FLKC6B+7UV6Z9F82Wrkfl8BgN1
         kkOTRQ+SLxnmOEqqjWSU/UrCL1C4SxdllKGH84dZJT+Vq+h48kyi+AM0FwgsPRcnNzp+
         hFzqRVLRmKBWsZHvT6EQlWIReMOEdauWIpFhhX0LU3VeqpPnKsvsBbLGaIcE1d3Umsly
         Rqwg==
X-Gm-Message-State: APjAAAXscoxtkLblrG0VX2VG0WWiFQ8yJCB4W9rWLBXE+qsomNxort/U
        oS2lsqoSqYHtc/e9GnIq4lE2Kq1rEHNKTmq0OJHhNUpxobH3DWuY4hBvC/iZMu7AVz0ZE1JJIF9
        vdZSA022rz0ce
X-Received: by 2002:ac2:544f:: with SMTP id d15mr2745246lfn.126.1579187690072;
        Thu, 16 Jan 2020 07:14:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqykdvWwds5xDPVzmlKDORDeiP6xmTI4LYBNKx0wi8ARPDLBr3oLyAh9MDVE8eLu0dxKTHDqVA==
X-Received: by 2002:ac2:544f:: with SMTP id d15mr2745239lfn.126.1579187689887;
        Thu, 16 Jan 2020 07:14:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f11sm12722827lfa.9.2020.01.16.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 07:14:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3922B1804D7; Thu, 16 Jan 2020 16:14:46 +0100 (CET)
Subject: [PATCH bpf-next v3 3/3] devmap: Adjust tracepoint for map-less queue
 flush
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date:   Thu, 16 Jan 2020 16:14:46 +0100
Message-ID: <157918768613.1458396.9165902403373826572.stgit@toke.dk>
In-Reply-To: <157918768284.1458396.8128704597152008763.stgit@toke.dk>
References: <157918768284.1458396.8128704597152008763.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

Now that we don't have a reference to a devmap when flushing the device
bulk queue, let's change the the devmap_xmit tracepoint to remote the
map_id and map_index fields entirely. Rearrange the fields so 'drops' and
'sent' stay in the same position in the tracepoint struct, to make it
possible for the xdp_monitor utility to read both the old and the new
format.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/trace/events/xdp.h     |   29 ++++++++++++-----------------
 kernel/bpf/devmap.c            |    2 +-
 samples/bpf/xdp_monitor_kern.c |    8 +++-----
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index b680973687b4..b95d65e8c628 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -246,43 +246,38 @@ TRACE_EVENT(xdp_cpumap_enqueue,
 
 TRACE_EVENT(xdp_devmap_xmit,
 
-	TP_PROTO(const struct bpf_map *map, u32 map_index,
-		 int sent, int drops,
-		 const struct net_device *from_dev,
-		 const struct net_device *to_dev, int err),
+	TP_PROTO(const struct net_device *from_dev,
+		 const struct net_device *to_dev,
+		 int sent, int drops, int err),
 
-	TP_ARGS(map, map_index, sent, drops, from_dev, to_dev, err),
+	TP_ARGS(from_dev, to_dev, sent, drops, err),
 
 	TP_STRUCT__entry(
-		__field(int, map_id)
+		__field(int, from_ifindex)
 		__field(u32, act)
-		__field(u32, map_index)
+		__field(int, to_ifindex)
 		__field(int, drops)
 		__field(int, sent)
-		__field(int, from_ifindex)
-		__field(int, to_ifindex)
 		__field(int, err)
 	),
 
 	TP_fast_assign(
-		__entry->map_id		= map ? map->id : 0;
+		__entry->from_ifindex	= from_dev->ifindex;
 		__entry->act		= XDP_REDIRECT;
-		__entry->map_index	= map_index;
+		__entry->to_ifindex	= to_dev->ifindex;
 		__entry->drops		= drops;
 		__entry->sent		= sent;
-		__entry->from_ifindex	= from_dev->ifindex;
-		__entry->to_ifindex	= to_dev->ifindex;
 		__entry->err		= err;
 	),
 
 	TP_printk("ndo_xdp_xmit"
-		  " map_id=%d map_index=%d action=%s"
+		  " from_ifindex=%d to_ifindex=%d action=%s"
 		  " sent=%d drops=%d"
-		  " from_ifindex=%d to_ifindex=%d err=%d",
-		  __entry->map_id, __entry->map_index,
+		  " err=%d",
+		  __entry->from_ifindex, __entry->to_ifindex,
 		  __print_symbolic(__entry->act, __XDP_ACT_SYM_TAB),
 		  __entry->sent, __entry->drops,
-		  __entry->from_ifindex, __entry->to_ifindex, __entry->err)
+		  __entry->err)
 );
 
 /* Expect users already include <net/xdp.h>, but not xdp_priv.h */
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index d5311009953f..de630f980282 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -340,7 +340,7 @@ static int bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 out:
 	bq->count = 0;
 
-	trace_xdp_devmap_xmit(NULL, 0, sent, drops, bq->dev_rx, dev, err);
+	trace_xdp_devmap_xmit(bq->dev_rx, dev, sent, drops, err);
 	bq->dev_rx = NULL;
 	__list_del_clearprev(&bq->flush_node);
 	return 0;
diff --git a/samples/bpf/xdp_monitor_kern.c b/samples/bpf/xdp_monitor_kern.c
index ad10fe700d7d..39458a44472e 100644
--- a/samples/bpf/xdp_monitor_kern.c
+++ b/samples/bpf/xdp_monitor_kern.c
@@ -222,14 +222,12 @@ struct bpf_map_def SEC("maps") devmap_xmit_cnt = {
  */
 struct devmap_xmit_ctx {
 	u64 __pad;		// First 8 bytes are not accessible by bpf code
-	int map_id;		//	offset:8;  size:4; signed:1;
+	int from_ifindex;	//	offset:8;  size:4; signed:1;
 	u32 act;		//	offset:12; size:4; signed:0;
-	u32 map_index;		//	offset:16; size:4; signed:0;
+	int to_ifindex; 	//	offset:16; size:4; signed:1;
 	int drops;		//	offset:20; size:4; signed:1;
 	int sent;		//	offset:24; size:4; signed:1;
-	int from_ifindex;	//	offset:28; size:4; signed:1;
-	int to_ifindex;		//	offset:32; size:4; signed:1;
-	int err;		//	offset:36; size:4; signed:1;
+	int err;		//	offset:28; size:4; signed:1;
 };
 
 SEC("tracepoint/xdp/xdp_devmap_xmit")

