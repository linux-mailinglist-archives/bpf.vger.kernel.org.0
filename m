Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF18404AC6
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbhIILsX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 07:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238112AbhIILqV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 07:46:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47B7D61214;
        Thu,  9 Sep 2021 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631187775;
        bh=h6FqXYCR30wR/rITiby2miwzaK5galCFD9iDPMZKP1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdu25mCXm/nq/YbIdoGRsY32W22s/6ejNjewYeopEGxdxKudCe1FkAr13knIc4wac
         OCkX6SEQxjUWru3ezbvZtCaJMVjSAL/iT0YVmUpVL3betjDTOoRcTVB3PcBGXWeF6A
         rht7Eb3QvfVLldX+HT+LWspR8WZ7dbbJ+dCdy0SJerQW9fse1OknazCdM/NrMHCuzL
         i7YOfaRBz1INedw2knOwVQTFy9w4L+DqiTxFP4opJ/RPKdzjbhSSFGrqvxr/6rsheR
         u+oaD7z8ydPTe6BwqnDrbiJFTe9cp9AmecZhDxRCck3Wfdsz1iu1BNA0uepnnWrGTD
         Uo81U/LQ3bcwQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juhee Kang <claudiajkang@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 085/252] samples: bpf: Fix tracex7 error raised on the missing argument
Date:   Thu,  9 Sep 2021 07:38:19 -0400
Message-Id: <20210909114106.141462-85-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114106.141462-1-sashal@kernel.org>
References: <20210909114106.141462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Juhee Kang <claudiajkang@gmail.com>

[ Upstream commit 7d07006f05922b95518be403f08ef8437b67aa32 ]

The current behavior of 'tracex7' doesn't consist with other bpf samples
tracex{1..6}. Other samples do not require any argument to run with, but
tracex7 should be run with btrfs device argument. (it should be executed
with test_override_return.sh)

Currently, tracex7 doesn't have any description about how to run this
program and raises an unexpected error. And this result might be
confusing since users might not have a hunch about how to run this
program.

    // Current behavior
    # ./tracex7
    sh: 1: Syntax error: word unexpected (expecting ")")
    // Fixed behavior
    # ./tracex7
    ERROR: Run with the btrfs device argument!

In order to fix this error, this commit adds logic to report a message
and exit when running this program with a missing argument.

Additionally in test_override_return.sh, there is a problem with
multiple directory(tmpmnt) creation. So in this commit adds a line with
removing the directory with every execution.

Signed-off-by: Juhee Kang <claudiajkang@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20210727041056.23455-1-claudiajkang@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/test_override_return.sh | 1 +
 samples/bpf/tracex7_user.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/samples/bpf/test_override_return.sh b/samples/bpf/test_override_return.sh
index e68b9ee6814b..35db26f736b9 100755
--- a/samples/bpf/test_override_return.sh
+++ b/samples/bpf/test_override_return.sh
@@ -1,5 +1,6 @@
 #!/bin/bash
 
+rm -r tmpmnt
 rm -f testfile.img
 dd if=/dev/zero of=testfile.img bs=1M seek=1000 count=1
 DEVICE=$(losetup --show -f testfile.img)
diff --git a/samples/bpf/tracex7_user.c b/samples/bpf/tracex7_user.c
index fdcd6580dd73..8be7ce18d3ba 100644
--- a/samples/bpf/tracex7_user.c
+++ b/samples/bpf/tracex7_user.c
@@ -14,6 +14,11 @@ int main(int argc, char **argv)
 	int ret = 0;
 	FILE *f;
 
+	if (!argv[1]) {
+		fprintf(stderr, "ERROR: Run with the btrfs device argument!\n");
+		return 0;
+	}
+
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 	obj = bpf_object__open_file(filename, NULL);
 	if (libbpf_get_error(obj)) {
-- 
2.30.2

