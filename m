Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69178102C9D
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 20:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfKSTa7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 14:30:59 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33835 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfKSTa7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 14:30:59 -0500
Received: by mail-pg1-f202.google.com with SMTP id w9so16239599pgl.1
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jXrWlSvxSIV7SLutAc92WU1LozEt5/o5gmsENSdeMlw=;
        b=qRnAj9sLFjfyidZkY77ZuLNvqnfOM2c7OsFHowTq1B61urCpWGgj83PZqUwv5U68j9
         nmbEI+CVIVaMsYYe7ObuAZuMsvdEgJcWUcmUpWqODQKgoVp4beMP4FHCd/GVTG5XMZ/f
         Dg8ad+YPlG7acNGLIInEzKl2qcrLhEYv0aIIWJ7hUcnXBaGP2yBNDg9GRZc4eNNhWMmB
         nbvi4sxTJTtMIcGb+pnb7UEcsm5lMb6mPQB1eShne6yUnHElJDYs2tPrnrSnvEtZlRCj
         dt1iusYpASeJ8MG0scyYp1twH2lT10O1Xa13zwoRQ1RBfonUk3C0quB6b2pe1QhIDQwI
         diEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jXrWlSvxSIV7SLutAc92WU1LozEt5/o5gmsENSdeMlw=;
        b=X+NeAXqLXrBp+fr1V+zgcu4VhtOcmEIIGhGHYHA2+dMwtmeEYLxDSFingUH+hmHu89
         KJyR1Vlds6ifC3g3O7pMjjxvDMz+L8nwzUzZDjV5fKMNN1KqEoCf/28OlEz/YOS6TFq3
         Lq5tPmWEtP2RxfHnjvX+N8H6VMAho5owsBTfpLP5Mx/hSVkCbDdlD+Q+6T6jhmADuEA5
         ZCiz7QHqo4jIqHPxHYXN3RBuvMutU8tx5M6JWNWzBbj04rMF6X5wxhGHFnKtWPnN+ELo
         55I0wQb5CPuH9GTPOb5TwshKfbAX51AAT4YdbcIh2ti8ebDP1NxyWRx6IljpL9CIKuTM
         9O3A==
X-Gm-Message-State: APjAAAXd30lpNEUO0rSpVD1aWz9f/rzgYYk6yhxGXE/1VGOpZx5m+jhI
        Ejf+26PWO9IZfVxGvTSJ7L6bTjIOsWmT
X-Google-Smtp-Source: APXvYqwL5tKN6MLbbinOhEr3EbjZs9T1WyD1ZfcTtUFtgeNZqCEfxlfny6rPELtrE4bo+lnFpV2eVPVoR/k8
X-Received: by 2002:a63:ff66:: with SMTP id s38mr7329802pgk.84.1574191858436;
 Tue, 19 Nov 2019 11:30:58 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:30:33 -0800
In-Reply-To: <20191119193036.92831-1-brianvv@google.com>
Message-Id: <20191119193036.92831-7-brianvv@google.com>
Mime-Version: 1.0
References: <20191119193036.92831-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 bpf-next 6/9] tools/bpf: sync uapi header bpf.h
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
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
index 4842a134b202a..0f6ff0c4d79dd 100644
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
@@ -400,6 +404,23 @@ union bpf_attr {
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
2.24.0.432.g9d3f5f5b63-goog

