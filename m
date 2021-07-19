Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318C03CE9A0
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 19:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbhGSQ6U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 12:58:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53819 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346639AbhGSQ4H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Jul 2021 12:56:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4906F5C0056;
        Mon, 19 Jul 2021 13:36:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 19 Jul 2021 13:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FFfCVZVrwpemUdxqqYH0VyK4IO4CmiuPK9o5/d0I1mw=; b=Ucrs+TJ6
        E9ikhlfwzuYr1BVxGPKk321tkHgbFih6il7kajSxZMdT+HSOP/yKL+EeVu0scRI+
        rufX++v9Ar4jLok9WLfJj2KPrSQIAw5WCrT/dbmnRMb5LsDnhsAFgeWL5Hpg88DB
        qwqH0ikMRdSICJjbUiqYb1KpY94nVMNsKcU9reCOoOUaAb16GsjehR5+9PHTLUBt
        Ror6rGQwbiuAqkjkq1wiXTCrdpFmkOUXlynm0qhJCz4YUfHPBOYcJL0giYQWteDe
        l+uE9QPyNmRpBF9cy0s6cGMM3N/KB09+Hf9oohP17+niaBCsPIjg0RkUhRUEaYV6
        +CatE13pDzmMkw==
X-ME-Sender: <xms:Lrj1YMmcoeyI0eKo_1fxJR-mSOE1xvVL3Nt4keo2mCfwRW2hI_X8LA>
    <xme:Lrj1YL1z7hLDErFAfCcNf5AwoM-za7-H0xUY4G96eeaPETSp9xCGPMdSQXEHKsYiM
    wGKK-zPEvLeOrxr30M>
X-ME-Received: <xmr:Lrj1YKptH9vMRKTrE4CwYD-vSiVAXga7ymSgvGtUNi8GoSTNncFGo2tQSoIK9kCdFu2mww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghm
    sggurgdrlhhtqeenucggtffrrghtthgvrhhnpedtffffgeffjeeiheeuvdfhkeejvefhie
    dufeekffekueeuhfelvdetjeeiteduvdenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:Lrj1YInZg1I-SyTU6XMwQ3DERzfgtV1badB3joaaDvqy8U3GLIi8LA>
    <xmx:Lrj1YK15JCys37Hfgr5CZlAO36A0zyp1SAwIuaIcRdmvOXRbPd9pOA>
    <xmx:Lrj1YPvYO0M_nn8PnZrbm5mOWWg1lpa9NQaMnLlRYI_yJUe_RVpl7A>
    <xmx:Lrj1YIAvEh6ybOeMCcL0LkQSJt88LoHBqywzYUp_xbG1UKIYOgN4BQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jul 2021 13:36:44 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH bpf 1/2] libbpf: fix removal of inner map in bpf_object__create_map
Date:   Mon, 19 Jul 2021 19:38:37 +0200
Message-Id: <20210719173838.423148-2-m@lambda.lt>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719173838.423148-1-m@lambda.lt>
References: <20210719173838.423148-1-m@lambda.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If creating an outer map of a BTF-defined map-in-map fails (via
bpf_object__create_map()), then the previously created its inner map
won't be destroyed.

Fix this by ensuring that the destroy routines are not bypassed in the
case of a failure.

Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 tools/lib/bpf/libbpf.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6f5e2757bb3c..dde521366579 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4479,6 +4479,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 {
 	struct bpf_create_map_attr create_attr;
 	struct bpf_map_def *def = &map->def;
+	int err = 0;
 
 	memset(&create_attr, 0, sizeof(create_attr));
 
@@ -4521,8 +4522,6 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
 	if (bpf_map_type__is_map_in_map(def->type)) {
 		if (map->inner_map) {
-			int err;
-
 			err = bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
 				pr_warn("map '%s': failed to create inner map: %d\n",
@@ -4547,7 +4546,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	if (map->fd < 0 && (create_attr.btf_key_type_id ||
 			    create_attr.btf_value_type_id)) {
 		char *cp, errmsg[STRERR_BUFSIZE];
-		int err = -errno;
+		err = -errno;
 
 		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 		pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
@@ -4560,8 +4559,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		map->fd = bpf_create_map_xattr(&create_attr);
 	}
 
-	if (map->fd < 0)
-		return -errno;
+	err = map->fd < 0 ? -errno : 0;
 
 	if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
 		if (obj->gen_loader)
@@ -4570,7 +4568,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		zfree(&map->inner_map);
 	}
 
-	return 0;
+	return err;
 }
 
 static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
-- 
2.32.0

