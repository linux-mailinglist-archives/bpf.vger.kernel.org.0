Return-Path: <bpf+bounces-27115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D58A93DF
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 09:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804DE1C20D10
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651CB3FB81;
	Thu, 18 Apr 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvP1rtfq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6875438F9A
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424739; cv=none; b=UF1vu/oS4iAlvCsiBhe+2NFMolXnkpGDgaGwibyU09TR58whvsnrXjKpje5r07bxtyap3m8ZJ6MYg3odkXZC6lpaEzVB5gJ/h4QniE0gTLXiylV7lmITKoN+qWCQNJHDmT0+dfhw0b1nDAbUO9ZD8nt7wOFDVH1C3W7yGkp90Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424739; c=relaxed/simple;
	bh=BMH7hZwU+wD+NGGr1T7RQBKgeAKqxW4NCDSbR1LHrLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bIR7FziGmLguMVshczhtd3Fz0k3X45+quCzgluwhtH2jn/msCGLe6Z+AUkPk+sUzXMK3qIagdqTYNa1yEiAAVI6xtm4wls93dmlvR94auefMFdF0DP6FOSOBgfTuUeLUsYOCV5pLvsBvIQH/ktlDxN510qyVA+8fxX0mkvAeASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvP1rtfq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713424736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U8waPYZt0i0yBiI+S/dWR2ZLE7Pp8trZ7x0kmMR8de8=;
	b=GvP1rtfqTyqnjIa80W2/mSd9j+em1hs4d2i7GiyH0APrYV5XB7zOJ2W9R0+uudX4dD8ofU
	SFZ9iwGrEhmupDxAMfXtOM3YzhT/7VHto9y+2CE76vu3G9HjAPgNN3H22AIVjBP8ElRZSR
	6cKmpMji7BVEDwWjAwsFxL2c9W9qjnA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-NfJktvyzM0SpL9VFUld5aw-1; Thu, 18 Apr 2024 03:18:54 -0400
X-MC-Unique: NfJktvyzM0SpL9VFUld5aw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-417fb8195d7so2930845e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 00:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713424733; x=1714029533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8waPYZt0i0yBiI+S/dWR2ZLE7Pp8trZ7x0kmMR8de8=;
        b=HRcOXKZjuYdSdssTc2EargUsfGr9b4PkguKJK/5c0Ymv87m3ciWrx3N1cz7oUD/YIq
         V3+XQNrWxX7UuH2wjLUVw2bN5iqb1wYaJ7au1DpGMk3jjlM7fN/4HubiYd4njyiFGYw2
         pvMjefNTKJ/Urn6NH0GN1zdWlV9cxvDF8g7lYyoGc5vfrB1oakj+HttLduPlXUbk7tPm
         K3I/IWIGD1C8szLLD3aoC06HvzKzz6faxzrAmELJxyibCy1ID0QPi6WJ2eVSnEEcYHf2
         Ne8yBCWA7n1PTrgQSDlm47e0IfjvXPGjdBv+CFDAS+HEjzO9csTGg2HVRmNmJowMjhFR
         eoTg==
X-Forwarded-Encrypted: i=1; AJvYcCWJuIIIv/jN2oTBIaumjNSdL6SGoSLbNh314bIYqRcI2thErB2Wa0ZxLs6wg/hkhBlMvZIKKFXIG/dtYIC40k+7gZjq
X-Gm-Message-State: AOJu0Yw6bIn3Rf3jAaLxXwtda9L/1pIQ+MFlafZLnCW30YmqM7aYtj1a
	VT2xJYiY55evUEvI354lwpQzwymyQRDpQG3rPJU+HKvVID9UKFIP3IHSu67LMh11oDoY2v6xYgj
	3Bzzk/FhfKvavq9p8HZw6vivxofdrirs3ha8ASoPz4K9t/Cf4uw==
X-Received: by 2002:a7b:c5c5:0:b0:418:a786:3760 with SMTP id n5-20020a7bc5c5000000b00418a7863760mr1154260wmk.15.1713424733635;
        Thu, 18 Apr 2024 00:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRTPmhz1p/NrnfdOdw3BYBD9re4KpHwT1CsIf6pUAh0BhjY0v97naAmOoq8fGJwBrE1zAyUw==
X-Received: by 2002:a7b:c5c5:0:b0:418:a786:3760 with SMTP id n5-20020a7bc5c5000000b00418a7863760mr1154242wmk.15.1713424733238;
        Thu, 18 Apr 2024 00:18:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm5440297wmo.5.2024.04.18.00.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:18:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CB42D1233C3D; Thu, 18 Apr 2024 09:18:51 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf] xdp: use flags field to disambiguate broadcast redirect
