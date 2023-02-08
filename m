Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8AB68F039
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 14:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjBHN62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 08:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBHN61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 08:58:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D348171F
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 05:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675864659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p5aosny6w3YdBpadvgyzuejegoLFL3ZhCzD6Izl4BgM=;
        b=d751NOEQ5421+4HwAPw5gUyBkgEb/Ga0ZtX7U4b8ACfukibQG0nmziv8AdE1SVgYfi5sLh
        UdRmLFcyaDETFuD9lzUtTcEhJPoy8iG5JjQT4Lj+hi1k3h0d6ELhJcHm/Q6Nk56W5eIXQJ
        yZ8mz+V21rfWrVutr7XQz5/bwBF3DrQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-O8_0liP3NDC4kTApk6TlXA-1; Wed, 08 Feb 2023 08:57:38 -0500
X-MC-Unique: O8_0liP3NDC4kTApk6TlXA-1
Received: by mail-ed1-f70.google.com with SMTP id bq13-20020a056402214d00b004a25d8d7593so12294731edb.0
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 05:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5aosny6w3YdBpadvgyzuejegoLFL3ZhCzD6Izl4BgM=;
        b=bIAIAD0YH7lkpjeDUt67El35CRdLjcoOfZvwffOIDGmaYbTVl9vEQvPZRtHkXTqySJ
         gxbwFDl/4ANDsw4Ay0+gTf/U3EGGxihtyIhohmNYYZrx1jPFsd39hconn4KinHqoVx9/
         EchBiQpPh2TtEPKvY5ZTfbYqvVn6pKd1ylm54jMJgm9QI1JFqbv+q5PFr1Eub74ARJii
         IHnGm+es3p8tKCWg8gFusmiCW10qnC1onNar7J/KMQV+Ow32IBbWH6wTZjM1JvGPQsX5
         qJpmWu0DfRUoB3NWICcJiKagHiRCKUa0Fx3MniUIl6VGb/cKUjUHk3GinpQVfk0OhkbM
         GtSA==
X-Gm-Message-State: AO0yUKWA2YPAYayoirh3DmyuoeocqESkTxAhFqGQxaqcdF+xHMfqXcMU
        QVCIv3a2kxLr0wB5clACITn/8S1v0TnZ5qXSI8bsOqH4TEiY2Hmj7oKGLpMZbPMMesx3HOcsrwT
        y9xvLouWJ70VA
X-Received: by 2002:a17:906:86d6:b0:885:9ce9:dc79 with SMTP id j22-20020a17090686d600b008859ce9dc79mr7676713ejy.77.1675864656736;
        Wed, 08 Feb 2023 05:57:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/OsYCCrD5wS7PnZkD4zPKmJ7Y8Ux5rWCJg2puXsbJ3a5kZV/qASPCQFV2p/KV0Tckb6rwxAQ==
X-Received: by 2002:a17:906:86d6:b0:885:9ce9:dc79 with SMTP id j22-20020a17090686d600b008859ce9dc79mr7676677ejy.77.1675864656179;
        Wed, 08 Feb 2023 05:57:36 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906a20500b008710789d85fsm8395580ejy.156.2023.02.08.05.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:57:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 49CB19735B5; Wed,  8 Feb 2023 14:57:34 +0100 (CET)
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
Subject: [PATCH bpf-next v2] bpf/docs: Update design QA to be consistent with kfunc lifecycle docs
Date:   Wed,  8 Feb 2023 14:57:30 +0100
Message-Id: <20230208135731.268638-1-toke@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

v2:
- Fix repeated word (s/defined defined/defined/)

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/bpf/bpf_design_QA.rst | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index cec2371173d7..4d3135187e0c 100644
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
@@ -236,8 +240,8 @@ A: NO. Classic BPF programs are converted into extend BPF instructions.
 
 Q: Can BPF call arbitrary kernel functions?
 -------------------------------------------
-A: NO. BPF programs can only call a set of helper functions which
-is defined for every program type.
+A: NO. BPF programs can only call specific functions exposed as BPF helpers or
+kfuncs. The set of available functions is defined for every program type.
 
 Q: Can BPF overwrite arbitrary kernel memory?
 ---------------------------------------------
@@ -263,7 +267,12 @@ Q: New functionality via kernel modules?
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
@@ -278,7 +287,8 @@ kernel functions have already been used by other kernel tcp
 cc (congestion-control) implementations.  If any of these kernel
 functions has changed, both the in-tree and out-of-tree kernel tcp cc
 implementations have to be changed.  The same goes for the bpf
-programs and they have to be adjusted accordingly.
+programs and they have to be adjusted accordingly. See
+:ref:`BPF_kfunc_lifecycle_expectations` for details.
 
 Q: Attaching to arbitrary kernel functions is an ABI?
 -----------------------------------------------------
@@ -340,6 +350,7 @@ compatibility for these features?
 
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

