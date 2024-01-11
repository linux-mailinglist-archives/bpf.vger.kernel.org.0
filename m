Return-Path: <bpf+bounces-19359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9782A73C
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 06:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB381C2331A
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 05:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A120F8;
	Thu, 11 Jan 2024 05:21:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747B1FB0
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 354882C8779FB; Wed, 10 Jan 2024 21:21:36 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] docs/bpf: Fix an incorrect statement in verifier.rst
Date: Wed, 10 Jan 2024 21:21:36 -0800
Message-Id: <20240111052136.3440417-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In verifier.rst, I found an incorrect statement (maybe a typo) in section
'Liveness marks tracking'. Basically, the wrong register is attributed
to have a read mark. This may confuse the user.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 Documentation/bpf/verifier.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.=
rst
index f0ec19db301c..356894399fbf 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -562,7 +562,7 @@ works::
   * ``checkpoint[0].r1`` is marked as read;
=20
 * At instruction #5 exit is reached and ``checkpoint[0]`` can now be pro=
cessed
-  by ``clean_live_states()``. After this processing ``checkpoint[0].r0``=
 has a
+  by ``clean_live_states()``. After this processing ``checkpoint[0].r1``=
 has a
   read mark and all other registers and stack slots are marked as ``NOT_=
INIT``
   or ``STACK_INVALID``
=20
--=20
2.34.1


