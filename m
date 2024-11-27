Return-Path: <bpf+bounces-45715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8799DA9B9
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34922B21A2F
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E421FDE19;
	Wed, 27 Nov 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVgvVJYB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6E1FCFF4
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716617; cv=none; b=AsRhhFJwlOi2UIUOlZtKXf0hIPjhcMY+6nY6OUmDOtUQqYCj5LjcrVDqVcFpcoKaLraJUfhpDgLxRuCDozYmhjDfXmRN/4bfhNhKLz9Icrrl09HXtTL/NgW/s0gYWUlA2yyk34LpcsStP6aZKJ43rA/SQb/5GJfbZ0VDnjlOmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716617; c=relaxed/simple;
	bh=sGujSkfOje6q3rhHE4tIYkiqfs33OKNxgBeAjusNinA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LVo/MA9J/Df071AXhmuVQXxkeF89tUtk5vM6vOqkRp0iyy0AW/sGj3F8OOA2FFauMiJ61zFAEDcYndLxRj66KCQ7YkYV1FiT9IMGMo2XhtEQKZNEQW6fAZJ8Ck+OIUeGPPz8vsSjzBBcOSuEAwppBkGaw8iBGkH1/ZvbBtIqatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVgvVJYB; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-53dd663d73dso3596675e87.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 06:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732716613; x=1733321413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HKz8SHPsTiWdyPzN3tC8YsJEJ+U8IfvZzPBvdLUPXY=;
        b=dVgvVJYBbOx51B6a4HyhfdUr2qtY5X6V3UeSxbQVc4ay9cUplxdeefruqBV3aLSdzj
         z8H5eowlyhNwPzYr2IgoLNtMd3+vb8/qjHPwJaRZRaYCaeG5Ksi9MNamY2Ng7HVMt/h2
         i7xi09YskBXaesyZFvbWx30h4+8WPmrySue1G235wGop43oXNiQmf1zklLtq1kEhriEy
         V40OIFbqhminsf7IKB8clkbQskseupY0ZQhxhItmzAbzoLaaHAz8SJ1h5lvi9pfE6qQv
         Au0znA8+6oaGMKKwZw5+sFVFgk2JVEmKhVeNP9MlTmoAVatgWk774IHrlKYiTJgpKXJe
         +42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716613; x=1733321413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HKz8SHPsTiWdyPzN3tC8YsJEJ+U8IfvZzPBvdLUPXY=;
        b=Ye2gu7FIZGgTefpbwb/Ci3eh95a2kW9ELlYa4382ipy8VBNGQ9IopE9kJwFWANFi70
         oV/J+tR6QBSsnJB7lVP66dKiXrxnKChhOQtlbOyvzknckb8VrapN5PmXEA95WpHILvBA
         immFueNzq3UkXzNeiTL6oem0pfNbbcjK0ovrqQ9PeQoQ5WC3mUJmgNtN4i8fJVUcLmrV
         oh2mTpjquvMcZQ201bHUBmK2+rKYOOChMLYjyFU/8BBrDhtSzLWK3jOoPhydFM4SP+rb
         PLrD/yG1eovr0fsv4a5AMVmuc/cAF0GJvAT+JB6tvonEK08GO/3/vuKWao+4GMpjh5KC
         VNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV86mA9g+1Qb3EZ66EXsn+GH97VZkzlSFFoBOXNwWOIlbqVKIbJzefnym1Pilt+8BqdfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpbAKwHwPfpQdyPk9xWeiQUXrDBPoieh9BpK8zkHCUrEPyBF9
	7zRuDuE8hEUWOw5HI5oXhwcB03QJvmWhjg4gW8qApo6c08eBy+O3MAxduudtKjp02y7w/qqVdA=
	=
X-Google-Smtp-Source: AGHT+IGi/7aTXmyQZ5xDW/bdnyQbVTiKVhfU9+rw9t4S3CgNTD13Tt0NOWPvtx8xXNuCQvdoJx73CMyzmQ==
X-Received: from edsf19.prod.google.com ([2002:aa7:d853:0:b0:5d0:36d0:ad4a])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:124a:b0:53d:e568:ac95
 with SMTP id 2adb3069b0e04-53df00de101mr1532948e87.25.1732716613445; Wed, 27
 Nov 2024 06:10:13 -0800 (PST)
Date: Wed, 27 Nov 2024 15:09:36 +0100
In-Reply-To: <20241127140958.1828012-1-elver@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127140958.1828012-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127140958.1828012-2-elver@google.com>
Subject: [PATCH bpf-next v3 2/2] bpf: Refactor bpf_tracing_func_proto() and
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
v3:
* Fix where bpf_base_func_proto() is called - it needs to be last,
  because we may override protos (as is e.g. done for
  BPF_FUNC_get_smp_processor_id).

v2:
* New patch.
---
 kernel/trace/bpf_trace.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0ab56af2e298..9b1d1fa4c06c 100644
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
 
@@ -1458,9 +1450,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_event_read_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_probe_write_user:
-		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
-		       NULL : bpf_get_probe_write_proto();
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -1539,8 +1528,20 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id, prog);
+		break;
 	}
+
+	if (bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN)) {
+		switch (func_id) {
+		case BPF_FUNC_probe_write_user:
+			return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
+			       NULL : &bpf_probe_write_user_proto;
+		default:
+			break;
+		}
+	}
+
+	return bpf_base_func_proto(func_id, prog);
 }
 
 static bool is_kprobe_multi(const struct bpf_prog *prog)
-- 
2.47.0.338.g60cca15819-goog


