Return-Path: <bpf+bounces-28744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23908BD870
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DD31F22AAA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB6A59;
	Tue,  7 May 2024 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi/D79YA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00731653
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040836; cv=none; b=otKVEc0OEVzcPVCG0tjHZboDzARJxWtcSlQzFvUt5IcIYMOuJajvJ3E0HEbqnd1UP/p0AF7wXnTRn6678w814Co5cu4J7M4HSql2kJ1B6rD1XmbECDQ8dGxyyDYVEXj93rCnoub16rhMUh8Q8/KIPP8I5SaJR11ikel9FxgKN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040836; c=relaxed/simple;
	bh=Qfo7/DmAqnVQb+lryVOFU9WxqfPwY+i4xDZT3A3xM6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmpBXcyDvoD0I8fJTn4X0IcQTpCswyDlip6shNPGhBA2NU1zCuQ1NhIMUmXZvhXpOIv1gHQ1IMz53ERcBQMV6m4AUbPMWEG5Z8Hpl7yED28xv9rtlMOU+iI1z9YiFqOlU4wO5LYu0YG8ec19Wn1WPEBR4sDsf43dzQpN6tXZrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi/D79YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C50C116B1;
	Tue,  7 May 2024 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040835;
	bh=Qfo7/DmAqnVQb+lryVOFU9WxqfPwY+i4xDZT3A3xM6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xi/D79YAthcC8LIfkI5LlAh14Zz3ppm85Ia8+cBxeIjhBbCDhN5wNbGrH1C/ywz9E
	 5ZbrP7Q8Arlx1CRVBZKUOQgEKhJrAH3eEiu6tz6vJP0ita1p6uf6X9wlqD8ODEB3u1
	 k9lwelQ7Or9BuPFB3/TmbtdwZM7rLAKRWVe1DF/Od7yj03Q3F2NQ3UOcnxvDcRIuja
	 ROj1/7f6mv4GYYXgCZ07pU4JEgx5Lamv9kvA5ba63xV640H3U93p00QRsHLDIX9Maf
	 NT/zb/pSTa7AVN1gzW+kEaGj9wCqOM5OVAChU88Sr3b5TwVS3mB2fuViYcMqj0MjK6
	 bOxLHjk5YQNHg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 5/7] libbpf: improve early detection of doomed-to-fail BPF program loading
Date: Mon,  6 May 2024 17:13:33 -0700
Message-ID: <20240507001335.1445325-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507001335.1445325-1-andrii@kernel.org>
References: <20240507001335.1445325-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend libbpf's pre-load checks for BPF programs, detecting more typical
conditions that are destinated to cause BPF program failure. This is an
opportunity to provide more helpful and actionable error message to
users, instead of potentially very confusing BPF verifier log and/or
error.

In this case, we detect struct_ops BPF program that was not referenced
anywhere, but still attempted to be loaded (according to libbpf logic).
Suggest that the program might need to be used in some struct_ops
variable. User will get a message of the following kind:

  libbpf: prog 'test_1_forgotten': SEC("struct_ops") program isn't referenced anywhere, did you forget to use it?

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 04de4fb81785..5401f2df463d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7372,7 +7372,11 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	__u32 log_level = prog->log_level;
 	int ret, err;
 
-	if (prog->type == BPF_PROG_TYPE_UNSPEC) {
+	/* Be more helpful by rejecting programs that can't be validated early
+	 * with more meaningful and actionable error message.
+	 */
+	switch (prog->type) {
+	case BPF_PROG_TYPE_UNSPEC:
 		/*
 		 * The program type must be set.  Most likely we couldn't find a proper
 		 * section definition at load time, and thus we didn't infer the type.
@@ -7380,6 +7384,15 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		pr_warn("prog '%s': missing BPF prog type, check ELF section name '%s'\n",
 			prog->name, prog->sec_name);
 		return -EINVAL;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		if (prog->attach_btf_id == 0) {
+			pr_warn("prog '%s': SEC(\"struct_ops\") program isn't referenced anywhere, did you forget to use it?\n",
+				prog->name);
+			return -EINVAL;
+		}
+		break;
+	default:
+		break;
 	}
 
 	if (!insns || !insns_cnt)
-- 
2.43.0


