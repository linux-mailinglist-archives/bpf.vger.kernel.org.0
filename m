Return-Path: <bpf+bounces-62039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C52AF091B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32C51C073C3
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464C1D514E;
	Wed,  2 Jul 2025 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="easw64cA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F61FC0A
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426271; cv=none; b=XsTl3kxi9vtXFPntWRx8rtZ0IW/X0ry9TSWsg5B2atNUN88AWJbDgAmpxlbeatEJ+6uTvu76iDMqnQNBnyzqrjCQTTNqq6ON8Va3pKdeNyENe5AmeW4EChivVqBjI5jCCYPvjMSj29ONk7HFd96TFCkPJ/tZ3VOVpjcoKKbbGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426271; c=relaxed/simple;
	bh=PLOlODQsGllSok8+dpYjmI/AyfHdfTvXsSUamXG7IHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJrzQWetInFOVGLpL3cW0IKr+IwwcSlIuAhxh/Wsv4jAZSsDsFien4V0t3jFv8fc7Xe3/Lv4PEyu6VaL9cajz8rij1IDIWcw6eAurrTKVAAfwQwEOQATdzoGPWU/87NF4TBJucNLs0GwxIqNbbIQMPdemfouV3degIkdpt/KEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=easw64cA; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so7495903a12.3
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426267; x=1752031067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmMMJqdzJKeIfu0xRdPYFsGQfozeG0l56QI5gVqeKpo=;
        b=easw64cA2OMJl6U07P78f/rvb8C3IAlVQJJmW+yinV8vuMrfOQfyy9Px/MIUc0yunf
         OesTg3nVc7EQqVoufyB4id7n1jMugKDhovcNfhgIDWuc9x+jjL3Xcu75cvy0VVseWsnC
         /1PZkpC2kJcnMLxNu1jTCvLUTQ+zJmJUwHNFKSLd2E0gjCFKcz2A2o/oRF5vhS41cK/E
         MdedqkAp5njlZOKxjrtibTVFQgGaAxMySJPBqlRGxxkQC6xbai0EqHqWj6/ZNu/ZcJde
         fjbpMC2xh6014hpyEaKtk7EIVVItdKweot5kRH0n6H+lpcSAHcNFR4ru3qlTnWo03dCT
         Yp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426267; x=1752031067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmMMJqdzJKeIfu0xRdPYFsGQfozeG0l56QI5gVqeKpo=;
        b=Ykf5HPau9tM4B1tBxCSpsxT+5lP8C0+Qh6M4LgWzpoT6Wyjg9u8YsXrJXGPSi3Bb+E
         m6F5hcwLVSc75IZs2EVbgwrGypsOM4RKxQ4lwE7PGiW4igzw/KNRvN4pjULOogxgCYxU
         Ym22Ix06343yYOXvSaFfIbuxqn0YI5KmXObdc6YtKSXsSal4t/PnTj39S7ehCydQLnn3
         nUs0jiBnmfN9ze7uIFyJHq1UFUEGywJigOMRXxcgeYaH9Q/TF+BhWvOigW19fy8sXPff
         CoeybwhPSr9O5XIHHAyU8hwX39vm4nNHqsuyWjdzvm7n2d3Y/05QqIKryfkfxROIKdQi
         fsxA==
X-Gm-Message-State: AOJu0YzKWS3v4A8ykojdkoN02OE5H/3Ggg6/J/xfo2CBJnCVv28IrKjx
	TUS7IuzgUS9oIcshn+m9vh3UuAFw7ZiapQ2cXcJdECne5FQZB2nxcFZJUAPtcAkUbGI=
X-Gm-Gg: ASbGncv+MA6s2Sji7FNZB5N6Tf7/qgLioRot4P0BPMLajQKO6EaFc3XfXRNYCCGoDCX
	/wiIhjkoPrjT+awb57XayaPu3nRB/NUWLIkW5B6/zseUtJF3aQOvWEBCVWMIhVEmxyy9Qr8t6Ym
	tnMQoToZfH9cSwqmavdFyOq49A547PRLhp/0EFGcWV47zNBEDAdIPKyKT0oGyG5Fny6N2EmFZFp
	oA86AToaR+++0w7/ruaxiJY7VXXAUmvWJP3pfBtYnEj09s4ZhHyXSWLjYmsrmpRArB6jAq1CyEP
	7zLMjxqWzH1kKT+hytsWZWeMowNbCsc9inDFbnr61p29TBFJCRSA
