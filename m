Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1530D5AC104
	for <lists+bpf@lfdr.de>; Sat,  3 Sep 2022 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiICTC2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Sep 2022 15:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiICTC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Sep 2022 15:02:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D6459B7;
        Sat,  3 Sep 2022 12:02:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w5so6213875wrn.12;
        Sat, 03 Sep 2022 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Qf7PXikGCovsdv/2K6jAdSbyiEi6rrfmnYyZf0F4aGk=;
        b=PArMLiFee//94f9H5QNZjUZjFuoq+KvecU3v0RVUxJ3Go0RNuyHUBsggZXC1NuoBXo
         uvQvbSex10fLw4LMOgDBZQoBmHiCIJli3qPtPq69zkacaxIFT8EldYR5hsuTmOrjcOJK
         Cg6Qso+q+z3xIpFFqGLEsbqV36YJuTcBO4p9TvQ7SfGxoGCtXkrddaL7jZPgJ97XV+HV
         MyG5Yhck95bj+0gqLbnaaJCUpSDNDyWaGniBLIImCpeqAiJ1StRaSd3nvByaFHIKlhRW
         dSTEYvxJ9F26SdLQp/gQC5OjxiAEUfe/9pZB8h2lDfK+mfxMK1k/1/lhq/gBo5nO/a38
         /6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Qf7PXikGCovsdv/2K6jAdSbyiEi6rrfmnYyZf0F4aGk=;
        b=eRCW3Y1fehld63zt6v+5/e0zy5z4izaPdivO3sVCQSELAKaU6Q9SyFpDCfOihq5jxi
         D9QWjHEDnZfTkyKFhfgAxoBo9fRarmqIu+KiwgKLTlM+GLPDOq6zBkAqyM6okGGqYSfY
         NAeOd/h/6OOHC7qUj1PacGahzYMU2UaH2iJG5l8s9l0VE46H2vTHo/oSNJQG94Xhsxgt
         CCRpIMvPs4mXeoR+bDbs1jeHRtr3SdJTrK9xz26g6O0MRSAgzYwc4/RFhre25k4EPkZ9
         TsNBn8PDuGFhq18XvDC4iYgLHSuMW0YBSYGjTl9GhXQHHctKf+pdPU1Q+efFVKtILAZK
         ynHw==
X-Gm-Message-State: ACgBeo1v2ML/+lib71nMxkNK5+Uy/vdkehc5eoc17Gg3V+kS13o6oLsa
        W32d22YYt+KU2cdmpB7Bmg==
X-Google-Smtp-Source: AA6agR7kdeDvq4gxLSPKLxeBw32Ouq9hhnC9Ft8uf6ZUtdmoNBeGrCy0oyCLkaPvRF4r3SoDu/DJcA==
X-Received: by 2002:a5d:59a6:0:b0:226:fdaf:3ece with SMTP id p6-20020a5d59a6000000b00226fdaf3ecemr6121754wrr.444.1662231744731;
        Sat, 03 Sep 2022 12:02:24 -0700 (PDT)
Received: from playground (host-92-29-143-165.as13285.net. [92.29.143.165])
        by smtp.gmail.com with ESMTPSA id f15-20020adfb60f000000b00226d1b81b45sm5167315wre.27.2022.09.03.12.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 12:02:24 -0700 (PDT)
Date:   Sat, 3 Sep 2022 20:02:15 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     martin.lau@linux.dev
Cc:     Elana.Copperman@mobileye.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, sdf@google.com,
        haoluo@google.com
Subject: [PATCH 2/2] bpf: Fix warning of incorrect type in return expression
Message-ID: <YxOkt4An+u1azlvG@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sparse reports a warning at bpf_array_map_seq_start()

"warning: incorrect type in return expression (different address spaces)"

The root cause is the function expect a return of type void *
but instead got a percpu value in one of the return.

To fix this a variable of type void * is created
and the complainining return value is saved into the variable and return.

Fix incorrect type in return expression

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/bpf/arraymap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 624527401d4d..b1914168c23a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -548,6 +548,7 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
 	struct bpf_map *map = info->map;
 	struct bpf_array *array;
 	u32 index;
+	void *pptrs;
 
 	if (info->index >= map->max_entries)
 		return NULL;
@@ -556,8 +557,10 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
 		++*pos;
 	array = container_of(map, struct bpf_array, map);
 	index = info->index & array->index_mask;
-	if (info->percpu_value_buf)
-	       return array->pptrs[index];
+	if (info->percpu_value_buf) {
+		pptrs = &array->pptrs[index];
+		return pptrs;
+	}
 	return array_map_elem_ptr(array, index);
 }
 
-- 
2.35.1

