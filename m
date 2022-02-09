Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D474AE61E
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 01:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiBIAf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 19:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbiBIAfy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 19:35:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDFC061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 16:35:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61B5BB81DBE
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 00:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53428C340EE;
        Wed,  9 Feb 2022 00:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644366951;
        bh=1OsbDAkRCBcM7d1+agog4NXzE/5TWssVEKRgH703PLw=;
        h=From:To:Cc:Subject:Date:From;
        b=p50nyDMHg4XgbuVwv4p36Zxogk7bqyWXjxCaF0jfygFQEGEHKUBgFe0em+PKiZMdn
         IQDw9clqDMlWyAHgcQOaLVzg+c+yAUhr/bo5i/6O5sCA9p0fSf2NvBm/yVr5tmRr3H
         iWxhMspbA2cHxJibgtK1VFpjCMYZans9pdoNN2T0XLQMW0QF4yM0uF85AmHOBwB+Yb
         pT95JVBcBpuL5+WCSj2QM8L9AKVcMF3ps5QAtOMBqgPTNeDdeXuWmoOBglQOCrvj4a
         rt/oA++Wif9QdQg3zRhNEilGfTdVQlIgxwQvX+PS1HyUyUruqHsMAEMJ1Wr0iaQmkZ
         ff4mkgLdQ5YNQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        toke@redhat.com, lorenzo.bianconi@redhat.com, andrii@kernel.org,
        yhs@fb.com
Subject: [PATCH v2 bpf-next] selftest/bpf: check invalid length in test_xdp_update_frags
Date:   Wed,  9 Feb 2022 01:35:12 +0100
Message-Id: <3e4afa0ee4976854b2f0296998fe6754a80b62e5.1644366736.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update test_xdp_update_frags adding a test for a buffer size
set to (MAX_SKB_FRAGS + 2) * PAGE_SIZE. The kernel is supposed
to return -ENOMEM.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- updated ASSERT log message
---
 .../bpf/prog_tests/xdp_adjust_frags.c         | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
index d18e6f343c48..2f033da4cd45 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
@@ -5,11 +5,12 @@
 static void test_xdp_update_frags(void)
 {
 	const char *file = "./test_xdp_update_frags.o";
+	int err, prog_fd, max_skb_frags, buf_size, num;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	int err, prog_fd;
 	__u32 *offset;
 	__u8 *buf;
+	FILE *f;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
 	obj = bpf_object__open(file);
@@ -99,6 +100,41 @@ static void test_xdp_update_frags(void)
 	ASSERT_EQ(buf[7621], 0xbb, "xdp_update_frag buf[7621]");
 
 	free(buf);
+
+	/* test_xdp_update_frags: unsupported buffer size */
+	f = fopen("/proc/sys/net/core/max_skb_frags", "r");
+	if (!ASSERT_OK_PTR(f, "max_skb_frag file pointer"))
+		goto out;
+
+	num = fscanf(f, "%d", &max_skb_frags);
+	fclose(f);
+
+	if (!ASSERT_EQ(num, 1, "max_skb_frags read failed"))
+		goto out;
+
+	/* xdp_buff linear area size is always set to 4096 in the
+	 * bpf_prog_test_run_xdp routine.
+	 */
+	buf_size = 4096 + (max_skb_frags + 1) * sysconf(_SC_PAGE_SIZE);
+	buf = malloc(buf_size);
+	if (!ASSERT_OK_PTR(buf, "alloc buf"))
+		goto out;
+
+	memset(buf, 0, buf_size);
+	offset = (__u32 *)buf;
+	*offset = 16;
+	buf[*offset] = 0xaa;
+	buf[*offset + 15] = 0xaa;
+
+	topts.data_in = buf;
+	topts.data_out = buf;
+	topts.data_size_in = buf_size;
+	topts.data_size_out = buf_size;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_EQ(err, -ENOMEM,
+		  "unsupported buf size, possible non-default /proc/sys/net/core/max_skb_flags?");
+	free(buf);
 out:
 	bpf_object__close(obj);
 }
-- 
2.34.1

