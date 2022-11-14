Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EB0628B2F
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiKNVPJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiKNVPI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:15:08 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AFCBE3F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:15:06 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 30318240029
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 22:15:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1668460505; bh=HQgJxL/7O7ESpql92rC7HpGK6rpLqibePeK+GBQ863k=;
        h=From:To:Cc:Subject:Date:From;
        b=PSWrIyMYswBapTRHjTurtuRqpiMnrIKqH7Rklq0xYqFlJT3flVqdeF7ZOwP33ZMao
         fAdaOhC0TMEfKhobCBf1n+6e9bQXpSEV1AV40U1exDMkr+qZsMEcr6wkRG5QNulo+N
         skCNslrZhuxgOr9Ibpbbb09y0w+vmWYXHHJkCzGdB4IniUrLjOdMKXFVV+C55mXpwy
         m8WCH1BLltDSSM9frHlWW6vvLiN0FTtk+9RTQXkiC9QjZEEgYsLnE62X6ui7LZLS7o
         cz5qZLxd8BddBBEHKoMdPO9AYWsR0Jx9Y3kzdS4XZByCmd05gHVApDGPCxMTsZ9Ezt
         HpMlWoUt5odeA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NB2Bv5Qpbz9rxW;
        Mon, 14 Nov 2022 22:15:03 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com,
        quentin@isovalent.com, eddyz87@gmail.com
Cc:     deso@posteo.net
Subject: [PATCH bpf-next] docs/bpf: Document how to run CI without patch submission
Date:   Mon, 14 Nov 2022 21:15:01 +0000
Message-Id: <20221114211501.2068684-1-deso@posteo.net>
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

This change documents the process for running the BPF CI before
submitting a patch to the upstream mailing list, similar to what happens
if a patch is send to bpf@vger.kernel.org: it builds kernel and
selftests and runs the latter on different architecture (but it notably
does not cover stylistic checks such as cover letter verification).
Running BPF CI this way can help achieve better test coverage ahead of
patch submission than merely running locally (say, using
tools/testing/selftests/bpf/vmtest.sh), as additional architectures may
be covered as well.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 Documentation/bpf/bpf_devel_QA.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 761474..08572c7 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -44,6 +44,30 @@ is a guarantee that the reported issue will be overlooked.**
 Submitting patches
 ==================
 
+Q: How do I run BPF CI on my changes before sending them out for review?
+------------------------------------------------------------------------
+A: BPF CI is GitHub based and hosted at https://github.com/kernel-patches/bpf.
+While GitHub also provides a CLI that can be used to accomplish the same
+results, here we focus on the UI based workflow.
+
+The following steps lay out how to start a CI run for your patches:
+- Create a fork of the aforementioned repository in your own account (one time
+  action)
+- Clone the fork locally, check out a new branch tracking either the bpf-next
+  or bpf branch, and apply your to-be-tested patches on top of it
+- Push the local branch to your fork and create a pull request against
+  kernel-patches/bpf's bpf-next_base or bpf_base branch, respectively
+
+Shortly after the pull request has been created, the CI workflow will run. Note
+that capacity is shared with patches submitted upstream being checked and so
+depending on utilization the run can take a while to finish.
+
+Note furthermore that both base branches (bpf-next_base and bpf_base) will be
+updated as patches are pushed to the respective upstream branches they track. As
+such, your patch set will automatically (be attempted to) be rebased as well.
+This behavior can result in a CI run being aborted and restarted with the new
+base line.
+
 Q: To which mailing list do I need to submit my BPF patches?
 ------------------------------------------------------------
 A: Please submit your BPF patches to the bpf kernel mailing list:
-- 
2.30.2

