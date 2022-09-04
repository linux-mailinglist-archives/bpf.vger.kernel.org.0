Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E761E5AC66A
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIDUmC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiIDUmB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5A2CDDB
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id se27so13435331ejb.8
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XqoUwCntaNmDsOh9mPohu7UAOullRaOQCdmzJtDxuOA=;
        b=aWGOAwsbeFp6tz7K5W4ZokCVMxpzAQ46RU2TnrdDXWJyd2YPygfKqMA2Ipn2G31ICd
         4SClh8ya56KBNfo8y3eIYmKrVHuh3PJbJMgbGbBaZgQ5dhhZEbUOs+h5L/iR44EyDW/s
         QjtVye2RkYmJFcF8+1E79Ven8y/pzpcL1Y7XnQSeLzIQ3253gNtLlhFSZhzHhg+ZUA2m
         vXC+C1k3vkZrryA0reSOflojqqPSsYTWfHmn/G16iQEYodCha8aNQt5BgKC/GDDFB8Tw
         LsS0DKuntNBiVdw9smYJCqIzdxyfiCkhzch+gmLQ1JBpUIgjgRcXDAlXrR8hxo8RagV+
         FnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XqoUwCntaNmDsOh9mPohu7UAOullRaOQCdmzJtDxuOA=;
        b=JhXVDVQc+DeWBQ7B0Momjwkhj+9AVAfnvrzNG32ijB+H1LAM2gnEls7mOVTJtO5L1c
         KBEu2yB9b+Z47VQ78lNPSMzZkSwTdzFKtgitVmux2N75yuwiU7w9XUnZ0A09i5ejvTNZ
         kzvYdSG8Gg4LeyDYTzuCpxlu1xAbztHaspzL6rEf4zqDvTFu3gCnS8PIV7cb7BeBRWyy
         qhmrGhoRIPaEKHB4+mRQIa5ecqzh+5JxxJRaxfOIq2zf75a5mT1TESda9MXXl34G9HrH
         Xrz0wYUhkz5uXpMWp5BAz8i/0ARZuksUfvuSz2HzcsxIxJ9GX8bp/wHmgJJM218DmPpQ
         LYQw==
X-Gm-Message-State: ACgBeo1vuFgvyTqxJ+lcAtelXSh2QLZicxknQ0Il+0hR3854bGdDU4iB
        AJpdkqjS8rLGEAwV/7+4TckL9amie7lNtQ==
X-Google-Smtp-Source: AA6agR62QurShyRpg06aXg60D8xOheKhwX6gKKCOQjOVtski1cZgWRFNprIrW5k2lrl7BTQG6c/+lg==
X-Received: by 2002:a17:906:3fc3:b0:750:5e2b:ff1b with SMTP id k3-20020a1709063fc300b007505e2bff1bmr8954626ejj.233.1662324117564;
        Sun, 04 Sep 2022 13:41:57 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id cx6-20020a05640222a600b0043ba0cf5dbasm5299891edb.2.2022.09.04.13.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:57 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 08/32] bpf: Add comment about kptr's PTR_TO_MAP_VALUE handling
Date:   Sun,  4 Sep 2022 22:41:21 +0200
Message-Id: <20220904204145.3089-9-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=memxor@gmail.com; h=from:subject; bh=CHxAz3+7Y7vYAW9TFCqao6vr/GFIkUbN1nKEok0ekCs=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wvkkKSJk9DJAkhwEEXExUz8kobcT94SkF5MaG cH5wWLiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8RygxJD/ 9pJkkkSMbjlvnZvXPjX+4oDxJhNmsiWYru/IHW7861W1cqrC+cdD8lAFKDYuA2GZs3ugWtds6fSNEo gF/gbLHLIrVCQrh8sbaS2+rppOiSG6C555okQa9UABU1gQU8npUmLdCjBJcj3RBGP4t3R1A6FMSAA8 imcz3TVufXrHLNcGb5pxbPvftY7UsMaUGFHco4ccqeVSx4qQVfmhYj40KT2L3rJwtyNPn9qNA6C72s gHkwe5FSGBtFkG0VjBFWL4aR8YSEPpxCRA980JUXHtBBkEfqwj3phSoErANmWUoRZI4mr91iAiFI1l D0dH/qjFILe+f1pQRKEUzhzt/fZFSY/U0RQascmmY2dD/2WcLWgM6tDzRLKVFFB0exfrrTudcnpe8u 5dJktVnRCXsoPBsU2fpWep3kLNvAA6lcDVuYBTM3lTyjC5gkH+pnKK709oocYzzyLm4SWMKX/coHTQ EOG/nJQY5V4bdGslj2qHYtY4THJxSTl3OOP0YnOaQAjR6JqbLnf5rxJ1Dq3cCOJoWE5cq1RYEcfGUw TXI9/7GG9dsMpmaJ5co8BrsDdyZu0Gu/vE0ueV2RcNg7g5tmueaNF/IBhhTKttsRLo+y+QuhLzA2Gz kMxgrEJXpMIXOW4ru8eu/Kf24Hi/GqH191AHJmPlIKW8d7hyq8bLxw0ouz+w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In both process_ktpr_func and kptr_get handling for kfuncs, we expect
PTR_TO_MAP_VALUE with a constant var_off and optionally fixed off, which
in turn points to the kptr in the map value. We know that if we find
such offset in the kptr_off_tab it will be < value_size.

Hence, we skip checking the memory region access. Once establishing that
it is a kptr we also don't need to check whether the map value pointer
touches any other special fields for [ptr, ptr+8) region we are about to
access.

Finally, for check_map_access_type, we already ensure that neither
BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG flags can be set for the map
containing kptrs. Hence, checking that is also not required.

Encode all these implicit assumptions as comments where such checks are
made, so that any future changes to these take the kptr related
invariants into consideration, and avoid introducing bugs accidently.

All this information was also clarified in the commit adding kptr
support, 61df10c7799e ("bpf: Allow storing unreferenced kptr in map").

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b7bf68f3b2ec..0c19a98c748d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5196,6 +5196,11 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_mem_region_access(env, regno, reg->off, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
+		/* process_kptr_func and kptr_get assume only map_access_type
+		 * and special field access is checked for PTR_TO_MAP_VALUE,
+		 * apart from verifying memory region access, hence they must be
+		 * revisited when that assumption changes here.
+		 */
 		if (check_map_access_type(env, regno, reg->off, access_size,
 					  meta && meta->raw_mode ? BPF_WRITE :
 					  BPF_READ))
-- 
2.34.1

