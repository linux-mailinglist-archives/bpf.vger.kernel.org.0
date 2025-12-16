Return-Path: <bpf+bounces-76737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462ACC4BA5
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F49C3095AA5
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632A832E12A;
	Tue, 16 Dec 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="0IsklAHG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BD314A6F
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906516; cv=none; b=AvW5foH3KVbQ46lLBzkSqOH/SQd2414ccOJPUuGvQrgTmt6cE0lHaDQwXEO0l/WgpzP2X2ZPubit7v1RsNR2L/+t1A9XjDDTSgM+R0Oh8TyaN2A9EGTCo16a3i18YBD3fjj52ABmHkeIMtsEPrQrUBHIEJ2TG2vOellbpy2tdeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906516; c=relaxed/simple;
	bh=Ugv9sDTbemMnE5jeJJJg5Bww39GvvzXYP2ON5b3IuEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/xUnFkTRvPOmMrvQJQFAmTExFugmSF0oZEghkIMYEZ9L0zBKMSVndemHHRQx58FwSlFj6FJnThWeKUVC2ihj4Ykr+PieRrwm2+5dDSxi18Bf+F4Guf4Hskaymq3j55tS1OxQ2/R14Ev1xkX4m5QNfPIov6chz1dhROGAS6eHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=0IsklAHG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a2f2e5445so32546626d6.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765906506; x=1766511306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDPGp+47IyW9svZxtzF/6TKIDFcHQHo1HRsBBALTpwg=;
        b=0IsklAHGRDlZdDptUu2EmZD8BOZN6GWZQxGnG06L+1OWuFqzKaUbNmKVjRMNFbVZX9
         L9lvIMnVnui25pcoem3VXWYtlrX4M4d2iju3wg/fJJ2oFHEddkInMXVXNN3NlZ2gbEUJ
         pROrre6ec6ZhlFe/wZ3TQzQjY2IPEjPfPiQ19pDqaD9Wom598ZhyFvMFsWlUCImjYrcY
         NjuHfLASHgEH60CAnduDJk+ncvMfvfk6eFdTNRSpUzu1b4oKWgBjrooiJCpAAomYXW6B
         qACs+fNGr/KIX1QxhP/wDUoLAzPmokLA4GIpUg3k+f+gebWbbX5sWx5hKZOx7hbQfUKK
         6GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906506; x=1766511306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDPGp+47IyW9svZxtzF/6TKIDFcHQHo1HRsBBALTpwg=;
        b=VcaAsNsb2CdnscgmiWX1ZnQHF+UlufQEKU6FFKJKQRsjJX3qD7sJwQ9/T/uGzZrvOP
         xlAIperlWkP86aN98jEbfRSvYCYyx5cGw787PiJCkY59uBKjP3XahOliOo6Eh9gI8Uck
         77f+jOg9EwWVhp988ki6r0MuyJkf/y9Ip8VyBnEGOhFqGTf+a0C2Z8jvv95gcQG+QebV
         Jn1K58QbPHWrtq2ei/zU6PVfwwU6adOmkAWyRJaCdaoYG+LfelYOHpPwXZHudc1J8cOQ
         XYdd/e81Ydu3yn22EpabgMNp1FGwq2bjfSi9P/r57t9QTpeuuXJf1uoY2LNi4EFRI+50
         sCaQ==
X-Gm-Message-State: AOJu0Ywqp7vLvQrhN3iolDe+XuRtah30SO9TWmEZ4bkMveM83wuL1BmW
	cQj4cJx3it6IQ6Cq22gfHtjFiN/pd4umgsDlGEfLf3yViVrliL4t1IFjq3XuPH2EICY23YbgqlL
	ylXT6XV0=
