Return-Path: <bpf+bounces-14173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04F7E0C1F
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6E5281BDD
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7C2628B;
	Fri,  3 Nov 2023 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQJTODVB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9BB25112
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 23:22:14 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FCB7
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:22:13 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-586a5d76413so1363707eaf.3
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053732; x=1699658532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrSMHJTFN4VS+bJTktR0aBlANVua2h1i4VPb1Ipn4eE=;
        b=dQJTODVBUExFzxJ6sHnBwPlxTi6sdWVBhsDNwsq9eA1yKNywYax4+1co5ks/+gGQb+
         yAatxXKpnOoZctpCJXbmzxl7KOiNBSwmatYQxc4jImmMbWWDffp5g44eYsk+qbJw9Hbs
         BBqDgVqRjrqkg5ywX37R2FQ+eAaPWDYU7CP9vM78c/ypqgjTig7I9gLP7myjIxS1/iMX
         aJ6NVyDcYR/iDZKL5VJG+nwUl3UkspD2Wg7+U2U3uySTrrF+GQWJncj6hBrEbN3RFGdb
         rCBIdqJ3kaxfMe5Cjuazg0OL/0yKqtktDHJBsPCd5noXLVGFXuZRPJ4U4+WyORLJDwOM
         5Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053732; x=1699658532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrSMHJTFN4VS+bJTktR0aBlANVua2h1i4VPb1Ipn4eE=;
        b=Kx3MVna2zXAnL3HuCJlHfegARLb0T6mktN+YmXWRsjFYj/qeG7BgCll8AUjRBsrWPo
         CfsqExlQThKKp8/L+v8JQRXhWix7VnVL4ziwR2PPrG5JXdLaRbS4Mh6pRrcK2+ktyAPV
         5fJrc7COHoDyQoWP8kbbl4ueKZmnKMbFv0rJSYfhLsfd/W3UXHRtcjx6FMLT9Ba04HH1
         0X/Iij9uVnoaU0rNUG165bQ2NmQDP74ndGzQhs1YvCZ6w1EwrE3g2Ie0KqEyV/ZlIitK
         cZTd470IIATRggqX5IP7mjfHRtGHjCA6VAwg7GjusgstzZoPIoKOz3HX4rzxJir1LPF4
         Gnkg==
X-Gm-Message-State: AOJu0Yw1xxI64xCHqBm5ZTH+UQoY1hGEaOC2ST0cJgNzy3e1LjgaNLNX
	qALakW1W0nsHzoohnNx1IPrNU3+IIeY=
X-Google-Smtp-Source: AGHT+IHh8m5N2JJ0xmhx0XmzrO10mXUbkMDRbqCQ/VOXAa9Qv5ixihoViwkZbQ/lnSR1qTh5xTbTCw==
X-Received: by 2002:a05:6820:1a08:b0:56c:d297:164c with SMTP id bq8-20020a0568201a0800b0056cd297164cmr26666754oob.4.1699053732179;
        Fri, 03 Nov 2023 16:22:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:287:9d8c:4ad:9459])
        by smtp.gmail.com with ESMTPSA id 186-20020a4a14c3000000b0057b8baf00bbsm532288ood.22.2023.11.03.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:22:11 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v10 02/13] bpf: get type information with BPF_ID_LIST
Date: Fri,  3 Nov 2023 16:21:51 -0700
Message-Id: <20231103232202.3664407-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103232202.3664407-1-thinker.li@gmail.com>
References: <20231103232202.3664407-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Get ready to remove bpf_struct_ops_init() in the future. By using
BPF_ID_LIST, it is possible to gather type information while building
instead of runtime.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 627cf1ea840a..4ca4ca4998e0 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -108,7 +108,12 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 #endif
 };
 
-static const struct btf_type *module_type;
+BTF_ID_LIST(st_ops_ids)
+BTF_ID(struct, module)
+
+enum {
+	IDX_MODULE_ID,
+};
 
 static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 				    struct btf *btf,
@@ -197,7 +202,6 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops;
-	s32 module_id;
 	u32 i;
 
 	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
@@ -205,13 +209,6 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 #include "bpf_struct_ops_types.h"
 #undef BPF_STRUCT_OPS_TYPE
 
-	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
-	if (module_id < 0) {
-		pr_warn("Cannot find struct module in btf_vmlinux\n");
-		return;
-	}
-	module_type = btf_type_by_id(btf, module_id);
-
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
 		st_ops = bpf_struct_ops[i];
 		bpf_struct_ops_init_one(st_ops, btf, log);
@@ -381,6 +378,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	const struct bpf_struct_ops *st_ops = st_map->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
+	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
 	struct bpf_tramp_links *tlinks;
@@ -428,6 +426,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	image = st_map->image;
 	image_end = st_map->image + PAGE_SIZE;
 
+	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
-- 
2.34.1


