Return-Path: <bpf+bounces-58645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3AABEEE3
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 11:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410A61BA6D0C
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65064239E97;
	Wed, 21 May 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgGfjdai"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBA2397A4;
	Wed, 21 May 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818062; cv=none; b=O/1Klax2zB1EyIKjxINwHmjdp+gPAX3zwELNhJfcDP1uqpRHvV0fEbpJxzrsMubtSuxO6AY4yL4lBKJBwGtKIpgmxb/CMflSJdRYLAAfHT2NU3wCusXHlnl+cUW/hLfjVt+ON3e1TM1psBnj52WD2aFDG1zq6kGthVGoPOEeuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818062; c=relaxed/simple;
	bh=CuiAzH8TWBQ6hsj1XQd5STMsT5oYgE3ZD+GMYGuQ7p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRqYCyYGCmkJKMd0Edk+B2/J3V6vzSp262E/1Qe8BLAFtgpB+JwQCHQqRCqmcY90DPgF4E0l1wUdHhHZJde7FAK8IZkxzddGgpJAVrHzH82APKULFhmvcaNoc0PsHzBPWAQTgo/OeROSOGM9dRM8+amWkSwdultjPPZNn7PiR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgGfjdai; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e93626065so4282300a91.1;
        Wed, 21 May 2025 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747818060; x=1748422860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N387pxHdVSd/OCAm1SX+gl4E1/rug0lWTP4/Ovt1H+c=;
        b=LgGfjdaiGUME4poUwEia3tju22NuUMR3gJ1Jj5yNsk5oHQ7F1HdqXrTVfZzAsA+Nqs
         PgpmK8DHW93vVNVJPR/4ed8lmMjSOlaVbxVWDXUV/jjTi86bRm9ZvFCGS/Ae6NQf4tiR
         S3qH5/C5eL0924hqAj45ZQLzsH9BJEulAs91JLwi/8RQ3H7y45ndLOUJK44pMJGuT28O
         icWxeMqh3zU/jR1GndMvp1bUiMAp0ChojcgkMeWbSziIHkM0P8zACbUmhTd42uOlzSpv
         4cj13F8qxFG3d540RVdIkwh7yZsxk9QyUSRTHNpIUBzbp0hBPMq3y58mk2X0mnSEfnms
         Bd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747818060; x=1748422860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N387pxHdVSd/OCAm1SX+gl4E1/rug0lWTP4/Ovt1H+c=;
        b=Id0ZVFDTZEdIXMevsCiK45CylLGr9qqpzGjzXi0sWYppaBU2zKE60iW/argy8yzyoq
         HKrBUmx4x1MCuf/Nw/0Btu2ri/A+VjMl9DwJYJybu6erH+O0cHWySbs7sQAiVQtMMxlO
         GuYYb6chcUmyGBVNiMq1XJJG57Vhf1zAn2ti4d2Pui8e8msPDwB6e5FGigxH3dBJrvn0
         N6zPgBFtPhXNPJZDZCJxa58erLsOOdM/chhwalV71iDsvPBiGJpyJ0x7FHK42Kiv6JIX
         p1BscD+gI7xWb9+SMLmRtd/jhhm9Pq6e96SwxL/+hLtpshW3y4biu5rKfom6TtDSOQLE
         h94g==
X-Forwarded-Encrypted: i=1; AJvYcCVgsfCh3OEk4MULdUeRuM9N7Jz9ZNkC5GkkqPPdxZLtW92BUb5vzhbSTAYbQXhOpgnWw3c=@vger.kernel.org, AJvYcCXOajifMMW1MfmDrzN3kG0jMmn3v4YzUdrimuLh8L80lXkkfHTUG3NhMFoyNavF6EAtxdZT/Ox0GNPUUnZ7@vger.kernel.org
X-Gm-Message-State: AOJu0YzETSLgjzW17/u8Yivk16gFAZ35VsmC7zlIDNCfIFSkwp/r1lUn
	3S9IFNmVbodEWmfosU+DewL5Pl7a5rAaSHLpYojA0/K44Mfj04QlsiMfdehsuQ==
X-Gm-Gg: ASbGnctCyD8uynPND664VC7tDkpvG+u51zLdkYDG7VFyNHVA06fcj8HUsDXfzzKWtbv
	5iwnwreFqt90vyk9qxT92Hor11HPn0b9gQpKr2735cTclDAHTjISrECsHNAv79/voyAeGHDg35E
	ka5StZ98FM8qx6BgfZKBjZKpViLPN/gPlL7pJ2+s9ie7qOa/I8M+hdgqJJ91cSYhCIFkyD3y/rf
	wo2pkmqrPFEYXKFgRuK4+GdEmKyqgQmkFIH9SJcZR4aqQT5isvGYWKkvQEE2bb0lNwJDZXe4b8j
	URwqsRi3vOdn++yLlQD/GwjHcKvUpoQyVNVW+52Oq9bu+ILDSUOUuHkYijug3FDPkQ==
X-Google-Smtp-Source: AGHT+IHsVrB4VaPypsN+4SUe+MXj56+UFYuHbv7zeRdMWmi8YxnssZs5wXVFVeeG89P0ORa0XxusUg==
X-Received: by 2002:a17:90b:528d:b0:2fa:15ab:4de7 with SMTP id 98e67ed59e1d1-30e830ebd92mr34998497a91.12.1747818059382;
        Wed, 21 May 2025 02:00:59 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:3140:a3fe:81b6:f3a6])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-30f36491625sm3170276a91.25.2025.05.21.02.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 02:00:58 -0700 (PDT)
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
Subject: [REPOST PATCH net-next] xsk: add missing virtual address conversion for page
Date: Wed, 21 May 2025 16:00:35 +0700
Message-ID: <20250521090035.92592-1-minhquangbui99@gmail.com>
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

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
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


