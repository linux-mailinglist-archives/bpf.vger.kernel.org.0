Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEA65FD4C4
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJMGYx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJMGYu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:50 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCDC1573D
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cl1so997941pjb.1
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+3Ea7YUQetoMqv/SAe7B5+usBisfw2LsQ00VGJwBfQ=;
        b=p+Bdx3d5WAmIDxib61iCaWW7l467W0wsFdkZdxYaSPJWp8KvbhoUas/LnV5Zy9kCAr
         QhRH1xAoMbN/3sKY5UuEKj7K5oFEAWeiDeUw5iMxllBENRDe1amEiv0ThbTg8ACKrmOB
         HvQILOd2eVG8j5y9gZ0Q6GpsrPBfUfFmai3+dfqmAAUGbojWPSo/yFJFgLCZwphQi02D
         kRpu/uZwjTAYvjkFIssQxeO1KgQZjvAj1X2t06qAG1sPg01lmMa2zYmVIc0JRweNw45p
         h/l0T9lij7pAXb8+9xI527SrAX+8LCGWPBE8Tu3LlhSfEBS7fpjYxYLe8K2i2CYn+KFS
         TH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+3Ea7YUQetoMqv/SAe7B5+usBisfw2LsQ00VGJwBfQ=;
        b=QChZQLLS6eG+NKR4ThEbJ1EPWJayjpPpKXOJrPIlZGgWXMLMxuz17tyNGs9lDp7OCF
         W5PmL9eiwupcE77pg49hIazSG5BdxAt9w3GehBcloa52ym8JfbGoLGVvJ150UHkI9iAx
         oSNkculhIX4wSf3QJB6f5rrR+So0munrhY8bBuEZ9XdJLk53IqNPkcBPTsVteKsV84tn
         +2TnwUO5nZlZEP7Xf1aM4V4sBgcCF/O1tUSZNLFrDWuM8TKhQlCFXeIH+o+qt+UN6vWX
         uVfyUYFf9AwS3N0HHAUHJEbbgWU0GSe7PAlsjYUcx21zUc7HlBGCpdI4iSGO6l072egJ
         PIWg==
X-Gm-Message-State: ACrzQf2RQFwt8VkI3qegHw4A9CJWTENSrWoSFG6R8FUXybdG6Ta0zfjW
        qOXLfsSuglqvQpbjUH61RmT8I+ZECH0=
X-Google-Smtp-Source: AMsMyM4x4cTkvRGpkkWds5htJk3Dj1mJ8IOp2nSHuhCAp+pcnZFzWeauVqW5RWwA0j5Kcd+6uqpgrA==
X-Received: by 2002:a17:903:41cc:b0:183:5a22:c633 with SMTP id u12-20020a17090341cc00b001835a22c633mr14973841ple.164.1665642287264;
        Wed, 12 Oct 2022 23:24:47 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id k29-20020aa7999d000000b0056186e8b29esm1022778pfh.96.2022.10.12.23.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:46 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 24/25] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Thu, 13 Oct 2022 11:53:02 +0530
Message-Id: <20221013062303.896469-25-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=memxor@gmail.com; h=from:subject; bh=8b11dXInfjXrztN+2AuKMJ4sXcj24tJVDBWU5z/DlX4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67EUwxD5Ivls18jpCZBXsVcxM0JiJerJIsIQf7h FxRYjliJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8RypotD/ 4vT+WW0s63O+B38rjv3xwnpmKcIXJdp1fIq9vmElIzV2WXD1oo53fkGH9UE1Fy3XAyzdu+tul6nK1i KbgnKQkfbuhUtYsQu2doaadvo5Ukn2WUxUPTU0O0R2MOG/62VtdNyxEpizyeW2LBEmJmEtL4Xy06va KkYeEC8yqTZLk8EDmnete9/heqO5O5FpZ0yyINea69LrvV3AYAza4GYWBJ/8W2j1v4JAR/H1O9W3Fq sl5qHHxwu8r71AkN4wUr7+gsZkYPiCAc8nGIV2rpoOOyFbfc2nyrC5E6e3fcwkCNQt5sXbXufqLpkp FdQKG8TPsqnyno2vGOOKFjAA37nTN/fFGQjhDEIxBbETj8Vwv5NT/cdpV2JFFXAHa/DVZf+AyNLcEV eydozuvyQHGlPCszM0VXPGKeaWFAHkUdy1ie/nxw3nlls1hjjEgAu0uM6ggweaedsMcKcey5QuiXwf FNhKu5YMhmny7NGAlRANMShrQyoRykGMb8bOJ+6x5YSv926/3fvzb7oWCTPb91ih0SmC5WMXhvmQeL LU95QTM9fk1Rysval9VS7fXbnFQqkSpGiW0Eq1id140MnZSUwctNX2l2o1mjz5a+LCM1ntitsG9VYA 42aIXWtvF3Xu8IXQsluFvNTKe3c3kKlspqRkfy2YJ6cj6dP398vREye2RMbA==
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
index 21b85cd721cb..dc71b58b123c 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -5,6 +5,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:struct:" #name ":" #node)))
+
 #else
 
 struct bpf_list_head {
-- 
2.38.0

