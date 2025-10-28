Return-Path: <bpf+bounces-72570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA674C15B0B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A99918872E6
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB833F8C6;
	Tue, 28 Oct 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QbLLyE1Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D9Fu0wwY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QbLLyE1Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D9Fu0wwY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE61E32B7
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667335; cv=none; b=Hz56+tf51m9csQhb+AxavWOB0jmA2yleeakDLpMYF462ULIe9ImpeWVyWHtZAzY+H2AgxRb3tscqIGlmEBfzh4JEoRl+gnFOoeQrsD5Kw2nivZDdXMTratiBTPA2jcZg1wFU4S5Mtc5Mdoe7og4GCdXvZrD2cwsEWf+qwZV0EBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667335; c=relaxed/simple;
	bh=IQqgr56VnqqoJH2XbmtP0P2sPZiMxcHI5vQuBMWXJHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1drRE60sSEApNpW7j8F7Bu7KfmQxwzMndqfkQW4tfT551gZOrvxjWcXsIE/jJSeuDkxUuaHwCNjuDZVG2AY3Vm+tu1BsmZnD3TiMit35lYgfRIw8AK+359sdWgWzTl7CDs7KNe5ah6G+3YFC89VDxP02QUjI3FbkCsdxOyFLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QbLLyE1Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D9Fu0wwY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QbLLyE1Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D9Fu0wwY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1395F21A59;
	Tue, 28 Oct 2025 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761667331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QLqMRxznrznj5saAZz1t3wSWH/zx3hoK1Q8mQRVXN4E=;
	b=QbLLyE1ZRFlgfjuVO36xVZWZKorxCVZJXWN4Lt7dPqiFPfQ6A8Ks0PQEq8GGNRCnHrvSek
	saP1U8MH7MQk3UUr4ZYP4HGjXlmoDsTgfuueEZ1rD4o0Ebp+ASHsTxGoXFylN2VwvPNhTt
	U+/d1gOespvLm4nAZl84VAMLep0Vn9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761667331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QLqMRxznrznj5saAZz1t3wSWH/zx3hoK1Q8mQRVXN4E=;
	b=D9Fu0wwYInwY+80SPsoGnWcokRpsN1ZZY877JchHqP9Pw+nuDV/hI6ZK5HFAnpBJMfEXne
	cd4C23h09mA0q9CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761667331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QLqMRxznrznj5saAZz1t3wSWH/zx3hoK1Q8mQRVXN4E=;
	b=QbLLyE1ZRFlgfjuVO36xVZWZKorxCVZJXWN4Lt7dPqiFPfQ6A8Ks0PQEq8GGNRCnHrvSek
	saP1U8MH7MQk3UUr4ZYP4HGjXlmoDsTgfuueEZ1rD4o0Ebp+ASHsTxGoXFylN2VwvPNhTt
	U+/d1gOespvLm4nAZl84VAMLep0Vn9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761667331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QLqMRxznrznj5saAZz1t3wSWH/zx3hoK1Q8mQRVXN4E=;
	b=D9Fu0wwYInwY+80SPsoGnWcokRpsN1ZZY877JchHqP9Pw+nuDV/hI6ZK5HFAnpBJMfEXne
	cd4C23h09mA0q9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 879C113A7D;
	Tue, 28 Oct 2025 16:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RpYSHgLpAGlcfAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 28 Oct 2025 16:02:10 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	kerneljasonxing@gmail.com,
	fw@strlen.de,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 bpf] xdp: add XDP extension to skb
Date: Tue, 28 Oct 2025 17:01:59 +0100
Message-ID: <20251028160200.4204-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,gmail.com,strlen.de,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

This patch adds a new skb extension for XDP representing the number of
cq descriptors and a linked list of umem addresses.

This is going to be used from the xsk skb destructor to put the umem
addresses onto pool's completion queue.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: CC'ing Florian Westphal in case I am missing something
while implementing/using the skb extension.
---
 include/linux/skbuff.h | 3 +++
 include/net/xdp_sock.h | 5 +++++
 net/core/skbuff.c      | 4 ++++
 net/xdp/Kconfig        | 1 +
 4 files changed, 13 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fb3fec9affaa..1c4a598b6564 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4910,6 +4910,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_INET_PSP)
 	SKB_EXT_PSP,
+#endif
+#if IS_ENABLED(CONFIG_XDP_SOCKETS)
+	SKB_EXT_XDP,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..94c607093768 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -120,6 +120,11 @@ struct xsk_tx_metadata_ops {
 	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
 };
 
+struct xdp_skb_ext {
+	u32 num_descs;
+	struct list_head addrs_list;
+};
+
 #ifdef CONFIG_XDP_SOCKETS
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6be01454f262..f3966b8c61ee 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -81,6 +81,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -5066,6 +5067,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_INET_PSP)
 	[SKB_EXT_PSP] = SKB_EXT_CHUNKSIZEOF(struct psp_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_XDP_SOCKETS)
+	[SKB_EXT_XDP] = SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)
diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
index 71af2febe72a..89546c48ac2a 100644
--- a/net/xdp/Kconfig
+++ b/net/xdp/Kconfig
@@ -2,6 +2,7 @@
 config XDP_SOCKETS
 	bool "XDP sockets"
 	depends on BPF_SYSCALL
+	select SKB_EXTENSIONS
 	default n
 	help
 	  XDP sockets allows a channel between XDP programs and
-- 
2.51.0


