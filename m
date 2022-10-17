Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E9E601D84
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 01:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJQXWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 19:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJQXWG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 19:22:06 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C616A49C
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 16:22:06 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B2BA0240026
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 01:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666048924; bh=Nzfc8ODTGKJJ2cdjHt3x6ZMfBSOKK1aykVOtNIKKOJE=;
        h=From:To:Cc:Subject:Date:From;
        b=V/fIe/mq0XhVIldWx4IjM1Zq/1PESRYRcUZddW0oer5lqVsjHDQj5vbYLb2cvi9TJ
         e8aD75EWePHmrfdDRE/fG/G9C0IAyRQAGU59vmmyejDw/TNbd6RjoQYKm8LUzNB6GO
         Hcs3xth4B4q1AiDhGupKYFl5lvubK6oEURH5/Rt9ifvMs+oKXWrwDtK+RvG7kzB67h
         7epo38N/UKcgUK0tsxhOyT6Nunn47CXQHrw38mTuvv4FSs0IYYKk9Vc0WYp+nGITQC
         nG5op7aJvMubCGQiW+dRTvg2HX708pFE13Jv8+C3HcwzsAszNXZNsBKrBWIGaDypl5
         +5B1z2VmyhpoQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MrtLM6n1zz6tr3;
        Tue, 18 Oct 2022 01:22:03 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Cc:     deso@posteo.net
Subject: [PATCH bpf-next] samples/bpf: Fix two typos
Date:   Mon, 17 Oct 2022 23:22:01 +0000
Message-Id: <20221017232201.1257089-1-deso@posteo.net>
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

This change fixes two typos in the BPF samples README file.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 samples/bpf/README.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 60c649..f98c26 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -37,8 +37,8 @@ user, simply call::
 
  make headers_install
 
-This will creates a local "usr/include" directory in the git/build top
-level directory, that the make system automatically pickup first.
+This will create a local "usr/include" directory in the git/build top
+level directory, that the make system will automatically pickup first.
 
 Compiling
 =========
-- 
2.30.2

