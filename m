Return-Path: <bpf+bounces-19187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF7826FCC
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 14:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D353828108D
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791D4595A;
	Mon,  8 Jan 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un8bV9K6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DB45946
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccabf5a4beso17967611fa.2
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 05:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704720517; x=1705325317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgGScrJzuXyxQIjYSGhKX/9ivogWO1hoRNp5I/CGjrk=;
        b=Un8bV9K65oS7SShcF/xmdda/fH6PJpE9dCRZfS36iiIA7/a/NEYwDJ6IjVihcBSaH3
         vdUOVtWLll+OPgfCqiqG4F2CfHwtzC6zvETktLPkR6mCxMwHnIOm/vXErwx6+m6bhgAY
         qmtlIXS1jgSF4HQgG+Paf868DViDwqgYOOpyIERz+I6/uPwb1E4XLZwvmGKwVWFaR7V+
         Fj8+i+z320U/c1Al0BujBL6bD1LcISKrP7muDt4ODzARuIgSeNaZnb2kxRPg9pf/Ee6g
         tHrdUSbKxKuw/r8/dc9DHGQBJEXvQr3LRDfg788gS6K1oNHHq7IQiYuj0HYeNMkub4Af
         IwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704720517; x=1705325317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgGScrJzuXyxQIjYSGhKX/9ivogWO1hoRNp5I/CGjrk=;
        b=KmxAt6Hg6JpDTdDV/9Gh3b6c4cj3T+9ZRwaH79IEN144Za/zdwbvgFgRTLAv/rRNNM
         uJpJ061LMwbr355METn//GmYHADWEcQrtEgA8wSL27oBCE0D0cm4pdkqjqNrrDrQrWlv
         HolUG/D5dHj+1u2Krbhp+PsPlXUo5C7fdAQlMPpjHdiQV3p8Ch1ioQw3auLeJQVtQ0fK
         ePaZrLVmqSxFdd07tok5B1qd/DMO7tIstMNuZmyR+qRI/NlzF2OmJDFbKaN/O5JFFzbO
         VmS7lNeagOoRcgucz572r+8qcjQ5BWNQqkJqxDLPGiBaxYLYbO2yDugbWoG3xxJfZJMU
         QfEw==
X-Gm-Message-State: AOJu0YzUTGNZS72PRApxClmP2srxoydipe/EumTLSN8L+WANcLqEqY52
	+/dpRaAKaQ42iHAbtHt7mwseLyDgDJM=
X-Google-Smtp-Source: AGHT+IHQm1GCsVVQPcj7x/Jec+7T8Ww98U4CWa79PjfCrL1NacXEDW9yBrNue9vRpqw6sy44pEnXPg==
X-Received: by 2002:a2e:6e16:0:b0:2cd:2376:140c with SMTP id j22-20020a2e6e16000000b002cd2376140cmr651922ljc.57.1704720517318;
        Mon, 08 Jan 2024 05:28:37 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z3-20020a2ebe03000000b002cd3e2fc054sm1171458ljq.57.2024.01.08.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:28:36 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	zenczykowski@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: test packet range inference for 'if pkt ==/!= pkt_end'
Date: Mon,  8 Jan 2024 15:28:02 +0200
Message-ID: <20240108132802.6103-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108132802.6103-1-eddyz87@gmail.com>
References: <20240108132802.6103-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that the following cases are handled by verifier:
- packet access after 'if pkt_data + const != pkt_end'
  (positive and negative cases);
- packet access after 'if pkt_data + const == pkt_end'
  (positive and negative cases);
- packet metadata access after 'if pkt_meta + const != pkt_data';
- packet metadata access after 'if pkt_data != pkt_meta + const';

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_direct_packet_access.c | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index be95570ab382..0ee99d7bc846 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -800,4 +800,142 @@ l0_%=:	/* exit(0) */					\
 	: __clobber_all);
 }
 
+SEC("tc")
+__success __log_level(2)
+__msg("if r3 != r2 goto pc+1         ; R2_w=pkt_end() R3_w=pkt(off=8,r=0xffffffffffffffff)")
+__naked void data_plus_const_neq_pkt_end(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	r1 = *(u32*)(r9 + %[__sk_buff_data]);		\
+	r2 = *(u32*)(r9 + %[__sk_buff_data_end]);	\
+	r3 = r1;					\
+	r3 += 8;					\
+	if r3 != r2 goto 1f;				\
+	r1 = *(u64 *)(r1 + 0);				\
+1:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __log_level(2)
+__msg("8: R1=pkt(r=0) R2=pkt_end() R3=pkt(off=8,r=0)")
+__msg("invalid access to packet, off=0 size=8, R1(id=0,off=0,r=0)")
+__naked void data_plus_const_neq_pkt_end_negative(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	r1 = *(u32*)(r9 + %[__sk_buff_data]);		\
+	r2 = *(u32*)(r9 + %[__sk_buff_data_end]);	\
+	r3 = r1;					\
+	r3 += 8;					\
+	if r3 != r2 goto 1f;				\
+	r0 = 0;						\
+	exit;						\
+1:							\
+	r1 = *(u64 *)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__msg("8: R1=pkt(r=9) R2=pkt_end() R3=pkt(off=8,r=0xffffffffffffffff)")
+__naked void data_plus_const_eq_pkt_end(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	r1 = *(u32*)(r9 + %[__sk_buff_data]);		\
+	r2 = *(u32*)(r9 + %[__sk_buff_data_end]);	\
+	r3 = r1;					\
+	r3 += 8;					\
+	if r3 == r2 goto 1f;				\
+	r0 = 0;						\
+	exit;						\
+1:							\
+	r1 = *(u64 *)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __log_level(2)
+__msg("if r3 == r2 goto pc+3         ; R2_w=pkt_end() R3_w=pkt(off=8,r=0)")
+__msg("invalid access to packet, off=0 size=8, R1(id=0,off=0,r=0)")
+__naked void data_plus_const_eq_pkt_end_negative(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	r1 = *(u32*)(r9 + %[__sk_buff_data]);		\
+	r2 = *(u32*)(r9 + %[__sk_buff_data_end]);	\
+	r3 = r1;					\
+	r3 += 8;					\
+	if r3 == r2 goto 1f;				\
+	r1 = *(u64 *)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+1:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success
+__naked void pkt_meta_plus_const_neq_pkt_data(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	r1 = *(u32*)(r9 + %[__sk_buff_data_meta]);	\
+	r2 = *(u32*)(r9 + %[__sk_buff_data]);		\
+	r3 = r1;					\
+	r3 += 8;					\
+	if r3 != r2 goto 1f;				\
+	r1 = *(u64 *)(r1 + 0);				\
+1:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_meta, offsetof(struct __sk_buff, data_meta))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success
+__naked void pkt_data_neq_pkt_meta_plus_const(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	r1 = *(u32*)(r9 + %[__sk_buff_data_meta]);	\
+	r2 = *(u32*)(r9 + %[__sk_buff_data]);		\
+	r3 = r1;					\
+	r3 += 8;					\
+	if r2 != r3 goto 1f;				\
+	r1 = *(u64 *)(r1 + 0);				\
+1:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_meta, offsetof(struct __sk_buff, data_meta))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


