Return-Path: <bpf+bounces-72842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4B4C1CB0C
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6BF188EE68
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3FD32C305;
	Wed, 29 Oct 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOLUlSpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423B354AD7
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761387; cv=none; b=cVXNoGgrIMtGqaQAPLGfeon5H6FFe/ot02VUeAl+jifXm0PjNcafyyKXiDuVblJRbKJDkozq2n7KG7XEbhkO8kcPpyidhrKlhcIkuMYQwGmgXBm7xA7AcRtG7SGF7YWqUX+WJ1YwE+nLzEBYEcRKH5YKEwoCNB245G4h87Hev3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761387; c=relaxed/simple;
	bh=dWPZ1vMUZGwvldnx5hHqv6HtLWyBzsxGQxxMlT68dFo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Dv7WWoQvmg47v3GISbAaUBjfq36+1nhUpem06X6bjxpN90NB0kB0tWJ/woLqsnkAoDKpFnaP+a9FcauwTN1lZm29IWNIY2NO6dgBN6cU7Q6AfZEn014vwZXlfn0IRbPGO5vj/msYQ9jzOs88iw6KwUUBQlBzke7uGO5oN5dVtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOLUlSpq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-421851bcb25so75819f8f.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761382; x=1762366182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXI33tD54+aq9nAZ/zSVwb1H0zSaU8dg1YNP4Ue9Y1Q=;
        b=gOLUlSpqrJkDg7270uSho/R/Mj8CgY+WgURZXZ70RMz2z+/noJxtF4PNPMGIqbR46D
         dwp6HwlqtUA04GfXN0EBhfmVKEEh7JM0OO3q9dq/XjB0EP+KgJC/F5EOpOJFImjFg/W8
         c2ILXA6BJrMC3Hw8RpRhshquFpgbHxe3EOGOLIj8Mktt4eutDQ4zQzLiq4nmCrkqq2SG
         LBo2i1oItJv2ZHplNDqFmsx39VnNMyvLjMJHk0R0kkCj+XPjD0rxfLQPDE/rTjXvMRi2
         /bb4hY110up9MTkk0AKtoqs/k167UaWaRtgUcvne+tKFUShznsBgUzSNBzN9cMdiEWVO
         cymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761382; x=1762366182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXI33tD54+aq9nAZ/zSVwb1H0zSaU8dg1YNP4Ue9Y1Q=;
        b=BCos6dNLFzmVK4HAGrHBefNbUfmnE08zDU6cZf9vqW3JA2R/xEu+gzH5Ucd82S3b0A
         nFAjtFszsCFnvqF/COLIhfYpimdH/cnyiDG0jvTWe8ZBbKZRhVrOCImmlsCXsnD10Bwn
         75/3GcH8sUnTxu9aBQUuoATws9BTH6o9jw3hp6vI7mX5VNRSRjf/kbywqSRZ26c1n2CB
         UwBfhYMJgxWReRJ2dEyqskw4ORUp1ovvyyceNFpYBsW9n/BD7/3R+bnLziPcym7ZXFPm
         cB9jCCof5X0RenoJp8SIeb56v+Q4KPyP+fTGGPvz52OOHY3KFlyYLZM82jVXGnDWgFHE
         bi6w==
X-Forwarded-Encrypted: i=1; AJvYcCUfOfiWaBSdgoDT+Da9YFZ41SA+beHBEFm6l42GxqtaLuiyXo6VKmY44b6jZgxPGAqIeuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtxlxMrXrZRblZ4VQdJaKivtOQFu1Xg6fN4ZLZwidv702SDd+
	BVNfRwRSK01DRo6QG4Q69h/cXrzWcjXa9F0clJ6aOPiE7ra7rETAyeMd
