Return-Path: <bpf+bounces-39619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58631975645
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E092824D7
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A61A7ADE;
	Wed, 11 Sep 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7vFI/9t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BA18EFC6;
	Wed, 11 Sep 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066757; cv=none; b=KGB4R7D6x61VMJSdXYAHQPulmWJXRJcRe4RqCHSVDItmQy6wuZoZoADUJoEj9xbXwMv8KZ/dFxPbQxJuuGfA8IuWalGjkvzjjsGpxGXVNYFM2MpkLPIolBZdTyCTE2mH2npiFhjd9UFVNwtGKASsN+4ZZAWgLVMCubCIZfAB9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066757; c=relaxed/simple;
	bh=EqeoGGKYxejcimh8ipTluV/rKmHEBTKVxt+XCWO4Ng8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWWpFfFzQlKKejvQGWbKCBkKUxnfhPSI8DZoq7ILpARd+c64nMakFGfQR1+dY5QnDKqfqzqXq+MsGZdxHc1a16WVjVp5bcXpfQDLbngLuCvUKtlt3fCNekOA281Uptv8yhsANsHxfWM3OLFey3Fn4qSP+ECPoeoi05qtCbJRe3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7vFI/9t; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so19585385e9.0;
        Wed, 11 Sep 2024 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066753; x=1726671553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vPknzLVW9/P4LhuPBju+jLE/L8k7OTaPSStuKbZs4E=;
        b=E7vFI/9ttMzyIP/Ll4ISB9WIUzYFtF/A3qdEuObyeTxRSyzFff2F80AavIAfVRpS/H
         pSzf9C4P8rZMjNWTSQVZOi+UMu3KF0vGEJcut57fy3xzaLkSyYM/UEh5XL4Vh25EJXAq
         RtmA7guwF+HKuI5ik9CHt+pPPBBzH145STBUJq+i8rzWno5z0UasYaeXA9BfjO1Deo4L
         CUYmB9/Qm0ik2y3Pzqe3zH3aaF4sOOY3tf4WvBU6NyadTH46jLl7qyjw7XtpIqyQdKIb
         rBsgSjtEHhXvQIqfmVSNGcIrQTWA0XrKWeLK92sJl1aQjnG1Y8txppubXD0Yy66Cw1RL
         iXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066753; x=1726671553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vPknzLVW9/P4LhuPBju+jLE/L8k7OTaPSStuKbZs4E=;
        b=ojIqBDN/EeLuG7lmsKiK7xvBX0WNQ8OLCzmCY+lVmmURZClKL9vnPwiJvZn8cmfNnm
         6bPRwBa8kctNycvREYm74nKTARtaN5eV2m5XK3a0UZwq9xCtupYltMm89H/c+QjFIT65
         7MQy6j+RzXvvY02V1RJe4erpteIbqFKhO2s5GpjVm2V0+S/1egtMWgsd5Ta9ZdNGDPO5
         no1wISU919Wp9OrTy34bh8iYkXqKYQg1xFNAtSrTpKs472hzfuZpJ77ICjzK2DjkVzNS
         JVjj1QB6ymZt25LnBaKJSn3P5WJJ1iHv6vW/va2LuSTCmEFLa2bN68q4A3dZZ/A8T0dw
         S/9g==
X-Forwarded-Encrypted: i=1; AJvYcCUHfadbpEutBGkbGRsmdSm0asC1jKE+mbTCfH01+HYJim2JOJrSNGHZU6n8zby+ZGb8fCtLuoceRWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySLXCMAO/qrdDHbrb+SrsMY/tvN9h58BOVoFvGGTQIfiBqaxmp
	qrOoyVChzNuB2cwZKQtid0GksO/aYVFP7tKNqIgL+t+97pevSNxeuzaNTg==
X-Google-Smtp-Source: AGHT+IHbbMGDnBgiMdzBb7jXm6RmAw/LVu9dMUGLWDMnWSKu2Ind9p2nouMzQpdZnkzO2L2E7nfssw==
X-Received: by 2002:a05:600c:1d1f:b0:42c:b22e:fc23 with SMTP id 5b1f17b1804b1-42ccd32dde5mr24665565e9.15.1726066753011;
        Wed, 11 Sep 2024 07:59:13 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:68be:b85e:1dba:191c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d35e5sm11843507f8f.76.2024.09.11.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:59:11 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] docs/bpf: Add missing BPF program types to docs
Date: Wed, 11 Sep 2024 15:59:08 +0100
Message-ID: <20240911145908.34680-1-donald.hunter@gmail.com>
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
 Documentation/bpf/libbpf/program_types.rst | 29 +++++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index 63bb88846e50..fa80a82d5681 100644
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
@@ -209,5 +225,10 @@ described in more detail in the footnotes.
               ``a-zA-Z0-9_.*?``.
 .. [#lsm] The ``lsm`` attachment format is ``lsm[.s]/<hook>``.
 .. [#rawtp] The ``raw_tp`` attach format is ``raw_tracepoint[.w]/<tracepoint>``.
+.. [#tc_legacy] The ``tc``, ``classifier`` and ``action`` attach types are deprecated, use
+                ``tcx/*`` instead.
+.. [#struct_ops] The ``struct_ops`` attach format is ``struct_ops[.s]/<name>``, but name appears
+                 to be ignored. The attachments are defined in a struct initializer that is
+                 tagged with ``SEC(".struct_ops[.link]")``.
 .. [#tp] The ``tracepoint`` attach format is ``tracepoint/<category>/<name>``.
 .. [#iter] The ``iter`` attach format is ``iter[.s]/<struct-name>``.
-- 
2.45.2


