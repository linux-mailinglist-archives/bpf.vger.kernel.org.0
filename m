Return-Path: <bpf+bounces-21063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76B8474D9
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1571C23B8D
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95C1487E4;
	Fri,  2 Feb 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="FzJ4mt5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7581482F9
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891659; cv=none; b=PAs/MFRoztVVTZqPlCXitPmGRWN1VfxQNAYFHTEuk5M8FdL22C6cI4wwnpUQTTR1Iy1vNj2LNZM3FwayFEU40nt33zcoe+gotg58oiQqTnB2x6dmAli1DDss3vf8EtX7l55pAyBYlYwx7VEvi2Bm7Ce9yZ7cm2HOOnSP72FD7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891659; c=relaxed/simple;
	bh=/5eT0KZzLpagKLj0WzCL4hsOrlVf0tQTTb5YC6kHKg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hndcBy7RoJMLMhMEI8r5M1gxEk9P2u8s9+kG6vTReOOL6KMS7Bfkp7kUAeQDvWhbROPBtp3lhPHWGb4iNG07sOdB13YLGYuMZUwc+zrW3VzetLiBcJZaojRnSYfBky5dTakl/XU3N/9IX0CVWOpEawAw3WGcBUd1CnsB9+j032E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=FzJ4mt5E; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so3307669a12.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891655; x=1707496455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJEGOO/b1+o1hTO6SMOu4g8owzzUlWXaPImP6sMPI1c=;
        b=FzJ4mt5EAq3qcW8StnvfUL2BlDBLznYITY2/s+AsjX3tNuRQqpZfa60w2cRIOQPP+K
         FrASyYtq5Mj/pFa0mJVsJhJKB1QxDS2YDjs+cegMw0ZPyJ2hSqHnrayDZ8ZC8YKI/cU4
         fz1KaVIcNCvFAjOoSav/wncjkG4s4dyqT0UpKqBS/hDNhVvW9MyampdTYwB/FjKp50Sj
         Iu3AI2074PJabQTbvn3BRbiFFGtp2TWr9K9/qnXbQX0/DmUDR7HMyDO9zxvvm9jZYhMk
         QFr9O3y14ZxPWVKCLEdiJ0tzIFDV2+iOshVWKgAUWvGktm24RyX99djuwpGRNE7ZdNQA
         Fi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891655; x=1707496455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJEGOO/b1+o1hTO6SMOu4g8owzzUlWXaPImP6sMPI1c=;
        b=JpeFArUZ+S2dM0fEEe6bTAh9aWecGb2JPJsp+VHPHAQ4q4mJifP06YKecCRIt4027y
         nsEFR4WyiSFeOCI7flYgeZHTHfbLxJc++g6vzwz0xVq9N4Y5B1qrrNeuJQ0pP3bCfnOJ
         4Xc+z06QyILQGA51wXzEBzH13oT+n4aDimtOwtTeQUyfDxFo+l0Vl3fkhRvFpNiUuCKU
         cxjuJDiiU7C9KVkmFj/YcTJL1HUDhY6mg+CC6PGl3OBdTkXByBoWVeMjVxFzeeoOW0Vv
         Bhfsx8bbIXboNVJnHPOKRo1mVRcQGMfjLtgtv5yruoon4UbLiIkNzE3dRF79LIH7Cwai
         BYjA==
X-Gm-Message-State: AOJu0YwUV2IDz8RQq6LvX+zn/n78NMVY/Jbfb1esG4J41tFxibJ2ieZJ
	Ao7BUAE9ra/7lz+nf+gStzXXHNZq5Mpsj4PkLfKLKHE2N5ysA/SYyaK5r3rclA4=
X-Google-Smtp-Source: AGHT+IHW4Mh4tlEA9yDiUqaSQhf9R004AQJtZ2fNeLGQadUe79BVZoJPhbCBUAstzW+j+HYYjlYnJQ==
X-Received: by 2002:a05:6402:b23:b0:55f:e7e2:c963 with SMTP id bo3-20020a0564020b2300b0055fe7e2c963mr143996edb.15.1706891655438;
        Fri, 02 Feb 2024 08:34:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX86VCnTrg8Gf6EVa4kb/04gNQbIPvc2+JRbzkhn9kgL46sbM6tQo9dLEDxXNn2xC/P8+KtJ0kjOiI1nRvsVpsOII5nGgtw6EkebpKRp68oKRpMryVdKNDBk75W2Tmnx2Kh68SoZByXyMgYM58xBCbqvefkPSTGNlRTGl+18ejBx/z5S/fSUcNA1iepaEriMnBuaX5Fx/p3fY0c9xTqx/s9azTMVyh5E6RSvtRCvQb46FCn5TwQUg/b1G7ScxWPElO465/guxj0OsQYXaXExn7xPJz2yv+3r0kdcS+p5M3bPZMQWS5gSYQ=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:14 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v1 bpf-next 1/9] bpf: fix potential error return
Date: Fri,  2 Feb 2024 16:28:05 +0000
Message-Id: <20240202162813.4184616-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202162813.4184616-1-aspsk@isovalent.com>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
error is a result of bpf_adj_branches(), and thus should be always 0
However, if for any reason it is not 0, then it will be converted to
boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
error value. Fix this by returning the original err after the WARN check.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 71c459a51d9e..ad8e6f7e0886 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -532,6 +532,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -539,7 +541,12 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 		sizeof(struct bpf_insn) * (prog->len - off - cnt));
 	prog->len -= cnt;
 
-	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
+	err = bpf_adj_branches(prog, off, off + cnt, off, false);
+	WARN_ON_ONCE(err);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
-- 
2.34.1


