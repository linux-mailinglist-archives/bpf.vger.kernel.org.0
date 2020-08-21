Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF224D808
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHUPIe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:08:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22867 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgHUPI2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598022507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uODo1xhZPpoE3Yi6G3zNfVEp5LhzGrNq511alukRd44=;
        b=Nc6UPmxx3vG5Zj+WQaI2o3k/bELdOHLAVTLkwH1+mcxVW+p4MOJizBmUnPjrKlvNiYQfGy
        9kr1NoW2VZsFmM0jpcSgaBjeoAigiu8o8Oqx8Yfl3s//p6utKfNj35CjrbLz+flaM6Af5D
        hWIKqdHGl/t4CJHXLs+hq4Z+DLkmlBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-LqbHJrbCNu6ao_tfVUSYWw-1; Fri, 21 Aug 2020 11:08:24 -0400
X-MC-Unique: LqbHJrbCNu6ao_tfVUSYWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55F85107465A;
        Fri, 21 Aug 2020 15:08:23 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DB9F5D9CC;
        Fri, 21 Aug 2020 15:08:20 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id B67AF30736C8B;
        Fri, 21 Aug 2020 17:08:18 +0200 (CEST)
Subject: [PATCH bpf] selftests/bpf: Fix test_progs-flavor run getting number
 of tests
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, yhs@fb.com
Date:   Fri, 21 Aug 2020 17:08:18 +0200
Message-ID: <159802249863.919353.9321169154213417316.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Fix the issue by printing "flavor" info to stderr instead of stdout.

Fixes: 643e7233aa94 ("selftests/bpf: Test_progs option for getting number of tests")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_progs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index b1e4dadacd9b..d858e883bd75 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -618,7 +618,7 @@ int cd_flavor_subdir(const char *exec_name)
 	if (!flavor)
 		return 0;
 	flavor++;
-	fprintf(stdout, "Switching to flavor '%s' subdirectory...\n", flavor);
+	fprintf(stderr, "Switching to flavor '%s' subdirectory...\n", flavor);
 	return chdir(flavor);
 }
 


