Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D045B400EFD
	for <lists+bpf@lfdr.de>; Sun,  5 Sep 2021 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhIEKKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Sep 2021 06:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbhIEKKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Sep 2021 06:10:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7793C061575
        for <bpf@vger.kernel.org>; Sun,  5 Sep 2021 03:09:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u1so2184134plq.5
        for <bpf@vger.kernel.org>; Sun, 05 Sep 2021 03:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhmPc9CscbDpYTWunzyrAHEC/4hOr33nyYt4zFFItCE=;
        b=D5CBdGdIEgzkKXk0Rlg1QTYknkIPhjfuXqQgR6nnL3aHOdE+znC+QTCamZqWb4d3CV
         MnhlkHKOqH+TJbcimuhhRbQdwyKOAWJ2Fsqs5v9P0eK4eqiPduH2yGAd+AgP1+/a7RS8
         7hUnWsKb0X9AqF8qsFZnGoUJWa1xSJMZBDX40HWXxnmgEHFdLMnk5bbl0sGW+h2F+EJ+
         6QuHPr6Ua6xX1uSc4qLaed4QyEiJWJAyibOdFMxkoF8gPhE34e5iR/+muKvi7tqVLUcZ
         Kn7uwZQagSzqNXw8YfdLXOT9nJCyRxBjcUaosckf6quwmWzbbcIoTFhpVRGhef0lPqCs
         /eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhmPc9CscbDpYTWunzyrAHEC/4hOr33nyYt4zFFItCE=;
        b=UmxC5GxMcrQlhZ9jronbulyT5HkPZRE8W+c5iUrOf7h+UT3wuHZAYnbQwU9yWGGsfn
         TMsE/tVaxgb+WiTBXyHNeq8Oo5Tm+X9yFVZD0j3eUY7MkZBEPaeGHSRr/b34+WayIp5z
         nplw9vDJejTUF37VIeqngBI9+msRNsLGS2lfx4A766loZSOAPqFOWbp/8fW/bbx18hes
         ZlloTJ5Lr6XTc8XzYy4PXSBzfwFRIAq0palo37D8cYMBuiMNn0zI5ty7OpLYutYBPwV7
         Gyryen+nJxmELSsM9xZozUu8BxdizZ0UTzn65ORtcZmgWGQ6CGrAAUjkpyr23nuZkGDR
         9Rvw==
X-Gm-Message-State: AOAM532fyK2cnjsSPApdJ3RkvlXHNOdgRaa1lpQe7mc1Ak+K/9c/ag3N
        T/CvHvbQZ5GpZ/+Lx9t0jCnJj6W90YE=
X-Google-Smtp-Source: ABdhPJx+07dfKEXUT31BQNHcspS74kX/YTo18ubfVf/R31rD1RmSByDG//lPjl9ICGSddn4qDypOwQ==
X-Received: by 2002:a17:902:74c3:b0:132:45eb:6e9c with SMTP id f3-20020a17090274c300b0013245eb6e9cmr6252286plt.72.1630836558089;
        Sun, 05 Sep 2021 03:09:18 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id o6sm4443960pjk.4.2021.09.05.03.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 03:09:17 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] libbpf: Support uniform BTF-defined key/value specification across all BPF maps
Date:   Sun,  5 Sep 2021 18:09:13 +0800
Message-Id: <20210905100914.33007-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bunch of BPF maps do not support specifying types for key and value.
This is non-uniform and inconvenient[0]. Currently, libbpf uses a retry
logic which removes BTF type IDs when BPF map creation failed. Instead
of retrying, this commit recognizes those specialized map and removes
BTF type IDs when creating BPF map.

  [0] Closes: https://github.com/libbpf/libbpf/issues/355

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88d8825fc6f6..7068c4d07337 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4613,6 +4613,26 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 			create_attr.inner_map_fd = map->inner_map_fd;
 	}
 
+	if (def->type == BPF_MAP_TYPE_PERF_EVENT_ARRAY ||
+	    def->type == BPF_MAP_TYPE_STACK_TRACE ||
+	    def->type == BPF_MAP_TYPE_CGROUP_ARRAY ||
+	    def->type == BPF_MAP_TYPE_ARRAY_OF_MAPS ||
+	    def->type == BPF_MAP_TYPE_HASH_OF_MAPS ||
+	    def->type == BPF_MAP_TYPE_DEVMAP ||
+	    def->type == BPF_MAP_TYPE_SOCKMAP ||
+	    def->type == BPF_MAP_TYPE_CPUMAP ||
+	    def->type == BPF_MAP_TYPE_XSKMAP ||
+	    def->type == BPF_MAP_TYPE_SOCKHASH ||
+	    def->type == BPF_MAP_TYPE_QUEUE ||
+	    def->type == BPF_MAP_TYPE_STACK ||
+	    def->type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		create_attr.btf_fd = 0;
+		create_attr.btf_key_type_id = 0;
+		create_attr.btf_value_type_id = 0;
+		map->btf_key_type_id = 0;
+		map->btf_value_type_id = 0;
+	}
+
 	if (obj->gen_loader) {
 		bpf_gen__map_create(obj->gen_loader, &create_attr, is_inner ? -1 : map - obj->maps);
 		/* Pretend to have valid FD to pass various fd >= 0 checks.
@@ -4622,21 +4642,6 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	} else {
 		map->fd = bpf_create_map_xattr(&create_attr);
 	}
-	if (map->fd < 0 && (create_attr.btf_key_type_id ||
-			    create_attr.btf_value_type_id)) {
-		char *cp, errmsg[STRERR_BUFSIZE];
-
-		err = -errno;
-		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
-			map->name, cp, err);
-		create_attr.btf_fd = 0;
-		create_attr.btf_key_type_id = 0;
-		create_attr.btf_value_type_id = 0;
-		map->btf_key_type_id = 0;
-		map->btf_value_type_id = 0;
-		map->fd = bpf_create_map_xattr(&create_attr);
-	}
 
 	err = map->fd < 0 ? -errno : 0;
 
-- 
2.25.1

