Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA69426440C
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgIJK2b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbgIJK1Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 06:27:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA41C061795
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 03:27:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so6072635wrn.10
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCkbdaUxcOLV6qU6kxWcLZk/XxFKvurYHi1esL6nT4Q=;
        b=X8439DK5LD0Um4SHGnfZ9NrT6nkk5Qo65cMJes1Zcouo8W6mXfM/Ct5nKnxRB3xdtl
         NGMQcFybJwlQYduWlGhU4RxtTWUBtrTfNf8d//dxBc8HyaE/2R52QXwxHabbKs+fxmyK
         EAQyTnpPGC2UpXRaXciqbmVdtC0WQ62PYSFz9XxClCJsFzAwa8E1rUf+PENtDeUCie45
         FwLQlzYvTULrMAxbP4f3tCbK9YZDMXEJsy/dDdzTxCTuWP8O+z2YfiHdNhkLWNrLhyz3
         3di6HhpmKjozMu/DfSRZOJoL+z37H9U5GtITeLtmekFbRGH7U8PtA67NiYexQycWx8sl
         lWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCkbdaUxcOLV6qU6kxWcLZk/XxFKvurYHi1esL6nT4Q=;
        b=XzmfDjydXY2wWPPmaOMhuiejB7VjbVSVTRE80AEFvCMX9Ljo1yHM2NWVTML+CVNXj4
         yvQiq70dvNOorkz7Vh4kbnYYran37l31G7nG0hu/AyoYTcOBspPIyiOMO9r5G8cBdBa6
         UUxjuNuTbjY8eA7l53Syre6VCS/kYelADiwRGkKBCrIKaQlMxIJRwS6EVPpP1qVzBUnb
         5eKBmiRZJZblRR5tep+qwQwyMkB2+fApFPBy4up1zFG0SQg1CewYJ3ld+tWIj/AbOYZO
         Vup4CRy9+M8qcEk7AqyJ5OJe216bk8Swq7jRQe6BtraEwhsaeV93Ywt6tU8Ja0lWjjm3
         nROg==
X-Gm-Message-State: AOAM530Z85kDuFYJpbQMJKzn5sA2xynbmQLNL4oR1d86+mz4gQVVOLW2
        RZ7gzEPDjdKBUFxPU8dtrr3kpw==
X-Google-Smtp-Source: ABdhPJz4o34D4wwA7tquDWANd0D5MgxjXdf4OwgfcgkNG+xvHrjOF1WEDaWMzvrW8AP53Tu1Zoup7Q==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr8468020wrp.168.1599733624322;
        Thu, 10 Sep 2020 03:27:04 -0700 (PDT)
Received: from localhost.localdomain ([194.35.119.178])
        by smtp.gmail.com with ESMTPSA id h186sm3039494wmf.24.2020.09.10.03.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:27:03 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 2/3] tools: bpftool: keep errors for map-of-map dumps if distinct from ENOENT
Date:   Thu, 10 Sep 2020 11:26:51 +0100
Message-Id: <20200910102652.10509-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910102652.10509-1-quentin@isovalent.com>
References: <20200910102652.10509-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When dumping outer maps or prog_array maps, and on lookup failure,
bpftool simply skips the entry with no error message. This is because
the kernel returns non-zero when no value is found for the provided key,
which frequently happen for those maps if they have not been filled.

When such a case occurs, errno is set to ENOENT. It seems unlikely we
could receive other error codes at this stage (we successfully retrieved
map info just before), but to be on the safe side, let's skip the entry
only if errno was ENOENT, and not for the other errors.

v3: New patch

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c8159cb4fb1e..d8581d5e98a1 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -240,8 +240,8 @@ print_entry_error(struct bpf_map_info *map_info, void *key, int lookup_errno)
 	 * means there is no entry for that key. Do not print an error message
 	 * in that case.
 	 */
-	if (map_is_map_of_maps(map_info->type) ||
-	    map_is_map_of_progs(map_info->type))
+	if ((map_is_map_of_maps(map_info->type) ||
+	     map_is_map_of_progs(map_info->type)) && lookup_errno == ENOENT)
 		return;
 
 	if (json_output) {
-- 
2.25.1

