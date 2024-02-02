Return-Path: <bpf+bounces-21070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB08474E1
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE15F1F285EC
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487881474CD;
	Fri,  2 Feb 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="QxkC6JmM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C731487E8
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891665; cv=none; b=amozlm73sYvzn5qqSsd0t4ERz0lgvPAhHm2REjYZlhwdT04S2WSb73NIkXDBLOgCPdMyPC6SypvEvdM+IrrTCrsiO7+pMuFmUpSi9ATDr7LGgwWql/wnYRDco2yRZDQR4dIJh9S+hWEmKZtsC9KKgNb6RAOKXcTlGtVXcvt5+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891665; c=relaxed/simple;
	bh=NE1NLLzZr8CUrmLnmmaPmBcY9uHP2NUWNMFPX2IDo+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+CKVNBnn+tU53Z6d3OdMmrCwscnxkXeaNlu1y+bwp9U3qmp1/3Tl31pTY9Dw2XH3n0ow4q1QDPKAKMRpeIHnkOv5eyJuGy8l+DwBicWOJQmT8Aun2ovUn7uTJ5TG78MEKhQ6ywWxTdrcjYA1814QQsLs1l5xMKsVvaCsrVBS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=QxkC6JmM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1831286a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891662; x=1707496462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DsDRTsOyaVpHWTH/Ld3zgp4KeMMBnazkevDmIj8tFU=;
        b=QxkC6JmMKJWTymVCHkwmoBzkOjwD9Pps2ZtrSXJs5hbCsoYXnq2e+//1/a20xmOTQE
         ubzV+KQLYboqUNYu1CxuK7dJzW7iw9BbCMiUbEzPGQl3Ap2AVAUBBHqBTgKwLI970D+0
         5auy1nADEUFZtPurCgS7q0ezyyvON26tTSxBsD7HeFPmeI75v1UkvzwIpxVoU28mgfP6
         KNBKbzYZJQvl06h/+Swdd/bAldIV/rimWz1yTvj8B+3Ao+fTTKxx3YquJkgkS6PciXI0
         Dx7zbsHCYLD6TUsgX1/VMDcdJfclIgnkzF43l2jEnFOViPV2fz0Of58mzuC4k3A22Glf
         2mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891662; x=1707496462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DsDRTsOyaVpHWTH/Ld3zgp4KeMMBnazkevDmIj8tFU=;
        b=egxF1x2xhLB0AWd9INiEMrR+B/nrVVKfzUv8rgQw0lW1cOPFg0DYR389uf1B32cFNs
         pvQlvvW5Bfx7ImGRlaoDP//u81cyY6EdHXLheDwRs7Tt73D8mCqOV57kDgqMvg50qP+W
         WU9GFPn5IclFajr+HRml4lqRxylBMbl6AQIJQFq0tNmc2gutrOKFtxPIODwY417mqqN4
         XH/1IfOzH7OPm21Ndyp4sp5mI/cjdw2LaEuwaZwCPiWoI20bVLxtyU5FJlrendApmnwk
         kgj4q19Lwx6nvEAJNkCAwiDIE41TkPEGOOT2U+W3Kp14R58SKt4NaE84+8Sqzo/m8FpK
         GvwA==
X-Gm-Message-State: AOJu0YwRTdD8dwtCqn8hjvzXXGXNo5urxMIYEw57Y2uSsTeEkLZAfLLW
	PE5UzLo5H7BmibM4kjsS8CNP1tgs+eJ3oZvPjL2m5aiuuSUKcITk2oKKElfgn/s=
X-Google-Smtp-Source: AGHT+IHZa716znm/na8SX0FjzVuyAy0KNC7WnyegWEwJbahSN3uyFiKAYMBB4pNrYx/w9c2+Q7yQ0g==
X-Received: by 2002:a50:d516:0:b0:55f:ce14:337a with SMTP id u22-20020a50d516000000b0055fce14337amr185732edi.11.1706891662391;
        Fri, 02 Feb 2024 08:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUY9zXBO/iSyh02hb1iVUYsygi4Jt1HYcIuIkXhPPdFBUiKGNlpWCy8hVg74hGC0cbiHFbI+rcMw6Tr3C8Mrg4sC7UfuogZYU1HSS6OatYiyDKecWnZf3yZ6qDRyfTHpJBu6CdeCgqcc97To9KU/Tg6SSsGsgtxj2KwuDtTBNPOGw2X2hk4gQT83kRzfbHmqR5BaZ/bQRHWRTKS+MTNfXeG//xC9D1ovtzuBEP7/FqbI87hC6U/rAouT2PWd35fg2+k1EQLdFc8xydJzg8qi1dGh5rmPahTjCIIuwBm1cRzrpOK55zSQ6s=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:21 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 7/9] bpf: Add kernel/bpftool asm support for new instructions
Date: Fri,  2 Feb 2024 16:28:11 +0000
Message-Id: <20240202162813.4184616-8-aspsk@isovalent.com>
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

Add asm support for new JA* instructions so kernel verifier and bpftool
xlated insn dumps can have proper asm syntax.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/disasm.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 49940c26a227..5c8ee230ee5a 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -166,6 +166,30 @@ static bool is_movsx(const struct bpf_insn *insn)
 	       (insn->off == 8 || insn->off == 16 || insn->off == 32);
 }
 
+static void print_bpf_ja_insn(bpf_insn_print_t verbose,
+			      void *private_data,
+			      const struct bpf_insn *insn)
+{
+	bool jmp32 = insn->code == (BPF_JMP32 | BPF_JA);
+	int off = jmp32 ? insn->imm : insn->off;
+	const char *suffix = jmp32 ? "l" : "";
+	char op[16];
+
+	switch (insn->src_reg & BPF_STATIC_BRANCH_MASK) {
+	case BPF_STATIC_BRANCH_JA:
+		snprintf(op, sizeof(op), "goto%s_or_nop", suffix);
+		break;
+	case BPF_STATIC_BRANCH_JA | BPF_STATIC_BRANCH_NOP:
+		snprintf(op, sizeof(op), "nop_or_goto%s", suffix);
+		break;
+	default:
+		snprintf(op, sizeof(op), "goto%s", suffix);
+		break;
+	}
+
+	verbose(private_data, "(%02x) %s pc%+d\n", insn->code, op, off);
+}
+
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
@@ -319,12 +343,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 							tmp, sizeof(tmp)),
 					insn->imm);
 			}
-		} else if (insn->code == (BPF_JMP | BPF_JA)) {
-			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
-				insn->code, insn->off);
-		} else if (insn->code == (BPF_JMP32 | BPF_JA)) {
-			verbose(cbs->private_data, "(%02x) gotol pc%+d\n",
-				insn->code, insn->imm);
+		} else if (insn->code == (BPF_JMP | BPF_JA) ||
+			   insn->code == (BPF_JMP32 | BPF_JA)) {
+			print_bpf_ja_insn(verbose, cbs->private_data, insn);
 		} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
 			verbose(cbs->private_data, "(%02x) exit\n", insn->code);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
-- 
2.34.1


