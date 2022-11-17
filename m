Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22462E8C6
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiKQWzY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiKQWzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:55:19 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D271A3BA
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:18 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id k15so3216442pfg.2
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIaqqP+lrYotcahf/OVYZqQphVsBiOBaqIULMzIdPgs=;
        b=ggqZnpgYUZO9cE01WaOgfrmyO0kbluzi+CNnY5BJrf61dAoQM45COPHheG2pFqqfId
         NyLZaC/vpELfaC2PAyp1HVJzPjaeuqrd93ZeoQ4ic18SVEHqNd99U8EOG5xN608/5AD3
         5wqL0qcL3ZbByIRWbk/nqC9eV5iM7BUDn/pc4qlopqt3uVg3N4zFmq7h0JjWTWB1rFDS
         2re6vsj3bQqOKzuH/IVNnURNVnXiib9aNj1m5BhDgdzn9Erue0X7aSjlgae0AJ4pTlFY
         iFNmQFJFBl+v3dI3yWlX284lNDo1M8wRpYwoiW2kmG0bYmOWUK7rG5ZBdhbhgiyShrEU
         Y+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIaqqP+lrYotcahf/OVYZqQphVsBiOBaqIULMzIdPgs=;
        b=AImZBfJhTQkO4DDIqlTIPFOmFXJENdb80u8z86qEDBCPwRiaSPOr7ZNXK3Rwno9VZv
         phjcw6wQ+dACvIyDNzgYCDELhXaOVGV9K6iVjReviPXxRVH8ISUBFMQfDELwhf+2fOpn
         5LDRcKwZCBo0xnsy1TqNQjvlCTFL8LvRiPoM8HeCxwFkGhVoxhr5GvkJ9DnhSP81Lfbw
         3nPK5sxp+q1BMzLbRJHJarFInKFMTdqYxTiO1TldHadwcaQba4ZVxp5RkMDhTOF6kwKV
         jLi67pu6DFUpUQm7PAvqMJMwwprXNbeq+1EjbS3LW5blrogHC87Uv2/KTMhHM9us7MBJ
         DX+Q==
X-Gm-Message-State: ANoB5pl08DzbU03/RQux1FmHMe7yT8wTMTbiqKmSEEqpS4/0FF5wmh7c
        A53oyxh0J8KTEOr8s1k6drk3+9u8LrE=
X-Google-Smtp-Source: AA0mqf4stSZTfj2W5LhnGLQLgKIpA5aoXtcidbcpsRItAxfeQDDdD1NkkQygj+2v1gpVl/eM6Tg6Bg==
X-Received: by 2002:aa7:8750:0:b0:56c:80e5:c436 with SMTP id g16-20020aa78750000000b0056c80e5c436mr4917877pfo.36.1668725717852;
        Thu, 17 Nov 2022 14:55:17 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b0016c9e5f291bsm2008188plh.111.2022.11.17.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:55:17 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 01/23] bpf: Fix early return in map_check_btf
Date:   Fri, 18 Nov 2022 04:24:48 +0530
Message-Id: <20221117225510.1676785-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=memxor@gmail.com; h=from:subject; bh=qOzkLlEqNRMlZc1hevbR7OemmL9Z+xjR14TpehaqFoU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkaQco8hseIoIn+FXoEPJ9ky0qVqM8ccJD3tXku UeDulmeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5GgAKCRBM4MiGSL8RygaGD/ 0ehCtvimH54ZAXmAzCb0+4Xh3gTLue1bCeBrrj4SfbH891UCwVLgktg13D5bqZOaWal6V/cGOC21Ji u8HwNP03cfOYFGxm0IqpfHQiZjAVBsuZi5BHBLjNwEkqVQuWlmItGHOzM4IKos9uo0wT90aNjjVEz8 gwxeUkSbBZr6NsUCW0GGL2nyuag7SuYuPezRWYM10ADDdgc6ajGVKcnAcUKVK+LA+Zb/78iwkudBZu CmyHaAUurdhNiHzPMRTxNKfDDFvUGTf7a5Qqxd65HQQ2yOveYChyuSgmWJRJxwEhGuFjT0AdQZIvmJ w9b7O8tQ9CTouvF8+ub4czxdI4UK/tj+eez+WXSDsIIYeWZPRVzGJTJRmudkqZUaqDNzVNKvsit6IF B8adPoqz0V1SFRdmA7fOPJ2y5BjotYYFsaVS5Wx8gmDck2H6ALWtJezbOGnbtTcsQEm54rkSIzDoiG iYTx4IRHPQbg1k/xVWMNpnPk2Ql+G0u2duYRK3uVuKBjNN5t4lPOn5jcuqr826SZuz3ug+zfpO8jh6 dHdrREvaxLF+ZdqB5zPt0LYhNpelLq9a4Q2vWjRQW+SSW5y8X9AQT7mADy7Ly1ltRsbguh0WqiJjmC KiE9yC4b0Dh5bgmB7+vwyUoSZMNkPji25VUCekmOE9NoEKI+OwPXkgcTMlJw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Instead of returning directly with -EOPNOTSUPP for the timer case, we
need to free the btf_record before returning to userspace.

Fixes: db559117828d ("bpf: Consolidate spin_lock, timer management into btf_record")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b078965999e6..8eff51a63af6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1010,7 +1010,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {
-					return -EOPNOTSUPP;
+					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
 				break;
-- 
2.38.1

