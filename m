Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4B1010F7
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 02:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKSBoy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 20:44:54 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47200 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfKSBo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:29 -0500
Received: by mail-pg1-f201.google.com with SMTP id c10so14560563pgm.14
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 17:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tEe8RAW7MBg1zO9sfZasncxQxqg/PBFYBgYuXX6ANOY=;
        b=K8RhSk35hlwM4iwGeJGgh9tHYrYu24g+thHVrOM7cbaoj90XYuZ58wrRrHjYhJjnoK
         8FgzQrrWE5qvlelyBxxgg64bf3n1OwVDso0Cuf0r5aMXsiZcTqsurHAIrv3On2w3Sw8n
         SEX9mRdn2sfbOihaGzZntl3akYu7MmAhZe/eIVFoIJ2Ro6I+bju0nXSOmPJPq9ipGlJU
         LGPttvtIsETOnjAOUREOqjDzBamwNX2TdRYvUknKBzUaWjbe8PdoBhipodsJS8z520D5
         RtIEHNuqm+7jitIuO35ludXmuhie2vcVlnBTWtIcoxDj7C8cGTNZBdE298UedqMuePo5
         nWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tEe8RAW7MBg1zO9sfZasncxQxqg/PBFYBgYuXX6ANOY=;
        b=hbCg3AWeZWLbcFneZ80JdC54MYHu8pszmu1fS+PKlVVL/nFjOH7DlC5DLTqt924n2P
         6GRclERzuPMJwSJlxrwg0YZ3Jb0ZqB8yOWFLLDur5KpLVbGhEllUDksT5l/A0LUKaS7r
         /57/xSZ5WzHHz6O9S0OoB9pBgwtaEVhRVU4dwz14AeCKxsS8yURTnrqDqtgTDWyKZoR1
         AX1Rfx8BzC4OiQx0EkEPwKI/5YOgyklm7eeOuuzecIcFnt1mR7+hx2UYcQP4rqhKk6AY
         rLIaTqs4YMO9mhnWfXbXjAJgGNu3sHti8zrYwj9Fsp3/Ne7qgOn3g1WtjDtdgnL8Jc4B
         mQDg==
X-Gm-Message-State: APjAAAWyDEw8yapE1CWrXv3c7v2LS2e50xT0+iXrn+3ejc2wBY2XWKBg
        d29Jt3j0twDRnHOXwcqdRX3WvymVuRdc
X-Google-Smtp-Source: APXvYqw2w38HwDUij0Bk0tee7e4l618S+GHU2hzPUeItPDJElvv18erLem5jmOfiiBLpwHPzt+lSPjLQpo/X
X-Received: by 2002:a65:4381:: with SMTP id m1mr2637901pgp.43.1574127869013;
 Mon, 18 Nov 2019 17:44:29 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:54 -0800
In-Reply-To: <20191119014357.98465-1-brianvv@google.com>
Message-Id: <20191119014357.98465-7-brianvv@google.com>
Mime-Version: 1.0
References: <20191119014357.98465-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 6/9] tools/bpf: sync uapi header bpf.h
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sync uapi header include/uapi/linux/bpf.h to
tools/include/uapi/linux/bpf.h

Signed-off-by: Brian Vazquez <brianvv@google.com>
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

