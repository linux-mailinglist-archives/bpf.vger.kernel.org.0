Return-Path: <bpf+bounces-16367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C3800769
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23280281A34
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779FE1F922;
	Fri,  1 Dec 2023 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3bbmM7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E1E193;
	Fri,  1 Dec 2023 01:47:09 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d0538d9bbcso2892895ad.3;
        Fri, 01 Dec 2023 01:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424029; x=1702028829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q7TZ/hQmcOsL5S8ofmt3CfzAuJJI0PuQ5alBSABkro=;
        b=C3bbmM7RpyPc2vlkLSFBX5I/GjTcyQFwtDmE/1BodRnCa5YUF5OLWekXOoSxeH42+i
         PTzU/ZcPmYal047RbTBR5Qk9Xh4oK+yN9B9hhqM4rxI6GQjiMytdzvySR6a4SE2vEOFW
         Y+ACmfJefsuXmJe3knfWe+F54foYRl/MMTHMTTyxlNqAZscEfndscp2zqQ/dGX6f7Sft
         T++ueKeGe2Z2eqK2EVuu2ze9a0s//BitfkbmmaDTVQMrk7iiJY92pp9BVaMtz+n+cPks
         GPfY5HJ5vPnvhKZn6fqK42TJRxUygZw0ggLzjSdkor37ihHfUA2886oIPUHGlmLxLFaL
         TUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424029; x=1702028829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q7TZ/hQmcOsL5S8ofmt3CfzAuJJI0PuQ5alBSABkro=;
        b=dNxq6+IJoesuvUMTXCdvkh8umtqIHullmkyOkpo7blDP1bL8fnwepjAVnv+IGdXPb1
         H7uwZEVmpmKNUcTZ/r2EwCwAfkZPZLwEPSlvAFGje7RPkw2+LJAgbe1w8svM/D2H2m2S
         x8xuSRfsJspFN1gYGvxKIBNBHzTDy7I1xeOfB0cfj59wkSf+yi/r1RmK1R3MHZ8T0w+O
         8F8ycNOdEKE56zviyeSl7rk3XQWZWR8l/mMPxjkQZLXyTTv4U8/r000j73HgXMF2o7oC
         4IKbgc4KdhJPIQ3u2W+y5+JEnLExHC2M/WsbSanf2xpdQqJH8uGDzfw359px3QpUEB+v
         e3sg==
X-Gm-Message-State: AOJu0Yz3Zf7q+5bIoTo8re2iF/0ky7BO621RItdhBq/eKZHyWes6vS93
	ugsoo2035+HKjvbejB44XUU=
X-Google-Smtp-Source: AGHT+IHY7BXr2lrItoDjy9fRRvCLOX0ey7rYRvBq4aXsP/3tg6wFqHDYposNzHDwQ5WVCd/30HQ5Hg==
X-Received: by 2002:a17:902:c944:b0:1cf:a2e7:f843 with SMTP id i4-20020a170902c94400b001cfa2e7f843mr32499685pla.23.1701424028951;
        Fri, 01 Dec 2023 01:47:08 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm2875534pls.240.2023.12.01.01.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:47:08 -0800 (PST)
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
Subject: [PATCH v3 2/7] mm: mempolicy: Revise comment regarding mempolicy mode flags
Date: Fri,  1 Dec 2023 09:46:31 +0000
Message-Id: <20231201094636.19770-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231201094636.19770-1-laoar.shao@gmail.com>
References: <20231201094636.19770-1-laoar.shao@gmail.com>
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


