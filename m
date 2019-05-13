Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551D61B322
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 11:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfEMJqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 05:46:05 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:58538 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfEMJqF (ORCPT
        <rfc822;groupwise-bpf@vger.kernel.org:0:0>);
        Mon, 13 May 2019 05:46:05 -0400
Received: from GaryWorkstation.suse.de (unknown.telstraglobal.net [202.47.205.198])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Mon, 13 May 2019 11:46:01 +0200
From:   Gary Lin <glin@suse.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next] bpf: btf: fix the brackets of BTF_INT_OFFSET()
Date:   Mon, 13 May 2019 17:45:48 +0800
Message-Id: <20190513094548.9542-1-glin@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

'VAL' should be protected by the brackets.

v2:
* Squash the fix for Documentation/bpf/btf.rst

Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
Signed-off-by: Gary Lin <glin@suse.com>
---
 Documentation/bpf/btf.rst | 2 +-
 include/uapi/linux/btf.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 8820360d00da..35d83e24dbdb 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -131,7 +131,7 @@ The following sections detail encoding of each kind.
 ``btf_type`` is followed by a ``u32`` with the following bits arrangement::
 
   #define BTF_INT_ENCODING(VAL)   (((VAL) & 0x0f000000) >> 24)
-  #define BTF_INT_OFFSET(VAL)     (((VAL  & 0x00ff0000)) >> 16)
+  #define BTF_INT_OFFSET(VAL)     (((VAL) & 0x00ff0000) >> 16)
   #define BTF_INT_BITS(VAL)       ((VAL)  & 0x000000ff)
 
 The ``BTF_INT_ENCODING`` has the following attributes::
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 9310652ca4f9..63ae4a39e58b 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -83,7 +83,7 @@ struct btf_type {
  * is the 32 bits arrangement:
  */
 #define BTF_INT_ENCODING(VAL)	(((VAL) & 0x0f000000) >> 24)
-#define BTF_INT_OFFSET(VAL)	(((VAL  & 0x00ff0000)) >> 16)
+#define BTF_INT_OFFSET(VAL)	(((VAL) & 0x00ff0000) >> 16)
 #define BTF_INT_BITS(VAL)	((VAL)  & 0x000000ff)
 
 /* Attributes stored in the BTF_INT_ENCODING */
-- 
2.21.0

