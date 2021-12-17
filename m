Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A793D478148
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhLQA2J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230521AbhLQA2A (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 19:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639700879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BzoQ4LYtnk4t54dol/Wlm8CS8osrqlNokqKq+15qJw=;
        b=S7bqkfO4FGuCPyT2htT6TIIrSZVRDHydidYgIdFWvy2B9vLd4hJ9hlPYLm/oMpnO4pEqYs
        VF0cWNbtLcKizh0A0U0WVoSea/J/oRneAX9CgvfouXuZ5LoejU1OY4cpcvlEuw5OCAJZun
        EXscWI79uCuqMuUeAreRod1nX++v3OY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-V-sI3qRWMt6sdCioTvZO9A-1; Thu, 16 Dec 2021 19:27:58 -0500
X-MC-Unique: V-sI3qRWMt6sdCioTvZO9A-1
Received: by mail-ed1-f70.google.com with SMTP id r26-20020aa7cfda000000b003f7fbbd9b5dso370358edy.19
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BzoQ4LYtnk4t54dol/Wlm8CS8osrqlNokqKq+15qJw=;
        b=Uk+QOvKYrtjpXDEFpBfE0JmoxtCdhsns8FAVG0r15hyUZArEp+VnH1BpIa4PwczaPa
         B+rNG+DPy4Z7dKCbyjxAn3BaRm8GldwoaomKsLF7HtxyX0BO61GudKCHH2JXPknP6dwI
         qsJdApjChy5tWeJrpCtt/q27SlOvncPWwUxrqICr/zaZTFvJy9Y1VBqLoOdhVhbbTto/
         Yw3Acv5l/hgbrxwxPzgPePN+aaMczcQOw+NiDEoJiROrwPkZed7jcW5i/VWAArTKIQIt
         IRkoP3HJVkLfbj6bLG3p7l4L0B8ydrGZPwrG2/blBZxyVSn/XyxpnCgv4a9R5qslqfV2
         261A==
X-Gm-Message-State: AOAM53237LLUMbhYeULzUArDsuFoqfiMOvLsUCNebYGZn0tW/zgc+pwx
        nyuyWMuqfW/RGqQKHycWsUWjkzjHoaUCHKlXSqrTAay99vg9TNsdVhuMOa37dENgdll+/ColbKV
        g7kuMRo/Dai3m
X-Received: by 2002:a17:907:60d1:: with SMTP id hv17mr437017ejc.384.1639700876568;
        Thu, 16 Dec 2021 16:27:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynkiOOzHg5VbokHaefMtfILMHyPng9lTe2E9kyu9Mva5f+qFiPFL4gH2LAXH/4MVYXyl/DyA==
X-Received: by 2002:a17:907:60d1:: with SMTP id hv17mr436964ejc.384.1639700875196;
        Thu, 16 Dec 2021 16:27:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g19sm1973695edr.6.2021.12.16.16.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:27:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BFB1C1802E8; Fri, 17 Dec 2021 01:27:52 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 5/7] xdp: add xdp_do_redirect_frame() for pre-computed xdp_frames
Date:   Fri, 17 Dec 2021 01:27:39 +0100
Message-Id: <20211217002741.146797-6-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217002741.146797-1-toke@redhat.com>
References: <20211217002741.146797-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an xdp_do_redirect_frame() variant which supports pre-computed
xdp_frame structures. This will be used in bpf_prog_run() to avoid having
to write to the xdp_frame structure when the XDP program doesn't modify the
frame boundaries.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/filter.h |  4 +++
 net/core/filter.c      | 65 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 60eec80fa1d4..71fa57b88bfc 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1019,6 +1019,10 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 int xdp_do_redirect(struct net_device *dev,
 		    struct xdp_buff *xdp,
 		    struct bpf_prog *prog);
+int xdp_do_redirect_frame(struct net_device *dev,
+			  struct xdp_buff *xdp,
+			  struct xdp_frame *xdpf,
+			  struct bpf_prog *prog);
 void xdp_do_flush(void);
 
 /* The xdp_do_flush_map() helper has been renamed to drop the _map suffix, as
diff --git a/net/core/filter.c b/net/core/filter.c
index f4540c800f4a..663a5d5370d5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3957,26 +3957,44 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_master_redirect);
 
-int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
-		    struct bpf_prog *xdp_prog)
+static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
+					struct net_device *dev,
+					struct xdp_buff *xdp,
+					struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
-	struct xdp_frame *xdpf;
-	struct bpf_map *map;
 	int err;
 
 	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
-	if (map_type == BPF_MAP_TYPE_XSKMAP) {
-		err = __xsk_map_redirect(fwd, xdp);
-		goto out;
-	}
+	err = __xsk_map_redirect(fwd, xdp);
+	if (unlikely(err))
+		goto err;
+
+	_trace_xdp_redirect_map(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index);
+	return 0;
+err:
+	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index, err);
+	return err;
+}
+
+static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
+						   struct net_device *dev,
+						   struct xdp_frame *xdpf,
+						   struct bpf_prog *xdp_prog)
+{
+	enum bpf_map_type map_type = ri->map_type;
+	void *fwd = ri->tgt_value;
+	u32 map_id = ri->map_id;
+	struct bpf_map *map;
+	int err;
+
+	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
+	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
-	xdpf = xdp_convert_buff_to_frame(xdp);
 	if (unlikely(!xdpf)) {
 		err = -EOVERFLOW;
 		goto err;
@@ -4013,7 +4031,6 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		err = -EBADRQC;
 	}
 
-out:
 	if (unlikely(err))
 		goto err;
 
@@ -4023,8 +4040,34 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index, err);
 	return err;
 }
+
+int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
+		    struct bpf_prog *xdp_prog)
+{
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	enum bpf_map_type map_type = ri->map_type;
+
+	if (map_type == BPF_MAP_TYPE_XSKMAP)
+		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
+
+	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
+				       xdp_prog);
+}
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
+int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
+			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
+{
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	enum bpf_map_type map_type = ri->map_type;
+
+	if (map_type == BPF_MAP_TYPE_XSKMAP)
+		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
+
+	return __xdp_do_redirect_frame(ri, dev, xdpf, xdp_prog);
+}
+EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
+
 static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct xdp_buff *xdp,
-- 
2.34.1

