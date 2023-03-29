Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4CB6CD342
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjC2HdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC2HdA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 03:33:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A549CC
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 00:30:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so17688172pjb.4
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680075030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfgNbq5kFadJHtRcrhb5Gm24X+QKh+vxnOBoscS3bxo=;
        b=MNvDjOweXjEjnR013GP/0b0WEZVcYDW2Cr/V3lBjwt6sjBSWyZHg2m3w7h/Sy2IQj8
         77DnTxT9fGEjjzJlFQ4fc+Fccm+U1aNfrUZkWIUheZ1iRNvyHoKkDw5UsVSpoRY2xGav
         67uMdQXvIC7L5H8VP0xx5EQoCcqN6R3whfjBn3V4X0/UiZgACLmSuLVffHRjW6qz9etc
         ZMi8VdVa1PIMYJ5xK/FUoKRmornSHVUaw6s/ZxkpMOrVe6swG0xE0S6bz4RP+dOzxA6b
         EoAdzfQQ/x1jqRc8X6/PZPmCcx1sc4xTXzUOmcJh8boMkBDNh72lNGYi+D0MEpAMEVGA
         HCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680075030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfgNbq5kFadJHtRcrhb5Gm24X+QKh+vxnOBoscS3bxo=;
        b=XIgpi/mVL6DgRrwwj2mH/wVNSiluzRdUwg2F4l/eIfDCZ+ulBc6oMmB5pt11/6ofqJ
         iXXU2lap4hepnQxafo1pnOa9JTHDPKXjW7omf4lzeLphEae0nLl4eyPLmZDI01yjYwhc
         Rp6scmwd9KY+KXHRwVp7+//wde6XA/GgXOnYqsukbsJIroKdYLB785F/JR4nrx2eBI8I
         hImuQ38lzfA2RTskmF+OVNDW6SMDaWcDpRTMnRC+kvzlIMG+em1NbFTUdRPZuY2Ao/tW
         PgPsRYt8Ht6LwK7Fdxe9DUSlU4SBGuLgLigq1pc3mybxvnsX60lHOP3hFJxocYoHdwIy
         g6Dw==
X-Gm-Message-State: AAQBX9cgC/jb/J3668L6jCUrJEsi1t3fhBZzUL3Wt9K6JUrFupFSXq1i
        FEzPssdZ54Oce8DuFcCpVbo=
X-Google-Smtp-Source: AKy350Yr9AgUUpUKaRS7WO3GeTU5X/DWk9lprWM6pLYvFyMziL6Z1Rw72USQwaOscgJrvqnciof0uA==
X-Received: by 2002:a17:902:e192:b0:19f:a694:6d3c with SMTP id y18-20020a170902e19200b0019fa6946d3cmr14551478pla.55.1680075030448;
        Wed, 29 Mar 2023 00:30:30 -0700 (PDT)
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id bh4-20020a170902a98400b0019cb6222698sm7712798plb.266.2023.03.29.00.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:30:30 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, quentin@isovalent.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
Subject: [PATCH] tools: bpftool: json: fix backslash escape typo in jsonw_puts
Date:   Wed, 29 Mar 2023 00:30:02 -0700
Message-Id: <20230329073002.2026563-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is essentially a backport of iproute2's
commit ed54f76484b5 ("json: fix backslash escape typo in jsonw_puts")

Also added the stdio.h include in json_writer.h to be able to compile
and run the json_writer test as used below).

Before this fix:

$ gcc -D notused -D TEST -I../../include -o json_writer  json_writer.c
json_writer.h
$ ./json_writer
{
    "Vyatta": {
        "url": "http://vyatta.com",
        "downloads": 2000000,
        "stock": 8.16,
        "ARGV": [],
        "empty": [],
        "NIL": {},
        "my_null": null,
        "special chars": [
            "slash": "/",
            "newline": "\n",
            "tab": "\t",
            "ff": "\f",
            "quote": "\"",
            "tick": "'",
            "backslash": "\n"
        ]
    }
}

After:

$ gcc -D notused -D TEST -I../../include -o json_writer  json_writer.c
json_writer.h
$ ./json_writer
{
    "Vyatta": {
        "url": "http://vyatta.com",
        "downloads": 2000000,
        "stock": 8.16,
        "ARGV": [],
        "empty": [],
        "NIL": {},
        "my_null": null,
        "special chars": [
            "slash": "/",
            "newline": "\n",
            "tab": "\t",
            "ff": "\f",
            "quote": "\"",
            "tick": "'",
            "backslash": "\\"
        ]
    }
}

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/bpf/bpftool/json_writer.c | 2 +-
 tools/bpf/bpftool/json_writer.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/json_writer.c b/tools/bpf/bpftool/json_writer.c
index bca5dd0a59e3..be379613d118 100644
--- a/tools/bpf/bpftool/json_writer.c
+++ b/tools/bpf/bpftool/json_writer.c
@@ -75,7 +75,7 @@ static void jsonw_puts(json_writer_t *self, const char *str)
 			fputs("\\b", self->out);
 			break;
 		case '\\':
-			fputs("\\n", self->out);
+			fputs("\\\\", self->out);
 			break;
 		case '"':
 			fputs("\\\"", self->out);
diff --git a/tools/bpf/bpftool/json_writer.h b/tools/bpf/bpftool/json_writer.h
index 8ace65cdb92f..5aaffd3b837b 100644
--- a/tools/bpf/bpftool/json_writer.h
+++ b/tools/bpf/bpftool/json_writer.h
@@ -14,6 +14,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdarg.h>
+#include <stdio.h>
 #include <linux/compiler.h>
 
 /* Opaque class structure */
-- 
2.34.1

