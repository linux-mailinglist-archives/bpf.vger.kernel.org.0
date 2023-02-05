Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49168B1FE
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 22:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjBEVpo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 16:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBEVpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 16:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC8A17157
        for <bpf@vger.kernel.org>; Sun,  5 Feb 2023 13:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675633495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aa6I2C5F/8xIyHsF1x3we+fOCl0qGqBQvQxp6eQs6gA=;
        b=KQNicarM4o2PF17ktJ9wsxzCVCycG6qpHOy5TDoo43vEMfH9P+Tv12/QwzoVR1FgVdQ9zs
        Fo0aqo/HKdGpZl3vKxPEzBGBKR7i7iap4Reb598fNEH8t0bu/dKgZLJvua2dY0FP2y3M54
        KqzH18nem+qFf4HGxY/VmDked5pkc0k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-gGLi9eIvM_qmfCvKvVp_pQ-1; Sun, 05 Feb 2023 16:44:54 -0500
X-MC-Unique: gGLi9eIvM_qmfCvKvVp_pQ-1
Received: by mail-ej1-f72.google.com with SMTP id bw6-20020a170906c1c600b0088e4f4830b1so7241307ejb.7
        for <bpf@vger.kernel.org>; Sun, 05 Feb 2023 13:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aa6I2C5F/8xIyHsF1x3we+fOCl0qGqBQvQxp6eQs6gA=;
        b=szp6h3MlxfRYpNac3plydCQwwomm90WzI2+DM8zCjoeLOUJKq9pbGg7UNMyEBHDhXj
         EpNpid5zi49IF5BN8aCqbx0AP2tsFOJiZ9IiFAjBm7W3bVh9wvmnhlOnJsZ+IQc36OPK
         Sjn5kksebuzs3+95M/c8ih8TBboTeGVMSNFXv+PKJ2+TEEgMHamQJjMivRbA+j3uuEJc
         Dbmhub6ydzcstsOBqWF1rTXQX4EHePp+AkcE9vmEI6szLaCMpcAmma4kLZopQL5vj2kR
         DPrY5RPPj0g4G+3fIlJClst6malu9D/Pwd295dnH/kqDFI+Dl6a0zBwVv7f5tnIC1iAC
         QCOg==
X-Gm-Message-State: AO0yUKVYjrkV/jgXfDHFsJXgUGUsRAK76SxRSQfhyHwl3DSRKc1v+xgr
        Xd0pdSgOHmqkd5h4qQghe81nejNnHRCyaHhCzQpxFEtDbVEgrcA2D/bJmpd43jvvOvQ8ZMtJDRQ
        k3v+UXLgdOxbQ
X-Received: by 2002:a50:ce5a:0:b0:4aa:aaf6:e6be with SMTP id k26-20020a50ce5a000000b004aaaaf6e6bemr2780180edj.7.1675633492863;
        Sun, 05 Feb 2023 13:44:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9rtR/MvdTbsZPYhNJuIe8kgY9iy9J5KAlUEPkP4eQVjJNbRbqM2R/omjovVUdGyD8LTgK7ag==
X-Received: by 2002:a50:ce5a:0:b0:4aa:aaf6:e6be with SMTP id k26-20020a50ce5a000000b004aaaaf6e6bemr2780160edj.7.1675633492507;
        Sun, 05 Feb 2023 13:44:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r6-20020a056402018600b0049f29a7c0d6sm4304438edv.34.2023.02.05.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 13:44:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 858349730F3; Sun,  5 Feb 2023 22:44:50 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH bpf-next] bpf/docs: Update design QA to be consistent with kfunc lifecycle docs
Date:   Sun,  5 Feb 2023 22:44:45 +0100
Message-Id: <20230205214445.152828-1-toke@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cong pointed out that there are some inconsistencies between the BPF design
QA and the lifecycle expectations documentation we added for kfuncs. Let's
update the QA file to be consistent with the kfunc docs, and add references
where it makes sense. Also document that modules may export kfuncs now.

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/bpf/bpf_design_QA.rst | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index cec2371173d7..619a1fea0efa 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -208,6 +208,10 @@ data structures and compile with kernel internal headers. Both of these
 kernel internals are subject to change and can break with newer kernels
 such that the program needs to be adapted accordingly.
 
+New BPF functionality is generally added through the use of kfuncs instead of
+new helpers. Kfuncs are not considered part of the stable API, but has their own
+lifecycle expectations as described in :ref:`BPF_kfunc_lifecycle_expectations`.
+
 Q: Are tracepoints part of the stable ABI?
 ------------------------------------------
 A: NO. Tracepoints are tied to internal implementation details hence they are
@@ -236,8 +240,9 @@ A: NO. Classic BPF programs are converted into extend BPF instructions.
 
 Q: Can BPF call arbitrary kernel functions?
 -------------------------------------------
-A: NO. BPF programs can only call a set of helper functions which
-is defined for every program type.
+A: NO. BPF programs can only call specific functions exposed as BPF helpers or
+kfuncs. The set of available functions is defined defined for every program
+type.
 
 Q: Can BPF overwrite arbitrary kernel memory?
 ---------------------------------------------
@@ -263,7 +268,12 @@ Q: New functionality via kernel modules?
 Q: Can BPF functionality such as new program or map types, new
 helpers, etc be added out of kernel module code?
 
-A: NO.
+A: Yes, through kfuncs and kptrs
+
+The core BPF functionality such as program types, maps and helpers cannot be
+added to by modules. However, modules can expose functionality to BPF programs
+by exporting kfuncs (which may return pointers to module-internal data
+structures as kptrs).
 
 Q: Directly calling kernel function is an ABI?
 ----------------------------------------------
@@ -278,7 +288,8 @@ kernel functions have already been used by other kernel tcp
 cc (congestion-control) implementations.  If any of these kernel
 functions has changed, both the in-tree and out-of-tree kernel tcp cc
 implementations have to be changed.  The same goes for the bpf
-programs and they have to be adjusted accordingly.
+programs and they have to be adjusted accordingly. See
+:ref:`BPF_kfunc_lifecycle_expectations` for details.
 
 Q: Attaching to arbitrary kernel functions is an ABI?
 -----------------------------------------------------
@@ -340,6 +351,7 @@ compatibility for these features?
 
 A: NO.
 
-Unlike map value types, there are no stability guarantees for this case. The
-whole API to work with allocated objects and any support for special fields
-inside them is unstable (since it is exposed through kfuncs).
+Unlike map value types, the API to work with allocated objects and any support
+for special fields inside them is exposed through kfuncs, and thus has the same
+lifecycle expectations as the kfuncs themselves. See
+:ref:`BPF_kfunc_lifecycle_expectations` for details.
-- 
2.39.1

