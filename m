Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB15ACC64
	for <lists+bpf@lfdr.de>; Mon,  5 Sep 2022 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiIEHZp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Sep 2022 03:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiIEHZY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 03:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECC40BD2
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662362548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=huAsQvTHf1MfWOR1ef8OyW/tB/hrhJOT8AWaWSAq/5k=;
        b=RNnw55Di60ZIV9PMiDVUrMnJEWt+nX+RPBLFq5e2+qU9W0er01OMKnv1lIs0+axWs/U3dX
        JkexTcOPS8C0+RMzIzpcO+MncssPOF1HcfQC7PXzQovohQYvE6WPE9lJFwyMZsZeHXUgkm
        r/LZhqCAO51+RFYJzzdg1644l/paZ1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-2NQFd4FnME6dnGREbTAeJw-1; Mon, 05 Sep 2022 03:22:25 -0400
X-MC-Unique: 2NQFd4FnME6dnGREbTAeJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAAAB85A585;
        Mon,  5 Sep 2022 07:22:24 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 470821121314;
        Mon,  5 Sep 2022 07:22:23 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH bpf-next] selftests: bpf: test_kmod.sh: pass parameter to the module
Date:   Mon,  5 Sep 2022 10:22:19 +0300
Message-Id: <20220905072219.56361-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's possible to specify particular tests for test_bpf.ko with
module parameters. Make it possible to pass a module parameter as
the first test_kmod.sh argument, example:

test_kmod.sh test_range=1,3

Since magnitude tests take long time it can be reasonable to skip
them.

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---
 tools/testing/selftests/bpf/test_kmod.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmod.sh b/tools/testing/selftests/bpf/test_kmod.sh
index 4f6444bcd53f..3cb52ba20db8 100755
--- a/tools/testing/selftests/bpf/test_kmod.sh
+++ b/tools/testing/selftests/bpf/test_kmod.sh
@@ -4,6 +4,8 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+MOD_PARAM="$1"
+
 msg="skip all tests:"
 if [ "$(id -u)" != "0" ]; then
 	echo $msg please run this as root >&2
@@ -26,15 +28,15 @@ test_run()
 	echo "[ JIT enabled:$1 hardened:$2 ]"
 	dmesg -C
 	if [ -f ${OUTPUT}/lib/test_bpf.ko ]; then
-		insmod ${OUTPUT}/lib/test_bpf.ko 2> /dev/null
+		insmod ${OUTPUT}/lib/test_bpf.ko $MOD_PARAM 2> /dev/null
 		if [ $? -ne 0 ]; then
 			rc=1
 		fi
 	else
 		# Use modprobe dry run to check for missing test_bpf module
-		if ! /sbin/modprobe -q -n test_bpf; then
+		if ! /sbin/modprobe -q -n test_bpf $MOD_PARAM; then
 			echo "test_bpf: [SKIP]"
-		elif /sbin/modprobe -q test_bpf; then
+		elif /sbin/modprobe -q test_bpf $MOD_PARAM; then
 			echo "test_bpf: ok"
 		else
 			echo "test_bpf: [FAIL]"
-- 
2.34.1

