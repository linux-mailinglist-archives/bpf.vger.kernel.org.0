Return-Path: <bpf+bounces-45921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2109DFC0F
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 09:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A4BB20FB8
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB31B1F9F6F;
	Mon,  2 Dec 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUmSdLGi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00631F9F60
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128705; cv=none; b=cJF5PddCzwkzbNEplPNpA+GaP/9VUK2lJr8JZBVVMgRQB3+qyxlQU1Hb/vLivk5ZlzYnP/PnOdi/hk5PO7lSp5ChutJStzFc/4FJeus6Rw+TGmapSvrH7ReZ7gjroin0EfOKXcuUcGG5sSNp1nBB080sjrZAOkf4RhZHthPq/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128705; c=relaxed/simple;
	bh=yftFKNwJm1Jz0VZlXa7rxyy5dYGaYgKeYANzbooirzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF5J6lsSomBj8lPT8AwY2iQpX45vFKihNH8X7orHCbgcHOaT13R9EWy7FoJoR9o3ckwcBZN11gaKgB+oc8/1pnxFQTlEPCMw7XxtQJPyPyqj+Ql7e/NLf39oloTRUOYEORaqQvzJnPpAH7miBlfyWBOtPRAWqnkKxgJ6CQ5caj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUmSdLGi; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434a752140eso32413665e9.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 00:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733128702; x=1733733502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtrhSNEc8IrFO3j7mDizJkeNO+uKck/49EIV89z8Exk=;
        b=bUmSdLGiXXp0krRsciXEYmKFLXzBPRXaP3j0qwobL+/DCZJqkVdkAKCf0cWFNpn0cJ
         yg1TCON/Dcn8X9edwE3hCM3YmhkpmSEtWdFSpvx8O7TQkksXe0gpYuD2YkU3IOiet3t7
         oAq0KlsUTjE2RCRJLRjsR8xkoNWO2/cHNfdP3HfKr7bfyVYaY1BW0cfv0+ItaZBOiUVY
         sTRyMSfcUhtR0J7NI0hHuho6S7wK/cYpW4FiZmWxJAI7W6bpWphmy87xOWaIVMxSeBE5
         pvbfpLNHUWF0Q3O/CMm6AZ6vVT9mFGM/dmmDBRc0dF5cKndSLDWu4rPORuK1AsBZBoGD
         DabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128702; x=1733733502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtrhSNEc8IrFO3j7mDizJkeNO+uKck/49EIV89z8Exk=;
        b=TM7ZanjGbDN+b7YaRrLVAwaAPDqzwGMRz4T/cSv4hABU/7S6BymVRXfpfnR2TrHGUN
         GHAWpJvYa7wNJbtKskIfdG7lDSfXUdVoyT5vfpPyou3Ma2X+0SDjEJ25jNQzYpG8mPip
         ekw1LuSICLQfyDBQDYaVeUHc75lqGfpEhVPVaSC8HKGLlLP/GhcmqDmqhD43mpBlTYfE
         Pg6XaNfMpvSboH04LgQ4SVXjtkvkMqJCjU0uPmLwDpNfOLzwo+AhfX8/+mpzRO79h25U
         6ds4tw2qfEbJLL8UEUrUes3g9n1SaKPX13x3rJxIyLttWBW/GXGPlp1vsQDoXlu0eF9I
         j0kQ==
X-Gm-Message-State: AOJu0YypomCqBoWyi4d/zz/MSQCwpNxd7OlwSbi2LGitizpxLce3CRKM
	ySD+Od26tmPtq9+yQCBVF3YJInfCiHUeBVinVWxyqkep+pQXEAECOYPrY6guaXY=
