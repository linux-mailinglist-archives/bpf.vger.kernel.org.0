Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E7155E742
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348251AbiF1QCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348324AbiF1QC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:02:27 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98906377FF
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:01:53 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 046FF240111
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 18:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656432112; bh=Z2ghHnHk0epn5n04c6qY1QFCK7go3+8p1lg5DfFcm4M=;
        h=From:To:Cc:Subject:Date:From;
        b=ecFg9Hpyu1BNQJwNAU2hZANwFJET0DUOVr3JKSOmIAFOFzriujgUYPLzPwHSbzwWq
         WLtf7OJwZWeSPKJCBC1R9l0eY/+faZsCjDQidnOg1eokhsJdi1YBZz7HP4Zfc89AoM
         mGqU+FPehoeV1DlWwbEJ7OsAHKTOhHuH0GrFjufNA++yVfoExYVJMGVSR3hfcZK9nY
         k47Zs+NWCq3/uPsqEPsbTvmegAR9T8/lMZs+mv3bcdM4iqXeepL/a7zZIu9kYjL6KT
         L0omLCRxBfJcm6762nDBbFKZ+6W1gJIhEXR5KTDr+h3y3vJTD71ndpydk1FdmJRVDo
         yUDjniok43lSA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LXTqg1yHVz6tmf;
        Tue, 28 Jun 2022 18:01:51 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v3 03/10] bpf: Introduce btf_int_bits() function
Date:   Tue, 28 Jun 2022 16:01:20 +0000
Message-Id: <20220628160127.607834-4-deso@posteo.net>
In-Reply-To: <20220628160127.607834-1-deso@posteo.net>
References: <20220628160127.607834-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

