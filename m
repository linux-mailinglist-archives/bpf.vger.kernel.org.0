Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEDF3FD8FA
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbhIALt0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 07:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243904AbhIALtS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 07:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630496901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TpKhRaDL5uh9kwtULNfhD5GpIDEUbSUYlpxLcPeJ2GI=;
        b=X+GvF30IkZkBuKOlOH5SUOla4cTj63DdzkyQeVBq7XyNLdT0h9Kmx1hoqMXg/hTDljSZkL
        KVHY7BBNe8PFwewO6QW0Ra3GCqBmS9TXv+sVHAuV38oUFqw2I5KK5LwSwaOueOiCE9GOlq
        s9RfeRVwBicTvxXT8SgX7vR1nc26Hg4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-G6WwzfVWP2WEr0TMb0FrBQ-1; Wed, 01 Sep 2021 07:48:20 -0400
X-MC-Unique: G6WwzfVWP2WEr0TMb0FrBQ-1
Received: by mail-ed1-f72.google.com with SMTP id y21-20020a056402359500b003cd0257fc7fso1158146edc.10
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 04:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TpKhRaDL5uh9kwtULNfhD5GpIDEUbSUYlpxLcPeJ2GI=;
        b=cKo67sg4B6QK9me+0anGsm9mYu0wAclqWffDf/CuiSKB8WtiAjrD7JhR1q3YBOuY4u
         Lq5MLDkAOR21ztZCW0nRhpFl2oIRsK172ttqp6iqTMbw9AAE4LtEUrbsa1jQuIc2BJKV
         1wYEZnM4RbzHcSM1OGEiQ7IqW1HE9VRVgRjhXmyGXBbREqkTSB3pyIPwrmQv8nt9y6uu
         8glsZDSt9bshwOHKdjxsFmFoxCYmPv7nsLI3Mu1ZoLlamUM2dQtwXeo1J+Y3XmnZXFgP
         e83WvzcV1jPObAKGMOvQGmNGe8510Rwf+VwaxjuhMcWhF6qwHfN9dKeU51zNljteQsMa
         cq7g==
X-Gm-Message-State: AOAM533dgJPePwB2lh9v/Zzb1+RCiq/qOLZSjgXnnQcsjIfV3CweF3pp
        gAVpEaRt7TLBHIKJCEzisIVcrOnmsclFGic0rESkZWdSQhiVFcG0Gce0NGDIxUWSiYi+U45427k
        V002phkqwUbc8
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr36393367ejf.50.1630496899666;
        Wed, 01 Sep 2021 04:48:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0cnkbRVkbiVq+hTOc9zTMTCSJABSikudZcY4vayfYyx6/T8yZ+cgbzsYY0TjPgbJzplvpbA==
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr36393343ejf.50.1630496899383;
        Wed, 01 Sep 2021 04:48:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d22sm10009367ejj.47.2021.09.01.04.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:48:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3A8031800EB; Wed,  1 Sep 2021 13:48:16 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf v2] libbpf: don't crash on object files with no symbol tables
Date:   Wed,  1 Sep 2021 13:48:12 +0200
Message-Id: <20210901114812.204720-1-toke@redhat.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If libbpf encounters an ELF file that has been stripped of its symbol
table, it will crash in bpf_object__add_programs() when trying to
dereference the obj->efile.symbols pointer.

Fix this by erroring out of bpf_object__elf_collect() if it is not able
able to find the symbol table.

v2:
  - Move check into bpf_object__elf_collect() and add nice error message

Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6f5e2757bb3c..997060182cef 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2990,6 +2990,12 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		}
 	}
 
+	if (!obj->efile.symbols) {
+		pr_warn("elf: couldn't find symbol table in %s - stripped object file?\n",
+			obj->path);
+		return -ENOENT;
+	}
+
 	scn = NULL;
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
 		idx++;
-- 
2.33.0

