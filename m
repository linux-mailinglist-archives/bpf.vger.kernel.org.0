Return-Path: <bpf+bounces-45702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231F9DA694
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7166281E14
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E931EF086;
	Wed, 27 Nov 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qM4RhDWO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C851EE022
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705832; cv=none; b=lB8VgqoUEDEyGuy7ehOw+vcgIkJBHuxqWYUHGAXZF0TtNzXRgvRqM4ko/3N6mEMtCRWm6nnkCne7xFFvBapF7ooKauJEcTfm3RKQGfGpRmJvKJDggjXssPfm3FWP/Jih4N6DvazvWZCndxj/Xj+mz0t+dmHI3UkNyJFHBWhHAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705832; c=relaxed/simple;
	bh=n6SFQlgQ89x+UN3cScyPqDrPZQIK8ftr0Y2vU2LxfCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ReHXQNepflYWxdQ02LNF8d3DcmzCkqXkW1q71Q8WEtxmM9wTKoylT1u4yGglTjU9ZqzkDXq555loDnS4+usluheGDm/0GFHq+sprly7bS1JQmPZ5hDJVAxriuj/JfLVJbWVq8Q5uOpEBWyle17CU5pYYyRZVooBlWxKyxChzRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qM4RhDWO; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5cfd063f65fso2059943a12.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 03:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732705829; x=1733310629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R16rjOQpVflGeOoJdXs8xt/CprClomxX6VQzmlYl7Q8=;
        b=qM4RhDWOt44e4KZ9HnAFNjGT5OvWBDGwksE6v/6n4UxpfwoEQDw32WlimyAQF77g3U
         mu/k5RBsNcBRbPy3Q7mZHrWUahbhduwTZ92/daKd8dFO58wZscvSsyWvmCjcuRURcjdy
         GtY+Qv6a10mv9kf7nKvWOoOHI0kn5Xm//prxWzemIi1CbNHa5M0TVbwW/NjMVCeN59sf
         +VyDAzu3X2+4AU054Fxi4G+6tafTAAanYBV0PufcBunBIoG2VcGrRc5iLqtJrcOMZFWd
         wWAOjJgtaHuuuE5t/TxIRwb25yEjon3ugADOLOMu99A8P693tXfft8NRLMdJ0DQiDQbI
         p2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705829; x=1733310629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R16rjOQpVflGeOoJdXs8xt/CprClomxX6VQzmlYl7Q8=;
        b=C3PGwl3xDUGVUrK0GgtdfcBUx4DZrbsLVgC7OfkRBbHWxX2fzbwuw1a8XVC7iEZ2Sg
         ZFDV0yNzm1LQamrJQu/GajcfWsrF11BMotqQDWqCqPa5LbkSyz92IHQPs9AUD8C+JXl5
         5Y3Th+3VZMb/uqpRozkotMfknNG6IqfpKoqxNcOVtffx52InKVApdphGajJnFZCF/jBc
         pyHi7NkNQDOKZtDMO9ySJcO2WZVqY3vIYBNZ9Ewb9k+olv/cZ37t0BrUpOfcNZGoEVQ5
         XGyQNW8lA5A1w8wyn1e8wdVk1guGsJdTns2QZ+8RQx63H5gi0tWaGt/O29TlQ3pzo6wH
         0EVA==
X-Forwarded-Encrypted: i=1; AJvYcCX1eN1duvmE6FctauX1LUC5xAkNeqsYpR6DROm15P5I0gVmftLoE1HhmFUEZVGiqNmSjfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6SgkyiGk3bHq4kUMcZLZYp6PErvSuz5pw9caVqP11iIPtnsg
	PDjLuEJilAGUQUWAntS6e7iK38JfZzRoRPu70dIZP5MIbmHImjiHmfdjK02CM4JS0Derf30ENA=
	=
X-Google-Smtp-Source: AGHT+IFuVotXYt+hPl929kqPNZTpS9LM+/Eywv9tUfBdOkJB00QlrJaxyYKFUm0tMShw5iE3GwobJcrbhw==
X-Received: from edbio6.prod.google.com ([2002:a05:6402:2186:b0:5cf:db39:7001])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5108:b0:5ce:d435:c26d
 with SMTP id 4fb4d7f45d1cf-5d080be7cafmr2296169a12.19.1732705829149; Wed, 27
 Nov 2024 03:10:29 -0800 (PST)
Date: Wed, 27 Nov 2024 12:10:01 +0100
In-Reply-To: <20241127111020.1738105-1-elver@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127111020.1738105-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127111020.1738105-2-elver@google.com>
Subject: [PATCH bpf-next v2 2/2] bpf: Refactor bpf_tracing_func_proto() and
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
---
v2:
* New patch.
---
 kernel/trace/bpf_trace.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0ab56af2e298..d312b77993dc 100644
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
 
@@ -1417,6 +1409,12 @@ late_initcall(bpf_key_sig_kfuncs_init);
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = bpf_base_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
 		return &bpf_map_lookup_elem_proto;
@@ -1458,9 +1456,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_event_read_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_probe_write_user:
-		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
-		       NULL : bpf_get_probe_write_proto();
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -1539,7 +1534,18 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id, prog);
+		break;
+	}
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


