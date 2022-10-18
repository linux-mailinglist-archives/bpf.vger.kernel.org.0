Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBC6030CF
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJRQcw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJRQcv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 12:32:51 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A46DC06BF
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 09:32:49 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5209924002A
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 18:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666110767; bh=G+HDyOdBQ0f7n0MGSdtmfjbPB0H1+wdIV70H6C5JpDM=;
        h=From:To:Cc:Subject:Date:From;
        b=EKF2t4iFCM66mABCvFP5A0qQEs/MtyWfraFAx0ww4vuBq3RpIQU923Wgj/nNTRaaj
         Pgn1NuEjeZ1hrqpJ7/z/0b3+1UoDqQgw9Fv5tHPhfq7eqewIXajXPrAiqYV4KFJhwB
         VBWdQQ/s1wfnzA3JcG+JKTKyfWhHmDZxnDZEsqfTSkKpEGZARUhdSkoFXJSMMCf9Xd
         2XcXnQT69lzo0gn0RULbCkEyu0Hwstl4UrxcuxvMFJ0B/sC0Pegf5tvbL+0/m+CZl8
         beAUhl7yiguxS0r0478HgS6mJbnnWqpQrwyV50jHeFz8oW9ef9D4BlKeZh5nFPhfJO
         FBTow4IIFrQPw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MsKCf0v2rz9rxT;
        Tue, 18 Oct 2022 18:32:46 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Cc:     deso@posteo.net, David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2] samples/bpf: Fix typos in README
Date:   Tue, 18 Oct 2022 16:32:31 +0000
Message-Id: <20221018163231.1926462-1-deso@posteo.net>
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

This change fixes some typos found in the BPF samples README file.

Signed-off-by: Daniel Müller <deso@posteo.net>
Acked-by: David Vernet <void@manifault.com>
---
 samples/bpf/README.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 60c649..6cfb74 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -37,8 +37,8 @@ user, simply call::
 
  make headers_install
 
-This will creates a local "usr/include" directory in the git/build top
-level directory, that the make system automatically pickup first.
+This will create a local "usr/include" directory in the git/build top
+level directory, that the make system will automatically pick up first.
 
 Compiling
 =========
-- 
2.30.2

