Return-Path: <bpf+bounces-34942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD4933671
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 07:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EC91F21BAA
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 05:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B5411C83;
	Wed, 17 Jul 2024 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXMwFMxY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC18D304;
	Wed, 17 Jul 2024 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721194552; cv=none; b=ljh1te1U1bbohGnptxTYVOBIL3lVTUE/K4qAX46j3sLj3DugCIuTWRlyKxhWHHF5WKrueGhwR1543DzZWyhl/uv/h+hKjwQd99gJMPDOWF4KLJCMJhReZb1CUMSm8GBgO9VA0OwbM5CsudxDrOVOkQowdMtW34B/C8vB9x4xy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721194552; c=relaxed/simple;
	bh=JdlWSKlUZcf/O3X+mP9Ak6MuTf6FmrnmQ6Kg5GRRH8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzyphLkXJVXIONS//QBtTQPTnp/TueSoXcfch78cOYfKR1/+qdgrnajPBS3GY689opMlloqooaeMk63U69GNZxm9+sT4gKStYbFMrr87ST2ilnQxk+XyEJZWr9w917RY6D650sHoxtBAHuDX8w8h1XzFNNy75PciYN9WzTL6SAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXMwFMxY; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-75c3acf90f0so4366129a12.2;
        Tue, 16 Jul 2024 22:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721194550; x=1721799350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMXnWY9HVVFA+WTMwKlErlT8MSINlsWptZs/Y45C1Vo=;
        b=SXMwFMxYJ/T4sUk8MIYThshlOIfsxHAatxyTtY1Nj5D6cs6tzUCBpzlEcI1/EJSutj
         u2nTcsxcIu0VF75ck0MjQKuU5NlSuPom3tS6J6kESJnyf7oFPPQjRcq0YZ6BcQMMmKUk
         0TIYzRggwTz9tlvPZIDwrf/Mbz/fH3v4Z4akANrH7Q1xmDHowy8UW6r25dydk2VV7NLO
         yIAdojF0YuiprDJkaVyzRk2VKTkVRYKOzmDaSnhbNsFbu5o38HSMfvWP4GGABifwyzBA
         aR1nKnFincGX9R3QMQmYUGiamnmQYtqNVvqkMAP7gEvIF8IfucgV4L2REXnlviBIaXE+
         AL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721194550; x=1721799350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMXnWY9HVVFA+WTMwKlErlT8MSINlsWptZs/Y45C1Vo=;
        b=ufFc0Y3oQb5hzOFWSFCBOFa4GbUd64+BLZMzCqoolpzAnIbDboSFvGbOTBLw4iOrbK
         w18to6buwI/8ZyLuKJxGX+HX/vEv2cbF+WZg/Cdb1qAfdmZCfjs5mbt7pIHVqTirO8vk
         5HUNDJ0+KpcGyWk4XIN5KTnbwrlX4eSNtNAzfuNXgip3POOsqTi6ySGizKKbvqNYwz/s
         iz4LY+XPWAy++/uMqkhu4LeQCxjmjx1Sl00V5+PvczNQ/nPiUs7gH9qSGCczedNVYj05
         43+vtXKGzXolOTHh+SIQLmjjPFbntYzUpzgIiK3oOazTcxYhcnIT44Z/yTHDsJmF91zs
         fHTA==
X-Forwarded-Encrypted: i=1; AJvYcCW3SLcGHCmBbz1K4+gQm4l4xbewoOZMQtIblZPFKYMoBYIMiuHuBe8lHOk4jYv28ABgT9iq7lU8OETPfpMMCtMfWxId6GprLuNAb+d41ysyyhsxGmjeeAaoe9OrO10eXYCxIA9b
X-Gm-Message-State: AOJu0YxrCG/i4CSnZFw2HUy09fb94HHVhqhTIEO5cqNRbcVLAyuou8An
	PKidKV4WDUPjwiP+2xcMQ1g5oZQgM0xHxdXVQAq1aVLBN7zpeZ04
X-Google-Smtp-Source: AGHT+IGuwLTo6i0e1lP9M7fxkpUztlByON3nEWR85eFnZ2JdQrNR8fNKWb9M1P9kyYD1RQTO/z7k3A==
X-Received: by 2002:a05:6a21:33a6:b0:1c2:5fa8:2dee with SMTP id adf61e73a8af0-1c3fdc51804mr854951637.12.1721194550231;
        Tue, 16 Jul 2024 22:35:50 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:29bd:4b19:171:4fc5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedcac0ddsm7209140a91.52.2024.07.16.22.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 22:35:49 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	herbert@gondor.apana.org.au
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	Fred Li <dracodingfly@gmail.com>
Subject: [PATCH v3] net: linearizing skb when downgrade gso_size
Date: Wed, 17 Jul 2024 13:35:40 +0800
Message-Id: <20240717053540.2438-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linearizing skb when downgrade gso_size because it may
trigger the BUG_ON when segment skb as described in [1].

v3 changes:
  linearize skb if having frag_list as Willem de Bruijn suggested[2].

[1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail.com/
[2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch/

Signed-off-by: Fred Li <dracodingfly@gmail.com>
---
 net/core/filter.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index df4578219e82..70919b532d68 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3525,13 +3525,21 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* Due to header grow, MSS needs to be downgraded. */
-		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
-			skb_decrease_gso_size(shinfo, len_diff);
-
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= gso_type;
 		shinfo->gso_segs = 0;
+
+		/* Due to header grow, MSS needs to be downgraded.
+		 * There is BUG_ON When segment the frag_list with
+		 * head_frag true so linearize skb after downgrade
+		 * the MSS.
+		 */
+		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
+			skb_decrease_gso_size(shinfo, len_diff);
+			if (shinfo->frag_list)
+				return skb_linearize(skb);
+		}
+
 	}
 
 	return 0;
-- 
2.33.0


