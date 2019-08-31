Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE0A41BF
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2019 04:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfHaCed (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 22:34:33 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34516 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbfHaCed (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 22:34:33 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so6820473pfe.1
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 19:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a4rFTqioQJgL7bDCizE2uEN7gKuduEr/PEeqOE4KelA=;
        b=X6mkjQ+L6I57QTiTP9z37nxgauqLdrxNp+GYVqqoviLTp97AJ7zNZpFA3JTD6P/zHV
         nZNMPinATSq6dw8OkjfD0sJOd5HKU4bHcDr8p7mt32kXoroMSHYNH5HQ9wYAnI5WzP8F
         Dh/3ra7ewEGFHKEaUWUv/Xu2uV7k/q3+sOKuAVbjRsx3gswJyURoz+CQfylV1ak9acVj
         IUPGEWkc4BWdSSmlthRCOnSytEQE73f2DptLnr5ZLGbHLKZlOrCrCPrw0cX8OpRn5LMs
         m7yMNT9/JX0cgqSG8daY9cH21k2qPrPFpMgMKnJlyq7N+/xbzRDy0uC0T1NrPDQvUJG4
         sm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a4rFTqioQJgL7bDCizE2uEN7gKuduEr/PEeqOE4KelA=;
        b=qWgNYp63QYbbfEIq1XT/mTOSavKbbO3QucSpLeAnGhy63frj9kcX2V7GAfIDQhZTGf
         aV5CGKKoNDYdWuMEvABxHKDEv1wbQyGVw9L2RRZRq5W5ptYKMPLPVr7SgAG98rHYdVY/
         0H5DtcKO6KC+zJjuhd0OBJKjJBY4ZoQTd/GmIMO6fjjaP/sPXQcrdcdjQnX0adVTsxHn
         VISYcBGGofOXWUFJKgIjqi7gx8YN365xwhUsieXoHMqhip2vbhdK+zRMoGyJ5C9aZVtH
         HC69cW5IlimQK263AtvmDYIvN2jNYusE26lm/sOyD/hQIJ2ei8oU6l5ZrnobHgqS6qxX
         TxqA==
X-Gm-Message-State: APjAAAUbdGCkK1hku9wARSVY2YB0EMmRSroYGCq1slJ+0OONVObpBSnJ
        xU+62ek7mz/1ZsFyXDVL+kUl5o8=
X-Google-Smtp-Source: APXvYqxpEwR0+2wWqWQonzc5LDOYL17L9zSKywuFQC0oiWaQTExrmuJEonEfLUBsCX4hZAooio57g/s=
X-Received: by 2002:a65:514c:: with SMTP id g12mr1449437pgq.76.1567218871948;
 Fri, 30 Aug 2019 19:34:31 -0700 (PDT)
Date:   Fri, 30 Aug 2019 19:34:27 -0700
In-Reply-To: <20190831023427.239820-1-sdf@google.com>
Message-Id: <20190831023427.239820-2-sdf@google.com>
Mime-Version: 1.0
References: <20190831023427.239820-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next 2/2] selftests/bpf: test_progs: add missing \n to CHECK_FAIL
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Copy-paste error from CHECK.

Fixes: d38835b75f67 ("selftests/bpf: test_progs: remove global fail/success counts")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 33da849cb765..c8edb9464ba6 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -107,7 +107,7 @@ extern struct ipv6_packet pkt_v6;
 	int __ret = !!(condition);					\
 	if (__ret) {							\
 		test__fail();						\
-		printf("%s:FAIL:%d ", __func__, __LINE__);		\
+		printf("%s:FAIL:%d\n", __func__, __LINE__);		\
 	}								\
 	__ret;								\
 })
-- 
2.23.0.187.g17f5b7556c-goog

