Return-Path: <bpf+bounces-54763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ED0A71B49
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F563BBB3A
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2101F8672;
	Wed, 26 Mar 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eo5uYP9N"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912991F63D9;
	Wed, 26 Mar 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004734; cv=none; b=kYg4E9ZfV3q201EdJYcRXIsFmMvPHcH1otUOk210Wi6jiJPpM7UAU4xFqw2+UkE363n3rnWJs2x1kMdkDw0znXsKitsEMh46h8eEK5t7c3Y/CmZQ+d+iOVzpr/5gS6KIag5QcEL6C6iaeENibvpHQ2+GgojdGskFOaL44QAN5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004734; c=relaxed/simple;
	bh=NejtlTor2FpD1GJUomMaCO5RdVyHraorG0c0pmJ9Ouk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWGHFS2gbqlZM6PWN9MwjHYD7Wz2mZUMVs+sHGS7OTUG8MwYEwphzulgmvL5xQH3I66oaquCRwUJMAY9/k5I5++ket+oKNzimuxeomWhzwcrz/sWhKSv+GPH6/w7sRRsCr8aGMCrH9APOcSFos3bcf70PxXh4faZ7YqxhSrW83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eo5uYP9N; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C97FAC003AC9;
	Wed, 26 Mar 2025 08:58:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C97FAC003AC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1743004731;
	bh=NejtlTor2FpD1GJUomMaCO5RdVyHraorG0c0pmJ9Ouk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eo5uYP9N3yBJIVl2ifd2E56kR/fM9yf0z/zCw7IZynLfg6VlQ9ycmaRBGBvLwwxuH
	 +QoYgvR6ZTuV4acRi3mywjMsI6Ks5uS5jCV0jH/9TaVOJWyKWE/5C7+1BHdnQ7hF7t
	 lhU+1GRALgW62MJ7P/EKBj69hMJNDt6HYhXjxvAc=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 233EA4002F44;
	Wed, 26 Mar 2025 11:58:49 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Friedrich Weber <f.weber@proxmox.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Carlos Soto <carlos.soto@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Pravin B Shelar <pshelar@ovn.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	Yan Zhai <yan@cloudflare.com>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>,
	Thomas Graf <tgraf@suug.ch>,
	Justin Pettit <jpettit@nicira.com>,
	Andy Zhou <azhou@nicira.com>,
	Simon Horman <simon.horman@corigine.com>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	dev@openvswitch.org (open list:OPENVSWITCH),
	bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH stable 5.10 v3 2/2] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Wed, 26 Mar 2025 08:58:41 -0700
Message-Id: <20250326155841.4133945-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250326155841.4133945-1-florian.fainelli@broadcom.com>
References: <20250326155841.4133945-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 47e55e4b410f7d552e43011baa5be1aab4093990 ]

Commit in a fixes tag attempted to fix the issue in the following
sequence of calls:

    do_output
    -> ovs_vport_send
       -> dev_queue_xmit
          -> __dev_queue_xmit
             -> netdev_core_pick_tx
                -> skb_tx_hash

When device is unregistering, the 'dev->real_num_tx_queues' goes to
zero and the 'while (unlikely(hash >= qcount))' loop inside the
'skb_tx_hash' becomes infinite, locking up the core forever.

But unfortunately, checking just the carrier status is not enough to
fix the issue, because some devices may still be in unregistering
state while reporting carrier status OK.

One example of such device is a net/dummy.  It sets carrier ON
on start, but it doesn't implement .ndo_stop to set the carrier off.
And it makes sense, because dummy doesn't really have a carrier.
Therefore, while this device is unregistering, it's still easy to hit
the infinite loop in the skb_tx_hash() from the OVS datapath.  There
might be other drivers that do the same, but dummy by itself is
important for the OVS ecosystem, because it is frequently used as a
packet sink for tcpdump while debugging OVS deployments.  And when the
issue is hit, the only way to recover is to reboot.

Fix that by also checking if the device is running.  The running
state is handled by the net core during unregistering, so it covers
unregistering case better, and we don't really need to send packets
to devices that are not running anyway.

While only checking the running state might be enough, the carrier
check is preserved.  The running and the carrier states seem disjoined
throughout the code and different drivers.  And other core functions
like __dev_direct_xmit() check both before attempting to transmit
a packet.  So, it seems safer to check both flags in OVS as well.

Fixes: 066b86787fa3 ("net: openvswitch: fix race on port output")
Reported-by: Friedrich Weber <f.weber@proxmox.com>
Closes: https://mail.openvswitch.org/pipermail/ovs-discuss/2025-January/053423.html
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Friedrich Weber <f.weber@proxmox.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20250109122225.4034688-1-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 net/openvswitch/actions.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 9b07e2172c94..1f05fa85d295 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -913,7 +913,9 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
-	if (likely(vport && netif_carrier_ok(vport->dev))) {
+	if (likely(vport &&
+		   netif_running(vport->dev) &&
+		   netif_carrier_ok(vport->dev))) {
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
-- 
2.34.1


