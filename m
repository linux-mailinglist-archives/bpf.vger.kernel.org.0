Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3B3495D3
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 16:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhCYPlu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 11:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231327AbhCYPlV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 11:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616686878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pv3/pnycfrVRu1VGxuiha38s0MxnL2KBL2zpqVHqPs=;
        b=O6qJljGTF6SwtJmNvApsjE5TdiIdAjzo0KKTmGfm4nnP5sO2xnnLDQlded0chJZ4vfrDCC
        EpKiiU8dCEthkOVDlOTGgrGGbVtr7O5zkbLSgrjk3/6PTjvskgxgCJUtquKERoZQgUek5G
        RIZnGwbYEpDP7VJu6XXU//Z88atHJN4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-zU2_8oukOrmol8unUnUHyQ-1; Thu, 25 Mar 2021 11:41:09 -0400
X-MC-Unique: zU2_8oukOrmol8unUnUHyQ-1
Received: by mail-ed1-f71.google.com with SMTP id h2so2862778edw.10
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 08:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1pv3/pnycfrVRu1VGxuiha38s0MxnL2KBL2zpqVHqPs=;
        b=Z6RSc4TVA6ynGnnvSL40OxxXxGJZn/4ru6/1WB+uAr0HjkH1SN8YlhS0OdVsUa/qFL
         bkbCYconGyDVk0zQZikGAnXnvC1GjZkgfEunvlKAjVUKxoPWLAtb2DB2JPIZ4bLw5BV/
         3DELK055f689+wArT6yVUg3F4ljCG/cq8zWsODyN0m4Cs+lgWAn6HgOGXDHjp+Ncj+Dr
         4bu5s3PXuMS3SozImOjRkXCrfEeDJN/2UHFfC5HngcJXZx38qE/hLcJ1GAfvhmqsFw4s
         IG9pWGTrRhHL2FqvJRqrufa9cIWSuNU+Ll/MS7uueJWS0l/RLRAVVAMeN1uTeNAtwtDf
         ffOg==
X-Gm-Message-State: AOAM5330hXO6u8LB0NwdtcrvrOS37AxMPzd/EioXm6aH17iQqe3dPkHJ
        Qz1rzDylNz6HG1xtLU8QW0calE1j7YMhfbhTHAKl3qK9u6rMbRHkeO688ryarGLTypCxJoxZQJl
        VPdYKOTxlf4vu
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr10621180ejm.87.1616686868501;
        Thu, 25 Mar 2021 08:41:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB9z7SvrRgAr/XRHVbv0Ypve+lfCS12OxaE8vE9phJpo+BTalmijrbZUf4chfPUcnZ4ioI6w==
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr10621153ejm.87.1616686868340;
        Thu, 25 Mar 2021 08:41:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o6sm2849100edw.24.2021.03.25.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:41:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D385A18028C; Thu, 25 Mar 2021 16:41:05 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Clark Williams <williams@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf 2/2] bpf/selftests: test that kernel rejects a TCP CC with an invalid license
Date:   Thu, 25 Mar 2021 16:40:34 +0100
Message-Id: <20210325154034.85346-2-toke@redhat.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210325154034.85346-1-toke@redhat.com>
References: <20210325154034.85346-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a selftest to check that the verifier rejects a TCP CC struct_ops
with a non-GPL license. To save having to add a whole new BPF object just
for this, reuse the dctcp CC, but rewrite the license field before loading.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 37c5494a0381..613cf8a00b22 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -227,10 +227,41 @@ static void test_dctcp(void)
 	bpf_dctcp__destroy(dctcp_skel);
 }
 
+static void test_invalid_license(void)
+{
+	/* We want to check that the verifier refuses to load a non-GPL TCP CC.
+	 * Rather than create a whole new file+skeleton, just reuse an existing
+	 * object and rewrite the license in memory after loading. Sine libbpf
+	 * doesn't expose this, we define a struct that includes the first couple
+	 * of internal fields for struct bpf_object so we can overwrite the right
+	 * bits. Yes, this is a bit of a hack, but it makes the test a lot simpler.
+	 */
+	struct bpf_object_fragment {
+		char name[BPF_OBJ_NAME_LEN];
+		char license[64];
+	} *obj;
+	struct bpf_dctcp *skel;
+	int err;
+
+	skel = bpf_dctcp__open();
+	if (CHECK(!skel, "bpf_dctcp__open", "failed\n"))
+		return;
+
+	obj = (void *)skel->obj;
+	obj->license[0] = 'X'; // turns 'GPL' into 'XPL' which will fail the check
+
+	err = bpf_dctcp__load(skel);
+	CHECK(err != -LIBBPF_ERRNO__VERIFY, "bpf_dctcp__load", "err:%d\n", err);
+
+	bpf_dctcp__destroy(skel);
+}
+
 void test_bpf_tcp_ca(void)
 {
 	if (test__start_subtest("dctcp"))
 		test_dctcp();
 	if (test__start_subtest("cubic"))
 		test_cubic();
+	if (test__start_subtest("invalid_license"))
+		test_invalid_license();
 }
-- 
2.31.0

