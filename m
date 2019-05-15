Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C51F5DC
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 15:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfEONsa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 May 2019 09:48:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39854 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfEONsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 May 2019 09:48:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so101360wmk.4
        for <bpf@vger.kernel.org>; Wed, 15 May 2019 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4wFlx6HQLwkFDpRpijpjb+LCC4DqiZp6fdw5d4Bn0s=;
        b=D9xP2BubzEPMEBtp4A/REzzwHzsxPmnZZGeY2xY/f1+7/kcqWbosB7HhgK4rfNY63G
         rKonLvKxUHvdwCOEopEm/AVUNntJh2b6OOJzQgr4da6zbmppPX8HlkfDYipmSNtOAqWE
         3HIdf2UETubgofhYaek5zlB3hweliaucMnXKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4wFlx6HQLwkFDpRpijpjb+LCC4DqiZp6fdw5d4Bn0s=;
        b=r5jJB/r58HpGEZoF5r+35wnuClOGPssBpItDfDli2A2EfBm73FJ+tsI1vVMmy7Lrdy
         EoKl1TmHvDGns2PXIx75HCkR+uju9mNDOgmseQLiy+EXDgeebN5f84G1cJo74Tv6wzL2
         xYV2xIYENPYABmmhiY5JoKrc3U5WGsfBHh9wNx5xr6RI8Wa/TA8tTCOP51Z12tAg1FU9
         3EU29yVRshqKQvoQlTiPnEs6pUpd/qYmJidcQoZiL8FkUvYJ00JhER9fkNzpKxmjO1S1
         r6rb19uZqQGq9jh8hgmTePFeXiKvQQFI5d9CD/2EdWLhMbJq3CmeGJQylS4sN076gU+n
         BfKw==
X-Gm-Message-State: APjAAAV5ODfoWbduJWl3t+/P28slHOKwlR8chIHArQkxkW0jfI0jcmDS
        Y6Arjs7A0XiwjVsxoV5yojNTpInTmqZzLg==
X-Google-Smtp-Source: APXvYqwpuCIcSe7tEpjLLIyvs2sBphmsdGB5DWnT0DsJKq+gtI+0iDk2r07JPa/i5V9zFjAc1hfA9A==
X-Received: by 2002:a1c:1f0d:: with SMTP id f13mr3449718wmf.74.1557928107896;
        Wed, 15 May 2019 06:48:27 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aea35.dynamic.kabel-deutschland.de. [95.90.234.53])
        by smtp.gmail.com with ESMTPSA id v5sm4498506wra.83.2019.05.15.06.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:48:27 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     bpf@vger.kernel.org
Cc:     iago@kinvolk.io, alban@kinvolk.io,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1 2/3] selftests/bpf: Print a message when tester could not run a program
Date:   Wed, 15 May 2019 15:47:27 +0200
Message-Id: <20190515134731.12611-3-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515134731.12611-1-krzesimir@kinvolk.io>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This prints a message when the error is about program type being not
supported by the test runner or because of permissions problem. This
is to see if the program we expected to run was actually executed.

The messages are open-coded because strerror(ENOTSUPP) returns
"Unknown error 524".

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index ccd896b98cac..bf0da03f593b 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -825,11 +825,20 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 				tmp, &size_tmp, &retval, NULL);
 	if (unpriv)
 		set_admin(false);
-	if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
-		printf("Unexpected bpf_prog_test_run error ");
-		return err;
+	if (err) {
+		switch (errno) {
+		case 524/*ENOTSUPP*/:
+			printf("Did not run the program (not supported) ");
+			return 0;
+		case EPERM:
+			printf("Did not run the program (no permission) ");
+			return 0;
+		default:
+			printf("Unexpected bpf_prog_test_run error ");
+			return err;
+		}
 	}
-	if (!err && retval != expected_val &&
+	if (retval != expected_val &&
 	    expected_val != POINTER_VALUE) {
 		printf("FAIL retval %d != %d ", retval, expected_val);
 		return 1;
-- 
2.20.1

