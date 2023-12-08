Return-Path: <bpf+bounces-17119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA2809EC8
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7ED1F2180D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5B11C91;
	Fri,  8 Dec 2023 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH6DXY8D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C66A170F;
	Fri,  8 Dec 2023 01:06:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d04c097e34so15036265ad.0;
        Fri, 08 Dec 2023 01:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702026404; x=1702631204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHJ+KYyJ1jZcwPU6L/9C8DimrQ09bt4oL7onSyu8iGg=;
        b=XH6DXY8D5gyFTslQppy+82NmXrapItp3XX5qEm+B80K8SC85UTAO/PJe/uanOA1rIB
         MhfxlsptXdYNOZdTC2yG6pcgrSjGahv69Uh7kU0yuskfl4VgI6OLO1MC5rfSh1ON/BMo
         WavjjOSgL0hV1QkN4QYRHibAkfrZgejcKavmta98kA5mJSZKupbKFa4eMGsgocWqn3B8
         xk67wpW+xgJoAug5ZNSZe8RkDeNpjradl2WWdvHpZnlwmv5wAU1N3+OFNiAA6Pvvt96e
         +NrZtvbugPEiRXxMk3mx2X480k2sOs35v6DU/vPcXk0vZTMJplcKgZB/AEtnuROw0U3L
         8fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026404; x=1702631204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHJ+KYyJ1jZcwPU6L/9C8DimrQ09bt4oL7onSyu8iGg=;
        b=LwCHn5OqdtKBnI/z+DN0GTz6SFr6Ry0tg5Q/AuaYIyfljcL2scV3YjjgPMk7pSK+U/
         HNtcIpnRNRucG180mdA9YLN8YiRP62Q9N0y9ICEs/mkLAzcIyCSY3PLLmT37bGWZOVX3
         VWIB+nwDIfqjez0Xd6/OJm77e6xE+ItfXDR6eEPoqbGgZeEO1H5UpYBt2F51upGebXB5
         E2cOvl69zuU727b1cJExPzRTUuC3jgGZ8f+j6M1Kx0ZEp/8kEAfZo1S1T6dssvI6F9wD
         ptIB1/cAJRglkScf5n7t4Wo61pdlvKAtXzw1p6AE5be/W1dXib3wb+rBujrllMWBJoxh
         yOZw==
X-Gm-Message-State: AOJu0Yy4soRU9INE1uLFmtW2cLhQVFQiSl7VIE5MmPJEixpU55LGKHbB
	skrKFEIuJv+coW1DlH9woVQ=
X-Google-Smtp-Source: AGHT+IGDD+5m4P7ro9+jd2WHzgWnxmWzxe8aGNd9wryRLo3x0jXWLZRXgUnqD7rwbEtBQ9pvrJvDCw==
X-Received: by 2002:a17:902:d54c:b0:1d0:6ffd:6101 with SMTP id z12-20020a170902d54c00b001d06ffd6101mr856123plf.35.1702026404515;
        Fri, 08 Dec 2023 01:06:44 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:4055:5400:4ff:fead:3bd0])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d057080022sm1188173plo.20.2023.12.08.01.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:06:44 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v4 2/5] mm: mempolicy: Revise comment regarding mempolicy mode flags
Date: Fri,  8 Dec 2023 09:06:19 +0000
Message-Id: <20231208090622.4309-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231208090622.4309-1-laoar.shao@gmail.com>
References: <20231208090622.4309-1-laoar.shao@gmail.com>
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
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/mempolicy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index a8963f7..afed4a4 100644
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
1.8.3.1


