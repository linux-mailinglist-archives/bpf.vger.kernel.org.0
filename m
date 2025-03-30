Return-Path: <bpf+bounces-54895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2329A75A0C
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 14:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B2E188ACC0
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333C1CDFCE;
	Sun, 30 Mar 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ULEoh+5A"
X-Original-To: bpf@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF51E4AB;
	Sun, 30 Mar 2025 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743337440; cv=pass; b=d5CqOulj3hkN6o5FNxR0ptN7MXVwBtK1dy6BRJ3IxIxtiUFTthq1uhcnDYBguGIhVspYh7B34YGtTKdJwJBRo6dCSGXVvAANyUV6MxdRbJ8rqqX91iS5jByAGOdjr4kgPvUmjhfKMyNAGqDUeGECIH3jMssOnBgmfNRa2JZeXvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743337440; c=relaxed/simple;
	bh=IXWeVNUrDwiVLsyEdQ+VN9pOIe6FAnFmLtT5lPuMAqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppUBAFNXL4uvPB64dYpeCedZFJWFQw7+TiMoqHs/45zH/bLJMN3gyNnjOl5V+5HsuzLzxaj1IMChBesvynvPVDF1nrhkl8FWBCQE/UX0C4o+mAxh/2m/qzTEGfpCkwThuVRFBANDSfOS9X7LMQN0Zij4ibDxu8ZPOkJSIRhtsf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ULEoh+5A; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZQYMq0WqZz49QBV;
	Sun, 30 Mar 2025 15:23:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743337432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iXUua0n2qyPzavE1+BdybGcZSsXWYWL87EJRkEHnm8=;
	b=ULEoh+5AH6+MHwMyi9PcNk9mKsXF9NowBN2Ohbu9lga83k+JE43AVgEAQsU9672YrZ4Lx4
	s7R1jyYdPLlkQ0BpuPNguT4lYI9ZQHru4nNnUZ8XK6i+dlTSHJVXpS2b+KxGstiJ4K/gAm
	Zna1t0xIwb4FBJ420YuYss/lbY7Cxsw4k9XyVApB39/f3QKs27AojnDzD+VKfYmZcTjy49
	Y3+Guz8f7+uKa3HZ/aEuQVrzjtOvH55LQ1DpVagsS0k/60fPix912I0RZNNS0rjZ+fgfQm
	mC/179Lskz9WNHbkd9KgFrzpL8oydhw+oi6356CkoMplf+HNPG4zDCzGHUddMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1743337432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iXUua0n2qyPzavE1+BdybGcZSsXWYWL87EJRkEHnm8=;
	b=nhnQb1qU5g/B02s/rFW/A4E+sQPfU/uoOHpmRbbVxJ1qDXgOAp/+kdY6RV/oP7rXxisSC1
	YjpB+h5hpse/kF04PbQaYHRD5eZ0R0c5F+Y/gQOPFMRZJL3RLaHNM3iTZamu5svqPeLs3O
	d57i+hydKoutxD2x+3tNsq23/vVZvcBFkWwyCgBh/75gx5QeVAv/vusKvSunw/EvcDAnkB
	IHiru30JAKweYb96zW3kbPtZmJQHf5GQmfh8IP5Esi67xgkFC8LwoM++5M4bJ6g9REJsCw
	o6GuCQwllWmv4XInIs/IF7dpkJkHV4G+ojwb/dOkkUVpGnyITI0tw0QzwlCONQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1743337432; a=rsa-sha256;
	cv=none;
	b=U80OMiRKKvL6HcmR75FWKsTCZnrGCYK7FMfSse84dx0waTA2EusVTaNGvKPGijJEXFSBqn
	mkhjYn8ZyKezlvC67svzW+DxzZIbfg6l3aJppIzu9cjiNMS3pj+op4LjZIcAy467hm3eLq
	lq6RdWNy1A6bYSfdyssetxjgyK0s1RxZyKUAGOWCYgRPENNrhkttEmapfjCYoS8kTKLRSw
	hqB7oQUWytDPYstP9vyVZ52aFpAWEvgeXXwx/u1z3+mF7uu5qZrdmef3EY8ycBaNXfw025
	XPjSkaWfxJANsp7qkKvfkOXnPKxKfyX4aMtYCXg76FWH0FpRKAh0JPzbu5lcYA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	kerneljasonxing@gmail.com
Subject: [PATCH 1/3] bpf: Add BPF_SOCK_OPS_TSTAMP_COMPLETION_CB callback
Date: Sun, 30 Mar 2025 15:23:36 +0300
Message-ID: <256cac73a03d6c46b81766db0a1c67cd3220b8f5.1743337403.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743337403.git.pav@iki.fi>
References: <cover.1743337403.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support SCM_TSTAMP_COMPLETION case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TSTAMP_SND_SW_CB. This
callback shall occur at the same timestamping point as the user
space's software SCM_TSTAMP_COMPLETION. The BPF program can use it to
get the same SCM_TSTAMP_COMPLETION timestamp without modifying the
user-space application.

Emitting BPF completion timestamps is enabled in separate patches.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/uapi/linux/bpf.h | 5 +++++
 net/core/skbuff.c        | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index defa5bb881f4..6cd918febcb3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7054,6 +7054,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_TSTAMP_COMPLETION_CB,	/* Called on skb completion
+						 * report from hardware when
+						 * SK_BPF_CB_TX_TIMESTAMPING
+						 * feature is on.
+						 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6cbf77bc61fc..9b2ff115eaf5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5552,6 +5552,9 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_ACK:
 		op = BPF_SOCK_OPS_TSTAMP_ACK_CB;
 		break;
+	case SCM_TSTAMP_COMPLETION:
+		op = BPF_SOCK_OPS_TSTAMP_COMPLETION_CB;
+		break;
 	default:
 		return;
 	}
-- 
2.49.0


