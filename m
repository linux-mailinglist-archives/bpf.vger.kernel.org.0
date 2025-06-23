Return-Path: <bpf+bounces-61267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4083AE36E9
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9BF3B39AF
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F41F8733;
	Mon, 23 Jun 2025 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EePG7Y2G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119DA933;
	Mon, 23 Jun 2025 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663909; cv=none; b=eiVYYgQ4NKNla4ebxHwHQJ9fVBFBSnMdbNYL0SamypFRGAZtrr5SdJX6oCuZl3He0ttwAHjFVViV8cYHtTeX3t9uVaYy8kGWrGCPcqKJRVOP57exOvswjSxzzUS2mDGzjPXfvnUM8z1VkpG9pqyXhxl/piyT6TASYN4rZXyH6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663909; c=relaxed/simple;
	bh=tatSYMiVxDQuiFN/8lK9mgqGhLJXxcq4PW9B4gtp0iA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o6DuFxjmiYADz1DJD+90R0RDZ0OZBpZXioaOs0f7630ilmHiShDGgc+xMJ38phHvOXD/K3v9AuVeMQaQJ45LGLeh128wBWP2uJRnghLsXdsjqGHUIpGm3z2XSWRS0oBDyv7j1mSiUR7ONJK0+4iKrQ0TSfDkLgF0q5ErNOGBtq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EePG7Y2G; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748feca4a61so2001400b3a.3;
        Mon, 23 Jun 2025 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750663907; x=1751268707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKqlD73KtZnrM0j8ZmcgZ2nLmQXVmAtPd1A7XT39n8M=;
        b=EePG7Y2GLwv/a5cdDLH5sNjjjqTu2HvfP1jqCJtR/kkfHBbtoYj2atS32WOkHRMIVj
         FHRqFkcj5h1+E8y8t5Gb31KFe+bOCMFxI2dCU8Pt/7W7D1pQIiB7MVZKJB3IWDg3ESL2
         KhWVwAxgYIeI/3fMJ/BEfdxgfIg46jEpvV50MDmcrGSFGsrKkGMAMwU9N+TbROwgpwQ8
         CGyyglmnWgemNkTNUMQmHMBf+A2KPlsJOyzlEySfyghVEIEuumG+PXIQq2KBQLXWXrB8
         x3bBKTcynCqj8AGM10+6pQfife9RVrA964Bp8y1yZImQzO/04Og02d6z2NeZBxdzGCV6
         melg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750663907; x=1751268707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKqlD73KtZnrM0j8ZmcgZ2nLmQXVmAtPd1A7XT39n8M=;
        b=raqQb1roCemC56MJWrjxxJlyCDdLH8ieT6nqU6sFNotGs0poUJ16Ew+TOsIIQUHbDu
         8fU3tdX418Ks5RyiluKhgOmxNrDAXhPnF8cT6fhgvMXNonLMdQrjjF/NBIJCXPT+/5B1
         TE8hzdAf058w4XOWl4P28gNQ21m07pfHKAwXk2zSawMvRpn5ASY5ZxXFBBMcQ0NtGfLK
         LPNZA1MjdkWYJuougKvlbgVznPBMI5jaUGYJvOvLSDwNEpNGd6oE9jq/MGXNJ6NF/vOf
         tmDcV2ZGXgsGDSc28AXos8Ns1FVeQvPbStsm6eq2VHSFvcd04LG7gubl5d1Lgt1BQNQO
         C/gg==
X-Forwarded-Encrypted: i=1; AJvYcCVcr0HJJl7NYNJw5tg7fAuxM48omQX/6ODSVStGRN4/2GPOv3wZNFPhxguybQLWnSF14OxzZSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGF2GJ1eqRcNZ8eYlLqvUuuXooQryDc38HydBRUGy6RUSgOOw
	izQOf5dXBoULzBJx6HxZ3JE6KAbot3QIOm2LWZWJNkgETVigLGgk2oJj
