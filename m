Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0A62EB62
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiKRB4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiKRB4W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:22 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFF62052
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:21 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id g10so3294915plo.11
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIaqqP+lrYotcahf/OVYZqQphVsBiOBaqIULMzIdPgs=;
        b=WynKYrwTyXR47JCzXj5WEA0W+oXnNywVqOduFzQYNOenGiQquINnFOpsCcvg+nVZLK
         xOHN2vT/WsAmN29pl0o5UhWqYfrc5JtMSBzWuCfvKzQgZYMrHGAsw1mlb/wTeKRWhArt
         tiyI2gBUox4vcLhH3zixzSg8hlenuDd7kHBHQi9+EKf64QWYKh1GegQ13Vzp6lYi6QRF
         N0bfdSPYRAZQyz3vtcfF14YB84/qWiO6veNfcJCc8E/JmdAuSi6ZT2TlJT7WQFL+NKgl
         73D8jMZIk3Ihr8Wjd+TxQHzrtRS30wEkNB1FKEtGtu+XS3DGoxwXWog6wXQY/+0qKJxf
         Bb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIaqqP+lrYotcahf/OVYZqQphVsBiOBaqIULMzIdPgs=;
        b=p/7OhPdyXsSrNJrXJJG9SmoWr9QIAFQW0hFptfBIxw5YdUjX4nTGh9raUhuNkUfISC
         4tKoSIbpCEQ/LjetSa/JoQe+kWtldnJCCmp2iSRLYBCRvCs7PDWw4/Yuq282F30JWaFO
         qLQQjDqsgfgIi2H4pc9YEdQKigbAey54AZsQd51acW7zEOFJpa3eWtEEQDGEIN8TnwMj
         3zRTOIE9TFn7ysKRZ6QS5KVTWsdw8n1OlF+kJ5Y1Fzj2ueZWwyt1FhA8GBRXdhNfFuT7
         95Gzg3/+Qw4IuNQfySlzGhK+AzSLiYh2gaELntugd452L6zl60bEww6qJjzNBMTAv0AC
         n9zg==
X-Gm-Message-State: ANoB5plczoiJQetuO2CwGVV8/2jiZBkEoGKilLDkY7vA+tQSdZun3l89
        ws4fPJjniYO8/n3A442HAei0oQx6DOU=
X-Google-Smtp-Source: AA0mqf6/MapF/c4E/EnOiKvR25IBIrSjAWaoueYMpvd8P8O80n+9vnVAQC1ZRgZMlubxQgwy7LZ5NA==
X-Received: by 2002:a17:90a:db8c:b0:20b:1f6:3fe0 with SMTP id h12-20020a17090adb8c00b0020b01f63fe0mr5509046pjv.125.1668736581038;
        Thu, 17 Nov 2022 17:56:21 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id j10-20020a634a4a000000b00470537b9b0asm1702226pgl.51.2022.11.17.17.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 01/24] bpf: Fix early return in map_check_btf
Date:   Fri, 18 Nov 2022 07:25:51 +0530
Message-Id: <20221118015614.2013203-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=memxor@gmail.com; h=from:subject; bh=qOzkLlEqNRMlZc1hevbR7OemmL9Z+xjR14TpehaqFoU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXOQco8hseIoIn+FXoEPJ9ky0qVqM8ccJD3tXku UeDulmeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RyrILEA Cbv5YDmZxrbsthiSwepDETpnBiEVvqeAdv/fwtC5D02Wg3uoPceTOWpyjFNywuB9nhcFROLmJzmRYi fYsaPcenL4vXeMOfmmTNrL36rd+wUMfxnH7IQrJB5V3iWzrf69AleLaBUG/lpll39O2tFn6WDnN+3i kArJg30fSaU94M/PL3031+kWYFIJnoDvK6gt/QcnYtpXSGq/d3XyT56GoM84wizQ7rGWDi86m+mFgh XUIFMB4L8+pgHpEUDK2nVFW594XzTTth7bSAhkBX9lg3nPPWmhqsY1Sl1YWsqz/RX5iq8KMVuiRRCG ZVhUxqfWVtkNerMOeOV0lhs7HatJsMh1QnZBXXEb4eu8XjAQWViEy7iPGyZL3UPZRarHJbefmqD3VA j1A0f9EZ7Dph2FzdWYtJ4Ui/vmclTXC5Ld6VU00E+3VfjCEusM8MvHpSBIznJLmdqDxAFIH57rVV8q zuKKBzDIXROrKDWUA3+9YOD5XOqQ94kHWDqzaooltfyrlSsFOX20uUF9A9dtbcJi222rRWzfjrPrxR ZR7px55Ha/NrQp2gs/AmHoCm/h3t40nJcTGZJKm3S8wiVkkyLCEzV8hGsSZwk1jj3s64FAV+5PydEJ Cj5pG4qKq0RcipWUZ7O1ZEu7XzVzkY6s+tLLJVkay1pryh8bZBDU+nd+3O1g==
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

