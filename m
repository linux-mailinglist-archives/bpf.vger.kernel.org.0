Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F5662EB74
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiKRB5Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiKRB5Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:24 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C19742F4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:23 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id k22so3543066pfd.3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bydv3kCbIfnpZJCDWVNSsOM/hEDP+5Rsyiqy1sq5Ic=;
        b=DhaPupsE1OeEt/YagIIhPRpWnAeabHRYYWCcU2gMumxfrMnxm6ppR5b5Fo7KHTGAkx
         vY+cOYK3ho4LgJfLTm7sp6ieElWkF+k1zxbYnaJJOGEBFjh8pRtV5ml6gq2AwhWWc5tq
         ggv6CN2EIO+gZ0TkfRq1+/lgqVS7855UQozSPp7D861JpwYbFKUkLfkPjQb0hRa4j/R+
         A/Ff6PhpNIesPTtUH/7fey8jW6INhL7jissm3UtBz+gOHunyrTal/d0usmKU4PkVD/Lt
         jA2RNqDcworUfGVVSCCWB4RCuYH4snVJAdCOP5PgWbgdkL//UVwoWrgPpGz1a02SVF4/
         +1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bydv3kCbIfnpZJCDWVNSsOM/hEDP+5Rsyiqy1sq5Ic=;
        b=fjlQoUBSNL+rN2OIwQfdxDDyiuDIZJGbdfmajTnebSkFZC0vbscZ2kYHyCELKuTvrE
         O70QpOcpwcagZotRIJjZuKgwZTrzNRC0o4+f1c7oKZEwQ/MBci8yqpmEDIbuhHbUAYAp
         STj7weoxvdqRulD4QYAL3Ky3hIkY4+jfxZntkdD7udp1oxsdMELv9l5wawqd1lB+lZOM
         Jk5SrHo+Td8TGxyBLmISPyr5R32vvBT2lKViq4Wym2HnSPAxtoL3QIrlGOWV/XLkNI2b
         QCS1DB0krAQFsddkhvSQj3PYKjMIM44HSYobMTzLy0dNvhW/G6o/yLUA3VFluHew21j9
         upYg==
X-Gm-Message-State: ANoB5pkkmfhWQRC58ql30AzuLb7j739tceh5kHK6tCH2bvnWwY5AYHxz
        CTQfOaWcEqzGTh0WRsZ6RPfD8rf9Egc=
X-Google-Smtp-Source: AA0mqf7U9bG5hRuGfm+pYG/2X8o1cLbj03ZncdqUo5mw8dZkQMVXYpowQLTGRq9K4pOu4qErzPg7hQ==
X-Received: by 2002:a63:2787:0:b0:46e:baec:59bd with SMTP id n129-20020a632787000000b0046ebaec59bdmr4551692pgn.528.1668736643231;
        Thu, 17 Nov 2022 17:57:23 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id a13-20020aa794ad000000b0056ba02feda1sm1895616pfl.94.2022.11.17.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:22 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 19/24] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Fri, 18 Nov 2022 07:26:09 +0530
Message-Id: <20221118015614.2013203-20-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=memxor@gmail.com; h=from:subject; bh=QUh2azS5YwjYBzJI16lM6Jjvlpavd9KadUbWM8+nCmM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXPSV6X77+yli7nBHANFRr4j1zNcbG36mWEM3uR skI91oOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8RytKhEA CS+82z3iIdgGPflJcfhPpXDmGu1c8Ci4fHfiVXwFCLTz1VY3ghHNx3O8SOPffc2Sq/Fd798IzPJmEg 3hBfnKJ07/rzsqS2iYKEAAl5XlABvPEzyoZ9K9u+05lgZQU1Qknp2/5+3hM10SDGqyl+biUyDTZAwV g1oURZMt7vbb2uHQL6woAEgJoSh5f3ZZ2AbtBoQzk1RFlwgPylhrOj69zyOX5xNMSWeyj+mrsAc8zY P0Vilclz18IJkohjrAN0cSRpWMU+/KEKJjw1D1JwINLsbuiDlT+BCfjPBggLCCCiTj5R3S/8+ulcvv 279QdHs39RKHQXcj5dKfD7QU0S2lcKwfr0PYMKQ3Pv9pm/3PwSxC37mgGv5IT2X0cPo/e/pJH3+Xy/ 324fJZJNtAICcPS5XGCdVk3lA9jatIs1UupzpFS706SUBwnhymVgtosKv/wFE0OSsNxtQjylsEw7JS f3EnhX3ay2E5Q3P9+lsooGgLq3Wo1yfjCg9gj+6zoFy8SSdIeav1FniKLQmJb2109ROAPgJ8rUDDOG 6lasjaPBoj6xh0K94/fKJlcLJsY+PiB9q/oK7F+38KY2tzxtJPcGdq3b9PUNkOOWP11CpxKeZIoxAp oK58s6dlWGvnPw0wzQ+ys8GaHrtEsWhz1bzQWL05Qv2Kb3qjdsAGfCmaQ0kA==
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

