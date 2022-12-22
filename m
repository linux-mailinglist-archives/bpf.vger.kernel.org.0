Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731636547F8
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLVVkD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 16:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLVVkB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 16:40:01 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7002A27DC8
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 13:40:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x33-20020a056a0018a100b00577808a75c9so1650834pfh.13
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 13:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fzxbepp4VHyLhoBoX/57kkLRkRkakbicfhkVDl6vDKc=;
        b=pD45BT0uO3Qv2TIwgCanbWr3UyONGMsbD4JMUj+6UF/bsUK3wCQ2kaXOaLBdf/ndm/
         6EMh0EUBNKTs0ZOIoF+a2R4tqaoiD4/xfGExDh8m6eTW8gM+iqWGsOkuCIbYPuIjeM0H
         65xYqf1wYqfF7XseN9ADN6YV+2EKBjlfF8vdVzJuk23IuWquwUK0GrDikmLM5SICTm8p
         2ihXrL4fCBGqt353rSpGbglRVcLHAQg/bT+0z9UI2Hc26aX88/JtASesgjmI4Q7VWPSr
         Ac+8dWiOq02Kus+R7JFg3FwSq2CP4iqELYm+BjadJ3ZMjG4fZcVq20AH2ulv0zZiY3Sg
         olvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzxbepp4VHyLhoBoX/57kkLRkRkakbicfhkVDl6vDKc=;
        b=SjSPCKSjC3dHpPC04VDW1l1+IqPMtcAZSfnlwk9G+5RMB1p+JRqFG8GCRX6UfPmf4m
         fLpkmH7vkEq2pUpKGAlNv3OOA/pGjCzsxlWWimh7CkHZvPXmWnRLM8WzWX8t/fWgLqIx
         /i2PDE2OfyxR56ytD66XLQubv2P29+p0rva8EzWCa4z9nnvVrmQ5rwvqOGE/9DQwDouK
         z3Vj6AqLFOhorZRTWgo7I7n0erp9TeuBNPG0KzvVnZm+sTKYoywQ3Jzo93FqwaTvVuhf
         xmj+uLx+PQjDoBY8S3twi5ikMv1PDr1J/ycVf/uEiWI/UCcWcuPzXpKHSgA4S91xwgPk
         tN0w==
X-Gm-Message-State: AFqh2kqv7YX8PwUOu/d81fUrz/PDU2fe+stAEObEwxYZ5OsaOBnfUfju
        4UI+jWnHuVom1aTp/r739P66wj/VLorZJ1JViU522E18wU1k67hqtBhmtFSemU8rpYwi8B2qWBR
        WK+KaoxpSrNXu7TeFPudkP208ewAVwHuvM2UiDd4SVxybWMIHYg==
X-Google-Smtp-Source: AMrXdXvO1NFeJ+Qe0TFR0DrtnkVHzS9Y8dryfV0WUonp9Cc19s4luA2HmVLsQ/Qw/7EIPl78J/GwT9s=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:1e43:0:b0:577:a27c:52cf with SMTP id
 e64-20020a621e43000000b00577a27c52cfmr483337pfe.20.1671745199664; Thu, 22 Dec
 2022 13:39:59 -0800 (PST)
Date:   Thu, 22 Dec 2022 13:39:58 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222213958.2302320-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Add host-tools to gitignore
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Shows up when cross-compiling:

HOST_SCRATCH_DIR        := $(OUTPUT)/host-tools

vs

SCRATCH_DIR := $(OUTPUT)/tools
HOST_SCRATCH_DIR        := $(SCRATCH_DIR)

Reported-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 07d2d0a8c5cb..401a75844cc0 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -36,6 +36,7 @@ test_cpp
 *.lskel.h
 /no_alu32
 /bpf_gcc
+/host-tools
 /tools
 /runqslower
 /bench
-- 
2.39.0.314.g84b9a713c41-goog