X-Gm-Gg: ASbGncuie9QJRNYjzdgQpBnpPlm3iR5CozX9LkdBT2/8qKtk4rifOUqcJI/V9y2Tvpn
	G2/i36ip+SXAZ4qTEcD1PznopE+tx84Byy+V/10r1GfeiYnaYUPZNnwDH8fJE2MUd1nfDDrlmxA
	46lA07kzh86HHQr0eKAf4RHH21+QPRQxQ8+grghYWMXIWBpmxqivnexDdibhqtVAjsiaLiCGVp0
	Cwjs06Rw4TvN5OpNNW9RKmz5TWuXfFalIoKDz2hZdVt6h+ehf3gqqWkKRFP0m6wC7Fo2edsK5K/
	wg==
X-Google-Smtp-Source: AGHT+IFtNySmWCNiwxup05k4xMHd5oBGveSNYc/fLZWF1n43yW1/VoR1Ps/UfE9u0+/7ORIqDuvRwA==
X-Received: by 2002:a05:600c:198b:b0:434:a1d3:a331 with SMTP id 5b1f17b1804b1-434a9de8d46mr175957385e9.22.1733128701876;
        Mon, 02 Dec 2024 00:38:21 -0800 (PST)
Received: from localhost (fwdproxy-cln-037.fbsv.net. [2a03:2880:31ff:25::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7dd78sm143221005e9.44.2024.12.02.00.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:38:21 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Add test for narrow spill into 64-bit spilled scalar
Date: Mon,  2 Dec 2024 00:38:14 -0800
Message-ID: <20241202083814.1888784-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241202083814.1888784-1-memxor@gmail.com>
References: <20241202083814.1888784-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; h=from:subject; bh=yftFKNwJm1Jz0VZlXa7rxyy5dYGaYgKeYANzbooirzQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTXG0l02jSpcGOiTMciM4t3evEvbQqHstq8RX3V6Y CQrZZ1mJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ01xtAAKCRBM4MiGSL8RymRXD/ 91JzaDFVu3Rtnrk8TeEnK4NzxfTSIxZDn0v3Diqgm2gpj7WoErI4fV/+LMyttqn6Iwb+QAIAaxNnn8 AuBI+OoGH3pLmHl0fIjxSoHXCtgnKDtiSt2okxtPTC/5FvwbO0gmtLihnaCFaB0ue2oCeMEmor18Pw dLucuLgjO4MQa6NQjOBOhKWTguY/h5ABScGVSQYZIrvOYbnfdaunbez8SH6AhgbYEDC6SNm6Bz+T6x Gg+u7rLvW6okIV+N1GT6AHRXlIeReW9VxVbd/GU5BHkFPAsV7kGnn/04TPn+eqCv2NHG2KEihLaMPa y7nDk8F5RmW3aAzPbDEXNy54G9SfAznpFcukKE4j8iBIMnXLfVWsjCI5M4Zb/0pzWOf2IccljK9Sxa Gs0MVgf2YuJX3aGmvRC/4VzfwGAsJmAhpJxGGH1RDlJf/eHkw6GlLXa2Q0No5iYWTmLit4BsqDbHad QugNSNMHSbJVGTXQbPGNBH8JgzlQov1Pysp7RzFBU13lni3lAwgCWvnO4nt0eqioRzABziM3/8ORUh D5Cqx/Kg4+hRhW1diw1s+ZBeLD0Yktkeuvr++6ZG8+EBvZHtNAbdL6BBC7j7rhdM32FWuialN96vdN R7eaplsxODGFw2du/tBp3xp3d6hRqXEG2JzwbbDIRufWlEVVuWBuiryJZ4dg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a test case to verify that without CAP_PERFMON, the test now
succeeds instead of failing due to a verification error.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index f5cd21326811..83b5cd705ccd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1261,4 +1261,20 @@ __naked void stack_noperfmon_reject_invalid_read(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("stack_noperfmon: narrow spill onto 64-bit scalar spilled slots")
+__success __success_unpriv
+__caps_unpriv(CAP_BPF)
+__naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
+{
+	asm volatile("					\
+	r0 = 0;						\
+	*(u64 *)(r10 - 8) = r0;				\
+	*(u32 *)(r10 - 8) = r0;				\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


