Return-Path: <bpf+bounces-15649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F47F48B4
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAB02815A7
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA0D54FBC;
	Wed, 22 Nov 2023 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax5lL78t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C718E;
	Wed, 22 Nov 2023 06:16:22 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6be0277c05bso6108714b3a.0;
        Wed, 22 Nov 2023 06:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662581; x=1701267381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1wPdyu7ENjoKkwP42urAAujwzKPPcBKgK7aJbdTPeE=;
        b=ax5lL78th+Z22g/QoSweLLbYNQSWAEnGgTrbugudd31M8Pe8dgxUS9Izib712edpTp
         laj6FClvm6F58PQtRG9TmRwLVy3P+6J5NeR7Fc/SDs3KD0wwggNYTp1ldVaJ7dHPzJbs
         l6Cr0MUMBX+s85eCvC0Ew1NjIuI1C4doSpDeWZq2B8uyuRnl5YiL2msRw7iHoXG4NdZE
         RdAAC9tEHSpv0CRvqgzcgv0aCs73O5lcuNvC9J5xpNNcN3jPs+MknjBydJ4qTjhEuZwi
         aXkTEK8G5N0DNOn9nmtQJfUsV/mqOlzyiC3sLA2AKmg0SbG+15jEmqYZ/jIw/3GhB99C
         cnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662581; x=1701267381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1wPdyu7ENjoKkwP42urAAujwzKPPcBKgK7aJbdTPeE=;
        b=P7l/bqth0m0UAhToEbSA8iCA739Jd4Bb2BixOmDm6ee2VyDtXi7Oiojv8C4lcRvdVp
         nYyEMcb0pizZN/VAGtezlmATEctIsImaTbHMguKoN4C26hMyC4wiazYtQOxwT8QAl9Qu
         3FnlCE0dgdv6/3/UBOuZHusykTISbwTAtnyxagVATSrRAsLCU6EvIrJd+Ej9bqRdA6tF
         MNm8j/sb1nVOZR/LNq4ypXRig8jWuvtxFuQWjh2rDrCAvNU+TnC2NVP3lW7tnyK5hA8H
         lfs5lcm0ZDqllyJ6ElUEITgdOdfr+YjXtUde3/Yd8V3nUC3uhoOcJOrXfNskGOrpYQMi
         GhuA==
X-Gm-Message-State: AOJu0YyVjVgogNawburcyffpHBwD+ZEFIbsWYLVSOiBgeF5ilp8TAvUb
	qRZRQcxh0txpvrVq+RVu1GY=
X-Google-Smtp-Source: AGHT+IE6MKBa9DH0DLtzNahG0PY3BEbv8SQ3K8eKqp+aMh3wCYdSUNsYu1dxH5w+xaX+5VuH6wLbEA==
X-Received: by 2002:a05:6a21:33a4:b0:18b:4a28:6e2d with SMTP id yy36-20020a056a2133a400b0018b4a286e2dmr1310481pzb.22.1700662581452;
        Wed, 22 Nov 2023 06:16:21 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac01:a71:5400:4ff:fea8:5687])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm9356260pgh.90.2023.11.22.06.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:16:20 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"Huang, Ying" <ying.huang@intel.com>
Subject: [RFC PATCH v2 2/6] mm: mempolicy: Revise comment regarding mempolicy mode flags
Date: Wed, 22 Nov 2023 14:15:55 +0000
Message-Id: <20231122141559.4228-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231122141559.4228-1-laoar.shao@gmail.com>
References: <20231122141559.4228-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES, and MPOL_F_NUMA_BALANCING are
mode flags applicable to both set_mempolicy(2) and mbind(2) system calls.
It's worth noting that MPOL_F_NUMA_BALANCING was initially introduced in
commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
nodes") exclusively for set_mempolicy(2). However, it was later made a
shared flag for both set_mempolicy(2) and mbind(2) following
commit 6d2aec9e123b ("mm/mempolicy: do not allow illegal
MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()").

This revised version aims to clarify the details regarding the mode flags.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
---
 include/uapi/linux/mempolicy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index a8963f7ef4c2..afed4a45f5b9 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -26,7 +26,7 @@ enum {
 	MPOL_MAX,	/* always last member of enum */
 };
 
-/* Flags for set_mempolicy */
+/* Flags for set_mempolicy() or mbind() */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
 #define MPOL_F_NUMA_BALANCING	(1 << 13) /* Optimize with NUMA balancing if possible */
-- 
2.30.1 (Apple Git-130)


