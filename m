Return-Path: <bpf+bounces-78985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 869F7D22671
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 06:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D023024895
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 05:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0781E2D0C79;
	Thu, 15 Jan 2026 05:00:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1984C81
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768453258; cv=none; b=ZSXPIvK60fbWUkLMoDE/d2P2cGRW45VKdnt86EbAmIbMVDzfufxc3l0dNapVWuUNHnb07X7GbF3og0KtTNsWs79DUnz2iqQswMH6jEW/jzvOSG3Q8fASzQ4LBzROxNMDNiDwzM9/0qbCWUeLvervfemefQ1IXPu9/STuQOSOaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768453258; c=relaxed/simple;
	bh=rrOrrMztUI0DdfKZwROdsT0+yPrLisUc4IJb6hGOwY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMWEUqjm3BjjExB0czjwenKbr4IG7o/cxKQi7oq/RZk4Gt6S0kab00X/pxLlyXFSzMq7kleRVqoj/SSpttCWZsfq2cwYc+TPxaCImZUIUN1GY7px4nOQzR523WVyI7cN+VWJXEzmpwrMzV0guLrv1S6E05CBoFreLNdztiXD/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5A5E518E8B05E; Wed, 14 Jan 2026 21:00:44 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves] bpf_encoder: Fix a verbose output issue
Date: Wed, 14 Jan 2026 21:00:44 -0800
Message-ID: <20260115050044.2220436-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For the following test.c:
  $ cat test.c
  unsigned tar(int a);
  __attribute__((noinline)) static int foo(int a, int b)
  {
    return tar(a) + tar(a + 1);
  }
  __attribute__((noinline)) int bar(int a)
  {
    foo(a, 1);
    return 0;
  }
The llvm compilation:
  $ clang -O2 -g -c test.c
And then
  $ pahole -JV test.o
  btf_encoder__new: 'test.o' doesn't have '.data..percpu' sectio  n
  File test.o:
  [1] INT unsigned int size=3D4 nr_bits=3D32 encoding=3D(none)
  [2] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  search cu 'test.c' for percpu global variables.
  [3] FUNC_PROTO (anon) return=3D2 args=3D(2 a, [4] FUNC bar type_id=3D3
  [5] FUNC_PROTO (anon) return=3D2 args=3D(2 a, 2 b, [6] FUNC foo type_id=
=3D5

The above confused format is due to btf_encoder__add_func_proto_for_state=
().
The "is_last =3D param_idx =3D=3D nr_params" is always false since param_=
idx
starts from 0. The below change fixed the issue:
  is_last =3D param_idx =3D=3D (nr_params - 1)

With the fix, 'pahole -JV test.o' will produce the following:
  ...
  [3] FUNC_PROTO (anon) return=3D2 args=3D(2 a)
  [4] FUNC bar type_id=3D3
  [5] FUNC_PROTO (anon) return=3D2 args=3D(2 a, 2 b)
  [6] FUNC foo type_id=3D5
  ...

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b37ee7f..09a5cda 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -895,7 +895,7 @@ static int32_t btf_encoder__add_func_proto_for_state(=
struct btf_encoder *encoder
 	for (param_idx =3D 0; param_idx < nr_params; param_idx++) {
 		p =3D &state->parms[param_idx];
 		name =3D btf__name_by_offset(btf, p->name_off);
-		is_last =3D param_idx =3D=3D nr_params;
+		is_last =3D param_idx =3D=3D (nr_params - 1);
=20
 		/* adding BTF data may result in a move of the
 		 * name string memory, so make a temporary copy.
--=20
2.47.3


