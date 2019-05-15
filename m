Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC161F5D6
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfEONsQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 May 2019 09:48:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33540 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfEONsP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 May 2019 09:48:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so2804876wrx.0
        for <bpf@vger.kernel.org>; Wed, 15 May 2019 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgryeVXBfS0oVlWILr3leOrpFjnwkDVNHwaRTJYmSLs=;
        b=Wmz44KxNc+WRAG37tbtVeUY8uQiVejN1WhSs1iXgHDYxv4oCMYT+yjQ0veYGBot2ba
         yxeaLfF6beXeyGniY/YNQOUzQHVR2u0s9JyJ7nM+CFJhbe3RjRPe3YaJ1ahLsN/m6O/7
         mAtELVAbVymulWB8lnXEtF7Tbyq3yGIbhxozQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgryeVXBfS0oVlWILr3leOrpFjnwkDVNHwaRTJYmSLs=;
        b=ZADybuCVuBkagzzAKt1lcGqLR/vZZ+f45u4cuDncw6HeqB2nU3ucl6sFx3WL+aWorq
         uujqFAjrC8s8A6rzOsX4eKMZnib0hZyxzJV/sQdANX5B0UhK6SiatdgGysG3+4McRjo5
         gymM4Lei1kFJVxH9VWrSgpUGMsZV8hvsc/mjS8pPRxfaqXPs5SNVBnffLzmSgEaa/FRu
         aTd8y1aA38oenwIFkt2lv2n/CHV9ss9vzLLqDvzk1gcLCs2ZEw0WeQ8Q1W5u86JKC4a2
         UdcFrQbZ94eREUMjWJ0a8jsPzCujnekRHV619W8yBfGMCVrqChpfRoLLJXPkxs0d7wOl
         tj/A==
X-Gm-Message-State: APjAAAX9eXBeQcSge7utQzDqrNYCWLb9ty9YndRAbeBglKHI+IVyHQmy
        PnFpsgHlTx77Ggw771xCg++AnH68Du5spA==
X-Google-Smtp-Source: APXvYqxoKpq4i6hxR1Vd+uEIthTPeUr9Z2rxDVTBtNcWEq/8JUOsD/KwIJmcXYs0OmIhopWuSg9uyw==
X-Received: by 2002:adf:8385:: with SMTP id 5mr8392281wre.194.1557928093806;
        Wed, 15 May 2019 06:48:13 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aea35.dynamic.kabel-deutschland.de. [95.90.234.53])
        by smtp.gmail.com with ESMTPSA id v5sm4498506wra.83.2019.05.15.06.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:48:12 -0700 (PDT)
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
        Jiong Wang <jiong.wang@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1 0/3] Test the 32bit narrow reads
Date:   Wed, 15 May 2019 15:47:25 +0200
Message-Id: <20190515134731.12611-1-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These patches try to test the fix made in commit e2f7fc0ac695 ("bpf:
fix undefined behavior in narrow load handling"). The problem existed
in the generated BPF bytecode that was doing a 32bit narrow read of a
64bit field, so to test it the code would need to be executed.
Currently the only such field exists in BPF_PROG_TYPE_PERF_EVENT,
which is not supported by bpf_prog_test_run().

First commit adds the test, but since I can't run it, I'm not sure if
it is even valid (because endianness, for example). Second commit adds
a message to test_verifier when it couldn't run the program because of
lack permissions or program type being not supported. Third commit
fixes a possible problem with errno.

With these patches, I get the following output on my test:

/kernel/tools/testing/selftests/bpf$ sudo ./test_verifier 920 920
#920/p 32bit loads of a 64bit field (both least and most significant words) Did not run the program (not supported) OK
Summary: 1 PASSED, 0 SKIPPED, 0 FAILED

So it looks like I need to pick a different approach.

Krzesimir Nowak (3):
  selftests/bpf: Test correctness of narrow 32bit read on 64bit field
  selftests/bpf: Print a message when tester could not run a program
  selftests/bpf: Avoid a clobbering of errno

 tools/testing/selftests/bpf/test_verifier.c   | 19 +++++++++++++++----
 .../testing/selftests/bpf/verifier/var_off.c  | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.20.1

