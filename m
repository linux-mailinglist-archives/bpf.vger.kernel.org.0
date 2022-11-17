Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB962E1A9
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiKQQ0s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbiKQQ00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:26 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3797AF72
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:21 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id w23so2055020ply.12
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TZ78mRQGhRCyLlpThPUiFWEWQUdh6C4qa5kLyLUpQ8=;
        b=ePqXHnnTDpQKFZto1Jw7Au+AozgPwhrEWYPP9/c6Pkx6fnagTVkcqUrZNgm2u2QX0Z
         v17JtCs4rFVpAuUhNvE2Z2/dTfURBwfHuh/K+A7q3V2Ld6UZ7d9M4XkbV4vDzNP0v4VZ
         qWnNjqiDgNipfIcEwGoUdwpOu4eNm+mX4syvIn6JYDJKLa5fpEIt55excO/vyp6ECTVc
         0UQkOj5ISN2xdlpl4PxYPUI9KxoICThzTZUb6NaOIH82tIDTPNA0uLvxiwVR2JYSLqmt
         tGRnHh7S7P+lHxH1pkxEFESqu0QR/i/Q/xLsudBbojrKdihkvtSD5qD+UjjsUhBhIC8J
         X/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TZ78mRQGhRCyLlpThPUiFWEWQUdh6C4qa5kLyLUpQ8=;
        b=lO6teh2PYT/lFzU+lpDgGZ2lySesOii2pS9Vl/13X69l9GW7vLquTA4tvoBVOkwq9o
         XATd/rvxUE17R1nkLbNRVKFZY6MmOqso3dpAH/Vyjdux8sDLUjpGqDxQu3rYnvw20kfE
         GSLnL5gU5anOgOaAeOpdnMpVGjV/ynxXIQKUB5H5lb6/9fHp9F2tkPamdlz+/wG53Ozj
         1DFu60m53fiZcby+m4p1UsAs9upcbuA7Sf60jBh4KJMgXk/PnEoep7Z94r84qBNgyF+J
         +FR+xALDbHfQxpvNQ7CtNUbsx/wKhsCKqQqttv30efPQ3a004JrVs8tDvvsEVuxhVMHz
         b+jQ==
X-Gm-Message-State: ANoB5pl2OJjDWQFTujuArnp5GSJoYVxit6mUAwhcZr+PclhQPMEkvVKR
        C8LrTEOVNT/dLilUZgUJZulg4epS2Bk=
X-Google-Smtp-Source: AA0mqf4KsAEYFZY1opBcvTEnkhDPGGZiYGfAy/VlEHfLeUyea8wat0cGwkT/bhl9kfy24d2uktePBg==
X-Received: by 2002:a17:903:11c9:b0:178:2eca:9e1d with SMTP id q9-20020a17090311c900b001782eca9e1dmr3532267plh.43.1668702320773;
        Thu, 17 Nov 2022 08:25:20 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 85-20020a621858000000b00572c12a1e91sm1356036pfy.48.2022.11.17.08.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 10/22] bpf: Allow locking bpf_spin_lock in inner map values
Date:   Thu, 17 Nov 2022 21:54:18 +0530
Message-Id: <20221117162430.1213770-11-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=memxor@gmail.com; h=from:subject; bh=Qa1fKVcF/+XhoI6sA1HXYg2nz2Qei+HbVAfrou9iag8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7/+NlZ+dFZy2PU0LKdY4/0n+fMShDGgRHFlTOM iu4k4xyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/wAKCRBM4MiGSL8Ryj60EA CmJMbPD7lPXSUOqaooA3rvanbg2jLP8FSjbgHri5774RsdgmtGVNh+QXWF0Whr9i+xAw5wV5TX+K3H dVFOKW0ITCSn/xJDDXhJpK2Aa7jrMsjNhbEKb8zDsVLC8moIZb13NNB0YkaNo4KgpPswz/cz0Os7DD F/Z7c53S5wE2D5+IojGxAW1EGwoMNef/JIbtUNiiz+HFmaNnkmhXYZ7uJGtN8aVPLOOFXZsK0of328 zKnST1zIkTOySkW3/3kLZgz5dMtIJyc0b0Ga8YI7t4yXD9I8KvktsODr/UP1Rbl94unvbmRiA6ylzV xgcWRV3Ic6eqrbeSnOuslTjC4W0y3cUf09Dl1IzB4PFUhmEg3wM3vvd5F8D5n9hx9JqL3zGdJka73B TD8gkoPlYyTUG70pJrYDK2wq2UvUzd+he4r87+4JMKPyWXuJL1GdTcXlKJtdNQ0sNs/ppBa9DbC6pw NHOZnkHLRoLho72oU6VtiuWdAvTkdXElH3OSJERZUPnrNmpwlGoRn15dJfNf2XGYYkd+yLiTZEHSpv ICOAx2g1XHugeEib389CsRv1E5ZOgIBrM4SlI99ZJuLbkZF6E/dqXIXJmPNOB+XVg1NBsAlPMZlDQU mrw6W+SCu2sxFyHpf53KCaIKblVAS/IHMaXYsMM0WZ4Cmc7bUCLRjaJz7HjQ==
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

There is no need to restrict users from locking bpf_spin_lock in map
values of inner maps. Each inner map lookup gets a unique reg->id
assigned to the returned PTR_TO_MAP_VALUE which will be preserved after
the NULL check. Distinct lookups into different inner map get unique
IDs, and distinct lookups into same inner map also get unique IDs.

Hence, lift the restriction by removing the check return -ENOTSUPP in
map_in_map.c. Later commits will add comprehensive test cases to ensure
that invalid cases are rejected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/map_in_map.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index b3fa03a84334..b9bf15ec2c4a 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -30,11 +30,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		goto put;
 	}
 
-	if (btf_record_has_field(inner_map->record, BPF_SPIN_LOCK)) {
-		ret = -ENOTSUPP;
-		goto put;
-	}
-
 	inner_map_meta_size = sizeof(*inner_map_meta);
 	/* In some cases verifier needs to access beyond just base map. */
 	if (inner_map->ops == &array_map_ops)
-- 
2.38.1

