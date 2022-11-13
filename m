Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCA6271ED
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 20:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKMTHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 14:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiKMTHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 14:07:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBB4101E8;
        Sun, 13 Nov 2022 11:07:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p21so8260483plr.7;
        Sun, 13 Nov 2022 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLA01oFV4J5GlvoqrcMHLaIMq8KumIWqDPPbGMC23js=;
        b=dL1DVKBxXtx/5DE7BDl5yr+EADqUdsivGQVWulyx5LT72sxEE9MFwrJjSujAC04Hy8
         YtjBWnwSf7oLhGAuncPLv4j+7gdePmP2FErFmwZEjbR3sCfn1E4KnERcXaChhClKoT8U
         Qkgl6B6slzTLFw5TUCMMVjIKTtRzJ9SILarGagIQKAE2cvNwRqMeTGel+U19CYnJ2NSd
         caCEHgn/YwOM7OaWOM0ahG0FeIRdUFE0QHapQnFr8eky8l6L5KyWvqXg84Qh82/zYvYL
         rbvTWWNShjlUSOwzvKlUts+X5f2riL2fB69gbBbh0WGBZlJV6vKH06iWCIOHPbraGdRr
         ZM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLA01oFV4J5GlvoqrcMHLaIMq8KumIWqDPPbGMC23js=;
        b=cRD5aW7EFKLTZ+YqN06p3QfqsN8umg9XG5MWQx4hdapGeuLe3Wq1jNOjXbUnnhcM12
         rE9xS8fjqgSior463KU3eHbj1C/ZUQOgbidRpj067OWINRVvVlzjBGIwGQRHjiwDSJrE
         jMkZvT2VqQhXx0hY2CJoHKvNlM29pA0hQoxKk2Q939RVDC0cTt69EphuDLQj4fWUfZYN
         E1OP9ydk3BWeKIKizcvZU3rm64UHyyIXixcBBU7LbFmoIfODjmcMI9eexd2rDUSefjHF
         GKyThzXQXOTIljCxXgD4pkretKl26y8Qt9GuztKv3gaZ4Judt56/TE0OyBrA2weHs60W
         ixWA==
X-Gm-Message-State: ANoB5pkyIwuDsD2Pn+kNBQmeLcAqyALLN8PTE3dvRxsBXwbrycDcMVV1
        X7S4IPLejFU8SsjhzKQaECg=
X-Google-Smtp-Source: AA0mqf4Ry0GPN6uDZwuhGrEuDzZUTHAk7FhXbl5RCAOldZ1lL5XPYboWrm10VKGIQG9JR9UquEWGJg==
X-Received: by 2002:a17:902:f80b:b0:17f:8042:7223 with SMTP id ix11-20020a170902f80b00b0017f80427223mr11101289plb.38.1668366421245;
        Sun, 13 Nov 2022 11:07:01 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001869f2120a5sm5549604plh.34.2022.11.13.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 11:07:00 -0800 (PST)
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
Subject: [PATCH v2 1/3] libbpf: checkpatch: Fixed code alignments in btf.c
Date:   Mon, 14 Nov 2022 04:06:46 +0900
Message-Id: <20221113190648.38556-2-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113190648.38556-1-tegongkang@gmail.com>
References: <20221113190648.38556-1-tegongkang@gmail.com>
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

