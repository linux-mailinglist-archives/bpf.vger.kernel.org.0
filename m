Return-Path: <bpf+bounces-21068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043098474DF
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E711F2AB73
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897481487FF;
	Fri,  2 Feb 2024 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="a1qrDorq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0D1487F4
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891664; cv=none; b=ax8475eyMhQiE8dHgrWzT4SkBlJLQ3hGQwsRXCNyymB0edLhW4AshbdlCILD7xNI8Sfb8TWfj5kOw8vjIEiVxZFfAxRHrXjFaiJQIwRqBQCxRWMkSe92P4JvZoVQTJs8nhQQh1ryp/xDtGJsQfiTbVC8EmjxP4JRagG+vbhJ3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891664; c=relaxed/simple;
	bh=TL9L4X+rUjQ91gN/VNqRNMR+Gb80qW9iWai2lkK8nyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHlB2bWagAROmnzPPcgajoiSS9eTd+jOTuiGHnp/kk1eDXwdpVZQfLwMGZ+uXx/I8/3nlo3pzk3KQfSROO/HkQQgUhuN43W4rhi5GillNj91M/GQnr5TtfZLMLOq4vttwGdKbzSEfNtmRQOQwZHUe/O6RHDG2z9lQgbAZprZwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=a1qrDorq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55790581457so3388456a12.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891660; x=1707496460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eEh07CcQmyPa939B6UJrl0j+WeVe+LqiVEymgHgF5I=;
        b=a1qrDorq2KcR0amqbXFOAdYKk8AtVm+FNmW+kGR+LWKEVh4OGeGKhagQ3KC5qxp4bR
         n6wGOJ+bQDPLLTY2M0hSib7/IdkR6lKbYFHNTNbAXQVWaRDZoejjcamwdRDa2s7DQUPt
         pslGCixUcFpsm+smFx4HKacedU67/preP9NvxFlpb8j1MWPDQXYPoxQzO14UGWRKFmQ7
         i9a7L9obznj9/XlbKzLRAnxMGghntTktrrjOnozcsEbfCTsdwr/aQ3F124JzOaf6gfnh
         U1YXQ4rCLCR0ZQAgxBBVU+SAFi+dUoGKiqnugUONj0UvnlKHBB5sO/zJgJl2FdiFjxGO
         07Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891660; x=1707496460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eEh07CcQmyPa939B6UJrl0j+WeVe+LqiVEymgHgF5I=;
        b=NvqodFyoEjDWkQc9ST1BPG4uqlx0/4y2NI2KdNoaX5T54xegTH3y4Fsx1PS4KV1AMH
         GhLjVMErzmTJdFnhHmRq/S4oa0cHfqhaQxyhiUxoHM9xXSGoBBi5BnHp6kT8J1FYjKyn
         80/XP0iDgURG/ipGE0eQ3K78zZFNJmVWJacEtd+n8j45pVrZyV6rhqxtQCOGo4kBgbCZ
         7fXK3XhhAG3ieGqUlOfrQhGG4OdLAoR4iF8p0JEwkzle1JAIYwnWiv+8AP9M1G37st92
         uIOoe/k8F334NlS16QhnrL/pkPcqGb/j/RbUe8oeUs9h28DKf/A60REe8//cbwLyBfqD
         CdKw==
X-Gm-Message-State: AOJu0YzxTweZUGRcWxl10uMkW0zX4EX5II8YDqXKFwZe12RpCDW/8ziP
	CHf/6FfTOT6ATerZp6QjqDI2XX4f3TwC6HRSrcdw79Lt/zaD3HXj06Rc9SLS09U7xHogsOl1euJ
	f
X-Google-Smtp-Source: AGHT+IFdZIe48zHhRIjAriwrZeL4gOML7pW6+xIz9F1EcMFy33EQz/xzxMvrDmcaelxrvietrZRprQ==
X-Received: by 2002:aa7:c0c7:0:b0:55f:8c5d:e55e with SMTP id j7-20020aa7c0c7000000b0055f8c5de55emr120857edp.26.1706891660541;
        Fri, 02 Feb 2024 08:34:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZ55Mebdh/6cz2O3bKDVLT929R+EdMAANKiTaQebr0axKBuhqaJcp5BHI9sk5hIMq7cDEgHNfUxv3fDw+BDnDoIIHfiTZCVxlSOzn0KN0M5v76eda13KE8mvtVLrNwpwM9xI48bVlh3tWp/vXX8YXTo8GM0hq1ReqYVsq0hT94pcUw3ekFZdxHlIsbeoxQPyxpGAK03ZhfGfOIqYc5vPnW8TMSbxbPROflpAKluPLIOVLV5cj8NDTW5oHTvMWdVHMTSUQ2CFpH+1X5jSVgz3YDnOXeMyhQClxlkWcvSvRJUgH18PLaxJA=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:19 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 5/9] bpftool: dump new fields of bpf prog info
