Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B022111BFF1
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 23:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLKWep (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Dec 2019 17:34:45 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:33125 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfLKWel (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:41 -0500
Received: by mail-yw1-f74.google.com with SMTP id s128so417067ywf.0
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 14:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9RMTraS0Zyi1z70WafFMEjChZMSkEcb6BYR/zMAVpRk=;
        b=Zug62ED/rZ6MU18zqHoC2AZP8SDrH5cGX100lu0Z2eD5T/Li+NQTurecemxrmPyix4
         fO5JP1aafPiRtXqcCAd1fXvnqC2t+l+vhGQAcx/Pj0XoLQa5N4jl9jfW9xL2brOngDdT
         FustuWSs2UGUDABRbXjhK+vGP1pQ+HDWlvMNVCeUt+J+bj1EPpa64+TnfhtyGklWYt0W
         OyxghJBnHhef7hXeraIAA2cSSVkM5w2gczpr9PRlYu64Fq/3BAYuqxzPABqXyj+7I8wS
         yvDT22/puKvl1/Bc0P2CC32tcrSTLM+Z2h1nTB83/Ks03PqDbW+2t0yGXuguCvU9b6o/
         U9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9RMTraS0Zyi1z70WafFMEjChZMSkEcb6BYR/zMAVpRk=;
        b=S5gSy4CKOnC3r617yP5eDt3KLrttrXLx4DvkC7eoRnGLSAtAFdMUorJUgQGu/rs6Po
         YFMlONW3s/XKiJNRyECE2zjG3cGGjWwhRHpAR41ZyrxBQ/uuoJWuZTy/6xb7wlyVqknB
         66x6NKnyzaPlapSZ48aePNisJoZkKKNJzp6F8xM97NcorZPQ1F9cWMgIalkk5PEvl7ND
         ikqIQ1s4J+mUXnfP+7pDMPmWOrA9QooQ4kgJ2YkJFOiMhigFonbONQbsLKoqOMzqoB/j
         9cPPQyCM+v0SyfpBnVYoBY9jdcy4vytU4+ywvyJ7ocWVwYewWmXLVczSAG9gI3Bsgon9
         3efA==
X-Gm-Message-State: APjAAAUXpdaeEMcrvQyRpiP2+Jx/6NHhqlcn2Kegv7rDYIfi3isce2JE
        sqYX0RKAVTes0FrPVuLpYUysXbc+1JJ5
X-Google-Smtp-Source: APXvYqyTOAXBOqE4/mNwSkivQk9IjaFFqeApQ7AiGm35jI+iqW+PysIEWzIlF9ZMWMeVT4CFQMwp5yN28II4
X-Received: by 2002:a81:6344:: with SMTP id x65mr1665232ywb.271.1576103680204;
 Wed, 11 Dec 2019 14:34:40 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:40 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-8-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 07/11] tools/bpf: sync uapi header bpf.h
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

sync uapi header include/uapi/linux/bpf.h to
tools/include/uapi/linux/bpf.h

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/include/uapi/linux/bpf.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index dbbcf0b02970b..dab24a763e4bb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -107,6 +107,10 @@ enum bpf_cmd {
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
 	BPF_BTF_GET_NEXT_ID,
+	BPF_MAP_LOOKUP_BATCH,
+	BPF_MAP_LOOKUP_AND_DELETE_BATCH,
+	BPF_MAP_UPDATE_BATCH,
+	BPF_MAP_DELETE_BATCH,
 };
 
 enum bpf_map_type {
@@ -403,6 +407,23 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_*_BATCH commands */
+		__aligned_u64	in_batch;	/* start batch,
+						 * NULL to start from beginning
+						 */
+		__aligned_u64	out_batch;	/* output: next start batch */
+		__aligned_u64	keys;
+		__aligned_u64	values;
+		__u32		count;		/* input/output:
+						 * input: # of key/value
+						 * elements
+						 * output: # of filled elements
+						 */
+		__u32		map_fd;
+		__u64		elem_flags;
+		__u64		flags;
+	} batch;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
-- 
2.24.1.735.g03f4e72817-goog

