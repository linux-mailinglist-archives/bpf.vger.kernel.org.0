Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61816957EF
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 05:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBNEfJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 23:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBNEfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 23:35:08 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05B1968E
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 20:35:06 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id 3FCD065D6F98; Mon, 13 Feb 2023 20:34:54 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v1 bpf-next] bpf: Update kfunc __sz documentation
Date:   Mon, 13 Feb 2023 20:33:50 -0800
Message-Id: <20230214043350.3497406-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bpf program calling a kfunc with a __sz-annotated arg must explicitly
initialize the stack themselves if the pointer to the memory region is
a pointer to the stack. This is because in the verifier, we do not
explicitly initialize the stack space for reg type PTR_TO_STACK
kfunc args. Thus, the verifier will reject the program with:

invalid indirect read from stack
arg#0 arg#1 memory, len pair leads to invalid memory access

Alternatively, the verifier could support initializing the stack
space on behalf of the program for KF_ARG_PTR_TO_MEM_SIZE args,
but this has some drawbacks. For example this would not allow the
verifier to reject a program for passing in an uninitialized
PTR_TO_STACK for an arg that should have valid data. Another example is
that since there's no current way in a kfunc to differentiate between
whether the arg should be treated as uninitialized or not, additional
check_mem_access calls would need to be called even on PTR_TO_STACKs
that have been initialized, which is inefficient. Please note
that non-kfuncs don't have this problem because of the MEM_UNINIT tag;
only if the arg is tagged as MEM_UNINIT, then do we call
check_mem_access byte-by-byte for the size of the buffer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ca96ef3f6896..97497a7879d6 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -71,10 +71,37 @@ An example is given below::
         ...
         }
=20
-Here, the verifier will treat first argument as a PTR_TO_MEM, and second
-argument as its size. By default, without __sz annotation, the size of t=
he type
-of the pointer is used. Without __sz annotation, a kfunc cannot accept a=
 void
-pointer.
+Here, the verifier will treat first argument (KF_ARG_PTR_TO_MEM_SIZE) as=
 a
+pointer to the memory region and second argument as its size. By default=
,
+without __sz annotation, the size of the type of the pointer is used. Wi=
thout
+__sz annotation, a kfunc cannot accept a void pointer.
+
+Please note that if the memory is on the stack, the stack space must be
+explicitly initialized by the program. For example:
+
+.. code-block:: c
+
+	SEC("tc")
+	int prog(struct __sk_buff *skb)
+	{
+		char buf[8];
+
+		bpf_memzero(buf, sizeof(buf));
+	...
+	}
+
+should be
+
+.. code-block:: c
+
+	SEC("tc")
+	int prog(struct __sk_buff *skb)
+	{
+		char buf[8] =3D {};
+
+		bpf_memzero(buf, sizeof(buf));
+	...
+	}
=20
 2.2.2 __k Annotation
 --------------------
--=20
2.30.2

