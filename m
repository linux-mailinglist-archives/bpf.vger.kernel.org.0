Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0141F53F
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 20:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354962AbhJATA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJATA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 15:00:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE8FC061775
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 11:59:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 75so10278349pga.3
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4m2iyk14ScAutetRY9OfGr8w9vRIrIp+GXTOsp+ccE=;
        b=n2NVl++3dv8GewD9qh2u90dyayuU85yp8yI64rh9X1d1a7Lt09yMbngRcmKVQP+eC6
         8Qz15Lw69v9Jw2PtjixRxAPyAYN0zzhk8PysunZzddpGwOKH/e1jcTA34HmFh0lGvYuD
         ZsWSFfI3IZmX+gYftJ1Eg5YMeUHBpxJLAYldtwGTQsyo6sCX8AU9US4WDLva522+SBkW
         FiSdrhYP7XCKvg+4/NVDRJlDrocr77WDhwTH49PPxHL4PSDB1WaYEywUHosH8pSJvu0H
         iJqpcEnYC1vRXxON2ZWmwipmuQXmgsjYPAOdt9PZOpWvGgSvtZJG4r9E44NL7UyZ/e4r
         l7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4m2iyk14ScAutetRY9OfGr8w9vRIrIp+GXTOsp+ccE=;
        b=aPoYfT+vwsvojmXOVT4L3xbF4V4qdrMMUN+WiOXBJ81AKrPpaScGfDEmrjvSxibt9I
         xHsvqnfGMlTaijBD3quVe9FK7ZtBmFMuGHNJ8RA0Y5nuHS87AVk0D3UMz0ADqPtyKx6+
         KhgRLZTp593UmfPL9iPz/mndwZLJz0Gg0wVmHrvULLLCveKe2tQXtx263mYy7cHMX3dl
         WiNrJrNT9zAlSqYHlFRmJzJjqYWCcKrsUmy9R5mOZeboOpJbi26RCZpq0kGLQ0Ig/wNx
         3/6YFdEMsrfKcxxMFmBOav+sLtdv/MeLjxA5o6EtagazaCRCK7gWOMBNNREZ66TXbuNv
         sxcw==
X-Gm-Message-State: AOAM531TmyNHZNjFJWZthD4pS2u4BqXhsPvHron4s1BAXZgQHcDg8N6r
        +0k4nMbBg1TaIIH9M0ShRpsSWHUz9pC/RA==
X-Google-Smtp-Source: ABdhPJwOKOCEvVPO9e1/eTHu7RNqSeLfuvwtFa+0YJLL0fNF2lqyAqAoGAXwL+j+4bilzNWRzzyZXg==
X-Received: by 2002:a63:ce57:: with SMTP id r23mr11049287pgi.271.1633114753316;
        Fri, 01 Oct 2021 11:59:13 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::2:d9ef])
        by smtp.gmail.com with ESMTPSA id k1sm6272729pjj.54.2021.10.01.11.59.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Oct 2021 11:59:13 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: [PATCH bpf] libbpf: fix memory leak in strset
Date:   Fri,  1 Oct 2021 11:59:10 -0700
Message-Id: <20211001185910.86492-1-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Free struct strset itself, not just its internal parts.

Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructure APIs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/strset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index 1fb8b49de1d6..ea655318153f 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -88,6 +88,7 @@ void strset__free(struct strset *set)
 
 	hashmap__free(set->strs_hash);
 	free(set->strs_data);
+	free(set);
 }
 
 size_t strset__data_size(const struct strset *set)
-- 
2.30.2

