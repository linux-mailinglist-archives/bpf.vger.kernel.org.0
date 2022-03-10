Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A84D54EC
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 23:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbiCJW5l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 17:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCJW5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 17:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45D871986FF
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 14:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646952997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+C4z+W6JKvW1PkIKtt/f0rXq2MGC/kPw7Xm7/uk89s=;
        b=FjZelZNX4hNp2TNws2K2Hojj4QyhC76VuUJEYSjNLMLFnEdJyHslxeUCfGwO7dzH89Vnya
        Q2OtKXlnqbmsMFlTVkZtl/hhepHNFibb+tdFfh/bIPg2eSwX8f1O5KDyzry5qornzSofc6
        q+pQBqXt1zCk7xC2tqeNPjg0zE5eGCE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-eUabmi_OMWW7N8FhYRWzZQ-1; Thu, 10 Mar 2022 17:56:36 -0500
X-MC-Unique: eUabmi_OMWW7N8FhYRWzZQ-1
Received: by mail-ej1-f70.google.com with SMTP id hq34-20020a1709073f2200b006d677c94909so3913927ejc.8
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 14:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+C4z+W6JKvW1PkIKtt/f0rXq2MGC/kPw7Xm7/uk89s=;
        b=WUoBhb6puiLpAMzmrcavtk+QeXzF4WRho5UFB46H3lXXygY3i6Bbn90njclHUem0BO
         F2rTRE+MKlJ0hRd09kVhpL+IBCPuc8Wcrq4vJikYWXY8goTsHko8loQlBCB0faKNEbS/
         MPuR0bhiOwWYyNgzB38UxGbkv64dqI6S3Xvoe026g6j9qDOboJlSDDLqJ5M7yaMYUBgw
         u4yu5+TIPHcakZPSdhR0ExteBstvbFRW3nY90hWRpMeYzkJ4kzeSdZiDc8QofDcDwOnT
         +9GA0h3oW4eEJ7Uyce5558ZRy5jEsbSP3+JcYMqVv52kKV2VLurEIkOqcdnXVnaMS7sr
         H8TA==
X-Gm-Message-State: AOAM532NTplaumvlCxX3EYfoljnPv20dDGV8QkZCvPXUcAUDyV9nmF2O
        ywu/db5pOmZLaOzLRSptTOHG8TpFpe7NaCkXk8U/2iIKpEyXbfyqeQBqqC2lFtxy+XJ78Xk3r7b
        WkqY1PKNqQ1G6
X-Received: by 2002:a17:907:da4:b0:6da:7952:ccd2 with SMTP id go36-20020a1709070da400b006da7952ccd2mr6015469ejc.763.1646952993996;
        Thu, 10 Mar 2022 14:56:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsZOomQyju/SgppJIjOpLtra7yrnPadi1K+LnceE/3q023DlNqyHtR4F2O64IOpBOAZBUmdA==
X-Received: by 2002:a17:907:da4:b0:6da:7952:ccd2 with SMTP id go36-20020a1709070da400b006da7952ccd2mr6015421ejc.763.1646952992959;
        Thu, 10 Mar 2022 14:56:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm2259017ejm.188.2022.03.10.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:56:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C34181A89A3; Thu, 10 Mar 2022 23:56:31 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a test for maximum packet size in xdp_do_redirect
Date:   Thu, 10 Mar 2022 23:56:21 +0100
Message-Id: <20220310225621.53374-2-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310225621.53374-1-toke@redhat.com>
References: <20220310225621.53374-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds an extra test to the xdp_do_redirect selftest for XDP live packet
mode, which verifies that the maximum permissible packet size is accepted
without any errors, and that a too big packet is correctly rejected.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../bpf/prog_tests/xdp_do_redirect.c          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index 9926b07e38c8..a50971c6cf4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -62,6 +62,28 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int fd)
 	return 0;
 }
 
+/* The maximum permissible size is: PAGE_SIZE - sizeof(struct xdp_page_head) -
+ * sizeof(struct skb_shared_info) - XDP_PACKET_HEADROOM = 3368 bytes
+ */
+#define MAX_PKT_SIZE 3368
+static void test_max_pkt_size(int fd)
+{
+	char data[MAX_PKT_SIZE + 1] = {};
+	int err;
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = MAX_PKT_SIZE,
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = 1,
+		);
+	err = bpf_prog_test_run_opts(fd, &opts);
+	ASSERT_OK(err, "prog_run_max_size");
+
+	opts.data_size_in += 1;
+	err = bpf_prog_test_run_opts(fd, &opts);
+	ASSERT_EQ(err, -EINVAL, "prog_run_too_big");
+}
+
 #define NUM_PKTS 10000
 void test_xdp_do_redirect(void)
 {
@@ -167,6 +189,8 @@ void test_xdp_do_redirect(void)
 	ASSERT_EQ(skel->bss->pkts_seen_zero, 2, "pkt_count_zero");
 	ASSERT_EQ(skel->bss->pkts_seen_tc, NUM_PKTS - 2, "pkt_count_tc");
 
+	test_max_pkt_size(bpf_program__fd(skel->progs.xdp_count_pkts));
+
 out_tc:
 	bpf_tc_hook_destroy(&tc_hook);
 out:
-- 
2.35.1

