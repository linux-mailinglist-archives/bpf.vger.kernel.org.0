Return-Path: <bpf+bounces-55878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE3CA8883D
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCC07A4FD9
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641327F745;
	Mon, 14 Apr 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqj/SW92"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD25A27B51A
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647299; cv=none; b=qGKlg00F8RyELB5wsi5hoPSarQQ9+UC+ZUpSQRTjujJgQ4zXN+daeQoemKcGM1hqCyxa60jlRpMTmvBDy6CKO28hY13ju7hHoI0mFGslww1+FT9GIzQ8PZL8tmHyND2Z2nx9FFrq38HjQwkRphXBZ1GsDjps90bhgNc5vhNyUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647299; c=relaxed/simple;
	bh=6lHBUe/VdpvPirAmrRbc+bD5135B7NGLqizHUpWBPNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0dRO14WdnWV8GOdtxusmJEmsTof0JvAcoIDG8fcpm4srimxi2LAqQVRct2GIubN0avHsSY78rrtaRNSS7kGh/lvtvoreprl8ScAMl/sxPtIifeMa5DvWXMZex0fPtoYnWM2tLhK9dXQn8gogTuVaekQ+JXSL4GefS0m8Mpq+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqj/SW92; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-39c266c1389so3124115f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647296; x=1745252096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNUsMw1maYsjUg3yswn5HDJ5EK5yFMdHvKWyGoPN7pg=;
        b=Oqj/SW92PtmqlA/bCODdg0Nwamn39OhSYPsL41F+N3Y47PDZqF7N1W4ntuwr2umeSa
         wv2YF2gA38E6zFN0jWBBSAqnJrkp8lx6H8X6OTYFtL8jCK2a5/tMpy1ieCsbvSL5RRVD
         Sf1lNJwvtDPjryo/mEL6CWT/9H/fQN0Fm5gTWLzrxwEDLkTYxSn5YH5v0kH4G9VRIKKS
         9a/qNsk2/1MFvpydghk++eiHQBS4uokM3yhOE5brh6TVHe/X1PTwcZN9x1DcLamEUO7q
         YC8W9Cczs9bwbXsql2cnkGb9/ROJ7xz2KmNuC1Jcx106Mic3THazDpp2SRTJarmgsQ+V
         yXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647296; x=1745252096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNUsMw1maYsjUg3yswn5HDJ5EK5yFMdHvKWyGoPN7pg=;
        b=TPm0f7XYAzbC9230CD2nuh73W/BHdpPDXavIq569SYK98HRGK5yvh4dU8cJ5M7gBbu
         d2IWJJGrspdNVJEns4UCL7eNTs1bTOMGtsQpfv9oFwLOVigUJJ7xbh59q+CjuaASmOOL
         1q2UaYZjbGWnyaRlaozzXTFxzwkKM3iucJTQbHKghl4lXrkC9U8tvOMXx6yg5npYrPw2
         NX2wSadepn3oGC9MYhb20Isw0ZhFJuL4H7G3oy5c+c+0qzKIKreWNHcXEw1Sw6iDXJjd
         lDpth+ALV2LXr7U/soDfi5p6ULvpm5GdL2T/VU2rzO9zz0/9P0aMNrA/wK/YmYXHlDdr
         9EUw==
X-Gm-Message-State: AOJu0YzHnORV+rVTvcst2idAawA84wwjdkeFnvTIuz95YRlgbWlOq3Qx
	kPfcT9VwIUqwEgoBT3ea5TsP8XZrERZNHFUk9+fNcKy80zWroDAQZjou/nFvKx0=
X-Gm-Gg: ASbGncvSvFK+yKpj27hBCKCqz4jdUPSgWW24h2Ht6TF0k03DT1IMVZZccEJlo/kK4NT
	K5KJnJ3nLRxfGftd/IOiAAqoZZ5OptYfrcwMXkmf17Xjr1BCI6RtmZzvvtVdrRrrFNtqQLo8EHT
	GiJectnK03C8J+F9gJRKy2d1vKxO+T3k+GCSr1hanIw4b/aWHJWloZK636dFzXIAn0wZfHyGofl
	hw1HKmPSykGRfCiSOqEP/6oFwKU+R5p9+GzYQJqQhnV3EzelnYCMIT022yKLLG4IRgmT2E5KOoi
	I4OO4hSpHe5PIIUCAzvCFCFnD3EdtQqECNkyGBV0Mw==
X-Google-Smtp-Source: AGHT+IHLF+UzAsiv0pRHRMjyzXrKN8QyRrX5T6sh/efFgWh+DwKCQDc3z+CoBVQzWa25oUETDet8zg==
X-Received: by 2002:a05:6000:4305:b0:39c:1257:dbab with SMTP id ffacd0b85a97d-39eaaed3ebemr10669591f8f.59.1744647295424;
        Mon, 14 Apr 2025 09:14:55 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977a7fsm11336751f8f.45.2025.04.14.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 08/13] bpf: Add dump_stack() analogue to print to BPF stderr
