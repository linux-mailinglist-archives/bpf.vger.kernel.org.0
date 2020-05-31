Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4E1E9649
	for <lists+bpf@lfdr.de>; Sun, 31 May 2020 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgEaI3J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 May 2020 04:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgEaI3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 May 2020 04:29:08 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B74DC08C5CA
        for <bpf@vger.kernel.org>; Sun, 31 May 2020 01:29:06 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w7so1280298edt.1
        for <bpf@vger.kernel.org>; Sun, 31 May 2020 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P4mfqd4Xn4EQ0V99iX6SdAGczVXsitpi5uLY0Cm55+M=;
        b=j2SQmLXhfLAsfWe2dVyx4GZDhXEdFvhnNui7S//zA9EwxI0c9ughXwqFmmtzLvUNUO
         91A2mugUT2sZMVfxSehiz5EqgeJzb5PtD8kH6w7JL+u8KdaKqUtYO5k1aTEmVhZ5lM+g
         Gy8GipCPpxLkf1NAbUjF52xOPEo4bT3vntUso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4mfqd4Xn4EQ0V99iX6SdAGczVXsitpi5uLY0Cm55+M=;
        b=QsQf0Djp12IVz9btudFDIO6n6/z4J4gCEWCgInRg3RFmVofiVepUp0LuE3O9S44lmT
         pGOhgL1k2+me+HBTUwVN0iHVAxAZ4Oujz0V5m4rsJUhf1d6ovOxdToZNSl5qlYryd4x6
         nl5nVn0Z+aR/sDANG7xqfmvnVq8v0xTQfktPjImxp6y9wDpJcwPAjOpFUoMAPgSkKk2j
         z6XBs9sakj93XzPqnIjqGXbAqifkPKqrk6nTMSrkmDj1W9+w9O6HbCVPpF7m9Z4yc9uW
         8W6eiphL7qSGglMmTWr6bevr7OrpHdimNclKsak/CON33oF4pddFGPlRsbMuHrqatKyk
         jNDQ==
X-Gm-Message-State: AOAM530IfDAg7RDkwO/vMNXne21+ZisCo3rHDOW0mIvprSBjMVv3IS4f
        kgDLwNbuQ8+YmVZUy3n1uEir81TOFRA=
X-Google-Smtp-Source: ABdhPJzCHu0B3zLFyK/UTOwmgfIImU0PHghXhOGoB4Tm04RnReRbV9jJsptjI33EPKOZ95kRfmrt3g==
X-Received: by 2002:aa7:d84b:: with SMTP id f11mr16585626eds.288.1590913744698;
        Sun, 31 May 2020 01:29:04 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 64sm12536439eda.85.2020.05.31.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 01:29:04 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next v2 08/12] bpftool: Support link show for netns-attached links
Date:   Sun, 31 May 2020 10:28:42 +0200
Message-Id: <20200531082846.2117903-9-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200531082846.2117903-1-jakub@cloudflare.com>
References: <20200531082846.2117903-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make `bpf link show` aware of new link type, that is links attached to
netns. When listing netns-attached links, display netns inode number as its
identifier and link attach type.

Sample session:

  # readlink /proc/self/ns/net
  net:[4026532251]
  # bpftool prog show
  357: flow_dissector  tag a04f5eef06a7f555  gpl
          loaded_at 2020-05-30T16:53:51+0200  uid 0
          xlated 16B  jited 37B  memlock 4096B
  358: flow_dissector  tag a04f5eef06a7f555  gpl
          loaded_at 2020-05-30T16:53:51+0200  uid 0
          xlated 16B  jited 37B  memlock 4096B
  # bpftool link show
  108: netns  prog 357
          netns_ino 4026532251  attach_type flow_dissector
  # bpftool link -jp show
  [{
          "id": 108,
          "type": "netns",
          "prog_id": 357,
          "netns_ino": 4026532251,
          "attach_type": "flow_dissector"
      }
  ]

  (... after netns is gone ...)

  # bpftool link show
  108: netns  prog 357
          netns_ino 0  attach_type flow_dissector
  # bpftool link -jp show
  [{
          "id": 108,
          "type": "netns",
          "prog_id": 357,
          "netns_ino": 0,
          "attach_type": "flow_dissector"
      }
  ]

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/bpf/bpftool/link.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 1ff416eff3d7..fca57ee8fafe 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -17,6 +17,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_TRACING]			= "tracing",
 	[BPF_LINK_TYPE_CGROUP]			= "cgroup",
 	[BPF_LINK_TYPE_ITER]			= "iter",
+	[BPF_LINK_TYPE_NETNS]			= "netns",
 };
 
 static int link_parse_fd(int *argc, char ***argv)
@@ -122,6 +123,11 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 				   info->cgroup.cgroup_id);
 		show_link_attach_type_json(info->cgroup.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_NETNS:
+		jsonw_uint_field(json_wtr, "netns_ino",
+				 info->netns.netns_ino);
+		show_link_attach_type_json(info->netns.attach_type, json_wtr);
+		break;
 	default:
 		break;
 	}
@@ -190,6 +196,10 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		printf("\n\tcgroup_id %zu  ", (size_t)info->cgroup.cgroup_id);
 		show_link_attach_type_plain(info->cgroup.attach_type);
 		break;
+	case BPF_LINK_TYPE_NETNS:
+		printf("\n\tnetns_ino %u  ", info->netns.netns_ino);
+		show_link_attach_type_plain(info->netns.attach_type);
+		break;
 	default:
 		break;
 	}
-- 
2.25.4

