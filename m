Return-Path: <bpf+bounces-59107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE825AC606A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521767AEFD7
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB71F461A;
	Wed, 28 May 2025 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAo2jUyj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9D21C9F9;
	Wed, 28 May 2025 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404217; cv=none; b=BDuA29gYf89VaMiNqFN85XauTRWKCK4YTL1yiNop6Dika8y1wd4htBq5KAtY8Zd6ZgkLhLMdGeBTqgbgMcLKlb+Z9F7ZBwdZf/GrxGkCOuyzzFnraj0SbO/lTixXekVvGGDl/RBQQnIDfF5NmndWPRfNdmtB0yfGwige+lP2d3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404217; c=relaxed/simple;
	bh=OA+FxIGlKhg819WfsELB4yUlJn708Xx4wh4sMB6f6gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LA6ESrQD4iiMNRW11HG6wrIDbrAYVkcpuXpA7Ojgb7OgUT2AlKqYLxnd0h/QwYPJDcksamqolyDHGNhdx3/US7pl1EuhNE24i1vusX1eMTPD20w+7QeWdkdFWyT79BrLoUaPX6DqXHK3PHtx8W6/aOA0K5WTv/k5LOuLQgLWD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAo2jUyj; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so2412935a12.2;
        Tue, 27 May 2025 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404215; x=1749009015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WffP/cSbyBFMF+/uXvI9bocvXjk7B9YFHd0hp/gMMUk=;
        b=TAo2jUyj0CofIR7R/EO1PIYcH5b9CdUg5UWROkNV3b+lxFtiRdgjodP9gSDVU2NrBo
         C4F9dRMWg7c6vLFiRLjttCoSZzmC/hKG9V4yz+f0zqFaMCniYfX5i83M7QhWH9iSdW+u
         g1T2tt8qM3FZNrsj+L2bWVZUQYgqhBCW9ED4vq07pY1SqQEqbpRB263Jcfs2Zz4JAtJT
         kGYc4f1CnSyxlhJP5eho27BMr+xvUbPvoag+G9YBwo6H5ISjpzfz5at+aiBohxtIhFOX
         hA69ANp3EMt5qcVh8JW8riYTfhVu9XZLGvF3k4szMDzkHb1iSz6oii1HhB4avzr220p+
         rHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404215; x=1749009015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WffP/cSbyBFMF+/uXvI9bocvXjk7B9YFHd0hp/gMMUk=;
        b=IcccYVw8Fi6RntT+YBM7Gf/ANoIjgoXgF3x6VJXxCgGdVqQlRKZ5mo4mDlL7jRjtZR
         5zu+hxq4sGnQ50DIdVywtzSdzz311XxddvA9qzQtqkkmm3koBcqG4OVwKfFE80QNPicE
         Bg030dUC32kCvMdgkh6Snk6zax6Op4ZqTOeHWXnhtoJjU+JF7m4of/eoorDottUrgflf
         NplFh4IQWFbplewxSbMfKr66P8g8yjB9OQXdy3W3ocz8eH+aAI+7NUURcF5UjiLCOBB7
         XUF6D4ziDHUGjeu+WOQ312YvdWxNLPwVWyP6u33F3gSjQ1fx7RgMGzrzei2psG70oPp2
         Tokg==
X-Forwarded-Encrypted: i=1; AJvYcCUKQblZlCmnICR3oANA63NCvgKaKuAK9vzRrcjHuSaqkSymlSxxS3AqzUKEyQIx4TWkNtz1vpLM1In926s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKd/09694KEsXC62+MKQ8tfIUkNVmlU5WevdnLZElDzbOSdZA
	TsWgVP3qlEbg5wr+bye6+0VHNhVcQEpRQJrHjjYh+EJlcfiCAT2u0K04
X-Gm-Gg: ASbGncu86K2l6nK5S+9PCBMZEvuj1KxAiFUmklFw90mH9TxPAml1t1svqLedLIIsow2
	plIQVEDQzQeu/OT+Y5va5jAl8uJZxYtd+aCuZ57crN4jt/60nc8GWAGYKtX4qwfoKNc5jqSE8z3
	JuqZxefRZ8fqwAg8+XYa/uWS1hqjZz/t1E6bANCX5Ro85XNmF8v1aeTux4oKSkFCOWcvGDYoJ9+
	DXKkPFePRIa9Vcd2qa0WuMTTxhhIqP7oRBIXKrX0mj6S8GV1MVKMJ2OHA929BdGKYOuYgqbi+WV
	HGno7N8TuUhG5NRAvtyY+sBak39zd8rhRUmClAop/dKaF2xu5CW7AX39vfAGZA2b8B1d
X-Google-Smtp-Source: AGHT+IEO4NrcYqigTspQOA9dpUSJowPXjoJZkbYF2Lxs7j/SRyuV59rn8R0FzF4o1MHWYhKhpnLV/w==
X-Received: by 2002:a17:902:ecd2:b0:223:7006:4db2 with SMTP id d9443c01a7336-234d2adc24amr10290065ad.31.1748404215441;
        Tue, 27 May 2025 20:50:15 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 18/25] libbpf: don't free btf if tracing_multi progs existing
Date: Wed, 28 May 2025 11:47:05 +0800
Message-Id: <20250528034712.138701-19-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, the kernel btf that we load during loading program will be
freed after the programs are loaded in bpf_object_load(). However, we
still need to use these btf for tracing of multi-link during attaching.
Therefore, we don't free the btfs until the bpf object is closed if any
bpf programs of the type multi-link tracing exist.

Meanwhile, introduce the new api bpf_object__free_btf() to manually free
the btfs after attaching.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/lib/bpf/libbpf.c   | 16 +++++++++++++++-
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e9c641a2fb20..cfe81e1640d8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8581,6 +8581,20 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 	obj->btf_vmlinux = NULL;
 }
 
+static void bpf_object_early_free_btf(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+
+	bpf_object__for_each_program(prog, obj) {
+		if (prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+		    prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
+		    prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI)
+			return;
+	}
+
+	bpf_object_post_load_cleanup(obj);
+}
+
 static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_path)
 {
 	int err;
@@ -8652,7 +8666,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_early_free_btf(obj);
 	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 
 	if (err) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d39f19c8396d..ded98e8cf327 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -323,6 +323,8 @@ LIBBPF_API struct bpf_program *
 bpf_object__find_program_by_name(const struct bpf_object *obj,
 				 const char *name);
 
+LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
+
 LIBBPF_API int
 libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			 enum bpf_attach_type *expected_attach_type);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1205f9a4fe04..23df00ae0b73 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -415,6 +415,7 @@ LIBBPF_1.4.0 {
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
+		bpf_object__free_btfs;
 } LIBBPF_1.3.0;
 
 LIBBPF_1.5.0 {
-- 
2.39.5


