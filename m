Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A833B7121
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhF2LMv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 07:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233315AbhF2LMu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 07:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624965023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M9+dWhJWmd7DVS+Y6c5YJeckM41fEC7rx3NEP6gte0o=;
        b=S/RvQsiWtigUzdmRUoEPK5MlR2QGmjtBnUUl2VAsvbveUfNNmix9XobsDjU2mTmw2YUshL
        9c/KEJJSYxM/P0RgzllCHvtJB1grGKll8I+CnEIqLMe0XTflLQ1GQpum+gUyr0htMgMe20
        mDGVKACHRd6XOZljOhuZYaLbY+WH/5k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-2jPxgZNkPdeKNhrRcmNKzQ-1; Tue, 29 Jun 2021 07:10:21 -0400
X-MC-Unique: 2jPxgZNkPdeKNhrRcmNKzQ-1
Received: by mail-ej1-f70.google.com with SMTP id lt4-20020a170906fa84b0290481535542e3so5615279ejb.18
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 04:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9+dWhJWmd7DVS+Y6c5YJeckM41fEC7rx3NEP6gte0o=;
        b=ltOrvWTDqiH9/aoIAOVozAv2XRh7WJdZ2qhk9l2FhQD1P4C2O7ldeC+0nOR4b0beF0
         We8IRTA6V12nS1/5DPh3JnNoOW/WALKcYQEtuOYmp3oJnA4b1GH0c8QHawjzNn1yt3Z9
         kq0AeWB93Rd+PZ3trnsnZDGXCYSL6JaDt90vG1KZMlam3rDWdbH8/MBt68pUk70d+82n
         vfkSxaln+nUVbB2LFFHWuZ7l16PjBxZT4ioh5AMiNHUe5x7WM/8OtD+vieye9nbC6wN4
         8QyRAtxyiZBFEgsriK8lKF6XuoQk9T8bfQ4Dt4jX2IlO7fPUfjFRhzfvm91tYtP2G3Tb
         bHOA==
X-Gm-Message-State: AOAM5325zM6GL1OIjr4tr2KKnwNbnenQFXalX3oRiqDnafTvzUS0ibiG
        A3GEkT+dQeVOLCXME+OI6tIzwpmKQyMK0rhGC+ObR0g27obNfMUjndSCcJQc5Z0a+tXlkGah4M/
        a6IEYnOZ52w0C
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr29716024ejc.1.1624965020237;
        Tue, 29 Jun 2021 04:10:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5KWgSEx8rM8xYRPasysP1U5T1yzTEt1GS6wbBy6hSuKWtXuoy9AIjzxSwy1lTZ2UfQ0atTg==
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr29715978ejc.1.1624965019709;
        Tue, 29 Jun 2021 04:10:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h4sm3609147edv.59.2021.06.29.04.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:10:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 71C4018071E; Tue, 29 Jun 2021 13:10:18 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next] libbpf: ignore .eh_frame sections when parsing elf files
Date:   Tue, 29 Jun 2021 13:09:23 +0200
Message-Id: <20210629110923.580029-1-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The .eh_frame and .rel.eh_frame sections will be present in BPF object
files when compiled using a multi-stage compile pipe like in samples/bpf.
This produces errors when loading such a file with libbpf. While the errors
are technically harmless, they look odd and confuse users. So add .eh_frame
sections to is_sec_name_dwarf() so they will also be ignored by libbpf
processing. This gets rid of output like this from samples/bpf:

libbpf: elf: skipping unrecognized data section(32) .eh_frame
libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh_frame

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1e04ce724240..676af6be5961 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2906,7 +2906,8 @@ static Elf_Data *elf_sec_data(const struct bpf_object *obj, Elf_Scn *scn)
 static bool is_sec_name_dwarf(const char *name)
 {
 	/* approximation, but the actual list is too long */
-	return strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0;
+	return (strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0 ||
+		strncmp(name, ".eh_frame", sizeof(".eh_frame") - 1) == 0);
 }
 
 static bool ignore_elf_section(GElf_Shdr *hdr, const char *name)
-- 
2.32.0

