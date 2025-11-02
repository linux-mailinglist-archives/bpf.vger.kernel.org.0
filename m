Return-Path: <bpf+bounces-73262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A542C296A7
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 21:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE1188DBFC
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52D245006;
	Sun,  2 Nov 2025 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7NAo1jw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333C23F429
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762116721; cv=none; b=LTNaZ7g5Ax71SmwPPA068oKIyjH7+9ImVFrGCUZVLHVJZJyDiHuui4HyGN22PRAznyNchzAV4gAzcP69FJizRZtLWmZKJRV00GKewHXzi4RbcxkUIbxSYe0Mc4hxBEP27HUUpi2x0F92dWKCbgL6I5aeKc7jm0oykrvo4GRbARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762116721; c=relaxed/simple;
	bh=xFxeXQqPKAgcFOWf9VOQjhwob5K+AMyyXdaqOi1Ejpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khKC09VqBRsmnIrgyVcyUNX9AbvgBgnFAtz08442z+16ThGo5oRNn2lW3OZH8EJo72J8Xa1RNSxF/jVXejDo50fpQXWlBnVD19f79a3mbCzv1LI6qBjUNlWOmpogE5Q/zqZsDHkeHkQCPPE1IYAQDBIsko3NzBOWV8N8Fp983+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7NAo1jw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so4059238a12.2
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762116717; x=1762721517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=a7NAo1jwHNN/EBjibm0clTK6x+vL0G+YWtVaBs6HzDGVC4yWPbWYRy2YdK9pmSnHkY
         2m1VkEd/iSD+SGkb315ZiJHCYTn4LxIzfvFqSa21ffpZkUnjLuA6IWQLCHqQ5iq1OvdQ
         PnpJinCECLoXMKXnnunoCSg+zn52fAKmM2fdR4SdGUzwtAcDuV2Ei+p6c0AMm15DHrqQ
         OImsIHu/o++qdSwffSKQwHO+B+wVbJz2x2Jk+l/P2udXqv8AZ1GAKBADp8YjdgQR6SxH
         9GjacwmKZ0L4QGnuQpz2xolMYV2Gznzi3nsuNjXioFUSCv0bTltNB68jqrMIoJCgj3T7
         bDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762116717; x=1762721517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=gd0qpIMeE02orz/bEZ4HRgNrCwosZQ8zq10YoAxzZjkLbN0rf7jFjq+xhH2NK5AslR
         eueD/yi8mGgmYGwg0EFT+iDy7pMr25YxFiEiIktV3D5LRoE+7kZ5GXUkW7y3klmlm/Qk
         5SAiyMpBJoeLxTz4SY6pUz5J5RMhZFWM2QzB21QeoE0cTdHbqzIx3W8IkhGv9yfWLlEg
         s9+DiMq19nBiObAf2R2/EHr7YdQcDiOzSi6n8IYGSIIRDCcDA+Nuy+vWEez3T6KeJ2pJ
         dqOo5JJ74+0CGYQlleguxpT+Wb8bfCwOzqFl1Gmfn97mlA5Po9Cx1UUSXEx2ifa6BQoX
         hvGg==
X-Gm-Message-State: AOJu0YzoBhxcRx0jFgTaDzAVEs95ZU8/y69+oQebxW+qWs8gmlt+3SAI
	vl/fqPGVUsVGZ8bOnb63HPlmhhwVXF/485PNQFZ39r1WIzK1lFlctS0+cYEdVg==
X-Gm-Gg: ASbGncuWod9sMIBepc1hM2pyyg49eSFcBjrUR5qoRnf0qjH1thY4sTtlEpDSQjukcmk
	Af9AbchqBQsW7ajMmUYaezLq2dIWM13to9hN8sw7AeUq1YWHNUP3HtCZNbLH1yKldqvthpY27ci
	c7XRZu6xcv6uMZQppXmnswXIyUmsDC3gGUdkklLfIUGHl/QIIxd108kN3pivfKRu27KOk3zcuKO
	FzJAUIRlE+2X+v9sFXrerKGWG+ZA0NYuSyL1SrARD6e1NmFSROt9y1+zmcjb9VT210lCx7B1ca4
	jfdsBsHvXF/+tSjgFoOzhn0LvUvpan/rmf9dDtZojBs2o4HYvtYEQm9CBS1qBgn7NHP6B8HvDDl
	+Ps5oXDE7MlEUjA6S2TJMBG2W3v8aYWgxDS/WKGhydhgEAx8bf23jgyVPt6vDLPcAwkr7eUpVwH
	ZTXlMEmwwuAn/5ns8GBRhX1Ef31EcgjA==
X-Google-Smtp-Source: AGHT+IFgD2RbpYdEdUGZ8oagqS20tT2R7f8o0BKGn3Y+1IKm6g5+5SjPRGvnu5nI3gxsSepNYCYiwA==
X-Received: by 2002:a17:906:4790:b0:b3f:294c:2467 with SMTP id a640c23a62f3a-b70700bb711mr1071931066b.10.1762116717024;
        Sun, 02 Nov 2025 12:51:57 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b71240c245bsm14029566b.10.2025.11.02.12.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:51:56 -0800 (PST)
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
Subject: [PATCH v10 bpf-next 07/11] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Sun,  2 Nov 2025 20:57:18 +0000
Message-Id: <20251102205722.3266908-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
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


