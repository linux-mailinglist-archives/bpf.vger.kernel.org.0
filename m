Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764356CB2E0
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 02:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjC1Ar7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 20:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjC1Ar4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 20:47:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C7271E
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 17:47:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x3so43115092edb.10
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 17:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679964473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90sq28Z4LK2wnYlGuleCTSP3THsDEaCXMhiSBkKJtHo=;
        b=AWvyPsalWdauNe32R8iqzddH+I206mzUOEbcHmiBe7g74XrUIT8vpLZ+qD+csYHxv5
         deWRlx72kAi0hiU+YQbZb23z6WGH8J46qsrP5IRc7r5GVqQxGUYxDaoSgCuNkHJOQ4kH
         ndryMEdin5NMZwZatXYMku5qUllHaNdrFWX1umXO+GVybgj62OdpAn4j36Fz9Vl4ssi4
         MeGu9Aat5hj8PcB5nE0l2nDp8ByQ8A1ASD91e3JTuRgF0KpzyDwPxEQkUFiF+oLOvycE
         5pxE82V6t8MAyN9CFus2GZn8efZbHWvJz9Xy4Bfl/LDn0Q9HDqJeq5FGupU0vgAI01Cp
         W82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679964473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90sq28Z4LK2wnYlGuleCTSP3THsDEaCXMhiSBkKJtHo=;
        b=MpX+OgGj5iAvTfZCOuZougrSUpXhqwiB84M7RMjHFdqtpjkE7WmLVQHBHx5oa64fgH
         8XBFROX3je7TRoOhBpMm/JNrqMTAU54h4aqSB22tkK++jnkS86rire4kv4MgdHR/XjXA
         fcFhbKxEHw2cSHBXXRlAuQkPmuiMEzVBA8MnCnPXVHmOFBhhtobipLbP74bVx/Pk/U+b
         0lCiTURiwOtoGvYQxo1MWyyWtJe15qSin/cg32m2jX6m+IsizqhaA1MCnuKJY9AEsCYv
         YfVCpHVCIqK/sWznZAy75G/EPR6Isx6jEV4FbWDfi8SWbadI0I1ImHFaWBbzph6eRQN5
         pwGw==
X-Gm-Message-State: AAQBX9cNoePCWvf/8WdYHKBPLwatTXIYjND04nCGKn/yzoMI80dI19tD
        srFoCcmwVmZwkgCOsy6t91LnSF7F5FA09Q==
X-Google-Smtp-Source: AKy350bPI1tdRGNLvxEIYN/gR0DhzjeqZRELwLSwGTv3p8Bylsq6OPRV9WP9fikgSTQ0e3tZ6UzOvg==
X-Received: by 2002:a17:906:3f8e:b0:939:ad91:adf5 with SMTP id b14-20020a1709063f8e00b00939ad91adf5mr15519501ejj.25.1679964472755;
        Mon, 27 Mar 2023 17:47:52 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id xc1-20020a170907074100b0093de5b42856sm5560175ejb.119.2023.03.27.17.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 17:47:52 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, james.hilliard1@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] libbpf: Fix double-free when linker processes empty sections
Date:   Tue, 28 Mar 2023 03:47:38 +0300
Message-Id: <20230328004738.381898-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328004738.381898-1-eddyz87@gmail.com>
References: <20230328004738.381898-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Double-free error in bpf_linker__free() was reported by James Hilliard.
The error is caused by miss-use of realloc() in extend_sec().
The error occurs when two files with empty sections of the same name
are linked:
- when first file is processed:
  - extend_sec() calls realloc(dst->raw_data, dst_align_sz)
    with dst->raw_data == NULL and dst_align_sz == 0;
  - dst->raw_data is set to a special pointer to a memory block of
    size zero;
- when second file is processed:
  - extend_sec() calls realloc(dst->raw_data, dst_align_sz)
    with dst->raw_data == <special pointer> and dst_align_sz == 0;
  - realloc() "frees" dst->raw_data special pointer and returns NULL;
  - extend_sec() exits with -ENOMEM, and the old dst->raw_data value
    is preserved (it is now invalid);
  - eventually, bpf_linker__free() attempts to free dst->raw_data again.

This patch fixes the bug by avoiding -ENOMEM exit for dst_align_sz == 0.
The fix was suggested by Andrii Nakryiko <andrii.nakryiko@gmail.com>.

Reported-by: James Hilliard <james.hilliard1@gmail.com>
Link: https://lore.kernel.org/bpf/CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/linker.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index d7069780984a..5ced96d99f8c 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1115,7 +1115,19 @@ static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src
 
 	if (src->shdr->sh_type != SHT_NOBITS) {
 		tmp = realloc(dst->raw_data, dst_final_sz);
-		if (!tmp)
+		/* If dst_align_sz == 0, realloc() behaves in a special way:
+		 * 1. When dst->raw_data is NULL it returns:
+		 *    "either NULL or a pointer suitable to be passed to free()" [1].
+		 * 2. When dst->raw_data is not-NULL it frees dst->raw_data and returns NULL,
+		 *    thus invalidating any "pointer suitable to be passed to free()" obtained
+		 *    at step (1).
+		 *
+		 * The dst_align_sz > 0 check avoids error exit after (2), otherwise
+		 * dst->raw_data would be freed again in bpf_linker__free().
+		 *
+		 * [1] man 3 realloc
+		 */
+		if (!tmp && dst_align_sz > 0)
 			return -ENOMEM;
 		dst->raw_data = tmp;
 
-- 
2.40.0

