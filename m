Return-Path: <bpf+bounces-67924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3107B50444
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F2B5E752F
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D473168F9;
	Tue,  9 Sep 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF2PTzFV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F22DFA38
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438213; cv=none; b=j6YYiIjWsX2ziaNf13BfRP4FP95hj3NlAYbLTdBpro/2ZQKDLsi9zfmUpF0W84WFjkj7Ld1T7aAiTAxqvp3yQzuF883Bn7J4fmUBsoXwRD4W6Kv+DtGkjjTInkMCkQcKZ8ONhER2CPxLeHPdeKFrMAqLvnkxW+tZ9IvZ3yvHSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438213; c=relaxed/simple;
	bh=T1PG7e/SBGc+SiZQGejziOTauLcoYmswAVMlCXxhUcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFINLzAMGwcgaFKCVxCorLIBytywjA5Um5ZR3xXvHlZCH80sAyJiHdjsisdr9jdxBwic4cHqlusIG3xv8MLqQTx6kF6j+tDrfOtN2wbCF6CTocTwB27oWJSehBzbhfn2U3YBUHK5PKsS3c3Z3Vdr+N8au/TyrGqN7/BIi3hr87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF2PTzFV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24cdd95c422so34088925ad.0
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757438211; x=1758043011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIkwnf7WK8ucfgodL6TkODPxZ7J0EJbNm8CJfsyYx4k=;
        b=EF2PTzFVXLliMI3RaPqoEKHH7Lr5RxU8R5Tzbil2DbDvb/qve55CfjtmQbPlm7n00d
         JhAvKEjnW2Qq89hycVf/WcFHeHjxdoe4HYvqxtv4vo6hcpaofD9f4b+8yXq+BkiNT+2U
         61fFTw5A2aAzaS6kBXmx5rCxUtHElyPSR3bpV10yUAFTluuTngqrByH7l5cbDaVEQ5tb
         LuSHd2EowUJN8pLaGD5EGR7UUNM8QwpXiEmeElpOCyfh4gVsaIa7iXyeNP4+tgi7ZHKA
         eAa5xOyj8mzOAEM6+cQbKnBxUCUW08vEvNpIOnactAqJkSbjxNX7m3bj133NLI96qVkl
         60yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438211; x=1758043011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIkwnf7WK8ucfgodL6TkODPxZ7J0EJbNm8CJfsyYx4k=;
        b=pck4ITShwIfGKQZ/7XnawjSYnsjZflQYmZoo+cEZk8Z7IBtif5gOvg5A5vXCkRWSz+
         JeyTa7SIprN2En165lePRZCYUEDxcM6rnP7sm6Jpi2/iPn7Lc9ldv99qWpS6RU2HeeY4
         x87vcl6YaqaRyX3NwQMIvTtLHDOp7nTLgPoHhhPJHbbYVHpURB8jrcta09FzLw/IYH4s
         TAISZY+eHf4BDxpeLU9P6t3/m7RMzU2jV0MgbHFqZmb8ES/Bw37P4pK7jT6GVuzEOIQk
         5yOdPJdyqg7TfFA13yvl2mIokWdzaHaat767ryXtUSYM/Sh8mFUJWdnVPE/uV4RNCrf9
         A6PA==
X-Gm-Message-State: AOJu0Yz3ZYUxjLVoQuZNn1zpO7VjDSo4ZW50fY0K3hwM4/HhbwTweSFT
	4Z93tJpmFhjEOOpV9BNByYTdsuv3Uto/r0aLHIZtETW1kZ0ovdjQxo8V7hTB+nE/
X-Gm-Gg: ASbGncsWVInImXaq2TtWjmBnrefC3yOblYQQamx2esHfD77b803SOifNi6li6rfH/po
	vshY2s+du2dNm4r+8dUdR2Z/7GVNmKY7Mf8Ot/CQxc92znwPLkOXikpaWTLPaMkOo8fcfDlts+M
	rP/uLsmRlLV9BiUc8BdNta1ZEGbK8O1F+Znt7tLDf5IUer7Mon8d3mP1IroFOyLeoUY3s6l6o30
	VC+l/eDRP3+Jz6Lkh4v/0As7OfWHqp2vNhc7hZQs7Dlz26DMoer6Do29UzvyN7/VFpqLPQ1bUnd
	T6LTyC2+MFgxz1YESYdlo2V7x0BVcT+Lbs5DyMazLatVEK6/P1vPkn1Bw1kXTFVDIkAUe3SEaXb
	GFMbUOUQE+WwY8JHKXV7DKoeJT4Jn/0143djrKW/ZMh1zJeioJirOuDiqDg==
X-Google-Smtp-Source: AGHT+IGhuQdlwBFfVvc6O4mWMwkWWT/b5o8vuFyd5pmsoNU1VQRLDIYend3OWv9YaXw0/bkxXpRmsg==
X-Received: by 2002:a17:902:e5d0:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25172291ab5mr156334385ad.29.1757438210481;
        Tue, 09 Sep 2025 10:16:50 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::7:b68e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a345064sm2970665ad.69.2025.09.09.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:16:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: remove Mykola Lysenko from BPF selftests maintainers
Date: Tue,  9 Sep 2025 10:16:38 -0700
Message-ID: <20250909171638.2417272-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately Mykola won't participate in BPF selftests maintenance
anymore. He asked me to remove the entry on his behalf.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..6056ad6f1afa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4682,7 +4682,6 @@ F:	security/bpf/
 BPF [SELFTESTS] (Test Runners & Infrastructure)
 M:	Andrii Nakryiko <andrii@kernel.org>
 M:	Eduard Zingerman <eddyz87@gmail.com>
-R:	Mykola Lysenko <mykolal@fb.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/testing/selftests/bpf/
-- 
2.47.3