X-Gm-Gg: AY/fxX6TkkbkNOdx2tdt4hkrW/4O0qVr70VKGvYmX27BBHZ1AJfrl1V0SPYa5yruxNW
	Ki8PvVFuuR6UdqkRpjAx1uILlHmJPs1EOeG0Wn7jEejD3gZVHImqcVC8VDnndx5iaTgoXvnsXn3
	VgcmB1YWY535joAiOLswcTpEP9G6DOa1HaCxcuFqxXpoNQETuJyV22JRIk2fKqGuZn3EIJUWYxb
	FjaLCQ996mFiBjh/1QMiZDYQ6PxEhuBQHj5wd87QtK+2FuUYcxxG9IKd6Od6gFVwHcJ3V8JXsPd
	sUJE7JPQD8m/VGU3Irt9au7ihK7iqcbEGhJYODHryazoAGBkiHX7wh2WnsKdolv12JzvlWOXmqA
	v8EckGb+41xSmYbgDxukTHiEFOcKvN6w09UaTr/lU5og8JmmrFZXimh49kCHWQ4dvCPg1L8JHXA
	vOPYSisV8W2w==
X-Google-Smtp-Source: AGHT+IEw7VsTF3yd1zf6sZc06X+vPmi7/ppU6CigPsqh69aEwvXm93bocECn4bpDAZe4Qbi4x/Yzeg==
X-Received: by 2002:a05:6214:3203:b0:880:572e:4565 with SMTP id 6a1803df08f44-8887e16da9dmr234925206d6.60.1765906505434;
        Tue, 16 Dec 2025 09:35:05 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a860f8basm79310456d6.56.2025.12.16.09.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:35:05 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v4 3/5] libbpf: turn relo_core->sym_off unsigned
Date: Tue, 16 Dec 2025 12:33:23 -0500
Message-ID: <20251216173325.98465-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251216173325.98465-1-emil@etsalapatis.com>
References: <20251216173325.98465-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The symbols' relocation offsets in BPF are stored in an int field,
but cannot actually be negative. When in the next patch libbpf relocates
globals to the end of the arena, it is also possible to have valid
offsets > 2GiB that are used to calculate the final relo offsets.
Avoid accidentally interpreting large offsets as negative by turning
the sym_off field unsigned.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c7c79014d46c..4d4badb64824 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -380,7 +380,7 @@ struct reloc_desc {
 		const struct bpf_core_relo *core_relo; /* used when type == RELO_CORE */
 		struct {
 			int map_idx;
-			int sym_off;
+			unsigned int sym_off;
 			/*
 			 * The following two fields can be unionized, as the
 			 * ext_idx field is used for extern symbols, and the
@@ -763,7 +763,7 @@ struct bpf_object {
 
 	struct {
 		struct bpf_program *prog;
-		int sym_off;
+		unsigned int sym_off;
 		int fd;
 	} *jumptable_maps;
 	size_t jumptable_map_cnt;
@@ -6192,7 +6192,7 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
 	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
 }
 
-static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off)
+static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, unsigned int sym_off)
 {
 	size_t i;
 
@@ -6210,7 +6210,7 @@ static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym
 	return -ENOENT;
 }
 
-static int add_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off, int map_fd)
+static int add_jt_map(struct bpf_object *obj, struct bpf_program *prog, unsigned int sym_off, int map_fd)
 {
 	size_t cnt = obj->jumptable_map_cnt;
 	size_t size = sizeof(obj->jumptable_maps[0]);
@@ -6244,7 +6244,7 @@ static int find_subprog_idx(struct bpf_program *prog, int insn_idx)
 static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
 {
 	const __u32 jt_entry_size = 8;
-	int sym_off = relo->sym_off;
+	unsigned int sym_off = relo->sym_off;
 	int jt_size = relo->sym_size;
 	__u32 max_entries = jt_size / jt_entry_size;
 	__u32 value_size = sizeof(struct bpf_insn_array_value);
@@ -6260,7 +6260,7 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
 		return map_fd;
 
 	if (sym_off % jt_entry_size) {
-		pr_warn("map '.jumptables': jumptable start %d should be multiple of %u\n",
+		pr_warn("map '.jumptables': jumptable start %u should be multiple of %u\n",
 			sym_off, jt_entry_size);
 		return -EINVAL;
 	}
@@ -6316,7 +6316,7 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
 		 * should contain values that fit in u32.
 		 */
 		if (insn_off > UINT32_MAX) {
-			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset %d\n",
+			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset %u\n",
 				(long long)jt[i], sym_off + i * jt_entry_size);
 			err = -EINVAL;
 			goto err_close;
-- 
2.49.0


