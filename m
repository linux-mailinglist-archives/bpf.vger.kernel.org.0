Return-Path: <bpf+bounces-20016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C978F836E5C
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFA9B305F8
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8B46432;
	Mon, 22 Jan 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="gnMhS5S1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602C46425
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942515; cv=none; b=rbqEN+k5qFHGiAP9iCeddmg3f4gCaOvmq5IbR21/ncEfKdImtaixPoy1iSIQ2LwkfXRsBpc4keGUnKekTSWdU92gwoHiAaNtAMGTDg24NZqDKzhHvyKWR5/FMypRHAWQkmDox2Lw5e22H8TrJm0ctFiH5e8vJVT4Z6UoKEIAtok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942515; c=relaxed/simple;
	bh=tpQvt9G42nnQDZRlXc0TE2y39UU3Zn4Be+EgQfR1hxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPherphXUSB+OmeV+gCRgHjEVHebktEmM8sMasiRvZkfoKcH8lRrSPvYYwzejC+JWrTjY+ksaUB6+bS5fns3E+bu+Y1iyuTExpf43UmyVPDwP9yobTdxS0LtCTtcBtW4Jz+Mn/5ckBZviMOS4S2uFNxkEPWyT9mLrwO33kl8k8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=gnMhS5S1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e880121efso37776615e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 08:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705942512; x=1706547312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FGyeWs+ozxQbhoL9nxQPlsMBhd+vACZ0QkZ538lwU0=;
        b=gnMhS5S1tqcizzdVHU0Ijg/nB5UQfbKwyHxA8tOgd2c9N25kNt4Xg8YuDU8He0iX5V
         mIAsSLO44ux0WziyYWsMO3PCefiX00m3YgoYkUQGwv5BhgaxHsesfBchAsmxtg4T1pH3
         kxvOFWSvulK2KpM3srELRspqsTSBUgxjZ7f5vCLYwPKlekHqqLyVKncHEPhKUg/ZEtRI
         mtvQQ1hWU/xJpDcSkqUHnbhyrNAlzHcitO2Hl8QCp3ymFqNWXV49+iDmDD1fkjgSsmVG
         97FasJVGxH3LJ1jC2ZgIjxCD4TmM+2PbI9VDqN6X1+ri2g69JTjUOu3zuNmFgsT8VmkP
         SatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942512; x=1706547312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FGyeWs+ozxQbhoL9nxQPlsMBhd+vACZ0QkZ538lwU0=;
        b=nByySSNLOj8zwRifH/rSe5izlFgot0zeiSf+WxU22evT6B7Mg23XhOHIAyKxwKEnvx
         O+kUNim8rGdiOvBbfykKt6KZYPbFOStwQH1kRIk0Bh5km3siavAvYH99ByuG2SzPAyNR
         kXw+K6V3YktMcpTNdmVZXzvMBajA+n+iJaL68w7bJ6SfP1TPtVIzVb/1e/Of6vzsePtv
         xCD0eRNu4nyZC90qCnExSC/AZmGVh1Vmb9iuwtT2tN9b+WTS1MeNWnKiiY/k6OPaSxIo
         bcySJL+acBXewE+fmKXPfh0IKHiwcVoZ5qjbWjvOK0RBdazl7VwV4fPV0vNet62sQNha
         9ORQ==
X-Gm-Message-State: AOJu0YzMeg6+HlseLvZMi3km65WsspE+WLlRqCC5z/L/hida68Jsk9xE
	k0uovHS1RBpCfPqRnbXnm6e4LW1mhOsmEr3sRAufU/BmLEVNSXKbPjmvp0W3Ds32upnDiyubIO2
	V
X-Google-Smtp-Source: AGHT+IH0Ofk1bctD/QDeuO5fUC1YNZvMxMsXi+gj4U16iuGulUVoZWnoV+GKrpiduS7zbfGO+fPXBQ==
X-Received: by 2002:a05:600c:4a15:b0:40e:44c7:3d25 with SMTP id c21-20020a05600c4a1500b0040e44c73d25mr2313797wmp.69.1705942512160;
        Mon, 22 Jan 2024 08:55:12 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d6307000000b00337d71bb3c0sm10402466wru.46.2024.01.22.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:55:11 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [RFC PATCH bpf-next 1/5] bpf: fix potential error return
Date: Mon, 22 Jan 2024 16:49:32 +0000
Message-Id: <20240122164936.810117-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122164936.810117-1-aspsk@isovalent.com>
References: <20240122164936.810117-1-aspsk@isovalent.com>
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
---
 kernel/bpf/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fbb1d95a9b44..9ba9e0ea9c45 100644
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


