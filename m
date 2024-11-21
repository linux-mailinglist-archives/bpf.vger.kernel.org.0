Return-Path: <bpf+bounces-45337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8022E9D48EE
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 09:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7663B240FB
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B2E1C7B64;
	Thu, 21 Nov 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN4BHeyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218711BD501;
	Thu, 21 Nov 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178079; cv=none; b=SFjuqGvWpRtrkJbRMgbwZvP26rDxOTRNGooU2eh8b+1ZaleqIht0ztFeVvK9lkRxzmrIApH78XmnkxfkIhuXeX8hyfKG4UGdgNZeMj4u9cyFffXibJ4P8OxIHHxCMMT2iVdNupkg8UY2oSPIhcUFe6F4Ie6nfiQa0RQyE/tkQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178079; c=relaxed/simple;
	bh=zjTOpW2VoG1jkCz4sfFZmC1KrVbbCTNewmnwv7ZVvow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omEvwvYHdzrjKqCUhT0tl75DbV98ZcPqSL+JrKJ7GQt0TB1JSVglkdhUKgDGFmyBiyFRlc8L15jg2Nxb1hK2BKKptEqo1MbmB7Yg7DT6/cW40HPuI8vl5ljhNaEusOTZMU1oGibFG/sllo3rgztoD6QmHLIfc0BYW72iqHfNBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN4BHeyB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316cce103dso7066605e9.3;
        Thu, 21 Nov 2024 00:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732178076; x=1732782876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuY9UIumhzkIskqm/6SfN6e7LblNj5wpgZ/rsXPts54=;
        b=bN4BHeyBV2VREztHtKyl/wCugyrLw37xHgq16597EFBfeRQTnKp3NFcUCeEKSs+M/Z
         nttwkg8VsO/o2/UVYpiB3YUJhbVS7JdPlaX+60J8/3NxgGnCcju1sA1DAPyGnZt5WkdW
         WaNe7Lhv6tp1zRi4xzmAIqXDB+21WUCJVqyF6oxFb0rge1NjewXxRiuop5Nss0rBX703
         S8W2p1uU1TPNqNjnRH7oNa0PAS9YBTKTH3q6Vc7zB8v/rlrj3DsawhJzLJPhfq4Xw4Yx
         /DV5BtZZns/rps/aVqNXPjUiRwT1xFR/0+QN6V86/5PqGOcashnyxiU2vY+GbVRcnnzq
         UNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178076; x=1732782876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuY9UIumhzkIskqm/6SfN6e7LblNj5wpgZ/rsXPts54=;
        b=ETbU7/JoKOm1nYYWz8p5F0Oh3+DL7mNQb1n4v+Jp2nqR2WolPFD42ACd1nE7+a9fJd
         Yj2S7pCThmmGIPvqXS21xyB2uCMRKj+CYpGzv5b3r5/DBbDaIhhyn8hQ5+2GtX8/q+O/
         07HoGsC+85/JjqM1anRM1PQL3vOtLz/b49CkMWneLuleg3DYe+ioWUTDNcGAwZKiKJGs
         n3tZKlhltTDk4E9LpB+NUqjpi6M3rouhNdNoeXuZrn16FybiEZx0wI1CZqLdrIcoO3Vv
         BwZ3zotEYZWniIP6EuhA85RqwC5hrjKLPqP0QpSP1/28/Y3wzjFOhp/Lxzo4zRFwqxdr
         AHxw==
X-Forwarded-Encrypted: i=1; AJvYcCU+CGh1Wy0K6foly1meMR+YeL8xiMEA9OQqlMq7zjmoUUPB/6Rx+10LseViUEQU3mptiX/jBJpAzd/Kr5Kv@vger.kernel.org, AJvYcCVr4ykj4ANGbqwgaH5jzM1B4nqGLERLmWKdpzWveHcKdE50ZX3MyLS/t/oFbuXXNc/2dpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/AcF9BOapqNLA2bZ+7BLvMuJ5Y+mEt5uOwvDzCp3T6GcNgPj
	4fz7SWAFsBiU4wnSq4vKeoa/UCHBh5Wr87Fd14YbTF/jrhD15f8=
X-Google-Smtp-Source: AGHT+IHeO1HwhmFK4O5/NJbZp2M0Ctx7jARETW7C4rvS3zI6J6/qaqoBgcBCSOBXifhAzWODgPr6ag==
X-Received: by 2002:a05:600c:34ce:b0:432:bb4d:cd77 with SMTP id 5b1f17b1804b1-433489ca951mr53704995e9.19.1732178076223;
        Thu, 21 Nov 2024 00:34:36 -0800 (PST)
Received: from qoroot.. ([195.181.116.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d16f8sm45392335e9.2.2024.11.21.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:34:35 -0800 (PST)
From: Amir Mohammadi <amirmohammadi1999.am@gmail.com>
X-Google-Original-From: Amir Mohammadi <amiremohamadi@yahoo.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Amir Mohammadi <amiremohamadi@yahoo.com>
Subject: [PATCH v3] bpftool: fix potential NULL pointer dereferencing in prog_dump()
Date: Thu, 21 Nov 2024 12:04:13 +0330
Message-ID: <20241121083413.7214-1-amiremohamadi@yahoo.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <47225498-12ab-4e69-ac50-2aab9dbe62c0@kernel.org>
References: <47225498-12ab-4e69-ac50-2aab9dbe62c0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

A NULL pointer dereference could occur if ksyms
is not properly checked before usage in the prog_dump() function.

Fixes: b053b439b72a ("bpf: libbpf: bpftool: Print bpf_line_info during prog dump")
Signed-off-by: Amir Mohammadi <amiremohamadi@yahoo.com>
---
 tools/bpf/bpftool/prog.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 2ff949ea8..e71be67f1 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -822,11 +822,18 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 					printf("%s:\n", sym_name);
 				}
 
-				if (disasm_print_insn(img, lens[i], opcodes,
-						      name, disasm_opt, btf,
-						      prog_linfo, ksyms[i], i,
-						      linum))
-					goto exit_free;
+				if (ksyms) {
+					if (disasm_print_insn(img, lens[i], opcodes,
+							      name, disasm_opt, btf,
+							      prog_linfo, ksyms[i], i,
+							      linum))
+						goto exit_free;
+				} else {
+					if (disasm_print_insn(img, lens[i], opcodes,
+							      name, disasm_opt, btf,
+							      NULL, 0, 0, false))
+						goto exit_free;
+				}
 
 				img += lens[i];
 
-- 
2.42.0


