Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28375B1BC9
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 13:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiIHLpK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIHLpJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 07:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026653E771
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662637508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InIEn6Rm7e/7YT/6NTccV9QlpGTX/QrfJ5NqmGvNorI=;
        b=ccTAKciqH9lZLwgfkzVvMPkmyy2/8CVvln6rwXoNw/VrZFJrLxaBqEHuVkeTtwTXIb/iks
        IC2oKOjRTzg7z5C6T+d1VgS/RYtwhm8ojR+grHxkBwsP1POq5aU9eb0VuLXTPgcXBi6f2p
        Pmjht5QovTw8RPPjsnrI6Q7LiFiLy90=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-11GEVHHZPjeQ8vwGblbhgw-1; Thu, 08 Sep 2022 07:45:03 -0400
X-MC-Unique: 11GEVHHZPjeQ8vwGblbhgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4A4B296A608;
        Thu,  8 Sep 2022 11:45:02 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.194.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98AB52166B26;
        Thu,  8 Sep 2022 11:45:00 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, song@kernel.org,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH bpf-next v2] selftests: bpf: test_kmod.sh: pass parameters to the module
Date:   Thu,  8 Sep 2022 14:44:58 +0300
Message-Id: <20220908114458.378999-1-ykaliuta@redhat.com>
In-Reply-To: <20220905072219.56361-1-ykaliuta@redhat.com>
References: <20220905072219.56361-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's possible to specify particular tests for test_bpf.ko with
module parameters. Make it possible to pass the module parameters,
example:

test_kmod.sh test_range=1,3

Since magnitude tests take long time it can be reasonable to skip
them.

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---
v1->v2: pass all the parameters, "$@", not only the first one.
---
 tools/testing/selftests/bpf/test_kmod.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmod.sh b/tools/testing/selftests/bpf/test_kmod.sh
index 4f6444bcd53f..6550d523b04a 100755
--- a/tools/testing/selftests/bpf/test_kmod.sh
+++ b/tools/testing/selftests/bpf/test_kmod.sh
@@ -26,15 +26,15 @@ test_run()
 	echo "[ JIT enabled:$1 hardened:$2 ]"
 	dmesg -C
 	if [ -f ${OUTPUT}/lib/test_bpf.ko ]; then
-		insmod ${OUTPUT}/lib/test_bpf.ko 2> /dev/null
+		insmod ${OUTPUT}/lib/test_bpf.ko "$@" 2> /dev/null
 		if [ $? -ne 0 ]; then
 			rc=1
 		fi
 	else
 		# Use modprobe dry run to check for missing test_bpf module
-		if ! /sbin/modprobe -q -n test_bpf; then
+		if ! /sbin/modprobe -q -n test_bpf "$@"; then
 			echo "test_bpf: [SKIP]"
-		elif /sbin/modprobe -q test_bpf; then
+		elif /sbin/modprobe -q test_bpf "$@"; then
 			echo "test_bpf: ok"
 		else
 			echo "test_bpf: [FAIL]"
-- 
2.37.3

