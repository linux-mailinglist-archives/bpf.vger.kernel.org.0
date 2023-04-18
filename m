Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6466E55D9
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjDRA3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 20:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDRA3W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:29:22 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A131733
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:29:21 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id n17so736242ybq.2
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681777761; x=1684369761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6sL+cRDqQyOvuDs50dqbecdFGTBwaNLP45HnP24rc0=;
        b=oglWpTelND456VOd0fFU8Ep1Z+3uurma6Fg1JFjb2fZLEUwBid1WnEPyR403Rsq0cI
         vj+VYPTRg5RShbUrw8zhQEnqLe2BjhjUI3FKvTD7VVIHjcTku90tSe/2QBJ7/7RLku7A
         daawIwNH8V3kb/3WzNZPasm7pKugq/1SC5aDWb40aufEtcNYLj2nHJWuzgGMZMnbRi9h
         XEy1wQBei24hrm8KAHG/txSRMzmtNfsJpVkofrH2+OYgsLPn2hyj26JroEV++zkv8a3a
         swlZb2rTAUr4pTV2llQC1KjOcH1JebciSy6+vXkeWTslRIlzWYHbe6DZaSzIp0M4XhmV
         j4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681777761; x=1684369761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6sL+cRDqQyOvuDs50dqbecdFGTBwaNLP45HnP24rc0=;
        b=N4v/WERTWXJj7+L85Kq0MD0F2fOt38oyqdCC13lK7UQfQZzwpZKk+lt6nQo4OeZQxw
         DkNEkJn6FgbVhxbJxoznemBTsAi4EpKh0T6addb3W8CNJTxymHbCmwAz+dKHKcFeyTXd
         su6w1fnQKa/0SRXE86r8Px+s+Vv5Y7FaN7hDHlbEd/qguW6Bcee3gyMYVqOL3fhZeX0U
         HziaKPc+hc1pmW0gIIrUCPXDSqGe4dgbVDOPThwKcZRGo6NWHfP6LkV4/OrfGID51AGo
         1GZpkXJJzidhEcrVmwlYxkH+veUk5ek5QXa9ZO3gFzqK+yrAJCMK2IR3j0zSzgoWAGLH
         VLyQ==
X-Gm-Message-State: AAQBX9cHNSL02EcJhDeE21AxblC48jg+epcrpwktMeSbM7VuzpH16VSc
        WLcNVHVhJpnZoVmCgHZXqkOvgzCU7y0=
X-Google-Smtp-Source: AKy350YMPuPxk4y856MnT17aSzGDsS3NfS5Z/kHWM8FibVaThMS2tWMcheRVu7oGMmsdW8QOa3QmUw==
X-Received: by 2002:a25:1903:0:b0:9ed:13e9:fe65 with SMTP id 3-20020a251903000000b009ed13e9fe65mr20994609ybz.19.1681777760605;
        Mon, 17 Apr 2023 17:29:20 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:24b7:680:9d60:6ef7])
        by smtp.gmail.com with ESMTPSA id j185-20020a8155c2000000b00545a08184fdsm3410987ywb.141.2023.04.17.17.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 17:29:20 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next] bpftool: Show map IDs along with struct_ops links.
Date:   Mon, 17 Apr 2023 17:29:17 -0700
Message-Id: <20230418002917.519492-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
struct_ops to links. (226bc6ae6405) It would be helpful for users to
know which map is associated with the link.

The assumption was that every link is associated with a BPF program,
but this does not hold true for struct_ops. It would be better to
display map_id instead of prog_id for struct_ops links. However, some
tools may rely on the old assumption and need a prog_id displayed in
the link header line.  By keeping the prog_id unchanged, an extra line
indicating the map_id is displayed.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/bpf/bpftool/link.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index f985b79cca27..cb41a447ae3a 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -195,6 +195,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 				 info->netns.netns_ino);
 		show_link_attach_type_json(info->netns.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_STRUCT_OPS:
+		jsonw_uint_field(json_wtr, "map_id",
+				 info->struct_ops.map_id);
+		break;
 	default:
 		break;
 	}
@@ -301,6 +305,9 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		printf("\n\tnetns_ino %u  ", info->netns.netns_ino);
 		show_link_attach_type_plain(info->netns.attach_type);
 		break;
+	case BPF_LINK_TYPE_STRUCT_OPS:
+		printf("\n\tmap_id %u  ", info->struct_ops.map_id);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1

