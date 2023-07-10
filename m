Return-Path: <bpf+bounces-4626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A0674DD5D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39360280A1C
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5A14A9B;
	Mon, 10 Jul 2023 18:31:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4BF16428
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:31:54 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0BC3
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:31:53 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5D479C16B5AE
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689013913; bh=uzq1TBOaR54PUAY+kQMzPg/RwXrX30NmNmoFdL3sLaY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=RRGm6vio9QZmoURr+HcJwadGw2L2w0tKuSZ1uwUgeluzhNHKmOumlwJrHmrvQa90d
	 9A2NZ6DzLB652AjJ+CluDP8EWGLV++MTmesfHF07Cp+DKyWbkfmZCK3EoPlKG64gUp
	 eIg1Ji4MZV/qbOiJibU/rxFHI5D1InxicqWt/bsg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 11:31:53 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0F15FC169510;
	Mon, 10 Jul 2023 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689013913; bh=uzq1TBOaR54PUAY+kQMzPg/RwXrX30NmNmoFdL3sLaY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=RRGm6vio9QZmoURr+HcJwadGw2L2w0tKuSZ1uwUgeluzhNHKmOumlwJrHmrvQa90d
	 9A2NZ6DzLB652AjJ+CluDP8EWGLV++MTmesfHF07Cp+DKyWbkfmZCK3EoPlKG64gUp
	 eIg1Ji4MZV/qbOiJibU/rxFHI5D1InxicqWt/bsg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 18280C169510
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 11:31:52 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.547
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1hr0TNJNaTKY for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 11:31:48 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4F1FCC151094
 for <bpf@ietf.org>; Mon, 10 Jul 2023 11:31:48 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-403a85eb723so20375861cf.1
 for <bpf@ietf.org>; Mon, 10 Jul 2023 11:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689013907; x=1691605907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FFg6es6MnkESIGeku/OXeP7kXEnpRz2XkgXfhzN59IQ=;
 b=Vu7mDQN2vOocgmDkQbFJMA98TVOiguWhPSb/Mhh/O35XuG4cogzX3AytuegPd/GIkU
 YSwFs//PJhRyP1w0+DAunmziZbsQRSNown1rafohw21/y8SPwJGdO/r2p1aiajGSf00C
 CDYoIUPeth07YvTd4X+8IDp7mvSNkGQtSyNwdKxJKVGWCRvyKHs23Am7P4sf5WnyQFVh
 w625KaUs0H4Iv3hlnKX9ynrKMClcKTXP2Fj2vZtiFzIwMOwMUrpaWWjuoAZmjYgLXI3R
 Dwsb5D3Btw0bIG/sl6dH18uVl3uQWYlwTeNz2sxkXfCGkX3loIv2lh1BS31W87W1bU1d
 /skQ==
X-Gm-Message-State: ABy/qLZjuihbCFf2vesIg/+PYogFK7FWQa/7D0fRM0uA4/2cWrlLufyN
 jGNtbLfiBRoiv7vhP8dk4v0=
X-Google-Smtp-Source: APBJJlFnJy56MSvI7hBVrDADp6aJ5NB+E7GR4tyisl4jvg/ekNRgWT9+E1wpViPcJoyO6CTGRqMzyA==
X-Received: by 2002:ac8:7d43:0:b0:403:a7de:ae36 with SMTP id
 h3-20020ac87d43000000b00403a7deae36mr8725658qtb.67.1689013906996; 
 Mon, 10 Jul 2023 11:31:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:4850])
 by smtp.gmail.com with ESMTPSA id
 z4-20020ac87f84000000b00403a2e88d01sm180690qtj.40.2023.07.10.11.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 11:31:46 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, bpf@ietf.org
Date: Mon, 10 Jul 2023 13:30:27 -0500
Message-Id: <20230710183027.15132-1-void@manifault.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Jqf7RKUggFbwjzwBdMm_eKB41eU>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Create new standardization subdirectory
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The BPF standardization effort is actively underway with the IETF. As
described in the BPF Working Group (WG) charter in [0], there are a
number of proposed documents, some informational and some proposed
standards, that will be drafted as part of the standardization effort.

