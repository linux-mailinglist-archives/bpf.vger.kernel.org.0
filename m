Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2711C5580C
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 21:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfFYTnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 15:43:55 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42290 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfFYTmr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 15:42:47 -0400
Received: by mail-wr1-f46.google.com with SMTP id x17so19198251wrl.9
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VsQ/hHNcVRgyGfowhBC9LviGWtE+VmAC6qAcPnOXLw=;
        b=MNqpO7flohV2LHC/0o99V4Flq60k6Xqi5mVOq7pvi5o8/vUhZmA/FJZ08L3RSQMEAm
         G7W8ulQn3fUI0QAd4qjYDL+bd3bm6kUM1Cn6TLsRE1CpPVJumaw1JYS0Oopvhiwr7CSV
         Zjmxix/Yfqu0BysCNAzYd2cLYdcbSIm1mN/wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VsQ/hHNcVRgyGfowhBC9LviGWtE+VmAC6qAcPnOXLw=;
        b=eNpT0NJ5trRS5Ulpyss1XhTPw9aYjcuDNIaAtnN1h0saCtc4d3BhAZCN97q+SPaB3a
         Y75NVz140htt+LmzIrW5lY0Mt+ApOZwo8s3AC4cwYmwqBZ6V5q4s8653NLvfOcsn0RdV
         J7j60Di2LqkUjOijHOp6oHXsANqVID5WXXGYrsBQfiEip7PUPExh2EKk1T6u93gD5et8
         O/532oCosp0owHgSBLyNzmwbfpSFE0YAonzm1yfIkGrYvyXTj1LPAqDS34hX9+6Z2Aod
         OfVQteJ2Kv47WPnomPDtKqRmMBVYIc8ehUKprIJbRhbt4BfBU90oHHVt4NENz898Ir2t
         nMtQ==
X-Gm-Message-State: APjAAAVgL7RxEo0OZ5RwDmV+T3HcN83wAkW2G0nWN9ODbitm3grqpqud
        QCkCHck174dIgpvhH7LmoWeeiQ==
X-Google-Smtp-Source: APXvYqxwIWnsmoPrhrrxor1cV0WAhSle5gHJb9T/lxWdy3jjx0rg6VuJjqVtNv9BYAB4tfqUMWNygg==
X-Received: by 2002:a5d:4708:: with SMTP id y8mr3829076wrq.85.1561491765822;
        Tue, 25 Jun 2019 12:42:45 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedb6.dynamic.kabel-deutschland.de. [95.90.237.182])
        by smtp.gmail.com with ESMTPSA id q193sm84991wme.8.2019.06.25.12.42.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 12:42:45 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     netdev@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v2 01/10] selftests/bpf: Print a message when tester could not run a program
Date:   Tue, 25 Jun 2019 21:42:06 +0200
Message-Id: <20190625194215.14927-2-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625194215.14927-1-krzesimir@kinvolk.io>
References: <20190625194215.14927-1-krzesimir@kinvolk.io>
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
index c5514daf8865..9e17bda016ef 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -831,11 +831,20 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
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
+			printf("Unexpected bpf_prog_test_run error (%s) ", strerror(saved_errno));
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