X-Google-Smtp-Source: AGHT+IGYhjPRa51V9XXgukSi90k0YzfkSvRONacgHeqQymG/5vZWTnHV7HO4QOK6709khYfgqxfNVA==
X-Received: by 2002:a05:6402:3508:b0:608:f54b:5c81 with SMTP id 4fb4d7f45d1cf-60e52cb3f50mr870025a12.1.1751426267510;
        Tue, 01 Jul 2025 20:17:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bbd29sm8538002a12.16.2025.07.01.20.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 03/12] bpf: Add function to extract program source info
Date: Tue,  1 Jul 2025 20:17:28 -0700
Message-ID: <20250702031737.407548-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; h=from:subject; bh=PLOlODQsGllSok8+dpYjmI/AyfHdfTvXsSUamXG7IHc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFQNMpu2/h7IyH9aGvgmdpWUZYmpd0TdRCI4CA5 GWJyOFCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUAAKCRBM4MiGSL8RyoVBD/ 9CGNJpQhBzQiBKx2n5zG6/QgDR5YPC8z0dk9SUf7/l9IqsZrofTCe6DEmDf47xtEI4tEO3elyZH7XU BZL41gHV7waFc8jGR6wLnLa2YvlNTLMmpxYUVTq2Jegj5HqesRUMnd+nKWKm7sqLHy7gGCG2oUeNrI 4F4dE1DlhahwMDUgQpLDAL7uWbzzytwtll+OoU+ck8NJW2w23OkjXIAXM3iasBAQ550aPgBSlbOX48 mF8vQnVqC/xGgRtlJd28/pjapqDmc8dRgbQzKQMjHnWYQ00dsf/2/snsFj2Etq9b1zg9LlTSiY3C+q vMDsh/L5j2FIcXkOq45yYmUWgPIZUVyvis+I0kf3qnn72j7nH8fwlbv2PJkkDsdv+Z5IYTFC/UwZHG krlVS7i6EmVCzbvvBrUGIuW5HzMdiO4v8pbnWq0N5qln4vNUi7cSVh28CqqxMCS+ptXThcWFmaN5se qadGghV/t9q76QCNqbNajJqETPVW36/1tw0GxgkrAr0bQEdymDRXUs2zEtTwH5J0ob8vdvFhJTiqm5 9OT2JJCNJvUIDifn7TFG8ur8IFs9lkOwuxZMd6S7KNH0WG81uIzQokx725vQNpaFk4bkMkoX92J9g9 tl4zo2wuLOQ9k5XskaqOmUf+/ps8/hhMHUhBN4r993mTVTyyKSPFMuG9qnbg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Prepare a function for use in future patches that can extract the file
info, line info, and the source line number for a given BPF program
provided it's program counter.

Only the basename of the file path is provided, given it can be
excessively long in some cases.

This will be used in later patches to print source info to the BPF
stream.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  3 +++
 kernel/bpf/core.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 85b1cbe494f5..09f06b1ea62e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3660,4 +3660,7 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
+			   const char **linep, int *nump);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f0def24573ae..5c6e9fbb5508 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3213,3 +3213,50 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
+
+#ifdef CONFIG_BPF_SYSCALL
+
+int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
+			   const char **linep, int *nump)
+{
+	int idx = -1, insn_start, insn_end, len;
+	struct bpf_line_info *linfo;
+	void **jited_linfo;
+	struct btf *btf;
+
+	btf = prog->aux->btf;
+	linfo = prog->aux->linfo;
+	jited_linfo = prog->aux->jited_linfo;
+
+	if (!btf || !linfo || !prog->aux->jited_linfo)
+		return -EINVAL;
+	len = prog->aux->func ? prog->aux->func[prog->aux->func_idx]->len : prog->len;
+
+	linfo = &prog->aux->linfo[prog->aux->linfo_idx];
+	jited_linfo = &prog->aux->jited_linfo[prog->aux->linfo_idx];
+
+	insn_start = linfo[0].insn_off;
+	insn_end = insn_start + len;
+
+	for (int i = 0; i < prog->aux->nr_linfo &&
+	     linfo[i].insn_off >= insn_start && linfo[i].insn_off < insn_end; i++) {
+		if (jited_linfo[i] >= (void *)ip)
+			break;
+		idx = i;
+	}
+
+	if (idx == -1)
+		return -ENOENT;
+
+	/* Get base component of the file path. */
+	*filep = btf_name_by_offset(btf, linfo[idx].file_name_off);
+	*filep = kbasename(*filep);
+	/* Obtain the source line, and strip whitespace in prefix. */
+	*linep = btf_name_by_offset(btf, linfo[idx].line_off);
+	while (isspace(**linep))
+		*linep += 1;
+	*nump = BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
+	return 0;
+}
+
+#endif
-- 
2.47.1


