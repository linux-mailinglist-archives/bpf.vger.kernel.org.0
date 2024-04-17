Return-Path: <bpf+bounces-27064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36348A8BFB
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 21:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593E1286E5F
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADD2561D;
	Wed, 17 Apr 2024 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WayJRNx9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BEF22338;
	Wed, 17 Apr 2024 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381508; cv=none; b=YquEMscCX2Q5z5inX8jiyQZQyhAPmgO5UF2Toon5gejNdd22HbqioLHWYRoMaV7MV7u5lfP5j1Wl7tbVI+7EHmzUJBrKFiVbABa181zXQyshV3dKTzYLfRLAzZt3u4Kxllr48iNeY3lS3oMAfWnOqQ4h8uVxkKOgqk6dbjohSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381508; c=relaxed/simple;
	bh=g8wIfvshnqk+Sxb6Bc7bHBKuR56ID1L8n+BXfr1Zka4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LH8J2yn5quy1YjmQUOJreMuG3ne3BEiwwc22QHMNZ9Ks8VpWQiueQbAo4QUm9WGSUBN2CT03Dzp0yz5OZj9YqkP7RDevJJLQ0XNQGZUSdmw1r+cXRqcVcctVjXxVF6Pn7dyd8jSSvHa5V3TqvV8UiNt2aiiR74MAoBAxKpshNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WayJRNx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF82C072AA;
	Wed, 17 Apr 2024 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713381507;
	bh=g8wIfvshnqk+Sxb6Bc7bHBKuR56ID1L8n+BXfr1Zka4=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=WayJRNx9Cce1kET5/K3SOl7Uv39bsxR6NKo4iyAx8lycwsDHMhfiPPOuUVWccZL3m
	 kGxguqQjb/+7NlebrR5KCxxw5nHndHCznBVDY+3aBSUjkBi0Mm1bemto9j+2c6SMDl
	 wUXNiiY8wZcL9530gOVJGChmB9dI0q32AGl3lAA+qFsPdKpnEPU+fdJeLoHYqgvrFM
	 DjYlVVFE191OoZMctKwoxnUV37k0h+aGOer+tqsa8ZCsGZa9yEY23dwhvRCiqoNivg
	 BNlBFUBctBIfpNeeSvGM5fr0KbHqjpS8Jm32sqd2l7lNOnq7kVIFsH+kBQFTPWhEmH
	 CQWP4wwJLlrnA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0C4F11233B0D; Wed, 17 Apr 2024 21:18:25 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com,
 eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
In-Reply-To: <000000000000a693f106164bf4c7@google.com>
References: <000000000000a693f106164bf4c7@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Apr 2024 21:18:24 +0200
Message-ID: <871q73vlvj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=125ea0e3180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=156227cd180000
>
> Note: testing is done by a robot and is best-effort only.

And now the real patch:

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 443574b03387


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
+			* down by bpf_clear_redirect_map()
+			*/
+			if (unlikely(!map)) {
+				err = -ENOENT;
+				break;
+			}
+
 			WRITE_ONCE(ri->map, NULL);
 			err = dev_map_enqueue_multi(xdpf, dev, map,
-						   ri->flags & BPF_F_EXCLUDE_INGRESS);
+						   flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
 			err = dev_map_enqueue(fwd, xdpf, dev);
 		}
@@ -4445,9 +4456,9 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
 static int xdp_do_generic_redirect_map(struct net_device *dev,
 				      struct sk_buff *skb,
 				      struct xdp_buff *xdp,
-				      struct bpf_prog *xdp_prog,
-				      void *fwd,
-				      enum bpf_map_type map_type, u32 map_id)
+				      struct bpf_prog *xdp_prog, void *fwd,
+				      enum bpf_map_type map_type, u32 map_id,
+				      u32 flags)
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
+			* down by bpf_clear_redirect_map()
+			*/
+			if (unlikely(!map)) {
+				err = -ENOENT;
+				break;
+			}
+
 			WRITE_ONCE(ri->map, NULL);
 			err = dev_map_redirect_multi(dev, skb, xdp_prog, map,
-						    ri->flags & BPF_F_EXCLUDE_INGRESS);
+						    flags & BPF_F_EXCLUDE_INGRESS);
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

