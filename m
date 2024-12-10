Return-Path: <bpf+bounces-46512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF709EB2D9
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B086283B8F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8371B041D;
	Tue, 10 Dec 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CoRotnf2"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912DA1AAA15;
	Tue, 10 Dec 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839981; cv=none; b=aQ9cpBVWpEU6W4hljVB4CeTpcs0CuxxVcLyDOpx9/GfTlVa1OJ0fxyK09tbbQ6tRKaudA+n7tnXzGy6MH4POftuGXyAab+trgsiGEkHT4rT4MbdIpTdzdk/Wb2pVemPrW16PFZ+4x15e7csoky8nQqhw79O04Ht5nu0TC4sNdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839981; c=relaxed/simple;
	bh=/jRFu/L7c7AGe1yS6dfrf3NctqzbyX3J8DU7XIfSWq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTVGKfBfIWEg+T2XQ2yoa6xeaauSn/qYjV37Uc6ii1od//12/i61owsFx8wNGj3SBOA8ctV7cy3ddiDpeWYh/NWze9hlrDnDMQnFR9VV8wnoZETp5fbhNcuuRMrcYUtsQK2Zv0wiIfUBBxlq90ZyGg6iiLFaQsX/ECJ/WGi99Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CoRotnf2; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qVM3mlRYhOps9AQNgzS6NlJvaj25o3zlADgsHEc1zBI=; b=CoRotnf2uKs0xSE1//LI25otrL
	h/uxMbCM9MKGgDMWxA2W/oXBIyUnFS/FcuXALLAVHtyZM2ipA7Z2FmJi3Bp/bHWrll2Fkhrv/jl/V
	pEbzn9NoTm/BWZLXpjpHEoumAOCZydvL/1WOyxn9hrtYdiOYZ0iKFzfJTsfpwcZCjgtsDNrDLZoyu
	/SYL9UHuXlM+4fpGtB3kf9AHg0C1ISWck0XZK4FqAZ592a17SFSIcc030rPbYKcKFmusGt9PephCl
	x1cJ13xcuJt2aNEt/qHD3DagHk2LxijMvRdTQZIAwhaYIjbACArla1XSV2dwQxH6sdW0p+23tNf/+
	5z9qO9Kg==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tL0yk-000JgG-OI; Tue, 10 Dec 2024 15:12:46 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net 2/5] bonding: Fix initial {vlan,mpls}_feature set in bond_compute_features
Date: Tue, 10 Dec 2024 15:12:42 +0100
Message-ID: <20241210141245.327886-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>
References: <20241210141245.327886-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27483/Tue Dec 10 10:38:50 2024)

If a bonding device has slave devices, then the current logic to derive
the feature set for the master bond device is limited in that flags which
are fully supported by the underlying slave devices cannot be propagated
up to vlan devices which sit on top of bond devices. Instead, these get
blindly masked out via current NETIF_F_ALL_FOR_ALL logic.

vlan_features and mpls_features should reuse netdev_base_features() in
order derive the set in the same way as ndo_fix_features before iterating
through the slave devices to refine the feature set.

Fixes: a9b3ace44c7d ("bonding: fix vlan_features computing")
Fixes: 2e770b507ccd ("net: bonding: Inherit MPLS features from slave devices")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 42c835c60cd8..320dd71392ef 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1563,8 +1563,9 @@ static void bond_compute_features(struct bonding *bond)
 
 	if (!bond_has_slaves(bond))
 		goto done;
-	vlan_features &= NETIF_F_ALL_FOR_ALL;
-	mpls_features &= NETIF_F_ALL_FOR_ALL;
+
+	vlan_features = netdev_base_features(vlan_features);
+	mpls_features = netdev_base_features(mpls_features);
 
 	bond_for_each_slave(bond, slave, iter) {
 		vlan_features = netdev_increment_features(vlan_features,
-- 
2.43.0


