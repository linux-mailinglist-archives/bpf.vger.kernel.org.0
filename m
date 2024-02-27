Return-Path: <bpf+bounces-22789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D289786A0FC
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CE91C24631
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556914E2C6;
	Tue, 27 Feb 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd34Em+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25014D425
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066794; cv=none; b=Ici9+qBrYaYDdDzHxbsi3ynuRPhMgK5TfCM6fZ0ukCuZdQYBEiQBRfnORU0AqeSZzQg4+1HvzX59WedBChOn/LfR0hHDW5Uu41ICXnbgTTJ63t6ThaI9Wg1+hajXE3MpTc0c1xw4Nhv7+cG5QVqLguNxUh5vrF9usiW2slnIfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066794; c=relaxed/simple;
	bh=ZdJM11ZJMQL4kqeHstlcNnl5hl1UkYiPZkVwm1vJIVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cngrCG44ODPK8flnCx3QfA4+IQUokGf2DNuBmThviFvieTWZsoCxcQGVBm/2zlzLIFy9yqctL5zCyUdV2niMe2NprefcTIufHT9sKLF6YHgOXMZTeA6WWoocc3G8ApZDVYtTNXfuQBWniWH4mfUIiaKaw9jGG0WJ2vQfthdpEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd34Em+w; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51316d6e026so643964e87.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066791; x=1709671591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j00Md19Jw5VmAQzRBHP8AbFIwaIQCyFiwhh2nW0rXis=;
        b=Qd34Em+wc7yYU9G7tYh3ZnaNuEFaMsbTkxQg4ACnXHdI7zpCgA+mhkJa+A0p20w/IO
         dQtEUhCEWl9rkp3HXLCOayfB5baYYFHGKcT98RON1fBD3Qj2qUjhip3dx++jxuWUxcVD
         CxcEEtKc+BjzUNR59UY7GhTkc6ySneMdW23JQDIBSaRyMnUPnNfZ79rkFZHP7gONIGvc
         VcjepKvyuHlztug5i8kO/5RzP2d55qpsvnhb3xp4NMWjwFcNG9gdy5Ytvf8SYUY96mPL
         Y328ygMPB70awXv0mLwG79GDPTsh6qtCIgEaNCi+0yWAwFShoGWwkqW5RL//GoqTCVR9
         CNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066791; x=1709671591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j00Md19Jw5VmAQzRBHP8AbFIwaIQCyFiwhh2nW0rXis=;
        b=nLxIzBHwKaCrTstWRL+B/2Rb+8Y7roFzaf/QKLwJPopPl3oI7j0Btt5UTmwUZR5/Sg
         0btyEAdcI6jOlSoKPaTGJUq0KjnmgWE2AX/jPes/uX5vRC+U8rEFWEywwcOxQw9x6/zl
         tszu7lN5QMjsIA1IlMKeFjnGrxx3BFEQHimEKkGu2/FPd8fwKwouWE/HQnZ6DAYO8b2T
         o4df8aamMNRbLhIZksb9DKuLt7mP5tCL/v8AQngBGeqTOmNJn6+S2g31zdGl17CrkKjm
         UEPuHhX0jbvYMW16kRmuJZTVTnFqsjnDsa+11UJS2oQr6l7+B2RR231DlrM2hVBSIrO6
         OqBA==
X-Gm-Message-State: AOJu0YxVLLX32+DS5NGkcdEXOOQv0gGiTUoJj0oPjEDTwYRZdTBoJD0C
	Wl0Kysg3GwmIJyzSWu6dT9iXRQe8WkS5lpCZCeV9pqwmNyETl41SG+HWueK4XRw=
X-Google-Smtp-Source: AGHT+IE+plvsJAuBAjP1auTDnyc9POXqssakgs32dKPl0WhlNrOWsdxPRcStKlfn9SpPp1qiTOVdXA==
X-Received: by 2002:ac2:4e6e:0:b0:512:a939:3fcc with SMTP id y14-20020ac24e6e000000b00512a9393fccmr6202191lfs.32.1709066790717;
        Tue, 27 Feb 2024 12:46:30 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:30 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/8] libbpf: tie struct_ops programs to kernel BTF ids, not to local ids
Date: Tue, 27 Feb 2024 22:45:50 +0200
Message-ID: <20240227204556.17524-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227204556.17524-1-eddyz87@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enforce the following existing limitation on struct_ops programs based
on kernel BTF id instead of program-local BTF id:

    struct_ops BPF prog can be re-used between multiple .struct_ops &
    .struct_ops.link as long as it's the same struct_ops struct
    definition and the same function pointer field

This allows reusing same BPF program for versioned struct_ops map
definitions, e.g.:

    SEC("struct_ops/test")
    int BPF_PROG(foo) { ... }

    struct some_ops___v1 { int (*test)(void); };
    struct some_ops___v2 { int (*test)(void); };

    SEC(".struct_ops.link") struct some_ops___v1 a = { .test = foo }
    SEC(".struct_ops.link") struct some_ops___v2 b = { .test = foo }

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 44 ++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index abe663927013..c239b75d5816 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1134,8 +1134,27 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 
 			if (mod_btf)
 				prog->attach_btf_obj_fd = mod_btf->fd;
-			prog->attach_btf_id = kern_type_id;
-			prog->expected_attach_type = kern_member_idx;
+
+			/* if we haven't yet processed this BPF program, record proper
+			 * attach_btf_id and member_idx
+			 */
+			if (!prog->attach_btf_id) {
+				prog->attach_btf_id = kern_type_id;
+				prog->expected_attach_type = kern_member_idx;
+			}
+
+			/* struct_ops BPF prog can be re-used between multiple
+			 * .struct_ops & .struct_ops.link as long as it's the
+			 * same struct_ops struct definition and the same
+			 * function pointer field
+			 */
+			if (prog->attach_btf_id != kern_type_id ||
+			    prog->expected_attach_type != kern_member_idx) {
+				pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
+					map->name, prog->name, prog->sec_name, prog->type,
+					prog->attach_btf_id, prog->expected_attach_type, mname);
+				return -EINVAL;
+			}
 
 			st_ops->kern_func_off[i] = kern_data_off + kern_moff;
 
@@ -9409,27 +9428,6 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
-		/* if we haven't yet processed this BPF program, record proper
-		 * attach_btf_id and member_idx
-		 */
-		if (!prog->attach_btf_id) {
-			prog->attach_btf_id = st_ops->type_id;
-			prog->expected_attach_type = member_idx;
-		}
-
-		/* struct_ops BPF prog can be re-used between multiple
-		 * .struct_ops & .struct_ops.link as long as it's the
-		 * same struct_ops struct definition and the same
-		 * function pointer field
-		 */
-		if (prog->attach_btf_id != st_ops->type_id ||
-		    prog->expected_attach_type != member_idx) {
-			pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
-				map->name, prog->name, prog->sec_name, prog->type,
-				prog->attach_btf_id, prog->expected_attach_type, name);
-			return -EINVAL;
-		}
-
 		st_ops->progs[member_idx] = prog;
 	}
 
-- 
2.43.0


