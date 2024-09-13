Return-Path: <bpf+bounces-39784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 313339775FB
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 02:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2819B232B4
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 00:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447C10E3;
	Fri, 13 Sep 2024 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EUcVWq7J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B17E6
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726186751; cv=none; b=kxqaBKusehHbgZ7zzCteJnRjuy9XnhIuhXHj1drRKWxUcxfoPyar5xgW6z4rSdMV4oSGkV4ZJ8ErfdRUQEVHRYqFj+zOwfFrzJdfOm30tweftTY9cHHa5fl1lzKT1bNEHHMLEuvD3ij/3dIaVWzwFJ+C1VtppacERA3W3ir4E5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726186751; c=relaxed/simple;
	bh=C4jA1h7wuOR+3LJkBGT/J7Oq6MJTOyJEBQU3FMGekDM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dH3KmScYYu2AqVa1Vr+nftfZevOiIogYijKtZsrunYMwTIdOBWLwGl25bzh8jT1vENzkWqBjy2ijX/dDcvy114u4lAUTZcWzUufdah8fdW8ShrB7UuwrKwPJFDDcjQqD//wVHLSHGfFabceKkIaMeWcPosdH+McRW/w/TGETbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EUcVWq7J; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726186747; x=1726445947;
	bh=ojicEVzTtZCVcMKd8X6DQKr9PmRn79q/0YsnmvRznL0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EUcVWq7JdLfZN2rNSKE0L2WLZqvSyzaGcJXPChh3DuYRXwfz6tZoijdwSL+YYyqoU
	 T0ISBJlw+oKLSXfmSo24qzoKbTgaNSx+zcjvBu84VJIz1vOmc58dNxA7jC53suxrUH
	 1UeZBGVXUFO3an+0PagNZKMp0cl5fPE5Mcsar7UeF90w5nXZukjMcytK4XxOf6/KAJ
	 1cZ6QOmqLQgcSsJb2SIkTheXpRiJs36IVre0HUcp8tyP15meLhjIyhvwoHerctxYDm
	 JYPMS6go+5wm+IAa2IPdEo9IQR6sAxDDVWbjbY2WFksX9f4NNvvKcr6o9BmovlORGV
	 xVf16NHfck3/w==
Date: Fri, 13 Sep 2024 00:19:02 +0000
To: bpf@vger.kernel.org, andrii@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH bpf-next v2] libbpf: add bpf_object__token_fd accessor
Message-ID: <20240913001858.3345583-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d1b00b467f0e2ffc21cf5a1e681a7b37fdbf7ff8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a LIBBPF_API function to retrieve the token_fd from a bpf_object.

Without this accessor, if user needs a token FD they have to get it
manually via bpf_token_create, even though a token might have been
already created by bpf_object__load.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/lib/bpf/libbpf.c   | 5 +++++
 tools/lib/bpf/libbpf.h   | 8 ++++++++
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 14 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 84d4ec0e1f60..219facd0e66e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9059,6 +9059,11 @@ unsigned int bpf_object__kversion(const struct bpf_o=
bject *obj)
 =09return obj ? obj->kern_version : 0;
 }
=20
+int bpf_object__token_fd(const struct bpf_object *obj)
+{
+=09return obj->token_fd ?: -1;
+}
+
 struct btf *bpf_object__btf(const struct bpf_object *obj)
 {
 =09return obj ? obj->btf : NULL;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6917653ef9fa..eaf1021b08ea 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -294,6 +294,14 @@ LIBBPF_API const char *bpf_object__name(const struct b=
pf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj)=
;
 LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern=
_version);
=20
+/**
+ * @brief **bpf_object__token_fd** is an accessor to token FD that is
+ * created on **bpf_object__load()**
+ * @param obj Pointer to a valid BPF object
+ * @return Token FD or -1 if it wasn't set
+ */
+LIBBPF_API int bpf_object__token_fd(const struct bpf_object *obj);
+
 struct btf;
 LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
 LIBBPF_API int bpf_object__btf_fd(const struct bpf_object *obj);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8f0d9ea3b1b4..0096e483f7eb 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -423,6 +423,7 @@ LIBBPF_1.5.0 {
 =09=09btf__relocate;
 =09=09bpf_map__autoattach;
 =09=09bpf_map__set_autoattach;
+=09=09bpf_object__token_fd;
 =09=09bpf_program__attach_sockmap;
 =09=09ring__consume_n;
 =09=09ring_buffer__consume_n;
--=20
2.34.1



