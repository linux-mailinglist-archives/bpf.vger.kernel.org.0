Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD15F403C93
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhIHPhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbhIHPhG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 11:37:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268BAC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 08:35:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w7so2980364pgk.13
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5THeVPjlz5mHu6wptsoRq2zUg/vecY8txoTSBglnhfU=;
        b=EH3WvulbuyG8a2BaItgcUVwF+cQvpmLZfNdTAzAJZ2nq/pmy3mh5BRd+DLJfm9Ngcv
         3GlH9dqwExSUFLrC6SZlS4OI4ITUX0m9SxBCsfsAVB7dZ8CA48/FWFr2WLvZJH9TgpEv
         yKhEEvmNuZQrVqZKz9qAcvilr0NH15ePz5q4RzrW7yPNUrP4yxIiFOkrGmG7Y/+eVa0O
         qcoWp9Ik6tViRdAqbWA4tVX3rI3C1gW9fjdsJi0q/sKvwJTXKDIllyAESh3zenjUeuRV
         HW2OJsFdvWhDiz71TGiEsR5g67uLVBGAo3u9+Trlouu2bS7gx9nE9cR7B852idY+yK6E
         8ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5THeVPjlz5mHu6wptsoRq2zUg/vecY8txoTSBglnhfU=;
        b=bwRp0KXKQ347jV5MjKYyA8AdWiDqjA/uW9D6we8EcIuOroL6BUwH/+WH+Dcgo1UXWu
         0rkz8X1CA62BMCJxQ0HTnFF6yMQJ/dSvbDcsoS/Xmm+W/ryjNxYaFwPCE/+c1JR2k0tb
         0xiC8uGjs6b6m6PAwHBCo8lt0fvjRFwNhOrqbj1mxLbEHW2As3h7pP1DroSDx3c3Ex8d
         PJ0puWiJFL9U66V1JYhADUG+y3AeWiWyB+CIVfpJnDZguRueu+xH8gbE+wTlYkeWnsvI
         /JooXkPM7lRyywds18tHEo2eaEAUerZztho+ltD1HIBNnz0xyrG9qUNed/LVEJsTWoI6
         PqRA==
X-Gm-Message-State: AOAM5302YIQnEuGmqqItVpB5kwN3cUgVHBPLjFPusdUmT0pcN0NJr3m5
        +BKwAJZD/xwGFOLtzMwb31ia5vapDSdLUA==
X-Google-Smtp-Source: ABdhPJwFVY9/wIRB783leYX0/BKmDkHnRz/HWGoFVfMU4/dfoQZd+ykzzfxXr+ttB5/+1/kEdFYTPw==
X-Received: by 2002:aa7:8893:0:b0:416:4ed7:e4c4 with SMTP id z19-20020aa78893000000b004164ed7e4c4mr4292801pfe.83.1631115358527;
        Wed, 08 Sep 2021 08:35:58 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id l23sm2588245pji.45.2021.09.08.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:35:58 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: deprecate bpf_object__unload() API
Date:   Wed,  8 Sep 2021 23:35:44 +0800
Message-Id: <20210908153544.749101-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF objects are not re-loadable after unload. User are expected to use
bpf_object__close() to unload and free up resources in one operation.
No need to expose bpf_object__unload() as a public API, deprecate it.[0]
Remove bpf_object__unload() inside bpf_object__load_xattr(), it is the
caller's responsibility to free up resources, otherwise, the following
code path will cause double-free problem when loading failed:

    bpf_prog_load
        bpf_prog_load_xattr
            bpf_object__load
                bpf_object__load_xattr

Replace bpf_object__unload() inside bpf_object__close() with the necessary
cleanup operations to avoid compilation error.

  [0] Closes: https://github.com/libbpf/libbpf/issues/290

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 8 +++++---
 tools/lib/bpf/libbpf.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8f579c6666b2..c56b466c5461 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6931,7 +6931,6 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 		if (obj->maps[i].pinned && !obj->maps[i].reused)
 			bpf_map__unpin(&obj->maps[i], NULL);
 
-	bpf_object__unload(obj);
 	pr_warn("failed to load object '%s'\n", obj->path);
 	return libbpf_err(err);
 }
@@ -7540,12 +7539,15 @@ void bpf_object__close(struct bpf_object *obj)
 
 	bpf_gen__free(obj->gen_loader);
 	bpf_object__elf_finish(obj);
-	bpf_object__unload(obj);
 	btf__free(obj->btf);
 	btf_ext__free(obj->btf_ext);
 
-	for (i = 0; i < obj->nr_maps; i++)
+	for (i = 0; i < obj->nr_maps; i++) {
+		zclose(obj->maps[i].fd);
+		if (obj->maps[i].st_ops)
+			zfree(&obj->maps[i].st_ops->kern_vdata);
 		bpf_map__destroy(&obj->maps[i]);
+	}
 
 	zfree(&obj->btf_custom_path);
 	zfree(&obj->kconfig);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2f6f0e15d1e7..748f7dabe4c7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -147,7 +147,8 @@ struct bpf_object_load_attr {
 /* Load/unload object into/from kernel */
 LIBBPF_API int bpf_object__load(struct bpf_object *obj);
 LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
-LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
+LIBBPF_API LIBBPF_DEPRECATED("bpf_object__unload() is deprecated, use bpf_object__close() instead")
+int bpf_object__unload(struct bpf_object *obj);
 
 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
-- 
2.25.1

