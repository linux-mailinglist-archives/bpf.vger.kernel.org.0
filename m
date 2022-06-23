Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA53558AA4
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 23:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiFWVWi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiFWVWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 17:22:37 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFB156FB4
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:22:36 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id C1386240029
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656019354; bh=Z2ghHnHk0epn5n04c6qY1QFCK7go3+8p1lg5DfFcm4M=;
        h=From:To:Cc:Subject:Date:From;
        b=V/FwayzgrrtdrDxKJCoLESXL0ucoSuzbL4L1XLERm79PJGK5RzncB4HnFdugK23N7
         p1Tt9vKHTc7k6htCxYMMLgQO85XrGCFTTkKwbkHe0MLdRLKo1ZjH2Axhg7bAQUb5Vr
         6rV3BtjbxClfe2LMI34qbohFuBpaH0rDbBWkSajW6R8Zsb4urdMa964PFrUReAcpt8
         URjGOXmgzR/6CHWE10D5pwSktBqAjdAwNpi02l3PknkotzOXelEHGbgAeo1PTYEFQd
         OuUwOJe6sn8FAMU8KWdgdtQzwKgLcnAgIdaixXASBdVYQo7uLXz8pN3RiXbnutL1mJ
         WVd7RQvKTqbxw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTYB20bn2z6tmq;
        Thu, 23 Jun 2022 23:22:34 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v2 3/9] bpf: Introduce btf_int_bits() function
Date:   Thu, 23 Jun 2022 21:21:59 +0000
Message-Id: <20220623212205.2805002-4-deso@posteo.net>
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

This change adds the btf_int_bits() function to include/linux/btf.h. It
mirrors what already exists in user space and will be required by follow
on changes.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 include/linux/btf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bfed7..54a65a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -242,6 +242,11 @@ static inline u8 btf_int_offset(const struct btf_type *t)
 	return BTF_INT_OFFSET(*(u32 *)(t + 1));
 }
 
+static inline u8 btf_int_bits(const struct btf_type *t)
+{
+	return BTF_INT_BITS(*(u32 *)(t + 1));
+}
+
 static inline u8 btf_int_encoding(const struct btf_type *t)
 {
 	return BTF_INT_ENCODING(*(u32 *)(t + 1));
-- 
2.30.2

