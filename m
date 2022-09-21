Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4F5BFFFB
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 16:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIUOgC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiIUOgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 10:36:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3C27AC37
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 07:35:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id hy2so10423507ejc.8
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rEhEuZVm8WcSoFWLFg77NICIR3AxkWO45KJhmJkf960=;
        b=K/N6I5bLgZC1ypSZtEyWTK1/tjQG+RMLvX7fayVDMqMYSyRmZ7c3KF73J8YV4f6Nbr
         9pDiAG+TXEw2uNf0HaDt1pbbdubiVjhS1sc9YlEyapD8unPz/1PUEECkA2ZSUTYiUFEL
         Li+DAl7BOLmCUbUnht+ykX1ZxrduISeiwb8oLRR79NEGg6vpFV/5VMPDfH+RiC2BVoek
         yXTkmEQstha9A19iUUfaFjDXvZZ5VaGPyR2PXSpyaWJ4SY2+0OZ5c5YrAZMgytn9YR91
         5qKWsRvQ96R+MwNDkCcO0u/RKROqiylCqnG0mOwgR2IBNohFZcSljkAMc4TGM3IDNYDf
         O8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rEhEuZVm8WcSoFWLFg77NICIR3AxkWO45KJhmJkf960=;
        b=qkTJZ76gO7irzVjTiWtMfeRqgXM1vq/h8tedwyYo/i+6PPM0lOJsLcFhHaSqFCZ5uY
         SdZgHzzj8BRBuqSO31I++tEEupqyOsY48wJn4U5tvPzVJLGpi+lL7iFLfELNeVOnGXEr
         FMarDA3KGpa2ZMWXk0hJdal3F3r+XsH/ISNnFCGW4JGE9MFmWrc8LX5Z5uaJpu1URr7i
         sseKJC5BsA5sXQ7I2f3RMV8+Yfq5TrotmOZjnQBtAXIvkFu8xJcsYsP60DGaO+dMEQry
         /lPz1ZfFy5/9vQLofbtn/l0vW06hMlf9H2nSrmLSvHQ00uuAVT/0k1hvdJT7wPblGNiC
         MCUw==
X-Gm-Message-State: ACrzQf1u4Pz8poe3MPorKIKWUhboWCXxr43xayly9L6wiV3qqSsW1mEz
        eTztNTIjLDhEdeUFpTu+1D9eYWKG0Xk=
X-Google-Smtp-Source: AMsMyM5jwNZ7YaB4UoTiSyH37g7z3314nPRdaBYSDKbB4MqFfpvJe/JUTyH5tjFNMe+MhcWpbPn91A==
X-Received: by 2002:a17:906:8448:b0:77b:e6d0:58a5 with SMTP id e8-20020a170906844800b0077be6d058a5mr21945515ejy.347.1663770956798;
        Wed, 21 Sep 2022 07:35:56 -0700 (PDT)
Received: from localhost (tsf-460-wpa-1-058.epfl.ch. [128.179.161.58])
        by smtp.gmail.com with ESMTPSA id cf14-20020a0564020b8e00b0044ea1fe7ce4sm1890429edb.56.2022.09.21.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:35:56 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf v2] bpf: Gate dynptr API behind CAP_BPF
