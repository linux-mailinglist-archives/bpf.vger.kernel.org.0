Return-Path: <bpf+bounces-51356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED122A33727
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749BF3A7ED8
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277352063F0;
	Thu, 13 Feb 2025 05:04:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C523BE
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739423082; cv=none; b=fomeHFF7gehqkQrCFATBu62m1+P6aYFEwJsM0w1f0wXlNfvRb5b1qVs5mm+A+nd3ojaq6YJLZS0LmOU+OKLgTEmbNyvC2u9GDv9E7aRqnQAvyQL7cmZAV7RXNIG+I/TvmwCOjRp1P1DsoT6iXacfWWEObHzHAb6Mv4trJYQ//oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739423082; c=relaxed/simple;
	bh=xs20+M76eEarQIogKTjdUuanHIn5oTFO05RERLU6mME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOSJbJSQjFOD8uU3pk6xYspMUF+wHBvAflRwyTLBzFAehiT3fBDszgFNH9J4+2LvxbQcoVs9TTfNbSORvQdnsaSRz4vGDJRiTKVSld6Pr/YTo8pjKHE5cYgsOs/EDZZBd0yekBGz8kcIZVAbX85xvpfEY0y9ujjKuuEBKLHD1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 599077DD101; Wed, 12 Feb 2025 21:04:27 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Sync uapi bpf.h header for the tooling infra
Date: Wed, 12 Feb 2025 21:04:27 -0800
Message-ID: <20250213050427.2788837-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 0abff462d802 ("bpf: Add comment about helper freeze") missed the
tooling header sync. Fix it.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/include/uapi/linux/bpf.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 2acf9b336371..fff6cdb8d11a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6019,7 +6019,10 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
-	/* */
+	/* This helper list is effectively frozen. If you are trying to	\
+	 * add a new helper, you should add a kfunc instead which has	\
+	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
+	 */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
  * know or care about integer value that is now passed as second argumen=
t
--=20
2.43.5


