Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E006E50A1C0
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388868AbiDUOKo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388847AbiDUOKn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 10:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E289262A
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mu71EcrM6CS//34lSShcmIEpi6ln3dKHHiAx5OAiSvg=;
        b=XRG8eAJZ7eYW/fZxS8WS06fLrPeTUrO7Wa95VAyJFN9aa40JrGNnTYjgA/EDFkzO7HE2PB
        L7NxPQExcY6GtxQvIdXBHl5lcPNGKln1QGZTFsxoiime4eoyo6VaOD6U1N1ZPJl41LaJS8
        oYSja5EzVjLnpWlwrfUxfdrZbI0JXK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-mfu0MqcAOoaEIsbQDeRINw-1; Thu, 21 Apr 2022 10:07:48 -0400
X-MC-Unique: mfu0MqcAOoaEIsbQDeRINw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1786985A5BE;
        Thu, 21 Apr 2022 14:07:48 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 013EF40EC002;
        Thu, 21 Apr 2022 14:07:45 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC bpf-next v4 1/7] bpf/btf: also allow kfunc in tracing programs
Date:   Thu, 21 Apr 2022 16:07:34 +0200
Message-Id: <20220421140740.459558-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

using fentry/fexit and fmod_ret is very convenient to access
module BPF capabilities, so be able to define kfuncs there is
a must.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v4:
- I think this is where I need to add my new kfuncs, though
  in the end I need to be able to change the incoming data, so
  maybe only fmod_ret is the one we need to be able to be RW.
---
 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0493310d981f..76318a4c2d0e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -202,6 +202,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_XDP,
 	BTF_KFUNC_HOOK_TC,
 	BTF_KFUNC_HOOK_STRUCT_OPS,
+	BTF_KFUNC_HOOK_TRACING,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -6892,6 +6893,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_TC;
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
+	case BPF_PROG_TYPE_TRACING:
+		return BTF_KFUNC_HOOK_TRACING;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
-- 
2.35.1

