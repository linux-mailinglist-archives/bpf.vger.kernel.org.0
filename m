Return-Path: <bpf+bounces-39772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD969773C9
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 23:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63581F24C49
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF771C2312;
	Thu, 12 Sep 2024 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Yq99cS9w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2BA5F
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177749; cv=none; b=QeGMsQAJ/TFJwupoF+uUPZ+qcy1via++9fM01ETUoe2XF4YBafun+SUt+T5CydofrzwOEz6Jrz1I49/tpmnOnE54yAr68g6JzoRlgeqLgX77sqvpM3gVtHzYmzshwRdKTEgAT37eYMrNy3xdCq8IMwdyIVyd9G943MAoOPB6vkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177749; c=relaxed/simple;
	bh=qayd9Jzrx3FblkVqzTe5R0bZ1b5w2tkz3itaIUpr1Hs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BczYjCheA0LAm1tUUz+uONYs7qG5BLCJ0m62h5X/TrhVZ0a6zj1idRpK9dbio3Y0O1GyCw6dtz4IrgKEhsUJ7mNntWsUgRCiWn1NzjEGe09RzoBGLBuIspUkuXGT8U1KrCznP6ycNv/VkbMGYONGySb5ZpsfScpGu30cIdolh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Yq99cS9w; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726177739; x=1726436939;
	bh=QgbCGsDoNw8Ffoae4RzOqJXJMZjnjerEeYJVIxdKZLk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Yq99cS9wSuGbiUKZkaHMsSupGVef0wok4+ZD7sO11e1DwNX/xXdRbMKWQd2A4OZg9
	 i3tAQlyHm1t4h96tS8M82v9V2xKXFWrzKEeALTGaqmKYXIU24lTrxz8msheYkJOZ4U
	 DibEzdvIdcxvlxMe8SP9DNqco8AH7dBsXu0D5+Vk3woMdWJ05CGGyOg5S2FtTPYf6p
	 rY3zRrX2zE5zmBc6F5a5F3j842kHaB3km362UYMkXMkfYnBiHF3DO16xUXG805lhBI
	 oaf/rd4PKa94uHhXM0mQvVQJa4ZivxVqOH6WkS1ADFZG2AUkcwdMlw9RKP9pC70/Gy
	 1kO/QmaX/ofhA==
Date: Thu, 12 Sep 2024 21:48:52 +0000
To: bpf@vger.kernel.org, andrii@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH bpf-next] libbpf: add bpf_object__token_fd accessor
Message-ID: <20240912214849.3102215-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: e0bf4356cfc1d7710ea2ed494326b368118c69b9
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
already created by bpf_object_load.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/lib/bpf/libbpf.c   | 5 +++++
 tools/lib/bpf/libbpf.h   | 2 ++
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 84d4ec0e1f60..e9ac950ce2ff 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9059,6 +9059,11 @@ unsigned int bpf_object__kversion(const struct bpf_o=
bject *obj)
 =09return obj ? obj->kern_version : 0;
 }
=20
+int bpf_object__token_fd(const struct bpf_object *obj)
+{
+=09return obj ? obj->token_fd : -1;
+}
+
 struct btf *bpf_object__btf(const struct bpf_object *obj)
 {
 =09return obj ? obj->btf : NULL;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6917653ef9fa..5cd143e83f95 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -294,6 +294,8 @@ LIBBPF_API const char *bpf_object__name(const struct bp=
f_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj)=
;
 LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern=
_version);
=20
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



