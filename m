Return-Path: <bpf+bounces-21590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F30584EF8B
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BABB26225
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70F853B8;
	Fri,  9 Feb 2024 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Z+MWUF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021875681
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451601; cv=none; b=RHL44D9C/GFf3JvM1z21lmwRr1WUC2BJnCD1js23UFAmA9cRPrBD8jywPYQ1VnA08Ty/GlbkXybcjPLJVGk4OJbO5HPCg6hDx3O9rMibjkrolbjTJkHproejnT/Ev5V8a0Ztpo09J1APfpVOUL1ilwNnYU+bi1i66dd14FJJpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451601; c=relaxed/simple;
	bh=q/Oh4UGLAUx5nS2repzDRhenYLeGL9xgTdHnvBGVAfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SL6EuFF0pkfkAI4mCcSIka1b+rqjuyyWdjFKByB6nHOS+U2shqL+ozYwHpoY2inKtNuf85TFiHKhwJUfJ1nrxLIAJxRfSt9nrG1nrt/A1PvK7B87ip7BqKTLshZOg7ErPA3XA28zMKAYAjM0dBR6d+BwsZlMaZDmIYPU5w6Kdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5Z+MWUF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d93f2c3701so3165485ad.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451598; x=1708056398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj+O15ERlc2oNccgk7u96NynUdtw7IljkhhXG+cbct8=;
        b=L5Z+MWUF+R9W0lgEVdctfML1z7k6SMZwGr4nOyYTpgzSBuRyKECiTUQQ2iZV71147v
         ZYNi2m3RvmGFFER5ZB2Rtio8AeJQIhQzOvsjDjSUhejojoSabHjkIN8qWdRzlA2uT8m9
         tJ19V/Y5jF3VCXHzZLvuODgvj0EgJeT/6JHsyEhyEhqAbEjKXfLWms1ELC/uySULhrkY
         TzQ60E++fcaT1e3ECOgnDTdf+J8OGNFwsFKLTMlRiPji0bYCeY9Hbl7axUqWcHqMyLQN
         +xWquk8dtlNjx7SCD5WRG26h8lIV1tt8vPjHR6i4p5ihuuKeUM/agyXZhI/qSrTTXg5L
         Z60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451598; x=1708056398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dj+O15ERlc2oNccgk7u96NynUdtw7IljkhhXG+cbct8=;
        b=FMy+1d2iZV1D0Nbe42fPciowrWtm2hpxCc826W4DSvmEsksgfWE0tRQToh+yRlH0Ef
         PBXY7fQv+AdWiZP6feXdRoB+Y8b7I4gBIUotLu17QXlVWCHbtMV0gGsvdIYqnVH/2woy
         7HfpFFfB+p/MFPC/hIiGKp4n59VIjJLOX3jKhtaM3jpQUK5vDL6UiQivU2fihcGApQwr
         7ZjQwsHoe4uO6nhgl8DM6jmuroCVgsTSxgdtNxlO33cY4sK4PJfildx8R1FQSwE5TivI
         fNmLKJAUDzRXR5gOyYaQgQC+Up51//As0B9+p+lzgmhEiwd5sJZhuf1KBMMaU4SsKUrj
         zAww==
X-Gm-Message-State: AOJu0YxC/jFbT7UnYtzLx/QZhO0wrwjsls4MXYbHUpubXhb/2m8LI4AK
	rFN9e63gLyBKkMdA/s2L81DfFBgAbbD0JK4/VTKLTdf5/cqYSikHHwrHZM+V
X-Google-Smtp-Source: AGHT+IH2IsgScbF5ztEZpq6NjR9/2tA7q8l7Ix0S1q4VHpCiUufQi2AhA2u+G2VsbGb/+uLf6rgQHA==
X-Received: by 2002:a17:902:b68c:b0:1d8:fae3:2216 with SMTP id c12-20020a170902b68c00b001d8fae32216mr419187pls.35.1707451598204;
        Thu, 08 Feb 2024 20:06:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCvhcfuaPez5OC/0K6lsZftyKKLtOFjodjSkRdPq0l1nidkiVoJHU0Trfc2t9CHoxVoGuR75BnUBtDC7gLBQ5y1kSWyuyg0x40itdsIGSi0vL6t/hDpiz3VGWvzx1E7jyVPl9K9LQX+7fbCFhxUC3CdIANDI84yBGyKa04JykPcZxl05c6A0hQNL7dkYjfPxslz4jAHOWN1SA3/EFocm4/Y4mzyEFTltE88QxdJlxI/+lGIt1LRaqh1R6CISaCy56IDDTUokGPy6rscJPCxBOK6mSWq+iGAF9teb5RqL2aAEQNZwCC6Nscq4hnc7lq7PODCpjmijWqNsxvLhCBkxJ8QMIxLowrFG/g1w/GsVw1Akxvfy/DcA==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id lh16-20020a170903291000b001d9537cf238sm538602plb.295.2024.02.08.20.06.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 06/20] bpf: Disasm support for cast_kern/user instructions.
Date: Thu,  8 Feb 2024 20:05:54 -0800
Message-Id: <20240209040608.98927-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

LLVM generates rX = bpf_cast_kern/_user(rY, address_space) instructions
when pointers in non-zero address space are used by the bpf program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/disasm.c            | 11 +++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f6648851eae6..3de1581379d4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1313,6 +1313,11 @@ enum {
  */
 #define BPF_PSEUDO_KFUNC_CALL	2
 
+enum bpf_arena_cast_kinds {
+	BPF_ARENA_CAST_KERN = 1,
+	BPF_ARENA_CAST_USER = 2,
+};
+
 /* flags for BPF_MAP_UPDATE_ELEM command */
 enum {
 	BPF_ANY		= 0, /* create new element or update existing */
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 49940c26a227..37d9b37b34f7 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -166,6 +166,12 @@ static bool is_movsx(const struct bpf_insn *insn)
 	       (insn->off == 8 || insn->off == 16 || insn->off == 32);
 }
 
+static bool is_arena_cast(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) &&
+		(insn->off == BPF_ARENA_CAST_KERN || insn->off == BPF_ARENA_CAST_USER);
+}
+
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
@@ -184,6 +190,11 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg);
+		} else if (is_arena_cast(insn)) {
+			verbose(cbs->private_data, "(%02x) r%d = cast_%s(r%d, %d)\n",
+				insn->code, insn->dst_reg,
+				insn->off == BPF_ARENA_CAST_KERN ? "kern" : "user",
+				insn->src_reg, insn->imm);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d\n",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f6648851eae6..3de1581379d4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1313,6 +1313,11 @@ enum {
  */
 #define BPF_PSEUDO_KFUNC_CALL	2
 
+enum bpf_arena_cast_kinds {
+	BPF_ARENA_CAST_KERN = 1,
+	BPF_ARENA_CAST_USER = 2,
+};
+
 /* flags for BPF_MAP_UPDATE_ELEM command */
 enum {
 	BPF_ANY		= 0, /* create new element or update existing */
-- 
2.34.1


