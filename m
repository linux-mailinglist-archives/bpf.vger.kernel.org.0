Return-Path: <bpf+bounces-45863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD79DC0F3
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 10:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BDB1642B9
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846FD17278D;
	Fri, 29 Nov 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCHhrI4j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58195143C40
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870852; cv=none; b=N6jN7KIarGiqWG5EVjfpPKzATpfItGgc47mcweZ41Fpj0r+p3+Q78F8UQX2N3R3m23lnavlE+MojSbG3L/wTQxjYGm6ivEmNJg/Yz89UNHu6FcDSEC3JQm5N7ljsds/dFXe7EIeC50k7U1Kb31axt5PLnkUQG2yW7MnWMHoXcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870852; c=relaxed/simple;
	bh=xEslxxsKiLFjjUwGtii3ivKf92ut0unGtMTc00chBhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AiQ0Fsv9AxJZB9SCFN1wLL1NtVPGAo3ZafMrtlP1Mz30qgnNUe13XWa9LqPUkCGn3Ay104FboA4nknb933cQW3X/05DrFiutgeD5ddlRS6ejpV3qltKTYRKFXHoiKe2UouIetOd4BHEYOXeJyCpwveL9SCxA1iQDiCfBOOU+sYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCHhrI4j; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa52d371666so191737766b.3
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732870849; x=1733475649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AM59VOGYG3wMVgUo99G/iJLAIksKG+8729FKlv13tNI=;
        b=VCHhrI4jQUAULt0SFnU/cQeuVGY/zn4FwyQ9RUX/F7+XerRIszkBul6k7NDETe1ojE
         if9Ya0A3Ezt6QDuRLf2iZ25VomwVKZJ7tKkIAfsBZss86ue3786MvLpNndMM5gw3LKQ2
         8XOUn36Lgy5u86L9EGD+iBiWi4PuYUiCFH88BByf0UY9OQ2aGObMX7iRTwftuq7Pzw46
         9cy5TUtrSnv6V+82DkEPPWJgcvpAdjC8tZsy/Oogw9RGqGhOHfMLFziv1fJst1I+1J1v
         nU5KUF0qd/gAWUUfMdhLDnI/OJFa4l81AvETdG+t9n8ihdcMeJqRysZb2rdVQws0ceKu
         lgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870849; x=1733475649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM59VOGYG3wMVgUo99G/iJLAIksKG+8729FKlv13tNI=;
        b=GTboJ2CtxhOI8vo02c0WEzcDTYFVhQm12HOXtMHqDPyDjLP59F1s3A/9v4E7j4rBXu
         Zhj4p7tr2yHYk6s+QF6IZ8RDs7fnrGRHSLvwvENcxLxZ5Z06eho/ApCfrDVt4Htyi2YP
         EHcw541zhFUyx+bVjJHvpSg7k6cAEKoyJF65JC6cqoj8DWlocEAaohh68wSrWh4ciuPQ
         G4whG01xu9W2B6YCMszlb0YGlyKCa7LL6VoYNZtSnDJJ/xmoBSh0OHCP/1guo3Rgf3/f
         LMymFJxsQL7QwYwFqhuZfmjj2kLznKlzwpN+GG+IKT6DmsEn7KHjrW0FOJyrq6CzQdBB
         XkCA==
X-Forwarded-Encrypted: i=1; AJvYcCVLJkZSdljyplvt5Wc1jsyvkK1ncufTSpkW4YeRPY4cNdDZ62J2qrkIRMwEWDg+/z1ezss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAA6HBz9H1tzR2pdHFSD4dy/a5wGyYar6mqhMPU423FrywjM6C
	A5naZChctEJLcIlzTyOClj4wDKNuMu1q6EQi8qV5o+MnO3kph2VTeg1wvU4JkLlvfAZCELWb9A=
	=
X-Google-Smtp-Source: AGHT+IGHXhcpcjgkHjA0k7hYdLh0VcYJ721uO/6wKXB9uB8gEZqYP0S/2HCU0HVINTTx/wAZ9JlKx76g5w==
X-Received: from ejca24.prod.google.com ([2002:a17:906:3698:b0:aa5:2ede:53bf])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:d513:b0:aa5:199f:2bf2
 with SMTP id a640c23a62f3a-aa580f56baamr1006472966b.29.1732870848742; Fri, 29
 Nov 2024 01:00:48 -0800 (PST)
Date: Fri, 29 Nov 2024 09:59:34 +0100
In-Reply-To: <20241129090040.2690691-1-elver@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241129090040.2690691-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241129090040.2690691-2-elver@google.com>
Subject: [PATCH bpf-next v4 2/2] bpf: Refactor bpf_tracing_func_proto() and
 remove bpf_get_probe_write_proto()
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With bpf_get_probe_write_proto() no longer printing a message, we can
avoid it being a special case with its own permission check.

Refactor bpf_tracing_func_proto() similar to bpf_base_func_proto() to
have a section conditional on bpf_token_capable(CAP_SYS_ADMIN), where
the proto for bpf_probe_write_user() is returned. Finally, remove the
unnecessary bpf_get_probe_write_proto().

This simplifies the code, and adding additional CAP_SYS_ADMIN-only
helpers in future avoids duplicating the same CAP_SYS_ADMIN check.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
v4:
* Call bpf_base_func_proto() before bpf_token_capable() (no protos after
  should override bpf_base_func_proto() protos), so we can avoid
  indenting the switch-block after bpf_token_capable() (suggested by Alexei).

v3:
* Fix where bpf_base_func_proto() is called - it needs to be last,
  because we may override protos (as is e.g. done for
  BPF_FUNC_get_smp_processor_id).

v2:
* New patch.
---
 kernel/trace/bpf_trace.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0ab56af2e298..b07d8067aa6e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -357,14 +357,6 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
-static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
-{
-	if (!capable(CAP_SYS_ADMIN))
-		return NULL;
-
-	return &bpf_probe_write_user_proto;
-}
-
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
@@ -1417,6 +1409,8 @@ late_initcall(bpf_key_sig_kfuncs_init);
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
 		return &bpf_map_lookup_elem_proto;
@@ -1458,9 +1452,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_event_read_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_probe_write_user:
-		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
-		       NULL : bpf_get_probe_write_proto();
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -1539,7 +1530,22 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id, prog);
+		break;
+	}
+
+	func_proto = bpf_base_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
+		return NULL;
+
+	switch (func_id) {
+	case BPF_FUNC_probe_write_user:
+		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
+		       NULL : &bpf_probe_write_user_proto;
+	default:
+		return NULL;
 	}
 }
 
-- 
2.47.0.338.g60cca15819-goog


