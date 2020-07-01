Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB4211545
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 23:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgGAVoR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 17:44:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37870 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgGAVoR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 17:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593639856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wl/H9/tgtObSfb+1v5cHf8t0bewQp9ap+L2O/qbBKcc=;
        b=TT4EcFnkx7Qh6/Rz7kKYbCrrYnxtKxER2I9r8DJqKiE8R/xK2onc5iOwj0sT8vqa78HsdG
        Q9S8i1Z6IXlmCgVCEuP6L3pFXunJsxnqNbTVATGVA/qyWWx8cRTwY9vAY3cjCfdlPchMLR
        RPXDsso4Oo6qCyMfTnPhJKMejjKSyxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-IwYEmN9ZM-yOIIPf8TWcgA-1; Wed, 01 Jul 2020 17:44:12 -0400
X-MC-Unique: IwYEmN9ZM-yOIIPf8TWcgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 663A5EC1A9;
        Wed,  1 Jul 2020 21:44:11 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76DE977885;
        Wed,  1 Jul 2020 21:44:08 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 69EE7300003EB;
        Wed,  1 Jul 2020 23:44:07 +0200 (CEST)
Subject: [PATCH bpf-next V3 1/3] selftests/bpf: test_progs indicate to shell
 on non-actions
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com
Date:   Wed, 01 Jul 2020 23:44:07 +0200
Message-ID: <159363984736.930467.17956007131403952343.stgit@firesoul>
In-Reply-To: <159363976938.930467.11835380146293463365.stgit@firesoul>
References: <159363976938.930467.11835380146293463365.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 tools/testing/selftests/bpf/test_progs.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 54fa5fa688ce..da70a4f72f54 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -687,5 +687,8 @@ int main(int argc, char **argv)
 	free_str_set(&env.subtest_selector.whitelist);
 	free(env.subtest_selector.num_set);
 
+	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
+		return EXIT_FAILURE;
+
 	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
 }


