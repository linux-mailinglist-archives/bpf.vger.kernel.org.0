Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD77618857
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKCTLx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKCTLv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E691DA48
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p21so2836781plr.7
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYtF/UXw0qmYd1/zuW+uh72Hu3XMpXMJLuNN98J9FJY=;
        b=DyGya8POuJz/ySqmBDysM2sFnwO9A75HupcAwY972HfdQ7Sp749s2w8hDdI7SsLrvp
         cPjYSJ9YrkNA5Osf/8yvbv20tLuO5BkbBp2yxoxZmedJkc4cvYMr/WZXmrADB8o5tfQX
         njpMXd303FIl+2GeZyXx1sMbqFgO6O8305f4B0ifxc+7Rw5SvzAwQeJ2pA3sT1K7G9ng
         ZKBsJldE8aMMwkppwYlzB1fGMG+3hpMuuJcNkGk6QEINkxl0+zHyHodaKbWiEL0Dc2bk
         lGVzi5iw3Ab1yFEKSb7d1VLZcSI9sMbySmozkSwC/ar+xg5QdDD2O82mo4HEZeR3KCoL
         fQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYtF/UXw0qmYd1/zuW+uh72Hu3XMpXMJLuNN98J9FJY=;
        b=OuFD4fV7ebTjPKOnRWDIlHtgbG0VFkId2jeA87wQjL1bAHJk6L6lKlnPY010JbGAqG
         CqW9uTUkGpxp/xvcFntU4LYvpF9HujHWdlTMeMNdsAlpaYPhTRj9AkfhUONnM/vhPH5R
         sEtuQmVF+YIeSmNFeVYtBq9C0zNarYvsbanyKJ0HbA00YKIR0jdfCIeajSviSLJ/jGlD
         UXVKoiqiFiUZWQ17glE5txeAOj4fXIBSZE1+0JIa3o4AumqHvjM6Wm/Xma6ohJkYNOAz
         oCV4b0og9sKLUAl9rf/wymbjvJRYpaCnMo1855MjLduO3KPRtDuYodbuojNE0pBNF423
         2b+w==
X-Gm-Message-State: ACrzQf3Er2Z3+B2f5hyESeFf04nxDpC8YLICccF+bYE2JEVH5yX89U1l
        eXufk+2ioiyl5YBtNpy/w603ykW9Gl6LFw==
X-Google-Smtp-Source: AMsMyM7Zl3218PkSNR1KeRWvoYdrLlloPdWTHGsUhwPqpkJBY7cgNJEfLaf4beZrheXzlspk1FRbyA==
X-Received: by 2002:a17:902:e810:b0:186:e9ff:4ec2 with SMTP id u16-20020a170902e81000b00186e9ff4ec2mr30599663plg.26.1667502710565;
        Thu, 03 Nov 2022 12:11:50 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a39c600b0020ae09e9724sm308489pjf.53.2022.11.03.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:50 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 23/24] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Fri,  4 Nov 2022 00:40:12 +0530
Message-Id: <20221103191013.1236066-24-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=memxor@gmail.com; h=from:subject; bh=Io4vqKrkd1wDTzE0Rs4W9/+sNb3Zdb5AncG3KXVOofI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBICXNYEiYDxNVYDibmbUKaS47MCCg9fdooXNrUf FL8HCdKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAgAKCRBM4MiGSL8RyvH5D/ 9iHezgBLnJCLRLVu8C48XX9o/PgIanV9cD8wyP+CLtWhcVH2IQID0pdh7NQQpwmE9ReV4T2rDPZOSf doEK+WoU4YZwUSrxxiTEKNK06Wyer3ggEWEog3gSBYp4L6rtKDVejOBij9W+jmcSKFI0WguOn2LplF +LjB71nY1JZ2+mBs/fcWHsrVqD8fiCFoxJw1SsZD0VbfYLdngwQE0TaUJC3RKfJbA0bZZw2YJxZdA7 rzS9qJrOljmTrXBXczpanOrsL8HFj47u6X2bOD4pvr+LkscQi7/8k3Yb3oNImMyIFEZIgCOTZNeh/K ud4xJ81Qk8brec+npqXUZfBgmyxaQoQ3J5Z0idompwg1LwtEAlOou1gSJv0M0tXf1JLsg2wzavDfNh fg5nJivJ3I6Lz43YHKZm4wnfV10pqU9OfmApo8buqqiUFvrrRQNXeBbkM99Ky2Ph8qC7LKlhFGPZWV ajZ2V8YpqHlj4/Y1vUZkcM3CfwCoEX1/pH2Pah86IR/8pckGbLwQA1CPdku5UYKL4FA44yWBWneDAE IgQ+av8WOR1GHW7ZfpAyZHd1jNPUotLh4h4LZCCNJYz/IS5+KGjBxw/PC0OPyQR9fwfK/uAlGlneeC n3W+RGvGSTuhxdEn1evQIKqdz0MLUdjZQEK0x6huIq+HpGdS/RvQC69bqlkw==
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

Add user facing __contains macro which provides a convenient wrapper
over the verbose kernel specific BTF declaration tag required to
annotate BPF list head structs in user types.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4a76c64e50ad..3db1578db2d9 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -3,6 +3,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
 /* Description
  *	Allocates a local kptr of type represented by 'local_type_id' in program
  *	BTF. User may use the bpf_core_type_id_local macro to pass the type ID
-- 
2.38.1

