Return-Path: <bpf+bounces-16370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5E80076C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EA12817F4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BD2200D4;
	Fri,  1 Dec 2023 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jevcNiOX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3BCB2;
	Fri,  1 Dec 2023 01:47:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d04c097e34so2722175ad.0;
        Fri, 01 Dec 2023 01:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424035; x=1702028835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGCoJREXvSOAbrJphjZNhFQw16aaUKi1TbhunSAnqyc=;
        b=jevcNiOX5rWmIDl+8uMuo+yG4NYe/rMus/ep5qXtgrdUG0yttLDgrqujwCGAXzQtXN
         E7PuvKlQ2GlfLwWwww8Wk4tb4Cge0ZViU0Ve757wdiUVSPKC1VmWOKkwZtYCfixTquCc
         RTc4r68B4uNM+RG9c/T8CcG/o2Cy+h4AGUMt+/SJbMCE2nvEhbU+y+vbKSKeLGXeBqKf
         OcWyNu567IYnig9/7peTQG4Op1Vx2Mh4QfZIyswWhldVHXtYyuCjVubRonGLTaOkSgJ+
         oV/cenrMFuuf2KTCAIgUsLNoLHHx2oTTcIR8I5nXx0k6dH1wLVq1C4El0w0C9vKbfspc
         FmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424035; x=1702028835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGCoJREXvSOAbrJphjZNhFQw16aaUKi1TbhunSAnqyc=;
        b=Bcdjro5rgR2SX6Ns0XEoxHSgzEDLZv51VM6Rr9iIlGA5Q640J2z0ELZnQ9JmlvVY4b
         aEz5HV2BzM0ydosnYCfoYA3rbRhFvMuxiNT/pROfXgdF5rRiQF+z4LYIhErckasexd79
         AMwM6N2ElR1Hhd/Dqi0Y5DonkXm2HS+gyjZuDgg//LEYHQ72eZeTBVaWxyfQV2lHabSf
         v5UQQb+obCOGp+/UUF2tHznkQFcJVBs3ueNDPzWN12HX7wkB3bIyyVrxqE792plqZ3sq
         7wX6pPqiOLuoOFTwq/QtIDJdCs9YkLQp23+Npz0U7IZAU4DpEI2puffQRaQLZGtGItj6
         Il0Q==
X-Gm-Message-State: AOJu0YxhscufmD5AurqfWYvQ2STEOJSXikf8/RvM6n5/dWb7kEFcKSNj
	D7+F26malxAUg4GqMJRsr9Q=
X-Google-Smtp-Source: AGHT+IGzXU9LrPgZca13IbQFWnu/fiFk9usQfcwA1GinqIP6YmUaY32WZLHTprYh2c8I8vSS8VEDvA==
X-Received: by 2002:a17:902:f805:b0:1cf:5806:564f with SMTP id ix5-20020a170902f80500b001cf5806564fmr27316532plb.10.1701424034967;
        Fri, 01 Dec 2023 01:47:14 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm2875534pls.240.2023.12.01.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:47:14 -0800 (PST)
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
	Alejandro Colomar <alx.manpages@gmail.com>,
	Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH v3 7/7] NOT kernel/man2/mbind.2: Add mode flag MPOL_F_NUMA_BALANCING
Date: Fri,  1 Dec 2023 09:46:36 +0000
Message-Id: <20231201094636.19770-8-laoar.shao@gmail.com>
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

In Linux Kernel 5.12, a new mode flag, MPOL_F_NUMA_BALANCING, was
added to set_mempolicy() to optimize the page placement among the
NUMA nodes with the NUMA balancing mechanism even if the memory of
the applications is bound with MPOL_BIND.

In Linux Kernel 5.15, this mode flag was extended to mbind(2). Let's
also add man-page for mbind(2). It is copied from set_mempoicy(2)
man-page with subtle modifications.

Related kernel commits:
bda420b985054a3badafef23807c4b4fa38a3dff
6d2aec9e123bb9c49cb5c7fc654f25f81e688e8c

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 man2/mbind.2 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/man2/mbind.2 b/man2/mbind.2
index ba1b81ae9..dac784389 100644
--- a/man2/mbind.2
+++ b/man2/mbind.2
@@ -142,6 +142,23 @@ The supported
 .I "mode flags"
 are:
 .TP
+.BR MPOL_F_NUMA_BALANCING " (since Linux 5.15)"
+.\" commit bda420b985054a3badafef23807c4b4fa38a3dff
+.\" commit 6d2aec9e123bb9c49cb5c7fc654f25f81e688e8c
+When
+.I mode
+is
+.BR MPOL_BIND ,
+enable the kernel NUMA balancing for the task if it is supported by the kernel.
+If the flag isn't supported by the kernel, or is used with
+.I mode
+other than
+.BR MPOL_BIND ,
+\-1 is returned and
+.I errno
+is set to
+.BR EINVAL .
+.TP
 .BR MPOL_F_STATIC_NODES " (since Linux-2.6.26)"
 A nonempty
 .I nodemask
-- 
2.39.3