Date: Fri,  2 Feb 2024 16:28:09 +0000
Message-Id: <20240202162813.4184616-6-aspsk@isovalent.com>
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

When dumping prog info in JSON format add two new fields: "orig_insn"
and "jit". The former field maps the xlated instruction to the original
instruction (which was loaded via the bpf(2) syscall). The latter maps
the xlated instruction to the jitted instruction; as jited instructions
lengths may vary both the offset and length are specified.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/bpf/bpftool/prog.c          | 14 ++++++++++++++
 tools/bpf/bpftool/xlated_dumper.c | 18 ++++++++++++++++++
 tools/bpf/bpftool/xlated_dumper.h |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9cb42a3366c0..d3fd7d699574 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -119,6 +119,12 @@ static int prep_prog_info(struct bpf_prog_info *const info, enum dump_mode mode,
 	holder.jited_line_info_rec_size = info->jited_line_info_rec_size;
 	needed += info->nr_jited_line_info * info->jited_line_info_rec_size;
 
+	holder.orig_idx_len = info->orig_idx_len;
+	needed += info->orig_idx_len;
+
+	holder.xlated_to_jit_len = info->xlated_to_jit_len;
+	needed += info->xlated_to_jit_len;
+
 	if (needed > *info_data_sz) {
 		ptr = realloc(*info_data, needed);
 		if (!ptr)
@@ -152,6 +158,12 @@ static int prep_prog_info(struct bpf_prog_info *const info, enum dump_mode mode,
 	holder.jited_line_info = ptr_to_u64(ptr);
 	ptr += holder.nr_jited_line_info * holder.jited_line_info_rec_size;
 
+	holder.orig_idx = ptr_to_u64(ptr);
+	ptr += holder.orig_idx_len;
+
+	holder.xlated_to_jit = ptr_to_u64(ptr);
+	ptr += holder.xlated_to_jit_len;
+
 	*info = holder;
 	return 0;
 }
@@ -852,6 +864,8 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		dd.func_info = func_info;
 		dd.finfo_rec_size = info->func_info_rec_size;
 		dd.prog_linfo = prog_linfo;
+		dd.orig_idx = u64_to_ptr(info->orig_idx);
+		dd.xlated_to_jit = u64_to_ptr(info->xlated_to_jit);
 
 		if (json_output)
 			dump_xlated_json(&dd, buf, member_len, opcodes, linum);
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 567f56dfd9f1..fcc1c4a96178 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -270,6 +270,24 @@ void dump_xlated_json(struct dump_data *dd, void *buf, unsigned int len,
 		jsonw_name(json_wtr, "disasm");
 		print_bpf_insn(&cbs, insn + i, true);
 
+		if (dd->orig_idx) {
+			jsonw_name(json_wtr, "orig_insn");
+			jsonw_printf(json_wtr, "\"0x%x\"", dd->orig_idx[i]);
+		}
+
+		if (dd->xlated_to_jit) {
+			jsonw_name(json_wtr, "jit");
+			jsonw_start_object(json_wtr);
+
+			jsonw_name(json_wtr, "off");
+			jsonw_printf(json_wtr, "\"0x%x\"", dd->xlated_to_jit[i].off);
+
+			jsonw_name(json_wtr, "len");
+			jsonw_printf(json_wtr, "\"%d\"", dd->xlated_to_jit[i].len);
+
+			jsonw_end_object(json_wtr);
+		}
+
 		if (opcodes) {
 			jsonw_name(json_wtr, "opcodes");
 			jsonw_start_object(json_wtr);
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index db3ba0671501..078430fada17 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -26,6 +26,8 @@ struct dump_data {
 	__u32 finfo_rec_size;
 	const struct bpf_prog_linfo *prog_linfo;
 	char scratch_buff[SYM_MAX_NAME + 8];
+	unsigned int *orig_idx;
+	struct bpf_xlated_to_jit *xlated_to_jit;
 };
 
 void kernel_syms_load(struct dump_data *dd);
-- 
2.34.1


