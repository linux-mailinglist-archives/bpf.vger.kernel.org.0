Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8C197EAE
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgC3OnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 10:43:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgC3OnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 10:43:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so22029356wrm.4
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDKK1rxJ/Ozhs2MJS25zEDVu2X8lPSvrnkUT9J5tmBI=;
        b=cz42H+A8OSoPd3whOFLMSUywzwBy3ywnzV2zBfkD+ytvB9Mj+IAte7/ngWzBF1/24n
         5i8xmKdIi6zhwjPWbWoGVkVnm21fqheDuTvTBitdBXakf3H4CiItd6f6F2iwyJLrxfS0
         onXSXEA8PA/rQsscopkh6zm9OWz1MsTwOJmhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDKK1rxJ/Ozhs2MJS25zEDVu2X8lPSvrnkUT9J5tmBI=;
        b=b6fhBsyI45ACmxqEq05t9jvlSsvw/GBRlG34748jIkhXiSW8WQoy9DmBfNTmzlhMG3
         7O9OOHoaAr3/1GycCOuFOjIJKcObQMcqZOSEnsUc00y4ImYvb0sbqOutlYYGilaQFfhE
         mOIftiQSP9r+h6pJ87HAXhTGkgSjp+1SvDxYLfP33KUBGdH7c3dI6by4valQZ5Syod9s
         l6P/aCbHad/eLhZMSkSz2W2RJOHaTyspKKwFoiGE5QcI3baZOX52GvDNRw2VWyS8MzfT
         UbRdZsRX6unkMgy/yXLfxnX0mg9BZ+k6ktKqMIjq6thtmPRiEQo6uZo33vYsG+lta3PB
         3lmQ==
X-Gm-Message-State: ANhLgQ3mIpx4GUr67Mj699bzU+XVQR93Wyngx2KW1K9RKgqzUiYakqe2
        sJMmkDpvB8quAFr0RBk/SnWamQ==
X-Google-Smtp-Source: ADFU+vtKWzncbD9ytoVigT1zTjamTQbtwMydoETXzoZ4vJoDGHCRa1CGDLhc9iDD3yyLZ/6AjOkBcw==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr14956268wrp.112.1585579397851;
        Mon, 30 Mar 2020 07:43:17 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id i2sm22128947wrx.22.2020.03.30.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:43:17 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: btf: Fix arg verification in btf_ctx_access()
Date:   Mon, 30 Mar 2020 16:42:46 +0200
Message-Id: <20200330144246.338-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The bounds checking for the arguments accessed in the BPF program breaks
when the expected_attach_type is not BPF_TRACE_FEXIT, BPF_LSM_MAC or
BPF_MODIFY_RETURN resulting in no check being done for the default case
(the programs which do not receive the return value of the attached
function in its arguments) when the index of the argument being accessed
is equal to the number of arguments (nr_args).

This was a result of a misplaced "else if" block  introduced by the
Commit 6ba43b761c41 ("bpf: Attachment verification for
BPF_MODIFY_RETURN")

Signed-off-by: KP Singh <kpsingh@google.com>
Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
Reported-by: Jann Horn <jannh@google.com>
---
 kernel/bpf/btf.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index de335cd386f0..3b6dcfb6ea49 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3709,9 +3709,16 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		nr_args--;
 	}
 
+	if (arg > nr_args) {
+		bpf_log(log, "func '%s' doesn't have %d-th argument\n",
+			tname, arg + 1);
+		return false;
+	}
+
 	if (arg == nr_args) {
-		if (prog->expected_attach_type == BPF_TRACE_FEXIT ||
-		    prog->expected_attach_type == BPF_LSM_MAC) {
+		switch (prog->expected_attach_type) {
+		case BPF_LSM_MAC:
+		case BPF_TRACE_FEXIT:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
@@ -3728,7 +3735,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			if (!t)
 				return true;
 			t = btf_type_by_id(btf, t->type);
-		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+			break;
+		case BPF_MODIFY_RETURN:
 			/* For now the BPF_MODIFY_RETURN can only be attached to
 			 * functions that return an int.
 			 */
@@ -3742,17 +3750,19 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 					btf_kind_str[BTF_INFO_KIND(t->info)]);
 				return false;
 			}
+			break;
+		default:
+			bpf_log(log, "func '%s' doesn't have %d-th argument\n",
+				tname, arg + 1);
+			return false;
 		}
-	} else if (arg >= nr_args) {
-		bpf_log(log, "func '%s' doesn't have %d-th argument\n",
-			tname, arg + 1);
-		return false;
 	} else {
 		if (!t)
 			/* Default prog with 5 args */
 			return true;
 		t = btf_type_by_id(btf, args[arg].type);
 	}
+
 	/* skip modifiers */
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
-- 
2.20.1

