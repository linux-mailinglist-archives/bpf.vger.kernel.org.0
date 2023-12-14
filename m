Return-Path: <bpf+bounces-17818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDD813095
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A8628318E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ECD4F5E4;
	Thu, 14 Dec 2023 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/+tXeXa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0317C11B;
	Thu, 14 Dec 2023 04:51:45 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d0ccda19eeso48529555ad.1;
        Thu, 14 Dec 2023 04:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702558304; x=1703163104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHJ+KYyJ1jZcwPU6L/9C8DimrQ09bt4oL7onSyu8iGg=;
        b=Q/+tXeXaKkgpfcse1ngDpsoFbG7qOrPkhMmOP9qgaQazvFZwoAOhA+zORaPOlw5d2u
         TVG4cHhbPoxqkoU6z01QTgidcZMSGcOFIALU41EsS4B6XfxjUxP1AcbiqjKoZU/yfbmd
         ZaLCDxmyYfmNimsH+whNHB+Ox9cHTeyQwbCnrxKMV9bh9jgnYNLsQ6FhLaKpMu6myayM
         5bTIUIw0/UaI5zZ/7VFtF8b/EHy8JMKpTNsty923bOnrQ54oVmGSpofQDWnx8mdz2ZRl
         FoSbz5oUforam+LpZCAL0VprF9myubhSZKjQfTtihitwy9m0dh/XQI6Sx6uElufyfoVO
         50+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558304; x=1703163104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHJ+KYyJ1jZcwPU6L/9C8DimrQ09bt4oL7onSyu8iGg=;
        b=ZQeFe2jjs63Cmsr7Xl6n3zyVZ9Tv5UKbL6px6IRp1wO+twSdMcamxPtTVAc+X+N0Ka
         TPXH691YkbXLYk4MkudkHrmN1FzDZtswyOYS+y25shtxlgiQItL8177vk1veYzE34V9d
         9TtvyHTQwX4E47p4CiaXqsEBZX6gsAXJtCrVjIWh46sJtOOSMLt3Xky4P9s4VY8L7sLV
         89RtRGZd791grzrXuWweRkRGqp2ghWHel9Ii//8OcJ++pPe/sW0+rScmig+VXAFYbCjv
         /tzekdN24UNOWJ/Fjxa4l8rsuwUNYXFRRrjAf2ZntRlgWHk0SHik+B+I4NC4cAFapLXf
         oftg==
X-Gm-Message-State: AOJu0YwcrbSJlLzWkVBpSySrFfptLS3/0cj0rf7JtCsp/i/BCXWdgfaE
	R3EUVBjmF3PhnN3yf2UZgNY=
X-Google-Smtp-Source: AGHT+IHJCfmGa/OQsAmV/JJqlMOqa+7hR321uAICGK3vb14T4CyiXYT6mtyWpONo4B+Q9E+Y2wuXOA==
X-Received: by 2002:a17:903:2441:b0:1cf:aff5:8934 with SMTP id l1-20020a170903244100b001cfaff58934mr5418252pls.48.1702558304467;
        Thu, 14 Dec 2023 04:51:44 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001d36b2e3dddsm1184528plb.192.2023.12.14.04.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:51:43 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	kpsingh@kernel.org,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v5 bpf-next 2/5] mm: mempolicy: Revise comment regarding mempolicy mode flags
Date: Thu, 14 Dec 2023 12:50:30 +0000
Message-Id: <20231214125033.4158-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231214125033.4158-1-laoar.shao@gmail.com>
References: <20231214125033.4158-1-laoar.shao@gmail.com>
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


