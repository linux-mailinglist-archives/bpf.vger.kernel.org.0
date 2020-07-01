Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD3211437
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 22:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgGAUTP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 16:19:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54967 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgGAUTP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Jul 2020 16:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593634753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nEpLa92itLbIaK0rWrJJY4HDP/pyUCqwTL+6awhsh50=;
        b=CPxLyUsk8J1lMpXghxMHes2H6JU67UqQczktww6h2IciFPhkp4Sqt4E1SS52wQrL6+3xQS
        nvhVwBgNsq1uAB2L+IrdfXdU1nrzU3VdXLzxwbnBRjY3g07N8uN0BoXvC00JpWrDvvhl/9
        lY0oTZsaZFwrptzppCYOw42z7RMXrcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-yVBgf4E5M2KJb2w9QGZyNg-1; Wed, 01 Jul 2020 16:19:11 -0400
X-MC-Unique: yVBgf4E5M2KJb2w9QGZyNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9441F8015F6;
        Wed,  1 Jul 2020 20:19:10 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D0355C220;
        Wed,  1 Jul 2020 20:19:10 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 4DB54300003EB;
        Wed,  1 Jul 2020 22:19:09 +0200 (CEST)
Subject: [PATCH bpf-next V2 3/3] selftests/bpf: test_progs indicate to shell
 on non-actions
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com
Date:   Wed, 01 Jul 2020 22:19:09 +0200
Message-ID: <159363474925.929474.15491499711324280696.stgit@firesoul>
In-Reply-To: <159363468114.929474.3089726346933732131.stgit@firesoul>
References: <159363468114.929474.3089726346933732131.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a user selects a non-existing test the summary is printed with
indication 0 for all info types, and shell "success" (EXIT_SUCCESS) is
indicated. This can be understood by a human end-user, but for shell
scripting is it useful to indicate a shell failure (EXIT_FAILURE).

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_progs.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 3345cd977c10..75cf5b13cbd6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -706,11 +706,8 @@ int main(int argc, char **argv)
 		goto out;
 	}
 
-	if (env.list_test_names) {
-		if (env.succ_cnt == 0)
-			env.fail_cnt = 1;
+	if (env.list_test_names)
 		goto out;
-	}
 
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
@@ -723,5 +720,9 @@ int main(int argc, char **argv)
 	free_str_set(&env.subtest_selector.whitelist);
 	free(env.subtest_selector.num_set);
 
+	/* Return EXIT_FAILURE when options resulted in no actions */
+	if (!env.succ_cnt && !env.fail_cnt && !env.skip_cnt)
+		env.fail_cnt = 1;
+
 	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
 }


