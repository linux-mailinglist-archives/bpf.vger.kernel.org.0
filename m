Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59C62663
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbfGHQbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 12:31:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37235 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388297AbfGHQbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 12:31:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so8702199wrr.4
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amfYeislYJ8EeT6TDcXvFdnxBjp9KM9m4SLqeYyRX4s=;
        b=iGxEo3ErstIbpnRCA6hd+jmfSU0hCfTpvTKR6lvsxesRxZHf1hoNU5JuBoXW3jQVVU
         QpC+S686rdjpn9J+WWGmQaUXctXp5v5m2wY/OlhNR+Ayr3kqJxXU3Ig9XtNGK75HceN9
         r6SBGDX9r2Mm8acAfQ74175bgJbek0xTFYta4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amfYeislYJ8EeT6TDcXvFdnxBjp9KM9m4SLqeYyRX4s=;
        b=bSwjrztjq9FVJyM6vNQdMEOmYgAUqSdzJEW7F0CEhxqZzEsVhN7HauyfQHpBpSWo9G
         6BRyTl4dsfZ0LWzUOrGjBpj2ejlX61mJFEN+FAZB663iweSJJKvnErb3dq2Gto8LbJq6
         1oTeGEOTDP8jEBRA6d4Cj4nru/yA5frHFB0p0EAjR+nFWJi11U0WxVeCC3hgV6Dk0cBm
         /KmvA2T4sx1ot0oBrbDGgHacFpbGje+cY160w9ZI0ANCn8lRfsVi/sod03rCn75LwViY
         Y3NOynayXoG8DNGm3ap9++l0FI/Yo8j49krp7CuY+4eAvcfU+ARd9A5gUTqIVIyr5avP
         QhDA==
X-Gm-Message-State: APjAAAWrTc/sH5FbLikb+a6MBqttIPHADpxQkU35up+h/oCjyL/a7U3Y
        khBTTNIcO8xXfMORmGiyJ9P0tA==
X-Google-Smtp-Source: APXvYqwxUunAJhKUnVcTSUV6gdzpyIQotbg9qXmr0mcKTSCOn3444ijLQOND9itE4kXqRoTQnQgfrw==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr19391048wrq.333.1562603507442;
        Mon, 08 Jul 2019 09:31:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedbe.dynamic.kabel-deutschland.de. [95.90.237.190])
        by smtp.gmail.com with ESMTPSA id e6sm18255086wrw.23.2019.07.08.09.31.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:31:46 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v3 01/12] selftests/bpf: Print a message when tester could not run a program
Date:   Mon,  8 Jul 2019 18:31:10 +0200
Message-Id: <20190708163121.18477-2-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708163121.18477-1-krzesimir@kinvolk.io>
References: <20190708163121.18477-1-krzesimir@kinvolk.io>
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

Changes since v2:
- Also print "FAIL" on an unexpected bpf_prog_test_run error, so there
  is a corresponding "FAIL" message for each failed test.

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index c5514daf8865..b8d065623ead 100644
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
+			printf("FAIL: Unexpected bpf_prog_test_run error (%s) ", strerror(saved_errno));
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

