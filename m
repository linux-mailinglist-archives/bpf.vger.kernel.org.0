Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C359CDEB
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiHWBbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 21:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbiHWBbW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 21:31:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12255A3F7
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:31:21 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u15so15918515ejt.6
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=v5wa0sDhiXcOHOmZYvW1r3YmLcJ/blrvBOQMDTMbYHc=;
        b=QbzXZVN0ki8kUNNmI+ixYnaZBTC2WB6UuOge2Z1J5Hj6QVmljAm4Td5dPmcn/Aw0sx
         oPRlDIGgo/sinB3w0v5y07kZEB4ibmP2uguQGWNfj8l0R1ZeRQSCTB3ZWpgG9DQ6XYpS
         UFYRcy+zw9HhPV/yPcucphnliGEvIJy1K8+vkALKmDV9dCCL1hkO9soOKw4ovL3IgrCP
         ftAe7bNHk4fXjBN0RzeY5rsOARjQDHo6UG6VLT/tkS7QfCr6VamMQlf+dyofFhwAKjYN
         bMX/QBF8k6Qv4UTKry8e2O6xuN2Ws1pMCIjrNi2pS87YW1JPTd/RGoeSUzDLikhD/bqH
         esxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=v5wa0sDhiXcOHOmZYvW1r3YmLcJ/blrvBOQMDTMbYHc=;
        b=suihJ7g7rm/0rl78oxYJCF+Y0hKKNzrij0eikvPb4h7emOauFzmen1rTDX83YXWGzM
         U+muJn8lPMOnmvWM7XeSfNZCh2lh+U5Ewy7tjwNmVXEhpLk4f6l900GX6RdBasDuRqXW
         zI2jMcVukI0Gw8+FL+cdoOkYGIItUFqTw9fNZsqGt3sKrRHFl7I7aLuP5qUh/nEXcggz
         WLVi0bNO+bOvosWih+z0IsgTsWWgPieKf1x0F9K+QCXqgr+SKLV6pmogzyrQeDcw+Jzq
         dq4CryzmX0fSUbMB7nmkGc0+3gl2x0WGuwy0+uid2oFRRk+7wLUN4T4iLm2j8mAjepof
         CbcA==
X-Gm-Message-State: ACgBeo0k/r121b/3c8NCoRtVeadeNqr4MBkO2rbbag20OLC5AkrtOJRR
        WmU8f1oT0TCDWz4OntHz5pc66LgO2dM=
X-Google-Smtp-Source: AA6agR6kjdobyiUHmWMfd94k+NaVvfByk21uAIDAlylPNPKxgYwfF4U4vwNuYY+hDm8vYXqn/nNnXA==
X-Received: by 2002:a17:907:dab:b0:73d:5ada:cff5 with SMTP id go43-20020a1709070dab00b0073d5adacff5mr10120307ejc.275.1661218280038;
        Mon, 22 Aug 2022 18:31:20 -0700 (PDT)
Received: from localhost (vpn-253-070.epfl.ch. [128.179.253.70])
        by smtp.gmail.com with ESMTPSA id bi4-20020a170906a24400b0072af4af2f46sm6782616ejb.74.2022.08.22.18.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:31:19 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 1/3] bpf: Move bpf_loop and bpf_for_each_map_elem under CAP_BPF
Date:   Tue, 23 Aug 2022 03:31:17 +0200
Message-Id: <20220823013117.24916-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220823012759.24844-1-memxor@gmail.com>
References: <20220823012759.24844-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=memxor@gmail.com; h=from:subject; bh=i9XsXlrauYqZVhAtHZgDG3t3go7UNmDH/TPP+h/wWnk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjBCbaHdVpVhYSQrcoRERNcValxamu2SeAqeJu7v3j OZeqE06JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwQm2gAKCRBM4MiGSL8Ryt9QD/ 4q28YSl+SuyPqoWEwa+zJ2BJA/8IDFVDuohh84yagNvIrauODv2Q2YKDOdGlOi2eWTN4oK7ynmRn2g LZsJSYuZbW/lcumKp/FgbK2RR7QKJe/Xi0cPn0NNuKtpxJd4vT5XRGJzA5EF5K38AvOtZFmEj9YSEq Ce8OeZlQb9bTEAtQOaa4Y9kYuxIzI1g0mwiumN1VbWKgRmnFQJSrAClqmod2hzaFoJvxAJ0TVDZotK mD1STYjhxXGrNvdRbmGgSL9oWKDh/gIz7RwqD2uqEurY4WAzBJl7uYQcZK2tn822Vs45yb2rOjT+vB x95kNAU0YtDZjuT8YLgZl5aVB7Rn+cdrkhRGoUNmHRnJayq2L5XLAkOvhHF2ntZc0//uGameCbEjzL PiyPo1C2+4dgm9ZREvklCgbEFwTsqoXGDtiUUhdeZys9ad6d/QENr8cK2g2PRX8/GOt0dbobMBAAWN y/+FMGrExkUgX47g90W/LYzvF6Jy02x1h8PT1LJqjFIVV8fta0l1XZfvgJlQ8urAiqt0bakNQAFW1K ZEZrE4d+9cTfnKM3cn7MtRryxQTnh+b/EpQTHwOdWgIuVkPImKg88CV96I9JHDVh+zKNITqb33KO9o SCe15uZvMxw3vgJ0kIlt1YRONX9voCOVYMSl3mypONsu6kpgVVBeDATziqhA==
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

They would require func_info which needs prog BTF anyway. Loading BTF
and setting the prog btf_fd while loading the prog indirectly requires
CAP_BPF, so just to reduce confusion, move both these helpers taking
callback under bpf_capable() protection as well, since they cannot be
used without CAP_BPF.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1f961f9982d2..d0e80926bac5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1633,10 +1633,6 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_submit_dynptr_proto;
 	case BPF_FUNC_ringbuf_discard_dynptr:
 		return &bpf_ringbuf_discard_dynptr_proto;
-	case BPF_FUNC_for_each_map_elem:
-		return &bpf_for_each_map_elem_proto;
-	case BPF_FUNC_loop:
-		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
 	case BPF_FUNC_dynptr_from_mem:
@@ -1675,6 +1671,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_timer_cancel_proto;
 	case BPF_FUNC_kptr_xchg:
 		return &bpf_kptr_xchg_proto;
+	case BPF_FUNC_for_each_map_elem:
+		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_loop:
+		return &bpf_loop_proto;
 	default:
 		break;
 	}
-- 
2.34.1

