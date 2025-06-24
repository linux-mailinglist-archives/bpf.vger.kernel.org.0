Return-Path: <bpf+bounces-61344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA5BAE5A67
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF203480788
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0621771B;
	Tue, 24 Jun 2025 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3TRE4BL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD42192D87
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734786; cv=none; b=r1SdgsdoxvmLU2PKF7NZRxg+CEx5X+O26gwSCCxYptMN4dVogTBbgqO3CHrMxyscHlakqMZT/y5rmtcZfqibO8l2eybCXyZpdkDZfEbmuX+8oYy+/mKHJxc7+S24lCwjirwCfaaihUQEvEDLspJnM5p9Hv67PPeFUfdoIyt+ovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734786; c=relaxed/simple;
	bh=Bvf6Q4QDEpC9orJnQ4Jl1+9GYtKp4aH52fTTGQF8HAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTWjWWpjZT836b7QoVuSuoVLwE0fwpzQcdII+VzH99L8FDodTUnQVkzjYXbMQUu09Ltkj5PBfNAuoiq4PXoFgu2A1/Yt2m1rFqOOt0tyZmeXjV4fsCG67D6VzP5ZKYqYkmnIhl4M1Q/45Di8HI5+nl4eoT9r5B6qrVwDRzp/yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3TRE4BL; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so9198904a12.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734783; x=1751339583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+2Pgwb7uphBhkOjc9C72jwPVaGhDpNaO2bpb9E0PMU=;
        b=e3TRE4BL7zwSm1CJSvWxJ9RnXzln9ctEMYjCoK/G83VWGOpQ9MSz62mf4zhx7R0JLX
         UA0c0ABU1nqec4HOq2WGsSUvI2tRoufrj4c63+4ss5bV+XzjMa6VgDorI2m7coW0nLlO
         jsdDP60Myc6lvE+Vpx1aTmAW59wQM5THQK3K23nCisVyyTemA5RcXisNc+7vNwy09xfo
         gQyPRPTl6yvuJDtdiVPxZUyFW+QjZOFeUMdBZ4upeOdU7d2kQfd6VnHSQZmuH3uX4KgN
         Gx87mbQe7+79Swibb/qfoGkcrczIHmtUtkEV/IRt9Yycvx5qoe5RVO0qAgSiYagQRCFc
         qkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734783; x=1751339583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+2Pgwb7uphBhkOjc9C72jwPVaGhDpNaO2bpb9E0PMU=;
        b=FvoPEug7KBm9qMbvlXnbd6opGiax2nW7m5iEw+UXlmkcHSBQZdK9Z+pq+VmQnBgiHm
         ap72owEIWWruaY6t8J45d/1/vnkptXCDfCvZ1BiIJHIYwsYlXVzd9go3CEggzh1a4SaU
         FeMWmB8gsaluEY/9G/bXGiQwTfEpXX6s6meKVe5CaOkpBz7wPEwdCZywiZ+RSQNExdpU
         ZpjAaLQIAEVMvxF9FMb0TBYakb9Vpt8c29U3UZ6qhslkbvUcCooCnciCVue/L0G9tUpL
         UeJwF4/ssYjmV+B3/be+SbJJjhAoByBiIwqsBywUbazr8pl9X0RJCpugGH7HEVhPSsRg
         msYg==
X-Gm-Message-State: AOJu0YyPlu+LgdXgYt/SAZpkh5Uj/6uIo+DE6oTKQ+BHq57lBd8wBiSO
	ezUaoryT807ueGwckZnpvlUiWpeQdQUd9qzBpXkZzbRP4BCd9FCZVxCBmyv+242w9davZQ==
X-Gm-Gg: ASbGncvRpYIF406qFc7wsu43Npci/yla/xrelsq9A5YCiBJM1ZujeJbQU+aOwl8M4/r
	0fIfwZsFCEEInXJvrLUj/LNUWGLXEc1ypCKBGJvFHbYstRBmhJsMHHDLjSxDgnx8Ba0KZEAeMRz
	bswq2jmpCN54hNT3S229qG1FuJI23ZNx2yU7yDIpb5NNp8o1nQWFiXCr4FrkrqQ+Waunxj39zmX
	ZVGWoKOLyGIMTzkE2UFMM5SKNwtlZQs6VtUNxCTHtw0Naptg+r9gYm9lkB+c/0ymQ0zRqt7Lrmo
	BBkRi5NwvJJ49ov321YbIqdhGEaVDSdNzB61YWVCwl4Iq/JmUP/NJ1HYILdYEA==
