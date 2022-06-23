Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72640558AA6
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 23:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiFWVWn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 17:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiFWVWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 17:22:40 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150894DF46
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:22:40 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B4D4A240029
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:22:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656019358; bh=13z+K4njtIfx/wWw8OlBFQPCnKQNDKrac+Iq3GVZknM=;
        h=From:To:Cc:Subject:Date:From;
        b=XYwrt/Y8l8VCCnMsrNMiKcf1w/k7bQHSg6/vf7u2MFdpJmAa6PNTuia9i8zXpc4HH
         MQp/Q0UWYJqcv5cJHyGsosikK/BWusCV82VyD5OjTZJ114GOTQB6lEf0Bp9hyetOJQ
         0IF/vRUZa89bnToUlvpPXNmuzG4nclZdH3dp1wz2A340K4DicXMR60ttzp8U+r0UkE
         B8CPFKDURM/+t4Fzq47I2tCWAyi+hck9RC8Xu/RYnaOX5zkbY/ulpZ68WcB4AJD9u5
         c5JIGLZzngO+vWcrPC2e+6+6BEmkfNF/RFPnWfHAZPXTQB2mMs6zQiDlZKv1ON40zt
         /z9Hoke5Bh2Tw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTYB612S4z6tmb;
        Thu, 23 Jun 2022 23:22:38 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v2 5/9] bpf: Add type match support
Date:   Thu, 23 Jun 2022 21:22:01 +0000
Message-Id: <20220623212205.2805002-6-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-1-deso@posteo.net>
References: <20220623212205.2805002-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change implements the kernel side of the "type matches" support,
just calling the previously added core logic in relo_core.c.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 kernel/bpf/btf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f08037..d06855d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7524,6 +7524,15 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 					   MAX_TYPES_ARE_COMPAT_DEPTH);
 }
 
+#define MAX_TYPES_MATCH_DEPTH 2
+
+int bpf_core_types_match(const struct btf *local_btf, u32 local_id,
+			 const struct btf *targ_btf, u32 targ_id)
+{
+	return __bpf_core_types_match(local_btf, local_id, targ_btf, targ_id,
+				      MAX_TYPES_MATCH_DEPTH);
+}
+
 static bool bpf_core_is_flavor_sep(const char *s)
 {
 	/* check X___Y name pattern, where X and Y are not underscores */
-- 
2.30.2