Date: Mon, 14 Apr 2025 09:14:38 -0700
Message-ID: <20250414161443.1146103-9-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4337; h=from:subject; bh=6lHBUe/VdpvPirAmrRbc+bD5135B7NGLqizHUpWBPNQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOJJe0llvBgpzN4ZqKYz3WpkGoLcrFdNy9NNQaY ZdMvfCSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0ziQAKCRBM4MiGSL8Ryha9D/ 9JN7wnHujGxR53KaHW3NCoQMz27xqkGGsUETc+9UcV3dYPnuOTa0X1U18cshwoIhfO72hjdVGXuK7S qFvwjUuuKJ0daDjXcibsZjF60EA9idzuILlqwjPj924QibjdlPvpZt6qTKSvJmkycNfBgoLhrqBGSx VWxuF4Ay2FaKEXzbILG9XTshbhpPQ334Mk4UAqPqqQbtvW6Q3iDN1OAt7ddn3z6SBO61aY5j/Mm9vz PPvqALaU2vV7MtjXDuuq6NLNZBIMpa72Fkubmj/dJj7gh8Fi34pcdxZo8OFphyrVVxLPX0Vl2Zu4jB u/0toZnUeON+mGzb5JI2PDgg5kJGhzEhUL2DVuz/QF1iZlRj7bDDHj7cbmSZHzPx5JKkHTu6z09Xfn PuBIpA9h753qak4q8Np4yAtXnWtay50Btw678JANs1vSvH+OqVca8AG0itxqdFx7z+AwoA6DDwCWIU yMU1SXMTM/DL19M28CLEvuNRrVq+6B7fQ1wIj8xm6sgDhatFi5toHiMyw043BL4KJ/Bh21XhKfXF8s PlvWd7ULoPjcPI5ys5XhVwmvd9BnDg/qfNgXnTgwgcivGykqLtAeLyTm9IfGe/7fC7zNys7w+ALxfk 8WevsiNBSgeujiIRbGcf4tJm4pzienFpKJKX9pCHnSdb5nbIvD0QH6XhklLw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce a kernel function which is the analogue of dump_stack()
printing some useful information and the stack trace. This is not
exposed to BPF programs yet, but can be made available in the future.

When we have a PC for a BPF program in the stack trace, also
additionally output the filename and line number to make the trace
helpful. The rest of the trace can be passed into ./decode_stacktrace.sh
to obtain the line numbers for kernel symbols.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  2 +
 kernel/bpf/stream.c | 99 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ae2ddd3bdea1..d4687da63645 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3588,6 +3588,8 @@ void bpf_prog_stream_init(struct bpf_prog *prog);
 void bpf_prog_stream_free(struct bpf_prog *prog);
 __printf(2, 3)
 int bpf_prog_stderr_printk(struct bpf_prog *prog, const char *fmt, ...);
+struct bpf_prog *bpf_prog_find_from_stack(void);
+void bpf_prog_stderr_dump_stack(struct bpf_prog *prog);
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 2019ce134310..f5d8d2841a13 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/percpu.h>
 #include <linux/refcount.h>
@@ -494,3 +495,101 @@ int bpf_prog_stderr_printk(struct bpf_prog *prog, const char *fmt, ...)
 	bpf_put_buffers();
 	return ret;
 }
+
+struct walk_stack_ctx {
+	struct bpf_prog *prog;
+};
+
+static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct walk_stack_ctx *ctxp = cookie;
+	struct bpf_prog *prog;
+
+	if (!is_bpf_text_address(ip))
+		return true;
+	prog = bpf_prog_ksym_find(ip);
+	if (bpf_is_subprog(prog))
+		return true;
+	ctxp->prog = prog;
+	return false;
+}
+
+struct bpf_prog *bpf_prog_find_from_stack(void)
+{
+	struct walk_stack_ctx ctx = {};
+
+	arch_bpf_stack_walk(find_from_stack_cb, &ctx);
+	return ctx.prog;
+}
+
+struct dump_stack_ctx {
+	struct bpf_prog *prog;
+};
+
+static int dump_stack_bpf_linfo(u64 ip, const char **filep)
+{
+	struct bpf_prog *prog = bpf_prog_ksym_find(ip);
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
+		return -1;
+	len = prog->aux->func ? prog->aux->func[prog->aux->func_idx]->len : prog->len;
+
+	linfo = &prog->aux->linfo[prog->aux->linfo_idx];
+	jited_linfo = &prog->aux->jited_linfo[prog->aux->linfo_idx];
+
+	insn_start = linfo[0].insn_off;
+	insn_end = insn_start + len;
+
+	for (int i = 0; linfo[i].insn_off >= insn_start && linfo[i].insn_off < insn_end; i++) {
+		if (jited_linfo[i] >= (void *)ip)
+			break;
+		idx = i;
+	}
+
+	if (idx == -1)
+		return -1;
+
+	*filep = btf_name_by_offset(btf, linfo[idx].file_name_off);
+	*filep = strrchr(*filep, '/') ?: *filep;
+	*filep += 1;
+
+	return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
+}
+
+static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct dump_stack_ctx *ctxp = cookie;
+	const char *file = "";
+	int num;
+
+	if (is_bpf_text_address(ip)) {
+		num = dump_stack_bpf_linfo(ip, &file);
+		if (num == -1)
+			goto end;
+		bpf_prog_stderr_printk(ctxp->prog, " %pS: [%s:%d]\n", (void *)ip, file, num);
+		return true;
+	}
+end:
+	bpf_prog_stderr_printk(ctxp->prog, " %pS\n", (void *)ip);
+	return true;
+}
+
+void bpf_prog_stderr_dump_stack(struct bpf_prog *prog)
+{
+	struct dump_stack_ctx ctx = { .prog = prog };
+
+	bpf_prog_stderr_printk(prog, "CPU: %d UID: %d PID: %d Comm: %s\n",
+			       raw_smp_processor_id(), __kuid_val(current_real_cred()->euid),
+			       current->pid, current->comm);
+	bpf_prog_stderr_printk(prog, "Call trace:\n");
+	arch_bpf_stack_walk(dump_stack_cb, &ctx);
+	bpf_prog_stderr_printk(prog, "\n");
+}
-- 
2.47.1


