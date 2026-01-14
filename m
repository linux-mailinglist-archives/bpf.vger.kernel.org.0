Return-Path: <bpf+bounces-78918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F2D1F3DE
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 14:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6880D300F240
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E571280037;
	Wed, 14 Jan 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibXeNwcV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2C275AF0
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399023; cv=none; b=gS6aqrKFB2QUcXwG0HdwOPRe8EGereMjAmE9Q1UfFIU2PmdvV/to1tKvyBj9+QiKnLlDz4ZFvKxz35vagNRo4ZnsZslMLS4LeSvjFIJJ7PcJoulff0kAeaYO2nilCkf7nYJ9HFX64q7McilNFPW2u74exyJJsdHnty68KD0wyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399023; c=relaxed/simple;
	bh=TYxf7SZnQ2eEGK0g388oPVoYS2/SRCR4lOTK0KL9wn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCSTOUgIB/j6/e67vgr2gu2DXfoQ7Y/wN3mbP8/1f2HzTAIaM9Bmu8vRaHnlY3TA5iAFeBJce7I9cCnzOc1/OGvWJROPffZU3cZawghAtWCaIuPMber8kf2rQpxWEoUP873d9c5+MeYeHEUhyBO8AkdIeoWn4+xLC582Wl6wiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibXeNwcV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso3342763a12.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 05:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768399021; x=1769003821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqt8eQM5BNypt/9I1/zzKIKkEegYbz84TqkLhVtJnT8=;
        b=ibXeNwcVZAN4GCD/BMvJb+pVZ8x0Tgzz8xIRsuds/YKTBZ9VBms9gLwjlMAFQ+z25U
         Sh7r8sc56U2CF3Y2RbbH2R5YpSKOcsmRP66OSIWTH0zOK2S3M7Qar4YXTQteSv2OxlZe
         lAwYbYAf2ypwPVbikZ+mrriyk14/I4Pi+9Gn6djmjSP0fZCxLqjiIKSd6+iWjbL+i/aQ
         DMT92ysNBzSxCUd9LZLeWUJX720YHnjNtTmAchM4sfFZK5raAaMAdfqe65PYdU8HatgE
         L/ECHtZcXWqMlxobaW91cFbYwgNaxbcB/GhvOhSyS2ieZt0FxeBlJ9ZkDSm7xgKxk54+
         QKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768399021; x=1769003821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xqt8eQM5BNypt/9I1/zzKIKkEegYbz84TqkLhVtJnT8=;
        b=Fc/K/w7x3MpjySSn0usL3jyVL1P5ZBs4yn64l9rbk0gRLpv4SO/Rw1HFRPHB+9+PHO
         DuE+K3FiWxjDircig0hkwA7JDJvjcIG6zEU3GYerVVporTEEFMm0cPPH3bfvAN6KSTIq
         mrvGFioaoM4p7Vt7fw/mfJ0b4s4YdcQWkGHiGUbo+cD2LWnlksAXjoFW7z3KbSITpPqm
         Z+ZadR6adIOkD9ZKMyEO3TubvmqbqD+iB5dacCk6YnmJdViqsY3nYqfR0vQd+9wDIcbJ
         fPxVlFQo7QertifXhxVUphjT0WPZnws4ahUU3JEIJjf7tXiiIHH1hptRL2aUPjlruE4y
         bgMg==
X-Forwarded-Encrypted: i=1; AJvYcCUea6PIX0lDshQph7C7h1jMgPGdYqjBLN8woUFYHfcH0DtH291UVYYROcaff8YJKXrQbDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZiWUJxIOHBLrB0+7ee+h1jusWi3aw/LSJPE5G6DcFbX8oIBZ
	LwePMmXZnQ1FEpY6ElzTKfZqiVkrwdaRVn8djvPzZMtdgv/aMP8Cl2jk
X-Gm-Gg: AY/fxX4Qlzzasu6AklCrPm7to1AH8t/RCucaLrYBZR070dKiybb4t8q9VNeFrT7Tk0F
	wWS5kR2OC4rAET4gwPtznFj54YrPQE/m2qG0YjH5lbhlCpQ3XB3kJZPsgzZHk61yDSWUkk6nq7H
	77NvouxCPD9VH7xKqHWkjkCg5ZF61/wr3uTyGrfPwaTquMPizmf99iV6Fv2vblEEAypiOCJGo4o
	+yu9yKEKJ6gccKQt7zhajTVzIvblw55rk7bOe/u17KYD3yOoLEO2L3m5QHaj2gYA2W1F8QYDt/x
	TCc+INurGxSURGWbBR18LE7UnZ8I3s1VNvpIcw7CiBO9nTo8krAG9RSiCAepKDv8c6dj/Qhnx3a
	BVFV8WX+n2cezYAJCCP40kwBIh9VfzJJaFsA5/NAPvaO//7hS21qJOBs1pzKIuQ/EwJblFo5Mr6
	Ro2WJHn3rD/9vyRuUVTDg=
X-Received: by 2002:a17:90b:4a46:b0:341:c964:125b with SMTP id 98e67ed59e1d1-35109177bc3mr2421622a91.31.1768399020900;
        Wed, 14 Jan 2026 05:57:00 -0800 (PST)
Received: from soham-laptop.. ([103.182.158.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109e7ee68sm2101653a91.17.2026.01.14.05.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:57:00 -0800 (PST)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Soham Metha <sohammetha01@gmail.com>
Subject: [PATCH] net: skbuff: fix uninitialized memory use in pskb_expand_head()
Date: Wed, 14 Jan 2026 19:26:43 +0530
Message-Id: <20260114135643.17484-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6954bc70.050a0220.a1b6.0310.GAE@google.com>
References: <6954bc70.050a0220.a1b6.0310.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pskb_expand_head() allocates a new skb data buffer using
kmalloc_reserve(), which does not initialize memory. skb helpers may
later copy or move padding bytes from the buffer.

Initialize the newly allocated skb buffer to avoid propagating
uninitialized memory.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
#syz test

 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a56133902c0d..b0f0d3a0310b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2282,6 +2282,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		goto nodata;
+
+	memset(data, 0, size);
+
 	size = SKB_WITH_OVERHEAD(size);
 
 	/* Copy only real data... and, alas, header. This should be
-- 
2.34.1


