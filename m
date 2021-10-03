Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D93420303
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhJCRBH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhJCRBH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 13:01:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D2C0613EC
        for <bpf@vger.kernel.org>; Sun,  3 Oct 2021 09:59:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r7so9876188pjo.3
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07/x0sB8gg76c2kAGVtDNCapNqpl88YS2jSvjNpkDLA=;
        b=cZuSwDjQUtDPTIjKPm1rAoBRVRdMSFBOeejo6OaVjiIrKsvWEkvqISqn+nyrJTaeAu
         r51mZgnREfdiONqDEkKOR9F+Y3z4anF06OiIIq8MRL7h5slJA9OQj1Vg6VCdtlYOS00Y
         qpi+HsnySrjDLacqJIBeTDraoWKZk5pkKbon6QNm6eyVz9BAVniAkbhMhLMFXukYXeDh
         S+B2PKFB4xHIjM89GXsSK0xs34/oWWC5QF7CsntoGHeKVXcWPiu5TsM61WeaW2R7DINa
         MhtVHu/0Buft6C1QDnTp/TWJBgFsNwJ6W/ZdKkWyw0F53i9roSzlje6Ha4zDXKeDmhOQ
         8oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07/x0sB8gg76c2kAGVtDNCapNqpl88YS2jSvjNpkDLA=;
        b=zrQBQmYfQZqidHzf7KZkDY/ZFzgnE1Euvw59Ua8+3+qTS9qRwzq8fV/EqBVAkzfZ7r
         NGxt1mojdO7x0JveuyqAs1pLcw4ZQASxfo/c/overBo+1xkVfrVuaN2KWA1aef5S6uCo
         HZXZyqC/9zA1g7uX1W0xKRqlGP9F3JwipZAu/W/4d0ObSKsGYCX/b/xnNfquLZd3gT3Z
         wmjtGHaEh9qA1+g5bTyJJLpS/045OKQSCMPadvggO6EeIqUeYMHxqXeZ1PC2SbMyD7Nq
         UkmxOdCh1ZKl38opdq8euBLwx0cxha2fNel98vaV8dOtGdQ69gVcIEwJB702AcTEQwX3
         37sQ==
X-Gm-Message-State: AOAM533Y3VCC31q+7G6i9OcwcpWOhDhiY0SUzJ+s6OPOmVpE8wlnlOPU
        fWkR0Wyr6FustonYTaXXO9Rtj5U1ySeaUg==
X-Google-Smtp-Source: ABdhPJwsvAcsrV4fR0JTbPUEwtfZULkSkTqLdqf0q+TYQG1vVVhkEUhB7BxaczIgL3aPn429U4aePQ==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr25447018pjp.56.1633280359410;
        Sun, 03 Oct 2021 09:59:19 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id e11sm11592296pfm.79.2021.10.03.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 09:59:19 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2 v2] libbpf: Deprecate bpf_{map,program}__{prev,next} APIs since v0.7
Date:   Mon,  4 Oct 2021 00:58:43 +0800
Message-Id: <20211003165844.4054931-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003165844.4054931-1-hengqi.chen@gmail.com>
References: <20211003165844.4054931-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate bpf_{map,program}__{prev,next} APIs. Replace them with
a new set of APIs named bpf_object__{prev,next}_{program,map} which
follow the libbpf API naming convention.[0] No functionality changes.

  Closes: https://github.com/libbpf/libbpf/issues/296

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c   | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 35 +++++++++++++++++++++++------------
 tools/lib/bpf/libbpf.map |  4 ++++
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e23f1b6b9402..ecd5284c705d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7798,6 +7798,12 @@ __bpf_program__iter(const struct bpf_program *p, const struct bpf_object *obj,

 struct bpf_program *
 bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj)
+{
+	return bpf_object__next_program(obj, prev);
+}
+
+struct bpf_program *
+bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
 {
 	struct bpf_program *prog = prev;

@@ -7810,6 +7816,12 @@ bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj)

 struct bpf_program *
 bpf_program__prev(struct bpf_program *next, const struct bpf_object *obj)
