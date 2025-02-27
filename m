Return-Path: <bpf+bounces-52784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB7EA487CF
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B6F1888F6D
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6791C1FCF47;
	Thu, 27 Feb 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc/TMF32"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D63C1F
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680936; cv=none; b=qalbL3EJ0qoEcJUoQY+gvStUk2gYvyXKEBBffY5FGeA8ljU7XfEjR2p0JUl6YN/ycf5ueSZ4rqVHGQSkVyalh/QmTgi3F4scvJKu+CjbvUswDrplpXr0Yj4WwkEywBtLd+P8lggimuU7KkvtfuQjL/JxQ7V+q/RsTvOdLsnhpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680936; c=relaxed/simple;
	bh=H1wBdTjlS4Ar0wNTIZE6jYaz0NqfWNleEf4i1G95xQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aXf1flxPlq6JHrLN3X9QbLhl8VaCuB4/3vU9pHbZUoTe+Foze/YpALNsjM/aUhKGGKCIJJ5O0bzYt3wVnR0brR6eCFgjFyOPJCrytcUVyc3r2pnMc3qNka1j9Tze4xrA6pa8qlJ2a/2a+uCSFkSZmeeBGFLivTFPd9wUVMcw9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dc/TMF32; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390dd3403fdso1065876f8f.0
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 10:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740680933; x=1741285733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2dFzW/wwKGgpFrPUC9+64GrIFTxUJI1qNSXitcHF04=;
        b=Dc/TMF32HW8BSC0R0aQ80ImKxdSkLDKZDA/CyT6wOv595Zh09p+jhpXVoL2HhnwetE
         PsUNp4G+HI4lZMQqanTqa5MftXZk5M2JR5CMrJXnMJAHSEQ4FVallNlD7JbCKXB4ZTlH
         IpqNs/CPYbclAJjSTy2Jyd4Wy3MaemJqcPkgWGW8jXzEiaBG4JGinP3FUkJLzmslicyd
         iA1PpADRATImC2hdCGnvFb/ra+T5W1RHr0DNXi4LGpNuV5p7LfGKRx9Pcc5UyNtHWoR9
         RZmZsT/8Rrt0ZR7SyiB1ugxhKUgBjg0gZ58gkxgyowwafbPtEH/VttA4RkgKdRGfAdaX
         LS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680933; x=1741285733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2dFzW/wwKGgpFrPUC9+64GrIFTxUJI1qNSXitcHF04=;
        b=wOlas9wstSVfr/THptnF6LCrrtxcRMazqUtmIhCu/JLWnmeBl4JqK3DvwDNCt+I0iX
         DL44ITaNvd653/BF7wVcZ7uY+YryC03N/X5qy0wEBzq1Duwu29VrB53uNfdZanKL00mc
         /2RnmuF44bE+6bPxO3BkufKg0GzFdDJHVpk4ZP/YfJtC32f2E9j0DdG+XMipuBYkt8x1
         y6ulwL8ZOdeSB+30l5AhzE3TNoYGZf1cBtUQ+BjMp2ctiaMAQJlkAYlZ7L988FqqfwBu
         XZHhXBlrW4TVDGzSAgzhOFzAWh7RszopJV4w4jxGAkgM+LjaCfatBTo1ns1/CDTszkgf
         7S0w==
X-Gm-Message-State: AOJu0YxR2FzpDJ464pvvO2HF4P7VMYBxgXO+xXL7xOrxDJXjz7gujaJR
	LmTn8JC4b/3q0Ff6Yz1pWL3RWr7xwmVSaLoAqtZ9zrE/te51aIAYLxQaNkfzab+mLHY/
X-Gm-Gg: ASbGncvhxqBTZE8RyELvhcoNbxG93X1qoZzuxSmyBztJOeEbxMgQl3rz8GZHIznSBT0
	1ImiNEMw6t4Ry834XmpNUON7KEzfnufmwI2pqRWIWw6zSFplAPki3mNJUHmWeUkJBNhyP1Kj9TS
	X+/SXoL66vVfCFkOrHvfw4DMcpvJDoUg0aOJmqLuYplF3/fKaVRjPC2pRc7S68CYwuJgB7FCbrb
	uzmvHNjKI5ivn6ZjRGdFzV1y6ndm0FkVZAeW2iNa57j2yTOHOIffTy+CD0pq78t0t4CwpSWBex3
	bEL/02pJyO5p1gT6Iw2jVug4VFnlkM3ncLjRYDoK0H9+DEF/aJul
X-Google-Smtp-Source: AGHT+IElRhTMK9I8q90mTyr0NWtaPDPo3T43dz2Ge+xrI1BCaGkblYK4esvKi1Dd8jnPdaDq+I+Ngw==
X-Received: by 2002:a05:6000:4027:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-390eca5b1c2mr126422f8f.43.1740680932290;
        Thu, 27 Feb 2025 10:28:52 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e47a66c9sm2818233f8f.33.2025.02.27.10.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:28:51 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to tracing programs
Date: Thu, 27 Feb 2025 18:28:29 +0000
Message-Id: <20250227182830.90863-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed in the context of Cilium and Tetragon to retrieve netns
cookie from hostns when traffic leaves Pod, so that we can correlate
skb->sk's netns cookie.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
This is a follow-up of c221d3744ad3 ("bpf: add get_netns_cookie helper
to cgroup_skb programs") and eb62f49de7ec ("bpf: add get_netns_cookie
helper to tc programs"), adding this helper respectively to cgroup_skb
and tcx programs.

I looked up a patch doing a similar thing c5dbb89fc2ac ("bpf: Expose
bpf_get_socket_cookie to tracing programs") and there was an item about
"sleepable context". It seems it indeed concerns tracing and LSM progs
from reading 1e6c62a88215 ("bpf: Introduce sleepable BPF programs"). Is
this needed here?

Thanks!

 include/linux/bpf.h      | 1 +
 kernel/trace/bpf_trace.c | 2 ++
 net/core/filter.c        | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 15164787ce7f..c079cf3e34ea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3361,6 +3361,7 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_get_netns_cookie_sock_ptr_proto;

 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 13bef2462e94..f2d37ae27ad2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2012,6 +2012,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_from_file_proto;
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_ptr_cookie_proto;
+	case BPF_FUNC_get_netns_cookie:
+		return &bpf_get_netns_cookie_sock_ptr_proto;
 	case BPF_FUNC_xdp_get_buff_len:
 		return &bpf_xdp_get_buff_len_trace_proto;
 #endif
diff --git a/net/core/filter.c b/net/core/filter.c
index 827108c6dad9..4f42ab00c875 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5168,6 +5168,12 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sock_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX_OR_NULL,
 };

+const struct bpf_func_proto bpf_get_netns_cookie_sock_ptr_proto = {
+	.func		= bpf_get_netns_cookie_sock,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_MAYBE_NULL,
+};
+
 BPF_CALL_1(bpf_get_netns_cookie_sock_addr, struct bpf_sock_addr_kern *, ctx)
 {
 	return __bpf_get_netns_cookie(ctx ? ctx->sk : NULL);
--
2.34.1


