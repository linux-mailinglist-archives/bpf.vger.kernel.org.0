Return-Path: <bpf+bounces-39945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB70F9797D0
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 18:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B206D281EBE
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DCB1C985F;
	Sun, 15 Sep 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QfDlyRZl"
X-Original-To: bpf@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BF18B04
	for <bpf@vger.kernel.org>; Sun, 15 Sep 2024 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726417334; cv=none; b=HhzYcLExY5yi2jYyL+/cNxqqexLFrbhlhhF9ZcuBS/jLqUjuWPffZ62hFpkdbPwSOhYons2eBA+bfOQGKRdhny5Xr2/C4P+CeZpXcS6RcjD2cQwBdHcZvPW/Nm/Gu5v2kKwAkqtADQOumrxWAoYSEEeMVwHMGoi3lRAQceeYvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726417334; c=relaxed/simple;
	bh=iP5KDxcrGXOfBoGJGJ0pumZ3z5ExNyCE/KMQVZalkLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkU2dTHDL1OczrrnUykazEALaDpwA3jj0V03R8VAz97ywmrpnK07iBKyd3NmFpD0U8Z6/ZXl6BErIypDpUxB8vheslUzrURvVepLurR07eAYJDRE6VZcI3Woocbw7E7ck7uqdRb2bd9LPBXs6v8hmTrCskTAAGmkbMs7Z47VF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QfDlyRZl; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ps0hs0twFsBGNps0hsCwLZ; Sun, 15 Sep 2024 18:22:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726417324;
	bh=TkpQY2gkdM9Y4uSBD/xLgQaqvbdgPYywQWgtIu56p6w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QfDlyRZlRfeL1VuQOzwaFDgvuOr22XTTOBc2GzrHsNFsbdXmaAki92zGGU5D5IoQP
	 EdGH8u9i+4AphxszaSbzBjBRQuRpq6anu7Gb1eAZQrLb4Ibzj5BK2F3q+AaPDeJqIR
	 MjohFkRNSM1CYYiO9vl0nKWP3VCEoRjOJwC4lNCwjYRhDhSVkftodZo9mY1YhP1DhM
	 KMF7/Bu9GWnIUuI7vckG3ABNTRdo4wUY1WWfAebQuIQuLBYJXNfcaNyoKCXSB8gbkA
	 FKHqVbQ03Ytyx31bEmPEwvTfxNHNBOiaz2bgPOHwgW4YAUyrtP/4KvlGzDEQBbCfro
	 zPG6AcA4Yac+A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Sep 2024 18:22:04 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	bpf@vger.kernel.org
Subject: [PATCH] bpf: Constify struct btf_kind_operations
Date: Sun, 15 Sep 2024 18:21:54 +0200
Message-ID: <9192ab72b2e9c66aefd6520f359a20297186327f.1726417289.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct btf_kind_operations' are not modified in this driver.

Constifying this structures moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
 184320	   7091	    548	 191959	  2edd7	kernel/bpf/btf.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
 184896	   6515	    548	 191959	  2edd7	kernel/bpf/btf.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 kernel/bpf/btf.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d2f87db9131e..432eda0f6550 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2808,7 +2808,7 @@ static void btf_ref_type_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "type_id=%u", t->type);
 }
 
-static struct btf_kind_operations modifier_ops = {
+static const struct btf_kind_operations modifier_ops = {
 	.check_meta = btf_ref_type_check_meta,
 	.resolve = btf_modifier_resolve,
 	.check_member = btf_modifier_check_member,
@@ -2817,7 +2817,7 @@ static struct btf_kind_operations modifier_ops = {
 	.show = btf_modifier_show,
 };
 
-static struct btf_kind_operations ptr_ops = {
+static const struct btf_kind_operations ptr_ops = {
 	.check_meta = btf_ref_type_check_meta,
 	.resolve = btf_ptr_resolve,
 	.check_member = btf_ptr_check_member,
@@ -2858,7 +2858,7 @@ static void btf_fwd_type_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "%s", btf_type_kflag(t) ? "union" : "struct");
 }
 
-static struct btf_kind_operations fwd_ops = {
+static const struct btf_kind_operations fwd_ops = {
 	.check_meta = btf_fwd_check_meta,
 	.resolve = btf_df_resolve,
 	.check_member = btf_df_check_member,
@@ -3109,7 +3109,7 @@ static void btf_array_show(const struct btf *btf, const struct btf_type *t,
 	__btf_array_show(btf, t, type_id, data, bits_offset, show);
 }
 
-static struct btf_kind_operations array_ops = {
+static const struct btf_kind_operations array_ops = {
 	.check_meta = btf_array_check_meta,
 	.resolve = btf_array_resolve,
 	.check_member = btf_array_check_member,
@@ -4185,7 +4185,7 @@ static void btf_struct_show(const struct btf *btf, const struct btf_type *t,
 	__btf_struct_show(btf, t, type_id, data, bits_offset, show);
 }
 
-static struct btf_kind_operations struct_ops = {
+static const struct btf_kind_operations struct_ops = {
 	.check_meta = btf_struct_check_meta,
 	.resolve = btf_struct_resolve,
 	.check_member = btf_struct_check_member,
@@ -4353,7 +4353,7 @@ static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
 	btf_show_end_type(show);
 }
 
-static struct btf_kind_operations enum_ops = {
+static const struct btf_kind_operations enum_ops = {
 	.check_meta = btf_enum_check_meta,
 	.resolve = btf_df_resolve,
 	.check_member = btf_enum_check_member,
@@ -4456,7 +4456,7 @@ static void btf_enum64_show(const struct btf *btf, const struct btf_type *t,
 	btf_show_end_type(show);
 }
 
-static struct btf_kind_operations enum64_ops = {
+static const struct btf_kind_operations enum64_ops = {
 	.check_meta = btf_enum64_check_meta,
 	.resolve = btf_df_resolve,
 	.check_member = btf_enum_check_member,
@@ -4534,7 +4534,7 @@ static void btf_func_proto_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, ")");
 }
 
-static struct btf_kind_operations func_proto_ops = {
+static const struct btf_kind_operations func_proto_ops = {
 	.check_meta = btf_func_proto_check_meta,
 	.resolve = btf_df_resolve,
 	/*
@@ -4592,7 +4592,7 @@ static int btf_func_resolve(struct btf_verifier_env *env,
 	return 0;
 }
 
-static struct btf_kind_operations func_ops = {
+static const struct btf_kind_operations func_ops = {
 	.check_meta = btf_func_check_meta,
 	.resolve = btf_func_resolve,
 	.check_member = btf_df_check_member,
-- 
2.46.0


