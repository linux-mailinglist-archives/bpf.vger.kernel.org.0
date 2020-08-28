Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6563256168
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 21:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgH1Tgo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgH1TgV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 15:36:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9627C06123B
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 12:36:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x6so299161ybp.10
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/oSu15iVmSBJdOUV6p1+kO5Pm5AmWE98m3xQFZWiXC0=;
        b=dBW0+cOtokGqj6meEWumuyEo00cuC3AReIF8t4Ru5xNxa+070cxeFyo0u4n/fMX1Yi
         7TznjpY46QdL5uyDntFSfFKzp3K5L0XZvUwLPxpMtxxpSceV9vXPDEheW2XcFs7YSUu6
         HtQfo1jAop6a78m2gCgcpHjK1d/MJucU0fv7buxjGH+PAqeBi6Ubb/LLP3ezmV8a5JMj
         F4cHlZ5F54qOWboKy0Yr7nGvjCEV9Fo8dFzX1ZXRBNP6Yivrvll0pBDejJeWChBMme6v
         o2Zt5GMApb1OCxcxytspQaQU4CaD4BW4fBost8fhLZenyqKADvDIi0r3J9EWm0hQRqne
         Ly6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/oSu15iVmSBJdOUV6p1+kO5Pm5AmWE98m3xQFZWiXC0=;
        b=s95Pk3LghCcX5ccF7CNxyMwZeF73yMnX94Xu/X4K4USlTQ14dHKpI6c2+w8hKOYkdE
         lsOOFTJdc4nwrCaXOurQEG2lWdM0oh5lA6GSfP49bg4hzfL2oUpktvv54Qo92wXHvMUR
         loJQVxj6f32bt1ofbHSEypOtieiZPjR13kITpy0n61laUihFCgwoeKyApZtK499kiV+p
         GxwMl011/qIX9Lc2BHSXjn9XositGZOJyufJnuvPizTaZhydQLGUynK3CRjLVPRdlhau
         X1A2/EF5sw+Aq2JgK+Qxlqn2uEvDK0iGs5BRnohG/pj+YIpV6IFjJl3Z9yGfComMBv+7
         ACKA==
X-Gm-Message-State: AOAM530odJv8ENZ944zCTVov5iEyCrWXCsDWTBW8sUhqFnQx1aZl+e7x
        IZJexdlKzZH7tS1NB1BQbcBhgAo=
X-Google-Smtp-Source: ABdhPJw0lbVButdQJ8/y00PDdA9UqaSFZ0nkZQhHgQRBm+WgAB33NQbNI9Ekd8hTgXUq+4rwW25d5u4=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:e0a:: with SMTP id 10mr4802050ybo.256.1598643377048;
 Fri, 28 Aug 2020 12:36:17 -0700 (PDT)
Date:   Fri, 28 Aug 2020 12:36:01 -0700
In-Reply-To: <20200828193603.335512-1-sdf@google.com>
Message-Id: <20200828193603.335512-7-sdf@google.com>
Mime-Version: 1.0
References: <20200828193603.335512-1-sdf@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH bpf-next v3 6/8] bpftool: support metadata internal map in gen skeleton
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        YiFei Zhu <zhuyifei@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

The treatment of this section .metadata is exactly like .rodata,
the type modifiers are stripped. The resulting skeleton looks like:

  struct skel_with_metadata {
  	struct bpf_object_skeleton *skeleton;
  	struct bpf_object *obj;
  	struct {
  		struct bpf_map *metadata;
  	} maps;
  	[...]
  	struct skel_with_metadata__metadata {
  		char metadata_a[4];
  		int metadata_b;
  	} *metadata;
  };

Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/gen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 4033c46d83e7..9c316ea23ca1 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -82,6 +82,8 @@ static const char *get_map_ident(const struct bpf_map *map)
 		return "bss";
 	else if (str_has_suffix(name, ".kconfig"))
 		return "kconfig";
+	else if (str_has_suffix(name, ".metadata"))
+		return "metadata";
 	else
 		return NULL;
 }
@@ -113,6 +115,9 @@ static int codegen_datasec_def(struct bpf_object *obj,
 		strip_mods = true;
 	} else if (strcmp(sec_name, ".kconfig") == 0) {
 		sec_ident = "kconfig";
+	} else if (strcmp(sec_name, ".metadata") == 0) {
+		sec_ident = "metadata";
+		strip_mods = true;
 	} else {
 		return 0;
 	}
-- 
2.28.0.402.g5ffc5be6b7-goog

