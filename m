Return-Path: <bpf+bounces-72618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6432C167A7
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 520AF5024EB
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED934F480;
	Tue, 28 Oct 2025 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6jlEv25"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5FF33031F
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676117; cv=none; b=pZYQi7DnZC4NFWMvLISh+yT9KCSYcNkBwk1XkwZPoAEnUQWzuWbChAkWxQwS/KiCOzvN6MiRfCEh4j3NBLLJE7CxbCcSWv/6f+MfCU0hT7VOfdkLWyJbva1k5l2qYB4QaWdlcucx3jYFHM7Rw8wg4+mUUX9byo+qk1OUylN1rs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676117; c=relaxed/simple;
	bh=2dAa4RMKmWD/bUrT5o5cw61/7b2o4SLA35npbfQLoj4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PPnbrdyffRg2KjEtahwcoKjZn/nAc7ZVk9QhchCUQ9wnVm/eEMPbIagOC2diBb/HgDGq2h2VHrYOJw1PncNdipPbXqOEMstm0KAkact3fDKwBfILykzwzAYKNkQCLEcgYVhR0+pHlCu7Qqx4ixtLSf0m/Lry2Xs6+JrqQiF6s34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6jlEv25; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47114a40161so71132215e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761676114; x=1762280914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=molTA5hkZyuDOYaFb92vgkuv4wnED9t/TDjtQWCsg9w=;
        b=R6jlEv25uFhxC8Nzm000XFMtdrGDhWMZx0U7uGx8Ue1P7xiRh6SbA/bVjLWTgu5X2N
         86N5U3YLpNoScayGg8qOvjceI0aM9JK4H+Bbp3c3wUkxAM1cVyjPVezhpby170q0BJXv
         OGEW33gEjI9vJIInM1thp2lGjpF8SVsR2TPyG+ag68EFrrW42gVCAFyOXVvoT08XVJ18
         bpe64XzdLCKbC8susKVBc7vjg3pE6viNYdC/hkTgjj6n0IynC1rvhL7zBdja0uHi6+pE
         JALPRKlT3zrthvfjj6NtFznA2okldQTIRWN8HoLl7UgOHQOz7QSJ8xHXvuz/4bMdhCqu
         IG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676114; x=1762280914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=molTA5hkZyuDOYaFb92vgkuv4wnED9t/TDjtQWCsg9w=;
        b=keqjqIIPA2mIhx3jgt1jMhHt/sRAUl1u4V6nPo2Ue3bLhWH//y6veNVl6UP1S1yRQu
         kWe8+Rqa2Z4t9CMP905z1djL0cx5FWFBi4qRwCU8Ex7nhkABjAYOMa94E5mOYCrQnmTM
         I8kW5g2HKCt2OfY1nXx/nhEyDymaBrDCPdwFIE0wFDaglcXbVCKFeKAv35Y09kJaqDZL
         gxyc1IxTsfZNvIOnsj7dhjx6GdUqTyqswcrPb/5uCB/xn6RP0NcjUGcrh2xLwUfjazYN
         wV9SBSG7vbCKLFJNBtECmXNcEkG3ClcN2BOWsEZXJbI92+K6oiMM79KLAIKEqOCaqGZz
         qFkg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Re8JRCYVSQWJnWcbBXkpI368OQh92XfMEu6la4v3Sq3r+2lxmfgiMabO9c5PQn0qFmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0g/Cz5Mg10ijwSChPgbCNZfDSJiVr7D1tgBanL7Z8IDpAtvf
	pO1LMXd5cBSwKdrUu/5h5hfMl4TkF+scGzj8ofB6BOlvILjZP+wLhtIR
X-Gm-Gg: ASbGncvLpk7DHd4qh0PS/ZYJpNTK1LQKOwMbSh1at+eIJzisB78uwYPw4E9Ufnzy3B0
	ckTnOS2I0pDhtUIiiN9G+Mi1xzCLkm3QZOzDH1EGi7ZFbCeFd4Hj+vLFdlRs5sHzpSfzxefQeBJ
	OSNwnL+wR6hXNJTZ1NG+k8HQDEjMI5pKjgLOXUQZmh2Mc9by6qYeLsinvXPa5/wIXkwyvRzhaUn
	PvKVxBxXjq87XDNHsQRFlLFXh8M/whQbr+pFQsxyFcHtWTbs1vV+WHHpM99rJM4UOTwEso8PIFi
	oEYIFFj5vt5kPAjnD+qMHJS+zfd2I/F6UQJWpTx2HhO5jGLGzTiRkWYCJ6gMeR6FuQ+KF5J2kHl
	NsKvVMWRlU4Rtyws8HlYEG+QBgpZEgAsn7cU8Z+niEPvXgmgUDfYtoIJOoffZdK8D8hWa90KfQR
	Nlu6qNoNKfJHm+hczF8w==
X-Google-Smtp-Source: AGHT+IHaMqZuas9WygehcwbfPiTeO5dpQVV/GnKrQNSaR3dSV5zdTBhceIjR5i7m5iWNLyC2LmN9tg==
X-Received: by 2002:a05:600c:4708:b0:475:d8c8:6894 with SMTP id 5b1f17b1804b1-4771e34a956mr3820075e9.9.1761676113806;
        Tue, 28 Oct 2025 11:28:33 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:a938:2bbc:5022:a559])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b7ca2sm5110355e9.14.2025.10.28.11.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:28:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v1] docs/bpf: Add missing BPF k/uprobe program types to docs
Date: Tue, 28 Oct 2025 18:28:18 +0000
Message-ID: <20251028182818.78640-1-donald.hunter@gmail.com>
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
 Documentation/bpf/libbpf/program_types.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index 218b020a2f81..5e7a202dce5e 100644
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
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``kprobe.session+`` [#kpmulti]_  |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uprobe.multi+`` [#upmul]_      |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uprobe.multi.s+`` [#upmul]_    | Yes       |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uretprobe.multi+`` [#upmul]_   |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uretprobe.multi.s+`` [#upmul]_ | Yes       |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uprobe.session+`` [#upmul]_    |           |
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


