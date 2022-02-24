Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12B4C3473
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiBXSRM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 13:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiBXSRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 13:17:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C793711140;
        Thu, 24 Feb 2022 10:16:40 -0800 (PST)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 51AC320C31D9;
        Thu, 24 Feb 2022 10:16:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51AC320C31D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1645726600;
        bh=B9D0vxUsqxzPl9SgqxuD2InwAl15dfx72SkXuvsaNUE=;
        h=From:To:Cc:Subject:Date:From;
        b=CVTrs4+vSecZwIS60ocevKSDh0y7A9Znfdrs27XhtYZRyTZH+jdCDlwcvwiG9C4nx
         nX0GqYuGW7g5sHbKcjg+uJlSXd1qxH4JdiQV0TeebWWWgm6RdLZ1YTs8MCStsmf1Sg
         JRVPnKW1avCtJ5JnXXP0Ak0rS0sSKuA5CloBVJsw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, dan.carpenter@oracle.com
Cc:     linux-trace-devel@vger.kernel.org, bpf@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH] user_events: Fix potential uninitialized pointer while parsing field
Date:   Thu, 24 Feb 2022 10:16:37 -0800
Message-Id: <20220224181637.2129-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure name is initialized by default to NULL to prevent possible edge
cases that could lead to it being left uninitialized. Add an explicit
check for NULL name to ensure edge boundaries.

Link: https://lore.kernel.org/bpf/20220224105334.GA2248@kili/

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/trace/trace_events_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2b5e9fdb63a0..9a6191a6a786 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -362,6 +362,8 @@ static int user_event_parse_field(char *field, struct user_event *user,
 	*field++ = '\0';
 	depth++;
 parse:
+	name = NULL;
+
 	while ((part = strsep(&field, " ")) != NULL) {
 		switch (depth++) {
 		case FIELD_DEPTH_TYPE:
@@ -382,7 +384,7 @@ static int user_event_parse_field(char *field, struct user_event *user,
 		}
 	}
 
-	if (depth < FIELD_DEPTH_SIZE)
+	if (depth < FIELD_DEPTH_SIZE || !name)
 		return -EINVAL;
 
 	if (depth == FIELD_DEPTH_SIZE)

base-commit: 864ea0e10cc90416a01b46f0d47a6f26dc020820
-- 
2.17.1

