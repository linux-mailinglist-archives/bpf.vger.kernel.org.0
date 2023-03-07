Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF626AF818
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 22:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCGVzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 16:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjCGVzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 16:55:18 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CDFA1FD7
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 13:55:12 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 674F924083F
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 22:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1678226111; bh=B97Zxqmv2jJRC3pdnHqz4vUKQ13wY6DAjIWdt+drjxI=;
        h=From:To:Subject:Date:From;
        b=HiKtR5ZdJmdzd986uXT1CRJwSqR7WRsI+j6bIhlLz6dRhor4GkExAclomUTWO0rsL
         ziQKmhwPn2SI5TqQzgMp6D1iWu3rk2lZgNjw5dn6+onwNkiNWLShVQtorREd0XW8xZ
         B7JzpvOZ3gV2V8s1b9tiSF/GLoIs/FJOpzzF3YCAnnX9P+JhEdAL5U5Wa/a5V7TeqI
         iPun+2qo6xKCGHqtzwQO6FjnIsMW/rESRflfL1f3TH2VF8dZ/zfp3UAEAl18B2gwoK
         k9WnbgPLggMkLh+IamVcic+PxlbSUF5Ip+1x1/gcp/3+8GpLGIoHARIlMWTuqAWUpd
         nyZENroAaf1Qw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PWTl249zYz6tm4;
        Tue,  7 Mar 2023 22:55:10 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: Fix theoretical u32 underflow in find_cd() function
Date:   Tue,  7 Mar 2023 21:55:04 +0000
Message-Id: <20230307215504.837321-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Coverity reported a potential underflow of the offset variable used in
the find_cd() function. Switch to using a signed 64 bit integer for the
representation of offset to make sure we can never underflow.

Fixes: 1eebcb60633f ("libbpf: Implement basic zip archive parsing support")
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/zip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
index 8458c2..f561aa 100644
--- a/tools/lib/bpf/zip.c
+++ b/tools/lib/bpf/zip.c
@@ -168,9 +168,8 @@ static int try_parse_end_of_cd(struct zip_archive *archive, __u32 offset)
 
 static int find_cd(struct zip_archive *archive)
 {
+	int64_t limit, offset;
 	int rc = -EINVAL;
-	int64_t limit;
-	__u32 offset;
 
 	if (archive->size <= sizeof(struct end_of_cd_record))
 		return -EINVAL;
-- 
2.34.1

