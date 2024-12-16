Return-Path: <bpf+bounces-47058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E528D9F3903
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21B91881A14
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04F136331;
	Mon, 16 Dec 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SXjqvfbQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBF8207DE7;
	Mon, 16 Dec 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373891; cv=none; b=CrHFnWF6mwU1um7z0iTOMoQNyko7e9GWBAU4IWGtOBSCZqNinL3ZJSMRKDqQxPA9BFDleUGSDqSmICZyZfVYezzlx3wYvdFuQnzTRHhtI2Qfl7+AyJU01oauaIhL4iHNYCKb94mfxRsFDz8fBK94y55G7sK54YEensS6kACLknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373891; c=relaxed/simple;
	bh=ocgx6N5FQHbVwN01L3hu3UtW7LD6q5pcrWJDa92LQxI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lPAECpnah4+NGiDvYSqDIIDMf/zWzcldv8D7EUYTM5EddMFCuoKpqqrPPUCqIldmjhclzm5DUDe2D8T+ERQxeBWM95SFNDhsiuAN4Bypf0Dim1zDdxukhdmHX6rd6/ayi1poamydn6hvvuWd8S2ggBYQsXnnno6bMnsBQlSoa8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SXjqvfbQ; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734373882; x=1734633082;
	bh=Y7eU+F4NcjjQfqNcws+V8CRu+gKSBvLjO14NLlwOwzo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=SXjqvfbQ6i/s3OBMaQLNyAvshAf21jGULvMz49bE63wxR89a747qeGeFpt+r9n4h5
	 y5h5W9p1B2IubVob+6V8vFZ8Npk5YTcQKcVY+O0M8SlOTpUhWFaA2/P85Qfk5n6dSr
	 TZBnwyRB7AWmUoap/z+vB+gJo0L5MJbmNSgxw+aJpCI8Z3nhA7McFIrzU4H+onKHIP
	 XMgQdBNW+URM2PJA4Prw5mJIwdSuo1eBWcPmvK4od1pGQo/tlEzh9t20UyL/eiCoMH
	 mOuXNeR8+BgePltN8GfnODGEcbruwS49Q9qT8FICb/8YWqjSE+6DiTPhC0NRkSjyf/
	 9S3ssDMjxB1yQ==
Date: Mon, 16 Dec 2024 18:31:15 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2] btf_encoder: fix memory access bugs
Message-ID: <20241216183112.206072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d40caae6cfa0abceb1a64bdf2b8c1be8d4f9bd7e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When compiled with address sanitizer, a couple of errors were reported
on pahole BTF encoding:
  * A memory leak of strdup(func->alias), due to unchecked
    reassignment.
  * A read of uninitialized memory in gobuffer__sort or bsearch in
    case btf_funcs gobuffer is empty.

Used compiler flags:
    -fsanitize=3Dundefined,address
    -fsanitize-recover=3Daddress
    -fno-omit-frame-pointer

v1: https://lore.kernel.org/dwarves/20241213233205.633927-1-ihor.solodrai@p=
m.me/

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 3754884..fbc9509 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1794,7 +1794,8 @@ static int btf_encoder__collect_btf_funcs(struct btf_=
encoder *encoder, struct go
 =09}
=20
 =09/* Now that we've collected funcs, sort them by name */
-=09gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
+=09if (gobuffer__nr_entries(funcs) > 0)
+=09=09gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
=20
 =09err =3D 0;
 out:
@@ -1954,6 +1955,11 @@ static int btf_encoder__tag_kfuncs(struct btf_encode=
r *encoder)
 =09=09goto out;
 =09}
=20
+=09if (gobuffer__nr_entries(&btf_funcs) =3D=3D 0) {
+=09=09err =3D 0;
+=09=09goto out;
+=09}
+
 =09/* First collect all kfunc set ranges.
 =09 *
 =09 * Note we choose not to sort these ranges and accept a linear
@@ -2607,7 +2613,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09=09=09=09       ", has optimized-out parameters" :
 =09=09=09=09=09=09       fn->proto.unexpected_reg ? ", has unexpected regi=
ster use by params" :
 =09=09=09=09=09=09       "");
-=09=09=09=09=09func->alias =3D strdup(name);
+=09=09=09=09=09if (!func->alias)
+=09=09=09=09=09=09func->alias =3D strdup(name);
 =09=09=09=09}
 =09=09=09}
 =09=09} else {
--=20
2.47.1



