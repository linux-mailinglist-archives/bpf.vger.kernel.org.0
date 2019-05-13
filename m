Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F7A1B26C
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEMJMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 05:12:14 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:52127 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfEMJMO (ORCPT
        <rfc822;groupwise-bpf@vger.kernel.org:0:0>);
        Mon, 13 May 2019 05:12:14 -0400
Received: from GaryWorkstation.suse.de (unknown.telstraglobal.net [202.47.205.198])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Mon, 13 May 2019 11:12:11 +0200
From:   Gary Lin <glin@suse.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: btf: fix the brackets of BTF_INT_OFFSET()
Date:   Mon, 13 May 2019 17:11:57 +0800
Message-Id: <20190513091158.6200-1-glin@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

'VAL' should be protected by the brackets.

Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
Signed-off-by: Gary Lin <glin@suse.com>
---
 include/uapi/linux/btf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

