Return-Path: <bpf+bounces-39711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C0A976634
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 11:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0321C2324B
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035F19F10D;
	Thu, 12 Sep 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEedDX+D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0D18BB9E;
	Thu, 12 Sep 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135192; cv=none; b=g/QMM9Fl5CTaRsyMLLfBCGuVmLKQhMEg7gWWm7yjJdpl601bbgLV2WkQNnvc35EzDw/u5QDV+0/BDUolFh3javZ+4VZUvs3il4Cr2xuhAELLnublW6Joatr8G708I6v/LGvYW7cA2Bvk1ZLqvWLLLEEtSXYPkl7vcQM+zyVFISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135192; c=relaxed/simple;
	bh=+eC9LwoKU/0hryseT1PuMLp7OtuNBsxxiX6MZcVBpRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/viSwJUL20ZD9fyo8WB6jx0bakfzS/nIck87l7LGZou8uMhVFfrXgDny5F2SkNZZ0vfE8uNiXAEuh14pBY5Pj7TqwM3ABBGNBeb5ER0QVCT64/9PniW9Wh8mnR50QcRuM9mm5PVnn2LRaKWNDCfBIR2LxxF8IJ6Hh+YOZ8V26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEedDX+D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so6851875e9.3;
        Thu, 12 Sep 2024 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726135188; x=1726739988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R68n0WpZ7NAMs//wrAMdNTn+ob5hHmatDwrx6WqrR6E=;
        b=GEedDX+DerAhREATiFweFJaFit6+Lxen0TN6fgCqOv/4eKTQg24vlWlvSjxnmO21Ic
         8N5bG2UCcgbNWfyLwlLcoZWSa6D9RnwhkfN9G9kVkHU6m1o01Z5odWPOiuCpFxA/xSDU
         u1WznTX0odqhE4k1ZFtiiWkEZdsDtCiPxskLjEt6E+ciaeA6dvobImN40M2+4UH7aoME
         bvxcaQFYNGxFtLkBisFanM6MXWT05jsrNfurPiMBPCYQyrKb+V5xHYj2N5kT2Tiwfs2k
         qKBVn8lHT0KkyjOISFEPvYW3XZbLBvu0I8LpocUQuaMx0SSfTTo7ACPP5bef0VG8SWcq
         KckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135188; x=1726739988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R68n0WpZ7NAMs//wrAMdNTn+ob5hHmatDwrx6WqrR6E=;
        b=gr5c668r7hcj+/JFPA4eW112B6fhFmqpa3xPEAF7hLVuPYnZcmMwSBcUYRDt3pR83f
         o9lIPRWmWrxT97NFXX910i9C1wMXf9diOAetNGHVXPRk23xkQNEyX28mRiPbtrw0rman
         Uu7wh37+CYwsN4EPoppwlAeRzW0JGCmGo6Ysn6QotjmmSSg7tu2qhXzJ4AkQtwzvoDlA
         T/9KZHeB1Pt0itNag4LIMp/gL+hUwbZM7KpW0j9Qb9g5ZmCjCLcibf0zkB4ibqauhKdt
         yTW64vLRfFlLdrTcqY5cbyRbA9CdoPU3vNXX8WDlqbmOuyVBsFWQkuicofLZgCD3b052
         CeYw==
X-Forwarded-Encrypted: i=1; AJvYcCWgkJKdVoNp0wAUbFJE4UjILXtpoQsSW1gSMsnsvIRGT2gI51fRG9xGR/DX/bxFZdmL/3HwciSdBEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hdhI4AnM+19DrLCUrUciFbFk+WSYPeGBlO/JK3ORLbsVe1/x
	WwBRTDG6vRLTMdbHfTzwbKmUvI0DEooOp2iHqELd588js7AXOsh2It6miQ==
