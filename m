Return-Path: <bpf+bounces-40028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851797AD1A
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505B91C234E9
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494A15B98F;
	Tue, 17 Sep 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyx8liOH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EAE1531DB;
	Tue, 17 Sep 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563095; cv=none; b=dAMj2fJre8ywqJqpQkO/xV9R06vwudsftc6HtBFaCeLnDsWN/b8kK2RzN0P1Hn+NfCWG+T4/9poNdcknk6T4fMFmVV/bqGqW8XbkpqJIUac9w7Ecc+0HHm3lyqSXPyFZcsjrzXhZkljAKPGFVzqyBtouD5mW2dHxJ3bdgcSx3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563095; c=relaxed/simple;
	bh=CPerKjyUxXsQem1//02PfSk7GL1ToGqym/zky5T6kMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrM2CGHNsBU/Pi+Io3+AHxhsiZjL2AjJ0onf1kQETM1nDaoYm4fLwyHu71GX/Gb2R4yWSVZ0egBlivQIyv4FU6EL2VbzPIJ6ttx6PMcWit71GSSZeI/sgB/hWynAvVb7Yljxth0QMeT6VagLWQxupa+TTw/QgZCtB1hZHTW6LSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyx8liOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C0AC4CEC5;
	Tue, 17 Sep 2024 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563094;
	bh=CPerKjyUxXsQem1//02PfSk7GL1ToGqym/zky5T6kMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vyx8liOHTixui+kIOZ8huwdmz0eYibNSQyKvdXsc7214UiUn7NyoC2oHdrFJUdnke
	 z2nA49abu/A1XbvJEb+wO0ZWN+qk6NBnWa9hwIAPMNluSagAnwwISQI3VkaeosKCC0
	 N5JCKruLs/+vHo6Ap3zNgtMwHAQXZjbDK6lc5g/s61/BvQ3cRONRTItjQQ32amQjck
	 bV7oJjFm4J7kGgWPfvyEUH9DhIotd3TybBnIWCMmHVEJNu6tKtwpzaaJ+DnrrOYdqk
	 8dk/53IiCtYqwJuVJjsjU0HNfdXwZtUBhb5groC2RubcXKDkU56FSgONPQ4nWY/ulL
	 IDVC27xL5ZwiQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 05/14] bpf: Allow return values 0 and 1 for uprobe/kprobe session
Date: Tue, 17 Sep 2024 10:50:15 +0200
Message-ID: <20240917085024.765883-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uprobe and kprobe session program can return only 0 or 1,
instruct verifier to check for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8520095ca03..988858fc37e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15668,6 +15668,16 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			return -ENOTSUPP;
 		}
 		break;
+	case BPF_PROG_TYPE_KPROBE:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_KPROBE_SESSION:
+		case BPF_TRACE_UPROBE_SESSION:
+			range = retval_range(0, 1);
+			break;
+		default:
+			return 0;
+		}
+		break;
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		range = retval_range(SK_DROP, SK_PASS);
 		break;
-- 
2.46.0


