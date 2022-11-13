Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236FF627041
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiKMPnN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 10:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiKMPnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 10:43:11 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AFCBCB8;
        Sun, 13 Nov 2022 07:43:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g24so8032149plq.3;
        Sun, 13 Nov 2022 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLA01oFV4J5GlvoqrcMHLaIMq8KumIWqDPPbGMC23js=;
        b=GDh/5ZwJ9IQY8JKJ5fNbuM3L5bRLpO2C6PElCD0BN/2SQCI9d4cQ0P4+taywYpMzlA
         NgLkZhPcHRZRnpB7ryVBeh/aimQZSIVYHdg3ild13Dd1tQ89RHg7IPqtMUnaeG8occpY
         iaf2EniO8gVkxLf70o5mM+ds7tBvRjU/1M+mhD8N/nou5ZuMosnANAaDqdddt2tOlaWn
         TW8px/1LmmogYA6GkHGcfB0MiMH2ISKWd8ST6p+drra0VqZc6T/ByKnnmaZv+AgU3178
         piQCvUh98O62Gy2ozjAPVPBxyLwO/13vH7tyihE5Ku6U9GwPBDmtnrT5ZhndscR9EEgc
         FFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLA01oFV4J5GlvoqrcMHLaIMq8KumIWqDPPbGMC23js=;
        b=N19Hmj1SIC839J9xXwKGFK5VdJzNR2sqWgOEN0CAt1yrz1bz4LHGZy33CLpMXSOnfC
         EFURP1gUZ+QOyTKyYC+zlKTLoWL5rj/e4vgRhJl0EyVUTcs2OYbLna5Lh5N3mzhuq21M
         dnirwZH3yWd85xl2SSD03VfrIPQQocXR1l71zqExWa2uiyrG6qyKAJXHfefpK4EVAQs/
         2QZAInbUJE6YOXB+ZrVXLfXavjH7jne04GiYJhmGjtb/up1BwhxdkUyh02mfeqLPNeir
         C5HxFyw37EU1DTjHrTQE0royhrj0dXh9om3ikPH1MiQ4SDE4UAhIPa69xBvfe2F5o6SQ
         TIZA==
X-Gm-Message-State: ANoB5pk7FxGyLbq4LcMmO2FDSl9RDfT4MNvzr8vQNfn6MWM/i1JifgRP
        DgXsnSz5680nJ8gooZEyTo8=
X-Google-Smtp-Source: AA0mqf5fq3rBUa6kTPVHBqn3T7OYnEZ6JFAF46HkASAWgIwLqyjQ2YDWWL6C3HE26NKpiRiFYWEBLA==
X-Received: by 2002:a17:90b:30f:b0:211:42a9:d132 with SMTP id ay15-20020a17090b030f00b0021142a9d132mr10562859pjb.8.1668354190222;
        Sun, 13 Nov 2022 07:43:10 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0018544ad1e8esm5304550plk.238.2022.11.13.07.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 07:43:09 -0800 (PST)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH 1/3] libbpf: checkpatch: Fixed code alignments in btf.c
Date:   Mon, 14 Nov 2022 00:42:56 +0900
Message-Id: <20221113154258.36560-2-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113154258.36560-1-tegongkang@gmail.com>
References: <20221113154258.36560-1-tegongkang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixed some checkpatch issues in btf.c

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 tools/lib/bpf/btf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3bd812bf88ff..71e165b09ed5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1724,7 +1724,8 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	memset(btf->strs_data + old_strs_len, 0, btf->hdr->str_len - old_strs_len);
 
 	/* and now restore original strings section size; types data size
-	 * wasn't modified, so doesn't need restoring, see big comment above */
+	 * wasn't modified, so doesn't need restoring, see big comment above
+	 */
 	btf->hdr->str_len = old_strs_len;
 
 	hashmap__free(p.str_off_map);
@@ -2329,7 +2330,7 @@ int btf__add_restrict(struct btf *btf, int ref_type_id)
  */
 int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
 {
-	if (!value|| !value[0])
+	if (!value || !value[0])
 		return libbpf_err(-EINVAL);
 
 	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id);
-- 
2.34.1

