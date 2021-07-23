Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141063D3593
	for <lists+bpf@lfdr.de>; Fri, 23 Jul 2021 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhGWHDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhGWHDE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 03:03:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA28C06175F
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 00:43:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a6so569909edv.11
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 00:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4mVr82TAyJrGTu2iYSH9ZMwjS+O3g2Vuf3k2y8lPww=;
        b=DcrFmM9Tdq123mFlfAnVS5IVzMKtonQZday3grN3gZUOK+PUXfSin0YhO627pGl5qm
         zUbaWOn/wt8kUm+XIPgRFWC4wXcZjl7DwiwDfl/5T1L02ZvTyRpSuQZKan//MeoVqsXg
         1iLgA10EQHjeLxsVxmQIVS/Y9XyLSvHVm3PX1V7DUcfZ3pMbT5g6CFR56HV+IKth9y+w
         wZxgAjk0IlTFV5oXHYxvGJlKhDFMBeWE8iKoRtziMrcBybRWsYBQ7DYA40QltNZtcB4k
         PmEaxop/8iHfz2B6qKdDa31/S4sBhu/U7a88l3T4hwm/7t6j5i4gmwK/f59TgwJ7ZWdz
         m9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4mVr82TAyJrGTu2iYSH9ZMwjS+O3g2Vuf3k2y8lPww=;
        b=DnU7zmmukaxoh0j0XLTiwOyjJDaI5SnvUEfVK4QZxFgca/VCDbrNcZaaFu5MWOmjY7
         baYNT42icuR8pi2rCvTaV2uhkPqQBzUv5j+XaugTOm6b2UsPVaMfJAqVrPJcElsThSwy
         KJQu/i+tuaur3jnBrB7RNdEgvynMJ64swze/mJnEXlpmpifo9lBv4DpTF8RRIWWTFZSa
         fx04A/OwidV3vPF5tP4uieP2WdqXl+ZtHNQqejNTbVDwpS1dIoq6LnnrT19d3yoatTw+
         c7Ct8O+CT8dF016tMXsaN5e0hc1nfRHB862lOboU0Opcxcc+WPzGl1cR4nZ+Q2itS4CB
         10Wg==
X-Gm-Message-State: AOAM532CPUvwqoHrfsX223zByPFlMYbRfA39B2wXz9botKo3S8fsG2ZM
        zcyc7XrYerVJVMAOx27KsFGuWo1+Lq/r
X-Google-Smtp-Source: ABdhPJxCzP50uXSlj33el1DImsNbLt6NkeiKzOpkGka3X+PiCXPgrW80RBsdQUeFreLauLXZjEgHKA==
X-Received: by 2002:a05:6402:22aa:: with SMTP id cx10mr4077020edb.0.1627026215980;
        Fri, 23 Jul 2021 00:43:35 -0700 (PDT)
Received: from localhost.localdomain ([89.237.108.124])
        by smtp.gmail.com with ESMTPSA id d22sm10595277ejj.47.2021.07.23.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:43:35 -0700 (PDT)
From:   Tal Lossos <tallossos@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, Tal Lossos <tallossos@gmail.com>
Subject: [PATCH bpf-next v2] libbpf: Remove deprecated bpf_object__find_map_by_offset
Date:   Fri, 23 Jul 2021 10:43:22 +0300
Message-Id: <20210723074323.55193-1-tallossos@gmail.com>
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
 tools/lib/bpf/libbpf.c | 6 ------
 tools/lib/bpf/libbpf.h | 7 -------
 2 files changed, 13 deletions(-)

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
-- 
2.27.0

