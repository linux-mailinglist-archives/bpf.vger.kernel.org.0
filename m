Return-Path: <bpf+bounces-74834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD1C66C2B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A90DB364B36
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC952F0681;
	Tue, 18 Nov 2025 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="LzpbjX5A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0FF2FD1BC
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427203; cv=none; b=Xc7CyWAivPAjppPf1K6suFlfVGoXThd0g14W1nDfno9PI0xFZ/fl6Aly6wvDplRJXnFatG/RhH+w5t7fqxrRgLvuMZ9qLnZsT6aBmaqJZ+oFDwm4xAgOOcRbipoB85IiEGyCLcTEnC1MACRdhNZkdmNMpuxtL7mF8e0LlWIfIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427203; c=relaxed/simple;
	bh=mxX/gPyXLSW9fvdVbcxRxIhK5u9925lyqazn8p1TInM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6poHIDAFPZXGafXlMPu6+Ld2GGBHEFicy2Xc5pBx8SW80Eo1hl+oJNZGs8YcuqiKfvN4yrk60sVdlzGIho2vW38an9uRQOCshWzmI+zjV9cHKTB7JFNVKv6Unu5UByW+ZhslG0VGHBDVU1BRy3CJQDwQPV2r0TTIiKHfIoY0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=LzpbjX5A; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e2736308so4457905ad.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427199; x=1764031999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJWvEh/HJ2KX3LdjCjzprEHwj4So4ol1ev17Vb/Ad9I=;
        b=LzpbjX5AFX7c/jme4uRTA9wmguzVLGKBOKU4h7Rq6qx8LqIYMi2wAdT7edAO4Zhl5r
         Zvmk0NCEy91LIEu8xEKUgHt89r3bDYbhtJYTHlJUV0yvnO8PUtBXUlAuKYmGAxbFGtF8
         2d4t6By8+t7C0dNzztjzqcGEw78jv+wI2ndJxRJ2+gRpJU0MdRi/mZQqt7sLK51ohGAH
         55BPTumm7yoYec1oOiIaHbGsPV893TKM3YS0fF9facGr4hte8lUSquZ6jcfM6M8uwFuF
         hzSUO9iiYjGhW1W28MdESoVq7st3oxRedBKVUqpoWXL0pJC1ecV+oG5BaMH6TXFsyDrP
         aCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427199; x=1764031999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJWvEh/HJ2KX3LdjCjzprEHwj4So4ol1ev17Vb/Ad9I=;
        b=bkYd33u5E9cqZTQnv6Yewg8ukeufTJTnnN0XDSCSl3pPQeh4qixuOkeYiwIppi/CwH
         H5IU6BTXITyMWRSi8+mKCZV/+fhepvA8+NHtnVjfS9dI48d4TrxQTnAk3vZs6X8js/hU
         SqnCsb1kJU7Tyb/llKHLTOW9KiInzOUGKW6JlN6s25Xjw78cTMzSjDfSzmiRXq0ugB+k
         OsdQ96dm4xIucGsFH+CL8IcZr1cjvaYC5c+Pm6bOn8jRxfWn0mAUXHwBUKFp6WQOuq/F
         gGFWrTPk9YbwV1ltRzk0h8DJ4Umf7gmC6nx0ApAr8Uxr0zDKtgj8EIszZHCoMPEFuj+9
         VeQg==
X-Gm-Message-State: AOJu0Yx/h/Hru7wpAAOPnHdxyB5nf7Tw6BqdrXGIMwdDtD2mF+JyTZY7
	y376U95bTB60PCZgAK9r3KaxigypgXprkM89G5KdaVwgjAhMyzKICzThEXfEaFY6z/+4xuSQc4U
	Qw0Bq
