Return-Path: <bpf+bounces-77578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA84CEB9D9
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FD513007E4F
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6C31353D;
	Wed, 31 Dec 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIAUeASC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440721A9FA7
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171231; cv=none; b=gNckH/4FqB8AjH2IiZj4LGaSrYXagbfnMWCI/yUQyi8UwOeFZ6ETu4tVSZBbCnwWPaZSt+WyrVQaCttCg5X3/M6arLZ7LsJ02uLkBhv10cTCJAzHYmecRZ4ZQtZgfiDnWpTZk4MFxTkBgl8nYXPCYGJQn7GUtNuV82cYdXpeE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171231; c=relaxed/simple;
	bh=0xNMWLmzbdpUAIU2L73K9taXz+TuQgiz53/MYOlnHXE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GXXNes9lvWr7AovjGpZKXWgzHW6iwFbKmbnfWw2j4vjiUKo+YuOka8XbazJDVJSjEIjKOkbhEsyWihBRf6jIbnRdiisDk2/ezS0zIjrCKiPHprcAMH7RNdM9lYH1Xn1RXSx59WTwstoUC5HsdjWy9SMHVkTJYOlML7sCv9Pa0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIAUeASC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so102061105e9.1
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 00:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767171227; x=1767776027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zEcLp/F9Uq6NVB3VNgG8AY0r9oLq8C7H19pf8kVAwrQ=;
        b=fIAUeASCExgN6xNOySjJIaDgaIHinRZHSH/6OME9lIO5KUB8C96Dgm2js5K6mf5Njm
         Iv+Gt9xAltrbrcvcvT4IpF7e+hiJ/z8IKxEem0VGCPeGANASDXJmmHHbRyUJoGGbiFXv
         LoSbOBiNFdkOy0ofhR2AmK71PNV8XHbWy4NxKiU3zYE4byCPzJr4c7I42wfuk5pmI/cX
         syfDmreNPKwWCoXfJ9Fg8jn+i0ZGNeuV20sDmLnn1O4/iTGEI01L2lhORgpP48q8SXW6
         qfysqR5CxLa/g5auN7cSqwSgVLLYT4fUPPFAFUYwDi6X8nykYgUrMQKOn3VD2QKAOhKj
         0SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767171227; x=1767776027;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEcLp/F9Uq6NVB3VNgG8AY0r9oLq8C7H19pf8kVAwrQ=;
        b=oqBqmL65btl4r6EbUVdPFLaDBYjAz/cZKt8sW1+0TmjTU3k2ckXBQzN8jmKoEQXjQ8
         MKtPV/f3FX3OiKkjbZLrv1ZXkgRDzzOMbLy6p41vMsGTgRcHIWcM4sKfgUqMamt/jJc2
         kXt/qS4UT5tCPljvrWqwGXJvrcCpfV3ILvNBdBiyclIDIT9htX5JZgyN2vssTx8RG4hv
         Bbg3WYFSMPm+gc1earNd1b1j0k3/OvS6eX3U2DmC8JfIDPV1WciJ3D1t+nLMs8aOH0S5
         ZDgUZ90QBurTo6fjwfF2h8Rh+tnFrl3dYMtD9DZOyIr71xSPRj4T634Dpg/mseoEiav3
         lV3A==
X-Gm-Message-State: AOJu0YwvVPQiPOjeuL7eiFm3xavaQEQmBaso/Q0cRXWGjszNUlPHEyl8
	TdspddCheMFlD+YhLCt9SJPdQxT9WbynqJqWLPmTlkYOt9mpIuFQxUo+AA/Uq1biT7vUUyOCkWo
	ztZ/s+LUMGe/9ENz8fzaQqqoKs0gIqE3NEg==
X-Google-Smtp-Source: AGHT+IGHQ93F3Tury6kxsMpyVrTuIgnVMVGbs0mQe672Vf4kgnZkpMZsMOHvbBuTZHe6N2QqQIaMGREDJk/24EhBvSGM
X-Received: from wmow10.prod.google.com ([2002:a05:600c:474a:b0:475:d804:bfd2])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8216:b0:47d:403e:90c9 with SMTP id 5b1f17b1804b1-47d403e9114mr234064145e9.11.1767171227538;
 Wed, 31 Dec 2025 00:53:47 -0800 (PST)
Date: Wed, 31 Dec 2025 08:53:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251231085322.3248063-1-mattbobrowski@google.com>
Subject: [PATCH dwarves] btf_encoder: prefer strong function definitions for
 BTF generation
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, when a function has both a weak and a strong definition
across different compilation units (CUs), the BTF encoder arbitrarily
selects one to generate the BTF entry. This selection fundamentally is
dependent on the order in which pahole processes the CUs.

This indifference often leads to a mismatch where the generated BTF
reflects the weak definition's prototype, even though the linker
selected the strong definition for the final vmlinux binary.

A notable example described in [0] involving function
bpf_lsm_mmap_file(). Both weak and strong definitions exist,
distinguished only by parameter names (e.g., file vs
file__nullable). While the strong definition is linked into the
vmlinux object, the generated BTF contained the prototype for the weak
definition. This causes issues for BPF verifier (e.g., __nullable
annotation semantics), or tools relying on accurate type information.

To fix this, ensure the BTF encoder selects the function definition
corresponding to the actual code linked into the binary. This is
achieved by comparing the DWARF function address (DW_AT_low_pc) with
the ELF symbol address (st_value). Only the DWARF entry for the strong
definition will match the final resolved ELF symbol address.

[0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/

Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index b37ee7f..0462094 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
 
 /* state used to do later encoding of saved functions */
 struct btf_encoder_func_state {
+	uint64_t addr;
 	struct elf_function *elf;
 	uint32_t type_id_off;
 	uint16_t nr_parms;
@@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	if (!state)
 		return -ENOMEM;
 
+	state->addr = function__addr(fn);
 	state->elf = func;
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
@@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
 	encoder->func_states.cap = 0;
 }
 
+static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
+									  int combined_cnt)
+{
+	int i, j;
+
+	/*
+	 * The same elf_function is shared amongst combined functions,
+	 * as per saved_functions_combine().
+	 */
+	struct elf_function *elf = combined_states[0].elf;
+
+	for (i = 0; i < combined_cnt; i++) {
+		struct btf_encoder_func_state *state = &combined_states[i];
+
+		for (j = 0; j < elf->sym_cnt; j++) {
+			if (state->addr == elf->syms[j].addr)
+				return state;
+		}
+	}
+
+	return &combined_states[0];
+}
+
 static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
 {
 	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
@@ -1517,6 +1542,17 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 					0, 0);
 
 		if (add_to_btf) {
+			/*
+			 * We're to add the current function within
+			 * BTF. Although, from all functions that have
+			 * possibly been combined via
+			 * saved_functions_combine(), ensure to only
+			 * select and emit BTF for the most canonical
+			 * function definition.
+			 */
+			if (j - i > 1)
+				state = btf_encoder__select_canonical_state(state, j - i);
+
 			if (is_kfunc_state(state))
 				err = btf_encoder__add_bpf_kfunc(encoder, state);
 			else
-- 
2.52.0.351.gbe84eed79e-goog


