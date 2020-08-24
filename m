Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14B124FD11
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHXL5a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 07:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgHXL53 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Aug 2020 07:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598270248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=byhy0L7Z/GZciYi7AZTSlAg56dSdBRaijFzPc2IFMhQ=;
        b=UKUh8Yb2WZyPni3R53o7QJR4e2u/dW0fI0yX8NOu9G7QeL2x0dcElDH+wZFKvk9jEbBdH4
        MqUHNtoYhBoJAziro3qM1BuBKOWMJiI+QaZthfzshwTlV94mcq6ZqlrvyHH4r+6ViPh5TR
        oOe40581RkITedBMiU7J4Z+jnSUkvDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-HeU72245PWWle7nlD4ULpg-1; Mon, 24 Aug 2020 07:57:26 -0400
X-MC-Unique: HeU72245PWWle7nlD4ULpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AD5B81F00C;
        Mon, 24 Aug 2020 11:57:25 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0391F60C47;
        Mon, 24 Aug 2020 11:57:21 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id AEA0C30736C8B;
        Mon, 24 Aug 2020 13:57:20 +0200 (CEST)
Subject: [PATCH bpf V2] selftests/bpf: Fix test_progs-flavor run getting
 number of tests
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, yhs@fb.com
Date:   Mon, 24 Aug 2020 13:57:20 +0200
Message-ID: <159827024012.923543.7104106594870150597.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 643e7233aa94 ("selftests/bpf: Test_progs option for getting number of
tests") introduced ability to getting number of tests, which is targeted
towards scripting.  As demonstrate in the commit the number can be use as a
shell variable for further scripting.

The test_progs program support "flavor", which is detected by the binary
have a "-flavor" in the executable name. One example is test_progs-no_alu32,
which load bpf-progs compiled with disabled alu32, located in dir 'no_alu32/'.

The problem is that invoking a "flavor" binary prints to stdout e.g.:
 "Switching to flavor 'no_alu32' subdirectory..."
Thus, intermixing with the number of tests, making it unusable for scripting.

Fix the issue by only printing "flavor" info when verbose -v option is used.

Fixes: 643e7233aa94 ("selftests/bpf: Test_progs option for getting number of tests")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_progs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index b1e4dadacd9b..22943b58d752 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -618,7 +618,9 @@ int cd_flavor_subdir(const char *exec_name)
 	if (!flavor)
 		return 0;
 	flavor++;
-	fprintf(stdout, "Switching to flavor '%s' subdirectory...\n", flavor);
+	if (env.verbosity > VERBOSE_NONE)
+		fprintf(stdout,	"Switching to flavor '%s' subdirectory...\n", flavor);
+
 	return chdir(flavor);
 }
 