X-Gm-Gg: ASbGnctcC6VERWm693Vj6VsPAembZlHTPjJ8bwJs11IUAPy/vlvyVFvEkTpgy0zPkpI
	5SZdFBGc1j5fz1rYwZPwPixENmjvPeAAhT8M+Lu/Dj+lKthDbg/SvTXSFlcRFiq2IqlmQDN6vXQ
	jOH2CXtcFa3GdTI5Yl8n/VbuOBEQJY6i8M4yR9ACg+HTqHZcZyXYMkgD0Xt6neMb50rmdjIzHi8
	1wyi4ddAWXdbHPCi2F64sKF9IPo5JhxRkxFtUYDpxobS+9Mi41SVTtpimOFA44vE2j8oQ3Mb0s+
	+vjm2F98Vl0LePvuogf1PmDPVYqE3AeupINjVc0a1v3q+0AeTO1SJxDg3Ay6ILaKCTOEYtViKof
	0ZmFWkx4Gajv+bU62W8Q5LAb4/JbXBxHCY6SHVGtzwvn6kIO8j0/RJw5XFnDwDnj2bGFQYtmFjm
	4=
X-Google-Smtp-Source: AGHT+IG3sPrz8MEZiYwPiZ6/EpY059urBkdovE1wf/NV5guCPZ6qna+8U9eWUGcGq+wUPWME4rwtsA==
X-Received: by 2002:a05:7300:fb05:b0:2a4:3593:5fc8 with SMTP id 5a478bee46e88-2a4abb56fe7mr4474732eec.2.1763427198597;
        Mon, 17 Nov 2025 16:53:18 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:18 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 6/7] bpf, arm64: Make program update work for trampoline ops
Date: Mon, 17 Nov 2025 16:52:58 -0800
Message-ID: <20251118005305.27058-7-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
References: <20251118005305.27058-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use update_prog in place of current link prog when link matches
update_link.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 arch/arm64/net/bpf_jit_comp.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0c9a50a1e73e..1725d4cebdf2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2284,24 +2284,23 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
-static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
+static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_prog *p, u64 cookie,
 			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
 	__le32 *branch;
 	u64 enter_prog;
 	u64 exit_prog;
-	struct bpf_prog *p = l->link.prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
 	enter_prog = (u64)bpf_trampoline_enter(p);
 	exit_prog = (u64)bpf_trampoline_exit(p);
 
-	if (l->cookie == 0) {
+	if (cookie == 0) {
 		/* if cookie is zero, one instruction is enough to store it */
 		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
 	} else {
-		emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
+		emit_a64_mov_i64(A64_R(10), cookie, ctx);
 		emit(A64_STR64I(A64_R(10), A64_SP, run_ctx_off + cookie_off),
 		     ctx);
 	}
@@ -2362,7 +2361,8 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	 */
 	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
 	for (i = 0; i < tl->nr_links; i++) {
-		invoke_bpf_prog(ctx, tl->links[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, bpf_tramp_links_prog(tl, i),
+				tl->links[i]->cookie, bargs_off, retval_off,
 				run_ctx_off, true);
 		/* if (*(u64 *)(sp + retval_off) !=  0)
 		 *	goto do_fexit;
@@ -2656,8 +2656,9 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fentry->nr_links; i++)
-		invoke_bpf_prog(ctx, fentry->links[i], bargs_off,
-				retval_off, run_ctx_off,
+		invoke_bpf_prog(ctx, bpf_tramp_links_prog(fentry, i),
+				fentry->links[i]->cookie, bargs_off, retval_off,
+				run_ctx_off,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 
 	if (fmod_ret->nr_links) {
@@ -2691,7 +2692,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fexit->nr_links; i++)
-		invoke_bpf_prog(ctx, fexit->links[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, bpf_tramp_links_prog(fexit, i),
+				fexit->links[i]->cookie, bargs_off, retval_off,
 				run_ctx_off, false);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -2829,6 +2831,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	return ret;
 }
 
+bool bpf_trampoline_supports_update_prog(void)
+{
+	return true;
+}
+
 static bool is_long_jump(void *ip, void *target)
 {
 	long offset;
-- 
2.43.0


