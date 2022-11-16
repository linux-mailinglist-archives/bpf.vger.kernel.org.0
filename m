Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72562C69E
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 18:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKPRoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 12:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiKPRoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 12:44:12 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E657E019
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 09:44:11 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0242524002C
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 18:44:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1668620650; bh=AH/hAIBswvARWgzvBJE3iV9aPdnnP096ae0gtREDiwk=;
        h=From:To:Cc:Subject:Date:From;
        b=jyCB/8lKBMQEZ5T4sHrQfFfQil8myanRc4maFECjT5VATFKycpggHGNbQJ5ue/ZD4
         dg/rziJ6w3C8dsgJvkUBovqI+O/ajN47bWTIFA/5E0X5klgFTh1jbdj5j0eTrgnw5K
         7/U0NI3j2UHulxu9kwe7jq2yybQ9ZkzMPiKZELXWvnXBUNN51JbQ8D5ngKUEBwARNS
         Gxogcyh6dxKi7qkp0bqev8PDHHitfBNZ34Hcd5L4cuC1mnpLWsCjBd8tIiqYkBFZc5
         aTTxIyky/udRy24PEyDbUBaiaaddcGYtk/OMCIwyPMBswqnZZzUvEyTYZ3j3xxtQTe
         YgtFkJUuIC4Mw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NC9Qc2ppsz9rxL;
        Wed, 16 Nov 2022 18:44:08 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Cc:     deso@posteo.net, Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH bpf-next] bpf/docs: Include blank lines between bullet points in bpf_devel_QA.rst
Date:   Wed, 16 Nov 2022 17:43:58 +0000
Message-Id: <20221116174358.2744613-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 26a9b433cf08 ("bpf/docs: Document how to run CI without patch
submission") caused a warning to be generated when compiling the
documentation:
 > bpf_devel_QA.rst:55: WARNING: Unexpected indentation.
 > bpf_devel_QA.rst:56: WARNING: Block quote ends without a blank line

This change fixes the problem by inserting the required blank lines.

Fixes: 26a9b433cf08 ("bpf/docs: Document how to run CI without patch submission")
Reported-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 Documentation/bpf/bpf_devel_QA.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 08572c7..03d499 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -51,10 +51,13 @@ While GitHub also provides a CLI that can be used to accomplish the same
 results, here we focus on the UI based workflow.
 
 The following steps lay out how to start a CI run for your patches:
+
 - Create a fork of the aforementioned repository in your own account (one time
   action)
+
 - Clone the fork locally, check out a new branch tracking either the bpf-next
   or bpf branch, and apply your to-be-tested patches on top of it
+
 - Push the local branch to your fork and create a pull request against
   kernel-patches/bpf's bpf-next_base or bpf_base branch, respectively
 
-- 
2.30.2

