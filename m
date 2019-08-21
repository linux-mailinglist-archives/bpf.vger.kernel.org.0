Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86F497560
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfHUIwa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 04:52:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33222 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfHUIw3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 04:52:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so4271313wme.0
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jsfJpUVjU9dUn+lZhqs5bn9/2bp4FWXp9iMvmKTuF4E=;
        b=byzJFaKj+d4bHL9LHY3n0DV4iHLyQuvcnTXnasPh7QkG38qUdOY7LF4MKsMy4J7PNP
         3LwV3h5V+UlmP1QGqaLfVuxbywNciaYZqh9cdt0ohkeRPT53mBMAgawFqEFSCbyr/0kf
         fzSNBvmJAsEQbcB9Ix3luxaR3Td7zVIbuxaqvuWE7SzBZK5f5DJY/BzX8AfGG+ji/8MK
         MuLmdwlokb1Aq3M3bkx/NW8f36eIVS33cHwS3APVDvYj4Ln9gDD6FrpE9BGOskPo6nXk
         syK/OJ687HVIxHtD6l98jTZIH+SxmqOdaj0m0jcDVhAiOp/aSNsd6P39D4DGyDjEPEMP
         tQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jsfJpUVjU9dUn+lZhqs5bn9/2bp4FWXp9iMvmKTuF4E=;
        b=DMpX+xMxX0G7DRbzbWqUp917N7nWJ+9IK3fMAmKg83Qk14/r592CwiE5b4MewSvi6D
         68G9QIKMGr9Pg2CAZiTKmGdTBuxykrTZchSRE2m0Xn5+K6VnbkediGpkUgCZOYxmyUOc
         L1kllDILr8yonrO+cmbxeBNJNhw+MZ7Kx7MXZHw9pxbt1TYo3BxtV5bn8JagxnOvChUm
         SYfdRcLl6bUecB9A0hmtQX26nQFLNsnV8/gu7dYixuHKxcg7uB2hYFZWp+6Th8H9uaIB
         EJwBhL4hpOcKIhbV1TQkH8EtuYpd1e7wm7GPRwEIns1jHjgnou+J+Z7pb2EcNXwHEbfL
         yEAg==
X-Gm-Message-State: APjAAAWuMuIqL7BjSHN1G4LnMcOXo77QmEtpC43msm4gKN1Oc6+FDNxc
        XmtJCFGxVg31gxFinqlUiXKjzA==
X-Google-Smtp-Source: APXvYqwL+YrEg3UG2c5vp4RYF5inEJnepCfl8hWeHhW+rgYDI3vvhrlOEQEVmGrw0sfLOw0dTmEAyw==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr4999397wmf.161.1566377547342;
        Wed, 21 Aug 2019 01:52:27 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p7sm2040165wmh.38.2019.08.21.01.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 01:52:26 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 1/2] tools: bpftool: show frozen status for maps
Date:   Wed, 21 Aug 2019 09:52:18 +0100
Message-Id: <20190821085219.30387-2-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821085219.30387-1-quentin.monnet@netronome.com>
References: <20190821085219.30387-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When listing maps, read their "frozen" status from procfs, and tell if
maps are frozen.

As commit log for map freezing command mentions that the feature might
be extended with flags (e.g. for write-only instead of read-only) in the
future, use an integer and not a boolean for JSON output.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/map.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index bfbbc6b4cb83..af2e9eb9747b 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -481,9 +481,11 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 
 static int show_map_close_json(int fd, struct bpf_map_info *info)
 {
-	char *memlock;
+	char *memlock, *frozen_str;
+	int frozen = 0;
 
 	memlock = get_fdinfo(fd, "memlock");
+	frozen_str = get_fdinfo(fd, "frozen");
 
 	jsonw_start_object(json_wtr);
 
@@ -533,6 +535,12 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 	}
 	close(fd);
 
+	if (frozen_str) {
+		frozen = atoi(frozen_str);
+		free(frozen_str);
+	}
+	jsonw_int_field(json_wtr, "frozen", frozen);
+
 	if (info->btf_id)
 		jsonw_int_field(json_wtr, "btf_id", info->btf_id);
 
@@ -555,9 +563,11 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 
 static int show_map_close_plain(int fd, struct bpf_map_info *info)
 {
-	char *memlock;
+	char *memlock, *frozen_str;
+	int frozen = 0;
 
 	memlock = get_fdinfo(fd, "memlock");
+	frozen_str = get_fdinfo(fd, "frozen");
 
 	printf("%u: ", info->id);
 	if (info->type < ARRAY_SIZE(map_type_name))
@@ -610,9 +620,23 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 				printf("\n\tpinned %s", obj->path);
 		}
 	}
+	printf("\n");
+
+	if (frozen_str) {
+		frozen = atoi(frozen_str);
+		free(frozen_str);
+	}
+
+	if (!info->btf_id && !frozen)
+		return 0;
+
+	printf("\t");
 
 	if (info->btf_id)
-		printf("\n\tbtf_id %d", info->btf_id);
+		printf("btf_id %d", info->btf_id);
+
+	if (frozen)
+		printf("%sfrozen", info->btf_id ? "  " : "");
 
 	printf("\n");
 	return 0;
-- 
2.17.1

