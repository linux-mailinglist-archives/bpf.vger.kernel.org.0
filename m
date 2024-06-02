Return-Path: <bpf+bounces-31166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5BC8D78EF
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 00:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB60C1C20B7A
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C286EB68;
	Sun,  2 Jun 2024 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIpnY5xp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE4A21;
	Sun,  2 Jun 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717369123; cv=none; b=XVP1tijxfraCQyoKyANsq2YcK6AcPoF6PiH7ZugZegGS/EkqQmDgroQ65qtcF6mJtiFkFrJdXk+sbLRwG4Awd5x5lg/I3MoRMTFMrphwNAS7kfHUYyGZC6rnILE/yDueF0Mzztvs5Hts6vbl0sK3C4MNr5FirjYUDpiz8Jl9YOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717369123; c=relaxed/simple;
	bh=l5o5JcMau/VusknSuamjv+4ITRRlMR5KV3zcY3ndfCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qeijnXO/nISjOOJlnNSpUhUoEg3ibPRGeL9pbcSd6b4ru+LTRPsz+7FfiKHdT1yleBI6xxzgwSnO9hZSbwdwhHEycqkcn2uGta2J3XajuSER1K9AdMLiJs2iqGSKT52EkAi40gFLsuue/svugrWiZtHK88fgfwtFQo57GJiHqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIpnY5xp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42120e3911eso33377985e9.0;
        Sun, 02 Jun 2024 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717369119; x=1717973919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJN1BIYPem4Vicpm6XqYQ1DycrTK8vnRrbZGTtf9tP0=;
        b=gIpnY5xpI4Cn6aCDcLpbhhZFczoQ91+0NhGsl3ZYLNKKIQOvJGQNxIDC4dLgRDtmtJ
         WTrBDz/Pb/FGY6dMw8BKxmlN5hzl4qSL7s0PClV0FdXSgByKM5HGg7zXB6d630A7a2Of
         x2FJOrDvdpLZ7QNTqBCSaQnrS/mdWr6kZrOZOK/dbspMv/1yo3MWjdN/bXBtXaYT+BGk
         ZXC2QD74jDKVI/RAA/SxPcnsW1+gk2XDE2r4noUtwnPXDPac0DbI5rQ6TfwAwC/NSSP2
         eszLrCgEdGytwP/dCo9Lz++S6fGTdUIVtzL/eoKoM/t5L/u2XphEhnfLHExWeR6DBHmD
         j+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717369119; x=1717973919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJN1BIYPem4Vicpm6XqYQ1DycrTK8vnRrbZGTtf9tP0=;
        b=SimxjH2Gpq01dRhPZ/kDT29MEroFWh2fkJ4KJMkjvMhKXDq9FXa2uYG4Up0FckpL90
         b0TIWXgwPE5mC2PapqkBsTPxbAJpEfSX9DQfjc5HHb9mJj0qaVGnPK+awABVyYAK8qcM
         oFI1Nl9fwLa+Qus3EtJuNpg94bqhI7ApSBt5ycIGFC+vnc1TBeS5H8rv5AeJe1Arj8So
         rY0M2yhu12V3jXoJsHVCaKDUa/oLPc50aI2vVfcZgcjPkcfjuoZHGyz7zAumA6tTuj17
         mozKI/Ys7nKYZZF479nLjFjSq9v9/y36la+4q1a6m8W3s2T5c0ImtNl7QaB7/up0C2gh
         AjPg==
X-Forwarded-Encrypted: i=1; AJvYcCWxan+r3nYaiIR/PDQqeFOapMgwswhCLiP8Vi6q/O8lUkxXBhryKbEF7N5xb5NnwQuyrvB7Jnq9V1x/1oKPfh+ca9xVv/8NlG9RcMKsO7+g9+4ANMGJ2+WUa0QGJoxcfpv8
X-Gm-Message-State: AOJu0YxjV3zScpJfXSG43LPKr449Y46E03S+78BQXuc9Pc89ZCbEz9ew
	0O3aCToC/nBTd2lD5n5J5oZOSmXTezoIrEAOmcRuSnnYh6Of4j0wRh8LFV6x
X-Google-Smtp-Source: AGHT+IF0zeDftp2EVR0WrwbVei/VT7PflWWHur4Di2Pfg2B1bjup06PX3rrsIEX05i7ihSDvaLjM9Q==
X-Received: by 2002:a05:600c:3144:b0:41a:c170:701f with SMTP id 5b1f17b1804b1-4212e0c4000mr61390705e9.38.1717369119206;
        Sun, 02 Jun 2024 15:58:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8429:ddef:6d01:2c8c:394b:7d6f:b34b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4212278968fsm111599385e9.0.2024.06.02.15.58.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Jun 2024 15:58:38 -0700 (PDT)
From: Swan Beaujard <beaujardswan@gmail.com>
To: 
Cc: beaujardswan@gmail.com,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bpf: matric typo erro
Date: Mon,  3 Jun 2024 00:58:12 +0200
Message-Id: <20240602225812.81171-1-beaujardswan@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected typo in bpftool profiler.

Changed all instances of 'MATRICS' to 'METRICS' in the profiler.bpf.c file.

Signed-off-by: Swan Beaujard <beaujardswan@gmail.com>
---
 tools/bpf/bpftool/skeleton/profiler.bpf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index 2f80edc68..f48c783cb 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -40,17 +40,17 @@ struct {
 
 const volatile __u32 num_cpu = 1;
 const volatile __u32 num_metric = 1;
-#define MAX_NUM_MATRICS 4
+#define MAX_NUM_METRICS 4
 
 SEC("fentry/XXX")
 int BPF_PROG(fentry_XXX)
 {
-	struct bpf_perf_event_value___local *ptrs[MAX_NUM_MATRICS];
+	struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
 	u32 key = bpf_get_smp_processor_id();
 	u32 i;
 
 	/* look up before reading, to reduce error */
-	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
+	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
 		u32 flag = i;
 
 		ptrs[i] = bpf_map_lookup_elem(&fentry_readings, &flag);
@@ -58,7 +58,7 @@ int BPF_PROG(fentry_XXX)
 			return 0;
 	}
 
-	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
+	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
 		struct bpf_perf_event_value___local reading;
 		int err;
 
@@ -99,14 +99,14 @@ fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
 SEC("fexit/XXX")
 int BPF_PROG(fexit_XXX)
 {
-	struct bpf_perf_event_value___local readings[MAX_NUM_MATRICS];
+	struct bpf_perf_event_value___local readings[MAX_NUM_METRICS];
 	u32 cpu = bpf_get_smp_processor_id();
 	u32 i, zero = 0;
 	int err;
 	u64 *count;
 
 	/* read all events before updating the maps, to reduce error */
-	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
+	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
 		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
 						(void *)(readings + i),
 						sizeof(*readings));
@@ -116,7 +116,7 @@ int BPF_PROG(fexit_XXX)
 	count = bpf_map_lookup_elem(&counts, &zero);
 	if (count) {
 		*count += 1;
-		for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++)
+		for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++)
 			fexit_update_maps(i, &readings[i]);
 	}
 	return 0;
-- 
2.39.3 (Apple Git-146)