X-Gm-Gg: ASbGncth8EKkYtAwU1VINWEnkiWXwfnhvRD/qfIvp16LSMIHgqusOtW9Ui+dQRI8N/x
	wRH7xmxZSgJEScJPv2R+/cZ3K8TSlRbwyLet5A6x5WWAJCTUe2W0eQr9RaXcBc5pMj6hxXO6TLJ
	WguVsT5sXB1MgEyBwi1Zab/W7CS/NEDXOyUaZ2K+Rs2cSln8N669bqBgC0OBksMlHNOad8Qe/im
	8lE10d/Es7bi++RTMXrPwsftFRzy982z8QFgsKzZcY9wvN6mfZa7FPWU70WTB8dme4rRmZh0Dpl
	M2lHcUx4J7oR6TO6c1PC3aTAaymcu46s4RrVXRQ0zQpX3Q5PfYtTOMRr40A2SeYBzITiwF3pvUt
	1WoM4jUqcnvgAxbiiahpKP9OSFhKRAP91AyFVeD7/0vxkLZSqxg0Y4wHXnR8AQoUAC1hvvtjVzG
	wSSouLRF4aNWFbmA4DkLAqD7a75lM=
X-Google-Smtp-Source: AGHT+IEcrPMculvGLm+7SwTY0vEPu2f5p0xV1Ze5JnahmEGnJoY0TXskVU7ulCQN2i8vhgM45yjxIg==
X-Received: by 2002:a05:6000:2584:b0:3ee:3dce:f672 with SMTP id ffacd0b85a97d-429b4c73515mr449295f8f.4.1761761381534;
        Wed, 29 Oct 2025 11:09:41 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:dfe:468f:744f:5a8a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7ce1sm26979595f8f.0.2025.10.29.11.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:09:41 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH bpf-next v2] docs/bpf: Add missing BPF k/uprobe program types to docs
Date: Wed, 29 Oct 2025 18:09:32 +0000
Message-ID: <20251029180932.98038-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the table of program types in the libbpf docs with the missing
k/uprobe multi and session program types.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

---
Changes in v2:
- Document the correct attach types for kprobe.session, uprobe.multi and
  uprobe.session, thanks Jiri Olsa
---
 Documentation/bpf/libbpf/program_types.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index 218b020a2f81..3b837522834b 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -100,10 +100,26 @@ described in more detail in the footnotes.
 |                                           |                                        | ``uretprobe.s+`` [#uprobe]_      | Yes       |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``usdt+`` [#usdt]_               |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``usdt.s+`` [#usdt]_             | Yes       |
 +                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_TRACE_KPROBE_MULTI``             | ``kprobe.multi+`` [#kpmulti]_    |           |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``kretprobe.multi+`` [#kpmulti]_ |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_KPROBE_SESSION``           | ``kprobe.session+`` [#kpmulti]_  |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_UPROBE_MULTI``             | ``uprobe.multi+`` [#upmul]_      |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uprobe.multi.s+`` [#upmul]_    | Yes       |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uretprobe.multi+`` [#upmul]_   |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uretprobe.multi.s+`` [#upmul]_ | Yes       |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_UPROBE_SESSION``           | ``uprobe.session+`` [#upmul]_    |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uprobe.session.s+`` [#upmul]_  | Yes       |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_LIRC_MODE2``              | ``BPF_LIRC_MODE2``                     | ``lirc_mode2``                   |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
@@ -219,6 +235,8 @@ described in more detail in the footnotes.
              non-negative integer.
 .. [#ksyscall] The ``ksyscall`` attach format is ``ksyscall/<syscall>``.
 .. [#uprobe] The ``uprobe`` attach format is ``uprobe[.s]/<path>:<function>[+<offset>]``.
+.. [#upmul] The ``uprobe.multi`` attach format is ``uprobe.multi[.s]/<path>:<function-pattern>``
+            where ``function-pattern`` supports ``*`` and ``?`` wildcards.
 .. [#usdt] The ``usdt`` attach format is ``usdt/<path>:<provider>:<name>``.
 .. [#kpmulti] The ``kprobe.multi`` attach format is ``kprobe.multi/<pattern>`` where ``pattern``
               supports ``*`` and ``?`` wildcards. Valid characters for pattern are
-- 
2.51.1