[0]: https://datatracker.ietf.org/wg/bpf/about/

Though the specific documents that will formally be standardized will
exist as Internet Drafts (I-D) and WG documents in the BPF WG
datatracker page, the source of truth from where those documents will be
generated will reside in the kernel documentation tree (originating in
the bpf-next tree).

Because these documents will be used to generate the I-D and WG
documents which will be standardized with the IETF, they are a bit
special as far as kernel-tree documentation goes:

- They will be dual licensed with LGPL-2.1 OR BSD-2-Clause
- IETF I-D and WG documents (the documents which will actually be
  standardized) will be auto-generated from these documents.

In order to keep things clearly organized in the BPF documentation tree,
and to make it abundantly clear where standards-related documentation
needs to go, we should move standards-relevant documents into a separate
standardization/ subdirectory.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/index.rst                    |  3 +--
 Documentation/bpf/standardization/index.rst    | 18 ++++++++++++++++++
 .../{ => standardization}/instruction-set.rst  |  0
 .../bpf/{ => standardization}/linux-notes.rst  |  3 ++-
 MAINTAINERS                                    |  2 +-
 5 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/bpf/standardization/index.rst
 rename Documentation/bpf/{ => standardization}/instruction-set.rst (100%)
 rename Documentation/bpf/{ => standardization}/linux-notes.rst (96%)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index dbb39e8f9889..1ff177b89d66 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -12,9 +12,9 @@ that goes into great technical depth about the BPF Architecture.
 .. toctree::
    :maxdepth: 1
 
-   instruction-set
    verifier
    libbpf/index
+   standardization/index
    btf
    faq
    syscall_api
@@ -29,7 +29,6 @@ that goes into great technical depth about the BPF Architecture.
    bpf_licensing
    test_debug
    clang-notes
-   linux-notes
    other
    redirect
 
diff --git a/Documentation/bpf/standardization/index.rst b/Documentation/bpf/standardization/index.rst
new file mode 100644
index 000000000000..09c6ba055fd7
--- /dev/null
+++ b/Documentation/bpf/standardization/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+===================
+BPF Standardization
+===================
+
+This directory contains documents that are being iterated on as part of the BPF
+standardization effort with the IETF. See the `IETF BPF Working Group`_ page
+for the working group charter, documents, and more.
+
+.. toctree::
+   :maxdepth: 1
+
+   instruction-set
+   linux-notes
+
+.. Links:
+.. _IETF BPF Working Group: https://datatracker.ietf.org/wg/bpf/about/
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
similarity index 100%
rename from Documentation/bpf/instruction-set.rst
rename to Documentation/bpf/standardization/instruction-set.rst
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/standardization/linux-notes.rst
similarity index 96%
rename from Documentation/bpf/linux-notes.rst
rename to Documentation/bpf/standardization/linux-notes.rst
index 508d009d3bed..00d2693de025 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/standardization/linux-notes.rst
@@ -45,7 +45,8 @@ On Linux, this integer is a BTF ID.
 Legacy BPF Packet access instructions
 =====================================
 
-As mentioned in the `ISA standard documentation <instruction-set.rst#legacy-bpf-packet-access-instructions>`_,
+As mentioned in the `ISA standard documentation
+<instruction-set.html#legacy-bpf-packet-access-instructions>`_,
 Linux has special eBPF instructions for access to packet data that have been
 carried over from classic BPF to retain the performance of legacy socket
 filters running in the eBPF interpreter.
diff --git a/MAINTAINERS b/MAINTAINERS
index acbe54087d1c..99d8dc9b2850 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3746,7 +3746,7 @@ R:	David Vernet <void@manifault.com>
 L:	bpf@vger.kernel.org
 L:	bpf@ietf.org
 S:	Maintained
-F:	Documentation/bpf/instruction-set.rst
+F:	Documentation/bpf/standardization/
 
 BPF [GENERAL] (Safe Dynamic Programs and Tools)
 M:	Alexei Starovoitov <ast@kernel.org>
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

