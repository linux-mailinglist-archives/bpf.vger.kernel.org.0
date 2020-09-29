Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13927CBE6
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgI2Mbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 08:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732295AbgI2Mam (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 08:30:42 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601382641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xvzLng++d0GQjJBUi/0nO1Ms1IYQwD4+9R7Ygprni3c=;
        b=F0mG7jjj1+34SY89PNbwwMRWRVMruW7N5drLiRSmbXgQ04hK46fnQA+mRa00aHfMTP1FsZ
        ZUL21knQaUgYk9CBlA2Y+9bLfOEYXYvcxqwqXEdE4Di/SEi8Vev+iH5YZWKMm18J1wWnR0
        dmLZKacuDxQg/1AuUgw7MG8ofsugmJM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-muOCOB04M-CSAK0Aj7sJSg-1; Tue, 29 Sep 2020 08:30:37 -0400
X-MC-Unique: muOCOB04M-CSAK0Aj7sJSg-1
Received: by mail-oo1-f71.google.com with SMTP id q189so1974115ooa.18
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 05:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvzLng++d0GQjJBUi/0nO1Ms1IYQwD4+9R7Ygprni3c=;
        b=KGokx3Pec7udPhmB+DBBZ6UfDLkgyRCCYQfWPuN76pO+6WjxdXL6TkMXiJxEq/4sJT
         xX4jFfSVvxTqkC6fRt/Ze8iUK9oA0VQVdwngARTUDQC/HiB/1cjtFP/meFpoxX4bFD+g
         4is7o0sVQVIvq2jaUtvq502XmjBX9P5gjZM1qL94HdzqvSA4gDdgAIsNY9f4IgJLoW7S
         wAY0yQQKyMU+xIxh2TUtVryffaD5vqoyMfQRPNeT1kgBmCXvOMvrVFvuoMHS8HjV7XIn
         2uqkbBgw+kj+M9tLN5rf70EjrJr+a00fqCLv9i6JPxReh6l6330TIokI3/y9cO3VgLGE
         bICQ==
X-Gm-Message-State: AOAM530WobeLs7Ds+hmVEH59iwjjpOKvv3MciFZ0sMrYDEezrdHYPovj
        fuhrOqHDy2w0maGhvochy3Xd7duoscqKY7XY7gn/BS9Y079UxLBvi0InVxHls1ZQsd3t8ktj/KD
        wAUW1CxWQKIER
X-Received: by 2002:aca:bd8a:: with SMTP id n132mr2398098oif.100.1601382636963;
        Tue, 29 Sep 2020 05:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxtMOVSRmpEJspMGu1B9TMyJUHZE/vqWdRPfqoJwttt3tbdemxQ/MKrn2R6TluIvpwr/UyNw==
X-Received: by 2002:aca:bd8a:: with SMTP id n132mr2398080oif.100.1601382636497;
        Tue, 29 Sep 2020 05:30:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k3sm2852115oof.6.2020.09.29.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 05:30:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6847B183C5B; Tue, 29 Sep 2020 14:30:32 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next] selftests: Make sure all 'skel' variables are declared static
Date:   Tue, 29 Sep 2020 14:30:26 +0200
Message-Id: <20200929123026.46751-1-toke@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If programs in prog_tests using skeletons declare the 'skel' variable as
global but not static, that will lead to linker errors on the final link of
the prog_tests binary due to duplicate symbols. Fix a few instances of this.

Fixes: b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel and global variables")
Fixes: 9a856cae2217 ("bpf: selftest: Add test_btf_skc_cls_ingress")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/sock_fields.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index 4ce0e8a25bc5..86ccf37e26b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -16,7 +16,7 @@
 #include "test_progs.h"
 #include "test_btf_skc_cls_ingress.skel.h"
 
-struct test_btf_skc_cls_ingress *skel;
+static struct test_btf_skc_cls_ingress *skel;
 struct sockaddr_in6 srv_sa6;
 static __u32 duration;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
index 66e83b8fc69d..af87118e748e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
@@ -36,7 +36,7 @@ struct bpf_spinlock_cnt {
 
 static struct sockaddr_in6 srv_sa6, cli_sa6;
 static int sk_pkt_out_cnt10_fd;
-struct test_sock_fields *skel;
+static struct test_sock_fields *skel;
 static int sk_pkt_out_cnt_fd;
 static __u64 parent_cg_id;
 static __u64 child_cg_id;
-- 
2.28.0

