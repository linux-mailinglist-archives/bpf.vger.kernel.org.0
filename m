Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8321465A58
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 01:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354073AbhLBAHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 19:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354091AbhLBAHc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 19:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638403445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2W/44qFKQfDTqcBT48p2Uxe3qzLn64OCXa3a4zfm4NU=;
        b=cd90q82GGK2DRuzC1vpEyq2JgCZvGR3umY3YstBva6aP/uF4xLpZz2C3IBnhCmHz5dR+Im
        qnBO8R00VSRRtZ3w8x72QcF0k9SqGwNEUpNNGh5D0j39LtxPd6ZOUCCFTJK9LZPd7Ohug+
        kWXi1Us8nYoU/0P5r7dQscwxnjnb9Ls=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-qgwGnaZXNDmNKq8vEKzTHg-1; Wed, 01 Dec 2021 19:04:04 -0500
X-MC-Unique: qgwGnaZXNDmNKq8vEKzTHg-1
Received: by mail-ed1-f71.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso15666414edc.10
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 16:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2W/44qFKQfDTqcBT48p2Uxe3qzLn64OCXa3a4zfm4NU=;
        b=IkRSbyRXxRWQvfShJvGzIsBw0Nqj1Pk2nWBOkf36A5S874X4p/scn90iIbsqlh39Wl
         5brd9+7oU4OBEVTVyfvAu05RfFbiKL7WxjnfIiNMdBcJYWgzxLbOZf5Gdg9bxrgOY40r
         2Sl6lGNNN/Z82ATc0H9NqagAcwA3x/iqd/kYc/KBB8oJHRACGcCjuAxLPs5UbRYjXq21
         ChwYqoxT4DbctXCms44Pr78OwQfVcmywjFLLC5CRpIZD76JJj5CRTmYdznPrYZHP4X+a
         yICkRhkR2+owDxxUhgnkGQlNn2bPSuS+2sQE4KtKZKYChYDRsvONQLFk+queONjOZVer
         MZxw==
X-Gm-Message-State: AOAM533m6vAW+D5SKIwKKDbCV14Bwc0OEctTdj6FuqNZpdTJqb6rhRVh
        /fmddAhMMojWOoNJrYyrJLA1mOuY430LmN7+KNFLyOLb+1+rWCS/EA5xa3f0pjXMHw3qG2q6fMx
        TTEmMmdGVHiDz
X-Received: by 2002:aa7:cd99:: with SMTP id x25mr13243269edv.249.1638403442822;
        Wed, 01 Dec 2021 16:04:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaREVZ/SRhsyoyTktsxFg17mRvv7Dgk0J4972XycW57VidbMbXnUBgWi8xHahFE5RWUaaZjA==
X-Received: by 2002:aa7:cd99:: with SMTP id x25mr13243161edv.249.1638403442070;
        Wed, 01 Dec 2021 16:04:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w5sm802906edc.58.2021.12.01.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:04:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B11C31802A2; Thu,  2 Dec 2021 01:04:00 +0100 (CET)
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
Subject: [PATCH bpf-next 5/8] xdp: add xdp_do_redirect_frame() for pre-computed xdp_frames
Date:   Thu,  2 Dec 2021 01:02:26 +0100
Message-Id: <20211202000232.380824-6-toke@redhat.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202000232.380824-1-toke@redhat.com>
References: <20211202000232.380824-1-toke@redhat.com>
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
 include/linux/filter.h |  4 ++++
 net/core/filter.c      | 28 +++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b6a216eb217a..845452c83e0f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1022,6 +1022,10 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
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
index 1e86130a913a..d8fe74cc8b66 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3957,14 +3957,13 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_master_redirect);
 
-int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
-		    struct bpf_prog *xdp_prog)
+static int __xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
+			     struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
-	struct xdp_frame *xdpf;
 	struct bpf_map *map;
 	int err;
 
@@ -3976,10 +3975,12 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		goto out;
 	}
 
-	xdpf = xdp_convert_buff_to_frame(xdp);
-	if (unlikely(!xdpf)) {
-		err = -EOVERFLOW;
-		goto err;
+	if (!xdpf) {
+		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf)) {
+			err = -EOVERFLOW;
+			goto err;
+		}
 	}
 
 	switch (map_type) {
@@ -4024,8 +4025,21 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index, err);
 	return err;
 }
+
+int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
+		    struct bpf_prog *xdp_prog)
+{
+	return __xdp_do_redirect(dev, xdp, NULL, xdp_prog);
+}
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
+int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
+			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
+{
+	return __xdp_do_redirect(dev, xdp, xdpf, xdp_prog);
+}
+EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
+
 static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct xdp_buff *xdp,
-- 
2.34.0