X-Google-Smtp-Source: AGHT+IHBrBsiZ56npXLVA9V2y/txqCNhp5TRVjwcm4BWatJhQjqF9MMVrz9B5ohegMQ11RMxpreBYA==
X-Received: by 2002:a05:6402:3548:b0:5e6:e842:f9d2 with SMTP id 4fb4d7f45d1cf-60a1cf321ccmr11511464a12.29.1750734782961;
        Mon, 23 Jun 2025 20:13:02 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4a6174sm358364a12.72.2025.06.23.20.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:13:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 07/12] bpf: Report may_goto timeout to BPF stderr
Date: Mon, 23 Jun 2025 20:12:47 -0700
Message-ID: <20250624031252.2966759-8-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; h=from:subject; bh=Bvf6Q4QDEpC9orJnQ4Jl1+9GYtKp4aH52fTTGQF8HAE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWeAc3j0dTee7aNjzsJKCm+oZmT9lETY39CTRYc FocFwQmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVngAKCRBM4MiGSL8RysRQD/ 4jdxo+oX680JOMszXTcsEZnAc3aUS3dEE1B343MJ6hiMkb+AqqTvHGNP+z3cC6B9YLSUqDxfJawBCA mkgyYB4QDe5LY5bNaU5opAXdZyDYUpCKmRChe7j4xD9Trku3fxY9jZtMHxePD9TYJ2g9X8EdbeCRt+ a4FnHjD57iJZ85Zb/ucvMkvftsKpTo8POCCUU/+hKRUSqEm2uNoO/8Elb/ueZNv0LJCEU9NQ9nST52 ZdR+lCVGzVnvAPMfDQdi51Wjy8tBBEsJTJmtohM5t3rWNqEVUkE8Oxbddp2sR0aPXy6/CHAx5ogZlt lanfdhJ2FqyScCJwX8AEz2RV9ajZHTq+7lCIeYazTqH8H/IHRH2WQ9dQ2MUll0aEXvdfHPm45epdeK wcn8Ie38lohCHV+jS/5LuYd672axoPEREw2sR5hImwAn9g0n1KH3s7ZWALoj/X/hfwJYp8Le7oJe/O PxZ66D7Rxm2KO7EJR3nNIprykNLQway619zqiT7Pv1GYufNV5mv3mSs4lLKBBk+n8wIraeQdE3C1Zi Z61wo40DHN2OEw5C5YKO2XCzcEbujZh9LoxduWit1aN+jiyI8MhgHhm+rf0yNJ4WuwZyf/rdxLbZGU 8NJYjEdOn07Ry8uKXEZayvel+0HWDfH/7+q+mYfVlK/Gvm+e3ED4TMkaJj6A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting may_goto timeouts to BPF program's stderr stream.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3871d817396d..7ff2d37625f5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3168,6 +3168,22 @@ u64 __weak arch_bpf_timed_may_goto(void)
 	return 0;
 }
 
+static noinline void bpf_prog_report_may_goto_violation(void)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: Timeout detected for may_goto instruction\n");
+		bpf_stream_dump_stack(ss);
+	}));
+#endif
+}
+
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
 	u64 time = ktime_get_mono_fast_ns();
@@ -3178,8 +3194,10 @@ u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 		return BPF_MAX_TIMED_LOOPS;
 	}
 	/* Check if we've exhausted our time slice, and zero count. */
-	if (time - p->timestamp >= (NSEC_PER_SEC / 4))
+	if (unlikely(time - p->timestamp >= (NSEC_PER_SEC / 4))) {
+		bpf_prog_report_may_goto_violation();
 		return 0;
+	}
 	/* Refresh the count for the stack frame. */
 	return BPF_MAX_TIMED_LOOPS;
 }
-- 
2.47.1


