Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC83FCBF0
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 18:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhHaQ7X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 12:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240366AbhHaQ7W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 12:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630429107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5O4cN5GN4rES6GaYCNOSVbONIJtZrh2SfxoFUXUD9nc=;
        b=PzLiWiNSAlgtvYyilSLf87uIKFADeMMjqz/oRaNkwRe+46XU6mivnOyJ8vLmJ+IRHBC5E1
        fM2t6+VjZEj6gtApTYS+Di/XX6K/Gw+xTFFyoM4pSxnmv8IUZYKSSKp4YyM6L+trqCCdJF
        6fSjrsAMhhPx++WA7+mN1WkeimUZXg4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-7LOqXhVoMC6YJNli_cmD3A-1; Tue, 31 Aug 2021 12:58:24 -0400
X-MC-Unique: 7LOqXhVoMC6YJNli_cmD3A-1
Received: by mail-ed1-f70.google.com with SMTP id o11-20020a056402038b00b003c9e6fd522bso4956274edv.19
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 09:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5O4cN5GN4rES6GaYCNOSVbONIJtZrh2SfxoFUXUD9nc=;
        b=KsL1qEUDu0t22XYhz/SpDPE2ykb0YOhrXwHs9U1hQmQMatyk6lTKBIFnOr2BMCEeeO
         urOzl6pUcSTHcE6iTHXc3ELhPARImcXDIv8nCdEynpGdgT/gHYNwXpMtI3hP9AsBMLeM
         hv97BGHHVFgWRhUkO3suK9W4jub/AzJkrN2/n8Xq7STGU/xeae0Unl+oBVgHAy63i/LB
         JARqjnlBwpNlTy+k7QFmWGGLxou5s8pkS2h9RThp5MWiygPY3w4slQUuX0uUGbfq4tZ9
         X0haqXXTcfu996NKeK53T5lTQxgilxa4jeRRv9wP3EKTbib+YrLR8HLnpzAMUyNbkrIY
         HafA==
X-Gm-Message-State: AOAM530ObEoF/yamAywSC/VofHJ0IlteS261e8yT6Y3DbmoVnCNzdQaY
        x7TcRUbzDGaWJzQKFXD5Ncls6BJxoxNWDDhaRBBo84VFlG0p6hxg01EaUGA5fdWSitdU8Tm4ZD2
        4x3RwsuDTWDW0
X-Received: by 2002:a17:906:7d83:: with SMTP id v3mr31920116ejo.216.1630429101993;
        Tue, 31 Aug 2021 09:58:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpUVqdypaPmTVrhaipJVHrC1X5LmDfF9NeucZle44BTObeNdYlW+Id4S+7bhi0U+/iiaipSA==
X-Received: by 2002:a17:906:7d83:: with SMTP id v3mr31920065ejo.216.1630429101275;
        Tue, 31 Aug 2021 09:58:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id jx21sm6554677ejb.41.2021.08.31.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:58:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B6AD91800EB; Tue, 31 Aug 2021 18:58:18 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf] libbpf: don't crash on object files with no symbol tables
Date:   Tue, 31 Aug 2021 18:58:02 +0200
Message-Id: <20210831165802.168776-1-toke@redhat.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If libbpf encounters an ELF file that has been stripped of its symbol
table, it will crash in bpf_object__add_programs() when trying to
dereference the obj->efile.symbols pointer. Add a check and return to avoid
this.

Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6f5e2757bb3c..4cd102affeef 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -668,6 +668,9 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 	const char *name;
 	GElf_Sym sym;
 
+	if (!symbols)
+		return -ENOENT;
+
 	progs = obj->programs;
 	nr_progs = obj->nr_programs;
 	nr_syms = symbols->d_size / sizeof(GElf_Sym);
-- 
2.33.0

