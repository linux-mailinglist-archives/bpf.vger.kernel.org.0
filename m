Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6A73D278A
	for <lists+bpf@lfdr.de>; Thu, 22 Jul 2021 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhGVPp7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Jul 2021 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGVPp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Jul 2021 11:45:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9243C061575
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 09:26:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d2so6615638wrn.0
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94cu1D5No3gfVI9OcvJFuMZX9xg9a5Nq+Cs5jv48lvY=;
        b=iI2UZgMaxElnBiZeAhP/JJtJKgMuvixxxJrRh7gcke87CDF8ZWxJlEB8UGO3rdGpL1
         sfNVuNVAPkD6KTgGMNemodvw8RM6fReVOAqoXwZEG7mSTNGeUnntbzWPZ4/9q07nql+/
         HHQDFHtlIJc1oFPce0ObSuZcqaNSzOf8X3VY/VUTPP/CH0/1Er2curIECZ5bhtsgcsZV
         qbmqCaia9CfYTw2EJMPTw5nRC8g2TCNvM6FKLpodwLHaMQJGl8PMat/t2T7dGVFvOemm
         7kHbXakqKdLpoBFii9OvpK4m89D2QhHFixrHXhHSaGltGQDGq5yoEqcJQa4k3AOaJwgk
         DlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94cu1D5No3gfVI9OcvJFuMZX9xg9a5Nq+Cs5jv48lvY=;
        b=UnFjw3C9CFfdodpNNgSsxLGHryn/4joqcVFQrw1O2Fp/70cbjqTDs1Nm08tmak9cCB
         W3clmYPWTg9daUxUbVOnpLomRJTbxyxZcZzv+LSWv0dFSZQJvHf4yXIAZEGcDjinCmr1
         n3T833xs22mH/0Oo7QufgpuzRKP4sCNKkpX1b2gXx5T3dBzU5kZvsHsnxQY99U/cyFQ3
         xmG4PA1ZE+l3rvvzFwP0HJjnOOseD1cDDSNDEKKCROSHho1k5h0ie9Xc/ejVSwBl5LJ8
         2qWgAbFSrHi0WUjA9BNuzOSnCCiguNV8SBZEpgEwnWRutcVlUVhLxVH0Pex3KzWFmq9c
         ZQVA==
X-Gm-Message-State: AOAM530xHpAxA200HhJYk2OuJXkd4Y4mh9mFct4vLJpJ8Z2QE4Gkb6X0
        +ewhWXSBS+vJilNHPDantB2EzKly/mdR
X-Google-Smtp-Source: ABdhPJyPi0p/o5p576dh4ZJh3UJxRJza6+ierlIBZx1anxuEo0EcR+WfncFKHRpyvEET4tQGvfUcNw==
X-Received: by 2002:a5d:457b:: with SMTP id a27mr805296wrc.280.1626971191035;
        Thu, 22 Jul 2021 09:26:31 -0700 (PDT)
Received: from localhost.localdomain (bzq-233-168-31-62.red.bezeqint.net. [31.168.233.62])
        by smtp.gmail.com with ESMTPSA id o14sm2793454wmq.31.2021.07.22.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:26:30 -0700 (PDT)
From:   Tal Lossos <tallossos@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, Tal Lossos <tallossos@gmail.com>
Subject: [PATCH bpf-next] libbpf: Remove deprecated bpf_object__find_map_by_offset
Date:   Thu, 22 Jul 2021 19:25:26 +0300
Message-Id: <20210722162526.32444-1-tallossos@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Removing bpf_object__find_map_by_offset as part of the effort to move
towards a v1.0 for libbpf: https://github.com/libbpf/libbpf/issues/302.

Signed-off-by: Tal Lossos <tallossos@gmail.com>
---
 tools/lib/bpf/libbpf.c   | 6 ------
 tools/lib/bpf/libbpf.h   | 7 -------
 tools/lib/bpf/libbpf.map | 1 -
 3 files changed, 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c153c379989..6b021b893579 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9956,12 +9956,6 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name)
 	return bpf_map__fd(bpf_object__find_map_by_name(obj, name));
 }
 
-struct bpf_map *
-bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset)
-{
-	return libbpf_err_ptr(-ENOTSUP);
-}
-
 long libbpf_get_error(const void *ptr)
 {
 	if (!IS_ERR_OR_NULL(ptr))
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6b08c1023609..1de34b315277 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -422,13 +422,6 @@ bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name);
 LIBBPF_API int
 bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name);
 
-/*
- * Get bpf_map through the offset of corresponding struct bpf_map_def
- * in the BPF object file.
- */
-LIBBPF_API struct bpf_map *
-bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
-
 LIBBPF_API struct bpf_map *
 bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
 #define bpf_object__for_each_map(pos, obj)		\
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5bfc10722647..220d22b73b9c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -38,7 +38,6 @@ LIBBPF_0.0.1 {
 		bpf_object__btf_fd;
 		bpf_object__close;
 		bpf_object__find_map_by_name;
-		bpf_object__find_map_by_offset;
 		bpf_object__find_program_by_title;
 		bpf_object__kversion;
 		bpf_object__load;
-- 
2.27.0

