Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91BF62E8D8
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiKQW42 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiKQW41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:56:27 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDB062CE
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:26 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y10so1804260plp.3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bydv3kCbIfnpZJCDWVNSsOM/hEDP+5Rsyiqy1sq5Ic=;
        b=FXfvG48rfXSGFzoMkxHqRsB3j1PENVIx92Dh1elmyr3wYYARq5m8SOEVICrsJljj7g
         TMURI3AB/RQkXY7JBSN0d3Q/AauGGeaxXDZ5nlKBFueSluznX7FsynQXM42a+lgMQxGj
         y/YgY2+/IvBDv+8RJpjayrx7BxULL7Ff6xtDt11iqoU47k9iXSlsIxduafi90ZsW2ohK
         QI/jaXYvgmP9XlceIdDnkCEKZduca0DJkdJumP88FCsDzqPxH3UdaPAxq3igmFYbOx1+
         8guF7L5FqtPryzPfM0ATUOVGdkRPTfFtR7Jtf/kWy7l5lLZ8v65zbjyQTq2hD6djLcUh
         LrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bydv3kCbIfnpZJCDWVNSsOM/hEDP+5Rsyiqy1sq5Ic=;
        b=Yap7l1czVUqKv7ZTJQBD2rb8vjzwp0rmn8K9Mle8ODswRA0CcGdKOGIdR1gGwUarYx
         uKTFihlfOw5i3SoxtgNbqxmANRerMJXBUg1CE/16KUpWqZ5PSFznCYNSlbKLtN2PUjS3
         nWjc7eD2m1eRz0V/vJorauv4iSHc6C5www+XMHWM+SNzsqeLGLnAE/6BOsJ/Qk0QqM7g
         WR5wPRfTgZKGtrPBXnSCLex1noA0IA0ubBLlGQJdCwBS5418Zj0qdmephaBBJ08Yayve
         UKj1jKhgEkVgZR9ftaGiey74n0iBtwo4I+ND1y3FmAiPuUiMmhDu28tSbZT0q2z9hnNR
         j0OA==
X-Gm-Message-State: ANoB5pm7yC+EUn4Sn7jNOENj45QqHqeSemfYW1f2Sx64J9Jtsb04R2Wc
        ewxSAvPDgcmyRE3cEwuY35ZPAz4tYLo=
X-Google-Smtp-Source: AA0mqf6qqIRYMQBfFWnkue2HL5zRcCsULYc9LVqze+KXx0KbwkMvhW78IqnwR5Ml6zHLK+csHQd2hQ==
X-Received: by 2002:a17:903:186:b0:188:4ba9:7a04 with SMTP id z6-20020a170903018600b001884ba97a04mr4808389plg.45.1668725785814;
        Thu, 17 Nov 2022 14:56:25 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902b68500b00186b758c9fasm1973844pls.33.2022.11.17.14.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:56:25 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 19/23] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Fri, 18 Nov 2022 04:25:06 +0530
Message-Id: <20221117225510.1676785-20-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=memxor@gmail.com; h=from:subject; bh=QUh2azS5YwjYBzJI16lM6Jjvlpavd9KadUbWM8+nCmM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkcSV6X77+yli7nBHANFRr4j1zNcbG36mWEM3uR skI91oOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5HAAKCRBM4MiGSL8Ryl3OD/ 9wzb1ECpzmofiV0Q34owbSya6qKlcmCoyUxtfn8oLlm9JVOzV5OLThrx1oqVk+NkaT9qx6CqtnnKg/ Y22d9/SdlqiYWRwlygd+Z03jGD5n+VUMMdlTg0GFHKI7woM35/YRq1Vn0/orgXMPx+FeZ4tstgQbx+ 4uKVR7xBDd7MbEvnGJtWG66z038q58Gr1txUnWepMz7cBTtbwswbERRbg5a+dqcbmb3dRkjBAXgTtt Q6qsBQI3se9ryB3JXA38KbonUR+a3+P9LClOQn2J6HmwcIyY0hs/GBtHcRIzir9Fn5wgKC/gJ3H71j fvUJ6TABTNnMiyf11fsgsgYpSDxE6QObj0zwE+2/LeCTNikVMZiLBW29sV0r7vUgI8VAP2QSdHHUYH AGlTmgSc9EblFt7FtU07BdZhwfgjnJIucVm0KIL/NS374USJTjwNnSKiTkK0xspD08EXB/ebp5hrUt NsO9HBFHaoIG/xM0i3hMl8piWsYlW482bM7SBM1aZArX3yFS0HcA+4G86/BBiQ3U2lVT9zXlxnDkzo Pp5B76wJ4HfM3xDAYeR8mnbrDtYN+p1c91Wv38IMjnediRknj2MR1hxWqHigXbgUvd2AoyCwJpeO2j xMwIpue0BV5cPHdjpeP0t5yIw8bf01QOkAffGo3j/XBXJJKQWH1t65XjMe0Q==
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

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d6b143275e82..424f7bbbfe9b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
 /* Description
  *	Allocates an object of the type represented by 'local_type_id' in
  *	program BTF. User may use the bpf_core_type_id_local macro to pass the
-- 
2.38.1