X-Gm-Gg: ASbGncuy5cLEYsI0qDxX1TZQqwCj2SQY/mMQ34OEIWNZqIhMbCL2MLWuUOK4nftf7ez
	/fFzXmIxDJLAnoeG0vLxod7xXt0sYYpiQDgy2Pvp9LWig5wp0Fagsdp4jLbgHO1MSNHAdIq9SGU
	4VabLW/XLNTu3ka7Hv4uzDTKaX4PyE/CNBzOo1mgqsk2zW81mTzvtnGKlb7O25f6Idu+9JDLMaL
	b3HReHrS3zMs8CXYmAcr1gnRqYvtJxq5x23gmK7rar2Hl4jaF7U135z4sF4jnGIaC6CaJ8eXXkI
	uWZcpdNWWcwqDHZaddKZUaPTxpzdTz9qbsa0tHsQleTD51t++qZbuUhGIJ9UshdKRJIu425VhP6
	rUObdLBmYZTjv1yrxOdneSkbCtGUxh0kkIA==
X-Google-Smtp-Source: AGHT+IH52PfXstiysUB1iqUOsJyYb62U2tQw51gl4gWLGGDnvKGK410yIodIcmev/67J0eQ5wPPcKA==
X-Received: by 2002:a05:6a00:2e88:b0:742:a77b:8bc with SMTP id d2e1a72fcca58-7490d5c1d0cmr16726775b3a.2.1750663907235;
        Mon, 23 Jun 2025 00:31:47 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1241f4asm6005315a12.44.2025.06.23.00.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 00:31:46 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] net: xsk: update tx queue consumer immediately after transmission
Date: Mon, 23 Jun 2025 15:31:29 +0800
Message-Id: <20250623073129.23290-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For afxdp, the return value of sendto() syscall doesn't reflect how many
descs handled in the kernel. One of use cases is that when user-space
application tries to know the number of transmitted skbs and then decides
if it continues to send, say, is it stopped due to max tx budget?

The following formular can be used after sending to learn how many
skbs/descs the kernel takes care of:

  tx_queue.consumers_before - tx_queue.consumers_after

Prior to the current patch, in non-zc mode, the consumer of tx queue is
not immediately updated at the end of each sendto syscall when error
occurs, which leads to the consumer value out-of-dated from the perspective
of user space. So this patch requires store operation to pass the cached
value to the shared value to handle the problem.

More than those explicit errors appearing in the while() loop in
__xsk_generic_xmit(), there are a few possible error cases that might
be neglected in the following call trace:
__xsk_generic_xmit()
    xskq_cons_peek_desc()
        xskq_cons_read_desc()
	    xskq_cons_is_valid_desc()
It will also cause the premature exit in the while() loop even if not
all the descs are consumed.

Based on the above analysis, using 'cached_prod != cached_cons' could
cover all the possible cases because it represents there are remaining
descs that are not handled and cached_cons are not updated to the global
state of consumer at this time.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
V2
Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
1. filter out those good cases because only those that return error need
updates.
Side note:
1. in non-batched zero copy mode, at the end of every caller of
xsk_tx_peek_desc(), there is always a xsk_tx_release() function that used
to update the local consumer to the global state of consumer. So for the
zero copy mode, no need to change at all.
2. Actually I have no strong preference between v1 (see the above link)
and v2 because smp_store_release() shouldn't cause side effect.
Considering the exactitude of writing code, v2 is a more preferable
one.
---
 net/xdp/xsk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5542675dffa9..b9223a2a6ada 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -856,6 +856,9 @@ static int __xsk_generic_xmit(struct sock *sk)
 	}
 
 out:
+	if (xs->tx->cached_prod != xs->tx->cached_cons)
+		__xskq_cons_release(xs->tx);
+
 	if (sent_frame)
 		if (xsk_tx_writeable(xs))
 			sk->sk_write_space(sk);
-- 
2.43.5


