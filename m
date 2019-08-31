Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3886AA41BD
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2019 04:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfHaCea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 22:34:30 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:53016 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfHaCea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 22:34:30 -0400
Received: by mail-yw1-f74.google.com with SMTP id d18so6644245ywb.19
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=o06HkPxIPXx8Sc900nvKiFOh9246i19O7yDA5ZbcmgE=;
        b=RpYhA35aCeSSt096Ky2o5pdBBcCpGYs4CyV+IcPegOIJ+wmXpAbw1WMiOQ79B2Kplj
         sq2aJJJVhLBFkzRi6mRvjIAYY72MmhL+ufI5k1pqvlz6cxNrluNMD9vY8WaE1zB0/NHQ
         FCc8cry9davbl0fUGKcuPuLMTKZrvkrCP7r+ywvah9hyhV/CylL15nb8wN5dzwMFI1ct
         Sm5D6RY7dKtpTxZZ85HrFyyAf0uEbqHgzgPqAZr3qxxefeHvTpK/MU3CNsjL42N8c/IC
         mE6tAfDsLWwFdQO2zI8NrLdHEkm/vmSbCK2gLAClV+MhhVdAMmwvvYYaZaJ/G+8E8KNX
         Hq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=o06HkPxIPXx8Sc900nvKiFOh9246i19O7yDA5ZbcmgE=;
        b=MFpFYc/HNIxrWduO3NyWhY+exKR5lQ9WRtxws5qv7t57UceFbjvv6ZAb+bw5HobCIY
         2fnUKSEhppNe578QVjB5k5PqqJT+tRYeTX9TzYf4I9bhYOBN7usl4Z57WwDZcdf8Knak
         5Ap1ptF8PeiD8jb+EcMu7jGJfZFzHUbdXBqMkUXGaG7k7tRZrZY+210ZTTSDBeEDwwW0
         s6tf1UrW09YaJuhrQ+xCRCQmp18gfCtFDtzP2JfOaj04vNzzsCtg7Zza0xujvsxirgWT
         hE6eYx6HQKLMe//PHdDK1lD0yn1jAEM4TL/TkqoCmozpM3rPtwZSJriJ/EKgdhrgO27h
         GOUA==
X-Gm-Message-State: APjAAAXbx7OaZ2QyADuQgdm9+EsOaj4I32cipVEssxjIKu7A17JNGiAb
        2gmVM/uT94dWfT3Kp5AZcyBV85M=
X-Google-Smtp-Source: APXvYqzf7QvbOER6Pdtj2E1hKd74VR9u2nJPawUxC4mJhMzOvVrjnsXYTyJFzFaQKJYi3IcHdhpkxeM=
X-Received: by 2002:a81:9917:: with SMTP id q23mr14340518ywg.312.1567218869396;
 Fri, 30 Aug 2019 19:34:29 -0700 (PDT)
Date:   Fri, 30 Aug 2019 19:34:26 -0700
Message-Id: <20190831023427.239820-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next 1/2] selftests/bpf: test_progs: fix verbose mode garbage
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

fseeko(.., 0, SEEK_SET) on a memstream just puts the buffer pointer
to the beginning so when we call fflush on it we get some garbage
log data from the previous test. Let's manually set terminating
byte to zero at the reported buffer size.

To show the issue consider the following snippet:

	stream = open_memstream (&buf, &len);

	fprintf(stream, "aaa");
	fflush(stream);
	printf("buf=%s, len=%zu\n", buf, len);
	fseeko(stream, 0, SEEK_SET);

	fprintf(stream, "b");
	fflush(stream);
	printf("buf=%s, len=%zu\n", buf, len);

Output:

	buf=aaa, len=3
	buf=baa, len=1

Fixes: 946152b3c5d6 ("selftests/bpf: test_progs: switch to open_memstream")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index e5892cb60eca..e8616e778cb5 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -45,6 +45,7 @@ static void dump_test_log(const struct prog_test_def *test, bool failed)
 
 	if (env.verbose || test->force_log || failed) {
 		if (env.log_cnt) {
+			env.log_buf[env.log_cnt] = '\0';
 			fprintf(env.stdout, "%s", env.log_buf);
 			if (env.log_buf[env.log_cnt - 1] != '\n')
 				fprintf(env.stdout, "\n");
-- 
2.23.0.187.g17f5b7556c-goog

