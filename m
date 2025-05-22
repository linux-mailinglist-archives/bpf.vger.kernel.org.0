Return-Path: <bpf+bounces-58710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC5AC034E
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 06:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845D07ACF5B
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 04:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83EB1624E1;
	Thu, 22 May 2025 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grjSF6bL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5A184E;
	Thu, 22 May 2025 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747886529; cv=none; b=pkCxAt9fAfBg8YuNj/xgO2iTpynkG2OUcG0bOhBhh/k9V+0OvtiVXAqyLKiuOTK5sw4bS2cxActRjWu/zJQpVrVe+/3W8/mkzEVw6uq3MM6rZGx5Djd3NLlLI0MWZJuY9yN7kRTgbrmns8Cf+6ui9ly6UkZ6vrGqf6oKx43NotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747886529; c=relaxed/simple;
	bh=VaCm9odT9ZRMdbNFJ0psuY8WZxzOUA90QWzgpSQSWew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=guuI8wuJcogsNXZWauDeyed6NOiiwhG0c5nAfWrXDH8VZSCkG1CsyY+WoFokIgogBU7OTC+nvX8Xm60/U++c0NK2NM+OF2RUkHgUJHoi4GbcfCQSZajxCdOmpMw7prxFaxXiBC7MQK7G2pjZsHS63RJkkKT5c49w/+CRKNZfSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grjSF6bL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23211e62204so36694975ad.3;
        Wed, 21 May 2025 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747886526; x=1748491326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZhUzfOUEweTXHf5T0hPVYO2QZbak8VcGiB8Zx0TkCQ=;
        b=grjSF6bLDdJl0xSQUo/0exCd/+roUR2k+yClevT11Ce1OEgqGYE6Lf9mhveAVCVi4q
         Hmb5tt97JyvojuvWK4NKx8lI7+/ME3xq4q1i6B7IXLy/tUPau7NtRXYhvVXxefljNAYU
         mtkGQGux1poMOz+4yuZHeT3MI2QdBj31/q6CtlWd+bS+W8zgVfxJHyi7Q/HNByvIPKbT
         l+qwSH8Bpi9LnTayJU882noMqurQVGC3/6O4rhhcXm/7M7DOPkPRYzIlbH9g/wmcUHa1
         G69UWG2xjyx/tUfw23P20QgOyV8Sufd/xUM45ibqKLs6xqHzhff1jUVfSE0qRzsQyYYV
         i6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747886526; x=1748491326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZhUzfOUEweTXHf5T0hPVYO2QZbak8VcGiB8Zx0TkCQ=;
        b=XYafQb/0BVWDgRgfLMEDJ6/nzVznQ0M4nvw0OaCjEn9E/TdnvKY2+fQSUQ4Kxh7STR
         wRFqLliePcG1ksv/RbXFZjKBzYPKe51jQak2/bYqCzhzJA7CRLnB9r0lDM6ATW54if0D
         P93AsGWKG/mlFHLCSm3bhxoAgP56U3WALKJXOyMXYEgHxZE2ANmxAqwfwH4aLPBGdYXP
         O1UXD/9rFgVO6PCRvUKP1UWJ4L+joK8k3pvXe9maVE/pkYzBSGwWBPHgQ2qPIuDJD7RB
         V1YTbCg68Wpk1wcW9We8NUisHRptLOx3ztPSSMYIlRWxI76Q/b40lgM8zRCrmPP1YoVd
         CeJw==
X-Forwarded-Encrypted: i=1; AJvYcCUsxyG46gZ8sOsBseIH0UN1TBq7hq01BrocFeaw7Vn1eMWCGR4DFPXcbvwB2jy2ANkB7kQ=@vger.kernel.org, AJvYcCVg8DU5q/n86XM3Ee2AxOiuG4nud1tE018T144TI/F6+NpVm9uFRGhkYBOIA3q4EkezCFFMvT+AHtJMG5Xf@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfEETt+Jc6bIHPeGE4RThFEtd883GDUzu1nlee6Ofd5bPLT/D
	u1BpI8Asc9NS6sKM9w+OMPOSa8ISyPLBlQzgCXAJ/gbK86jtYmXdqPsBv7nGCQ==
X-Gm-Gg: ASbGnctybxOCYGdlcDaazO/Pxa8MIzoPyR7YQcUOsSHk5kJymjbTJa6GB3QknOizZBN
	XseHibN9od61UAOkTIDpQwxCEJohTixAS2eCbxI1LTK580uHA/KZ+dGilcpwg7PrSQemmKxTFYK
	KrP6djho307JwIGcKyrC9qXSyTloXz3KHUSCPF3mWvnDNlQ7dmyrMEXIgpE0HHBt5LB8zXVptA/
	UeHikpfbee1hV3nGT7vG50qgkeXyBrfxpGkEC7b0sVG855HlBr5VDy6iW9sH/U+heX8mxDjqs+a
	iBwvEcJtitBeKS0bLhTTBhGqiAy9y4uxHuUAvbOcw+kR+AlLkTuAYw8mLawcZPNRfNM9Ld65EGd
	g
X-Google-Smtp-Source: AGHT+IHN4e8t0B8D9y55dtrTUEzkuMGlnFb8gkeKQPNLgOGCM3vx8v2UVamtSCZqaJLxtwmhUS6DIA==
X-Received: by 2002:a17:902:e74c:b0:231:d0c4:e806 with SMTP id d9443c01a7336-231d459a971mr360062605ad.32.1747886526384;
        Wed, 21 May 2025 21:02:06 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:e79e:1a85:fe3:abe2])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-30f36364f9asm4532890a91.4.2025.05.21.21.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 21:02:05 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v2 net-next] xsk: add missing virtual address conversion for page
Date: Thu, 22 May 2025 11:01:15 +0700
Message-ID: <20250522040115.5057-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 7ead4405e06f ("xsk: convert xdp_copy_frags_from_zc() to use
page_pool_dev_alloc()"), when converting from netmem to page, I missed a
call to page_address() around skb_frag_page(frag) to get the virtual
address of the page. This commit uses skb_frag_address() helper to fix
the issue.

Fixes: 7ead4405e06f ("xsk: convert xdp_copy_frags_from_zc() to use page_pool_dev_alloc()")
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Add Fixes tag

 net/core/xdp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index e6f22ba61c1e..491334b9b8be 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -709,8 +709,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 			return false;
 		}
 
-		memcpy(page_address(page) + offset,
-		       skb_frag_page(frag) + skb_frag_off(frag),
+		memcpy(page_address(page) + offset, skb_frag_address(frag),
 		       LARGEST_ALIGN(len));
 		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
 
-- 
2.43.0