+{
+	return bpf_object__prev_program(obj, next);
+}
+
+struct bpf_program *
+bpf_object__prev_program(const struct bpf_object *obj, struct bpf_program *next)
 {
 	struct bpf_program *prog = next;

@@ -8742,6 +8754,12 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)

 struct bpf_map *
 bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
+{
+	return bpf_object__next_map(obj, prev);
+}
+
+struct bpf_map *
+bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 {
 	if (prev == NULL)
 		return obj->maps;
@@ -8751,6 +8769,12 @@ bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)

 struct bpf_map *
 bpf_map__prev(const struct bpf_map *next, const struct bpf_object *obj)
+{
+	return bpf_object__prev_map(obj, next);
+}
+
+struct bpf_map *
+bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *next)
 {
 	if (next == NULL) {
 		if (!obj->nr_maps)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e35490c54eb3..8f5144bfa321 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -189,16 +189,22 @@ LIBBPF_API int libbpf_find_vmlinux_btf_id(const char *name,

 /* Accessors of bpf_program */
 struct bpf_program;
-LIBBPF_API struct bpf_program *bpf_program__next(struct bpf_program *prog,
-						 const struct bpf_object *obj);
+LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__next_program() instead")
+struct bpf_program *bpf_program__next(struct bpf_program *prog,
+				      const struct bpf_object *obj);
+LIBBPF_API struct bpf_program *
+bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prog);

-#define bpf_object__for_each_program(pos, obj)		\
-	for ((pos) = bpf_program__next(NULL, (obj));	\
-	     (pos) != NULL;				\
-	     (pos) = bpf_program__next((pos), (obj)))
+#define bpf_object__for_each_program(pos, obj)			\
+	for ((pos) = bpf_object__next_program((obj), NULL);	\
+	     (pos) != NULL;					\
+	     (pos) = bpf_object__next_program((obj), (pos)))

-LIBBPF_API struct bpf_program *bpf_program__prev(struct bpf_program *prog,
-						 const struct bpf_object *obj);
+LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__prev_program() instead")
+struct bpf_program *bpf_program__prev(struct bpf_program *prog,
+				      const struct bpf_object *obj);
+LIBBPF_API struct bpf_program *
+bpf_object__prev_program(const struct bpf_object *obj, struct bpf_program *prog);

 typedef void (*bpf_program_clear_priv_t)(struct bpf_program *, void *);

@@ -502,16 +508,21 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name);
 LIBBPF_API struct bpf_map *
 bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);

+LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__next_map() instead")
+struct bpf_map *bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
 LIBBPF_API struct bpf_map *
-bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
+bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *map);
+
 #define bpf_object__for_each_map(pos, obj)		\
-	for ((pos) = bpf_map__next(NULL, (obj));	\
+	for ((pos) = bpf_object__next_map((obj), NULL);	\
 	     (pos) != NULL;				\
-	     (pos) = bpf_map__next((pos), (obj)))
+	     (pos) = bpf_object__next_map((obj), (pos)))
 #define bpf_map__for_each bpf_object__for_each_map

+LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__prev_map() instead")
+struct bpf_map *bpf_map__prev(const struct bpf_map *map, const struct bpf_object *obj);
 LIBBPF_API struct bpf_map *
-bpf_map__prev(const struct bpf_map *map, const struct bpf_object *obj);
+bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *map);

 /**
  * @brief **bpf_map__fd()** gets the file descriptor of the passed
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 9e649cf9e771..b9f711ca475f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -389,5 +389,9 @@ LIBBPF_0.5.0 {

 LIBBPF_0.6.0 {
 	global:
+		bpf_object__next_map;
+		bpf_object__next_program;
+		bpf_object__prev_map;
+		bpf_object__prev_program;
 		btf__add_tag;
 } LIBBPF_0.5.0;
--
2.25.1