Date:   Wed, 21 Sep 2022 16:35:50 +0200
Message-Id: <20220921143550.30247-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=memxor@gmail.com; h=from:subject; bh=X0dv5kg0rBRvOUl31cQpkX8YT1PrGS4zrRgn5FfcK58=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjKxyMf0KucedB4W5f0ila4rrPsY/M/ZPAp20X1bGw nkjizQqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYyscjAAKCRBM4MiGSL8Rym4GD/ 9w1cO5RHAgG0K6rgysKim2ge1eHfzb4vkQXFosvW0vFGL7XrIOCMIpvgzxegaBL4qBaL5nDflBTTj2 B5DK+cf0x3DKwK8vf8+EtXe0Tyl2y6ivLrIAR0SerPC/xnoNfThDq8SpKGTBbb01NP9CMRcByjH4JT RKXpFUz6sIsmCz3KoyVnETcTqP/NFyo84H1GwUNXwx3nWUT1Jl/4BoWDjYzjQseAC7KhEtsKgNNnqD bGHgj4ps0Y/Z6stt6JQuBa7N42nmlLrvrHuIr+oDaqq6A4dCwR60/4hlCO2gWsD1QGfoOXXTzOr3OK W704dwgRnEgCYILOI4/eP9FHjNEqMN4XNaMiIJFRhwpjmNGUCHDrZudS7mY3sMs6Iedapd7fUZDi3m HRc0vTNjZe/8rPw/54kgz4e+9HS3ZBBsOK7x2e50+KAJOX05saC6Hmjj8ynKWTovEsJ0VKb9NZ0QZB hY0N3aC2f9BchbVTRTS8LBJjDlTOCS4aN8dT/PwjBskH2qQaNR/3InzxvPoUk1zh4meI5CAvmi1ib7 Gk9VNHwGRvV7Pc+I21AraTWjJ+TbphmE4g1d0n7kZ4r27iCprMyv+7AwFnLzVZ6sfDbMrkzs/n6Iqj aBcM2agtw2xbOSWP7+g5xSFqfrs0SG8Uy0pJEIyoDLAzQ4gEny/GR6A5xDIw==
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

This has been enabled for unprivileged programs for only one kernel
release, hence the expected annoyances due to this move are low. Users
using ringbuf can stick to non-dynptr APIs. The actual use cases dynptr
is meant to serve may not make sense in unprivileged BPF programs.

Hence, gate these helpers behind CAP_BPF and limit use to privileged
BPF programs.

Fixes: 263ae152e962 ("bpf: Add bpf_dynptr_from_mem for local dynptrs")
Fixes: bc34dee65a65 ("bpf: Dynptr support for ring buffers")
Fixes: 13bbbfbea759 ("bpf: Add bpf_dynptr_read and bpf_dynptr_write")
Fixes: 34d4ef5775f7 ("bpf: Add dynptr data slices")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
v2: Rebase on bpf tree
---
 kernel/bpf/helpers.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1f961f9982d2..3814b0fd3a2c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1627,26 +1627,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_discard_proto;
 	case BPF_FUNC_ringbuf_query:
 		return &bpf_ringbuf_query_proto;
-	case BPF_FUNC_ringbuf_reserve_dynptr:
-		return &bpf_ringbuf_reserve_dynptr_proto;
-	case BPF_FUNC_ringbuf_submit_dynptr:
-		return &bpf_ringbuf_submit_dynptr_proto;
-	case BPF_FUNC_ringbuf_discard_dynptr:
-		return &bpf_ringbuf_discard_dynptr_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_loop:
 		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
-	case BPF_FUNC_dynptr_from_mem:
-		return &bpf_dynptr_from_mem_proto;
-	case BPF_FUNC_dynptr_read:
-		return &bpf_dynptr_read_proto;
-	case BPF_FUNC_dynptr_write:
-		return &bpf_dynptr_write_proto;
-	case BPF_FUNC_dynptr_data:
-		return &bpf_dynptr_data_proto;
 	default:
 		break;
 	}
@@ -1675,6 +1661,20 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_timer_cancel_proto;
 	case BPF_FUNC_kptr_xchg:
 		return &bpf_kptr_xchg_proto;
+	case BPF_FUNC_ringbuf_reserve_dynptr:
+		return &bpf_ringbuf_reserve_dynptr_proto;
+	case BPF_FUNC_ringbuf_submit_dynptr:
+		return &bpf_ringbuf_submit_dynptr_proto;
+	case BPF_FUNC_ringbuf_discard_dynptr:
+		return &bpf_ringbuf_discard_dynptr_proto;
+	case BPF_FUNC_dynptr_from_mem:
+		return &bpf_dynptr_from_mem_proto;
+	case BPF_FUNC_dynptr_read:
+		return &bpf_dynptr_read_proto;
+	case BPF_FUNC_dynptr_write:
+		return &bpf_dynptr_write_proto;
+	case BPF_FUNC_dynptr_data:
+		return &bpf_dynptr_data_proto;
 	default:
 		break;
 	}
--
2.34.1