X-Google-Smtp-Source: AGHT+IH/JFGMcLnxAyELo+XxOIqJWUK72/01yc0uML7I0RbSY4WEbbWkzGhyf4bbETJZg5e+VebaOw==
X-Received: by 2002:a05:600c:510f:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-42cdb5389acmr18701695e9.1.1726135188088;
        Thu, 12 Sep 2024 02:59:48 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:c4fd:1041:7607:289c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8674sm14098064f8f.115.2024.09.12.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 02:59:47 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2] docs/bpf: Add missing BPF program types to docs
Date: Thu, 12 Sep 2024 10:59:44 +0100
Message-ID: <20240912095944.6386-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the table of program types in the libbpf documentation with the
recently added program types.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/libbpf/program_types.rst | 30 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index 63bb88846e50..09bb834aa827 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -121,6 +121,8 @@ described in more detail in the footnotes.
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_LWT_XMIT``                |                                        | ``lwt_xmit``                     |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_NETFILTER``               |                                        | ``netfilter``                    |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_PERF_EVENT``              |                                        | ``perf_event``                   |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE`` |                                        | ``raw_tp.w+`` [#rawtp]_          |           |
@@ -131,11 +133,23 @@ described in more detail in the footnotes.
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``raw_tracepoint+``              |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
-| ``BPF_PROG_TYPE_SCHED_ACT``               |                                        | ``action``                       |           |
+| ``BPF_PROG_TYPE_SCHED_ACT``               |                                        | ``action`` [#tc_legacy]_         |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
-| ``BPF_PROG_TYPE_SCHED_CLS``               |                                        | ``classifier``                   |           |
+| ``BPF_PROG_TYPE_SCHED_CLS``               |                                        | ``classifier`` [#tc_legacy]_     |           |
 +                                           +                                        +----------------------------------+-----------+
-|                                           |                                        | ``tc``                           |           |
+|                                           |                                        | ``tc`` [#tc_legacy]_             |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_NETKIT_PRIMARY``                 | ``netkit/primary``               |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_NETKIT_PEER``                    | ``netkit/peer``                  |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TCX_INGRESS``                    | ``tc/ingress``                   |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TCX_EGRESS``                     | ``tc/egress``                    |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TCX_INGRESS``                    | ``tcx/ingress``                  |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TCX_EGRESS``                     | ``tcx/egress``                   |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_SK_LOOKUP``               | ``BPF_SK_LOOKUP``                      | ``sk_lookup``                    |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
@@ -155,7 +169,9 @@ described in more detail in the footnotes.
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_SOCK_OPS``                | ``BPF_CGROUP_SOCK_OPS``                | ``sockops``                      |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
-| ``BPF_PROG_TYPE_STRUCT_OPS``              |                                        | ``struct_ops+``                  |           |
+| ``BPF_PROG_TYPE_STRUCT_OPS``              |                                        | ``struct_ops+`` [#struct_ops]_   |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``struct_ops.s+`` [#struct_ops]_ | Yes       |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_SYSCALL``                 |                                        | ``syscall``                      | Yes       |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
@@ -209,5 +225,11 @@ described in more detail in the footnotes.
               ``a-zA-Z0-9_.*?``.
 .. [#lsm] The ``lsm`` attachment format is ``lsm[.s]/<hook>``.
 .. [#rawtp] The ``raw_tp`` attach format is ``raw_tracepoint[.w]/<tracepoint>``.
+.. [#tc_legacy] The ``tc``, ``classifier`` and ``action`` attach types are deprecated, use
+                ``tcx/*`` instead.
+.. [#struct_ops] The ``struct_ops`` attach format is ``struct_ops[.s]/<name>``, but ``name`` is
+                 ignored and it is recommended to just use ``SEC("struct_ops[.s]")``. The
+                 attachments are defined in a struct initializer that is tagged with
+                 ``SEC(".struct_ops[.link]")``.
 .. [#tp] The ``tracepoint`` attach format is ``tracepoint/<category>/<name>``.
 .. [#iter] The ``iter`` attach format is ``iter[.s]/<struct-name>``.
-- 
2.45.2


