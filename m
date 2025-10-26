Return-Path: <bpf+bounces-72263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D7C0B124
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56B1C4E9517
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7342FE578;
	Sun, 26 Oct 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY9/oq8g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69312FE575
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506446; cv=none; b=SqlPyq6pQXybg1DYwZl3JIYeFFtsPZIsxKw9RGpjy0ooHS1W2ky2RJnzSkAwPIrH6OvKMskg8Acv+ZbdRLg9+YOzHgxcWsQEiG8T4NcLS1n4k3cxXgRqEBS0jPlUv0ikKgOy04xs9gy5qPAhe1XF90sT7XA5DydQhMb6xg+8Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506446; c=relaxed/simple;
	bh=xFxeXQqPKAgcFOWf9VOQjhwob5K+AMyyXdaqOi1Ejpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqivmqHYnuvA2Ca9MHrfQzngwh3Yz9B5naEVNUfFxq3MVHk8KO1Sb10lH3YAPKFhDS2Mi/WqDIs3Oh3IB5IIiHNTr7qYkWlmp1ky6IoXazavnyU71snaFB5HpWtySY0rsEkq5m1mmJVBsbRxw0FnSENDGof5cqp/boGG3poTvIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY9/oq8g; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so4152195e9.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506443; x=1762111243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=CY9/oq8gRVecyr+iBl9PwOfXxzmMROo9g5Q9V0NARze1pV0e56zaj2SizVEKeK+MTH
         dujMtoooS+0vQ8SWssuYHmjU8QzNm2KPuYe3nwF3/ZjFX9kHl8ySffCqnHGG35fObl1U
         n6sJW7CoNlnRkCB02x4YcjARb6APbPxPDsOIGsttlu975ogiK8oEFaPBzHrIM3P5opcc
         NXjm37pCZSBe6qlrSXHITKpfZrOhNCV5p27I5Wm3lw+WS+cCneRtDA2fn5GpC+ziMwql
         qc7H1Zni0z4/HH18wTSZ0hzw78PtWYBW0XxyjI/NtX2bg310tgmCSQobKCar6mND0kI0
         UpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506443; x=1762111243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=cqkgixS6+/HgNBgTtdusA/JrWoAHZxMMMrqxYdyLN1fShCAvERMAjvQrC06UQ4dwMq
         uur4M+kpa9cPSNrZspQ3AhArfQzRL33N9CWPaXCkAgctqcWoe4ZsCRQ7c0cRFQLIEtp1
         GYpPdVxW2E4eptrJ2n1h5tK5y+weCxl6suBnLfSs8BUUrRq2SXe0uiSzpFGsT5Pxfy0X
         Skzpp0tB0bSgnCATju91l5b7jsWi15LeQNDCJAb5vY5kYqpWYYLeqmy6b/00VgTuaHTW
         dc/zf+fBPN7WwWKHP9Il44Z6TpoYo0GY1uwBaLR4OMFRiLrMfToBscfbtgwfjK4pFT4H
         H6SQ==
X-Gm-Message-State: AOJu0Yz5IzRJ8t35goRilPQhBIPjPWLPQ26zbUHETBFM7jSVsDms57Gf
	tamexjLRYsR6fTjy3xOyJv91UFBZbDhuwBRIf5ZselRWI0VGV4b/r1v6oUfhIA==
X-Gm-Gg: ASbGncuCUrMMTknKITnKzpTIBzAcHr/qpNc4ujE3bZ33osHnxmdwcw0dmkKbOdi6UpV
	DrkCBVqE9kK61HOTE9o5dDv83+lCMEy+hahF1E/HQxXTFGrvqaGXO4WjRGM6uubgN0BlexUdyah
	cMiVZHph2L7upm8HjvxaDuC2spRGXFpBzavxtQDjKVtlYfiPsVTDpbVcFwO4hbNgNFYhnazZENE
	643w6sIaQ8ETjx//uYLLn3yEiEX4g3z8vqNFhRNuuYjnd8gCBuPFJhGu4Rpjs4eXLavnV9QJU4E
	lNa81NRRdbLV7oWFm7HFJXYzoLaTvzZHSN/ZRuf4G3tA8gU44OHMP3TqyNyI+pONIoyQjRbTPZK
	VIoSfd0FWX62EPRyKhC0ofh2oxlA7RNmCJgiu/4aHlNY74mib88lISXqppOxb3CugqeAEYptBPK
	gTI9jyk3PX7AfwstHEPI8=
X-Google-Smtp-Source: AGHT+IHen/L54FtPYuDIg5VzRFauw7obglub1mqwf3UxXEpOKQ6jRq7INONi45BRmS6COVDY6bcMzQ==
X-Received: by 2002:a05:600c:37c3:b0:46e:3550:9390 with SMTP id 5b1f17b1804b1-475d2ec5777mr64737835e9.20.1761506442767;
        Sun, 26 Oct 2025 12:20:42 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:41 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v7 bpf-next 07/12] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Sun, 26 Oct 2025 19:27:04 +0000
Message-Id: <20251026192709.1964787-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for indirect jump instruction.

Example output from bpftool:

   0: (79) r3 = *(u64 *)(r1 +0)
   1: (25) if r3 > 0x4 goto pc+666
   2: (67) r3 <<= 3
   3: (18) r1 = 0xffffbeefspameggs
   5: (0f) r1 += r3
   6: (79) r1 = *(u64 *)(r1 +0)
   7: (0d) gotox r1

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/disasm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 20883c6b1546..f8a3c7eb451e 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -358,6 +358,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JA | BPF_X)) {
+			verbose(cbs->private_data, "(%02x) gotox r%d\n",
+				insn->code, insn->dst_reg);
 		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
 			   insn->src_reg == BPF_MAY_GOTO) {
 			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
-- 
2.34.1


