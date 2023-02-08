Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDCC68F3AB
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 17:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjBHQpE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 11:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjBHQov (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 11:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160E30C0
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675874512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1YNZbpe0n60mPrJnwiUAdm1/ZMHBphP6DStDV17ccyQ=;
        b=Nlt94guvwrB9HjEyOoZH6NSMEdbo0aOvnooBFgzfbGBwHr32Lb4Y4CEZ7qKG4TzncXog9s
        G3TUZVU925F8kkwWOFeMOPqPR6EHuKuor5RXGZZwj4XW+06yoaJFiOrNIXufu2rjy3R2A0
        24iNTYOK8VoOQ5P02BURlb3vMmajIk0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-nmoY7XMuNxC358zbsT9oeg-1; Wed, 08 Feb 2023 11:41:48 -0500
X-MC-Unique: nmoY7XMuNxC358zbsT9oeg-1
Received: by mail-ej1-f70.google.com with SMTP id vq12-20020a170907a4cc00b00896db1c78aaso7968296ejc.9
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 08:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YNZbpe0n60mPrJnwiUAdm1/ZMHBphP6DStDV17ccyQ=;
        b=x/JL3u/XmyV54EauFbLz9BbiWi1JMTUD0v0TDQhOGg9fNDj+xYIEZc2dvJUFpq4eLY
         /TogqzG25j1E0g74uwnlqCfy5PsPQQoO1VKUTOG5WBjgMnkLubsw0GZ+4/HCeRRvH7KA
         ofTvw5hCA7WhwK8HPp00VkfHJgcSYzH5QAj842ATocZZpJcnmjxp4cn0vEonNJhMI2pk
         ZMFb0NTOaxhsR5f1JdoiOMT1VyLBlcDTGs2tZsnlr12vptGsRT9KrUMqiV03M1+akGUq
         MmRZnNUfTd/LxezV+zvAZ2PTL4tqU6fMPJNiKIcEf82VF80cbGRXLiGcHdAFdlbtmXM+
         jW/g==
X-Gm-Message-State: AO0yUKUe7rEQoFN0TTmpCWn1eEWCQ01d0qa3zEG3YWrw74RoEFb50UgW
        MsN2gtSOvdLA9XD/UdlbcSqWPNy75HwLSzpCESbBwAhm/CtTFwIaFtS1beUB4kWP8us+scJHvy2
        wFeneNqTWmXA3
X-Received: by 2002:a50:8e5b:0:b0:4aa:aa90:eeb0 with SMTP id 27-20020a508e5b000000b004aaaa90eeb0mr8686718edx.10.1675874506972;
        Wed, 08 Feb 2023 08:41:46 -0800 (PST)
X-Google-Smtp-Source: AK7set8hipcNP0yhKThKsAPXHkhiewTa/uYVgDASPJB06br2zp93oOwb/wVBxDoSNQXEboSlumCupw==
X-Received: by 2002:a50:8e5b:0:b0:4aa:aa90:eeb0 with SMTP id 27-20020a508e5b000000b004aaaa90eeb0mr8686676edx.10.1675874506015;
        Wed, 08 Feb 2023 08:41:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a30-20020a50c31e000000b004aaf8decec4sm1192212edb.44.2023.02.08.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:41:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 37F9B973CE0; Wed,  8 Feb 2023 17:41:44 +0100 (CET)
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
        David Vernet <void@manifault.com>,
        Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH bpf-next v3] bpf/docs: Update design QA to be consistent with kfunc lifecycle docs
Date:   Wed,  8 Feb 2023 17:41:43 +0100
Message-Id: <20230208164143.286392-1-toke@redhat.com>
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

v3:
- Grammar nit + ack from David

v2:
- Fix repeated word (s/defined defined/defined/)

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/bpf/bpf_design_QA.rst | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index cec2371173d7..bfff0e7e37c2 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -208,6 +208,10 @@ data structures and compile with kernel internal headers. Both of these
 kernel internals are subject to change and can break with newer kernels
 such that the program needs to be adapted accordingly.
 
+New BPF functionality is generally added through the use of kfuncs instead of
+new helpers. Kfuncs are not considered part of the stable API, and have their own
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