Date: Thu, 18 Apr 2024 09:18:39 +0200
Message-ID: <20240418071840.156411-1-toke@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When redirecting a packet using XDP, the bpf_redirect_map() helper will set
up the redirect destination information in struct bpf_redirect_info (using
the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
function will read this information after the XDP program returns and pass
the frame on to the right redirect destination.

When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
bpf_redirect_info to point to the destination map to be broadcast. And
xdp_do_redirect() reacts to the value of this map pointer to decide whether
it's dealing with a broadcast or a single-value redirect. However, if the
destination map is being destroyed before xdp_do_redirect() is called, the
map pointer will be cleared out (by bpf_clear_redirect_map()) without
waiting for any XDP programs to stop running. This causes xdp_do_redirect()
to think that the redirect was to a single target, but the target pointer
is also NULL (since broadcast redirects don't have a single target), so
this causes a crash when a NULL pointer is passed to dev_map_enqueue().

To fix this, change xdp_do_redirect() to react directly to the presence of
the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_info
to disambiguate between a single-target and a broadcast redirect. And only
read the 'map' pointer if the broadcast flag is set, aborting if that has
been cleared out in the meantime. This prevents the crash, while keeping
the atomic (cmpxchg-based) clearing of the map pointer itself, and without
adding any more checks in the non-broadcast fast path.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 786d792ac816..8120c3dddf5e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4363,10 +4363,12 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
+	u32 flags = ri->flags;
 	struct bpf_map *map;
 	int err;
 
 	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
+	ri->flags = 0;
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
 	if (unlikely(!xdpf)) {
@@ -4378,11 +4380,20 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 	case BPF_MAP_TYPE_DEVMAP:
 		fallthrough;
 	case BPF_MAP_TYPE_DEVMAP_HASH:
-		map = READ_ONCE(ri->map);
-		if (unlikely(map)) {
+		if (unlikely(flags & BPF_F_BROADCAST)) {
+			map = READ_ONCE(ri->map);
+
+			/* The map pointer is cleared when the map is being torn
+			 * down by bpf_clear_redirect_map()
+			 */
+			if (unlikely(!map)) {
+				err = -ENOENT;
+				break;
+			}
+
 			WRITE_ONCE(ri->map, NULL);
 			err = dev_map_enqueue_multi(xdpf, dev, map,
-						    ri->flags & BPF_F_EXCLUDE_INGRESS);
+						    flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
 			err = dev_map_enqueue(fwd, xdpf, dev);
 		}
@@ -4445,9 +4456,9 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
 static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct xdp_buff *xdp,
-				       struct bpf_prog *xdp_prog,
-				       void *fwd,
-				       enum bpf_map_type map_type, u32 map_id)
+				       struct bpf_prog *xdp_prog, void *fwd,
+				       enum bpf_map_type map_type, u32 map_id,
+				       u32 flags)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	struct bpf_map *map;
@@ -4457,11 +4468,20 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 	case BPF_MAP_TYPE_DEVMAP:
 		fallthrough;
 	case BPF_MAP_TYPE_DEVMAP_HASH:
-		map = READ_ONCE(ri->map);
-		if (unlikely(map)) {
+		if (unlikely(flags & BPF_F_BROADCAST)) {
+			map = READ_ONCE(ri->map);
+
+			/* The map pointer is cleared when the map is being torn
+			 * down by bpf_clear_redirect_map()
+			 */
+			if (unlikely(!map)) {
+				err = -ENOENT;
+				break;
+			}
+
 			WRITE_ONCE(ri->map, NULL);
 			err = dev_map_redirect_multi(dev, skb, xdp_prog, map,
-						     ri->flags & BPF_F_EXCLUDE_INGRESS);
+						     flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
 			err = dev_map_generic_redirect(fwd, skb, xdp_prog);
 		}
@@ -4498,9 +4518,11 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
+	u32 flags = ri->flags;
 	int err;
 
 	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
+	ri->flags = 0;
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
 	if (map_type == BPF_MAP_TYPE_UNSPEC && map_id == INT_MAX) {
@@ -4520,7 +4542,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 		return 0;
 	}
 
-	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, map_type, map_id);
+	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, map_type, map_id, flags);
 err:
 	_trace_xdp_redirect_err(dev, xdp_prog, ri->tgt_index, err);
 	return err;
-- 
2.44.0


