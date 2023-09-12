Return-Path: <bpf+bounces-9761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A879D446
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0241C20B19
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4564C18B1B;
	Tue, 12 Sep 2023 15:04:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BEA952
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 15:04:57 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA512E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 08:04:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c09673b006so39197685ad.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694531096; x=1695135896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI9GtAR4RRRZfUjyqGfr+hbPaguofKvf0zmClaMrL3M=;
        b=IsxLNC8WsqWTVQGSaiLt8uv3BlLKH+wZPxCoTp89FkWVM+Y4THsyQCv6ChQdzWmF8j
         c+dsEc03XFaN08ERqgAaMV8nXW5DPBIXSbEk3wkZ5G/CDWBTAWI91sPCPu26e3WJbzTv
         WWBZ9mZMIS5eSKPjHUh5/7SH7XDDRNCE511s1cRTpaZw0gq9z4T5mJc0eyMFrKHZ31AI
         ap3ciyco9ClPhMdYiTFEm3XYgfBTDiv0glGfZs7mefQ6F+uMLCfDAen3wZnsKJycZloL
         DZ95VLGpMoIsksN7ABPTPp8y4slvvR8mg1lKOuqfxCn7qUDUcZPRBPjCuU66Pfu0N3ZX
         V/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531096; x=1695135896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI9GtAR4RRRZfUjyqGfr+hbPaguofKvf0zmClaMrL3M=;
        b=NCZliZibcCgQQwyMYtLBAJ5VXx4R0rGML1QlQYkF4eNwoslvBpB4Uiyjs2M6F8GMJJ
         F9BDvj1Ik6+GwLWm4jt1jq+ToVmPbVbpBvkiVoQiH8TfCo1kKp5seWx12v13FUjVyL+s
         Xh3AEGUpSKLwxTQD0c5xUBeMOaaAx3Bgm1UXbOWjom7IfOautAz7EbMqgG4szxyH3z+o
         HA5EdtPy6nvF2KVWsUnwREDt9N8NK5gMHHX2QHFBraYIkNxpmNL8GY7YdT04uPunMOgH
         /UhtCNuix0kdCfY0v0A5StEFKpi7w4JH/3AuDQBPKVhuUaJTgweoqXGUbb7l6FqfQ8uA
         xG9Q==
X-Gm-Message-State: AOJu0YzcKDsYC5QB1JdH5sshshvtJpjr4w1PUSTUJXkrVgssGZNXyO22
	nig6BV60EC5yvKeZKXI70wSIqhIWJ1Q=
X-Google-Smtp-Source: AGHT+IG18uNEJtEKTXKhpp2Oe5Lg1wZCTB3MvtVmUdufRQJu/98weLQuHPeKuQvnJKxBJeTSsT0zaQ==
X-Received: by 2002:a17:902:a3ca:b0:1bf:63c0:ae79 with SMTP id q10-20020a170902a3ca00b001bf63c0ae79mr11615plb.33.1694531096165;
        Tue, 12 Sep 2023 08:04:56 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001b8b26fa6c1sm8526941pli.115.2023.09.12.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:04:55 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	song@kernel.org,
	iii@linux.ibm.com,
	xukuohai@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/3] bpf, x64: Comment tail_call_cnt initialisation
Date: Tue, 12 Sep 2023 23:04:40 +0800
Message-ID: <20230912150442.2009-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912150442.2009-1-hffilwlqm@gmail.com>
References: <20230912150442.2009-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without understanding emit_prologue(), it is really hard to figure out
where does tail_call_cnt come from, even though searching tail_call_cnt
in the whole kernel repo.

By adding these comments, it is a little bit easier to understand
tail_call_cnt initialisation.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a5930042139d3..bcca1c9b9a027 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	prog += X86_PATCH_SIZE;
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
+			/* When it's the entry of the whole tailcall context,
+			 * zeroing rax means initialising tail_call_cnt.
+			 */
 			EMIT2(0x31, 0xC0); /* xor eax, eax */
 		else
+			/* Keep the same instruction layout. */
 			EMIT2(0x66, 0x90); /* nop2 */
 	}
 	EMIT1(0x55);             /* push rbp */
-- 
2.41.0


